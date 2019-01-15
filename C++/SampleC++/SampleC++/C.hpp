//
//  C.hpp
//  SampleC++
//
//  Created by Konymp on 23/11/18.
//  Copyright © 2018 konymp. All rights reserved.
//

#ifndef C_hpp
#define C_hpp

#include <stdio.h>
#include <iostream>

#include "A.hpp"
#include "B.hpp"

class C : public A, public B {
    
    public :
    virtual void Hello();
};

#endif /* C_hpp */
