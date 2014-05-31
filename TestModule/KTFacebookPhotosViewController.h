//
//  KTFacebookPhotosViewController.h
//  TestModule
//
//  Created by khanh tran on 2014-05-31.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface KTFacebookPhotosViewController : UIViewController <FBLoginViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *loginButtonView;

@end
