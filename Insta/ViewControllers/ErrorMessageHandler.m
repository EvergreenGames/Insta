//
//  ErrorMessageHandler.m
//  Insta
//
//  Created by Ruben Green on 7/9/20.
//  Copyright © 2020 Ruben Green. All rights reserved.
//

#import "ErrorMessageHandler.h"

@implementation ErrorMessageHandler

+ (void)showErrorMessageWithString:(NSString *)string{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Error" message:string preferredStyle:(UIAlertControllerStyleAlert)];
    
}

@end
