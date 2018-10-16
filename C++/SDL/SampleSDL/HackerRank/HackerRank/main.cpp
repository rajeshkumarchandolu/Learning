//
//  main.cpp
//  HackerRank
//
//  Created by Konymp on 14/10/18.
//  Copyright © 2018 konymp. All rights reserved.
//

#include <iostream>
using namespace std;


int main(int argc, const char * argv[]) {

    char * s= "hello";
    int index =0;
   char c = s[0];
    while(c!= '\0'){
        cout << "index :" <<index <<"char :" << c << "\n";
      //  index++;
        c= s[index++];
        
        
        
    }
    return 0;
}


