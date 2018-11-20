//
//  Window.hpp
//  SampleSDL
//
//  Created by Konymp on 12/10/18.
//  Copyright © 2018 konymp. All rights reserved.
//

#ifndef Window_hpp
#define Window_hpp

#include <stdio.h>
#include "Swarm.hpp"

class Window {
    public :
    //properties
    SampleSDL::Swarm *swarm;
    
    Window(char *screenName,int width, int height);
    //destructor
    ~Window();
    //getScreenheight
    int getScreenHeight(){return height;};
    //getScreenWidth
    int getScreenWidth(){return width;};
    //Renderer Creation Method
    void createRenderer();
    //create texture method
    void createTexture();
    //setpixel color
    void SetPixel(int x ,int y, Uint8 Red, Uint8 Green , Uint8 Blue );
    //draw
    void draw();
    //Blur
    void blur();
    //clear
    void clear();
    private :
    int width,height;
    SDL_Window *window =NULL;
    SDL_Renderer *renderer = NULL;
    SDL_Texture *texture = NULL;
    Uint32 *pixeldata,*tempPixelData;
    
    
};

#endif /* Window_hpp */
