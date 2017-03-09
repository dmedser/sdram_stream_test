/***** MODE REGISTER DEFINITIONS *****/
`define write_burst_mode A[9]   
`define operating_mode   A[8:7] 
`define cas_latency      A[6:4] 
`define burst_type       A[3]   
`define burst_length     A[2:0] 

`define BURST_TYPE_SEQUENTIAL  0
`define BURST_TYPE_INTERLEAVED 1

`define BURST_LENGTH_1 0
`define BURST_LENGTH_2 1
`define BURST_LENGTH_4 2
`define BURST_LENGTH_8 3
`define BURST_LENGTH_FULL_PAGE 7
			 
`define CAS_LATENCY_2 2
`define CAS_LATENCY_3 3
			
`define OPERATING_MODE_STANDARD 0

`define WRITE_BURST_MODE_PROGRAMMED_BURST_LENGTH 0
`define WRITE_BURST_MODE_SINGLE_LOCATION_ACCESS  1

