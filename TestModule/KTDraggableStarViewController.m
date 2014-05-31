//
//  KTDraggableStarViewController.m
//  TestModule
//
//  Created by khanh tran on 2014-05-31.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import "KTDraggableStarViewController.h"
#import "KTDraggableStar.h"

@interface KTDraggableStarViewController ()

@end

@implementation KTDraggableStarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [singleTap setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:singleTap];
}

-(void) handleTapGesture:(UIGestureRecognizer *) sender {
    CGPoint tapPoint = [sender locationInView:self.view];
    KTDraggableStar *star = [[KTDraggableStar alloc] initWithFrame:CGRectMake(0, 0, 50, 55)];
    [star setCenter:tapPoint];
    [self.view addSubview:star];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

@end
