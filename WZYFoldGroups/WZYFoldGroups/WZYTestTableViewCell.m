//
//  WZYTestTableViewCell.m
//  WZYFoldGroups
//
//  Created by 奔跑宝BPB on 2017/1/19.
//  Copyright © 2017年 wzy. All rights reserved.
//

#import "WZYTestTableViewCell.h"

@interface WZYTestTableViewCell ()

/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
/** 名称 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
/** 在线状态 */
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;
/** 个性签名 */
@property (weak, nonatomic) IBOutlet UILabel *supLabel;

@end

@implementation WZYTestTableViewCell

- (void)cellWithIconStr:(NSString *)iconStr nameStr:(NSString *)nameStr statusStr:(NSString *)statusStr supStr:(NSString *)supStr {
    
    _iconImageView.image = [UIImage imageNamed:iconStr];
    _nameLabel.text = nameStr;
    _statusLabel.text = statusStr;
    _supLabel.text = supStr;
}

@end
