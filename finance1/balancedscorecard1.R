# Balanced Scorecard
#https://cran.r-project.org/web/packages/scorecard/scorecard.pdf

# Load German credit data and create subset
library(scorecard)
data(germancredit)
df = germancredit[, c('creditability', 'credit.amount', 'duration.in.month',
                      'savings.account.and.bonds', 'purpose')]
# Display structure of the subset (data frame)
str(df)

#-----
# Load German credit data
data(germancredit)
# information values
dt_info_value = iv(germancredit, y = "creditability")
dt_info_value


#perf
## Not run:
# load germancredit data
data("germancredit")
# filter variable via missing rate, iv, identical value rate
dt_sel = var_filter(germancredit, "creditability")
# woe binning ------
bins = woebin(dt_sel, "creditability")
dt_woe = woebin_ply(dt_sel, bins)
# glm ------
m1 = glm( creditability ~ ., family = binomial(), data = dt_woe)
summary(m1)
# Select a formula-based model by AIC
m_step = step(m1, direction="both", trace=FALSE)
m2 = eval(m_step$call)
summary(m2)

# predicted proability
(dt_pred = predict(m2, type='response', dt_woe))
# performance ------
# Example I # only ks & auc values
perf_eva(dt_woe$creditability, dt_pred, show_plot=FALSE)
# Example II # ks & roc plot
perf_eva(dt_woe$creditability, dt_pred)
# Example III # ks, lift, roc & pr plot
perf_eva(dt_woe$creditability, dt_pred, type = c("ks","lift","roc","pr"))
## End(Not run)


#-----
## Not run:
# load germancredit data
data("germancredit")
# filter variable via missing rate, iv, identical value rate
dt_sel = var_filter(germancredit, "creditability")
# breaking dt into train and test ------
dt_list = split_df(dt_sel, "creditability", ratio = 0.6, seed=21)
dt_train = dt_list$train; dt_test = dt_list$test
dt_train

# woe binning ------
bins = woebin(dt_train, "creditability")
# converting train and test into woe values
train = woebin_ply(dt_train, bins)
test = woebin_ply(dt_test, bins)
# glm ------
m1 = glm(creditability ~ ., family = binomial(), data = train)
# summary(m1)
# Select a formula-based model by AIC
m_step = step(m1, direction="both", trace=FALSE)
m2 = eval(m_step$call)
# summary(m2)
# predicted proability
train_pred = predict(m2, type='response', train)
test_pred = predict(m2, type='response', test)
# # ks & roc plot
# perf_eva(train$creditability, train_pred, title = "train")
# perf_eva(test$creditability, test_pred, title = "test")

#' # scorecard
card = scorecard(bins, m2)
# credit score, only_total_score = TRUE
train_score = scorecard_ply(dt_train, card)
test_score = scorecard_ply(dt_test, card)
# Example I # psi
psi = perf_psi(
  score = list(train = train_score, test = test_score),
  label = list(train = train$creditability, test = test$creditability)
)
# psi$psi # psi dataframe
# psi$pic # pic of score distribution

# Example II # specifying score range
psi_s = perf_psi(
  score = list(train = train_score, test = test_score),
  label = list(train = train$creditability, test = test$creditability),
  x_limits = c(200, 750),
  x_tick_break = 50
)
# Example III # credit score, only_total_score = FALSE
train_score2 = scorecard_ply(dt_train, card, only_total_score=FALSE)
test_score2 = scorecard_ply(dt_test, card, only_total_score=FALSE)
# psi

psi2 = perf_psi( score = list(train = train_score2, test = test_score2),
                 label = list(train = train$creditability, test = test$creditability)
)
# psi2$psi # psi dataframe
# psi2$pic # pic of score distribution
## End(Not run)


#-----
## Not run:
# load germancredit data
data("germancredit")
# filter variable via missing rate, iv, identical value rate
dt_sel = var_filter(germancredit, "creditability")

# woe binning ------
bins = woebin(dt_sel, "creditability")
dt_woe = woebin_ply(dt_sel, bins)
# glm ------
m = glm(creditability ~ ., family = binomial(), data = dt_woe)
# summary(m)
# Select a formula-based model by AIC
m_step = step(m, direction="both", trace=FALSE)
m = eval(m_step$call)
# summary(m)
# predicted proability
# dt_pred = predict(m, type='response', dt_woe)
# performace
# ks & roc plot
# perf_eva(dt_woe$creditability, dt_pred)

# scorecard
# Example I # creat a scorecard
card = scorecard(bins, m)
# credit score
# Example I # only total score
score1 = scorecard_ply(dt, card)
# Example II # credit score for both total and each variable
score2 = scorecard_ply(dt, card, only_total_score = F)
## End(Not run)

