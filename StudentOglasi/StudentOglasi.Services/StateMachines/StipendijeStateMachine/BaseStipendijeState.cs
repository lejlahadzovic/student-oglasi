using AutoMapper;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.VisualStudio.Services.Users;
using StudentOglasi.Model.Requests;
using StudentOglasi.Services.Database;
using StudentOglasi.Services.StateMachine.PrakseStateMaachine;
using StudentOglasi.Services.StateMachine.StipendijeStateMachine;

namespace StudentOglasi.Services.OglasiStateMachine
{
    public class BaseStipendijeState
    {
        protected StudentoglasiContext _context;
        public IMapper _mapper { get; set; }
        protected IServiceProvider _serviceProvider { get; set; }
        public BaseStipendijeState(IServiceProvider serviceProvider, StudentoglasiContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
            _serviceProvider = serviceProvider;
        }
        public virtual Task<Model.Stipendije> Insert(StipendijeInsertRequest request)
        {
            throw new UserException("Action is not allowed!");
        }
        public virtual Task<Model.Stipendije> Update(int id, StipendijeUpdateRequest request)
        {
            throw new UserException("Action is not allowed!");
        }
        public virtual Task<Model.Stipendije> Hide(int id)
        {
            throw new UserException("Action is not allowed!");
        }
        public BaseStipendijeState CreateState(string stateName)
        {
            switch (stateName)
            {
                case "Kreiran":
                case null:
                    return _serviceProvider.GetService<InitialStipendijeState>();
                    break;
                case "Skica":
                    return _serviceProvider.GetService<DraftStipendijeState>();
                    break;
                case "Aktivan":
                    return _serviceProvider.GetService<ActiveStipendijeState>(); 
                    break;
                case "Istekao":
                    return _serviceProvider.GetService<InactiveStipendijeState>();
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
