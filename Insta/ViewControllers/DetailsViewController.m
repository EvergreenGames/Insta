//
//  DetailsViewController.m
//  Insta
//
//  Created by Ruben Green on 7/8/20.
//  Copyright © 2020 Ruben Green. All rights reserved.
//

#import "DetailsViewController.h"
#import <PFImageView.h>
@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet PFImageView *postImageView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.authorLabel.text = self.post.author.username;
    self.captionLabel.text = self.post.caption;
    NSString* dateString = [NSDateFormatter localizedStringFromDate:self.post.createdAt dateStyle:NSDateFormatterShortStyle timeStyle:NSDateFormatterShortStyle];
    self.dateLabel.text = [NSString stringWithFormat:@"Posted at %@", dateString];
    self.postImageView.image = [UIImage imageNamed:@"image_placeholder"];
    self.postImageView.file = self.post.image;
    [self.postImageView loadInBackground];
}

@end
