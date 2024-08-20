using AutoMapper;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.VisualStudio.Services.Users;
using StudentOglasi.Model.Requests;
using StudentOglasi.Services.Database;
using StudentOglasi.Services.StateMachine.PrakseStateMaachine;

namespace StudentOglasi.Services.StateMachines.PrijaveStipendijaStateMachine
{
    public class BasePrijaveStipendijaState
    {
        protected StudentoglasiContext _context;
        public IMapper _mapper { get; set; }
        protected IServiceProvider _serviceProvider { get; set; }
        public BasePrijaveStipendijaState(IServiceProvider serviceProvider, StudentoglasiContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
            _serviceProvider = serviceProvider;
        }
        public virtual Task<Model.PrijaveStipendija> Insert(PrijaveStipendijaInsertRequest request)
        {
            throw new UserException("Action is not allowed!");
        }
        public virtual Task<Model.PrijaveStipendija> Approve(int studentId, int stipendijaId)
        {
            throw new UserException("Action is not allowed!");
        }
        public virtual Task<Model.PrijaveStipendija> Cancel(int studentId, int stipendijaId)
        {
            throw new UserException("Action is not allowed!");
        }
   
        public BasePrijaveStipendijaState CreateState(string stateName)
        {
            switch (stateName)
            {
                case "Initial":
                case null:
                    return _serviceProvider.GetService<InitialPrijaveStipendijaState>();
                    break;
                case "Na cekanju":
                    return _serviceProvider.GetService<DraftPrijaveStipendijaState>();
                    break;
                case "Odobrena":
                    return _serviceProvider.GetService<ApprovedPrijaveStipendijaState>();
                    break;
                case "Otkazana":
                    return _serviceProvider.GetService<CanceledPrijaveStipendijaState>();
                    break;
                default:
                    throw new UserException("Action is not allowed!");
            }
        }
        public virtual async Task<List<string>> AllowedActions()
        {
            return new List<string>();
        }
    }
}
