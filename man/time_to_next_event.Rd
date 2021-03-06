% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/General_Epidemic_Simulation.R
\name{time_to_next_event}
\alias{time_to_next_event}
\title{time_to_next_event Draws the time to next event in the Infectious Disease process}
\usage{
time_to_next_event(rates, population, dist = "Exp")
}
\arguments{
\item{rates}{Holds information about the rates ate which each individual transition
between each state}

\item{population}{Holds information about what state each individual in the population is in}

\item{dist}{What distribution does the time_to_next_event follow (Exponential for a
First Order Markov Process)}
}
\description{
time_to_next_event Draws the time to next event in the Infectious Disease process
}
