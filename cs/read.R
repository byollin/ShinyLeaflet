library(quantmod)
library(magrittr)
indices <- c('SFXRSA', 'LXXRSA', 'NYXRSA', 'BOXRSA', 'SDXRSA', 'CHXRSA', 'SEXRSA', 'DNXRSA',
             'PHXRSA', 'DAXRSA', 'MIXRSA', 'POXRSA', 'WDXRSA', 'LVXRSA', 'ATXRSA', 'MNXRSA',
             'DEXRSA', 'TPXRSA', 'CRXRSA', 'CEXRSA', 'SPCS20RSA')
cities  <- c('San Francisco', 'Las Angeles', 'New York City', 'Boston', 'San Diego', 'Chicago',
             'Seattle', 'Denver', 'Phoenix', 'Dallas', 'Miami', 'Portland', 'Washington D.C.',
             'Las Vegas', 'Atlanta', 'Minneapolis', 'Detroit', 'Tampa', 'Charlotte', 'Cleveland',
             '20-City Composite')
dict    <- as.list(cities) %>% setNames(nm = indices)
env     <- new.env()
lapply(indices, getSymbols, src = 'FRED', env = env)
cs      <- as.list(env) %>% setNames(nm = dict[names(as.list(env))]) %>% as.list()
cs      <- lapply(cs, function(x) x['2000-01-01/2017-12-01'])
save(list = c('cs', 'cities'), file = 'cs.Rdata')
