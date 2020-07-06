//
//  ViewController.m
//  Insta
//
//  Created by Ruben Green on 7/6/20.
//  Copyright © 2020 Ruben Green. All rights reserved.
//

#import "LoginViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *usernameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

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
        }
        else{
            NSLog(@"Created User: %@", newUser.username);
            
        }
    }];
}

- (void)loginUser {
    NSString* username = self.usernameTextField.text;
    NSString* password = self.passwordTextField.text;
    
    [PFUser logInWithUsernameInBackground:username password:password block:^(PFUser * _Nullable user, NSError * _Nullable error) {
        if(error){
            NSLog(@"Login Failed: %@", error.localizedDescription);
        }
        else{
            NSLog(@"Login Successful");
        }
    }];
}

@end
