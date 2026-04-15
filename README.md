# TracePro automation with Python

This repository contains a small Python workflow used to automate several tasks in TracePro through Scheme macros and the COM interface.

The goal is to avoid repeating the same manual steps (geometry creation, source definition, ray tracing, basic analysis) and to build models incrementally from Python, while keeping the interaction close to how TracePro is normally used.

This is not meant to be a generic library, but a practical tool based on real use cases.

## General idea

The workflow uses Python to generate Scheme code fragments, write them to a temporary macro file, and execute that file in TracePro via COM.

The macro file acts as a small command buffer:

1. Scheme commands are appended step by step
2. The macro is executed through COM
3. The file can be cleared afterwards
4. The TracePro model stays open and can be updated incrementally

This makes it easy to extend a model (adding detectors, running analysis steps, etc.) without rebuilding everything from scratch.

## Structure

The code is organized into three main components:

- Element  
Generates Scheme fragments related to geometry creation and manipulation (blocks, lenses, transformations, etc.).

- Source  
Generates Scheme fragments for ray sources, surface sources, ray tracing and analysis.

- TP_app  
Handles macro file creation, execution through the COM interface, saving, and basic utilities.

Geometry and source classes only return text. Only TP_app actually sends commands to TracePro.

## Examples

Several examples are provided mainly as Jupyter notebooks, the examples show how to:

- create geometry programmatically
- define sources and detectors
- modify objects (translations, rotations)
- run ray traces
- generate and save irradiance maps

A low-level example using direct COM calls without is also included for reference.

## Notes and limitations

- When using surface sources, renaming the emitting surface after the source has been created breaks the internal TracePro reference. For this reason, surface names are not modified once a surface source is assigned.

- The project focuses on the functionality needed for the current work scope. Some parts could be extended further, but the emphasis has been kept on clarity and usability rather than on building a fully general framework.
