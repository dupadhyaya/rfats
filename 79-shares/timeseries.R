#Get Financial Quotes as zoo
# from yahoo

library(tseries)
SBUX.z = get.hist.quote(instrument="sbux", start="1993-03-01", end="2008-03-01", quote="AdjClose", provider="yahoo", origin="1970-01-01", compression="d", retclass="zoo") 
SBUX.z
start(SBUX.z)
end(SBUX.z)
