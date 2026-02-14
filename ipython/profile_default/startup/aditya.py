"""Custom line magic"""


import json
import subprocess
import glob

import numpy as np
import pandas as pd

from IPython.core.magic import Magics, magics_class, line_magic


def _read_file(fname):
    """The function to select a file using fzf and read its content."""
    with open(fname, "r") as file:
        return file.read()


def _read_json(fname):
    """The function to select a file using fzf and read its content."""
    with open(fname, "r") as file:
        return json.load(file)


def _select_and_read_file():
    """The function to select a file using fzf and read its content."""
    selected_file = (
        subprocess.check_output("ls | fzf", shell=True).decode("utf-8").strip()
    )
    if selected_file:
        return _read_file(selected_file)

def fast_read(files, num_cores=20):
    from multiprocessing.pool import ThreadPool

    with ThreadPool(num_cores) as pool:
        return pool.map(_read_file, files)

def fast_read_json(files, num_cores=20):
    from multiprocessing.pool import ThreadPool

    with ThreadPool(num_cores) as pool:
        return pool.map(_read_json, files)


@magics_class
class CustomMagics(Magics):
    def _read_file(self, var_name, fname=None):
        if not fname:
            # Use the select_and_read_file function to get the file content
            file_content = _select_and_read_file()
        else:
            file_content = _read_file(fname)

        # Store the file content in the specified variable
        self.shell.user_ns[var_name] = file_content

    def _var_and_file(self, args):
        args = args.split()
        if len(args) == 0:
            raise ValueError(f"Error: You must provide a variable name")
        elif len(args) > 2:
            raise ValueError(
                f"Error: You can provide upto two arguments - a variable name and optinally the filename to read."
            )
        elif len(args) == 1:
            var_name = args[0]
            fname = None
        else:
            var_name = args[0]
            fname = args[1]

        # Extract the variable name from the input line
        var_name = var_name.strip()

        # Ensure the variable name is valid
        if not var_name.isidentifier():
            raise ValueError(f"Error: '{var_name}' is not a valid variable name.")

        return var_name, fname

    @line_magic
    def read_file(self, args):
        """
        %read_file var_name {fname} - Select a file using fzf and store its content in the variable 'var_name'. If fname is provided, will read from fname instead
        """
        var_name, fname = self._var_and_file(args)
        self._read_file(var_name, fname)

    @line_magic
    def read_json(self, args):
        """
        %read_json var_name {fname} - Select a file using fzf and store its content in the variable 'var_name'. If fname is provided, will read from fname instead
        """
        var_name, fname = self._var_and_file(args)
        self._read_file(var_name, fname)
        self.shell.user_ns[var_name] = json.loads(self.shell.user_ns[var_name])

    @line_magic
    def read_soup(self, args):
        """
        %read_soup var_name {fname} - Select a file using fzf and store its content in the variable 'var_name'. If fname is provided, will read from fname instead
        """
        from bs4 import BeautifulSoup
        var_name, fname = self._var_and_file(args)
        self._read_file(var_name, fname)
        self.shell.user_ns[var_name] = BeautifulSoup(self.shell.user_ns[var_name])


# Register the magic command
get_ipython().register_magics(CustomMagics)
