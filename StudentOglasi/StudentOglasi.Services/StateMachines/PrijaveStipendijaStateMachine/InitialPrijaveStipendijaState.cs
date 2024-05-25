using AutoMapper;
using StudentOglasi.Services.Database;
using StudentOglasi.Services.StateMachines.PrijaveStipendijaStateMachine;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Services.StateMachines.PrijaveStipendijaStateMachine
{
    public class InitialPrijaveStipendijaState : BasePrijaveStipendijaState
    {
        public InitialPrijaveStipendijaState(IServiceProvider serviceProvider, StudentoglasiContext context, IMapper mapper) : base(serviceProvider, context, mapper)
        {
        }
    }
}
