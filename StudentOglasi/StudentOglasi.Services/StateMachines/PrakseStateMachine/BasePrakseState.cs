using AutoMapper;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.VisualStudio.Services.Users;
using StudentOglasi.Model.Requests;
using StudentOglasi.Services.Database;
using StudentOglasi.Services.StateMachine.PrakseStateMaachine;

namespace StudentOglasi.Services.StateMachines.PrakseStateMachine
{
    public class BasePrakseState
    {
        protected StudentoglasiContext _context;
        public IMapper _mapper { get; set; }
        protected IServiceProvider _serviceProvider { get; set; }
        public BasePrakseState(IServiceProvider serviceProvider, StudentoglasiContext context, IMapper mapper)
        {
            _context = context;
            _mapper = mapper;
            _serviceProvider = serviceProvider;
        }
        public virtual Task<Model.Prakse> Insert(PrakseInsertRequest request)
        {
            throw new UserException("Not allowed!");
        }
        public virtual Task<Model.Prakse> Update(int id, PrakseUpdateRequest request)
        {
            throw new UserException("Not allowed!");
        }
        public virtual Task<Model.Prakse> Activate(int id)
        {
            throw new UserException("Not allowed!");
        }
        public virtual Task<Model.Prakse> Hide(int id)
        {
            throw new UserException("Not allowed!");
        }
        public virtual Task<Model.Prakse> Delete(int id)
        {
            throw new UserException("Not allowed!");
        }
        public BasePrakseState CreateState(string stateName)
        {
            switch (stateName)
            {
                case "Initial":
                case null:
                    return _serviceProvider.GetService<InitialPraksaState>();
                    break;
                case "Draft":
                    return _serviceProvider.GetService<DraftPrakseState>();
                    break;
                case "Aktivan":
                    return _serviceProvider.GetService<ActivePrakseState>();
                    break;
                default:
                    throw new Exception("Not allowed");
            }
        }
        public virtual async Task<List<string>> AllowedActions()
        {
            return new List<string>();
        }
    }
}
