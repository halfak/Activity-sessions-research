source("loader/stack_overflow_post_intertimes.sample.R")

posts = load_stack_overflow_post_intertimes.sample(reload=T)

source('clustering.R')

############################ All ##########################################
fit = fit_intertimes(
    posts[type=="all"]$intertime,
    clusters=c("within", "between", "extended_break")
)
svg("exploration/plots/inter-activity_time.stack_overflow_posts.svg",
    height=5, width=7)
plot_clusters(
    posts[type=="all"]$intertime,
    clusters=c("within", "between", "extended_break"),
    fit=fit
)
dev.off()

svg("exploration/plots/threshold_roc.stack_overflow_posts.svg", height=5, width=7)
plot_roc(
    posts[type=="all"]$intertime,
    clusters=c("within", "between", "extended_break"),
    fit=fit
)
dev.off()

svg("exploration/plots/true_and_false_positives.stack_overflow_posts.svg",
    height=5, width=7)
plot_true_and_false_positives(
    posts[type=="all"]$intertime,
    clusters=c("within", "between", "extended_break"),
    fit=fit
)
dev.off()

svg("exploration/plots/true_and_false_positive_difference.stack_overflow_posts.svg",
    height=5, width=7)
plot_true_and_false_positive_difference(
    posts[type=="all"]$intertime,
    clusters=c("within", "between", "extended_break"),
    fit=fit
)
dev.off()

############################ Questions #########################################
fit = fit_intertimes(
    posts[type=="question"]$intertime,
    clusters=c("between", "extended_break")
)
svg("exploration/plots/inter-activity_time.stack_overflow_questions.svg",
    height=5, width=7)
plot_clusters(
    posts[type=="question"]$intertime,
    clusters=c("between", "extended_break"),
    fit=fit
)
dev.off()

svg("exploration/plots/threshold_roc.stack_overflow_questions.svg", height=5, width=7)
plot_roc(
    posts[type=="question"]$intertime,
    clusters=c("between", "extended_break"),
    fit=fit
)
dev.off()

svg("exploration/plots/true_and_false_positives.stack_overflow_questions.svg",
    height=5, width=7)
plot_true_and_false_positives(
    actions[type=="question"]$intertime,
    clusters=c("between", "extended_break"),
    fit=fit
)
dev.off()

svg("exploration/plots/true_and_false_positive_difference.stack_overflow_questions.svg",
    height=5, width=7)
plot_true_and_false_positive_difference(
    posts[type=="question"]$intertime,
    clusters=c("between", "extended_break"),
    fit=fit
)
dev.off()

############################ Answers #########################################
fit = fit_intertimes(
    posts[type=="answer"]$intertime,
    clusters=c("within", "between", "extended_break")
)
svg("exploration/plots/inter-activity_time.stack_overflow_answers.svg",
    height=5, width=7)
plot_clusters(
    posts[type=="answer"]$intertime,
    clusters=c("within", "between", "extended_break"),
    fit=fit
)
dev.off()

svg("exploration/plots/threshold_roc.stack_overflow_answers.svg", height=5, width=7)
plot_roc(
    posts[type=="answer"]$intertime,
    clusters=c("within", "between", "extended_break"),
    fit=fit
)
dev.off()

svg("exploration/plots/true_and_false_positives.stack_overflow_answers.svg",
    height=5, width=7)
plot_true_and_false_positives(
    posts[type=="answer"]$intertime,
    clusters=c("within", "between", "extended_break"),
    fit=fit
)
dev.off()

svg("exploration/plots/true_and_false_positive_difference.stack_overflow_answers.svg",
    height=5, width=7)
plot_true_and_false_positive_difference(
    posts[type=="answer"]$intertime,
    clusters=c("within", "between", "extended_break"),
    fit=fit
)
dev.off()
