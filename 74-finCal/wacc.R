#Weighted Cost of Capital
#https://cran.r-project.org/web/packages/waccR/vignettes/Calculate_WACC_in_R.html

# Weighted Average Cost of Capital (WACC) represents the average cost of financing a company’s debt and equity. There are two approches to calculating it, one based on the “Build-up” approach, the other on the Capital Assets Pricing Model (CAPM) approach.
library(waccR)
#@14.5 Book
help(waccR)
wacc_usa <- wacc()
head(wacc_usa)
wacc_usa
