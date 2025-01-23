#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow

inputs:
  DT6106:
    doc: list of earthquake scenarios
    type: Directory
  DT6109:
    doc: topo-bathymetric grids
    type: Directory

outputs:
  DT6110:
    doc: Tsunami intensities
    type: Directory
    outputSource: SS6107/DT6110
  DT6111:
    doc: Ground deformation
    type: Directory
    outputSource: SS6107/DT6111

steps:
  SS6106:
    doc: SeisSol
    in:
      DT6106: DT6106
      DT6109: DT6109
    run:
      class: Operation
      inputs:
        DT6106: Directory
        DT6109: Directory
      outputs:
        dynamic rupture: Directory
    out:
    - dynamic rupture
  SS6112:
    doc: Source-to-wave filter
    in:
      dynamic rupture: SS6106/dynamic rupture
    run:
      class: Operation
      inputs:
        dynamic rupture: Directory
      outputs:
        dynamic deformation: Directory
    out:
    - dynamic deformation
  SS6107:
    doc: Tsunami-HySEA
    in:
      DT6106: DT6106
      DT6109: DT6109
      dynamic deformation: SS6112/dynamic deformation
    run:
      class: Operation
      inputs:
        DT6106: Directory
        DT6109: Directory
        dynamic deformation: Directory
      outputs:
        DT6110: Directory
        DT6111: Directory
        offshore time series: Directory
    out:
    - DT6110
    - DT6111
    - offshore time series
