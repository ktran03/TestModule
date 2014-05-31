//
//  KTFacebookPhotosViewController.m
//  TestModule
//
//  Created by khanh tran on 2014-05-31.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import "KTFacebookPhotosViewController.h"
#import "UIImageView+WebCache.h"
#import "KTCollectionViewImageCell.h"

@interface KTFacebookPhotosViewController ()

@end

@implementation KTFacebookPhotosViewController{
    NSMutableArray *_thumbnailImagesURLs;
    NSMutableArray *_imagesURLs;
}

#pragma mark - VC init & lifecycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    FBLoginView *loginView = [[FBLoginView alloc] initWithReadPermissions:
     @[@"public_profile", @"user_photos"]];
    loginView.delegate = self;
    //[loginView setCenter:self.view.center];
    [self.view addSubview:loginView];
    
    _thumbnailImagesURLs = [[NSMutableArray alloc] init];
    _imagesURLs = [[NSMutableArray alloc] init];
    
    [_collectionView setDelegate:self];
    [_collectionView setDataSource:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - CollectionView Delegate methods

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"ImageCell";
    KTCollectionViewImageCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSURL *imageURL = [_thumbnailImagesURLs objectAtIndex:indexPath.row];
    [cell.imageView setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"placeholder"]];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_imagesURLs count];
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}


#pragma mark - FB SDK methods

-(void)getUserPhotos{
    _thumbnailImagesURLs = [[NSMutableArray alloc] init];
    _imagesURLs = [[NSMutableArray alloc] init];
    [FBRequestConnection startWithGraphPath:@"/me/photos/uploaded" parameters:nil HTTPMethod:@"GET"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error){
                              
                              NSArray *dataArray = [result valueForKey:@"data"];
                              [dataArray enumerateObjectsUsingBlock:^(FBGraphObject *imageObj, NSUInteger idx, BOOL *stop) {
                                  NSURL *thumbnailURL = [NSURL URLWithString:[imageObj valueForKey:@"picture"]];
                                  [_thumbnailImagesURLs addObject:thumbnailURL];
                                  
                                  NSURL *imageURL = [NSURL URLWithString:[imageObj valueForKey:@"source"]];
                                  [_imagesURLs addObject:imageURL];
                              }];
                              
                              [_collectionView reloadData];
    }];
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    [self getUserPhotos];
}

// Logged-in user
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    //[self getUserPhotos];
}

// Logged-out user
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {

}

// Handle possible errors that can occur during login
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures that happen outside of the app
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

@end
