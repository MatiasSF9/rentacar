//
//  KeyboardManager.h
//  RentACar
//
//  Created by Matias Paillet on 8/3/13.
//  Copyright (c) 2013 Matias Paillet. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KeyboardManager : NSObject

+ (void) willMoveToVisibleArea: (UITextField*) txtField inView: (UIView*) view;
+ (void) returnToViewFrame : (UIView*) view;

@end
