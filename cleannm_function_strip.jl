function cleannm_tocsv(filename, headerrow=-99, overwrite = false)

  normalizedfilename = abspath(filename)

  if(!isfile(normalizedfilename))
      error("file not found at: $normalizedfilename")
  end

  dirfile = splitdir(normalizedfilename)
  fileext = splitext(dirfile[2])


  rawdat = readlines(open(filename))
  println("read in rawdat")
  keeplines = similar(rawdat[3:4], 0)
  if headerrow .== -99
      for (i, x) in enumerate(rawdat)
          if headerrow .== -99
              if ismatch(r"ID|DV|TIME|MDV|EVID",x)
                  headerrow = i
                  break
              end
              continue
          end
      end
  end
  for x in rawdat
      if(!ismatch(r"TABLE|ID|DV|TIME|MDV|EVID", x))
          x = lstrip(x)
          x = replace(x, "  ", ",")
          # can use fancier regex to match all whitespace but is 2x slower
          # and if nonmem always is double spaced don't need to
          push!(keeplines, x)
      end
  end
  wdat = [replace(rawdat[headerrow], " ", ","), keeplines]
  if overwrite
      c = open(normalizedfilename, "w+")
  else
      c = open("$(fileext[1])_cleaned$(fileext[2])", "w+")
  end
  write(c, wdat)
  close(c)
  println("successfully cleaned")
end