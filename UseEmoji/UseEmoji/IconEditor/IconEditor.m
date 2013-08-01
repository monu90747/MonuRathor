//
//  IconEditor.m
//  UseEmoji
//
//  Created by Monu Rathor on 7-22-13.
//  Copyright (c) 2013 Hunka Technologies Pvt. Ltd. All rights reserved.
//

#import "IconEditor.h"

@interface IconEditor ()

@end

@implementation IconEditor

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        
    }
    
    return self;
}

- (id)init{
    return [super initWithWindowNibName:@"IconEditor" owner:self];
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    
    //NSGlyph glyph = [demoFont glyphWithName:@"A"];
    
    //NSLog(@"coveredCharacterSet:%@",);
    //NSBitmapImageRep *bitmapref = [[NSBitmapImageRep alloc] initWithData:[charSet bitmapRepresentation]];
    //NSData *imgData = [charSet bitmapRepresentation];//[bitmapref representationUsingType:NSPNGFileType properties:nil];
    //NSImage *image = [[NSImage alloc] initWithData:imgData];
    //imageViewPreview.image = image;
    
    //NSLog(@"charcter:%@",[NSCharacterSet characterSetWithBitmapRepresentation:[charSet bitmapRepresentation]]);
    //[imgData writeToFile:@"/Users/macmini2/Desktop/test.rtf" atomically:YES];
    
    
}


#pragma mark - IBAction method

- (IBAction)clickSelectImageButton:(id)sender{
    NSOpenPanel *openPanel = [NSOpenPanel openPanel];
	
    [openPanel setAllowsMultipleSelection:YES];
    [openPanel setAllowedFileTypes:[NSArray arrayWithObjects:@"textClipping",@"text",@"RTF",@"rtfd",@"png",@"PNG",@"jpg",@"JPG",@"jpeg",@"JPEG",nil]];
	
	[openPanel beginSheetModalForWindow:[self window] completionHandler:^(NSInteger result) {
		if (NSFileHandlingPanelOKButton == result)
		{
            imagePath = openPanel.filename;
            NSImage *img = [[NSImage alloc]initWithContentsOfFile:imagePath];
            imageViewIcon.image = img;
            imageViewPreview.image=img;
            
            width = img.size.width/3;
            height = img.size.height/4;
            
            sliderHorizontal.minValue=0;
            sliderHorizontal.maxValue=img.size.width-width;
            sliderHorizontal.floatValue=sliderHorizontal.maxValue/2;
            sliderVertical.minValue=0;
            sliderVertical.maxValue=img.size.height-height;
            sliderVertical.floatValue=sliderVertical.maxValue/2;
            if(img.size.width<=60){
                [sliderHorizontal setHidden:YES];
            }
            else{
                [sliderHorizontal setHidden:NO];
                [self sliderUpdate:nil];
            }
            if(img.size.height<=60){
                [sliderVertical setHidden:YES];
            }
            else{
                [sliderVertical setHidden:NO];
                [self sliderUpdate:nil];
            }
            
            
            NSLog(@"-------------------\nWidth:%f\nHeight:%f\n----------------",img.size.width,img.size.height);
		}
	}];
}

- (void)clearImage{
    imageViewIcon.image=nil;
    imageViewPreview.image=nil;
    [sliderVertical setHidden:YES];
    [sliderHorizontal setHidden:YES];
}

- (IBAction)clickCreateEmojiButton:(id)sender{
    //NSData *imageData = [imageViewIcon.image TIFFRepresentation];
    NSData *imageData = [NSData dataWithContentsOfFile:imagePath];
    NSArray *pathArray = [imagePath componentsSeparatedByString:@"/"];
    imageName = [[[pathArray lastObject] componentsSeparatedByString:@"."] objectAtIndex:0];
    NSLog(@"Image Path:%@\nImage Name:%@",imagePath,imageName);
    imagePath=@"";
    for(int i=0;i<[pathArray count]-1;i++){
        imagePath = [imagePath stringByAppendingFormat:@"/%@",[pathArray objectAtIndex:i]];
    }
    imagePath = [imagePath stringByAppendingFormat:@"/copy_%@.textClipping",imageName];
    //NSBitmapImageRep *rep = [NSBitmapImageRep imageRepWithData:imageData];
    //NSData *dataToWrite = [rep representationUsingType:NSPNGFileType properties:nil];
    [imageData writeToFile:imagePath atomically:NO];
    NSAlert *alert = [[NSAlert alloc] init];
    [alert setMessageText:@"Icon successfully saved."];
    [alert runModal];
    [self clearImage];
}

- (IBAction)sliderUpdate:(id)sender{
    
    NSImage *source = imageViewPreview.image;
    NSImage *target = [[NSImage alloc]initWithSize:NSMakeSize(width,height)];
	
	[target lockFocus];
	[source drawInRect:NSMakeRect(0,0,width,height)
              fromRect:NSMakeRect(sliderHorizontal.floatValue,sliderVertical.floatValue,width,height)
             operation:NSCompositeCopy
              fraction:1.0];
	[target unlockFocus];
    imageViewIcon.image = target;
}


- (IBAction)clickCancelButton:(id)sender{
    [NSApp endSheet:self.window];
}


@end
