# index.mod

set T;                            # Time periods
set STOCKS;                       # Stock tickers

param R {T, STOCKS};              # Stock returns
param R_b {T};                    # Benchmark (ETF) returns
param q integer;                  # Number of stocks to select

var w {s in STOCKS} >= 0;         # Weights of stocks
var z {s in STOCKS} binary;       # 1 if stock selected

# Constraints
s.t. TotalWeight: sum {s in STOCKS} w[s] = 1;
s.t. LimitStocks:  sum {s in STOCKS} z[s] = q;
s.t. LinkSelection {s in STOCKS}: w[s] <= z[s];

# Objective function: minimize tracking error
minimize TotalTrackingError:
    sum {t in T} (sum {s in STOCKS} w[s] * R[t,s] - R_b[t])^2;
