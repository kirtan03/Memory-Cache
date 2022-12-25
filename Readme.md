<a name="readme-top"></a>

# CSN-221 Course Project-2: Implementation of Configurable Cache

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#about-the-project">About The Project</a>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li>
          <a href="#eda-playground">EDA Playground</a>
          <ul>
            <li><a href="#login">Login</a></li>
            <li><a href="#code">Code</a></li>
            <li><a href="#simulator-setup">Simulator Setup</a></li>
            <li><a href="#run-code">Run Code</a></li>
          </ul>
        </li>
      </ul>
    </li>
    <li><a href="#contributors">Contributors</a></li>
  </ol>
</details>

***

<!-- ABOUT THE PROJECT -->
## About The Project


This is a simulation of a configurable cache in SystemVerilog. In this simulation, we take instructions as input. (Since EDA playground has file size limit of 1,00,000 characters, we have considered at most 10,000 instructions.) It has following format:

* Blank space followed by operation bit (1 for read and 2 for write)
* Memory address of 6 hex-digits.

The address tag is compared to the tag value in the cache and , the data is either found in the cache, identifying a hit, or in case of a miss, it's pulled from the memory. Thereafter, based on the type of operation, read or write takes place. Finally hit rate is calculated and displayed along with number of read/write hits.

This is [our](#contributors) submission for CSN-221 Course Project-1.

---

<!-- GETTING STARTED -->
## Getting Started

Since there is no satisfactory compiler for SystemVerilog, so this Project has had to be run on online SystemVerilog Simulators like [Aldec Riviera Pro 2022.04](https://www.aldec.com/en/products/functional_verification/riviera-pro), which we used to make this project.

To run this project follow these steps:

### EDA Playground

This is a web application that allows users to edit, simulate, synthesize, and share their HDL code written in languages like SystemVerilog.

#### Login
* Go to https://www.edaplayground.com/
* Login by clicking on `Login` in the top-right corner

#### Code
* Copy-paste the code in `testbench.sv` into `testbench.sv` on EDA-Playground
* Create a new file named `Assembler.sv` and paste the `Assembler.sv` code into it.
* From http://www.cs.toronto.edu/~reid/csc150/02f/a2/traces.html copy the instruction sets and paste them into `input.txt`. If `_Number_instructions` is greater than 10,000, take first 10,000 instructions only.
* Change `_Number_instructions` from line number 8 of `testbench.sv` and line number 1 from `Assembler.sv` accordingly.
* If chosen instruction set is `qsort` or `mm16`, then change `line[2]` to `line[1]` from line number 80 of `Assembler.sv`.
* Set up the configurations by making necessary changes in line number 4 to 8 in `testbench.sv`.
* By default, `input.txt` contains instruction set `lu` and configuration is set as 32 kB cache size, 8 ways and block size of 64 bytes.

#### Simulator setup
* Click on `Tools & Simulators` in left side-bar
* Select `Aldec Riviera Pro 2022.04` from the dropdown menu

#### Run code
* Save the playground and then click `Run`
* Output will be shown in `Log` tab at the bottom


---
<!-- Contributors -->
## Contributors
Contributors of this Group project:

<table>
  <tbody>
    <tr>
      <td align="center"><a href="https://github.com/i-love-chess"><img src="https://avatars.githubusercontent.com/u/101268569?v=4" width="100px;" alt="Ashutosh Kalidas Pise (21114073)"/><br /><sub><b>Ashutosh Kalidas Pise (21114073)</b></sub>
      </td>
      <td align="center"><a href="https://github.com/ashutoshkr129"><img src="https://avatars.githubusercontent.com/u/96130203?v=4" width="100px;" alt="Ashutosh Kumar (21114021)"/><br /><sub><b>Ashutosh Kumar (21114021)</b></sub>
      </td>
      <td align="center"><a href="https://github.com/kirtan03"><img src="https://avatars.githubusercontent.com/u/95969313?v=4" width="100px;" alt="KirtanKumar VijayKumar Patel (21114051)"/><br /><sub><b>KirtanKumar VijayKumar Patel (21114051)</b></sub>
      </td>
      <td align="center"><a href="https://github.com/Magnesium12"><img src="https://avatars.githubusercontent.com/u/99383854?v=4" width="100px;" alt="Mudit Gupta (21114061)"/><br /><sub><b>Mudit Gupta (21114061)</b></sub>
      </td>
      <td align="center"><a href="https://github.com/kej-r03"><img src="https://avatars.githubusercontent.com/u/99071926?v=4" width="100px;" alt="Rishi Kejriwal (21114081)"/><br /><sub><b>Rishi Kejriwal (21114081)</b></sub>
      </td>
      <td align="center"><a href="https://github.com/rohan-kalra904"><img src="https://avatars.githubusercontent.com/u/94923525?v=4" width="100px;" alt="Rohan Kalra (21114083)"/><br /><sub><b>Rohan Kalra (21114083)</b></sub>
      </td>
    </tr>
  </tbody>
  <tfoot>

  </tfoot>
</table>