import numpy as np
# machine_part_matrix=m
def dca_algorithm(machine_part_matrix):
    """
    Applies the DCA algorithm to a given machine-part matrix.
    
    Parameters:
    machine_part_matrix (numpy array): a binary matrix representing the 
                                        machine-part relationship
    
    Returns:
    cells (list): a list of cells formed by the algorithm
    """
    # Convert pandas DataFrame to numpy array if needed
    if hasattr(machine_part_matrix, 'values'):
        machine_part_matrix = machine_part_matrix.values
    
    # Step 1: Order the rows and columns
    # Sum the 1s in each row and column
    row_sums = machine_part_matrix.sum(axis=1)
    col_sums = machine_part_matrix.sum(axis=0)
    
    # Order the rows and columns based on their sums
    row_indices = np.argsort(-row_sums) # descending order
    col_indices = np.argsort(col_sums) # ascending order
    
    # Step 2: Sort the columns
    for i in range(len(machine_part_matrix)):
        for j in range(len(col_indices)):
            # If a column contains 1 in the current row,
            # shift it to the left
            if machine_part_matrix[row_indices[i]][col_indices[j]] == 1:
                machine_part_matrix[:, [j, j-1]] = machine_part_matrix[:, [j-1, j]]
                col_indices[j], col_indices[j-1] = col_indices[j-1], col_indices[j]
    
    # Step 3: Sort the rows
    for j in range(len(col_indices)):
        for i in range(len(machine_part_matrix)-1):
        
            if machine_part_matrix[row_indices[i]][col_indices[j]] == 0 and \
               machine_part_matrix[row_indices[i+1]][col_indices[j]] == 1:
                machine_part_matrix[[i, i+1], :] = machine_part_matrix[[i+1, i], :]
                row_indices[i], row_indices[i+1] = row_indices[i+1], row_indices[i]
    
    # Step 4: Form cells
    cells = []
    for i in range(len(row_indices)):
        # If the current row is not part of any cell yet
        if machine_part_matrix[row_indices[i], :].sum() > 0:
            # Form a new cell
            cell = []
            for j in range(len(col_indices)):
                if machine_part_matrix[row_indices[i], col_indices[j]] == 1:
                    cell.append(col_indices[j])
            cells.append(cell)
            # Remove the processed rows from the matrix
            machine_part_matrix[row_indices[i], :] = 0
    
    return cells



def dca(m):
    """
    Applies the Direct Clustering Algorithm (DCA) to a binary matrix `m` and returns the sorted binary matrix.

    Args:
        m (pandas.DataFrame): A binary matrix to be sorted by DCA. Rows represent items and columns represent features.
        
    Returns:
        pandas.DataFrame: The sorted binary matrix obtained by applying the DCA algorithm to `m`.
        
    The Direct Clustering Algorithm consists of the following steps:
    
    Step 1: Order the rows and columns.
    - Rows are ordered in descending order of their sum, breaking ties by numerical descending order.
    - Columns are ordered in ascending order of their sum, breaking ties by numerical descending order.
    
    Step 2: Sort columns.
    - Shift the column with 1 in the first row to the left.
    
    Step 3: Sort rows.
    - Sort the rows in descending order of the number of 1s they share with the first row.
    - Sort the columns as in Step 2, shifting the column with 1 in the first row to the left.
    """
    # Step 1: Order the rows and columns.
    m1 = m.copy()
    m1 = m1.iloc[np.argsort(-m1.sum(axis=1)), :]  # rows in desc order, break ties by numerical descending order
    m1 = m1.iloc[:, np.argsort(-m1.sum(axis=0))]  # cols in ascending order, break ties by numerical descending order

    # Step 2: sort columns,
    # shift column with 1 in the first row to the left
    m2 = m1.copy()
    for i in list(range(m2.shape[1])) + list(range(m2.shape[1] - 2, -1, -1)):
        m2.iloc[:, i] = m2.iloc[:, i].sort_values(ascending=False).reset_index(drop=True)

    # Step 3:
    m3 = m2.copy()
    for i in list(range(m3.shape[1])) + list(range(m3.shape[1] - 2, -1, -1)):
        m3.iloc[:, i] = m3.iloc[:, i].sort_values(ascending=False).reset_index(drop=True)

    return m3