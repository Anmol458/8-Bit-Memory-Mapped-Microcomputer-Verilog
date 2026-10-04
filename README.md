# 8-Bit Memory-Mapped Microcomputer in Verilog

An 8-bit stored-program microcomputer implemented in Verilog HDL with memory-mapped I/O for peripheral interfacing. The design includes a program ROM, data RAM, input/output ports, an ALU-based datapath, processor registers, condition-code logic, and an FSM-based control unit.

## Overview

This project implements a small 8-bit microcomputer at RTL level using Verilog.

The processor uses an 8-bit data bus and an 8-bit address space. Program memory, data memory, and peripheral I/O are mapped into the same address space, allowing the processor to communicate with external inputs and outputs using normal memory access instructions.

The design was developed in Xilinx Vivado with an Artix-7 FPGA target.

## Features

- 8-bit stored-program computer
- 8-bit data bus
- 8-bit address bus
- Program ROM
- Data RAM
- Memory-mapped input/output
- 8-bit ALU
- A and B registers
- Program Counter (PC)
- Memory Address Register (MAR)
- Instruction Register (IR)
- Condition Code Register (CCR)
- Negative, Zero, Overflow, and Carry flags
- FSM-based control unit
- 16 input ports
- 16 output ports
- Verilog testbench for functional verification
- Xilinx Artix-7 target device: `xc7a35tcsg324-1`

## Architecture

The design is divided into a control unit, datapath, and memory subsystem.

```text
                         +----------------------+
                         |     Control Unit     |
                         |        FSM           |
                         +----------+-----------+
                                    |
                                    | Control Signals
                                    v
              +------------------------------------------+
              |                 Data Path                 |
              |                                          |
              |   +----+   +-----+   +----+   +-----+   |
              |   | PC |   | MAR |   | IR |   | CCR |   |
              |   +----+   +-----+   +----+   +-----+   |
              |                                          |
              |   +-----+   +-----+       +---------+   |
              |   |  A  |   |  B  | ----> |   ALU   |   |
              |   +-----+   +-----+       +---------+   |
              |                                          |
              |              8-bit System Bus            |
              +----------------------+-------------------+
                                     |
                                     v
                          +---------------------+
                          |     Main Memory     |
                          |                     |
                          |    Program ROM      |
                          |     Data RAM        |
                          |   Output Ports     |
                          |    Input Ports      |
                          +---------------------+
```

The top-level module is:

```text
computer_system_top
```

The main hierarchy is:

```text
computer_system_top
├── control_unit
├── data_path
└── main_memory
    ├── program_memory
    ├── data_memory
    ├── output_port
    ├── input_port
    └── system_bus
```

## Memory Map

The processor has an 8-bit address space from `0x00` to `0xFF`.

| Address Range | Function |
|---|---|
| `0x00 - 0x7F` | Program ROM |
| `0x80 - 0xDF` | Data RAM |
| `0xE0 - 0xEF` | Output ports |
| `0xF0 - 0xFF` | Input ports |

This provides 16 memory-mapped output ports and 16 memory-mapped input ports, with each port being 8 bits wide.

### Output Ports

| Address | Port |
|---|---|
| `0xE0` | Output Port 0 |
| `0xE1` | Output Port 1 |
| `0xE2` | Output Port 2 |
| `0xE3` | Output Port 3 |
| `...` | ... |
| `0xEF` | Output Port 15 |

### Input Ports

| Address | Port |
|---|---|
| `0xF0` | Input Port 0 |
| `0xF1` | Input Port 1 |
| `0xF2` | Input Port 2 |
| `0xF3` | Input Port 3 |
| `...` | ... |
| `0xFF` | Input Port 15 |

For example, a store operation to address `0xE0` writes to output port 0 rather than to normal RAM.

## Processor Datapath

The datapath contains the registers and ALU required to execute the instruction set.

The main registers are:

- Program Counter (PC)
- Memory Address Register (MAR)
- Instruction Register (IR)
- A register
- B register
- Condition Code Register (CCR)

The ALU operates on the A and B registers and supports arithmetic, logical, and shift operations.

## Control Unit

The control unit is implemented as a finite-state machine. It controls the sequence of operations required to fetch, decode, and execute instructions.

