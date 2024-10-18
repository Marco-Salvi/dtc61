#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow

requirements:
  SubworkflowFeatureRequirement: {}

inputs:
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
    in:
      DT6003: DT6003
      DT6004: DT6004
      DT6005: DT6005
    run: ST610101.cwl
    out:
    - DT6101
  ST610102:
    in:
      DT6001: DT6001
    run: ST610102.cwl
    out:
    - event_file
  ST610103:
    in:
      DT6001: DT6001
    run: ST610103.cwl
    out:
    - sea_level_data
  ST610104:
    in:
      DT6001: DT6001
    run: ST610104.cwl
    out:
    - gnss_data
  ST610105:
    in:
      DT6002: DT6002
      event_file: ST610102/event_file
      fault_model: ST610111/fault_model
      misfit_data: ST610107/misfit_output
    run: ST610105.cwl
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
    in:
      DT6010: ST610106/DT6010
      DT6011: ST610106/DT6011
      gnss_data: ST610104/gnss_data
      sea_level_data: ST610103/sea_level_data
    run: ST610107.cwl
    out:
    - misfit_output
  ST610108:
    in:
      DT6007: ST610105/DT6007
      DT6010: ST610106/DT6010
      misfit_output: ST610107/misfit_output
    run: ST610108.cwl
    out:
    - DT6012
  ST610109:
    in:
      DT6012: ST610108/DT6012
    run: ST610109.cwl
    out:
    - DT6013
  ST610110:
    in:
      fault_model: ST610111/fault_model
      misfit_output: ST610107/misfit_output
    run: ST610110.cwl
    out:
    - DT6008
  ST610111:
    in:
      gnss_data: ST610104/gnss_data
    run: ST610111.cwl
    out:
    - fault_model
