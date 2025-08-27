#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/// Objective-C++ 桥接 Paddle Lite
/// Swift 调用 PaddleLiteWrapper 进行模型推理
@interface PaddleLiteWrapper : NSObject

/// 初始化 Predictor
/// @param modelPath 模型文件本地路径
- (instancetype)initWithModelPath:(NSString *)modelPath;

/// 对 UIImage 输入进行推理
/// @param inputImage 输入图片
/// @return 输出 UIImage（推理结果）
- (UIImage *)predict:(UIImage *)inputImage;

@end

NS_ASSUME_NONNULL_END
