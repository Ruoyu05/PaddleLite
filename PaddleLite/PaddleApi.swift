import UIKit

/// Swift 封装 Paddle Lite Predictor
public class PaddleApi {

    /// 桥接层实例
    private let wrapper: PaddleLiteWrapper

    /// 初始化 Predictor
    /// - Parameter modelPath: 模型文件本地路径
    public init(modelPath: String) {
        self.wrapper = PaddleLiteWrapper(modelPath: modelPath)
    }

    /// 对 UIImage 输入进行推理
    /// - Parameter image: 输入图片
    /// - Returns: 推理结果 UIImage
    public func predict(image: UIImage) -> UIImage {
        return wrapper.predict(image)
    }
}
