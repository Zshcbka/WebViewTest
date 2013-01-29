//
//  WebViewViewController.m
//  WebViewTestProject
//
//  Created by Zshcbka on 1/29/13.
//  Copyright (c) 2013 Zshcbka. All rights reserved.
//

#import "WebViewViewController.h"

@interface WebViewViewController () <UIGestureRecognizerDelegate, UIScrollViewDelegate, UIWebViewDelegate>
@property (nonatomic, strong) IBOutletCollection (UIWebView) NSArray *webPage;
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@end

@implementation WebViewViewController
static int defaultHeight = 100;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.scrollView.delegate = self;
    [self setWebViews];
    //NSLog(@"scrollview size at start %f", self.scrollView.frame.size.height)

}

- (void) setWebViews
{
    for (UIWebView *view in self.webPage )
    {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:nil];
        tap.numberOfTapsRequired = 1;
        tap.delegate = self;
        [view addGestureRecognizer:tap];
        
        int index = [self.webPage indexOfObject:view];
        [view setFrame:CGRectMake(10, 10 * (index + 1) + defaultHeight*index, self.view.frame.size.width - 20, defaultHeight)];
        NSString *indexPath = [NSBundle pathForResource:@"index" ofType:@"html" inDirectory:@"/Users/zshcbka/Documents/Test/WebViewTestProject/WebViewTestProject"];
        [view loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:indexPath]]];
        [self.scrollView setContentSize:CGSizeMake(self.scrollView.contentSize.width, (defaultHeight* self.webPage.count))];
    
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    [self adjustWebViewHeight:gestureRecognizer.view];
    return YES;
}


-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //when user clicks on url in webview initiate safari
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }
    //when user clicks on e-mail link initiate mail
    else if ([[[request URL] scheme] isEqual:@"mailto"])
    {
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }
    return YES;
}

- (void) adjustWebViewHeight: (UIView *) view
{
    
    if (view.frame.size.height == defaultHeight) {
        CGRect frame = view.frame;
        frame.size = [view sizeThatFits:CGSizeZero];
        view.frame = frame;
        [self.scrollView setContentSize:CGSizeMake(self.scrollView.frame.size.width, view.frame.size.height)];
                                            
    } else if (view.frame.size.height > defaultHeight)
    {
        int deltaHeight = view.frame.size.height - defaultHeight;
        [view setFrame:CGRectMake(10, 10, self.view.frame.size.width - 20, defaultHeight)];
        self.scrollView.contentSize = CGSizeMake(self.scrollView.contentSize.width, self.scrollView.contentSize.height - deltaHeight);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
