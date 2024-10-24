#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow

inputs:
  DT6002:
    type: Directory
  DT6006:
    type: Directory
  DT6008:
    type: Directory
  DT6009:
    type: Directory

outputs:
  DT6010:
    doc: Tsunami_intensity -> SS6108 oppure SS6107
    type: Directory
    outputSource: SS6107/DT6010
  DT6011:
    doc: può essere generato da -> SS6106 oppure SS6107 oppure SS6108
    type: Directory
    outputSource: SS6107/DT6011

steps:
  SS6106:
    doc: SeisSol
    in:
      DT6006: DT6006
      DT6009: DT6009
    run:
      class: Operation
      inputs:
        DT6006: Directory
        DT6009: Directory
      outputs:
        deformation: Directory
    out:
    - deformation
  SS6107:
    in:
      DT6006: DT6006
      DT6009: DT6009
    run:
      class: Operation
      inputs:
        DT6006: Directory
        DT6009: Directory
      outputs:
        DT6010: Directory
        DT6011: Directory
    out:
    - DT6010
    - DT6011
  SS6108:
    doc: Landslide-HySEA
    in:
      DT6008: DT6008
      DT6009: DT6009
    run:
      class: Operation
      inputs:
        DT6008: Directory
        DT6009: Directory
      outputs:
        DT6010: Directory
    out:
    - DT6010
  SS6109:
    doc: BingClaw
    in:
      DT6008: DT6008
      DT6009: DT6009
    run:
      class: Operation
      inputs:
        DT6008: Directory
        DT6009: Directory
      outputs:
        tbd: Directory
    out:
    - tbd
  SS6110:
    doc: SHALTOP
    in:
      DT6008: DT6008
      DT6009: DT6009
    run:
      class: Operation
      inputs:
        DT6008: Directory
        DT6009: Directory
      outputs:
        tbd_2: Directory
    out:
    - tbd_2
  SS6111:
    doc: InundationAI DT6010 può essere generato da -> SS6106 oppure SS6107 oppure
      SS6108
    in:
      DT6010: SS6107/DT6010
    run:
      class: Operation
      inputs:
        DT6010: Directory
      outputs:
        DT6010: Directory
    out:
    - DT6010
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
    out:
    - deformation
    - tbd
    - tbd_2
  SS6113:
    doc: Precomputed simulation
    in:
      DT6002: DT6002
    run:
      class: Operation
      inputs:
        DT6002: Directory
      outputs:
        DT6010: Directory
    out:
    - DT6010
