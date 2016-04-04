//
//  DDWebViewController.m
//  bs
//
//  Created by dt on 16/4/2.
//  Copyright © 2016年 dt. All rights reserved.
//

#import "DDWebViewController.h"
#import "NJKWebViewProgress.h"
@interface DDWebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackItem;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardItem;


@property (nonatomic, strong) NJKWebViewProgress *progress;
@end

@implementation DDWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.progress = [[NJKWebViewProgress  alloc] init];
    self.webView.delegate = self.progress;
    
    __weak typeof(self) weakSelf = self;
    
    self.progress.progressBlock  = ^(float progress) {
    
        weakSelf.progressView.progress = progress;
        
        weakSelf.progressView.hidden = (progress == 1.0);
    
    
    };
    
    self.progress.webViewProxyDelegate = self;
    
    [self.webView loadRequest:[NSURLRequest  requestWithURL:[NSURL  URLWithString:self.url]]];
    
    
    
}


- (IBAction)refresh:(id)sender {
    
    [self.webView  reload];
}


- (IBAction)goBack:(id)sender {
    
    [self.webView  goForward];
}

- (IBAction)goForward:(id)sender {
    [self.webView  goForward];
    
}



- (void)webViewDidFinishLoad:(UIWebView *)webView{

    self.goBackItem.enabled = webView.canGoBack;
    
    self.goForwardItem.enabled = webView.canGoForward;




}









@end
