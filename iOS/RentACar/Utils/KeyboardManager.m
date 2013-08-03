//
//  KeyboardManager.m
//  RentACar
//
//  Created by Matias Paillet on 8/3/13.
//  Copyright (c) 2013 Matias Paillet. All rights reserved.
//

#import "KeyboardManager.h"

#define KEYBOARD_HEIGHT             215
#define ANIMATION_DURATION           .2

@implementation KeyboardManager

static int offSet;

+ (void) willMoveToVisibleArea: (UITextField*) txtField inView: (UIView*) view{
    if (txtField.frame.origin.y + view.frame.origin.y < KEYBOARD_HEIGHT){
        return;
    }
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:ANIMATION_DURATION];
    
    offSet = (txtField.frame.origin.y - KEYBOARD_HEIGHT);
    
    [view setFrame: CGRectMake(view.frame.origin.x,
                               view.frame.origin.y - offSet ,
                               view.frame.size.width,
                               view.frame.size.height)];
    [UIView commitAnimations];
}

+ (void) returnToViewFrame : (UIView*) view {
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:ANIMATION_DURATION];
    
    [view setFrame: CGRectMake(0,
                               0 ,
                               view.frame.size.width,
                               view.frame.size.height)];
    [UIView commitAnimations];
}

@end
