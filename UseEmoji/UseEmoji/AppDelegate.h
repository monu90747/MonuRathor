//
//  AppDelegate.h
//  UseEmoji
//
//  Created by Monu Rathor on 7-19-13.
//  Copyright (c) 2013 Hunka Technologies Pvt. Ltd. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "IconEditor.h"

@interface AppDelegate : NSObject <NSApplicationDelegate,NSTextViewDelegate>
{
    IBOutlet NSTextView *textView,*textViewAddEmoji;
    //IBOutlet NSButton *rectButton;
    //IBOutlet IconEditor *iconWindow;
    IBOutlet NSPopUpButton *fontNamePopUp;
    IBOutlet NSTextField *sizeTextField;
    NSMutableArray *emogiesCode;
    NSString *str;
    CGFloat sliderVal;
    
}
@property (assign) IBOutlet NSWindow *window;
- (IBAction)sliderDrag:(id)sender;
- (IBAction)clickAddButton:(id)sender;
- (IBAction)selectPopUpOption:(id)sender;
@end
