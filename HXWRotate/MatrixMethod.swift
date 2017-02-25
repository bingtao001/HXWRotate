//
//  MatrixMethod.swift
//  HXWRotate
//
//  Created by huxingwang on 2017/2/25.
//  Copyright © 2017年 bingtao. All rights reserved.
//

import UIKit
import Accelerate

class MatrixMethod: NSObject {
    class func mixMultip(matrix: [Double], matrix2: [Double]) -> [Double] {
        let matrix1 = invert(matri :matrix)
        var result = [0.0, 0.0]
        vDSP_mmulD(matrix1, 1, matrix2, 1, &result, 1, 2, 1, 2);
        return result
    }
    
    class func multip(matrix: [Double], matrix2: [Double]) -> [Double] {
        let matrix1 = matrix
        var result = [0.0, 0.0]
        vDSP_mmulD(matrix1, 1, matrix2, 1, &result, 1, 2, 1, 2);
        return result
    }
    
    class func addMatrix(matrix: [Double], matrix2: [Double]) -> [Double] {
        var mmResult = [Double](repeating : 0.0, count : matrix.count)
        vDSP_vaddD(matrix, 1, matrix2, 1, &mmResult, 1, vDSP_Length(matrix.count))
        return mmResult
    }
    
    class func invert(matri : [Double]) -> [Double] {
        var inMatrix = matri
        var pivot : __CLPK_integer = 0
        var workspace = 0.0
        var error : __CLPK_integer = 0
        
        var N = __CLPK_integer(sqrt(Double(matri.count)))
        dgetrf_(&N, &N, &inMatrix, &N, &pivot, &error)
        
        if error != 0 {
            return inMatrix
        }
        
        dgetri_(&N, &inMatrix, &N, &pivot, &workspace, &N, &error)
        return inMatrix
    }
}
