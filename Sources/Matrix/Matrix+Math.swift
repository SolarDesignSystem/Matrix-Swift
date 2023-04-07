//
//  Matrix+Math.swift
//  Matrix
//
//  Created by Solar Design System on 4/5/23.
//
//  The MIT License (MIT)
//
//  Copyright (c) 2023 Solar Design System
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import RealModule

infix operator •: MultiplicationPrecedence

extension Matrix {
    
    /// The transpose of the matrix.
    public var transpose: Matrix<Element> {
        var outputMatrix = self
        let oldRowCount = self.rowCount
        outputMatrix.rowCount = self.columnCount
        outputMatrix.columnCount = oldRowCount
        for index in self.indices {
            outputMatrix[index.transpose] = self[index]
        }
        return outputMatrix
    }
    
}

extension Matrix where Element: AdditiveArithmetic {
    
    /// Adds two matrices of the same size.
    /// - Parameters:
    ///   - lhs: The first matrix.
    ///   - rhs: The second matrix.
    /// - Returns: The resulting matrix.
    /// - Precondition: The two matrices must be the same size.
    public static func +(lhs: Matrix<Element>, rhs: Matrix<Element>) -> Matrix<Element> {
        precondition(lhs.rowCount == rhs.rowCount && lhs.columnCount == rhs.columnCount, "Cannot add matrices of different dimensions.")
        return Matrix(elements: zip(lhs, rhs).map({ $0.0 + $0.1 }), rowCount: lhs.rowCount, columnCount: rhs.columnCount)
    }
    
    /// Subtracts two matrices of the same size.
    /// - Parameters:
    ///   - lhs: The first matrix.
    ///   - rhs: The second matrix.
    /// - Returns: The resulting matrix.
    /// - Precondition: The two matrices must be the same size.
    public static func -(lhs: Matrix<Element>, rhs: Matrix<Element>) -> Matrix<Element> {
        precondition(lhs.rowCount == rhs.rowCount && lhs.columnCount == rhs.columnCount, "Cannot add matrices of different dimensions.")
        return Matrix(elements: zip(lhs, rhs).map({ $0.0 - $0.1 }), rowCount: lhs.rowCount, columnCount: rhs.columnCount)
    }
    
}

extension Matrix where Element: Numeric {
    
    // MARK: - Initalization
    
    /// Creates an identify matrix of the given size.
    /// - Parameters:
    ///   - size: The number of rows and columns in the matrix.
    /// - Returns: A matrix of `0`'s with a value of `1` along the diagonal.
    public init(identityOfSize size: Int) {
        self.init(repeating: 0, diagonalElement: 1, rowCount: size, columnCount: size)
    }
    
    /// Transform a vector using the matrix.
    /// - Parameter vector: The vector to transform.
    /// - Returns: The transformed vector.
    public func transform(_ vector: [Element]) -> [Element] {
        precondition(vector.count == columnCount, "The vector length must be equal to the number of columns in the matrix.")
        return (0..<rowCount).map({ rowIndex in
            let row = self[row: rowIndex]
            return zip(row, vector).map(*).reduce(0, +)
        })
    }
    
    /// Multiply the elements of a matrix by a constant.
    /// - Parameters:
    ///   - lhs: The constant.
    ///   - rhs: The matrix.
    /// - Returns: The resulting matrix.
    public static func *(lhs: Element, rhs: Matrix<Element>) -> Matrix<Element> {
        return rhs.map({ lhs * $0 })
    }
    
    /// Multiply the elements of a matrix by a constant.
    /// - Parameters:
    ///   - lhs: The matrix.
    ///   - rhs: The constant.
    /// - Returns: The resulting matrix.
    public static func *(lhs: Matrix<Element>, rhs: Element) -> Matrix<Element> {
        return lhs.map({ $0 * rhs })
    }
    
    /// Computes the dot product of two matrices.
    /// - Parameters:
    ///   - lhs: The first matrix.
    ///   - rhs: The second matrix.
    /// - Returns: The dot product of the two matrices.
    /// - Precondition: The two matrices must be the same size.
    public static func •(lhs: Matrix<Element>, rhs: Matrix<Element>) -> Element {
        precondition(lhs.rowCount == rhs.rowCount && lhs.columnCount == rhs.columnCount, "Cannot compute the dot product of matrices with different dimensions.")
        return zip(lhs, rhs).reduce(Element.zero) { $0 + $1.0 * $1.1 }
    }
    
    /// Multiply two matrices.
    /// - Parameters:
    ///   - lhs: The first matrix.
    ///   - rhs: The second matrix.
    /// - Returns: The product of the two matrices.
    /// - Precondition: The two matrices must be the same size.
    public static func *(lhs: Matrix<Element>, rhs: Matrix<Element>) -> Matrix<Element> {
        precondition(lhs.columnCount == rhs.rowCount, "Cannot multiply matricies where the number of columns of the first matrix is not equal to the number of rows in the second matrix.")
        var result = Matrix(repeating: Element.zero, rowCount: lhs.rowCount, columnCount: rhs.columnCount)
        
        for rowIndex in 0..<lhs.rowCount {
            for columnIndex in 0..<rhs.columnCount {
                result[rowIndex, columnIndex] = zip(lhs[row: rowIndex], rhs[column: columnIndex]).map({ $0.0 * $0.1 }).reduce(Element.zero, +)
            }
        }
        
        return result
    }
    
}

extension Matrix where Element: SignedNumeric {
    
    /// The determinate of the matrix.
    /// - Precondition: The matrix must be square and not empty.
    public var determinant: Element {
        precondition(isSquare, "Cannot find the determinant of a non-square matrix.")
        precondition(!isEmpty, "Cannot find the determinant of an empty matrix.")
        
        guard rowCount != 1 && columnCount != 1 else {
            return self[0, 0]
        }
        
        var sum: Element = 0
        var polarity: Element = 1
        
        let topRow = self[row: 0]
        for (column, value) in topRow.enumerated() {
            var subMatrix = self
            _ = subMatrix.remove(rowAt: 0)
            _ = subMatrix.remove(columnAt: column)
            sum += polarity * value * subMatrix.determinant
            polarity *= -1
        }
        
        return sum
    }
    
    /// The cofactor of the matrix.
    public var cofactor: Matrix {
        return map({ (index, value) -> Element in
            var subMatrix = self
            _ = subMatrix.remove(rowAt: index.row)
            _ = subMatrix.remove(columnAt: index.column)
            let polarity: Element = ((index.row + index.column) % 2 == 0 ? 1 : -1)
            return subMatrix.determinant * polarity
        })
    }
    
    /// The adjugate of the matrix.
    public var adjoint: Matrix {
        return cofactor.transpose
    }

}

extension Matrix where Element: FloatingPoint {
    
    /// The inverse of the matrix.
    public var inverse: Matrix<Element> {
        return adjoint * (1 / determinant)
    }
    
}

