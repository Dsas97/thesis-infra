- job_name: "edge-nodes"
  static_configs:
    - targets:
%{ for t in targets ~}
      - "${t}"
%{ endfor ~}
