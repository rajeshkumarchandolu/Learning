//
//  main.cpp
//  SampleSDL
//
//  Created by Konymp on 12/10/18.
//  Copyright © 2018 konymp. All rights reserved.
//

#include <iostream>
#include <SDL2/SDL.h>
#import "Window.hpp"
#include <iomanip>
#include <math.h>
#include <stdlib.h>
#include <time.h>
using namespace std;
#import "Particle.hpp"

int main(int argc, const char * argv[]) {
    
    
    int width =600;
    int Height = 300;
  
    Window *window = new Window("sampleWindow",600,300);
    window->createRenderer();
    window->createTexture();
    
    SDL_Event event;
    
    //run loop
    bool isquit = false;
    int timeelapsed =0;
    
    int avg = (width+Height)/2;
    
    while(!isquit){
        int shiftRequired = sin(timeelapsed*0.01)*128;
       // cout << "the shift is :"<<shiftRequired << "\n";
        timeelapsed ++;
        window->clear();
        
        SampleSDL::Particle *Group = window->swarm->getParticles();
        
        
        
        for( int i =0; i<1000;i++){
            int XCoOrdinate = ((Group[i].x+1) * (avg/2)) +75;
            int YcoOrdinate = ((Group[i].y+1) * (avg/2)) -75;
             Group[i].increment(timeelapsed);
            window->SetPixel(XCoOrdinate, YcoOrdinate, 0xFF, 0xFF, 0xFF);
           // std::cout <<"particle X:" << Group[i].x << "\t particle y :" << Group[i].y << std::endl;
            
        }
        
        
//        //every frame logic
//        for(int height=0;height<window->getScreenHeight();height++){
//            for(int width =0;width <window->getScreenWidth();width++ ){
//                window->SetPixel(height,width ,0xFF, 0xFF, 0xFF);
//            }
//        }
        
        //draw
        window->draw();
        
        if(SDL_PollEvent(&event)){
            if(event.type == SDL_QUIT){
                isquit = true;
            }
        }
    }
    
    //delete the window
    delete window;

    return 0;
}

void decToBinary(int n)
{
    // array to store binary number
    int binaryNum[1000];
    
    // counter for binary array
    int i = 0;
    while (n > 0) {
        
        // storing remainder in binary array
        binaryNum[i] = n % 2;
        n = n / 2;
        i++;
    }
    
    // printing binary array in reverse order
    for (int j = i - 1; j >= 0; j--)
        cout << binaryNum[j];
}
