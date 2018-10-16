//
//  Swarm.hpp
//  SampleSDL
//
//  Created by Konymp on 15/10/18.
//  Copyright © 2018 konymp. All rights reserved.
//

#ifndef Swarm_hpp
#define Swarm_hpp

#include <stdio.h>
#include "Particle.hpp"

namespace SampleSDL {
    
    class Swarm {
    public:
        Particle *GroupParticles;
        Swarm(int width, int heigth);
        ~Swarm();
        Particle * getParticles(){return GroupParticles;};
        
    };
    
}

#endif /* Swarm_hpp */
