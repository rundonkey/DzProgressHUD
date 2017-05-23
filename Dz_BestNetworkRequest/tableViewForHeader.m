//
//  tableViewForHeader.m
//  Dz_BestNetworkRequest
//
//  Created by 李志学 on 17/2/18.
//  Copyright © 2017年 张达. All rights reserved.
//

#import "tableViewForHeader.h"

@implementation tableViewForHeader

+(instancetype)ceartHeaderView
{
    return [[[NSBundle mainBundle]loadNibNamed:NSStringFromClass([tableViewForHeader class]) owner:self options:nil]lastObject];
}

- (IBAction)headerViewAction:(UIButton *)sender {
    NSLog(@"123");
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
