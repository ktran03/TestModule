//
//  KTDraggableStarViewController.m
//  TestModule
//
//  Created by khanh tran on 2014-05-31.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import "KTDraggableStarViewController.h"
#import "KTDraggableStar.h"

@interface KTDraggableStarViewController (){
    KTDraggableStar *_star;
}
@end

@implementation KTDraggableStarViewController

#pragma mark - VC init & lifecycle
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _star = nil;
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapGesture:)];
    [singleTap setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:singleTap];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

-(void)handleTapGesture:(UIGestureRecognizer *)sender{
    if (!_star) {
        CGPoint tapPoint = [sender locationInView:self.view];
        _star = [[KTDraggableStar alloc] initWithFrame:CGRectMake(0, 0, 50, 55)];
        [_star setCenter:tapPoint];
        [self.view addSubview:_star];
    }
}

@end
