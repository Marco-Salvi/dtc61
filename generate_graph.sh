curl -X POST https://view.commonwl.org/graph/png \
     -H "Content-Type: text/yaml" \
     --data-binary @mini-ST610106.cwl \
     --output graph.png
