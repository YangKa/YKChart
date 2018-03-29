//
//  YKECharts.m
//  StudyDemo
//
//  Created by qiager on 2018/3/28.
//  Copyright © 2018年 yangka. All rights reserved.
//

#import "YKEChartsView.h"
#import <WebKit/WebKit.h>

@interface YKEChartsView ()<WKNavigationDelegate>

@property (nonatomic, copy) NSString *optionJson;

@property (nonatomic, strong) WKWebView *webView;

@property (nonatomic, weak) id<YKEChartsDelegate> delegate;

@end

@implementation YKEChartsView


- (instancetype)initWithFrame:(CGRect)frame delegate:(id<YKEChartsDelegate>)delegate{
    self = [super initWithFrame:frame];
    if (self) {
        _delegate = delegate;
        self.backgroundColor = [UIColor whiteColor];
        
        _webView = [[WKWebView alloc] initWithFrame:self.bounds];
        _webView.navigationDelegate = self;
        _webView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self addSubview:_webView];
        
    }
    return self;
}

- (NSURLRequest *)getJavaScriptFileURLRequest {
    NSString *webPath = [[NSBundle mainBundle] pathForResource:@"YKCharts" ofType:@"html"];
    NSURL *webURL = [NSURL fileURLWithPath:webPath];
    NSURLRequest *URLRequest = [[NSURLRequest alloc] initWithURL:webURL];
    return URLRequest;
}

- (NSString *)configJavaScriptWithOptions:(NSString*)optionsJson{
    return [NSString stringWithFormat:@"drawChart('%@')",optionsJson];;
}

- (void)drawChartWithOptions:(NSDictionary*)optionDic{
    NSString *options = [self convertDictionaryIntoJson:optionDic];
    _optionJson = options;
    [_webView loadRequest:[self getJavaScriptFileURLRequest]];
}

- (void)refreshChartWithOptions:(NSDictionary *)optionDic{
    NSString *options = [self convertDictionaryIntoJson:optionDic];
    _optionJson = options;
    [self draw];
}

#pragma  mark - draw
- (void)draw{
    NSString *javascript = [self configJavaScriptWithOptions:_optionJson];
    __weak typeof(self) weakSelf = self;
    
    [_webView evaluateJavaScript:javascript completionHandler:^(id item, NSError * _Nullable error) {
        if (error) {
            NSLog(@"item=%@", item);
            NSLog(@"☠️☠️💀☠️☠️WARNING!!!!! THERE ARE SOME ERROR INFOMATION_______%@",error);
        }else{
            [weakSelf drawSuccess];
        }
    }];
}

- (void)drawSuccess{
    if ([self.delegate respondsToSelector:@selector(didDrawFinishedForChartView:)]) {
        [self.delegate didDrawFinishedForChartView:self];
    }
}

#pragma mark -WKNavigationDelegate
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self draw];
}

#pragma mark -convert
- (NSString*)convertDictionaryIntoJson:(NSDictionary *)dictionary {
    
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:&parseError];
    if (parseError) {
        NSLog(@"解析option字典出错 error=%@", parseError);
    }else{
        NSString *string =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSString *str =[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
        
        return str;
    }

    return nil;
}

@end
