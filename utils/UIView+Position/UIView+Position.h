//
//  UIView+position.h
//
//  Created by Tyler Neylon on 3/19/10.
//  Copyleft 2010 Bynomial.
//

#import <Foundation/Foundation.h>

@interface UIView (position)

@property (nonatomic) CGPoint frameOrigin;
@property (nonatomic) CGSize frameSize;

@property (nonatomic) CGFloat x;
@property (nonatomic) CGFloat y;

// Setting these modifies the origin but not the size.
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat bottom;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@end

@interface UIColor(Hex)

+ (UIColor *)colorWithHex:(UInt32)col;

@end
