//
//  Window.cpp
//  SampleSDL
//
//  Created by Konymp on 12/10/18.
//  Copyright © 2018 konymp. All rights reserved.
//

#include <SDL2/SDL.h>
#include <iostream>



#include "Window.hpp"


Window :: Window(char *screenName,int width, int height){
    this->width = width;
    this->height = height;
    SDL_Init(SDL_INIT_EVERYTHING);
    window =SDL_CreateWindow(screenName, SDL_WINDOWPOS_CENTERED_MASK, SDL_WINDOWPOS_CENTERED_MASK, width, height, SDL_WINDOW_RESIZABLE);
    pixeldata = new Uint32[width*height];
    swarm = new SampleSDL::Swarm(width,height);
    std::cout<<"End of Window constructor";
};
Window :: ~Window(){
    std::cout <<"window is destroyed";
        SDL_DestroyWindow(window);
    delete swarm;
};

void Window::createRenderer(){
    renderer = SDL_CreateRenderer(window, -1, SDL_RENDERER_ACCELERATED);
    if(renderer == NULL){
        std::cout << "unable to create the renderer";
        this->~Window();
    }
    
};

void Window::createTexture(){
    texture = SDL_CreateTexture(renderer, SDL_PIXELFORMAT_RGBA8888, SDL_TEXTUREACCESS_STATIC, width, height);
    
    //creatign the pixel data
    
    
    
    
}

void Window::SetPixel(int currentWidth,int currentHeight , Uint8 red, Uint8 green , Uint8 blue ){
    
    if(currentHeight>=height || currentHeight<0){
        return;
    }
    if(currentWidth>=width || currentWidth<0){
        return;
    }
    
    
    Uint32 color = 0;
    color +=red;
    color <<=8;
    color +=green;
    color <<= 8;
    color+=blue;
    color<<=8;
    color+=0xFF;
    
    pixeldata[(currentHeight*width)+currentWidth] = color;
    
    
}


void Window::draw(){
   
    
    SDL_UpdateTexture(texture, NULL, pixeldata, width*sizeof(Uint32));
    SDL_RenderClear(renderer);
    SDL_RenderCopy(renderer, texture, NULL, NULL);
    SDL_RenderPresent(renderer);
    
}


void Window::clear(){
    memset(pixeldata, 0, width*height*sizeof(Uint32));
}
