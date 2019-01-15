//
//  main.cpp
//  SampleC++
//
//  Created by Konymp on 23/11/18.
//  Copyright © 2018 konymp. All rights reserved.
//

#include <iostream>
#include <vector>

#include "A.hpp"
#include "B.hpp"
#include "C.hpp"


void problem1(int *a, int *b, int length){
    
    int combinedProduct = 1;
    
    for( int i =0 ; i<length;i++){
        combinedProduct *= a[i];
    }
    
    for(int i=0;i<length;i++){
        b[i] = combinedProduct / a[i];
    }
    
}

int main(int argc, const char * argv[]) {
    
    
    std::vector<int> v;
    v.push_back(10);
    v.push_back(11);
    
    v.pop_back();
    
    A a;
    B *b;
     C c;
    
    a.h = 10;
    
    a.Hello();
    
    b = &c;
 
    b->Hello();
    
    c.Hello();
    
    
    return 0;
}





