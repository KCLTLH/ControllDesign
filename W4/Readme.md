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

<h1 align="center" style="color: white; background-color:pink; padding: 10px;">🧮 Calculation</h1>

<br>

<h2 align="center" style="color: white; background-color:; padding: 10px;">Approximate Bandwidth (f<sub>B</sub>)</h2>

<center>

#### The bandwidth of a first-order system can be approximated as the inverse of the time constant.
### f<sub>B</sub> = 1/(2 π τ)

#### For τ = 2.79 seconds, the approximate bandwidth f<sub>B</sub> = `0.057 Hz`

</center>

<h2 align="center" style="color: white; background-color:; padding: 10px;">Minimum Nyquist Frequency (f<sub>N</sub>)</h2>

<center>

#### The Nyquist frequency should be at least twice the bandwidth to satisfy the Nyquist criterion for sampling.

### f<sub>N</sub> ≥ 2f<sub>B</sub> ≥ `0.11409 Hz`

#### Thus, the minimum Nyquist frequency f<sub>N</sub> is:

### f<sub>N</sub> ≈ `0.114 Hz`

</center>

<h2 align="center" style="color: white; background-color:; padding: 10px;">Conclusion</h2>

<center>

### Approximate Bandwidth **f<sub>B</sub>** : `0.057 Hz`
### Minimum Nyquist Frequency **f<sub>N</sub>** : `0.114 Hz`
### Minimum Sampling Frequency **f<sub>s</sub>** : `0.228 Hz`

</center>


