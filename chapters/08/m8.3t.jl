using TuringModels, Turing

Turing.setadbackend(:reverse_diff)

@model m8_3(y) = begin
    α ~ Normal(1, 10)
    σ ~ Truncated(Cauchy(0, 1), 0, Inf)

    for i ∈ 1:length(y)
        y[i] ~ Normal(α, σ)
    end
end

y = [-1,1]

posterior = sample(m8_3(y), Turing.NUTS(4000,1000, 0.95));

posterior2 = MCMCChain.Chains(posterior.value[1001:4000,:,:], names=posterior.names)

describe(posterior2)

m83rethinking = "
      mean   sd  5.5% 94.5% n_eff Rhat
alpha 0.09 1.63 -2.13  2.39   959    1
sigma 2.04 2.05  0.68  4.83  1090    1
";

# This file was generated using Literate.jl, https://github.com/fredrikekre/Literate.jl

