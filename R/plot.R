library(ggplot2)
library(ggmap)

df = read.csv("../data/crash-merged-lat-lng.csv")
df.subset = df[df$TLA.NAME == "Hamilton City", ]

hamilton = qmap("hamilton new zealand", zoom=14, color="bw")

# density crashes in hamilton
hamiltonMap + stat_density2d(
  aes(x=LNG, y=LAT, fill=..level.., alpha=..level..),
  bins=6, geom="polygon", data=df.subset) +
  scale_fill_gradient(low = "black", high = "red")

# point crashes in hamilton


# bar plot crashes by region
tla.factors.sorted = levels(df$TLA.NAME)[ order(table(df$TLA.NAME)) ]
tla.sorted = factor(df$TLA.NAME, levels=tla.factors.sorted)
tmp = data.frame(tla.sorted=tla.sorted)
ggplot(tmp, aes(tla.sorted)) + geom_bar() + coord_flip() + ylab("Frequency") + xlab("Region") + ggtitle("Number of car accidents by region")

causes = read.csv("../data/causes.csv")
# types of crashes
cause.sorted = factor(causes$cause, levels=levels(causes$cause)[ order(table(causes$cause))])
tmp = data.frame(cause=cause.sorted)
png("causes.png", width=2000, height=5000)
ggplot(tmp, aes(cause)) + geom_bar() + coord_flip()
dev.off()

dates = read.csv("../data/dates.csv")
png("dates.png", width=2000, height=1000)
ggplot(dates, aes(date)) + geom_bar() + theme(axis.text.x=element_text(angle=90,hjust=1,vjust=0.5))
dev.off()

objects = read.csv("../data/objects.csv")
ggplot(objects, aes(object)) + geom_bar() + coord_flip()

weathers = read.csv("../data/weathers.csv")
ggplot(weathers, aes(weather)) + geom_bar() + coord_flip()
