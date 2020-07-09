//
//  Post.m
//  Insta
//
//  Created by Ruben Green on 7/7/20.
//  Copyright © 2020 Ruben Green. All rights reserved.
//

#import "Post.h"

@implementation Post

@dynamic postID;
@dynamic userID;
@dynamic author;
@dynamic caption;
@dynamic image;

+ (nonnull NSString*) parseClassName {
    return @"Post";
}

+ (void) postUserImage:(UIImage *)image withCaption:(NSString *)caption withCompletion:(PFBooleanResultBlock)completion{
    Post* newPost = [Post new];
    newPost.image = [self getPFFileFromImage:image];
    newPost.author = PFUser.currentUser;
    newPost.caption = caption;
    
    [newPost saveInBackgroundWithBlock:completion];
}

+ (PFFileObject*)getPFFileFromImage:(UIImage* _Nullable)image{
    if(!image){
        return nil;
    }
    
    NSData* imageData = UIImagePNGRepresentation(image);
    
    if(!imageData){
        return nil;
    }
    
    return [PFFileObject fileObjectWithName:@"image.png" data:imageData];
}

@end
