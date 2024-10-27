using AutoMapper;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using StudentOglasi.Model;
using StudentOglasi.Model.Requests;
using StudentOglasi.Model.SearchObjects;
using StudentOglasi.Services.Database;
using StudentOglasi.Services.Interfaces;
using StudentOglasi.Services.Services;
using System.Linq;

namespace StudentOglasi.Controllers
{
    [Route("[controller]")]
    [ApiController]
    public class PrijaveStipendijaController : BaseCRUDController<Model.PrijaveStipendija, PrijaveStipendijaSearchObject,PrijaveStipendijaInsertRequest,PrijaveStipendijaUpdateRequest>
    {
        private readonly IPrijaveStipendijaService _prijaveStipendijeService;
        public PrijaveStipendijaController(ILogger<BaseController<Model.PrijaveStipendija, PrijaveStipendijaSearchObject>> logger, IPrijaveStipendijaService prijaveStipendijaService) : base(logger, prijaveStipendijaService)
        {
            _prijaveStipendijeService = prijaveStipendijaService;
        }

        public override Task<IActionResult> Insert([FromForm] PrijaveStipendijaInsertRequest insert)
        {
            return base.Insert(insert);
        }
        public override Task<IActionResult> Update(int id, [FromForm] PrijaveStipendijaUpdateRequest update)
        {
            return base.Update(id, update);
        }

        [HttpPut("{studentId}/{stipendijaId}/approve")]
        public virtual async Task<Model.PrijaveStipendija> Approve(int studentId, int stipendijaId)
        {
            return await (_service as IPrijaveStipendijaService).Approve(studentId, stipendijaId);
        }

        [HttpPut("{studentId}/{stipendijaId}/cancel")]
        public virtual async Task<Model.PrijaveStipendija> Cancel(int studentId, int stipendijaId)
        {
            return await (_service as IPrijaveStipendijaService).Cancel(studentId, stipendijaId);
        }

        [HttpGet("{studentId}/{stipendijaId}/allowedActions")]
        public async Task<List<string>> AllowedActions(int studentId, int stipendijaId)
        {
            return await (_service as IPrijaveStipendijaService).AllowedActions(studentId, stipendijaId);
        }

        [HttpGet("student/{studentId}")]
        public async Task<List<Model.PrijaveStipendija>> GetByStudentId(int studentId)
        {
            return await (_service as IPrijaveStipendijaService).GetByStudentIdAsync(studentId);
        }

        [HttpGet("report/download/{stipendijaId}")]
        public async Task<IActionResult> DownloadReport(int stipendijaId)
        {
            try
            {
                var pdfReport = await _prijaveStipendijeService.DownloadReportAsync(stipendijaId);

                var contentType = "application/pdf";
                var fileName = $"ScholarshipReport_{stipendijaId}.pdf";
                Response.Headers.Add("Content-Disposition", $"attachment; filename={fileName}");

                return File(pdfReport, contentType, fileName);
            }
            catch (Exception ex)
            {
                return NotFound(ex.Message);
            }
        }
    }
}
