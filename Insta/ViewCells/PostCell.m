//
//  PostCell.m
//  Insta
//
//  Created by Ruben Green on 7/8/20.
//  Copyright © 2020 Ruben Green. All rights reserved.
//

#import "PostCell.h"

@implementation PostCell

- (void)setPost:(Post *)post{
    _post = post;
    
    self.authorLabel.text = post.author.username;
    self.captionLabel.text = post.caption;
    self.postImageView.image = [UIImage imageNamed:@"image_placeholder"];
    self.postImageView.file = post.image;
    [self.postImageView loadInBackground];
}

@end
