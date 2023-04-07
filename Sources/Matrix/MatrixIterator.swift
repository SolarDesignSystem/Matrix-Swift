//
//  Matrix+Iterator.swift
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

public struct MatrixIterator<Element>: IteratorProtocol {
    
    // MARK: - Properties
    
    /// The matrix to iterate over.
    private let matrix: Matrix<Element>
    
    /// The current row
    private var row: Int = 0
    
    /// The current column
    private var column: Int = 0
    
    // MARK: Initialization
    
    internal init(matrix: Matrix<Element>) {
        self.matrix = matrix
    }
    
    // MARK: Iterator
    
    public mutating func next() -> Element? {
        // Validate the index is valid.
        guard matrix.isIndexValid(row: row, column: column) else {
            return nil
        }
        
        // Retrieve the next element
        let nextElement = matrix[row, column]
        
        // Increment the iterator
        var nextColumn: Int = column + 1
        var nextRow: Int = row
        if nextColumn == matrix.columnCount {
            nextColumn = 0
            nextRow += 1
        }
        
        row = nextRow
        column = nextColumn
        
        // Return the element.
        return nextElement
    }

}
