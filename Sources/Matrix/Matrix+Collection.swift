//
//  Matrix+Collection.swift
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

extension Matrix: Collection {
    public typealias Index = MatrixIndex
    
    public var startIndex: Self.Index {
        Index(row: 0, column: 0)
    }
    
    public var endIndex: Self.Index {
        Index(row: rowCount - 1, column: columnCount - 1)
    }
    
    /// An index for a random element in the matrix.
    public func randomIndex() -> MatrixIndex? {
        guard rowCount != 0 && columnCount != 0 else {
            return nil
        }
        
        let randomRow = (0..<rowCount).randomElement()!
        let randomColumn = (0..<columnCount).randomElement()!
        return MatrixIndex(row: randomRow, column: randomColumn)
    }
    
    public func index(after i: Index) -> Index {
        if i.column + 1 < columnCount {
            return Index(row: i.row, column: i.column + 1)
        } else {
            return Index(row: i.row + 1, column: 0)
        }
    }
    
    public var count: Int {
        data.count
    }
    
    public var isEmpty: Bool {
        data.count == 0
    }
    
    /// Gets or sets the element at the specified index.
    /// - Parameters:
    ///   - position: The index of the element.
    /// - Returns: The element at the inputed index.
    /// - Precondition: The index must be within the range of the matrices rows/columns.
    public subscript(position: Index) -> Element {
        get {
            precondition(isIndexValid(position), "MatrixIndex(row: \(position.row), column: \(position.column)) out of range")
            return data[(position.row * columnCount) + position.column]
        }
        set {
            precondition(isIndexValid(position), "MatrixIndex(row: \(position.row), column: \(position.column)) out of range")
            data[(position.row * columnCount) + position.column] = newValue
        }
    }
    
    /// Gets or sets the element at the specified row and column.
    /// - Parameters:
    ///   - row: The index of the row of the element.
    ///   - column: The index of the column of the element.
    /// - Returns: The element at the specified index.
    /// - Precondition: The index must be within the range of the matrices rows/columns.
    public subscript(row: Int, column: Int) -> Element {
        get {
            precondition(isIndexValid(row: row, column: column), "Index: (\(row), \(column)) out of range")
            return data[(row * columnCount) + column]
        }
        set {
            precondition(isIndexValid(row: row, column: column), "Index: (\(row), \(column)) out of range")
            data[(row * columnCount) + column] = newValue
        }
    }
    
    // TODO: Should output `ArraySlice` like object.
    /// Gets or sets the row at the specified index.
    /// - Parameters:
    ///   - row: The index of the row to acccess.
    /// - Returns: The row at the specified index.
    /// - Precondition: The index must be within the range of the matrices rows/columns.
    public subscript(row index: Int) -> [Element] {
        get {
            precondition(isIndexValid(row: index, column: 0), "Row: \(index) out of range")
            return Array(data[(index * columnCount)..<(index * columnCount) + columnCount])
        } set {
            precondition(index < rowCount, "Row: \(index) out of range.")
            precondition(newValue.count == columnCount, "Row: Must contain \(columnCount) items")
            for (columnIndex, element) in newValue.enumerated() {
                data[(index * columnCount) + columnIndex] = element
            }
        }
    }
    
    // TODO: Should output `ArraySlice` like object.
    /// Gets or sets the column at the specified index.
    /// - Parameters:
    ///   - column: The index of the column to acccess.
    /// - Returns: The column at the specified index.
    /// - Precondition: The index must be within the range of the matrices rows/columns.
    public subscript(column index: Int) -> [Element] {
        get {
            precondition(isIndexValid(row: 0, column: index), "Column: \(index) out of range")
            let column = (0..<rowCount).map { (currentRow) -> Element in
                let currentColumnIndex = currentRow * columnCount + index
                return data[currentColumnIndex]
            }
            return column
        } set {
            precondition(index < columnCount, "Column: \(index) out of range.")
            precondition(newValue.count == rowCount, "Row: Must contain \(rowCount) items")
            for (rowIndex, element) in newValue.enumerated() {
                data[(rowIndex * columnCount) + index] = element
            }
        }
    }

}

