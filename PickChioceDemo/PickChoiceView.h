//
//  PickChoiceView.h
//  PickChioceDemo
//
//  Created by liujie on 16/8/3.
// 自己封装的选择器，根据类型去选择你想要的，可以扩展
//

#import <UIKit/UIKit.h>

@protocol LJPickerDelegate <NSObject>


-(void)PickkerSelectorIndeixString:(NSString *)str;

@end

/**
 *  选择器数组类型的
 */
typedef NS_ENUM(NSInteger,ArrayType) {
    GenderArray,//性别的类型
    dateArray,//时间的数组
    heightArray//身高
    
};


@interface PickChoiceView : UIView

@property (nonatomic,assign) ArrayType arrayType;

@property (nonatomic,assign)NSArray *customArray;



@property (nonatomic,assign)id<LJPickerDelegate>delegate;


@end
