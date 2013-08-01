//
//  IconEditor.h
//  UseEmoji
//
//  Created by Monu Rathor on 7-22-13.
//  Copyright (c) 2013 Hunka Technologies Pvt. Ltd. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface IconEditor : NSWindowController{
    IBOutlet NSImageView *imageViewIcon,*imageViewPreview;
    IBOutlet NSSlider *sliderHorizontal,*sliderVertical;
    CGFloat width,height;
    NSString *imagePath;
    NSString *imageName;
}
- (IBAction)clickCancelButton:(id)sender;
- (IBAction)clickSelectImageButton:(id)sender;
- (IBAction)clickCreateEmojiButton:(id)sender;
- (IBAction)sliderUpdate:(id)sender;
@end
