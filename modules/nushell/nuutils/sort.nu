export def "sort random" [] {
  let max = ($in | length) * 2
  $in | sort-by { random int 0..$max }
}