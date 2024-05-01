using Azure.Storage;
using Azure.Storage.Blobs;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Configuration;
using StudentOglasi.Model.BlobModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Services.Services
{
    public class FileService
    {
        private readonly IConfiguration _configuration;
        private readonly BlobContainerClient _fileContainer;

        public FileService(IConfiguration configuration)
        {
            _configuration = configuration;
            var storageAccountName = _configuration["AzureBlobStorage:StorageAccountName"];
            var accessKey = _configuration["AzureBlobStorage:AccessKey"];

            var credetials = new StorageSharedKeyCredential(storageAccountName, accessKey);
            var blobUri = $"https://{storageAccountName}.blob.core.windows.net";
            var blobServiceClient = new BlobServiceClient(new Uri(blobUri), credetials);
            _fileContainer = blobServiceClient.GetBlobContainerClient("files");
        }

        public async Task<List<BlobDto>> ListAsync()
        {
            List<BlobDto> files = new List<BlobDto>();

            await foreach (var file in _fileContainer.GetBlobsAsync())
            {
                string uri = _fileContainer.Uri.ToString();
                var name = file.Name;
                var fullUri = $"{uri}/{name}";

                files.Add(new BlobDto
                {
                    Uri = fullUri,
                    Name = name,
                    ContentType = file.Properties.ContentType
                });
            }
            return files;
        }

        public async Task<BlobResponseDto> UploadAsync(IFormFile blob)
        {
            BlobResponseDto response = new();
            string filename = Guid.NewGuid().ToString() + Path.GetExtension(blob.FileName);
            BlobClient client = _fileContainer.GetBlobClient(filename);

            await using (Stream? data = blob.OpenReadStream())
            {
                await client.UploadAsync(data);
            }

            response.Status = $"File {blob.FileName} Uploaded Successfully";
            response.Error = false;
            response.Blob.Uri = client.Uri.AbsoluteUri;
            response.Blob.Name = client.Name;

            return response;
        }

        public async Task<BlobDto?> DownloadAsync(string blobFilename)
        {
            BlobClient file = _fileContainer.GetBlobClient(blobFilename);

            if (await file.ExistsAsync())
            {
                var data = await file.OpenReadAsync();
                Stream blobContent = data;

                var content = await file.DownloadContentAsync();

                string name = blobFilename;
                string contentType = content.Value.Details.ContentType;

                return new BlobDto { Content = blobContent, Name = name, ContentType = contentType };
            }
            return null;
        }

        public async Task<BlobResponseDto> DeleteAsync(string blobFilename)
        {
            BlobClient file = _fileContainer.GetBlobClient(blobFilename);

            await file.DeleteAsync();

            return new BlobResponseDto { Error = false, Status = $"File: {blobFilename} has been successfully deleted." };
        }
    }
}
