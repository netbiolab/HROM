#!/bin/bash

emapper.py -i ${1} -m diamond --itype proteins -o ${1}.eggnog --cpu 20 --data_dir /dev/shm/eggnog_db 

