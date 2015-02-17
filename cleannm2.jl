using ArgParse

include("cleannm_function.jl")



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
println("Running cleannm...")
cleannm(parsed_args["arg1"], parsed_args["hr"], parsed_args["overwrite"])



#main(ARGS)