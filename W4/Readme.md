<h1 align="center" style="color: white; background-color:; padding: 10px;">HW4 Summary</h1>

<p align="center">
    <img src="PIC_HW4/001.png" style="width: 60%; margin: auto; display: block;">
</p>

<p align="center">
    <img src="PIC_HW4/002.png" style="width: 60%; margin: auto; display: block;">
</p>

### <center> In this homework we will learn how to simulate discrete & continuous time, and how to interpretation PZ map information. </center>

<h2 align="center" style="color: white; background-color:; padding: 10px;">🖊Plot from system</h2>


<p align="center">
    <img src="PIC_HW4/1.png" style="width: 80%; margin: auto; display: block;">
</p>

<p align="center">
    <img src="PIC_HW4/3.png" style="width: 80%; margin: auto; display: block;">
</p>


<h2 align="center" style="color: white; background-color:; padding: 10px;">👀Interpretation</h2>


<center>

### From the PZ map, we can know the discrete time dominate pole overshoot is 28%. In the second picture, we do see the overshoot is 20% ish.
### Why the right plane of the poles is not dominate pole? Pole zero cancellation.
### Why the discrete time simulation outcome seems so poor? The time constant (τ = 2.79s) and T = 2 sec. T is too close to τ, causing Aliasing.


</center>

Given a time constant (τ) of a system, we can approximate its bandwidth and from there, determine the Nyquist frequency for sampling the system's output.

## Given Data
- Time Constant (τ): `2.79 seconds`

## Calculations

### 1. Approximate Bandwidth (f_B)
The bandwidth of a first-order system can be approximated as the inverse of the time constant.
f<sub>B</sub> = 1/ 

For τ = 2.79 seconds, the approximate bandwidth \( f_B \) is calculated as:

\[ f_B ≈ \frac{1}{2\pi \times 2.79} ≈ 0.057 \, \text{Hz} \]

### 2. Minimum Nyquist Frequency (f_N)
The Nyquist frequency should be at least twice the bandwidth to satisfy the Nyquist criterion for sampling.

\[ f_N ≥ 2 \times f_B \]

Thus, the minimum Nyquist frequency \( f_N \) is:

\[ f_N ≈ 2 \times 0.057 ≈ 0.114 \, \text{Hz} \]

## Conclusion
- Approximate Bandwidth (\(f_B\)): `0.057 Hz`
- Minimum Nyquist Frequency (\(f_N\)): `0.114 Hz`



