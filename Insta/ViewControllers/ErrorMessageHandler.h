//
//  ErrorMessageHandler.h
//  Insta
//
//  Created by Ruben Green on 7/9/20.
//  Copyright © 2020 Ruben Green. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ErrorMessageHandler : NSObject

+ (void)showErrorMessageWithString:(NSString*)string;

@end

NS_ASSUME_NONNULL_END
