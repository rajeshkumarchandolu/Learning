//
//  Particle.cpp
//  SampleSDL
//
//  Created by Konymp on 15/10/18.
//  Copyright © 2018 konymp. All rights reserved.
//

#include "Particle.hpp"
#include <stdlib.h>
#include <math.h>
SampleSDL::Particle::Particle(){
     angle = rand()%360;
     //speed  = (((2.0*rand())/RAND_MAX)-1)*0.0001 ;
}

void SampleSDL::Particle::setSpeed(int speed){
    this->speed = speed* 0.000005;
    
}
void SampleSDL::Particle::setAngle(int angle){
    this->angle = angle;
    
}

void SampleSDL::Particle :: increment(int time){
    
    angle += 0.0016 *2;
    
    this->x += speed*(cos(angle));
    this->y += speed*sin(angle);
    
    if(this->x <-1 || this->x >1 ||this->y <-1 || this->y >1 ){
    //    angle +=180;
    }
    
//    if(this->x <-1 || this->x >1){
//        xspeed *= -1;
//    }
//    if(this->y <-1 || this->y >1){
//        yspeed *= -1;
//    }
}
