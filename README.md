# ARM Assembly Projects  

This repository contains two ARM assembly projects implementing the **Breadth-First Search (BFS) algorithm** and **Merge Sort algorithm**. Both implementations follow an **iterative approach** instead of using function calls. The programs were developed and tested using **Keil uVision 5** with the **LH75400 microprocessor package**.  

## Task 1: Breadth-First Search (BFS) Algorithm  

### Description  
This task implements the **Breadth-First Search (BFS) algorithm** in ARM assembly. The algorithm traverses a graph level by level, ensuring that all nodes at a given depth are visited before moving to the next level.  

### Approach  
- **Iterative Process:** The BFS algorithm is implemented using a **queue-based approach** instead of recursion.  
- **Queue Management:** A **hardcoded adjacency matrix** represents the graph, and a queue (implemented using an array) stores nodes to be visited.  
- **Control Flow:** Conditional branching handles enqueueing and dequeueing operations to ensure correct traversal order.  

### Files  
- `BFS.s` - ARM assembly code implementing BFS.  
- `BFS_Report.pdf` - Detailed explanation of the BFS implementation.  

---

## Task 2: Merge Sort Algorithm on a 10-Element Array  

### Description  
This task implements the **Merge Sort algorithm** on a **hardcoded 10-element array** in ARM assembly. Instead of a recursive approach, the algorithm is structured iteratively.  

### Approach  
- **Iterative Merge Sort:** The array is divided into subarrays, sorted, and merged in multiple passes.  
- **Array Handling:** The 10-element array is stored in memory, and sorting is performed using a loop-based merging technique.  
- **Register Usage:** Sorting and merging operations are managed using registers and direct memory access, avoiding function calls.  

### Files  
- `MergeSort.s` - ARM assembly code implementing Merge Sort.  
- `MergeSort_Report.pdf` - Detailed explanation of the Merge Sort implementation.  

---

## Development Environment  

Both programs were written and tested using:  
- **Keil uVision 5** IDE  
- **LH75400 microprocessor package**  

This means the code is **not intended to be run in a terminal** but rather simulated and debugged within Keil uVision.  

---

## How to Use  

To run these programs:  
1. Open **Keil uVision 5**.  
2. Load the provided **assembly files** into a new project.  
3. Ensure that the **LH75400 microprocessor package** is installed.  
4. Assemble and build the project.  
5. Run the program using Keil’s **debugging and simulation tools**.  

For detailed step-by-step execution, refer to the corresponding **report files** for each task.  

---

## Why an Iterative Approach?  

Both algorithms are traditionally implemented recursively, but recursion handling in ARM assembly requires managing the **stack, function calls, and register preservation**. To **simplify execution and optimize performance**, these implementations:  
- **Avoid recursion** by using loops and arrays.  
- **Maintain control flow explicitly** through branching instead of function calls.  
- **Optimize memory usage** by managing data directly in registers where possible.  

---

