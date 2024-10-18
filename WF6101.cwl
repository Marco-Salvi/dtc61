#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow

requirements:
  SubworkflowFeatureRequirement: {}

inputs:
  DT6001: Directory
  DT6002: Directory
  DT6003: Directory
  DT6004: Directory
  DT6005: Directory
  DT6009: Directory

outputs:
  DT6006:
    type: Directory
    outputSource: ST610105/DT6006
  DT6007:
    type: Directory
    outputSource: ST610105/DT6007
  DT6008:
    type: Directory
    outputSource: ST610110/DT6008
  DT6010:
    type: Directory
    outputSource: ST610106/DT6010
  DT6011:
    type: Directory
    outputSource: ST610106/DT6011
  DT6012:
    type: Directory
    outputSource: ST610108/DT6012
  DT6013:
    type: Directory
    outputSource: ST610109/DT6013

steps:
  ST610101:
    doc: SS6101
    in:
      DT6003: DT6003
      DT6004: DT6004
      DT6005: DT6005
    run:
      class: Operation
      inputs:
        DT6003: Directory
        DT6004: Directory
        DT6005: Directory
      outputs:
        DT6101: Directory
    out:
    - DT6101
  ST610102:
    doc: SS6102
    in:
      DT6001: DT6001
    run:
      class: Operation
      inputs:
        DT6001: Directory
      outputs:
        event_file: File
    out:
    - event_file
  ST610103:
    doc: SS6103
    in:
      DT6001: DT6001
    run:
      class: Operation
      inputs:
        DT6001: Directory
      outputs:
        sea_level_data: Directory
    out:
    - sea_level_data
  ST610104:
    doc: SS6104
    in:
      DT6001: DT6001
    run:
      class: Operation
      inputs:
        DT6001: Directory
      outputs:
        gnss_data: Directory
    out:
    - gnss_data
  ST610105:
    doc: SS6105
    in:
      DT6002: DT6002
      event_file: ST610102/event_file
      fault_model: ST610111/fault_model
      misfit_data: ST610107/misfit_output
    run:
      class: Operation
      inputs:
        DT6002: Directory
        event_file: File
        fault_model: Directory
        misfit_data: Directory
      outputs:
        DT6006: Directory
        DT6007: Directory
    out:
    - DT6006
    - DT6007
  ST610106:
    in:
      DT6002: DT6002
      DT6006: ST610105/DT6006
      DT6008: ST610110/DT6008
      DT6009: DT6009
    run: ST610106.cwl
    out:
    - DT6010
    - DT6011
  ST610107:
    doc: SS6113
    in:
      DT6010: ST610106/DT6010
      DT6011: ST610106/DT6011
      gnss_data: ST610104/gnss_data
      sea_level_data: ST610103/sea_level_data
    run:
      class: Operation
      inputs:
        DT6010: Directory
        DT6011: Directory
        gnss_data: Directory
        sea_level_data: Directory
      outputs:
        misfit_output: Directory
    out:
    - misfit_output
  ST610108:
    doc: SS6114
    in:
      DT6007: ST610105/DT6007
      DT6010: ST610106/DT6010
      misfit_output: ST610107/misfit_output
    run:
      class: Operation
      inputs:
        DT6007: Directory
        DT6010: Directory
        misfit_output: Directory
      outputs:
        DT6012: Directory
    out:
    - DT6012
  ST610109:
    in:
      DT6012: ST610108/DT6012
    run: ST610109.cwl
    out:
    - DT6013
  ST610110:
    doc: SS6117
    in:
      fault_model: ST610111/fault_model
      misfit_output: ST610107/misfit_output
    run:
      class: Operation
      inputs:
        fault_model: Directory
        misfit_output: Directory?
      outputs:
        DT6008: Directory
    out:
    - DT6008
  ST610111:
    doc: SS6118
    in:
      gnss_data: ST610104/gnss_data
    run:
      class: Operation
      inputs:
        gnss_data: Directory
      outputs:
        fault_model: Directory
    out:
    - fault_model
