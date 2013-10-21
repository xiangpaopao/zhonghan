//
// REPagedScrollView.m
// REPagedScrollView
//
// Copyright (c) 2013 Roman Efimov (https://github.com/romaonthego)
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

#import "REPagedScrollView.h"

@interface REPagedScrollView()

@property (strong, readonly, nonatomic) NSMutableArray *pageViews;

@end

@implementation REPagedScrollView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
    _scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    
    
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height-28, frame.size.width, 28)];
    _titleLabel.backgroundColor = [UIColor colorWithRed:245.0/255.0 green:244.0/255.0 blue:235.0/255.0 alpha:0.8];
    _titleLabel.textColor = [UIColor blackColor];
    _titleLabel.font = [UIFont systemFontOfSize:13.0];
    [self addSubview:_titleLabel];
    
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(240, frame.size.height - 28, 80, 28)];
    _pageControl.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    [_pageControl addTarget:self action:@selector(pageControlPageDidChange:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:_pageControl];
    
    _pageViews = [[NSMutableArray alloc] init];
    
      _titles = [NSMutableArray arrayWithCapacity:5];
    
    //
  }
  return self;
}


- (void)addPage:(UIView *)page withTitle:(NSString *)title
{
  UIView *pageContainerView = [[UIView alloc] initWithFrame:CGRectMake(self.numberOfPages * _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height)];
  [pageContainerView addSubview:page];
  [_scrollView addSubview:pageContainerView];
  [_pageViews addObject:pageContainerView];

    [_titles addObject:[NSString stringWithFormat:@" %@",title]];
    
  _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * self.numberOfPages, _scrollView.frame.size.height);
  _pageControl.numberOfPages = self.numberOfPages;
}

- (void)scrollToPageWithIndex:(NSUInteger)pageIndex animated:(BOOL)animated
{
  CGRect frame = _scrollView.frame;
  frame.origin.x = frame.size.width * pageIndex;
  frame.origin.y = 0;
  [_scrollView scrollRectToVisible:frame animated:animated];
}

- (NSArray *)pages
{
  return _pageViews;
}

- (NSUInteger)numberOfPages
{
  return _pageViews.count;
}

#pragma mark -
#pragma mark Events

- (void)pageControlPageDidChange:(UIPageControl *)pageControl
{
  [self scrollToPageWithIndex:pageControl.currentPage animated:YES];
}

#pragma mark -
#pragma mark UIScrollViewDelegate functions

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  CGFloat pageWidth = scrollView.frame.size.width;
  int page = floor((scrollView.contentOffset.x - pageWidth / 2.0) / pageWidth) + 1;
	_pageControl.currentPage = page;
    [_titleLabel setText:[_titles objectAtIndex:page]];
  if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewDidScroll:)])
    [_delegate scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
  if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewDidZoom:)])
    [_delegate scrollViewDidZoom:scrollView];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
  if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewWillBeginDragging:)])
    [_delegate scrollViewWillBeginDragging:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
  if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewDidEndDragging:willDecelerate:)])
    [_delegate scrollViewDidEndDragging:scrollView willDecelerate:decelerate];
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
  if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewWillBeginDecelerating:)])
    [_delegate scrollViewWillBeginDecelerating:scrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
  if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewDidEndDecelerating:)])
    [_delegate scrollViewDidEndDecelerating:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
  if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewDidEndScrollingAnimation:)])
    [_delegate scrollViewDidEndScrollingAnimation:scrollView];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
  if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(viewForZoomingInScrollView:)])
    return [_delegate viewForZoomingInScrollView:scrollView];
  
  return nil;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
  if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewWillBeginZooming:withView:)])
    [_delegate scrollViewWillBeginZooming:scrollView withView:view];
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale;
{
  if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewDidEndZooming:withView:atScale:)])
    [_delegate scrollViewDidEndZooming:scrollView withView:view atScale:scale];
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
  if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewShouldScrollToTop:)])
    return [_delegate scrollViewShouldScrollToTop:scrollView];
  
  return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
  if ([_delegate conformsToProtocol:@protocol(UIScrollViewDelegate)] && [_delegate respondsToSelector:@selector(scrollViewDidScrollToTop:)])
    [_delegate scrollViewDidScrollToTop:scrollView];
}

@end
