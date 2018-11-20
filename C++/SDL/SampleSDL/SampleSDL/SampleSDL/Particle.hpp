//
//  Particle.hpp
//  SampleSDL
//
//  Created by Konymp on 15/10/18.
//  Copyright © 2018 konymp. All rights reserved.
//

#ifndef Particle_hpp
#define Particle_hpp

#include <stdio.h>

namespace SampleSDL {
    class Particle{
    public:
        double x=0,y=0;
        double angle=0,speed=0;
        Particle();
        void setSpeed(int speed);
        void setAngle(int angle);
        void setXandYCoordinates(double x, double y){
            this->x = x;
            this->y = y;
        }
        void increment(int time);
    };
}


#endif /* Particle_hpp */
