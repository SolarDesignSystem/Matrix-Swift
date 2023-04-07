//
//  MatrixMathTests.swift
//  MatrixTests
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

import XCTest
@testable import Matrix

final class MatrixMathTests: XCTestCase {
    
    func testTranspose() {
        let matrix = Matrix(elements: [1, 2, 3, 4, 5, 6, 7, 8, 9], rowCount: 3, columnCount: 3)
        XCTAssertEqual(matrix.transpose, Matrix(elements: [1, 4, 7, 2, 5, 8, 3, 6, 9], rowCount: 3, columnCount: 3), "The matrix does not match the expected value.")
    }
    
    func testAddition() {
        let matrixA = Matrix(elements: [1, 2, 3, 4], rowCount: 2, columnCount: 2)
        let matrixB = Matrix(elements: [5, 6, 7, 8], rowCount: 2, columnCount: 2)
        XCTAssertEqual(matrixA + matrixB, Matrix(elements: [6, 8, 10, 12], rowCount: 2, columnCount: 2), "The matrix does not match the expected value.")
    }
    
    func testSubtraction() {
        let matrixA = Matrix(elements: [1, 2, 3, 4], rowCount: 2, columnCount: 2)
        let matrixB = Matrix(elements: [5, 6, 7, 8], rowCount: 2, columnCount: 2)
        XCTAssertEqual(matrixA - matrixB, Matrix(elements: [-4, -4, -4, -4], rowCount: 2, columnCount: 2), "The matrix does not match the expected value.")
    }
    
    func testIdentityInitializer() {
        let matrix = Matrix<Int>(identityOfSize: 3)
        XCTAssertEqual(matrix, Matrix(elements: [1, 0, 0, 0, 1, 0, 0, 0, 1], rowCount: 3, columnCount: 3), "The matrix does not match the expected value.")
    }
    
    func testTransform() {
        let matrix = Matrix(elements: [1, 2, 3, 4], rowCount: 2, columnCount: 2)
        let vector = [5, 6]
        XCTAssertEqual(matrix.transform(vector), [17, 39], "The result does not match the expected value.")
    }
    
    func testMultiplicationByConstant() {
        let matrix = Matrix(elements: [1, 2, 3, 4], rowCount: 2, columnCount: 2)
        XCTAssertEqual(2 * matrix, Matrix(elements: [2, 4, 6, 8], rowCount: 2, columnCount: 2), "The result does not match the expected value.")
        XCTAssertEqual(matrix * 2, Matrix(elements: [2, 4, 6, 8], rowCount: 2, columnCount: 2), "The result does not match the expected value.")
    }
    
    func testDotProduct() {
        let matrixA = Matrix(elements: [1, 2, 3, 4], rowCount: 2, columnCount: 2)
        let matrixB = Matrix(elements: [5, 6, 7, 8], rowCount: 2, columnCount: 2)
        XCTAssertEqual(matrixA • matrixB, 70, "The result does not match the expected value.")
    }
    
    func testMultiplicationByMatrix() {
        let matrixA = Matrix(elements: [2, 3, 1, 4, 2, 1], rowCount: 3, columnCount: 2)
        let matrixB = Matrix(elements: [3, 1, 2, 2, 4, 2], rowCount: 2, columnCount: 3)
        XCTAssertEqual(matrixA * matrixB, Matrix(elements: [12, 14, 10, 11, 17, 10, 8, 6, 6], rowCount: 3, columnCount: 3), "The result does not match the expected value.")
    }
    
    func testDeterminant() {
        let matrix = Matrix(elements: [1, 3, 5, 9, 1, 3, 1, 7, 4, 3, 9, 7, 5, 2, 0, 9], rowCount: 4, columnCount: 4)
        XCTAssertEqual(matrix.determinant, -376, "The result does not match the expected value.")
    }
    
    func testCofactor() {
        let matrix = Matrix(elements: [0, 9, 3, 2, 0, 4, 3, 7, 0], rowCount: 3, columnCount: 3)
        XCTAssertEqual(matrix.cofactor, Matrix(elements: [-28, 12, 14, 21, -9, 27, 36, 6, -18], rowCount: 3, columnCount: 3), "The result does not match the expected value.")
    }
    
    func testAdjoint() {
        let matrix = Matrix(elements: [0, 9, 3, 2, 0, 4, 3, 7, 0], rowCount: 3, columnCount: 3)
        XCTAssertEqual(matrix.adjoint, Matrix(elements: [-28, 21, 36, 12, -9, 6, 14, 27, -18], rowCount: 3, columnCount: 3), "The result does not match the expected value.")
    }
    
    func testInverse() {
        let matrix = Matrix<Double>(elements: [0, 9, 3, 2, 0, 4, 3, 7, 0], rowCount: 3, columnCount: 3)
        XCTAssertEqual(matrix.inverse, Matrix<Double>(elements: [-14.0 / 75.0, 7.0 / 50.0, 6.0 / 25.0, 2.0 / 25, -3.0 / 50.0, 1.0 / 25.0, 7.0 / 75.0, 9.0 / 50.0, -3.0 / 25.0], rowCount: 3, columnCount: 3), accuracy: 0.0000000000000001, "The result does not match the expected value.")
    }
    
}
