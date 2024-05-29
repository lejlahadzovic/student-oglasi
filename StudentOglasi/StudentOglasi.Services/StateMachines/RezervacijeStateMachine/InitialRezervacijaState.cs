using AutoMapper;
using StudentOglasi.Services.Database;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace StudentOglasi.Services.StateMachines.RezervacijeStateMachine
{
    public class InitialRezervacijaState : BaseRezervacijaState
    {
        public InitialRezervacijaState(IServiceProvider serviceProvider, StudentoglasiContext context, IMapper mapper) : base(serviceProvider, context, mapper)
        {
        }
    }
}
