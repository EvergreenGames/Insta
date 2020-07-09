//
//  ViewController.m
//  Insta
//
//  Created by Ruben Green on 7/6/20.
//  Copyright © 2020 Ruben Green. All rights reserved.
//

#import "LoginViewController.h"
#import "SceneDelegate.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (IBAction)loginAction:(id)sender {
    [self loginUser];
}
- (IBAction)createAccountAction:(id)sender {
    [self registerUser];
}

- (void)registerUser {
    PFUser* newUser = [PFUser user];
    
    newUser.username = self.usernameTextField.text;
    newUser.password = self.passwordTextField.text;
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        if(error){
            NSLog(@"Error creating user: %@", error.localizedDescription);
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to sign up. Please try again." preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:okAction];
            [self presentViewController:alert animated:true completion:nil];
        }
        else{
            NSLog(@"Created User: %@", newUser.username);
            [self loginUser];
        }
    }];
}

- (void)loginUser {
    NSString* username = self.usernameTextField.text;
    NSString* password = self.passwordTextField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * _Nullable user, NSError * _Nullable error) {
        if(error){
            NSLog(@"Login Failed: %@", error.localizedDescription);
            UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:@"Failed to log in" preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:okAction];
            [self presentViewController:alert animated:true completion:nil];
        }
        else{
            NSLog(@"Login Successful");
            [self switchToMainView];
        }
    }];
}

- (void)switchToMainView {
    SceneDelegate* sceneDelegate = (SceneDelegate*)self.view.window.windowScene.delegate;
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UINavigationController* homeViewController = [storyboard instantiateViewControllerWithIdentifier:@"HomeFeedNavigationController"];
    sceneDelegate.window.rootViewController = homeViewController;
}

@end
