using ArgParse

function cleannm(filename, headerrow=-99)
    rawdat = readlines(open(filename))
    keeplines = similar(rawdat[3:4], 0)
    println(headerrow)
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
    println(headerrow)
    for x in rawdat
        if(!ismatch(r"(TABLE|ID)", x)) 
            push!(keeplines, lstrip(x))
        end
    end
    wdat = [replace(rawdat[headerrow], " ", ""), keeplines]
    c = open(filename*"cleaned", "w+")
    write(c, wdat)
    close(c)
    println("successfully cleaned")
end



s = ArgParseSettings("clean nonmem csv tables: " *  # description
                     "flags, options help, " *
                     "required arguments.")

@add_arg_table s begin
    "--hr"
        help = "which row is header"     # used by the help screen
        arg_type=Int
        default=-99
    "arg1"
        help = "nonmem table name"
        required = true        # makes the argument mandatory
end

parsed_args = parse_args(ARGS, s)
println("Parsed args:")
println(parsed_args["arg1"])
println(parsed_args["hr"])
println("Running cleannm")
cleannm(parsed_args["arg1"], parsed_args["hr"])



#main(ARGS)