#!/bin/bash 

enable_bright_cyan_text_color() {
  tput setaf 6 2>/dev/null
}

enable_bright_yellow_text_color() {
  tput setaf 3 2>/dev/null
}

enable_bright_red_text_color() {
  tput setaf 1 2>/dev/null
}

enable_normal_text_color() {
  tput sgr0 2>/dev/null
}

enable_bright_red_text_color() {
  tput setaf 9 2>/dev/null
}

