//
//  HomeViewController.m
//  Insta
//
//  Created by Ruben Green on 7/6/20.
//  Copyright © 2020 Ruben Green. All rights reserved.
//

#import "HomeViewController.h"
#import "SceneDelegate.h"
#import <Parse/Parse.h>

@interface HomeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)didTapLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        if(error){
            NSLog(@"Error logging out: %@", error.localizedDescription);
        }
        else{
            //Refactor this
            SceneDelegate* sceneDelegate = (SceneDelegate*)self.view.window.windowScene.delegate;
            
            UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UINavigationController* homeViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            sceneDelegate.window.rootViewController = homeViewController;
        }
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
