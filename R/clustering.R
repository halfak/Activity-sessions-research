library(ggplot2)
library(doBy)
library(mixtools)

fit_intertimes = function(intertimes, clusters){
    normalmixEM(
        log(intertimes[intertimes > 0], base=2),
        lambda=c(.77, .15, .05)[1:clusters],
        mu=c(6.5, 15.7, 22.5)[1:clusters],
        sigma=c(2.75, 2.5, 2.5)[1:clusters]
    )
}

log_freq_intertimes = function(intertimes){
    intertimes[,
        list(
            freq=length(user)
        ),
        list(
            intertime.log_bucket = 2^round(log(intertime, base=2))
        )
    ]
}

plot_clusters = function(intertimes, clusters=2){
    colors = c("red", "blue", "green")
    fit = fit_intertimes(intertimes$intertime, clusters)
    
    g = ggplot(
        intertimes,
        aes(
            x=intertime
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
            60,
            430,
            60*60,
            24*60*60,
            7*24*60*60,
            30*24*60*60,
            356*24*60*60
        ),
        labels=c("minute", "430 sec.", "hour", "day", "week", "month", "year")
    ) +
    scale_y_continuous("Density\n") + 
    theme_bw()
    
    max_intertime = max(intertimes$intertime)
    for(cluster in 1:clusters){
        log_norm = function(x){
            dnorm(x, fit$mu[cluster], fit$sigma[cluster])*fit$lambda[cluster]
        }
        dist = data.table(
            x = 2^seq(0,log2(max_intertime),.01),
            y = log_norm(seq(0,log2(max_intertime),.01))
        )
        
        cat("Plotting cluster:", cluster, "\n")
        g = g +
        geom_area(
            data=dist,
            aes(x=x,y=y),
            fill=colors[cluster],
            alpha=0.25
        ) +
        geom_line(
            data=dist,
            aes(x=x,y=y),
            color=colors[cluster]
        )
    }
    
    g
}