extension Matrix: MutableCollection {
    
    /// Removes the row at the given index.
    /// - Parameter row: The index of the row to remove.
    /// - Returns: The row that was removed from the matrix.
    public mutating func remove(rowAt row: Int) -> [Element] {
        let range = (row * columnCount)..<((row * columnCount) + (columnCount))
        let removedData = Array<Element>(data[range])
        rowCount -= 1
        data.removeSubrange(range)
        return removedData
    }
    
    /// Removes the column at the given index.
    /// - Parameter column: The index of the column to remove.
    /// - Returns: The column that was removed from the matrix.
    public mutating func remove(columnAt column: Int) -> [Element] {
        let indices = (0..<rowCount).map({ Index(row: $0, column: column) })
        let removedData = indices.map({ self[$0] })
        let colCount = columnCount
        let dataIndices = indices.map({ ($0.row * colCount) + $0.column }).reversed()
        columnCount -= 1
        dataIndices.forEach({ data.remove(at: $0) })
        return removedData
    }
    
    /// Appends a row to the end of the matrix.
    /// - Parameter row: The row to append.
    /// - Precondition: Inserted rows must have the same number of elements as the number of columns in the matrix.
    public mutating func append(row: [Element]) {
        insert(row: row, at: rowCount)
    }
    
    /// Inserts a row into the matrix.
    /// - Parameters:
    ///   - row: The row to insert.
    ///   - rowIndex: The index where the row will be inserted.
    /// - Precondition: Inserted rows must have the same number of elements as the number of columns in the matrix.
    public mutating func insert(row: [Element], at rowIndex: Int) {
        precondition(row.count == columnCount, "Inserted rows must has the same number of elements as the number of columns in the matrix.")
        let dataIndex = rowIndex * columnCount
        data.insert(contentsOf: row, at: dataIndex)
        rowCount += 1
    }
    
    /// Appends a column to the end of the matrix.
    /// - Parameter column: The column to append.
    /// - Precondition: Inserted columns must have the same number of elements as the number of rows in the matrix.
    public mutating func append(column: [Element]) {
        insert(column: column, at: columnCount)
    }
    
    /// Inserts a column into the matrix.
    /// - Parameters:
    ///   - column: The column to insert.
    ///   - columnIndex: The index where the column will be inserted.
    /// - Precondition: Inserted columns must have the same number of elements as the number of rows in the matrix.
    public mutating func insert(column: [Element], at columnIndex: Int) {
        precondition(column.count == rowCount, "Inserted columns must has the same number of elements as the number of rows in the matrix.")
        let dataIndices = (0..<rowCount).map({ ($0 * columnCount) + columnIndex })
        for (arrayIndex, index) in dataIndices.enumerated() {
            data.insert(column[arrayIndex], at: index)
        }
        columnCount += 1
    }
    
}

extension Matrix: BidirectionalCollection {
    
    public func index(before i: MatrixIndex) -> MatrixIndex {
        if i.column == 0 {
            return Index(row: i.row - 1, column: columnCount - 1)
        } else {
            return Index(row: i.row, column: i.column - 1)
        }
    }
    
}

extension Matrix: RangeReplaceableCollection {
    
    mutating public func replaceSubrange<C>(_ subrange: Range<Self.Index>, with newElements: C) where C : Collection, Self.Element == C.Element {
        let lastSubrangeIndex = index(before: subrange.upperBound)
        let startIndex = subrange.lowerBound.row * columnCount + subrange.lowerBound.column
        let endIndex = lastSubrangeIndex.row * columnCount + (lastSubrangeIndex.row + 1)
        
        let elementCount = endIndex - startIndex
        precondition(elementCount == newElements.count, "The number of replacement elements must equal the number of elements being replaced.")
        
        data.replaceSubrange(startIndex..<endIndex, with: newElements)
    }
    
}
