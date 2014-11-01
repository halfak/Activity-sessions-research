library(ggplot2)
library(doBy)
library(mixtools)

cluster_init = list(
    short_within = list(
        color = "deepskyblue1",
        lambda = .55,
        mu = 3,
        sigma = 2
    ),
    long_within = list(
        color = "navyblue",
        lambda = .22,
        mu = 7,
        sigma = 2.75
    ),
    within = list(
        color = "blue",
        lambda = .77,
        mu = 6.7,
        sigma = 2.75
    ),
    between = list(
        color = "red",
        lambda = .15,
        mu = 16.5,
        sigma = 2.2
    ),
    extended_break = list(
        color = "yellow",
        lambda = .05,
        mu = 22.5,
        sigma = 2.5
    )
)

cluster_inits = function(clusters){
    inits = data.table(
        lambda=sapply(clusters, function(c){cluster_init[[c]]$lambda}),
        mu=sapply(clusters, function(c){cluster_init[[c]]$mu}),
        sigma=sapply(clusters, function(c){cluster_init[[c]]$sigma})
    )
    inits
}

fit_intertimes = function(intertimes, clusters){
    
    inits = cluster_inits(clusters)
    
    fit = normalmixEM(
        log(intertimes[intertimes > 0], base=2),
        lambda=inits$lambda,
        mu=inits$mu,
        sigma=inits$sigma
    )
    
    cluster_fits = list()
    for(cluster_i in 1:length(clusters)){
        cluster_fits[[clusters[cluster_i]]] = list(
            mu=fit$mu[cluster_i],
            sigma=fit$sigma[cluster_i],
            lambda=fit$lambda[cluster_i]
        )
    }
    cluster_fits
}


plot_frequencies = function(intertimes){
    ggplot(
        data.table(x=intertimes),
        aes(
            x=x
        )
    ) +
    geom_histogram(
        fill="#cccccc",
        color="#888888",
        binwidth=1/5,
        aes(y = (..density../sum(..density..)) * 1.5)
    ) +
    scale_x_log10(
        "\nInter-activity time",
        breaks=c(
            5,
            60,
            7*60,
            60*60,
            24*60*60,
            7*24*60*60,
            30*24*60*60,
            356*24*60*60
        ),
        labels=c("5 sec.", "minute", "7 min.", "hour", "day",
                 "week", "month", "year")
    ) +
    theme(
        axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position="top"
    ) +
    scale_y_continuous("Density\n") +
    theme_bw()
}

plot_clusters = function(intertimes, clusters=c("within", "between")){
    fit = fit_intertimes(intertimes, clusters)
    
    g = plot_frequencies(intertimes)
    
    max_intertime = max(intertimes)
    dists = rbindlist(
        lapply(
            clusters,
            function(cluster){
                log_norm = function(x){
                    dnorm(x, fit[[cluster]]$mu, fit[[cluster]]$sigma) *
                    fit[[cluster]]$lambda
                }
                data.table(
                    x = 2^seq(0,log2(max_intertime),.01),
                    y = log_norm(seq(0,log2(max_intertime),.01)),
                    cluster = cluster
                )
            }
        )
    )
    
    g = g +
    geom_area(
        data=dists,
        aes(x=x,y=y, fill=cluster),
        alpha=0.25,
        position="identity"
    ) +
    geom_line(
        data=dists,
        aes(x=x,y=y, color=cluster),
    )
    
    color_values = sapply(
        clusters,
        function(c){
            cluster_init[[c]]$color
        }
    )
    names(color_values) = clusters
    
    g = g +
    scale_fill_manual(
        name="Clusters",
        values=color_values,
        breaks=clusters,
        guide="legend"
    ) +
    scale_color_manual(
        name="Clusters",
        values=color_values,
        breaks=clusters,
        guide="legend"
    ) +
    theme(
        axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position="top"
    )
    
    g
}

theoretical_roc = function(intertimes, clusters){
    fit = fit_intertimes(intertimes, clusters)
    
    x = seq(0, max(log2(intertimes)), .1)
    
    within_clusters = intersect(clusters, c("within", "within_short",
                                            "within_long"))
    within_mass = sum(sapply(within_clusters, function(c){fit[[c]]$lambda}))
    
    tp = 0
    for(c in within_clusters){
        tp = tp + pnorm(x, fit[[c]]$mu, fit[[c]]$sigma) *
                  (fit[[c]]$lambda/within_mass)
    }
    
    external_clusters = setdiff(clusters, within_clusters)
    external_mass = sum(sapply(external_clusters, function(c){fit[[c]]$lambda}))
    
    fp = 0
    for(c in external_clusters){
        fp = fp + pnorm(x, fit[[c]]$mu, fit[[c]]$sigma) *
             (fit[[c]]$lambda/external_mass)
    }
    
    data.table(threshold=2^x, true_positive=tp, false_positive=fp)
    
}

plot_roc = function(intertimes, clusters=c("within", "between")){
    roc = theoretical_roc(intertimes, clusters)
    ggplot(
        roc,
        aes(x=false_positive, y=true_positive)
    ) +
    geom_line(
        aes(
            x=c(0, 1),
            y=c(0, 1)
        ),
        linetype=2,
        color="#888888"
    ) +
    geom_line() +
    scale_x_continuous("\nFalse positive rate") +
    scale_y_continuous("True positive rate\n") +
    theme_bw()
}

plot_true_and_false_positives = function(intertimes,
                                         clusters=c("within", "between")){
    
    ggplot(
        with(
            theoretical_roc(intertimes, clusters),
            rbind(
                data.table(
                    x=threshold,
                    y=true_positive,
                    label="true positive"
                ),
                data.table(
                    x=threshold,
                    y=false_positive,
                    label="false positive"
                )
            )
        ),
        aes(x=x, y=y, linetype=label, color=label)
    ) +
    geom_line() +
    theme_bw() +
    scale_x_log10(
        "\nInter-activity threshold",
        breaks=c(
            5,
            60,
            7*60,
            60*60,
            24*60*60,
            7*24*60*60,
            30*24*60*60,
            356*24*60*60
        ),
        labels=c("5 sec.", "minute", "7 min.", "hour", "day",
                 "week", "month", "year")
    ) +
    scale_color_manual(
        name="",
        values=c("true positive"="blue", "false positive"="red"),
        guide="legend"
    ) +
    scale_linetype_manual(
        name="",
        values=c("true positive"=1, "false positive"=2),
        guide="legend"
    ) +
    theme(
        axis.text.x = element_text(angle = 45, hjust = 1),
        legend.position="top"
    ) +
    scale_y_continuous("Rate\n")
}
