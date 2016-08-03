//
//  PickChoiceView.m
//  PickChioceDemo
//
//  Created by liujie on 16/8/3.
//  Copyright © 2016年 liujie. All rights reserved.
//
//屏幕宽和高
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
//RGB
#define RGBA(r, g, b, a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]
// 缩放比
#define kScale ([UIScreen mainScreen].bounds.size.width) / 375
#define hScale ([UIScreen mainScreen].bounds.size.height) / 667
//字体大小
#define kfont 15

#import "PickChoiceView.h"
#import "Masonry.h"

@interface PickChoiceView ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property (nonatomic,strong)UIView *bgV;


@property (nonatomic,strong)UIButton *cancelBtn;

@property (nonatomic,strong)UIButton *conpleteBtn;

@property (nonatomic,strong)UILabel *selectLb;
@property (nonatomic,strong)UIPickerView *pickerV;

@property (nonatomic,strong)NSMutableArray *array;

@end
@implementation PickChoiceView
//初始化
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatView];
    }
    return self;

}
-(void)creatView{
    self.array = [NSMutableArray array];
    self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
    self.bgV = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, 260*hScale)];
    self.bgV.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.bgV];
    self.backgroundColor = RGBA(51, 51, 51, 0.8);
    [self showAnimation];
    //取消
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.bgV addSubview:self.cancelBtn];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(44);
    }];
    
    self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:kfont];
    [self.cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [self.cancelBtn addTarget:self action:@selector(cancelBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn setTitleColor:RGBA(0, 122, 255, 1) forState:UIControlStateNormal];
    //完成
    self.conpleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.bgV addSubview:self.conpleteBtn];
    [self.conpleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(0);
        make.right.mas_equalTo(-15);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(44);
        
    }];
    
    self.conpleteBtn.titleLabel.font = [UIFont systemFontOfSize:kfont];
    [self.conpleteBtn setTitle:@"确定" forState:UIControlStateNormal];
    [self.conpleteBtn addTarget:self action:@selector(completeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.conpleteBtn setTitleColor:RGBA(0, 122, 255, 1) forState:UIControlStateNormal];
    //选择
    self.selectLb = [UILabel new];
    [self.bgV addSubview:self.selectLb];
    [self.selectLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bgV.mas_centerX).offset(0);
        make.centerY.mas_equalTo(self.conpleteBtn.mas_centerY).offset(0);
        
    }];
    self.selectLb.font = [UIFont systemFontOfSize:kfont];
    self.selectLb.textAlignment = NSTextAlignmentCenter;
    
    //线
    UIView *line = [UIView new];
    [self.bgV addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(self.cancelBtn.mas_bottom).offset(0);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kScreenWidth);
        make.height.mas_equalTo(0.5);
        
    }];
    line.backgroundColor = RGBA(224, 224, 224, 1);
    
    
    //选择器
    self.pickerV = [UIPickerView new];
    [self.bgV addSubview:self.pickerV];
    [self.pickerV mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.mas_equalTo(line.mas_bottom).offset(0);
        make.bottom.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        
    }];
    self.pickerV.delegate = self;
    self.pickerV.dataSource = self;

}

-(void)setCustomArray:(NSArray *)customArray{
    if (customArray) {
        _customArray = customArray;
        [self.array addObject:customArray];
    }
}
-(void)setArrayType:(ArrayType)arrayType{


        _arrayType = arrayType;
        switch (_arrayType) {
            case GenderArray:
            {
                self.selectLb.text = @"性别选择";
                [self.array addObject:@[@"男",@"女"]];
            }
                break;
            case dateArray:
            {
                self.selectLb.text = @"选择生日";
                [self creatDate];
            }
                break;
            case heightArray:
            {
                self.selectLb.text = @"身高选择";
                [self creatHeight];
            }
                break;
                
            default:
                break;
        }
    
}

