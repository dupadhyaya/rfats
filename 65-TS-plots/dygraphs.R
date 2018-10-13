#Dygraphs
#https://rstudio.github.io/dygraphs/gallery-series-options.html

#dygraphs for R
# The dygraphs package is an R interface to the dygraphs JavaScript charting library. It provides rich facilities for charting time-series data in R, including:
#   
#   Automatically plots xts time series objects (or any object convertible to xts).
# Highly configurable axis and series display (including optional second Y-axis).
# Rich interactive features including zoom/pan and series/point highlighting.
# Display upper/lower bars (e.g. prediction intervals) around series.
# Various graph overlays including shaded regions, event lines, and point annotations.
# Use at the R console just like conventional R plots (via RStudio Viewer).
# Seamless embedding within R Markdown documents and Shiny web applications.

#InstallationYou can install the dygraphs package from CRAN as follows:
install.packages("dygraphs")
#You can use dygraphs at the R console, within R Markdown documents, and within Shiny applications. See the usage documentation linked to from the sidebar for more details. There are a few demos of dygraphs below as well as quite a few others in the gallery of examples.

#Demos Here’s a simple dygraph created from a multiple time series object:
  
library(dygraphs)
lungDeaths <- cbind(mdeaths, fdeaths)
dygraph(lungDeaths)
dygraph(lungDeaths) %>% dyRangeSelector()

dygraph(lungDeaths) %>%  dySeries("mdeaths", label = "Male") %>%  dySeries("fdeaths", label = "Female") %>%   dyOptions(stackedGraph = TRUE) %>%   dyRangeSelector(height = 20)

#Many options for customizing series and axis display are available. It’s even possible to combine multiple lower/value/upper style series into a single display with shaded bars. Here’s an example that illustrates shaded bars, specifying a plot title, suppressing the drawing of the grid for the x axis, and the use of a custom palette for series colors:
  
hw <- HoltWinters(ldeaths)
predicted <- predict(hw, n.ahead = 72, prediction.interval = TRUE)

dygraph(predicted, main = "Predicted Lung Deaths (UK)") %>%  dyAxis("x", drawGrid = FALSE) %>%   dySeries(c("lwr", "fit", "upr"), label = "Deaths") %>%  dyOptions(colors = RColorBrewer::brewer.pal(3, "Set1"))


#
library(dygraphs)

lungDeaths <- cbind(ldeaths, mdeaths, fdeaths)
dygraph(lungDeaths, main = "Deaths from Lung Disease (UK)") %>%
  dyOptions(colors = RColorBrewer::brewer.pal(3, "Set2"))
?dygraph

#Step Plots
#By default dygraphs displays series as a line, you can however plot series as step chart as follows:
  
lungDeaths <- cbind(mdeaths, fdeaths)
dygraph(lungDeaths, main = "Deaths from Lung Disease (UK)") %>%
  dyOptions(stepPlot = TRUE)

#Filling
#You can also fill in the area underneath the series as well as customize the alpha value for the filling:
  
dygraph(ldeaths, main = "Deaths from Lung Disease (UK)") %>%  dyOptions(fillGraph = TRUE, fillAlpha = 0.4)

#Point Display
#You can include display of the individual points in a series as well as customize the size of the points:
  
dygraph(ldeaths, main = "Deaths from Lung Disease (UK)") %>%  dyOptions(drawPoints = TRUE, pointSize = 2)


#Different point shapes are available as well:

dygraph(ldeaths, main = "Deaths from Lung Disease (UK)") %>%
  dyOptions(drawPoints = TRUE, pointSize = 5, pointShape = "triangle")


#The possible parameters for pointShape are: triangle, square, diamond, pentagon, hexagon,  circle, star, plus or ex.

#Per-Series Options
#All of the options above can also be set on a per-series basis using the dySeries function. For example:
  
dygraph(lungDeaths, main = "Deaths from Lung Disease (UK)") %>% dySeries("mdeaths", drawPoints = TRUE, pointShape = "square", color = "blue") %>%  dySeries("fdeaths", stepPlot = TRUE, fillGraph = TRUE, color = "red")

#Line Strokes
#You can also customize the way that series lines are drawn. Here we draw a wider line with a custom stroke pattern (dashed line):
  
