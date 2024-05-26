using AutoMapper;
using StudentOglasi.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Services.StateMachines.PrijavePrakseStateMachine
{
    public class InitialPrijavePraksaState : BasePrijavePrakseState
    {
        public InitialPrijavePraksaState(IServiceProvider serviceProvider, StudentoglasiContext context, IMapper mapper) : base(serviceProvider, context, mapper)
        {
        }
    }
}
