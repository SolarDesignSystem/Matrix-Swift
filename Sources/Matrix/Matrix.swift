//
//  Matrix.swift
//  Matrix
//
//  Created by Solar Design System on 2/10/23.
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

/// A 2-D ordered, random-access collection.
public struct Matrix<Element> {
    
    // MARK: - Properties
    
    /// The data backing the matrix row by row.
    internal var data: [Element]
    
    /// The number of rows in the matrix.
    public internal(set) var rowCount: Int
    
    /// The number of columns in the matrix.
    public internal(set) var columnCount: Int
    
    // MARK: - Initialization
    
    /// Creates a 0x0 matrix.
    public init() {
        data = []
        rowCount = 0
        columnCount = 0
    }
    
    /// Creates a matrix repeating the specified element.
    /// - Parameters:
    ///   - element: The element to fill the matrix with.
    ///   - rowCount: The number of rows in the matrix.
    ///   - columnCount: The number of columns in the matrix.
    public init(repeating element: Element, rowCount: Int, columnCount: Int) {
        self.rowCount = rowCount
        self.columnCount = columnCount
        self.data = Array(repeating: element, count: rowCount * columnCount)
    }
    
    /// Creates a matrix with the given elements.
    /// - Parameters:
    ///   - elements: The elements to create the matrix.
    ///   - rowCount: The number of rows in the matrix.
    ///   - columnCount: The number of columns in the matrix.
    /// - Note: If `elements.count` is not equal to `rowCount * columnCount` this initalizer will fail.
    public init(elements: [Element], rowCount: Int, columnCount: Int) {
        precondition(elements.count == rowCount * columnCount, "The number of elements in the array must be equal to rowCount * columnCount")
        self.rowCount = rowCount
        self.columnCount = columnCount
        self.data = elements
    }
    
    /// Creates a matrix with the given elements.
    /// - Parameters:
    ///   - elements: The elements to create the matrix.
    /// - Note: If the provided rows are not the same length this initializer will fail.
    public init(elements: [[Element]]) {
        precondition(Set(elements.map({ $0.count })).count == 1, "Every row in the array must have the same length.")
        self.rowCount = elements.count
        self.columnCount = elements.first?.count ?? 0
        self.data = elements.reduce(into: Array<Element>(), { partialResult, row in
            partialResult.append(contentsOf: row)
        })
    }
    
    /// Creates a matrix repeating the given element, and a different element along the diagonal.
    /// - Parameters:
    ///   - elements: The elements to create the matrix.
    ///   - diagonalElement: The element to repeat along the diagonal.
    ///   - rowCount: The number of rows in the matrix.
    ///   - columnCount: The number of columns in the matrix.`.
    public init(repeating element: Element, diagonalElement: Element, rowCount: Int, columnCount: Int) {
        self.init(repeating: element, rowCount: rowCount, columnCount: columnCount)
        for i in 0..<Swift.min(rowCount, columnCount) {
            self.data[(i * columnCount) + i] = diagonalElement
        }
    }
    
    // MARK: - Utilities
    
    /// Whether or not the matrix is square.
    public var isSquare: Bool {
        rowCount == columnCount
    }
    
    /// Whether or not the given index is valid.
    /// - Parameters:
    ///   - row: The potential row index.
    ///   - column: The potential column index.
    /// - Returns: Whether or not the given index is a valid index.
    internal func isIndexValid(row: Int, column: Int) -> Bool {
        isIndexValid(Index(row: row, column: column))
    }
    
    /// Whether or not the given index is valid.
    /// - Parameters:
    ///   - index: The potential index.
    /// - Returns: Whether or not the given index is a valid index.
    internal func isIndexValid(_ index: Index) -> Bool {
        index.row >= 0 && index.row < rowCount && index.column >= 0 && index.column < columnCount
    }
    
}
