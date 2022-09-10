//
//  ETypeExtensions.swift
//  TourPlannit
//
//  Created by Svetoslav Angelov on 10/09/2022.
//

import Foundation

extension CGSize: Comparable {
    public static func < (lhs: CGSize, rhs: CGSize) -> Bool {
        return lhs.height < rhs.height
    }
    
    public static func > (lhs: CGSize, rhs: CGSize) -> Bool {
        return lhs.height > rhs.height
    }
    
    public static func == (lhs: CGSize, rhs: CGSize) -> Bool {
        return lhs.width == rhs.width && lhs.height == rhs.height
    }
    
    public static func != (lhs: CGSize, rhs: CGSize) -> Bool {
        return !(lhs == rhs)
    }
    
    public static  func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
}

func abs(_ a: CGSize) -> CGSize {
    return CGSize(width: abs(a.width), height: abs(a.height))
}
