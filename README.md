# Coding Assignment 2 — Decode Stage
<!--
Replace every item in square brackets before submitting.
Keep this README focused on what the design does, how it is used, and how it was
verified.
-->
## Design Scope and Assumptions
- **In scope:** The purpose of this lab is to continue to the second stage of the MIPS pipeline - decode.
- **Out of scope:** The fetch stage has already been implemented. The remaining stages of the MIPS pipeline will be implemented in future labs.
- **Assumptions:** [Clock frequency, reset behavior, data width, memory model, or
other assumptions]
- **Limitations:** [Known limitations or simplified behaviors]
  
## Requirements
| Requirement | Description | Verification Method |
|---|---|---|
| Latch | Passes the data through on the clock cycle | [Test case, waveform, calculation, or
inspection] |
| Register File | Consists of 32 general purpose registers. If regwrite == 1, then write the "writedata" value into the "writereg" location. Else, read the data from "read reg1" and "read reg2" as their respective "read data" | [Test case, waveform, calculation, or
inspection] |
| Control | Follows the format images/controlTable.png | [Test case, waveform, calculation, or
inspection] |
| Sign Extend | Receives 16 bit immediate values and outputs 32 bits sign extended | [Test case, waveform, calculation, or
inspection] |
| Final ID Stage | Module with all 4 components | [Test case, waveform, calculation, or
inspection] |

## Architecture
### Timing or Behavioral Summary
Save diagrams in the repository's `images/` folder. Use relative paths so they
display on GitHub.
![Timing Diagram](images/[timing-diagram-filename].png)

## Implementation
### Source Code
| File | Description |
|---|---|
| [`decode.v`](https://github.com/isabellalaurenn/codingAssignment2-ID/blob/main/decode.v) | [Primary implementation module] |
| [`idExLatch.v`](https://github.com/isabellalaurenn/codingAssignment2-ID/blob/main/idExLatch.v) | [Supporting component] |
| [`control.v`](https://github.com/isabellalaurenn/codingAssignment2-ID/blob/main/control.v) | [Supporting component] |
| [`regFile.v`](https://github.com/isabellalaurenn/codingAssignment2-ID/blob/main/regFile.v) | [Supporting component] |
| [`signExt.v`](https://github.com/isabellalaurenn/codingAssignment2-ID/blob/main/signExt.v) | [Supporting component] |
| [`decodeTB.v`](https://github.com/isabellalaurenn/codingAssignment2-ID/blob/main/decodeTB.v) | [Verification testbench] |
| [`idExLatchTB.v`](https://github.com/isabellalaurenn/codingAssignment2-ID/blob/main/idExLatchTB.v) | [Verification testbench] |
| [`controlTB.v`](https://github.com/isabellalaurenn/codingAssignment2-ID/blob/main/controlTB.v) | [Verification testbench] |
| [`signExtTB.v`](https://github.com/isabellalaurenn/codingAssignment2-ID/blob/main/signExtTB.v) | [Verification testbench] |

### Implementation Notes
- [Explain one important design decision.]
- [Identify any parameterization, reusable module, or interface convention.]
- [Document any deliberate simplification made for this lab.]
  
## Verification
### Verification Strategy
The design is verified using **[simulation, formal checks, hardware testing, or
another method]**.
Verification covers:
- [Normal operating case]
- [Boundary or maximum-value case]
- [Reset or initialization case]
- [Invalid, stalled, or exceptional case, if applicable]
### Testbench and Waveform
Save screenshots and waveform images in the repository's `images/` folder.
![Testbench or waveform](images/[testbench-screenshot-filename].png)
The testbench source is available [*here*](LINK_TO_TESTBENCH_CODE).
### Results
| Test Case | Expected Result | Observed Result | Status |
|---|---|---|---|
| TC-01 — [Name] | [Expected behavior] | [Observed behavior] | Pass / Fail |
| TC-02 — [Name] | [Expected behavior] | [Observed behavior] | Pass / Fail |
| TC-03 — [Name] | [Expected behavior] | [Observed behavior] | Pass / Fail |

## Reproduction Instructions
### Tools and Versions
- **Simulator / synthesis tool:** [Name and version]
- **Language / standard:** [Verilog/SystemVerilog version]
- **Operating system:** [macOS, Windows, Linux, or other]
- **Additional dependencies:** [List any required tools or libraries]
### Build and Run
```bash
# Replace these commands with the commands required for this lab.
[compile-command]
[run-command]
```
Expected output:
```text
[Paste a short representative output or result here.]
```

## Repository Organization
```text
.
├── README.md
├── images/
│ ├── [timing-diagram-filename].png
│ └── [testbench-screenshot-filename].png
├── [source-files]
└── [testbench-files]
```
## Known Issues and Future Improvements
- [Document any known issue, unverified behavior, or technical debt.]
- [Describe a realistic improvement or extension.]
