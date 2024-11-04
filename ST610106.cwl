#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow

inputs:
  DT6102:
    doc: NEAMTHM18
    type: Directory
  DT6106:
    type: Directory
  DT6108:
    type: Directory
  DT6109:
    type: Directory

outputs:
  DT6110:
    doc: Tsunami_intensity -> SS6108 oppure SS6107
    type: Directory
    outputSource: SS6107/DT6110
  DT6111:
    doc: può essere generato da -> SS6106 oppure SS6107 oppure SS6108
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
        deformation: Directory
    out:
    - deformation
  SS6107:
    in:
      DT6106: DT6106
      DT6109: DT6109
    run:
      class: Operation
      inputs:
        DT6106: Directory
        DT6109: Directory
      outputs:
        DT6110: Directory
        DT6111: Directory
    out:
    - DT6110
    - DT6111
  SS6108:
    doc: Landslide-HySEA
    in:
      DT6108: DT6108
      DT6109: DT6109
    run:
      class: Operation
      inputs:
        DT6108: Directory
        DT6109: Directory
      outputs:
        DT6110: Directory
    out:
    - DT6110
  SS6109:
    doc: BingClaw
    in:
      DT6108: DT6108
      DT6109: DT6109
    run:
      class: Operation
      inputs:
        DT6108: Directory
        DT6109: Directory
      outputs:
        tbd: Directory
    out:
    - tbd
  SS6110:
    doc: SHALTOP
    in:
      DT6108: DT6108
      DT6109: DT6109
    run:
      class: Operation
      inputs:
        DT6108: Directory
        DT6109: Directory
      outputs:
        tbd_2: Directory
    out:
    - tbd_2
  SS6111:
    doc: InundationAI DT6110 può essere generato da -> SS6106 oppure SS6107 oppure
      SS6108
    in:
      DT6110: SS6107/DT6110
    run:
      class: Operation
      inputs:
        DT6110: Directory
      outputs:
        DT6110: Directory
    out:
    - DT6110
  SS6112:
    doc: Source-to-wave filter
    in:
      deformation: SS6106/deformation
      tbd: SS6109/tbd
      tbd_2: SS6110/tbd_2
    run:
      class: Operation
      inputs:
        deformation: Directory
        tbd: Directory
        tbd_2: Directory
      outputs:
        deformation: Directory
        tbd: Directory
        tbd_2: Directory
    out:
    - deformation
    - tbd
    - tbd_2
  SS6113:
    doc: Precomputed simulation
    in:
      DT6102: DT6102
    run:
      class: Operation
      inputs:
        DT6102: Directory
      outputs:
        DT6110: Directory
    out:
    - DT6110
