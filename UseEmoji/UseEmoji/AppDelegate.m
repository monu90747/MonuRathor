//
//  AppDelegate.m
//  UseEmoji
//
//  Created by Monu Rathor on 7-19-13.
//  Copyright (c) 2013 Hunka Technologies Pvt. Ltd. All rights reserved.
//

#import "AppDelegate.h"
#import "ZWEmoji.h"

#define FONT_NAME @"Times New Roman"
@implementation AppDelegate

- (BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)sender{
    return YES;
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    NSMutableArray *emojis = [NSMutableArray array];
	NSDictionary *codes = [ZWEmoji codes];
    
    [codes enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		[emojis addObject:@{@"code" : key, @"emoji" : obj}];
	}];
	
	[emojis sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
		return [obj1[@"code"] compare:obj2[@"code"]];
	}];
    
    sliderVal=15;
    str= @"";
//    for(int i=0;i<[emojis count];i++){
//        NSDictionary *emogi = emojis[i];
//        str = [str stringByAppendingString:[ZWEmoji stringByReplacingCodesInString:[emogi valueForKey:@"emoji"]]];
//    }
//    [textView setFont:[NSFont fontWithName:@"Times New Roman" size:15]];
//    textView.string=str;
    
    
//#define UNICHAR_MAX (1 << (CHAR_BIT * sizeof(unichar) - 1))
//    NSFont *demoFont = [NSFont fontWithName:@"Apple Color Emoji" size:15];
//    NSCharacterSet *charSet = [demoFont coveredCharacterSet];
//    NSData *data = [charSet bitmapRepresentation];
//    uint8_t *ptr = [data bytes];
//    NSMutableArray *allCharsInSet = [NSMutableArray array];
//    // following from Apple's sample code
//    for (unichar i = 0; i < UNICHAR_MAX; i++) {
//        if (ptr[i >> 3] & (((unsigned int)1) << (i & 7))) {
//            [allCharsInSet addObject:[NSString stringWithCharacters:&i length:1]];
//        }
//    }
//    NSLog(@"%@",allCharsInSet);
//    for(int i=0;i<[allCharsInSet count];i++){
//        str = [str stringByAppendingString:[allCharsInSet objectAtIndex:i]];
//    }
    
    NSFontManager *manager = [[NSFontManager alloc]init];
    NSArray *fontName = [manager availableFonts];
    [fontNamePopUp addItemsWithTitles:fontName];
    fontNamePopUp.title = FONT_NAME;
    [self addCharacterInViewWithFontName:FONT_NAME];
    
}

- (void)addCharacterInViewWithFontName:(NSString *)fontnm{
    NSFont *demoFont = [NSFont fontWithName:fontnm size:15];
    NSCharacterSet *charset = [demoFont coveredCharacterSet];
    NSMutableArray *array = [NSMutableArray array];
    for (int plane = 0; plane <= 20; plane++) {
        if ([charset hasMemberInPlane:plane]) {
            UTF32Char c;
            for (c = plane << 16; c < (plane+1) << 16; c++) {
                if ([charset longCharacterIsMember:c]) {
                    UTF32Char c1 = OSSwapHostToLittleInt32(c); // To make it byte-order safe
                    //NSLog(@"%u",c1);
                    NSString *s = [[NSString alloc] initWithBytes:&c1 length:4 encoding:NSUTF32LittleEndianStringEncoding];
                    if(![s isEqualToString:@" "]){
                        [array addObject:s];
                    }
                }
            }
        }
    }
    
    NSLog(@"FontName:%@     Count:%lu",[fontNamePopUp title],[array count]);
    for(int i=0;i<[array count];i++){
        str = [str stringByAppendingString:[array objectAtIndex:i]];
    }
    
    [textView setFont:[NSFont fontWithName:fontnm size:sliderVal]];
    textView.string=str;
}

- (IBAction)selectPopUpOption:(id)sender{
    str= @"";
    NSString *font = [sender title];
    [self addCharacterInViewWithFontName:font];
}

- (IBAction)sliderDrag:(id)sender{
    int val = [sender floatValue];
    sizeTextField.stringValue=[NSString stringWithFormat:@"Size:%d",val];
    sliderVal=[sender floatValue];
    [textView setFont:[NSFont fontWithName:[fontNamePopUp title] size:sliderVal]];
    
}

- (IBAction)clickAddButton:(id)sender{
    str = [str stringByAppendingString:[ZWEmoji stringByReplacingCodesInString:textViewAddEmoji.string]];
    textView.string = str;
    //initilize create icon window controller
//    iconWindow = [[IconEditor alloc]init];
//    [NSApp beginSheet:iconWindow.window modalForWindow:[sender window] modalDelegate:self didEndSelector:@selector(sheetDidEnd:returnCode:contextInfo:) contextInfo:nil];
}

- (void)sheetDidEnd:(NSWindow *)sheet returnCode:(NSInteger)returnCode contextInfo:(void *)contextInfo{
    [sheet orderOut:self];
}

@end