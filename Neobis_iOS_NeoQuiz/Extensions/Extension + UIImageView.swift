//
//  Extension + UIImageView.swift
//  Neobis_iOS_NeoQuiz
//
//  Created by Alisher on 14.01.2024.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(from urlString: String, completion: ((UIImage?) -> Void)? = nil) {
        guard let url = URL(string: urlString) else {
            completion?(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion?(nil)
                return
            }

            if let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
                completion?(image)
            } else {
                completion?(nil)
            }
        }.resume()
    }
}
