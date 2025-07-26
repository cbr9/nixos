export def "str strip-diacritics" [] {
  $in | 
  str replace "á" "a" |
  str replace "é" "e" |
  str replace "í" "i" |
  str replace "ó" "o" |
  str replace "ú" "u" |
  str replace "Á" "A" |
  str replace "É" "E" |
  str replace "Í" "I" |
  str replace "Ó" "O" |
  str replace "Ú" "U" |
  str replace "à" "a" |
  str replace "è" "e" |
  str replace "ì" "i" |
  str replace "ò" "o" |
  str replace "ù" "u" |
  str replace "À" "A" |
  str replace "È" "E" |
  str replace "Ì" "I" |
  str replace "Ò" "O" |
  str replace "Ù" "U"
}
