# emacs_d
startup configurations for emacs 

# How to install my configure

* step 1 
  create your .emacs.d directory into your home directory
  
  ```sh
      cd ${HOME}
      mkdir .emacs.d
  ```
  
* step 2 
  
  clone the code into  your ${HOME}/.emacs.d directory
  
  ```sh
      cd ${HOME}/.emacs.d/
      git init
      git remote add origin https://github.com/suzp1984/emacs_d.git
      git remote update
  ```
  
* step 3

    open your emacs, ignore the loading errors, edit ~/.emacs.d/install.el, then eval the buffer
    
    ```sh
        M-x eval-buffer
    ```
    
    reopen your emacs, debug if there are still has loading errors.
