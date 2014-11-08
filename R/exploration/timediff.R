source("loader/timediffs.R")

timediffs = load_timediffs(reload=T)


timediffs$timediff.bucket = 2^round(log(timediffs$timediff, base=2))
timediffs$log.timediff = log(timediffs$timediff, base=2)

library(ggplot2)
library(doBy)
library(mixtools)

timediff.counts = with(
	summaryBy(
		timediff ~ timediff.bucket,
		data=timediffs,
		FUN=length
	),
	data.frame(
		timediff = timediff.bucket,
		n        = timediff.length
	)
)

png("plots/inter-edit_time.png", height=1024, width=2048, res=250)
ggplot(
	timediff.counts,
	aes(
		x=timediff,
		y=n
	)
) + 
geom_area(
	fill="#d6d6d6"
) + 
geom_line(
	color="#000000"
) + 
geom_vline(
	aes(xintercept=3600),
	linetype=2
) +
scale_x_log10(
	name="\nInter-edit time (log2 bucketed and log10 scaled)",
	breaks=c(60, 430, 60*60, 24*60*60, 7*24*60*60, 356*24*60*60),
	labels=c("minute", "7.5 min.", "hour", "day", "week", "year")
) + 
scale_y_continuous(name="Frequency\n") + 
theme_bw() + 
opts(
	axis.text.x=theme_text(angle=45, hjust=1)
)
dev.off()

timediff.counts$log.timediff = log(timediff.counts$timediff, base=2)
#timediff.inter.y = splinefun(timediff.counts$log.timediff, timediff.counts$n)(seq(0,27,0.1))
#timediff.inter.x = seq(0,27,0.1)


fit = normalmixEM(timediffs$log.timediff, lambda=c(.77, .15, .05), mu=c(6.5, 15.7, 22.5), sigma=c(2.75, 2.5, 2.5))
norm1 = function(x){dnorm(x, fit$mu[1], fit$sigma[1])*fit$lambda[1]}
norm2 = function(x){dnorm(x, fit$mu[2], fit$sigma[2])*fit$lambda[2]}
norm3 = function(x){dnorm(x, fit$mu[3], fit$sigma[3])*fit$lambda[3]}

#nsum = function(x){norm1(x) + norm2(x) + norm3(x)}


png("plots/inter-edit_time.fit.png", height=2048, width=2048, res=300)
ggplot(
	timediff.counts,
	aes(
		x=log.timediff,
		y=n/sum(n)
	)
) + 
geom_bar(
	fill="#cccccc",
	color="#888888",
	stat="identity"
) + 
geom_line(
	data=data.frame(x=seq(0,27,0.01), y=norm1(seq(0,27,0.01))),
	aes(x=x,y=y),
	color="red"
) + 
geom_area(
	data=data.frame(x=seq(0,27,0.01), y=norm1(seq(0,27,0.01))),
	aes(x=x,y=y),
	fill="red",
	alpha=0.25
) + 
geom_line(
	data=data.frame(x=seq(0,27,0.01), y=norm2(seq(0,27,0.01))),
	aes(x=x,y=y),
	color="blue"
) + 
geom_area(
	data=data.frame(x=seq(0,27,0.01), y=norm2(seq(0,27,0.01))),
	aes(x=x,y=y),
	fill="blue",
	alpha=0.25
) + 
geom_line(
	data=data.frame(x=seq(0,27,0.01), y=norm3(seq(0,27,0.01))),
	aes(x=x,y=y),
	color="green"
) + 
geom_area(
	data=data.frame(x=seq(0,27,0.01), y=norm3(seq(0,27,0.01))),
	aes(x=x,y=y),
	fill="green",
	alpha=0.25
) + 
geom_vline(
	aes(xintercept=log(3600, 2)),
	linetype=2
) +
scale_x_continuous(
	name="\nInter-edit time (log scaled)",
	breaks=c(
		log(60, 2),
		log(430, 2),
		log(60*60, 2),
		log(24*60*60, 2),
		log(7*24*60*60, 2),
		log(30*24*60*60, 2),
		log(356*24*60*60, 2)
	),
	labels=c("minute", "430 sec.", "hour", "day", "week", "month", "year")
) + 
scale_y_continuous(name="Frequency\n") + 
theme_bw() + 
opts(
	axis.text.x=theme_text(angle=45, hjust=1)
)
dev.off()
