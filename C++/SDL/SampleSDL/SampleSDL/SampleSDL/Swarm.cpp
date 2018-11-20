//
//  Swarm.cpp
//  SampleSDL
//
//  Created by Konymp on 15/10/18.
//  Copyright © 2018 konymp. All rights reserved.
//

#include "Swarm.hpp"
#include <stdlib.h>
#include <iostream>

namespace SampleSDL {
    Swarm :: Swarm(int width, int heigth){
        GroupParticles = new Particle[5000];
        for(int i=0 ;i<5000;i++){
//            double randX = ((2.0*rand())/RAND_MAX)-1;
//            double randY = ((2.0*rand())/RAND_MAX)-1;
            double randX = 0;
            double randY = 0;
            GroupParticles[i].setXandYCoordinates(randX,randY);
            GroupParticles[i].setSpeed(i);
            GroupParticles[i].setAngle(i%360);
            std::cout << "\tx:"<<GroupParticles[i].x << "\t y : " <<GroupParticles[i].y << "\tindex :"<<i<<std::endl;
        }
        
    }
    
    Swarm::~Swarm(){
        std::cout <<"Group particles are destroyed";
        delete [] GroupParticles;
    }
}
