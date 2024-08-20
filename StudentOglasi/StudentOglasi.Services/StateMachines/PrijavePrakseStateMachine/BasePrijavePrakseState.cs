using AutoMapper;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.VisualStudio.Services.Users;
using StudentOglasi.Model.Requests;
using StudentOglasi.Services.Database;
using StudentOglasi.Services.StateMachine.PrakseStateMaachine;

namespace StudentOglasi.Services.StateMachines.PrijavePrakseStateMachine
{
    public class BasePrijavePrakseState
    {
        protected StudentoglasiContext _context;
        public IMapper _mapper { get; set; }
        protected IServiceProvider _serviceProvider { get; set; }
        public BasePrijavePrakseState(IServiceProvider serviceProvider, StudentoglasiContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
            _serviceProvider = serviceProvider;
        }
        public virtual Task<Model.PrijavePraksa> Insert(PrijavePrakseInsertRequest request)
        {
            throw new UserException("Action is not allowed!");
        }

        public virtual Task<Model.PrijavePraksa> Approve(int studentId, int praksaId)
        {
            throw new UserException("Action is not allowed!");
        }
        public virtual Task<Model.PrijavePraksa> Cancel(int studentId, int praksaId)
        {
            throw new UserException("Action is not allowed!");
        }
   
        public BasePrijavePrakseState CreateState(string stateName)
        {
            switch (stateName)
            {
                case "Initial":
                case null:
                    return _serviceProvider.GetService<InitialPrijavePraksaState>();
                    break;
                case "Na cekanju":
                    return _serviceProvider.GetService<DraftPrijavePraksaState>();
                    break;
                case "Odobrena":
                    return _serviceProvider.GetService<ApprovedPrijavePraksaState>();
                    break;
                case "Otkazana":
                    return _serviceProvider.GetService<CanceledPrijavePraksaState>();
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
