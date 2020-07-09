//
//  ComposeViewController.m
//  Insta
//
//  Created by Ruben Green on 7/7/20.
//  Copyright © 2020 Ruben Green. All rights reserved.
//

#import "ComposeViewController.h"
#import "Post.h"
#import <MBProgressHUD.h>

@interface ComposeViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextView *captionTextField;
@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

@end

@implementation ComposeViewController

- (void)showPicker:(UIImagePickerControllerSourceType) type {
    UIImagePickerController* imagePickerController = [UIImagePickerController new];
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    imagePickerController.sourceType = type;
    
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    UIImage* editedImage = info[UIImagePickerControllerEditedImage];
    UIImage* resizedImage = [self resizeImage:editedImage withSize:CGSizeMake(512, 512)];
    
    [self.contentImageView setImage:resizedImage];
    
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
    [MBProgressHUD showHUDAddedTo:self.view animated:true];
    [Post postUserImage:self.contentImageView.image withCaption:self.captionTextField.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        if(error){
            NSLog(@"Error uploading post: %@", error.localizedDescription);
        }
        else{
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        [MBProgressHUD hideHUDForView:self.view animated:true];
    }];
}

- (UIImage *)resizeImage:(UIImage *)image withSize:(CGSize)size {
    UIImageView *resizeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, size.width, size.height)];
    
    resizeImageView.contentMode = UIViewContentModeScaleAspectFill;
    resizeImageView.image = image;
    
    UIGraphicsBeginImageContext(size);
    [resizeImageView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
