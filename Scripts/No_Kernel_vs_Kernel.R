#'
#' Epidemic Gillespie w/ Kernel Test
#'
#'


# Set seed then carry out Epidemic Gillespie

# Set same seed then do Kernel Epidemic Gillespie with full contact matrix
# (Everyone in contact with each other)

R_0 = 1.5
gamma = 0.5
psi = R_0*gamma
N = 10^(2:5)
beta = psi/N

#' Which Population
i = 1

par(mfrow = c(1,1))
# ==== Without Kernel ====
susceptibles_left = c()
for(j in 1:2000){
  print(j)
  Test_Epidemic_norm = Epidemic_Gillespie(N[i], a = 5, gamma, beta[i])
  susceptibles_left[j] = min(Test_Epidemic_norm[,2], na.rm = T)
}

# ==== With Kernel ====

kernel = Contact_Kernel(matrix(1, nrow = N[i], ncol = N[i]))

susceptibles_left_split = c()
for(j in 1:2000){
  print(j)
  Test_Epidemic_kernel = Kernel_Epidemic_Gillespie(N[i], a = 5, gamma, beta[i],
                                                   kernel)
  susceptibles_left_split[j] = min(Test_Epidemic_kernel$sim_data[,2], na.rm = TRUE)
}

# ==== Deterministic ====

kernel = Contact_Kernel(matrix(1, nrow = N[i], ncol = N[i]))
susceptibles_left_det = c()
for(j in 1:2000){
  print(j)
  E = rexp(2*N[i])
  U = runif(2*N[i])
  Test_Epidemic_Deterministic = Kernel_Deterministic_Gillespie(N[i], a = 5, beta[i], gamma, T_obs = c(0,10), k = 5, E, U, kernel,
                                                               store = T)

  susceptibles_left_det[j] = min(Test_Epidemic_Deterministic$sim_data[,2], na.rm = TRUE)
}

boxplot(susceptibles_left, susceptibles_left_split, susceptibles_left_det)

# ==== Profiling Gillespie Simulations w/ kernel ====

#' Standard

tmp = tempfile()
Rprof(tmp, interval = 0.01)

for(j in 1:2000){
  Test_Epidemic_norm = Epidemic_Gillespie(N[i], a = 5, gamma, beta[i])
}

Rprof(NULL)
summaryRprof(tmp)



#' W/ kernel
kernel = Contact_Kernel(matrix(1, nrow = N[i], ncol = N[i]))

tmp = tempfile()
Rprof(tmp, interval = 0.01)
for(j in 1:2000){
  Test_Epidemic_kernel = Kernel_Epidemic_Gillespie(N[i], a = 5, gamma, beta[i],
                                                   kernel)
}
Rprof(NULL)
summaryRprof(tmp)



#' Deterministic
tmp = tempfile()
Rprof(tmp, interval = 0.01)

for(j in 1:2000){
  E = rexp(2*N[i])
  U = runif(2*N[i])
  Test_Epidemic_Deterministic = Kernel_Deterministic_Gillespie(N[i], a = 5, beta[i], gamma, T_obs = c(0,10), k = 5, E, U, kernel,
                                                               store = T)
}

Rprof(NULL)
summaryRprof(tmp)


# ==== fsMCMC ====


psi = 1 # Normalised infection rate
p = 0.05 # Proportion Infected
N = c(2*10^2, 10^3, 10^4, 10^5) # Population
a = p*N
beta = psi/N # Infection parameter
gamma = 0.15 # Removal Parameter
prop_obs = 0.1
T_obs = c(0,30)
k = 6



sim_data1 = Contact_Epidemic$sim_data

i = 1
rep_sample = c(sample(N[i] - a[i], size = prop_obs*(N[i] - a[i])),
               sample((N[i] - a[i] + 1 ):N[i], size = prop_obs*a[i]))
x_rep = gillespie_panel_transitions(X_0 = prop_obs*(N[i] - a[i]), Y_0 = prop_obs*a[i],
                                    sim_data1[,5], sim_data1[,1], sim_data1[,6],
                                    T_obs, k, subset = rep_sample)



V = diag(1,2)
no_its = 10000
burn_in = 1000
lambda = 0.2
s = 250

Test = Epidemic_fsMCMC(N[i], a[i], x_rep, beta[i], gamma, kernel = Contact_Epidemic$kernel, no_draws = 2*N[i], s, T_obs, k, lambda, V,
                       no_its, burn_in)


Test = Epidemic_fsMCMC(N[i], a[i], x_rep, beta[i], gamma, kernel = kernel, no_draws = 2*N[i], s, T_obs, k, lambda, V,
                       no_its = 1000, burn_in = 100)



