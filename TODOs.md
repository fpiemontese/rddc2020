# TODO

1. Create IMSC repo ex novo, keeping the scripts and weights, allowing YOLOv5 to be a subtree within
   that repo
2. Make it so running `detect.py` or others on WSL does not break anything. Can be achieved by
   adding an additional function `is_wsl` or something of the sort, there is already `is_colab`,
   used in the function `check_imshow`