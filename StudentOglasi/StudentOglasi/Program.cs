using DotNetEnv;
using Microsoft.AspNetCore.Authentication;
using Microsoft.EntityFrameworkCore;
using Microsoft.OpenApi.Models;
using StudentOglasi;
using StudentOglasi.Filters;
using StudentOglasi.Model;
using StudentOglasi.Services;
using StudentOglasi.Services.Database;
using StudentOglasi.Services.Interfaces;
using StudentOglasi.Services.OglasiStateMachine;
using StudentOglasi.Services.Services;
using StudentOglasi.Services.StateMachine.PrakseStateMaachine;
using StudentOglasi.Services.StateMachine.StipendijeStateMachine;
using StudentOglasi.Services.StateMachines.PrakseStateMachine;
using StudentOglasi.Services.StateMachines.PrijavePrakseStateMachine;
using StudentOglasi.Services.StateMachines.PrijaveStipendijaStateMachine;
using StudentOglasi.Services.StateMachines.RezervacijeStateMachine;
using System.Globalization;

var builder = WebApplication.CreateBuilder(args);

CultureInfo.DefaultThreadCurrentCulture = new CultureInfo("en-US");
CultureInfo.DefaultThreadCurrentUICulture = new CultureInfo("en-US");

// Add services to the container.
builder.Services.AddHttpContextAccessor();
builder.Services.AddTransient<IObjaveService, ObjaveService>();
builder.Services.AddTransient<IKorisniciService, KorisniciService>();
builder.Services.AddTransient<IKategorijeService, KategorijeService>();
builder.Services.AddTransient<IPrakseService, PrakseService>();
builder.Services.AddTransient<IStipendijeService, StipendijeService>();
builder.Services.AddSingleton<FileService>();
builder.Services.AddTransient<RecommenderSystem>();
builder.Services.AddTransient<IStatusOglasiService, StatusOglasiService>();
builder.Services.AddTransient<IOglasiService, OglasiService>();
builder.Services.AddTransient<IOrganizacijeService, OrganizacijeService>();
builder.Services.AddTransient<IStipenditoriService, StipenditoriService>();
builder.Services.AddTransient<IStudentiService, StudentiService>();
builder.Services.AddTransient<KorisniciService>();
builder.Services.AddTransient<IFakultetiService, FakultetiService>();
builder.Services.AddTransient<IUniverzitetiService, UniverzitetiService>();
builder.Services.AddTransient<INacinStudiranjaService, NacinStudiranjaService>();
builder.Services.AddTransient<IPrijaveStipendijaService, PrijaveStipendijaService>();
builder.Services.AddTransient<IPrijavePraksaService, PrijavePraksaService>();
builder.Services.AddTransient<IStatusPrijaveService, StatusPrijaveService>();
builder.Services.AddTransient<IRezervacijeService, RezervacijeService>();
builder.Services.AddTransient<BasePrakseState>();
builder.Services.AddTransient<InitialPraksaState>();
builder.Services.AddTransient<ActivePrakseState>();
builder.Services.AddTransient<DraftPrakseState>();
builder.Services.AddTransient<BaseStipendijeState>();
builder.Services.AddTransient<InitialStipendijeState>();
builder.Services.AddTransient<ActiveStipendijeState>();
builder.Services.AddTransient<BasePrijavePrakseState>();
builder.Services.AddTransient<DraftStipendijeState>();
builder.Services.AddTransient<ISmjestajiService, SmjestajiService>();
builder.Services.AddTransient<ISmjestajanaJedinicaService, SmjestajnaJedinicaService>();
builder.Services.AddTransient<IGradoviService, GradoviService>();
builder.Services.AddTransient<ITipSmjestajaService, TipSmjestajaService>();
builder.Services.AddTransient<ISlikeService, SlikeService>();
builder.Services.AddTransient<ILikeService, LikeService>();
builder.Services.AddTransient<IKomentariService, KomentariService>();
builder.Services.AddTransient<IOcjeneService, OcjeneService>();
builder.Services.AddTransient<IMailService, MailService>();
builder.Services.AddTransient<IObavijestiService, ObavijestiService>();
builder.Services.AddTransient<SlikeService>();
builder.Services.AddTransient<ObavijestiService>();
builder.Services.AddTransient<SmjestajnaJedinicaService>();
builder.Services.AddTransient<DraftPrijavePraksaState>();
builder.Services.AddTransient<ApprovedPrijavePraksaState>();
builder.Services.AddTransient<CanceledPrijavePraksaState>();
builder.Services.AddTransient<InitialPrijavePraksaState>();
builder.Services.AddTransient<BasePrijaveStipendijaState>();
builder.Services.AddTransient<DraftPrijaveStipendijaState>();
builder.Services.AddTransient<ApprovedPrijaveStipendijaState>();
builder.Services.AddTransient<CanceledPrijaveStipendijaState>();
builder.Services.AddTransient<InitialPrijaveStipendijaState>();
builder.Services.AddTransient<BaseRezervacijaState>();
builder.Services.AddTransient<DraftRezervacijaState>();
builder.Services.AddTransient<ApprovedRezervacijaState>();
builder.Services.AddTransient<CanceledRezervacijaState>();
builder.Services.AddTransient<InitialRezervacijaState>();
builder.Services.AddTransient<IStripeService, StripeService>();

builder.Services.AddControllers(x =>
{
    x.Filters.Add<ErrorFilter>();
});
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(c =>
{
    c.AddSecurityDefinition("basicAuth", new Microsoft.OpenApi.Models.OpenApiSecurityScheme()
    {
        Type = Microsoft.OpenApi.Models.SecuritySchemeType.Http,
        Scheme = "basic"
    });
    c.AddSecurityRequirement(new Microsoft.OpenApi.Models.OpenApiSecurityRequirement()
    {
        {      new OpenApiSecurityScheme
                {
                    Reference = new OpenApiReference{Type = ReferenceType.SecurityScheme, Id="basicAuth"}
                },
                new string[]{}
        }
    });
});


var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<StudentoglasiContext>(options =>
options.UseSqlServer(connectionString));

builder.Services.AddAutoMapper(typeof(IObjaveService));
builder.Services.AddAutoMapper(typeof(IPrakseService));
builder.Services.AddAutoMapper(typeof(IKorisniciService));
builder.Services.AddAutoMapper(typeof(IStipendijeService));
builder.Services.AddAuthentication("BasicAuthentication")
    .AddScheme<AuthenticationSchemeOptions, BasicAuthenticationHandler>("BasicAuthentication", null);

Env.Load();

builder.Services.Configure<StripeSettings>(options =>
{
    options.SecretKey = Environment.GetEnvironmentVariable("STRIPE_SECRET_KEY");
    options.PublishableKey = Environment.GetEnvironmentVariable("STRIPE_PUBLISHABLE_KEY");
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();

app.UseAuthentication();
app.UseAuthorization();


using (var scope = app.Services.CreateScope())
{
    var dbContext = scope.ServiceProvider.GetRequiredService<StudentoglasiContext>();
    dbContext.Database.Migrate();
}

app.MapControllers();

app.Run();
