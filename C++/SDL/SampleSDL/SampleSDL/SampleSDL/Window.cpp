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
    tempPixelData = new Uint32[width*height];
    swarm = new SampleSDL::Swarm(width,height);
    std::cout<<"End of Window constructor";
};
Window :: ~Window(){
    std::cout <<"window is destroyed";
        SDL_DestroyWindow(window);
    delete[] pixeldata;
    delete[] tempPixelData;
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


void Window::blur(){
    
    for(int i=0;i < width*height;i++){
        
        int maxValue = (height*width-1);
        
        if(i%width ==0 || i/width < 1 || (i%width == (width-1)) || ((i+width)/maxValue)>0){
            //do nothing to edges
            continue;
        }
        
        int indexTopLeft =  (i-width-1);
        int indexTop = (i-width);
        int indexTopRight = (i-width+1);
        int indexleft = (i-1);
        int indexright = (i+1);
        int indexBottonLeft = (i+width-1);
        int indexBottom = (i+width);
        int indexBottomRight = (i+width+1);
        
        
        int red = (((pixeldata[indexTopLeft]&0xFF000000)>> 24) + ((pixeldata[indexTop]&0xFF000000)>> 24) + ((pixeldata[indexTopRight]&0xFF000000)>> 24) +
                      ((pixeldata[indexleft]&0xFF000000)>> 24) + ((pixeldata[i]&0xFF000000)>> 24) + ((pixeldata[indexright]&0xFF000000)>> 24) +
                     ((pixeldata[indexBottonLeft]&0xFF000000)>> 24) + ((pixeldata[indexBottom]&0xFF000000)>> 24) + ((pixeldata[indexBottomRight]&0xFF000000)>> 24));
        
        int green = (((pixeldata[indexTopLeft]&0x00FF0000)>>16) + ((pixeldata[indexTop]&0x00FF0000)>>16) + ((pixeldata[indexTopRight]&0x00FF0000)>>16) +
                     ((pixeldata[indexleft]&0x00FF0000)>>16) + ((pixeldata[i]&0x00FF0000)>>16) + ((pixeldata[indexright]&0x00FF0000)>>16) +
                     ((pixeldata[indexBottonLeft]&0x00FF0000)>>16) + ((pixeldata[indexBottom]&0x00FF0000)>>16) + ((pixeldata[indexBottomRight]&0x00FF0000)>>16));
        
        int blue = (((pixeldata[indexTopLeft]&0x0000FF00)>> 8) + ((pixeldata[indexTop]&0x0000FF00)>> 8) + ((pixeldata[indexTopRight]&0x0000FF00)>> 8) +
                     ((pixeldata[indexleft]&0x0000FF00)>> 8) + ((pixeldata[i]&0x0000FF00)>> 8) + ((pixeldata[indexright]&0x0000FF00)>> 8) +
                     ((pixeldata[indexBottonLeft]&0x0000FF00)>> 8) + ((pixeldata[indexBottom]&0x0000FF00)>> 8) + ((pixeldata[indexBottomRight]&0x0000FF00)>> 8));
       
        
        if(i == 90301){
            //std::cout<< "requiredIndex";
        }
        
        Uint32 blurredcolor = 0x000000;
        blurredcolor <<= 8;
        blurredcolor +=red/9;
        blurredcolor <<= 8;
        blurredcolor +=green/9;
        blurredcolor <<= 8;
        blurredcolor +=blue/9;
        //setting Alphs
        blurredcolor <<=8 ;
        blurredcolor +=0xFF;
        
        tempPixelData[i] = blurredcolor;
        
    }
    // exchaing the tempdata and pixeldata
    
    Uint32 *temp = pixeldata;
    pixeldata = tempPixelData;
    tempPixelData = temp;
    
    
}


void Window::clear(){
    memset(pixeldata, 0, width*height*sizeof(Uint32));
}
