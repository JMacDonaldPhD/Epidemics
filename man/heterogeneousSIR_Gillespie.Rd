% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/simplified_gillespies.R
\name{heterogeneousSIR_Gillespie}
\alias{heterogeneousSIR_Gillespie}
\title{Possible states and their respective
logical representations.
Summarise in matrix
Initial state of each individual
Initial state of epidemic at population level
Possible Events
Summarise in a matrix
event table
Waiting Time
Which event happens?
event = sample(c(1,2), size = 1, prob = c(infectionRate, removalRate))
To who?
Construct rate vector
Update Population State
Update Individual State
Record event}
\usage{
heterogeneousSIR_Gillespie(initialState, beta, gamma, kernel)
}
\description{
Possible states and their respective
logical representations.
Summarise in matrix
Initial state of each individual
Initial state of epidemic at population level
Possible Events
Summarise in a matrix
event table
Waiting Time
Which event happens?
event = sample(c(1,2), size = 1, prob = c(infectionRate, removalRate))
To who?
Construct rate vector
Update Population State
Update Individual State
Record event
}
