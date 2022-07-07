//
//  ImageTaskHandlerGettable.swift
//  MemExplorer
//
//  Created by Александр Ермаков on 06.07.2022.
//

import Foundation
import UIKit

protocol ImageTaskHandlerGettable {
    
    func image(for url: URL, resumed: Bool, handler: @escaping ImageCompletion, taskHandler: @escaping TaskCompletion)
}
