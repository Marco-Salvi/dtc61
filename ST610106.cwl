#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow

inputs:
  DT6002: Directory
  DT6006: Directory
  DT6008: Directory
  DT6009: Directory

outputs:
  DT6010: 
    type: Directory
    outputSource: SS6106/DT6010
  DT6011: 
    type: Directory
    outputSource: SS6106/DT6011

steps:
#  doc: SeisSol
  SS6106:
    in:
      DT6002: DT6002
      DT6006: DT6006
      DT6008: DT6008
      DT6009: DT6009
    run:
      class: Operation
      inputs:
        DT6002: Directory
        DT6006: Directory
        DT6008: Directory
        DT6009: Directory
      outputs:
        DT6010: Directory
        DT6011: Directory
    out:
    - DT6010
    - DT6011

