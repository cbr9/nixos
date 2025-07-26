# Get the absolute ancestors of a path
export def "path ancestors" [] {
    let parts = $in | path split
    $parts | enumerate | each {|p| $p.item | path join ...($parts | first ($p.index + 1))} | drop
}


