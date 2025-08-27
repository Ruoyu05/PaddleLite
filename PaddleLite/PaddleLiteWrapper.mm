#import "PaddleLiteWrapper.h"
#include "paddle_api.h"
#include "paddle_image_preprocess.h"
#include "paddle_place.h"

using namespace paddle::lite_api;

@interface PaddleLiteWrapper ()

@property(nonatomic) std::shared_ptr<PaddlePredictor> predictor;

@end

@implementation PaddleLiteWrapper

/// 初始化 Predictor
- (instancetype)initWithModelPath:(NSString *)modelPath {
    self = [super init];
    if (self) {
        MobileConfig config;
        config.set_model_from_file([modelPath UTF8String]);
        config.set_threads(2);
        config.set_power_mode(PowerModeLITE_POWER_HIGH);

        self.predictor = CreatePaddlePredictor<MobileConfig>(config);
    }
    return self;
}

/// 对 UIImage 输入进行推理
- (UIImage *)predict:(UIImage *)inputImage {
    if (!self.predictor) {
        NSLog(@"Predictor 未初始化");
        return inputImage;
    }

    // 1. 图像预处理，将 UIImage 转为 float 数据
    CVImageData cvImage;
    if (![self uiImageToCVImage:inputImage output:&cvImage]) {
        NSLog(@"图像转换失败");
        return inputImage;
    }

    // 2. 获取输入 Tensor
    auto inputTensor = self.predictor->GetInput(0);
    inputTensor->Resize({1, cvImage.height, cvImage.width, 3}); // NHWC
    float* input_data = inputTensor->mutable_data<float>();

    // 3. 填充数据（归一化到 [0,1]）
    size_t count = cvImage.height * cvImage.width * 3;
    for (size_t i = 0; i < count; ++i) {
        input_data[i] = cvImage.data[i] / 255.0f;
    }

    // 4. 执行预测
    self.predictor->Run();

    // 5. 获取输出 Tensor（这里只是示例，返回原图）
    // 你可以根据模型输出生成 UIImage 或数组
    return inputImage;
}

/// 将 UIImage 转为 Paddle Lite 可用的 float 数据
- (BOOL)uiImageToCVImage:(UIImage *)image output:(CVImageData *)cvImage {
    if (!image) return NO;

    CGSize size = image.size;
    NSUInteger width = size.width;
    NSUInteger
