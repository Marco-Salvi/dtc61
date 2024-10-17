#!/usr/bin/env cwl-runner

cwlVersion: v1.2
class: Workflow

inputs:
  DT6002: Directory
  DT6006: Directory
  DT6008: Directory
  DT6009: Directory

outputs:
  DT6010: Directory
  DT6011: Directory

steps:
  doc: SeisSol
  SS6106:
    in:
