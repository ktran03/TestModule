//
//  KTFacebookPhotosViewController.h
//  TestModule
//
//  Created by khanh tran on 2014-05-31.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface KTFacebookPhotosViewController : UIViewController <FBLoginViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet FBLoginView *fbLoginView;
@property (weak, nonatomic) IBOutlet UILabel *helloLabel;

@end