The control logic handles:

- Instruction fetch
- Instruction decode
- Operand fetch
- Register transfers
- ALU operations
- Memory reads
- Memory writes
- Branch operations
- Condition-code updates

## ALU Operations

The processor supports the following ALU operations:

- Addition
- Subtraction
- OR
- AND
- XOR
- NOT
- Left shift
- Right shift

The ALU also generates condition information used by the condition-code register.

## Condition Codes

The condition-code register contains four status flags:

| Flag | Meaning |
|---|---|
| `N` | Negative |
| `Z` | Zero |
| `V` | Overflow |
| `C` | Carry |

These flags are used by the control unit when executing conditional operations. The `BEQ` instruction uses the zero flag to determine whether a branch should be taken.

## Instruction Set

The implemented instruction set includes:

| Instruction | Opcode | Operation |
|---|---:|---|
| `LDA_IMM` | `0x86` | Load A with immediate data |
| `LDA_DIR` | `0x87` | Load A from direct address |
| `LDB_IMM` | `0x88` | Load B with immediate data |
| `LDB_DIR` | `0x89` | Load B from direct address |
| `STA_DIR` | `0x96` | Store A to direct address |
| `STB_DIR` | `0x97` | Store B to direct address |
| `ADD_AB` | `0x43` | A ← A + B |
| `SUB_AB` | `0x44` | A ← A − B |
| `OR_AB` | `0x45` | A ← A OR B |
| `AND_AB` | `0x46` | A ← A AND B |
| `XOR_AB` | `0x81` | A ← A XOR B |
| `NOT_A` | `0x82` | A ← NOT A |
| `LEFT_A` | `0x83` | A ← A << 1 |
| `RIGHT_A` | `0x84` | A ← A >> 1 |
| `BRA` | `0x85` | Unconditional branch |
| `BEQ` | `0x90` | Branch if zero flag is set |

## Program Memory

The program ROM is initialized directly in the Verilog source.

The stored program is used to exercise the processor datapath, ALU, memory interface, register operations, and branch logic. The program also writes results to the memory-mapped output ports, making the processor behavior observable during simulation.

The program exercises:

1. Immediate loads
2. Direct memory loads
3. Register-to-register operations
4. Addition
5. Subtraction
6. AND
7. OR
8. XOR
9. NOT
10. Left shift
11. Right shift
12. Store operations
13. Conditional branching
14. Unconditional branching
15. Memory-mapped output

## Verification

The testbench is located at:

```text
tb/COMPUTER_SYSTEM_DESIGN_TB.v
```

The testbench provides the clock and reset signals, initializes the processor inputs, allows the stored program to execute, and checks the values written to the memory-mapped output ports.

The expected output values are:

| Output Address | Expected Value |
|---|---:|
| `0xE0` | `0x08` |
| `0xE1` | `0x05` |
| `0xE2` | `0x01` |
| `0xE3` | `0x05` |
| `0xE4` | `0x06` |
| `0xE5` | `0xF9` |
| `0xE6` | `0xF2` |
| `0xE7` | `0xF9` |
| `0xE8` | `0x03` |
| `0xE9` | `0x08` |
| `0xEA` | `0xFF` |
| `0xEB` | `0x11` |

The testbench reports the individual output checks and a final pass/fail result.

## Running the Simulation

The design can be simulated using Xilinx Vivado.

1. Create a new RTL project in Vivado.
2. Select the target device:

```text
xc7a35tcsg324-1
```

3. Add the RTL source:

```text
rtl/COMPUTER_SYSTEM_DESIGN.v
```

4. Add the simulation source:

```text
tb/COMPUTER_SYSTEM_DESIGN_TB.v
```

5. Set the design top module to:

```text
computer_system_top
```

6. Set the simulation top module to:

```text
COMPUTER_SYSTEM_DESIGN_TB
```

7. Run Behavioral Simulation.

The simulation should execute the program stored in ROM and check the values written to the memory-mapped output ports.

## FPGA Target

The Vivado project used the following target device:

```text
Xilinx Artix-7
xc7a35tcsg324-1
```

The repository contains the RTL and verification files needed to review and simulate the design.

Board-specific pin constraints are not included because the supplied project files did not contain the corresponding XDC constraint file.
