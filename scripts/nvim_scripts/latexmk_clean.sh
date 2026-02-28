#!/bin/bash
latexmk -pdf -interaction=nonstopmode "$1"
latexmk -c
