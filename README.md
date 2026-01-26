# ISYE 6960: Facilities Design & Industrial Logistics Design

A comprehensive repository of programs and tools developed for the **Facilities Design & Industrial Logistics Design** course. These implementations are designed to support key algorithms and methodologies in industrial engineering, with applications extending beyond this course to other IE projects.

## Overview

This repository contains implementations of fundamental algorithms and techniques used in:
- **Facilities Planning** - Layout design, department arrangement, and space allocation
- **Cellular Manufacturing** - Machine-part grouping and cell formation
- **Industrial Logistics** - Distribution, scheduling, and optimization

## Programs Included

### 1. Direct Clustering Algorithm (DCA)
**File**: `dca.py` with supporting functions in `main.py`

The Direct Clustering Algorithm is used to form manufacturing cells by clustering parts and machines based on their relationships. This algorithm helps identify which parts should be produced together and which machines should be grouped into cells.

**Usage**:
```bash
python dca.py
```

**Input**: `part.machine.csv` - A binary matrix where rows represent parts and columns represent machines. Entry (i,j) = 1 if part i requires machine j.

**Output**: A sorted matrix that reveals the block-diagonal structure, helping identify manufacturing cells and potential conflicts.

### 2. Kinematic Similarity (KS)
**File**: `ks.py`

Implements kinematic similarity methods for analyzing part and machine relationships based on their manufacturing requirements.

### 3. K-Means Clustering
**File**: `kmeans.py`

Standard k-means clustering implementation for grouping parts or machines based on similarity metrics.

### 4. Triangular Distribution
**File**: `triangular_distribution.py`

Utility for working with triangular probability distributions, commonly used in logistics and project management (PERT analysis).

### 5. Middle-Square Random Number Generator
**File**: `mid_sq.py`

Classic random number generation method useful for simulations in logistics and facilities planning.

## Data Files

- **`part.machine.csv`** - Binary incidence matrix representing part-machine relationships used by DCA and related algorithms

## Requirements

- Python 3.7+
- pandas
- numpy

## Installation

1. Clone or download this repository
2. Create a virtual environment (optional but recommended):
   ```bash
   python -m venv .venv
   source .venv/bin/activate  # On macOS/Linux
   ```
3. Install dependencies:
   ```bash
   pip install pandas numpy
   ```

## Usage Examples

### Running the Direct Clustering Algorithm

```bash
python dca.py
```

This will:
1. Read the part-machine matrix from `part.machine.csv`
2. Apply the DCA algorithm to reorganize rows and columns
3. Display the sorted matrix with visual representation
4. Help identify manufacturing cells and conflicts

## Applications in Other IE Projects

These tools can be adapted for:
- **Supply Chain Optimization** - Clustering suppliers and products
- **Hospital Layout Design** - Grouping departments and services
- **Warehouse Management** - Organizing stock locations and pick routes
- **Production Scheduling** - Cell-based manufacturing systems
- **Distribution Network Design** - Facility location and allocation problems

## Course Information

**Course**: ISYE 6960 - Facilities Design & Industrial Logistics Design

These programs support the theoretical concepts covered in the course and provide practical implementations for solving real-world industrial engineering problems.

## Notes

- All implementations follow industrial engineering standards and textbook algorithms
- Use these as starting points for more complex, real-world applications
- Modify data inputs and parameters to suit specific project requirements

## License

Educational use - Course materials for ISYE 6960

---

**Contributing**: Feel free to extend these programs with additional features, optimizations, or alternative algorithms for specific applications.
