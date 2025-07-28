#!/bin/bash
set -e
./clean-up.sh
./k3d-create.sh
./deploy.sh
./test.sh
