//
//  Matrix+Sequence.swift
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

extension Matrix: Sequence {
    
    // MARK: - Creating an Iterator
    
    public typealias Iterator = MatrixIterator<Element>
    
    public func makeIterator() -> Self.Iterator {
        MatrixIterator(matrix: self)
    }
    
    // MARK: - Transforming a Sequence
    
    /// Returns a matrix containing the results of mapping the given closure over the sequence’s elements.
    /// - Parameters:
    ///   - transform: A mapping closure. `transform` accepts an element of this sequence as its parameter and returns a transformed value of the same or of a different type.
    /// - Returns: A matrix containing the transformed elements of this sequence.
    public func map<S>(_ transform: (Element) throws -> S) rethrows -> Matrix<S> {
        return try Matrix<S>(elements: data.map(transform), rowCount: rowCount, columnCount: columnCount)
    }
    
    /// Returns a matrix containing the results of mapping the given closure over the sequence’s elements.
    /// - Parameters:
    ///   - transform: A mapping closure. `transform` accepts an element of this sequence as its parameter and returns a transformed value of the same or of a different type.
    /// - Returns: A matrix containing the transformed elements of this sequence.
    public func map<S>(_ transform: (Index, Element) throws -> S) rethrows -> Matrix<S> {
        var index = Index(row: 0, column: -1)
        return Matrix<S>(elements: try data.map({ (element) in
            index = self.index(after: index)
            return try transform(index, element)
        }), rowCount: rowCount, columnCount: columnCount)
    }
    
}