dygraph(ldeaths, main = "Deaths from Lung Disease (UK)") %>%  dySeries("V1", strokeWidth = 2, strokePattern = "dashed")


#dyGroup
#With dyGroup you can replicate options across multiple series or pass a vector of values and have it replicate across the series. If arguments differ in length than the number of series named, then the argument will be cycled across the named series.

lungDeaths <- cbind(mdeaths, fdeaths, ldeaths)

dygraph(lungDeaths, main = "Deaths from Lung Disease (UK)") %>%  dySeries("fdeaths", stepPlot = TRUE, color = "red") %>%  dyGroup(c("mdeaths", "ldeaths"), drawPoints = TRUE, color = c("blue", "green"))


#https://rstudio.github.io/dygraphs/gallery-series-highlighting.html

#Series Highlighting----
#When users hover their mouse over series and points on the graph a highlight effect appears on the surface of the graph. You can use the dyHighlight function to customize how the highlighting appears.

#In this example we specify a larger circle size for point highlighting as well as more decisively fade the non-highlighted series. We also request that the highlighting persist even after the mouse leaves the graph area.

lungDeaths <- cbind(ldeaths, mdeaths, fdeaths)
dygraph(lungDeaths, main = "Deaths from Lung Disease (UK)") %>%  dyHighlight(highlightCircleSize = 7,  highlightSeriesBackgroundAlpha = 0.3,hideOnMouseOut = FALSE)

#You can also set additional visual options for the highlighted series using highlightSeriesOpts. This argument takes a list of named series options to apply to just the currently highlighted series (see the dySeries function for the various options that can be set). Here we set the stroke width of highlighted series to 3:
  
dygraph(lungDeaths, main = "Deaths from Lung Disease (UK)") %>%  dyHighlight(highlightSeriesOpts = list(strokeWidth = 3))


#candlestick Diagram

library(xts)
data(sample_matrix)
head(sample_matrix)
m <- tail(sample_matrix, n = 32)
dygraph(m) %>% dyCandlestick()

#Candlestick charts use the first four data series to plot, the rest of the data series (if any) are rendered with line plotter:
  
m <- cbind(m, apply(m[, 1:3], 1, mean))
colnames(m)[5] <- "Mean" 
dygraph(m) %>%   dyCandlestick()


#You can also use compress function argument to compress chart data annually, quarterly, monthly, weekly or daily depending on the current chart zoom level to prevent chart bars overflow:
  
library(xts)
data(sample_matrix)
dygraph(sample_matrix) %>%  dyCandlestick(compress = TRUE)
#select areas


#Synchronization
#You can link the zoom behavior of multiple dygraphs by specifying a group when creating the graph. For example, the following code links the three graphs below. Try zooming one chart (done by mouse-selection) and note that the zoom range of the other graphs is also updated.

dygraph(ldeaths, main = "All", group = "lung-deaths")
dygraph(mdeaths, main = "Male", group = "lung-deaths")
dygraph(fdeaths, main = "Female", group = "lung-deaths")



#Straw Broom Charts
#You can create straw broom charts with dyRebase function. For example:
  
library(quantmod)

tickers <- c("AAPL", "MSFT")
getSymbols(tickers)
closePrices <- do.call(merge, lapply(tickers, function(x) Cl(get(x))))
dateWindow <- c("2008-01-01", "2009-01-01")

dygraph(closePrices, main = "Value", group = "stock") %>%
  dyRebase(value = 100) %>%
  dyRangeSelector(dateWindow = dateWindow)

dygraph(closePrices, main = "Percent", group = "stock") %>%
  dyRebase(percent = TRUE) %>%
  dyRangeSelector(dateWindow = dateWindow)

dygraph(closePrices, main = "None", group = "stock") %>%
  dyRangeSelector(dateWindow = dateWindow)

#Roll Periods
#In order to smooth out the display of a series you can specify a rollPeriod. This will result in each plotted point representing an average of the number of timestamps specified in the roll period. The roll period will be displayed in a text box at the bottom-left of the plot so that viewers of the plot are aware of the averaging and so that they can change it if they like.

#The dyRoller function adds a roller with a specified roll period:
  
dygraph(discoveries, main = "Important Discoveries") %>% dyRoller(rollPeriod = 5)