-(void)creatDate{
    NSMutableArray *yearArray = [[NSMutableArray alloc] init];
    for (int i = 1970; i<=2050; i++) {
        [yearArray addObject:[NSString stringWithFormat:@"%d年",i]];
    }
    [self.array addObject:yearArray];
    NSMutableArray *monthArray = [[NSMutableArray alloc] init];
    for (int i = 1; i<13; i++) {
        [monthArray addObject:[NSString stringWithFormat:@"%d月",i]];
    }
    [self.array addObject:monthArray];
    NSMutableArray *daysArray = [[NSMutableArray alloc] init];
    for (int i = 1; i <32; i++) {
        [daysArray addObject:[NSString stringWithFormat:@"%d日",i]];
    }
    [self.array addObject:daysArray];
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *currentYear = [NSString stringWithFormat:@"%@年",[formatter stringFromDate:date]];
    [self.pickerV selectRow:[yearArray indexOfObject:currentYear]+81*50 inComponent:0 animated:YES];
    
    [formatter setDateFormat:@"MM"];
    NSString *currentMonth = [NSString stringWithFormat:@"%ld月",(long)[[formatter stringFromDate:date]integerValue]];
    [self.pickerV selectRow:[monthArray indexOfObject:currentMonth]+12*50 inComponent:1 animated:YES];
    
    [formatter setDateFormat:@"d"];
    NSString *currentDay = [NSString stringWithFormat:@"%@日",[formatter stringFromDate:date]];
    [self.pickerV selectRow:[daysArray indexOfObject:currentDay]+31*50 inComponent:2 animated:YES];
}

-(void)creatHeight{

    NSMutableArray *heightArray = [[NSMutableArray alloc] init];
    for (int i = 30; i < 201; i++) {
        [heightArray addObject:[NSString stringWithFormat:@"%d厘米",i]];
    }
    [self.array addObject:heightArray];

}

#pragma mark-----UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return self.array.count;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    NSArray * arr = (NSArray *)[self.array objectAtIndex:component];
    if (self.arrayType == dateArray) {
        
        return arr.count*100;
        
    }else{
        
        return arr.count;
    }
    
}
-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel *label = [[UILabel alloc] init];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = [self pickerView:pickerView titleForRow:row forComponent:component];
    return label;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    NSArray *arr = (NSArray *)[self.array objectAtIndex:component];
    return [arr objectAtIndex:row % arr.count];
    
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    if (self.arrayType == dateArray) {
        
        return 60;
        
    }else{
        
        return 110;
    }
    
}

#pragma mark-----点击方法

- (void)cancelBtnClick{
    
    [self hideAnimation];
    
}
//隐藏动画
- (void)hideAnimation{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect frame = self.bgV.frame;
        frame.origin.y = kScreenHeight;
        self.bgV.frame = frame;
        
    } completion:^(BOOL finished) {
        
        [self.bgV removeFromSuperview];
        [self removeFromSuperview];
        
    }];
    
}
//显示动画
- (void)showAnimation{
    
    [UIView animateWithDuration:0.5 animations:^{
        
        CGRect frame = self.bgV.frame;
        frame.origin.y = kScreenHeight-260*hScale;
        self.bgV.frame = frame;
    }];
    
}
- (void)completeBtnClick{
    NSString *fullstr = [NSString string];
    for (int i = 0; i < self.array.count; i ++) {
        NSArray *arr = [self.array objectAtIndex:i];
        if (self.arrayType == dateArray) {
            NSString *str = [arr objectAtIndex:[self.pickerV selectedRowInComponent:i]% arr.count];
            fullstr = [fullstr stringByAppendingString:str];
        }else{
            NSString *str = [arr objectAtIndex:[self.pickerV selectedRowInComponent:i]];
            fullstr = [fullstr stringByAppendingString:str];
        
        }
    }
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(PickkerSelectorIndeixString:)]) {
        [self.delegate PickkerSelectorIndeixString:fullstr];
    }

     [self hideAnimation];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    [self hideAnimation];
    
}
@end
