#################################################################################
##### RideSharing and USS: Data Import: NYC: Raw Download
##### 8 October 2020
##### Description: Note that this file will need to be adjusted when new data is 
#####              posted to the landing website
#################################################################################

NYC_sales <- read_html("https://www1.nyc.gov/site/finance/taxes/property-annualized-sales-update.page")

NYC_sales_parsed <- NYC_sales                          %>%
  html_nodes("td a")                                   %>%
  html_attr("href")                                    %>%
  data.frame(stringsAsFactors = FALSE)                 %>%
  filter(str_detect(.,".xls") | str_detect(.,".xlsx")) %>%
  filter(str_detect(.,"annualized"))                   %>%
  mutate(filetype = if_else(str_detect(., ".xlsx"), ".xlsx", ".xls"))


### Identify names of datasets
slashloc  <- str_locate_all(NYC_sales_parsed$., "/")
slashvec  <- vector(mode = "numeric")
for (i in 1:length(slashloc)){
  tempmat   <- slashloc[[i]]
  n         <- dim(tempmat)[1]
  slashvec  <- c(slashvec, tempmat[n,2])
}

NYC_sales_parsed <- NYC_sales_parsed                  %>%
  mutate(slash    = slashvec)                         %>%
  mutate(filename = str_sub(., start = slashvec + 1)) %>%
  mutate(Year     = str_sub(filename, end = 4),
         Borough  = str_to_title(str_sub(filename, start = 6, end = str_locate(filename, "\\.")[,1]-1))) %>%
  mutate(Borough  = if_else(Borough == "Statenisland", "Staten", Borough))                               %>%
  mutate(savename = here("Data", "Raw", paste0("PropertySales_NYC_", Borough, "_", Year, filetype)))  %>%
  mutate(linkname = paste0("https://www1.nyc.gov", .))                                                

if (dir.exists(paste0(file_NYC, "\\Sales\\Raw"))){
  unlink(paste0(file_NYC, "\\Sales\\Raw"), recursive = TRUE)
  dir.create(paste0(file_NYC, "\\Sales\\Raw"), recursive = TRUE)
}else {
  dir.create(paste0(file_NYC, "\\Sales\\Raw"), recursive = TRUE)
}

for (i in 1:dim(NYC_sales_parsed)[1]){
  download.file(NYC_sales_parsed$linkname[i], NYC_sales_parsed$savename[i], mode = "wb")
}
rm(list=ls()[ls() %in% c("NYC_sales", "NYC_sales_parsed", "slashloc", "tempmat")])