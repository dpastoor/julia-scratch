using ArgParse

function cleannm(filename, headerrow=2, overwrite = false)
    rawdat = readlines(open(filename))
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
        if(!ismatch(r"ID|DV|TIME|MDV|EVID", x)) 
            push!(keeplines, lstrip(x))
        end
    end
    wdat = [replace(rawdat[headerrow], " ", ""), keeplines]
    if overwrite
        c = open(filename, "w+")
    else
        c = open(filename*"cleaned", "w+")
    end
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
        default=2
    "--overwrite"
        help = "whether to overwrite original file"
        arg_type=Bool
        default = false
    "arg1"
        help = "nonmem table name"
        required = true        # makes the argument mandatory
end

parsed_args = parse_args(ARGS, s)
println("Parsed args:")
println(parsed_args["arg1"])
println(parsed_args["hr"])
println("Running cleannm")
cleannm(parsed_args["arg1"], parsed_args["hr"], parsed_args["overwrite"])



#main(ARGS)