#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow

inputs:
  DT6012: Directory

outputs:
  DT6013: 
    type: Directory
    outputSource: SS6115/DT6013

steps:
#  doc: TODO
  SS6115:
    in:
      DT6012: DT6012
    run:
      class: Operation
      inputs:
        DT6012: Directory
      outputs:
        DT6013: Directory
    out:
    - DT6013
