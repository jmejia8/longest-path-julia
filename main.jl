# return all vertices without parents
function getRoots(graph)
    roots = Array{Int}([])

    children = Set(graph[:,2])

    for parnt ∈ Set(graph[:,1])
        if parnt ∉ children
            push!(roots, parnt)
        end
    end

    return roots

end

function findPath(graph, edge, ws, paths)
    _ , vertex, w = edge

    # println(edge)

    # is it visited?
    if haskey(ws, vertex)
        return ws[vertex] + w, paths[vertex]
    end

    # get children
    children = graph[ graph[:,1] .== vertex,: ]
    n_children = length(children[:,1])
        
    # leaves only return its weight and id 
    if n_children == 0
        return w, [vertex]
    end

    w_max = -Inf
    best_path = []

    # for each child of vertex instance best path
    for i ∈ 1:n_children

        w_c, path = findPath(graph, children[i,:], ws, paths)

        if w_max < w_c
            w_max = w_c
            best_path = path
        end
    end
    
    # save best path information
    ws[vertex] = w_max
    paths[vertex] = [vertex ; best_path]

    return ws[vertex] + w, paths[vertex]

end

function findPath(graph)
    # vertices without parents
    roots = getRoots(graph)

    # paths information from i-th vertex to longest path
    ws    = Dict{Int, Int}()
    paths = Dict{Int, Vector{Int}}()

    w_max = -1
    best_path = []

    # for each root / connected-component find longest path
    for vertex ∈ roots

        w_c, path = findPath(graph, [-1, vertex, 0], ws, paths)

        if w_max < w_c
            w_max = w_c
            best_path = path
        end

    end

    return w_max, best_path
end

function main()

    for testCase ∈ readdir("./test")
        graph = readdlm("./test/$testCase", Int)

        w, path = findPath( graph )

        for vertex ∈ path
            print(vertex, " ")
        end
        
        println("($w)")
    end

end

main()