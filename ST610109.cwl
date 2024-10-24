#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow

inputs:
  DT6012: Directory

outputs:
  DT6013:
    type: Directory
    outputSource: SS6116/DT6013

steps:
  SS6115:
    in:
      DT6012: DT6012
    run:
      class: Operation
      inputs:
        DT6012: Directory
      outputs:
        alert_levels: Directory
    out:
    - alert_levels
  SS6116:
    in:
      DT6012: DT6012
      alert_levels: SS6115/alert_levels
    run:
      class: Operation
      inputs:
        DT6012: Directory
        alert_levels: Directory
      outputs:
        DT6013: Directory
    out:
    - DT6013
