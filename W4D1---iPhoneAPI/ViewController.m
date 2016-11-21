//
//  ViewController.m
//  W4D1---iPhoneAPI
//
//  Created by Dylan McCrindle on 2016-11-21.
//  Copyright © 2016 Dylan McCrindle. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *iPhoneImageView;
@property (strong, nonatomic) NSArray* iphonePics;
@property (strong, nonatomic) NSURL *url;
-(void)loadNewPic;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.iphonePics = @[@"http://i.imgur.com/zdwdenZ.png", @"http://i.imgur.com/bktnImE.png", @"http://imgur.com/y9MIaCS.png"];
	
	self.url = [NSURL URLWithString:self.iphonePics[arc4random_uniform(3)]]; // 1.1
	[self loadNewPic];
	
}

- (IBAction)button:(UIButton *)sender {
	self.url = [NSURL URLWithString:self.iphonePics[arc4random_uniform(3)]];
	[self loadNewPic];
}

-(void)loadNewPic{
	NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration]; // 1.2
	NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration]; // 1.3
	
	NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:self.url completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
		
		if (error) { // 2.1
					 // Handle the error
			NSLog(@"error: %@", error.localizedDescription);
			return;
		}
		
		NSData *data = [NSData dataWithContentsOfURL:location];
		UIImage *image = [UIImage imageWithData:data]; // 2.2
		
		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
			// This will run on the main queue
			
			self.iPhoneImageView.image = image; // 2.4
		}];
		
	}]; // 1.4
	
	[downloadTask resume]; // 1.5
}



@end


















