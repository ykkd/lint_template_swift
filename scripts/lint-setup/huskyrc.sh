#!/bin/bash

node_path=$(dirname $(which node))
echo "export PATH=\"$node_path:\$PATH\"" >> ~/.huskyrc

npx_path=$(dirname $(which npx))
echo "export PATH=\"$npx_path:\$PATH\"" >> ~/.huskyrc