libmakepkg_module = 'executable'

# whats android value
_system = host_machine.system()

message(
  _system)

sources = [
  'ccache.sh.in',
  'checksum.sh.in',
  'distcc.sh.in',
  'debugedit.sh.in',
  'gpg.sh.in',
  'gzip.sh.in',
  'pacman.sh.in',
  'sccache.sh.in',
  'strip.sh.in',
  'vcs.sh.in',
]

# enable after '_system'
# variable value is determined
if _system != "android" and _system != "windows"
  sources += [
    'fakeroot.sh.in',
    'sudo.sh.in',
  ]
endif

foreach src : sources
  output_dir = join_paths(
                 get_option('datadir'),
                'makepkg',
                libmakepkg_module)

  custom_target(
    libmakepkg_module + '_' + src.underscorify(),
    command : [ SCRIPT_EDITOR, '@INPUT@', '@OUTPUT@' ],
    input : src,
    output : '@BASENAME@',
    install : true,
    install_dir : output_dir)
endforeach
