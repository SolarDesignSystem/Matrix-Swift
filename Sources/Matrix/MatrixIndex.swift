//
//  MatrixIndex.swift
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

/// The index type for matricies.
public struct MatrixIndex: Comparable, Codable {
    
    // MARK: - Properties
    
    /// The row of the element in the matrix the index represents.
    public var row: Int
    
    /// The column of the element in the matrix. the index represents
    public var column: Int
    
    /// The transpose of the index.
    public var transpose: MatrixIndex {
        return MatrixIndex(row: column, column: row)
    }
    
    // MARK: - Initalization
    
    
    /// Create a new matrix index.
    /// - Parameters:
    ///   - row: The row of the element in the matrix the index represents.
    ///   - column: The column of the element in the matrix. the index represents
    public init(row: Int, column: Int) {
        self.row = row
        self.column = column
    }
    
    /// Codable
    
    public init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        self.row = try container.decode(Int.self)
        self.column = try container.decode(Int.self)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.unkeyedContainer()
        try container.encode(row)
        try container.encode(column)
    }
    
    // MARK: - Comparable
    
    public static func < (lhs: MatrixIndex, rhs: MatrixIndex) -> Bool {
        if lhs.row > rhs.row {
            return false
        } else if lhs.row == rhs.row {
            return lhs.column < rhs.column
        } else {
            return true
        }
    }
    
    // MARK: - String Convertable
    
    public var description: String {
        return "[\(row), \(column)]"
    }
    
    public var debugDescription: String {
        return description
    }
    
}
