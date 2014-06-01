//
//  KTCollectionViewImageCell.m
//  TestModule
//
//  Created by khanh tran on 2014-05-31.
//  Copyright (c) 2014 ktran03. All rights reserved.
//

#import "KTCollectionViewImageCell.h"
#import "UIImageView+WebCache.h"

@implementation KTCollectionViewImageCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib {
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(2.5, 2.5);
    self.layer.shadowOpacity = 0.3;
    self.layer.shadowRadius = 5.0;
    self.layer.masksToBounds = NO;
    [super awakeFromNib];
}

-(void)configureCellWithImageURL:(NSURL*)url{
    [_imageView setImageWithURL:url placeholderImage:[UIImage imageNamed:@"placeholder"]];
}

@end
