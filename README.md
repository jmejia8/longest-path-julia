# Longest Path in a Directed Acyclic Graph

A [Julia 0.6.2](https://julialang.org/) implementation for solving *longest path in a 
Directed Acyclic Graph*.

## Usage

Test cases can be added to `test/` directory (see examples).

To get high performance, write in Julia REPL:
```
julia> include("main.jl")
1 2 5 10 11 6 (44)
1 4 5 7 8 (31)

julia> @time main() # to measure time
1 2 5 10 11 6 (44)
1 4 5 7 8 (31)
  0.001543 seconds (1.31 k allocations: 247.264 KiB)

```

Also, you can write in terminal `julia main.jl`

Here, `1 2 5 10 11 6 (44)` means: the largest path is 1 -> 2 -> 5 -> 10 -> 11 -> 6 
with distance 44.

## Time Complexity
This implementation spends, at most, linear time. That is, **O**(*E + R*)
where *E* is the number of edges and *R* the number of vertices without parents.