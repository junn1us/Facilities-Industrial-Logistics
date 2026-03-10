# ISYE 6960: Facilities Design & Industrial Logistics Design

A comprehensive repository of programs and tools developed for the **Facilities Design & Industrial Logistics Design** course. These implementations are designed to support key algorithms and methodologies in industrial engineering, with applications extending beyond this course to other IE projects.

## Overview

This repository contains implementations of fundamental algorithms and techniques used in:
- **Facilities Planning** - Layout design, department arrangement, and space allocation
- **Cellular Manufacturing** - Machine-part grouping and cell formation
- **Industrial Logistics** - Distribution, scheduling, and optimization



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
- Use these as starting points for more complex applications
- Modify data inputs and parameters to suit specific project requirements

## License

Educational use 

---

**Contributing**: Feel free to extend these programs with additional features, optimizations, or alternative algorithms for specific applications.
