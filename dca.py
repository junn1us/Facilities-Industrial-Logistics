import pandas as pd
import numpy as np
from main import dca

# Read the machine-part matrix from CSV
m = pd.read_csv("part.machine.csv", sep=",", header=None, dtype=int)

print("Original Machine-Part Matrix:")
print(m)
print("\n" + "="*50 + "\n")

# Apply DCA algorithm
result_matrix = dca(m)

print("Sorted Matrix (after DCA):")
print(result_matrix)
print("\n" + "="*50 + "\n")

# Display the matrix with visual representation
print("Visual representation (1 = part-machine pair):")
for i, row in result_matrix.iterrows():
    print(f"Part {i+1}: {' '.join(['X' if x == 1 else '-' for x in row])}")

