//
//  VisionService.swift
//  NiceTube
//

import CoreImage
import CoreML
import SwiftyUtilities

protocol SuperResolutionService {
    func upscale(image: CIImage) -> CGImage?
}

final class SuperResolutionBSRGAN: SuperResolutionService {
    static let shared = SuperResolutionBSRGAN()

    private let model: BSRGAN
    private lazy var context = CIContext()

    private init() {
        model = try! BSRGAN(configuration: .init())
    }

    func upscale(image: CIImage) -> CGImage? {
        // Resize the input image to the model's input size
        let resized = image.resized(size: model.inputSize)

        guard let cgImage = context.createCGImage(resized, from: resized.extent) else {
            return nil
        }

        // Create the model's input
        guard let input = try? BSRGANInput(xWith: cgImage) else {
            return nil
        }

        // Run the model
        guard let output = try? model.prediction(input: input) else {
            return nil
        }

        // Get the model's output image
        let upscaledImage = CIImage(cvPixelBuffer: output.activation_out)

        // Resize the output image to the desired output size
        let finalImage = upscaledImage.resized(size: model.outputSize)

        // Return final image
        guard let cgImage = context.createCGImage(finalImage, from: finalImage.extent) else {
            return nil
        }
        return cgImage
    }
}

extension BSRGAN {
    var inputSize: CGSize {
        CGSize(width: 512, height: 512)
    }

    var outputSize: CGSize {
        CGSize(width: 2048, height: 2048)
    }
}
