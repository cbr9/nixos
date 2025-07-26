#!/usr/bin/env nu 
def parse_slurm_duration [] {
  # parse a SLURM timedate into nushell duration.
  # also make sure that timedates of less than one hour/day 
  # are correctly parsed by changing missing values into zeros
  let record = $in | parse -r '(?:(?P<DAYS>\d?\d)-)?(?:(?P<HOURS>\d?\d):)?(?P<MINUTES>\d?\d):(?P<SECONDS>\d?\d)' | str replace -r "^$" "0" HOURS DAYS  
  let duration = $record | format duration '{DAYS}day {HOURS}hr {MINUTES}min {SECONDS}sec'
  return $duration
}

export def "slurm nusqueue" [] {
  let table = squeue --format "%i\t%u\t%M\t%B\t%j\t%P\t%g\t%T\t%Q" | from tsv
  let time_running = $table | get TIME | parse_slurm_duration
  let time_running = [[TIME_RUNNING]; [$time_running]] | flatten
  let table = $table | reject TIME | merge $time_running | sort-by STATE TIME_RUNNING
  return $table
}

