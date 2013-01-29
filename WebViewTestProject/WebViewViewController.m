//
//  WebViewViewController.m
//  WebViewTestProject
//
//  Created by Zshcbka on 1/29/13.
//  Copyright (c) 2013 Zshcbka. All rights reserved.
//

#import "WebViewViewController.h"

@interface WebViewViewController ()
@property (nonatomic, strong) IBOutlet UIWebView *webPage;

@end

@implementation WebViewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *indexPath = [NSBundle pathForResource:@"index" ofType:@"html" inDirectory:nil];
    [self.webPage loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:indexPath]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
