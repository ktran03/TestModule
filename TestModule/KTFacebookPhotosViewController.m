//
//  KTFacebookPhotosViewController.m
//  TestModule
//
//  Created by khanh tran on 2014-05-31.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import "KTFacebookPhotosViewController.h"
#import "KTCollectionViewImageCell.h"

//Setting an upper limit on displayable photos. Users may have thousands (or 10's of thousands!), and in that case, may be better to use folders or some sort of hierachy.
#define MAX_DISPLAYABLE_IMAGES 100

@interface KTFacebookPhotosViewController ()

@end

@implementation KTFacebookPhotosViewController{
    NSMutableArray *_thumbnailImagesURLs;
}

#pragma mark - VC init & lifecycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _fbLoginView.readPermissions = @[@"public_profile", @"user_photos"];
        _thumbnailImagesURLs = [[NSMutableArray alloc] init];
        [_collectionView setDelegate:self];
        [_collectionView setDataSource:self];
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma mark - CollectionView Delegate methods
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"ImageCell";
    KTCollectionViewImageCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    NSURL *imageURL = [_thumbnailImagesURLs objectAtIndex:indexPath.row];
    [cell configureCellWithImageURL:imageURL];
    return cell;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [_thumbnailImagesURLs count];
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    //unused
}

#pragma mark - FB SDK methods
-(void)getUserPhotos{
    _thumbnailImagesURLs = [[NSMutableArray alloc] init];
    [FBRequestConnection startWithGraphPath:@"/me/photos/uploaded" parameters:nil HTTPMethod:@"GET"
                          completionHandler:^(FBRequestConnection *connection, id result, NSError *error){
                              
                              NSArray *dataArray = [result valueForKey:@"data"];
                              [dataArray enumerateObjectsUsingBlock:^(FBGraphObject *imageObj, NSUInteger idx, BOOL *stop) {
                                  if ([_thumbnailImagesURLs count] >= MAX_DISPLAYABLE_IMAGES) {
                                      *stop = YES;
                                  }
                                  NSURL *thumbnailURL = [NSURL URLWithString:[imageObj valueForKey:@"picture"]];
                                  [_thumbnailImagesURLs addObject:thumbnailURL];

                              }];
                              
                              [_collectionView reloadData];
    }];
}

- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    NSString *helloString = [NSString stringWithFormat:@"Hi %@!", [user objectForKey:@"first_name"]];
    [_helloLabel setText:helloString];
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    [self getUserPhotos];
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    _thumbnailImagesURLs = nil;
    [_helloLabel setText:@"Login to see your pictures"];
    [_collectionView reloadData];
}

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
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
