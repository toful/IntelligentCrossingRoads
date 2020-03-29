# IntelligentCrossingRoads

[![License](https://img.shields.io/github/license/toful/IntelligentCrossingRoads?style=plastic)](https://github.com/toful/IntelligentCrossingRoads)

Design and implementation of an Expert System over the CLIPS shell that controls Intelligent Crossing Roads. This exericise has been carried out on the Knowledge Representation and Engineering subject, MESIIA Master, URV

## Introduction

In the new era of the Internet of Things (IOT) and autonomous cars (AC), a change in the control of crossing roads is expected that will replace all traffic lights by peer‐to‐peer communication between cars and crossing road controls (CRC). With these new intelligent crossings, cars will arrive in one of four possible directions (North, South, East, or West), they will communicate their arrival, and will wait in line until they are given the way. 

We are have designed two types of CRCs implementing two alternative preference policies: 
* straight‐right crossing (SRC)
* straight‐right‐left crossing (SRLC)

SRLC and the SRC are going to be implemented as two separate set of rules in a Rule Production System with CLIPS.

### Straight‐Right Crossing (SRC)

SRC allows a car to cross either following the same lane or turning to the right. It rotates the crossing from North&South to East&West, in alternate turns, communicating to the N first cars in each two directions that they can cross.


### Straight‐Right-Left Crossing (SRLC)

SRLC control allows a car to cross following the same lane, but also turning either to the right or to the left. It follows a "the first car arriving is the first car crossing" strategy, this meaning that cars cross in the strict order in which they communicate arrival to the crossing.

## Pre-requisites

In order to run the program you need to have [CLIPS](http://www.clipsrules.net/) installed:

```apt-get install clips```

## Usage

Run the CRC implementing the SRC policie:

	$ clips
	CLIPS> (batch src-policy.bat)

Run the CRC implementing the SRC policie:

	$ clips
	CLIPS> (batch srlc-policy.bat)

## Authors

* **Klevis Shkembi** - [klevis](https://github.com/KlevisShkembi)
* **Cristòfol Daudén Esmel** - [toful](https://github.com/toful)