if (!require("gplots")) {
  install.packages("gplots", dependencies = TRUE)
}

if (!require("RColorBrewer")) {
  install.packages("RColorBrewer", dependencies = TRUE)
}

if (!require("MASS")) {
  install.packages("MASS", dependencies = TRUE)
}
library(fields)
rm(list = ls())

# Define Variables Here
domain <- 'i27'
sim_name <- paste('clpy-tmd-pull-eef1-',domain, sep='',collapse = '')
force <- 'fmean300'
analysis <- "contour-length"
r_script_dir <- '/media/javidi/data/library/clpy/manuscripts/clpy-implicit-solvent-paper/r-scripts/implicit-solvent'
traj_dir <- paste('/media/javidi/data/library/clpy/',sim_name,'/analysis/enery-force-translocation-qn-rgyr-rms/trajs',sep = '',collapse='')

# Find and filter the list of targeted folders
setwd(traj_dir)
print(traj_dir)
print(list.dirs())
list_dirs <- list.dirs()

targeted_lsit_dirs <- grep(force,list_dirs, value = T)
print(targeted_lsit_dirs)
i <- 1
# Loop over directories
readfirstcycle <- FALSE
for (dir in targeted_lsit_dirs) {
  analysis_data_file_name <- paste(dir,"/",analysis,"-tmd-pull.dat.merged", sep='', collapse = '')
  print(paste("Reading: ",analysis_data_file_name))
  if (file.exists(analysis_data_file_name)) {
    print("File exists....")
    if (!exists("analysis_df") && readfirstcycle==FALSE) {
      analysis_df = read.table(file=analysis_data_file_name,sep="",header = F, na.strings = "", stringsAsFactors = F, nrows = 2501)
      analysis_df$traj <- rep(i, nrow(analysis_df))
      readfirstcycle <- TRUE
      i <- i + 1
    }
    if (exists("analysis_df") && readfirstcycle==TRUE){
      temp_analysis_df = read.table(file = analysis_data_file_name, sep = "", header=F, na.strings = "", stringsAsFactors = F, nrows = 2501 )
      temp_analysis_df$traj <- rep(i, nrow(temp_analysis_df))
      analysis_df <- rbind(analysis_df, temp_analysis_df)
      rm(temp_analysis_df)
      i <- i + 1
    }
  }
}


plot(x=c(0,2500),
     y=c(1,90),
     yaxs = "i",
     type="n",
     las=1,
     xlab="Transect Number",
     ylab="Total Number")

for (i in 1:24) {
 print(i)
 current_traj_df <- analysis_df[analysis_df$traj==i,]
 colour <- ifelse(tail(current_traj_df$V6)<80,"green","red")
 print(colour)
  if (force=='fmean150' && domain=='i27'){
   current_traj_df$V6 <- current_traj_df$V6 - 22
   } 
   else if (force=='fmean300' && domain=='i27') {
   current_traj_df$V6 <- current_traj_df$V6 - 44
   }
   else if (force=="fmean150" && domain=="2i7") {
   print("YAY")
   current_traj_df$V6 <- current_traj_df$V6 - 2060 #+ 111 - 22
   }
 lines(current_traj_df$V6,col=colour)
}

