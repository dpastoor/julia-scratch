
# coding: utf-8

# In[2]:

function pauc(idv, dv, range)
    idvfirst = range[1]
    idvlast = range[2]
    dv = dv[dv .>= idvfirst]
    idv = idv[idv .>= idvfirst]
    lengthidv = length(idv[idv .<= idvlast])
    paucvalue = zeros(0)
    for i = 1:(lengthidv - 1)
        push!(paucvalue, (dv[i] + dv[i+1])*(idv[i + 1]-idv[i])/2)
    end
    return sum(paucvalue)
end


# In[3]:

using DataFrames


# In[4]:

df = readtable("/Users/devin/Desktop/predout_qpc_2cmt2.csv")


# In[5]:

subdf = df[df[:REPLICATE] .== 0, :]


# In[6]:

subdf[:Time]


# In[7]:

function runpauc()
    by(df, [:id, :REPLICATE], df -> pauc(df[:Time], df[:DV], [0, 24]))
end


# In[15]:

@time runpauc()
@time runpauc()

# In[9]:


# In[10]:

using Benchmark

benchmark(runpauc, "partialauc", "pauc()", 10)


# In[13]:




# In[14]:
