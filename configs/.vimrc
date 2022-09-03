runtime defaults.vim

set aw sr rnu nu hi=1000
set sw=2 ts=2 sts=2

ino {<CR> {<CR>}<C-o>O

nm <F5> :!clear && make CXXFLAGS="-Wall -Wextra -Wshadow -Wconversion -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC" %:r && gdb -ex run -ex bt -batch %:r<cr>
nm <F6> :!clear && make CXXFLAGS="-Wall -Wextra -Wshadow -Wconversion -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC" %:r && gdb -ex run -ex bt -batch %:r < test
nm <F7> :!clear && make CXXFLAGS="-Wall -Wextra -Wshadow -Wconversion" %:r && gdb -ex run -ex bt -batch %:r<cr>
nm <F8> :!clear && make CXXFLAGS="-Wall -Wextra -Wshadow -Wconversion" %:r && gdb -ex run -ex bt -batch %:r < test
