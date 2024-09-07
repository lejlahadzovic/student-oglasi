using AutoMapper;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.VisualStudio.Services.Users;
using StudentOglasi.Model.Requests;
using StudentOglasi.Services.Database;
using StudentOglasi.Services.StateMachine.PrakseStateMaachine;

namespace StudentOglasi.Services.StateMachines.RezervacijeStateMachine
{
    public class BaseRezervacijaState
    {
        protected StudentoglasiContext _context;
        public IMapper _mapper { get; set; }
        protected IServiceProvider _serviceProvider { get; set; }
        public BaseRezervacijaState(IServiceProvider serviceProvider, StudentoglasiContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
            _serviceProvider = serviceProvider;
        }

        public virtual Task<Model.Rezervacije> Approve(int studentId, int smjestajnaJedinicaId)
        {
            throw new UserException("Action is not allowed!");
        }
        public virtual Task<Model.Rezervacije> Cancel(int studentId, int smjestajnaJedinicaId)
        {
            throw new UserException("Action is not allowed!");
        }
        public virtual Task<Model.Rezervacije> Insert(RezervacijaInsertRequest request)
        {
            throw new UserException("Action is not allowed in this state!");
        }

        public BaseRezervacijaState CreateState(string stateName)
        {
            switch (stateName)
            {
                case "Initial":
                case null:
                    return _serviceProvider.GetService<InitialRezervacijaState>();
                    break;
                case "Na cekanju":
                    return _serviceProvider.GetService<DraftRezervacijaState>();
                    break;
                case "Odobrena":
                    return _serviceProvider.GetService<ApprovedRezervacijaState>();
                    break;
                case "Otkazana":
                    return _serviceProvider.GetService<CanceledRezervacijaState>();
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
