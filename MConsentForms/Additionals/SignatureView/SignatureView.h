//
//  SignatureView.h
//  SignatureView
//
//  Created by Michal Konturek on 05/05/2014.
//  Copyright (c) 2014 Michal Konturek. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SignatureView;

@protocol SignatureViewDelegate <NSObject>

-(void)drawingCompleted:(UIImage *)image signView:(SignatureView *)signatureView;

@end

@interface SignatureView : UIImageView

@property (nonatomic, strong) id<SignatureViewDelegate> delegate;
@property (nonatomic, strong) UIColor *foregroundLineColor;
@property (nonatomic, strong) UIColor *backgroundLineColor;

@property (nonatomic, strong) UIImage *previousImage;
@property (nonatomic, strong) UIImage *imageObj;

@property (nonatomic, assign) CGFloat foregroundLineWidth;
@property (nonatomic, assign) CGFloat backgroundLineWidth;

@property (nonatomic, strong) UILongPressGestureRecognizer *recognizer;

- (void)setLineColor:(UIColor *)color;
- (void)setLineWidth:(CGFloat)width;

- (void)clear;
- (void)clearWithColor:(UIColor *)color;

- (UIImage *)signatureImage;
- (NSData *)signatureData;

- (BOOL)isSigned;

@end
