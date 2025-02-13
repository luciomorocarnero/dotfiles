# This is a sample commands.py.  You can add your own commands here.
#
# Please refer to commands_full.py for all the default commands and a complete
# documentation.  Do NOT add them all here, or you may end up with defunct
# commands when upgrading ranger.

# A simple command for demonstration purposes follows.
# -----------------------------------------------------------------------------

from __future__ import absolute_import, division, print_function

# You can import any python module as needed.
import os
from typing import override

# You always need to import ranger.api.commands here to get the Command class:
from ranger.api.commands import Command
from ranger.gui.colorscheme import ColorScheme
from ranger.gui.color import *


# Any class that is a subclass of "Command" will be integrated into ranger as a
# command.  Try typing ":my_edit<ENTER>" in ranger!
class my_edit(Command):
    # The so-called doc-string of the class will be visible in the built-in
    # help that is accessible by typing "?c" inside ranger.
    """:my_edit <filename>

    A sample command for demonstration purposes that opens a file in an editor.
    """

    # The execute method is called when you run this command in ranger.
    def execute(self):
        # self.arg(1) is the first (space-separated) argument to the function.
        # This way you can write ":my_edit somefilename<ENTER>".
        if self.arg(1):
            # self.rest(1) contains self.arg(1) and everything that follows
            target_filename = self.rest(1)
        else:
            # self.fm is a ranger.core.filemanager.FileManager object and gives
            # you access to internals of ranger.
            # self.fm.thisfile is a ranger.container.file.File object and is a
            # reference to the currently selected file.
            target_filename = self.fm.thisfile.path

        # This is a generic function to print text in ranger.
        self.fm.notify("Let's edit the file " + target_filename + "!")

        # Using bad=True in fm.notify allows you to print error messages:
        if not os.path.exists(target_filename):
            self.fm.notify("The given file does not exist!", bad=True)
            return

        # This executes a function from ranger.core.acitons, a module with a
        # variety of subroutines that can help you construct commands.
        # Check out the source, or run "pydoc ranger.core.actions" for a list.
        self.fm.edit_file(target_filename)

    # The tab method is called when you press tab, and should return a list of
    # suggestions that the user will tab through.
    # tabnum is 1 for <TAB> and -1 for <S-TAB> by default
    def tab(self, tabnum):
        # This is a generic tab-completion function that iterates through the
        # content of the current directory.
        return self._tab_directory_content()


class Default(ColorScheme):
    def use(self, context):
        fg, bg, attr = default_colors

        if context.reset:
            return default_colors

        elif context.in_browser:
            if context.selected:
                fg = white
                attr = bold
            else:
                attr = normal
            if context.empty or context.error:
                fg = black
            if context.border:
                attr = normal
                fg = default
            if context.media:
                if context.image:
                    fg = red
                else:
                    fg = yellow
            if context.container:
                attr |= normal
                fg = green
            if context.directory:
                attr |= normal
                fg = magenta
            elif context.executable and not any(
                (context.media, context.container, context.fifo, context.socket)
            ):
                attr |= bold
                fg = red
            if context.socket:
                fg = black
            if context.fifo or context.device:
                fg = blue
                if context.device:
                    attr |= bold
            if context.link:
                fg = context.good and white or red
            if context.tag_marker and not context.selected:
                attr |= bold
                if fg in (red, white):
                    fg = black
                else:
                    fg = green
            if not context.selected and (context.cut or context.copied):
                fg = black
                attr |= bold
            if context.main_column:
                if context.selected:
                    attr |= normal
                if context.marked:
                    attr |= underline
                    fg = white
            if context.badinfo:
                if attr & reverse:
                    bg = red
                else:
                    fg = red

        elif context.in_titlebar:
            attr |= normal
            if context.hostname:
                attr |= normal
                fg = red
            elif context.directory:
                fg = red
            elif context.tab:
                if context.good:
                    bg = white
            elif context.link:
                fg = green

        elif context.in_statusbar:
            if context.permissions:
                if context.good:
                    fg = white
                elif context.bad:
                    fg = red
            if context.marked:
                attr |= bold | reverse
                fg = yellow
            if context.message:
                if context.bad:
                    attr |= bold
                    fg = red

        if context.text:
            if context.highlight:
                attr |= bold

        if context.in_taskview:
            if context.title:
                fg = red

            if context.selected:
                attr |= normal

        return fg, bg, attr


class opencwd(Command):
    def execute(self):
        self.fm.run("xdg-open .")


import os


class encrypt(Command):
    def execute(self):
        if not self.fm.thisfile.is_file:
            self.fm.notify(
                "Error: Selecciona un archivo o directorio válido.", bad=True
            )
            return
        os.system(f'gpgenc "{self.fm.thisfile.path}"')
        self.fm.notify(f"Encriptado completado: {self.fm.thisfile.path}")


class decrypt(Command):
    def execute(self):
        if not self.fm.thisfile.is_file:
            self.fm.notify("Error: Selecciona un archivo .gpg válido.", bad=True)
            return
        if not self.fm.thisfile.path.endswith(".gpg"):
            self.fm.notify("Error: El archivo debe tener extensión .gpg.", bad=True)
            return
        self.fm.run(f'gpgdec "{self.fm.thisfile.path}"')
        self.fm.notify(f"Desencriptado completado: {self.fm.thisfile.path}")
