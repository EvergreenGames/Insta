//
//  ComposeViewController.m
//  Insta
//
//  Created by Ruben Green on 7/7/20.
//  Copyright © 2020 Ruben Green. All rights reserved.
//

#import "ComposeViewController.h"
#import "Post.h"

@interface ComposeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *captionTextField;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)showPicker:(UIImagePickerControllerSourceType) type {
    UIImagePickerController* imagePickerController = [UIImagePickerController new];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = type;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    UIImage* editedImage = info[UIImagePickerControllerEditedImage];
    
    [self.contentImageView setImage:editedImage];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)chooseImageAction:(id)sender {
    NSLog(@"Tapped");
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction* camAction = [UIAlertAction actionWithTitle:@"Take Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showPicker:UIImagePickerControllerSourceTypeCamera];
    }];
    [alertController addAction:camAction];
    
    UIAlertAction* libraryAction = [UIAlertAction actionWithTitle:@"Choose Photo" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self showPicker:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    [alertController addAction:libraryAction];
    
    UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:cancelAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
- (IBAction)cancelAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)shareAction:(id)sender {
    [Post postUserImage:self.contentImageView.image withCaption:self.captionTextField.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(error){
            NSLog(@"Error uploading post: %@", error.localizedDescription);
        }
        else{
            [self dismissViewControllerAnimated:YES completion:nil];
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
