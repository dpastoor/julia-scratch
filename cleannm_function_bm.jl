function cleannm_tocsv1(filename, headerrow=-99, overwrite = false)

  normalizedfilename = abspath(filename)

  if(!isfile(normalizedfilename))
      error("file not found at: $normalizedfilename")
  end

  dirfile = splitdir(normalizedfilename)
  fileext = splitext(dirfile[2])


  rawdat = readlines(open(filename))
  if headerrow .== -99
      for (i, x) in enumerate(rawdat)
          if headerrow .== -99
              if any([contains(x, s) for s in ["ID", "DV"]])
                  headerrow = i
                  break
              end
              continue
          end
      end
  end
  if overwrite
      c = open(normalizedfilename, "w+")
  else
      c = open("$(fileext[1])_cleaned$(fileext[2])", "w+")
  end
  write(c, rawdat[headerrow])
  for x in rawdat
      if(!any([contains(x, s) for s in ["ID", "DV", "TABLE"]]))
          x = lstrip(x)
          x = replace(x, "  ", ",")
          # can use fancier regex to match all whitespace but is 2x slower
          # and if nonmem always is double spaced don't need to
          write(c, x)
      end
  end

  close(c)
  println("successfully cleaned")
end

function cleannm_tocsv2(filename, headerrow=-99, overwrite = false)

  normalizedfilename = abspath(filename)

  if(!isfile(normalizedfilename))
      error("file not found at: $normalizedfilename")
  end

  dirfile = splitdir(normalizedfilename)
  fileext = splitext(dirfile[2])


  rawdat = readlines(open(filename))
  if headerrow .== -99
      for (i, x) in enumerate(rawdat)
          if headerrow .== -99
              if any([contains(x, s) for s in ["ID", "DV"]])
                  headerrow = i
                  break
              end
              continue
          end
      end
  end
  if overwrite
      c = open(normalizedfilename, "w+")
  else
      fn = "$(fileext[1])_cleaned2$(fileext[2])"
  end
  open(fn, "w") do c
    for x in rawdat
        if(!any([contains(x, s) for s in ["ID", "DV", "TABLE"]]))
            x = lstrip(x)
            x = replace(x, r"\s{2,}", ",") # 20% slower than doing a replace for "  "
            write(c, x)
        end
    end
  end
  println("successfully cleaned")
end

