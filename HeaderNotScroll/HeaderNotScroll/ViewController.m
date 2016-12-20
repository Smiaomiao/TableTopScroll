//
//  ViewController.m
//  HeaderNotScroll
//
//  Created by dufei on 16/12/19.
//  Copyright © 2016年 dufei. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *objectTableView;

@property (nonatomic, strong) UIImageView *topImgView;
@property (nonatomic, strong) UIButton *leftBtn;
@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UIView *topView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.view addSubview:self.objectTableView];
    
    [self startLoadTopView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellIdenti"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellIdenti"];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];

    return cell;
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (self.objectTableView.contentOffset.y > -(CGRectGetHeight(self.leftBtn.frame))) {
        [self suspendTopView];
    } else {
        [self startLoadTopView];
    }

}

- (void)suspendTopView{
    self.topView.frame = CGRectMake(0, -120, CGRectGetWidth(self.view.frame), 180);
    [self.topView removeFromSuperview];
    [self.view addSubview:self.topView];
}

- (void)startLoadTopView{
    self.topView.frame = CGRectMake(0, -180, CGRectGetWidth(self.view.frame), 180);
    [self.topView removeFromSuperview];
    self.objectTableView.contentInset = UIEdgeInsetsMake(180, 0, 0, 0);
    [self.objectTableView addSubview:self.topView];
}

- (UITableView *)objectTableView{
    if (!_objectTableView) {
        _objectTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        _objectTableView.delegate = self;
        _objectTableView.dataSource = self;
        _objectTableView.rowHeight = 100;
    }
    return _objectTableView;
}

- (UIView *)topView{
    if (!_topView) {
        _topView = [UIView new];
        _topView.backgroundColor = [UIColor whiteColor];
        _topView.userInteractionEnabled = YES;
        
        CGFloat width = CGRectGetWidth(self.view.frame);
        
        
        self.topImgView.frame = CGRectMake(0, 0, width, 120);
        
        self.leftBtn.frame = CGRectMake(0, 120, width/2, 60);
        self.rightBtn.frame = CGRectMake(width/2, 120, width/2, CGRectGetHeight(self.leftBtn.frame));
        
        
        [_topView addSubview:self.leftBtn];
        [_topView addSubview:self.rightBtn];
        
        [_topView addSubview:self.topImgView];
    }
    return _topView;
}

- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.backgroundColor = [UIColor whiteColor];
        [_rightBtn setTitle:@"智能分类" forState:UIControlStateNormal];
        _rightBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_rightBtn addTarget:self action:@selector(pressRight) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

- (UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setTitle:@"全部分类" forState:UIControlStateNormal];
        _leftBtn.backgroundColor = [UIColor whiteColor];
        _leftBtn.titleLabel.font = [UIFont systemFontOfSize:14];
        [_leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        
        [_leftBtn addTarget:self action:@selector(pressLeft) forControlEvents:UIControlEventTouchUpInside];

    }
    return _leftBtn;
}

- (UIImageView *)topImgView{
    if (!_topImgView) {
        CGFloat width = self.view.frame.size.width;
        _topImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width, 120)];
        _topImgView.image = [UIImage imageNamed:@"backPage"];
    }
    return _topImgView;
}

- (void)pressRight{
    NSLog(@"right");
}

- (void)pressLeft{
    NSLog(@"left");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
