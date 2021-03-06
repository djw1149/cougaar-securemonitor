#line 1 "tmp/all.te"
#
# Declarations for type attributes.
# 

# A type attribute can be used to identify a set of types with a similar
# property.  Each type can have any number of attributes, and each
# attribute can be associated with any number of types.  Attributes are
# explicitly declared here, and can then be associated with particular
# types in type declarations.  Attribute names can then be used throughout 
# the configuration to express the set of types that are associated with 
# the attribute.  Except for the MLS attributes, attributes have no implicit
# meaning to SELinux.  The meaning of all other attributes are completely 
# defined through their usage within the configuration, but should be 
# documented here as comments preceding the attribute declaration.  

#####################
# Attributes for MLS:
#

# The mlstrustedreader attribute identifies every domain that can
# override the normal MLS restrictions on reading (i.e. domains
# that can read up).  
attribute mlstrustedreader;

# The mlstrustedwriter attribute identifies every domain that can
# override the normal MLS restrictions on writing (i.e. domains
# that can write down).  
attribute mlstrustedwriter;

# The mlstrustedobject attribute identifies every type that can
# be accessed without normal MLS restrictions (i.e. processes can
# read or write objects with this type regardless of MLS level).  
# Examples:  /dev/null, descriptors created by login
attribute mlstrustedobject;


#########################
# Attributes for domains:
#

# The domain attribute identifies every type that can be 
# assigned to a process.  This attribute is used in TE rules 
# that should be applied to all domains, e.g. permitting 
# init to kill all processes or permitting all processes
# to read a particular file.
attribute domain;

# The privuser attribute identifies every domain that can 
# change its SELinux user identity.  This attribute is used 
# in the constraints configuration.  NOTE:  This attribute
# is not required for domains that merely change the Linux
# uid attributes, only for domains that must change the
# SELinux user identity.
attribute privuser;

# The privrole attribute identifies every domain that can 
# change its SELinux role.  This attribute is used in the 
# constraints configuration.
attribute privrole;

# The privowner attribute identifies every domain that can 
# assign a different SELinux user identity to a file.  This 
# attribute is used in the constraints configuration.
attribute privowner;

# The privlog attribute identifies every domain that can 
# communicate with syslogd through its Unix domain socket.
# This attribute is used in the TE rules in 
# domains/program/syslogd.te to grant such access.  
# XXX If you want to mandate the use of this attribute for all 
# XXX domains that can log, then you should also write corresponding 
# XXX assertions in assert.te to enforce this restriction.  Otherwise,
# XXX it is just an optional convenience for domain writers.
attribute privlog;

# The privmem attribute identifies every domain that can 
# access kernel memory devices.
# This attribute is used in the TE assertions to verify
# that such access is limited to domains that are explicitly
# tagged with this attribute.
attribute privmem;

# The privfd attribute identifies every domain that should have
# file handles inherited widely (IE sshd_t and getty_t).
attribute privfd;

# The privhome attribute identifies every domain that can create files under
# regular user home directories in the regular context (IE act on behalf of
# a user in writing regular files)
attribute privhome;

# The auth attribute identifies every domain that needs
# to perform user authentication and requires access to
# the corresponding authentication data.  
# XXX This attribute is no longer in use except in type declarations.
# XXX It was introduced for the original attempt to put /etc/shadow into
# XXX a separate type and to limit read access to certain domains.  
# XXX Doing so transparently to applications is problematic due to
# XXX the fact that both /etc/passwd and /etc/shadow are recreated
# XXX by the same processes and live in the same directory, so file type
# XXX transition rules cannot specify different default types.  Relocating
# XXX /etc/shadow to a separate subdirectory was tried, but required
# XXX modifications to a lot of applications even after changing
# XXX the pwdb shared library.
attribute auth;

# The admin attribute identifies every administrator domain.
# It is used in TE assertions when verifying that only administrator 
# domains have certain permissions.  
# This attribute is presently associated with sysadm_t and 
# certain administrator utility domains.  
# XXX The use of this attribute should be reviewed for consistency.
# XXX Might want to partition into several finer-grained attributes 
# XXX used in different assertions within assert.te.
attribute admin;

# The userdomain attribute identifies every user domain, presently
# user_t and sysadm_t.  It is used in TE rules that should be applied
# to all user domains.
attribute userdomain;

# attribute for all non-administrative devpts types
attribute userpty_type;

# The user_crond_domain attribute identifies every user_crond domain, presently
# user_crond_t and sysadm_crond_t.  It is used in TE rules that should be
# applied to all user domains.
attribute user_crond_domain;

# The unpriv_userdomain identifies non-administrative users (default user_t)
attribute unpriv_userdomain;

# This attribute is for the main user home directory for unpriv users
attribute user_home_dir_type;

# The gphdomain attribute identifies every gnome-pty-helper derived
# domain.  It is used in TE rules to permit inheritance and use of
# descriptors created by these domains.
attribute gphdomain;


############################
# Attributes for file types:
#

# The file_type attribute identifies all types assigned to files 
# in persistent filesystems.  It is used in TE rules to permit
# the association of all such file types with persistent filesystem
# types, and to permit certain domains to access all such types as 
# appropriate.
attribute file_type;

# The sysadmfile attribute identifies all types assigned to files 
# that should be completely accessible to administrators.  It is used
# in TE rules to grant such access for administrator domains.
attribute sysadmfile;

# The fs_type attribute identifies all types assigned to filesystems
# (not limited to persistent filesystems).
# It is used in TE rules to permit certain domains to mount
# any filesystem and to permit most domains to obtain the
# overall filesystem statistics.
attribute fs_type;

# The root_dir_type attribute identifies all types assigned to 
# root directories of filesystems (not limited to persistent
# filesystems).
# XXX This attribute was used to grant mountassociate permission,
# XXX but this permission is no longer defined.  We can likely
# XXX remove this attribute.
attribute root_dir_type;

# The exec_type attribute identifies all types assigned
# to entrypoint executables for domains.  This attribute is 
# used in TE rules and assertions that should be applied to all 
# such executables.
attribute exec_type;

# The tmpfile attribute identifies all types assigned to temporary 
# files.  This attribute is used in TE rules to grant certain 
# domains the ability to remove all such files (e.g. init, crond).
attribute tmpfile;

# The user_tmpfile attribute identifies all types associated with temporary
# files for unpriv_userdomain domains.
attribute user_tmpfile;

# for the user_xserver_tmp_t etc
attribute xserver_tmpfile;

# The tmpfsfile attribute identifies all types defined for tmpfs 
# type transitions. 
# It is used in TE rules to grant certain domains the ability to
# access all such files.
attribute tmpfsfile;

# The home_type attribute identifies all types assigned to home
# directories.  This attribute is used in TE rules to grant certain
# domains the ability to access all home directory types.
attribute home_type;

# This attribute is for the main user home directory /home/user, to
# distinguish it from sub-dirs.  Often you want a process to be able to
# read the user home directory but not read the regular directories under it.
attribute home_dir_type;

# The ttyfile attribute identifies all types assigned to ttys.
# It is used in TE rules to grant certain domains the ability to
# access all ttys.
attribute ttyfile;

# The ptyfile attribute identifies all types assigned to ptys.
# It is used in TE rules to grant certain domains the ability to
# access all ptys.
attribute ptyfile;

# The pidfile attribute identifies all types assigned to pid files.
# It is used in TE rules to grant certain domains the ability to
# access all such files.
attribute pidfile;


############################
# Attributes for network types:
#

# The socket_type attribute identifies all types assigned to 
# kernel-created sockets.  Ordinary sockets are assigned the 
# domain of the creating process.
# XXX This attribute is unused.  Remove?
attribute socket_type;

# Identifies all types assigned to port numbers to control binding.
attribute port_type;

# Identifies all types assigned to network interfaces to control
# operations on the interface (XXX obsolete, not supported via LSM) 
# and to control traffic sent or received on the interface.
attribute netif_type;

# Identifies all default types assigned to packets received 
# on network interfaces.  
attribute netmsg_type;

# Identifies all types assigned to network nodes/hosts to control
# traffic sent to or received from the node.
attribute node_type;

# Identifier for log files or directories that only exist for log files.
attribute logfile;

# Identifier for lock files (/var/lock/*) or directories that only exist for
# lock files.
attribute lockfile;



##############################
# Attributes for security policy types:
#

# The login_contexts attribute idenitifies the files used
# to define default contexts for login types (e.g., login, cron).
attribute login_contexts;

# Identifier for a domain used by "sendmail -t" (IE user_mail_t,
# sysadm_mail_t, etc)
attribute user_mail_domain;

# Identifies domains that can transition to system_mail_t
attribute privmail;

# Type for non-sysadm home directory
attribute user_home_type;

# For domains that are part of a mail server and need to read user files and
# fifos, and inherit file handles to enable user email to get to the mail
# spool
attribute mta_user_agent;

# For domains that are part of a mail server for delivering messages to the
# user
attribute mta_delivery_agent;

































#
# Macros for all admin domains.
#

#
# admin_domain(domain_prefix)
#
# Define derived types and rules for an administrator domain.
#
# The type declaration and role authorization for the domain must be
# provided separately.  Likewise, domain transitions into this domain
# must be specified separately.  If the every_domain() rules are desired,
# then these rules must also be specified separately.
#

#line 466

##############################
#
# Global macros for the type enforcement (TE) configuration.
#

#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
# Modified: Howard Holm (NSA), <hdholm@epoch.ncsc.mil>
#           System V IPC added
#
#################################
# 
# Macros for groups of classes and 
# groups of permissions.
#

#
# All directory and file classes
#


#
# All non-directory file classes.
#


#
# Non-device file classes.
#


#
# Device file classes.
#


#
# All socket classes.
#


#
# Datagram socket classes.
# 


#
# Stream socket classes.
#


#
# Unprivileged socket classes (exclude rawip, netlink, packet).
#



# 
# Permissions for getting file attributes.
#


# 
# Permissions for executing files.
#


# 
# Permissions for reading files and their attributes.
#


# 
# Permissions for reading and executing files.
#


# 
# Permissions for reading and writing files and their attributes.
#


# 
# Permissions for reading and appending to files.
#


#
# Permissions for linking, unlinking and renaming files.
# 


#
# Permissions for creating and using files.
# 


# 
# Permissions for reading directories and their attributes.
#


# 
# Permissions for reading and writing directories and their attributes.
#


# 
# Permissions for reading and adding names to directories.
#



#
# Permissions for creating and using directories.
# 


#
# Permissions to mount and unmount file systems.
#


#
# Permissions for using sockets.
# 


#
# Permissions for creating and using sockets.
# 


#
# Permissions for using stream sockets.
# 


#
# Permissions for creating and using stream sockets.
# 



#
# Permissions for sending all signals.
#


#
# Permissions for sending and receiving network packets.
#


#
# Permissions for using System V IPC
#







#################################
# 
# Macros for type transition rules and
# access vector rules.
#

#
# Simple combinations for reading and writing both
# directories and files.
# 
#line 644


#line 649


#line 654


#line 659


#line 664


#line 669


#line 674


#################################
#
# domain_trans(parent_domain, program_type, child_domain)
#
# Permissions for transitioning to a new domain.
#

#line 721


#################################
#
# domain_auto_trans(parent_domain, program_type, child_domain)
#
# Define a default domain transition and allow it.
#
#line 732


#line 737


#################################
#
# uses_shlib(domain)
#
# Permissions for using shared libraries.
#
#line 754


#line 764


#################################
#
# can_ptrace(domain, domain)
#
# Permissions for running ptrace (strace or gdb) on another domain
#
#line 774


#################################
#
# can_exec(domain, type)
#
# Permissions for executing programs with
# a specified type without changing domains.
#
#line 785


#################################
#
# can_exec_any(domain)
#
# Permissions for executing a variety
# of executable types.
#
#line 803



#################################
#
# file_type_trans(domain, dir_type, file_type)
#
# Permissions for transitioning to a new file type.
#

#line 830


#################################
#
# file_type_auto_trans(creator_domain, parent_directory_type, file_type, object_class)
#
# the object class will default to notdevfile_class_set if not specified as
# the fourth parameter
#
# Define a default file type transition and allow it.
#
#line 851


#################################
#
# can_network(domain)
#
# Permissions for accessing the network.
# See types/network.te for the network types.
# See net_contexts for security contexts for network entities.
#
#line 929


#################################
#
# can_unix_connect(client, server)
#
# Permissions for establishing a Unix stream connection.
#
#line 939


#################################
#
# can_unix_send(sender, receiver)
#
# Permissions for sending Unix datagrams.
#
#line 949


#################################
#
# can_tcp_connect(client, server)
#
# Permissions for establishing a TCP connection.
#
#line 962


#################################
#
# can_udp_send(sender, receiver)
#
# Permissions for sending/receiving UDP datagrams.
#
#line 973


#################################
#
# can_sysctl(domain)
#
# Permissions for modifying sysctl parameters.
#
#line 997



##################################
#
# can_create_pty(domain_prefix, attributes)
#
# Permissions for creating ptys.
#
#line 1026



##################################
#
# can_create_other_pty(domain_prefix,other_domain)
#
# Permissions for creating ptys for another domain.
#
#line 1050




################################################
#
# The following macros are an attempt to start
# partitioning every_domain into finer-grained subsets
# that can be used by individual domains.
#

#
# general_domain_access(domain)
#
# Grant permissions within the domain.
# This includes permissions to processes, /proc/PID files,
# file descriptors, pipes, Unix sockets, and System V IPC objects
# labeled with the domain.
#
#line 1094


#
# general_proc_read_access(domain)
#
# Grant read/search permissions to most of /proc, excluding
# the /proc/PID directories and the /proc/kmsg and /proc/kcore files.
# The general_domain_access macro grants access to the domain /proc/PID
# directories, but not to other domains.  Only permissions to stat
# are granted for /proc/kmsg and /proc/kcore, since these files are more
# sensitive.
# 
#line 1129


#
# base_file_read_access(domain)
#
# Grant read/search permissions to a few system file types.
#
#line 1153


#
# general_file_read_access(domain)
#
# Grant read/search permissions to many system file types.
#
#line 1292


#
# general_file_write_access(domain)
#
# Grant write permissions to a small set of system file types, e.g. 
# /dev/tty, /dev/null, etc.
#
# For shared directories like /tmp, each domain should have its own derived
# type (with a file_type_auto_trans rule) for files created in the shared
# directory.
#
#line 1313


#
# every_test_domain(domain)
#
# Grant permissions common to the test domains.
#
#line 1350


################################
#
# every_domain(domain)
#
# Grant permissions common to most domains.
#
# This macro replaces the rules formerly located in domains/every.te.
# An every_domain macro has been inserted into each domain .te file
# for each domain defined within that file.  If you want a new domain
# to inherit these rules, then you can likewise use this macro in
# your new domain .te file.  However, for least privilege purposes, you 
# may want to consider using macros or individual rules that only include 
# a subset of these permissions for your new domain.  This macro has already 
# been partitioned into a few subsets, with corresponding macros defined 
# above and used in defining this macro.  
#
#line 1377


#######################
# daemon_base_domain(domain_prefix, attribs)
#
# Define a daemon domain with a base set of type declarations
# and permissions that are common to most daemons.
# attribs is the list of attributes which must start with `,' if it is not empty
#
# Author:  Russell Coker <russell@coker.com.au>
#
#line 1413

#line 1429

#line 1435


# define a sub-domain, $1_t is the parent domain, $2 is the name
# of the sub-domain.
#
#line 1463



#line 1469


#line 1474


#line 1479


#line 1484


#######################
# application_domain(domain_prefix)
#
# Define a domain with a base set of type declarations
# and permissions that are common to simple applications.
#
# Author:  Russell Coker <russell@coker.com.au>
#
#line 1500


#line 1506


#line 1514



#
# Macros for all user login domains.
#

#
# user_domain(domain_prefix)
#
# Define derived types and rules for an ordinary user domain.
#
# The type declaration and role authorization for the domain must be
# provided separately.  Likewise, domain transitions into this domain
# must be specified separately.  
#

#line 1746



###########################################################################
#
# Domains for ordinary users.
#

#line 1854



#line 1861



#
# Macros for chkpwd domains.
#

#
# chkpwd_domain(domain_prefix)
#
# Define a derived domain for the *_chkpwd program when executed
# by a user domain.
#
# The type declaration for the executable type for this program is
# provided separately in domains/program/su.te. 
#

#line 1910

#line 1910

#line 1910

#line 1910


# macro for chroot environments
# Author Russell Coker

# chroot(initial_domain, basename, role, tty_device_type)
#line 2042

#
# Macros for clamscan
#
# Author:  Brian May <bam@snoopy.apana.org.au>
#

#
# clamscan_domain(domain_prefix)
#
# Define a derived domain for the clamscan program when executed
#
#line 2077


#line 2086

#
# Macros for crond domains.
#

#
# Authors:  Jonathan Crowley (MITRE) <jonathan@mitre.org>,
#	    Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser
#

#
# crond_domain(domain_prefix)
#
# Define a derived domain for cron jobs executed by crond on behalf 
# of a user domain.  These domains are separate from the top-level domain
# defined for the crond daemon and the domain defined for system cron jobs,
# which are specified in domains/program/crond.te.
#

#line 2157


# When system_crond_t domain executes a type $1 executable then transition to
# domain $2, allow $2 to interact with crond_t as well.
#line 2167

#
# Macros for crontab domains.
#

#
# Authors:  Jonathan Crowley (MITRE) <jonathan@mitre.org>
# Revised by Stephen Smalley <sds@epoch.ncsc.mil>
#

#
# crontab_domain(domain_prefix)
#
# Define a derived domain for the crontab program when executed by
# a user domain.  
#
# The type declaration for the executable type for this program is
# provided separately in domains/program/crontab.te. 
#

#line 2245

#
# Macro for fingerd
#
# Author:  Russell Coker <russell@coker.com.au>
#

#
# fingerd_macro(domain_prefix)
#
# allow fingerd to create a fingerlog file in the user home dir
#
#line 2260

#
# Macros for gpg and pgp
#
# Author:  Russell Coker <russell@coker.com.au>
#
# based on the work of:
# Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser
#

#
# gpg_domain(domain_prefix)
#
# Define a derived domain for the gpg/pgp program when executed by
# a user domain.
#
# The type declaration for the executable type for this program is
# provided separately in domains/program/gpg.te.
#
#line 2345

#
# Macros for gnome-pty-helper domains.
#

#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser 
#

#
# gph_domain(domain_prefix)
#
# Define a derived domain for the gnome-pty-helper program when
# executed by a user domain.
#
# The type declaration for the executable type for this program is
# provided separately in domains/program/gnome-pty-helper.te. 
#
# The *_gph_t domains are for the gnome_pty_helper program.
# This program is executed by gnome-terminal to handle
# updates to utmp and wtmp.  In this regard, it is similar
# to utempter.  However, unlike utempter, gnome-pty-helper
# also creates the pty file for the terminal program.
# There is one *_gph_t domain for each user domain.  
#

#line 2417


#
# Macros for irc domains.
#

#
# Author:  Russell Coker <russell@coker.com.au>
#

#
# irc_domain(domain_prefix)
#
# Define a derived domain for the irc program when executed
# by a user domain.
#
# The type declaration for the executable type for this program is
# provided separately in domains/program/irc.te. 
#

#line 2507

#line 2507

#line 2507

#line 2507

#line 2507

#
# Macros for lpr domains.
#

#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser 
#

#
# lpr_domain(domain_prefix)
#
# Define a derived domain for the lpr/lpq/lprm programs when executed
# by a user domain.
#
# The type declaration for the executable type for this program is
# provided separately in domains/program/lpr.te. 
#

#line 2596

#
# Macros for mount
#
# Author:  Brian May <bam@snoopy.apana.org.au>
# Extended by Russell Coker <russell@coker.com.au>
#

#
# mount_domain(domain_prefix,dst_domain_prefix)
#
# Define a derived domain for the mount program for anyone.
#
#line 2638

#
# Macros for MTA domains.
#

#
# Author:   Russell Coker <russell@coker.com.au>
# Based on the work of: Stephen Smalley <sds@epoch.ncsc.mil>
#                       Timothy Fraser 
#

#
# mail_domain(domain_prefix)
#
# Define a derived domain for the sendmail program when executed by
# a user domain to send outgoing mail.  These domains are separate and
# independent of the domain used for the sendmail daemon process.
#
# The type declaration for the executable type for this program is
# provided separately in domains/program/mta.te. 
#

#line 2729

#
# Macros for netscape/mozilla (or other browser) domains.
#

#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser 
#

#
# netscape_domain(domain_prefix)
#
# Define a derived domain for the netscape/mozilla program when executed by
# a user domain.  
#
# The type declaration for the executable type for this program is
# provided separately in domains/program/netscape.te. 
#
#line 2766

# $1 is the source domain (or domains), $2 is the source role (or roles) and $3
# is the base name for the domain to run.  $1 is normally sysadm_t, and $2 is
# normally sysadm_r.  $4 is the type of program to run and $5 is the domain to
# transition to.
# sample usage:
# run_program(sysadm_t, sysadm_r, init, etc_t, initrc_t)
#
# if you have several users who run the same run_init type program for
# different purposes (think of a run_db program used by several database
# administrators to start several databases) then you can list all the source
# domains in $1, all the source roles in $2, but you may not want to list all
# types of programs to run in $4 and target domains in $5 (as that may permit
# entering a domain from the wrong type).  In such a situation just specify
# one value for each of $4 and $5 and have some rules such as the following:
# domain_trans(run_whatever_t, whatever_exec_t, whatever_t)

#line 2809

#
# Macros for screen domains.
#

#
# Author: Russell Coker <russell@coker.com.au>
# Based on the work of Stephen Smalley <sds@epoch.ncsc.mil>
# and Timothy Fraser
#

#
# screen_domain(domain_prefix)
#
# Define a derived domain for the screen program when executed
# by a user domain.
#
# The type declaration for the executable type for this program is
# provided separately in domains/program/screen.te. 
#

#line 2899

#line 2899

#line 2899

#line 2899

#line 2899

#
# Macros for sendmail domains.
#

#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser 
#           Russell Coker <russell@coker.com.au>
#

#
# sendmail_user_domain(domain_prefix)
#
# Define a derived domain for the sendmail program when executed by
# a user domain to send outgoing mail.  These domains are separate and
# independent of the domain used for the sendmail daemon process.
#

#line 2939


#
# Macros for ssh domains.
#

#
# Author:  Stephen Smalley <sds@epoch.ncsc.mil>
#

# 
# ssh_domain(domain_prefix)
#
# Define a derived domain for the ssh program when executed
# by a user domain.
#
# The type declaration for the executable type for this program is
# provided separately in domains/program/ssh.te. 
#

#line 3099

#line 3099

#line 3099

#line 3099

#
# Macros for su domains.
#

#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser
#

#
# su_domain(domain_prefix)
#
# Define a derived domain for the su program when executed
# by a user domain.
#
# The type declaration for the executable type for this program is
# provided separately in domains/program/su.te. 
#


#line 3182

#line 3182

#line 3182

#line 3182

#
# Macros for xauth domains.
#

#
# Author:  Russell Coker <russell@coker.com.au>
#

#
# xauth_domain(domain_prefix)
#
# Define a derived domain for the xauth program when executed
# by a user domain.
#
# The type declaration for the executable type for this program is
# provided separately in domains/program/xauth.te. 
#

#line 3280

#line 3280

#line 3280

#line 3280

#
# Macros for X client programs ($2 etc)
#

#
# Author: Russell Coker <russell@coker.com.au>
# Based on the work of Stephen Smalley <sds@epoch.ncsc.mil>
# and Timothy Fraser 
#

#
# x_client_domain(domain_prefix)
#
# Define a derived domain for an X program when executed by
# a user domain.  
#
# The type declaration for the executable type for this program ($2_exec_t)
# must be provided separately!
#
# The first parameter is the base name for the domain/role (EG user or sysadm)
# The second parameter is the program name (EG $2)
# The third parameter is the attributes for the domain (if any)
#
#line 3419
#
# Macros for X server domains.
#

#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser
#

#################################
#
# xserver_domain(domain_prefix)
#
# Define a derived domain for the X server when executed
# by a user domain (e.g. via startx).  See the xdm_t domain
# in domains/program/xdm.te if using an X Display Manager.
#
# The type declarations for the executable type for this program 
# and the log type are provided separately in domains/program/xserver.te. 
#
# FIXME!  The X server requires far too many privileges.
#

#line 3580

#line 3580

#line 3580

#line 3580

#line 3580


#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
#

############################################
#
# Device types
#

#
# device_t is the type of /dev.
#
type device_t, file_type;

#
# null_device_t is the type of /dev/null.
#
type null_device_t, file_type, mlstrustedobject;

#
# zero_device_t is the type of /dev/zero.
#
type zero_device_t, file_type, mlstrustedobject;

#
# console_device_t is the type of /dev/console.
#
type console_device_t, file_type;

#
# memory_device_t is the type of /dev/kmem,
# /dev/mem, and /dev/port.
#
type memory_device_t, file_type;

#
# random_device_t is the type of /dev/urandom
# and /dev/random.
#
type random_device_t, file_type;

#
# devtty_t is the type of /dev/tty.
#
type devtty_t, file_type, mlstrustedobject;

#
# tty_device_t is the type of /dev/*tty*
#
type tty_device_t, file_type;

#
# fixed_disk_device_t is the type of 
# /dev/hd* and /dev/sd*.
#
type fixed_disk_device_t, file_type;

#
# removable_device_t is the type of
# /dev/scd* and /dev/fd*.
#
type removable_device_t, file_type;

#
# clock_device_t is the type of
# /dev/rtc.
#
type clock_device_t, file_type;

#
# tun_tap_device_t is the type of /dev/net/tun/* and /dev/net/tap/*
#
type tun_tap_device_t, file_type;

#
# misc_device_t is the type of miscellaneous devices.
# XXX:  FIXME!  Appropriate access to these devices need to be identified.
#
type misc_device_t, file_type;

#
# psaux_t is the type of the /dev/psaux mouse device.
# This type is deprecated and will be removed.
#
type psaux_t, file_type;

#
# A more general type for mouse devices.
#
type mouse_device_t, file_type;

#
# Not sure what these devices are for, but X wants access to them.
#
type agp_device_t, file_type;
type dri_device_t, file_type;

# Type for sound devices.
type sound_device_t, file_type;

# Type for /dev/ppp.
type ppp_device_t, file_type;

# Type for frame buffer /dev/fb/*
type framebuf_device_t, file_type;

# Type for /dev/.devfsd
type devfs_control_t, file_type;

# Type for /dev/cpu/mtrr
type mtrr_device_t, file_type;


# Type for /dev/apm_bios
type apm_bios_t, file_type;

# Type for v4l
type v4l_device_t, file_type;
#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
#

############################################
#
# Devpts types
#

#
# ptmx_t is the type for /dev/ptmx.
#
type ptmx_t, file_type, sysadmfile;

#
# devpts_t is the type of the devpts file system and 
# the type of the root directory of the file system.
#
type devpts_t, fs_type, root_dir_type;


#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
#

#######################################
#
# General file-related types
#

#
# unlabeled_t is the type of unlabeled objects.
# Eventually, once all objects are labeled and 
# controlled by the security policy, unlabeled_t 
# will not be used.
#
type unlabeled_t, fs_type, file_type, root_dir_type, sysadmfile;

#
# fs_t is the default type of an unlabeled
# file system.  When an unlabeled file system is
# mounted read-write, the file system is labeled
# with this type.  Except for the root file system,
# other types may be specified using the fs_contexts
# or fs_contexts.mls file.
#
type fs_t, fs_type;

#
# file_t is the default type of an unlabeled
# file.  When an unlabeled file system is mounted
# read-write, all files in the file system are labeled
# with this type.   Except for the root file system,
# other types may be specified using the fs_contexts
# or fs_contexts.mls file.
#
type file_t, file_type, root_dir_type, sysadmfile;

#
# root_t is the type for the root directory.
#
type root_t, file_type, sysadmfile;

#
# home_root_t is the type for the directory where user home directories
# are created
#
type home_root_t, file_type, sysadmfile;

#
# lost_found_t is the type for the lost+found directories.
#
type lost_found_t, file_type, sysadmfile;

#
# boot_t is the type for files in /boot,
# including the kernel.
#
type boot_t, file_type, root_dir_type, sysadmfile;
# system_map_t is for the system.map files in /boot
type system_map_t, file_type, sysadmfile;

#
# boot_runtime_t is the type for /boot/kernel.h,
# which is automatically generated at boot time.
# only for red hat
type boot_runtime_t, file_type, sysadmfile;

#
# tmp_t is the type of /tmp and /var/tmp.
#
type tmp_t, file_type, sysadmfile, tmpfile;

#
# etc_t is the type of the system etc directories.
#
type etc_t, file_type, sysadmfile;
#
# shadow_t is the type of the /etc/shadow file
#
type shadow_t, file_type;
allow auth shadow_t:file { getattr read };

#
# ld_so_cache_t is the type of /etc/ld.so.cache.
#
type ld_so_cache_t, file_type, sysadmfile;

#
# etc_runtime_t is the type of various
# files in /etc that are automatically
# generated during initialization.
#
type etc_runtime_t, file_type, sysadmfile;

#
# etc_aliases_t is the type of the aliases database.
# etc_mail_t is the type of /etc/mail.
# sendmail needs write access to these files.
#
type etc_aliases_t, file_type, sysadmfile;
type etc_mail_t, file_type, sysadmfile;

# resolv_conf_t is the type of the /etc/resolv.conf file.
# pump needs write access to this file.
type resolv_conf_t, file_type, sysadmfile;

#
# lib_t is the type of files in the system lib directories.
#
type lib_t, file_type, sysadmfile;

#
# shlib_t is the type of shared objects in the system lib
# directories.
#
type shlib_t, file_type, sysadmfile;

#
# ld_so_t is the type of the system dynamic loaders.
#
type ld_so_t, file_type, sysadmfile;

#
# bin_t is the type of files in the system bin directories.
#
type bin_t, file_type, sysadmfile;

#
# ls_exec_t is the type of the ls program.
#
type ls_exec_t, file_type, exec_type, sysadmfile;

#
# shell_exec_t is the type of user shells such as /bin/bash.
#
type shell_exec_t, file_type, exec_type, sysadmfile;

#
# sbin_t is the type of files in the system sbin directories.
#
type sbin_t, file_type, sysadmfile;

#
# usr_t is the type for /usr.
#
type usr_t, file_type, root_dir_type, sysadmfile;

#
# src_t is the type of files in the system src directories.
#
type src_t, file_type, sysadmfile;

#
# var_t is the type for /var.
#
type var_t, file_type, root_dir_type, sysadmfile;

#
# Types for subdirectories of /var.
#
type var_run_t, file_type, sysadmfile;
type var_log_t, file_type, sysadmfile, logfile;
type faillog_t, file_type, sysadmfile, logfile;
type var_lock_t, file_type, sysadmfile, lockfile;
type var_lib_t, file_type, sysadmfile;
# for /var/{spool,lib}/texmf index files
type tetex_data_t, file_type, sysadmfile, tmpfile;
type var_spool_t, file_type, sysadmfile;
type var_yp_t, file_type, sysadmfile;

# Type for /var/log/sa.
type var_log_sa_t, file_type, sysadmfile, logfile;

# Type for /var/log/ksyms.
type var_log_ksyms_t, file_type, sysadmfile, logfile;

# Type for /var/log/lastlog.
type lastlog_t, file_type, sysadmfile, logfile;

# Type for /var/lib/nfs.
type var_lib_nfs_t, file_type, sysadmfile;

#
# wtmp_t is the type of /var/log/wtmp.
#
type wtmp_t, file_type, sysadmfile, logfile;

#
# catman_t is the type for /var/catman.
#
type catman_t, file_type, sysadmfile, tmpfile;

#
# at_spool_t is the type for /var/spool/at.
#
type at_spool_t, file_type, sysadmfile;

#
# cron_spool_t is the type for /var/spool/cron.
#
type cron_spool_t, file_type, sysadmfile;

#
# print_spool_t is the type for /var/spool/lpd and /var/spool/cups.
#
type print_spool_t, file_type, sysadmfile;

#
# mail_spool_t is the type for /var/spool/mail.
#
type mail_spool_t, file_type, sysadmfile;

#
# mqueue_spool_t is the type for /var/spool/mqueue.
#
type mqueue_spool_t, file_type, sysadmfile;

#
# man_t is the type for the man directories.
#
type man_t, file_type, sysadmfile;

#
# readable_t is a general type for
# files that are readable by all domains.
#
type readable_t, file_type, sysadmfile;

# 
# Base type for the tests directory.
# 
type test_file_t, file_type, sysadmfile;

#
# poly_t is the type for the polyinstantiated directories.
#
type poly_t, file_type, sysadmfile;

#
# swapfile_t is for swap files
#
type swapfile_t, file_type, sysadmfile;

#
# locale_t is the type for system localization
# 
type locale_t, file_type;

#
# Allow each file type to be associated with 
# the default file system type.
#
allow file_type fs_t:filesystem associate;

# Allow the pty to be associated with the file system.
allow devpts_t devpts_t:filesystem associate;

type tmpfs_t, file_type, sysadmfile, fs_type, root_dir_type;
allow { tmpfs_t tmp_t } tmpfs_t:filesystem associate;

type usbdevfs_t, fs_type, root_dir_type, sysadmfile;
allow usbdevfs_t usbdevfs_t:filesystem associate;
type usbdevfs_device_t, file_type, sysadmfile;
allow usbdevfs_device_t usbdevfs_t:filesystem associate;

type sysfs_t alias driverfs_t, fs_type, root_dir_type, sysadmfile;
allow sysfs_t sysfs_t:filesystem associate;

type iso9660_t, fs_type, root_dir_type, sysadmfile;
allow iso9660_t iso9660_t:filesystem associate;

type dosfs_t, fs_type, root_dir_type, sysadmfile;
allow dosfs_t dosfs_t:filesystem associate;
#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
#

# Modified by Reino Wallin <reino@oribium.com>
# Multi NIC, and IPSEC features

# Modified by Russell Coker
# Move port types to their respective domains, add ifdefs, other cleanups.

############################################
#
# Network types
#

# 
# any_socket_t is the default destination
# socket type for UDP traffic.  Unless a 
# destination socket type is explicitly specified
# using sendto_secure/sendmsg_secure, this type
# is used for the udp_socket sendto permission check.
#
type any_socket_t, socket_type;
role system_r types any_socket_t;

#
# igmp_packet_t is the type of kernel-generated IGMP packets.
# icmp_socket_t is the type of the kernel socket used to send ICMP messages.
# tcp_socket_t is the type of the kernel socket used to send TCP resets.
# scmp_packet_t is the type for SCMP packets used by the SELOPT packet labeling.
#
type igmp_packet_t;
role system_r types igmp_packet_t;
type icmp_socket_t, socket_type;
role system_r types icmp_socket_t;
type tcp_socket_t, socket_type;
role system_r types tcp_socket_t;
type scmp_packet_t;
role system_r types scmp_packet_t;

#
# port_t is the default type of INET port numbers.
# The *_port_t types are used for specific port
# numbers in net_contexts or net_contexts.mls.
#
type port_t, port_type;

#
# netif_t is the default type of network interfaces.
# The netif_*_t types are used for specific network
# interfaces in net_contexts or net_contexts.mls.
#
type netif_t, netif_type;
type netif_eth0_t, netif_type;
type netif_eth1_t, netif_type;
type netif_eth2_t, netif_type;
type netif_lo_t, netif_type;
type netif_ippp0_t, netif_type;

type netif_ipsec0_t, netif_type;
type netif_ipsec1_t, netif_type;
type netif_ipsec2_t, netif_type;

#
# netmsg_t is the default type of unlabeled received messages.
# The netmsg_*_t types are used for specific network
# interfaces in net_contexts or net_contexts.mls.
#
type netmsg_t, netmsg_type;
type netmsg_eth0_t, netmsg_type;
type netmsg_eth1_t, netmsg_type;
type netmsg_eth2_t, netmsg_type;
type netmsg_lo_t, netmsg_type;
type netmsg_ippp0_t, netmsg_type;

type netmsg_ipsec0_t, netmsg_type;
type netmsg_ipsec1_t, netmsg_type;
type netmsg_ipsec2_t, netmsg_type;

#
# node_t is the default type of network nodes.
# The node_*_t types are used for specific network
# nodes in net_contexts or net_contexts.mls.
#
type node_t, node_type;
type node_lo_t, node_type;
type node_internal_t, node_type;

#
# Permissions for the kernel-generated IGMP packets.
#
allow igmp_packet_t netif_type:netif { rawip_send rawip_recv };
allow igmp_packet_t node_type:node { rawip_send rawip_recv };

#
# Permissions for the kernel ICMP socket.
#
allow icmp_socket_t netif_type:netif { rawip_send rawip_recv };
allow icmp_socket_t node_type:node { rawip_send rawip_recv };
allow icmp_socket_t netmsg_type:rawip_socket recvfrom;

#
# Permissions for the kernel TCP reset socket.
#
allow tcp_socket_t netif_type:netif { tcp_send tcp_recv };
allow tcp_socket_t netmsg_type:tcp_socket recvfrom;
allow tcp_socket_t node_type:node { tcp_send tcp_recv };

#
# Allow network messages to be received.
#
allow netmsg_t node_t:node { tcp_recv udp_recv rawip_recv };
allow netmsg_eth0_t node_t:node { tcp_recv udp_recv rawip_recv };
allow netmsg_eth0_t netif_eth0_t:netif { tcp_recv udp_recv rawip_recv };
allow netmsg_eth1_t node_t:node { tcp_recv udp_recv rawip_recv };
allow netmsg_eth1_t netif_eth1_t:netif { tcp_recv udp_recv rawip_recv };
allow netmsg_eth2_t node_t:node { tcp_recv udp_recv rawip_recv };
allow netmsg_eth2_t netif_eth2_t:netif { tcp_recv udp_recv rawip_recv };
allow netmsg_lo_t node_lo_t:node { tcp_recv udp_recv rawip_recv };
allow netmsg_lo_t node_t:node { tcp_recv udp_recv rawip_recv };
allow netmsg_lo_t netif_lo_t:netif { tcp_recv udp_recv rawip_recv };
allow netmsg_ippp0_t node_t:node { tcp_recv udp_recv rawip_recv };
allow netmsg_ippp0_t netif_ippp0_t:netif { tcp_recv udp_recv rawip_recv };
allow netmsg_ipsec0_t node_t:node { tcp_recv udp_recv rawip_recv };
allow netmsg_ipsec0_t netif_ipsec0_t:node { tcp_recv udp_recv rawip_recv };
allow netmsg_ipsec1_t node_t:node { tcp_recv udp_recv rawip_recv };
allow netmsg_ipsec1_t netif_ipsec1_t:netif { tcp_recv udp_recv rawip_recv };
allow netmsg_ipsec2_t node_t:node { tcp_recv udp_recv rawip_recv };
allow netmsg_ipsec2_t netif_ipsec2_t:netif { tcp_recv udp_recv rawip_recv };

#
# Allow ICMP echo requests to be sent and received, and echo replies to 
# be received (when packets are labeled)
#
#line 4131

#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
#

#############################################
#
# NFS types
#

#
# nfs_t is the default type for NFS file systems 
# and their files.  
# The nfs_*_t types are used for specific NFS
# servers in net_contexts or net_contexts.mls.
#
type nfs_t, fs_type, root_dir_type;

#
# Allow NFS files to be associated with an NFS file system.
#
allow nfs_t nfs_t:filesystem associate;
#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
#

############################################
#
# Procfs types
#

#
# proc_t is the type of /proc.
# proc_kmsg_t is the type of /proc/kmsg.
# proc_kcore_t is the type of /proc/kcore.
#
type proc_t, fs_type, root_dir_type;
type proc_kmsg_t;
type proc_kcore_t;

#
# sysctl_t is the type of /proc/sys.
# sysctl_fs_t is the type of /proc/sys/fs.
# sysctl_kernel_t is the type of /proc/sys/kernel.
# sysctl_modprobe_t is the type of /proc/sys/kernel/modprobe.
# sysctl_net_t is the type of /proc/sys/net.
# sysctl_net_unix_t is the type of /proc/sys/net/unix.
# sysctl_vm_t is the type of /proc/sys/vm.
# sysctl_dev_t is the type of /proc/sys/dev.
#
# These types are applied to both the entries in
# /proc/sys and the corresponding sysctl parameters.
#
type sysctl_t;
type sysctl_fs_t;
type sysctl_kernel_t;
type sysctl_modprobe_t;
type sysctl_net_t;
type sysctl_net_unix_t;
type sysctl_vm_t;
type sysctl_dev_t;


#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
#

############################################
#
# Security types
#

# 
# security_t is the target type when checking
# most of the permissions in the security class.
# The two exceptions are sid_to_context and load_policy.
# The sid_to_context permission uses the type attribute
# of the SID parameter, and the load_policy permission
# uses the type of the policy file.
#
type security_t;

#
# policy_config_t is the type of /ss_policy,
# the security server policy configuration.
#
type policy_config_t, file_type;

#
# policy_src_t is the type of the policy source
# files.
#
type policy_src_t, file_type;

#
# default_context_t is the type applied to 
# /etc/security/default_context
#
type default_context_t, file_type, sysadmfile, login_contexts;

#
# file_labels_t is the type of the persistent
# label mapping stored in each file system.
# The mapping files are in the ...security
# subdirectory at the root of each file system.
#
type file_labels_t, file_type, sysadmfile;

#
# no_access_t is the type for objects that should
# only be accessed administratively. 
#
type no_access_t, file_type, sysadmfile;


#DESC Admin - Domains for administrators.
#
#################################

# sysadm_t is the system administrator domain.
type sysadm_t, domain, privlog, privowner, admin, userdomain, privhome;
allow privhome home_root_t:dir search;

# system_r is authorized for sysadm_t for single-user mode.
role system_r types sysadm_t; 

# sysadm_r is authorized for sysadm_t for the initial login domain.
role sysadm_r types sysadm_t;

# sysadm_t is granted the permissions common to most domains.

#line 4261

#line 4261
# Grant the permissions common to the test domains.
#line 4261

#line 4261
# Grant permissions within the domain.
#line 4261

#line 4261
# Access other processes in the same domain.
#line 4261
allow sysadm_t self:process *;
#line 4261

#line 4261
# Access /proc/PID files for processes in the same domain.
#line 4261
allow sysadm_t self:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4261

#line 4261
# Access file descriptions, pipes, and sockets
#line 4261
# created by processes in the same domain.
#line 4261
allow sysadm_t self:fd *;
#line 4261
allow sysadm_t self:fifo_file { ioctl read getattr lock write append };
#line 4261
allow sysadm_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4261
allow sysadm_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4261

#line 4261
# Allow the domain to communicate with other processes in the same domain.
#line 4261
allow sysadm_t self:unix_dgram_socket sendto;
#line 4261
allow sysadm_t self:unix_stream_socket connectto;
#line 4261

#line 4261
# Access System V IPC objects created by processes in the same domain.
#line 4261
allow sysadm_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 4261
allow sysadm_t self:msg  { send receive };
#line 4261
allow sysadm_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 4261
allow sysadm_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 4261

#line 4261

#line 4261

#line 4261
# Grant read/search permissions to most of /proc.
#line 4261

#line 4261
# Read system information files in /proc.
#line 4261
allow sysadm_t proc_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t proc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4261

#line 4261
# Stat /proc/kmsg and /proc/kcore.
#line 4261
allow sysadm_t proc_kmsg_t:file { getattr };
#line 4261
allow sysadm_t proc_kcore_t:file { getattr };
#line 4261

#line 4261
# Read system variables in /proc/sys.
#line 4261
allow sysadm_t sysctl_modprobe_t:file { read getattr lock ioctl };
#line 4261
allow sysadm_t sysctl_t:file { read getattr lock ioctl };
#line 4261
allow sysadm_t sysctl_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t sysctl_fs_t:file { read getattr lock ioctl };
#line 4261
allow sysadm_t sysctl_fs_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t sysctl_kernel_t:file { read getattr lock ioctl };
#line 4261
allow sysadm_t sysctl_kernel_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t sysctl_net_t:file { read getattr lock ioctl };
#line 4261
allow sysadm_t sysctl_net_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t sysctl_vm_t:file { read getattr lock ioctl };
#line 4261
allow sysadm_t sysctl_vm_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t sysctl_dev_t:file { read getattr lock ioctl };
#line 4261
allow sysadm_t sysctl_dev_t:dir { read getattr lock search ioctl };
#line 4261

#line 4261

#line 4261
# Grant read/search permissions to many system file types.
#line 4261

#line 4261

#line 4261
# Get attributes of file systems.
#line 4261
allow sysadm_t fs_type:filesystem getattr;
#line 4261

#line 4261

#line 4261
# Read /.
#line 4261
allow sysadm_t root_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t root_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4261

#line 4261
# Read /home.
#line 4261
allow sysadm_t home_root_t:dir { read getattr lock search ioctl };
#line 4261

#line 4261
# Read /usr.
#line 4261
allow sysadm_t usr_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t usr_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4261

#line 4261
# Read bin and sbin directories.
#line 4261
allow sysadm_t bin_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4261
allow sysadm_t sbin_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4261

#line 4261

#line 4261
# Read directories and files with the readable_t type.
#line 4261
# This type is a general type for "world"-readable files.
#line 4261
allow sysadm_t readable_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t readable_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4261

#line 4261
# Stat /...security and lost+found.
#line 4261
allow sysadm_t file_labels_t:dir getattr;
#line 4261
allow sysadm_t lost_found_t:dir getattr;
#line 4261

#line 4261
# Read the devpts root directory.  
#line 4261
allow sysadm_t devpts_t:dir { read getattr lock search ioctl };
#line 4261

#line 4261

#line 4261
# Read the /tmp directory and any /tmp files with the base type.
#line 4261
# Temporary files created at runtime will typically use derived types.
#line 4261
allow sysadm_t tmp_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t tmp_t:{ file lnk_file } { read getattr lock ioctl };
#line 4261

#line 4261
# Read /var.
#line 4261
allow sysadm_t var_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t var_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4261

#line 4261
# Read /var/catman.
#line 4261
allow sysadm_t catman_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t catman_t:{ file lnk_file } { read getattr lock ioctl };
#line 4261

#line 4261
# Read /var/lib.
#line 4261
allow sysadm_t var_lib_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t var_lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4261
allow sysadm_t var_lib_nfs_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t var_lib_nfs_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4261

#line 4261

#line 4261
allow sysadm_t tetex_data_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t tetex_data_t:{ file lnk_file } { read getattr lock ioctl };
#line 4261

#line 4261

#line 4261
# Read /var/yp.
#line 4261
allow sysadm_t var_yp_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t var_yp_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4261

#line 4261
# Read /var/spool.
#line 4261
allow sysadm_t var_spool_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t var_spool_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4261

#line 4261
# Read /var/run, /var/lock, /var/log.
#line 4261
allow sysadm_t var_run_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t var_run_t:{ file lnk_file } { read getattr lock ioctl };
#line 4261
allow sysadm_t var_log_t:dir { read getattr lock search ioctl };
#line 4261
#allow sysadm_t var_log_t:{ file lnk_file } r_file_perms;
#line 4261
allow sysadm_t var_log_sa_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t var_log_sa_t:{ file lnk_file } { read getattr lock ioctl };
#line 4261
allow sysadm_t var_log_ksyms_t:{ file lnk_file } { read getattr lock ioctl };
#line 4261

#line 4261
allow sysadm_t var_lock_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t var_lock_t:{ file lnk_file } { read getattr lock ioctl };
#line 4261

#line 4261
# Read /var/run/utmp and /var/log/wtmp.
#line 4261
allow sysadm_t initrc_var_run_t:file { read getattr lock ioctl };
#line 4261
allow sysadm_t wtmp_t:file { read getattr lock ioctl };
#line 4261

#line 4261
# Read /boot, /boot/System.map*, and /vmlinuz*
#line 4261
allow sysadm_t boot_t:dir { search getattr };
#line 4261
allow sysadm_t boot_t:file getattr;
#line 4261
allow sysadm_t system_map_t:{ file lnk_file } { read getattr lock ioctl };
#line 4261

#line 4261
allow sysadm_t boot_t:lnk_file read;
#line 4261

#line 4261
# Read /etc.
#line 4261
allow sysadm_t etc_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t etc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4261
allow sysadm_t etc_runtime_t:{ file lnk_file } { read getattr lock ioctl };
#line 4261
allow sysadm_t etc_aliases_t:{ file lnk_file } { read getattr lock ioctl };
#line 4261
allow sysadm_t etc_mail_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t etc_mail_t:{ file lnk_file } { read getattr lock ioctl };
#line 4261
allow sysadm_t resolv_conf_t:{ file lnk_file } { read getattr lock ioctl };
#line 4261
allow sysadm_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4261

#line 4261
# Read /lib.
#line 4261
allow sysadm_t lib_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4261

#line 4261
# Read the linker, shared library, and executable types.
#line 4261
allow sysadm_t ld_so_t:{ file lnk_file } { read getattr lock ioctl };
#line 4261
allow sysadm_t shlib_t:{ file lnk_file } { read getattr lock ioctl };
#line 4261
allow sysadm_t exec_type:{ file lnk_file } { read getattr lock ioctl };
#line 4261

#line 4261
# Read man directories and files.
#line 4261
allow sysadm_t man_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t man_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4261

#line 4261
# Read /usr/src.
#line 4261
allow sysadm_t src_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t src_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4261

#line 4261
# Read module-related files.
#line 4261
allow sysadm_t modules_object_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t modules_object_t:{ file lnk_file } { read getattr lock ioctl };
#line 4261
allow sysadm_t modules_dep_t:{ file lnk_file } { read getattr lock ioctl };
#line 4261
allow sysadm_t modules_conf_t:{ file lnk_file} { read getattr lock ioctl };
#line 4261

#line 4261
# Read /dev directories and any symbolic links.
#line 4261
allow sysadm_t device_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t device_t:lnk_file { read getattr lock ioctl };
#line 4261

#line 4261
# Read /dev/random and /dev/zero.
#line 4261
allow sysadm_t random_device_t:chr_file { read getattr lock ioctl };
#line 4261
allow sysadm_t zero_device_t:chr_file { read getattr lock ioctl };
#line 4261

#line 4261
# Read the root directory of a tmpfs filesytem and any symbolic links.
#line 4261
allow sysadm_t tmpfs_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t tmpfs_t:lnk_file { read getattr lock ioctl };
#line 4261

#line 4261
# Read any symbolic links on a devfs file system.
#line 4261
allow sysadm_t device_t:lnk_file { read getattr lock ioctl };
#line 4261

#line 4261
# Read the root directory of a usbdevfs filesystem, and
#line 4261
# the devices and drivers files.  Permit stating of the
#line 4261
# device nodes, but nothing else.
#line 4261
allow sysadm_t usbdevfs_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t usbdevfs_t:{ file lnk_file } { read getattr lock ioctl };
#line 4261
allow sysadm_t usbdevfs_device_t:file getattr;
#line 4261

#line 4261

#line 4261
# Grant write permissions to a small set of system file types.
#line 4261
# No permission to create files is granted here.  Use allow rules to grant 
#line 4261
# create permissions to a type or use file_type_auto_trans rules to set up
#line 4261
# new types for files.
#line 4261

#line 4261

#line 4261
# Read and write /dev/tty and /dev/null.
#line 4261
allow sysadm_t devtty_t:chr_file { ioctl read getattr lock write append };
#line 4261
allow sysadm_t { null_device_t zero_device_t }:chr_file { ioctl read getattr lock write append };
#line 4261

#line 4261
# Do not audit write denials to /etc/ld.so.cache.
#line 4261
dontaudit sysadm_t ld_so_cache_t:file write;
#line 4261

#line 4261

#line 4261
# Execute from the system shared libraries.
#line 4261
# No permission to execute anything else is granted here.
#line 4261
# Use can_exec or can_exec_any to grant the ability to execute within a domain.
#line 4261
# Use domain_auto_trans for executing and changing domains.
#line 4261

#line 4261
allow sysadm_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t ld_so_t:file { read getattr lock execute ioctl };
#line 4261
allow sysadm_t ld_so_t:file execute_no_trans;
#line 4261
allow sysadm_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4261
allow sysadm_t shlib_t:file { read getattr lock execute ioctl };
#line 4261
allow sysadm_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4261
allow sysadm_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4261
allow sysadm_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4261

#line 4261

#line 4261
# read localization information
#line 4261
allow sysadm_t locale_t:dir { read getattr lock search ioctl };
#line 4261
allow sysadm_t locale_t:{file lnk_file} { read getattr lock ioctl };
#line 4261

#line 4261
# Obtain the context of any SID, the SID for any context, 
#line 4261
# and the list of active SIDs.
#line 4261
allow sysadm_t security_t:security { sid_to_context context_to_sid get_sids };
#line 4261

#line 4261

#line 4261

#line 4261
# Grant permissions needed to create TCP and UDP sockets and 
#line 4261
# to access the network.
#line 4261

#line 4261
#
#line 4261
# Allow the domain to create and use UDP and TCP sockets.
#line 4261
# Other kinds of sockets must be separately authorized for use.
#line 4261
allow sysadm_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4261
allow sysadm_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4261

#line 4261
#
#line 4261
# Allow the domain to send UDP packets.
#line 4261
# Since the destination sockets type is unknown, the generic
#line 4261
# any_socket_t type is used as a placeholder.
#line 4261
#
#line 4261
allow sysadm_t any_socket_t:udp_socket sendto;
#line 4261

#line 4261
#
#line 4261
# Allow the domain to send using any network interface.
#line 4261
# netif_type is a type attribute for all network interface types.
#line 4261
#
#line 4261
allow sysadm_t netif_type:netif { tcp_send udp_send rawip_send };
#line 4261

#line 4261
#
#line 4261
# Allow packets sent by the domain to be received on any network interface.
#line 4261
#
#line 4261
allow sysadm_t netif_type:netif { tcp_recv udp_recv rawip_recv };
#line 4261

#line 4261
#
#line 4261
# Allow the domain to receive packets from any network interface.
#line 4261
# netmsg_type is a type attribute for all default message types.
#line 4261
#
#line 4261
allow sysadm_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
#line 4261

#line 4261
#
#line 4261
# Allow the domain to initiate or accept TCP connections 
#line 4261
# on any network interface.
#line 4261
#
#line 4261
allow sysadm_t netmsg_type:tcp_socket { connectto acceptfrom };
#line 4261

#line 4261
#
#line 4261
# Receive resets from the TCP reset socket.
#line 4261
# The TCP reset socket is labeled with the tcp_socket_t type.
#line 4261
#
#line 4261
allow sysadm_t tcp_socket_t:tcp_socket recvfrom;
#line 4261

#line 4261
dontaudit sysadm_t tcp_socket_t:tcp_socket connectto;
#line 4261

#line 4261
#
#line 4261
# Allow the domain to send to any node.
#line 4261
# node_type is a type attribute for all node types.
#line 4261
#
#line 4261
allow sysadm_t node_type:node { tcp_send udp_send rawip_send };
#line 4261

#line 4261
#
#line 4261
# Allow packets sent by the domain to be received from any node.
#line 4261
#
#line 4261
allow sysadm_t node_type:node { tcp_recv udp_recv rawip_recv };
#line 4261

#line 4261
#
#line 4261
# Allow the domain to send NFS client requests via the socket
#line 4261
# created by mount.
#line 4261
#
#line 4261
allow sysadm_t mount_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4261

#line 4261
#
#line 4261
# Bind to the default port type.
#line 4261
# Other port types must be separately authorized.
#line 4261
#
#line 4261
allow sysadm_t port_t:udp_socket name_bind;
#line 4261
allow sysadm_t port_t:tcp_socket name_bind;
#line 4261

#line 4261


# sysadm_t is also granted permissions specific to administrator domains.

#line 4264
# Inherit rules for ordinary users.
#line 4264

#line 4264
# Use capabilities
#line 4264
allow sysadm_t self:capability { setgid chown fowner };
#line 4264
dontaudit sysadm_t self:capability { sys_nice fsetid };
#line 4264

#line 4264
# Type for home directory.
#line 4264

#line 4264
type sysadm_home_dir_t, file_type, sysadmfile, home_dir_type, home_type;
#line 4264
type sysadm_home_t, file_type, sysadmfile, home_type;
#line 4264

#line 4264
type sysadm_tmp_t, file_type, sysadmfile, tmpfile ;
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
#
#line 4264
# Allow the process to modify the directory.
#line 4264
#
#line 4264
allow sysadm_t tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4264

#line 4264
#
#line 4264
# Allow the process to create the file.
#line 4264
#
#line 4264

#line 4264
allow sysadm_t sysadm_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4264
allow sysadm_t sysadm_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4264

#line 4264

#line 4264

#line 4264
type_transition sysadm_t tmp_t:dir sysadm_tmp_t;
#line 4264
type_transition sysadm_t tmp_t:{ file lnk_file sock_file fifo_file } sysadm_tmp_t;
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
# Create, access, and remove files in home directory.
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
#
#line 4264
# Allow the process to modify the directory.
#line 4264
#
#line 4264
allow sysadm_t sysadm_home_dir_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4264

#line 4264
#
#line 4264
# Allow the process to create the file.
#line 4264
#
#line 4264

#line 4264
allow sysadm_t sysadm_home_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4264
allow sysadm_t sysadm_home_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4264

#line 4264

#line 4264

#line 4264
type_transition sysadm_t sysadm_home_dir_t:dir sysadm_home_t;
#line 4264
type_transition sysadm_t sysadm_home_dir_t:{ file lnk_file sock_file fifo_file } sysadm_home_t;
#line 4264

#line 4264

#line 4264

#line 4264
allow sysadm_t sysadm_home_t:{ dir file lnk_file sock_file fifo_file chr_file blk_file } { relabelfrom relabelto };
#line 4264

#line 4264
# Bind to a Unix domain socket in /tmp.
#line 4264
allow sysadm_t sysadm_tmp_t:unix_stream_socket name_bind;
#line 4264

#line 4264
# Type for tty devices.
#line 4264
type sysadm_tty_device_t, file_type, sysadmfile, ttyfile;
#line 4264
# Access ttys.
#line 4264
allow sysadm_t sysadm_tty_device_t:chr_file { setattr { ioctl read getattr lock write append } };
#line 4264
# Use the type when relabeling terminal devices.
#line 4264
type_change sysadm_t tty_device_t:chr_file sysadm_tty_device_t;
#line 4264

#line 4264

#line 4264
# Type and access for pty devices.
#line 4264

#line 4264

#line 4264

#line 4264
type sysadm_devpts_t, file_type, sysadmfile, ptyfile ;
#line 4264

#line 4264
# Allow the pty to be associated with the file system.
#line 4264
allow sysadm_devpts_t devpts_t:filesystem associate;
#line 4264

#line 4264
# Access the pty master multiplexer.
#line 4264
allow sysadm_t ptmx_t:chr_file { ioctl read getattr lock write append };
#line 4264

#line 4264
# Label pty files with a derived type.
#line 4264
type_transition sysadm_t devpts_t:chr_file sysadm_devpts_t;
#line 4264

#line 4264
# Read and write my pty files.
#line 4264
allow sysadm_t sysadm_devpts_t:chr_file { setattr { ioctl read getattr lock write append } };
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
# Use the type when relabeling pty devices.
#line 4264

#line 4264

#line 4264
type_change sysadm_t sshd_devpts_t:chr_file sysadm_devpts_t;
#line 4264

#line 4264
# Connect to sshd.
#line 4264

#line 4264
allow sysadm_t sshd_t:tcp_socket { connectto recvfrom };
#line 4264
allow sshd_t sysadm_t:tcp_socket { acceptfrom recvfrom };
#line 4264
allow sshd_t tcp_socket_t:tcp_socket { recvfrom };
#line 4264
allow sysadm_t tcp_socket_t:tcp_socket { recvfrom };
#line 4264

#line 4264

#line 4264
# Connect to ssh proxy.
#line 4264

#line 4264
allow sysadm_t sysadm_ssh_t:tcp_socket { connectto recvfrom };
#line 4264
allow sysadm_ssh_t sysadm_t:tcp_socket { acceptfrom recvfrom };
#line 4264
allow sysadm_ssh_t tcp_socket_t:tcp_socket { recvfrom };
#line 4264
allow sysadm_t tcp_socket_t:tcp_socket { recvfrom };
#line 4264

#line 4264

#line 4264
allow sysadm_t sshd_t:fd use;
#line 4264
allow sysadm_t sshd_t:tcp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4264
# Use a Unix stream socket inherited from sshd.
#line 4264
allow sysadm_t sshd_t:unix_stream_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4264

#line 4264
# Type for tmpfs/shm files.
#line 4264
type sysadm_tmpfs_t, file_type, sysadmfile, tmpfsfile;
#line 4264
# Use the type when creating files in tmpfs.
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
#
#line 4264
# Allow the process to modify the directory.
#line 4264
#
#line 4264
allow sysadm_t tmpfs_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4264

#line 4264
#
#line 4264
# Allow the process to create the file.
#line 4264
#
#line 4264

#line 4264
allow sysadm_t sysadm_tmpfs_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4264
allow sysadm_t sysadm_tmpfs_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4264

#line 4264

#line 4264

#line 4264
type_transition sysadm_t tmpfs_t:dir sysadm_tmpfs_t;
#line 4264
type_transition sysadm_t tmpfs_t:{ file lnk_file sock_file fifo_file } sysadm_tmpfs_t;
#line 4264

#line 4264

#line 4264

#line 4264
allow sysadm_tmpfs_t tmpfs_t:filesystem associate;
#line 4264

#line 4264
# Read and write /var/catman.
#line 4264
allow sysadm_t catman_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4264
allow sysadm_t catman_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4264

#line 4264
# Modify mail spool file.
#line 4264
allow sysadm_t mail_spool_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_t mail_spool_t:file { ioctl read getattr lock write append };
#line 4264
allow sysadm_t mail_spool_t:lnk_file read;
#line 4264

#line 4264
#
#line 4264
# Allow the query of filesystem quotas
#line 4264
#
#line 4264
allow sysadm_t fs_type:filesystem quotaget;
#line 4264

#line 4264
# Run helper programs.
#line 4264

#line 4264
allow sysadm_t { bin_t sbin_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_t { bin_t sbin_t }:lnk_file read;
#line 4264

#line 4264
allow sysadm_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_t ld_so_t:file { read getattr lock execute ioctl };
#line 4264
allow sysadm_t ld_so_t:file execute_no_trans;
#line 4264
allow sysadm_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4264
allow sysadm_t shlib_t:file { read getattr lock execute ioctl };
#line 4264
allow sysadm_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4264
allow sysadm_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4264

#line 4264

#line 4264
allow sysadm_t etc_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4264

#line 4264

#line 4264
allow sysadm_t lib_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4264

#line 4264

#line 4264
allow sysadm_t bin_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4264

#line 4264

#line 4264
allow sysadm_t sbin_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4264

#line 4264

#line 4264
allow sysadm_t exec_type:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4264

#line 4264

#line 4264
# Run programs developed by other users in the same domain.
#line 4264

#line 4264
allow sysadm_t sysadm_home_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4264

#line 4264

#line 4264
allow sysadm_t sysadm_tmp_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4264

#line 4264

#line 4264
# Run user programs that require different permissions in their own domain.
#line 4264
# These rules were moved into the individual program domains.
#line 4264

#line 4264
# Instantiate derived domains for a number of programs.
#line 4264
# These derived domains encode both information about the calling
#line 4264
# user domain and the program, and allow us to maintain separation
#line 4264
# between different instances of the program being run by different
#line 4264
# user domains.
#line 4264

#line 4264

#line 4264

#line 4264
# Derived domain based on the calling user domain and the program.
#line 4264
type sysadm_su_t, domain, privlog, auth;
#line 4264

#line 4264
# Transition from the user domain to this domain.
#line 4264

#line 4264

#line 4264

#line 4264
#
#line 4264
# Allow the process to transition to the new domain.
#line 4264
#
#line 4264
allow sysadm_t sysadm_su_t:process transition;
#line 4264

#line 4264
#
#line 4264
# Allow the process to execute the program.
#line 4264
# 
#line 4264
allow sysadm_t su_exec_t:file { getattr execute };
#line 4264

#line 4264
#
#line 4264
# Allow the process to reap the new domain.
#line 4264
#
#line 4264
allow sysadm_su_t sysadm_t:process sigchld;
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to inherit and use file 
#line 4264
# descriptions from the creating process and vice versa.
#line 4264
#
#line 4264
allow sysadm_su_t sysadm_t:fd use;
#line 4264
allow sysadm_t sysadm_su_t:fd use;
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to write back to the old domain via a pipe.
#line 4264
#
#line 4264
allow sysadm_su_t sysadm_t:fifo_file { ioctl read getattr lock write append };
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to read and execute the program.
#line 4264
#
#line 4264
allow sysadm_su_t su_exec_t:file { read getattr lock execute ioctl };
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to be entered via the program.
#line 4264
#
#line 4264
allow sysadm_su_t su_exec_t:file entrypoint;
#line 4264

#line 4264
type_transition sysadm_t su_exec_t:process sysadm_su_t;
#line 4264

#line 4264

#line 4264
# This domain is granted permissions common to most domains.
#line 4264

#line 4264

#line 4264
# Grant the permissions common to the test domains.
#line 4264

#line 4264
# Grant permissions within the domain.
#line 4264

#line 4264
# Access other processes in the same domain.
#line 4264
allow sysadm_su_t self:process *;
#line 4264

#line 4264
# Access /proc/PID files for processes in the same domain.
#line 4264
allow sysadm_su_t self:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Access file descriptions, pipes, and sockets
#line 4264
# created by processes in the same domain.
#line 4264
allow sysadm_su_t self:fd *;
#line 4264
allow sysadm_su_t self:fifo_file { ioctl read getattr lock write append };
#line 4264
allow sysadm_su_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4264
allow sysadm_su_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4264

#line 4264
# Allow the domain to communicate with other processes in the same domain.
#line 4264
allow sysadm_su_t self:unix_dgram_socket sendto;
#line 4264
allow sysadm_su_t self:unix_stream_socket connectto;
#line 4264

#line 4264
# Access System V IPC objects created by processes in the same domain.
#line 4264
allow sysadm_su_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 4264
allow sysadm_su_t self:msg  { send receive };
#line 4264
allow sysadm_su_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 4264
allow sysadm_su_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 4264

#line 4264

#line 4264

#line 4264
# Grant read/search permissions to most of /proc.
#line 4264

#line 4264
# Read system information files in /proc.
#line 4264
allow sysadm_su_t proc_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t proc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Stat /proc/kmsg and /proc/kcore.
#line 4264
allow sysadm_su_t proc_kmsg_t:file { getattr };
#line 4264
allow sysadm_su_t proc_kcore_t:file { getattr };
#line 4264

#line 4264
# Read system variables in /proc/sys.
#line 4264
allow sysadm_su_t sysctl_modprobe_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_su_t sysctl_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_su_t sysctl_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t sysctl_fs_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_su_t sysctl_fs_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t sysctl_kernel_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_su_t sysctl_kernel_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t sysctl_net_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_su_t sysctl_net_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t sysctl_vm_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_su_t sysctl_vm_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t sysctl_dev_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_su_t sysctl_dev_t:dir { read getattr lock search ioctl };
#line 4264

#line 4264

#line 4264
# Grant read/search permissions to many system file types.
#line 4264

#line 4264

#line 4264
# Get attributes of file systems.
#line 4264
allow sysadm_su_t fs_type:filesystem getattr;
#line 4264

#line 4264

#line 4264
# Read /.
#line 4264
allow sysadm_su_t root_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t root_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /home.
#line 4264
allow sysadm_su_t home_root_t:dir { read getattr lock search ioctl };
#line 4264

#line 4264
# Read /usr.
#line 4264
allow sysadm_su_t usr_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t usr_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read bin and sbin directories.
#line 4264
allow sysadm_su_t bin_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264
allow sysadm_su_t sbin_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264

#line 4264
# Read directories and files with the readable_t type.
#line 4264
# This type is a general type for "world"-readable files.
#line 4264
allow sysadm_su_t readable_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t readable_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Stat /...security and lost+found.
#line 4264
allow sysadm_su_t file_labels_t:dir getattr;
#line 4264
allow sysadm_su_t lost_found_t:dir getattr;
#line 4264

#line 4264
# Read the devpts root directory.  
#line 4264
allow sysadm_su_t devpts_t:dir { read getattr lock search ioctl };
#line 4264

#line 4264

#line 4264
# Read the /tmp directory and any /tmp files with the base type.
#line 4264
# Temporary files created at runtime will typically use derived types.
#line 4264
allow sysadm_su_t tmp_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t tmp_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /var.
#line 4264
allow sysadm_su_t var_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t var_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /var/catman.
#line 4264
allow sysadm_su_t catman_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t catman_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /var/lib.
#line 4264
allow sysadm_su_t var_lib_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t var_lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264
allow sysadm_su_t var_lib_nfs_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t var_lib_nfs_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264

#line 4264
allow sysadm_su_t tetex_data_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t tetex_data_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264

#line 4264
# Read /var/yp.
#line 4264
allow sysadm_su_t var_yp_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t var_yp_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /var/spool.
#line 4264
allow sysadm_su_t var_spool_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t var_spool_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /var/run, /var/lock, /var/log.
#line 4264
allow sysadm_su_t var_run_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t var_run_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_su_t var_log_t:dir { read getattr lock search ioctl };
#line 4264
#allow sysadm_su_t var_log_t:{ file lnk_file } r_file_perms;
#line 4264
allow sysadm_su_t var_log_sa_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t var_log_sa_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_su_t var_log_ksyms_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264
allow sysadm_su_t var_lock_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t var_lock_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /var/run/utmp and /var/log/wtmp.
#line 4264
allow sysadm_su_t initrc_var_run_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_su_t wtmp_t:file { read getattr lock ioctl };
#line 4264

#line 4264
# Read /boot, /boot/System.map*, and /vmlinuz*
#line 4264
allow sysadm_su_t boot_t:dir { search getattr };
#line 4264
allow sysadm_su_t boot_t:file getattr;
#line 4264
allow sysadm_su_t system_map_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264
allow sysadm_su_t boot_t:lnk_file read;
#line 4264

#line 4264
# Read /etc.
#line 4264
allow sysadm_su_t etc_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t etc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264
allow sysadm_su_t etc_runtime_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_su_t etc_aliases_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_su_t etc_mail_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t etc_mail_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_su_t resolv_conf_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_su_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4264

#line 4264
# Read /lib.
#line 4264
allow sysadm_su_t lib_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read the linker, shared library, and executable types.
#line 4264
allow sysadm_su_t ld_so_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_su_t shlib_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_su_t exec_type:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read man directories and files.
#line 4264
allow sysadm_su_t man_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t man_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /usr/src.
#line 4264
allow sysadm_su_t src_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t src_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read module-related files.
#line 4264
allow sysadm_su_t modules_object_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t modules_object_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_su_t modules_dep_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_su_t modules_conf_t:{ file lnk_file} { read getattr lock ioctl };
#line 4264

#line 4264
# Read /dev directories and any symbolic links.
#line 4264
allow sysadm_su_t device_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t device_t:lnk_file { read getattr lock ioctl };
#line 4264

#line 4264
# Read /dev/random and /dev/zero.
#line 4264
allow sysadm_su_t random_device_t:chr_file { read getattr lock ioctl };
#line 4264
allow sysadm_su_t zero_device_t:chr_file { read getattr lock ioctl };
#line 4264

#line 4264
# Read the root directory of a tmpfs filesytem and any symbolic links.
#line 4264
allow sysadm_su_t tmpfs_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t tmpfs_t:lnk_file { read getattr lock ioctl };
#line 4264

#line 4264
# Read any symbolic links on a devfs file system.
#line 4264
allow sysadm_su_t device_t:lnk_file { read getattr lock ioctl };
#line 4264

#line 4264
# Read the root directory of a usbdevfs filesystem, and
#line 4264
# the devices and drivers files.  Permit stating of the
#line 4264
# device nodes, but nothing else.
#line 4264
allow sysadm_su_t usbdevfs_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t usbdevfs_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_su_t usbdevfs_device_t:file getattr;
#line 4264

#line 4264

#line 4264
# Grant write permissions to a small set of system file types.
#line 4264
# No permission to create files is granted here.  Use allow rules to grant 
#line 4264
# create permissions to a type or use file_type_auto_trans rules to set up
#line 4264
# new types for files.
#line 4264

#line 4264

#line 4264
# Read and write /dev/tty and /dev/null.
#line 4264
allow sysadm_su_t devtty_t:chr_file { ioctl read getattr lock write append };
#line 4264
allow sysadm_su_t { null_device_t zero_device_t }:chr_file { ioctl read getattr lock write append };
#line 4264

#line 4264
# Do not audit write denials to /etc/ld.so.cache.
#line 4264
dontaudit sysadm_su_t ld_so_cache_t:file write;
#line 4264

#line 4264

#line 4264
# Execute from the system shared libraries.
#line 4264
# No permission to execute anything else is granted here.
#line 4264
# Use can_exec or can_exec_any to grant the ability to execute within a domain.
#line 4264
# Use domain_auto_trans for executing and changing domains.
#line 4264

#line 4264
allow sysadm_su_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t ld_so_t:file { read getattr lock execute ioctl };
#line 4264
allow sysadm_su_t ld_so_t:file execute_no_trans;
#line 4264
allow sysadm_su_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4264
allow sysadm_su_t shlib_t:file { read getattr lock execute ioctl };
#line 4264
allow sysadm_su_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4264
allow sysadm_su_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_su_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4264

#line 4264

#line 4264
# read localization information
#line 4264
allow sysadm_su_t locale_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_su_t locale_t:{file lnk_file} { read getattr lock ioctl };
#line 4264

#line 4264
# Obtain the context of any SID, the SID for any context, 
#line 4264
# and the list of active SIDs.
#line 4264
allow sysadm_su_t security_t:security { sid_to_context context_to_sid get_sids };
#line 4264

#line 4264

#line 4264

#line 4264
# Grant permissions needed to create TCP and UDP sockets and 
#line 4264
# to access the network.
#line 4264

#line 4264
#
#line 4264
# Allow the domain to create and use UDP and TCP sockets.
#line 4264
# Other kinds of sockets must be separately authorized for use.
#line 4264
allow sysadm_su_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4264
allow sysadm_su_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4264

#line 4264
#
#line 4264
# Allow the domain to send UDP packets.
#line 4264
# Since the destination sockets type is unknown, the generic
#line 4264
# any_socket_t type is used as a placeholder.
#line 4264
#
#line 4264
allow sysadm_su_t any_socket_t:udp_socket sendto;
#line 4264

#line 4264
#
#line 4264
# Allow the domain to send using any network interface.
#line 4264
# netif_type is a type attribute for all network interface types.
#line 4264
#
#line 4264
allow sysadm_su_t netif_type:netif { tcp_send udp_send rawip_send };
#line 4264

#line 4264
#
#line 4264
# Allow packets sent by the domain to be received on any network interface.
#line 4264
#
#line 4264
allow sysadm_su_t netif_type:netif { tcp_recv udp_recv rawip_recv };
#line 4264

#line 4264
#
#line 4264
# Allow the domain to receive packets from any network interface.
#line 4264
# netmsg_type is a type attribute for all default message types.
#line 4264
#
#line 4264
allow sysadm_su_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
#line 4264

#line 4264
#
#line 4264
# Allow the domain to initiate or accept TCP connections 
#line 4264
# on any network interface.
#line 4264
#
#line 4264
allow sysadm_su_t netmsg_type:tcp_socket { connectto acceptfrom };
#line 4264

#line 4264
#
#line 4264
# Receive resets from the TCP reset socket.
#line 4264
# The TCP reset socket is labeled with the tcp_socket_t type.
#line 4264
#
#line 4264
allow sysadm_su_t tcp_socket_t:tcp_socket recvfrom;
#line 4264

#line 4264
dontaudit sysadm_su_t tcp_socket_t:tcp_socket connectto;
#line 4264

#line 4264
#
#line 4264
# Allow the domain to send to any node.
#line 4264
# node_type is a type attribute for all node types.
#line 4264
#
#line 4264
allow sysadm_su_t node_type:node { tcp_send udp_send rawip_send };
#line 4264

#line 4264
#
#line 4264
# Allow packets sent by the domain to be received from any node.
#line 4264
#
#line 4264
allow sysadm_su_t node_type:node { tcp_recv udp_recv rawip_recv };
#line 4264

#line 4264
#
#line 4264
# Allow the domain to send NFS client requests via the socket
#line 4264
# created by mount.
#line 4264
#
#line 4264
allow sysadm_su_t mount_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4264

#line 4264
#
#line 4264
# Bind to the default port type.
#line 4264
# Other port types must be separately authorized.
#line 4264
#
#line 4264
allow sysadm_su_t port_t:udp_socket name_bind;
#line 4264
allow sysadm_su_t port_t:tcp_socket name_bind;
#line 4264

#line 4264

#line 4264

#line 4264
# Use capabilities.
#line 4264
allow sysadm_su_t self:capability { setuid setgid net_bind_service chown dac_override sys_nice sys_resource };
#line 4264

#line 4264
# Revert to the user domain when a shell is executed.
#line 4264

#line 4264

#line 4264

#line 4264
#
#line 4264
# Allow the process to transition to the new domain.
#line 4264
#
#line 4264
allow sysadm_su_t sysadm_t:process transition;
#line 4264

#line 4264
#
#line 4264
# Allow the process to execute the program.
#line 4264
# 
#line 4264
allow sysadm_su_t shell_exec_t:file { getattr execute };
#line 4264

#line 4264
#
#line 4264
# Allow the process to reap the new domain.
#line 4264
#
#line 4264
allow sysadm_t sysadm_su_t:process sigchld;
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to inherit and use file 
#line 4264
# descriptions from the creating process and vice versa.
#line 4264
#
#line 4264
allow sysadm_t sysadm_su_t:fd use;
#line 4264
allow sysadm_su_t sysadm_t:fd use;
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to write back to the old domain via a pipe.
#line 4264
#
#line 4264
allow sysadm_t sysadm_su_t:fifo_file { ioctl read getattr lock write append };
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to read and execute the program.
#line 4264
#
#line 4264
allow sysadm_t shell_exec_t:file { read getattr lock execute ioctl };
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to be entered via the program.
#line 4264
#
#line 4264
allow sysadm_t shell_exec_t:file entrypoint;
#line 4264

#line 4264
type_transition sysadm_su_t shell_exec_t:process sysadm_t;
#line 4264

#line 4264

#line 4264
allow sysadm_su_t privfd:fd use;
#line 4264

#line 4264
# Write to utmp.
#line 4264
allow sysadm_su_t initrc_var_run_t:file { ioctl read getattr lock write append };
#line 4264

#line 4264

#line 4264

#line 4264
# Run chkpwd.
#line 4264

#line 4264
allow sysadm_su_t chkpwd_exec_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4264

#line 4264

#line 4264

#line 4264
# Inherit and use descriptors from gnome-pty-helper.
#line 4264

#line 4264

#line 4264
# The user role is authorized for this domain.
#line 4264
role sysadm_r types sysadm_su_t;
#line 4264

#line 4264
# Write to the user domain tty.
#line 4264
allow sysadm_su_t sysadm_tty_device_t:chr_file { ioctl read getattr lock write append };
#line 4264
allow sysadm_su_t sysadm_devpts_t:chr_file { ioctl read getattr lock write append };
#line 4264

#line 4264
allow sysadm_su_t sysadm_home_dir_t:dir search;
#line 4264

#line 4264
# Modify .Xauthority file (via xauth program).
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
#
#line 4264
# Allow the process to transition to the new domain.
#line 4264
#
#line 4264
allow sysadm_su_t sysadm_xauth_t:process transition;
#line 4264

#line 4264
#
#line 4264
# Allow the process to execute the program.
#line 4264
# 
#line 4264
allow sysadm_su_t xauth_exec_t:file { getattr execute };
#line 4264

#line 4264
#
#line 4264
# Allow the process to reap the new domain.
#line 4264
#
#line 4264
allow sysadm_xauth_t sysadm_su_t:process sigchld;
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to inherit and use file 
#line 4264
# descriptions from the creating process and vice versa.
#line 4264
#
#line 4264
allow sysadm_xauth_t sysadm_su_t:fd use;
#line 4264
allow sysadm_su_t sysadm_xauth_t:fd use;
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to write back to the old domain via a pipe.
#line 4264
#
#line 4264
allow sysadm_xauth_t sysadm_su_t:fifo_file { ioctl read getattr lock write append };
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to read and execute the program.
#line 4264
#
#line 4264
allow sysadm_xauth_t xauth_exec_t:file { read getattr lock execute ioctl };
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to be entered via the program.
#line 4264
#
#line 4264
allow sysadm_xauth_t xauth_exec_t:file entrypoint;
#line 4264

#line 4264
type_transition sysadm_su_t xauth_exec_t:process sysadm_xauth_t;
#line 4264

#line 4264

#line 4264

#line 4264
# Access sshd cookie files.
#line 4264
allow sysadm_su_t sshd_tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4264
allow sysadm_su_t sshd_tmp_t:file { ioctl read getattr lock write append };
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
#
#line 4264
# Allow the process to modify the directory.
#line 4264
#
#line 4264
allow sysadm_su_t sshd_tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4264

#line 4264
#
#line 4264
# Allow the process to create the file.
#line 4264
#
#line 4264

#line 4264
allow sysadm_su_t sysadm_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4264
allow sysadm_su_t sysadm_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4264

#line 4264

#line 4264

#line 4264
type_transition sysadm_su_t sshd_tmp_t:dir sysadm_tmp_t;
#line 4264
type_transition sysadm_su_t sshd_tmp_t:{ file lnk_file sock_file fifo_file } sysadm_tmp_t;
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
# stop su complaining if you run it from a directory with restrictive perms
#line 4264
dontaudit sysadm_su_t file_type:dir search;
#line 4264

#line 4264

#line 4264
# Derived domain based on the calling user domain and the program.
#line 4264
type sysadm_chkpwd_t, domain, privlog, auth;
#line 4264

#line 4264
# Transition from the user domain to this domain.
#line 4264

#line 4264

#line 4264

#line 4264
#
#line 4264
# Allow the process to transition to the new domain.
#line 4264
#
#line 4264
allow sysadm_t sysadm_chkpwd_t:process transition;
#line 4264

#line 4264
#
#line 4264
# Allow the process to execute the program.
#line 4264
# 
#line 4264
allow sysadm_t chkpwd_exec_t:file { getattr execute };
#line 4264

#line 4264
#
#line 4264
# Allow the process to reap the new domain.
#line 4264
#
#line 4264
allow sysadm_chkpwd_t sysadm_t:process sigchld;
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to inherit and use file 
#line 4264
# descriptions from the creating process and vice versa.
#line 4264
#
#line 4264
allow sysadm_chkpwd_t sysadm_t:fd use;
#line 4264
allow sysadm_t sysadm_chkpwd_t:fd use;
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to write back to the old domain via a pipe.
#line 4264
#
#line 4264
allow sysadm_chkpwd_t sysadm_t:fifo_file { ioctl read getattr lock write append };
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to read and execute the program.
#line 4264
#
#line 4264
allow sysadm_chkpwd_t chkpwd_exec_t:file { read getattr lock execute ioctl };
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to be entered via the program.
#line 4264
#
#line 4264
allow sysadm_chkpwd_t chkpwd_exec_t:file entrypoint;
#line 4264

#line 4264
type_transition sysadm_t chkpwd_exec_t:process sysadm_chkpwd_t;
#line 4264

#line 4264

#line 4264
# The user role is authorized for this domain.
#line 4264
role sysadm_r types sysadm_chkpwd_t;
#line 4264

#line 4264
# This domain is granted permissions common to most domains (includes can_net)
#line 4264

#line 4264

#line 4264
# Grant the permissions common to the test domains.
#line 4264

#line 4264
# Grant permissions within the domain.
#line 4264

#line 4264
# Access other processes in the same domain.
#line 4264
allow sysadm_chkpwd_t self:process *;
#line 4264

#line 4264
# Access /proc/PID files for processes in the same domain.
#line 4264
allow sysadm_chkpwd_t self:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Access file descriptions, pipes, and sockets
#line 4264
# created by processes in the same domain.
#line 4264
allow sysadm_chkpwd_t self:fd *;
#line 4264
allow sysadm_chkpwd_t self:fifo_file { ioctl read getattr lock write append };
#line 4264
allow sysadm_chkpwd_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4264
allow sysadm_chkpwd_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4264

#line 4264
# Allow the domain to communicate with other processes in the same domain.
#line 4264
allow sysadm_chkpwd_t self:unix_dgram_socket sendto;
#line 4264
allow sysadm_chkpwd_t self:unix_stream_socket connectto;
#line 4264

#line 4264
# Access System V IPC objects created by processes in the same domain.
#line 4264
allow sysadm_chkpwd_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 4264
allow sysadm_chkpwd_t self:msg  { send receive };
#line 4264
allow sysadm_chkpwd_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 4264
allow sysadm_chkpwd_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 4264

#line 4264

#line 4264

#line 4264
# Grant read/search permissions to most of /proc.
#line 4264

#line 4264
# Read system information files in /proc.
#line 4264
allow sysadm_chkpwd_t proc_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t proc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Stat /proc/kmsg and /proc/kcore.
#line 4264
allow sysadm_chkpwd_t proc_kmsg_t:file { getattr };
#line 4264
allow sysadm_chkpwd_t proc_kcore_t:file { getattr };
#line 4264

#line 4264
# Read system variables in /proc/sys.
#line 4264
allow sysadm_chkpwd_t sysctl_modprobe_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_chkpwd_t sysctl_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_chkpwd_t sysctl_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t sysctl_fs_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_chkpwd_t sysctl_fs_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t sysctl_kernel_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_chkpwd_t sysctl_kernel_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t sysctl_net_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_chkpwd_t sysctl_net_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t sysctl_vm_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_chkpwd_t sysctl_vm_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t sysctl_dev_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_chkpwd_t sysctl_dev_t:dir { read getattr lock search ioctl };
#line 4264

#line 4264

#line 4264
# Grant read/search permissions to many system file types.
#line 4264

#line 4264

#line 4264
# Get attributes of file systems.
#line 4264
allow sysadm_chkpwd_t fs_type:filesystem getattr;
#line 4264

#line 4264

#line 4264
# Read /.
#line 4264
allow sysadm_chkpwd_t root_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t root_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /home.
#line 4264
allow sysadm_chkpwd_t home_root_t:dir { read getattr lock search ioctl };
#line 4264

#line 4264
# Read /usr.
#line 4264
allow sysadm_chkpwd_t usr_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t usr_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read bin and sbin directories.
#line 4264
allow sysadm_chkpwd_t bin_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264
allow sysadm_chkpwd_t sbin_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264

#line 4264
# Read directories and files with the readable_t type.
#line 4264
# This type is a general type for "world"-readable files.
#line 4264
allow sysadm_chkpwd_t readable_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t readable_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Stat /...security and lost+found.
#line 4264
allow sysadm_chkpwd_t file_labels_t:dir getattr;
#line 4264
allow sysadm_chkpwd_t lost_found_t:dir getattr;
#line 4264

#line 4264
# Read the devpts root directory.  
#line 4264
allow sysadm_chkpwd_t devpts_t:dir { read getattr lock search ioctl };
#line 4264

#line 4264

#line 4264
# Read the /tmp directory and any /tmp files with the base type.
#line 4264
# Temporary files created at runtime will typically use derived types.
#line 4264
allow sysadm_chkpwd_t tmp_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t tmp_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /var.
#line 4264
allow sysadm_chkpwd_t var_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t var_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /var/catman.
#line 4264
allow sysadm_chkpwd_t catman_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t catman_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /var/lib.
#line 4264
allow sysadm_chkpwd_t var_lib_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t var_lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264
allow sysadm_chkpwd_t var_lib_nfs_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t var_lib_nfs_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264

#line 4264
allow sysadm_chkpwd_t tetex_data_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t tetex_data_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264

#line 4264
# Read /var/yp.
#line 4264
allow sysadm_chkpwd_t var_yp_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t var_yp_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /var/spool.
#line 4264
allow sysadm_chkpwd_t var_spool_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t var_spool_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /var/run, /var/lock, /var/log.
#line 4264
allow sysadm_chkpwd_t var_run_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t var_run_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_chkpwd_t var_log_t:dir { read getattr lock search ioctl };
#line 4264
#allow sysadm_chkpwd_t var_log_t:{ file lnk_file } r_file_perms;
#line 4264
allow sysadm_chkpwd_t var_log_sa_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t var_log_sa_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_chkpwd_t var_log_ksyms_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264
allow sysadm_chkpwd_t var_lock_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t var_lock_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /var/run/utmp and /var/log/wtmp.
#line 4264
allow sysadm_chkpwd_t initrc_var_run_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_chkpwd_t wtmp_t:file { read getattr lock ioctl };
#line 4264

#line 4264
# Read /boot, /boot/System.map*, and /vmlinuz*
#line 4264
allow sysadm_chkpwd_t boot_t:dir { search getattr };
#line 4264
allow sysadm_chkpwd_t boot_t:file getattr;
#line 4264
allow sysadm_chkpwd_t system_map_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264
allow sysadm_chkpwd_t boot_t:lnk_file read;
#line 4264

#line 4264
# Read /etc.
#line 4264
allow sysadm_chkpwd_t etc_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t etc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264
allow sysadm_chkpwd_t etc_runtime_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_chkpwd_t etc_aliases_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_chkpwd_t etc_mail_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t etc_mail_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_chkpwd_t resolv_conf_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_chkpwd_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4264

#line 4264
# Read /lib.
#line 4264
allow sysadm_chkpwd_t lib_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read the linker, shared library, and executable types.
#line 4264
allow sysadm_chkpwd_t ld_so_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_chkpwd_t shlib_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_chkpwd_t exec_type:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read man directories and files.
#line 4264
allow sysadm_chkpwd_t man_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t man_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /usr/src.
#line 4264
allow sysadm_chkpwd_t src_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t src_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read module-related files.
#line 4264
allow sysadm_chkpwd_t modules_object_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t modules_object_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_chkpwd_t modules_dep_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_chkpwd_t modules_conf_t:{ file lnk_file} { read getattr lock ioctl };
#line 4264

#line 4264
# Read /dev directories and any symbolic links.
#line 4264
allow sysadm_chkpwd_t device_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t device_t:lnk_file { read getattr lock ioctl };
#line 4264

#line 4264
# Read /dev/random and /dev/zero.
#line 4264
allow sysadm_chkpwd_t random_device_t:chr_file { read getattr lock ioctl };
#line 4264
allow sysadm_chkpwd_t zero_device_t:chr_file { read getattr lock ioctl };
#line 4264

#line 4264
# Read the root directory of a tmpfs filesytem and any symbolic links.
#line 4264
allow sysadm_chkpwd_t tmpfs_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t tmpfs_t:lnk_file { read getattr lock ioctl };
#line 4264

#line 4264
# Read any symbolic links on a devfs file system.
#line 4264
allow sysadm_chkpwd_t device_t:lnk_file { read getattr lock ioctl };
#line 4264

#line 4264
# Read the root directory of a usbdevfs filesystem, and
#line 4264
# the devices and drivers files.  Permit stating of the
#line 4264
# device nodes, but nothing else.
#line 4264
allow sysadm_chkpwd_t usbdevfs_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t usbdevfs_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_chkpwd_t usbdevfs_device_t:file getattr;
#line 4264

#line 4264

#line 4264
# Grant write permissions to a small set of system file types.
#line 4264
# No permission to create files is granted here.  Use allow rules to grant 
#line 4264
# create permissions to a type or use file_type_auto_trans rules to set up
#line 4264
# new types for files.
#line 4264

#line 4264

#line 4264
# Read and write /dev/tty and /dev/null.
#line 4264
allow sysadm_chkpwd_t devtty_t:chr_file { ioctl read getattr lock write append };
#line 4264
allow sysadm_chkpwd_t { null_device_t zero_device_t }:chr_file { ioctl read getattr lock write append };
#line 4264

#line 4264
# Do not audit write denials to /etc/ld.so.cache.
#line 4264
dontaudit sysadm_chkpwd_t ld_so_cache_t:file write;
#line 4264

#line 4264

#line 4264
# Execute from the system shared libraries.
#line 4264
# No permission to execute anything else is granted here.
#line 4264
# Use can_exec or can_exec_any to grant the ability to execute within a domain.
#line 4264
# Use domain_auto_trans for executing and changing domains.
#line 4264

#line 4264
allow sysadm_chkpwd_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t ld_so_t:file { read getattr lock execute ioctl };
#line 4264
allow sysadm_chkpwd_t ld_so_t:file execute_no_trans;
#line 4264
allow sysadm_chkpwd_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4264
allow sysadm_chkpwd_t shlib_t:file { read getattr lock execute ioctl };
#line 4264
allow sysadm_chkpwd_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4264
allow sysadm_chkpwd_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_chkpwd_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4264

#line 4264

#line 4264
# read localization information
#line 4264
allow sysadm_chkpwd_t locale_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_chkpwd_t locale_t:{file lnk_file} { read getattr lock ioctl };
#line 4264

#line 4264
# Obtain the context of any SID, the SID for any context, 
#line 4264
# and the list of active SIDs.
#line 4264
allow sysadm_chkpwd_t security_t:security { sid_to_context context_to_sid get_sids };
#line 4264

#line 4264

#line 4264

#line 4264
# Grant permissions needed to create TCP and UDP sockets and 
#line 4264
# to access the network.
#line 4264

#line 4264
#
#line 4264
# Allow the domain to create and use UDP and TCP sockets.
#line 4264
# Other kinds of sockets must be separately authorized for use.
#line 4264
allow sysadm_chkpwd_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4264
allow sysadm_chkpwd_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4264

#line 4264
#
#line 4264
# Allow the domain to send UDP packets.
#line 4264
# Since the destination sockets type is unknown, the generic
#line 4264
# any_socket_t type is used as a placeholder.
#line 4264
#
#line 4264
allow sysadm_chkpwd_t any_socket_t:udp_socket sendto;
#line 4264

#line 4264
#
#line 4264
# Allow the domain to send using any network interface.
#line 4264
# netif_type is a type attribute for all network interface types.
#line 4264
#
#line 4264
allow sysadm_chkpwd_t netif_type:netif { tcp_send udp_send rawip_send };
#line 4264

#line 4264
#
#line 4264
# Allow packets sent by the domain to be received on any network interface.
#line 4264
#
#line 4264
allow sysadm_chkpwd_t netif_type:netif { tcp_recv udp_recv rawip_recv };
#line 4264

#line 4264
#
#line 4264
# Allow the domain to receive packets from any network interface.
#line 4264
# netmsg_type is a type attribute for all default message types.
#line 4264
#
#line 4264
allow sysadm_chkpwd_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
#line 4264

#line 4264
#
#line 4264
# Allow the domain to initiate or accept TCP connections 
#line 4264
# on any network interface.
#line 4264
#
#line 4264
allow sysadm_chkpwd_t netmsg_type:tcp_socket { connectto acceptfrom };
#line 4264

#line 4264
#
#line 4264
# Receive resets from the TCP reset socket.
#line 4264
# The TCP reset socket is labeled with the tcp_socket_t type.
#line 4264
#
#line 4264
allow sysadm_chkpwd_t tcp_socket_t:tcp_socket recvfrom;
#line 4264

#line 4264
dontaudit sysadm_chkpwd_t tcp_socket_t:tcp_socket connectto;
#line 4264

#line 4264
#
#line 4264
# Allow the domain to send to any node.
#line 4264
# node_type is a type attribute for all node types.
#line 4264
#
#line 4264
allow sysadm_chkpwd_t node_type:node { tcp_send udp_send rawip_send };
#line 4264

#line 4264
#
#line 4264
# Allow packets sent by the domain to be received from any node.
#line 4264
#
#line 4264
allow sysadm_chkpwd_t node_type:node { tcp_recv udp_recv rawip_recv };
#line 4264

#line 4264
#
#line 4264
# Allow the domain to send NFS client requests via the socket
#line 4264
# created by mount.
#line 4264
#
#line 4264
allow sysadm_chkpwd_t mount_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4264

#line 4264
#
#line 4264
# Bind to the default port type.
#line 4264
# Other port types must be separately authorized.
#line 4264
#
#line 4264
allow sysadm_chkpwd_t port_t:udp_socket name_bind;
#line 4264
allow sysadm_chkpwd_t port_t:tcp_socket name_bind;
#line 4264

#line 4264

#line 4264

#line 4264
# Use capabilities.
#line 4264
allow sysadm_chkpwd_t self:capability setuid;
#line 4264

#line 4264
# Inherit and use descriptors from gnome-pty-helper.
#line 4264

#line 4264

#line 4264
# Inherit and use descriptors from newrole.
#line 4264
allow sysadm_chkpwd_t newrole_t:fd use;
#line 4264

#line 4264
# Write to the user domain tty.
#line 4264
allow sysadm_chkpwd_t sysadm_tty_device_t:chr_file { ioctl read getattr lock write append };
#line 4264
allow sysadm_chkpwd_t sysadm_devpts_t:chr_file { ioctl read getattr lock write append };
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
# Derived domain based on the calling user domain and the program.
#line 4264
type sysadm_xauth_t, domain;
#line 4264
type sysadm_home_xauth_t, file_type, sysadmfile;
#line 4264

#line 4264
allow sysadm_t sysadm_home_xauth_t:file { relabelfrom relabelto { create ioctl read getattr lock write setattr append link unlink rename } };
#line 4264

#line 4264
# Transition from the user domain to this domain.
#line 4264

#line 4264

#line 4264

#line 4264
#
#line 4264
# Allow the process to transition to the new domain.
#line 4264
#
#line 4264
allow sysadm_t sysadm_xauth_t:process transition;
#line 4264

#line 4264
#
#line 4264
# Allow the process to execute the program.
#line 4264
# 
#line 4264
allow sysadm_t xauth_exec_t:file { getattr execute };
#line 4264

#line 4264
#
#line 4264
# Allow the process to reap the new domain.
#line 4264
#
#line 4264
allow sysadm_xauth_t sysadm_t:process sigchld;
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to inherit and use file 
#line 4264
# descriptions from the creating process and vice versa.
#line 4264
#
#line 4264
allow sysadm_xauth_t sysadm_t:fd use;
#line 4264
allow sysadm_t sysadm_xauth_t:fd use;
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to write back to the old domain via a pipe.
#line 4264
#
#line 4264
allow sysadm_xauth_t sysadm_t:fifo_file { ioctl read getattr lock write append };
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to read and execute the program.
#line 4264
#
#line 4264
allow sysadm_xauth_t xauth_exec_t:file { read getattr lock execute ioctl };
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to be entered via the program.
#line 4264
#
#line 4264
allow sysadm_xauth_t xauth_exec_t:file entrypoint;
#line 4264

#line 4264
type_transition sysadm_t xauth_exec_t:process sysadm_xauth_t;
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
#
#line 4264
# Allow the process to transition to the new domain.
#line 4264
#
#line 4264
allow sysadm_ssh_t sysadm_xauth_t:process transition;
#line 4264

#line 4264
#
#line 4264
# Allow the process to execute the program.
#line 4264
# 
#line 4264
allow sysadm_ssh_t xauth_exec_t:file { getattr execute };
#line 4264

#line 4264
#
#line 4264
# Allow the process to reap the new domain.
#line 4264
#
#line 4264
allow sysadm_xauth_t sysadm_ssh_t:process sigchld;
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to inherit and use file 
#line 4264
# descriptions from the creating process and vice versa.
#line 4264
#
#line 4264
allow sysadm_xauth_t sysadm_ssh_t:fd use;
#line 4264
allow sysadm_ssh_t sysadm_xauth_t:fd use;
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to write back to the old domain via a pipe.
#line 4264
#
#line 4264
allow sysadm_xauth_t sysadm_ssh_t:fifo_file { ioctl read getattr lock write append };
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to read and execute the program.
#line 4264
#
#line 4264
allow sysadm_xauth_t xauth_exec_t:file { read getattr lock execute ioctl };
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to be entered via the program.
#line 4264
#
#line 4264
allow sysadm_xauth_t xauth_exec_t:file entrypoint;
#line 4264

#line 4264
type_transition sysadm_ssh_t xauth_exec_t:process sysadm_xauth_t;
#line 4264

#line 4264
allow sysadm_xauth_t sshd_t:fifo_file { getattr read };
#line 4264
dontaudit sysadm_xauth_t sysadm_ssh_t:tcp_socket { read write };
#line 4264
allow sysadm_xauth_t sshd_t:process sigchld;
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
#
#line 4264
# Allow the process to transition to the new domain.
#line 4264
#
#line 4264
allow sysadm_su_t sysadm_xauth_t:process transition;
#line 4264

#line 4264
#
#line 4264
# Allow the process to execute the program.
#line 4264
# 
#line 4264
allow sysadm_su_t xauth_exec_t:file { getattr execute };
#line 4264

#line 4264
#
#line 4264
# Allow the process to reap the new domain.
#line 4264
#
#line 4264
allow sysadm_xauth_t sysadm_su_t:process sigchld;
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to inherit and use file 
#line 4264
# descriptions from the creating process and vice versa.
#line 4264
#
#line 4264
allow sysadm_xauth_t sysadm_su_t:fd use;
#line 4264
allow sysadm_su_t sysadm_xauth_t:fd use;
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to write back to the old domain via a pipe.
#line 4264
#
#line 4264
allow sysadm_xauth_t sysadm_su_t:fifo_file { ioctl read getattr lock write append };
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to read and execute the program.
#line 4264
#
#line 4264
allow sysadm_xauth_t xauth_exec_t:file { read getattr lock execute ioctl };
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to be entered via the program.
#line 4264
#
#line 4264
allow sysadm_xauth_t xauth_exec_t:file entrypoint;
#line 4264

#line 4264
type_transition sysadm_su_t xauth_exec_t:process sysadm_xauth_t;
#line 4264

#line 4264

#line 4264

#line 4264
# The user role is authorized for this domain.
#line 4264
role sysadm_r types sysadm_xauth_t;
#line 4264

#line 4264
# Inherit and use descriptors from gnome-pty-helper.
#line 4264

#line 4264

#line 4264
allow sysadm_xauth_t privfd:fd use;
#line 4264

#line 4264
# allow ps to show xauth
#line 4264
allow sysadm_t sysadm_xauth_t:dir { search getattr read };
#line 4264
allow sysadm_t sysadm_xauth_t:{ file lnk_file } { read getattr };
#line 4264
allow sysadm_t sysadm_xauth_t:process signal;
#line 4264

#line 4264

#line 4264
allow sysadm_xauth_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_xauth_t ld_so_t:file { read getattr lock execute ioctl };
#line 4264
allow sysadm_xauth_t ld_so_t:file execute_no_trans;
#line 4264
allow sysadm_xauth_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4264
allow sysadm_xauth_t shlib_t:file { read getattr lock execute ioctl };
#line 4264
allow sysadm_xauth_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4264
allow sysadm_xauth_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_xauth_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4264

#line 4264

#line 4264
# allow DNS lookups...
#line 4264

#line 4264
#
#line 4264
# Allow the domain to create and use UDP and TCP sockets.
#line 4264
# Other kinds of sockets must be separately authorized for use.
#line 4264
allow sysadm_xauth_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4264
allow sysadm_xauth_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4264

#line 4264
#
#line 4264
# Allow the domain to send UDP packets.
#line 4264
# Since the destination sockets type is unknown, the generic
#line 4264
# any_socket_t type is used as a placeholder.
#line 4264
#
#line 4264
allow sysadm_xauth_t any_socket_t:udp_socket sendto;
#line 4264

#line 4264
#
#line 4264
# Allow the domain to send using any network interface.
#line 4264
# netif_type is a type attribute for all network interface types.
#line 4264
#
#line 4264
allow sysadm_xauth_t netif_type:netif { tcp_send udp_send rawip_send };
#line 4264

#line 4264
#
#line 4264
# Allow packets sent by the domain to be received on any network interface.
#line 4264
#
#line 4264
allow sysadm_xauth_t netif_type:netif { tcp_recv udp_recv rawip_recv };
#line 4264

#line 4264
#
#line 4264
# Allow the domain to receive packets from any network interface.
#line 4264
# netmsg_type is a type attribute for all default message types.
#line 4264
#
#line 4264
allow sysadm_xauth_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
#line 4264

#line 4264
#
#line 4264
# Allow the domain to initiate or accept TCP connections 
#line 4264
# on any network interface.
#line 4264
#
#line 4264
allow sysadm_xauth_t netmsg_type:tcp_socket { connectto acceptfrom };
#line 4264

#line 4264
#
#line 4264
# Receive resets from the TCP reset socket.
#line 4264
# The TCP reset socket is labeled with the tcp_socket_t type.
#line 4264
#
#line 4264
allow sysadm_xauth_t tcp_socket_t:tcp_socket recvfrom;
#line 4264

#line 4264
dontaudit sysadm_xauth_t tcp_socket_t:tcp_socket connectto;
#line 4264

#line 4264
#
#line 4264
# Allow the domain to send to any node.
#line 4264
# node_type is a type attribute for all node types.
#line 4264
#
#line 4264
allow sysadm_xauth_t node_type:node { tcp_send udp_send rawip_send };
#line 4264

#line 4264
#
#line 4264
# Allow packets sent by the domain to be received from any node.
#line 4264
#
#line 4264
allow sysadm_xauth_t node_type:node { tcp_recv udp_recv rawip_recv };
#line 4264

#line 4264
#
#line 4264
# Allow the domain to send NFS client requests via the socket
#line 4264
# created by mount.
#line 4264
#
#line 4264
allow sysadm_xauth_t mount_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4264

#line 4264
#
#line 4264
# Bind to the default port type.
#line 4264
# Other port types must be separately authorized.
#line 4264
#
#line 4264
allow sysadm_xauth_t port_t:udp_socket name_bind;
#line 4264
allow sysadm_xauth_t port_t:tcp_socket name_bind;
#line 4264

#line 4264

#line 4264

#line 4264
#allow sysadm_xauth_t devpts_t:dir { getattr read search };
#line 4264
#allow sysadm_xauth_t device_t:dir search;
#line 4264
#allow sysadm_xauth_t devtty_t:chr_file rw_file_perms;
#line 4264
allow sysadm_xauth_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4264
allow sysadm_xauth_t { etc_t resolv_conf_t }:file { getattr read };
#line 4264
allow sysadm_xauth_t fs_t:filesystem getattr;
#line 4264

#line 4264
#allow sysadm_xauth_t proc_t:dir search;
#line 4264
#allow sysadm_xauth_t { self proc_t }:lnk_file read;
#line 4264
#allow sysadm_xauth_t self:dir search;
#line 4264
#dontaudit sysadm_xauth_t var_run_t:dir search;
#line 4264

#line 4264
# Write to the user domain tty.
#line 4264
allow sysadm_xauth_t sysadm_tty_device_t:chr_file { ioctl read getattr lock write append };
#line 4264
allow sysadm_xauth_t sysadm_devpts_t:chr_file { ioctl read getattr lock write append };
#line 4264

#line 4264
# allow utmp access
#line 4264
#allow sysadm_xauth_t initrc_var_run_t:file read;
#line 4264
#dontaudit sysadm_xauth_t initrc_var_run_t:file lock;
#line 4264

#line 4264
# Scan /var/run.
#line 4264
allow sysadm_xauth_t var_t:dir search;
#line 4264
allow sysadm_xauth_t var_run_t:dir search; 
#line 4264

#line 4264
# this is what we are here for
#line 4264
allow sysadm_xauth_t home_root_t:dir search;
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
#
#line 4264
# Allow the process to modify the directory.
#line 4264
#
#line 4264
allow sysadm_xauth_t sysadm_home_dir_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4264

#line 4264
#
#line 4264
# Allow the process to create the file.
#line 4264
#
#line 4264

#line 4264
allow sysadm_xauth_t sysadm_home_xauth_t:file { create ioctl read getattr lock write setattr append link unlink rename };
#line 4264

#line 4264

#line 4264

#line 4264
type_transition sysadm_xauth_t sysadm_home_dir_t:file sysadm_home_xauth_t;
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
# Derived domain based on the calling user domain and the program.
#line 4264
type sysadm_crontab_t, domain, privlog;
#line 4264

#line 4264
# Transition from the user domain to the derived domain.
#line 4264

#line 4264

#line 4264

#line 4264
#
#line 4264
# Allow the process to transition to the new domain.
#line 4264
#
#line 4264
allow sysadm_t sysadm_crontab_t:process transition;
#line 4264

#line 4264
#
#line 4264
# Allow the process to execute the program.
#line 4264
# 
#line 4264
allow sysadm_t crontab_exec_t:file { getattr execute };
#line 4264

#line 4264
#
#line 4264
# Allow the process to reap the new domain.
#line 4264
#
#line 4264
allow sysadm_crontab_t sysadm_t:process sigchld;
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to inherit and use file 
#line 4264
# descriptions from the creating process and vice versa.
#line 4264
#
#line 4264
allow sysadm_crontab_t sysadm_t:fd use;
#line 4264
allow sysadm_t sysadm_crontab_t:fd use;
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to write back to the old domain via a pipe.
#line 4264
#
#line 4264
allow sysadm_crontab_t sysadm_t:fifo_file { ioctl read getattr lock write append };
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to read and execute the program.
#line 4264
#
#line 4264
allow sysadm_crontab_t crontab_exec_t:file { read getattr lock execute ioctl };
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to be entered via the program.
#line 4264
#
#line 4264
allow sysadm_crontab_t crontab_exec_t:file entrypoint;
#line 4264

#line 4264
type_transition sysadm_t crontab_exec_t:process sysadm_crontab_t;
#line 4264

#line 4264

#line 4264
# The user role is authorized for this domain.
#line 4264
role sysadm_r types sysadm_crontab_t;
#line 4264

#line 4264
# This domain is granted permissions common to most domains (including can_net)
#line 4264

#line 4264

#line 4264
# Grant the permissions common to the test domains.
#line 4264

#line 4264
# Grant permissions within the domain.
#line 4264

#line 4264
# Access other processes in the same domain.
#line 4264
allow sysadm_crontab_t self:process *;
#line 4264

#line 4264
# Access /proc/PID files for processes in the same domain.
#line 4264
allow sysadm_crontab_t self:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Access file descriptions, pipes, and sockets
#line 4264
# created by processes in the same domain.
#line 4264
allow sysadm_crontab_t self:fd *;
#line 4264
allow sysadm_crontab_t self:fifo_file { ioctl read getattr lock write append };
#line 4264
allow sysadm_crontab_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4264
allow sysadm_crontab_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4264

#line 4264
# Allow the domain to communicate with other processes in the same domain.
#line 4264
allow sysadm_crontab_t self:unix_dgram_socket sendto;
#line 4264
allow sysadm_crontab_t self:unix_stream_socket connectto;
#line 4264

#line 4264
# Access System V IPC objects created by processes in the same domain.
#line 4264
allow sysadm_crontab_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 4264
allow sysadm_crontab_t self:msg  { send receive };
#line 4264
allow sysadm_crontab_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 4264
allow sysadm_crontab_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 4264

#line 4264

#line 4264

#line 4264
# Grant read/search permissions to most of /proc.
#line 4264

#line 4264
# Read system information files in /proc.
#line 4264
allow sysadm_crontab_t proc_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t proc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Stat /proc/kmsg and /proc/kcore.
#line 4264
allow sysadm_crontab_t proc_kmsg_t:file { getattr };
#line 4264
allow sysadm_crontab_t proc_kcore_t:file { getattr };
#line 4264

#line 4264
# Read system variables in /proc/sys.
#line 4264
allow sysadm_crontab_t sysctl_modprobe_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_crontab_t sysctl_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_crontab_t sysctl_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t sysctl_fs_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_crontab_t sysctl_fs_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t sysctl_kernel_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_crontab_t sysctl_kernel_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t sysctl_net_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_crontab_t sysctl_net_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t sysctl_vm_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_crontab_t sysctl_vm_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t sysctl_dev_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_crontab_t sysctl_dev_t:dir { read getattr lock search ioctl };
#line 4264

#line 4264

#line 4264
# Grant read/search permissions to many system file types.
#line 4264

#line 4264

#line 4264
# Get attributes of file systems.
#line 4264
allow sysadm_crontab_t fs_type:filesystem getattr;
#line 4264

#line 4264

#line 4264
# Read /.
#line 4264
allow sysadm_crontab_t root_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t root_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /home.
#line 4264
allow sysadm_crontab_t home_root_t:dir { read getattr lock search ioctl };
#line 4264

#line 4264
# Read /usr.
#line 4264
allow sysadm_crontab_t usr_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t usr_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read bin and sbin directories.
#line 4264
allow sysadm_crontab_t bin_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264
allow sysadm_crontab_t sbin_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264

#line 4264
# Read directories and files with the readable_t type.
#line 4264
# This type is a general type for "world"-readable files.
#line 4264
allow sysadm_crontab_t readable_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t readable_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Stat /...security and lost+found.
#line 4264
allow sysadm_crontab_t file_labels_t:dir getattr;
#line 4264
allow sysadm_crontab_t lost_found_t:dir getattr;
#line 4264

#line 4264
# Read the devpts root directory.  
#line 4264
allow sysadm_crontab_t devpts_t:dir { read getattr lock search ioctl };
#line 4264

#line 4264

#line 4264
# Read the /tmp directory and any /tmp files with the base type.
#line 4264
# Temporary files created at runtime will typically use derived types.
#line 4264
allow sysadm_crontab_t tmp_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t tmp_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /var.
#line 4264
allow sysadm_crontab_t var_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t var_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /var/catman.
#line 4264
allow sysadm_crontab_t catman_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t catman_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /var/lib.
#line 4264
allow sysadm_crontab_t var_lib_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t var_lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264
allow sysadm_crontab_t var_lib_nfs_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t var_lib_nfs_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264

#line 4264
allow sysadm_crontab_t tetex_data_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t tetex_data_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264

#line 4264
# Read /var/yp.
#line 4264
allow sysadm_crontab_t var_yp_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t var_yp_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /var/spool.
#line 4264
allow sysadm_crontab_t var_spool_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t var_spool_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /var/run, /var/lock, /var/log.
#line 4264
allow sysadm_crontab_t var_run_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t var_run_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_crontab_t var_log_t:dir { read getattr lock search ioctl };
#line 4264
#allow sysadm_crontab_t var_log_t:{ file lnk_file } r_file_perms;
#line 4264
allow sysadm_crontab_t var_log_sa_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t var_log_sa_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_crontab_t var_log_ksyms_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264
allow sysadm_crontab_t var_lock_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t var_lock_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /var/run/utmp and /var/log/wtmp.
#line 4264
allow sysadm_crontab_t initrc_var_run_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_crontab_t wtmp_t:file { read getattr lock ioctl };
#line 4264

#line 4264
# Read /boot, /boot/System.map*, and /vmlinuz*
#line 4264
allow sysadm_crontab_t boot_t:dir { search getattr };
#line 4264
allow sysadm_crontab_t boot_t:file getattr;
#line 4264
allow sysadm_crontab_t system_map_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264
allow sysadm_crontab_t boot_t:lnk_file read;
#line 4264

#line 4264
# Read /etc.
#line 4264
allow sysadm_crontab_t etc_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t etc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264
allow sysadm_crontab_t etc_runtime_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_crontab_t etc_aliases_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_crontab_t etc_mail_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t etc_mail_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_crontab_t resolv_conf_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_crontab_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4264

#line 4264
# Read /lib.
#line 4264
allow sysadm_crontab_t lib_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read the linker, shared library, and executable types.
#line 4264
allow sysadm_crontab_t ld_so_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_crontab_t shlib_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_crontab_t exec_type:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read man directories and files.
#line 4264
allow sysadm_crontab_t man_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t man_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /usr/src.
#line 4264
allow sysadm_crontab_t src_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t src_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read module-related files.
#line 4264
allow sysadm_crontab_t modules_object_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t modules_object_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_crontab_t modules_dep_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_crontab_t modules_conf_t:{ file lnk_file} { read getattr lock ioctl };
#line 4264

#line 4264
# Read /dev directories and any symbolic links.
#line 4264
allow sysadm_crontab_t device_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t device_t:lnk_file { read getattr lock ioctl };
#line 4264

#line 4264
# Read /dev/random and /dev/zero.
#line 4264
allow sysadm_crontab_t random_device_t:chr_file { read getattr lock ioctl };
#line 4264
allow sysadm_crontab_t zero_device_t:chr_file { read getattr lock ioctl };
#line 4264

#line 4264
# Read the root directory of a tmpfs filesytem and any symbolic links.
#line 4264
allow sysadm_crontab_t tmpfs_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t tmpfs_t:lnk_file { read getattr lock ioctl };
#line 4264

#line 4264
# Read any symbolic links on a devfs file system.
#line 4264
allow sysadm_crontab_t device_t:lnk_file { read getattr lock ioctl };
#line 4264

#line 4264
# Read the root directory of a usbdevfs filesystem, and
#line 4264
# the devices and drivers files.  Permit stating of the
#line 4264
# device nodes, but nothing else.
#line 4264
allow sysadm_crontab_t usbdevfs_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t usbdevfs_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_crontab_t usbdevfs_device_t:file getattr;
#line 4264

#line 4264

#line 4264
# Grant write permissions to a small set of system file types.
#line 4264
# No permission to create files is granted here.  Use allow rules to grant 
#line 4264
# create permissions to a type or use file_type_auto_trans rules to set up
#line 4264
# new types for files.
#line 4264

#line 4264

#line 4264
# Read and write /dev/tty and /dev/null.
#line 4264
allow sysadm_crontab_t devtty_t:chr_file { ioctl read getattr lock write append };
#line 4264
allow sysadm_crontab_t { null_device_t zero_device_t }:chr_file { ioctl read getattr lock write append };
#line 4264

#line 4264
# Do not audit write denials to /etc/ld.so.cache.
#line 4264
dontaudit sysadm_crontab_t ld_so_cache_t:file write;
#line 4264

#line 4264

#line 4264
# Execute from the system shared libraries.
#line 4264
# No permission to execute anything else is granted here.
#line 4264
# Use can_exec or can_exec_any to grant the ability to execute within a domain.
#line 4264
# Use domain_auto_trans for executing and changing domains.
#line 4264

#line 4264
allow sysadm_crontab_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t ld_so_t:file { read getattr lock execute ioctl };
#line 4264
allow sysadm_crontab_t ld_so_t:file execute_no_trans;
#line 4264
allow sysadm_crontab_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4264
allow sysadm_crontab_t shlib_t:file { read getattr lock execute ioctl };
#line 4264
allow sysadm_crontab_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4264
allow sysadm_crontab_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_crontab_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4264

#line 4264

#line 4264
# read localization information
#line 4264
allow sysadm_crontab_t locale_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crontab_t locale_t:{file lnk_file} { read getattr lock ioctl };
#line 4264

#line 4264
# Obtain the context of any SID, the SID for any context, 
#line 4264
# and the list of active SIDs.
#line 4264
allow sysadm_crontab_t security_t:security { sid_to_context context_to_sid get_sids };
#line 4264

#line 4264

#line 4264

#line 4264
# Grant permissions needed to create TCP and UDP sockets and 
#line 4264
# to access the network.
#line 4264

#line 4264
#
#line 4264
# Allow the domain to create and use UDP and TCP sockets.
#line 4264
# Other kinds of sockets must be separately authorized for use.
#line 4264
allow sysadm_crontab_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4264
allow sysadm_crontab_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4264

#line 4264
#
#line 4264
# Allow the domain to send UDP packets.
#line 4264
# Since the destination sockets type is unknown, the generic
#line 4264
# any_socket_t type is used as a placeholder.
#line 4264
#
#line 4264
allow sysadm_crontab_t any_socket_t:udp_socket sendto;
#line 4264

#line 4264
#
#line 4264
# Allow the domain to send using any network interface.
#line 4264
# netif_type is a type attribute for all network interface types.
#line 4264
#
#line 4264
allow sysadm_crontab_t netif_type:netif { tcp_send udp_send rawip_send };
#line 4264

#line 4264
#
#line 4264
# Allow packets sent by the domain to be received on any network interface.
#line 4264
#
#line 4264
allow sysadm_crontab_t netif_type:netif { tcp_recv udp_recv rawip_recv };
#line 4264

#line 4264
#
#line 4264
# Allow the domain to receive packets from any network interface.
#line 4264
# netmsg_type is a type attribute for all default message types.
#line 4264
#
#line 4264
allow sysadm_crontab_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
#line 4264

#line 4264
#
#line 4264
# Allow the domain to initiate or accept TCP connections 
#line 4264
# on any network interface.
#line 4264
#
#line 4264
allow sysadm_crontab_t netmsg_type:tcp_socket { connectto acceptfrom };
#line 4264

#line 4264
#
#line 4264
# Receive resets from the TCP reset socket.
#line 4264
# The TCP reset socket is labeled with the tcp_socket_t type.
#line 4264
#
#line 4264
allow sysadm_crontab_t tcp_socket_t:tcp_socket recvfrom;
#line 4264

#line 4264
dontaudit sysadm_crontab_t tcp_socket_t:tcp_socket connectto;
#line 4264

#line 4264
#
#line 4264
# Allow the domain to send to any node.
#line 4264
# node_type is a type attribute for all node types.
#line 4264
#
#line 4264
allow sysadm_crontab_t node_type:node { tcp_send udp_send rawip_send };
#line 4264

#line 4264
#
#line 4264
# Allow packets sent by the domain to be received from any node.
#line 4264
#
#line 4264
allow sysadm_crontab_t node_type:node { tcp_recv udp_recv rawip_recv };
#line 4264

#line 4264
#
#line 4264
# Allow the domain to send NFS client requests via the socket
#line 4264
# created by mount.
#line 4264
#
#line 4264
allow sysadm_crontab_t mount_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4264

#line 4264
#
#line 4264
# Bind to the default port type.
#line 4264
# Other port types must be separately authorized.
#line 4264
#
#line 4264
allow sysadm_crontab_t port_t:udp_socket name_bind;
#line 4264
allow sysadm_crontab_t port_t:tcp_socket name_bind;
#line 4264

#line 4264

#line 4264

#line 4264
# Use capabilities
#line 4264
allow sysadm_crontab_t sysadm_crontab_t:capability { setuid setgid chown };
#line 4264

#line 4264
# Type for temporary files.
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
#
#line 4264
# Allow the process to modify the directory.
#line 4264
#
#line 4264
allow sysadm_crontab_t tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4264

#line 4264
#
#line 4264
# Allow the process to create the file.
#line 4264
#
#line 4264

#line 4264
allow sysadm_crontab_t sysadm_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4264
allow sysadm_crontab_t sysadm_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4264

#line 4264

#line 4264

#line 4264
type_transition sysadm_crontab_t tmp_t:dir sysadm_tmp_t;
#line 4264
type_transition sysadm_crontab_t tmp_t:{ file lnk_file sock_file fifo_file } sysadm_tmp_t;
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
# Type of user crontabs once moved to cron spool.
#line 4264
type sysadm_cron_spool_t, file_type, sysadmfile;
#line 4264
# Use the type when creating files in /var/spool/cron.
#line 4264
allow sysadm_crontab_t sysadm_cron_spool_t:file { getattr read };
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
#
#line 4264
# Allow the process to modify the directory.
#line 4264
#
#line 4264
allow sysadm_crontab_t cron_spool_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4264

#line 4264
#
#line 4264
# Allow the process to create the file.
#line 4264
#
#line 4264

#line 4264
allow sysadm_crontab_t sysadm_cron_spool_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4264
allow sysadm_crontab_t sysadm_cron_spool_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4264

#line 4264

#line 4264

#line 4264
type_transition sysadm_crontab_t cron_spool_t:dir sysadm_cron_spool_t;
#line 4264
type_transition sysadm_crontab_t cron_spool_t:{ file lnk_file sock_file fifo_file } sysadm_cron_spool_t;
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
# crontab signals crond by updating the mtime on the spooldir
#line 4264
allow sysadm_crontab_t cron_spool_t:dir setattr;
#line 4264
# Allow crond to read those crontabs in cron spool.
#line 4264
allow crond_t sysadm_cron_spool_t:file { read getattr lock ioctl };
#line 4264

#line 4264
# Run helper programs as sysadm_t
#line 4264

#line 4264

#line 4264

#line 4264
#
#line 4264
# Allow the process to transition to the new domain.
#line 4264
#
#line 4264
allow sysadm_crontab_t sysadm_t:process transition;
#line 4264

#line 4264
#
#line 4264
# Allow the process to execute the program.
#line 4264
# 
#line 4264
allow sysadm_crontab_t { bin_t sbin_t exec_type }:file { getattr execute };
#line 4264

#line 4264
#
#line 4264
# Allow the process to reap the new domain.
#line 4264
#
#line 4264
allow sysadm_t sysadm_crontab_t:process sigchld;
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to inherit and use file 
#line 4264
# descriptions from the creating process and vice versa.
#line 4264
#
#line 4264
allow sysadm_t sysadm_crontab_t:fd use;
#line 4264
allow sysadm_crontab_t sysadm_t:fd use;
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to write back to the old domain via a pipe.
#line 4264
#
#line 4264
allow sysadm_t sysadm_crontab_t:fifo_file { ioctl read getattr lock write append };
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to read and execute the program.
#line 4264
#
#line 4264
allow sysadm_t { bin_t sbin_t exec_type }:file { read getattr lock execute ioctl };
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to be entered via the program.
#line 4264
#
#line 4264
allow sysadm_t { bin_t sbin_t exec_type }:file entrypoint;
#line 4264

#line 4264
type_transition sysadm_crontab_t { bin_t sbin_t exec_type }:process sysadm_t;
#line 4264

#line 4264

#line 4264
# Read user crontabs 
#line 4264
allow sysadm_crontab_t { sysadm_home_t sysadm_home_dir_t }:dir { read getattr lock search ioctl };  
#line 4264
allow sysadm_crontab_t sysadm_home_t:file { read getattr lock ioctl };  
#line 4264
dontaudit sysadm_crontab_t sysadm_home_dir_t:dir write;
#line 4264

#line 4264
# Access the cron log file.
#line 4264
allow sysadm_crontab_t cron_log_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_crontab_t cron_log_t:file { append };
#line 4264

#line 4264
# Access terminals.
#line 4264
allow sysadm_crontab_t sysadm_tty_device_t:chr_file { ioctl read getattr lock write append };
#line 4264
allow sysadm_crontab_t sysadm_devpts_t:chr_file { ioctl read getattr lock write append };
#line 4264

#line 4264
# Inherit and use descriptors from gnome-pty-helper.
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
# Derived domain based on the calling user domain and the program.
#line 4264
type sysadm_ssh_t, domain, privlog;
#line 4264

#line 4264
# Transition from the user domain to the derived domain.
#line 4264

#line 4264

#line 4264

#line 4264
#
#line 4264
# Allow the process to transition to the new domain.
#line 4264
#
#line 4264
allow sysadm_t sysadm_ssh_t:process transition;
#line 4264

#line 4264
#
#line 4264
# Allow the process to execute the program.
#line 4264
# 
#line 4264
allow sysadm_t ssh_exec_t:file { getattr execute };
#line 4264

#line 4264
#
#line 4264
# Allow the process to reap the new domain.
#line 4264
#
#line 4264
allow sysadm_ssh_t sysadm_t:process sigchld;
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to inherit and use file 
#line 4264
# descriptions from the creating process and vice versa.
#line 4264
#
#line 4264
allow sysadm_ssh_t sysadm_t:fd use;
#line 4264
allow sysadm_t sysadm_ssh_t:fd use;
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to write back to the old domain via a pipe.
#line 4264
#
#line 4264
allow sysadm_ssh_t sysadm_t:fifo_file { ioctl read getattr lock write append };
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to read and execute the program.
#line 4264
#
#line 4264
allow sysadm_ssh_t ssh_exec_t:file { read getattr lock execute ioctl };
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to be entered via the program.
#line 4264
#
#line 4264
allow sysadm_ssh_t ssh_exec_t:file entrypoint;
#line 4264

#line 4264
type_transition sysadm_t ssh_exec_t:process sysadm_ssh_t;
#line 4264

#line 4264

#line 4264
# The user role is authorized for this domain.
#line 4264
role sysadm_r types sysadm_ssh_t;
#line 4264

#line 4264
# Grant permissions within the domain.
#line 4264

#line 4264
# Access other processes in the same domain.
#line 4264
allow sysadm_ssh_t self:process *;
#line 4264

#line 4264
# Access /proc/PID files for processes in the same domain.
#line 4264
allow sysadm_ssh_t self:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_ssh_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Access file descriptions, pipes, and sockets
#line 4264
# created by processes in the same domain.
#line 4264
allow sysadm_ssh_t self:fd *;
#line 4264
allow sysadm_ssh_t self:fifo_file { ioctl read getattr lock write append };
#line 4264
allow sysadm_ssh_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4264
allow sysadm_ssh_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4264

#line 4264
# Allow the domain to communicate with other processes in the same domain.
#line 4264
allow sysadm_ssh_t self:unix_dgram_socket sendto;
#line 4264
allow sysadm_ssh_t self:unix_stream_socket connectto;
#line 4264

#line 4264
# Access System V IPC objects created by processes in the same domain.
#line 4264
allow sysadm_ssh_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 4264
allow sysadm_ssh_t self:msg  { send receive };
#line 4264
allow sysadm_ssh_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 4264
allow sysadm_ssh_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 4264

#line 4264

#line 4264

#line 4264
# Use descriptors created by sshd
#line 4264
allow sysadm_ssh_t privfd:fd use;
#line 4264

#line 4264

#line 4264
allow sysadm_ssh_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_ssh_t ld_so_t:file { read getattr lock execute ioctl };
#line 4264
allow sysadm_ssh_t ld_so_t:file execute_no_trans;
#line 4264
allow sysadm_ssh_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4264
allow sysadm_ssh_t shlib_t:file { read getattr lock execute ioctl };
#line 4264
allow sysadm_ssh_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4264
allow sysadm_ssh_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_ssh_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4264

#line 4264

#line 4264
# read localization information
#line 4264
allow sysadm_ssh_t locale_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_ssh_t locale_t:{file lnk_file} { read getattr lock ioctl };
#line 4264

#line 4264
# Get attributes of file systems.
#line 4264
allow sysadm_ssh_t fs_type:filesystem getattr;
#line 4264

#line 4264

#line 4264
# Read /.
#line 4264
allow sysadm_ssh_t root_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_ssh_t root_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /home.
#line 4264
allow sysadm_ssh_t home_root_t:dir { read getattr lock search ioctl };
#line 4264

#line 4264
# Read /usr.
#line 4264
allow sysadm_ssh_t usr_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_ssh_t usr_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read bin and sbin directories.
#line 4264
allow sysadm_ssh_t bin_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_ssh_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264
allow sysadm_ssh_t sbin_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_ssh_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264

#line 4264
# Read the devpts root directory.
#line 4264
allow sysadm_ssh_t devpts_t:dir { read getattr lock search ioctl };
#line 4264

#line 4264
# Read /var.
#line 4264
allow sysadm_ssh_t var_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_ssh_t var_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /var/run, /var/log.
#line 4264
allow sysadm_ssh_t var_run_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_ssh_t var_run_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_ssh_t var_log_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_ssh_t var_log_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /etc.
#line 4264
allow sysadm_ssh_t etc_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_ssh_t etc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264
allow sysadm_ssh_t etc_runtime_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_ssh_t resolv_conf_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read the linker, shared library, and executable types.
#line 4264
allow sysadm_ssh_t ld_so_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_ssh_t shlib_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_ssh_t exec_type:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /dev directories and any symbolic links.
#line 4264
allow sysadm_ssh_t device_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_ssh_t device_t:lnk_file { read getattr lock ioctl };
#line 4264

#line 4264
# Read /dev/random.
#line 4264
allow sysadm_ssh_t random_device_t:chr_file { read getattr lock ioctl };
#line 4264

#line 4264
# Read and write /dev/tty and /dev/null.
#line 4264
allow sysadm_ssh_t devtty_t:chr_file { ioctl read getattr lock write append };
#line 4264
allow sysadm_ssh_t { null_device_t zero_device_t }:chr_file { ioctl read getattr lock write append };
#line 4264

#line 4264
# Grant permissions needed to create TCP and UDP sockets and
#line 4264
# to access the network.
#line 4264

#line 4264
#
#line 4264
# Allow the domain to create and use UDP and TCP sockets.
#line 4264
# Other kinds of sockets must be separately authorized for use.
#line 4264
allow sysadm_ssh_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4264
allow sysadm_ssh_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4264

#line 4264
#
#line 4264
# Allow the domain to send UDP packets.
#line 4264
# Since the destination sockets type is unknown, the generic
#line 4264
# any_socket_t type is used as a placeholder.
#line 4264
#
#line 4264
allow sysadm_ssh_t any_socket_t:udp_socket sendto;
#line 4264

#line 4264
#
#line 4264
# Allow the domain to send using any network interface.
#line 4264
# netif_type is a type attribute for all network interface types.
#line 4264
#
#line 4264
allow sysadm_ssh_t netif_type:netif { tcp_send udp_send rawip_send };
#line 4264

#line 4264
#
#line 4264
# Allow packets sent by the domain to be received on any network interface.
#line 4264
#
#line 4264
allow sysadm_ssh_t netif_type:netif { tcp_recv udp_recv rawip_recv };
#line 4264

#line 4264
#
#line 4264
# Allow the domain to receive packets from any network interface.
#line 4264
# netmsg_type is a type attribute for all default message types.
#line 4264
#
#line 4264
allow sysadm_ssh_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
#line 4264

#line 4264
#
#line 4264
# Allow the domain to initiate or accept TCP connections 
#line 4264
# on any network interface.
#line 4264
#
#line 4264
allow sysadm_ssh_t netmsg_type:tcp_socket { connectto acceptfrom };
#line 4264

#line 4264
#
#line 4264
# Receive resets from the TCP reset socket.
#line 4264
# The TCP reset socket is labeled with the tcp_socket_t type.
#line 4264
#
#line 4264
allow sysadm_ssh_t tcp_socket_t:tcp_socket recvfrom;
#line 4264

#line 4264
dontaudit sysadm_ssh_t tcp_socket_t:tcp_socket connectto;
#line 4264

#line 4264
#
#line 4264
# Allow the domain to send to any node.
#line 4264
# node_type is a type attribute for all node types.
#line 4264
#
#line 4264
allow sysadm_ssh_t node_type:node { tcp_send udp_send rawip_send };
#line 4264

#line 4264
#
#line 4264
# Allow packets sent by the domain to be received from any node.
#line 4264
#
#line 4264
allow sysadm_ssh_t node_type:node { tcp_recv udp_recv rawip_recv };
#line 4264

#line 4264
#
#line 4264
# Allow the domain to send NFS client requests via the socket
#line 4264
# created by mount.
#line 4264
#
#line 4264
allow sysadm_ssh_t mount_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4264

#line 4264
#
#line 4264
# Bind to the default port type.
#line 4264
# Other port types must be separately authorized.
#line 4264
#
#line 4264
allow sysadm_ssh_t port_t:udp_socket name_bind;
#line 4264
allow sysadm_ssh_t port_t:tcp_socket name_bind;
#line 4264

#line 4264

#line 4264
# for sshing to a ssh tunnel
#line 4264

#line 4264
allow sysadm_ssh_t sysadm_ssh_t:tcp_socket { connectto recvfrom };
#line 4264
allow sysadm_ssh_t sysadm_ssh_t:tcp_socket { acceptfrom recvfrom };
#line 4264
allow sysadm_ssh_t tcp_socket_t:tcp_socket { recvfrom };
#line 4264
allow sysadm_ssh_t tcp_socket_t:tcp_socket { recvfrom };
#line 4264

#line 4264

#line 4264
# Use capabilities.
#line 4264
allow sysadm_ssh_t self:capability { setuid setgid dac_override dac_read_search };
#line 4264

#line 4264
# Run helpers.
#line 4264

#line 4264
allow sysadm_ssh_t { bin_t sbin_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_ssh_t { bin_t sbin_t }:lnk_file read;
#line 4264

#line 4264
allow sysadm_ssh_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_ssh_t ld_so_t:file { read getattr lock execute ioctl };
#line 4264
allow sysadm_ssh_t ld_so_t:file execute_no_trans;
#line 4264
allow sysadm_ssh_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4264
allow sysadm_ssh_t shlib_t:file { read getattr lock execute ioctl };
#line 4264
allow sysadm_ssh_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4264
allow sysadm_ssh_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_ssh_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4264

#line 4264

#line 4264
allow sysadm_ssh_t etc_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4264

#line 4264

#line 4264
allow sysadm_ssh_t lib_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4264

#line 4264

#line 4264
allow sysadm_ssh_t bin_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4264

#line 4264

#line 4264
allow sysadm_ssh_t sbin_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4264

#line 4264

#line 4264
allow sysadm_ssh_t exec_type:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4264

#line 4264

#line 4264

#line 4264
# Read the ssh key file.
#line 4264
allow sysadm_ssh_t sshd_key_t:file { read getattr lock ioctl };
#line 4264

#line 4264
# Access the ssh temporary files.
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
#
#line 4264
# Allow the process to modify the directory.
#line 4264
#
#line 4264
allow sysadm_ssh_t tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4264

#line 4264
#
#line 4264
# Allow the process to create the file.
#line 4264
#
#line 4264

#line 4264
allow sysadm_ssh_t sshd_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4264
allow sysadm_ssh_t sshd_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4264

#line 4264

#line 4264

#line 4264
type_transition sysadm_ssh_t tmp_t:dir sshd_tmp_t;
#line 4264
type_transition sysadm_ssh_t tmp_t:{ file lnk_file sock_file fifo_file } sshd_tmp_t;
#line 4264

#line 4264

#line 4264

#line 4264
allow sysadm_ssh_t sysadm_tmp_t:dir { read getattr lock search ioctl };
#line 4264

#line 4264
# for rsync
#line 4264
allow sysadm_ssh_t sysadm_t:unix_stream_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4264

#line 4264
# Access the users .ssh directory.
#line 4264
type sysadm_home_ssh_t, file_type, sysadmfile;
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
#
#line 4264
# Allow the process to modify the directory.
#line 4264
#
#line 4264
allow { sysadm_ssh_t sysadm_ssh_t } sysadm_home_dir_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4264

#line 4264
#
#line 4264
# Allow the process to create the file.
#line 4264
#
#line 4264

#line 4264
allow { sysadm_ssh_t sysadm_ssh_t } sysadm_home_ssh_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4264
allow { sysadm_ssh_t sysadm_ssh_t } sysadm_home_ssh_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4264

#line 4264

#line 4264

#line 4264
type_transition { sysadm_ssh_t sysadm_ssh_t } sysadm_home_dir_t:dir sysadm_home_ssh_t;
#line 4264
type_transition { sysadm_ssh_t sysadm_ssh_t } sysadm_home_dir_t:{ file lnk_file sock_file fifo_file } sysadm_home_ssh_t;
#line 4264

#line 4264

#line 4264

#line 4264
allow { sysadm_ssh_t sysadm_ssh_t } sysadm_home_ssh_t:lnk_file { getattr read };
#line 4264
dontaudit sysadm_ssh_t sysadm_home_t:dir search;
#line 4264

#line 4264
allow sshd_t sysadm_home_ssh_t:dir { read getattr lock search ioctl };
#line 4264
allow sshd_t sysadm_home_ssh_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264

#line 4264
allow sysadm_t sysadm_home_ssh_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4264
allow sysadm_t sysadm_home_ssh_t:{ file lnk_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4264

#line 4264

#line 4264
# Inherit and use descriptors from gnome-pty-helper.
#line 4264

#line 4264

#line 4264
# Connect to sshd.
#line 4264

#line 4264
allow sysadm_ssh_t sshd_t:tcp_socket { connectto recvfrom };
#line 4264
allow sshd_t sysadm_ssh_t:tcp_socket { acceptfrom recvfrom };
#line 4264
allow sshd_t tcp_socket_t:tcp_socket { recvfrom };
#line 4264
allow sysadm_ssh_t tcp_socket_t:tcp_socket { recvfrom };
#line 4264

#line 4264

#line 4264
# Write to the user domain tty.
#line 4264
allow sysadm_ssh_t sysadm_tty_device_t:chr_file { ioctl read getattr lock write append };
#line 4264
allow sysadm_ssh_t sysadm_devpts_t:chr_file { ioctl read getattr lock write append };
#line 4264

#line 4264
# Allow the user shell to signal the ssh program.
#line 4264
allow sysadm_t sysadm_ssh_t:process signal;
#line 4264
# allow ps to show ssh
#line 4264
allow sysadm_t sysadm_ssh_t:dir { search getattr read };
#line 4264
allow sysadm_t sysadm_ssh_t:{ file lnk_file } { read getattr };
#line 4264

#line 4264
# Allow the ssh program to communicate with ssh-agent.
#line 4264
allow sysadm_ssh_t sysadm_tmp_t:sock_file write;
#line 4264
allow sysadm_ssh_t sysadm_t:unix_stream_socket connectto;
#line 4264
allow sysadm_ssh_t sshd_t:unix_stream_socket connectto;
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
# Instantiate a derived domain for user cron jobs.
#line 4264

#line 4264
# Derived domain for user cron jobs, user user_crond_domain if not system
#line 4264

#line 4264
type sysadm_crond_t, domain, user_crond_domain;
#line 4264

#line 4264

#line 4264
# Permit a transition from the crond_t domain to this domain.
#line 4264
# The transition is requested explicitly by the modified crond 
#line 4264
# via execve_secure.  There is no way to set up an automatic
#line 4264
# transition, since crontabs are configuration files, not executables.
#line 4264

#line 4264

#line 4264
#
#line 4264
# Allow the process to transition to the new domain.
#line 4264
#
#line 4264
allow crond_t sysadm_crond_t:process transition;
#line 4264

#line 4264
#
#line 4264
# Allow the process to execute the program.
#line 4264
# 
#line 4264
allow crond_t shell_exec_t:file { getattr execute };
#line 4264

#line 4264
#
#line 4264
# Allow the process to reap the new domain.
#line 4264
#
#line 4264
allow sysadm_crond_t crond_t:process sigchld;
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to inherit and use file 
#line 4264
# descriptions from the creating process and vice versa.
#line 4264
#
#line 4264
allow sysadm_crond_t crond_t:fd use;
#line 4264
allow crond_t sysadm_crond_t:fd use;
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to write back to the old domain via a pipe.
#line 4264
#
#line 4264
allow sysadm_crond_t crond_t:fifo_file { ioctl read getattr lock write append };
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to read and execute the program.
#line 4264
#
#line 4264
allow sysadm_crond_t shell_exec_t:file { read getattr lock execute ioctl };
#line 4264

#line 4264
#
#line 4264
# Allow the new domain to be entered via the program.
#line 4264
#
#line 4264
allow sysadm_crond_t shell_exec_t:file entrypoint;
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
# The user role is authorized for this domain.
#line 4264
role sysadm_r types sysadm_crond_t;
#line 4264

#line 4264
# This domain is granted permissions common to most domains.
#line 4264

#line 4264

#line 4264
# Grant the permissions common to the test domains.
#line 4264

#line 4264
# Grant permissions within the domain.
#line 4264

#line 4264
# Access other processes in the same domain.
#line 4264
allow sysadm_crond_t self:process *;
#line 4264

#line 4264
# Access /proc/PID files for processes in the same domain.
#line 4264
allow sysadm_crond_t self:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Access file descriptions, pipes, and sockets
#line 4264
# created by processes in the same domain.
#line 4264
allow sysadm_crond_t self:fd *;
#line 4264
allow sysadm_crond_t self:fifo_file { ioctl read getattr lock write append };
#line 4264
allow sysadm_crond_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4264
allow sysadm_crond_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4264

#line 4264
# Allow the domain to communicate with other processes in the same domain.
#line 4264
allow sysadm_crond_t self:unix_dgram_socket sendto;
#line 4264
allow sysadm_crond_t self:unix_stream_socket connectto;
#line 4264

#line 4264
# Access System V IPC objects created by processes in the same domain.
#line 4264
allow sysadm_crond_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 4264
allow sysadm_crond_t self:msg  { send receive };
#line 4264
allow sysadm_crond_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 4264
allow sysadm_crond_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 4264

#line 4264

#line 4264

#line 4264
# Grant read/search permissions to most of /proc.
#line 4264

#line 4264
# Read system information files in /proc.
#line 4264
allow sysadm_crond_t proc_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t proc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Stat /proc/kmsg and /proc/kcore.
#line 4264
allow sysadm_crond_t proc_kmsg_t:file { getattr };
#line 4264
allow sysadm_crond_t proc_kcore_t:file { getattr };
#line 4264

#line 4264
# Read system variables in /proc/sys.
#line 4264
allow sysadm_crond_t sysctl_modprobe_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_crond_t sysctl_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_crond_t sysctl_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t sysctl_fs_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_crond_t sysctl_fs_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t sysctl_kernel_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_crond_t sysctl_kernel_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t sysctl_net_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_crond_t sysctl_net_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t sysctl_vm_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_crond_t sysctl_vm_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t sysctl_dev_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_crond_t sysctl_dev_t:dir { read getattr lock search ioctl };
#line 4264

#line 4264

#line 4264
# Grant read/search permissions to many system file types.
#line 4264

#line 4264

#line 4264
# Get attributes of file systems.
#line 4264
allow sysadm_crond_t fs_type:filesystem getattr;
#line 4264

#line 4264

#line 4264
# Read /.
#line 4264
allow sysadm_crond_t root_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t root_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /home.
#line 4264
allow sysadm_crond_t home_root_t:dir { read getattr lock search ioctl };
#line 4264

#line 4264
# Read /usr.
#line 4264
allow sysadm_crond_t usr_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t usr_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read bin and sbin directories.
#line 4264
allow sysadm_crond_t bin_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264
allow sysadm_crond_t sbin_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264

#line 4264
# Read directories and files with the readable_t type.
#line 4264
# This type is a general type for "world"-readable files.
#line 4264
allow sysadm_crond_t readable_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t readable_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Stat /...security and lost+found.
#line 4264
allow sysadm_crond_t file_labels_t:dir getattr;
#line 4264
allow sysadm_crond_t lost_found_t:dir getattr;
#line 4264

#line 4264
# Read the devpts root directory.  
#line 4264
allow sysadm_crond_t devpts_t:dir { read getattr lock search ioctl };
#line 4264

#line 4264

#line 4264
# Read the /tmp directory and any /tmp files with the base type.
#line 4264
# Temporary files created at runtime will typically use derived types.
#line 4264
allow sysadm_crond_t tmp_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t tmp_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /var.
#line 4264
allow sysadm_crond_t var_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t var_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /var/catman.
#line 4264
allow sysadm_crond_t catman_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t catman_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /var/lib.
#line 4264
allow sysadm_crond_t var_lib_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t var_lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264
allow sysadm_crond_t var_lib_nfs_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t var_lib_nfs_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264

#line 4264
allow sysadm_crond_t tetex_data_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t tetex_data_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264

#line 4264
# Read /var/yp.
#line 4264
allow sysadm_crond_t var_yp_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t var_yp_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /var/spool.
#line 4264
allow sysadm_crond_t var_spool_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t var_spool_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /var/run, /var/lock, /var/log.
#line 4264
allow sysadm_crond_t var_run_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t var_run_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_crond_t var_log_t:dir { read getattr lock search ioctl };
#line 4264
#allow sysadm_crond_t var_log_t:{ file lnk_file } r_file_perms;
#line 4264
allow sysadm_crond_t var_log_sa_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t var_log_sa_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_crond_t var_log_ksyms_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264
allow sysadm_crond_t var_lock_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t var_lock_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /var/run/utmp and /var/log/wtmp.
#line 4264
allow sysadm_crond_t initrc_var_run_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_crond_t wtmp_t:file { read getattr lock ioctl };
#line 4264

#line 4264
# Read /boot, /boot/System.map*, and /vmlinuz*
#line 4264
allow sysadm_crond_t boot_t:dir { search getattr };
#line 4264
allow sysadm_crond_t boot_t:file getattr;
#line 4264
allow sysadm_crond_t system_map_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264
allow sysadm_crond_t boot_t:lnk_file read;
#line 4264

#line 4264
# Read /etc.
#line 4264
allow sysadm_crond_t etc_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t etc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264
allow sysadm_crond_t etc_runtime_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_crond_t etc_aliases_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_crond_t etc_mail_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t etc_mail_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_crond_t resolv_conf_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_crond_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4264

#line 4264
# Read /lib.
#line 4264
allow sysadm_crond_t lib_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read the linker, shared library, and executable types.
#line 4264
allow sysadm_crond_t ld_so_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_crond_t shlib_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_crond_t exec_type:{ file lnk_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read man directories and files.
#line 4264
allow sysadm_crond_t man_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t man_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read /usr/src.
#line 4264
allow sysadm_crond_t src_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t src_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Read module-related files.
#line 4264
allow sysadm_crond_t modules_object_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t modules_object_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_crond_t modules_dep_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_crond_t modules_conf_t:{ file lnk_file} { read getattr lock ioctl };
#line 4264

#line 4264
# Read /dev directories and any symbolic links.
#line 4264
allow sysadm_crond_t device_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t device_t:lnk_file { read getattr lock ioctl };
#line 4264

#line 4264
# Read /dev/random and /dev/zero.
#line 4264
allow sysadm_crond_t random_device_t:chr_file { read getattr lock ioctl };
#line 4264
allow sysadm_crond_t zero_device_t:chr_file { read getattr lock ioctl };
#line 4264

#line 4264
# Read the root directory of a tmpfs filesytem and any symbolic links.
#line 4264
allow sysadm_crond_t tmpfs_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t tmpfs_t:lnk_file { read getattr lock ioctl };
#line 4264

#line 4264
# Read any symbolic links on a devfs file system.
#line 4264
allow sysadm_crond_t device_t:lnk_file { read getattr lock ioctl };
#line 4264

#line 4264
# Read the root directory of a usbdevfs filesystem, and
#line 4264
# the devices and drivers files.  Permit stating of the
#line 4264
# device nodes, but nothing else.
#line 4264
allow sysadm_crond_t usbdevfs_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t usbdevfs_t:{ file lnk_file } { read getattr lock ioctl };
#line 4264
allow sysadm_crond_t usbdevfs_device_t:file getattr;
#line 4264

#line 4264

#line 4264
# Grant write permissions to a small set of system file types.
#line 4264
# No permission to create files is granted here.  Use allow rules to grant 
#line 4264
# create permissions to a type or use file_type_auto_trans rules to set up
#line 4264
# new types for files.
#line 4264

#line 4264

#line 4264
# Read and write /dev/tty and /dev/null.
#line 4264
allow sysadm_crond_t devtty_t:chr_file { ioctl read getattr lock write append };
#line 4264
allow sysadm_crond_t { null_device_t zero_device_t }:chr_file { ioctl read getattr lock write append };
#line 4264

#line 4264
# Do not audit write denials to /etc/ld.so.cache.
#line 4264
dontaudit sysadm_crond_t ld_so_cache_t:file write;
#line 4264

#line 4264

#line 4264
# Execute from the system shared libraries.
#line 4264
# No permission to execute anything else is granted here.
#line 4264
# Use can_exec or can_exec_any to grant the ability to execute within a domain.
#line 4264
# Use domain_auto_trans for executing and changing domains.
#line 4264

#line 4264
allow sysadm_crond_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t ld_so_t:file { read getattr lock execute ioctl };
#line 4264
allow sysadm_crond_t ld_so_t:file execute_no_trans;
#line 4264
allow sysadm_crond_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4264
allow sysadm_crond_t shlib_t:file { read getattr lock execute ioctl };
#line 4264
allow sysadm_crond_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4264
allow sysadm_crond_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_crond_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4264

#line 4264

#line 4264
# read localization information
#line 4264
allow sysadm_crond_t locale_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t locale_t:{file lnk_file} { read getattr lock ioctl };
#line 4264

#line 4264
# Obtain the context of any SID, the SID for any context, 
#line 4264
# and the list of active SIDs.
#line 4264
allow sysadm_crond_t security_t:security { sid_to_context context_to_sid get_sids };
#line 4264

#line 4264

#line 4264

#line 4264
# Grant permissions needed to create TCP and UDP sockets and 
#line 4264
# to access the network.
#line 4264

#line 4264
#
#line 4264
# Allow the domain to create and use UDP and TCP sockets.
#line 4264
# Other kinds of sockets must be separately authorized for use.
#line 4264
allow sysadm_crond_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4264
allow sysadm_crond_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4264

#line 4264
#
#line 4264
# Allow the domain to send UDP packets.
#line 4264
# Since the destination sockets type is unknown, the generic
#line 4264
# any_socket_t type is used as a placeholder.
#line 4264
#
#line 4264
allow sysadm_crond_t any_socket_t:udp_socket sendto;
#line 4264

#line 4264
#
#line 4264
# Allow the domain to send using any network interface.
#line 4264
# netif_type is a type attribute for all network interface types.
#line 4264
#
#line 4264
allow sysadm_crond_t netif_type:netif { tcp_send udp_send rawip_send };
#line 4264

#line 4264
#
#line 4264
# Allow packets sent by the domain to be received on any network interface.
#line 4264
#
#line 4264
allow sysadm_crond_t netif_type:netif { tcp_recv udp_recv rawip_recv };
#line 4264

#line 4264
#
#line 4264
# Allow the domain to receive packets from any network interface.
#line 4264
# netmsg_type is a type attribute for all default message types.
#line 4264
#
#line 4264
allow sysadm_crond_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
#line 4264

#line 4264
#
#line 4264
# Allow the domain to initiate or accept TCP connections 
#line 4264
# on any network interface.
#line 4264
#
#line 4264
allow sysadm_crond_t netmsg_type:tcp_socket { connectto acceptfrom };
#line 4264

#line 4264
#
#line 4264
# Receive resets from the TCP reset socket.
#line 4264
# The TCP reset socket is labeled with the tcp_socket_t type.
#line 4264
#
#line 4264
allow sysadm_crond_t tcp_socket_t:tcp_socket recvfrom;
#line 4264

#line 4264
dontaudit sysadm_crond_t tcp_socket_t:tcp_socket connectto;
#line 4264

#line 4264
#
#line 4264
# Allow the domain to send to any node.
#line 4264
# node_type is a type attribute for all node types.
#line 4264
#
#line 4264
allow sysadm_crond_t node_type:node { tcp_send udp_send rawip_send };
#line 4264

#line 4264
#
#line 4264
# Allow packets sent by the domain to be received from any node.
#line 4264
#
#line 4264
allow sysadm_crond_t node_type:node { tcp_recv udp_recv rawip_recv };
#line 4264

#line 4264
#
#line 4264
# Allow the domain to send NFS client requests via the socket
#line 4264
# created by mount.
#line 4264
#
#line 4264
allow sysadm_crond_t mount_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4264

#line 4264
#
#line 4264
# Bind to the default port type.
#line 4264
# Other port types must be separately authorized.
#line 4264
#
#line 4264
allow sysadm_crond_t port_t:udp_socket name_bind;
#line 4264
allow sysadm_crond_t port_t:tcp_socket name_bind;
#line 4264

#line 4264

#line 4264

#line 4264
# Use capabilities.
#line 4264
allow sysadm_crond_t sysadm_crond_t:capability dac_override;
#line 4264

#line 4264
# Inherit and use descriptors from initrc.
#line 4264
allow sysadm_crond_t initrc_t:fd use;
#line 4264

#line 4264
# 
#line 4264
# Since crontab files are not directly executed,
#line 4264
# crond must ensure that the crontab file has
#line 4264
# a type that is appropriate for the domain of
#line 4264
# the user cron job.  It performs an entrypoint
#line 4264
# permission check for this purpose.
#line 4264
#
#line 4264
allow sysadm_crond_t sysadm_cron_spool_t:file entrypoint;
#line 4264

#line 4264
# Access user files and dirs.
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
#
#line 4264
# Allow the process to modify the directory.
#line 4264
#
#line 4264
allow sysadm_crond_t sysadm_home_dir_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4264

#line 4264
#
#line 4264
# Allow the process to create the file.
#line 4264
#
#line 4264

#line 4264
allow sysadm_crond_t sysadm_home_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4264
allow sysadm_crond_t sysadm_home_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4264

#line 4264

#line 4264

#line 4264
type_transition sysadm_crond_t sysadm_home_dir_t:dir sysadm_home_t;
#line 4264
type_transition sysadm_crond_t sysadm_home_dir_t:{ file lnk_file sock_file fifo_file } sysadm_home_t;
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
#
#line 4264
# Allow the process to modify the directory.
#line 4264
#
#line 4264
allow sysadm_crond_t tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4264

#line 4264
#
#line 4264
# Allow the process to create the file.
#line 4264
#
#line 4264

#line 4264
allow sysadm_crond_t sysadm_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4264
allow sysadm_crond_t sysadm_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4264

#line 4264

#line 4264

#line 4264
type_transition sysadm_crond_t tmp_t:dir sysadm_tmp_t;
#line 4264
type_transition sysadm_crond_t tmp_t:{ file lnk_file sock_file fifo_file } sysadm_tmp_t;
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
# Run helper programs.
#line 4264

#line 4264
allow sysadm_crond_t { bin_t sbin_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t { bin_t sbin_t }:lnk_file read;
#line 4264

#line 4264
allow sysadm_crond_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_crond_t ld_so_t:file { read getattr lock execute ioctl };
#line 4264
allow sysadm_crond_t ld_so_t:file execute_no_trans;
#line 4264
allow sysadm_crond_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4264
allow sysadm_crond_t shlib_t:file { read getattr lock execute ioctl };
#line 4264
allow sysadm_crond_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4264
allow sysadm_crond_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4264
allow sysadm_crond_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4264

#line 4264

#line 4264
allow sysadm_crond_t etc_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4264

#line 4264

#line 4264
allow sysadm_crond_t lib_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4264

#line 4264

#line 4264
allow sysadm_crond_t bin_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4264

#line 4264

#line 4264
allow sysadm_crond_t sbin_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4264

#line 4264

#line 4264
allow sysadm_crond_t exec_type:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4264

#line 4264

#line 4264

#line 4264
# Run scripts in user home directory.
#line 4264

#line 4264
allow sysadm_crond_t sysadm_home_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
# Read the mouse.
#line 4264
allow sysadm_t mouse_device_t:chr_file { read getattr lock ioctl };
#line 4264
# Access other miscellaneous devices.
#line 4264
allow sysadm_t misc_device_t:{ file lnk_file sock_file fifo_file chr_file blk_file } { ioctl read getattr lock write append };
#line 4264

#line 4264
# Use the network.
#line 4264

#line 4264
#
#line 4264
# Allow the domain to create and use UDP and TCP sockets.
#line 4264
# Other kinds of sockets must be separately authorized for use.
#line 4264
allow sysadm_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4264
allow sysadm_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4264

#line 4264
#
#line 4264
# Allow the domain to send UDP packets.
#line 4264
# Since the destination sockets type is unknown, the generic
#line 4264
# any_socket_t type is used as a placeholder.
#line 4264
#
#line 4264
allow sysadm_t any_socket_t:udp_socket sendto;
#line 4264

#line 4264
#
#line 4264
# Allow the domain to send using any network interface.
#line 4264
# netif_type is a type attribute for all network interface types.
#line 4264
#
#line 4264
allow sysadm_t netif_type:netif { tcp_send udp_send rawip_send };
#line 4264

#line 4264
#
#line 4264
# Allow packets sent by the domain to be received on any network interface.
#line 4264
#
#line 4264
allow sysadm_t netif_type:netif { tcp_recv udp_recv rawip_recv };
#line 4264

#line 4264
#
#line 4264
# Allow the domain to receive packets from any network interface.
#line 4264
# netmsg_type is a type attribute for all default message types.
#line 4264
#
#line 4264
allow sysadm_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
#line 4264

#line 4264
#
#line 4264
# Allow the domain to initiate or accept TCP connections 
#line 4264
# on any network interface.
#line 4264
#
#line 4264
allow sysadm_t netmsg_type:tcp_socket { connectto acceptfrom };
#line 4264

#line 4264
#
#line 4264
# Receive resets from the TCP reset socket.
#line 4264
# The TCP reset socket is labeled with the tcp_socket_t type.
#line 4264
#
#line 4264
allow sysadm_t tcp_socket_t:tcp_socket recvfrom;
#line 4264

#line 4264
dontaudit sysadm_t tcp_socket_t:tcp_socket connectto;
#line 4264

#line 4264
#
#line 4264
# Allow the domain to send to any node.
#line 4264
# node_type is a type attribute for all node types.
#line 4264
#
#line 4264
allow sysadm_t node_type:node { tcp_send udp_send rawip_send };
#line 4264

#line 4264
#
#line 4264
# Allow packets sent by the domain to be received from any node.
#line 4264
#
#line 4264
allow sysadm_t node_type:node { tcp_recv udp_recv rawip_recv };
#line 4264

#line 4264
#
#line 4264
# Allow the domain to send NFS client requests via the socket
#line 4264
# created by mount.
#line 4264
#
#line 4264
allow sysadm_t mount_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4264

#line 4264
#
#line 4264
# Bind to the default port type.
#line 4264
# Other port types must be separately authorized.
#line 4264
#
#line 4264
allow sysadm_t port_t:udp_socket name_bind;
#line 4264
allow sysadm_t port_t:tcp_socket name_bind;
#line 4264

#line 4264

#line 4264
#
#line 4264
# connect_secure and sendmsg_secure calls with a 
#line 4264
# peer or destination socket SID can be enforced
#line 4264
# when using the loopback interface.  Enforcement
#line 4264
# for real network interfaces will be possible when
#line 4264
# a packet labeling mechanism is integrated.
#line 4264
#
#line 4264
allow sysadm_t node_lo_t:node enforce_dest;
#line 4264

#line 4264
# Communicate within the domain.
#line 4264

#line 4264
allow sysadm_t sysadm_t:udp_socket { sendto };
#line 4264
allow sysadm_t sysadm_t:udp_socket { recvfrom };
#line 4264

#line 4264

#line 4264
allow sysadm_t sysadm_t:tcp_socket { connectto recvfrom };
#line 4264
allow sysadm_t sysadm_t:tcp_socket { acceptfrom recvfrom };
#line 4264
allow sysadm_t tcp_socket_t:tcp_socket { recvfrom };
#line 4264
allow sysadm_t tcp_socket_t:tcp_socket { recvfrom };
#line 4264

#line 4264

#line 4264
# Connect to inetd.
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
# Connect data port to ftpd.
#line 4264

#line 4264

#line 4264
# Connect to portmap.
#line 4264

#line 4264

#line 4264
# Inherit and use sockets from inetd
#line 4264

#line 4264

#line 4264
# Allow system log read
#line 4264
#allow sysadm_t kernel_t:system syslog_read;
#line 4264
# else do not log it
#line 4264
dontaudit sysadm_t kernel_t:system syslog_read;
#line 4264

#line 4264
# Very permissive allowing every domain to see every type.
#line 4264
allow sysadm_t kernel_t:system { ipc_info };
#line 4264

#line 4264
# When the user domain runs ps, there will be a number of access
#line 4264
# denials when ps tries to search /proc.  Do not audit these denials.
#line 4264
dontaudit sysadm_t domain:dir { read getattr lock search ioctl };
#line 4264
dontaudit sysadm_t domain:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Some shells ask for w access to utmp, but will operate
#line 4264
# correctly without it.  Do not audit write denials to utmp.
#line 4264
dontaudit sysadm_t initrc_var_run_t:file { getattr read write };
#line 4264

#line 4264
# do not audit getattr on tmpfile, otherwise ls -l /tmp fills the logs
#line 4264
dontaudit sysadm_t tmpfile:{ dir file lnk_file sock_file fifo_file chr_file blk_file } getattr;
#line 4264

#line 4264
# do not audit getattr on disk devices, otherwise KDE fills the logs
#line 4264
dontaudit sysadm_t { removable_device_t fixed_disk_device_t }:blk_file getattr;
#line 4264

#line 4264

#line 4264
# Access the sound device.
#line 4264
allow sysadm_t sound_device_t:chr_file { getattr read write ioctl };
#line 4264

#line 4264
# Allow reading dpkg origins file
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
# Violates the goal of limiting write access to checkpolicy.
#line 4264
#rw_dir_create_file(sysadm_t, policy_config_t)
#line 4264

#line 4264

#line 4264
allow sysadm_crond_t var_log_t:file { read getattr lock ioctl };
#line 4264

#line 4264

#line 4264
# Allow system log read
#line 4264
allow sysadm_t kernel_t:system syslog_read;
#line 4264

#line 4264
# Use capabilities other than sys_module.
#line 4264
allow sysadm_t self:capability ~sys_module;
#line 4264

#line 4264
# Determine the set of legal user SIDs reachable from a given SID.
#line 4264
allow sysadm_t security_t:security { get_user_sids };
#line 4264

#line 4264
# Use system operations.
#line 4264
allow sysadm_t kernel_t:system *;
#line 4264

#line 4264
# Change system parameters.
#line 4264

#line 4264
allow sysadm_t sysctl_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_t sysctl_t:file { setattr { ioctl read getattr lock write append } };
#line 4264
allow sysadm_t sysctl_fs_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_t sysctl_fs_t:file { setattr { ioctl read getattr lock write append } };
#line 4264
allow sysadm_t sysctl_kernel_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_t sysctl_kernel_t:file { setattr { ioctl read getattr lock write append } };
#line 4264
allow sysadm_t sysctl_net_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_t sysctl_net_t:file { setattr { ioctl read getattr lock write append } };
#line 4264
allow sysadm_t sysctl_net_unix_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_t sysctl_net_unix_t:file { setattr { ioctl read getattr lock write append } };
#line 4264
allow sysadm_t sysctl_vm_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_t sysctl_vm_t:file { setattr { ioctl read getattr lock write append } };
#line 4264
allow sysadm_t sysctl_dev_t:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_t sysctl_dev_t:file { setattr { ioctl read getattr lock write append } };
#line 4264
allow sysadm_t sysctl_modprobe_t:file { setattr { ioctl read getattr lock write append } };
#line 4264

#line 4264

#line 4264
# Create and use all files that have the sysadmfile attribute.
#line 4264
allow sysadm_t sysadmfile:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4264
allow sysadm_t sysadmfile:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4264

#line 4264
# Access removable devices.
#line 4264
allow sysadm_t removable_device_t:{ chr_file blk_file } { ioctl read getattr lock write append };
#line 4264

#line 4264
# Communicate with the init process.
#line 4264
allow sysadm_t initctl_t:fifo_file { ioctl read getattr lock write append };
#line 4264

#line 4264
# Examine all processes.
#line 4264
allow sysadm_t domain:dir { read getattr lock search ioctl };
#line 4264
allow sysadm_t domain:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4264

#line 4264
# Send signals to all processes.
#line 4264
allow sysadm_t { domain unlabeled_t }:process { sigchld sigkill sigstop signull signal };
#line 4264

#line 4264
# Access all user terminals.
#line 4264
allow sysadm_t tty_device_t:chr_file { ioctl read getattr lock write append };
#line 4264
allow sysadm_t ttyfile:chr_file { ioctl read getattr lock write append };
#line 4264
allow sysadm_t ptyfile:chr_file { ioctl read getattr lock write append };
#line 4264

#line 4264
# allow setting up tunnels
#line 4264
allow sysadm_t tun_tap_device_t:chr_file { ioctl read getattr lock write append };
#line 4264

#line 4264
# Run init (telinit).
#line 4264

#line 4264
allow sysadm_t init_exec_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4264

#line 4264

#line 4264
# Run programs from user home directories.
#line 4264
# Not ideal, but typical if users want to login as both sysadm_t or user_t.
#line 4264

#line 4264
allow sysadm_t user_home_type:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4264

#line 4264
# Run programs from /usr/src.
#line 4264

#line 4264
allow sysadm_t src_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4264

#line 4264

#line 4264
# Run admin programs that require different permissions in their own domain.
#line 4264
# These rules were moved into the appropriate program domain file.
#line 4264

#line 4264
# added by mayerf@tresys.com
#line 4264
# The following rules are temporary until such time that a complete
#line 4264
# policy management infrastructure is in place so that an administrator
#line 4264
# cannot directly manipulate policy files with arbitrary programs.
#line 4264
#
#line 4264
allow sysadm_t policy_src_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4264
allow sysadm_t policy_src_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4264

#line 4264
# Remove the binary policy.
#line 4264
allow sysadm_t policy_config_t:file unlink;
#line 4264

#line 4264
# Relabel all files.
#line 4264
allow sysadm_t file_type:dir { getattr read search relabelfrom relabelto };
#line 4264
allow sysadm_t file_type:{ file lnk_file sock_file fifo_file chr_file blk_file } { getattr relabelfrom relabelto };
#line 4264

#line 4264
# Create files in /tmp/orbit-* and /tmp/.ICE-unix
#line 4264
# with our derived tmp type rather than user_tmp_t.
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
#
#line 4264
# Allow the process to modify the directory.
#line 4264
#
#line 4264
allow sysadm_t user_tmpfile:dir { read getattr lock search ioctl add_name remove_name write };
#line 4264

#line 4264
#
#line 4264
# Allow the process to create the file.
#line 4264
#
#line 4264

#line 4264
allow sysadm_t sysadm_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4264
allow sysadm_t sysadm_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4264

#line 4264

#line 4264

#line 4264
type_transition sysadm_t user_tmpfile:dir sysadm_tmp_t;
#line 4264
type_transition sysadm_t user_tmpfile:{ file lnk_file sock_file fifo_file } sysadm_tmp_t;
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
#
#line 4264
# A user who is authorized for sysadm_t may nonetheless have
#line 4264
# a home directory labeled with user_home_t if the user is expected
#line 4264
# to login in either user_t or sysadm_t.  Hence, the derived domains
#line 4264
# for programs need to be able to access user_home_t.  
#line 4264
# 
#line 4264

#line 4264
# Allow our xauth domain to write to .Xauthority.
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
#
#line 4264
# Allow the process to modify the directory.
#line 4264
#
#line 4264
allow sysadm_xauth_t user_home_dir_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4264

#line 4264
#
#line 4264
# Allow the process to create the file.
#line 4264
#
#line 4264

#line 4264
allow sysadm_xauth_t user_home_xauth_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4264
allow sysadm_xauth_t user_home_xauth_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4264

#line 4264

#line 4264

#line 4264
type_transition sysadm_xauth_t user_home_dir_t:dir user_home_xauth_t;
#line 4264
type_transition sysadm_xauth_t user_home_dir_t:{ file lnk_file sock_file fifo_file } user_home_xauth_t;
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
# Allow our gph domain to write to .xsession-errors.
#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264

#line 4264
# Allow our crontab domain to unlink a user cron spool file.
#line 4264
allow sysadm_crontab_t user_cron_spool_t:file unlink;
#line 4264

#line 4264
#
#line 4264
# Allow sysadm to execute quota commands against filesystems and files.
#line 4264
#
#line 4264
allow sysadm_t fs_type:filesystem { quotamod quotaget };
#line 4264
allow sysadm_t file_t:file quotaon;
#line 4264

#line 4264
# Grant read and write access to /dev/console.
#line 4264
allow sysadm_t console_device_t:chr_file { ioctl read getattr lock write append };
#line 4264

#line 4264
# for lsof
#line 4264
allow sysadm_t domain:{ tcp_socket udp_socket rawip_socket netlink_socket packet_socket unix_stream_socket unix_dgram_socket } getattr;
#line 4264


# Audit grantings of avc_toggle to the administrator domains.
# Due to its sensitivity, we always audit this permission.
auditallow admin kernel_t:system avc_toggle;




allow sysadm_t var_spool_t:file { execute };
#allow sysadm_t sysadm_home_dir_t:dir { add_name read remove_name write };
#allow sysadm_t sysadm_home_dir_t:file { create getattr link read unlink write };

allow sysadm_t usr_t:file { execute };

allow sysadm_t sysadm_t:packet_socket { create bind getopt ioctl read setopt };








#DESC Httpd admin -  Domain for httpd administrators
########################################
# httpd_admin domain macro and rules for 
# httpd_admin_t
########################################

# Uses some types defined in apache.te, so conditionally defined this macro.
# The intent is to remove this file in the future.
#
#line 4435

#DESC User - Domains for ordinary users.
#
#################################
#full_user_role(java)
#allow system_r java_r;
#allow sysadm_r java_r;


#line 4443

#line 4443
# user_t/user_t is an unprivileged users domain.
#line 4443
type user_t, domain, userdomain, unpriv_userdomain;
#line 4443

#line 4443
# user_r is authorized for user_t for the initial login domain.
#line 4443
role user_r types user_t;
#line 4443
allow system_r user_r;
#line 4443

#line 4443
# Grant permissions within the domain.
#line 4443

#line 4443
# Access other processes in the same domain.
#line 4443
allow user_t self:process *;
#line 4443

#line 4443
# Access /proc/PID files for processes in the same domain.
#line 4443
allow user_t self:dir { read getattr lock search ioctl };
#line 4443
allow user_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Access file descriptions, pipes, and sockets
#line 4443
# created by processes in the same domain.
#line 4443
allow user_t self:fd *;
#line 4443
allow user_t self:fifo_file { ioctl read getattr lock write append };
#line 4443
allow user_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4443
allow user_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4443

#line 4443
# Allow the domain to communicate with other processes in the same domain.
#line 4443
allow user_t self:unix_dgram_socket sendto;
#line 4443
allow user_t self:unix_stream_socket connectto;
#line 4443

#line 4443
# Access System V IPC objects created by processes in the same domain.
#line 4443
allow user_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 4443
allow user_t self:msg  { send receive };
#line 4443
allow user_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 4443
allow user_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 4443

#line 4443
;
#line 4443

#line 4443
# Grant read/search permissions to some of /proc.
#line 4443
allow user_t proc_t:dir { read getattr lock search ioctl };
#line 4443
allow user_t proc_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Grand read/search permissions to many system types.
#line 4443
#general_file_read_access(user_t);
#line 4443
# Get attributes of file systems.
#line 4443
allow user_t fs_type:filesystem getattr;
#line 4443

#line 4443

#line 4443
# Read /.
#line 4443
allow user_t root_t:dir { read getattr lock search ioctl };
#line 4443
allow user_t root_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /home.
#line 4443
allow user_t home_root_t:dir { read getattr lock search ioctl };
#line 4443

#line 4443
# Read /usr.
#line 4443
allow user_t usr_t:dir { read getattr lock search ioctl };
#line 4443
allow user_t usr_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read bin and sbin directories.
#line 4443
allow user_t bin_t:dir { read getattr lock search ioctl };
#line 4443
allow user_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443
allow user_t sbin_t:dir { read getattr lock search ioctl };
#line 4443
allow user_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443

#line 4443
# Read directories and files with the readable_t type.
#line 4443
# This type is a general type for "world"-readable files.
#line 4443
allow user_t readable_t:dir { read getattr lock search ioctl };
#line 4443
allow user_t readable_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Stat /...security and lost+found.
#line 4443
allow user_t file_labels_t:dir getattr;
#line 4443
allow user_t lost_found_t:dir getattr;
#line 4443

#line 4443
# Read the devpts root directory.
#line 4443
allow user_t devpts_t:dir { read getattr lock search ioctl };
#line 4443

#line 4443

#line 4443
# Read the /tmp directory and any /tmp files with the base type.
#line 4443
# Temporary files created at runtime will typically use derived types.
#line 4443
allow user_t tmp_t:dir { read getattr lock search ioctl };
#line 4443
allow user_t tmp_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /var, /var/spool, /var/run.
#line 4443
allow user_t var_t:dir { read getattr lock search ioctl };
#line 4443
allow user_t var_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443
allow user_t var_spool_t:dir { read getattr lock search ioctl };
#line 4443
allow user_t var_spool_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443
allow user_t var_run_t:dir { read getattr lock search ioctl };
#line 4443
allow user_t var_run_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /etc.
#line 4443
allow user_t etc_t:dir { read getattr lock search ioctl };
#line 4443
allow user_t etc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443
allow user_t etc_runtime_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read man directories and files.
#line 4443
allow user_t man_t:dir { read getattr lock search ioctl };
#line 4443
allow user_t man_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /dev directories and any symbolic links.
#line 4443
allow user_t device_t:dir { read getattr lock search ioctl };
#line 4443
allow user_t device_t:lnk_file { read getattr lock ioctl };
#line 4443

#line 4443
# Read and write /dev/tty and /dev/null.
#line 4443
allow user_t devtty_t:chr_file { ioctl read getattr lock write append };
#line 4443
allow user_t { null_device_t zero_device_t }:chr_file { ioctl read getattr lock write append };
#line 4443

#line 4443
# Do not audit write denials to /etc/ld.so.cache.
#line 4443
dontaudit user_t ld_so_cache_t:file write;
#line 4443

#line 4443
# Execute from the system shared libraries.
#line 4443

#line 4443
allow user_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4443
allow user_t ld_so_t:file { read getattr lock execute ioctl };
#line 4443
allow user_t ld_so_t:file execute_no_trans;
#line 4443
allow user_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4443
allow user_t shlib_t:file { read getattr lock execute ioctl };
#line 4443
allow user_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4443
allow user_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4443
allow user_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4443
;
#line 4443

#line 4443
# Obtain the context of any SID, the SID for any context,
#line 4443
# and the list of active SIDs.
#line 4443
allow user_t security_t:security { sid_to_context context_to_sid get_sids };
#line 4443

#line 4443
# user_t is also granted permissions specific to user domains.
#line 4443

#line 4443
# Use capabilities
#line 4443
allow user_t self:capability { setgid chown fowner };
#line 4443
dontaudit user_t self:capability { sys_nice fsetid };
#line 4443

#line 4443
# Type for home directory.
#line 4443

#line 4443
type user_home_dir_t, file_type, sysadmfile, home_dir_type, user_home_dir_type, home_type, user_home_type;
#line 4443
type user_home_t, file_type, sysadmfile, home_type, user_home_type;
#line 4443
# do not allow privhome access to sysadm_home_dir_t
#line 4443

#line 4443

#line 4443

#line 4443

#line 4443
#
#line 4443
# Allow the process to modify the directory.
#line 4443
#
#line 4443
allow privhome user_home_dir_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4443

#line 4443
#
#line 4443
# Allow the process to create the file.
#line 4443
#
#line 4443

#line 4443
allow privhome user_home_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4443
allow privhome user_home_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4443

#line 4443

#line 4443

#line 4443
type_transition privhome user_home_dir_t:dir user_home_t;
#line 4443
type_transition privhome user_home_dir_t:{ file lnk_file sock_file fifo_file } user_home_t;
#line 4443

#line 4443

#line 4443

#line 4443

#line 4443
type user_tmp_t, file_type, sysadmfile, tmpfile , user_tmpfile;
#line 4443

#line 4443

#line 4443

#line 4443

#line 4443
#
#line 4443
# Allow the process to modify the directory.
#line 4443
#
#line 4443
allow user_t tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4443

#line 4443
#
#line 4443
# Allow the process to create the file.
#line 4443
#
#line 4443

#line 4443
allow user_t user_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4443
allow user_t user_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4443

#line 4443

#line 4443

#line 4443
type_transition user_t tmp_t:dir user_tmp_t;
#line 4443
type_transition user_t tmp_t:{ file lnk_file sock_file fifo_file } user_tmp_t;
#line 4443

#line 4443

#line 4443

#line 4443

#line 4443

#line 4443

#line 4443
# Create, access, and remove files in home directory.
#line 4443

#line 4443

#line 4443

#line 4443

#line 4443
#
#line 4443
# Allow the process to modify the directory.
#line 4443
#
#line 4443
allow user_t user_home_dir_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4443

#line 4443
#
#line 4443
# Allow the process to create the file.
#line 4443
#
#line 4443

#line 4443
allow user_t user_home_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4443
allow user_t user_home_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4443

#line 4443

#line 4443

#line 4443
type_transition user_t user_home_dir_t:dir user_home_t;
#line 4443
type_transition user_t user_home_dir_t:{ file lnk_file sock_file fifo_file } user_home_t;
#line 4443

#line 4443

#line 4443

#line 4443
allow user_t user_home_t:{ dir file lnk_file sock_file fifo_file chr_file blk_file } { relabelfrom relabelto };
#line 4443

#line 4443
# Bind to a Unix domain socket in /tmp.
#line 4443
allow user_t user_tmp_t:unix_stream_socket name_bind;
#line 4443

#line 4443
# Type for tty devices.
#line 4443
type user_tty_device_t, file_type, sysadmfile, ttyfile;
#line 4443
# Access ttys.
#line 4443
allow user_t user_tty_device_t:chr_file { setattr { ioctl read getattr lock write append } };
#line 4443
# Use the type when relabeling terminal devices.
#line 4443
type_change user_t tty_device_t:chr_file user_tty_device_t;
#line 4443

#line 4443

#line 4443
# Type and access for pty devices.
#line 4443

#line 4443

#line 4443

#line 4443
type user_devpts_t, file_type, sysadmfile, ptyfile , userpty_type;
#line 4443

#line 4443
# Allow the pty to be associated with the file system.
#line 4443
allow user_devpts_t devpts_t:filesystem associate;
#line 4443

#line 4443
# Access the pty master multiplexer.
#line 4443
allow user_t ptmx_t:chr_file { ioctl read getattr lock write append };
#line 4443

#line 4443
# Label pty files with a derived type.
#line 4443
type_transition user_t devpts_t:chr_file user_devpts_t;
#line 4443

#line 4443
# Read and write my pty files.
#line 4443
allow user_t user_devpts_t:chr_file { setattr { ioctl read getattr lock write append } };
#line 4443

#line 4443

#line 4443

#line 4443

#line 4443

#line 4443

#line 4443
# Use the type when relabeling pty devices.
#line 4443

#line 4443

#line 4443
type_change user_t sshd_devpts_t:chr_file user_devpts_t;
#line 4443

#line 4443
# Connect to sshd.
#line 4443

#line 4443
allow user_t sshd_t:tcp_socket { connectto recvfrom };
#line 4443
allow sshd_t user_t:tcp_socket { acceptfrom recvfrom };
#line 4443
allow sshd_t tcp_socket_t:tcp_socket { recvfrom };
#line 4443
allow user_t tcp_socket_t:tcp_socket { recvfrom };
#line 4443

#line 4443

#line 4443
# Connect to ssh proxy.
#line 4443

#line 4443
allow user_t user_ssh_t:tcp_socket { connectto recvfrom };
#line 4443
allow user_ssh_t user_t:tcp_socket { acceptfrom recvfrom };
#line 4443
allow user_ssh_t tcp_socket_t:tcp_socket { recvfrom };
#line 4443
allow user_t tcp_socket_t:tcp_socket { recvfrom };
#line 4443

#line 4443

#line 4443
allow user_t sshd_t:fd use;
#line 4443
allow user_t sshd_t:tcp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4443
# Use a Unix stream socket inherited from sshd.
#line 4443
allow user_t sshd_t:unix_stream_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4443

#line 4443
# Type for tmpfs/shm files.
#line 4443
type user_tmpfs_t, file_type, sysadmfile, tmpfsfile;
#line 4443
# Use the type when creating files in tmpfs.
#line 4443

#line 4443

#line 4443

#line 4443

#line 4443
#
#line 4443
# Allow the process to modify the directory.
#line 4443
#
#line 4443
allow user_t tmpfs_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4443

#line 4443
#
#line 4443
# Allow the process to create the file.
#line 4443
#
#line 4443

#line 4443
allow user_t user_tmpfs_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4443
allow user_t user_tmpfs_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4443

#line 4443

#line 4443

#line 4443
type_transition user_t tmpfs_t:dir user_tmpfs_t;
#line 4443
type_transition user_t tmpfs_t:{ file lnk_file sock_file fifo_file } user_tmpfs_t;
#line 4443

#line 4443

#line 4443

#line 4443
allow user_tmpfs_t tmpfs_t:filesystem associate;
#line 4443

#line 4443
# Read and write /var/catman.
#line 4443
allow user_t catman_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4443
allow user_t catman_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4443

#line 4443
# Modify mail spool file.
#line 4443
allow user_t mail_spool_t:dir { read getattr lock search ioctl };
#line 4443
allow user_t mail_spool_t:file { ioctl read getattr lock write append };
#line 4443
allow user_t mail_spool_t:lnk_file read;
#line 4443

#line 4443
#
#line 4443
# Allow the query of filesystem quotas
#line 4443
#
#line 4443
allow user_t fs_type:filesystem quotaget;
#line 4443

#line 4443
# Run helper programs.
#line 4443

#line 4443
allow user_t { bin_t sbin_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4443
allow user_t { bin_t sbin_t }:lnk_file read;
#line 4443

#line 4443
allow user_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4443
allow user_t ld_so_t:file { read getattr lock execute ioctl };
#line 4443
allow user_t ld_so_t:file execute_no_trans;
#line 4443
allow user_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4443
allow user_t shlib_t:file { read getattr lock execute ioctl };
#line 4443
allow user_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4443
allow user_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4443
allow user_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4443

#line 4443

#line 4443
allow user_t etc_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4443

#line 4443

#line 4443
allow user_t lib_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4443

#line 4443

#line 4443
allow user_t bin_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4443

#line 4443

#line 4443
allow user_t sbin_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4443

#line 4443

#line 4443
allow user_t exec_type:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4443

#line 4443

#line 4443
# Run programs developed by other users in the same domain.
#line 4443

#line 4443
allow user_t user_home_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4443

#line 4443

#line 4443
allow user_t user_tmp_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4443

#line 4443

#line 4443
# Run user programs that require different permissions in their own domain.
#line 4443
# These rules were moved into the individual program domains.
#line 4443

#line 4443
# Instantiate derived domains for a number of programs.
#line 4443
# These derived domains encode both information about the calling
#line 4443
# user domain and the program, and allow us to maintain separation
#line 4443
# between different instances of the program being run by different
#line 4443
# user domains.
#line 4443

#line 4443

#line 4443

#line 4443
# Derived domain based on the calling user domain and the program.
#line 4443
type user_su_t, domain, privlog, auth;
#line 4443

#line 4443
# Transition from the user domain to this domain.
#line 4443

#line 4443

#line 4443

#line 4443
#
#line 4443
# Allow the process to transition to the new domain.
#line 4443
#
#line 4443
allow user_t user_su_t:process transition;
#line 4443

#line 4443
#
#line 4443
# Allow the process to execute the program.
#line 4443
# 
#line 4443
allow user_t su_exec_t:file { getattr execute };
#line 4443

#line 4443
#
#line 4443
# Allow the process to reap the new domain.
#line 4443
#
#line 4443
allow user_su_t user_t:process sigchld;
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to inherit and use file 
#line 4443
# descriptions from the creating process and vice versa.
#line 4443
#
#line 4443
allow user_su_t user_t:fd use;
#line 4443
allow user_t user_su_t:fd use;
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to write back to the old domain via a pipe.
#line 4443
#
#line 4443
allow user_su_t user_t:fifo_file { ioctl read getattr lock write append };
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to read and execute the program.
#line 4443
#
#line 4443
allow user_su_t su_exec_t:file { read getattr lock execute ioctl };
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to be entered via the program.
#line 4443
#
#line 4443
allow user_su_t su_exec_t:file entrypoint;
#line 4443

#line 4443
type_transition user_t su_exec_t:process user_su_t;
#line 4443

#line 4443

#line 4443
# This domain is granted permissions common to most domains.
#line 4443

#line 4443

#line 4443
# Grant the permissions common to the test domains.
#line 4443

#line 4443
# Grant permissions within the domain.
#line 4443

#line 4443
# Access other processes in the same domain.
#line 4443
allow user_su_t self:process *;
#line 4443

#line 4443
# Access /proc/PID files for processes in the same domain.
#line 4443
allow user_su_t self:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Access file descriptions, pipes, and sockets
#line 4443
# created by processes in the same domain.
#line 4443
allow user_su_t self:fd *;
#line 4443
allow user_su_t self:fifo_file { ioctl read getattr lock write append };
#line 4443
allow user_su_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4443
allow user_su_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4443

#line 4443
# Allow the domain to communicate with other processes in the same domain.
#line 4443
allow user_su_t self:unix_dgram_socket sendto;
#line 4443
allow user_su_t self:unix_stream_socket connectto;
#line 4443

#line 4443
# Access System V IPC objects created by processes in the same domain.
#line 4443
allow user_su_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 4443
allow user_su_t self:msg  { send receive };
#line 4443
allow user_su_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 4443
allow user_su_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 4443

#line 4443

#line 4443

#line 4443
# Grant read/search permissions to most of /proc.
#line 4443

#line 4443
# Read system information files in /proc.
#line 4443
allow user_su_t proc_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t proc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Stat /proc/kmsg and /proc/kcore.
#line 4443
allow user_su_t proc_kmsg_t:file { getattr };
#line 4443
allow user_su_t proc_kcore_t:file { getattr };
#line 4443

#line 4443
# Read system variables in /proc/sys.
#line 4443
allow user_su_t sysctl_modprobe_t:file { read getattr lock ioctl };
#line 4443
allow user_su_t sysctl_t:file { read getattr lock ioctl };
#line 4443
allow user_su_t sysctl_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t sysctl_fs_t:file { read getattr lock ioctl };
#line 4443
allow user_su_t sysctl_fs_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t sysctl_kernel_t:file { read getattr lock ioctl };
#line 4443
allow user_su_t sysctl_kernel_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t sysctl_net_t:file { read getattr lock ioctl };
#line 4443
allow user_su_t sysctl_net_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t sysctl_vm_t:file { read getattr lock ioctl };
#line 4443
allow user_su_t sysctl_vm_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t sysctl_dev_t:file { read getattr lock ioctl };
#line 4443
allow user_su_t sysctl_dev_t:dir { read getattr lock search ioctl };
#line 4443

#line 4443

#line 4443
# Grant read/search permissions to many system file types.
#line 4443

#line 4443

#line 4443
# Get attributes of file systems.
#line 4443
allow user_su_t fs_type:filesystem getattr;
#line 4443

#line 4443

#line 4443
# Read /.
#line 4443
allow user_su_t root_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t root_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /home.
#line 4443
allow user_su_t home_root_t:dir { read getattr lock search ioctl };
#line 4443

#line 4443
# Read /usr.
#line 4443
allow user_su_t usr_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t usr_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read bin and sbin directories.
#line 4443
allow user_su_t bin_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443
allow user_su_t sbin_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443

#line 4443
# Read directories and files with the readable_t type.
#line 4443
# This type is a general type for "world"-readable files.
#line 4443
allow user_su_t readable_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t readable_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Stat /...security and lost+found.
#line 4443
allow user_su_t file_labels_t:dir getattr;
#line 4443
allow user_su_t lost_found_t:dir getattr;
#line 4443

#line 4443
# Read the devpts root directory.  
#line 4443
allow user_su_t devpts_t:dir { read getattr lock search ioctl };
#line 4443

#line 4443

#line 4443
# Read the /tmp directory and any /tmp files with the base type.
#line 4443
# Temporary files created at runtime will typically use derived types.
#line 4443
allow user_su_t tmp_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t tmp_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /var.
#line 4443
allow user_su_t var_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t var_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /var/catman.
#line 4443
allow user_su_t catman_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t catman_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /var/lib.
#line 4443
allow user_su_t var_lib_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t var_lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443
allow user_su_t var_lib_nfs_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t var_lib_nfs_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443

#line 4443
allow user_su_t tetex_data_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t tetex_data_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443

#line 4443
# Read /var/yp.
#line 4443
allow user_su_t var_yp_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t var_yp_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /var/spool.
#line 4443
allow user_su_t var_spool_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t var_spool_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /var/run, /var/lock, /var/log.
#line 4443
allow user_su_t var_run_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t var_run_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_su_t var_log_t:dir { read getattr lock search ioctl };
#line 4443
#allow user_su_t var_log_t:{ file lnk_file } r_file_perms;
#line 4443
allow user_su_t var_log_sa_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t var_log_sa_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_su_t var_log_ksyms_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
allow user_su_t var_lock_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t var_lock_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /var/run/utmp and /var/log/wtmp.
#line 4443
allow user_su_t initrc_var_run_t:file { read getattr lock ioctl };
#line 4443
allow user_su_t wtmp_t:file { read getattr lock ioctl };
#line 4443

#line 4443
# Read /boot, /boot/System.map*, and /vmlinuz*
#line 4443
allow user_su_t boot_t:dir { search getattr };
#line 4443
allow user_su_t boot_t:file getattr;
#line 4443
allow user_su_t system_map_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
allow user_su_t boot_t:lnk_file read;
#line 4443

#line 4443
# Read /etc.
#line 4443
allow user_su_t etc_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t etc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443
allow user_su_t etc_runtime_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_su_t etc_aliases_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_su_t etc_mail_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t etc_mail_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_su_t resolv_conf_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_su_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4443

#line 4443
# Read /lib.
#line 4443
allow user_su_t lib_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read the linker, shared library, and executable types.
#line 4443
allow user_su_t ld_so_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_su_t shlib_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_su_t exec_type:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read man directories and files.
#line 4443
allow user_su_t man_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t man_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /usr/src.
#line 4443
allow user_su_t src_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t src_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read module-related files.
#line 4443
allow user_su_t modules_object_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t modules_object_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_su_t modules_dep_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_su_t modules_conf_t:{ file lnk_file} { read getattr lock ioctl };
#line 4443

#line 4443
# Read /dev directories and any symbolic links.
#line 4443
allow user_su_t device_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t device_t:lnk_file { read getattr lock ioctl };
#line 4443

#line 4443
# Read /dev/random and /dev/zero.
#line 4443
allow user_su_t random_device_t:chr_file { read getattr lock ioctl };
#line 4443
allow user_su_t zero_device_t:chr_file { read getattr lock ioctl };
#line 4443

#line 4443
# Read the root directory of a tmpfs filesytem and any symbolic links.
#line 4443
allow user_su_t tmpfs_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t tmpfs_t:lnk_file { read getattr lock ioctl };
#line 4443

#line 4443
# Read any symbolic links on a devfs file system.
#line 4443
allow user_su_t device_t:lnk_file { read getattr lock ioctl };
#line 4443

#line 4443
# Read the root directory of a usbdevfs filesystem, and
#line 4443
# the devices and drivers files.  Permit stating of the
#line 4443
# device nodes, but nothing else.
#line 4443
allow user_su_t usbdevfs_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t usbdevfs_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_su_t usbdevfs_device_t:file getattr;
#line 4443

#line 4443

#line 4443
# Grant write permissions to a small set of system file types.
#line 4443
# No permission to create files is granted here.  Use allow rules to grant 
#line 4443
# create permissions to a type or use file_type_auto_trans rules to set up
#line 4443
# new types for files.
#line 4443

#line 4443

#line 4443
# Read and write /dev/tty and /dev/null.
#line 4443
allow user_su_t devtty_t:chr_file { ioctl read getattr lock write append };
#line 4443
allow user_su_t { null_device_t zero_device_t }:chr_file { ioctl read getattr lock write append };
#line 4443

#line 4443
# Do not audit write denials to /etc/ld.so.cache.
#line 4443
dontaudit user_su_t ld_so_cache_t:file write;
#line 4443

#line 4443

#line 4443
# Execute from the system shared libraries.
#line 4443
# No permission to execute anything else is granted here.
#line 4443
# Use can_exec or can_exec_any to grant the ability to execute within a domain.
#line 4443
# Use domain_auto_trans for executing and changing domains.
#line 4443

#line 4443
allow user_su_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t ld_so_t:file { read getattr lock execute ioctl };
#line 4443
allow user_su_t ld_so_t:file execute_no_trans;
#line 4443
allow user_su_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4443
allow user_su_t shlib_t:file { read getattr lock execute ioctl };
#line 4443
allow user_su_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4443
allow user_su_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4443
allow user_su_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4443

#line 4443

#line 4443
# read localization information
#line 4443
allow user_su_t locale_t:dir { read getattr lock search ioctl };
#line 4443
allow user_su_t locale_t:{file lnk_file} { read getattr lock ioctl };
#line 4443

#line 4443
# Obtain the context of any SID, the SID for any context, 
#line 4443
# and the list of active SIDs.
#line 4443
allow user_su_t security_t:security { sid_to_context context_to_sid get_sids };
#line 4443

#line 4443

#line 4443

#line 4443
# Grant permissions needed to create TCP and UDP sockets and 
#line 4443
# to access the network.
#line 4443

#line 4443
#
#line 4443
# Allow the domain to create and use UDP and TCP sockets.
#line 4443
# Other kinds of sockets must be separately authorized for use.
#line 4443
allow user_su_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4443
allow user_su_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4443

#line 4443
#
#line 4443
# Allow the domain to send UDP packets.
#line 4443
# Since the destination sockets type is unknown, the generic
#line 4443
# any_socket_t type is used as a placeholder.
#line 4443
#
#line 4443
allow user_su_t any_socket_t:udp_socket sendto;
#line 4443

#line 4443
#
#line 4443
# Allow the domain to send using any network interface.
#line 4443
# netif_type is a type attribute for all network interface types.
#line 4443
#
#line 4443
allow user_su_t netif_type:netif { tcp_send udp_send rawip_send };
#line 4443

#line 4443
#
#line 4443
# Allow packets sent by the domain to be received on any network interface.
#line 4443
#
#line 4443
allow user_su_t netif_type:netif { tcp_recv udp_recv rawip_recv };
#line 4443

#line 4443
#
#line 4443
# Allow the domain to receive packets from any network interface.
#line 4443
# netmsg_type is a type attribute for all default message types.
#line 4443
#
#line 4443
allow user_su_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
#line 4443

#line 4443
#
#line 4443
# Allow the domain to initiate or accept TCP connections 
#line 4443
# on any network interface.
#line 4443
#
#line 4443
allow user_su_t netmsg_type:tcp_socket { connectto acceptfrom };
#line 4443

#line 4443
#
#line 4443
# Receive resets from the TCP reset socket.
#line 4443
# The TCP reset socket is labeled with the tcp_socket_t type.
#line 4443
#
#line 4443
allow user_su_t tcp_socket_t:tcp_socket recvfrom;
#line 4443

#line 4443
dontaudit user_su_t tcp_socket_t:tcp_socket connectto;
#line 4443

#line 4443
#
#line 4443
# Allow the domain to send to any node.
#line 4443
# node_type is a type attribute for all node types.
#line 4443
#
#line 4443
allow user_su_t node_type:node { tcp_send udp_send rawip_send };
#line 4443

#line 4443
#
#line 4443
# Allow packets sent by the domain to be received from any node.
#line 4443
#
#line 4443
allow user_su_t node_type:node { tcp_recv udp_recv rawip_recv };
#line 4443

#line 4443
#
#line 4443
# Allow the domain to send NFS client requests via the socket
#line 4443
# created by mount.
#line 4443
#
#line 4443
allow user_su_t mount_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4443

#line 4443
#
#line 4443
# Bind to the default port type.
#line 4443
# Other port types must be separately authorized.
#line 4443
#
#line 4443
allow user_su_t port_t:udp_socket name_bind;
#line 4443
allow user_su_t port_t:tcp_socket name_bind;
#line 4443

#line 4443

#line 4443

#line 4443
# Use capabilities.
#line 4443
allow user_su_t self:capability { setuid setgid net_bind_service chown dac_override sys_nice sys_resource };
#line 4443

#line 4443
# Revert to the user domain when a shell is executed.
#line 4443

#line 4443

#line 4443

#line 4443
#
#line 4443
# Allow the process to transition to the new domain.
#line 4443
#
#line 4443
allow user_su_t user_t:process transition;
#line 4443

#line 4443
#
#line 4443
# Allow the process to execute the program.
#line 4443
# 
#line 4443
allow user_su_t shell_exec_t:file { getattr execute };
#line 4443

#line 4443
#
#line 4443
# Allow the process to reap the new domain.
#line 4443
#
#line 4443
allow user_t user_su_t:process sigchld;
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to inherit and use file 
#line 4443
# descriptions from the creating process and vice versa.
#line 4443
#
#line 4443
allow user_t user_su_t:fd use;
#line 4443
allow user_su_t user_t:fd use;
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to write back to the old domain via a pipe.
#line 4443
#
#line 4443
allow user_t user_su_t:fifo_file { ioctl read getattr lock write append };
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to read and execute the program.
#line 4443
#
#line 4443
allow user_t shell_exec_t:file { read getattr lock execute ioctl };
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to be entered via the program.
#line 4443
#
#line 4443
allow user_t shell_exec_t:file entrypoint;
#line 4443

#line 4443
type_transition user_su_t shell_exec_t:process user_t;
#line 4443

#line 4443

#line 4443
allow user_su_t privfd:fd use;
#line 4443

#line 4443
# Write to utmp.
#line 4443
allow user_su_t initrc_var_run_t:file { ioctl read getattr lock write append };
#line 4443

#line 4443

#line 4443

#line 4443
# Run chkpwd.
#line 4443

#line 4443
allow user_su_t chkpwd_exec_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4443

#line 4443

#line 4443

#line 4443
# Inherit and use descriptors from gnome-pty-helper.
#line 4443

#line 4443

#line 4443
# The user role is authorized for this domain.
#line 4443
role user_r types user_su_t;
#line 4443

#line 4443
# Write to the user domain tty.
#line 4443
allow user_su_t user_tty_device_t:chr_file { ioctl read getattr lock write append };
#line 4443
allow user_su_t user_devpts_t:chr_file { ioctl read getattr lock write append };
#line 4443

#line 4443
allow user_su_t user_home_dir_t:dir search;
#line 4443

#line 4443
# Modify .Xauthority file (via xauth program).
#line 4443

#line 4443

#line 4443

#line 4443

#line 4443
#
#line 4443
# Allow the process to transition to the new domain.
#line 4443
#
#line 4443
allow user_su_t user_xauth_t:process transition;
#line 4443

#line 4443
#
#line 4443
# Allow the process to execute the program.
#line 4443
# 
#line 4443
allow user_su_t xauth_exec_t:file { getattr execute };
#line 4443

#line 4443
#
#line 4443
# Allow the process to reap the new domain.
#line 4443
#
#line 4443
allow user_xauth_t user_su_t:process sigchld;
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to inherit and use file 
#line 4443
# descriptions from the creating process and vice versa.
#line 4443
#
#line 4443
allow user_xauth_t user_su_t:fd use;
#line 4443
allow user_su_t user_xauth_t:fd use;
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to write back to the old domain via a pipe.
#line 4443
#
#line 4443
allow user_xauth_t user_su_t:fifo_file { ioctl read getattr lock write append };
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to read and execute the program.
#line 4443
#
#line 4443
allow user_xauth_t xauth_exec_t:file { read getattr lock execute ioctl };
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to be entered via the program.
#line 4443
#
#line 4443
allow user_xauth_t xauth_exec_t:file entrypoint;
#line 4443

#line 4443
type_transition user_su_t xauth_exec_t:process user_xauth_t;
#line 4443

#line 4443

#line 4443

#line 4443
# Access sshd cookie files.
#line 4443
allow user_su_t sshd_tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4443
allow user_su_t sshd_tmp_t:file { ioctl read getattr lock write append };
#line 4443

#line 4443

#line 4443

#line 4443

#line 4443
#
#line 4443
# Allow the process to modify the directory.
#line 4443
#
#line 4443
allow user_su_t sshd_tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4443

#line 4443
#
#line 4443
# Allow the process to create the file.
#line 4443
#
#line 4443

#line 4443
allow user_su_t user_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4443
allow user_su_t user_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4443

#line 4443

#line 4443

#line 4443
type_transition user_su_t sshd_tmp_t:dir user_tmp_t;
#line 4443
type_transition user_su_t sshd_tmp_t:{ file lnk_file sock_file fifo_file } user_tmp_t;
#line 4443

#line 4443

#line 4443

#line 4443

#line 4443
# stop su complaining if you run it from a directory with restrictive perms
#line 4443
dontaudit user_su_t file_type:dir search;
#line 4443

#line 4443

#line 4443
# Derived domain based on the calling user domain and the program.
#line 4443
type user_chkpwd_t, domain, privlog, auth;
#line 4443

#line 4443
# Transition from the user domain to this domain.
#line 4443

#line 4443

#line 4443

#line 4443
#
#line 4443
# Allow the process to transition to the new domain.
#line 4443
#
#line 4443
allow user_t user_chkpwd_t:process transition;
#line 4443

#line 4443
#
#line 4443
# Allow the process to execute the program.
#line 4443
# 
#line 4443
allow user_t chkpwd_exec_t:file { getattr execute };
#line 4443

#line 4443
#
#line 4443
# Allow the process to reap the new domain.
#line 4443
#
#line 4443
allow user_chkpwd_t user_t:process sigchld;
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to inherit and use file 
#line 4443
# descriptions from the creating process and vice versa.
#line 4443
#
#line 4443
allow user_chkpwd_t user_t:fd use;
#line 4443
allow user_t user_chkpwd_t:fd use;
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to write back to the old domain via a pipe.
#line 4443
#
#line 4443
allow user_chkpwd_t user_t:fifo_file { ioctl read getattr lock write append };
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to read and execute the program.
#line 4443
#
#line 4443
allow user_chkpwd_t chkpwd_exec_t:file { read getattr lock execute ioctl };
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to be entered via the program.
#line 4443
#
#line 4443
allow user_chkpwd_t chkpwd_exec_t:file entrypoint;
#line 4443

#line 4443
type_transition user_t chkpwd_exec_t:process user_chkpwd_t;
#line 4443

#line 4443

#line 4443
# The user role is authorized for this domain.
#line 4443
role user_r types user_chkpwd_t;
#line 4443

#line 4443
# This domain is granted permissions common to most domains (includes can_net)
#line 4443

#line 4443

#line 4443
# Grant the permissions common to the test domains.
#line 4443

#line 4443
# Grant permissions within the domain.
#line 4443

#line 4443
# Access other processes in the same domain.
#line 4443
allow user_chkpwd_t self:process *;
#line 4443

#line 4443
# Access /proc/PID files for processes in the same domain.
#line 4443
allow user_chkpwd_t self:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Access file descriptions, pipes, and sockets
#line 4443
# created by processes in the same domain.
#line 4443
allow user_chkpwd_t self:fd *;
#line 4443
allow user_chkpwd_t self:fifo_file { ioctl read getattr lock write append };
#line 4443
allow user_chkpwd_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4443
allow user_chkpwd_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4443

#line 4443
# Allow the domain to communicate with other processes in the same domain.
#line 4443
allow user_chkpwd_t self:unix_dgram_socket sendto;
#line 4443
allow user_chkpwd_t self:unix_stream_socket connectto;
#line 4443

#line 4443
# Access System V IPC objects created by processes in the same domain.
#line 4443
allow user_chkpwd_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 4443
allow user_chkpwd_t self:msg  { send receive };
#line 4443
allow user_chkpwd_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 4443
allow user_chkpwd_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 4443

#line 4443

#line 4443

#line 4443
# Grant read/search permissions to most of /proc.
#line 4443

#line 4443
# Read system information files in /proc.
#line 4443
allow user_chkpwd_t proc_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t proc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Stat /proc/kmsg and /proc/kcore.
#line 4443
allow user_chkpwd_t proc_kmsg_t:file { getattr };
#line 4443
allow user_chkpwd_t proc_kcore_t:file { getattr };
#line 4443

#line 4443
# Read system variables in /proc/sys.
#line 4443
allow user_chkpwd_t sysctl_modprobe_t:file { read getattr lock ioctl };
#line 4443
allow user_chkpwd_t sysctl_t:file { read getattr lock ioctl };
#line 4443
allow user_chkpwd_t sysctl_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t sysctl_fs_t:file { read getattr lock ioctl };
#line 4443
allow user_chkpwd_t sysctl_fs_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t sysctl_kernel_t:file { read getattr lock ioctl };
#line 4443
allow user_chkpwd_t sysctl_kernel_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t sysctl_net_t:file { read getattr lock ioctl };
#line 4443
allow user_chkpwd_t sysctl_net_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t sysctl_vm_t:file { read getattr lock ioctl };
#line 4443
allow user_chkpwd_t sysctl_vm_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t sysctl_dev_t:file { read getattr lock ioctl };
#line 4443
allow user_chkpwd_t sysctl_dev_t:dir { read getattr lock search ioctl };
#line 4443

#line 4443

#line 4443
# Grant read/search permissions to many system file types.
#line 4443

#line 4443

#line 4443
# Get attributes of file systems.
#line 4443
allow user_chkpwd_t fs_type:filesystem getattr;
#line 4443

#line 4443

#line 4443
# Read /.
#line 4443
allow user_chkpwd_t root_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t root_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /home.
#line 4443
allow user_chkpwd_t home_root_t:dir { read getattr lock search ioctl };
#line 4443

#line 4443
# Read /usr.
#line 4443
allow user_chkpwd_t usr_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t usr_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read bin and sbin directories.
#line 4443
allow user_chkpwd_t bin_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443
allow user_chkpwd_t sbin_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443

#line 4443
# Read directories and files with the readable_t type.
#line 4443
# This type is a general type for "world"-readable files.
#line 4443
allow user_chkpwd_t readable_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t readable_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Stat /...security and lost+found.
#line 4443
allow user_chkpwd_t file_labels_t:dir getattr;
#line 4443
allow user_chkpwd_t lost_found_t:dir getattr;
#line 4443

#line 4443
# Read the devpts root directory.  
#line 4443
allow user_chkpwd_t devpts_t:dir { read getattr lock search ioctl };
#line 4443

#line 4443

#line 4443
# Read the /tmp directory and any /tmp files with the base type.
#line 4443
# Temporary files created at runtime will typically use derived types.
#line 4443
allow user_chkpwd_t tmp_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t tmp_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /var.
#line 4443
allow user_chkpwd_t var_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t var_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /var/catman.
#line 4443
allow user_chkpwd_t catman_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t catman_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /var/lib.
#line 4443
allow user_chkpwd_t var_lib_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t var_lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443
allow user_chkpwd_t var_lib_nfs_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t var_lib_nfs_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443

#line 4443
allow user_chkpwd_t tetex_data_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t tetex_data_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443

#line 4443
# Read /var/yp.
#line 4443
allow user_chkpwd_t var_yp_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t var_yp_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /var/spool.
#line 4443
allow user_chkpwd_t var_spool_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t var_spool_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /var/run, /var/lock, /var/log.
#line 4443
allow user_chkpwd_t var_run_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t var_run_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_chkpwd_t var_log_t:dir { read getattr lock search ioctl };
#line 4443
#allow user_chkpwd_t var_log_t:{ file lnk_file } r_file_perms;
#line 4443
allow user_chkpwd_t var_log_sa_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t var_log_sa_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_chkpwd_t var_log_ksyms_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
allow user_chkpwd_t var_lock_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t var_lock_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /var/run/utmp and /var/log/wtmp.
#line 4443
allow user_chkpwd_t initrc_var_run_t:file { read getattr lock ioctl };
#line 4443
allow user_chkpwd_t wtmp_t:file { read getattr lock ioctl };
#line 4443

#line 4443
# Read /boot, /boot/System.map*, and /vmlinuz*
#line 4443
allow user_chkpwd_t boot_t:dir { search getattr };
#line 4443
allow user_chkpwd_t boot_t:file getattr;
#line 4443
allow user_chkpwd_t system_map_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
allow user_chkpwd_t boot_t:lnk_file read;
#line 4443

#line 4443
# Read /etc.
#line 4443
allow user_chkpwd_t etc_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t etc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443
allow user_chkpwd_t etc_runtime_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_chkpwd_t etc_aliases_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_chkpwd_t etc_mail_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t etc_mail_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_chkpwd_t resolv_conf_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_chkpwd_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4443

#line 4443
# Read /lib.
#line 4443
allow user_chkpwd_t lib_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read the linker, shared library, and executable types.
#line 4443
allow user_chkpwd_t ld_so_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_chkpwd_t shlib_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_chkpwd_t exec_type:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read man directories and files.
#line 4443
allow user_chkpwd_t man_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t man_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /usr/src.
#line 4443
allow user_chkpwd_t src_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t src_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read module-related files.
#line 4443
allow user_chkpwd_t modules_object_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t modules_object_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_chkpwd_t modules_dep_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_chkpwd_t modules_conf_t:{ file lnk_file} { read getattr lock ioctl };
#line 4443

#line 4443
# Read /dev directories and any symbolic links.
#line 4443
allow user_chkpwd_t device_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t device_t:lnk_file { read getattr lock ioctl };
#line 4443

#line 4443
# Read /dev/random and /dev/zero.
#line 4443
allow user_chkpwd_t random_device_t:chr_file { read getattr lock ioctl };
#line 4443
allow user_chkpwd_t zero_device_t:chr_file { read getattr lock ioctl };
#line 4443

#line 4443
# Read the root directory of a tmpfs filesytem and any symbolic links.
#line 4443
allow user_chkpwd_t tmpfs_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t tmpfs_t:lnk_file { read getattr lock ioctl };
#line 4443

#line 4443
# Read any symbolic links on a devfs file system.
#line 4443
allow user_chkpwd_t device_t:lnk_file { read getattr lock ioctl };
#line 4443

#line 4443
# Read the root directory of a usbdevfs filesystem, and
#line 4443
# the devices and drivers files.  Permit stating of the
#line 4443
# device nodes, but nothing else.
#line 4443
allow user_chkpwd_t usbdevfs_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t usbdevfs_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_chkpwd_t usbdevfs_device_t:file getattr;
#line 4443

#line 4443

#line 4443
# Grant write permissions to a small set of system file types.
#line 4443
# No permission to create files is granted here.  Use allow rules to grant 
#line 4443
# create permissions to a type or use file_type_auto_trans rules to set up
#line 4443
# new types for files.
#line 4443

#line 4443

#line 4443
# Read and write /dev/tty and /dev/null.
#line 4443
allow user_chkpwd_t devtty_t:chr_file { ioctl read getattr lock write append };
#line 4443
allow user_chkpwd_t { null_device_t zero_device_t }:chr_file { ioctl read getattr lock write append };
#line 4443

#line 4443
# Do not audit write denials to /etc/ld.so.cache.
#line 4443
dontaudit user_chkpwd_t ld_so_cache_t:file write;
#line 4443

#line 4443

#line 4443
# Execute from the system shared libraries.
#line 4443
# No permission to execute anything else is granted here.
#line 4443
# Use can_exec or can_exec_any to grant the ability to execute within a domain.
#line 4443
# Use domain_auto_trans for executing and changing domains.
#line 4443

#line 4443
allow user_chkpwd_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t ld_so_t:file { read getattr lock execute ioctl };
#line 4443
allow user_chkpwd_t ld_so_t:file execute_no_trans;
#line 4443
allow user_chkpwd_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4443
allow user_chkpwd_t shlib_t:file { read getattr lock execute ioctl };
#line 4443
allow user_chkpwd_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4443
allow user_chkpwd_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4443
allow user_chkpwd_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4443

#line 4443

#line 4443
# read localization information
#line 4443
allow user_chkpwd_t locale_t:dir { read getattr lock search ioctl };
#line 4443
allow user_chkpwd_t locale_t:{file lnk_file} { read getattr lock ioctl };
#line 4443

#line 4443
# Obtain the context of any SID, the SID for any context, 
#line 4443
# and the list of active SIDs.
#line 4443
allow user_chkpwd_t security_t:security { sid_to_context context_to_sid get_sids };
#line 4443

#line 4443

#line 4443

#line 4443
# Grant permissions needed to create TCP and UDP sockets and 
#line 4443
# to access the network.
#line 4443

#line 4443
#
#line 4443
# Allow the domain to create and use UDP and TCP sockets.
#line 4443
# Other kinds of sockets must be separately authorized for use.
#line 4443
allow user_chkpwd_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4443
allow user_chkpwd_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4443

#line 4443
#
#line 4443
# Allow the domain to send UDP packets.
#line 4443
# Since the destination sockets type is unknown, the generic
#line 4443
# any_socket_t type is used as a placeholder.
#line 4443
#
#line 4443
allow user_chkpwd_t any_socket_t:udp_socket sendto;
#line 4443

#line 4443
#
#line 4443
# Allow the domain to send using any network interface.
#line 4443
# netif_type is a type attribute for all network interface types.
#line 4443
#
#line 4443
allow user_chkpwd_t netif_type:netif { tcp_send udp_send rawip_send };
#line 4443

#line 4443
#
#line 4443
# Allow packets sent by the domain to be received on any network interface.
#line 4443
#
#line 4443
allow user_chkpwd_t netif_type:netif { tcp_recv udp_recv rawip_recv };
#line 4443

#line 4443
#
#line 4443
# Allow the domain to receive packets from any network interface.
#line 4443
# netmsg_type is a type attribute for all default message types.
#line 4443
#
#line 4443
allow user_chkpwd_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
#line 4443

#line 4443
#
#line 4443
# Allow the domain to initiate or accept TCP connections 
#line 4443
# on any network interface.
#line 4443
#
#line 4443
allow user_chkpwd_t netmsg_type:tcp_socket { connectto acceptfrom };
#line 4443

#line 4443
#
#line 4443
# Receive resets from the TCP reset socket.
#line 4443
# The TCP reset socket is labeled with the tcp_socket_t type.
#line 4443
#
#line 4443
allow user_chkpwd_t tcp_socket_t:tcp_socket recvfrom;
#line 4443

#line 4443
dontaudit user_chkpwd_t tcp_socket_t:tcp_socket connectto;
#line 4443

#line 4443
#
#line 4443
# Allow the domain to send to any node.
#line 4443
# node_type is a type attribute for all node types.
#line 4443
#
#line 4443
allow user_chkpwd_t node_type:node { tcp_send udp_send rawip_send };
#line 4443

#line 4443
#
#line 4443
# Allow packets sent by the domain to be received from any node.
#line 4443
#
#line 4443
allow user_chkpwd_t node_type:node { tcp_recv udp_recv rawip_recv };
#line 4443

#line 4443
#
#line 4443
# Allow the domain to send NFS client requests via the socket
#line 4443
# created by mount.
#line 4443
#
#line 4443
allow user_chkpwd_t mount_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4443

#line 4443
#
#line 4443
# Bind to the default port type.
#line 4443
# Other port types must be separately authorized.
#line 4443
#
#line 4443
allow user_chkpwd_t port_t:udp_socket name_bind;
#line 4443
allow user_chkpwd_t port_t:tcp_socket name_bind;
#line 4443

#line 4443

#line 4443

#line 4443
# Use capabilities.
#line 4443
allow user_chkpwd_t self:capability setuid;
#line 4443

#line 4443
# Inherit and use descriptors from gnome-pty-helper.
#line 4443

#line 4443

#line 4443
# Inherit and use descriptors from newrole.
#line 4443
allow user_chkpwd_t newrole_t:fd use;
#line 4443

#line 4443
# Write to the user domain tty.
#line 4443
allow user_chkpwd_t user_tty_device_t:chr_file { ioctl read getattr lock write append };
#line 4443
allow user_chkpwd_t user_devpts_t:chr_file { ioctl read getattr lock write append };
#line 4443

#line 4443

#line 4443

#line 4443

#line 4443

#line 4443

#line 4443
# Derived domain based on the calling user domain and the program.
#line 4443
type user_xauth_t, domain;
#line 4443
type user_home_xauth_t, file_type, sysadmfile;
#line 4443

#line 4443
allow user_t user_home_xauth_t:file { relabelfrom relabelto { create ioctl read getattr lock write setattr append link unlink rename } };
#line 4443

#line 4443
# Transition from the user domain to this domain.
#line 4443

#line 4443

#line 4443

#line 4443
#
#line 4443
# Allow the process to transition to the new domain.
#line 4443
#
#line 4443
allow user_t user_xauth_t:process transition;
#line 4443

#line 4443
#
#line 4443
# Allow the process to execute the program.
#line 4443
# 
#line 4443
allow user_t xauth_exec_t:file { getattr execute };
#line 4443

#line 4443
#
#line 4443
# Allow the process to reap the new domain.
#line 4443
#
#line 4443
allow user_xauth_t user_t:process sigchld;
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to inherit and use file 
#line 4443
# descriptions from the creating process and vice versa.
#line 4443
#
#line 4443
allow user_xauth_t user_t:fd use;
#line 4443
allow user_t user_xauth_t:fd use;
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to write back to the old domain via a pipe.
#line 4443
#
#line 4443
allow user_xauth_t user_t:fifo_file { ioctl read getattr lock write append };
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to read and execute the program.
#line 4443
#
#line 4443
allow user_xauth_t xauth_exec_t:file { read getattr lock execute ioctl };
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to be entered via the program.
#line 4443
#
#line 4443
allow user_xauth_t xauth_exec_t:file entrypoint;
#line 4443

#line 4443
type_transition user_t xauth_exec_t:process user_xauth_t;
#line 4443

#line 4443

#line 4443

#line 4443

#line 4443

#line 4443
#
#line 4443
# Allow the process to transition to the new domain.
#line 4443
#
#line 4443
allow user_ssh_t user_xauth_t:process transition;
#line 4443

#line 4443
#
#line 4443
# Allow the process to execute the program.
#line 4443
# 
#line 4443
allow user_ssh_t xauth_exec_t:file { getattr execute };
#line 4443

#line 4443
#
#line 4443
# Allow the process to reap the new domain.
#line 4443
#
#line 4443
allow user_xauth_t user_ssh_t:process sigchld;
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to inherit and use file 
#line 4443
# descriptions from the creating process and vice versa.
#line 4443
#
#line 4443
allow user_xauth_t user_ssh_t:fd use;
#line 4443
allow user_ssh_t user_xauth_t:fd use;
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to write back to the old domain via a pipe.
#line 4443
#
#line 4443
allow user_xauth_t user_ssh_t:fifo_file { ioctl read getattr lock write append };
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to read and execute the program.
#line 4443
#
#line 4443
allow user_xauth_t xauth_exec_t:file { read getattr lock execute ioctl };
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to be entered via the program.
#line 4443
#
#line 4443
allow user_xauth_t xauth_exec_t:file entrypoint;
#line 4443

#line 4443
type_transition user_ssh_t xauth_exec_t:process user_xauth_t;
#line 4443

#line 4443
allow user_xauth_t sshd_t:fifo_file { getattr read };
#line 4443
dontaudit user_xauth_t user_ssh_t:tcp_socket { read write };
#line 4443
allow user_xauth_t sshd_t:process sigchld;
#line 4443

#line 4443

#line 4443

#line 4443

#line 4443

#line 4443

#line 4443
#
#line 4443
# Allow the process to transition to the new domain.
#line 4443
#
#line 4443
allow user_su_t user_xauth_t:process transition;
#line 4443

#line 4443
#
#line 4443
# Allow the process to execute the program.
#line 4443
# 
#line 4443
allow user_su_t xauth_exec_t:file { getattr execute };
#line 4443

#line 4443
#
#line 4443
# Allow the process to reap the new domain.
#line 4443
#
#line 4443
allow user_xauth_t user_su_t:process sigchld;
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to inherit and use file 
#line 4443
# descriptions from the creating process and vice versa.
#line 4443
#
#line 4443
allow user_xauth_t user_su_t:fd use;
#line 4443
allow user_su_t user_xauth_t:fd use;
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to write back to the old domain via a pipe.
#line 4443
#
#line 4443
allow user_xauth_t user_su_t:fifo_file { ioctl read getattr lock write append };
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to read and execute the program.
#line 4443
#
#line 4443
allow user_xauth_t xauth_exec_t:file { read getattr lock execute ioctl };
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to be entered via the program.
#line 4443
#
#line 4443
allow user_xauth_t xauth_exec_t:file entrypoint;
#line 4443

#line 4443
type_transition user_su_t xauth_exec_t:process user_xauth_t;
#line 4443

#line 4443

#line 4443

#line 4443
# The user role is authorized for this domain.
#line 4443
role user_r types user_xauth_t;
#line 4443

#line 4443
# Inherit and use descriptors from gnome-pty-helper.
#line 4443

#line 4443

#line 4443
allow user_xauth_t privfd:fd use;
#line 4443

#line 4443
# allow ps to show xauth
#line 4443
allow user_t user_xauth_t:dir { search getattr read };
#line 4443
allow user_t user_xauth_t:{ file lnk_file } { read getattr };
#line 4443
allow user_t user_xauth_t:process signal;
#line 4443

#line 4443

#line 4443
allow user_xauth_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4443
allow user_xauth_t ld_so_t:file { read getattr lock execute ioctl };
#line 4443
allow user_xauth_t ld_so_t:file execute_no_trans;
#line 4443
allow user_xauth_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4443
allow user_xauth_t shlib_t:file { read getattr lock execute ioctl };
#line 4443
allow user_xauth_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4443
allow user_xauth_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4443
allow user_xauth_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4443

#line 4443

#line 4443
# allow DNS lookups...
#line 4443

#line 4443
#
#line 4443
# Allow the domain to create and use UDP and TCP sockets.
#line 4443
# Other kinds of sockets must be separately authorized for use.
#line 4443
allow user_xauth_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4443
allow user_xauth_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4443

#line 4443
#
#line 4443
# Allow the domain to send UDP packets.
#line 4443
# Since the destination sockets type is unknown, the generic
#line 4443
# any_socket_t type is used as a placeholder.
#line 4443
#
#line 4443
allow user_xauth_t any_socket_t:udp_socket sendto;
#line 4443

#line 4443
#
#line 4443
# Allow the domain to send using any network interface.
#line 4443
# netif_type is a type attribute for all network interface types.
#line 4443
#
#line 4443
allow user_xauth_t netif_type:netif { tcp_send udp_send rawip_send };
#line 4443

#line 4443
#
#line 4443
# Allow packets sent by the domain to be received on any network interface.
#line 4443
#
#line 4443
allow user_xauth_t netif_type:netif { tcp_recv udp_recv rawip_recv };
#line 4443

#line 4443
#
#line 4443
# Allow the domain to receive packets from any network interface.
#line 4443
# netmsg_type is a type attribute for all default message types.
#line 4443
#
#line 4443
allow user_xauth_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
#line 4443

#line 4443
#
#line 4443
# Allow the domain to initiate or accept TCP connections 
#line 4443
# on any network interface.
#line 4443
#
#line 4443
allow user_xauth_t netmsg_type:tcp_socket { connectto acceptfrom };
#line 4443

#line 4443
#
#line 4443
# Receive resets from the TCP reset socket.
#line 4443
# The TCP reset socket is labeled with the tcp_socket_t type.
#line 4443
#
#line 4443
allow user_xauth_t tcp_socket_t:tcp_socket recvfrom;
#line 4443

#line 4443
dontaudit user_xauth_t tcp_socket_t:tcp_socket connectto;
#line 4443

#line 4443
#
#line 4443
# Allow the domain to send to any node.
#line 4443
# node_type is a type attribute for all node types.
#line 4443
#
#line 4443
allow user_xauth_t node_type:node { tcp_send udp_send rawip_send };
#line 4443

#line 4443
#
#line 4443
# Allow packets sent by the domain to be received from any node.
#line 4443
#
#line 4443
allow user_xauth_t node_type:node { tcp_recv udp_recv rawip_recv };
#line 4443

#line 4443
#
#line 4443
# Allow the domain to send NFS client requests via the socket
#line 4443
# created by mount.
#line 4443
#
#line 4443
allow user_xauth_t mount_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4443

#line 4443
#
#line 4443
# Bind to the default port type.
#line 4443
# Other port types must be separately authorized.
#line 4443
#
#line 4443
allow user_xauth_t port_t:udp_socket name_bind;
#line 4443
allow user_xauth_t port_t:tcp_socket name_bind;
#line 4443

#line 4443

#line 4443

#line 4443
#allow user_xauth_t devpts_t:dir { getattr read search };
#line 4443
#allow user_xauth_t device_t:dir search;
#line 4443
#allow user_xauth_t devtty_t:chr_file rw_file_perms;
#line 4443
allow user_xauth_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4443
allow user_xauth_t { etc_t resolv_conf_t }:file { getattr read };
#line 4443
allow user_xauth_t fs_t:filesystem getattr;
#line 4443

#line 4443
#allow user_xauth_t proc_t:dir search;
#line 4443
#allow user_xauth_t { self proc_t }:lnk_file read;
#line 4443
#allow user_xauth_t self:dir search;
#line 4443
#dontaudit user_xauth_t var_run_t:dir search;
#line 4443

#line 4443
# Write to the user domain tty.
#line 4443
allow user_xauth_t user_tty_device_t:chr_file { ioctl read getattr lock write append };
#line 4443
allow user_xauth_t user_devpts_t:chr_file { ioctl read getattr lock write append };
#line 4443

#line 4443
# allow utmp access
#line 4443
#allow user_xauth_t initrc_var_run_t:file read;
#line 4443
#dontaudit user_xauth_t initrc_var_run_t:file lock;
#line 4443

#line 4443
# Scan /var/run.
#line 4443
allow user_xauth_t var_t:dir search;
#line 4443
allow user_xauth_t var_run_t:dir search; 
#line 4443

#line 4443
# this is what we are here for
#line 4443
allow user_xauth_t home_root_t:dir search;
#line 4443

#line 4443

#line 4443

#line 4443

#line 4443
#
#line 4443
# Allow the process to modify the directory.
#line 4443
#
#line 4443
allow user_xauth_t user_home_dir_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4443

#line 4443
#
#line 4443
# Allow the process to create the file.
#line 4443
#
#line 4443

#line 4443
allow user_xauth_t user_home_xauth_t:file { create ioctl read getattr lock write setattr append link unlink rename };
#line 4443

#line 4443

#line 4443

#line 4443
type_transition user_xauth_t user_home_dir_t:file user_home_xauth_t;
#line 4443

#line 4443

#line 4443

#line 4443

#line 4443

#line 4443

#line 4443

#line 4443

#line 4443

#line 4443

#line 4443
# Derived domain based on the calling user domain and the program.
#line 4443
type user_crontab_t, domain, privlog;
#line 4443

#line 4443
# Transition from the user domain to the derived domain.
#line 4443

#line 4443

#line 4443

#line 4443
#
#line 4443
# Allow the process to transition to the new domain.
#line 4443
#
#line 4443
allow user_t user_crontab_t:process transition;
#line 4443

#line 4443
#
#line 4443
# Allow the process to execute the program.
#line 4443
# 
#line 4443
allow user_t crontab_exec_t:file { getattr execute };
#line 4443

#line 4443
#
#line 4443
# Allow the process to reap the new domain.
#line 4443
#
#line 4443
allow user_crontab_t user_t:process sigchld;
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to inherit and use file 
#line 4443
# descriptions from the creating process and vice versa.
#line 4443
#
#line 4443
allow user_crontab_t user_t:fd use;
#line 4443
allow user_t user_crontab_t:fd use;
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to write back to the old domain via a pipe.
#line 4443
#
#line 4443
allow user_crontab_t user_t:fifo_file { ioctl read getattr lock write append };
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to read and execute the program.
#line 4443
#
#line 4443
allow user_crontab_t crontab_exec_t:file { read getattr lock execute ioctl };
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to be entered via the program.
#line 4443
#
#line 4443
allow user_crontab_t crontab_exec_t:file entrypoint;
#line 4443

#line 4443
type_transition user_t crontab_exec_t:process user_crontab_t;
#line 4443

#line 4443

#line 4443
# The user role is authorized for this domain.
#line 4443
role user_r types user_crontab_t;
#line 4443

#line 4443
# This domain is granted permissions common to most domains (including can_net)
#line 4443

#line 4443

#line 4443
# Grant the permissions common to the test domains.
#line 4443

#line 4443
# Grant permissions within the domain.
#line 4443

#line 4443
# Access other processes in the same domain.
#line 4443
allow user_crontab_t self:process *;
#line 4443

#line 4443
# Access /proc/PID files for processes in the same domain.
#line 4443
allow user_crontab_t self:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Access file descriptions, pipes, and sockets
#line 4443
# created by processes in the same domain.
#line 4443
allow user_crontab_t self:fd *;
#line 4443
allow user_crontab_t self:fifo_file { ioctl read getattr lock write append };
#line 4443
allow user_crontab_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4443
allow user_crontab_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4443

#line 4443
# Allow the domain to communicate with other processes in the same domain.
#line 4443
allow user_crontab_t self:unix_dgram_socket sendto;
#line 4443
allow user_crontab_t self:unix_stream_socket connectto;
#line 4443

#line 4443
# Access System V IPC objects created by processes in the same domain.
#line 4443
allow user_crontab_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 4443
allow user_crontab_t self:msg  { send receive };
#line 4443
allow user_crontab_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 4443
allow user_crontab_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 4443

#line 4443

#line 4443

#line 4443
# Grant read/search permissions to most of /proc.
#line 4443

#line 4443
# Read system information files in /proc.
#line 4443
allow user_crontab_t proc_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t proc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Stat /proc/kmsg and /proc/kcore.
#line 4443
allow user_crontab_t proc_kmsg_t:file { getattr };
#line 4443
allow user_crontab_t proc_kcore_t:file { getattr };
#line 4443

#line 4443
# Read system variables in /proc/sys.
#line 4443
allow user_crontab_t sysctl_modprobe_t:file { read getattr lock ioctl };
#line 4443
allow user_crontab_t sysctl_t:file { read getattr lock ioctl };
#line 4443
allow user_crontab_t sysctl_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t sysctl_fs_t:file { read getattr lock ioctl };
#line 4443
allow user_crontab_t sysctl_fs_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t sysctl_kernel_t:file { read getattr lock ioctl };
#line 4443
allow user_crontab_t sysctl_kernel_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t sysctl_net_t:file { read getattr lock ioctl };
#line 4443
allow user_crontab_t sysctl_net_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t sysctl_vm_t:file { read getattr lock ioctl };
#line 4443
allow user_crontab_t sysctl_vm_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t sysctl_dev_t:file { read getattr lock ioctl };
#line 4443
allow user_crontab_t sysctl_dev_t:dir { read getattr lock search ioctl };
#line 4443

#line 4443

#line 4443
# Grant read/search permissions to many system file types.
#line 4443

#line 4443

#line 4443
# Get attributes of file systems.
#line 4443
allow user_crontab_t fs_type:filesystem getattr;
#line 4443

#line 4443

#line 4443
# Read /.
#line 4443
allow user_crontab_t root_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t root_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /home.
#line 4443
allow user_crontab_t home_root_t:dir { read getattr lock search ioctl };
#line 4443

#line 4443
# Read /usr.
#line 4443
allow user_crontab_t usr_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t usr_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read bin and sbin directories.
#line 4443
allow user_crontab_t bin_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443
allow user_crontab_t sbin_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443

#line 4443
# Read directories and files with the readable_t type.
#line 4443
# This type is a general type for "world"-readable files.
#line 4443
allow user_crontab_t readable_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t readable_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Stat /...security and lost+found.
#line 4443
allow user_crontab_t file_labels_t:dir getattr;
#line 4443
allow user_crontab_t lost_found_t:dir getattr;
#line 4443

#line 4443
# Read the devpts root directory.  
#line 4443
allow user_crontab_t devpts_t:dir { read getattr lock search ioctl };
#line 4443

#line 4443

#line 4443
# Read the /tmp directory and any /tmp files with the base type.
#line 4443
# Temporary files created at runtime will typically use derived types.
#line 4443
allow user_crontab_t tmp_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t tmp_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /var.
#line 4443
allow user_crontab_t var_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t var_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /var/catman.
#line 4443
allow user_crontab_t catman_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t catman_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /var/lib.
#line 4443
allow user_crontab_t var_lib_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t var_lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443
allow user_crontab_t var_lib_nfs_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t var_lib_nfs_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443

#line 4443
allow user_crontab_t tetex_data_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t tetex_data_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443

#line 4443
# Read /var/yp.
#line 4443
allow user_crontab_t var_yp_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t var_yp_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /var/spool.
#line 4443
allow user_crontab_t var_spool_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t var_spool_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /var/run, /var/lock, /var/log.
#line 4443
allow user_crontab_t var_run_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t var_run_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_crontab_t var_log_t:dir { read getattr lock search ioctl };
#line 4443
#allow user_crontab_t var_log_t:{ file lnk_file } r_file_perms;
#line 4443
allow user_crontab_t var_log_sa_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t var_log_sa_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_crontab_t var_log_ksyms_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
allow user_crontab_t var_lock_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t var_lock_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /var/run/utmp and /var/log/wtmp.
#line 4443
allow user_crontab_t initrc_var_run_t:file { read getattr lock ioctl };
#line 4443
allow user_crontab_t wtmp_t:file { read getattr lock ioctl };
#line 4443

#line 4443
# Read /boot, /boot/System.map*, and /vmlinuz*
#line 4443
allow user_crontab_t boot_t:dir { search getattr };
#line 4443
allow user_crontab_t boot_t:file getattr;
#line 4443
allow user_crontab_t system_map_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
allow user_crontab_t boot_t:lnk_file read;
#line 4443

#line 4443
# Read /etc.
#line 4443
allow user_crontab_t etc_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t etc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443
allow user_crontab_t etc_runtime_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_crontab_t etc_aliases_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_crontab_t etc_mail_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t etc_mail_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_crontab_t resolv_conf_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_crontab_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4443

#line 4443
# Read /lib.
#line 4443
allow user_crontab_t lib_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read the linker, shared library, and executable types.
#line 4443
allow user_crontab_t ld_so_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_crontab_t shlib_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_crontab_t exec_type:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read man directories and files.
#line 4443
allow user_crontab_t man_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t man_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /usr/src.
#line 4443
allow user_crontab_t src_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t src_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read module-related files.
#line 4443
allow user_crontab_t modules_object_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t modules_object_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_crontab_t modules_dep_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_crontab_t modules_conf_t:{ file lnk_file} { read getattr lock ioctl };
#line 4443

#line 4443
# Read /dev directories and any symbolic links.
#line 4443
allow user_crontab_t device_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t device_t:lnk_file { read getattr lock ioctl };
#line 4443

#line 4443
# Read /dev/random and /dev/zero.
#line 4443
allow user_crontab_t random_device_t:chr_file { read getattr lock ioctl };
#line 4443
allow user_crontab_t zero_device_t:chr_file { read getattr lock ioctl };
#line 4443

#line 4443
# Read the root directory of a tmpfs filesytem and any symbolic links.
#line 4443
allow user_crontab_t tmpfs_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t tmpfs_t:lnk_file { read getattr lock ioctl };
#line 4443

#line 4443
# Read any symbolic links on a devfs file system.
#line 4443
allow user_crontab_t device_t:lnk_file { read getattr lock ioctl };
#line 4443

#line 4443
# Read the root directory of a usbdevfs filesystem, and
#line 4443
# the devices and drivers files.  Permit stating of the
#line 4443
# device nodes, but nothing else.
#line 4443
allow user_crontab_t usbdevfs_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t usbdevfs_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_crontab_t usbdevfs_device_t:file getattr;
#line 4443

#line 4443

#line 4443
# Grant write permissions to a small set of system file types.
#line 4443
# No permission to create files is granted here.  Use allow rules to grant 
#line 4443
# create permissions to a type or use file_type_auto_trans rules to set up
#line 4443
# new types for files.
#line 4443

#line 4443

#line 4443
# Read and write /dev/tty and /dev/null.
#line 4443
allow user_crontab_t devtty_t:chr_file { ioctl read getattr lock write append };
#line 4443
allow user_crontab_t { null_device_t zero_device_t }:chr_file { ioctl read getattr lock write append };
#line 4443

#line 4443
# Do not audit write denials to /etc/ld.so.cache.
#line 4443
dontaudit user_crontab_t ld_so_cache_t:file write;
#line 4443

#line 4443

#line 4443
# Execute from the system shared libraries.
#line 4443
# No permission to execute anything else is granted here.
#line 4443
# Use can_exec or can_exec_any to grant the ability to execute within a domain.
#line 4443
# Use domain_auto_trans for executing and changing domains.
#line 4443

#line 4443
allow user_crontab_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t ld_so_t:file { read getattr lock execute ioctl };
#line 4443
allow user_crontab_t ld_so_t:file execute_no_trans;
#line 4443
allow user_crontab_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4443
allow user_crontab_t shlib_t:file { read getattr lock execute ioctl };
#line 4443
allow user_crontab_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4443
allow user_crontab_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4443
allow user_crontab_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4443

#line 4443

#line 4443
# read localization information
#line 4443
allow user_crontab_t locale_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crontab_t locale_t:{file lnk_file} { read getattr lock ioctl };
#line 4443

#line 4443
# Obtain the context of any SID, the SID for any context, 
#line 4443
# and the list of active SIDs.
#line 4443
allow user_crontab_t security_t:security { sid_to_context context_to_sid get_sids };
#line 4443

#line 4443

#line 4443

#line 4443
# Grant permissions needed to create TCP and UDP sockets and 
#line 4443
# to access the network.
#line 4443

#line 4443
#
#line 4443
# Allow the domain to create and use UDP and TCP sockets.
#line 4443
# Other kinds of sockets must be separately authorized for use.
#line 4443
allow user_crontab_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4443
allow user_crontab_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4443

#line 4443
#
#line 4443
# Allow the domain to send UDP packets.
#line 4443
# Since the destination sockets type is unknown, the generic
#line 4443
# any_socket_t type is used as a placeholder.
#line 4443
#
#line 4443
allow user_crontab_t any_socket_t:udp_socket sendto;
#line 4443

#line 4443
#
#line 4443
# Allow the domain to send using any network interface.
#line 4443
# netif_type is a type attribute for all network interface types.
#line 4443
#
#line 4443
allow user_crontab_t netif_type:netif { tcp_send udp_send rawip_send };
#line 4443

#line 4443
#
#line 4443
# Allow packets sent by the domain to be received on any network interface.
#line 4443
#
#line 4443
allow user_crontab_t netif_type:netif { tcp_recv udp_recv rawip_recv };
#line 4443

#line 4443
#
#line 4443
# Allow the domain to receive packets from any network interface.
#line 4443
# netmsg_type is a type attribute for all default message types.
#line 4443
#
#line 4443
allow user_crontab_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
#line 4443

#line 4443
#
#line 4443
# Allow the domain to initiate or accept TCP connections 
#line 4443
# on any network interface.
#line 4443
#
#line 4443
allow user_crontab_t netmsg_type:tcp_socket { connectto acceptfrom };
#line 4443

#line 4443
#
#line 4443
# Receive resets from the TCP reset socket.
#line 4443
# The TCP reset socket is labeled with the tcp_socket_t type.
#line 4443
#
#line 4443
allow user_crontab_t tcp_socket_t:tcp_socket recvfrom;
#line 4443

#line 4443
dontaudit user_crontab_t tcp_socket_t:tcp_socket connectto;
#line 4443

#line 4443
#
#line 4443
# Allow the domain to send to any node.
#line 4443
# node_type is a type attribute for all node types.
#line 4443
#
#line 4443
allow user_crontab_t node_type:node { tcp_send udp_send rawip_send };
#line 4443

#line 4443
#
#line 4443
# Allow packets sent by the domain to be received from any node.
#line 4443
#
#line 4443
allow user_crontab_t node_type:node { tcp_recv udp_recv rawip_recv };
#line 4443

#line 4443
#
#line 4443
# Allow the domain to send NFS client requests via the socket
#line 4443
# created by mount.
#line 4443
#
#line 4443
allow user_crontab_t mount_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4443

#line 4443
#
#line 4443
# Bind to the default port type.
#line 4443
# Other port types must be separately authorized.
#line 4443
#
#line 4443
allow user_crontab_t port_t:udp_socket name_bind;
#line 4443
allow user_crontab_t port_t:tcp_socket name_bind;
#line 4443

#line 4443

#line 4443

#line 4443
# Use capabilities
#line 4443
allow user_crontab_t user_crontab_t:capability { setuid setgid chown };
#line 4443

#line 4443
# Type for temporary files.
#line 4443

#line 4443

#line 4443

#line 4443

#line 4443
#
#line 4443
# Allow the process to modify the directory.
#line 4443
#
#line 4443
allow user_crontab_t tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4443

#line 4443
#
#line 4443
# Allow the process to create the file.
#line 4443
#
#line 4443

#line 4443
allow user_crontab_t user_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4443
allow user_crontab_t user_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4443

#line 4443

#line 4443

#line 4443
type_transition user_crontab_t tmp_t:dir user_tmp_t;
#line 4443
type_transition user_crontab_t tmp_t:{ file lnk_file sock_file fifo_file } user_tmp_t;
#line 4443

#line 4443

#line 4443

#line 4443

#line 4443
# Type of user crontabs once moved to cron spool.
#line 4443
type user_cron_spool_t, file_type, sysadmfile;
#line 4443
# Use the type when creating files in /var/spool/cron.
#line 4443
allow sysadm_crontab_t user_cron_spool_t:file { getattr read };
#line 4443

#line 4443

#line 4443

#line 4443

#line 4443
#
#line 4443
# Allow the process to modify the directory.
#line 4443
#
#line 4443
allow user_crontab_t cron_spool_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4443

#line 4443
#
#line 4443
# Allow the process to create the file.
#line 4443
#
#line 4443

#line 4443
allow user_crontab_t user_cron_spool_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4443
allow user_crontab_t user_cron_spool_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4443

#line 4443

#line 4443

#line 4443
type_transition user_crontab_t cron_spool_t:dir user_cron_spool_t;
#line 4443
type_transition user_crontab_t cron_spool_t:{ file lnk_file sock_file fifo_file } user_cron_spool_t;
#line 4443

#line 4443

#line 4443

#line 4443

#line 4443
# crontab signals crond by updating the mtime on the spooldir
#line 4443
allow user_crontab_t cron_spool_t:dir setattr;
#line 4443
# Allow crond to read those crontabs in cron spool.
#line 4443
allow crond_t user_cron_spool_t:file { read getattr lock ioctl };
#line 4443

#line 4443
# Run helper programs as user_t
#line 4443

#line 4443

#line 4443

#line 4443
#
#line 4443
# Allow the process to transition to the new domain.
#line 4443
#
#line 4443
allow user_crontab_t user_t:process transition;
#line 4443

#line 4443
#
#line 4443
# Allow the process to execute the program.
#line 4443
# 
#line 4443
allow user_crontab_t { bin_t sbin_t exec_type }:file { getattr execute };
#line 4443

#line 4443
#
#line 4443
# Allow the process to reap the new domain.
#line 4443
#
#line 4443
allow user_t user_crontab_t:process sigchld;
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to inherit and use file 
#line 4443
# descriptions from the creating process and vice versa.
#line 4443
#
#line 4443
allow user_t user_crontab_t:fd use;
#line 4443
allow user_crontab_t user_t:fd use;
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to write back to the old domain via a pipe.
#line 4443
#
#line 4443
allow user_t user_crontab_t:fifo_file { ioctl read getattr lock write append };
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to read and execute the program.
#line 4443
#
#line 4443
allow user_t { bin_t sbin_t exec_type }:file { read getattr lock execute ioctl };
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to be entered via the program.
#line 4443
#
#line 4443
allow user_t { bin_t sbin_t exec_type }:file entrypoint;
#line 4443

#line 4443
type_transition user_crontab_t { bin_t sbin_t exec_type }:process user_t;
#line 4443

#line 4443

#line 4443
# Read user crontabs 
#line 4443
allow user_crontab_t { user_home_t user_home_dir_t }:dir { read getattr lock search ioctl };  
#line 4443
allow user_crontab_t user_home_t:file { read getattr lock ioctl };  
#line 4443
dontaudit user_crontab_t user_home_dir_t:dir write;
#line 4443

#line 4443
# Access the cron log file.
#line 4443
allow user_crontab_t cron_log_t:file { read getattr lock ioctl };
#line 4443
allow user_crontab_t cron_log_t:file { append };
#line 4443

#line 4443
# Access terminals.
#line 4443
allow user_crontab_t user_tty_device_t:chr_file { ioctl read getattr lock write append };
#line 4443
allow user_crontab_t user_devpts_t:chr_file { ioctl read getattr lock write append };
#line 4443

#line 4443
# Inherit and use descriptors from gnome-pty-helper.
#line 4443

#line 4443

#line 4443

#line 4443

#line 4443
# Derived domain based on the calling user domain and the program.
#line 4443
type user_ssh_t, domain, privlog;
#line 4443

#line 4443
# Transition from the user domain to the derived domain.
#line 4443

#line 4443

#line 4443

#line 4443
#
#line 4443
# Allow the process to transition to the new domain.
#line 4443
#
#line 4443
allow user_t user_ssh_t:process transition;
#line 4443

#line 4443
#
#line 4443
# Allow the process to execute the program.
#line 4443
# 
#line 4443
allow user_t ssh_exec_t:file { getattr execute };
#line 4443

#line 4443
#
#line 4443
# Allow the process to reap the new domain.
#line 4443
#
#line 4443
allow user_ssh_t user_t:process sigchld;
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to inherit and use file 
#line 4443
# descriptions from the creating process and vice versa.
#line 4443
#
#line 4443
allow user_ssh_t user_t:fd use;
#line 4443
allow user_t user_ssh_t:fd use;
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to write back to the old domain via a pipe.
#line 4443
#
#line 4443
allow user_ssh_t user_t:fifo_file { ioctl read getattr lock write append };
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to read and execute the program.
#line 4443
#
#line 4443
allow user_ssh_t ssh_exec_t:file { read getattr lock execute ioctl };
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to be entered via the program.
#line 4443
#
#line 4443
allow user_ssh_t ssh_exec_t:file entrypoint;
#line 4443

#line 4443
type_transition user_t ssh_exec_t:process user_ssh_t;
#line 4443

#line 4443

#line 4443
# The user role is authorized for this domain.
#line 4443
role user_r types user_ssh_t;
#line 4443

#line 4443
# Grant permissions within the domain.
#line 4443

#line 4443
# Access other processes in the same domain.
#line 4443
allow user_ssh_t self:process *;
#line 4443

#line 4443
# Access /proc/PID files for processes in the same domain.
#line 4443
allow user_ssh_t self:dir { read getattr lock search ioctl };
#line 4443
allow user_ssh_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Access file descriptions, pipes, and sockets
#line 4443
# created by processes in the same domain.
#line 4443
allow user_ssh_t self:fd *;
#line 4443
allow user_ssh_t self:fifo_file { ioctl read getattr lock write append };
#line 4443
allow user_ssh_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4443
allow user_ssh_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4443

#line 4443
# Allow the domain to communicate with other processes in the same domain.
#line 4443
allow user_ssh_t self:unix_dgram_socket sendto;
#line 4443
allow user_ssh_t self:unix_stream_socket connectto;
#line 4443

#line 4443
# Access System V IPC objects created by processes in the same domain.
#line 4443
allow user_ssh_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 4443
allow user_ssh_t self:msg  { send receive };
#line 4443
allow user_ssh_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 4443
allow user_ssh_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 4443

#line 4443

#line 4443

#line 4443
# Use descriptors created by sshd
#line 4443
allow user_ssh_t privfd:fd use;
#line 4443

#line 4443

#line 4443
allow user_ssh_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4443
allow user_ssh_t ld_so_t:file { read getattr lock execute ioctl };
#line 4443
allow user_ssh_t ld_so_t:file execute_no_trans;
#line 4443
allow user_ssh_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4443
allow user_ssh_t shlib_t:file { read getattr lock execute ioctl };
#line 4443
allow user_ssh_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4443
allow user_ssh_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4443
allow user_ssh_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4443

#line 4443

#line 4443
# read localization information
#line 4443
allow user_ssh_t locale_t:dir { read getattr lock search ioctl };
#line 4443
allow user_ssh_t locale_t:{file lnk_file} { read getattr lock ioctl };
#line 4443

#line 4443
# Get attributes of file systems.
#line 4443
allow user_ssh_t fs_type:filesystem getattr;
#line 4443

#line 4443

#line 4443
# Read /.
#line 4443
allow user_ssh_t root_t:dir { read getattr lock search ioctl };
#line 4443
allow user_ssh_t root_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /home.
#line 4443
allow user_ssh_t home_root_t:dir { read getattr lock search ioctl };
#line 4443

#line 4443
# Read /usr.
#line 4443
allow user_ssh_t usr_t:dir { read getattr lock search ioctl };
#line 4443
allow user_ssh_t usr_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read bin and sbin directories.
#line 4443
allow user_ssh_t bin_t:dir { read getattr lock search ioctl };
#line 4443
allow user_ssh_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443
allow user_ssh_t sbin_t:dir { read getattr lock search ioctl };
#line 4443
allow user_ssh_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443

#line 4443
# Read the devpts root directory.
#line 4443
allow user_ssh_t devpts_t:dir { read getattr lock search ioctl };
#line 4443

#line 4443
# Read /var.
#line 4443
allow user_ssh_t var_t:dir { read getattr lock search ioctl };
#line 4443
allow user_ssh_t var_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /var/run, /var/log.
#line 4443
allow user_ssh_t var_run_t:dir { read getattr lock search ioctl };
#line 4443
allow user_ssh_t var_run_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_ssh_t var_log_t:dir { read getattr lock search ioctl };
#line 4443
allow user_ssh_t var_log_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /etc.
#line 4443
allow user_ssh_t etc_t:dir { read getattr lock search ioctl };
#line 4443
allow user_ssh_t etc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443
allow user_ssh_t etc_runtime_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_ssh_t resolv_conf_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read the linker, shared library, and executable types.
#line 4443
allow user_ssh_t ld_so_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_ssh_t shlib_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_ssh_t exec_type:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /dev directories and any symbolic links.
#line 4443
allow user_ssh_t device_t:dir { read getattr lock search ioctl };
#line 4443
allow user_ssh_t device_t:lnk_file { read getattr lock ioctl };
#line 4443

#line 4443
# Read /dev/random.
#line 4443
allow user_ssh_t random_device_t:chr_file { read getattr lock ioctl };
#line 4443

#line 4443
# Read and write /dev/tty and /dev/null.
#line 4443
allow user_ssh_t devtty_t:chr_file { ioctl read getattr lock write append };
#line 4443
allow user_ssh_t { null_device_t zero_device_t }:chr_file { ioctl read getattr lock write append };
#line 4443

#line 4443
# Grant permissions needed to create TCP and UDP sockets and
#line 4443
# to access the network.
#line 4443

#line 4443
#
#line 4443
# Allow the domain to create and use UDP and TCP sockets.
#line 4443
# Other kinds of sockets must be separately authorized for use.
#line 4443
allow user_ssh_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4443
allow user_ssh_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4443

#line 4443
#
#line 4443
# Allow the domain to send UDP packets.
#line 4443
# Since the destination sockets type is unknown, the generic
#line 4443
# any_socket_t type is used as a placeholder.
#line 4443
#
#line 4443
allow user_ssh_t any_socket_t:udp_socket sendto;
#line 4443

#line 4443
#
#line 4443
# Allow the domain to send using any network interface.
#line 4443
# netif_type is a type attribute for all network interface types.
#line 4443
#
#line 4443
allow user_ssh_t netif_type:netif { tcp_send udp_send rawip_send };
#line 4443

#line 4443
#
#line 4443
# Allow packets sent by the domain to be received on any network interface.
#line 4443
#
#line 4443
allow user_ssh_t netif_type:netif { tcp_recv udp_recv rawip_recv };
#line 4443

#line 4443
#
#line 4443
# Allow the domain to receive packets from any network interface.
#line 4443
# netmsg_type is a type attribute for all default message types.
#line 4443
#
#line 4443
allow user_ssh_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
#line 4443

#line 4443
#
#line 4443
# Allow the domain to initiate or accept TCP connections 
#line 4443
# on any network interface.
#line 4443
#
#line 4443
allow user_ssh_t netmsg_type:tcp_socket { connectto acceptfrom };
#line 4443

#line 4443
#
#line 4443
# Receive resets from the TCP reset socket.
#line 4443
# The TCP reset socket is labeled with the tcp_socket_t type.
#line 4443
#
#line 4443
allow user_ssh_t tcp_socket_t:tcp_socket recvfrom;
#line 4443

#line 4443
dontaudit user_ssh_t tcp_socket_t:tcp_socket connectto;
#line 4443

#line 4443
#
#line 4443
# Allow the domain to send to any node.
#line 4443
# node_type is a type attribute for all node types.
#line 4443
#
#line 4443
allow user_ssh_t node_type:node { tcp_send udp_send rawip_send };
#line 4443

#line 4443
#
#line 4443
# Allow packets sent by the domain to be received from any node.
#line 4443
#
#line 4443
allow user_ssh_t node_type:node { tcp_recv udp_recv rawip_recv };
#line 4443

#line 4443
#
#line 4443
# Allow the domain to send NFS client requests via the socket
#line 4443
# created by mount.
#line 4443
#
#line 4443
allow user_ssh_t mount_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4443

#line 4443
#
#line 4443
# Bind to the default port type.
#line 4443
# Other port types must be separately authorized.
#line 4443
#
#line 4443
allow user_ssh_t port_t:udp_socket name_bind;
#line 4443
allow user_ssh_t port_t:tcp_socket name_bind;
#line 4443

#line 4443

#line 4443
# for sshing to a ssh tunnel
#line 4443

#line 4443
allow user_ssh_t user_ssh_t:tcp_socket { connectto recvfrom };
#line 4443
allow user_ssh_t user_ssh_t:tcp_socket { acceptfrom recvfrom };
#line 4443
allow user_ssh_t tcp_socket_t:tcp_socket { recvfrom };
#line 4443
allow user_ssh_t tcp_socket_t:tcp_socket { recvfrom };
#line 4443

#line 4443

#line 4443
# Use capabilities.
#line 4443
allow user_ssh_t self:capability { setuid setgid dac_override dac_read_search };
#line 4443

#line 4443
# Run helpers.
#line 4443

#line 4443
allow user_ssh_t { bin_t sbin_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4443
allow user_ssh_t { bin_t sbin_t }:lnk_file read;
#line 4443

#line 4443
allow user_ssh_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4443
allow user_ssh_t ld_so_t:file { read getattr lock execute ioctl };
#line 4443
allow user_ssh_t ld_so_t:file execute_no_trans;
#line 4443
allow user_ssh_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4443
allow user_ssh_t shlib_t:file { read getattr lock execute ioctl };
#line 4443
allow user_ssh_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4443
allow user_ssh_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4443
allow user_ssh_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4443

#line 4443

#line 4443
allow user_ssh_t etc_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4443

#line 4443

#line 4443
allow user_ssh_t lib_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4443

#line 4443

#line 4443
allow user_ssh_t bin_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4443

#line 4443

#line 4443
allow user_ssh_t sbin_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4443

#line 4443

#line 4443
allow user_ssh_t exec_type:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4443

#line 4443

#line 4443

#line 4443
# Read the ssh key file.
#line 4443
allow user_ssh_t sshd_key_t:file { read getattr lock ioctl };
#line 4443

#line 4443
# Access the ssh temporary files.
#line 4443

#line 4443

#line 4443

#line 4443

#line 4443
#
#line 4443
# Allow the process to modify the directory.
#line 4443
#
#line 4443
allow user_ssh_t tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4443

#line 4443
#
#line 4443
# Allow the process to create the file.
#line 4443
#
#line 4443

#line 4443
allow user_ssh_t sshd_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4443
allow user_ssh_t sshd_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4443

#line 4443

#line 4443

#line 4443
type_transition user_ssh_t tmp_t:dir sshd_tmp_t;
#line 4443
type_transition user_ssh_t tmp_t:{ file lnk_file sock_file fifo_file } sshd_tmp_t;
#line 4443

#line 4443

#line 4443

#line 4443
allow user_ssh_t user_tmp_t:dir { read getattr lock search ioctl };
#line 4443

#line 4443
# for rsync
#line 4443
allow user_ssh_t user_t:unix_stream_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4443

#line 4443
# Access the users .ssh directory.
#line 4443
type user_home_ssh_t, file_type, sysadmfile;
#line 4443

#line 4443

#line 4443

#line 4443

#line 4443
#
#line 4443
# Allow the process to modify the directory.
#line 4443
#
#line 4443
allow { sysadm_ssh_t user_ssh_t } user_home_dir_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4443

#line 4443
#
#line 4443
# Allow the process to create the file.
#line 4443
#
#line 4443

#line 4443
allow { sysadm_ssh_t user_ssh_t } user_home_ssh_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4443
allow { sysadm_ssh_t user_ssh_t } user_home_ssh_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4443

#line 4443

#line 4443

#line 4443
type_transition { sysadm_ssh_t user_ssh_t } user_home_dir_t:dir user_home_ssh_t;
#line 4443
type_transition { sysadm_ssh_t user_ssh_t } user_home_dir_t:{ file lnk_file sock_file fifo_file } user_home_ssh_t;
#line 4443

#line 4443

#line 4443

#line 4443
allow { sysadm_ssh_t user_ssh_t } user_home_ssh_t:lnk_file { getattr read };
#line 4443
dontaudit user_ssh_t user_home_t:dir search;
#line 4443

#line 4443
allow sshd_t user_home_ssh_t:dir { read getattr lock search ioctl };
#line 4443
allow sshd_t user_home_ssh_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443

#line 4443
allow user_t user_home_ssh_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4443
allow user_t user_home_ssh_t:{ file lnk_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4443

#line 4443

#line 4443
# Inherit and use descriptors from gnome-pty-helper.
#line 4443

#line 4443

#line 4443
# Connect to sshd.
#line 4443

#line 4443
allow user_ssh_t sshd_t:tcp_socket { connectto recvfrom };
#line 4443
allow sshd_t user_ssh_t:tcp_socket { acceptfrom recvfrom };
#line 4443
allow sshd_t tcp_socket_t:tcp_socket { recvfrom };
#line 4443
allow user_ssh_t tcp_socket_t:tcp_socket { recvfrom };
#line 4443

#line 4443

#line 4443
# Write to the user domain tty.
#line 4443
allow user_ssh_t user_tty_device_t:chr_file { ioctl read getattr lock write append };
#line 4443
allow user_ssh_t user_devpts_t:chr_file { ioctl read getattr lock write append };
#line 4443

#line 4443
# Allow the user shell to signal the ssh program.
#line 4443
allow user_t user_ssh_t:process signal;
#line 4443
# allow ps to show ssh
#line 4443
allow user_t user_ssh_t:dir { search getattr read };
#line 4443
allow user_t user_ssh_t:{ file lnk_file } { read getattr };
#line 4443

#line 4443
# Allow the ssh program to communicate with ssh-agent.
#line 4443
allow user_ssh_t user_tmp_t:sock_file write;
#line 4443
allow user_ssh_t user_t:unix_stream_socket connectto;
#line 4443
allow user_ssh_t sshd_t:unix_stream_socket connectto;
#line 4443

#line 4443

#line 4443

#line 4443

#line 4443

#line 4443

#line 4443

#line 4443

#line 4443

#line 4443

#line 4443
# Instantiate a derived domain for user cron jobs.
#line 4443

#line 4443
# Derived domain for user cron jobs, user user_crond_domain if not system
#line 4443

#line 4443
type user_crond_t, domain, user_crond_domain;
#line 4443

#line 4443

#line 4443
# Permit a transition from the crond_t domain to this domain.
#line 4443
# The transition is requested explicitly by the modified crond 
#line 4443
# via execve_secure.  There is no way to set up an automatic
#line 4443
# transition, since crontabs are configuration files, not executables.
#line 4443

#line 4443

#line 4443
#
#line 4443
# Allow the process to transition to the new domain.
#line 4443
#
#line 4443
allow crond_t user_crond_t:process transition;
#line 4443

#line 4443
#
#line 4443
# Allow the process to execute the program.
#line 4443
# 
#line 4443
allow crond_t shell_exec_t:file { getattr execute };
#line 4443

#line 4443
#
#line 4443
# Allow the process to reap the new domain.
#line 4443
#
#line 4443
allow user_crond_t crond_t:process sigchld;
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to inherit and use file 
#line 4443
# descriptions from the creating process and vice versa.
#line 4443
#
#line 4443
allow user_crond_t crond_t:fd use;
#line 4443
allow crond_t user_crond_t:fd use;
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to write back to the old domain via a pipe.
#line 4443
#
#line 4443
allow user_crond_t crond_t:fifo_file { ioctl read getattr lock write append };
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to read and execute the program.
#line 4443
#
#line 4443
allow user_crond_t shell_exec_t:file { read getattr lock execute ioctl };
#line 4443

#line 4443
#
#line 4443
# Allow the new domain to be entered via the program.
#line 4443
#
#line 4443
allow user_crond_t shell_exec_t:file entrypoint;
#line 4443

#line 4443

#line 4443

#line 4443

#line 4443
# The user role is authorized for this domain.
#line 4443
role user_r types user_crond_t;
#line 4443

#line 4443
# This domain is granted permissions common to most domains.
#line 4443

#line 4443

#line 4443
# Grant the permissions common to the test domains.
#line 4443

#line 4443
# Grant permissions within the domain.
#line 4443

#line 4443
# Access other processes in the same domain.
#line 4443
allow user_crond_t self:process *;
#line 4443

#line 4443
# Access /proc/PID files for processes in the same domain.
#line 4443
allow user_crond_t self:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Access file descriptions, pipes, and sockets
#line 4443
# created by processes in the same domain.
#line 4443
allow user_crond_t self:fd *;
#line 4443
allow user_crond_t self:fifo_file { ioctl read getattr lock write append };
#line 4443
allow user_crond_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4443
allow user_crond_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4443

#line 4443
# Allow the domain to communicate with other processes in the same domain.
#line 4443
allow user_crond_t self:unix_dgram_socket sendto;
#line 4443
allow user_crond_t self:unix_stream_socket connectto;
#line 4443

#line 4443
# Access System V IPC objects created by processes in the same domain.
#line 4443
allow user_crond_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 4443
allow user_crond_t self:msg  { send receive };
#line 4443
allow user_crond_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 4443
allow user_crond_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 4443

#line 4443

#line 4443

#line 4443
# Grant read/search permissions to most of /proc.
#line 4443

#line 4443
# Read system information files in /proc.
#line 4443
allow user_crond_t proc_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t proc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Stat /proc/kmsg and /proc/kcore.
#line 4443
allow user_crond_t proc_kmsg_t:file { getattr };
#line 4443
allow user_crond_t proc_kcore_t:file { getattr };
#line 4443

#line 4443
# Read system variables in /proc/sys.
#line 4443
allow user_crond_t sysctl_modprobe_t:file { read getattr lock ioctl };
#line 4443
allow user_crond_t sysctl_t:file { read getattr lock ioctl };
#line 4443
allow user_crond_t sysctl_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t sysctl_fs_t:file { read getattr lock ioctl };
#line 4443
allow user_crond_t sysctl_fs_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t sysctl_kernel_t:file { read getattr lock ioctl };
#line 4443
allow user_crond_t sysctl_kernel_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t sysctl_net_t:file { read getattr lock ioctl };
#line 4443
allow user_crond_t sysctl_net_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t sysctl_vm_t:file { read getattr lock ioctl };
#line 4443
allow user_crond_t sysctl_vm_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t sysctl_dev_t:file { read getattr lock ioctl };
#line 4443
allow user_crond_t sysctl_dev_t:dir { read getattr lock search ioctl };
#line 4443

#line 4443

#line 4443
# Grant read/search permissions to many system file types.
#line 4443

#line 4443

#line 4443
# Get attributes of file systems.
#line 4443
allow user_crond_t fs_type:filesystem getattr;
#line 4443

#line 4443

#line 4443
# Read /.
#line 4443
allow user_crond_t root_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t root_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /home.
#line 4443
allow user_crond_t home_root_t:dir { read getattr lock search ioctl };
#line 4443

#line 4443
# Read /usr.
#line 4443
allow user_crond_t usr_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t usr_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read bin and sbin directories.
#line 4443
allow user_crond_t bin_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443
allow user_crond_t sbin_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443

#line 4443
# Read directories and files with the readable_t type.
#line 4443
# This type is a general type for "world"-readable files.
#line 4443
allow user_crond_t readable_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t readable_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Stat /...security and lost+found.
#line 4443
allow user_crond_t file_labels_t:dir getattr;
#line 4443
allow user_crond_t lost_found_t:dir getattr;
#line 4443

#line 4443
# Read the devpts root directory.  
#line 4443
allow user_crond_t devpts_t:dir { read getattr lock search ioctl };
#line 4443

#line 4443

#line 4443
# Read the /tmp directory and any /tmp files with the base type.
#line 4443
# Temporary files created at runtime will typically use derived types.
#line 4443
allow user_crond_t tmp_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t tmp_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /var.
#line 4443
allow user_crond_t var_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t var_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /var/catman.
#line 4443
allow user_crond_t catman_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t catman_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /var/lib.
#line 4443
allow user_crond_t var_lib_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t var_lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443
allow user_crond_t var_lib_nfs_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t var_lib_nfs_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443

#line 4443
allow user_crond_t tetex_data_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t tetex_data_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443

#line 4443
# Read /var/yp.
#line 4443
allow user_crond_t var_yp_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t var_yp_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /var/spool.
#line 4443
allow user_crond_t var_spool_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t var_spool_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /var/run, /var/lock, /var/log.
#line 4443
allow user_crond_t var_run_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t var_run_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_crond_t var_log_t:dir { read getattr lock search ioctl };
#line 4443
#allow user_crond_t var_log_t:{ file lnk_file } r_file_perms;
#line 4443
allow user_crond_t var_log_sa_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t var_log_sa_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_crond_t var_log_ksyms_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
allow user_crond_t var_lock_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t var_lock_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /var/run/utmp and /var/log/wtmp.
#line 4443
allow user_crond_t initrc_var_run_t:file { read getattr lock ioctl };
#line 4443
allow user_crond_t wtmp_t:file { read getattr lock ioctl };
#line 4443

#line 4443
# Read /boot, /boot/System.map*, and /vmlinuz*
#line 4443
allow user_crond_t boot_t:dir { search getattr };
#line 4443
allow user_crond_t boot_t:file getattr;
#line 4443
allow user_crond_t system_map_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
allow user_crond_t boot_t:lnk_file read;
#line 4443

#line 4443
# Read /etc.
#line 4443
allow user_crond_t etc_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t etc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443
allow user_crond_t etc_runtime_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_crond_t etc_aliases_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_crond_t etc_mail_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t etc_mail_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_crond_t resolv_conf_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_crond_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4443

#line 4443
# Read /lib.
#line 4443
allow user_crond_t lib_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read the linker, shared library, and executable types.
#line 4443
allow user_crond_t ld_so_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_crond_t shlib_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_crond_t exec_type:{ file lnk_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read man directories and files.
#line 4443
allow user_crond_t man_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t man_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read /usr/src.
#line 4443
allow user_crond_t src_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t src_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Read module-related files.
#line 4443
allow user_crond_t modules_object_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t modules_object_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_crond_t modules_dep_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_crond_t modules_conf_t:{ file lnk_file} { read getattr lock ioctl };
#line 4443

#line 4443
# Read /dev directories and any symbolic links.
#line 4443
allow user_crond_t device_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t device_t:lnk_file { read getattr lock ioctl };
#line 4443

#line 4443
# Read /dev/random and /dev/zero.
#line 4443
allow user_crond_t random_device_t:chr_file { read getattr lock ioctl };
#line 4443
allow user_crond_t zero_device_t:chr_file { read getattr lock ioctl };
#line 4443

#line 4443
# Read the root directory of a tmpfs filesytem and any symbolic links.
#line 4443
allow user_crond_t tmpfs_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t tmpfs_t:lnk_file { read getattr lock ioctl };
#line 4443

#line 4443
# Read any symbolic links on a devfs file system.
#line 4443
allow user_crond_t device_t:lnk_file { read getattr lock ioctl };
#line 4443

#line 4443
# Read the root directory of a usbdevfs filesystem, and
#line 4443
# the devices and drivers files.  Permit stating of the
#line 4443
# device nodes, but nothing else.
#line 4443
allow user_crond_t usbdevfs_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t usbdevfs_t:{ file lnk_file } { read getattr lock ioctl };
#line 4443
allow user_crond_t usbdevfs_device_t:file getattr;
#line 4443

#line 4443

#line 4443
# Grant write permissions to a small set of system file types.
#line 4443
# No permission to create files is granted here.  Use allow rules to grant 
#line 4443
# create permissions to a type or use file_type_auto_trans rules to set up
#line 4443
# new types for files.
#line 4443

#line 4443

#line 4443
# Read and write /dev/tty and /dev/null.
#line 4443
allow user_crond_t devtty_t:chr_file { ioctl read getattr lock write append };
#line 4443
allow user_crond_t { null_device_t zero_device_t }:chr_file { ioctl read getattr lock write append };
#line 4443

#line 4443
# Do not audit write denials to /etc/ld.so.cache.
#line 4443
dontaudit user_crond_t ld_so_cache_t:file write;
#line 4443

#line 4443

#line 4443
# Execute from the system shared libraries.
#line 4443
# No permission to execute anything else is granted here.
#line 4443
# Use can_exec or can_exec_any to grant the ability to execute within a domain.
#line 4443
# Use domain_auto_trans for executing and changing domains.
#line 4443

#line 4443
allow user_crond_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t ld_so_t:file { read getattr lock execute ioctl };
#line 4443
allow user_crond_t ld_so_t:file execute_no_trans;
#line 4443
allow user_crond_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4443
allow user_crond_t shlib_t:file { read getattr lock execute ioctl };
#line 4443
allow user_crond_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4443
allow user_crond_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4443
allow user_crond_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4443

#line 4443

#line 4443
# read localization information
#line 4443
allow user_crond_t locale_t:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t locale_t:{file lnk_file} { read getattr lock ioctl };
#line 4443

#line 4443
# Obtain the context of any SID, the SID for any context, 
#line 4443
# and the list of active SIDs.
#line 4443
allow user_crond_t security_t:security { sid_to_context context_to_sid get_sids };
#line 4443

#line 4443

#line 4443

#line 4443
# Grant permissions needed to create TCP and UDP sockets and 
#line 4443
# to access the network.
#line 4443

#line 4443
#
#line 4443
# Allow the domain to create and use UDP and TCP sockets.
#line 4443
# Other kinds of sockets must be separately authorized for use.
#line 4443
allow user_crond_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4443
allow user_crond_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4443

#line 4443
#
#line 4443
# Allow the domain to send UDP packets.
#line 4443
# Since the destination sockets type is unknown, the generic
#line 4443
# any_socket_t type is used as a placeholder.
#line 4443
#
#line 4443
allow user_crond_t any_socket_t:udp_socket sendto;
#line 4443

#line 4443
#
#line 4443
# Allow the domain to send using any network interface.
#line 4443
# netif_type is a type attribute for all network interface types.
#line 4443
#
#line 4443
allow user_crond_t netif_type:netif { tcp_send udp_send rawip_send };
#line 4443

#line 4443
#
#line 4443
# Allow packets sent by the domain to be received on any network interface.
#line 4443
#
#line 4443
allow user_crond_t netif_type:netif { tcp_recv udp_recv rawip_recv };
#line 4443

#line 4443
#
#line 4443
# Allow the domain to receive packets from any network interface.
#line 4443
# netmsg_type is a type attribute for all default message types.
#line 4443
#
#line 4443
allow user_crond_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
#line 4443

#line 4443
#
#line 4443
# Allow the domain to initiate or accept TCP connections 
#line 4443
# on any network interface.
#line 4443
#
#line 4443
allow user_crond_t netmsg_type:tcp_socket { connectto acceptfrom };
#line 4443

#line 4443
#
#line 4443
# Receive resets from the TCP reset socket.
#line 4443
# The TCP reset socket is labeled with the tcp_socket_t type.
#line 4443
#
#line 4443
allow user_crond_t tcp_socket_t:tcp_socket recvfrom;
#line 4443

#line 4443
dontaudit user_crond_t tcp_socket_t:tcp_socket connectto;
#line 4443

#line 4443
#
#line 4443
# Allow the domain to send to any node.
#line 4443
# node_type is a type attribute for all node types.
#line 4443
#
#line 4443
allow user_crond_t node_type:node { tcp_send udp_send rawip_send };
#line 4443

#line 4443
#
#line 4443
# Allow packets sent by the domain to be received from any node.
#line 4443
#
#line 4443
allow user_crond_t node_type:node { tcp_recv udp_recv rawip_recv };
#line 4443

#line 4443
#
#line 4443
# Allow the domain to send NFS client requests via the socket
#line 4443
# created by mount.
#line 4443
#
#line 4443
allow user_crond_t mount_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4443

#line 4443
#
#line 4443
# Bind to the default port type.
#line 4443
# Other port types must be separately authorized.
#line 4443
#
#line 4443
allow user_crond_t port_t:udp_socket name_bind;
#line 4443
allow user_crond_t port_t:tcp_socket name_bind;
#line 4443

#line 4443

#line 4443

#line 4443
# Use capabilities.
#line 4443
allow user_crond_t user_crond_t:capability dac_override;
#line 4443

#line 4443
# Inherit and use descriptors from initrc.
#line 4443
allow user_crond_t initrc_t:fd use;
#line 4443

#line 4443
# 
#line 4443
# Since crontab files are not directly executed,
#line 4443
# crond must ensure that the crontab file has
#line 4443
# a type that is appropriate for the domain of
#line 4443
# the user cron job.  It performs an entrypoint
#line 4443
# permission check for this purpose.
#line 4443
#
#line 4443
allow user_crond_t user_cron_spool_t:file entrypoint;
#line 4443

#line 4443
# Access user files and dirs.
#line 4443

#line 4443

#line 4443

#line 4443

#line 4443
#
#line 4443
# Allow the process to modify the directory.
#line 4443
#
#line 4443
allow user_crond_t user_home_dir_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4443

#line 4443
#
#line 4443
# Allow the process to create the file.
#line 4443
#
#line 4443

#line 4443
allow user_crond_t user_home_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4443
allow user_crond_t user_home_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4443

#line 4443

#line 4443

#line 4443
type_transition user_crond_t user_home_dir_t:dir user_home_t;
#line 4443
type_transition user_crond_t user_home_dir_t:{ file lnk_file sock_file fifo_file } user_home_t;
#line 4443

#line 4443

#line 4443

#line 4443

#line 4443

#line 4443

#line 4443

#line 4443

#line 4443
#
#line 4443
# Allow the process to modify the directory.
#line 4443
#
#line 4443
allow user_crond_t tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4443

#line 4443
#
#line 4443
# Allow the process to create the file.
#line 4443
#
#line 4443

#line 4443
allow user_crond_t user_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4443
allow user_crond_t user_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4443

#line 4443

#line 4443

#line 4443
type_transition user_crond_t tmp_t:dir user_tmp_t;
#line 4443
type_transition user_crond_t tmp_t:{ file lnk_file sock_file fifo_file } user_tmp_t;
#line 4443

#line 4443

#line 4443

#line 4443

#line 4443
# Run helper programs.
#line 4443

#line 4443
allow user_crond_t { bin_t sbin_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t { bin_t sbin_t }:lnk_file read;
#line 4443

#line 4443
allow user_crond_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4443
allow user_crond_t ld_so_t:file { read getattr lock execute ioctl };
#line 4443
allow user_crond_t ld_so_t:file execute_no_trans;
#line 4443
allow user_crond_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4443
allow user_crond_t shlib_t:file { read getattr lock execute ioctl };
#line 4443
allow user_crond_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4443
allow user_crond_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4443
allow user_crond_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4443

#line 4443

#line 4443
allow user_crond_t etc_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4443

#line 4443

#line 4443
allow user_crond_t lib_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4443

#line 4443

#line 4443
allow user_crond_t bin_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4443

#line 4443

#line 4443
allow user_crond_t sbin_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4443

#line 4443

#line 4443
allow user_crond_t exec_type:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4443

#line 4443

#line 4443

#line 4443
# Run scripts in user home directory.
#line 4443

#line 4443
allow user_crond_t user_home_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4443

#line 4443

#line 4443

#line 4443

#line 4443

#line 4443
# Read the mouse.
#line 4443
allow user_t mouse_device_t:chr_file { read getattr lock ioctl };
#line 4443
# Access other miscellaneous devices.
#line 4443
allow user_t misc_device_t:{ file lnk_file sock_file fifo_file chr_file blk_file } { ioctl read getattr lock write append };
#line 4443

#line 4443
# Use the network.
#line 4443

#line 4443
#
#line 4443
# Allow the domain to create and use UDP and TCP sockets.
#line 4443
# Other kinds of sockets must be separately authorized for use.
#line 4443
allow user_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4443
allow user_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4443

#line 4443
#
#line 4443
# Allow the domain to send UDP packets.
#line 4443
# Since the destination sockets type is unknown, the generic
#line 4443
# any_socket_t type is used as a placeholder.
#line 4443
#
#line 4443
allow user_t any_socket_t:udp_socket sendto;
#line 4443

#line 4443
#
#line 4443
# Allow the domain to send using any network interface.
#line 4443
# netif_type is a type attribute for all network interface types.
#line 4443
#
#line 4443
allow user_t netif_type:netif { tcp_send udp_send rawip_send };
#line 4443

#line 4443
#
#line 4443
# Allow packets sent by the domain to be received on any network interface.
#line 4443
#
#line 4443
allow user_t netif_type:netif { tcp_recv udp_recv rawip_recv };
#line 4443

#line 4443
#
#line 4443
# Allow the domain to receive packets from any network interface.
#line 4443
# netmsg_type is a type attribute for all default message types.
#line 4443
#
#line 4443
allow user_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
#line 4443

#line 4443
#
#line 4443
# Allow the domain to initiate or accept TCP connections 
#line 4443
# on any network interface.
#line 4443
#
#line 4443
allow user_t netmsg_type:tcp_socket { connectto acceptfrom };
#line 4443

#line 4443
#
#line 4443
# Receive resets from the TCP reset socket.
#line 4443
# The TCP reset socket is labeled with the tcp_socket_t type.
#line 4443
#
#line 4443
allow user_t tcp_socket_t:tcp_socket recvfrom;
#line 4443

#line 4443
dontaudit user_t tcp_socket_t:tcp_socket connectto;
#line 4443

#line 4443
#
#line 4443
# Allow the domain to send to any node.
#line 4443
# node_type is a type attribute for all node types.
#line 4443
#
#line 4443
allow user_t node_type:node { tcp_send udp_send rawip_send };
#line 4443

#line 4443
#
#line 4443
# Allow packets sent by the domain to be received from any node.
#line 4443
#
#line 4443
allow user_t node_type:node { tcp_recv udp_recv rawip_recv };
#line 4443

#line 4443
#
#line 4443
# Allow the domain to send NFS client requests via the socket
#line 4443
# created by mount.
#line 4443
#
#line 4443
allow user_t mount_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4443

#line 4443
#
#line 4443
# Bind to the default port type.
#line 4443
# Other port types must be separately authorized.
#line 4443
#
#line 4443
allow user_t port_t:udp_socket name_bind;
#line 4443
allow user_t port_t:tcp_socket name_bind;
#line 4443

#line 4443

#line 4443
#
#line 4443
# connect_secure and sendmsg_secure calls with a 
#line 4443
# peer or destination socket SID can be enforced
#line 4443
# when using the loopback interface.  Enforcement
#line 4443
# for real network interfaces will be possible when
#line 4443
# a packet labeling mechanism is integrated.
#line 4443
#
#line 4443
allow user_t node_lo_t:node enforce_dest;
#line 4443

#line 4443
# Communicate within the domain.
#line 4443

#line 4443
allow user_t user_t:udp_socket { sendto };
#line 4443
allow user_t user_t:udp_socket { recvfrom };
#line 4443

#line 4443

#line 4443
allow user_t user_t:tcp_socket { connectto recvfrom };
#line 4443
allow user_t user_t:tcp_socket { acceptfrom recvfrom };
#line 4443
allow user_t tcp_socket_t:tcp_socket { recvfrom };
#line 4443
allow user_t tcp_socket_t:tcp_socket { recvfrom };
#line 4443

#line 4443

#line 4443
# Connect to inetd.
#line 4443

#line 4443

#line 4443

#line 4443

#line 4443
# Connect data port to ftpd.
#line 4443

#line 4443

#line 4443
# Connect to portmap.
#line 4443

#line 4443

#line 4443
# Inherit and use sockets from inetd
#line 4443

#line 4443

#line 4443
# Allow system log read
#line 4443
#allow user_t kernel_t:system syslog_read;
#line 4443
# else do not log it
#line 4443
dontaudit user_t kernel_t:system syslog_read;
#line 4443

#line 4443
# Very permissive allowing every domain to see every type.
#line 4443
allow user_t kernel_t:system { ipc_info };
#line 4443

#line 4443
# When the user domain runs ps, there will be a number of access
#line 4443
# denials when ps tries to search /proc.  Do not audit these denials.
#line 4443
dontaudit user_t domain:dir { read getattr lock search ioctl };
#line 4443
dontaudit user_t domain:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4443

#line 4443
# Some shells ask for w access to utmp, but will operate
#line 4443
# correctly without it.  Do not audit write denials to utmp.
#line 4443
dontaudit user_t initrc_var_run_t:file { getattr read write };
#line 4443

#line 4443
# do not audit getattr on tmpfile, otherwise ls -l /tmp fills the logs
#line 4443
dontaudit user_t tmpfile:{ dir file lnk_file sock_file fifo_file chr_file blk_file } getattr;
#line 4443

#line 4443
# do not audit getattr on disk devices, otherwise KDE fills the logs
#line 4443
dontaudit user_t { removable_device_t fixed_disk_device_t }:blk_file getattr;
#line 4443

#line 4443

#line 4443
# Access the sound device.
#line 4443
allow user_t sound_device_t:chr_file { getattr read write ioctl };
#line 4443

#line 4443
# Allow reading dpkg origins file
#line 4443

#line 4443

#line 4443

#line 4443

#line 4443

#line 4443

#line 4443
# When an ordinary user domain runs su, su may try to
#line 4443
# update the /root/.Xauthority file, and the user shell may
#line 4443
# try to update the shell history. This isnt allowed, but 
#line 4443
# we dont need to audit it.
#line 4443

#line 4443
dontaudit user_su_t sysadm_home_t:dir  { read getattr search write add_name remove_name };
#line 4443
dontaudit user_su_t sysadm_home_t:file { read getattr create write link unlink };
#line 4443
dontaudit user_t    sysadm_home_t:dir { read search getattr };
#line 4443
dontaudit user_t    sysadm_home_t:file { read getattr append };
#line 4443

#line 4443

#line 4443
# Some programs that are left in user_t will try to connect
#line 4443
# to syslogd, but we do not want to let them generate log messages.
#line 4443
# Do not audit.
#line 4443
dontaudit user_t devlog_t:sock_file { read write };
#line 4443
dontaudit user_t syslogd_t:unix_dgram_socket sendto;
#line 4443

#line 4443

#line 4443
# stop warnings about "ls -l" on directories with unlabelled files
#line 4443
dontaudit user_t file_t:{ dir file lnk_file } getattr;
#line 4443

# a role for staff that allows seeing all domains and control over the user_t
# domain
#full_user_role(staff)
#allow staff_t user_t:process signal_perms;
#r_dir_file(staff_t, domain)
#file_type_auto_trans(staff_t, user_home_dir_t, user_home_t)

# read localization information
allow user_t locale_t:dir { read getattr lock search ioctl };
allow user_t locale_t:{file lnk_file} { read getattr lock ioctl };

# if adding new user roles make sure you edit the in_user_role macro in
# macros/user_macros.te to match

# lots of user programs accidentally search /root, and also the admin often
# logs in as UID=0 domain=user_t...
dontaudit unpriv_userdomain sysadm_home_dir_t:dir { getattr search };

# system_r is authorized for user_t as a fallback for unmodified daemons.
role system_r types user_t;

# change from role $1_r to $2_r and relabel tty appropriately
#line 4470


#line 4480

#line 4480
#
#line 4480
# Allow the user roles to transition
#line 4480
# into each other.
#line 4480

#line 4480
allow sysadm_r user_r;
#line 4480
type_change user_t sysadm_devpts_t:chr_file user_devpts_t;
#line 4480
type_change user_t sysadm_tty_device_t:chr_file user_tty_device_t;
#line 4480

#line 4480

#line 4480
allow user_r sysadm_r;
#line 4480
type_change sysadm_t user_devpts_t:chr_file sysadm_devpts_t;
#line 4480
type_change sysadm_t user_tty_device_t:chr_file sysadm_tty_device_t;
#line 4480

#line 4480
#role_tty_type_change(staff, sysadm)
#line 4480
#role_tty_type_change(sysadm, staff)
#line 4480


# "ps aux" and "ls -l /dev/pts" make too much noise without this
dontaudit unpriv_userdomain ptyfile:chr_file getattr;




#line 4487

#line 4487
# user_t/cougaar_t is an unprivileged users domain.
#line 4487
type cougaar_t, domain, userdomain, unpriv_userdomain;
#line 4487

#line 4487
# cougaar_r is authorized for cougaar_t for the initial login domain.
#line 4487
role cougaar_r types cougaar_t;
#line 4487
allow system_r cougaar_r;
#line 4487

#line 4487
# Grant permissions within the domain.
#line 4487

#line 4487
# Access other processes in the same domain.
#line 4487
allow cougaar_t self:process *;
#line 4487

#line 4487
# Access /proc/PID files for processes in the same domain.
#line 4487
allow cougaar_t self:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Access file descriptions, pipes, and sockets
#line 4487
# created by processes in the same domain.
#line 4487
allow cougaar_t self:fd *;
#line 4487
allow cougaar_t self:fifo_file { ioctl read getattr lock write append };
#line 4487
allow cougaar_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4487
allow cougaar_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4487

#line 4487
# Allow the domain to communicate with other processes in the same domain.
#line 4487
allow cougaar_t self:unix_dgram_socket sendto;
#line 4487
allow cougaar_t self:unix_stream_socket connectto;
#line 4487

#line 4487
# Access System V IPC objects created by processes in the same domain.
#line 4487
allow cougaar_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 4487
allow cougaar_t self:msg  { send receive };
#line 4487
allow cougaar_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 4487
allow cougaar_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 4487

#line 4487
;
#line 4487

#line 4487
# Grant read/search permissions to some of /proc.
#line 4487
allow cougaar_t proc_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_t proc_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Grand read/search permissions to many system types.
#line 4487
#general_file_read_access(cougaar_t);
#line 4487
# Get attributes of file systems.
#line 4487
allow cougaar_t fs_type:filesystem getattr;
#line 4487

#line 4487

#line 4487
# Read /.
#line 4487
allow cougaar_t root_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_t root_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /home.
#line 4487
allow cougaar_t home_root_t:dir { read getattr lock search ioctl };
#line 4487

#line 4487
# Read /usr.
#line 4487
allow cougaar_t usr_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_t usr_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read bin and sbin directories.
#line 4487
allow cougaar_t bin_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487
allow cougaar_t sbin_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487

#line 4487
# Read directories and files with the readable_t type.
#line 4487
# This type is a general type for "world"-readable files.
#line 4487
allow cougaar_t readable_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_t readable_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Stat /...security and lost+found.
#line 4487
allow cougaar_t file_labels_t:dir getattr;
#line 4487
allow cougaar_t lost_found_t:dir getattr;
#line 4487

#line 4487
# Read the devpts root directory.
#line 4487
allow cougaar_t devpts_t:dir { read getattr lock search ioctl };
#line 4487

#line 4487

#line 4487
# Read the /tmp directory and any /tmp files with the base type.
#line 4487
# Temporary files created at runtime will typically use derived types.
#line 4487
allow cougaar_t tmp_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_t tmp_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /var, /var/spool, /var/run.
#line 4487
allow cougaar_t var_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_t var_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487
allow cougaar_t var_spool_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_t var_spool_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487
allow cougaar_t var_run_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_t var_run_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /etc.
#line 4487
allow cougaar_t etc_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_t etc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487
allow cougaar_t etc_runtime_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read man directories and files.
#line 4487
allow cougaar_t man_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_t man_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /dev directories and any symbolic links.
#line 4487
allow cougaar_t device_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_t device_t:lnk_file { read getattr lock ioctl };
#line 4487

#line 4487
# Read and write /dev/tty and /dev/null.
#line 4487
allow cougaar_t devtty_t:chr_file { ioctl read getattr lock write append };
#line 4487
allow cougaar_t { null_device_t zero_device_t }:chr_file { ioctl read getattr lock write append };
#line 4487

#line 4487
# Do not audit write denials to /etc/ld.so.cache.
#line 4487
dontaudit cougaar_t ld_so_cache_t:file write;
#line 4487

#line 4487
# Execute from the system shared libraries.
#line 4487

#line 4487
allow cougaar_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_t ld_so_t:file { read getattr lock execute ioctl };
#line 4487
allow cougaar_t ld_so_t:file execute_no_trans;
#line 4487
allow cougaar_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4487
allow cougaar_t shlib_t:file { read getattr lock execute ioctl };
#line 4487
allow cougaar_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4487
allow cougaar_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4487
;
#line 4487

#line 4487
# Obtain the context of any SID, the SID for any context,
#line 4487
# and the list of active SIDs.
#line 4487
allow cougaar_t security_t:security { sid_to_context context_to_sid get_sids };
#line 4487

#line 4487
# cougaar_t is also granted permissions specific to user domains.
#line 4487

#line 4487
# Use capabilities
#line 4487
allow cougaar_t self:capability { setgid chown fowner };
#line 4487
dontaudit cougaar_t self:capability { sys_nice fsetid };
#line 4487

#line 4487
# Type for home directory.
#line 4487

#line 4487
type cougaar_home_dir_t, file_type, sysadmfile, home_dir_type, user_home_dir_type, home_type, user_home_type;
#line 4487
type cougaar_home_t, file_type, sysadmfile, home_type, user_home_type;
#line 4487
# do not allow privhome access to sysadm_home_dir_t
#line 4487

#line 4487

#line 4487

#line 4487

#line 4487
#
#line 4487
# Allow the process to modify the directory.
#line 4487
#
#line 4487
allow privhome cougaar_home_dir_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4487

#line 4487
#
#line 4487
# Allow the process to create the file.
#line 4487
#
#line 4487

#line 4487
allow privhome cougaar_home_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4487
allow privhome cougaar_home_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4487

#line 4487

#line 4487

#line 4487
type_transition privhome cougaar_home_dir_t:dir cougaar_home_t;
#line 4487
type_transition privhome cougaar_home_dir_t:{ file lnk_file sock_file fifo_file } cougaar_home_t;
#line 4487

#line 4487

#line 4487

#line 4487

#line 4487
type cougaar_tmp_t, file_type, sysadmfile, tmpfile , user_tmpfile;
#line 4487

#line 4487

#line 4487

#line 4487

#line 4487
#
#line 4487
# Allow the process to modify the directory.
#line 4487
#
#line 4487
allow cougaar_t tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4487

#line 4487
#
#line 4487
# Allow the process to create the file.
#line 4487
#
#line 4487

#line 4487
allow cougaar_t cougaar_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4487
allow cougaar_t cougaar_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4487

#line 4487

#line 4487

#line 4487
type_transition cougaar_t tmp_t:dir cougaar_tmp_t;
#line 4487
type_transition cougaar_t tmp_t:{ file lnk_file sock_file fifo_file } cougaar_tmp_t;
#line 4487

#line 4487

#line 4487

#line 4487

#line 4487

#line 4487

#line 4487
# Create, access, and remove files in home directory.
#line 4487

#line 4487

#line 4487

#line 4487

#line 4487
#
#line 4487
# Allow the process to modify the directory.
#line 4487
#
#line 4487
allow cougaar_t cougaar_home_dir_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4487

#line 4487
#
#line 4487
# Allow the process to create the file.
#line 4487
#
#line 4487

#line 4487
allow cougaar_t cougaar_home_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4487
allow cougaar_t cougaar_home_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4487

#line 4487

#line 4487

#line 4487
type_transition cougaar_t cougaar_home_dir_t:dir cougaar_home_t;
#line 4487
type_transition cougaar_t cougaar_home_dir_t:{ file lnk_file sock_file fifo_file } cougaar_home_t;
#line 4487

#line 4487

#line 4487

#line 4487
allow cougaar_t cougaar_home_t:{ dir file lnk_file sock_file fifo_file chr_file blk_file } { relabelfrom relabelto };
#line 4487

#line 4487
# Bind to a Unix domain socket in /tmp.
#line 4487
allow cougaar_t cougaar_tmp_t:unix_stream_socket name_bind;
#line 4487

#line 4487
# Type for tty devices.
#line 4487
type cougaar_tty_device_t, file_type, sysadmfile, ttyfile;
#line 4487
# Access ttys.
#line 4487
allow cougaar_t cougaar_tty_device_t:chr_file { setattr { ioctl read getattr lock write append } };
#line 4487
# Use the type when relabeling terminal devices.
#line 4487
type_change cougaar_t tty_device_t:chr_file cougaar_tty_device_t;
#line 4487

#line 4487

#line 4487
# Type and access for pty devices.
#line 4487

#line 4487

#line 4487

#line 4487
type cougaar_devpts_t, file_type, sysadmfile, ptyfile , userpty_type;
#line 4487

#line 4487
# Allow the pty to be associated with the file system.
#line 4487
allow cougaar_devpts_t devpts_t:filesystem associate;
#line 4487

#line 4487
# Access the pty master multiplexer.
#line 4487
allow cougaar_t ptmx_t:chr_file { ioctl read getattr lock write append };
#line 4487

#line 4487
# Label pty files with a derived type.
#line 4487
type_transition cougaar_t devpts_t:chr_file cougaar_devpts_t;
#line 4487

#line 4487
# Read and write my pty files.
#line 4487
allow cougaar_t cougaar_devpts_t:chr_file { setattr { ioctl read getattr lock write append } };
#line 4487

#line 4487

#line 4487

#line 4487

#line 4487

#line 4487

#line 4487
# Use the type when relabeling pty devices.
#line 4487

#line 4487

#line 4487
type_change cougaar_t sshd_devpts_t:chr_file cougaar_devpts_t;
#line 4487

#line 4487
# Connect to sshd.
#line 4487

#line 4487
allow cougaar_t sshd_t:tcp_socket { connectto recvfrom };
#line 4487
allow sshd_t cougaar_t:tcp_socket { acceptfrom recvfrom };
#line 4487
allow sshd_t tcp_socket_t:tcp_socket { recvfrom };
#line 4487
allow cougaar_t tcp_socket_t:tcp_socket { recvfrom };
#line 4487

#line 4487

#line 4487
# Connect to ssh proxy.
#line 4487

#line 4487
allow cougaar_t cougaar_ssh_t:tcp_socket { connectto recvfrom };
#line 4487
allow cougaar_ssh_t cougaar_t:tcp_socket { acceptfrom recvfrom };
#line 4487
allow cougaar_ssh_t tcp_socket_t:tcp_socket { recvfrom };
#line 4487
allow cougaar_t tcp_socket_t:tcp_socket { recvfrom };
#line 4487

#line 4487

#line 4487
allow cougaar_t sshd_t:fd use;
#line 4487
allow cougaar_t sshd_t:tcp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4487
# Use a Unix stream socket inherited from sshd.
#line 4487
allow cougaar_t sshd_t:unix_stream_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4487

#line 4487
# Type for tmpfs/shm files.
#line 4487
type cougaar_tmpfs_t, file_type, sysadmfile, tmpfsfile;
#line 4487
# Use the type when creating files in tmpfs.
#line 4487

#line 4487

#line 4487

#line 4487

#line 4487
#
#line 4487
# Allow the process to modify the directory.
#line 4487
#
#line 4487
allow cougaar_t tmpfs_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4487

#line 4487
#
#line 4487
# Allow the process to create the file.
#line 4487
#
#line 4487

#line 4487
allow cougaar_t cougaar_tmpfs_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4487
allow cougaar_t cougaar_tmpfs_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4487

#line 4487

#line 4487

#line 4487
type_transition cougaar_t tmpfs_t:dir cougaar_tmpfs_t;
#line 4487
type_transition cougaar_t tmpfs_t:{ file lnk_file sock_file fifo_file } cougaar_tmpfs_t;
#line 4487

#line 4487

#line 4487

#line 4487
allow cougaar_tmpfs_t tmpfs_t:filesystem associate;
#line 4487

#line 4487
# Read and write /var/catman.
#line 4487
allow cougaar_t catman_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4487
allow cougaar_t catman_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4487

#line 4487
# Modify mail spool file.
#line 4487
allow cougaar_t mail_spool_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_t mail_spool_t:file { ioctl read getattr lock write append };
#line 4487
allow cougaar_t mail_spool_t:lnk_file read;
#line 4487

#line 4487
#
#line 4487
# Allow the query of filesystem quotas
#line 4487
#
#line 4487
allow cougaar_t fs_type:filesystem quotaget;
#line 4487

#line 4487
# Run helper programs.
#line 4487

#line 4487
allow cougaar_t { bin_t sbin_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_t { bin_t sbin_t }:lnk_file read;
#line 4487

#line 4487
allow cougaar_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_t ld_so_t:file { read getattr lock execute ioctl };
#line 4487
allow cougaar_t ld_so_t:file execute_no_trans;
#line 4487
allow cougaar_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4487
allow cougaar_t shlib_t:file { read getattr lock execute ioctl };
#line 4487
allow cougaar_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4487
allow cougaar_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4487

#line 4487

#line 4487
allow cougaar_t etc_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4487

#line 4487

#line 4487
allow cougaar_t lib_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4487

#line 4487

#line 4487
allow cougaar_t bin_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4487

#line 4487

#line 4487
allow cougaar_t sbin_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4487

#line 4487

#line 4487
allow cougaar_t exec_type:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4487

#line 4487

#line 4487
# Run programs developed by other users in the same domain.
#line 4487

#line 4487
allow cougaar_t cougaar_home_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4487

#line 4487

#line 4487
allow cougaar_t cougaar_tmp_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4487

#line 4487

#line 4487
# Run user programs that require different permissions in their own domain.
#line 4487
# These rules were moved into the individual program domains.
#line 4487

#line 4487
# Instantiate derived domains for a number of programs.
#line 4487
# These derived domains encode both information about the calling
#line 4487
# user domain and the program, and allow us to maintain separation
#line 4487
# between different instances of the program being run by different
#line 4487
# user domains.
#line 4487

#line 4487

#line 4487

#line 4487
# Derived domain based on the calling user domain and the program.
#line 4487
type cougaar_su_t, domain, privlog, auth;
#line 4487

#line 4487
# Transition from the user domain to this domain.
#line 4487

#line 4487

#line 4487

#line 4487
#
#line 4487
# Allow the process to transition to the new domain.
#line 4487
#
#line 4487
allow cougaar_t cougaar_su_t:process transition;
#line 4487

#line 4487
#
#line 4487
# Allow the process to execute the program.
#line 4487
# 
#line 4487
allow cougaar_t su_exec_t:file { getattr execute };
#line 4487

#line 4487
#
#line 4487
# Allow the process to reap the new domain.
#line 4487
#
#line 4487
allow cougaar_su_t cougaar_t:process sigchld;
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to inherit and use file 
#line 4487
# descriptions from the creating process and vice versa.
#line 4487
#
#line 4487
allow cougaar_su_t cougaar_t:fd use;
#line 4487
allow cougaar_t cougaar_su_t:fd use;
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to write back to the old domain via a pipe.
#line 4487
#
#line 4487
allow cougaar_su_t cougaar_t:fifo_file { ioctl read getattr lock write append };
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to read and execute the program.
#line 4487
#
#line 4487
allow cougaar_su_t su_exec_t:file { read getattr lock execute ioctl };
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to be entered via the program.
#line 4487
#
#line 4487
allow cougaar_su_t su_exec_t:file entrypoint;
#line 4487

#line 4487
type_transition cougaar_t su_exec_t:process cougaar_su_t;
#line 4487

#line 4487

#line 4487
# This domain is granted permissions common to most domains.
#line 4487

#line 4487

#line 4487
# Grant the permissions common to the test domains.
#line 4487

#line 4487
# Grant permissions within the domain.
#line 4487

#line 4487
# Access other processes in the same domain.
#line 4487
allow cougaar_su_t self:process *;
#line 4487

#line 4487
# Access /proc/PID files for processes in the same domain.
#line 4487
allow cougaar_su_t self:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Access file descriptions, pipes, and sockets
#line 4487
# created by processes in the same domain.
#line 4487
allow cougaar_su_t self:fd *;
#line 4487
allow cougaar_su_t self:fifo_file { ioctl read getattr lock write append };
#line 4487
allow cougaar_su_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4487
allow cougaar_su_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4487

#line 4487
# Allow the domain to communicate with other processes in the same domain.
#line 4487
allow cougaar_su_t self:unix_dgram_socket sendto;
#line 4487
allow cougaar_su_t self:unix_stream_socket connectto;
#line 4487

#line 4487
# Access System V IPC objects created by processes in the same domain.
#line 4487
allow cougaar_su_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 4487
allow cougaar_su_t self:msg  { send receive };
#line 4487
allow cougaar_su_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 4487
allow cougaar_su_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 4487

#line 4487

#line 4487

#line 4487
# Grant read/search permissions to most of /proc.
#line 4487

#line 4487
# Read system information files in /proc.
#line 4487
allow cougaar_su_t proc_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t proc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Stat /proc/kmsg and /proc/kcore.
#line 4487
allow cougaar_su_t proc_kmsg_t:file { getattr };
#line 4487
allow cougaar_su_t proc_kcore_t:file { getattr };
#line 4487

#line 4487
# Read system variables in /proc/sys.
#line 4487
allow cougaar_su_t sysctl_modprobe_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_su_t sysctl_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_su_t sysctl_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t sysctl_fs_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_su_t sysctl_fs_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t sysctl_kernel_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_su_t sysctl_kernel_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t sysctl_net_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_su_t sysctl_net_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t sysctl_vm_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_su_t sysctl_vm_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t sysctl_dev_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_su_t sysctl_dev_t:dir { read getattr lock search ioctl };
#line 4487

#line 4487

#line 4487
# Grant read/search permissions to many system file types.
#line 4487

#line 4487

#line 4487
# Get attributes of file systems.
#line 4487
allow cougaar_su_t fs_type:filesystem getattr;
#line 4487

#line 4487

#line 4487
# Read /.
#line 4487
allow cougaar_su_t root_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t root_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /home.
#line 4487
allow cougaar_su_t home_root_t:dir { read getattr lock search ioctl };
#line 4487

#line 4487
# Read /usr.
#line 4487
allow cougaar_su_t usr_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t usr_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read bin and sbin directories.
#line 4487
allow cougaar_su_t bin_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487
allow cougaar_su_t sbin_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487

#line 4487
# Read directories and files with the readable_t type.
#line 4487
# This type is a general type for "world"-readable files.
#line 4487
allow cougaar_su_t readable_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t readable_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Stat /...security and lost+found.
#line 4487
allow cougaar_su_t file_labels_t:dir getattr;
#line 4487
allow cougaar_su_t lost_found_t:dir getattr;
#line 4487

#line 4487
# Read the devpts root directory.  
#line 4487
allow cougaar_su_t devpts_t:dir { read getattr lock search ioctl };
#line 4487

#line 4487

#line 4487
# Read the /tmp directory and any /tmp files with the base type.
#line 4487
# Temporary files created at runtime will typically use derived types.
#line 4487
allow cougaar_su_t tmp_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t tmp_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /var.
#line 4487
allow cougaar_su_t var_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t var_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /var/catman.
#line 4487
allow cougaar_su_t catman_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t catman_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /var/lib.
#line 4487
allow cougaar_su_t var_lib_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t var_lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487
allow cougaar_su_t var_lib_nfs_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t var_lib_nfs_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487

#line 4487
allow cougaar_su_t tetex_data_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t tetex_data_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487

#line 4487
# Read /var/yp.
#line 4487
allow cougaar_su_t var_yp_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t var_yp_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /var/spool.
#line 4487
allow cougaar_su_t var_spool_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t var_spool_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /var/run, /var/lock, /var/log.
#line 4487
allow cougaar_su_t var_run_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t var_run_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_su_t var_log_t:dir { read getattr lock search ioctl };
#line 4487
#allow cougaar_su_t var_log_t:{ file lnk_file } r_file_perms;
#line 4487
allow cougaar_su_t var_log_sa_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t var_log_sa_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_su_t var_log_ksyms_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
allow cougaar_su_t var_lock_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t var_lock_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /var/run/utmp and /var/log/wtmp.
#line 4487
allow cougaar_su_t initrc_var_run_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_su_t wtmp_t:file { read getattr lock ioctl };
#line 4487

#line 4487
# Read /boot, /boot/System.map*, and /vmlinuz*
#line 4487
allow cougaar_su_t boot_t:dir { search getattr };
#line 4487
allow cougaar_su_t boot_t:file getattr;
#line 4487
allow cougaar_su_t system_map_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
allow cougaar_su_t boot_t:lnk_file read;
#line 4487

#line 4487
# Read /etc.
#line 4487
allow cougaar_su_t etc_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t etc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487
allow cougaar_su_t etc_runtime_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_su_t etc_aliases_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_su_t etc_mail_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t etc_mail_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_su_t resolv_conf_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_su_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4487

#line 4487
# Read /lib.
#line 4487
allow cougaar_su_t lib_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read the linker, shared library, and executable types.
#line 4487
allow cougaar_su_t ld_so_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_su_t shlib_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_su_t exec_type:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read man directories and files.
#line 4487
allow cougaar_su_t man_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t man_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /usr/src.
#line 4487
allow cougaar_su_t src_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t src_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read module-related files.
#line 4487
allow cougaar_su_t modules_object_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t modules_object_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_su_t modules_dep_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_su_t modules_conf_t:{ file lnk_file} { read getattr lock ioctl };
#line 4487

#line 4487
# Read /dev directories and any symbolic links.
#line 4487
allow cougaar_su_t device_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t device_t:lnk_file { read getattr lock ioctl };
#line 4487

#line 4487
# Read /dev/random and /dev/zero.
#line 4487
allow cougaar_su_t random_device_t:chr_file { read getattr lock ioctl };
#line 4487
allow cougaar_su_t zero_device_t:chr_file { read getattr lock ioctl };
#line 4487

#line 4487
# Read the root directory of a tmpfs filesytem and any symbolic links.
#line 4487
allow cougaar_su_t tmpfs_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t tmpfs_t:lnk_file { read getattr lock ioctl };
#line 4487

#line 4487
# Read any symbolic links on a devfs file system.
#line 4487
allow cougaar_su_t device_t:lnk_file { read getattr lock ioctl };
#line 4487

#line 4487
# Read the root directory of a usbdevfs filesystem, and
#line 4487
# the devices and drivers files.  Permit stating of the
#line 4487
# device nodes, but nothing else.
#line 4487
allow cougaar_su_t usbdevfs_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t usbdevfs_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_su_t usbdevfs_device_t:file getattr;
#line 4487

#line 4487

#line 4487
# Grant write permissions to a small set of system file types.
#line 4487
# No permission to create files is granted here.  Use allow rules to grant 
#line 4487
# create permissions to a type or use file_type_auto_trans rules to set up
#line 4487
# new types for files.
#line 4487

#line 4487

#line 4487
# Read and write /dev/tty and /dev/null.
#line 4487
allow cougaar_su_t devtty_t:chr_file { ioctl read getattr lock write append };
#line 4487
allow cougaar_su_t { null_device_t zero_device_t }:chr_file { ioctl read getattr lock write append };
#line 4487

#line 4487
# Do not audit write denials to /etc/ld.so.cache.
#line 4487
dontaudit cougaar_su_t ld_so_cache_t:file write;
#line 4487

#line 4487

#line 4487
# Execute from the system shared libraries.
#line 4487
# No permission to execute anything else is granted here.
#line 4487
# Use can_exec or can_exec_any to grant the ability to execute within a domain.
#line 4487
# Use domain_auto_trans for executing and changing domains.
#line 4487

#line 4487
allow cougaar_su_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t ld_so_t:file { read getattr lock execute ioctl };
#line 4487
allow cougaar_su_t ld_so_t:file execute_no_trans;
#line 4487
allow cougaar_su_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4487
allow cougaar_su_t shlib_t:file { read getattr lock execute ioctl };
#line 4487
allow cougaar_su_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4487
allow cougaar_su_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_su_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4487

#line 4487

#line 4487
# read localization information
#line 4487
allow cougaar_su_t locale_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_su_t locale_t:{file lnk_file} { read getattr lock ioctl };
#line 4487

#line 4487
# Obtain the context of any SID, the SID for any context, 
#line 4487
# and the list of active SIDs.
#line 4487
allow cougaar_su_t security_t:security { sid_to_context context_to_sid get_sids };
#line 4487

#line 4487

#line 4487

#line 4487
# Grant permissions needed to create TCP and UDP sockets and 
#line 4487
# to access the network.
#line 4487

#line 4487
#
#line 4487
# Allow the domain to create and use UDP and TCP sockets.
#line 4487
# Other kinds of sockets must be separately authorized for use.
#line 4487
allow cougaar_su_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4487
allow cougaar_su_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4487

#line 4487
#
#line 4487
# Allow the domain to send UDP packets.
#line 4487
# Since the destination sockets type is unknown, the generic
#line 4487
# any_socket_t type is used as a placeholder.
#line 4487
#
#line 4487
allow cougaar_su_t any_socket_t:udp_socket sendto;
#line 4487

#line 4487
#
#line 4487
# Allow the domain to send using any network interface.
#line 4487
# netif_type is a type attribute for all network interface types.
#line 4487
#
#line 4487
allow cougaar_su_t netif_type:netif { tcp_send udp_send rawip_send };
#line 4487

#line 4487
#
#line 4487
# Allow packets sent by the domain to be received on any network interface.
#line 4487
#
#line 4487
allow cougaar_su_t netif_type:netif { tcp_recv udp_recv rawip_recv };
#line 4487

#line 4487
#
#line 4487
# Allow the domain to receive packets from any network interface.
#line 4487
# netmsg_type is a type attribute for all default message types.
#line 4487
#
#line 4487
allow cougaar_su_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
#line 4487

#line 4487
#
#line 4487
# Allow the domain to initiate or accept TCP connections 
#line 4487
# on any network interface.
#line 4487
#
#line 4487
allow cougaar_su_t netmsg_type:tcp_socket { connectto acceptfrom };
#line 4487

#line 4487
#
#line 4487
# Receive resets from the TCP reset socket.
#line 4487
# The TCP reset socket is labeled with the tcp_socket_t type.
#line 4487
#
#line 4487
allow cougaar_su_t tcp_socket_t:tcp_socket recvfrom;
#line 4487

#line 4487
dontaudit cougaar_su_t tcp_socket_t:tcp_socket connectto;
#line 4487

#line 4487
#
#line 4487
# Allow the domain to send to any node.
#line 4487
# node_type is a type attribute for all node types.
#line 4487
#
#line 4487
allow cougaar_su_t node_type:node { tcp_send udp_send rawip_send };
#line 4487

#line 4487
#
#line 4487
# Allow packets sent by the domain to be received from any node.
#line 4487
#
#line 4487
allow cougaar_su_t node_type:node { tcp_recv udp_recv rawip_recv };
#line 4487

#line 4487
#
#line 4487
# Allow the domain to send NFS client requests via the socket
#line 4487
# created by mount.
#line 4487
#
#line 4487
allow cougaar_su_t mount_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4487

#line 4487
#
#line 4487
# Bind to the default port type.
#line 4487
# Other port types must be separately authorized.
#line 4487
#
#line 4487
allow cougaar_su_t port_t:udp_socket name_bind;
#line 4487
allow cougaar_su_t port_t:tcp_socket name_bind;
#line 4487

#line 4487

#line 4487

#line 4487
# Use capabilities.
#line 4487
allow cougaar_su_t self:capability { setuid setgid net_bind_service chown dac_override sys_nice sys_resource };
#line 4487

#line 4487
# Revert to the user domain when a shell is executed.
#line 4487

#line 4487

#line 4487

#line 4487
#
#line 4487
# Allow the process to transition to the new domain.
#line 4487
#
#line 4487
allow cougaar_su_t cougaar_t:process transition;
#line 4487

#line 4487
#
#line 4487
# Allow the process to execute the program.
#line 4487
# 
#line 4487
allow cougaar_su_t shell_exec_t:file { getattr execute };
#line 4487

#line 4487
#
#line 4487
# Allow the process to reap the new domain.
#line 4487
#
#line 4487
allow cougaar_t cougaar_su_t:process sigchld;
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to inherit and use file 
#line 4487
# descriptions from the creating process and vice versa.
#line 4487
#
#line 4487
allow cougaar_t cougaar_su_t:fd use;
#line 4487
allow cougaar_su_t cougaar_t:fd use;
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to write back to the old domain via a pipe.
#line 4487
#
#line 4487
allow cougaar_t cougaar_su_t:fifo_file { ioctl read getattr lock write append };
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to read and execute the program.
#line 4487
#
#line 4487
allow cougaar_t shell_exec_t:file { read getattr lock execute ioctl };
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to be entered via the program.
#line 4487
#
#line 4487
allow cougaar_t shell_exec_t:file entrypoint;
#line 4487

#line 4487
type_transition cougaar_su_t shell_exec_t:process cougaar_t;
#line 4487

#line 4487

#line 4487
allow cougaar_su_t privfd:fd use;
#line 4487

#line 4487
# Write to utmp.
#line 4487
allow cougaar_su_t initrc_var_run_t:file { ioctl read getattr lock write append };
#line 4487

#line 4487

#line 4487

#line 4487
# Run chkpwd.
#line 4487

#line 4487
allow cougaar_su_t chkpwd_exec_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4487

#line 4487

#line 4487

#line 4487
# Inherit and use descriptors from gnome-pty-helper.
#line 4487

#line 4487

#line 4487
# The user role is authorized for this domain.
#line 4487
role cougaar_r types cougaar_su_t;
#line 4487

#line 4487
# Write to the user domain tty.
#line 4487
allow cougaar_su_t cougaar_tty_device_t:chr_file { ioctl read getattr lock write append };
#line 4487
allow cougaar_su_t cougaar_devpts_t:chr_file { ioctl read getattr lock write append };
#line 4487

#line 4487
allow cougaar_su_t cougaar_home_dir_t:dir search;
#line 4487

#line 4487
# Modify .Xauthority file (via xauth program).
#line 4487

#line 4487

#line 4487

#line 4487

#line 4487
#
#line 4487
# Allow the process to transition to the new domain.
#line 4487
#
#line 4487
allow cougaar_su_t cougaar_xauth_t:process transition;
#line 4487

#line 4487
#
#line 4487
# Allow the process to execute the program.
#line 4487
# 
#line 4487
allow cougaar_su_t xauth_exec_t:file { getattr execute };
#line 4487

#line 4487
#
#line 4487
# Allow the process to reap the new domain.
#line 4487
#
#line 4487
allow cougaar_xauth_t cougaar_su_t:process sigchld;
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to inherit and use file 
#line 4487
# descriptions from the creating process and vice versa.
#line 4487
#
#line 4487
allow cougaar_xauth_t cougaar_su_t:fd use;
#line 4487
allow cougaar_su_t cougaar_xauth_t:fd use;
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to write back to the old domain via a pipe.
#line 4487
#
#line 4487
allow cougaar_xauth_t cougaar_su_t:fifo_file { ioctl read getattr lock write append };
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to read and execute the program.
#line 4487
#
#line 4487
allow cougaar_xauth_t xauth_exec_t:file { read getattr lock execute ioctl };
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to be entered via the program.
#line 4487
#
#line 4487
allow cougaar_xauth_t xauth_exec_t:file entrypoint;
#line 4487

#line 4487
type_transition cougaar_su_t xauth_exec_t:process cougaar_xauth_t;
#line 4487

#line 4487

#line 4487

#line 4487
# Access sshd cookie files.
#line 4487
allow cougaar_su_t sshd_tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4487
allow cougaar_su_t sshd_tmp_t:file { ioctl read getattr lock write append };
#line 4487

#line 4487

#line 4487

#line 4487

#line 4487
#
#line 4487
# Allow the process to modify the directory.
#line 4487
#
#line 4487
allow cougaar_su_t sshd_tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4487

#line 4487
#
#line 4487
# Allow the process to create the file.
#line 4487
#
#line 4487

#line 4487
allow cougaar_su_t cougaar_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4487
allow cougaar_su_t cougaar_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4487

#line 4487

#line 4487

#line 4487
type_transition cougaar_su_t sshd_tmp_t:dir cougaar_tmp_t;
#line 4487
type_transition cougaar_su_t sshd_tmp_t:{ file lnk_file sock_file fifo_file } cougaar_tmp_t;
#line 4487

#line 4487

#line 4487

#line 4487

#line 4487
# stop su complaining if you run it from a directory with restrictive perms
#line 4487
dontaudit cougaar_su_t file_type:dir search;
#line 4487

#line 4487

#line 4487
# Derived domain based on the calling user domain and the program.
#line 4487
type cougaar_chkpwd_t, domain, privlog, auth;
#line 4487

#line 4487
# Transition from the user domain to this domain.
#line 4487

#line 4487

#line 4487

#line 4487
#
#line 4487
# Allow the process to transition to the new domain.
#line 4487
#
#line 4487
allow cougaar_t cougaar_chkpwd_t:process transition;
#line 4487

#line 4487
#
#line 4487
# Allow the process to execute the program.
#line 4487
# 
#line 4487
allow cougaar_t chkpwd_exec_t:file { getattr execute };
#line 4487

#line 4487
#
#line 4487
# Allow the process to reap the new domain.
#line 4487
#
#line 4487
allow cougaar_chkpwd_t cougaar_t:process sigchld;
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to inherit and use file 
#line 4487
# descriptions from the creating process and vice versa.
#line 4487
#
#line 4487
allow cougaar_chkpwd_t cougaar_t:fd use;
#line 4487
allow cougaar_t cougaar_chkpwd_t:fd use;
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to write back to the old domain via a pipe.
#line 4487
#
#line 4487
allow cougaar_chkpwd_t cougaar_t:fifo_file { ioctl read getattr lock write append };
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to read and execute the program.
#line 4487
#
#line 4487
allow cougaar_chkpwd_t chkpwd_exec_t:file { read getattr lock execute ioctl };
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to be entered via the program.
#line 4487
#
#line 4487
allow cougaar_chkpwd_t chkpwd_exec_t:file entrypoint;
#line 4487

#line 4487
type_transition cougaar_t chkpwd_exec_t:process cougaar_chkpwd_t;
#line 4487

#line 4487

#line 4487
# The user role is authorized for this domain.
#line 4487
role cougaar_r types cougaar_chkpwd_t;
#line 4487

#line 4487
# This domain is granted permissions common to most domains (includes can_net)
#line 4487

#line 4487

#line 4487
# Grant the permissions common to the test domains.
#line 4487

#line 4487
# Grant permissions within the domain.
#line 4487

#line 4487
# Access other processes in the same domain.
#line 4487
allow cougaar_chkpwd_t self:process *;
#line 4487

#line 4487
# Access /proc/PID files for processes in the same domain.
#line 4487
allow cougaar_chkpwd_t self:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Access file descriptions, pipes, and sockets
#line 4487
# created by processes in the same domain.
#line 4487
allow cougaar_chkpwd_t self:fd *;
#line 4487
allow cougaar_chkpwd_t self:fifo_file { ioctl read getattr lock write append };
#line 4487
allow cougaar_chkpwd_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4487
allow cougaar_chkpwd_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4487

#line 4487
# Allow the domain to communicate with other processes in the same domain.
#line 4487
allow cougaar_chkpwd_t self:unix_dgram_socket sendto;
#line 4487
allow cougaar_chkpwd_t self:unix_stream_socket connectto;
#line 4487

#line 4487
# Access System V IPC objects created by processes in the same domain.
#line 4487
allow cougaar_chkpwd_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 4487
allow cougaar_chkpwd_t self:msg  { send receive };
#line 4487
allow cougaar_chkpwd_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 4487
allow cougaar_chkpwd_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 4487

#line 4487

#line 4487

#line 4487
# Grant read/search permissions to most of /proc.
#line 4487

#line 4487
# Read system information files in /proc.
#line 4487
allow cougaar_chkpwd_t proc_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t proc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Stat /proc/kmsg and /proc/kcore.
#line 4487
allow cougaar_chkpwd_t proc_kmsg_t:file { getattr };
#line 4487
allow cougaar_chkpwd_t proc_kcore_t:file { getattr };
#line 4487

#line 4487
# Read system variables in /proc/sys.
#line 4487
allow cougaar_chkpwd_t sysctl_modprobe_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_chkpwd_t sysctl_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_chkpwd_t sysctl_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t sysctl_fs_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_chkpwd_t sysctl_fs_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t sysctl_kernel_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_chkpwd_t sysctl_kernel_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t sysctl_net_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_chkpwd_t sysctl_net_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t sysctl_vm_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_chkpwd_t sysctl_vm_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t sysctl_dev_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_chkpwd_t sysctl_dev_t:dir { read getattr lock search ioctl };
#line 4487

#line 4487

#line 4487
# Grant read/search permissions to many system file types.
#line 4487

#line 4487

#line 4487
# Get attributes of file systems.
#line 4487
allow cougaar_chkpwd_t fs_type:filesystem getattr;
#line 4487

#line 4487

#line 4487
# Read /.
#line 4487
allow cougaar_chkpwd_t root_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t root_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /home.
#line 4487
allow cougaar_chkpwd_t home_root_t:dir { read getattr lock search ioctl };
#line 4487

#line 4487
# Read /usr.
#line 4487
allow cougaar_chkpwd_t usr_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t usr_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read bin and sbin directories.
#line 4487
allow cougaar_chkpwd_t bin_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487
allow cougaar_chkpwd_t sbin_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487

#line 4487
# Read directories and files with the readable_t type.
#line 4487
# This type is a general type for "world"-readable files.
#line 4487
allow cougaar_chkpwd_t readable_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t readable_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Stat /...security and lost+found.
#line 4487
allow cougaar_chkpwd_t file_labels_t:dir getattr;
#line 4487
allow cougaar_chkpwd_t lost_found_t:dir getattr;
#line 4487

#line 4487
# Read the devpts root directory.  
#line 4487
allow cougaar_chkpwd_t devpts_t:dir { read getattr lock search ioctl };
#line 4487

#line 4487

#line 4487
# Read the /tmp directory and any /tmp files with the base type.
#line 4487
# Temporary files created at runtime will typically use derived types.
#line 4487
allow cougaar_chkpwd_t tmp_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t tmp_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /var.
#line 4487
allow cougaar_chkpwd_t var_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t var_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /var/catman.
#line 4487
allow cougaar_chkpwd_t catman_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t catman_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /var/lib.
#line 4487
allow cougaar_chkpwd_t var_lib_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t var_lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487
allow cougaar_chkpwd_t var_lib_nfs_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t var_lib_nfs_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487

#line 4487
allow cougaar_chkpwd_t tetex_data_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t tetex_data_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487

#line 4487
# Read /var/yp.
#line 4487
allow cougaar_chkpwd_t var_yp_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t var_yp_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /var/spool.
#line 4487
allow cougaar_chkpwd_t var_spool_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t var_spool_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /var/run, /var/lock, /var/log.
#line 4487
allow cougaar_chkpwd_t var_run_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t var_run_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_chkpwd_t var_log_t:dir { read getattr lock search ioctl };
#line 4487
#allow cougaar_chkpwd_t var_log_t:{ file lnk_file } r_file_perms;
#line 4487
allow cougaar_chkpwd_t var_log_sa_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t var_log_sa_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_chkpwd_t var_log_ksyms_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
allow cougaar_chkpwd_t var_lock_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t var_lock_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /var/run/utmp and /var/log/wtmp.
#line 4487
allow cougaar_chkpwd_t initrc_var_run_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_chkpwd_t wtmp_t:file { read getattr lock ioctl };
#line 4487

#line 4487
# Read /boot, /boot/System.map*, and /vmlinuz*
#line 4487
allow cougaar_chkpwd_t boot_t:dir { search getattr };
#line 4487
allow cougaar_chkpwd_t boot_t:file getattr;
#line 4487
allow cougaar_chkpwd_t system_map_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
allow cougaar_chkpwd_t boot_t:lnk_file read;
#line 4487

#line 4487
# Read /etc.
#line 4487
allow cougaar_chkpwd_t etc_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t etc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487
allow cougaar_chkpwd_t etc_runtime_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_chkpwd_t etc_aliases_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_chkpwd_t etc_mail_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t etc_mail_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_chkpwd_t resolv_conf_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_chkpwd_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4487

#line 4487
# Read /lib.
#line 4487
allow cougaar_chkpwd_t lib_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read the linker, shared library, and executable types.
#line 4487
allow cougaar_chkpwd_t ld_so_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_chkpwd_t shlib_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_chkpwd_t exec_type:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read man directories and files.
#line 4487
allow cougaar_chkpwd_t man_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t man_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /usr/src.
#line 4487
allow cougaar_chkpwd_t src_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t src_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read module-related files.
#line 4487
allow cougaar_chkpwd_t modules_object_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t modules_object_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_chkpwd_t modules_dep_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_chkpwd_t modules_conf_t:{ file lnk_file} { read getattr lock ioctl };
#line 4487

#line 4487
# Read /dev directories and any symbolic links.
#line 4487
allow cougaar_chkpwd_t device_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t device_t:lnk_file { read getattr lock ioctl };
#line 4487

#line 4487
# Read /dev/random and /dev/zero.
#line 4487
allow cougaar_chkpwd_t random_device_t:chr_file { read getattr lock ioctl };
#line 4487
allow cougaar_chkpwd_t zero_device_t:chr_file { read getattr lock ioctl };
#line 4487

#line 4487
# Read the root directory of a tmpfs filesytem and any symbolic links.
#line 4487
allow cougaar_chkpwd_t tmpfs_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t tmpfs_t:lnk_file { read getattr lock ioctl };
#line 4487

#line 4487
# Read any symbolic links on a devfs file system.
#line 4487
allow cougaar_chkpwd_t device_t:lnk_file { read getattr lock ioctl };
#line 4487

#line 4487
# Read the root directory of a usbdevfs filesystem, and
#line 4487
# the devices and drivers files.  Permit stating of the
#line 4487
# device nodes, but nothing else.
#line 4487
allow cougaar_chkpwd_t usbdevfs_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t usbdevfs_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_chkpwd_t usbdevfs_device_t:file getattr;
#line 4487

#line 4487

#line 4487
# Grant write permissions to a small set of system file types.
#line 4487
# No permission to create files is granted here.  Use allow rules to grant 
#line 4487
# create permissions to a type or use file_type_auto_trans rules to set up
#line 4487
# new types for files.
#line 4487

#line 4487

#line 4487
# Read and write /dev/tty and /dev/null.
#line 4487
allow cougaar_chkpwd_t devtty_t:chr_file { ioctl read getattr lock write append };
#line 4487
allow cougaar_chkpwd_t { null_device_t zero_device_t }:chr_file { ioctl read getattr lock write append };
#line 4487

#line 4487
# Do not audit write denials to /etc/ld.so.cache.
#line 4487
dontaudit cougaar_chkpwd_t ld_so_cache_t:file write;
#line 4487

#line 4487

#line 4487
# Execute from the system shared libraries.
#line 4487
# No permission to execute anything else is granted here.
#line 4487
# Use can_exec or can_exec_any to grant the ability to execute within a domain.
#line 4487
# Use domain_auto_trans for executing and changing domains.
#line 4487

#line 4487
allow cougaar_chkpwd_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t ld_so_t:file { read getattr lock execute ioctl };
#line 4487
allow cougaar_chkpwd_t ld_so_t:file execute_no_trans;
#line 4487
allow cougaar_chkpwd_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4487
allow cougaar_chkpwd_t shlib_t:file { read getattr lock execute ioctl };
#line 4487
allow cougaar_chkpwd_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4487
allow cougaar_chkpwd_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_chkpwd_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4487

#line 4487

#line 4487
# read localization information
#line 4487
allow cougaar_chkpwd_t locale_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_chkpwd_t locale_t:{file lnk_file} { read getattr lock ioctl };
#line 4487

#line 4487
# Obtain the context of any SID, the SID for any context, 
#line 4487
# and the list of active SIDs.
#line 4487
allow cougaar_chkpwd_t security_t:security { sid_to_context context_to_sid get_sids };
#line 4487

#line 4487

#line 4487

#line 4487
# Grant permissions needed to create TCP and UDP sockets and 
#line 4487
# to access the network.
#line 4487

#line 4487
#
#line 4487
# Allow the domain to create and use UDP and TCP sockets.
#line 4487
# Other kinds of sockets must be separately authorized for use.
#line 4487
allow cougaar_chkpwd_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4487
allow cougaar_chkpwd_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4487

#line 4487
#
#line 4487
# Allow the domain to send UDP packets.
#line 4487
# Since the destination sockets type is unknown, the generic
#line 4487
# any_socket_t type is used as a placeholder.
#line 4487
#
#line 4487
allow cougaar_chkpwd_t any_socket_t:udp_socket sendto;
#line 4487

#line 4487
#
#line 4487
# Allow the domain to send using any network interface.
#line 4487
# netif_type is a type attribute for all network interface types.
#line 4487
#
#line 4487
allow cougaar_chkpwd_t netif_type:netif { tcp_send udp_send rawip_send };
#line 4487

#line 4487
#
#line 4487
# Allow packets sent by the domain to be received on any network interface.
#line 4487
#
#line 4487
allow cougaar_chkpwd_t netif_type:netif { tcp_recv udp_recv rawip_recv };
#line 4487

#line 4487
#
#line 4487
# Allow the domain to receive packets from any network interface.
#line 4487
# netmsg_type is a type attribute for all default message types.
#line 4487
#
#line 4487
allow cougaar_chkpwd_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
#line 4487

#line 4487
#
#line 4487
# Allow the domain to initiate or accept TCP connections 
#line 4487
# on any network interface.
#line 4487
#
#line 4487
allow cougaar_chkpwd_t netmsg_type:tcp_socket { connectto acceptfrom };
#line 4487

#line 4487
#
#line 4487
# Receive resets from the TCP reset socket.
#line 4487
# The TCP reset socket is labeled with the tcp_socket_t type.
#line 4487
#
#line 4487
allow cougaar_chkpwd_t tcp_socket_t:tcp_socket recvfrom;
#line 4487

#line 4487
dontaudit cougaar_chkpwd_t tcp_socket_t:tcp_socket connectto;
#line 4487

#line 4487
#
#line 4487
# Allow the domain to send to any node.
#line 4487
# node_type is a type attribute for all node types.
#line 4487
#
#line 4487
allow cougaar_chkpwd_t node_type:node { tcp_send udp_send rawip_send };
#line 4487

#line 4487
#
#line 4487
# Allow packets sent by the domain to be received from any node.
#line 4487
#
#line 4487
allow cougaar_chkpwd_t node_type:node { tcp_recv udp_recv rawip_recv };
#line 4487

#line 4487
#
#line 4487
# Allow the domain to send NFS client requests via the socket
#line 4487
# created by mount.
#line 4487
#
#line 4487
allow cougaar_chkpwd_t mount_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4487

#line 4487
#
#line 4487
# Bind to the default port type.
#line 4487
# Other port types must be separately authorized.
#line 4487
#
#line 4487
allow cougaar_chkpwd_t port_t:udp_socket name_bind;
#line 4487
allow cougaar_chkpwd_t port_t:tcp_socket name_bind;
#line 4487

#line 4487

#line 4487

#line 4487
# Use capabilities.
#line 4487
allow cougaar_chkpwd_t self:capability setuid;
#line 4487

#line 4487
# Inherit and use descriptors from gnome-pty-helper.
#line 4487

#line 4487

#line 4487
# Inherit and use descriptors from newrole.
#line 4487
allow cougaar_chkpwd_t newrole_t:fd use;
#line 4487

#line 4487
# Write to the user domain tty.
#line 4487
allow cougaar_chkpwd_t cougaar_tty_device_t:chr_file { ioctl read getattr lock write append };
#line 4487
allow cougaar_chkpwd_t cougaar_devpts_t:chr_file { ioctl read getattr lock write append };
#line 4487

#line 4487

#line 4487

#line 4487

#line 4487

#line 4487

#line 4487
# Derived domain based on the calling user domain and the program.
#line 4487
type cougaar_xauth_t, domain;
#line 4487
type cougaar_home_xauth_t, file_type, sysadmfile;
#line 4487

#line 4487
allow cougaar_t cougaar_home_xauth_t:file { relabelfrom relabelto { create ioctl read getattr lock write setattr append link unlink rename } };
#line 4487

#line 4487
# Transition from the user domain to this domain.
#line 4487

#line 4487

#line 4487

#line 4487
#
#line 4487
# Allow the process to transition to the new domain.
#line 4487
#
#line 4487
allow cougaar_t cougaar_xauth_t:process transition;
#line 4487

#line 4487
#
#line 4487
# Allow the process to execute the program.
#line 4487
# 
#line 4487
allow cougaar_t xauth_exec_t:file { getattr execute };
#line 4487

#line 4487
#
#line 4487
# Allow the process to reap the new domain.
#line 4487
#
#line 4487
allow cougaar_xauth_t cougaar_t:process sigchld;
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to inherit and use file 
#line 4487
# descriptions from the creating process and vice versa.
#line 4487
#
#line 4487
allow cougaar_xauth_t cougaar_t:fd use;
#line 4487
allow cougaar_t cougaar_xauth_t:fd use;
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to write back to the old domain via a pipe.
#line 4487
#
#line 4487
allow cougaar_xauth_t cougaar_t:fifo_file { ioctl read getattr lock write append };
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to read and execute the program.
#line 4487
#
#line 4487
allow cougaar_xauth_t xauth_exec_t:file { read getattr lock execute ioctl };
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to be entered via the program.
#line 4487
#
#line 4487
allow cougaar_xauth_t xauth_exec_t:file entrypoint;
#line 4487

#line 4487
type_transition cougaar_t xauth_exec_t:process cougaar_xauth_t;
#line 4487

#line 4487

#line 4487

#line 4487

#line 4487

#line 4487
#
#line 4487
# Allow the process to transition to the new domain.
#line 4487
#
#line 4487
allow cougaar_ssh_t cougaar_xauth_t:process transition;
#line 4487

#line 4487
#
#line 4487
# Allow the process to execute the program.
#line 4487
# 
#line 4487
allow cougaar_ssh_t xauth_exec_t:file { getattr execute };
#line 4487

#line 4487
#
#line 4487
# Allow the process to reap the new domain.
#line 4487
#
#line 4487
allow cougaar_xauth_t cougaar_ssh_t:process sigchld;
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to inherit and use file 
#line 4487
# descriptions from the creating process and vice versa.
#line 4487
#
#line 4487
allow cougaar_xauth_t cougaar_ssh_t:fd use;
#line 4487
allow cougaar_ssh_t cougaar_xauth_t:fd use;
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to write back to the old domain via a pipe.
#line 4487
#
#line 4487
allow cougaar_xauth_t cougaar_ssh_t:fifo_file { ioctl read getattr lock write append };
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to read and execute the program.
#line 4487
#
#line 4487
allow cougaar_xauth_t xauth_exec_t:file { read getattr lock execute ioctl };
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to be entered via the program.
#line 4487
#
#line 4487
allow cougaar_xauth_t xauth_exec_t:file entrypoint;
#line 4487

#line 4487
type_transition cougaar_ssh_t xauth_exec_t:process cougaar_xauth_t;
#line 4487

#line 4487
allow cougaar_xauth_t sshd_t:fifo_file { getattr read };
#line 4487
dontaudit cougaar_xauth_t cougaar_ssh_t:tcp_socket { read write };
#line 4487
allow cougaar_xauth_t sshd_t:process sigchld;
#line 4487

#line 4487

#line 4487

#line 4487

#line 4487

#line 4487

#line 4487
#
#line 4487
# Allow the process to transition to the new domain.
#line 4487
#
#line 4487
allow cougaar_su_t cougaar_xauth_t:process transition;
#line 4487

#line 4487
#
#line 4487
# Allow the process to execute the program.
#line 4487
# 
#line 4487
allow cougaar_su_t xauth_exec_t:file { getattr execute };
#line 4487

#line 4487
#
#line 4487
# Allow the process to reap the new domain.
#line 4487
#
#line 4487
allow cougaar_xauth_t cougaar_su_t:process sigchld;
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to inherit and use file 
#line 4487
# descriptions from the creating process and vice versa.
#line 4487
#
#line 4487
allow cougaar_xauth_t cougaar_su_t:fd use;
#line 4487
allow cougaar_su_t cougaar_xauth_t:fd use;
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to write back to the old domain via a pipe.
#line 4487
#
#line 4487
allow cougaar_xauth_t cougaar_su_t:fifo_file { ioctl read getattr lock write append };
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to read and execute the program.
#line 4487
#
#line 4487
allow cougaar_xauth_t xauth_exec_t:file { read getattr lock execute ioctl };
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to be entered via the program.
#line 4487
#
#line 4487
allow cougaar_xauth_t xauth_exec_t:file entrypoint;
#line 4487

#line 4487
type_transition cougaar_su_t xauth_exec_t:process cougaar_xauth_t;
#line 4487

#line 4487

#line 4487

#line 4487
# The user role is authorized for this domain.
#line 4487
role cougaar_r types cougaar_xauth_t;
#line 4487

#line 4487
# Inherit and use descriptors from gnome-pty-helper.
#line 4487

#line 4487

#line 4487
allow cougaar_xauth_t privfd:fd use;
#line 4487

#line 4487
# allow ps to show xauth
#line 4487
allow cougaar_t cougaar_xauth_t:dir { search getattr read };
#line 4487
allow cougaar_t cougaar_xauth_t:{ file lnk_file } { read getattr };
#line 4487
allow cougaar_t cougaar_xauth_t:process signal;
#line 4487

#line 4487

#line 4487
allow cougaar_xauth_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_xauth_t ld_so_t:file { read getattr lock execute ioctl };
#line 4487
allow cougaar_xauth_t ld_so_t:file execute_no_trans;
#line 4487
allow cougaar_xauth_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4487
allow cougaar_xauth_t shlib_t:file { read getattr lock execute ioctl };
#line 4487
allow cougaar_xauth_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4487
allow cougaar_xauth_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_xauth_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4487

#line 4487

#line 4487
# allow DNS lookups...
#line 4487

#line 4487
#
#line 4487
# Allow the domain to create and use UDP and TCP sockets.
#line 4487
# Other kinds of sockets must be separately authorized for use.
#line 4487
allow cougaar_xauth_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4487
allow cougaar_xauth_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4487

#line 4487
#
#line 4487
# Allow the domain to send UDP packets.
#line 4487
# Since the destination sockets type is unknown, the generic
#line 4487
# any_socket_t type is used as a placeholder.
#line 4487
#
#line 4487
allow cougaar_xauth_t any_socket_t:udp_socket sendto;
#line 4487

#line 4487
#
#line 4487
# Allow the domain to send using any network interface.
#line 4487
# netif_type is a type attribute for all network interface types.
#line 4487
#
#line 4487
allow cougaar_xauth_t netif_type:netif { tcp_send udp_send rawip_send };
#line 4487

#line 4487
#
#line 4487
# Allow packets sent by the domain to be received on any network interface.
#line 4487
#
#line 4487
allow cougaar_xauth_t netif_type:netif { tcp_recv udp_recv rawip_recv };
#line 4487

#line 4487
#
#line 4487
# Allow the domain to receive packets from any network interface.
#line 4487
# netmsg_type is a type attribute for all default message types.
#line 4487
#
#line 4487
allow cougaar_xauth_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
#line 4487

#line 4487
#
#line 4487
# Allow the domain to initiate or accept TCP connections 
#line 4487
# on any network interface.
#line 4487
#
#line 4487
allow cougaar_xauth_t netmsg_type:tcp_socket { connectto acceptfrom };
#line 4487

#line 4487
#
#line 4487
# Receive resets from the TCP reset socket.
#line 4487
# The TCP reset socket is labeled with the tcp_socket_t type.
#line 4487
#
#line 4487
allow cougaar_xauth_t tcp_socket_t:tcp_socket recvfrom;
#line 4487

#line 4487
dontaudit cougaar_xauth_t tcp_socket_t:tcp_socket connectto;
#line 4487

#line 4487
#
#line 4487
# Allow the domain to send to any node.
#line 4487
# node_type is a type attribute for all node types.
#line 4487
#
#line 4487
allow cougaar_xauth_t node_type:node { tcp_send udp_send rawip_send };
#line 4487

#line 4487
#
#line 4487
# Allow packets sent by the domain to be received from any node.
#line 4487
#
#line 4487
allow cougaar_xauth_t node_type:node { tcp_recv udp_recv rawip_recv };
#line 4487

#line 4487
#
#line 4487
# Allow the domain to send NFS client requests via the socket
#line 4487
# created by mount.
#line 4487
#
#line 4487
allow cougaar_xauth_t mount_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4487

#line 4487
#
#line 4487
# Bind to the default port type.
#line 4487
# Other port types must be separately authorized.
#line 4487
#
#line 4487
allow cougaar_xauth_t port_t:udp_socket name_bind;
#line 4487
allow cougaar_xauth_t port_t:tcp_socket name_bind;
#line 4487

#line 4487

#line 4487

#line 4487
#allow cougaar_xauth_t devpts_t:dir { getattr read search };
#line 4487
#allow cougaar_xauth_t device_t:dir search;
#line 4487
#allow cougaar_xauth_t devtty_t:chr_file rw_file_perms;
#line 4487
allow cougaar_xauth_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4487
allow cougaar_xauth_t { etc_t resolv_conf_t }:file { getattr read };
#line 4487
allow cougaar_xauth_t fs_t:filesystem getattr;
#line 4487

#line 4487
#allow cougaar_xauth_t proc_t:dir search;
#line 4487
#allow cougaar_xauth_t { self proc_t }:lnk_file read;
#line 4487
#allow cougaar_xauth_t self:dir search;
#line 4487
#dontaudit cougaar_xauth_t var_run_t:dir search;
#line 4487

#line 4487
# Write to the user domain tty.
#line 4487
allow cougaar_xauth_t cougaar_tty_device_t:chr_file { ioctl read getattr lock write append };
#line 4487
allow cougaar_xauth_t cougaar_devpts_t:chr_file { ioctl read getattr lock write append };
#line 4487

#line 4487
# allow utmp access
#line 4487
#allow cougaar_xauth_t initrc_var_run_t:file read;
#line 4487
#dontaudit cougaar_xauth_t initrc_var_run_t:file lock;
#line 4487

#line 4487
# Scan /var/run.
#line 4487
allow cougaar_xauth_t var_t:dir search;
#line 4487
allow cougaar_xauth_t var_run_t:dir search; 
#line 4487

#line 4487
# this is what we are here for
#line 4487
allow cougaar_xauth_t home_root_t:dir search;
#line 4487

#line 4487

#line 4487

#line 4487

#line 4487
#
#line 4487
# Allow the process to modify the directory.
#line 4487
#
#line 4487
allow cougaar_xauth_t cougaar_home_dir_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4487

#line 4487
#
#line 4487
# Allow the process to create the file.
#line 4487
#
#line 4487

#line 4487
allow cougaar_xauth_t cougaar_home_xauth_t:file { create ioctl read getattr lock write setattr append link unlink rename };
#line 4487

#line 4487

#line 4487

#line 4487
type_transition cougaar_xauth_t cougaar_home_dir_t:file cougaar_home_xauth_t;
#line 4487

#line 4487

#line 4487

#line 4487

#line 4487

#line 4487

#line 4487

#line 4487

#line 4487

#line 4487

#line 4487
# Derived domain based on the calling user domain and the program.
#line 4487
type cougaar_crontab_t, domain, privlog;
#line 4487

#line 4487
# Transition from the user domain to the derived domain.
#line 4487

#line 4487

#line 4487

#line 4487
#
#line 4487
# Allow the process to transition to the new domain.
#line 4487
#
#line 4487
allow cougaar_t cougaar_crontab_t:process transition;
#line 4487

#line 4487
#
#line 4487
# Allow the process to execute the program.
#line 4487
# 
#line 4487
allow cougaar_t crontab_exec_t:file { getattr execute };
#line 4487

#line 4487
#
#line 4487
# Allow the process to reap the new domain.
#line 4487
#
#line 4487
allow cougaar_crontab_t cougaar_t:process sigchld;
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to inherit and use file 
#line 4487
# descriptions from the creating process and vice versa.
#line 4487
#
#line 4487
allow cougaar_crontab_t cougaar_t:fd use;
#line 4487
allow cougaar_t cougaar_crontab_t:fd use;
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to write back to the old domain via a pipe.
#line 4487
#
#line 4487
allow cougaar_crontab_t cougaar_t:fifo_file { ioctl read getattr lock write append };
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to read and execute the program.
#line 4487
#
#line 4487
allow cougaar_crontab_t crontab_exec_t:file { read getattr lock execute ioctl };
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to be entered via the program.
#line 4487
#
#line 4487
allow cougaar_crontab_t crontab_exec_t:file entrypoint;
#line 4487

#line 4487
type_transition cougaar_t crontab_exec_t:process cougaar_crontab_t;
#line 4487

#line 4487

#line 4487
# The user role is authorized for this domain.
#line 4487
role cougaar_r types cougaar_crontab_t;
#line 4487

#line 4487
# This domain is granted permissions common to most domains (including can_net)
#line 4487

#line 4487

#line 4487
# Grant the permissions common to the test domains.
#line 4487

#line 4487
# Grant permissions within the domain.
#line 4487

#line 4487
# Access other processes in the same domain.
#line 4487
allow cougaar_crontab_t self:process *;
#line 4487

#line 4487
# Access /proc/PID files for processes in the same domain.
#line 4487
allow cougaar_crontab_t self:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Access file descriptions, pipes, and sockets
#line 4487
# created by processes in the same domain.
#line 4487
allow cougaar_crontab_t self:fd *;
#line 4487
allow cougaar_crontab_t self:fifo_file { ioctl read getattr lock write append };
#line 4487
allow cougaar_crontab_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4487
allow cougaar_crontab_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4487

#line 4487
# Allow the domain to communicate with other processes in the same domain.
#line 4487
allow cougaar_crontab_t self:unix_dgram_socket sendto;
#line 4487
allow cougaar_crontab_t self:unix_stream_socket connectto;
#line 4487

#line 4487
# Access System V IPC objects created by processes in the same domain.
#line 4487
allow cougaar_crontab_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 4487
allow cougaar_crontab_t self:msg  { send receive };
#line 4487
allow cougaar_crontab_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 4487
allow cougaar_crontab_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 4487

#line 4487

#line 4487

#line 4487
# Grant read/search permissions to most of /proc.
#line 4487

#line 4487
# Read system information files in /proc.
#line 4487
allow cougaar_crontab_t proc_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t proc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Stat /proc/kmsg and /proc/kcore.
#line 4487
allow cougaar_crontab_t proc_kmsg_t:file { getattr };
#line 4487
allow cougaar_crontab_t proc_kcore_t:file { getattr };
#line 4487

#line 4487
# Read system variables in /proc/sys.
#line 4487
allow cougaar_crontab_t sysctl_modprobe_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_crontab_t sysctl_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_crontab_t sysctl_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t sysctl_fs_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_crontab_t sysctl_fs_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t sysctl_kernel_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_crontab_t sysctl_kernel_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t sysctl_net_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_crontab_t sysctl_net_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t sysctl_vm_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_crontab_t sysctl_vm_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t sysctl_dev_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_crontab_t sysctl_dev_t:dir { read getattr lock search ioctl };
#line 4487

#line 4487

#line 4487
# Grant read/search permissions to many system file types.
#line 4487

#line 4487

#line 4487
# Get attributes of file systems.
#line 4487
allow cougaar_crontab_t fs_type:filesystem getattr;
#line 4487

#line 4487

#line 4487
# Read /.
#line 4487
allow cougaar_crontab_t root_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t root_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /home.
#line 4487
allow cougaar_crontab_t home_root_t:dir { read getattr lock search ioctl };
#line 4487

#line 4487
# Read /usr.
#line 4487
allow cougaar_crontab_t usr_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t usr_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read bin and sbin directories.
#line 4487
allow cougaar_crontab_t bin_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487
allow cougaar_crontab_t sbin_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487

#line 4487
# Read directories and files with the readable_t type.
#line 4487
# This type is a general type for "world"-readable files.
#line 4487
allow cougaar_crontab_t readable_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t readable_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Stat /...security and lost+found.
#line 4487
allow cougaar_crontab_t file_labels_t:dir getattr;
#line 4487
allow cougaar_crontab_t lost_found_t:dir getattr;
#line 4487

#line 4487
# Read the devpts root directory.  
#line 4487
allow cougaar_crontab_t devpts_t:dir { read getattr lock search ioctl };
#line 4487

#line 4487

#line 4487
# Read the /tmp directory and any /tmp files with the base type.
#line 4487
# Temporary files created at runtime will typically use derived types.
#line 4487
allow cougaar_crontab_t tmp_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t tmp_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /var.
#line 4487
allow cougaar_crontab_t var_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t var_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /var/catman.
#line 4487
allow cougaar_crontab_t catman_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t catman_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /var/lib.
#line 4487
allow cougaar_crontab_t var_lib_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t var_lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487
allow cougaar_crontab_t var_lib_nfs_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t var_lib_nfs_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487

#line 4487
allow cougaar_crontab_t tetex_data_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t tetex_data_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487

#line 4487
# Read /var/yp.
#line 4487
allow cougaar_crontab_t var_yp_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t var_yp_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /var/spool.
#line 4487
allow cougaar_crontab_t var_spool_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t var_spool_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /var/run, /var/lock, /var/log.
#line 4487
allow cougaar_crontab_t var_run_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t var_run_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_crontab_t var_log_t:dir { read getattr lock search ioctl };
#line 4487
#allow cougaar_crontab_t var_log_t:{ file lnk_file } r_file_perms;
#line 4487
allow cougaar_crontab_t var_log_sa_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t var_log_sa_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_crontab_t var_log_ksyms_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
allow cougaar_crontab_t var_lock_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t var_lock_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /var/run/utmp and /var/log/wtmp.
#line 4487
allow cougaar_crontab_t initrc_var_run_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_crontab_t wtmp_t:file { read getattr lock ioctl };
#line 4487

#line 4487
# Read /boot, /boot/System.map*, and /vmlinuz*
#line 4487
allow cougaar_crontab_t boot_t:dir { search getattr };
#line 4487
allow cougaar_crontab_t boot_t:file getattr;
#line 4487
allow cougaar_crontab_t system_map_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
allow cougaar_crontab_t boot_t:lnk_file read;
#line 4487

#line 4487
# Read /etc.
#line 4487
allow cougaar_crontab_t etc_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t etc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487
allow cougaar_crontab_t etc_runtime_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_crontab_t etc_aliases_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_crontab_t etc_mail_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t etc_mail_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_crontab_t resolv_conf_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_crontab_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4487

#line 4487
# Read /lib.
#line 4487
allow cougaar_crontab_t lib_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read the linker, shared library, and executable types.
#line 4487
allow cougaar_crontab_t ld_so_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_crontab_t shlib_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_crontab_t exec_type:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read man directories and files.
#line 4487
allow cougaar_crontab_t man_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t man_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /usr/src.
#line 4487
allow cougaar_crontab_t src_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t src_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read module-related files.
#line 4487
allow cougaar_crontab_t modules_object_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t modules_object_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_crontab_t modules_dep_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_crontab_t modules_conf_t:{ file lnk_file} { read getattr lock ioctl };
#line 4487

#line 4487
# Read /dev directories and any symbolic links.
#line 4487
allow cougaar_crontab_t device_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t device_t:lnk_file { read getattr lock ioctl };
#line 4487

#line 4487
# Read /dev/random and /dev/zero.
#line 4487
allow cougaar_crontab_t random_device_t:chr_file { read getattr lock ioctl };
#line 4487
allow cougaar_crontab_t zero_device_t:chr_file { read getattr lock ioctl };
#line 4487

#line 4487
# Read the root directory of a tmpfs filesytem and any symbolic links.
#line 4487
allow cougaar_crontab_t tmpfs_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t tmpfs_t:lnk_file { read getattr lock ioctl };
#line 4487

#line 4487
# Read any symbolic links on a devfs file system.
#line 4487
allow cougaar_crontab_t device_t:lnk_file { read getattr lock ioctl };
#line 4487

#line 4487
# Read the root directory of a usbdevfs filesystem, and
#line 4487
# the devices and drivers files.  Permit stating of the
#line 4487
# device nodes, but nothing else.
#line 4487
allow cougaar_crontab_t usbdevfs_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t usbdevfs_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_crontab_t usbdevfs_device_t:file getattr;
#line 4487

#line 4487

#line 4487
# Grant write permissions to a small set of system file types.
#line 4487
# No permission to create files is granted here.  Use allow rules to grant 
#line 4487
# create permissions to a type or use file_type_auto_trans rules to set up
#line 4487
# new types for files.
#line 4487

#line 4487

#line 4487
# Read and write /dev/tty and /dev/null.
#line 4487
allow cougaar_crontab_t devtty_t:chr_file { ioctl read getattr lock write append };
#line 4487
allow cougaar_crontab_t { null_device_t zero_device_t }:chr_file { ioctl read getattr lock write append };
#line 4487

#line 4487
# Do not audit write denials to /etc/ld.so.cache.
#line 4487
dontaudit cougaar_crontab_t ld_so_cache_t:file write;
#line 4487

#line 4487

#line 4487
# Execute from the system shared libraries.
#line 4487
# No permission to execute anything else is granted here.
#line 4487
# Use can_exec or can_exec_any to grant the ability to execute within a domain.
#line 4487
# Use domain_auto_trans for executing and changing domains.
#line 4487

#line 4487
allow cougaar_crontab_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t ld_so_t:file { read getattr lock execute ioctl };
#line 4487
allow cougaar_crontab_t ld_so_t:file execute_no_trans;
#line 4487
allow cougaar_crontab_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4487
allow cougaar_crontab_t shlib_t:file { read getattr lock execute ioctl };
#line 4487
allow cougaar_crontab_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4487
allow cougaar_crontab_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_crontab_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4487

#line 4487

#line 4487
# read localization information
#line 4487
allow cougaar_crontab_t locale_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crontab_t locale_t:{file lnk_file} { read getattr lock ioctl };
#line 4487

#line 4487
# Obtain the context of any SID, the SID for any context, 
#line 4487
# and the list of active SIDs.
#line 4487
allow cougaar_crontab_t security_t:security { sid_to_context context_to_sid get_sids };
#line 4487

#line 4487

#line 4487

#line 4487
# Grant permissions needed to create TCP and UDP sockets and 
#line 4487
# to access the network.
#line 4487

#line 4487
#
#line 4487
# Allow the domain to create and use UDP and TCP sockets.
#line 4487
# Other kinds of sockets must be separately authorized for use.
#line 4487
allow cougaar_crontab_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4487
allow cougaar_crontab_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4487

#line 4487
#
#line 4487
# Allow the domain to send UDP packets.
#line 4487
# Since the destination sockets type is unknown, the generic
#line 4487
# any_socket_t type is used as a placeholder.
#line 4487
#
#line 4487
allow cougaar_crontab_t any_socket_t:udp_socket sendto;
#line 4487

#line 4487
#
#line 4487
# Allow the domain to send using any network interface.
#line 4487
# netif_type is a type attribute for all network interface types.
#line 4487
#
#line 4487
allow cougaar_crontab_t netif_type:netif { tcp_send udp_send rawip_send };
#line 4487

#line 4487
#
#line 4487
# Allow packets sent by the domain to be received on any network interface.
#line 4487
#
#line 4487
allow cougaar_crontab_t netif_type:netif { tcp_recv udp_recv rawip_recv };
#line 4487

#line 4487
#
#line 4487
# Allow the domain to receive packets from any network interface.
#line 4487
# netmsg_type is a type attribute for all default message types.
#line 4487
#
#line 4487
allow cougaar_crontab_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
#line 4487

#line 4487
#
#line 4487
# Allow the domain to initiate or accept TCP connections 
#line 4487
# on any network interface.
#line 4487
#
#line 4487
allow cougaar_crontab_t netmsg_type:tcp_socket { connectto acceptfrom };
#line 4487

#line 4487
#
#line 4487
# Receive resets from the TCP reset socket.
#line 4487
# The TCP reset socket is labeled with the tcp_socket_t type.
#line 4487
#
#line 4487
allow cougaar_crontab_t tcp_socket_t:tcp_socket recvfrom;
#line 4487

#line 4487
dontaudit cougaar_crontab_t tcp_socket_t:tcp_socket connectto;
#line 4487

#line 4487
#
#line 4487
# Allow the domain to send to any node.
#line 4487
# node_type is a type attribute for all node types.
#line 4487
#
#line 4487
allow cougaar_crontab_t node_type:node { tcp_send udp_send rawip_send };
#line 4487

#line 4487
#
#line 4487
# Allow packets sent by the domain to be received from any node.
#line 4487
#
#line 4487
allow cougaar_crontab_t node_type:node { tcp_recv udp_recv rawip_recv };
#line 4487

#line 4487
#
#line 4487
# Allow the domain to send NFS client requests via the socket
#line 4487
# created by mount.
#line 4487
#
#line 4487
allow cougaar_crontab_t mount_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4487

#line 4487
#
#line 4487
# Bind to the default port type.
#line 4487
# Other port types must be separately authorized.
#line 4487
#
#line 4487
allow cougaar_crontab_t port_t:udp_socket name_bind;
#line 4487
allow cougaar_crontab_t port_t:tcp_socket name_bind;
#line 4487

#line 4487

#line 4487

#line 4487
# Use capabilities
#line 4487
allow cougaar_crontab_t cougaar_crontab_t:capability { setuid setgid chown };
#line 4487

#line 4487
# Type for temporary files.
#line 4487

#line 4487

#line 4487

#line 4487

#line 4487
#
#line 4487
# Allow the process to modify the directory.
#line 4487
#
#line 4487
allow cougaar_crontab_t tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4487

#line 4487
#
#line 4487
# Allow the process to create the file.
#line 4487
#
#line 4487

#line 4487
allow cougaar_crontab_t cougaar_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4487
allow cougaar_crontab_t cougaar_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4487

#line 4487

#line 4487

#line 4487
type_transition cougaar_crontab_t tmp_t:dir cougaar_tmp_t;
#line 4487
type_transition cougaar_crontab_t tmp_t:{ file lnk_file sock_file fifo_file } cougaar_tmp_t;
#line 4487

#line 4487

#line 4487

#line 4487

#line 4487
# Type of user crontabs once moved to cron spool.
#line 4487
type cougaar_cron_spool_t, file_type, sysadmfile;
#line 4487
# Use the type when creating files in /var/spool/cron.
#line 4487
allow sysadm_crontab_t cougaar_cron_spool_t:file { getattr read };
#line 4487

#line 4487

#line 4487

#line 4487

#line 4487
#
#line 4487
# Allow the process to modify the directory.
#line 4487
#
#line 4487
allow cougaar_crontab_t cron_spool_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4487

#line 4487
#
#line 4487
# Allow the process to create the file.
#line 4487
#
#line 4487

#line 4487
allow cougaar_crontab_t cougaar_cron_spool_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4487
allow cougaar_crontab_t cougaar_cron_spool_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4487

#line 4487

#line 4487

#line 4487
type_transition cougaar_crontab_t cron_spool_t:dir cougaar_cron_spool_t;
#line 4487
type_transition cougaar_crontab_t cron_spool_t:{ file lnk_file sock_file fifo_file } cougaar_cron_spool_t;
#line 4487

#line 4487

#line 4487

#line 4487

#line 4487
# crontab signals crond by updating the mtime on the spooldir
#line 4487
allow cougaar_crontab_t cron_spool_t:dir setattr;
#line 4487
# Allow crond to read those crontabs in cron spool.
#line 4487
allow crond_t cougaar_cron_spool_t:file { read getattr lock ioctl };
#line 4487

#line 4487
# Run helper programs as cougaar_t
#line 4487

#line 4487

#line 4487

#line 4487
#
#line 4487
# Allow the process to transition to the new domain.
#line 4487
#
#line 4487
allow cougaar_crontab_t cougaar_t:process transition;
#line 4487

#line 4487
#
#line 4487
# Allow the process to execute the program.
#line 4487
# 
#line 4487
allow cougaar_crontab_t { bin_t sbin_t exec_type }:file { getattr execute };
#line 4487

#line 4487
#
#line 4487
# Allow the process to reap the new domain.
#line 4487
#
#line 4487
allow cougaar_t cougaar_crontab_t:process sigchld;
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to inherit and use file 
#line 4487
# descriptions from the creating process and vice versa.
#line 4487
#
#line 4487
allow cougaar_t cougaar_crontab_t:fd use;
#line 4487
allow cougaar_crontab_t cougaar_t:fd use;
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to write back to the old domain via a pipe.
#line 4487
#
#line 4487
allow cougaar_t cougaar_crontab_t:fifo_file { ioctl read getattr lock write append };
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to read and execute the program.
#line 4487
#
#line 4487
allow cougaar_t { bin_t sbin_t exec_type }:file { read getattr lock execute ioctl };
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to be entered via the program.
#line 4487
#
#line 4487
allow cougaar_t { bin_t sbin_t exec_type }:file entrypoint;
#line 4487

#line 4487
type_transition cougaar_crontab_t { bin_t sbin_t exec_type }:process cougaar_t;
#line 4487

#line 4487

#line 4487
# Read user crontabs 
#line 4487
allow cougaar_crontab_t { cougaar_home_t cougaar_home_dir_t }:dir { read getattr lock search ioctl };  
#line 4487
allow cougaar_crontab_t cougaar_home_t:file { read getattr lock ioctl };  
#line 4487
dontaudit cougaar_crontab_t cougaar_home_dir_t:dir write;
#line 4487

#line 4487
# Access the cron log file.
#line 4487
allow cougaar_crontab_t cron_log_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_crontab_t cron_log_t:file { append };
#line 4487

#line 4487
# Access terminals.
#line 4487
allow cougaar_crontab_t cougaar_tty_device_t:chr_file { ioctl read getattr lock write append };
#line 4487
allow cougaar_crontab_t cougaar_devpts_t:chr_file { ioctl read getattr lock write append };
#line 4487

#line 4487
# Inherit and use descriptors from gnome-pty-helper.
#line 4487

#line 4487

#line 4487

#line 4487

#line 4487
# Derived domain based on the calling user domain and the program.
#line 4487
type cougaar_ssh_t, domain, privlog;
#line 4487

#line 4487
# Transition from the user domain to the derived domain.
#line 4487

#line 4487

#line 4487

#line 4487
#
#line 4487
# Allow the process to transition to the new domain.
#line 4487
#
#line 4487
allow cougaar_t cougaar_ssh_t:process transition;
#line 4487

#line 4487
#
#line 4487
# Allow the process to execute the program.
#line 4487
# 
#line 4487
allow cougaar_t ssh_exec_t:file { getattr execute };
#line 4487

#line 4487
#
#line 4487
# Allow the process to reap the new domain.
#line 4487
#
#line 4487
allow cougaar_ssh_t cougaar_t:process sigchld;
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to inherit and use file 
#line 4487
# descriptions from the creating process and vice versa.
#line 4487
#
#line 4487
allow cougaar_ssh_t cougaar_t:fd use;
#line 4487
allow cougaar_t cougaar_ssh_t:fd use;
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to write back to the old domain via a pipe.
#line 4487
#
#line 4487
allow cougaar_ssh_t cougaar_t:fifo_file { ioctl read getattr lock write append };
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to read and execute the program.
#line 4487
#
#line 4487
allow cougaar_ssh_t ssh_exec_t:file { read getattr lock execute ioctl };
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to be entered via the program.
#line 4487
#
#line 4487
allow cougaar_ssh_t ssh_exec_t:file entrypoint;
#line 4487

#line 4487
type_transition cougaar_t ssh_exec_t:process cougaar_ssh_t;
#line 4487

#line 4487

#line 4487
# The user role is authorized for this domain.
#line 4487
role cougaar_r types cougaar_ssh_t;
#line 4487

#line 4487
# Grant permissions within the domain.
#line 4487

#line 4487
# Access other processes in the same domain.
#line 4487
allow cougaar_ssh_t self:process *;
#line 4487

#line 4487
# Access /proc/PID files for processes in the same domain.
#line 4487
allow cougaar_ssh_t self:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_ssh_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Access file descriptions, pipes, and sockets
#line 4487
# created by processes in the same domain.
#line 4487
allow cougaar_ssh_t self:fd *;
#line 4487
allow cougaar_ssh_t self:fifo_file { ioctl read getattr lock write append };
#line 4487
allow cougaar_ssh_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4487
allow cougaar_ssh_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4487

#line 4487
# Allow the domain to communicate with other processes in the same domain.
#line 4487
allow cougaar_ssh_t self:unix_dgram_socket sendto;
#line 4487
allow cougaar_ssh_t self:unix_stream_socket connectto;
#line 4487

#line 4487
# Access System V IPC objects created by processes in the same domain.
#line 4487
allow cougaar_ssh_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 4487
allow cougaar_ssh_t self:msg  { send receive };
#line 4487
allow cougaar_ssh_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 4487
allow cougaar_ssh_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 4487

#line 4487

#line 4487

#line 4487
# Use descriptors created by sshd
#line 4487
allow cougaar_ssh_t privfd:fd use;
#line 4487

#line 4487

#line 4487
allow cougaar_ssh_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_ssh_t ld_so_t:file { read getattr lock execute ioctl };
#line 4487
allow cougaar_ssh_t ld_so_t:file execute_no_trans;
#line 4487
allow cougaar_ssh_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4487
allow cougaar_ssh_t shlib_t:file { read getattr lock execute ioctl };
#line 4487
allow cougaar_ssh_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4487
allow cougaar_ssh_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_ssh_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4487

#line 4487

#line 4487
# read localization information
#line 4487
allow cougaar_ssh_t locale_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_ssh_t locale_t:{file lnk_file} { read getattr lock ioctl };
#line 4487

#line 4487
# Get attributes of file systems.
#line 4487
allow cougaar_ssh_t fs_type:filesystem getattr;
#line 4487

#line 4487

#line 4487
# Read /.
#line 4487
allow cougaar_ssh_t root_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_ssh_t root_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /home.
#line 4487
allow cougaar_ssh_t home_root_t:dir { read getattr lock search ioctl };
#line 4487

#line 4487
# Read /usr.
#line 4487
allow cougaar_ssh_t usr_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_ssh_t usr_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read bin and sbin directories.
#line 4487
allow cougaar_ssh_t bin_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_ssh_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487
allow cougaar_ssh_t sbin_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_ssh_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487

#line 4487
# Read the devpts root directory.
#line 4487
allow cougaar_ssh_t devpts_t:dir { read getattr lock search ioctl };
#line 4487

#line 4487
# Read /var.
#line 4487
allow cougaar_ssh_t var_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_ssh_t var_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /var/run, /var/log.
#line 4487
allow cougaar_ssh_t var_run_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_ssh_t var_run_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_ssh_t var_log_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_ssh_t var_log_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /etc.
#line 4487
allow cougaar_ssh_t etc_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_ssh_t etc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487
allow cougaar_ssh_t etc_runtime_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_ssh_t resolv_conf_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read the linker, shared library, and executable types.
#line 4487
allow cougaar_ssh_t ld_so_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_ssh_t shlib_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_ssh_t exec_type:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /dev directories and any symbolic links.
#line 4487
allow cougaar_ssh_t device_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_ssh_t device_t:lnk_file { read getattr lock ioctl };
#line 4487

#line 4487
# Read /dev/random.
#line 4487
allow cougaar_ssh_t random_device_t:chr_file { read getattr lock ioctl };
#line 4487

#line 4487
# Read and write /dev/tty and /dev/null.
#line 4487
allow cougaar_ssh_t devtty_t:chr_file { ioctl read getattr lock write append };
#line 4487
allow cougaar_ssh_t { null_device_t zero_device_t }:chr_file { ioctl read getattr lock write append };
#line 4487

#line 4487
# Grant permissions needed to create TCP and UDP sockets and
#line 4487
# to access the network.
#line 4487

#line 4487
#
#line 4487
# Allow the domain to create and use UDP and TCP sockets.
#line 4487
# Other kinds of sockets must be separately authorized for use.
#line 4487
allow cougaar_ssh_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4487
allow cougaar_ssh_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4487

#line 4487
#
#line 4487
# Allow the domain to send UDP packets.
#line 4487
# Since the destination sockets type is unknown, the generic
#line 4487
# any_socket_t type is used as a placeholder.
#line 4487
#
#line 4487
allow cougaar_ssh_t any_socket_t:udp_socket sendto;
#line 4487

#line 4487
#
#line 4487
# Allow the domain to send using any network interface.
#line 4487
# netif_type is a type attribute for all network interface types.
#line 4487
#
#line 4487
allow cougaar_ssh_t netif_type:netif { tcp_send udp_send rawip_send };
#line 4487

#line 4487
#
#line 4487
# Allow packets sent by the domain to be received on any network interface.
#line 4487
#
#line 4487
allow cougaar_ssh_t netif_type:netif { tcp_recv udp_recv rawip_recv };
#line 4487

#line 4487
#
#line 4487
# Allow the domain to receive packets from any network interface.
#line 4487
# netmsg_type is a type attribute for all default message types.
#line 4487
#
#line 4487
allow cougaar_ssh_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
#line 4487

#line 4487
#
#line 4487
# Allow the domain to initiate or accept TCP connections 
#line 4487
# on any network interface.
#line 4487
#
#line 4487
allow cougaar_ssh_t netmsg_type:tcp_socket { connectto acceptfrom };
#line 4487

#line 4487
#
#line 4487
# Receive resets from the TCP reset socket.
#line 4487
# The TCP reset socket is labeled with the tcp_socket_t type.
#line 4487
#
#line 4487
allow cougaar_ssh_t tcp_socket_t:tcp_socket recvfrom;
#line 4487

#line 4487
dontaudit cougaar_ssh_t tcp_socket_t:tcp_socket connectto;
#line 4487

#line 4487
#
#line 4487
# Allow the domain to send to any node.
#line 4487
# node_type is a type attribute for all node types.
#line 4487
#
#line 4487
allow cougaar_ssh_t node_type:node { tcp_send udp_send rawip_send };
#line 4487

#line 4487
#
#line 4487
# Allow packets sent by the domain to be received from any node.
#line 4487
#
#line 4487
allow cougaar_ssh_t node_type:node { tcp_recv udp_recv rawip_recv };
#line 4487

#line 4487
#
#line 4487
# Allow the domain to send NFS client requests via the socket
#line 4487
# created by mount.
#line 4487
#
#line 4487
allow cougaar_ssh_t mount_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4487

#line 4487
#
#line 4487
# Bind to the default port type.
#line 4487
# Other port types must be separately authorized.
#line 4487
#
#line 4487
allow cougaar_ssh_t port_t:udp_socket name_bind;
#line 4487
allow cougaar_ssh_t port_t:tcp_socket name_bind;
#line 4487

#line 4487

#line 4487
# for sshing to a ssh tunnel
#line 4487

#line 4487
allow cougaar_ssh_t cougaar_ssh_t:tcp_socket { connectto recvfrom };
#line 4487
allow cougaar_ssh_t cougaar_ssh_t:tcp_socket { acceptfrom recvfrom };
#line 4487
allow cougaar_ssh_t tcp_socket_t:tcp_socket { recvfrom };
#line 4487
allow cougaar_ssh_t tcp_socket_t:tcp_socket { recvfrom };
#line 4487

#line 4487

#line 4487
# Use capabilities.
#line 4487
allow cougaar_ssh_t self:capability { setuid setgid dac_override dac_read_search };
#line 4487

#line 4487
# Run helpers.
#line 4487

#line 4487
allow cougaar_ssh_t { bin_t sbin_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_ssh_t { bin_t sbin_t }:lnk_file read;
#line 4487

#line 4487
allow cougaar_ssh_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_ssh_t ld_so_t:file { read getattr lock execute ioctl };
#line 4487
allow cougaar_ssh_t ld_so_t:file execute_no_trans;
#line 4487
allow cougaar_ssh_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4487
allow cougaar_ssh_t shlib_t:file { read getattr lock execute ioctl };
#line 4487
allow cougaar_ssh_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4487
allow cougaar_ssh_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_ssh_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4487

#line 4487

#line 4487
allow cougaar_ssh_t etc_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4487

#line 4487

#line 4487
allow cougaar_ssh_t lib_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4487

#line 4487

#line 4487
allow cougaar_ssh_t bin_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4487

#line 4487

#line 4487
allow cougaar_ssh_t sbin_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4487

#line 4487

#line 4487
allow cougaar_ssh_t exec_type:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4487

#line 4487

#line 4487

#line 4487
# Read the ssh key file.
#line 4487
allow cougaar_ssh_t sshd_key_t:file { read getattr lock ioctl };
#line 4487

#line 4487
# Access the ssh temporary files.
#line 4487

#line 4487

#line 4487

#line 4487

#line 4487
#
#line 4487
# Allow the process to modify the directory.
#line 4487
#
#line 4487
allow cougaar_ssh_t tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4487

#line 4487
#
#line 4487
# Allow the process to create the file.
#line 4487
#
#line 4487

#line 4487
allow cougaar_ssh_t sshd_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4487
allow cougaar_ssh_t sshd_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4487

#line 4487

#line 4487

#line 4487
type_transition cougaar_ssh_t tmp_t:dir sshd_tmp_t;
#line 4487
type_transition cougaar_ssh_t tmp_t:{ file lnk_file sock_file fifo_file } sshd_tmp_t;
#line 4487

#line 4487

#line 4487

#line 4487
allow cougaar_ssh_t cougaar_tmp_t:dir { read getattr lock search ioctl };
#line 4487

#line 4487
# for rsync
#line 4487
allow cougaar_ssh_t cougaar_t:unix_stream_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4487

#line 4487
# Access the users .ssh directory.
#line 4487
type cougaar_home_ssh_t, file_type, sysadmfile;
#line 4487

#line 4487

#line 4487

#line 4487

#line 4487
#
#line 4487
# Allow the process to modify the directory.
#line 4487
#
#line 4487
allow { sysadm_ssh_t cougaar_ssh_t } cougaar_home_dir_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4487

#line 4487
#
#line 4487
# Allow the process to create the file.
#line 4487
#
#line 4487

#line 4487
allow { sysadm_ssh_t cougaar_ssh_t } cougaar_home_ssh_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4487
allow { sysadm_ssh_t cougaar_ssh_t } cougaar_home_ssh_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4487

#line 4487

#line 4487

#line 4487
type_transition { sysadm_ssh_t cougaar_ssh_t } cougaar_home_dir_t:dir cougaar_home_ssh_t;
#line 4487
type_transition { sysadm_ssh_t cougaar_ssh_t } cougaar_home_dir_t:{ file lnk_file sock_file fifo_file } cougaar_home_ssh_t;
#line 4487

#line 4487

#line 4487

#line 4487
allow { sysadm_ssh_t cougaar_ssh_t } cougaar_home_ssh_t:lnk_file { getattr read };
#line 4487
dontaudit cougaar_ssh_t cougaar_home_t:dir search;
#line 4487

#line 4487
allow sshd_t cougaar_home_ssh_t:dir { read getattr lock search ioctl };
#line 4487
allow sshd_t cougaar_home_ssh_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487

#line 4487
allow cougaar_t cougaar_home_ssh_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4487
allow cougaar_t cougaar_home_ssh_t:{ file lnk_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4487

#line 4487

#line 4487
# Inherit and use descriptors from gnome-pty-helper.
#line 4487

#line 4487

#line 4487
# Connect to sshd.
#line 4487

#line 4487
allow cougaar_ssh_t sshd_t:tcp_socket { connectto recvfrom };
#line 4487
allow sshd_t cougaar_ssh_t:tcp_socket { acceptfrom recvfrom };
#line 4487
allow sshd_t tcp_socket_t:tcp_socket { recvfrom };
#line 4487
allow cougaar_ssh_t tcp_socket_t:tcp_socket { recvfrom };
#line 4487

#line 4487

#line 4487
# Write to the user domain tty.
#line 4487
allow cougaar_ssh_t cougaar_tty_device_t:chr_file { ioctl read getattr lock write append };
#line 4487
allow cougaar_ssh_t cougaar_devpts_t:chr_file { ioctl read getattr lock write append };
#line 4487

#line 4487
# Allow the user shell to signal the ssh program.
#line 4487
allow cougaar_t cougaar_ssh_t:process signal;
#line 4487
# allow ps to show ssh
#line 4487
allow cougaar_t cougaar_ssh_t:dir { search getattr read };
#line 4487
allow cougaar_t cougaar_ssh_t:{ file lnk_file } { read getattr };
#line 4487

#line 4487
# Allow the ssh program to communicate with ssh-agent.
#line 4487
allow cougaar_ssh_t cougaar_tmp_t:sock_file write;
#line 4487
allow cougaar_ssh_t cougaar_t:unix_stream_socket connectto;
#line 4487
allow cougaar_ssh_t sshd_t:unix_stream_socket connectto;
#line 4487

#line 4487

#line 4487

#line 4487

#line 4487

#line 4487

#line 4487

#line 4487

#line 4487

#line 4487

#line 4487
# Instantiate a derived domain for user cron jobs.
#line 4487

#line 4487
# Derived domain for user cron jobs, user user_crond_domain if not system
#line 4487

#line 4487
type cougaar_crond_t, domain, user_crond_domain;
#line 4487

#line 4487

#line 4487
# Permit a transition from the crond_t domain to this domain.
#line 4487
# The transition is requested explicitly by the modified crond 
#line 4487
# via execve_secure.  There is no way to set up an automatic
#line 4487
# transition, since crontabs are configuration files, not executables.
#line 4487

#line 4487

#line 4487
#
#line 4487
# Allow the process to transition to the new domain.
#line 4487
#
#line 4487
allow crond_t cougaar_crond_t:process transition;
#line 4487

#line 4487
#
#line 4487
# Allow the process to execute the program.
#line 4487
# 
#line 4487
allow crond_t shell_exec_t:file { getattr execute };
#line 4487

#line 4487
#
#line 4487
# Allow the process to reap the new domain.
#line 4487
#
#line 4487
allow cougaar_crond_t crond_t:process sigchld;
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to inherit and use file 
#line 4487
# descriptions from the creating process and vice versa.
#line 4487
#
#line 4487
allow cougaar_crond_t crond_t:fd use;
#line 4487
allow crond_t cougaar_crond_t:fd use;
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to write back to the old domain via a pipe.
#line 4487
#
#line 4487
allow cougaar_crond_t crond_t:fifo_file { ioctl read getattr lock write append };
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to read and execute the program.
#line 4487
#
#line 4487
allow cougaar_crond_t shell_exec_t:file { read getattr lock execute ioctl };
#line 4487

#line 4487
#
#line 4487
# Allow the new domain to be entered via the program.
#line 4487
#
#line 4487
allow cougaar_crond_t shell_exec_t:file entrypoint;
#line 4487

#line 4487

#line 4487

#line 4487

#line 4487
# The user role is authorized for this domain.
#line 4487
role cougaar_r types cougaar_crond_t;
#line 4487

#line 4487
# This domain is granted permissions common to most domains.
#line 4487

#line 4487

#line 4487
# Grant the permissions common to the test domains.
#line 4487

#line 4487
# Grant permissions within the domain.
#line 4487

#line 4487
# Access other processes in the same domain.
#line 4487
allow cougaar_crond_t self:process *;
#line 4487

#line 4487
# Access /proc/PID files for processes in the same domain.
#line 4487
allow cougaar_crond_t self:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Access file descriptions, pipes, and sockets
#line 4487
# created by processes in the same domain.
#line 4487
allow cougaar_crond_t self:fd *;
#line 4487
allow cougaar_crond_t self:fifo_file { ioctl read getattr lock write append };
#line 4487
allow cougaar_crond_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4487
allow cougaar_crond_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4487

#line 4487
# Allow the domain to communicate with other processes in the same domain.
#line 4487
allow cougaar_crond_t self:unix_dgram_socket sendto;
#line 4487
allow cougaar_crond_t self:unix_stream_socket connectto;
#line 4487

#line 4487
# Access System V IPC objects created by processes in the same domain.
#line 4487
allow cougaar_crond_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 4487
allow cougaar_crond_t self:msg  { send receive };
#line 4487
allow cougaar_crond_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 4487
allow cougaar_crond_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 4487

#line 4487

#line 4487

#line 4487
# Grant read/search permissions to most of /proc.
#line 4487

#line 4487
# Read system information files in /proc.
#line 4487
allow cougaar_crond_t proc_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t proc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Stat /proc/kmsg and /proc/kcore.
#line 4487
allow cougaar_crond_t proc_kmsg_t:file { getattr };
#line 4487
allow cougaar_crond_t proc_kcore_t:file { getattr };
#line 4487

#line 4487
# Read system variables in /proc/sys.
#line 4487
allow cougaar_crond_t sysctl_modprobe_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_crond_t sysctl_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_crond_t sysctl_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t sysctl_fs_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_crond_t sysctl_fs_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t sysctl_kernel_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_crond_t sysctl_kernel_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t sysctl_net_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_crond_t sysctl_net_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t sysctl_vm_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_crond_t sysctl_vm_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t sysctl_dev_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_crond_t sysctl_dev_t:dir { read getattr lock search ioctl };
#line 4487

#line 4487

#line 4487
# Grant read/search permissions to many system file types.
#line 4487

#line 4487

#line 4487
# Get attributes of file systems.
#line 4487
allow cougaar_crond_t fs_type:filesystem getattr;
#line 4487

#line 4487

#line 4487
# Read /.
#line 4487
allow cougaar_crond_t root_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t root_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /home.
#line 4487
allow cougaar_crond_t home_root_t:dir { read getattr lock search ioctl };
#line 4487

#line 4487
# Read /usr.
#line 4487
allow cougaar_crond_t usr_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t usr_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read bin and sbin directories.
#line 4487
allow cougaar_crond_t bin_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487
allow cougaar_crond_t sbin_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487

#line 4487
# Read directories and files with the readable_t type.
#line 4487
# This type is a general type for "world"-readable files.
#line 4487
allow cougaar_crond_t readable_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t readable_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Stat /...security and lost+found.
#line 4487
allow cougaar_crond_t file_labels_t:dir getattr;
#line 4487
allow cougaar_crond_t lost_found_t:dir getattr;
#line 4487

#line 4487
# Read the devpts root directory.  
#line 4487
allow cougaar_crond_t devpts_t:dir { read getattr lock search ioctl };
#line 4487

#line 4487

#line 4487
# Read the /tmp directory and any /tmp files with the base type.
#line 4487
# Temporary files created at runtime will typically use derived types.
#line 4487
allow cougaar_crond_t tmp_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t tmp_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /var.
#line 4487
allow cougaar_crond_t var_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t var_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /var/catman.
#line 4487
allow cougaar_crond_t catman_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t catman_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /var/lib.
#line 4487
allow cougaar_crond_t var_lib_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t var_lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487
allow cougaar_crond_t var_lib_nfs_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t var_lib_nfs_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487

#line 4487
allow cougaar_crond_t tetex_data_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t tetex_data_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487

#line 4487
# Read /var/yp.
#line 4487
allow cougaar_crond_t var_yp_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t var_yp_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /var/spool.
#line 4487
allow cougaar_crond_t var_spool_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t var_spool_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /var/run, /var/lock, /var/log.
#line 4487
allow cougaar_crond_t var_run_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t var_run_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_crond_t var_log_t:dir { read getattr lock search ioctl };
#line 4487
#allow cougaar_crond_t var_log_t:{ file lnk_file } r_file_perms;
#line 4487
allow cougaar_crond_t var_log_sa_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t var_log_sa_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_crond_t var_log_ksyms_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
allow cougaar_crond_t var_lock_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t var_lock_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /var/run/utmp and /var/log/wtmp.
#line 4487
allow cougaar_crond_t initrc_var_run_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_crond_t wtmp_t:file { read getattr lock ioctl };
#line 4487

#line 4487
# Read /boot, /boot/System.map*, and /vmlinuz*
#line 4487
allow cougaar_crond_t boot_t:dir { search getattr };
#line 4487
allow cougaar_crond_t boot_t:file getattr;
#line 4487
allow cougaar_crond_t system_map_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
allow cougaar_crond_t boot_t:lnk_file read;
#line 4487

#line 4487
# Read /etc.
#line 4487
allow cougaar_crond_t etc_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t etc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487
allow cougaar_crond_t etc_runtime_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_crond_t etc_aliases_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_crond_t etc_mail_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t etc_mail_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_crond_t resolv_conf_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_crond_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4487

#line 4487
# Read /lib.
#line 4487
allow cougaar_crond_t lib_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read the linker, shared library, and executable types.
#line 4487
allow cougaar_crond_t ld_so_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_crond_t shlib_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_crond_t exec_type:{ file lnk_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read man directories and files.
#line 4487
allow cougaar_crond_t man_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t man_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read /usr/src.
#line 4487
allow cougaar_crond_t src_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t src_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Read module-related files.
#line 4487
allow cougaar_crond_t modules_object_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t modules_object_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_crond_t modules_dep_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_crond_t modules_conf_t:{ file lnk_file} { read getattr lock ioctl };
#line 4487

#line 4487
# Read /dev directories and any symbolic links.
#line 4487
allow cougaar_crond_t device_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t device_t:lnk_file { read getattr lock ioctl };
#line 4487

#line 4487
# Read /dev/random and /dev/zero.
#line 4487
allow cougaar_crond_t random_device_t:chr_file { read getattr lock ioctl };
#line 4487
allow cougaar_crond_t zero_device_t:chr_file { read getattr lock ioctl };
#line 4487

#line 4487
# Read the root directory of a tmpfs filesytem and any symbolic links.
#line 4487
allow cougaar_crond_t tmpfs_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t tmpfs_t:lnk_file { read getattr lock ioctl };
#line 4487

#line 4487
# Read any symbolic links on a devfs file system.
#line 4487
allow cougaar_crond_t device_t:lnk_file { read getattr lock ioctl };
#line 4487

#line 4487
# Read the root directory of a usbdevfs filesystem, and
#line 4487
# the devices and drivers files.  Permit stating of the
#line 4487
# device nodes, but nothing else.
#line 4487
allow cougaar_crond_t usbdevfs_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t usbdevfs_t:{ file lnk_file } { read getattr lock ioctl };
#line 4487
allow cougaar_crond_t usbdevfs_device_t:file getattr;
#line 4487

#line 4487

#line 4487
# Grant write permissions to a small set of system file types.
#line 4487
# No permission to create files is granted here.  Use allow rules to grant 
#line 4487
# create permissions to a type or use file_type_auto_trans rules to set up
#line 4487
# new types for files.
#line 4487

#line 4487

#line 4487
# Read and write /dev/tty and /dev/null.
#line 4487
allow cougaar_crond_t devtty_t:chr_file { ioctl read getattr lock write append };
#line 4487
allow cougaar_crond_t { null_device_t zero_device_t }:chr_file { ioctl read getattr lock write append };
#line 4487

#line 4487
# Do not audit write denials to /etc/ld.so.cache.
#line 4487
dontaudit cougaar_crond_t ld_so_cache_t:file write;
#line 4487

#line 4487

#line 4487
# Execute from the system shared libraries.
#line 4487
# No permission to execute anything else is granted here.
#line 4487
# Use can_exec or can_exec_any to grant the ability to execute within a domain.
#line 4487
# Use domain_auto_trans for executing and changing domains.
#line 4487

#line 4487
allow cougaar_crond_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t ld_so_t:file { read getattr lock execute ioctl };
#line 4487
allow cougaar_crond_t ld_so_t:file execute_no_trans;
#line 4487
allow cougaar_crond_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4487
allow cougaar_crond_t shlib_t:file { read getattr lock execute ioctl };
#line 4487
allow cougaar_crond_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4487
allow cougaar_crond_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_crond_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4487

#line 4487

#line 4487
# read localization information
#line 4487
allow cougaar_crond_t locale_t:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t locale_t:{file lnk_file} { read getattr lock ioctl };
#line 4487

#line 4487
# Obtain the context of any SID, the SID for any context, 
#line 4487
# and the list of active SIDs.
#line 4487
allow cougaar_crond_t security_t:security { sid_to_context context_to_sid get_sids };
#line 4487

#line 4487

#line 4487

#line 4487
# Grant permissions needed to create TCP and UDP sockets and 
#line 4487
# to access the network.
#line 4487

#line 4487
#
#line 4487
# Allow the domain to create and use UDP and TCP sockets.
#line 4487
# Other kinds of sockets must be separately authorized for use.
#line 4487
allow cougaar_crond_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4487
allow cougaar_crond_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4487

#line 4487
#
#line 4487
# Allow the domain to send UDP packets.
#line 4487
# Since the destination sockets type is unknown, the generic
#line 4487
# any_socket_t type is used as a placeholder.
#line 4487
#
#line 4487
allow cougaar_crond_t any_socket_t:udp_socket sendto;
#line 4487

#line 4487
#
#line 4487
# Allow the domain to send using any network interface.
#line 4487
# netif_type is a type attribute for all network interface types.
#line 4487
#
#line 4487
allow cougaar_crond_t netif_type:netif { tcp_send udp_send rawip_send };
#line 4487

#line 4487
#
#line 4487
# Allow packets sent by the domain to be received on any network interface.
#line 4487
#
#line 4487
allow cougaar_crond_t netif_type:netif { tcp_recv udp_recv rawip_recv };
#line 4487

#line 4487
#
#line 4487
# Allow the domain to receive packets from any network interface.
#line 4487
# netmsg_type is a type attribute for all default message types.
#line 4487
#
#line 4487
allow cougaar_crond_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
#line 4487

#line 4487
#
#line 4487
# Allow the domain to initiate or accept TCP connections 
#line 4487
# on any network interface.
#line 4487
#
#line 4487
allow cougaar_crond_t netmsg_type:tcp_socket { connectto acceptfrom };
#line 4487

#line 4487
#
#line 4487
# Receive resets from the TCP reset socket.
#line 4487
# The TCP reset socket is labeled with the tcp_socket_t type.
#line 4487
#
#line 4487
allow cougaar_crond_t tcp_socket_t:tcp_socket recvfrom;
#line 4487

#line 4487
dontaudit cougaar_crond_t tcp_socket_t:tcp_socket connectto;
#line 4487

#line 4487
#
#line 4487
# Allow the domain to send to any node.
#line 4487
# node_type is a type attribute for all node types.
#line 4487
#
#line 4487
allow cougaar_crond_t node_type:node { tcp_send udp_send rawip_send };
#line 4487

#line 4487
#
#line 4487
# Allow packets sent by the domain to be received from any node.
#line 4487
#
#line 4487
allow cougaar_crond_t node_type:node { tcp_recv udp_recv rawip_recv };
#line 4487

#line 4487
#
#line 4487
# Allow the domain to send NFS client requests via the socket
#line 4487
# created by mount.
#line 4487
#
#line 4487
allow cougaar_crond_t mount_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4487

#line 4487
#
#line 4487
# Bind to the default port type.
#line 4487
# Other port types must be separately authorized.
#line 4487
#
#line 4487
allow cougaar_crond_t port_t:udp_socket name_bind;
#line 4487
allow cougaar_crond_t port_t:tcp_socket name_bind;
#line 4487

#line 4487

#line 4487

#line 4487
# Use capabilities.
#line 4487
allow cougaar_crond_t cougaar_crond_t:capability dac_override;
#line 4487

#line 4487
# Inherit and use descriptors from initrc.
#line 4487
allow cougaar_crond_t initrc_t:fd use;
#line 4487

#line 4487
# 
#line 4487
# Since crontab files are not directly executed,
#line 4487
# crond must ensure that the crontab file has
#line 4487
# a type that is appropriate for the domain of
#line 4487
# the user cron job.  It performs an entrypoint
#line 4487
# permission check for this purpose.
#line 4487
#
#line 4487
allow cougaar_crond_t cougaar_cron_spool_t:file entrypoint;
#line 4487

#line 4487
# Access user files and dirs.
#line 4487

#line 4487

#line 4487

#line 4487

#line 4487
#
#line 4487
# Allow the process to modify the directory.
#line 4487
#
#line 4487
allow cougaar_crond_t cougaar_home_dir_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4487

#line 4487
#
#line 4487
# Allow the process to create the file.
#line 4487
#
#line 4487

#line 4487
allow cougaar_crond_t cougaar_home_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4487
allow cougaar_crond_t cougaar_home_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4487

#line 4487

#line 4487

#line 4487
type_transition cougaar_crond_t cougaar_home_dir_t:dir cougaar_home_t;
#line 4487
type_transition cougaar_crond_t cougaar_home_dir_t:{ file lnk_file sock_file fifo_file } cougaar_home_t;
#line 4487

#line 4487

#line 4487

#line 4487

#line 4487

#line 4487

#line 4487

#line 4487

#line 4487
#
#line 4487
# Allow the process to modify the directory.
#line 4487
#
#line 4487
allow cougaar_crond_t tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4487

#line 4487
#
#line 4487
# Allow the process to create the file.
#line 4487
#
#line 4487

#line 4487
allow cougaar_crond_t cougaar_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4487
allow cougaar_crond_t cougaar_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4487

#line 4487

#line 4487

#line 4487
type_transition cougaar_crond_t tmp_t:dir cougaar_tmp_t;
#line 4487
type_transition cougaar_crond_t tmp_t:{ file lnk_file sock_file fifo_file } cougaar_tmp_t;
#line 4487

#line 4487

#line 4487

#line 4487

#line 4487
# Run helper programs.
#line 4487

#line 4487
allow cougaar_crond_t { bin_t sbin_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t { bin_t sbin_t }:lnk_file read;
#line 4487

#line 4487
allow cougaar_crond_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4487
allow cougaar_crond_t ld_so_t:file { read getattr lock execute ioctl };
#line 4487
allow cougaar_crond_t ld_so_t:file execute_no_trans;
#line 4487
allow cougaar_crond_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4487
allow cougaar_crond_t shlib_t:file { read getattr lock execute ioctl };
#line 4487
allow cougaar_crond_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4487
allow cougaar_crond_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4487
allow cougaar_crond_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4487

#line 4487

#line 4487
allow cougaar_crond_t etc_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4487

#line 4487

#line 4487
allow cougaar_crond_t lib_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4487

#line 4487

#line 4487
allow cougaar_crond_t bin_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4487

#line 4487

#line 4487
allow cougaar_crond_t sbin_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4487

#line 4487

#line 4487
allow cougaar_crond_t exec_type:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4487

#line 4487

#line 4487

#line 4487
# Run scripts in user home directory.
#line 4487

#line 4487
allow cougaar_crond_t cougaar_home_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4487

#line 4487

#line 4487

#line 4487

#line 4487

#line 4487
# Read the mouse.
#line 4487
allow cougaar_t mouse_device_t:chr_file { read getattr lock ioctl };
#line 4487
# Access other miscellaneous devices.
#line 4487
allow cougaar_t misc_device_t:{ file lnk_file sock_file fifo_file chr_file blk_file } { ioctl read getattr lock write append };
#line 4487

#line 4487
# Use the network.
#line 4487

#line 4487
#
#line 4487
# Allow the domain to create and use UDP and TCP sockets.
#line 4487
# Other kinds of sockets must be separately authorized for use.
#line 4487
allow cougaar_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4487
allow cougaar_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4487

#line 4487
#
#line 4487
# Allow the domain to send UDP packets.
#line 4487
# Since the destination sockets type is unknown, the generic
#line 4487
# any_socket_t type is used as a placeholder.
#line 4487
#
#line 4487
allow cougaar_t any_socket_t:udp_socket sendto;
#line 4487

#line 4487
#
#line 4487
# Allow the domain to send using any network interface.
#line 4487
# netif_type is a type attribute for all network interface types.
#line 4487
#
#line 4487
allow cougaar_t netif_type:netif { tcp_send udp_send rawip_send };
#line 4487

#line 4487
#
#line 4487
# Allow packets sent by the domain to be received on any network interface.
#line 4487
#
#line 4487
allow cougaar_t netif_type:netif { tcp_recv udp_recv rawip_recv };
#line 4487

#line 4487
#
#line 4487
# Allow the domain to receive packets from any network interface.
#line 4487
# netmsg_type is a type attribute for all default message types.
#line 4487
#
#line 4487
allow cougaar_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
#line 4487

#line 4487
#
#line 4487
# Allow the domain to initiate or accept TCP connections 
#line 4487
# on any network interface.
#line 4487
#
#line 4487
allow cougaar_t netmsg_type:tcp_socket { connectto acceptfrom };
#line 4487

#line 4487
#
#line 4487
# Receive resets from the TCP reset socket.
#line 4487
# The TCP reset socket is labeled with the tcp_socket_t type.
#line 4487
#
#line 4487
allow cougaar_t tcp_socket_t:tcp_socket recvfrom;
#line 4487

#line 4487
dontaudit cougaar_t tcp_socket_t:tcp_socket connectto;
#line 4487

#line 4487
#
#line 4487
# Allow the domain to send to any node.
#line 4487
# node_type is a type attribute for all node types.
#line 4487
#
#line 4487
allow cougaar_t node_type:node { tcp_send udp_send rawip_send };
#line 4487

#line 4487
#
#line 4487
# Allow packets sent by the domain to be received from any node.
#line 4487
#
#line 4487
allow cougaar_t node_type:node { tcp_recv udp_recv rawip_recv };
#line 4487

#line 4487
#
#line 4487
# Allow the domain to send NFS client requests via the socket
#line 4487
# created by mount.
#line 4487
#
#line 4487
allow cougaar_t mount_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4487

#line 4487
#
#line 4487
# Bind to the default port type.
#line 4487
# Other port types must be separately authorized.
#line 4487
#
#line 4487
allow cougaar_t port_t:udp_socket name_bind;
#line 4487
allow cougaar_t port_t:tcp_socket name_bind;
#line 4487

#line 4487

#line 4487
#
#line 4487
# connect_secure and sendmsg_secure calls with a 
#line 4487
# peer or destination socket SID can be enforced
#line 4487
# when using the loopback interface.  Enforcement
#line 4487
# for real network interfaces will be possible when
#line 4487
# a packet labeling mechanism is integrated.
#line 4487
#
#line 4487
allow cougaar_t node_lo_t:node enforce_dest;
#line 4487

#line 4487
# Communicate within the domain.
#line 4487

#line 4487
allow cougaar_t cougaar_t:udp_socket { sendto };
#line 4487
allow cougaar_t cougaar_t:udp_socket { recvfrom };
#line 4487

#line 4487

#line 4487
allow cougaar_t cougaar_t:tcp_socket { connectto recvfrom };
#line 4487
allow cougaar_t cougaar_t:tcp_socket { acceptfrom recvfrom };
#line 4487
allow cougaar_t tcp_socket_t:tcp_socket { recvfrom };
#line 4487
allow cougaar_t tcp_socket_t:tcp_socket { recvfrom };
#line 4487

#line 4487

#line 4487
# Connect to inetd.
#line 4487

#line 4487

#line 4487

#line 4487

#line 4487
# Connect data port to ftpd.
#line 4487

#line 4487

#line 4487
# Connect to portmap.
#line 4487

#line 4487

#line 4487
# Inherit and use sockets from inetd
#line 4487

#line 4487

#line 4487
# Allow system log read
#line 4487
#allow cougaar_t kernel_t:system syslog_read;
#line 4487
# else do not log it
#line 4487
dontaudit cougaar_t kernel_t:system syslog_read;
#line 4487

#line 4487
# Very permissive allowing every domain to see every type.
#line 4487
allow cougaar_t kernel_t:system { ipc_info };
#line 4487

#line 4487
# When the user domain runs ps, there will be a number of access
#line 4487
# denials when ps tries to search /proc.  Do not audit these denials.
#line 4487
dontaudit cougaar_t domain:dir { read getattr lock search ioctl };
#line 4487
dontaudit cougaar_t domain:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4487

#line 4487
# Some shells ask for w access to utmp, but will operate
#line 4487
# correctly without it.  Do not audit write denials to utmp.
#line 4487
dontaudit cougaar_t initrc_var_run_t:file { getattr read write };
#line 4487

#line 4487
# do not audit getattr on tmpfile, otherwise ls -l /tmp fills the logs
#line 4487
dontaudit cougaar_t tmpfile:{ dir file lnk_file sock_file fifo_file chr_file blk_file } getattr;
#line 4487

#line 4487
# do not audit getattr on disk devices, otherwise KDE fills the logs
#line 4487
dontaudit cougaar_t { removable_device_t fixed_disk_device_t }:blk_file getattr;
#line 4487

#line 4487

#line 4487
# Access the sound device.
#line 4487
allow cougaar_t sound_device_t:chr_file { getattr read write ioctl };
#line 4487

#line 4487
# Allow reading dpkg origins file
#line 4487

#line 4487

#line 4487

#line 4487

#line 4487

#line 4487

#line 4487
# When an ordinary user domain runs su, su may try to
#line 4487
# update the /root/.Xauthority file, and the user shell may
#line 4487
# try to update the shell history. This isnt allowed, but 
#line 4487
# we dont need to audit it.
#line 4487

#line 4487
dontaudit cougaar_su_t sysadm_home_t:dir  { read getattr search write add_name remove_name };
#line 4487
dontaudit cougaar_su_t sysadm_home_t:file { read getattr create write link unlink };
#line 4487
dontaudit cougaar_t    sysadm_home_t:dir { read search getattr };
#line 4487
dontaudit cougaar_t    sysadm_home_t:file { read getattr append };
#line 4487

#line 4487

#line 4487
# Some programs that are left in cougaar_t will try to connect
#line 4487
# to syslogd, but we do not want to let them generate log messages.
#line 4487
# Do not audit.
#line 4487
dontaudit cougaar_t devlog_t:sock_file { read write };
#line 4487
dontaudit cougaar_t syslogd_t:unix_dgram_socket sendto;
#line 4487

#line 4487

#line 4487
# stop warnings about "ls -l" on directories with unlabelled files
#line 4487
dontaudit cougaar_t file_t:{ dir file lnk_file } getattr;
#line 4487

allow system_r cougaar_r;
allow sysadm_r cougaar_r;
allow user_r cougaar_r;

allow user_t var_log_t:dir { getattr read };
allow user_t var_spool_t:file { execute };
allow user_t sysadm_home_dir_t:dir { add_name read remove_name write };
allow user_t sysadm_home_dir_t:file { create getattr link read unlink write };
allow user_t user_t:capability { sys_tty_config kill };

# added to run society with acme
allow user_t sysadm_home_dir_t:file { setattr };
allow user_xauth_t sshd_t:unix_stream_socket { read write };
allow user_xauth_t sysadm_home_dir_t:dir { add_name remove_name search write };
allow user_xauth_t sysadm_home_dir_t:file { create getattr link read unlink write };


#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
#

#################################
#
# Rules for the kernel_t domain.
#

#
# kernel_t is the domain of kernel threads.
# It is also the target type when checking permissions in the system class.
# 
type kernel_t, domain;
role system_r types kernel_t;

#line 4520
# Access other processes in the same domain.
#line 4520
allow kernel_t self:process *;
#line 4520

#line 4520
# Access /proc/PID files for processes in the same domain.
#line 4520
allow kernel_t self:dir { read getattr lock search ioctl };
#line 4520
allow kernel_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4520

#line 4520
# Access file descriptions, pipes, and sockets
#line 4520
# created by processes in the same domain.
#line 4520
allow kernel_t self:fd *;
#line 4520
allow kernel_t self:fifo_file { ioctl read getattr lock write append };
#line 4520
allow kernel_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4520
allow kernel_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4520

#line 4520
# Allow the domain to communicate with other processes in the same domain.
#line 4520
allow kernel_t self:unix_dgram_socket sendto;
#line 4520
allow kernel_t self:unix_stream_socket connectto;
#line 4520

#line 4520
# Access System V IPC objects created by processes in the same domain.
#line 4520
allow kernel_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 4520
allow kernel_t self:msg  { send receive };
#line 4520
allow kernel_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 4520
allow kernel_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 4520

#line 4520


#line 4521
# Read system information files in /proc.
#line 4521
allow kernel_t proc_t:dir { read getattr lock search ioctl };
#line 4521
allow kernel_t proc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4521

#line 4521
# Stat /proc/kmsg and /proc/kcore.
#line 4521
allow kernel_t proc_kmsg_t:file { getattr };
#line 4521
allow kernel_t proc_kcore_t:file { getattr };
#line 4521

#line 4521
# Read system variables in /proc/sys.
#line 4521
allow kernel_t sysctl_modprobe_t:file { read getattr lock ioctl };
#line 4521
allow kernel_t sysctl_t:file { read getattr lock ioctl };
#line 4521
allow kernel_t sysctl_t:dir { read getattr lock search ioctl };
#line 4521
allow kernel_t sysctl_fs_t:file { read getattr lock ioctl };
#line 4521
allow kernel_t sysctl_fs_t:dir { read getattr lock search ioctl };
#line 4521
allow kernel_t sysctl_kernel_t:file { read getattr lock ioctl };
#line 4521
allow kernel_t sysctl_kernel_t:dir { read getattr lock search ioctl };
#line 4521
allow kernel_t sysctl_net_t:file { read getattr lock ioctl };
#line 4521
allow kernel_t sysctl_net_t:dir { read getattr lock search ioctl };
#line 4521
allow kernel_t sysctl_vm_t:file { read getattr lock ioctl };
#line 4521
allow kernel_t sysctl_vm_t:dir { read getattr lock search ioctl };
#line 4521
allow kernel_t sysctl_dev_t:file { read getattr lock ioctl };
#line 4521
allow kernel_t sysctl_dev_t:dir { read getattr lock search ioctl };
#line 4521


#line 4522
# Read /.
#line 4522
allow kernel_t root_t:dir { read getattr lock search ioctl };
#line 4522
allow kernel_t root_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4522

#line 4522
# Read /home.
#line 4522
allow kernel_t home_root_t:dir { read getattr lock search ioctl };
#line 4522

#line 4522
# Read /usr.
#line 4522
allow kernel_t usr_t:dir { read getattr lock search ioctl };
#line 4522
allow kernel_t usr_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4522

#line 4522
# Read bin and sbin directories.
#line 4522
allow kernel_t bin_t:dir { read getattr lock search ioctl };
#line 4522
allow kernel_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4522
allow kernel_t sbin_t:dir { read getattr lock search ioctl };
#line 4522
allow kernel_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4522


#line 4523
allow kernel_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4523
allow kernel_t ld_so_t:file { read getattr lock execute ioctl };
#line 4523
allow kernel_t ld_so_t:file execute_no_trans;
#line 4523
allow kernel_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4523
allow kernel_t shlib_t:file { read getattr lock execute ioctl };
#line 4523
allow kernel_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4523
allow kernel_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4523
allow kernel_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4523


# Use capabilities.
allow kernel_t self:capability *;

# Run init in the init_t domain.

#line 4529

#line 4529

#line 4529

#line 4529
#
#line 4529
# Allow the process to transition to the new domain.
#line 4529
#
#line 4529
allow kernel_t init_t:process transition;
#line 4529

#line 4529
#
#line 4529
# Allow the process to execute the program.
#line 4529
# 
#line 4529
allow kernel_t init_exec_t:file { getattr execute };
#line 4529

#line 4529
#
#line 4529
# Allow the process to reap the new domain.
#line 4529
#
#line 4529
allow init_t kernel_t:process sigchld;
#line 4529

#line 4529
#
#line 4529
# Allow the new domain to inherit and use file 
#line 4529
# descriptions from the creating process and vice versa.
#line 4529
#
#line 4529
allow init_t kernel_t:fd use;
#line 4529
allow kernel_t init_t:fd use;
#line 4529

#line 4529
#
#line 4529
# Allow the new domain to write back to the old domain via a pipe.
#line 4529
#
#line 4529
allow init_t kernel_t:fifo_file { ioctl read getattr lock write append };
#line 4529

#line 4529
#
#line 4529
# Allow the new domain to read and execute the program.
#line 4529
#
#line 4529
allow init_t init_exec_t:file { read getattr lock execute ioctl };
#line 4529

#line 4529
#
#line 4529
# Allow the new domain to be entered via the program.
#line 4529
#
#line 4529
allow init_t init_exec_t:file entrypoint;
#line 4529

#line 4529
type_transition kernel_t init_exec_t:process init_t;
#line 4529

#line 4529
allow kernel_t init_exec_t:file read;
#line 4529


# Share state with the init process.
allow kernel_t init_t:process share;

# Mount and unmount file systems.
allow kernel_t fs_type:filesystem { mount remount unmount getattr };

# Search the persistent label mapping.
allow kernel_t file_labels_t:dir search;

# Send signal to any process.
allow kernel_t domain:process signal;

# Access the console.
allow kernel_t device_t:dir search;
allow kernel_t console_device_t:chr_file { ioctl read getattr lock write append };

# Access the initrd filesystem.
allow kernel_t file_t:chr_file { ioctl read getattr lock write append };

#line 4549
allow kernel_t file_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4549

#line 4552

allow kernel_t self:capability sys_chroot;

allow kernel_t file_t:dir mounton;
allow kernel_t file_t:dir { read getattr lock search ioctl add_name remove_name write };
allow kernel_t file_t:blk_file { create ioctl read getattr lock write setattr append link unlink rename };
allow kernel_t { sysctl_t sysctl_kernel_t }:file { setattr { ioctl read getattr lock write append } };

# Lookup the policy.
allow kernel_t policy_config_t:dir { read getattr lock search ioctl };

# Reload the policy from the real root.
allow kernel_t security_t:security load_policy;

#line 4570

#line 4570
# Run insmod (for kernel module loader).
#line 4570

#line 4570

#line 4570

#line 4570

#line 4570
#
#line 4570
# Allow the process to transition to the new domain.
#line 4570
#
#line 4570
allow kernel_t insmod_t:process transition;
#line 4570

#line 4570
#
#line 4570
# Allow the process to execute the program.
#line 4570
# 
#line 4570
allow kernel_t insmod_exec_t:file { getattr execute };
#line 4570

#line 4570
#
#line 4570
# Allow the process to reap the new domain.
#line 4570
#
#line 4570
allow insmod_t kernel_t:process sigchld;
#line 4570

#line 4570
#
#line 4570
# Allow the new domain to inherit and use file 
#line 4570
# descriptions from the creating process and vice versa.
#line 4570
#
#line 4570
allow insmod_t kernel_t:fd use;
#line 4570
allow kernel_t insmod_t:fd use;
#line 4570

#line 4570
#
#line 4570
# Allow the new domain to write back to the old domain via a pipe.
#line 4570
#
#line 4570
allow insmod_t kernel_t:fifo_file { ioctl read getattr lock write append };
#line 4570

#line 4570
#
#line 4570
# Allow the new domain to read and execute the program.
#line 4570
#
#line 4570
allow insmod_t insmod_exec_t:file { read getattr lock execute ioctl };
#line 4570

#line 4570
#
#line 4570
# Allow the new domain to be entered via the program.
#line 4570
#
#line 4570
allow insmod_t insmod_exec_t:file entrypoint;
#line 4570

#line 4570
type_transition kernel_t insmod_exec_t:process insmod_t;
#line 4570

#line 4570
allow kernel_t insmod_exec_t:file read;
#line 4570

#line 4570
allow kernel_t insmod_exec_t:lnk_file read;
#line 4570


# /proc/sys/kernel/modprobe is set to /bin/true if not using modules.

#line 4573
allow kernel_t bin_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4573


# added to run society with acme 
allow kernel_t mount_t:udp_socket { write };

#################################
#
# Rules for the acme_t domain.
#
# acme_t is the domain for the ruby and acme env of cougaar .
# ping_exec_t is the type of the corresponding program.
#
type acme_t, domain;
role sysadm_r types acme_t;
role system_r types acme_t;

#line 4588

#line 4588
# Grant the permissions common to the test domains.
#line 4588

#line 4588
# Grant permissions within the domain.
#line 4588

#line 4588
# Access other processes in the same domain.
#line 4588
allow acme_t self:process *;
#line 4588

#line 4588
# Access /proc/PID files for processes in the same domain.
#line 4588
allow acme_t self:dir { read getattr lock search ioctl };
#line 4588
allow acme_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4588

#line 4588
# Access file descriptions, pipes, and sockets
#line 4588
# created by processes in the same domain.
#line 4588
allow acme_t self:fd *;
#line 4588
allow acme_t self:fifo_file { ioctl read getattr lock write append };
#line 4588
allow acme_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4588
allow acme_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4588

#line 4588
# Allow the domain to communicate with other processes in the same domain.
#line 4588
allow acme_t self:unix_dgram_socket sendto;
#line 4588
allow acme_t self:unix_stream_socket connectto;
#line 4588

#line 4588
# Access System V IPC objects created by processes in the same domain.
#line 4588
allow acme_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 4588
allow acme_t self:msg  { send receive };
#line 4588
allow acme_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 4588
allow acme_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 4588

#line 4588

#line 4588

#line 4588
# Grant read/search permissions to most of /proc.
#line 4588

#line 4588
# Read system information files in /proc.
#line 4588
allow acme_t proc_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t proc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4588

#line 4588
# Stat /proc/kmsg and /proc/kcore.
#line 4588
allow acme_t proc_kmsg_t:file { getattr };
#line 4588
allow acme_t proc_kcore_t:file { getattr };
#line 4588

#line 4588
# Read system variables in /proc/sys.
#line 4588
allow acme_t sysctl_modprobe_t:file { read getattr lock ioctl };
#line 4588
allow acme_t sysctl_t:file { read getattr lock ioctl };
#line 4588
allow acme_t sysctl_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t sysctl_fs_t:file { read getattr lock ioctl };
#line 4588
allow acme_t sysctl_fs_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t sysctl_kernel_t:file { read getattr lock ioctl };
#line 4588
allow acme_t sysctl_kernel_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t sysctl_net_t:file { read getattr lock ioctl };
#line 4588
allow acme_t sysctl_net_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t sysctl_vm_t:file { read getattr lock ioctl };
#line 4588
allow acme_t sysctl_vm_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t sysctl_dev_t:file { read getattr lock ioctl };
#line 4588
allow acme_t sysctl_dev_t:dir { read getattr lock search ioctl };
#line 4588

#line 4588

#line 4588
# Grant read/search permissions to many system file types.
#line 4588

#line 4588

#line 4588
# Get attributes of file systems.
#line 4588
allow acme_t fs_type:filesystem getattr;
#line 4588

#line 4588

#line 4588
# Read /.
#line 4588
allow acme_t root_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t root_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4588

#line 4588
# Read /home.
#line 4588
allow acme_t home_root_t:dir { read getattr lock search ioctl };
#line 4588

#line 4588
# Read /usr.
#line 4588
allow acme_t usr_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t usr_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4588

#line 4588
# Read bin and sbin directories.
#line 4588
allow acme_t bin_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4588
allow acme_t sbin_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4588

#line 4588

#line 4588
# Read directories and files with the readable_t type.
#line 4588
# This type is a general type for "world"-readable files.
#line 4588
allow acme_t readable_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t readable_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4588

#line 4588
# Stat /...security and lost+found.
#line 4588
allow acme_t file_labels_t:dir getattr;
#line 4588
allow acme_t lost_found_t:dir getattr;
#line 4588

#line 4588
# Read the devpts root directory.  
#line 4588
allow acme_t devpts_t:dir { read getattr lock search ioctl };
#line 4588

#line 4588

#line 4588
# Read the /tmp directory and any /tmp files with the base type.
#line 4588
# Temporary files created at runtime will typically use derived types.
#line 4588
allow acme_t tmp_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t tmp_t:{ file lnk_file } { read getattr lock ioctl };
#line 4588

#line 4588
# Read /var.
#line 4588
allow acme_t var_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t var_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4588

#line 4588
# Read /var/catman.
#line 4588
allow acme_t catman_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t catman_t:{ file lnk_file } { read getattr lock ioctl };
#line 4588

#line 4588
# Read /var/lib.
#line 4588
allow acme_t var_lib_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t var_lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4588
allow acme_t var_lib_nfs_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t var_lib_nfs_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4588

#line 4588

#line 4588
allow acme_t tetex_data_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t tetex_data_t:{ file lnk_file } { read getattr lock ioctl };
#line 4588

#line 4588

#line 4588
# Read /var/yp.
#line 4588
allow acme_t var_yp_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t var_yp_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4588

#line 4588
# Read /var/spool.
#line 4588
allow acme_t var_spool_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t var_spool_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4588

#line 4588
# Read /var/run, /var/lock, /var/log.
#line 4588
allow acme_t var_run_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t var_run_t:{ file lnk_file } { read getattr lock ioctl };
#line 4588
allow acme_t var_log_t:dir { read getattr lock search ioctl };
#line 4588
#allow acme_t var_log_t:{ file lnk_file } r_file_perms;
#line 4588
allow acme_t var_log_sa_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t var_log_sa_t:{ file lnk_file } { read getattr lock ioctl };
#line 4588
allow acme_t var_log_ksyms_t:{ file lnk_file } { read getattr lock ioctl };
#line 4588

#line 4588
allow acme_t var_lock_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t var_lock_t:{ file lnk_file } { read getattr lock ioctl };
#line 4588

#line 4588
# Read /var/run/utmp and /var/log/wtmp.
#line 4588
allow acme_t initrc_var_run_t:file { read getattr lock ioctl };
#line 4588
allow acme_t wtmp_t:file { read getattr lock ioctl };
#line 4588

#line 4588
# Read /boot, /boot/System.map*, and /vmlinuz*
#line 4588
allow acme_t boot_t:dir { search getattr };
#line 4588
allow acme_t boot_t:file getattr;
#line 4588
allow acme_t system_map_t:{ file lnk_file } { read getattr lock ioctl };
#line 4588

#line 4588
allow acme_t boot_t:lnk_file read;
#line 4588

#line 4588
# Read /etc.
#line 4588
allow acme_t etc_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t etc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4588
allow acme_t etc_runtime_t:{ file lnk_file } { read getattr lock ioctl };
#line 4588
allow acme_t etc_aliases_t:{ file lnk_file } { read getattr lock ioctl };
#line 4588
allow acme_t etc_mail_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t etc_mail_t:{ file lnk_file } { read getattr lock ioctl };
#line 4588
allow acme_t resolv_conf_t:{ file lnk_file } { read getattr lock ioctl };
#line 4588
allow acme_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4588

#line 4588
# Read /lib.
#line 4588
allow acme_t lib_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4588

#line 4588
# Read the linker, shared library, and executable types.
#line 4588
allow acme_t ld_so_t:{ file lnk_file } { read getattr lock ioctl };
#line 4588
allow acme_t shlib_t:{ file lnk_file } { read getattr lock ioctl };
#line 4588
allow acme_t exec_type:{ file lnk_file } { read getattr lock ioctl };
#line 4588

#line 4588
# Read man directories and files.
#line 4588
allow acme_t man_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t man_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4588

#line 4588
# Read /usr/src.
#line 4588
allow acme_t src_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t src_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4588

#line 4588
# Read module-related files.
#line 4588
allow acme_t modules_object_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t modules_object_t:{ file lnk_file } { read getattr lock ioctl };
#line 4588
allow acme_t modules_dep_t:{ file lnk_file } { read getattr lock ioctl };
#line 4588
allow acme_t modules_conf_t:{ file lnk_file} { read getattr lock ioctl };
#line 4588

#line 4588
# Read /dev directories and any symbolic links.
#line 4588
allow acme_t device_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t device_t:lnk_file { read getattr lock ioctl };
#line 4588

#line 4588
# Read /dev/random and /dev/zero.
#line 4588
allow acme_t random_device_t:chr_file { read getattr lock ioctl };
#line 4588
allow acme_t zero_device_t:chr_file { read getattr lock ioctl };
#line 4588

#line 4588
# Read the root directory of a tmpfs filesytem and any symbolic links.
#line 4588
allow acme_t tmpfs_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t tmpfs_t:lnk_file { read getattr lock ioctl };
#line 4588

#line 4588
# Read any symbolic links on a devfs file system.
#line 4588
allow acme_t device_t:lnk_file { read getattr lock ioctl };
#line 4588

#line 4588
# Read the root directory of a usbdevfs filesystem, and
#line 4588
# the devices and drivers files.  Permit stating of the
#line 4588
# device nodes, but nothing else.
#line 4588
allow acme_t usbdevfs_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t usbdevfs_t:{ file lnk_file } { read getattr lock ioctl };
#line 4588
allow acme_t usbdevfs_device_t:file getattr;
#line 4588

#line 4588

#line 4588
# Grant write permissions to a small set of system file types.
#line 4588
# No permission to create files is granted here.  Use allow rules to grant 
#line 4588
# create permissions to a type or use file_type_auto_trans rules to set up
#line 4588
# new types for files.
#line 4588

#line 4588

#line 4588
# Read and write /dev/tty and /dev/null.
#line 4588
allow acme_t devtty_t:chr_file { ioctl read getattr lock write append };
#line 4588
allow acme_t { null_device_t zero_device_t }:chr_file { ioctl read getattr lock write append };
#line 4588

#line 4588
# Do not audit write denials to /etc/ld.so.cache.
#line 4588
dontaudit acme_t ld_so_cache_t:file write;
#line 4588

#line 4588

#line 4588
# Execute from the system shared libraries.
#line 4588
# No permission to execute anything else is granted here.
#line 4588
# Use can_exec or can_exec_any to grant the ability to execute within a domain.
#line 4588
# Use domain_auto_trans for executing and changing domains.
#line 4588

#line 4588
allow acme_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4588
allow acme_t ld_so_t:file { read getattr lock execute ioctl };
#line 4588
allow acme_t ld_so_t:file execute_no_trans;
#line 4588
allow acme_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4588
allow acme_t shlib_t:file { read getattr lock execute ioctl };
#line 4588
allow acme_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4588
allow acme_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4588
allow acme_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4588

#line 4588

#line 4588
# read localization information
#line 4588
allow acme_t locale_t:dir { read getattr lock search ioctl };
#line 4588
allow acme_t locale_t:{file lnk_file} { read getattr lock ioctl };
#line 4588

#line 4588
# Obtain the context of any SID, the SID for any context, 
#line 4588
# and the list of active SIDs.
#line 4588
allow acme_t security_t:security { sid_to_context context_to_sid get_sids };
#line 4588

#line 4588

#line 4588

#line 4588
# Grant permissions needed to create TCP and UDP sockets and 
#line 4588
# to access the network.
#line 4588

#line 4588
#
#line 4588
# Allow the domain to create and use UDP and TCP sockets.
#line 4588
# Other kinds of sockets must be separately authorized for use.
#line 4588
allow acme_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4588
allow acme_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4588

#line 4588
#
#line 4588
# Allow the domain to send UDP packets.
#line 4588
# Since the destination sockets type is unknown, the generic
#line 4588
# any_socket_t type is used as a placeholder.
#line 4588
#
#line 4588
allow acme_t any_socket_t:udp_socket sendto;
#line 4588

#line 4588
#
#line 4588
# Allow the domain to send using any network interface.
#line 4588
# netif_type is a type attribute for all network interface types.
#line 4588
#
#line 4588
allow acme_t netif_type:netif { tcp_send udp_send rawip_send };
#line 4588

#line 4588
#
#line 4588
# Allow packets sent by the domain to be received on any network interface.
#line 4588
#
#line 4588
allow acme_t netif_type:netif { tcp_recv udp_recv rawip_recv };
#line 4588

#line 4588
#
#line 4588
# Allow the domain to receive packets from any network interface.
#line 4588
# netmsg_type is a type attribute for all default message types.
#line 4588
#
#line 4588
allow acme_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
#line 4588

#line 4588
#
#line 4588
# Allow the domain to initiate or accept TCP connections 
#line 4588
# on any network interface.
#line 4588
#
#line 4588
allow acme_t netmsg_type:tcp_socket { connectto acceptfrom };
#line 4588

#line 4588
#
#line 4588
# Receive resets from the TCP reset socket.
#line 4588
# The TCP reset socket is labeled with the tcp_socket_t type.
#line 4588
#
#line 4588
allow acme_t tcp_socket_t:tcp_socket recvfrom;
#line 4588

#line 4588
dontaudit acme_t tcp_socket_t:tcp_socket connectto;
#line 4588

#line 4588
#
#line 4588
# Allow the domain to send to any node.
#line 4588
# node_type is a type attribute for all node types.
#line 4588
#
#line 4588
allow acme_t node_type:node { tcp_send udp_send rawip_send };
#line 4588

#line 4588
#
#line 4588
# Allow packets sent by the domain to be received from any node.
#line 4588
#
#line 4588
allow acme_t node_type:node { tcp_recv udp_recv rawip_recv };
#line 4588

#line 4588
#
#line 4588
# Allow the domain to send NFS client requests via the socket
#line 4588
# created by mount.
#line 4588
#
#line 4588
allow acme_t mount_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4588

#line 4588
#
#line 4588
# Bind to the default port type.
#line 4588
# Other port types must be separately authorized.
#line 4588
#
#line 4588
allow acme_t port_t:udp_socket name_bind;
#line 4588
allow acme_t port_t:tcp_socket name_bind;
#line 4588

#line 4588

type acme_exec_t, file_type, exec_type;

# Transition into this domain when you run this program.

#line 4592

#line 4592

#line 4592
#
#line 4592
# Allow the process to transition to the new domain.
#line 4592
#
#line 4592
allow sysadm_t acme_t:process transition;
#line 4592

#line 4592
#
#line 4592
# Allow the process to execute the program.
#line 4592
# 
#line 4592
allow sysadm_t acme_exec_t:file { getattr execute };
#line 4592

#line 4592
#
#line 4592
# Allow the process to reap the new domain.
#line 4592
#
#line 4592
allow acme_t sysadm_t:process sigchld;
#line 4592

#line 4592
#
#line 4592
# Allow the new domain to inherit and use file 
#line 4592
# descriptions from the creating process and vice versa.
#line 4592
#
#line 4592
allow acme_t sysadm_t:fd use;
#line 4592
allow sysadm_t acme_t:fd use;
#line 4592

#line 4592
#
#line 4592
# Allow the new domain to write back to the old domain via a pipe.
#line 4592
#
#line 4592
allow acme_t sysadm_t:fifo_file { ioctl read getattr lock write append };
#line 4592

#line 4592
#
#line 4592
# Allow the new domain to read and execute the program.
#line 4592
#
#line 4592
allow acme_t acme_exec_t:file { read getattr lock execute ioctl };
#line 4592

#line 4592
#
#line 4592
# Allow the new domain to be entered via the program.
#line 4592
#
#line 4592
allow acme_t acme_exec_t:file entrypoint;
#line 4592

#line 4592
type_transition sysadm_t acme_exec_t:process acme_t;
#line 4592


#line 4593

#line 4593

#line 4593
#
#line 4593
# Allow the process to transition to the new domain.
#line 4593
#
#line 4593
allow initrc_t acme_t:process transition;
#line 4593

#line 4593
#
#line 4593
# Allow the process to execute the program.
#line 4593
# 
#line 4593
allow initrc_t acme_exec_t:file { getattr execute };
#line 4593

#line 4593
#
#line 4593
# Allow the process to reap the new domain.
#line 4593
#
#line 4593
allow acme_t initrc_t:process sigchld;
#line 4593

#line 4593
#
#line 4593
# Allow the new domain to inherit and use file 
#line 4593
# descriptions from the creating process and vice versa.
#line 4593
#
#line 4593
allow acme_t initrc_t:fd use;
#line 4593
allow initrc_t acme_t:fd use;
#line 4593

#line 4593
#
#line 4593
# Allow the new domain to write back to the old domain via a pipe.
#line 4593
#
#line 4593
allow acme_t initrc_t:fifo_file { ioctl read getattr lock write append };
#line 4593

#line 4593
#
#line 4593
# Allow the new domain to read and execute the program.
#line 4593
#
#line 4593
allow acme_t acme_exec_t:file { read getattr lock execute ioctl };
#line 4593

#line 4593
#
#line 4593
# Allow the new domain to be entered via the program.
#line 4593
#
#line 4593
allow acme_t acme_exec_t:file entrypoint;
#line 4593

#line 4593
type_transition initrc_t acme_exec_t:process acme_t;
#line 4593


#line 4594

#line 4594

#line 4594
#
#line 4594
# Allow the process to transition to the new domain.
#line 4594
#
#line 4594
allow cougaar_t acme_t:process transition;
#line 4594

#line 4594
#
#line 4594
# Allow the process to execute the program.
#line 4594
# 
#line 4594
allow cougaar_t acme_exec_t:file { getattr execute };
#line 4594

#line 4594
#
#line 4594
# Allow the process to reap the new domain.
#line 4594
#
#line 4594
allow acme_t cougaar_t:process sigchld;
#line 4594

#line 4594
#
#line 4594
# Allow the new domain to inherit and use file 
#line 4594
# descriptions from the creating process and vice versa.
#line 4594
#
#line 4594
allow acme_t cougaar_t:fd use;
#line 4594
allow cougaar_t acme_t:fd use;
#line 4594

#line 4594
#
#line 4594
# Allow the new domain to write back to the old domain via a pipe.
#line 4594
#
#line 4594
allow acme_t cougaar_t:fifo_file { ioctl read getattr lock write append };
#line 4594

#line 4594
#
#line 4594
# Allow the new domain to read and execute the program.
#line 4594
#
#line 4594
allow acme_t acme_exec_t:file { read getattr lock execute ioctl };
#line 4594

#line 4594
#
#line 4594
# Allow the new domain to be entered via the program.
#line 4594
#
#line 4594
allow acme_t acme_exec_t:file entrypoint;
#line 4594

#line 4594
type_transition cougaar_t acme_exec_t:process acme_t;
#line 4594


# Let acme create raw socket.
allow acme_t self:tcp_socket { create bind setopt getopt write read };
allow acme_t any_socket_t:tcp_socket sendto;

# Let  acme receive ICMP replies.
allow acme_t { self tcp_socket_t }:tcp_socket recvfrom;

# Use capabilities.
allow acme_t acme_t:capability { net_raw setuid };

#allow role cougaar_r types acme_t;

# added to run society under acme
allow acme_t acme_exec_t:file { execute_no_trans };
allow acme_t acme_t:capability { net_bind_service setgid };
allow acme_t acme_t:tcp_socket { acceptfrom connectto };
allow acme_t bin_t:file { execute execute_no_trans };
allow acme_t crond_t:dir { search };
allow acme_t crond_t:file { getattr read };
allow acme_t devlog_t:sock_file { write };
allow acme_t dhcpc_t:dir { search };
allow acme_t dhcpc_t:file { getattr read };
allow acme_t file_t:dir { getattr search };
allow acme_t getty_t:dir { search };
allow acme_t getty_t:file { getattr read };
allow acme_t init_t:dir { search };
allow acme_t init_t:file { getattr read };
allow acme_t initrc_tmp_t:dir { getattr };
allow acme_t initrc_tmp_t:file { getattr };
allow acme_t initrc_t:dir { search };
allow acme_t initrc_t:file { getattr read };
allow acme_t initrc_t:udp_socket { recvfrom };
allow acme_t initrc_var_run_t:file { write };
allow acme_t kernel_t:dir { search };
allow acme_t kernel_t:file { getattr read };
allow acme_t klogd_t:dir { search };
allow acme_t klogd_t:file { getattr read };
allow acme_t lib_t:file { execute };
allow acme_t mount_t:dir { search };
allow acme_t mount_t:file { getattr read };
allow acme_t newrole_t:dir { search };
allow acme_t newrole_t:file { getattr read };
allow acme_t nfs_t:dir { add_name create getattr read remove_name search write };
allow acme_t nfs_t:file { append create getattr ioctl link lock read rename setattr unlink write };
allow acme_t nfs_t:lnk_file { getattr read };
allow acme_t shell_exec_t:file { execute execute_no_trans };
allow acme_t sshd_tmp_t:dir { getattr };
allow acme_t sshd_t:dir { search };
allow acme_t sshd_t:file { getattr read };
allow acme_t su_exec_t:file { execute execute_no_trans };
allow acme_t sysadm_home_dir_t:dir { add_name getattr remove_name search write };
allow acme_t sysadm_home_dir_t:file { create getattr link read unlink write };
allow acme_t sysadm_home_t:dir { search };
allow acme_t sysadm_home_t:file { getattr ioctl read };
allow acme_t sysadm_t:dir { search };
allow acme_t sysadm_t:file { getattr read };
allow acme_t syslogd_t:dir { search };
allow acme_t syslogd_t:file { getattr read };
allow acme_t syslogd_t:unix_dgram_socket { sendto };
allow acme_t tmp_t:dir { add_name remove_name write };
allow acme_t tmp_t:file { append create rename setattr unlink write };
allow acme_t user_t:dir { search };
allow acme_t user_t:file { getattr read };
allow acme_t usr_t:file { append setattr write };
allow acme_t var_spool_t:file { execute };
allow acme_t xauth_exec_t:file { execute execute_no_trans };
allow acme_t acme_t:tcp_socket { acceptfrom connectto };
allow acme_t devlog_t:sock_file { write };
allow acme_t file_t:dir { getattr search };
allow acme_t initrc_tmp_t:dir { getattr };
allow acme_t initrc_tmp_t:file { getattr };
allow acme_t initrc_t:udp_socket { recvfrom };
allow acme_t lib_t:file { execute };
allow acme_t nfs_t:dir { add_name create getattr read remove_name search write };
allow acme_t nfs_t:file { append getattr ioctl link lock read rename setattr unlink write };
allow acme_t nfs_t:lnk_file { getattr read };
allow acme_t sshd_tmp_t:dir { getattr };
allow acme_t tmp_t:dir { add_name remove_name write };
allow acme_t tmp_t:file { create rename setattr unlink write };
allow acme_t usr_t:file { append };
allow acme_t system_crond_t:dir { search };
allow acme_t system_crond_t:file { getattr read };
allow acme_t acme_t:capability { kill };
allow acme_t crond_t:dir { getattr };
allow acme_t dhcpc_t:dir { getattr };
allow acme_t getty_t:dir { getattr };
allow acme_t init_t:dir { getattr };
allow acme_t initrc_t:dir { getattr };
allow acme_t kernel_t:dir { getattr };
allow acme_t klogd_t:dir { getattr };
allow acme_t mount_t:dir { getattr };
allow acme_t newrole_t:dir { getattr };
allow acme_t sshd_t:dir { getattr };
allow acme_t sysadm_t:dir { getattr };
allow acme_t syslogd_t:dir { getattr };
allow acme_t user_t:dir { getattr };
allow acme_t usr_t:dir { add_name write };
allow acme_t usr_t:file { create };








#DESC Checkpolicy - SELinux policy compliler
#
# Authors:  Frank Mayer, mayerf@tresys.com
#

###########################
# 
# checkpolicy_t is the domain type for checkpolicy
# checkpolicy_exec_t if file type for the executable

type checkpolicy_t, domain;
role sysadm_r types checkpolicy_t;

type checkpolicy_exec_t, file_type, exec_type, sysadmfile;

##########################
# 
# Rules


#line 4721

#line 4721

#line 4721
#
#line 4721
# Allow the process to transition to the new domain.
#line 4721
#
#line 4721
allow sysadm_t checkpolicy_t:process transition;
#line 4721

#line 4721
#
#line 4721
# Allow the process to execute the program.
#line 4721
# 
#line 4721
allow sysadm_t checkpolicy_exec_t:file { getattr execute };
#line 4721

#line 4721
#
#line 4721
# Allow the process to reap the new domain.
#line 4721
#
#line 4721
allow checkpolicy_t sysadm_t:process sigchld;
#line 4721

#line 4721
#
#line 4721
# Allow the new domain to inherit and use file 
#line 4721
# descriptions from the creating process and vice versa.
#line 4721
#
#line 4721
allow checkpolicy_t sysadm_t:fd use;
#line 4721
allow sysadm_t checkpolicy_t:fd use;
#line 4721

#line 4721
#
#line 4721
# Allow the new domain to write back to the old domain via a pipe.
#line 4721
#
#line 4721
allow checkpolicy_t sysadm_t:fifo_file { ioctl read getattr lock write append };
#line 4721

#line 4721
#
#line 4721
# Allow the new domain to read and execute the program.
#line 4721
#
#line 4721
allow checkpolicy_t checkpolicy_exec_t:file { read getattr lock execute ioctl };
#line 4721

#line 4721
#
#line 4721
# Allow the new domain to be entered via the program.
#line 4721
#
#line 4721
allow checkpolicy_t checkpolicy_exec_t:file entrypoint;
#line 4721

#line 4721
type_transition sysadm_t checkpolicy_exec_t:process checkpolicy_t;
#line 4721


# able to create and modify binary policy files
allow checkpolicy_t policy_config_t:dir { read getattr lock search ioctl add_name remove_name write };
allow checkpolicy_t policy_config_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };

###########################
# constrain what checkpolicy can use as source files
#

# only allow read of policy source files
allow checkpolicy_t policy_src_t:dir { read getattr lock search ioctl };
allow checkpolicy_t policy_src_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };

# allow test policies to be created in src directories

#line 4736

#line 4736

#line 4736

#line 4736
#
#line 4736
# Allow the process to modify the directory.
#line 4736
#
#line 4736
allow checkpolicy_t policy_src_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4736

#line 4736
#
#line 4736
# Allow the process to create the file.
#line 4736
#
#line 4736

#line 4736
allow checkpolicy_t policy_config_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4736
allow checkpolicy_t policy_config_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4736

#line 4736

#line 4736

#line 4736
type_transition checkpolicy_t policy_src_t:dir policy_config_t;
#line 4736
type_transition checkpolicy_t policy_src_t:{ file lnk_file sock_file fifo_file } policy_config_t;
#line 4736

#line 4736

#line 4736


# directory search permissions for path to source and binary policy files
allow checkpolicy_t root_t:dir search;
allow checkpolicy_t etc_t:dir search;

# Read the devpts root directory.  
allow checkpolicy_t devpts_t:dir { read getattr lock search ioctl };
#line 4745


# Other access
allow checkpolicy_t { sysadm_tty_device_t sysadm_devpts_t }:chr_file { read write ioctl getattr };

#line 4749
allow checkpolicy_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4749
allow checkpolicy_t ld_so_t:file { read getattr lock execute ioctl };
#line 4749
allow checkpolicy_t ld_so_t:file execute_no_trans;
#line 4749
allow checkpolicy_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4749
allow checkpolicy_t shlib_t:file { read getattr lock execute ioctl };
#line 4749
allow checkpolicy_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4749
allow checkpolicy_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4749
allow checkpolicy_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4749

allow checkpolicy_t self:capability dac_override;

allow checkpolicy_t sysadm_tmp_t:file { getattr write } ;

##########################
# Allow users to execute checkpolicy without a domain transition
# so it can be used without privilege to write real binary policy file

#line 4757
allow user_t checkpolicy_exec_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4757


allow checkpolicy_t privfd:fd use;

# Added to run society under acme 
allow checkpolicy_t sysadm_home_t:dir { search };
allow checkpolicy_t sysadm_home_t:file { getattr ioctl read setattr write };



#DESC Chkpwd - PAM password checking programs
#
# Domains for the /sbin/.*_chkpwd utilities.
#

#
# chkpwd_exec_t is the type of the /sbin/.*_chkpwd executables.
#
type chkpwd_exec_t, file_type, sysadmfile, exec_type;

# Everything else is in the chkpwd_domain macro in
# macros/program/chkpwd_macros.te.
#DESC Cougaar
#
# File: cougaar.te
# Author(s):
#

role cougaar_r types cougaar_t;
#every_domain(cougaar_t)
#uses_java(cougaar_t);
#type cougaar_exec_t 
#allow cougaar_r:{file lnk_file} { create ioctl read getattr lock write setattr append };
allow cougaar_t cougaar_t:dir { create rmdir add_name remove_name write};
allow cougaar_t cougaar_t:file { append execute_no_trans rename setattr };
allow cougaar_t file_t:dir { search };
allow cougaar_t fs_t:filesystem { associate };
#allow cougaar_t sysadm_tty_device_t:chr_file { getattr };
allow cougaar_t tmp_t:file { setattr unlink write };
allow cougaar_t tty_device_t:chr_file { getattr };
allow cougaar_t user_devpts_t:chr_file { ioctl };
allow cougaar_t user_home_dir_t:dir { remove_name };
allow cougaar_t user_home_dir_t:file { read rename unlink write };
allow cougaar_t user_home_t:dir { add_name getattr read remove_name write };
allow cougaar_t user_home_t:file { append create getattr unlink write };
allow cougaar_t cougaar_t:dir { add_name remove_name write };
allow cougaar_t cougaar_t:file { create execute unlink write };
allow cougaar_t initrc_var_run_t:file { lock };
allow cougaar_t locale_t:dir { search };
allow cougaar_t locale_t:file { getattr read };
allow cougaar_t random_device_t:chr_file { getattr read };
allow cougaar_t resolv_conf_t:file { getattr read };
allow cougaar_t sysctl_kernel_t:dir { search };
allow cougaar_t sysctl_kernel_t:file { read };
allow cougaar_t user_devpts_t:chr_file { read write };
allow cougaar_t user_home_dir_t:dir { add_name getattr read search write };
allow cougaar_t user_home_dir_t:file { create getattr setattr };
allow cougaar_t user_home_t:dir { search };
allow cougaar_t user_home_t:file { read };
allow cougaar_t var_spool_t:file { execute };
allow cougaar_t var_yp_t:dir { search };
allow cougaar_t var_yp_t:file { read };

allow cougaar_t acme_t:process { sigkill };
allow cougaar_t nfs_t:dir { getattr read search };
allow cougaar_t nfs_t:file { getattr ioctl read };
allow cougaar_t nfs_t:lnk_file { read };
allow cougaar_xauth_t nfs_t:dir { add_name remove_name search write };
allow cougaar_xauth_t nfs_t:file { create getattr link read unlink write };
allow cougaar_xauth_t sshd_t:unix_stream_socket { read write };









#DESC Crond - Crond daemon
#
# Domains for the top-level crond daemon process and
# for system cron jobs.  The domains for user cron jobs
# are in macros/program/crond_macros.te.
#

#
# Authors:  Jonathan Crowley (MITRE) <jonathan@mitre.org>,
#	    Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser
#
# Domain for crond.  It needs auth to check for locked accounts.


#line 4849

#line 4849
type crond_t, domain, privlog , privrole, privmail, auth, privfd;
#line 4849
type crond_exec_t, file_type, sysadmfile, exec_type;
#line 4849

#line 4849
role system_r types crond_t;
#line 4849

#line 4849

#line 4849

#line 4849

#line 4849
#
#line 4849
# Allow the process to transition to the new domain.
#line 4849
#
#line 4849
allow initrc_t crond_t:process transition;
#line 4849

#line 4849
#
#line 4849
# Allow the process to execute the program.
#line 4849
# 
#line 4849
allow initrc_t crond_exec_t:file { getattr execute };
#line 4849

#line 4849
#
#line 4849
# Allow the process to reap the new domain.
#line 4849
#
#line 4849
allow crond_t initrc_t:process sigchld;
#line 4849

#line 4849
#
#line 4849
# Allow the new domain to inherit and use file 
#line 4849
# descriptions from the creating process and vice versa.
#line 4849
#
#line 4849
allow crond_t initrc_t:fd use;
#line 4849
allow initrc_t crond_t:fd use;
#line 4849

#line 4849
#
#line 4849
# Allow the new domain to write back to the old domain via a pipe.
#line 4849
#
#line 4849
allow crond_t initrc_t:fifo_file { ioctl read getattr lock write append };
#line 4849

#line 4849
#
#line 4849
# Allow the new domain to read and execute the program.
#line 4849
#
#line 4849
allow crond_t crond_exec_t:file { read getattr lock execute ioctl };
#line 4849

#line 4849
#
#line 4849
# Allow the new domain to be entered via the program.
#line 4849
#
#line 4849
allow crond_t crond_exec_t:file entrypoint;
#line 4849

#line 4849
type_transition initrc_t crond_exec_t:process crond_t;
#line 4849

#line 4849

#line 4849
# Inherit and use descriptors from init.
#line 4849
allow crond_t init_t:fd use;
#line 4849
allow crond_t init_t:process sigchld;
#line 4849
allow crond_t privfd:fd use;
#line 4849
allow crond_t newrole_t:process sigchld;
#line 4849
allow crond_t self:process { { sigchld sigkill sigstop signull signal } fork };
#line 4849

#line 4849

#line 4849
allow crond_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4849
allow crond_t ld_so_t:file { read getattr lock execute ioctl };
#line 4849
allow crond_t ld_so_t:file execute_no_trans;
#line 4849
allow crond_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4849
allow crond_t shlib_t:file { read getattr lock execute ioctl };
#line 4849
allow crond_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4849
allow crond_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4849
allow crond_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4849

#line 4849

#line 4849
allow crond_t { self proc_t }:dir { read getattr lock search ioctl };
#line 4849
allow crond_t { self proc_t }:lnk_file read;
#line 4849

#line 4849
allow crond_t device_t:dir { getattr search };
#line 4849
allow crond_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4849
allow crond_t console_device_t:chr_file { ioctl read getattr lock write append };
#line 4849
allow crond_t initrc_devpts_t:chr_file { ioctl read getattr lock write append };
#line 4849

#line 4849
# Create pid file.
#line 4849
allow crond_t var_t:dir { getattr search };
#line 4849
type var_run_crond_t, file_type, sysadmfile, pidfile;
#line 4849

#line 4849

#line 4849

#line 4849

#line 4849
#
#line 4849
# Allow the process to modify the directory.
#line 4849
#
#line 4849
allow crond_t var_run_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4849

#line 4849
#
#line 4849
# Allow the process to create the file.
#line 4849
#
#line 4849

#line 4849
allow crond_t var_run_crond_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4849
allow crond_t var_run_crond_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4849

#line 4849

#line 4849

#line 4849
type_transition crond_t var_run_t:dir var_run_crond_t;
#line 4849
type_transition crond_t var_run_t:{ file lnk_file sock_file fifo_file } var_run_crond_t;
#line 4849

#line 4849

#line 4849

#line 4849

#line 4849
allow crond_t devtty_t:chr_file { ioctl read getattr lock write append };
#line 4849

#line 4849
# for daemons that look at /root on startup
#line 4849
dontaudit crond_t sysadm_home_dir_t:dir search;
#line 4849

#line 4849
# for df
#line 4849
allow crond_t fs_type:filesystem getattr;
#line 4849


# This domain is granted permissions common to most domains (including can_net)

#line 4852
# Access other processes in the same domain.
#line 4852
allow crond_t self:process *;
#line 4852

#line 4852
# Access /proc/PID files for processes in the same domain.
#line 4852
allow crond_t self:dir { read getattr lock search ioctl };
#line 4852
allow crond_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4852

#line 4852
# Access file descriptions, pipes, and sockets
#line 4852
# created by processes in the same domain.
#line 4852
allow crond_t self:fd *;
#line 4852
allow crond_t self:fifo_file { ioctl read getattr lock write append };
#line 4852
allow crond_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4852
allow crond_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4852

#line 4852
# Allow the domain to communicate with other processes in the same domain.
#line 4852
allow crond_t self:unix_dgram_socket sendto;
#line 4852
allow crond_t self:unix_stream_socket connectto;
#line 4852

#line 4852
# Access System V IPC objects created by processes in the same domain.
#line 4852
allow crond_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 4852
allow crond_t self:msg  { send receive };
#line 4852
allow crond_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 4852
allow crond_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 4852

#line 4852


# Type for the anacron executable.
type anacron_exec_t, file_type, sysadmfile, exec_type;

# Type for temporary files.

#line 4858
type crond_tmp_t, file_type, sysadmfile, tmpfile ;
#line 4858

#line 4858

#line 4858

#line 4858

#line 4858
#
#line 4858
# Allow the process to modify the directory.
#line 4858
#
#line 4858
allow crond_t tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4858

#line 4858
#
#line 4858
# Allow the process to create the file.
#line 4858
#
#line 4858

#line 4858
allow crond_t crond_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4858
allow crond_t crond_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4858

#line 4858

#line 4858

#line 4858
type_transition crond_t tmp_t:dir crond_tmp_t;
#line 4858
type_transition crond_t tmp_t:{ file lnk_file sock_file fifo_file } crond_tmp_t;
#line 4858

#line 4858

#line 4858

#line 4858


# Domain for system cron jobs.
type system_crond_t, domain, privlog, privmail;

# Read and write console and ttys.
allow system_crond_t devtty_t:chr_file { ioctl read getattr lock write append };

# Read system information files in /proc.
allow system_crond_t proc_t:dir { read getattr lock search ioctl };
allow system_crond_t proc_t:file { read getattr lock ioctl };

#line 4872


# to stop killall type operations from filling our logs
dontaudit system_crond_t domain:dir search;

# read files in /etc (anacrontab)  execute /etc/cron.hourly/*, etc.
allow system_crond_t etc_t:file read;
allow system_crond_t etc_runtime_t:file read;

# read localization information
allow crond_t locale_t:dir { read getattr lock search ioctl };
allow crond_t locale_t:{file lnk_file} { read getattr lock ioctl };
allow system_crond_t locale_t:dir { read getattr lock search ioctl };
allow system_crond_t locale_t:{file lnk_file} { read getattr lock ioctl };

# Type for log files.
type cron_log_t, file_type, sysadmfile, logfile;
# Use this type when creating files in /var/log.

#line 4890

#line 4890

#line 4890

#line 4890
#
#line 4890
# Allow the process to modify the directory.
#line 4890
#
#line 4890
allow crond_t var_log_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4890

#line 4890
#
#line 4890
# Allow the process to create the file.
#line 4890
#
#line 4890

#line 4890
allow crond_t cron_log_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4890
allow crond_t cron_log_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4890

#line 4890

#line 4890

#line 4890
type_transition crond_t var_log_t:dir cron_log_t;
#line 4890
type_transition crond_t var_log_t:{ file lnk_file sock_file fifo_file } cron_log_t;
#line 4890

#line 4890

#line 4890


# Use capabilities.
allow crond_t crond_t:capability { setgid setuid net_bind_service };

# Check entrypoint permission on crontab files.
allow crond_t security_t:security compute_av;

# for finding binaries and /bin/sh
allow crond_t { bin_t sbin_t }:dir search;
allow crond_t bin_t:lnk_file read;

# Read from /var/spool/cron.
allow crond_t var_lib_t:dir search;
allow crond_t var_spool_t:dir { read getattr lock search ioctl };
allow crond_t cron_spool_t:dir { read getattr lock search ioctl };
allow crond_t cron_spool_t:file { read getattr lock ioctl };

# Read system crontabs
allow crond_t system_crond_script_t:file { read getattr lock ioctl };
allow crond_t system_crond_script_t:dir { read getattr lock search ioctl };

# Read /etc/security/default_contexts.
allow crond_t default_context_t:file { read getattr lock ioctl };

allow crond_t etc_t:file { getattr read };
allow crond_t etc_t:lnk_file read;

# crond tries to search /root.  Not sure why.
allow crond_t sysadm_home_dir_t:dir { read getattr lock search ioctl };

# to search /home
allow crond_t home_root_t:dir { getattr search };
allow crond_t user_home_dir_type:dir { read getattr lock search ioctl };

# Run a shell.

#line 4926
allow crond_t shell_exec_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4926


#line 4935


# This system_r role is authorized for this domain.
role system_r types system_crond_t;


#line 4940
allow system_crond_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 4940
allow system_crond_t ld_so_t:file { read getattr lock execute ioctl };
#line 4940
allow system_crond_t ld_so_t:file execute_no_trans;
#line 4940
allow system_crond_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 4940
allow system_crond_t shlib_t:file { read getattr lock execute ioctl };
#line 4940
allow system_crond_t shlib_t:lnk_file { read getattr lock ioctl };
#line 4940
allow system_crond_t ld_so_cache_t:file { read getattr lock ioctl };
#line 4940
allow system_crond_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 4940
;

#line 4941
# Access other processes in the same domain.
#line 4941
allow system_crond_t self:process *;
#line 4941

#line 4941
# Access /proc/PID files for processes in the same domain.
#line 4941
allow system_crond_t self:dir { read getattr lock search ioctl };
#line 4941
allow system_crond_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 4941

#line 4941
# Access file descriptions, pipes, and sockets
#line 4941
# created by processes in the same domain.
#line 4941
allow system_crond_t self:fd *;
#line 4941
allow system_crond_t self:fifo_file { ioctl read getattr lock write append };
#line 4941
allow system_crond_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 4941
allow system_crond_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 4941

#line 4941
# Allow the domain to communicate with other processes in the same domain.
#line 4941
allow system_crond_t self:unix_dgram_socket sendto;
#line 4941
allow system_crond_t self:unix_stream_socket connectto;
#line 4941

#line 4941
# Access System V IPC objects created by processes in the same domain.
#line 4941
allow system_crond_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 4941
allow system_crond_t self:msg  { send receive };
#line 4941
allow system_crond_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 4941
allow system_crond_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 4941

#line 4941
;
allow system_crond_t var_log_t:file { read getattr lock ioctl };

# Type for system crontab files.
type system_crond_script_t, file_type, sysadmfile;

# Permit crond_t to transition to this domain.
# The transition is requested explicitly by the modified crond 
# via execve_secure.  There is no way to set up an automatic
# transition, since crontabs are configuration files, not executables.

#line 4951

#line 4951
#
#line 4951
# Allow the process to transition to the new domain.
#line 4951
#
#line 4951
allow crond_t system_crond_t:process transition;
#line 4951

#line 4951
#
#line 4951
# Allow the process to execute the program.
#line 4951
# 
#line 4951
allow crond_t shell_exec_t:file { getattr execute };
#line 4951

#line 4951
#
#line 4951
# Allow the process to reap the new domain.
#line 4951
#
#line 4951
allow system_crond_t crond_t:process sigchld;
#line 4951

#line 4951
#
#line 4951
# Allow the new domain to inherit and use file 
#line 4951
# descriptions from the creating process and vice versa.
#line 4951
#
#line 4951
allow system_crond_t crond_t:fd use;
#line 4951
allow crond_t system_crond_t:fd use;
#line 4951

#line 4951
#
#line 4951
# Allow the new domain to write back to the old domain via a pipe.
#line 4951
#
#line 4951
allow system_crond_t crond_t:fifo_file { ioctl read getattr lock write append };
#line 4951

#line 4951
#
#line 4951
# Allow the new domain to read and execute the program.
#line 4951
#
#line 4951
allow system_crond_t shell_exec_t:file { read getattr lock execute ioctl };
#line 4951

#line 4951
#
#line 4951
# Allow the new domain to be entered via the program.
#line 4951
#
#line 4951
allow system_crond_t shell_exec_t:file entrypoint;
#line 4951


# Transition to this domain for anacron as well.
# Still need to study anacron.

#line 4955

#line 4955

#line 4955
#
#line 4955
# Allow the process to transition to the new domain.
#line 4955
#
#line 4955
allow initrc_t system_crond_t:process transition;
#line 4955

#line 4955
#
#line 4955
# Allow the process to execute the program.
#line 4955
# 
#line 4955
allow initrc_t anacron_exec_t:file { getattr execute };
#line 4955

#line 4955
#
#line 4955
# Allow the process to reap the new domain.
#line 4955
#
#line 4955
allow system_crond_t initrc_t:process sigchld;
#line 4955

#line 4955
#
#line 4955
# Allow the new domain to inherit and use file 
#line 4955
# descriptions from the creating process and vice versa.
#line 4955
#
#line 4955
allow system_crond_t initrc_t:fd use;
#line 4955
allow initrc_t system_crond_t:fd use;
#line 4955

#line 4955
#
#line 4955
# Allow the new domain to write back to the old domain via a pipe.
#line 4955
#
#line 4955
allow system_crond_t initrc_t:fifo_file { ioctl read getattr lock write append };
#line 4955

#line 4955
#
#line 4955
# Allow the new domain to read and execute the program.
#line 4955
#
#line 4955
allow system_crond_t anacron_exec_t:file { read getattr lock execute ioctl };
#line 4955

#line 4955
#
#line 4955
# Allow the new domain to be entered via the program.
#line 4955
#
#line 4955
allow system_crond_t anacron_exec_t:file entrypoint;
#line 4955

#line 4955
type_transition initrc_t anacron_exec_t:process system_crond_t;
#line 4955


# Access log files

#line 4958

#line 4958

#line 4958

#line 4958
#
#line 4958
# Allow the process to modify the directory.
#line 4958
#
#line 4958
allow system_crond_t var_log_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 4958

#line 4958
#
#line 4958
# Allow the process to create the file.
#line 4958
#
#line 4958

#line 4958
allow system_crond_t cron_log_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 4958
allow system_crond_t cron_log_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 4958

#line 4958

#line 4958

#line 4958
type_transition system_crond_t var_log_t:dir cron_log_t;
#line 4958
type_transition system_crond_t var_log_t:{ file lnk_file sock_file fifo_file } cron_log_t;
#line 4958

#line 4958

#line 4958


# Inherit and use descriptors from init.
allow system_crond_t init_t:fd use;

# Inherit and use descriptors from initrc.
allow system_crond_t initrc_t:fd use;

# Write to a socket from initrc.
allow system_crond_t initrc_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };

# Use capabilities.
allow system_crond_t system_crond_t:capability { setgid setuid dac_override fowner net_bind_service fsetid };

# Read the system crontabs.
allow system_crond_t system_crond_script_t:file { read getattr lock ioctl };

# 
# Since crontab files are not directly executed,
# crond must ensure that the crontab file has
# a type that is appropriate for the domain of
# the system cron job.  It performs an entrypoint
# permission check for this purpose.
#
allow system_crond_t system_crond_script_t:file entrypoint;
#line 4985


# Run helper programs in the system_crond_t domain.
allow system_crond_t { bin_t sbin_t }:dir { read getattr lock search ioctl };
allow system_crond_t { bin_t sbin_t }:lnk_file read;

#line 4990
allow system_crond_t etc_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4990


#line 4991
allow system_crond_t bin_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4991


#line 4992
allow system_crond_t sbin_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4992


#line 4993
allow system_crond_t exec_type:file { { read getattr lock execute ioctl } execute_no_trans };
#line 4993



# Read from /var/spool/cron.
allow system_crond_t cron_spool_t:dir { read getattr lock search ioctl };
allow system_crond_t cron_spool_t:file { read getattr lock ioctl };

# Write to /var/lib/slocate.db.
allow system_crond_t var_lib_t:dir { read getattr lock search ioctl add_name remove_name write };
allow system_crond_t var_lib_t:file { create ioctl read getattr lock write setattr append link unlink rename };

# Update whatis files.
allow system_crond_t catman_t:dir { read getattr lock search ioctl add_name remove_name write };
allow system_crond_t catman_t:file { create ioctl read getattr lock write setattr append link unlink rename };

# Write /var/lock/makewhatis.lock.
allow system_crond_t var_lock_t:dir { read getattr lock search ioctl add_name remove_name write };
allow system_crond_t var_lock_t:file { create ioctl read getattr lock write setattr append link unlink rename };

# Modutils are now combined, so we can no longer distinguish them.
# Let crond run the insmod executable in the insmod_t domain.
#line 5016

#line 5016

#line 5016

#line 5016

#line 5016

#line 5016
#
#line 5016
# Allow the process to transition to the new domain.
#line 5016
#
#line 5016
allow system_crond_t insmod_t:process transition;
#line 5016

#line 5016
#
#line 5016
# Allow the process to execute the program.
#line 5016
# 
#line 5016
allow system_crond_t insmod_exec_t:file { getattr execute };
#line 5016

#line 5016
#
#line 5016
# Allow the process to reap the new domain.
#line 5016
#
#line 5016
allow insmod_t system_crond_t:process sigchld;
#line 5016

#line 5016
#
#line 5016
# Allow the new domain to inherit and use file 
#line 5016
# descriptions from the creating process and vice versa.
#line 5016
#
#line 5016
allow insmod_t system_crond_t:fd use;
#line 5016
allow system_crond_t insmod_t:fd use;
#line 5016

#line 5016
#
#line 5016
# Allow the new domain to write back to the old domain via a pipe.
#line 5016
#
#line 5016
allow insmod_t system_crond_t:fifo_file { ioctl read getattr lock write append };
#line 5016

#line 5016
#
#line 5016
# Allow the new domain to read and execute the program.
#line 5016
#
#line 5016
allow insmod_t insmod_exec_t:file { read getattr lock execute ioctl };
#line 5016

#line 5016
#
#line 5016
# Allow the new domain to be entered via the program.
#line 5016
#
#line 5016
allow insmod_t insmod_exec_t:file entrypoint;
#line 5016

#line 5016
type_transition system_crond_t insmod_exec_t:process insmod_t;
#line 5016

#line 5016
allow insmod_t crond_t:fifo_file { getattr read write ioctl };
#line 5016
# a rule for privfd may make this obsolete
#line 5016
allow insmod_t crond_t:fd use;
#line 5016
allow insmod_t crond_t:process sigchld;
#line 5016

#line 5016


# for if /var/mail is a symlink
allow crond_t mail_spool_t:lnk_file read;

# Run logrotate in the logrotate_t domain.
#line 5024

#line 5024

#line 5024

#line 5024

#line 5024

#line 5024
#
#line 5024
# Allow the process to transition to the new domain.
#line 5024
#
#line 5024
allow system_crond_t logrotate_t:process transition;
#line 5024

#line 5024
#
#line 5024
# Allow the process to execute the program.
#line 5024
# 
#line 5024
allow system_crond_t logrotate_exec_t:file { getattr execute };
#line 5024

#line 5024
#
#line 5024
# Allow the process to reap the new domain.
#line 5024
#
#line 5024
allow logrotate_t system_crond_t:process sigchld;
#line 5024

#line 5024
#
#line 5024
# Allow the new domain to inherit and use file 
#line 5024
# descriptions from the creating process and vice versa.
#line 5024
#
#line 5024
allow logrotate_t system_crond_t:fd use;
#line 5024
allow system_crond_t logrotate_t:fd use;
#line 5024

#line 5024
#
#line 5024
# Allow the new domain to write back to the old domain via a pipe.
#line 5024
#
#line 5024
allow logrotate_t system_crond_t:fifo_file { ioctl read getattr lock write append };
#line 5024

#line 5024
#
#line 5024
# Allow the new domain to read and execute the program.
#line 5024
#
#line 5024
allow logrotate_t logrotate_exec_t:file { read getattr lock execute ioctl };
#line 5024

#line 5024
#
#line 5024
# Allow the new domain to be entered via the program.
#line 5024
#
#line 5024
allow logrotate_t logrotate_exec_t:file entrypoint;
#line 5024

#line 5024
type_transition system_crond_t logrotate_exec_t:process logrotate_t;
#line 5024

#line 5024
allow logrotate_t crond_t:fifo_file { getattr read write ioctl };
#line 5024
# a rule for privfd may make this obsolete
#line 5024
allow logrotate_t crond_t:fd use;
#line 5024
allow logrotate_t crond_t:process sigchld;
#line 5024

#line 5024


#line 5028


# Stat any file and search any directory for find.
allow system_crond_t file_type:{ file lnk_file sock_file fifo_file chr_file blk_file } getattr;
allow system_crond_t file_type:dir { read search getattr };

# Create temporary files.
type system_crond_tmp_t, file_type, sysadmfile, tmpfile;

#line 5036

#line 5036

#line 5036

#line 5036
#
#line 5036
# Allow the process to modify the directory.
#line 5036
#
#line 5036
allow system_crond_t { tmp_t crond_tmp_t }:dir { read getattr lock search ioctl add_name remove_name write };
#line 5036

#line 5036
#
#line 5036
# Allow the process to create the file.
#line 5036
#
#line 5036

#line 5036
allow system_crond_t system_crond_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 5036
allow system_crond_t system_crond_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 5036

#line 5036

#line 5036

#line 5036
type_transition system_crond_t { tmp_t crond_tmp_t }:dir system_crond_tmp_t;
#line 5036
type_transition system_crond_t { tmp_t crond_tmp_t }:{ file lnk_file sock_file fifo_file } system_crond_tmp_t;
#line 5036

#line 5036

#line 5036


# /sbin/runlevel ask for w access to utmp, but will operate
# correctly without it.  Do not audit write denials to utmp.
dontaudit system_crond_t initrc_var_run_t:file { read write };

# Access accounting summary files.
allow system_crond_t var_log_sa_t:file { create ioctl read getattr lock write setattr append link unlink rename };
allow system_crond_t var_log_sa_t:dir { read getattr lock search ioctl add_name remove_name write };

# Access other spool directories like
# /var/spool/anacron and /var/spool/slrnpull.
allow system_crond_t var_spool_t:file { create ioctl read getattr lock write setattr append link unlink rename };
allow system_crond_t var_spool_t:dir { read getattr lock search ioctl add_name remove_name write };

# Do not audit attempts to search unlabeled directories (e.g. slocate).
dontaudit system_crond_t unlabeled_t:dir { read getattr lock search ioctl };
dontaudit system_crond_t unlabeled_t:file { read getattr lock ioctl };

# Determine the set of legal user SIDs that can be reached.
allow crond_t security_t:security { sid_to_context context_to_sid get_user_sids };


# please verify later time added to make it work in enforcement mode Mike 
allow crond_t any_socket_t:udp_socket { sendto };
allow crond_t crond_t:tcp_socket { bind connect create read write };
allow crond_t crond_t:udp_socket { bind create read setopt write };
allow crond_t netif_eth0_t:netif { tcp_send udp_send };
allow crond_t netmsg_eth0_t:tcp_socket { connectto recvfrom };
allow crond_t netmsg_eth0_t:udp_socket { recvfrom };
allow crond_t node_t:node { tcp_send udp_send };
allow crond_t port_t:tcp_socket { name_bind };
allow crond_t port_t:udp_socket { name_bind };
allow crond_t var_yp_t:dir { search };
allow crond_t var_yp_t:file { read };
allow system_crond_t devpts_t:dir { getattr };
allow system_crond_t devpts_t:filesystem { getattr };
allow system_crond_t etc_t:lnk_file { read };
allow system_crond_t fs_t:filesystem { getattr };
allow system_crond_t initrc_var_run_t:file { lock };
allow system_crond_t lib_t:file { execute execute_no_trans ioctl read };
allow system_crond_t proc_t:filesystem { getattr };
allow system_crond_t proc_t:lnk_file { read };
allow system_crond_t sysctl_kernel_t:dir { search };
allow system_crond_t sysctl_kernel_t:file { getattr read };
allow system_crond_t sysctl_t:dir { search };
allow system_crond_t sysctl_t:file { getattr read };
allow system_crond_t usr_t:file { read };
allow crond_t var_spool_t:file { execute getattr read };
allow system_crond_t nfs_t:dir { getattr };








#DESC Crontab - Crontab manipulation programs
#
# Domains for the crontab program.
#

# Type for the crontab executable.
type crontab_exec_t, file_type, sysadmfile, exec_type;

# Everything else is in the crontab_domain macro in
# macros/program/crontab_macros.te.
#DESC DHCPC - DHCP client
#
# Authors:  Wayne Salamon (NAI Labs) <wsalamon@tislabs.com>
#

#################################
#
# Rules for the dhcpc_t domain.
#
# dhcpc_t is the domain for the client side of DHCP. dhcpcd, the DHCP 
# network configurator daemon started by /etc/sysconfig/network-scripts 
# rc scripts, runs in this domain.
# dhcpc_exec_t is the type of the dhcpcd executable.
# The dhcpc_t can be used for other DHCPC related files as well.
#
type dhcpc_t, domain, privlog;
role system_r types dhcpc_t;

#line 5121

#line 5121
# Grant the permissions common to the test domains.
#line 5121

#line 5121
# Grant permissions within the domain.
#line 5121

#line 5121
# Access other processes in the same domain.
#line 5121
allow dhcpc_t self:process *;
#line 5121

#line 5121
# Access /proc/PID files for processes in the same domain.
#line 5121
allow dhcpc_t self:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5121

#line 5121
# Access file descriptions, pipes, and sockets
#line 5121
# created by processes in the same domain.
#line 5121
allow dhcpc_t self:fd *;
#line 5121
allow dhcpc_t self:fifo_file { ioctl read getattr lock write append };
#line 5121
allow dhcpc_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 5121
allow dhcpc_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 5121

#line 5121
# Allow the domain to communicate with other processes in the same domain.
#line 5121
allow dhcpc_t self:unix_dgram_socket sendto;
#line 5121
allow dhcpc_t self:unix_stream_socket connectto;
#line 5121

#line 5121
# Access System V IPC objects created by processes in the same domain.
#line 5121
allow dhcpc_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 5121
allow dhcpc_t self:msg  { send receive };
#line 5121
allow dhcpc_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 5121
allow dhcpc_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 5121

#line 5121

#line 5121

#line 5121
# Grant read/search permissions to most of /proc.
#line 5121

#line 5121
# Read system information files in /proc.
#line 5121
allow dhcpc_t proc_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t proc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5121

#line 5121
# Stat /proc/kmsg and /proc/kcore.
#line 5121
allow dhcpc_t proc_kmsg_t:file { getattr };
#line 5121
allow dhcpc_t proc_kcore_t:file { getattr };
#line 5121

#line 5121
# Read system variables in /proc/sys.
#line 5121
allow dhcpc_t sysctl_modprobe_t:file { read getattr lock ioctl };
#line 5121
allow dhcpc_t sysctl_t:file { read getattr lock ioctl };
#line 5121
allow dhcpc_t sysctl_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t sysctl_fs_t:file { read getattr lock ioctl };
#line 5121
allow dhcpc_t sysctl_fs_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t sysctl_kernel_t:file { read getattr lock ioctl };
#line 5121
allow dhcpc_t sysctl_kernel_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t sysctl_net_t:file { read getattr lock ioctl };
#line 5121
allow dhcpc_t sysctl_net_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t sysctl_vm_t:file { read getattr lock ioctl };
#line 5121
allow dhcpc_t sysctl_vm_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t sysctl_dev_t:file { read getattr lock ioctl };
#line 5121
allow dhcpc_t sysctl_dev_t:dir { read getattr lock search ioctl };
#line 5121

#line 5121

#line 5121
# Grant read/search permissions to many system file types.
#line 5121

#line 5121

#line 5121
# Get attributes of file systems.
#line 5121
allow dhcpc_t fs_type:filesystem getattr;
#line 5121

#line 5121

#line 5121
# Read /.
#line 5121
allow dhcpc_t root_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t root_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5121

#line 5121
# Read /home.
#line 5121
allow dhcpc_t home_root_t:dir { read getattr lock search ioctl };
#line 5121

#line 5121
# Read /usr.
#line 5121
allow dhcpc_t usr_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t usr_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5121

#line 5121
# Read bin and sbin directories.
#line 5121
allow dhcpc_t bin_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5121
allow dhcpc_t sbin_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5121

#line 5121

#line 5121
# Read directories and files with the readable_t type.
#line 5121
# This type is a general type for "world"-readable files.
#line 5121
allow dhcpc_t readable_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t readable_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5121

#line 5121
# Stat /...security and lost+found.
#line 5121
allow dhcpc_t file_labels_t:dir getattr;
#line 5121
allow dhcpc_t lost_found_t:dir getattr;
#line 5121

#line 5121
# Read the devpts root directory.  
#line 5121
allow dhcpc_t devpts_t:dir { read getattr lock search ioctl };
#line 5121

#line 5121

#line 5121
# Read the /tmp directory and any /tmp files with the base type.
#line 5121
# Temporary files created at runtime will typically use derived types.
#line 5121
allow dhcpc_t tmp_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t tmp_t:{ file lnk_file } { read getattr lock ioctl };
#line 5121

#line 5121
# Read /var.
#line 5121
allow dhcpc_t var_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t var_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5121

#line 5121
# Read /var/catman.
#line 5121
allow dhcpc_t catman_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t catman_t:{ file lnk_file } { read getattr lock ioctl };
#line 5121

#line 5121
# Read /var/lib.
#line 5121
allow dhcpc_t var_lib_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t var_lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5121
allow dhcpc_t var_lib_nfs_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t var_lib_nfs_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5121

#line 5121

#line 5121
allow dhcpc_t tetex_data_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t tetex_data_t:{ file lnk_file } { read getattr lock ioctl };
#line 5121

#line 5121

#line 5121
# Read /var/yp.
#line 5121
allow dhcpc_t var_yp_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t var_yp_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5121

#line 5121
# Read /var/spool.
#line 5121
allow dhcpc_t var_spool_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t var_spool_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5121

#line 5121
# Read /var/run, /var/lock, /var/log.
#line 5121
allow dhcpc_t var_run_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t var_run_t:{ file lnk_file } { read getattr lock ioctl };
#line 5121
allow dhcpc_t var_log_t:dir { read getattr lock search ioctl };
#line 5121
#allow dhcpc_t var_log_t:{ file lnk_file } r_file_perms;
#line 5121
allow dhcpc_t var_log_sa_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t var_log_sa_t:{ file lnk_file } { read getattr lock ioctl };
#line 5121
allow dhcpc_t var_log_ksyms_t:{ file lnk_file } { read getattr lock ioctl };
#line 5121

#line 5121
allow dhcpc_t var_lock_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t var_lock_t:{ file lnk_file } { read getattr lock ioctl };
#line 5121

#line 5121
# Read /var/run/utmp and /var/log/wtmp.
#line 5121
allow dhcpc_t initrc_var_run_t:file { read getattr lock ioctl };
#line 5121
allow dhcpc_t wtmp_t:file { read getattr lock ioctl };
#line 5121

#line 5121
# Read /boot, /boot/System.map*, and /vmlinuz*
#line 5121
allow dhcpc_t boot_t:dir { search getattr };
#line 5121
allow dhcpc_t boot_t:file getattr;
#line 5121
allow dhcpc_t system_map_t:{ file lnk_file } { read getattr lock ioctl };
#line 5121

#line 5121
allow dhcpc_t boot_t:lnk_file read;
#line 5121

#line 5121
# Read /etc.
#line 5121
allow dhcpc_t etc_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t etc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5121
allow dhcpc_t etc_runtime_t:{ file lnk_file } { read getattr lock ioctl };
#line 5121
allow dhcpc_t etc_aliases_t:{ file lnk_file } { read getattr lock ioctl };
#line 5121
allow dhcpc_t etc_mail_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t etc_mail_t:{ file lnk_file } { read getattr lock ioctl };
#line 5121
allow dhcpc_t resolv_conf_t:{ file lnk_file } { read getattr lock ioctl };
#line 5121
allow dhcpc_t ld_so_cache_t:file { read getattr lock ioctl };
#line 5121

#line 5121
# Read /lib.
#line 5121
allow dhcpc_t lib_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5121

#line 5121
# Read the linker, shared library, and executable types.
#line 5121
allow dhcpc_t ld_so_t:{ file lnk_file } { read getattr lock ioctl };
#line 5121
allow dhcpc_t shlib_t:{ file lnk_file } { read getattr lock ioctl };
#line 5121
allow dhcpc_t exec_type:{ file lnk_file } { read getattr lock ioctl };
#line 5121

#line 5121
# Read man directories and files.
#line 5121
allow dhcpc_t man_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t man_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5121

#line 5121
# Read /usr/src.
#line 5121
allow dhcpc_t src_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t src_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5121

#line 5121
# Read module-related files.
#line 5121
allow dhcpc_t modules_object_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t modules_object_t:{ file lnk_file } { read getattr lock ioctl };
#line 5121
allow dhcpc_t modules_dep_t:{ file lnk_file } { read getattr lock ioctl };
#line 5121
allow dhcpc_t modules_conf_t:{ file lnk_file} { read getattr lock ioctl };
#line 5121

#line 5121
# Read /dev directories and any symbolic links.
#line 5121
allow dhcpc_t device_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t device_t:lnk_file { read getattr lock ioctl };
#line 5121

#line 5121
# Read /dev/random and /dev/zero.
#line 5121
allow dhcpc_t random_device_t:chr_file { read getattr lock ioctl };
#line 5121
allow dhcpc_t zero_device_t:chr_file { read getattr lock ioctl };
#line 5121

#line 5121
# Read the root directory of a tmpfs filesytem and any symbolic links.
#line 5121
allow dhcpc_t tmpfs_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t tmpfs_t:lnk_file { read getattr lock ioctl };
#line 5121

#line 5121
# Read any symbolic links on a devfs file system.
#line 5121
allow dhcpc_t device_t:lnk_file { read getattr lock ioctl };
#line 5121

#line 5121
# Read the root directory of a usbdevfs filesystem, and
#line 5121
# the devices and drivers files.  Permit stating of the
#line 5121
# device nodes, but nothing else.
#line 5121
allow dhcpc_t usbdevfs_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t usbdevfs_t:{ file lnk_file } { read getattr lock ioctl };
#line 5121
allow dhcpc_t usbdevfs_device_t:file getattr;
#line 5121

#line 5121

#line 5121
# Grant write permissions to a small set of system file types.
#line 5121
# No permission to create files is granted here.  Use allow rules to grant 
#line 5121
# create permissions to a type or use file_type_auto_trans rules to set up
#line 5121
# new types for files.
#line 5121

#line 5121

#line 5121
# Read and write /dev/tty and /dev/null.
#line 5121
allow dhcpc_t devtty_t:chr_file { ioctl read getattr lock write append };
#line 5121
allow dhcpc_t { null_device_t zero_device_t }:chr_file { ioctl read getattr lock write append };
#line 5121

#line 5121
# Do not audit write denials to /etc/ld.so.cache.
#line 5121
dontaudit dhcpc_t ld_so_cache_t:file write;
#line 5121

#line 5121

#line 5121
# Execute from the system shared libraries.
#line 5121
# No permission to execute anything else is granted here.
#line 5121
# Use can_exec or can_exec_any to grant the ability to execute within a domain.
#line 5121
# Use domain_auto_trans for executing and changing domains.
#line 5121

#line 5121
allow dhcpc_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t ld_so_t:file { read getattr lock execute ioctl };
#line 5121
allow dhcpc_t ld_so_t:file execute_no_trans;
#line 5121
allow dhcpc_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 5121
allow dhcpc_t shlib_t:file { read getattr lock execute ioctl };
#line 5121
allow dhcpc_t shlib_t:lnk_file { read getattr lock ioctl };
#line 5121
allow dhcpc_t ld_so_cache_t:file { read getattr lock ioctl };
#line 5121
allow dhcpc_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 5121

#line 5121

#line 5121
# read localization information
#line 5121
allow dhcpc_t locale_t:dir { read getattr lock search ioctl };
#line 5121
allow dhcpc_t locale_t:{file lnk_file} { read getattr lock ioctl };
#line 5121

#line 5121
# Obtain the context of any SID, the SID for any context, 
#line 5121
# and the list of active SIDs.
#line 5121
allow dhcpc_t security_t:security { sid_to_context context_to_sid get_sids };
#line 5121

#line 5121

#line 5121

#line 5121
# Grant permissions needed to create TCP and UDP sockets and 
#line 5121
# to access the network.
#line 5121

#line 5121
#
#line 5121
# Allow the domain to create and use UDP and TCP sockets.
#line 5121
# Other kinds of sockets must be separately authorized for use.
#line 5121
allow dhcpc_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 5121
allow dhcpc_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 5121

#line 5121
#
#line 5121
# Allow the domain to send UDP packets.
#line 5121
# Since the destination sockets type is unknown, the generic
#line 5121
# any_socket_t type is used as a placeholder.
#line 5121
#
#line 5121
allow dhcpc_t any_socket_t:udp_socket sendto;
#line 5121

#line 5121
#
#line 5121
# Allow the domain to send using any network interface.
#line 5121
# netif_type is a type attribute for all network interface types.
#line 5121
#
#line 5121
allow dhcpc_t netif_type:netif { tcp_send udp_send rawip_send };
#line 5121

#line 5121
#
#line 5121
# Allow packets sent by the domain to be received on any network interface.
#line 5121
#
#line 5121
allow dhcpc_t netif_type:netif { tcp_recv udp_recv rawip_recv };
#line 5121

#line 5121
#
#line 5121
# Allow the domain to receive packets from any network interface.
#line 5121
# netmsg_type is a type attribute for all default message types.
#line 5121
#
#line 5121
allow dhcpc_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
#line 5121

#line 5121
#
#line 5121
# Allow the domain to initiate or accept TCP connections 
#line 5121
# on any network interface.
#line 5121
#
#line 5121
allow dhcpc_t netmsg_type:tcp_socket { connectto acceptfrom };
#line 5121

#line 5121
#
#line 5121
# Receive resets from the TCP reset socket.
#line 5121
# The TCP reset socket is labeled with the tcp_socket_t type.
#line 5121
#
#line 5121
allow dhcpc_t tcp_socket_t:tcp_socket recvfrom;
#line 5121

#line 5121
dontaudit dhcpc_t tcp_socket_t:tcp_socket connectto;
#line 5121

#line 5121
#
#line 5121
# Allow the domain to send to any node.
#line 5121
# node_type is a type attribute for all node types.
#line 5121
#
#line 5121
allow dhcpc_t node_type:node { tcp_send udp_send rawip_send };
#line 5121

#line 5121
#
#line 5121
# Allow packets sent by the domain to be received from any node.
#line 5121
#
#line 5121
allow dhcpc_t node_type:node { tcp_recv udp_recv rawip_recv };
#line 5121

#line 5121
#
#line 5121
# Allow the domain to send NFS client requests via the socket
#line 5121
# created by mount.
#line 5121
#
#line 5121
allow dhcpc_t mount_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 5121

#line 5121
#
#line 5121
# Bind to the default port type.
#line 5121
# Other port types must be separately authorized.
#line 5121
#
#line 5121
allow dhcpc_t port_t:udp_socket name_bind;
#line 5121
allow dhcpc_t port_t:tcp_socket name_bind;
#line 5121

#line 5121

type dhcpc_exec_t, file_type, sysadmfile, exec_type;

#line 5123

#line 5123

#line 5123
#
#line 5123
# Allow the process to transition to the new domain.
#line 5123
#
#line 5123
allow initrc_t dhcpc_t:process transition;
#line 5123

#line 5123
#
#line 5123
# Allow the process to execute the program.
#line 5123
# 
#line 5123
allow initrc_t dhcpc_exec_t:file { getattr execute };
#line 5123

#line 5123
#
#line 5123
# Allow the process to reap the new domain.
#line 5123
#
#line 5123
allow dhcpc_t initrc_t:process sigchld;
#line 5123

#line 5123
#
#line 5123
# Allow the new domain to inherit and use file 
#line 5123
# descriptions from the creating process and vice versa.
#line 5123
#
#line 5123
allow dhcpc_t initrc_t:fd use;
#line 5123
allow initrc_t dhcpc_t:fd use;
#line 5123

#line 5123
#
#line 5123
# Allow the new domain to write back to the old domain via a pipe.
#line 5123
#
#line 5123
allow dhcpc_t initrc_t:fifo_file { ioctl read getattr lock write append };
#line 5123

#line 5123
#
#line 5123
# Allow the new domain to read and execute the program.
#line 5123
#
#line 5123
allow dhcpc_t dhcpc_exec_t:file { read getattr lock execute ioctl };
#line 5123

#line 5123
#
#line 5123
# Allow the new domain to be entered via the program.
#line 5123
#
#line 5123
allow dhcpc_t dhcpc_exec_t:file entrypoint;
#line 5123

#line 5123
type_transition initrc_t dhcpc_exec_t:process dhcpc_t;
#line 5123


#line 5128


# for the dhcp client to run ping to check IP addresses
#line 5137


# Type for files created during execution of dhcpcd.
type var_run_dhcpc_t, file_type, sysadmfile, pidfile;
#line 5142
type dhcp_state_t, file_type, sysadmfile;
type dhcpc_state_t, file_type, sysadmfile;
type etc_dhcpc_t, file_type, sysadmfile;

#line 5145

#line 5145

#line 5145

#line 5145
#
#line 5145
# Allow the process to modify the directory.
#line 5145
#
#line 5145
allow dhcpc_t var_run_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 5145

#line 5145
#
#line 5145
# Allow the process to create the file.
#line 5145
#
#line 5145

#line 5145
allow dhcpc_t var_run_dhcpc_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 5145
allow dhcpc_t var_run_dhcpc_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 5145

#line 5145

#line 5145

#line 5145
type_transition dhcpc_t var_run_t:dir var_run_dhcpc_t;
#line 5145
type_transition dhcpc_t var_run_t:{ file lnk_file sock_file fifo_file } var_run_dhcpc_t;
#line 5145

#line 5145

#line 5145


# Inherit and use descriptors from init.
allow dhcpc_t init_t:fd use;

# Use capabilities
allow dhcpc_t self:capability { net_admin net_raw net_bind_service };

# Allow read/write to /etc/resolv.conf. Note that any files in /etc 
# created by dhcpcd will be labelled resolv_conf_t. As of RH 7.2, no
# other files are accessed in the /etc dir, only in /etc/dhcpc dir.

#line 5156

#line 5156

#line 5156

#line 5156
#
#line 5156
# Allow the process to modify the directory.
#line 5156
#
#line 5156
allow dhcpc_t etc_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 5156

#line 5156
#
#line 5156
# Allow the process to create the file.
#line 5156
#
#line 5156

#line 5156
allow dhcpc_t resolv_conf_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 5156
allow dhcpc_t resolv_conf_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 5156

#line 5156

#line 5156

#line 5156
type_transition dhcpc_t etc_t:dir resolv_conf_t;
#line 5156
type_transition dhcpc_t etc_t:{ file lnk_file sock_file fifo_file } resolv_conf_t;
#line 5156

#line 5156

#line 5156


# Allow access to the dhcpc file types
allow dhcpc_t etc_dhcpc_t:file { ioctl read getattr lock write append };
allow dhcpc_t etc_dhcpc_t:dir { read getattr lock search ioctl add_name remove_name write };

#line 5161
allow dhcpc_t { dhcpc_exec_t etc_dhcpc_t sbin_t }:file { { read getattr lock execute ioctl } execute_no_trans };
#line 5161


#line 5162

#line 5162

#line 5162
#
#line 5162
# Allow the process to transition to the new domain.
#line 5162
#
#line 5162
allow dhcpc_t ifconfig_t:process transition;
#line 5162

#line 5162
#
#line 5162
# Allow the process to execute the program.
#line 5162
# 
#line 5162
allow dhcpc_t ifconfig_exec_t:file { getattr execute };
#line 5162

#line 5162
#
#line 5162
# Allow the process to reap the new domain.
#line 5162
#
#line 5162
allow ifconfig_t dhcpc_t:process sigchld;
#line 5162

#line 5162
#
#line 5162
# Allow the new domain to inherit and use file 
#line 5162
# descriptions from the creating process and vice versa.
#line 5162
#
#line 5162
allow ifconfig_t dhcpc_t:fd use;
#line 5162
allow dhcpc_t ifconfig_t:fd use;
#line 5162

#line 5162
#
#line 5162
# Allow the new domain to write back to the old domain via a pipe.
#line 5162
#
#line 5162
allow ifconfig_t dhcpc_t:fifo_file { ioctl read getattr lock write append };
#line 5162

#line 5162
#
#line 5162
# Allow the new domain to read and execute the program.
#line 5162
#
#line 5162
allow ifconfig_t ifconfig_exec_t:file { read getattr lock execute ioctl };
#line 5162

#line 5162
#
#line 5162
# Allow the new domain to be entered via the program.
#line 5162
#
#line 5162
allow ifconfig_t ifconfig_exec_t:file entrypoint;
#line 5162

#line 5162
type_transition dhcpc_t ifconfig_exec_t:process ifconfig_t;
#line 5162

# because dhclient is buggy and does not close file handles
dontaudit ifconfig_t dhcpc_t:{ packet_socket udp_socket } { read write };
dontaudit ifconfig_t dhcpc_state_t:file { read write };

# Allow dhcpc_t to use packet sockets
allow dhcpc_t self:packet_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
allow dhcpc_t self:packet_socket recvfrom;
allow dhcpc_t netmsg_eth0_t:packet_socket { recvfrom };
allow dhcpc_t icmp_socket_t:packet_socket { recvfrom };

#line 5172

#line 5172

#line 5172

#line 5172
#
#line 5172
# Allow the process to modify the directory.
#line 5172
#
#line 5172
allow dhcpc_t dhcp_state_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 5172

#line 5172
#
#line 5172
# Allow the process to create the file.
#line 5172
#
#line 5172

#line 5172
allow dhcpc_t dhcpc_state_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 5172
allow dhcpc_t dhcpc_state_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 5172

#line 5172

#line 5172

#line 5172
type_transition dhcpc_t dhcp_state_t:dir dhcpc_state_t;
#line 5172
type_transition dhcpc_t dhcp_state_t:{ file lnk_file sock_file fifo_file } dhcpc_state_t;
#line 5172

#line 5172

#line 5172



#line 5174
allow dhcpc_t { bin_t shell_exec_t }:file { { read getattr lock execute ioctl } execute_no_trans };
#line 5174

# need to modify later  
allow dhcpc_t crond_t:packet_socket { recvfrom };
allow dhcpc_t sysadm_t:packet_socket { recvfrom };
allow dhcpc_t tcp_socket_t:packet_socket { recvfrom };
allow dhcpc_t user_t:packet_socket { recvfrom };
allow dhcpc_t cougaar_t:packet_socket { recvfrom };
allow dhcpc_t initrc_t:packet_socket { recvfrom };
allow dhcpc_t sshd_t:packet_socket { recvfrom };
allow dhcpc_t mount_t:packet_socket { recvfrom };
allow dhcpc_t newrole_t:packet_socket { recvfrom };
allow dhcpc_t initrc_exec_t:file { execute };
allow dhcpc_t local_login_t:packet_socket { recvfrom };
allow dhcpc_t syslogd_t:packet_socket { recvfrom };
allow dhcpc_t var_spool_t:file { execute };

allow dhcpc_t dhcpc_t:capability { sys_admin };

# added to run society under acme
allow dhcpc_t acme_t:packet_socket { recvfrom };
allow dhcpc_t sysadm_su_t:packet_socket { recvfrom };


#DESC Fsadm - Disk and file system administration
#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
#

#################################
#
# Rules for the fsadm_t domain.
#
# fsadm_t is the domain for disk and file system
# administration.
# fsadm_exec_t is the type of the corresponding programs.
#
type fsadm_t, domain, privlog;
role system_r types fsadm_t;
role sysadm_r types fsadm_t;


#line 5214
# Access other processes in the same domain.
#line 5214
allow fsadm_t self:process *;
#line 5214

#line 5214
# Access /proc/PID files for processes in the same domain.
#line 5214
allow fsadm_t self:dir { read getattr lock search ioctl };
#line 5214
allow fsadm_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5214

#line 5214
# Access file descriptions, pipes, and sockets
#line 5214
# created by processes in the same domain.
#line 5214
allow fsadm_t self:fd *;
#line 5214
allow fsadm_t self:fifo_file { ioctl read getattr lock write append };
#line 5214
allow fsadm_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 5214
allow fsadm_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 5214

#line 5214
# Allow the domain to communicate with other processes in the same domain.
#line 5214
allow fsadm_t self:unix_dgram_socket sendto;
#line 5214
allow fsadm_t self:unix_stream_socket connectto;
#line 5214

#line 5214
# Access System V IPC objects created by processes in the same domain.
#line 5214
allow fsadm_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 5214
allow fsadm_t self:msg  { send receive };
#line 5214
allow fsadm_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 5214
allow fsadm_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 5214

#line 5214


# Read system information files in /proc.
allow fsadm_t proc_t:dir { read getattr lock search ioctl };
allow fsadm_t proc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };

# Read system variables in /proc/sys
allow fsadm_t sysctl_kernel_t:file { read getattr lock ioctl };
allow fsadm_t sysctl_kernel_t:dir { read getattr lock search ioctl };


#line 5224
# Read /.
#line 5224
allow fsadm_t root_t:dir { read getattr lock search ioctl };
#line 5224
allow fsadm_t root_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5224

#line 5224
# Read /home.
#line 5224
allow fsadm_t home_root_t:dir { read getattr lock search ioctl };
#line 5224

#line 5224
# Read /usr.
#line 5224
allow fsadm_t usr_t:dir { read getattr lock search ioctl };
#line 5224
allow fsadm_t usr_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5224

#line 5224
# Read bin and sbin directories.
#line 5224
allow fsadm_t bin_t:dir { read getattr lock search ioctl };
#line 5224
allow fsadm_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5224
allow fsadm_t sbin_t:dir { read getattr lock search ioctl };
#line 5224
allow fsadm_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5224


# Read /etc.
allow fsadm_t etc_t:dir { read getattr lock search ioctl };
allow fsadm_t etc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };

# Read module-related files.
allow fsadm_t modules_conf_t:{ file lnk_file } { read getattr lock ioctl };

# Read /dev directories and any symbolic links.
allow fsadm_t device_t:dir { read getattr lock search ioctl };
allow fsadm_t device_t:lnk_file { read getattr lock ioctl };


#line 5237
allow fsadm_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 5237
allow fsadm_t ld_so_t:file { read getattr lock execute ioctl };
#line 5237
allow fsadm_t ld_so_t:file execute_no_trans;
#line 5237
allow fsadm_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 5237
allow fsadm_t shlib_t:file { read getattr lock execute ioctl };
#line 5237
allow fsadm_t shlib_t:lnk_file { read getattr lock ioctl };
#line 5237
allow fsadm_t ld_so_cache_t:file { read getattr lock ioctl };
#line 5237
allow fsadm_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 5237


type fsadm_exec_t, file_type, sysadmfile, exec_type;

#line 5240

#line 5240

#line 5240
#
#line 5240
# Allow the process to transition to the new domain.
#line 5240
#
#line 5240
allow initrc_t fsadm_t:process transition;
#line 5240

#line 5240
#
#line 5240
# Allow the process to execute the program.
#line 5240
# 
#line 5240
allow initrc_t fsadm_exec_t:file { getattr execute };
#line 5240

#line 5240
#
#line 5240
# Allow the process to reap the new domain.
#line 5240
#
#line 5240
allow fsadm_t initrc_t:process sigchld;
#line 5240

#line 5240
#
#line 5240
# Allow the new domain to inherit and use file 
#line 5240
# descriptions from the creating process and vice versa.
#line 5240
#
#line 5240
allow fsadm_t initrc_t:fd use;
#line 5240
allow initrc_t fsadm_t:fd use;
#line 5240

#line 5240
#
#line 5240
# Allow the new domain to write back to the old domain via a pipe.
#line 5240
#
#line 5240
allow fsadm_t initrc_t:fifo_file { ioctl read getattr lock write append };
#line 5240

#line 5240
#
#line 5240
# Allow the new domain to read and execute the program.
#line 5240
#
#line 5240
allow fsadm_t fsadm_exec_t:file { read getattr lock execute ioctl };
#line 5240

#line 5240
#
#line 5240
# Allow the new domain to be entered via the program.
#line 5240
#
#line 5240
allow fsadm_t fsadm_exec_t:file entrypoint;
#line 5240

#line 5240
type_transition initrc_t fsadm_exec_t:process fsadm_t;
#line 5240


#line 5241

#line 5241

#line 5241
#
#line 5241
# Allow the process to transition to the new domain.
#line 5241
#
#line 5241
allow sysadm_t fsadm_t:process transition;
#line 5241

#line 5241
#
#line 5241
# Allow the process to execute the program.
#line 5241
# 
#line 5241
allow sysadm_t fsadm_exec_t:file { getattr execute };
#line 5241

#line 5241
#
#line 5241
# Allow the process to reap the new domain.
#line 5241
#
#line 5241
allow fsadm_t sysadm_t:process sigchld;
#line 5241

#line 5241
#
#line 5241
# Allow the new domain to inherit and use file 
#line 5241
# descriptions from the creating process and vice versa.
#line 5241
#
#line 5241
allow fsadm_t sysadm_t:fd use;
#line 5241
allow sysadm_t fsadm_t:fd use;
#line 5241

#line 5241
#
#line 5241
# Allow the new domain to write back to the old domain via a pipe.
#line 5241
#
#line 5241
allow fsadm_t sysadm_t:fifo_file { ioctl read getattr lock write append };
#line 5241

#line 5241
#
#line 5241
# Allow the new domain to read and execute the program.
#line 5241
#
#line 5241
allow fsadm_t fsadm_exec_t:file { read getattr lock execute ioctl };
#line 5241

#line 5241
#
#line 5241
# Allow the new domain to be entered via the program.
#line 5241
#
#line 5241
allow fsadm_t fsadm_exec_t:file entrypoint;
#line 5241

#line 5241
type_transition sysadm_t fsadm_exec_t:process fsadm_t;
#line 5241


type fsadm_tmp_t, file_type, sysadmfile, tmpfile;

#line 5244

#line 5244

#line 5244

#line 5244
#
#line 5244
# Allow the process to modify the directory.
#line 5244
#
#line 5244
allow fsadm_t tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 5244

#line 5244
#
#line 5244
# Allow the process to create the file.
#line 5244
#
#line 5244

#line 5244
allow fsadm_t fsadm_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 5244
allow fsadm_t fsadm_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 5244

#line 5244

#line 5244

#line 5244
type_transition fsadm_t tmp_t:dir fsadm_tmp_t;
#line 5244
type_transition fsadm_t tmp_t:{ file lnk_file sock_file fifo_file } fsadm_tmp_t;
#line 5244

#line 5244

#line 5244


# remount file system to apply changes
allow fsadm_t fs_t:filesystem remount;

# Use capabilities.  ipc_lock is for losetup
allow fsadm_t self:capability { ipc_lock sys_rawio sys_admin };

# Write to /etc/mtab.

#line 5253

#line 5253

#line 5253

#line 5253
#
#line 5253
# Allow the process to modify the directory.
#line 5253
#
#line 5253
allow fsadm_t etc_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 5253

#line 5253
#
#line 5253
# Allow the process to create the file.
#line 5253
#
#line 5253

#line 5253
allow fsadm_t etc_runtime_t:file { create ioctl read getattr lock write setattr append link unlink rename };
#line 5253

#line 5253

#line 5253

#line 5253
type_transition fsadm_t etc_t:file etc_runtime_t;
#line 5253

#line 5253

#line 5253


# Inherit and use descriptors from init.
allow fsadm_t init_t:fd use;

# Run other fs admin programs in the fsadm_t domain.

#line 5259
allow fsadm_t fsadm_exec_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 5259


# Access disk devices.
allow fsadm_t fixed_disk_device_t:{ chr_file blk_file } { ioctl read getattr lock write append };
allow fsadm_t removable_device_t:{ chr_file blk_file } { ioctl read getattr lock write append };

# Access lost+found.
allow fsadm_t lost_found_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
allow fsadm_t lost_found_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };

# Recreate /mnt/cdrom. 
allow fsadm_t file_t:dir { search read getattr rmdir create };

# Recreate /dev/cdrom.
allow fsadm_t device_t:dir { read getattr lock search ioctl add_name remove_name write };
allow fsadm_t device_t:lnk_file { unlink create };

# Enable swapping to devices and files
allow fsadm_t swapfile_t:file { getattr swapon };
allow fsadm_t fixed_disk_device_t:blk_file { getattr swapon };

# XXX Why does updfstab run insmod?

#line 5281

#line 5281

#line 5281
#
#line 5281
# Allow the process to transition to the new domain.
#line 5281
#
#line 5281
allow fsadm_t insmod_t:process transition;
#line 5281

#line 5281
#
#line 5281
# Allow the process to execute the program.
#line 5281
# 
#line 5281
allow fsadm_t insmod_exec_t:file { getattr execute };
#line 5281

#line 5281
#
#line 5281
# Allow the process to reap the new domain.
#line 5281
#
#line 5281
allow insmod_t fsadm_t:process sigchld;
#line 5281

#line 5281
#
#line 5281
# Allow the new domain to inherit and use file 
#line 5281
# descriptions from the creating process and vice versa.
#line 5281
#
#line 5281
allow insmod_t fsadm_t:fd use;
#line 5281
allow fsadm_t insmod_t:fd use;
#line 5281

#line 5281
#
#line 5281
# Allow the new domain to write back to the old domain via a pipe.
#line 5281
#
#line 5281
allow insmod_t fsadm_t:fifo_file { ioctl read getattr lock write append };
#line 5281

#line 5281
#
#line 5281
# Allow the new domain to read and execute the program.
#line 5281
#
#line 5281
allow insmod_t insmod_exec_t:file { read getattr lock execute ioctl };
#line 5281

#line 5281
#
#line 5281
# Allow the new domain to be entered via the program.
#line 5281
#
#line 5281
allow insmod_t insmod_exec_t:file entrypoint;
#line 5281

#line 5281
type_transition fsadm_t insmod_exec_t:process insmod_t;
#line 5281


# Allow console log change (updfstab)
allow fsadm_t kernel_t:system syslog_console;

# Access terminals.
allow fsadm_t { sysadm_tty_device_t sysadm_devpts_t }:chr_file { ioctl read getattr lock write append };


# read localization information
allow fsadm_t locale_t:dir { read getattr lock search ioctl };
allow fsadm_t locale_t:{file lnk_file} { read getattr lock ioctl };

# Added by us
allow fsadm_t insmod_exec_t:file { read };
allow fsadm_t insmod_exec_t:lnk_file { read };

#DESC Getty - Manage ttys
#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
#

#################################
#
# Rules for the getty_t domain.
#

#line 5307

#line 5307
type getty_t, domain, privlog , mlstrustedwriter, privfd;
#line 5307
type getty_exec_t, file_type, sysadmfile, exec_type;
#line 5307

#line 5307
role system_r types getty_t;
#line 5307

#line 5307

#line 5307

#line 5307

#line 5307
#
#line 5307
# Allow the process to transition to the new domain.
#line 5307
#
#line 5307
allow initrc_t getty_t:process transition;
#line 5307

#line 5307
#
#line 5307
# Allow the process to execute the program.
#line 5307
# 
#line 5307
allow initrc_t getty_exec_t:file { getattr execute };
#line 5307

#line 5307
#
#line 5307
# Allow the process to reap the new domain.
#line 5307
#
#line 5307
allow getty_t initrc_t:process sigchld;
#line 5307

#line 5307
#
#line 5307
# Allow the new domain to inherit and use file 
#line 5307
# descriptions from the creating process and vice versa.
#line 5307
#
#line 5307
allow getty_t initrc_t:fd use;
#line 5307
allow initrc_t getty_t:fd use;
#line 5307

#line 5307
#
#line 5307
# Allow the new domain to write back to the old domain via a pipe.
#line 5307
#
#line 5307
allow getty_t initrc_t:fifo_file { ioctl read getattr lock write append };
#line 5307

#line 5307
#
#line 5307
# Allow the new domain to read and execute the program.
#line 5307
#
#line 5307
allow getty_t getty_exec_t:file { read getattr lock execute ioctl };
#line 5307

#line 5307
#
#line 5307
# Allow the new domain to be entered via the program.
#line 5307
#
#line 5307
allow getty_t getty_exec_t:file entrypoint;
#line 5307

#line 5307
type_transition initrc_t getty_exec_t:process getty_t;
#line 5307

#line 5307

#line 5307
# Inherit and use descriptors from init.
#line 5307
allow getty_t init_t:fd use;
#line 5307
allow getty_t init_t:process sigchld;
#line 5307
allow getty_t privfd:fd use;
#line 5307
allow getty_t newrole_t:process sigchld;
#line 5307
allow getty_t self:process { { sigchld sigkill sigstop signull signal } fork };
#line 5307

#line 5307

#line 5307
allow getty_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 5307
allow getty_t ld_so_t:file { read getattr lock execute ioctl };
#line 5307
allow getty_t ld_so_t:file execute_no_trans;
#line 5307
allow getty_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 5307
allow getty_t shlib_t:file { read getattr lock execute ioctl };
#line 5307
allow getty_t shlib_t:lnk_file { read getattr lock ioctl };
#line 5307
allow getty_t ld_so_cache_t:file { read getattr lock ioctl };
#line 5307
allow getty_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 5307

#line 5307

#line 5307
allow getty_t { self proc_t }:dir { read getattr lock search ioctl };
#line 5307
allow getty_t { self proc_t }:lnk_file read;
#line 5307

#line 5307
allow getty_t device_t:dir { getattr search };
#line 5307
allow getty_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 5307
allow getty_t console_device_t:chr_file { ioctl read getattr lock write append };
#line 5307
allow getty_t initrc_devpts_t:chr_file { ioctl read getattr lock write append };
#line 5307

#line 5307
# Create pid file.
#line 5307
allow getty_t var_t:dir { getattr search };
#line 5307
type var_run_getty_t, file_type, sysadmfile, pidfile;
#line 5307

#line 5307

#line 5307

#line 5307

#line 5307
#
#line 5307
# Allow the process to modify the directory.
#line 5307
#
#line 5307
allow getty_t var_run_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 5307

#line 5307
#
#line 5307
# Allow the process to create the file.
#line 5307
#
#line 5307

#line 5307
allow getty_t var_run_getty_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 5307
allow getty_t var_run_getty_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 5307

#line 5307

#line 5307

#line 5307
type_transition getty_t var_run_t:dir var_run_getty_t;
#line 5307
type_transition getty_t var_run_t:{ file lnk_file sock_file fifo_file } var_run_getty_t;
#line 5307

#line 5307

#line 5307

#line 5307

#line 5307
allow getty_t devtty_t:chr_file { ioctl read getattr lock write append };
#line 5307

#line 5307
# for daemons that look at /root on startup
#line 5307
dontaudit getty_t sysadm_home_dir_t:dir search;
#line 5307

#line 5307
# for df
#line 5307
allow getty_t fs_type:filesystem getattr;
#line 5307


type etc_getty_t, file_type, sysadmfile;

#line 5310
allow getty_t etc_getty_t:dir { read getattr lock search ioctl };
#line 5310
allow getty_t etc_getty_t:{ file lnk_file } { read getattr lock ioctl };
#line 5310


allow getty_t console_device_t:chr_file setattr;


#line 5314
type getty_tmp_t, file_type, sysadmfile, tmpfile ;
#line 5314

#line 5314

#line 5314

#line 5314

#line 5314
#
#line 5314
# Allow the process to modify the directory.
#line 5314
#
#line 5314
allow getty_t tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 5314

#line 5314
#
#line 5314
# Allow the process to create the file.
#line 5314
#
#line 5314

#line 5314
allow getty_t getty_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 5314
allow getty_t getty_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 5314

#line 5314

#line 5314

#line 5314
type_transition getty_t tmp_t:dir getty_tmp_t;
#line 5314
type_transition getty_t tmp_t:{ file lnk_file sock_file fifo_file } getty_tmp_t;
#line 5314

#line 5314

#line 5314

#line 5314


#line 5315
type getty_log_t, file_type, sysadmfile, logfile;
#line 5315

#line 5315

#line 5315

#line 5315

#line 5315
#
#line 5315
# Allow the process to modify the directory.
#line 5315
#
#line 5315
allow getty_t var_log_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 5315

#line 5315
#
#line 5315
# Allow the process to create the file.
#line 5315
#
#line 5315

#line 5315
allow getty_t getty_log_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 5315
allow getty_t getty_log_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 5315

#line 5315

#line 5315

#line 5315
type_transition getty_t var_log_t:dir getty_log_t;
#line 5315
type_transition getty_t var_log_t:{ file lnk_file sock_file fifo_file } getty_log_t;
#line 5315

#line 5315

#line 5315

#line 5315


allow getty_t { etc_t etc_runtime_t }:file { getattr read };
allow getty_t etc_t:lnk_file read;
allow getty_t self:process { getpgid getsession };
allow getty_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
allow getty_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };

# for ldap and other authentication services
allow getty_t resolv_conf_t:file { getattr read };

# to allow w to display everyone...
#allow userdomain ttyfile:chr_file getattr;

# Use capabilities.
allow getty_t getty_t:capability { dac_override chown sys_tty_config };

# fbgetty needs fsetid for some reason
allow getty_t getty_t:capability fsetid;

# Run getty in its own domain.

#line 5336

#line 5336

#line 5336
#
#line 5336
# Allow the process to transition to the new domain.
#line 5336
#
#line 5336
allow init_t getty_t:process transition;
#line 5336

#line 5336
#
#line 5336
# Allow the process to execute the program.
#line 5336
# 
#line 5336
allow init_t getty_exec_t:file { getattr execute };
#line 5336

#line 5336
#
#line 5336
# Allow the process to reap the new domain.
#line 5336
#
#line 5336
allow getty_t init_t:process sigchld;
#line 5336

#line 5336
#
#line 5336
# Allow the new domain to inherit and use file 
#line 5336
# descriptions from the creating process and vice versa.
#line 5336
#
#line 5336
allow getty_t init_t:fd use;
#line 5336
allow init_t getty_t:fd use;
#line 5336

#line 5336
#
#line 5336
# Allow the new domain to write back to the old domain via a pipe.
#line 5336
#
#line 5336
allow getty_t init_t:fifo_file { ioctl read getattr lock write append };
#line 5336

#line 5336
#
#line 5336
# Allow the new domain to read and execute the program.
#line 5336
#
#line 5336
allow getty_t getty_exec_t:file { read getattr lock execute ioctl };
#line 5336

#line 5336
#
#line 5336
# Allow the new domain to be entered via the program.
#line 5336
#
#line 5336
allow getty_t getty_exec_t:file entrypoint;
#line 5336

#line 5336
type_transition init_t getty_exec_t:process getty_t;
#line 5336


# Inherit and use descriptors from init.
allow getty_t init_t:fd use;

# Run login in local_login_t domain.
allow getty_t bin_t:dir search;

#line 5343

#line 5343

#line 5343

#line 5343
#
#line 5343
# Allow the process to transition to the new domain.
#line 5343
#
#line 5343
allow getty_t local_login_t:process transition;
#line 5343

#line 5343
#
#line 5343
# Allow the process to execute the program.
#line 5343
# 
#line 5343
allow getty_t login_exec_t:file { getattr execute };
#line 5343

#line 5343
#
#line 5343
# Allow the process to reap the new domain.
#line 5343
#
#line 5343
allow local_login_t getty_t:process sigchld;
#line 5343

#line 5343
#
#line 5343
# Allow the new domain to inherit and use file 
#line 5343
# descriptions from the creating process and vice versa.
#line 5343
#
#line 5343
allow local_login_t getty_t:fd use;
#line 5343
allow getty_t local_login_t:fd use;
#line 5343

#line 5343
#
#line 5343
# Allow the new domain to write back to the old domain via a pipe.
#line 5343
#
#line 5343
allow local_login_t getty_t:fifo_file { ioctl read getattr lock write append };
#line 5343

#line 5343
#
#line 5343
# Allow the new domain to read and execute the program.
#line 5343
#
#line 5343
allow local_login_t login_exec_t:file { read getattr lock execute ioctl };
#line 5343

#line 5343
#
#line 5343
# Allow the new domain to be entered via the program.
#line 5343
#
#line 5343
allow local_login_t login_exec_t:file entrypoint;
#line 5343

#line 5343
type_transition getty_t login_exec_t:process local_login_t;
#line 5343

#line 5343
allow getty_t login_exec_t:file read;
#line 5343


# Write to /var/run/utmp.
allow getty_t initrc_var_run_t:file { ioctl read getattr lock write append };

# Write to /var/log/wtmp.
allow getty_t wtmp_t:file { ioctl read getattr lock write append };

# Chown, chmod, read and write ttys.
allow getty_t tty_device_t:chr_file { setattr { ioctl read getattr lock write append } };
allow getty_t ttyfile:chr_file { setattr { ioctl read getattr lock write append } };



#line 5356
allow getty_t var_lock_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 5356
allow getty_t var_lock_t:{ file lnk_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 5356

#DESC Groupadd - Manage system groups
#
# Authors:  David Caplan, dac@tresys.com
#	    (Based on useradd.te by Chris Vance <cvance@tislabs.com>)
#

#################################
#
# Rules for the groupadd_t domain.
#
# groupadd_t is the domain of the groupadd/mod/del programs when
# executed through the sgroupadd/mod/del wrapper.
type groupadd_t, domain, privlog, auth, privowner;
role sysadm_r types groupadd_t;


#line 5372
# Access other processes in the same domain.
#line 5372
allow groupadd_t self:process *;
#line 5372

#line 5372
# Access /proc/PID files for processes in the same domain.
#line 5372
allow groupadd_t self:dir { read getattr lock search ioctl };
#line 5372
allow groupadd_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5372

#line 5372
# Access file descriptions, pipes, and sockets
#line 5372
# created by processes in the same domain.
#line 5372
allow groupadd_t self:fd *;
#line 5372
allow groupadd_t self:fifo_file { ioctl read getattr lock write append };
#line 5372
allow groupadd_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 5372
allow groupadd_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 5372

#line 5372
# Allow the domain to communicate with other processes in the same domain.
#line 5372
allow groupadd_t self:unix_dgram_socket sendto;
#line 5372
allow groupadd_t self:unix_stream_socket connectto;
#line 5372

#line 5372
# Access System V IPC objects created by processes in the same domain.
#line 5372
allow groupadd_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 5372
allow groupadd_t self:msg  { send receive };
#line 5372
allow groupadd_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 5372
allow groupadd_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 5372

#line 5372


#line 5373
allow groupadd_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 5373
allow groupadd_t ld_so_t:file { read getattr lock execute ioctl };
#line 5373
allow groupadd_t ld_so_t:file execute_no_trans;
#line 5373
allow groupadd_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 5373
allow groupadd_t shlib_t:file { read getattr lock execute ioctl };
#line 5373
allow groupadd_t shlib_t:lnk_file { read getattr lock ioctl };
#line 5373
allow groupadd_t ld_so_cache_t:file { read getattr lock ioctl };
#line 5373
allow groupadd_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 5373


type groupadd_exec_t, file_type, sysadmfile, exec_type;

#line 5376

#line 5376

#line 5376
#
#line 5376
# Allow the process to transition to the new domain.
#line 5376
#
#line 5376
allow sysadm_t groupadd_t :process transition;
#line 5376

#line 5376
#
#line 5376
# Allow the process to execute the program.
#line 5376
# 
#line 5376
allow sysadm_t groupadd_exec_t:file { getattr execute };
#line 5376

#line 5376
#
#line 5376
# Allow the process to reap the new domain.
#line 5376
#
#line 5376
allow groupadd_t  sysadm_t:process sigchld;
#line 5376

#line 5376
#
#line 5376
# Allow the new domain to inherit and use file 
#line 5376
# descriptions from the creating process and vice versa.
#line 5376
#
#line 5376
allow groupadd_t  sysadm_t:fd use;
#line 5376
allow sysadm_t groupadd_t :fd use;
#line 5376

#line 5376
#
#line 5376
# Allow the new domain to write back to the old domain via a pipe.
#line 5376
#
#line 5376
allow groupadd_t  sysadm_t:fifo_file { ioctl read getattr lock write append };
#line 5376

#line 5376
#
#line 5376
# Allow the new domain to read and execute the program.
#line 5376
#
#line 5376
allow groupadd_t  groupadd_exec_t:file { read getattr lock execute ioctl };
#line 5376

#line 5376
#
#line 5376
# Allow the new domain to be entered via the program.
#line 5376
#
#line 5376
allow groupadd_t  groupadd_exec_t:file entrypoint;
#line 5376

#line 5376
type_transition sysadm_t groupadd_exec_t:process groupadd_t ;
#line 5376


# Use capabilities.
# need more if users can run gpasswd
allow groupadd_t groupadd_t:capability { dac_override };

# Allow access to context for shadow file
allow groupadd_t security_t:security { context_to_sid };

# Inherit and use descriptors from login.
allow groupadd_t privfd:fd use;

# Execute /usr/sbin/{groupadd,groupdel,groupmod}, /usr/bin/gpasswd.
allow groupadd_t { bin_t sbin_t }:dir { read getattr lock search ioctl };

#line 5390
allow groupadd_t { sbin_t bin_t }:file { { read getattr lock execute ioctl } execute_no_trans };
#line 5390


# Update /etc/shadow and /etc/passwd

#line 5393

#line 5393

#line 5393

#line 5393
#
#line 5393
# Allow the process to modify the directory.
#line 5393
#
#line 5393
allow groupadd_t etc_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 5393

#line 5393
#
#line 5393
# Allow the process to create the file.
#line 5393
#
#line 5393

#line 5393
allow groupadd_t shadow_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 5393
allow groupadd_t shadow_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 5393

#line 5393

#line 5393

#line 5393
type_transition groupadd_t etc_t:dir shadow_t;
#line 5393
type_transition groupadd_t etc_t:{ file lnk_file sock_file fifo_file } shadow_t;
#line 5393

#line 5393

#line 5393

allow groupadd_t etc_t:file { create ioctl read getattr lock write setattr append link unlink rename };

allow groupadd_t { etc_t shadow_t }:file { relabelfrom relabelto };

# some apps ask for these accesses, but seems to work regardless
dontaudit groupadd_t initrc_var_run_t:file { write };
dontaudit groupadd_t { var_run_t device_t var_t }:dir { search };

# Access terminals.
allow groupadd_t ttyfile:chr_file { ioctl read getattr lock write append };
allow groupadd_t ptyfile:chr_file { ioctl read getattr lock write append };












#DESC Ifconfig - Configure network interfaces
#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
#

#################################
#
# Rules for the ifconfig_t domain.
#
# ifconfig_t is the domain for the ifconfig program.
# ifconfig_exec_t is the type of the corresponding program.
#
type ifconfig_t, domain, privlog;
type ifconfig_exec_t, file_type, sysadmfile, exec_type;

role system_r types ifconfig_t;
role sysadm_r types ifconfig_t;


#line 5435
allow ifconfig_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 5435
allow ifconfig_t ld_so_t:file { read getattr lock execute ioctl };
#line 5435
allow ifconfig_t ld_so_t:file execute_no_trans;
#line 5435
allow ifconfig_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 5435
allow ifconfig_t shlib_t:file { read getattr lock execute ioctl };
#line 5435
allow ifconfig_t shlib_t:lnk_file { read getattr lock ioctl };
#line 5435
allow ifconfig_t ld_so_cache_t:file { read getattr lock ioctl };
#line 5435
allow ifconfig_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 5435


#line 5436
# Access other processes in the same domain.
#line 5436
allow ifconfig_t self:process *;
#line 5436

#line 5436
# Access /proc/PID files for processes in the same domain.
#line 5436
allow ifconfig_t self:dir { read getattr lock search ioctl };
#line 5436
allow ifconfig_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5436

#line 5436
# Access file descriptions, pipes, and sockets
#line 5436
# created by processes in the same domain.
#line 5436
allow ifconfig_t self:fd *;
#line 5436
allow ifconfig_t self:fifo_file { ioctl read getattr lock write append };
#line 5436
allow ifconfig_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 5436
allow ifconfig_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 5436

#line 5436
# Allow the domain to communicate with other processes in the same domain.
#line 5436
allow ifconfig_t self:unix_dgram_socket sendto;
#line 5436
allow ifconfig_t self:unix_stream_socket connectto;
#line 5436

#line 5436
# Access System V IPC objects created by processes in the same domain.
#line 5436
allow ifconfig_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 5436
allow ifconfig_t self:msg  { send receive };
#line 5436
allow ifconfig_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 5436
allow ifconfig_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 5436

#line 5436



#line 5438

#line 5438

#line 5438
#
#line 5438
# Allow the process to transition to the new domain.
#line 5438
#
#line 5438
allow initrc_t ifconfig_t:process transition;
#line 5438

#line 5438
#
#line 5438
# Allow the process to execute the program.
#line 5438
# 
#line 5438
allow initrc_t ifconfig_exec_t:file { getattr execute };
#line 5438

#line 5438
#
#line 5438
# Allow the process to reap the new domain.
#line 5438
#
#line 5438
allow ifconfig_t initrc_t:process sigchld;
#line 5438

#line 5438
#
#line 5438
# Allow the new domain to inherit and use file 
#line 5438
# descriptions from the creating process and vice versa.
#line 5438
#
#line 5438
allow ifconfig_t initrc_t:fd use;
#line 5438
allow initrc_t ifconfig_t:fd use;
#line 5438

#line 5438
#
#line 5438
# Allow the new domain to write back to the old domain via a pipe.
#line 5438
#
#line 5438
allow ifconfig_t initrc_t:fifo_file { ioctl read getattr lock write append };
#line 5438

#line 5438
#
#line 5438
# Allow the new domain to read and execute the program.
#line 5438
#
#line 5438
allow ifconfig_t ifconfig_exec_t:file { read getattr lock execute ioctl };
#line 5438

#line 5438
#
#line 5438
# Allow the new domain to be entered via the program.
#line 5438
#
#line 5438
allow ifconfig_t ifconfig_exec_t:file entrypoint;
#line 5438

#line 5438
type_transition initrc_t ifconfig_exec_t:process ifconfig_t;
#line 5438


#line 5439

#line 5439

#line 5439
#
#line 5439
# Allow the process to transition to the new domain.
#line 5439
#
#line 5439
allow sysadm_t ifconfig_t:process transition;
#line 5439

#line 5439
#
#line 5439
# Allow the process to execute the program.
#line 5439
# 
#line 5439
allow sysadm_t ifconfig_exec_t:file { getattr execute };
#line 5439

#line 5439
#
#line 5439
# Allow the process to reap the new domain.
#line 5439
#
#line 5439
allow ifconfig_t sysadm_t:process sigchld;
#line 5439

#line 5439
#
#line 5439
# Allow the new domain to inherit and use file 
#line 5439
# descriptions from the creating process and vice versa.
#line 5439
#
#line 5439
allow ifconfig_t sysadm_t:fd use;
#line 5439
allow sysadm_t ifconfig_t:fd use;
#line 5439

#line 5439
#
#line 5439
# Allow the new domain to write back to the old domain via a pipe.
#line 5439
#
#line 5439
allow ifconfig_t sysadm_t:fifo_file { ioctl read getattr lock write append };
#line 5439

#line 5439
#
#line 5439
# Allow the new domain to read and execute the program.
#line 5439
#
#line 5439
allow ifconfig_t ifconfig_exec_t:file { read getattr lock execute ioctl };
#line 5439

#line 5439
#
#line 5439
# Allow the new domain to be entered via the program.
#line 5439
#
#line 5439
allow ifconfig_t ifconfig_exec_t:file entrypoint;
#line 5439

#line 5439
type_transition sysadm_t ifconfig_exec_t:process ifconfig_t;
#line 5439


# Use capabilities.
allow ifconfig_t ifconfig_t:capability { sys_module net_admin };

# Inherit and use descriptors from init.
allow ifconfig_t init_t:fd use;

# Execute insmod.

#line 5448

#line 5448

#line 5448
#
#line 5448
# Allow the process to transition to the new domain.
#line 5448
#
#line 5448
allow ifconfig_t insmod_t:process transition;
#line 5448

#line 5448
#
#line 5448
# Allow the process to execute the program.
#line 5448
# 
#line 5448
allow ifconfig_t insmod_exec_t:file { getattr execute };
#line 5448

#line 5448
#
#line 5448
# Allow the process to reap the new domain.
#line 5448
#
#line 5448
allow insmod_t ifconfig_t:process sigchld;
#line 5448

#line 5448
#
#line 5448
# Allow the new domain to inherit and use file 
#line 5448
# descriptions from the creating process and vice versa.
#line 5448
#
#line 5448
allow insmod_t ifconfig_t:fd use;
#line 5448
allow ifconfig_t insmod_t:fd use;
#line 5448

#line 5448
#
#line 5448
# Allow the new domain to write back to the old domain via a pipe.
#line 5448
#
#line 5448
allow insmod_t ifconfig_t:fifo_file { ioctl read getattr lock write append };
#line 5448

#line 5448
#
#line 5448
# Allow the new domain to read and execute the program.
#line 5448
#
#line 5448
allow insmod_t insmod_exec_t:file { read getattr lock execute ioctl };
#line 5448

#line 5448
#
#line 5448
# Allow the new domain to be entered via the program.
#line 5448
#
#line 5448
allow insmod_t insmod_exec_t:file entrypoint;
#line 5448

#line 5448
type_transition ifconfig_t insmod_exec_t:process insmod_t;
#line 5448


#line 5452


# Access /proc
allow ifconfig_t proc_t:dir { read getattr lock search ioctl };
allow ifconfig_t proc_t:file { read getattr lock ioctl };

allow ifconfig_t privfd:fd use;

# Create UDP sockets, necessary when called from dhcpc
allow ifconfig_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };

# Access terminals.
allow ifconfig_t { initrc_devpts_t { sysadm_tty_device_t sysadm_devpts_t } }:chr_file { ioctl read getattr lock write append };


allow ifconfig_t tun_tap_device_t:chr_file { read write };

# ifconfig attempts to create to search some sysctl entries.
# Don't audit those attempts; comment out these rules if it is desired to
# see the denials.
dontaudit ifconfig_t sysctl_t:dir search;


# Added by us
allow ifconfig_t locale_t:dir { search };
allow ifconfig_t locale_t:file { getattr read };
allow ifconfig_t sysctl_net_t:dir { search };

#DESC Initrc - System initialization scripts
#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
#

#################################
#
# Rules for the initrc_t domain.
#
# initrc_t is the domain of the init rc scripts.
# initrc_exec_t is the type of the init program.
#
#line 5497

#line 5497
type initrc_t, domain, privlog, privowner, privmail;
#line 5497

role system_r types initrc_t;

#line 5499
allow initrc_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 5499
allow initrc_t ld_so_t:file { read getattr lock execute ioctl };
#line 5499
allow initrc_t ld_so_t:file execute_no_trans;
#line 5499
allow initrc_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 5499
allow initrc_t shlib_t:file { read getattr lock execute ioctl };
#line 5499
allow initrc_t shlib_t:lnk_file { read getattr lock ioctl };
#line 5499
allow initrc_t ld_so_cache_t:file { read getattr lock ioctl };
#line 5499
allow initrc_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 5499
;
type initrc_exec_t, file_type, sysadmfile, exec_type;

# read files in /etc/init.d
allow initrc_t etc_t:lnk_file { read getattr lock ioctl };

# read localization information
allow initrc_t locale_t:dir { read getattr lock search ioctl };
allow initrc_t locale_t:{file lnk_file} { read getattr lock ioctl };

# Read system information files in /proc.
allow initrc_t proc_t:dir { read getattr lock search ioctl };
allow initrc_t proc_t:{ file lnk_file } { read getattr lock ioctl };

# Allow IPC with self
allow initrc_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
allow initrc_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
allow initrc_t self:fifo_file { ioctl read getattr lock write append };

# Read the root directory of a usbdevfs filesystem, and
# the devices and drivers files.  Permit stating of the
# device nodes, but nothing else.
allow initrc_t usbdevfs_t:dir { read getattr lock search ioctl };
allow initrc_t usbdevfs_t:{ file lnk_file } { read getattr lock ioctl };
allow initrc_t usbdevfs_device_t:file getattr;

# allow initrc to fork and renice itself
allow initrc_t self:process { fork sigchld setsched };

# Can create ptys for open_init_pty

#line 5529

#line 5529
type initrc_devpts_t, file_type, sysadmfile, ptyfile ;
#line 5529

#line 5529
# Allow the pty to be associated with the file system.
#line 5529
allow initrc_devpts_t devpts_t:filesystem associate;
#line 5529

#line 5529
# Access the pty master multiplexer.
#line 5529
allow initrc_t ptmx_t:chr_file { ioctl read getattr lock write append };
#line 5529

#line 5529
# Label pty files with a derived type.
#line 5529
type_transition initrc_t devpts_t:chr_file initrc_devpts_t;
#line 5529

#line 5529
# Read and write my pty files.
#line 5529
allow initrc_t initrc_devpts_t:chr_file { setattr { ioctl read getattr lock write append } };
#line 5529

#line 5529

#line 5529

#line 5529


type initrc_tmp_t, file_type, sysadmfile, tmpfile;

#line 5532

#line 5532

#line 5532

#line 5532
#
#line 5532
# Allow the process to modify the directory.
#line 5532
#
#line 5532
allow initrc_t tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 5532

#line 5532
#
#line 5532
# Allow the process to create the file.
#line 5532
#
#line 5532

#line 5532
allow initrc_t initrc_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 5532
allow initrc_t initrc_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 5532

#line 5532

#line 5532

#line 5532
type_transition initrc_t tmp_t:dir initrc_tmp_t;
#line 5532
type_transition initrc_t tmp_t:{ file lnk_file sock_file fifo_file } initrc_tmp_t;
#line 5532

#line 5532

#line 5532


type initrc_var_run_t, file_type, sysadmfile, pidfile;

#line 5535

#line 5535

#line 5535

#line 5535
#
#line 5535
# Allow the process to modify the directory.
#line 5535
#
#line 5535
allow initrc_t var_run_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 5535

#line 5535
#
#line 5535
# Allow the process to create the file.
#line 5535
#
#line 5535

#line 5535
allow initrc_t initrc_var_run_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 5535
allow initrc_t initrc_var_run_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 5535

#line 5535

#line 5535

#line 5535
type_transition initrc_t var_run_t:dir initrc_var_run_t;
#line 5535
type_transition initrc_t var_run_t:{ file lnk_file sock_file fifo_file } initrc_var_run_t;
#line 5535

#line 5535

#line 5535

allow initrc_t var_run_t:{ file sock_file lnk_file } unlink;

allow initrc_t framebuf_device_t:chr_file { read getattr lock ioctl };

# Use capabilities.
allow initrc_t initrc_t:capability ~sys_module;

# Use system operations.
allow initrc_t kernel_t:system *;

# Audit grantings of the avc_toggle permission to initrc_t.
# The initrc_t domain is granted this permission for 
# people who want to use a development kernel and toggle
# into enforcing mode from an /etc/rc.d script.
# Due to its sensitivity, we always audit it.
auditallow initrc_t kernel_t:system avc_toggle;

# Set values in /proc/sys.

#line 5554
allow initrc_t sysctl_t:dir { read getattr lock search ioctl };
#line 5554
allow initrc_t sysctl_t:file { setattr { ioctl read getattr lock write append } };
#line 5554
allow initrc_t sysctl_fs_t:dir { read getattr lock search ioctl };
#line 5554
allow initrc_t sysctl_fs_t:file { setattr { ioctl read getattr lock write append } };
#line 5554
allow initrc_t sysctl_kernel_t:dir { read getattr lock search ioctl };
#line 5554
allow initrc_t sysctl_kernel_t:file { setattr { ioctl read getattr lock write append } };
#line 5554
allow initrc_t sysctl_net_t:dir { read getattr lock search ioctl };
#line 5554
allow initrc_t sysctl_net_t:file { setattr { ioctl read getattr lock write append } };
#line 5554
allow initrc_t sysctl_net_unix_t:dir { read getattr lock search ioctl };
#line 5554
allow initrc_t sysctl_net_unix_t:file { setattr { ioctl read getattr lock write append } };
#line 5554
allow initrc_t sysctl_vm_t:dir { read getattr lock search ioctl };
#line 5554
allow initrc_t sysctl_vm_t:file { setattr { ioctl read getattr lock write append } };
#line 5554
allow initrc_t sysctl_dev_t:dir { read getattr lock search ioctl };
#line 5554
allow initrc_t sysctl_dev_t:file { setattr { ioctl read getattr lock write append } };
#line 5554
allow initrc_t sysctl_modprobe_t:file { setattr { ioctl read getattr lock write append } };
#line 5554


# Run helper programs in the initrc_t domain.
allow initrc_t {bin_t sbin_t }:dir { read getattr lock search ioctl };
allow initrc_t {bin_t sbin_t }:lnk_file read;

#line 5559
allow initrc_t etc_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 5559


#line 5560
allow initrc_t lib_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 5560


#line 5561
allow initrc_t bin_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 5561


#line 5562
allow initrc_t sbin_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 5562


#line 5563
allow initrc_t exec_type:file { { read getattr lock execute ioctl } execute_no_trans };
#line 5563



# Read conf.modules.
allow initrc_t modules_conf_t:file { read getattr lock ioctl };

# Run other rc scripts in the initrc_t domain.

#line 5570
allow initrc_t initrc_exec_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 5570


# Run init (telinit) in the initrc_t domain.

#line 5573
allow initrc_t init_exec_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 5573


# Communicate with the init process.
allow initrc_t initctl_t:fifo_file { ioctl read getattr lock write append };

# Send messages to portmap and ypbind.



# Search persistent label mappings.
allow initrc_t file_labels_t:dir { read getattr lock search ioctl };
allow initrc_t file_labels_t:file { getattr };

# Read /proc/PID directories for all domains.
allow initrc_t domain:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
allow initrc_t domain:dir { read getattr lock search ioctl };

# Mount and unmount file systems.
allow initrc_t fs_type:filesystem { mount remount unmount getattr };
allow initrc_t file_t:dir { read search getattr mounton };

# Create runtime files in /etc, e.g. /etc/mtab, /etc/HOSTNAME.

#line 5595

#line 5595

#line 5595

#line 5595
#
#line 5595
# Allow the process to modify the directory.
#line 5595
#
#line 5595
allow initrc_t etc_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 5595

#line 5595
#
#line 5595
# Allow the process to create the file.
#line 5595
#
#line 5595

#line 5595
allow initrc_t etc_runtime_t:file { create ioctl read getattr lock write setattr append link unlink rename };
#line 5595

#line 5595

#line 5595

#line 5595
type_transition initrc_t etc_t:file etc_runtime_t;
#line 5595

#line 5595

#line 5595


# Update /etc/ld.so.cache.
allow initrc_t ld_so_cache_t:file { ioctl read getattr lock write append };

#line 5603


#line 5609


# Update /var/log/wtmp and /var/log/dmesg.
allow initrc_t wtmp_t:file { setattr { ioctl read getattr lock write append } };
allow initrc_t var_log_t:file { setattr { ioctl read getattr lock write append } };
allow initrc_t lastlog_t:file { setattr { ioctl read getattr lock write append } };

# remove old locks
allow initrc_t lockfile:dir { read getattr lock search ioctl add_name remove_name write };
allow initrc_t lockfile:file { getattr unlink };

# Access /var/lib/random-seed.
allow initrc_t var_lib_t:file { ioctl read getattr lock write append };
allow initrc_t var_lib_t:file unlink;

# Create lock file.
allow initrc_t var_lock_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
allow initrc_t var_lock_t:file { create ioctl read getattr lock write setattr append link unlink rename };

# Set the clock.
allow initrc_t clock_device_t:{ chr_file blk_file } { ioctl read getattr lock write append };

# Kill all processes.
allow initrc_t domain:process { sigchld sigkill sigstop signull signal };

# Read and unlink /var/run/*.pid files.
allow initrc_t pidfile:file { getattr read unlink };

# Write to /dev/urandom.
allow initrc_t random_device_t:chr_file { ioctl read getattr lock write append };

# Access /dev/psaux (for kudzu).
allow initrc_t psaux_t:chr_file { ioctl read getattr lock write append };

# Set device ownerships/modes.
allow initrc_t framebuf_device_t:lnk_file read;
allow initrc_t framebuf_device_t:{ chr_file blk_file } setattr;
allow initrc_t misc_device_t:{ chr_file blk_file } setattr;
allow initrc_t device_t:{ chr_file blk_file } setattr;
allow initrc_t fixed_disk_device_t:{ chr_file blk_file } setattr;
allow initrc_t removable_device_t:{ chr_file blk_file } setattr;

# Stat any file.
allow initrc_t file_type:{ file lnk_file sock_file fifo_file chr_file blk_file } getattr;
allow initrc_t file_type:dir { search getattr };

# Read and write console and ttys.
allow initrc_t devtty_t:chr_file { ioctl read getattr lock write append };
allow initrc_t console_device_t:chr_file { ioctl read getattr lock write append };
allow initrc_t tty_device_t:chr_file { ioctl read getattr lock write append };
allow initrc_t ttyfile:chr_file { ioctl read getattr lock write append };
allow initrc_t ptyfile:chr_file { ioctl read getattr lock write append };

# Reset tty labels.
allow initrc_t ttyfile:chr_file relabelfrom;
allow initrc_t tty_device_t:chr_file relabelto;

# Create and read /boot/kernel.h.
# Redhat systems typically create this file at boot time.
allow initrc_t boot_t:lnk_file { read getattr lock ioctl };

#line 5669

#line 5669

#line 5669

#line 5669
#
#line 5669
# Allow the process to modify the directory.
#line 5669
#
#line 5669
allow initrc_t boot_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 5669

#line 5669
#
#line 5669
# Allow the process to create the file.
#line 5669
#
#line 5669

#line 5669
allow initrc_t boot_runtime_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 5669
allow initrc_t boot_runtime_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 5669

#line 5669

#line 5669

#line 5669
type_transition initrc_t boot_t:dir boot_runtime_t;
#line 5669
type_transition initrc_t boot_t:{ file lnk_file sock_file fifo_file } boot_runtime_t;
#line 5669

#line 5669

#line 5669


# Delete and re-create /boot/System.map.
allow initrc_t boot_t:dir { read getattr write remove_name add_name };
allow initrc_t boot_t:lnk_file { read unlink create };
allow initrc_t system_map_t:{ file lnk_file } { read getattr lock ioctl };

# Unlink /halt.
allow initrc_t root_t:dir { search write remove_name };
allow initrc_t root_t:file { unlink write };



allow initrc_t var_spool_t:file { ioctl read getattr lock write append };



#
# quota control
#
allow initrc_t fs_type:filesystem { quotamod quotaget };

# Access the mouse (for kudzu).
allow initrc_t mouse_device_t:chr_file { ioctl read getattr lock write append };

# Allow access to the sysadm TTYs. Note that this will give access to the 
# TTYs to any process in the initrc_t domain. Therefore, daemons and such
# started from init should be placed in their own domain.
allow initrc_t { sysadm_tty_device_t sysadm_devpts_t }:chr_file { ioctl read getattr lock write append };

# Access sound device and files.
allow initrc_t sound_device_t:chr_file { setattr ioctl read write };


#line 5706


# Update /var/log/ksyms.*.

#line 5709

#line 5709

#line 5709

#line 5709
#
#line 5709
# Allow the process to modify the directory.
#line 5709
#
#line 5709
allow initrc_t var_log_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 5709

#line 5709
#
#line 5709
# Allow the process to create the file.
#line 5709
#
#line 5709

#line 5709
allow initrc_t var_log_ksyms_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 5709
allow initrc_t var_log_ksyms_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 5709

#line 5709

#line 5709

#line 5709
type_transition initrc_t var_log_t:dir var_log_ksyms_t;
#line 5709
type_transition initrc_t var_log_t:{ file lnk_file sock_file fifo_file } var_log_ksyms_t;
#line 5709

#line 5709

#line 5709


#line 5713


# Access /dev/fd0 (for kudzu). Need a separate domain for kudzu?
allow initrc_t removable_device_t:blk_file { ioctl read getattr lock write append };

#line 5721


# Create and delete /.autofsck
allow initrc_t root_t:dir { search write add_name };
allow initrc_t root_t:file { create setattr unlink getattr };
allow initrc_t file_t:file { unlink getattr };

# Read user home directories.
allow initrc_t { home_root_t home_type }:dir { read getattr lock search ioctl };
allow initrc_t home_type:file { read getattr lock ioctl };

# for system start scripts
allow initrc_t pidfile:dir { read getattr lock search ioctl add_name remove_name write };
allow initrc_t pidfile:sock_file unlink;
allow initrc_t tmpfile:sock_file unlink;

#line 5736
allow initrc_t var_lib_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 5736
allow initrc_t var_lib_t:{ file lnk_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 5736


# allow start scripts to clean /tmp
allow initrc_t tmpfile:dir { { read getattr lock search ioctl add_name remove_name write } rmdir };
allow initrc_t tmpfile:{ file lnk_file sock_file fifo_file } { getattr unlink };

#################################
#
# Rules for the run_init_t domain.
#

#line 5746
type run_init_exec_t, file_type, exec_type, sysadmfile;
#line 5746

#line 5746
# domain for program to run in, needs to change role (privrole), change
#line 5746
# identity to system_u (privuser), log failures to syslog (privlog) and
#line 5746
# authenticate users (auth)
#line 5746
type run_init_t, domain, privrole, privuser, privlog, auth;
#line 5746

#line 5746

#line 5746

#line 5746
#
#line 5746
# Allow the process to transition to the new domain.
#line 5746
#
#line 5746
allow sysadm_t run_init_t:process transition;
#line 5746

#line 5746
#
#line 5746
# Allow the process to execute the program.
#line 5746
# 
#line 5746
allow sysadm_t run_init_exec_t:file { getattr execute };
#line 5746

#line 5746
#
#line 5746
# Allow the process to reap the new domain.
#line 5746
#
#line 5746
allow run_init_t sysadm_t:process sigchld;
#line 5746

#line 5746
#
#line 5746
# Allow the new domain to inherit and use file 
#line 5746
# descriptions from the creating process and vice versa.
#line 5746
#
#line 5746
allow run_init_t sysadm_t:fd use;
#line 5746
allow sysadm_t run_init_t:fd use;
#line 5746

#line 5746
#
#line 5746
# Allow the new domain to write back to the old domain via a pipe.
#line 5746
#
#line 5746
allow run_init_t sysadm_t:fifo_file { ioctl read getattr lock write append };
#line 5746

#line 5746
#
#line 5746
# Allow the new domain to read and execute the program.
#line 5746
#
#line 5746
allow run_init_t run_init_exec_t:file { read getattr lock execute ioctl };
#line 5746

#line 5746
#
#line 5746
# Allow the new domain to be entered via the program.
#line 5746
#
#line 5746
allow run_init_t run_init_exec_t:file entrypoint;
#line 5746

#line 5746
type_transition sysadm_t run_init_exec_t:process run_init_t;
#line 5746

#line 5746
role sysadm_r types run_init_t;
#line 5746

#line 5746
# for utmp
#line 5746
allow run_init_t initrc_var_run_t:file { ioctl read getattr lock write append };
#line 5746
allow run_init_t { sysadm_tty_device_t sysadm_devpts_t }:chr_file { ioctl read getattr lock write append };
#line 5746

#line 5746
# often the administrator runs such programs from a directory that is owned
#line 5746
# by a different user or has restrictive SE permissions, do not want to audit
#line 5746
# the failed access to the current directory
#line 5746
dontaudit run_init_t file_type:dir search;
#line 5746
dontaudit run_init_t self:capability { dac_override dac_read_search };
#line 5746

#line 5746

#line 5746
allow run_init_t { bin_t chkpwd_exec_t shell_exec_t }:file { { read getattr lock execute ioctl } execute_no_trans };
#line 5746

#line 5746

#line 5746

#line 5746

#line 5746
#
#line 5746
# Allow the process to transition to the new domain.
#line 5746
#
#line 5746
allow run_init_t initrc_t:process transition;
#line 5746

#line 5746
#
#line 5746
# Allow the process to execute the program.
#line 5746
# 
#line 5746
allow run_init_t initrc_exec_t:file { getattr execute };
#line 5746

#line 5746
#
#line 5746
# Allow the process to reap the new domain.
#line 5746
#
#line 5746
allow initrc_t run_init_t:process sigchld;
#line 5746

#line 5746
#
#line 5746
# Allow the new domain to inherit and use file 
#line 5746
# descriptions from the creating process and vice versa.
#line 5746
#
#line 5746
allow initrc_t run_init_t:fd use;
#line 5746
allow run_init_t initrc_t:fd use;
#line 5746

#line 5746
#
#line 5746
# Allow the new domain to write back to the old domain via a pipe.
#line 5746
#
#line 5746
allow initrc_t run_init_t:fifo_file { ioctl read getattr lock write append };
#line 5746

#line 5746
#
#line 5746
# Allow the new domain to read and execute the program.
#line 5746
#
#line 5746
allow initrc_t initrc_exec_t:file { read getattr lock execute ioctl };
#line 5746

#line 5746
#
#line 5746
# Allow the new domain to be entered via the program.
#line 5746
#
#line 5746
allow initrc_t initrc_exec_t:file entrypoint;
#line 5746

#line 5746

#line 5746
# hmm, do we REALLY need this?
#line 5746

#line 5746

#line 5746
# Grant the permissions common to the test domains.
#line 5746

#line 5746
# Grant permissions within the domain.
#line 5746

#line 5746
# Access other processes in the same domain.
#line 5746
allow run_init_t self:process *;
#line 5746

#line 5746
# Access /proc/PID files for processes in the same domain.
#line 5746
allow run_init_t self:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5746

#line 5746
# Access file descriptions, pipes, and sockets
#line 5746
# created by processes in the same domain.
#line 5746
allow run_init_t self:fd *;
#line 5746
allow run_init_t self:fifo_file { ioctl read getattr lock write append };
#line 5746
allow run_init_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 5746
allow run_init_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 5746

#line 5746
# Allow the domain to communicate with other processes in the same domain.
#line 5746
allow run_init_t self:unix_dgram_socket sendto;
#line 5746
allow run_init_t self:unix_stream_socket connectto;
#line 5746

#line 5746
# Access System V IPC objects created by processes in the same domain.
#line 5746
allow run_init_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 5746
allow run_init_t self:msg  { send receive };
#line 5746
allow run_init_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 5746
allow run_init_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 5746

#line 5746

#line 5746

#line 5746
# Grant read/search permissions to most of /proc.
#line 5746

#line 5746
# Read system information files in /proc.
#line 5746
allow run_init_t proc_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t proc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5746

#line 5746
# Stat /proc/kmsg and /proc/kcore.
#line 5746
allow run_init_t proc_kmsg_t:file { getattr };
#line 5746
allow run_init_t proc_kcore_t:file { getattr };
#line 5746

#line 5746
# Read system variables in /proc/sys.
#line 5746
allow run_init_t sysctl_modprobe_t:file { read getattr lock ioctl };
#line 5746
allow run_init_t sysctl_t:file { read getattr lock ioctl };
#line 5746
allow run_init_t sysctl_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t sysctl_fs_t:file { read getattr lock ioctl };
#line 5746
allow run_init_t sysctl_fs_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t sysctl_kernel_t:file { read getattr lock ioctl };
#line 5746
allow run_init_t sysctl_kernel_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t sysctl_net_t:file { read getattr lock ioctl };
#line 5746
allow run_init_t sysctl_net_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t sysctl_vm_t:file { read getattr lock ioctl };
#line 5746
allow run_init_t sysctl_vm_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t sysctl_dev_t:file { read getattr lock ioctl };
#line 5746
allow run_init_t sysctl_dev_t:dir { read getattr lock search ioctl };
#line 5746

#line 5746

#line 5746
# Grant read/search permissions to many system file types.
#line 5746

#line 5746

#line 5746
# Get attributes of file systems.
#line 5746
allow run_init_t fs_type:filesystem getattr;
#line 5746

#line 5746

#line 5746
# Read /.
#line 5746
allow run_init_t root_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t root_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5746

#line 5746
# Read /home.
#line 5746
allow run_init_t home_root_t:dir { read getattr lock search ioctl };
#line 5746

#line 5746
# Read /usr.
#line 5746
allow run_init_t usr_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t usr_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5746

#line 5746
# Read bin and sbin directories.
#line 5746
allow run_init_t bin_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5746
allow run_init_t sbin_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5746

#line 5746

#line 5746
# Read directories and files with the readable_t type.
#line 5746
# This type is a general type for "world"-readable files.
#line 5746
allow run_init_t readable_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t readable_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5746

#line 5746
# Stat /...security and lost+found.
#line 5746
allow run_init_t file_labels_t:dir getattr;
#line 5746
allow run_init_t lost_found_t:dir getattr;
#line 5746

#line 5746
# Read the devpts root directory.  
#line 5746
allow run_init_t devpts_t:dir { read getattr lock search ioctl };
#line 5746

#line 5746

#line 5746
# Read the /tmp directory and any /tmp files with the base type.
#line 5746
# Temporary files created at runtime will typically use derived types.
#line 5746
allow run_init_t tmp_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t tmp_t:{ file lnk_file } { read getattr lock ioctl };
#line 5746

#line 5746
# Read /var.
#line 5746
allow run_init_t var_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t var_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5746

#line 5746
# Read /var/catman.
#line 5746
allow run_init_t catman_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t catman_t:{ file lnk_file } { read getattr lock ioctl };
#line 5746

#line 5746
# Read /var/lib.
#line 5746
allow run_init_t var_lib_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t var_lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5746
allow run_init_t var_lib_nfs_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t var_lib_nfs_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5746

#line 5746

#line 5746
allow run_init_t tetex_data_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t tetex_data_t:{ file lnk_file } { read getattr lock ioctl };
#line 5746

#line 5746

#line 5746
# Read /var/yp.
#line 5746
allow run_init_t var_yp_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t var_yp_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5746

#line 5746
# Read /var/spool.
#line 5746
allow run_init_t var_spool_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t var_spool_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5746

#line 5746
# Read /var/run, /var/lock, /var/log.
#line 5746
allow run_init_t var_run_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t var_run_t:{ file lnk_file } { read getattr lock ioctl };
#line 5746
allow run_init_t var_log_t:dir { read getattr lock search ioctl };
#line 5746
#allow run_init_t var_log_t:{ file lnk_file } r_file_perms;
#line 5746
allow run_init_t var_log_sa_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t var_log_sa_t:{ file lnk_file } { read getattr lock ioctl };
#line 5746
allow run_init_t var_log_ksyms_t:{ file lnk_file } { read getattr lock ioctl };
#line 5746

#line 5746
allow run_init_t var_lock_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t var_lock_t:{ file lnk_file } { read getattr lock ioctl };
#line 5746

#line 5746
# Read /var/run/utmp and /var/log/wtmp.
#line 5746
allow run_init_t initrc_var_run_t:file { read getattr lock ioctl };
#line 5746
allow run_init_t wtmp_t:file { read getattr lock ioctl };
#line 5746

#line 5746
# Read /boot, /boot/System.map*, and /vmlinuz*
#line 5746
allow run_init_t boot_t:dir { search getattr };
#line 5746
allow run_init_t boot_t:file getattr;
#line 5746
allow run_init_t system_map_t:{ file lnk_file } { read getattr lock ioctl };
#line 5746

#line 5746
allow run_init_t boot_t:lnk_file read;
#line 5746

#line 5746
# Read /etc.
#line 5746
allow run_init_t etc_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t etc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5746
allow run_init_t etc_runtime_t:{ file lnk_file } { read getattr lock ioctl };
#line 5746
allow run_init_t etc_aliases_t:{ file lnk_file } { read getattr lock ioctl };
#line 5746
allow run_init_t etc_mail_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t etc_mail_t:{ file lnk_file } { read getattr lock ioctl };
#line 5746
allow run_init_t resolv_conf_t:{ file lnk_file } { read getattr lock ioctl };
#line 5746
allow run_init_t ld_so_cache_t:file { read getattr lock ioctl };
#line 5746

#line 5746
# Read /lib.
#line 5746
allow run_init_t lib_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5746

#line 5746
# Read the linker, shared library, and executable types.
#line 5746
allow run_init_t ld_so_t:{ file lnk_file } { read getattr lock ioctl };
#line 5746
allow run_init_t shlib_t:{ file lnk_file } { read getattr lock ioctl };
#line 5746
allow run_init_t exec_type:{ file lnk_file } { read getattr lock ioctl };
#line 5746

#line 5746
# Read man directories and files.
#line 5746
allow run_init_t man_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t man_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5746

#line 5746
# Read /usr/src.
#line 5746
allow run_init_t src_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t src_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 5746

#line 5746
# Read module-related files.
#line 5746
allow run_init_t modules_object_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t modules_object_t:{ file lnk_file } { read getattr lock ioctl };
#line 5746
allow run_init_t modules_dep_t:{ file lnk_file } { read getattr lock ioctl };
#line 5746
allow run_init_t modules_conf_t:{ file lnk_file} { read getattr lock ioctl };
#line 5746

#line 5746
# Read /dev directories and any symbolic links.
#line 5746
allow run_init_t device_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t device_t:lnk_file { read getattr lock ioctl };
#line 5746

#line 5746
# Read /dev/random and /dev/zero.
#line 5746
allow run_init_t random_device_t:chr_file { read getattr lock ioctl };
#line 5746
allow run_init_t zero_device_t:chr_file { read getattr lock ioctl };
#line 5746

#line 5746
# Read the root directory of a tmpfs filesytem and any symbolic links.
#line 5746
allow run_init_t tmpfs_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t tmpfs_t:lnk_file { read getattr lock ioctl };
#line 5746

#line 5746
# Read any symbolic links on a devfs file system.
#line 5746
allow run_init_t device_t:lnk_file { read getattr lock ioctl };
#line 5746

#line 5746
# Read the root directory of a usbdevfs filesystem, and
#line 5746
# the devices and drivers files.  Permit stating of the
#line 5746
# device nodes, but nothing else.
#line 5746
allow run_init_t usbdevfs_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t usbdevfs_t:{ file lnk_file } { read getattr lock ioctl };
#line 5746
allow run_init_t usbdevfs_device_t:file getattr;
#line 5746

#line 5746

#line 5746
# Grant write permissions to a small set of system file types.
#line 5746
# No permission to create files is granted here.  Use allow rules to grant 
#line 5746
# create permissions to a type or use file_type_auto_trans rules to set up
#line 5746
# new types for files.
#line 5746

#line 5746

#line 5746
# Read and write /dev/tty and /dev/null.
#line 5746
allow run_init_t devtty_t:chr_file { ioctl read getattr lock write append };
#line 5746
allow run_init_t { null_device_t zero_device_t }:chr_file { ioctl read getattr lock write append };
#line 5746

#line 5746
# Do not audit write denials to /etc/ld.so.cache.
#line 5746
dontaudit run_init_t ld_so_cache_t:file write;
#line 5746

#line 5746

#line 5746
# Execute from the system shared libraries.
#line 5746
# No permission to execute anything else is granted here.
#line 5746
# Use can_exec or can_exec_any to grant the ability to execute within a domain.
#line 5746
# Use domain_auto_trans for executing and changing domains.
#line 5746

#line 5746
allow run_init_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t ld_so_t:file { read getattr lock execute ioctl };
#line 5746
allow run_init_t ld_so_t:file execute_no_trans;
#line 5746
allow run_init_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 5746
allow run_init_t shlib_t:file { read getattr lock execute ioctl };
#line 5746
allow run_init_t shlib_t:lnk_file { read getattr lock ioctl };
#line 5746
allow run_init_t ld_so_cache_t:file { read getattr lock ioctl };
#line 5746
allow run_init_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 5746

#line 5746

#line 5746
# read localization information
#line 5746
allow run_init_t locale_t:dir { read getattr lock search ioctl };
#line 5746
allow run_init_t locale_t:{file lnk_file} { read getattr lock ioctl };
#line 5746

#line 5746
# Obtain the context of any SID, the SID for any context, 
#line 5746
# and the list of active SIDs.
#line 5746
allow run_init_t security_t:security { sid_to_context context_to_sid get_sids };
#line 5746

#line 5746

#line 5746

#line 5746
# Grant permissions needed to create TCP and UDP sockets and 
#line 5746
# to access the network.
#line 5746

#line 5746
#
#line 5746
# Allow the domain to create and use UDP and TCP sockets.
#line 5746
# Other kinds of sockets must be separately authorized for use.
#line 5746
allow run_init_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 5746
allow run_init_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 5746

#line 5746
#
#line 5746
# Allow the domain to send UDP packets.
#line 5746
# Since the destination sockets type is unknown, the generic
#line 5746
# any_socket_t type is used as a placeholder.
#line 5746
#
#line 5746
allow run_init_t any_socket_t:udp_socket sendto;
#line 5746

#line 5746
#
#line 5746
# Allow the domain to send using any network interface.
#line 5746
# netif_type is a type attribute for all network interface types.
#line 5746
#
#line 5746
allow run_init_t netif_type:netif { tcp_send udp_send rawip_send };
#line 5746

#line 5746
#
#line 5746
# Allow packets sent by the domain to be received on any network interface.
#line 5746
#
#line 5746
allow run_init_t netif_type:netif { tcp_recv udp_recv rawip_recv };
#line 5746

#line 5746
#
#line 5746
# Allow the domain to receive packets from any network interface.
#line 5746
# netmsg_type is a type attribute for all default message types.
#line 5746
#
#line 5746
allow run_init_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
#line 5746

#line 5746
#
#line 5746
# Allow the domain to initiate or accept TCP connections 
#line 5746
# on any network interface.
#line 5746
#
#line 5746
allow run_init_t netmsg_type:tcp_socket { connectto acceptfrom };
#line 5746

#line 5746
#
#line 5746
# Receive resets from the TCP reset socket.
#line 5746
# The TCP reset socket is labeled with the tcp_socket_t type.
#line 5746
#
#line 5746
allow run_init_t tcp_socket_t:tcp_socket recvfrom;
#line 5746

#line 5746
dontaudit run_init_t tcp_socket_t:tcp_socket connectto;
#line 5746

#line 5746
#
#line 5746
# Allow the domain to send to any node.
#line 5746
# node_type is a type attribute for all node types.
#line 5746
#
#line 5746
allow run_init_t node_type:node { tcp_send udp_send rawip_send };
#line 5746

#line 5746
#
#line 5746
# Allow packets sent by the domain to be received from any node.
#line 5746
#
#line 5746
allow run_init_t node_type:node { tcp_recv udp_recv rawip_recv };
#line 5746

#line 5746
#
#line 5746
# Allow the domain to send NFS client requests via the socket
#line 5746
# created by mount.
#line 5746
#
#line 5746
allow run_init_t mount_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 5746

#line 5746
#
#line 5746
# Bind to the default port type.
#line 5746
# Other port types must be separately authorized.
#line 5746
#
#line 5746
allow run_init_t port_t:udp_socket name_bind;
#line 5746
allow run_init_t port_t:tcp_socket name_bind;
#line 5746

#line 5746

#line 5746


# added for now 
allow initrc_t any_socket_t:udp_socket { sendto };
allow initrc_t netif_eth0_t:netif { udp_recv };
allow initrc_t node_t:node { udp_recv };
allow initrc_t port_t:udp_socket { name_bind };
allow initrc_t var_spool_t:dir { read };
allow initrc_t var_yp_t:file { read setattr write };
allow initrc_t device_t:dir { add_name write };
allow initrc_t device_t:lnk_file { read };
allow initrc_t device_t:sock_file { create setattr };
allow initrc_t initrc_t:process { setcap setpgid };
allow initrc_t initrc_t:rawip_socket { create getopt };
allow initrc_t initrc_t:tcp_socket { accept acceptfrom bind connect connectto create getattr listen read recvfrom setopt write };
allow initrc_t initrc_t:unix_stream_socket { listen };
allow initrc_t lib_t:lnk_file { read };
allow initrc_t mount_t:udp_socket { recvfrom };
allow initrc_t netif_eth0_t:netif { tcp_send udp_send };
allow initrc_t netif_lo_t:netif { tcp_recv tcp_send udp_recv udp_send };
allow initrc_t netmsg_eth0_t:tcp_socket { connectto recvfrom };
allow initrc_t netmsg_eth0_t:udp_socket { recvfrom };
allow initrc_t node_lo_t:node { tcp_recv tcp_send udp_recv udp_send };
allow initrc_t node_t:node { tcp_send udp_send };
allow initrc_t var_t:dir { read };
allow initrc_t var_t:file { read };
allow initrc_t var_t:lnk_file { read };
allow initrc_t var_yp_t:dir { add_name read write };
allow initrc_t var_yp_t:file { create };
allow initrc_t etc_t:file { unlink };
allow initrc_t initrc_t:udp_socket { bind create ioctl recvfrom setopt };
allow initrc_t etc_t:file { setattr write };
allow initrc_t initrc_t:udp_socket { connect getattr read write };
allow initrc_t modules_dep_t:file { read };
allow initrc_t port_t:tcp_socket { name_bind };
allow initrc_t resolv_conf_t:file { read };
allow initrc_t usr_t:file { read };
allow initrc_t var_lib_nfs_t:dir { read write };
allow initrc_t var_lib_nfs_t:file { read write };

allow initrc_t apm_bios_t:chr_file { setattr };
allow initrc_t device_t:chr_file { write };
allow initrc_t device_t:dir { read };
allow initrc_t v4l_device_t:chr_file { setattr };
allow initrc_t var_run_dhcpc_t:file { write };
allow initrc_t var_spool_t:file { execute };

# added for buffer overflow exploit test
allow initrc_t newrole_t:fd { use };
allow initrc_t security_t:security { sid_to_context };
allow initrc_t usr_t:dir { add_name remove_name write };
allow initrc_t usr_t:file { create execute execute_no_trans unlink write setattr };

# added to run society using acme
allow initrc_t acme_t:udp_socket { recvfrom };
allow initrc_t var_lib_nfs_t:dir { add_name };
allow initrc_t var_lib_nfs_t:file { create };
allow initrc_t tmp_t:file { setattr write };
allow initrc_t tmp_t:sock_file { write };
#DESC Init - Process initialization
#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
#

#################################
#
# Rules for the init_t domain.
#
# init_t is the domain of the init process.
# init_exec_t is the type of the init program.
# initctl_t is the type of the named pipe created 
# by init during initialization.  This pipe is used
# to communicate with init.
# sulogin_exec_t is the type of sulogin.
#
type init_t, domain, privlog, mlstrustedreader, mlstrustedwriter;
role system_r types init_t;

#line 5823
allow init_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 5823
allow init_t ld_so_t:file { read getattr lock execute ioctl };
#line 5823
allow init_t ld_so_t:file execute_no_trans;
#line 5823
allow init_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 5823
allow init_t shlib_t:file { read getattr lock execute ioctl };
#line 5823
allow init_t shlib_t:lnk_file { read getattr lock ioctl };
#line 5823
allow init_t ld_so_cache_t:file { read getattr lock ioctl };
#line 5823
allow init_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 5823
;
type init_exec_t, file_type, sysadmfile, exec_type;
type initctl_t, file_type, sysadmfile;
type sulogin_exec_t, file_type, exec_type, sysadmfile;

# Use capabilities.
allow init_t init_t:capability ~sys_module;

# Run /etc/rc.sysinit, /etc/rc, /etc/rc.local in the initrc_t domain.

#line 5832

#line 5832

#line 5832
#
#line 5832
# Allow the process to transition to the new domain.
#line 5832
#
#line 5832
allow init_t initrc_t:process transition;
#line 5832

#line 5832
#
#line 5832
# Allow the process to execute the program.
#line 5832
# 
#line 5832
allow init_t initrc_exec_t:file { getattr execute };
#line 5832

#line 5832
#
#line 5832
# Allow the process to reap the new domain.
#line 5832
#
#line 5832
allow initrc_t init_t:process sigchld;
#line 5832

#line 5832
#
#line 5832
# Allow the new domain to inherit and use file 
#line 5832
# descriptions from the creating process and vice versa.
#line 5832
#
#line 5832
allow initrc_t init_t:fd use;
#line 5832
allow init_t initrc_t:fd use;
#line 5832

#line 5832
#
#line 5832
# Allow the new domain to write back to the old domain via a pipe.
#line 5832
#
#line 5832
allow initrc_t init_t:fifo_file { ioctl read getattr lock write append };
#line 5832

#line 5832
#
#line 5832
# Allow the new domain to read and execute the program.
#line 5832
#
#line 5832
allow initrc_t initrc_exec_t:file { read getattr lock execute ioctl };
#line 5832

#line 5832
#
#line 5832
# Allow the new domain to be entered via the program.
#line 5832
#
#line 5832
allow initrc_t initrc_exec_t:file entrypoint;
#line 5832

#line 5832
type_transition init_t initrc_exec_t:process initrc_t;
#line 5832


# Run the shell or sulogin in the sysadm_t domain for single-user mode.

#line 5835

#line 5835

#line 5835
#
#line 5835
# Allow the process to transition to the new domain.
#line 5835
#
#line 5835
allow init_t sysadm_t:process transition;
#line 5835

#line 5835
#
#line 5835
# Allow the process to execute the program.
#line 5835
# 
#line 5835
allow init_t shell_exec_t:file { getattr execute };
#line 5835

#line 5835
#
#line 5835
# Allow the process to reap the new domain.
#line 5835
#
#line 5835
allow sysadm_t init_t:process sigchld;
#line 5835

#line 5835
#
#line 5835
# Allow the new domain to inherit and use file 
#line 5835
# descriptions from the creating process and vice versa.
#line 5835
#
#line 5835
allow sysadm_t init_t:fd use;
#line 5835
allow init_t sysadm_t:fd use;
#line 5835

#line 5835
#
#line 5835
# Allow the new domain to write back to the old domain via a pipe.
#line 5835
#
#line 5835
allow sysadm_t init_t:fifo_file { ioctl read getattr lock write append };
#line 5835

#line 5835
#
#line 5835
# Allow the new domain to read and execute the program.
#line 5835
#
#line 5835
allow sysadm_t shell_exec_t:file { read getattr lock execute ioctl };
#line 5835

#line 5835
#
#line 5835
# Allow the new domain to be entered via the program.
#line 5835
#
#line 5835
allow sysadm_t shell_exec_t:file entrypoint;
#line 5835

#line 5835
type_transition init_t shell_exec_t:process sysadm_t;
#line 5835


#line 5836

#line 5836

#line 5836
#
#line 5836
# Allow the process to transition to the new domain.
#line 5836
#
#line 5836
allow init_t sysadm_t:process transition;
#line 5836

#line 5836
#
#line 5836
# Allow the process to execute the program.
#line 5836
# 
#line 5836
allow init_t sulogin_exec_t:file { getattr execute };
#line 5836

#line 5836
#
#line 5836
# Allow the process to reap the new domain.
#line 5836
#
#line 5836
allow sysadm_t init_t:process sigchld;
#line 5836

#line 5836
#
#line 5836
# Allow the new domain to inherit and use file 
#line 5836
# descriptions from the creating process and vice versa.
#line 5836
#
#line 5836
allow sysadm_t init_t:fd use;
#line 5836
allow init_t sysadm_t:fd use;
#line 5836

#line 5836
#
#line 5836
# Allow the new domain to write back to the old domain via a pipe.
#line 5836
#
#line 5836
allow sysadm_t init_t:fifo_file { ioctl read getattr lock write append };
#line 5836

#line 5836
#
#line 5836
# Allow the new domain to read and execute the program.
#line 5836
#
#line 5836
allow sysadm_t sulogin_exec_t:file { read getattr lock execute ioctl };
#line 5836

#line 5836
#
#line 5836
# Allow the new domain to be entered via the program.
#line 5836
#
#line 5836
allow sysadm_t sulogin_exec_t:file entrypoint;
#line 5836

#line 5836
type_transition init_t sulogin_exec_t:process sysadm_t;
#line 5836


# Run /sbin/update in the init_t domain.

#line 5839
allow init_t sbin_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 5839


# Run init.

#line 5842
allow init_t init_exec_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 5842


# Run chroot from initrd scripts.
#line 5847


# Create /dev/initctl.

#line 5850

#line 5850

#line 5850

#line 5850
#
#line 5850
# Allow the process to modify the directory.
#line 5850
#
#line 5850
allow init_t device_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 5850

#line 5850
#
#line 5850
# Allow the process to create the file.
#line 5850
#
#line 5850

#line 5850
allow init_t initctl_t:fifo_file { create ioctl read getattr lock write setattr append link unlink rename };
#line 5850

#line 5850

#line 5850

#line 5850
type_transition init_t device_t:fifo_file initctl_t;
#line 5850

#line 5850

#line 5850


# Create ioctl.save.

#line 5853

#line 5853

#line 5853

#line 5853
#
#line 5853
# Allow the process to modify the directory.
#line 5853
#
#line 5853
allow init_t etc_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 5853

#line 5853
#
#line 5853
# Allow the process to create the file.
#line 5853
#
#line 5853

#line 5853
allow init_t etc_runtime_t:file { create ioctl read getattr lock write setattr append link unlink rename };
#line 5853

#line 5853

#line 5853

#line 5853
type_transition init_t etc_t:file etc_runtime_t;
#line 5853

#line 5853

#line 5853


# Update /etc/ld.so.cache
allow init_t ld_so_cache_t:file { ioctl read getattr lock write append };

# Allow access to log files
allow init_t var_t:dir search;
allow init_t var_log_t:dir search;

# read /etc/localtime
allow init_t locale_t:dir { read getattr lock search ioctl };
allow init_t locale_t:{file lnk_file} { read getattr lock ioctl };

# Create unix sockets
allow init_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
allow init_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };

# Permissions required for system startup
allow init_t bin_t:dir { read getattr lock search ioctl };
allow init_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
allow init_t exec_type:{ file lnk_file } { read getattr lock ioctl };
allow init_t sbin_t:dir { read getattr lock search ioctl };
allow init_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };

# allow init to fork
allow init_t self:process { fork sigchld };

# Modify utmp.
allow init_t var_run_t:file { ioctl read getattr lock write append };
allow init_t initrc_var_run_t:file { ioctl read getattr lock write append };

# For /var/run/shutdown.pid.
type init_var_run_t, file_type, sysadmfile, pidfile;

#line 5886

#line 5886

#line 5886

#line 5886
#
#line 5886
# Allow the process to modify the directory.
#line 5886
#
#line 5886
allow init_t var_run_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 5886

#line 5886
#
#line 5886
# Allow the process to create the file.
#line 5886
#
#line 5886

#line 5886
allow init_t init_var_run_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 5886
allow init_t init_var_run_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 5886

#line 5886

#line 5886

#line 5886
type_transition init_t var_run_t:dir init_var_run_t;
#line 5886
type_transition init_t var_run_t:{ file lnk_file sock_file fifo_file } init_var_run_t;
#line 5886

#line 5886

#line 5886


# Shutdown permissions
allow init_t proc_t:dir { read getattr lock search ioctl };
allow init_t proc_t:lnk_file { read getattr lock ioctl };
allow init_t self:dir { read getattr lock search ioctl };
allow init_t self:lnk_file { read getattr lock ioctl };
allow init_t devpts_t:dir { read getattr lock ioctl };

# Modify wtmp.
allow init_t wtmp_t:file { ioctl read getattr lock write append };

# Kill all processes.
allow init_t domain:process { sigchld sigkill sigstop signull signal };

# Allow all processes to send SIGCHLD to init.
allow domain init_t:process { sigchld signull };

# If you load a new policy that removes active domains, processes can
# get stuck if you don't allow unlabeled policies to signal init
# If you load an incompatible policy, you should probably reboot,
# since you may have compromised system security.
# allow unlabeled_t init_t:process sigchld;

# Read and write the console and ttys.
allow init_t console_device_t:chr_file { ioctl read getattr lock write append };
allow init_t tty_device_t:chr_file { ioctl read getattr lock write append };
allow init_t ttyfile:chr_file { ioctl read getattr lock write append };
allow init_t ptyfile:chr_file { ioctl read getattr lock write append };

# Flush the system buffers (/sbin/update)
allow init_t kernel_t:system bdflush;

# Run system executables.

#line 5920
allow init_t bin_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 5920


# Run /etc/X11/prefdm.

#line 5923
allow init_t etc_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 5923


# for initrd pivot_root seems to access this
dontaudit init_t file_labels_t:dir { search };

# added to run society unde acme
allow init_t var_log_ksyms_t:file { append lock write };

#DESC Klogd - Kernel log daemon
#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
#

#################################
#
# Rules for the klogd_t domain.
#
type klogd_t, domain, privlog, privmem;
role system_r types klogd_t;

#line 5942
allow klogd_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 5942
allow klogd_t ld_so_t:file { read getattr lock execute ioctl };
#line 5942
allow klogd_t ld_so_t:file execute_no_trans;
#line 5942
allow klogd_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 5942
allow klogd_t shlib_t:file { read getattr lock execute ioctl };
#line 5942
allow klogd_t shlib_t:lnk_file { read getattr lock ioctl };
#line 5942
allow klogd_t ld_so_cache_t:file { read getattr lock ioctl };
#line 5942
allow klogd_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 5942

type klogd_exec_t, file_type, sysadmfile, exec_type;

#line 5944

#line 5944

#line 5944
#
#line 5944
# Allow the process to transition to the new domain.
#line 5944
#
#line 5944
allow initrc_t klogd_t:process transition;
#line 5944

#line 5944
#
#line 5944
# Allow the process to execute the program.
#line 5944
# 
#line 5944
allow initrc_t klogd_exec_t:file { getattr execute };
#line 5944

#line 5944
#
#line 5944
# Allow the process to reap the new domain.
#line 5944
#
#line 5944
allow klogd_t initrc_t:process sigchld;
#line 5944

#line 5944
#
#line 5944
# Allow the new domain to inherit and use file 
#line 5944
# descriptions from the creating process and vice versa.
#line 5944
#
#line 5944
allow klogd_t initrc_t:fd use;
#line 5944
allow initrc_t klogd_t:fd use;
#line 5944

#line 5944
#
#line 5944
# Allow the new domain to write back to the old domain via a pipe.
#line 5944
#
#line 5944
allow klogd_t initrc_t:fifo_file { ioctl read getattr lock write append };
#line 5944

#line 5944
#
#line 5944
# Allow the new domain to read and execute the program.
#line 5944
#
#line 5944
allow klogd_t klogd_exec_t:file { read getattr lock execute ioctl };
#line 5944

#line 5944
#
#line 5944
# Allow the new domain to be entered via the program.
#line 5944
#
#line 5944
allow klogd_t klogd_exec_t:file entrypoint;
#line 5944

#line 5944
type_transition initrc_t klogd_exec_t:process klogd_t;
#line 5944

allow klogd_t self:process { fork signal };

type klogd_tmp_t, file_type, sysadmfile, tmpfile;

#line 5948

#line 5948

#line 5948

#line 5948
#
#line 5948
# Allow the process to modify the directory.
#line 5948
#
#line 5948
allow klogd_t tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 5948

#line 5948
#
#line 5948
# Allow the process to create the file.
#line 5948
#
#line 5948

#line 5948
allow klogd_t klogd_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 5948
allow klogd_t klogd_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 5948

#line 5948

#line 5948

#line 5948
type_transition klogd_t tmp_t:dir klogd_tmp_t;
#line 5948
type_transition klogd_t tmp_t:{ file lnk_file sock_file fifo_file } klogd_tmp_t;
#line 5948

#line 5948

#line 5948

allow klogd_t var_t:dir { read getattr lock search ioctl };
type klogd_var_run_t, file_type, sysadmfile, pidfile;

#line 5951

#line 5951

#line 5951

#line 5951
#
#line 5951
# Allow the process to modify the directory.
#line 5951
#
#line 5951
allow klogd_t var_run_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 5951

#line 5951
#
#line 5951
# Allow the process to create the file.
#line 5951
#
#line 5951

#line 5951
allow klogd_t klogd_var_run_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 5951
allow klogd_t klogd_var_run_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 5951

#line 5951

#line 5951

#line 5951
type_transition klogd_t var_run_t:dir klogd_var_run_t;
#line 5951
type_transition klogd_t var_run_t:{ file lnk_file sock_file fifo_file } klogd_var_run_t;
#line 5951

#line 5951

#line 5951

allow klogd_t proc_t:dir { read getattr lock search ioctl };
allow klogd_t proc_t:lnk_file { read getattr lock ioctl };
allow klogd_t self:dir { read getattr lock search ioctl };
allow klogd_t self:lnk_file { read getattr lock ioctl };

# read /etc/nsswitch.conf
allow klogd_t etc_t:file { read getattr lock ioctl };

# read localization information
allow klogd_t locale_t:dir { read getattr lock search ioctl };
allow klogd_t locale_t:{file lnk_file} { read getattr lock ioctl };

# Create unix sockets
allow klogd_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };

# Use the sys_admin and sys_rawio capabilities.
allow klogd_t klogd_t:capability { sys_admin sys_rawio };

# Inherit and use descriptors from init.
allow klogd_t init_t:fd use;

# Read /proc/kmsg and /dev/mem.
allow klogd_t device_t:dir { read getattr lock search ioctl };
allow klogd_t proc_kmsg_t:file { read getattr lock ioctl };
allow klogd_t memory_device_t:chr_file { read getattr lock ioctl };

# Write to the console.
allow klogd_t { initrc_devpts_t console_device_t }:chr_file { ioctl read getattr lock write append };

# Control syslog and console logging
allow klogd_t kernel_t:system { syslog_mod syslog_console };

# Read /boot/System.map*
allow klogd_t system_map_t:file { read getattr lock ioctl };
allow klogd_t boot_t:dir { read getattr lock search ioctl };
allow klogd_t boot_t:{ file lnk_file } { read getattr lock ioctl };
#DESC Ldconfig - Configure dynamic linker bindings
#
# Author:  Russell Coker <russell@coker.com.au>
#

#################################
#
# Rules for the ldconfig_t domain.
#
type ldconfig_t, domain, privlog;
type ldconfig_exec_t, file_type, sysadmfile, exec_type;

role sysadm_r types ldconfig_t;
role system_r types ldconfig_t;


#line 6003

#line 6003

#line 6003
#
#line 6003
# Allow the process to transition to the new domain.
#line 6003
#
#line 6003
allow { sysadm_t initrc_t  } ldconfig_t:process transition;
#line 6003

#line 6003
#
#line 6003
# Allow the process to execute the program.
#line 6003
# 
#line 6003
allow { sysadm_t initrc_t  } ldconfig_exec_t:file { getattr execute };
#line 6003

#line 6003
#
#line 6003
# Allow the process to reap the new domain.
#line 6003
#
#line 6003
allow ldconfig_t { sysadm_t initrc_t  }:process sigchld;
#line 6003

#line 6003
#
#line 6003
# Allow the new domain to inherit and use file 
#line 6003
# descriptions from the creating process and vice versa.
#line 6003
#
#line 6003
allow ldconfig_t { sysadm_t initrc_t  }:fd use;
#line 6003
allow { sysadm_t initrc_t  } ldconfig_t:fd use;
#line 6003

#line 6003
#
#line 6003
# Allow the new domain to write back to the old domain via a pipe.
#line 6003
#
#line 6003
allow ldconfig_t { sysadm_t initrc_t  }:fifo_file { ioctl read getattr lock write append };
#line 6003

#line 6003
#
#line 6003
# Allow the new domain to read and execute the program.
#line 6003
#
#line 6003
allow ldconfig_t ldconfig_exec_t:file { read getattr lock execute ioctl };
#line 6003

#line 6003
#
#line 6003
# Allow the new domain to be entered via the program.
#line 6003
#
#line 6003
allow ldconfig_t ldconfig_exec_t:file entrypoint;
#line 6003

#line 6003
type_transition { sysadm_t initrc_t  } ldconfig_exec_t:process ldconfig_t;
#line 6003

dontaudit ldconfig_t device_t:dir search;
allow ldconfig_t { initrc_devpts_t { sysadm_tty_device_t sysadm_devpts_t } }:chr_file { ioctl read getattr lock write append };
allow ldconfig_t privfd:fd use;


#line 6008
allow ldconfig_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 6008
allow ldconfig_t ld_so_t:file { read getattr lock execute ioctl };
#line 6008
allow ldconfig_t ld_so_t:file execute_no_trans;
#line 6008
allow ldconfig_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 6008
allow ldconfig_t shlib_t:file { read getattr lock execute ioctl };
#line 6008
allow ldconfig_t shlib_t:lnk_file { read getattr lock ioctl };
#line 6008
allow ldconfig_t ld_so_cache_t:file { read getattr lock ioctl };
#line 6008
allow ldconfig_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 6008



#line 6010

#line 6010

#line 6010

#line 6010
#
#line 6010
# Allow the process to modify the directory.
#line 6010
#
#line 6010
allow ldconfig_t etc_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 6010

#line 6010
#
#line 6010
# Allow the process to create the file.
#line 6010
#
#line 6010

#line 6010
allow ldconfig_t ld_so_cache_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 6010
allow ldconfig_t ld_so_cache_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 6010

#line 6010

#line 6010

#line 6010
type_transition ldconfig_t etc_t:dir ld_so_cache_t;
#line 6010
type_transition ldconfig_t etc_t:{ file lnk_file sock_file fifo_file } ld_so_cache_t;
#line 6010

#line 6010

#line 6010


#line 6011

#line 6011

#line 6011

#line 6011
#
#line 6011
# Allow the process to modify the directory.
#line 6011
#
#line 6011
allow ldconfig_t lib_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 6011

#line 6011
#
#line 6011
# Allow the process to create the file.
#line 6011
#
#line 6011

#line 6011
allow ldconfig_t shlib_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 6011
allow ldconfig_t shlib_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 6011

#line 6011

#line 6011

#line 6011
type_transition ldconfig_t lib_t:dir shlib_t;
#line 6011
type_transition ldconfig_t lib_t:{ file lnk_file sock_file fifo_file } shlib_t;
#line 6011

#line 6011

#line 6011

# allow removing mis-labelled links
allow ldconfig_t lib_t:lnk_file unlink;

allow ldconfig_t userdomain:fd use;
allow ldconfig_t etc_t:file { getattr read };
allow ldconfig_t etc_t:lnk_file read;

allow ldconfig_t fs_t:filesystem getattr;
#DESC LoadPolicy - SELinux policy loading utilities
#
# Authors:  Frank Mayer, mayerf@tresys.com
#

###########################
# load_policy_t is the domain type for load_policy 
# load_policy_exec_t is the file type for the executable


type load_policy_t, domain;
role sysadm_r types load_policy_t;

type load_policy_exec_t, file_type, exec_type, sysadmfile;

##########################
# 
# Rules


#line 6039

#line 6039

#line 6039
#
#line 6039
# Allow the process to transition to the new domain.
#line 6039
#
#line 6039
allow sysadm_t load_policy_t:process transition;
#line 6039

#line 6039
#
#line 6039
# Allow the process to execute the program.
#line 6039
# 
#line 6039
allow sysadm_t load_policy_exec_t:file { getattr execute };
#line 6039

#line 6039
#
#line 6039
# Allow the process to reap the new domain.
#line 6039
#
#line 6039
allow load_policy_t sysadm_t:process sigchld;
#line 6039

#line 6039
#
#line 6039
# Allow the new domain to inherit and use file 
#line 6039
# descriptions from the creating process and vice versa.
#line 6039
#
#line 6039
allow load_policy_t sysadm_t:fd use;
#line 6039
allow sysadm_t load_policy_t:fd use;
#line 6039

#line 6039
#
#line 6039
# Allow the new domain to write back to the old domain via a pipe.
#line 6039
#
#line 6039
allow load_policy_t sysadm_t:fifo_file { ioctl read getattr lock write append };
#line 6039

#line 6039
#
#line 6039
# Allow the new domain to read and execute the program.
#line 6039
#
#line 6039
allow load_policy_t load_policy_exec_t:file { read getattr lock execute ioctl };
#line 6039

#line 6039
#
#line 6039
# Allow the new domain to be entered via the program.
#line 6039
#
#line 6039
allow load_policy_t load_policy_exec_t:file entrypoint;
#line 6039

#line 6039
type_transition sysadm_t load_policy_exec_t:process load_policy_t;
#line 6039

#line 6043


# Reload the policy configuration (sysadm_t no longer has this ability)
allow load_policy_t security_t:security load_policy;


###########################
# constrain from where load_policy can load a policy, specifically 
# policy_config_t files 
#

# only allow read of policy config files
allow load_policy_t policy_config_t:dir { read getattr lock search ioctl };
allow load_policy_t policy_config_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };

# directory search permissions for path to binary policy files
allow load_policy_t root_t:dir search;
allow load_policy_t etc_t:dir search;

# Read the devpts root directory (needed?)  
allow load_policy_t devpts_t:dir { read getattr lock search ioctl };

# Other access
allow load_policy_t { initrc_devpts_t { sysadm_tty_device_t sysadm_devpts_t } }:chr_file { read write ioctl getattr };

#line 6067
allow load_policy_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 6067
allow load_policy_t ld_so_t:file { read getattr lock execute ioctl };
#line 6067
allow load_policy_t ld_so_t:file execute_no_trans;
#line 6067
allow load_policy_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 6067
allow load_policy_t shlib_t:file { read getattr lock execute ioctl };
#line 6067
allow load_policy_t shlib_t:lnk_file { read getattr lock ioctl };
#line 6067
allow load_policy_t ld_so_cache_t:file { read getattr lock ioctl };
#line 6067
allow load_policy_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 6067

allow load_policy_t self:capability dac_override;

allow load_policy_t { initrc_t privfd }:fd use;

allow load_policy_t fs_t:filesystem getattr;

allow load_policy_t sysadm_tmp_t:file { getattr write } ;

#DESC Login - Local/remote login utilities
#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
# Macroised by Russell Coker <russell@coker.com.au>
#

#################################
# 
# Rules for the local_login_t domain
# and the remote_login_t domain.
#

# $1 is the name of the domain (local or remote)
# I added "mlstrustedreader, mlstrustedwriter, mlstrustedobject" to
# remote_login_t, not sure if this is right
#line 6169


#################################
#
# Rules for the local_login_t domain.
#
# local_login_t is the domain of a login process 
# spawned by getty.
#
# remote_login_t is the domain of a login process 
# spawned by rlogind.
#
# login_exec_t is the type of the login program
#
type login_exec_t, file_type, sysadmfile, exec_type;


#line 6185
type local_login_t, domain, privuser, privrole, privlog, auth, privowner, mlstrustedreader, mlstrustedwriter, mlstrustedobject, privfd;
#line 6185
role system_r types local_login_t;
#line 6185

#line 6185

#line 6185
# Access other processes in the same domain.
#line 6185
allow local_login_t self:process *;
#line 6185

#line 6185
# Access /proc/PID files for processes in the same domain.
#line 6185
allow local_login_t self:dir { read getattr lock search ioctl };
#line 6185
allow local_login_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6185

#line 6185
# Access file descriptions, pipes, and sockets
#line 6185
# created by processes in the same domain.
#line 6185
allow local_login_t self:fd *;
#line 6185
allow local_login_t self:fifo_file { ioctl read getattr lock write append };
#line 6185
allow local_login_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 6185
allow local_login_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 6185

#line 6185
# Allow the domain to communicate with other processes in the same domain.
#line 6185
allow local_login_t self:unix_dgram_socket sendto;
#line 6185
allow local_login_t self:unix_stream_socket connectto;
#line 6185

#line 6185
# Access System V IPC objects created by processes in the same domain.
#line 6185
allow local_login_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 6185
allow local_login_t self:msg  { send receive };
#line 6185
allow local_login_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 6185
allow local_login_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 6185

#line 6185
;
#line 6185

#line 6185
# Read system information files in /proc.
#line 6185
allow local_login_t proc_t:dir { read getattr lock search ioctl };
#line 6185
allow local_login_t proc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6185

#line 6185

#line 6185
# Read /.
#line 6185
allow local_login_t root_t:dir { read getattr lock search ioctl };
#line 6185
allow local_login_t root_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6185

#line 6185
# Read /home.
#line 6185
allow local_login_t home_root_t:dir { read getattr lock search ioctl };
#line 6185

#line 6185
# Read /usr.
#line 6185
allow local_login_t usr_t:dir { read getattr lock search ioctl };
#line 6185
allow local_login_t usr_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6185

#line 6185
# Read bin and sbin directories.
#line 6185
allow local_login_t bin_t:dir { read getattr lock search ioctl };
#line 6185
allow local_login_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6185
allow local_login_t sbin_t:dir { read getattr lock search ioctl };
#line 6185
allow local_login_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6185

#line 6185

#line 6185
# Read directories and files with the readable_t type.
#line 6185
# This type is a general type for "world"-readable files.
#line 6185
allow local_login_t readable_t:dir { read getattr lock search ioctl };
#line 6185
allow local_login_t readable_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6185

#line 6185
# Read /var, /var/spool, /var/log.
#line 6185
allow local_login_t var_t:dir { read getattr lock search ioctl };
#line 6185
allow local_login_t var_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6185
allow local_login_t var_spool_t:dir { read getattr lock search ioctl };
#line 6185
allow local_login_t var_spool_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6185
allow local_login_t var_log_t:dir { read getattr lock search ioctl };
#line 6185
allow local_login_t var_log_t:{ file lnk_file } { read getattr lock ioctl };
#line 6185

#line 6185
# Read /etc.
#line 6185
allow local_login_t etc_t:dir { read getattr lock search ioctl };
#line 6185
allow local_login_t etc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6185
allow local_login_t etc_runtime_t:{ file lnk_file } { read getattr lock ioctl };
#line 6185

#line 6185
# Read executable types.
#line 6185
allow local_login_t exec_type:{ file lnk_file } { read getattr lock ioctl };
#line 6185

#line 6185
# Read /dev directories and any symbolic links.
#line 6185
allow local_login_t device_t:dir { read getattr lock search ioctl };
#line 6185
allow local_login_t device_t:lnk_file { read getattr lock ioctl };
#line 6185

#line 6185

#line 6185
allow local_login_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 6185
allow local_login_t ld_so_t:file { read getattr lock execute ioctl };
#line 6185
allow local_login_t ld_so_t:file execute_no_trans;
#line 6185
allow local_login_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 6185
allow local_login_t shlib_t:file { read getattr lock execute ioctl };
#line 6185
allow local_login_t shlib_t:lnk_file { read getattr lock ioctl };
#line 6185
allow local_login_t ld_so_cache_t:file { read getattr lock ioctl };
#line 6185
allow local_login_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 6185
;
#line 6185
allow local_login_t security_t:security {sid_to_context context_to_sid };
#line 6185

#line 6185

#line 6185
type local_login_tmp_t, file_type, sysadmfile, tmpfile ;
#line 6185

#line 6185

#line 6185

#line 6185

#line 6185
#
#line 6185
# Allow the process to modify the directory.
#line 6185
#
#line 6185
allow local_login_t tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 6185

#line 6185
#
#line 6185
# Allow the process to create the file.
#line 6185
#
#line 6185

#line 6185
allow local_login_t local_login_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 6185
allow local_login_t local_login_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 6185

#line 6185

#line 6185

#line 6185
type_transition local_login_t tmp_t:dir local_login_tmp_t;
#line 6185
type_transition local_login_t tmp_t:{ file lnk_file sock_file fifo_file } local_login_tmp_t;
#line 6185

#line 6185

#line 6185

#line 6185

#line 6185

#line 6185
# Use capabilities
#line 6185
allow local_login_t self:capability { setuid setgid chown fowner fsetid net_bind_service sys_tty_config dac_override sys_nice sys_resource };
#line 6185

#line 6185
# Run shells in user_t by default.
#line 6185

#line 6185

#line 6185

#line 6185
#
#line 6185
# Allow the process to transition to the new domain.
#line 6185
#
#line 6185
allow local_login_t user_t:process transition;
#line 6185

#line 6185
#
#line 6185
# Allow the process to execute the program.
#line 6185
# 
#line 6185
allow local_login_t shell_exec_t:file { getattr execute };
#line 6185

#line 6185
#
#line 6185
# Allow the process to reap the new domain.
#line 6185
#
#line 6185
allow user_t local_login_t:process sigchld;
#line 6185

#line 6185
#
#line 6185
# Allow the new domain to inherit and use file 
#line 6185
# descriptions from the creating process and vice versa.
#line 6185
#
#line 6185
allow user_t local_login_t:fd use;
#line 6185
allow local_login_t user_t:fd use;
#line 6185

#line 6185
#
#line 6185
# Allow the new domain to write back to the old domain via a pipe.
#line 6185
#
#line 6185
allow user_t local_login_t:fifo_file { ioctl read getattr lock write append };
#line 6185

#line 6185
#
#line 6185
# Allow the new domain to read and execute the program.
#line 6185
#
#line 6185
allow user_t shell_exec_t:file { read getattr lock execute ioctl };
#line 6185

#line 6185
#
#line 6185
# Allow the new domain to be entered via the program.
#line 6185
#
#line 6185
allow user_t shell_exec_t:file entrypoint;
#line 6185

#line 6185
type_transition local_login_t shell_exec_t:process user_t;
#line 6185

#line 6185

#line 6185
# Permit login to search the user home directories.
#line 6185
allow local_login_t home_root_t:dir search;
#line 6185
allow local_login_t home_dir_type:dir search;
#line 6185

#line 6185
# Write to /var/run/utmp.
#line 6185
allow local_login_t initrc_var_run_t:file { ioctl read getattr lock write append };
#line 6185

#line 6185
# Write to /var/log/wtmp.
#line 6185
allow local_login_t wtmp_t:file { ioctl read getattr lock write append };
#line 6185

#line 6185
# Write to /var/log/lastlog.
#line 6185
allow local_login_t lastlog_t:file { ioctl read getattr lock write append };
#line 6185

#line 6185
# Write to /var/log/btmp
#line 6185
allow local_login_t faillog_t:file { append read write };
#line 6185

#line 6185
# Search for mail spool file.
#line 6185
allow local_login_t mail_spool_t:dir { read getattr lock search ioctl };
#line 6185
allow local_login_t mail_spool_t:file getattr;
#line 6185
allow local_login_t mail_spool_t:lnk_file read;
#line 6185

#line 6185
# Determine the set of legal user SIDs that can be reached.
#line 6185
allow local_login_t security_t:security get_user_sids;
#line 6185

#line 6185
# Obtain the SID to use for relabeling terminals.
#line 6185
allow local_login_t security_t:security change_sid;
#line 6185

#line 6185
# allow read access to default_contexts in /etc/security
#line 6185
allow local_login_t default_context_t:file { read getattr lock ioctl };
#line 6185

#line 6185


# But also permit other user domains to be entered by login.

#line 6188

#line 6188
#
#line 6188
# Allow the process to transition to the new domain.
#line 6188
#
#line 6188
allow local_login_t userdomain:process transition;
#line 6188

#line 6188
#
#line 6188
# Allow the process to execute the program.
#line 6188
# 
#line 6188
allow local_login_t shell_exec_t:file { getattr execute };
#line 6188

#line 6188
#
#line 6188
# Allow the process to reap the new domain.
#line 6188
#
#line 6188
allow userdomain local_login_t:process sigchld;
#line 6188

#line 6188
#
#line 6188
# Allow the new domain to inherit and use file 
#line 6188
# descriptions from the creating process and vice versa.
#line 6188
#
#line 6188
allow userdomain local_login_t:fd use;
#line 6188
allow local_login_t userdomain:fd use;
#line 6188

#line 6188
#
#line 6188
# Allow the new domain to write back to the old domain via a pipe.
#line 6188
#
#line 6188
allow userdomain local_login_t:fifo_file { ioctl read getattr lock write append };
#line 6188

#line 6188
#
#line 6188
# Allow the new domain to read and execute the program.
#line 6188
#
#line 6188
allow userdomain shell_exec_t:file { read getattr lock execute ioctl };
#line 6188

#line 6188
#
#line 6188
# Allow the new domain to be entered via the program.
#line 6188
#
#line 6188
allow userdomain shell_exec_t:file entrypoint;
#line 6188


# read localization information
allow local_login_t locale_t:dir { read getattr lock search ioctl };
allow local_login_t locale_t:{file lnk_file} { read getattr lock ioctl };

# Do not audit denied attempts to access devices.
dontaudit local_login_t fixed_disk_device_t:blk_file { getattr setattr };
dontaudit local_login_t removable_device_t:blk_file { getattr setattr };
dontaudit local_login_t device_t:{ chr_file blk_file lnk_file } { getattr setattr };
dontaudit local_login_t misc_device_t:{ chr_file blk_file lnk_file } { getattr setattr };
dontaudit local_login_t framebuf_device_t:{ chr_file blk_file lnk_file } { getattr setattr read };
dontaudit local_login_t apm_bios_t:chr_file { getattr setattr };
dontaudit local_login_t v4l_device_t:{ chr_file blk_file lnk_file } { getattr setattr read };
dontaudit local_login_t v4l_device_t:dir { read search getattr };

# Do not audit denied attempts to access /mnt.
dontaudit local_login_t file_t:dir { read getattr lock search ioctl };


# Create lock file.
allow local_login_t var_lock_t:dir { read getattr lock search ioctl add_name remove_name write };
allow local_login_t var_lock_t:file { create ioctl read getattr lock write setattr append link unlink rename };


# Read and write ttys.
allow local_login_t tty_device_t:chr_file { setattr { ioctl read getattr lock write append } };
allow local_login_t ttyfile:chr_file { setattr { ioctl read getattr lock write append } };

# Relabel ttys.
allow local_login_t tty_device_t:chr_file { getattr relabelfrom relabelto };
allow local_login_t ttyfile:chr_file { getattr relabelfrom relabelto };

#line 6222


# Allow setting of attributes on sound devices.
allow local_login_t sound_device_t:chr_file { getattr setattr };

# Allow access to /var/run/console and /var/run/console.lock.  Need a separate type?
allow local_login_t var_run_t:dir { read getattr lock search ioctl add_name remove_name write };
allow local_login_t var_run_t:file { create ioctl read getattr lock write setattr append link unlink rename };


# Aded by us 
allow local_login_t any_socket_t:udp_socket { sendto };
allow local_login_t local_login_t:tcp_socket { bind connect create read write };
allow local_login_t local_login_t:udp_socket { bind create read setopt write };
allow local_login_t netif_eth0_t:netif { tcp_send udp_send };
allow local_login_t netmsg_eth0_t:tcp_socket { connectto recvfrom };
allow local_login_t netmsg_eth0_t:udp_socket { recvfrom };
allow local_login_t node_t:node { tcp_send udp_send };
allow local_login_t port_t:tcp_socket { name_bind };
allow local_login_t port_t:udp_socket { name_bind };
allow local_login_t var_spool_t:file { execute };
allow local_login_t var_yp_t:dir { search };
allow local_login_t var_yp_t:file { read };
allow local_login_t any_socket_t:udp_socket { sendto };
allow local_login_t local_login_t:tcp_socket { read write };
allow local_login_t netmsg_eth0_t:tcp_socket { connectto recvfrom };
allow local_login_t node_t:node { tcp_send };
allow local_login_t port_t:tcp_socket { name_bind };
allow local_login_t port_t:udp_socket { name_bind };
#allow local_login_t var_spool_t:file { execute };
allow local_login_t var_yp_t:file { read };
allow user_t var_yp_t:dir { search };
allow user_t var_yp_t:file { read };

#################################
#
# Rules for the remote_login_t domain.
#


#line 6261
type remote_login_t, domain, privuser, privrole, privlog, auth, privowner, mlstrustedreader, mlstrustedwriter, mlstrustedobject, privfd;
#line 6261
role system_r types remote_login_t;
#line 6261

#line 6261

#line 6261
# Access other processes in the same domain.
#line 6261
allow remote_login_t self:process *;
#line 6261

#line 6261
# Access /proc/PID files for processes in the same domain.
#line 6261
allow remote_login_t self:dir { read getattr lock search ioctl };
#line 6261
allow remote_login_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6261

#line 6261
# Access file descriptions, pipes, and sockets
#line 6261
# created by processes in the same domain.
#line 6261
allow remote_login_t self:fd *;
#line 6261
allow remote_login_t self:fifo_file { ioctl read getattr lock write append };
#line 6261
allow remote_login_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 6261
allow remote_login_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 6261

#line 6261
# Allow the domain to communicate with other processes in the same domain.
#line 6261
allow remote_login_t self:unix_dgram_socket sendto;
#line 6261
allow remote_login_t self:unix_stream_socket connectto;
#line 6261

#line 6261
# Access System V IPC objects created by processes in the same domain.
#line 6261
allow remote_login_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 6261
allow remote_login_t self:msg  { send receive };
#line 6261
allow remote_login_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 6261
allow remote_login_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 6261

#line 6261
;
#line 6261

#line 6261
# Read system information files in /proc.
#line 6261
allow remote_login_t proc_t:dir { read getattr lock search ioctl };
#line 6261
allow remote_login_t proc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6261

#line 6261

#line 6261
# Read /.
#line 6261
allow remote_login_t root_t:dir { read getattr lock search ioctl };
#line 6261
allow remote_login_t root_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6261

#line 6261
# Read /home.
#line 6261
allow remote_login_t home_root_t:dir { read getattr lock search ioctl };
#line 6261

#line 6261
# Read /usr.
#line 6261
allow remote_login_t usr_t:dir { read getattr lock search ioctl };
#line 6261
allow remote_login_t usr_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6261

#line 6261
# Read bin and sbin directories.
#line 6261
allow remote_login_t bin_t:dir { read getattr lock search ioctl };
#line 6261
allow remote_login_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6261
allow remote_login_t sbin_t:dir { read getattr lock search ioctl };
#line 6261
allow remote_login_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6261

#line 6261

#line 6261
# Read directories and files with the readable_t type.
#line 6261
# This type is a general type for "world"-readable files.
#line 6261
allow remote_login_t readable_t:dir { read getattr lock search ioctl };
#line 6261
allow remote_login_t readable_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6261

#line 6261
# Read /var, /var/spool, /var/log.
#line 6261
allow remote_login_t var_t:dir { read getattr lock search ioctl };
#line 6261
allow remote_login_t var_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6261
allow remote_login_t var_spool_t:dir { read getattr lock search ioctl };
#line 6261
allow remote_login_t var_spool_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6261
allow remote_login_t var_log_t:dir { read getattr lock search ioctl };
#line 6261
allow remote_login_t var_log_t:{ file lnk_file } { read getattr lock ioctl };
#line 6261

#line 6261
# Read /etc.
#line 6261
allow remote_login_t etc_t:dir { read getattr lock search ioctl };
#line 6261
allow remote_login_t etc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6261
allow remote_login_t etc_runtime_t:{ file lnk_file } { read getattr lock ioctl };
#line 6261

#line 6261
# Read executable types.
#line 6261
allow remote_login_t exec_type:{ file lnk_file } { read getattr lock ioctl };
#line 6261

#line 6261
# Read /dev directories and any symbolic links.
#line 6261
allow remote_login_t device_t:dir { read getattr lock search ioctl };
#line 6261
allow remote_login_t device_t:lnk_file { read getattr lock ioctl };
#line 6261

#line 6261

#line 6261
allow remote_login_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 6261
allow remote_login_t ld_so_t:file { read getattr lock execute ioctl };
#line 6261
allow remote_login_t ld_so_t:file execute_no_trans;
#line 6261
allow remote_login_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 6261
allow remote_login_t shlib_t:file { read getattr lock execute ioctl };
#line 6261
allow remote_login_t shlib_t:lnk_file { read getattr lock ioctl };
#line 6261
allow remote_login_t ld_so_cache_t:file { read getattr lock ioctl };
#line 6261
allow remote_login_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 6261
;
#line 6261
allow remote_login_t security_t:security {sid_to_context context_to_sid };
#line 6261

#line 6261

#line 6261
type remote_login_tmp_t, file_type, sysadmfile, tmpfile ;
#line 6261

#line 6261

#line 6261

#line 6261

#line 6261
#
#line 6261
# Allow the process to modify the directory.
#line 6261
#
#line 6261
allow remote_login_t tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 6261

#line 6261
#
#line 6261
# Allow the process to create the file.
#line 6261
#
#line 6261

#line 6261
allow remote_login_t remote_login_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 6261
allow remote_login_t remote_login_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 6261

#line 6261

#line 6261

#line 6261
type_transition remote_login_t tmp_t:dir remote_login_tmp_t;
#line 6261
type_transition remote_login_t tmp_t:{ file lnk_file sock_file fifo_file } remote_login_tmp_t;
#line 6261

#line 6261

#line 6261

#line 6261

#line 6261

#line 6261
# Use capabilities
#line 6261
allow remote_login_t self:capability { setuid setgid chown fowner fsetid net_bind_service sys_tty_config dac_override sys_nice sys_resource };
#line 6261

#line 6261
# Run shells in user_t by default.
#line 6261

#line 6261

#line 6261

#line 6261
#
#line 6261
# Allow the process to transition to the new domain.
#line 6261
#
#line 6261
allow remote_login_t user_t:process transition;
#line 6261

#line 6261
#
#line 6261
# Allow the process to execute the program.
#line 6261
# 
#line 6261
allow remote_login_t shell_exec_t:file { getattr execute };
#line 6261

#line 6261
#
#line 6261
# Allow the process to reap the new domain.
#line 6261
#
#line 6261
allow user_t remote_login_t:process sigchld;
#line 6261

#line 6261
#
#line 6261
# Allow the new domain to inherit and use file 
#line 6261
# descriptions from the creating process and vice versa.
#line 6261
#
#line 6261
allow user_t remote_login_t:fd use;
#line 6261
allow remote_login_t user_t:fd use;
#line 6261

#line 6261
#
#line 6261
# Allow the new domain to write back to the old domain via a pipe.
#line 6261
#
#line 6261
allow user_t remote_login_t:fifo_file { ioctl read getattr lock write append };
#line 6261

#line 6261
#
#line 6261
# Allow the new domain to read and execute the program.
#line 6261
#
#line 6261
allow user_t shell_exec_t:file { read getattr lock execute ioctl };
#line 6261

#line 6261
#
#line 6261
# Allow the new domain to be entered via the program.
#line 6261
#
#line 6261
allow user_t shell_exec_t:file entrypoint;
#line 6261

#line 6261
type_transition remote_login_t shell_exec_t:process user_t;
#line 6261

#line 6261

#line 6261
# Permit login to search the user home directories.
#line 6261
allow remote_login_t home_root_t:dir search;
#line 6261
allow remote_login_t home_dir_type:dir search;
#line 6261

#line 6261
# Write to /var/run/utmp.
#line 6261
allow remote_login_t initrc_var_run_t:file { ioctl read getattr lock write append };
#line 6261

#line 6261
# Write to /var/log/wtmp.
#line 6261
allow remote_login_t wtmp_t:file { ioctl read getattr lock write append };
#line 6261

#line 6261
# Write to /var/log/lastlog.
#line 6261
allow remote_login_t lastlog_t:file { ioctl read getattr lock write append };
#line 6261

#line 6261
# Write to /var/log/btmp
#line 6261
allow remote_login_t faillog_t:file { append read write };
#line 6261

#line 6261
# Search for mail spool file.
#line 6261
allow remote_login_t mail_spool_t:dir { read getattr lock search ioctl };
#line 6261
allow remote_login_t mail_spool_t:file getattr;
#line 6261
allow remote_login_t mail_spool_t:lnk_file read;
#line 6261

#line 6261
# Determine the set of legal user SIDs that can be reached.
#line 6261
allow remote_login_t security_t:security get_user_sids;
#line 6261

#line 6261
# Obtain the SID to use for relabeling terminals.
#line 6261
allow remote_login_t security_t:security change_sid;
#line 6261

#line 6261
# allow read access to default_contexts in /etc/security
#line 6261
allow remote_login_t default_context_t:file { read getattr lock ioctl };
#line 6261

#line 6261


# Only permit unprivileged user domains to be entered via rlogin,
# since very weak authentication is used.

#line 6265

#line 6265
#
#line 6265
# Allow the process to transition to the new domain.
#line 6265
#
#line 6265
allow remote_login_t unpriv_userdomain:process transition;
#line 6265

#line 6265
#
#line 6265
# Allow the process to execute the program.
#line 6265
# 
#line 6265
allow remote_login_t shell_exec_t:file { getattr execute };
#line 6265

#line 6265
#
#line 6265
# Allow the process to reap the new domain.
#line 6265
#
#line 6265
allow unpriv_userdomain remote_login_t:process sigchld;
#line 6265

#line 6265
#
#line 6265
# Allow the new domain to inherit and use file 
#line 6265
# descriptions from the creating process and vice versa.
#line 6265
#
#line 6265
allow unpriv_userdomain remote_login_t:fd use;
#line 6265
allow remote_login_t unpriv_userdomain:fd use;
#line 6265

#line 6265
#
#line 6265
# Allow the new domain to write back to the old domain via a pipe.
#line 6265
#
#line 6265
allow unpriv_userdomain remote_login_t:fifo_file { ioctl read getattr lock write append };
#line 6265

#line 6265
#
#line 6265
# Allow the new domain to read and execute the program.
#line 6265
#
#line 6265
allow unpriv_userdomain shell_exec_t:file { read getattr lock execute ioctl };
#line 6265

#line 6265
#
#line 6265
# Allow the new domain to be entered via the program.
#line 6265
#
#line 6265
allow unpriv_userdomain shell_exec_t:file entrypoint;
#line 6265


# Use the pty created by rlogind.
#line 6270


# Relabel ptys created by rlogind.
#line 6274

allow remote_login_t ptyfile:chr_file { getattr relabelfrom relabelto };



#DESC Logrotate - Rotate log files
#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
#

#################################
#
# Rules for the logrotate_t domain.
#
# logrotate_t is the domain for the logrotate program.
# logrotate_exec_t is the type of the corresponding program.
#
type logrotate_t, domain, privowner, privmail;
role system_r types logrotate_t;
role sysadm_r types logrotate_t;

#line 6294
allow logrotate_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 6294
allow logrotate_t ld_so_t:file { read getattr lock execute ioctl };
#line 6294
allow logrotate_t ld_so_t:file execute_no_trans;
#line 6294
allow logrotate_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 6294
allow logrotate_t shlib_t:file { read getattr lock execute ioctl };
#line 6294
allow logrotate_t shlib_t:lnk_file { read getattr lock ioctl };
#line 6294
allow logrotate_t ld_so_cache_t:file { read getattr lock ioctl };
#line 6294
allow logrotate_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 6294
;

#line 6295
# Access other processes in the same domain.
#line 6295
allow logrotate_t self:process *;
#line 6295

#line 6295
# Access /proc/PID files for processes in the same domain.
#line 6295
allow logrotate_t self:dir { read getattr lock search ioctl };
#line 6295
allow logrotate_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6295

#line 6295
# Access file descriptions, pipes, and sockets
#line 6295
# created by processes in the same domain.
#line 6295
allow logrotate_t self:fd *;
#line 6295
allow logrotate_t self:fifo_file { ioctl read getattr lock write append };
#line 6295
allow logrotate_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 6295
allow logrotate_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 6295

#line 6295
# Allow the domain to communicate with other processes in the same domain.
#line 6295
allow logrotate_t self:unix_dgram_socket sendto;
#line 6295
allow logrotate_t self:unix_stream_socket connectto;
#line 6295

#line 6295
# Access System V IPC objects created by processes in the same domain.
#line 6295
allow logrotate_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 6295
allow logrotate_t self:msg  { send receive };
#line 6295
allow logrotate_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 6295
allow logrotate_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 6295

#line 6295
;
type logrotate_exec_t, file_type, sysadmfile, exec_type;

#line 6297

#line 6297

#line 6297
#
#line 6297
# Allow the process to transition to the new domain.
#line 6297
#
#line 6297
allow system_crond_t logrotate_t:process transition;
#line 6297

#line 6297
#
#line 6297
# Allow the process to execute the program.
#line 6297
# 
#line 6297
allow system_crond_t logrotate_exec_t:file { getattr execute };
#line 6297

#line 6297
#
#line 6297
# Allow the process to reap the new domain.
#line 6297
#
#line 6297
allow logrotate_t system_crond_t:process sigchld;
#line 6297

#line 6297
#
#line 6297
# Allow the new domain to inherit and use file 
#line 6297
# descriptions from the creating process and vice versa.
#line 6297
#
#line 6297
allow logrotate_t system_crond_t:fd use;
#line 6297
allow system_crond_t logrotate_t:fd use;
#line 6297

#line 6297
#
#line 6297
# Allow the new domain to write back to the old domain via a pipe.
#line 6297
#
#line 6297
allow logrotate_t system_crond_t:fifo_file { ioctl read getattr lock write append };
#line 6297

#line 6297
#
#line 6297
# Allow the new domain to read and execute the program.
#line 6297
#
#line 6297
allow logrotate_t logrotate_exec_t:file { read getattr lock execute ioctl };
#line 6297

#line 6297
#
#line 6297
# Allow the new domain to be entered via the program.
#line 6297
#
#line 6297
allow logrotate_t logrotate_exec_t:file entrypoint;
#line 6297

#line 6297
type_transition system_crond_t logrotate_exec_t:process logrotate_t;
#line 6297

allow logrotate_t crond_t:fifo_file write;

#line 6299

#line 6299

#line 6299
#
#line 6299
# Allow the process to transition to the new domain.
#line 6299
#
#line 6299
allow sysadm_t logrotate_t:process transition;
#line 6299

#line 6299
#
#line 6299
# Allow the process to execute the program.
#line 6299
# 
#line 6299
allow sysadm_t logrotate_exec_t:file { getattr execute };
#line 6299

#line 6299
#
#line 6299
# Allow the process to reap the new domain.
#line 6299
#
#line 6299
allow logrotate_t sysadm_t:process sigchld;
#line 6299

#line 6299
#
#line 6299
# Allow the new domain to inherit and use file 
#line 6299
# descriptions from the creating process and vice versa.
#line 6299
#
#line 6299
allow logrotate_t sysadm_t:fd use;
#line 6299
allow sysadm_t logrotate_t:fd use;
#line 6299

#line 6299
#
#line 6299
# Allow the new domain to write back to the old domain via a pipe.
#line 6299
#
#line 6299
allow logrotate_t sysadm_t:fifo_file { ioctl read getattr lock write append };
#line 6299

#line 6299
#
#line 6299
# Allow the new domain to read and execute the program.
#line 6299
#
#line 6299
allow logrotate_t logrotate_exec_t:file { read getattr lock execute ioctl };
#line 6299

#line 6299
#
#line 6299
# Allow the new domain to be entered via the program.
#line 6299
#
#line 6299
allow logrotate_t logrotate_exec_t:file entrypoint;
#line 6299

#line 6299
type_transition sysadm_t logrotate_exec_t:process logrotate_t;
#line 6299

allow logrotate_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
allow logrotate_t devtty_t:chr_file { ioctl read getattr lock write append };

# access files in /etc
allow logrotate_t etc_t:file { getattr read };
allow logrotate_t etc_t:lnk_file read;
allow logrotate_t etc_runtime_t:{ file lnk_file } { read getattr lock ioctl };

# it should not require this
allow logrotate_t sysadm_home_dir_t:dir { read getattr search };

# create lock files

#line 6312
allow logrotate_t var_lock_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 6312
allow logrotate_t var_lock_t:{ file lnk_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 6312


# Create temporary files.

#line 6315
type logrotate_tmp_t, file_type, sysadmfile, tmpfile ;
#line 6315

#line 6315

#line 6315

#line 6315

#line 6315
#
#line 6315
# Allow the process to modify the directory.
#line 6315
#
#line 6315
allow logrotate_t tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 6315

#line 6315
#
#line 6315
# Allow the process to create the file.
#line 6315
#
#line 6315

#line 6315
allow logrotate_t logrotate_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 6315
allow logrotate_t logrotate_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 6315

#line 6315

#line 6315

#line 6315
type_transition logrotate_t tmp_t:dir logrotate_tmp_t;
#line 6315
type_transition logrotate_t tmp_t:{ file lnk_file sock_file fifo_file } logrotate_tmp_t;
#line 6315

#line 6315

#line 6315

#line 6315


# Run helper programs.
allow logrotate_t { bin_t sbin_t }:dir { read getattr lock search ioctl };
allow logrotate_t { bin_t sbin_t }:lnk_file read;

#line 6320
allow logrotate_t bin_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 6320
;

#line 6321
allow logrotate_t sbin_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 6321
;

#line 6322
allow logrotate_t shell_exec_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 6322
;

# Read PID files.
allow logrotate_t pidfile:file { read getattr lock ioctl };

# Read /proc/PID directories for all domains.
allow logrotate_t proc_t:dir { read getattr lock search ioctl };
allow logrotate_t proc_t:{ file lnk_file } { read getattr lock ioctl };
allow logrotate_t domain:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
allow logrotate_t domain:dir { read getattr lock search ioctl };

# Read /dev directories and any symbolic links.
allow logrotate_t device_t:dir { read getattr lock search ioctl };
allow logrotate_t device_t:lnk_file { read getattr lock ioctl };

# Signal processes.
allow logrotate_t domain:process signal;

# Modify /var/log and other log dirs.
allow logrotate_t var_t:dir { read getattr lock search ioctl };
allow logrotate_t logfile:dir { read getattr lock search ioctl add_name remove_name write };
allow logrotate_t logfile:lnk_file read;

# Create, rename, and truncate log files.
allow logrotate_t logfile:file { create ioctl read getattr lock write setattr append link unlink rename };
allow logrotate_t wtmp_t:file { create ioctl read getattr lock write setattr append link unlink rename };
#line 6353


# Change ownership on log files.
allow logrotate_t self:capability { chown dac_override kill fsetid fowner };
# for mailx
dontaudit logrotate_t self:capability { setuid setgid };

#line 6362


# Access /var/run
allow logrotate_t var_run_t:dir { read getattr lock search ioctl };

# Write to /var/lib/logrotate.status - should be moved into its own type.
allow logrotate_t var_lib_t:dir { read getattr lock search ioctl add_name remove_name write };
allow logrotate_t var_lib_t:file { create ioctl read getattr lock write setattr append link unlink rename };

# Write to /var/spool/slrnpull - should be moved into its own type.
allow logrotate_t var_spool_t:dir { search write add_name remove_name };
allow logrotate_t var_spool_t:file { rename create setattr unlink };

# Access terminals.
allow logrotate_t { sysadm_tty_device_t sysadm_devpts_t }:chr_file { ioctl read getattr lock write append };


# for /var/backups on Debian
#line 6382


# read localization information
allow logrotate_t locale_t:dir { read getattr lock search ioctl };
allow logrotate_t locale_t:{file lnk_file} { read getattr lock ioctl };
#DESC Modutil - Dynamic module utilities
#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
#

#################################
#
# Rules for the module utility domains.
#
type modules_dep_t, file_type, sysadmfile;
type modules_conf_t, file_type, sysadmfile;
type modules_object_t, file_type, sysadmfile;


#################################
#
# Rules for the depmod_t domain.
#
type depmod_t, domain;
role system_r types depmod_t;
role sysadm_r types depmod_t;


#line 6409
allow depmod_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 6409
allow depmod_t ld_so_t:file { read getattr lock execute ioctl };
#line 6409
allow depmod_t ld_so_t:file execute_no_trans;
#line 6409
allow depmod_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 6409
allow depmod_t shlib_t:file { read getattr lock execute ioctl };
#line 6409
allow depmod_t shlib_t:lnk_file { read getattr lock ioctl };
#line 6409
allow depmod_t ld_so_cache_t:file { read getattr lock ioctl };
#line 6409
allow depmod_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 6409


type depmod_exec_t, file_type, exec_type, sysadmfile;

#line 6412

#line 6412

#line 6412
#
#line 6412
# Allow the process to transition to the new domain.
#line 6412
#
#line 6412
allow initrc_t depmod_t:process transition;
#line 6412

#line 6412
#
#line 6412
# Allow the process to execute the program.
#line 6412
# 
#line 6412
allow initrc_t depmod_exec_t:file { getattr execute };
#line 6412

#line 6412
#
#line 6412
# Allow the process to reap the new domain.
#line 6412
#
#line 6412
allow depmod_t initrc_t:process sigchld;
#line 6412

#line 6412
#
#line 6412
# Allow the new domain to inherit and use file 
#line 6412
# descriptions from the creating process and vice versa.
#line 6412
#
#line 6412
allow depmod_t initrc_t:fd use;
#line 6412
allow initrc_t depmod_t:fd use;
#line 6412

#line 6412
#
#line 6412
# Allow the new domain to write back to the old domain via a pipe.
#line 6412
#
#line 6412
allow depmod_t initrc_t:fifo_file { ioctl read getattr lock write append };
#line 6412

#line 6412
#
#line 6412
# Allow the new domain to read and execute the program.
#line 6412
#
#line 6412
allow depmod_t depmod_exec_t:file { read getattr lock execute ioctl };
#line 6412

#line 6412
#
#line 6412
# Allow the new domain to be entered via the program.
#line 6412
#
#line 6412
allow depmod_t depmod_exec_t:file entrypoint;
#line 6412

#line 6412
type_transition initrc_t depmod_exec_t:process depmod_t;
#line 6412


#line 6413
allow depmod_t depmod_exec_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 6413


#line 6414

#line 6414

#line 6414
#
#line 6414
# Allow the process to transition to the new domain.
#line 6414
#
#line 6414
allow sysadm_t depmod_t:process transition;
#line 6414

#line 6414
#
#line 6414
# Allow the process to execute the program.
#line 6414
# 
#line 6414
allow sysadm_t depmod_exec_t:file { getattr execute };
#line 6414

#line 6414
#
#line 6414
# Allow the process to reap the new domain.
#line 6414
#
#line 6414
allow depmod_t sysadm_t:process sigchld;
#line 6414

#line 6414
#
#line 6414
# Allow the new domain to inherit and use file 
#line 6414
# descriptions from the creating process and vice versa.
#line 6414
#
#line 6414
allow depmod_t sysadm_t:fd use;
#line 6414
allow sysadm_t depmod_t:fd use;
#line 6414

#line 6414
#
#line 6414
# Allow the new domain to write back to the old domain via a pipe.
#line 6414
#
#line 6414
allow depmod_t sysadm_t:fifo_file { ioctl read getattr lock write append };
#line 6414

#line 6414
#
#line 6414
# Allow the new domain to read and execute the program.
#line 6414
#
#line 6414
allow depmod_t depmod_exec_t:file { read getattr lock execute ioctl };
#line 6414

#line 6414
#
#line 6414
# Allow the new domain to be entered via the program.
#line 6414
#
#line 6414
allow depmod_t depmod_exec_t:file entrypoint;
#line 6414

#line 6414
type_transition sysadm_t depmod_exec_t:process depmod_t;
#line 6414


# Inherit and use descriptors from init.
allow depmod_t init_t:fd use;

# Read conf.modules.
allow depmod_t modules_conf_t:file { read getattr lock ioctl };

# Create modules.dep.

#line 6423

#line 6423

#line 6423

#line 6423
#
#line 6423
# Allow the process to modify the directory.
#line 6423
#
#line 6423
allow depmod_t modules_object_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 6423

#line 6423
#
#line 6423
# Allow the process to create the file.
#line 6423
#
#line 6423

#line 6423
allow depmod_t modules_dep_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 6423
allow depmod_t modules_dep_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 6423

#line 6423

#line 6423

#line 6423
type_transition depmod_t modules_object_t:dir modules_dep_t;
#line 6423
type_transition depmod_t modules_object_t:{ file lnk_file sock_file fifo_file } modules_dep_t;
#line 6423

#line 6423

#line 6423


# Read module objects.
allow depmod_t modules_object_t:dir { read getattr lock search ioctl };
allow depmod_t modules_object_t:{ file lnk_file } { read getattr lock ioctl };

# Access terminals.
allow depmod_t { console_device_t initrc_devpts_t { sysadm_tty_device_t sysadm_devpts_t } }:chr_file { ioctl read getattr lock write append };


# Read System.map from home directories.
allow depmod_t { home_root_t user_home_dir_type sysadm_home_dir_t }:dir { read getattr lock search ioctl };

#line 6435
allow depmod_t { user_home_type sysadm_home_t }:dir { read getattr lock search ioctl };
#line 6435
allow depmod_t { user_home_type sysadm_home_t }:{ file lnk_file } { read getattr lock ioctl };
#line 6435


#################################
#
# Rules for the insmod_t domain.
#

type insmod_t, domain, privlog;
role system_r types insmod_t;
role sysadm_r types insmod_t;

allow insmod_t self:process { fork { sigchld sigkill sigstop signull signal } };


#line 6448
allow insmod_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 6448
allow insmod_t ld_so_t:file { read getattr lock execute ioctl };
#line 6448
allow insmod_t ld_so_t:file execute_no_trans;
#line 6448
allow insmod_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 6448
allow insmod_t shlib_t:file { read getattr lock execute ioctl };
#line 6448
allow insmod_t shlib_t:lnk_file { read getattr lock ioctl };
#line 6448
allow insmod_t ld_so_cache_t:file { read getattr lock ioctl };
#line 6448
allow insmod_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 6448


type insmod_exec_t, file_type, exec_type, sysadmfile;

#line 6451

#line 6451

#line 6451
#
#line 6451
# Allow the process to transition to the new domain.
#line 6451
#
#line 6451
allow { initrc_t kernel_t } insmod_t:process transition;
#line 6451

#line 6451
#
#line 6451
# Allow the process to execute the program.
#line 6451
# 
#line 6451
allow { initrc_t kernel_t } insmod_exec_t:file { getattr execute };
#line 6451

#line 6451
#
#line 6451
# Allow the process to reap the new domain.
#line 6451
#
#line 6451
allow insmod_t { initrc_t kernel_t }:process sigchld;
#line 6451

#line 6451
#
#line 6451
# Allow the new domain to inherit and use file 
#line 6451
# descriptions from the creating process and vice versa.
#line 6451
#
#line 6451
allow insmod_t { initrc_t kernel_t }:fd use;
#line 6451
allow { initrc_t kernel_t } insmod_t:fd use;
#line 6451

#line 6451
#
#line 6451
# Allow the new domain to write back to the old domain via a pipe.
#line 6451
#
#line 6451
allow insmod_t { initrc_t kernel_t }:fifo_file { ioctl read getattr lock write append };
#line 6451

#line 6451
#
#line 6451
# Allow the new domain to read and execute the program.
#line 6451
#
#line 6451
allow insmod_t insmod_exec_t:file { read getattr lock execute ioctl };
#line 6451

#line 6451
#
#line 6451
# Allow the new domain to be entered via the program.
#line 6451
#
#line 6451
allow insmod_t insmod_exec_t:file entrypoint;
#line 6451

#line 6451
type_transition { initrc_t kernel_t } insmod_exec_t:process insmod_t;
#line 6451

allow initrc_t insmod_exec_t:lnk_file read;

#line 6453
allow insmod_t insmod_exec_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 6453

allow insmod_t init_t:fd use;

#line 6455

#line 6455

#line 6455
#
#line 6455
# Allow the process to transition to the new domain.
#line 6455
#
#line 6455
allow sysadm_t insmod_t:process transition;
#line 6455

#line 6455
#
#line 6455
# Allow the process to execute the program.
#line 6455
# 
#line 6455
allow sysadm_t insmod_exec_t:file { getattr execute };
#line 6455

#line 6455
#
#line 6455
# Allow the process to reap the new domain.
#line 6455
#
#line 6455
allow insmod_t sysadm_t:process sigchld;
#line 6455

#line 6455
#
#line 6455
# Allow the new domain to inherit and use file 
#line 6455
# descriptions from the creating process and vice versa.
#line 6455
#
#line 6455
allow insmod_t sysadm_t:fd use;
#line 6455
allow sysadm_t insmod_t:fd use;
#line 6455

#line 6455
#
#line 6455
# Allow the new domain to write back to the old domain via a pipe.
#line 6455
#
#line 6455
allow insmod_t sysadm_t:fifo_file { ioctl read getattr lock write append };
#line 6455

#line 6455
#
#line 6455
# Allow the new domain to read and execute the program.
#line 6455
#
#line 6455
allow insmod_t insmod_exec_t:file { read getattr lock execute ioctl };
#line 6455

#line 6455
#
#line 6455
# Allow the new domain to be entered via the program.
#line 6455
#
#line 6455
allow insmod_t insmod_exec_t:file entrypoint;
#line 6455

#line 6455
type_transition sysadm_t insmod_exec_t:process insmod_t;
#line 6455


# Read module objects.
allow insmod_t modules_object_t:dir { read getattr lock search ioctl };
allow insmod_t modules_object_t:{ file lnk_file } { read getattr lock ioctl };

# Read module config and dependency files.
allow insmod_t modules_conf_t:file { read getattr lock ioctl };
allow insmod_t modules_dep_t:file { read getattr lock ioctl };

# read localization information
allow insmod_t locale_t:dir { read getattr lock search ioctl };
allow insmod_t locale_t:{file lnk_file} { read getattr lock ioctl };

# Use the sys_module capability.
allow insmod_t self:capability { sys_module kill };

# for ipv6
allow insmod_t self:capability net_raw;

# Inherit and use descriptors from init.
allow insmod_t privfd:fd use;

# I do not know why insmod sends signals or what signals it sends
allow insmod_t domain:process signal;

# Update /proc/sys/kernel/tainted.
allow insmod_t { proc_t sysctl_t sysctl_kernel_t }:dir search;
allow insmod_t sysctl_kernel_t:file { setattr { ioctl read getattr lock write append } };

# /var/log/ksymoops/*
allow insmod_t var_t:dir { read getattr lock search ioctl };
allow insmod_t var_log_t:dir { read getattr lock search ioctl };
allow insmod_t var_log_ksyms_t:file { create ioctl read getattr lock write setattr append link unlink rename };
allow insmod_t var_log_ksyms_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };

#line 6493

#line 6493

#line 6493
allow system_crond_t var_log_ksyms_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 6493
allow system_crond_t var_log_ksyms_t:{ file lnk_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 6493

#line 6493

#line 6496


# Access terminals.
allow insmod_t { initrc_devpts_t { sysadm_tty_device_t sysadm_devpts_t } }:chr_file { ioctl read getattr lock write append };



#line 6502
allow insmod_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 6502
allow insmod_t ld_so_t:file { read getattr lock execute ioctl };
#line 6502
allow insmod_t ld_so_t:file execute_no_trans;
#line 6502
allow insmod_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 6502
allow insmod_t shlib_t:file { read getattr lock execute ioctl };
#line 6502
allow insmod_t shlib_t:lnk_file { read getattr lock ioctl };
#line 6502
allow insmod_t ld_so_cache_t:file { read getattr lock ioctl };
#line 6502
allow insmod_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 6502


allow insmod_t initctl_t:fifo_file { ioctl read getattr lock write append };

#################################
#
# Rules for the update_modules_t domain.
#
type update_modules_t, domain, privlog;
type update_modules_exec_t, file_type, exec_type, sysadmfile;

role system_r types update_modules_t;
role sysadm_r types update_modules_t;


#line 6516

#line 6516

#line 6516
#
#line 6516
# Allow the process to transition to the new domain.
#line 6516
#
#line 6516
allow { initrc_t sysadm_t } update_modules_t:process transition;
#line 6516

#line 6516
#
#line 6516
# Allow the process to execute the program.
#line 6516
# 
#line 6516
allow { initrc_t sysadm_t } update_modules_exec_t:file { getattr execute };
#line 6516

#line 6516
#
#line 6516
# Allow the process to reap the new domain.
#line 6516
#
#line 6516
allow update_modules_t { initrc_t sysadm_t }:process sigchld;
#line 6516

#line 6516
#
#line 6516
# Allow the new domain to inherit and use file 
#line 6516
# descriptions from the creating process and vice versa.
#line 6516
#
#line 6516
allow update_modules_t { initrc_t sysadm_t }:fd use;
#line 6516
allow { initrc_t sysadm_t } update_modules_t:fd use;
#line 6516

#line 6516
#
#line 6516
# Allow the new domain to write back to the old domain via a pipe.
#line 6516
#
#line 6516
allow update_modules_t { initrc_t sysadm_t }:fifo_file { ioctl read getattr lock write append };
#line 6516

#line 6516
#
#line 6516
# Allow the new domain to read and execute the program.
#line 6516
#
#line 6516
allow update_modules_t update_modules_exec_t:file { read getattr lock execute ioctl };
#line 6516

#line 6516
#
#line 6516
# Allow the new domain to be entered via the program.
#line 6516
#
#line 6516
allow update_modules_t update_modules_exec_t:file entrypoint;
#line 6516

#line 6516
type_transition { initrc_t sysadm_t } update_modules_exec_t:process update_modules_t;
#line 6516

allow update_modules_t privfd:fd use;
allow update_modules_t init_t:fd use;

allow update_modules_t device_t:dir { getattr search };
allow update_modules_t { console_device_t devtty_t }:chr_file { ioctl read getattr lock write append };
allow update_modules_t { initrc_devpts_t { sysadm_tty_device_t sysadm_devpts_t } }:chr_file { ioctl read getattr lock write append };

dontaudit update_modules_t sysadm_home_dir_t:dir search;


#line 6526
allow update_modules_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 6526
allow update_modules_t ld_so_t:file { read getattr lock execute ioctl };
#line 6526
allow update_modules_t ld_so_t:file execute_no_trans;
#line 6526
allow update_modules_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 6526
allow update_modules_t shlib_t:file { read getattr lock execute ioctl };
#line 6526
allow update_modules_t shlib_t:lnk_file { read getattr lock ioctl };
#line 6526
allow update_modules_t ld_so_cache_t:file { read getattr lock ioctl };
#line 6526
allow update_modules_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 6526

allow update_modules_t self:process { fork sigchld };
allow update_modules_t self:fifo_file { ioctl read getattr lock write append };
allow update_modules_t modules_dep_t:file { ioctl read getattr lock write append };


#line 6531

#line 6531

#line 6531

#line 6531
#
#line 6531
# Allow the process to modify the directory.
#line 6531
#
#line 6531
allow update_modules_t modules_object_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 6531

#line 6531
#
#line 6531
# Allow the process to create the file.
#line 6531
#
#line 6531

#line 6531
allow update_modules_t modules_conf_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 6531
allow update_modules_t modules_conf_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 6531

#line 6531

#line 6531

#line 6531
type_transition update_modules_t modules_object_t:dir modules_conf_t;
#line 6531
type_transition update_modules_t modules_object_t:{ file lnk_file sock_file fifo_file } modules_conf_t;
#line 6531

#line 6531

#line 6531


#line 6532

#line 6532

#line 6532

#line 6532
#
#line 6532
# Allow the process to transition to the new domain.
#line 6532
#
#line 6532
allow update_modules_t depmod_t:process transition;
#line 6532

#line 6532
#
#line 6532
# Allow the process to execute the program.
#line 6532
# 
#line 6532
allow update_modules_t depmod_exec_t:file { getattr execute };
#line 6532

#line 6532
#
#line 6532
# Allow the process to reap the new domain.
#line 6532
#
#line 6532
allow depmod_t update_modules_t:process sigchld;
#line 6532

#line 6532
#
#line 6532
# Allow the new domain to inherit and use file 
#line 6532
# descriptions from the creating process and vice versa.
#line 6532
#
#line 6532
allow depmod_t update_modules_t:fd use;
#line 6532
allow update_modules_t depmod_t:fd use;
#line 6532

#line 6532
#
#line 6532
# Allow the new domain to write back to the old domain via a pipe.
#line 6532
#
#line 6532
allow depmod_t update_modules_t:fifo_file { ioctl read getattr lock write append };
#line 6532

#line 6532
#
#line 6532
# Allow the new domain to read and execute the program.
#line 6532
#
#line 6532
allow depmod_t depmod_exec_t:file { read getattr lock execute ioctl };
#line 6532

#line 6532
#
#line 6532
# Allow the new domain to be entered via the program.
#line 6532
#
#line 6532
allow depmod_t depmod_exec_t:file entrypoint;
#line 6532

#line 6532
type_transition update_modules_t depmod_exec_t:process depmod_t;
#line 6532

#line 6532
allow update_modules_t depmod_exec_t:file read;
#line 6532


#line 6533
allow update_modules_t { shell_exec_t bin_t sbin_t update_modules_exec_t etc_t }:file { { read getattr lock execute ioctl } execute_no_trans };
#line 6533


allow update_modules_t bin_t:lnk_file read;
allow update_modules_t { sbin_t bin_t }:dir search;
allow update_modules_t { etc_t etc_runtime_t }:file { read getattr lock ioctl };
allow update_modules_t etc_t:lnk_file read;
allow update_modules_t fs_t:filesystem getattr;

allow update_modules_t proc_t:dir search;
allow update_modules_t proc_t:file { read getattr lock ioctl };
allow update_modules_t { self proc_t }:lnk_file read;
allow update_modules_t sysctl_kernel_t:dir search;
allow update_modules_t sysctl_kernel_t:file { getattr read };
allow update_modules_t self:dir search;
allow update_modules_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };

allow update_modules_t security_t:security sid_to_context;


#line 6551

#line 6551

#line 6551

#line 6551
#
#line 6551
# Allow the process to modify the directory.
#line 6551
#
#line 6551
allow update_modules_t etc_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 6551

#line 6551
#
#line 6551
# Allow the process to create the file.
#line 6551
#
#line 6551

#line 6551
allow update_modules_t modules_conf_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 6551
allow update_modules_t modules_conf_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 6551

#line 6551

#line 6551

#line 6551
type_transition update_modules_t etc_t:dir modules_conf_t;
#line 6551
type_transition update_modules_t etc_t:{ file lnk_file sock_file fifo_file } modules_conf_t;
#line 6551

#line 6551

#line 6551


# for when /etc/modules.conf gets the wrong type
allow update_modules_t etc_t:file unlink;


#line 6556
type update_modules_tmp_t, file_type, sysadmfile, tmpfile ;
#line 6556

#line 6556

#line 6556

#line 6556

#line 6556
#
#line 6556
# Allow the process to modify the directory.
#line 6556
#
#line 6556
allow update_modules_t tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 6556

#line 6556
#
#line 6556
# Allow the process to create the file.
#line 6556
#
#line 6556

#line 6556
allow update_modules_t update_modules_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 6556
allow update_modules_t update_modules_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 6556

#line 6556

#line 6556

#line 6556
type_transition update_modules_t tmp_t:dir update_modules_tmp_t;
#line 6556
type_transition update_modules_t tmp_t:{ file lnk_file sock_file fifo_file } update_modules_tmp_t;
#line 6556

#line 6556

#line 6556

#line 6556

# Added by us 
allow insmod_t initrc_t:rawip_socket { read write };
allow insmod_t etc_t:file { read };
allow insmod_t insmod_t:unix_stream_socket { connect create write };

allow insmod_t device_t:dir { search };
allow insmod_t insmod_t:unix_dgram_socket { connect create };

allow depmod_t etc_runtime_t:file { getattr read };
allow depmod_t proc_t:dir { search };
allow depmod_t proc_t:file { getattr read };

#DESC Mount - Filesystem mount utilities
#
# Macros for mount
#
# Author:  Brian May <bam@snoopy.apana.org.au>
#
# based on the work of:
#          Mark Westerman mark.westerman@csoconline.com
#

type mount_exec_t, file_type, sysadmfile, exec_type;


#line 6581
#
#line 6581
# Rules for the mount_t domain, used by the sysadm_t domain.
#line 6581
#
#line 6581
# mount_t is the domain for the mount process.
#line 6581
#
#line 6581
# This macro will not be included by all users and it may be included twice if
#line 6581
# called from other macros, so we need protection for this do not call this
#line 6581
# macro if mount_def is defined
#line 6581

#line 6581
#
#line 6581
type mount_t, domain, privlog;
#line 6581

#line 6581

#line 6581

#line 6581
# Grant the permissions common to the test domains.
#line 6581

#line 6581
# Grant permissions within the domain.
#line 6581

#line 6581
# Access other processes in the same domain.
#line 6581
allow mount_t self:process *;
#line 6581

#line 6581
# Access /proc/PID files for processes in the same domain.
#line 6581
allow mount_t self:dir { read getattr lock search ioctl };
#line 6581
allow mount_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6581

#line 6581
# Access file descriptions, pipes, and sockets
#line 6581
# created by processes in the same domain.
#line 6581
allow mount_t self:fd *;
#line 6581
allow mount_t self:fifo_file { ioctl read getattr lock write append };
#line 6581
allow mount_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 6581
allow mount_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 6581

#line 6581
# Allow the domain to communicate with other processes in the same domain.
#line 6581
allow mount_t self:unix_dgram_socket sendto;
#line 6581
allow mount_t self:unix_stream_socket connectto;
#line 6581

#line 6581
# Access System V IPC objects created by processes in the same domain.
#line 6581
allow mount_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 6581
allow mount_t self:msg  { send receive };
#line 6581
allow mount_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 6581
allow mount_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 6581

#line 6581

#line 6581

#line 6581
# Grant read/search permissions to most of /proc.
#line 6581

#line 6581
# Read system information files in /proc.
#line 6581
allow mount_t proc_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t proc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6581

#line 6581
# Stat /proc/kmsg and /proc/kcore.
#line 6581
allow mount_t proc_kmsg_t:file { getattr };
#line 6581
allow mount_t proc_kcore_t:file { getattr };
#line 6581

#line 6581
# Read system variables in /proc/sys.
#line 6581
allow mount_t sysctl_modprobe_t:file { read getattr lock ioctl };
#line 6581
allow mount_t sysctl_t:file { read getattr lock ioctl };
#line 6581
allow mount_t sysctl_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t sysctl_fs_t:file { read getattr lock ioctl };
#line 6581
allow mount_t sysctl_fs_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t sysctl_kernel_t:file { read getattr lock ioctl };
#line 6581
allow mount_t sysctl_kernel_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t sysctl_net_t:file { read getattr lock ioctl };
#line 6581
allow mount_t sysctl_net_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t sysctl_vm_t:file { read getattr lock ioctl };
#line 6581
allow mount_t sysctl_vm_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t sysctl_dev_t:file { read getattr lock ioctl };
#line 6581
allow mount_t sysctl_dev_t:dir { read getattr lock search ioctl };
#line 6581

#line 6581

#line 6581
# Grant read/search permissions to many system file types.
#line 6581

#line 6581

#line 6581
# Get attributes of file systems.
#line 6581
allow mount_t fs_type:filesystem getattr;
#line 6581

#line 6581

#line 6581
# Read /.
#line 6581
allow mount_t root_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t root_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6581

#line 6581
# Read /home.
#line 6581
allow mount_t home_root_t:dir { read getattr lock search ioctl };
#line 6581

#line 6581
# Read /usr.
#line 6581
allow mount_t usr_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t usr_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6581

#line 6581
# Read bin and sbin directories.
#line 6581
allow mount_t bin_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6581
allow mount_t sbin_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6581

#line 6581

#line 6581
# Read directories and files with the readable_t type.
#line 6581
# This type is a general type for "world"-readable files.
#line 6581
allow mount_t readable_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t readable_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6581

#line 6581
# Stat /...security and lost+found.
#line 6581
allow mount_t file_labels_t:dir getattr;
#line 6581
allow mount_t lost_found_t:dir getattr;
#line 6581

#line 6581
# Read the devpts root directory.  
#line 6581
allow mount_t devpts_t:dir { read getattr lock search ioctl };
#line 6581

#line 6581

#line 6581
# Read the /tmp directory and any /tmp files with the base type.
#line 6581
# Temporary files created at runtime will typically use derived types.
#line 6581
allow mount_t tmp_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t tmp_t:{ file lnk_file } { read getattr lock ioctl };
#line 6581

#line 6581
# Read /var.
#line 6581
allow mount_t var_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t var_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6581

#line 6581
# Read /var/catman.
#line 6581
allow mount_t catman_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t catman_t:{ file lnk_file } { read getattr lock ioctl };
#line 6581

#line 6581
# Read /var/lib.
#line 6581
allow mount_t var_lib_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t var_lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6581
allow mount_t var_lib_nfs_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t var_lib_nfs_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6581

#line 6581

#line 6581
allow mount_t tetex_data_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t tetex_data_t:{ file lnk_file } { read getattr lock ioctl };
#line 6581

#line 6581

#line 6581
# Read /var/yp.
#line 6581
allow mount_t var_yp_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t var_yp_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6581

#line 6581
# Read /var/spool.
#line 6581
allow mount_t var_spool_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t var_spool_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6581

#line 6581
# Read /var/run, /var/lock, /var/log.
#line 6581
allow mount_t var_run_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t var_run_t:{ file lnk_file } { read getattr lock ioctl };
#line 6581
allow mount_t var_log_t:dir { read getattr lock search ioctl };
#line 6581
#allow mount_t var_log_t:{ file lnk_file } r_file_perms;
#line 6581
allow mount_t var_log_sa_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t var_log_sa_t:{ file lnk_file } { read getattr lock ioctl };
#line 6581
allow mount_t var_log_ksyms_t:{ file lnk_file } { read getattr lock ioctl };
#line 6581

#line 6581
allow mount_t var_lock_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t var_lock_t:{ file lnk_file } { read getattr lock ioctl };
#line 6581

#line 6581
# Read /var/run/utmp and /var/log/wtmp.
#line 6581
allow mount_t initrc_var_run_t:file { read getattr lock ioctl };
#line 6581
allow mount_t wtmp_t:file { read getattr lock ioctl };
#line 6581

#line 6581
# Read /boot, /boot/System.map*, and /vmlinuz*
#line 6581
allow mount_t boot_t:dir { search getattr };
#line 6581
allow mount_t boot_t:file getattr;
#line 6581
allow mount_t system_map_t:{ file lnk_file } { read getattr lock ioctl };
#line 6581

#line 6581
allow mount_t boot_t:lnk_file read;
#line 6581

#line 6581
# Read /etc.
#line 6581
allow mount_t etc_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t etc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6581
allow mount_t etc_runtime_t:{ file lnk_file } { read getattr lock ioctl };
#line 6581
allow mount_t etc_aliases_t:{ file lnk_file } { read getattr lock ioctl };
#line 6581
allow mount_t etc_mail_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t etc_mail_t:{ file lnk_file } { read getattr lock ioctl };
#line 6581
allow mount_t resolv_conf_t:{ file lnk_file } { read getattr lock ioctl };
#line 6581
allow mount_t ld_so_cache_t:file { read getattr lock ioctl };
#line 6581

#line 6581
# Read /lib.
#line 6581
allow mount_t lib_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6581

#line 6581
# Read the linker, shared library, and executable types.
#line 6581
allow mount_t ld_so_t:{ file lnk_file } { read getattr lock ioctl };
#line 6581
allow mount_t shlib_t:{ file lnk_file } { read getattr lock ioctl };
#line 6581
allow mount_t exec_type:{ file lnk_file } { read getattr lock ioctl };
#line 6581

#line 6581
# Read man directories and files.
#line 6581
allow mount_t man_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t man_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6581

#line 6581
# Read /usr/src.
#line 6581
allow mount_t src_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t src_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6581

#line 6581
# Read module-related files.
#line 6581
allow mount_t modules_object_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t modules_object_t:{ file lnk_file } { read getattr lock ioctl };
#line 6581
allow mount_t modules_dep_t:{ file lnk_file } { read getattr lock ioctl };
#line 6581
allow mount_t modules_conf_t:{ file lnk_file} { read getattr lock ioctl };
#line 6581

#line 6581
# Read /dev directories and any symbolic links.
#line 6581
allow mount_t device_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t device_t:lnk_file { read getattr lock ioctl };
#line 6581

#line 6581
# Read /dev/random and /dev/zero.
#line 6581
allow mount_t random_device_t:chr_file { read getattr lock ioctl };
#line 6581
allow mount_t zero_device_t:chr_file { read getattr lock ioctl };
#line 6581

#line 6581
# Read the root directory of a tmpfs filesytem and any symbolic links.
#line 6581
allow mount_t tmpfs_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t tmpfs_t:lnk_file { read getattr lock ioctl };
#line 6581

#line 6581
# Read any symbolic links on a devfs file system.
#line 6581
allow mount_t device_t:lnk_file { read getattr lock ioctl };
#line 6581

#line 6581
# Read the root directory of a usbdevfs filesystem, and
#line 6581
# the devices and drivers files.  Permit stating of the
#line 6581
# device nodes, but nothing else.
#line 6581
allow mount_t usbdevfs_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t usbdevfs_t:{ file lnk_file } { read getattr lock ioctl };
#line 6581
allow mount_t usbdevfs_device_t:file getattr;
#line 6581

#line 6581

#line 6581
# Grant write permissions to a small set of system file types.
#line 6581
# No permission to create files is granted here.  Use allow rules to grant 
#line 6581
# create permissions to a type or use file_type_auto_trans rules to set up
#line 6581
# new types for files.
#line 6581

#line 6581

#line 6581
# Read and write /dev/tty and /dev/null.
#line 6581
allow mount_t devtty_t:chr_file { ioctl read getattr lock write append };
#line 6581
allow mount_t { null_device_t zero_device_t }:chr_file { ioctl read getattr lock write append };
#line 6581

#line 6581
# Do not audit write denials to /etc/ld.so.cache.
#line 6581
dontaudit mount_t ld_so_cache_t:file write;
#line 6581

#line 6581

#line 6581
# Execute from the system shared libraries.
#line 6581
# No permission to execute anything else is granted here.
#line 6581
# Use can_exec or can_exec_any to grant the ability to execute within a domain.
#line 6581
# Use domain_auto_trans for executing and changing domains.
#line 6581

#line 6581
allow mount_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 6581
allow mount_t ld_so_t:file { read getattr lock execute ioctl };
#line 6581
allow mount_t ld_so_t:file execute_no_trans;
#line 6581
allow mount_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 6581
allow mount_t shlib_t:file { read getattr lock execute ioctl };
#line 6581
allow mount_t shlib_t:lnk_file { read getattr lock ioctl };
#line 6581
allow mount_t ld_so_cache_t:file { read getattr lock ioctl };
#line 6581
allow mount_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 6581

#line 6581

#line 6581
# read localization information
#line 6581
allow mount_t locale_t:dir { read getattr lock search ioctl };
#line 6581
allow mount_t locale_t:{file lnk_file} { read getattr lock ioctl };
#line 6581

#line 6581
# Obtain the context of any SID, the SID for any context, 
#line 6581
# and the list of active SIDs.
#line 6581
allow mount_t security_t:security { sid_to_context context_to_sid get_sids };
#line 6581

#line 6581

#line 6581

#line 6581
# Grant permissions needed to create TCP and UDP sockets and 
#line 6581
# to access the network.
#line 6581

#line 6581
#
#line 6581
# Allow the domain to create and use UDP and TCP sockets.
#line 6581
# Other kinds of sockets must be separately authorized for use.
#line 6581
allow mount_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 6581
allow mount_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 6581

#line 6581
#
#line 6581
# Allow the domain to send UDP packets.
#line 6581
# Since the destination sockets type is unknown, the generic
#line 6581
# any_socket_t type is used as a placeholder.
#line 6581
#
#line 6581
allow mount_t any_socket_t:udp_socket sendto;
#line 6581

#line 6581
#
#line 6581
# Allow the domain to send using any network interface.
#line 6581
# netif_type is a type attribute for all network interface types.
#line 6581
#
#line 6581
allow mount_t netif_type:netif { tcp_send udp_send rawip_send };
#line 6581

#line 6581
#
#line 6581
# Allow packets sent by the domain to be received on any network interface.
#line 6581
#
#line 6581
allow mount_t netif_type:netif { tcp_recv udp_recv rawip_recv };
#line 6581

#line 6581
#
#line 6581
# Allow the domain to receive packets from any network interface.
#line 6581
# netmsg_type is a type attribute for all default message types.
#line 6581
#
#line 6581
allow mount_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
#line 6581

#line 6581
#
#line 6581
# Allow the domain to initiate or accept TCP connections 
#line 6581
# on any network interface.
#line 6581
#
#line 6581
allow mount_t netmsg_type:tcp_socket { connectto acceptfrom };
#line 6581

#line 6581
#
#line 6581
# Receive resets from the TCP reset socket.
#line 6581
# The TCP reset socket is labeled with the tcp_socket_t type.
#line 6581
#
#line 6581
allow mount_t tcp_socket_t:tcp_socket recvfrom;
#line 6581

#line 6581
dontaudit mount_t tcp_socket_t:tcp_socket connectto;
#line 6581

#line 6581
#
#line 6581
# Allow the domain to send to any node.
#line 6581
# node_type is a type attribute for all node types.
#line 6581
#
#line 6581
allow mount_t node_type:node { tcp_send udp_send rawip_send };
#line 6581

#line 6581
#
#line 6581
# Allow packets sent by the domain to be received from any node.
#line 6581
#
#line 6581
allow mount_t node_type:node { tcp_recv udp_recv rawip_recv };
#line 6581

#line 6581
#
#line 6581
# Allow the domain to send NFS client requests via the socket
#line 6581
# created by mount.
#line 6581
#
#line 6581
allow mount_t mount_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 6581

#line 6581
#
#line 6581
# Bind to the default port type.
#line 6581
# Other port types must be separately authorized.
#line 6581
#
#line 6581
allow mount_t port_t:udp_socket name_bind;
#line 6581
allow mount_t port_t:tcp_socket name_bind;
#line 6581

#line 6581

#line 6581
# when mount is run by sysadm goto mount_t domain
#line 6581

#line 6581

#line 6581

#line 6581
#
#line 6581
# Allow the process to transition to the new domain.
#line 6581
#
#line 6581
allow sysadm_t mount_t:process transition;
#line 6581

#line 6581
#
#line 6581
# Allow the process to execute the program.
#line 6581
# 
#line 6581
allow sysadm_t mount_exec_t:file { getattr execute };
#line 6581

#line 6581
#
#line 6581
# Allow the process to reap the new domain.
#line 6581
#
#line 6581
allow mount_t sysadm_t:process sigchld;
#line 6581

#line 6581
#
#line 6581
# Allow the new domain to inherit and use file 
#line 6581
# descriptions from the creating process and vice versa.
#line 6581
#
#line 6581
allow mount_t sysadm_t:fd use;
#line 6581
allow sysadm_t mount_t:fd use;
#line 6581

#line 6581
#
#line 6581
# Allow the new domain to write back to the old domain via a pipe.
#line 6581
#
#line 6581
allow mount_t sysadm_t:fifo_file { ioctl read getattr lock write append };
#line 6581

#line 6581
#
#line 6581
# Allow the new domain to read and execute the program.
#line 6581
#
#line 6581
allow mount_t mount_exec_t:file { read getattr lock execute ioctl };
#line 6581

#line 6581
#
#line 6581
# Allow the new domain to be entered via the program.
#line 6581
#
#line 6581
allow mount_t mount_exec_t:file entrypoint;
#line 6581

#line 6581
type_transition sysadm_t mount_exec_t:process mount_t;
#line 6581

#line 6581

#line 6581

#line 6581
type mount_tmp_t, file_type, sysadmfile, tmpfile ;
#line 6581

#line 6581

#line 6581

#line 6581

#line 6581
#
#line 6581
# Allow the process to modify the directory.
#line 6581
#
#line 6581
allow mount_t tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 6581

#line 6581
#
#line 6581
# Allow the process to create the file.
#line 6581
#
#line 6581

#line 6581
allow mount_t mount_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 6581
allow mount_t mount_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 6581

#line 6581

#line 6581

#line 6581
type_transition mount_t tmp_t:dir mount_tmp_t;
#line 6581
type_transition mount_t tmp_t:{ file lnk_file sock_file fifo_file } mount_tmp_t;
#line 6581

#line 6581

#line 6581

#line 6581

#line 6581

#line 6581
# Use capabilities.
#line 6581
allow mount_t self:capability { net_bind_service sys_rawio sys_admin };
#line 6581

#line 6581
# Create and modify /etc/mtab.
#line 6581

#line 6581

#line 6581

#line 6581

#line 6581
#
#line 6581
# Allow the process to modify the directory.
#line 6581
#
#line 6581
allow mount_t etc_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 6581

#line 6581
#
#line 6581
# Allow the process to create the file.
#line 6581
#
#line 6581

#line 6581
allow mount_t etc_runtime_t:file { create ioctl read getattr lock write setattr append link unlink rename };
#line 6581

#line 6581

#line 6581

#line 6581
type_transition mount_t etc_t:file etc_runtime_t;
#line 6581

#line 6581

#line 6581

#line 6581

#line 6581
# Access the terminal.
#line 6581
allow mount_t sysadm_tty_device_t:chr_file { getattr read write ioctl };
#line 6581
allow mount_t sysadm_devpts_t:chr_file { getattr read write };
#line 6581

#line 6581

role sysadm_r types mount_t;
role system_r types mount_t;


#line 6585

#line 6585

#line 6585
#
#line 6585
# Allow the process to transition to the new domain.
#line 6585
#
#line 6585
allow initrc_t mount_t:process transition;
#line 6585

#line 6585
#
#line 6585
# Allow the process to execute the program.
#line 6585
# 
#line 6585
allow initrc_t mount_exec_t:file { getattr execute };
#line 6585

#line 6585
#
#line 6585
# Allow the process to reap the new domain.
#line 6585
#
#line 6585
allow mount_t initrc_t:process sigchld;
#line 6585

#line 6585
#
#line 6585
# Allow the new domain to inherit and use file 
#line 6585
# descriptions from the creating process and vice versa.
#line 6585
#
#line 6585
allow mount_t initrc_t:fd use;
#line 6585
allow initrc_t mount_t:fd use;
#line 6585

#line 6585
#
#line 6585
# Allow the new domain to write back to the old domain via a pipe.
#line 6585
#
#line 6585
allow mount_t initrc_t:fifo_file { ioctl read getattr lock write append };
#line 6585

#line 6585
#
#line 6585
# Allow the new domain to read and execute the program.
#line 6585
#
#line 6585
allow mount_t mount_exec_t:file { read getattr lock execute ioctl };
#line 6585

#line 6585
#
#line 6585
# Allow the new domain to be entered via the program.
#line 6585
#
#line 6585
allow mount_t mount_exec_t:file entrypoint;
#line 6585

#line 6585
type_transition initrc_t mount_exec_t:process mount_t;
#line 6585

allow mount_t init_t:fd use;
allow mount_t privfd:fd use;

allow mount_t self:capability { ipc_lock dac_override };

# Create and modify /etc/mtab.

#line 6592

#line 6592

#line 6592

#line 6592
#
#line 6592
# Allow the process to modify the directory.
#line 6592
#
#line 6592
allow mount_t etc_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 6592

#line 6592
#
#line 6592
# Allow the process to create the file.
#line 6592
#
#line 6592

#line 6592
allow mount_t etc_runtime_t:file { create ioctl read getattr lock write setattr append link unlink rename };
#line 6592

#line 6592

#line 6592

#line 6592
type_transition mount_t etc_t:file etc_runtime_t;
#line 6592

#line 6592

#line 6592


allow mount_t file_type:dir search;

# Access disk devices.
allow mount_t fixed_disk_device_t:{ chr_file blk_file } { ioctl read getattr lock write append };
allow mount_t removable_device_t:{ chr_file blk_file } { ioctl read getattr lock write append };

# Mount, remount and unmount file systems.
allow mount_t fs_type:filesystem { mount remount unmount getattr };
allow mount_t file_t:dir mounton;
allow mount_t usr_t:dir mounton;
allow mount_t proc_t:dir mounton;
allow mount_t root_t:dir mounton;
# On some RedHat systems, /boot is a mount point
allow mount_t boot_t:dir mounton;
allow mount_t device_t:dir mounton;
#line 6611

allow mount_t root_t:filesystem unmount;
# Added by us
allow mount_t initrc_t:udp_socket { recvfrom };
allow mount_t var_spool_t:file { execute };

# added to run society with acme
allow mount_t acme_t:udp_socket { write };

#DESC Netutils - Network utilities
#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil>
#

#
# Rules for the netutils_t domain.
# This domain is for network utilities that require access to
# special protocol families.
#
type netutils_t, domain, privlog;
type netutils_exec_t, file_type, sysadmfile, exec_type;
role system_r types netutils_t;
role sysadm_r types netutils_t;


#line 6635
allow netutils_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 6635
allow netutils_t ld_so_t:file { read getattr lock execute ioctl };
#line 6635
allow netutils_t ld_so_t:file execute_no_trans;
#line 6635
allow netutils_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 6635
allow netutils_t shlib_t:file { read getattr lock execute ioctl };
#line 6635
allow netutils_t shlib_t:lnk_file { read getattr lock ioctl };
#line 6635
allow netutils_t ld_so_cache_t:file { read getattr lock ioctl };
#line 6635
allow netutils_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 6635



#line 6637

#line 6637

#line 6637
#
#line 6637
# Allow the process to transition to the new domain.
#line 6637
#
#line 6637
allow initrc_t netutils_t:process transition;
#line 6637

#line 6637
#
#line 6637
# Allow the process to execute the program.
#line 6637
# 
#line 6637
allow initrc_t netutils_exec_t:file { getattr execute };
#line 6637

#line 6637
#
#line 6637
# Allow the process to reap the new domain.
#line 6637
#
#line 6637
allow netutils_t initrc_t:process sigchld;
#line 6637

#line 6637
#
#line 6637
# Allow the new domain to inherit and use file 
#line 6637
# descriptions from the creating process and vice versa.
#line 6637
#
#line 6637
allow netutils_t initrc_t:fd use;
#line 6637
allow initrc_t netutils_t:fd use;
#line 6637

#line 6637
#
#line 6637
# Allow the new domain to write back to the old domain via a pipe.
#line 6637
#
#line 6637
allow netutils_t initrc_t:fifo_file { ioctl read getattr lock write append };
#line 6637

#line 6637
#
#line 6637
# Allow the new domain to read and execute the program.
#line 6637
#
#line 6637
allow netutils_t netutils_exec_t:file { read getattr lock execute ioctl };
#line 6637

#line 6637
#
#line 6637
# Allow the new domain to be entered via the program.
#line 6637
#
#line 6637
allow netutils_t netutils_exec_t:file entrypoint;
#line 6637

#line 6637
type_transition initrc_t netutils_exec_t:process netutils_t;
#line 6637


#line 6638

#line 6638

#line 6638
#
#line 6638
# Allow the process to transition to the new domain.
#line 6638
#
#line 6638
allow sysadm_t netutils_t:process transition;
#line 6638

#line 6638
#
#line 6638
# Allow the process to execute the program.
#line 6638
# 
#line 6638
allow sysadm_t netutils_exec_t:file { getattr execute };
#line 6638

#line 6638
#
#line 6638
# Allow the process to reap the new domain.
#line 6638
#
#line 6638
allow netutils_t sysadm_t:process sigchld;
#line 6638

#line 6638
#
#line 6638
# Allow the new domain to inherit and use file 
#line 6638
# descriptions from the creating process and vice versa.
#line 6638
#
#line 6638
allow netutils_t sysadm_t:fd use;
#line 6638
allow sysadm_t netutils_t:fd use;
#line 6638

#line 6638
#
#line 6638
# Allow the new domain to write back to the old domain via a pipe.
#line 6638
#
#line 6638
allow netutils_t sysadm_t:fifo_file { ioctl read getattr lock write append };
#line 6638

#line 6638
#
#line 6638
# Allow the new domain to read and execute the program.
#line 6638
#
#line 6638
allow netutils_t netutils_exec_t:file { read getattr lock execute ioctl };
#line 6638

#line 6638
#
#line 6638
# Allow the new domain to be entered via the program.
#line 6638
#
#line 6638
allow netutils_t netutils_exec_t:file entrypoint;
#line 6638

#line 6638
type_transition sysadm_t netutils_exec_t:process netutils_t;
#line 6638


# Inherit and use descriptors from init.
allow netutils_t init_t:fd use;

# Perform network administration operations and have raw access to the network.
allow netutils_t self:capability { net_admin net_raw setuid setgid };

# Create and use netlink sockets.
allow netutils_t self:netlink_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };

# Create and use packet sockets.
allow netutils_t self:packet_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };

# Create and use UDP sockets.
allow netutils_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };

# Create and use TCP sockets.
allow netutils_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };

# Read certain files in /etc
allow netutils_t etc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
allow netutils_t resolv_conf_t:file { read getattr lock ioctl };

# Access terminals.
allow netutils_t privfd:fd use;
allow netutils_t { sysadm_tty_device_t sysadm_devpts_t }:chr_file { ioctl read getattr lock write append };


# Added by us
allow netutils_t var_spool_t:file { execute getattr read };

#DESC Newrole - SELinux utility to run a shell with a new role
#
# Authors:  Anthony Colatrella (NSA) 
# Maintained by Stephen Smalley <sds@epoch.ncsc.mil>
#

#################################
#
# Rules for the newrole_t domain.
#
# newrole_t is the domain for the newrole program.
# newrole_exec_t is the type of the newrole executable.
#
type newrole_t, domain, privrole, privowner, privlog, auth, privfd;

#line 6684
role user_r types newrole_t;
#line 6684
role cougaar_r types newrole_t;
#line 6684
#role staff_r types newrole_t;
#line 6684

role sysadm_r types newrole_t;


#line 6687
# Access other processes in the same domain.
#line 6687
allow newrole_t self:process *;
#line 6687

#line 6687
# Access /proc/PID files for processes in the same domain.
#line 6687
allow newrole_t self:dir { read getattr lock search ioctl };
#line 6687
allow newrole_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6687

#line 6687
# Access file descriptions, pipes, and sockets
#line 6687
# created by processes in the same domain.
#line 6687
allow newrole_t self:fd *;
#line 6687
allow newrole_t self:fifo_file { ioctl read getattr lock write append };
#line 6687
allow newrole_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 6687
allow newrole_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 6687

#line 6687
# Allow the domain to communicate with other processes in the same domain.
#line 6687
allow newrole_t self:unix_dgram_socket sendto;
#line 6687
allow newrole_t self:unix_stream_socket connectto;
#line 6687

#line 6687
# Access System V IPC objects created by processes in the same domain.
#line 6687
allow newrole_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 6687
allow newrole_t self:msg  { send receive };
#line 6687
allow newrole_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 6687
allow newrole_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 6687

#line 6687
;
allow newrole_t proc_t:{file lnk_file} { read getattr lock ioctl };


#line 6690
allow newrole_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 6690
allow newrole_t ld_so_t:file { read getattr lock execute ioctl };
#line 6690
allow newrole_t ld_so_t:file execute_no_trans;
#line 6690
allow newrole_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 6690
allow newrole_t shlib_t:file { read getattr lock execute ioctl };
#line 6690
allow newrole_t shlib_t:lnk_file { read getattr lock ioctl };
#line 6690
allow newrole_t ld_so_cache_t:file { read getattr lock ioctl };
#line 6690
allow newrole_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 6690


# read localization information
allow newrole_t locale_t:dir { read getattr lock search ioctl };
allow newrole_t locale_t:{file lnk_file} { read getattr lock ioctl };

type newrole_exec_t, file_type, exec_type, sysadmfile;

#line 6697

#line 6697

#line 6697
#
#line 6697
# Allow the process to transition to the new domain.
#line 6697
#
#line 6697
allow userdomain newrole_t:process transition;
#line 6697

#line 6697
#
#line 6697
# Allow the process to execute the program.
#line 6697
# 
#line 6697
allow userdomain newrole_exec_t:file { getattr execute };
#line 6697

#line 6697
#
#line 6697
# Allow the process to reap the new domain.
#line 6697
#
#line 6697
allow newrole_t userdomain:process sigchld;
#line 6697

#line 6697
#
#line 6697
# Allow the new domain to inherit and use file 
#line 6697
# descriptions from the creating process and vice versa.
#line 6697
#
#line 6697
allow newrole_t userdomain:fd use;
#line 6697
allow userdomain newrole_t:fd use;
#line 6697

#line 6697
#
#line 6697
# Allow the new domain to write back to the old domain via a pipe.
#line 6697
#
#line 6697
allow newrole_t userdomain:fifo_file { ioctl read getattr lock write append };
#line 6697

#line 6697
#
#line 6697
# Allow the new domain to read and execute the program.
#line 6697
#
#line 6697
allow newrole_t newrole_exec_t:file { read getattr lock execute ioctl };
#line 6697

#line 6697
#
#line 6697
# Allow the new domain to be entered via the program.
#line 6697
#
#line 6697
allow newrole_t newrole_exec_t:file entrypoint;
#line 6697

#line 6697
type_transition userdomain newrole_exec_t:process newrole_t;
#line 6697


allow newrole_t shadow_t:file { read getattr };

# Inherit descriptors from the current session.
allow newrole_t privfd:fd use;

# Execute /sbin/pwdb_chkpwd to check the password.
allow newrole_t sbin_t:dir { read getattr lock search ioctl };

#line 6706
allow newrole_t chkpwd_exec_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 6706


# Execute shells
allow newrole_t bin_t:dir { read getattr lock search ioctl };
allow newrole_t shell_exec_t:file { read getattr lock ioctl };

# Allow newrole_t to transition to user domains.

#line 6713

#line 6713
#
#line 6713
# Allow the process to transition to the new domain.
#line 6713
#
#line 6713
allow newrole_t userdomain:process transition;
#line 6713

#line 6713
#
#line 6713
# Allow the process to execute the program.
#line 6713
# 
#line 6713
allow newrole_t shell_exec_t:file { getattr execute };
#line 6713

#line 6713
#
#line 6713
# Allow the process to reap the new domain.
#line 6713
#
#line 6713
allow userdomain newrole_t:process sigchld;
#line 6713

#line 6713
#
#line 6713
# Allow the new domain to inherit and use file 
#line 6713
# descriptions from the creating process and vice versa.
#line 6713
#
#line 6713
allow userdomain newrole_t:fd use;
#line 6713
allow newrole_t userdomain:fd use;
#line 6713

#line 6713
#
#line 6713
# Allow the new domain to write back to the old domain via a pipe.
#line 6713
#
#line 6713
allow userdomain newrole_t:fifo_file { ioctl read getattr lock write append };
#line 6713

#line 6713
#
#line 6713
# Allow the new domain to read and execute the program.
#line 6713
#
#line 6713
allow userdomain shell_exec_t:file { read getattr lock execute ioctl };
#line 6713

#line 6713
#
#line 6713
# Allow the new domain to be entered via the program.
#line 6713
#
#line 6713
allow userdomain shell_exec_t:file entrypoint;
#line 6713


# Use capabilities.
allow newrole_t self:capability { setuid setgid net_bind_service dac_override };

# Write to utmp.
allow newrole_t var_run_t:dir { read getattr lock search ioctl };
allow newrole_t initrc_var_run_t:file { ioctl read getattr lock write append };

# Read the devpts root directory.
allow newrole_t devpts_t:dir { read getattr lock search ioctl };

# Read the /etc/security/default_type file
allow newrole_t etc_t:file { read getattr lock ioctl };

# Read /var.
allow newrole_t var_t:dir { read getattr lock search ioctl };
allow newrole_t var_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };

# Read /dev directories and any symbolic links.
allow newrole_t device_t:dir { read getattr lock search ioctl };

# Relabel terminals.
allow newrole_t ttyfile:chr_file { getattr relabelfrom relabelto };
allow newrole_t ptyfile:chr_file { getattr relabelfrom relabelto };

# Access terminals.
allow newrole_t ttyfile:chr_file { ioctl read getattr lock write append };
allow newrole_t ptyfile:chr_file { ioctl read getattr lock write append };


#
# Allow sysadm_t to reap a user_t process 
# created via newrole.
#
allow userdomain userdomain:process { sigchld };

#
# Allow newrole to obtain SIDs to relabel TTYs
#
allow newrole_t security_t:security { sid_to_context context_to_sid change_sid };

allow newrole_t fs_t:filesystem getattr;

# for some PAM modules and for cwd
dontaudit newrole_t { home_root_t home_type }:dir search;

# Failed reads to /proc cause no harm, so don't audit them
dontaudit newrole_t proc_t:dir search;
allow newrole_t netif_eth0_t:netif { udp_send };
allow newrole_t netmsg_eth0_t:udp_socket { recvfrom };
allow newrole_t newrole_t:udp_socket { read };
allow newrole_t node_t:node { udp_send };

allow newrole_t var_spool_t:file { execute getattr read };

#DESC Passwd - Password utilities
#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
#

#################################
#
# Rules for the passwd_t domain.
#
# passwd_t is the domain of the passwd program when
# it is executed through the spasswd wrapper.
# passwd_exec_t is the type of the spasswd wrapper.
# This domain and type is also used for wrappers for
# chfn and chsh.
#
type passwd_t, domain, privlog, auth, privowner;

#line 6785
role user_r types passwd_t;
#line 6785
role cougaar_r types passwd_t;
#line 6785
#role staff_r types passwd_t;
#line 6785

role sysadm_r types passwd_t;

type passwd_exec_t, file_type, sysadmfile, exec_type;
type passwd_real_exec_t, file_type, sysadmfile;
type admin_passwd_exec_t, file_type, sysadmfile;


#line 6792
# Access other processes in the same domain.
#line 6792
allow passwd_t self:process *;
#line 6792

#line 6792
# Access /proc/PID files for processes in the same domain.
#line 6792
allow passwd_t self:dir { read getattr lock search ioctl };
#line 6792
allow passwd_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6792

#line 6792
# Access file descriptions, pipes, and sockets
#line 6792
# created by processes in the same domain.
#line 6792
allow passwd_t self:fd *;
#line 6792
allow passwd_t self:fifo_file { ioctl read getattr lock write append };
#line 6792
allow passwd_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 6792
allow passwd_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 6792

#line 6792
# Allow the domain to communicate with other processes in the same domain.
#line 6792
allow passwd_t self:unix_dgram_socket sendto;
#line 6792
allow passwd_t self:unix_stream_socket connectto;
#line 6792

#line 6792
# Access System V IPC objects created by processes in the same domain.
#line 6792
allow passwd_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 6792
allow passwd_t self:msg  { send receive };
#line 6792
allow passwd_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 6792
allow passwd_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 6792

#line 6792
;


#line 6794
allow passwd_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 6794
allow passwd_t ld_so_t:file { read getattr lock execute ioctl };
#line 6794
allow passwd_t ld_so_t:file execute_no_trans;
#line 6794
allow passwd_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 6794
allow passwd_t shlib_t:file { read getattr lock execute ioctl };
#line 6794
allow passwd_t shlib_t:lnk_file { read getattr lock ioctl };
#line 6794
allow passwd_t ld_so_cache_t:file { read getattr lock ioctl };
#line 6794
allow passwd_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 6794
;


#line 6796

#line 6796

#line 6796
#
#line 6796
# Allow the process to transition to the new domain.
#line 6796
#
#line 6796
allow userdomain passwd_t:process transition;
#line 6796

#line 6796
#
#line 6796
# Allow the process to execute the program.
#line 6796
# 
#line 6796
allow userdomain passwd_exec_t:file { getattr execute };
#line 6796

#line 6796
#
#line 6796
# Allow the process to reap the new domain.
#line 6796
#
#line 6796
allow passwd_t userdomain:process sigchld;
#line 6796

#line 6796
#
#line 6796
# Allow the new domain to inherit and use file 
#line 6796
# descriptions from the creating process and vice versa.
#line 6796
#
#line 6796
allow passwd_t userdomain:fd use;
#line 6796
allow userdomain passwd_t:fd use;
#line 6796

#line 6796
#
#line 6796
# Allow the new domain to write back to the old domain via a pipe.
#line 6796
#
#line 6796
allow passwd_t userdomain:fifo_file { ioctl read getattr lock write append };
#line 6796

#line 6796
#
#line 6796
# Allow the new domain to read and execute the program.
#line 6796
#
#line 6796
allow passwd_t passwd_exec_t:file { read getattr lock execute ioctl };
#line 6796

#line 6796
#
#line 6796
# Allow the new domain to be entered via the program.
#line 6796
#
#line 6796
allow passwd_t passwd_exec_t:file entrypoint;
#line 6796

#line 6796
type_transition userdomain passwd_exec_t:process passwd_t;
#line 6796


#line 6797

#line 6797

#line 6797
#
#line 6797
# Allow the process to transition to the new domain.
#line 6797
#
#line 6797
allow sysadm_t passwd_t:process transition;
#line 6797

#line 6797
#
#line 6797
# Allow the process to execute the program.
#line 6797
# 
#line 6797
allow sysadm_t admin_passwd_exec_t:file { getattr execute };
#line 6797

#line 6797
#
#line 6797
# Allow the process to reap the new domain.
#line 6797
#
#line 6797
allow passwd_t sysadm_t:process sigchld;
#line 6797

#line 6797
#
#line 6797
# Allow the new domain to inherit and use file 
#line 6797
# descriptions from the creating process and vice versa.
#line 6797
#
#line 6797
allow passwd_t sysadm_t:fd use;
#line 6797
allow sysadm_t passwd_t:fd use;
#line 6797

#line 6797
#
#line 6797
# Allow the new domain to write back to the old domain via a pipe.
#line 6797
#
#line 6797
allow passwd_t sysadm_t:fifo_file { ioctl read getattr lock write append };
#line 6797

#line 6797
#
#line 6797
# Allow the new domain to read and execute the program.
#line 6797
#
#line 6797
allow passwd_t admin_passwd_exec_t:file { read getattr lock execute ioctl };
#line 6797

#line 6797
#
#line 6797
# Allow the new domain to be entered via the program.
#line 6797
#
#line 6797
allow passwd_t admin_passwd_exec_t:file entrypoint;
#line 6797

#line 6797
type_transition sysadm_t admin_passwd_exec_t:process passwd_t;
#line 6797


# for vipw - vi looks in the root home directory for config
dontaudit passwd_t sysadm_home_dir_t:dir { getattr search };

# Use capabilities.
allow passwd_t passwd_t:capability { chown dac_override fsetid setuid sys_resource };

# Inherit and use descriptors from login.
allow passwd_t privfd:fd use;

# Execute /usr/bin/{passwd,chfn,chsh} and /usr/sbin/{useradd,vipw}.
allow passwd_t { bin_t sbin_t }:dir { read getattr lock search ioctl };

#line 6810
allow passwd_t { bin_t sbin_t shell_exec_t passwd_real_exec_t }:file { { read getattr lock execute ioctl } execute_no_trans };
#line 6810


# allow checking if a shell is executable
allow passwd_t shell_exec_t:file execute;

# Obtain contexts
allow passwd_t security_t:security { sid_to_context context_to_sid };

# Update /etc/shadow and /etc/passwd

#line 6819

#line 6819

#line 6819

#line 6819
#
#line 6819
# Allow the process to modify the directory.
#line 6819
#
#line 6819
allow passwd_t etc_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 6819

#line 6819
#
#line 6819
# Allow the process to create the file.
#line 6819
#
#line 6819

#line 6819
allow passwd_t shadow_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 6819
allow passwd_t shadow_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 6819

#line 6819

#line 6819

#line 6819
type_transition passwd_t etc_t:dir shadow_t;
#line 6819
type_transition passwd_t etc_t:{ file lnk_file sock_file fifo_file } shadow_t;
#line 6819

#line 6819

#line 6819

allow passwd_t etc_t:file { create ioctl read getattr lock write setattr append link unlink rename };
allow passwd_t { etc_t shadow_t }:file { relabelfrom relabelto };

# allow vipw to create temporary files under /var/tmp/vi.recover

#line 6824
type passwd_tmp_t, file_type, sysadmfile, tmpfile ;
#line 6824

#line 6824

#line 6824

#line 6824

#line 6824
#
#line 6824
# Allow the process to modify the directory.
#line 6824
#
#line 6824
allow passwd_t tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 6824

#line 6824
#
#line 6824
# Allow the process to create the file.
#line 6824
#
#line 6824

#line 6824
allow passwd_t passwd_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 6824
allow passwd_t passwd_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 6824

#line 6824

#line 6824

#line 6824
type_transition passwd_t tmp_t:dir passwd_tmp_t;
#line 6824
type_transition passwd_t tmp_t:{ file lnk_file sock_file fifo_file } passwd_tmp_t;
#line 6824

#line 6824

#line 6824

#line 6824


# Access terminals.
allow passwd_t ttyfile:chr_file { ioctl read getattr lock write append };
allow passwd_t ptyfile:chr_file { ioctl read getattr lock write append };


# for vipw - vi looks in the root home directory for config
dontaudit passwd_t sysadm_home_dir_t:dir { getattr search };

# /usr/bin/passwd asks for w access to utmp, but it will operate
# correctly without it.  Do not audit write denials to utmp.
dontaudit passwd_t initrc_var_run_t:file { read write };

# user generally runs this from their home directory, so do not audit a search
# on user home dir
dontaudit passwd_t { user_home_dir_type user_home_type }:dir search;

# When the wrong current passwd is entered, passwd, for some reason, 
# attempts to access /proc and /dev, but fails appropriately. So don't
# audit those denials.
# Access denials to /var aren't audited either.
dontaudit passwd_t { proc_t device_t var_t }:dir { search read };

allow passwd_t device_t:dir getattr;
#DESC Setfiles - SELinux filesystem labeling utilities
#
# Authors:  Russell Coker <russell@coker.com.au>
#

#################################
#
# Rules for the setfiles_t domain.
#
# setfiles_exec_t is the type of the setfiles executable.
#
type setfiles_t, domain, privlog, privowner;
type setfiles_exec_t, file_type, sysadmfile, exec_type;

role system_r types setfiles_t;
role sysadm_r types setfiles_t;

allow setfiles_t initrc_devpts_t:chr_file { read write ioctl };
allow setfiles_t { sysadm_tty_device_t sysadm_devpts_t }:chr_file { read write ioctl };


#line 6869

#line 6869

#line 6869
#
#line 6869
# Allow the process to transition to the new domain.
#line 6869
#
#line 6869
allow { initrc_t sysadm_t } setfiles_t:process transition;
#line 6869

#line 6869
#
#line 6869
# Allow the process to execute the program.
#line 6869
# 
#line 6869
allow { initrc_t sysadm_t } setfiles_exec_t:file { getattr execute };
#line 6869

#line 6869
#
#line 6869
# Allow the process to reap the new domain.
#line 6869
#
#line 6869
allow setfiles_t { initrc_t sysadm_t }:process sigchld;
#line 6869

#line 6869
#
#line 6869
# Allow the new domain to inherit and use file 
#line 6869
# descriptions from the creating process and vice versa.
#line 6869
#
#line 6869
allow setfiles_t { initrc_t sysadm_t }:fd use;
#line 6869
allow { initrc_t sysadm_t } setfiles_t:fd use;
#line 6869

#line 6869
#
#line 6869
# Allow the new domain to write back to the old domain via a pipe.
#line 6869
#
#line 6869
allow setfiles_t { initrc_t sysadm_t }:fifo_file { ioctl read getattr lock write append };
#line 6869

#line 6869
#
#line 6869
# Allow the new domain to read and execute the program.
#line 6869
#
#line 6869
allow setfiles_t setfiles_exec_t:file { read getattr lock execute ioctl };
#line 6869

#line 6869
#
#line 6869
# Allow the new domain to be entered via the program.
#line 6869
#
#line 6869
allow setfiles_t setfiles_exec_t:file entrypoint;
#line 6869

#line 6869
type_transition { initrc_t sysadm_t } setfiles_exec_t:process setfiles_t;
#line 6869

allow setfiles_t init_t:fd use;
allow setfiles_t privfd:fd use;


#line 6873
allow setfiles_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 6873
allow setfiles_t ld_so_t:file { read getattr lock execute ioctl };
#line 6873
allow setfiles_t ld_so_t:file execute_no_trans;
#line 6873
allow setfiles_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 6873
allow setfiles_t shlib_t:file { read getattr lock execute ioctl };
#line 6873
allow setfiles_t shlib_t:lnk_file { read getattr lock ioctl };
#line 6873
allow setfiles_t ld_so_cache_t:file { read getattr lock ioctl };
#line 6873
allow setfiles_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 6873

allow setfiles_t self:capability { dac_override dac_read_search };

# for upgrading glibc - without this the glibc upgrade scripts will put things
# in a state such that setfiles can not be run!
allow setfiles_t lib_t:file execute;

allow setfiles_t security_t:security { context_to_sid sid_to_context };
allow setfiles_t policy_src_t:file { read getattr lock ioctl };

allow setfiles_t file_type:dir { read getattr lock search ioctl };
allow setfiles_t file_type:lnk_file { read getattr lock ioctl };
allow setfiles_t file_type:{ dir file lnk_file sock_file fifo_file chr_file blk_file } { getattr relabelfrom relabelto };

allow setfiles_t file_labels_t:dir { read getattr lock search ioctl add_name remove_name write };
allow setfiles_t file_labels_t:file { create ioctl read getattr lock write setattr append link unlink rename };

allow setfiles_t kernel_t:system ichsid;

allow setfiles_t fs_t:filesystem getattr;
allow setfiles_t fs_type:dir { read getattr lock search ioctl };

allow setfiles_t etc_runtime_t:file read;
allow setfiles_t etc_t:file read;
allow setfiles_t proc_t:file { getattr read };

# for config files in a home directory
allow setfiles_t home_type:file { read getattr lock ioctl };
#DESC SE Linux User Manager (seuser)
#DEPENDS checkpolicy.te load_policy.te
#
# Authors:   don.patterson@tresys.com mayerf@tresys.com
# Additions: wsalamon@tislabs.com, dac@tresys.com

#

#################################
#
# Rules for the seuser_t domain.
#
# seuser_t is the domain of the seuser application when it is executed.
# seuser_conf_t is the type of the seuser configuration file.
# seuser_exec_t is the type of the seuser executable.
# seuser_tmp_t is the type of the temporary file(s) created by seuser.
# 
##############################################
# Define types, and typical rules including
# access to execute and transition
##############################################

# Defined seuser types
type seuser_t, domain ;
type seuser_conf_t, file_type, sysadmfile ;
type seuser_exec_t, file_type, sysadmfile, exec_type ;
type seuser_tmp_t, file_type, sysadmfile, tmpfile ;

# Authorize roles
role sysadm_r types seuser_t ;

# Allow sysadm_t to run with privilege

#line 6933

#line 6933

#line 6933
#
#line 6933
# Allow the process to transition to the new domain.
#line 6933
#
#line 6933
allow sysadm_t seuser_t:process transition;
#line 6933

#line 6933
#
#line 6933
# Allow the process to execute the program.
#line 6933
# 
#line 6933
allow sysadm_t seuser_exec_t:file { getattr execute };
#line 6933

#line 6933
#
#line 6933
# Allow the process to reap the new domain.
#line 6933
#
#line 6933
allow seuser_t sysadm_t:process sigchld;
#line 6933

#line 6933
#
#line 6933
# Allow the new domain to inherit and use file 
#line 6933
# descriptions from the creating process and vice versa.
#line 6933
#
#line 6933
allow seuser_t sysadm_t:fd use;
#line 6933
allow sysadm_t seuser_t:fd use;
#line 6933

#line 6933
#
#line 6933
# Allow the new domain to write back to the old domain via a pipe.
#line 6933
#
#line 6933
allow seuser_t sysadm_t:fifo_file { ioctl read getattr lock write append };
#line 6933

#line 6933
#
#line 6933
# Allow the new domain to read and execute the program.
#line 6933
#
#line 6933
allow seuser_t seuser_exec_t:file { read getattr lock execute ioctl };
#line 6933

#line 6933
#
#line 6933
# Allow the new domain to be entered via the program.
#line 6933
#
#line 6933
allow seuser_t seuser_exec_t:file entrypoint;
#line 6933

#line 6933
type_transition sysadm_t seuser_exec_t:process seuser_t;
#line 6933


# Permission to create files in /tmp with seuser_tmp_t derived type rather than 
# the tmp_t type

#line 6937

#line 6937

#line 6937

#line 6937
#
#line 6937
# Allow the process to modify the directory.
#line 6937
#
#line 6937
allow seuser_t tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 6937

#line 6937
#
#line 6937
# Allow the process to create the file.
#line 6937
#
#line 6937

#line 6937
allow seuser_t seuser_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 6937
allow seuser_t seuser_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 6937

#line 6937

#line 6937

#line 6937
type_transition seuser_t tmp_t:dir seuser_tmp_t;
#line 6937
type_transition seuser_t tmp_t:{ file lnk_file sock_file fifo_file } seuser_tmp_t;
#line 6937

#line 6937

#line 6937


# Grant the new domain permissions to many common operations
# FIX: Should be more resticted than this.

#line 6941

#line 6941
# Grant the permissions common to the test domains.
#line 6941

#line 6941
# Grant permissions within the domain.
#line 6941

#line 6941
# Access other processes in the same domain.
#line 6941
allow seuser_t self:process *;
#line 6941

#line 6941
# Access /proc/PID files for processes in the same domain.
#line 6941
allow seuser_t self:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6941

#line 6941
# Access file descriptions, pipes, and sockets
#line 6941
# created by processes in the same domain.
#line 6941
allow seuser_t self:fd *;
#line 6941
allow seuser_t self:fifo_file { ioctl read getattr lock write append };
#line 6941
allow seuser_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 6941
allow seuser_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 6941

#line 6941
# Allow the domain to communicate with other processes in the same domain.
#line 6941
allow seuser_t self:unix_dgram_socket sendto;
#line 6941
allow seuser_t self:unix_stream_socket connectto;
#line 6941

#line 6941
# Access System V IPC objects created by processes in the same domain.
#line 6941
allow seuser_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 6941
allow seuser_t self:msg  { send receive };
#line 6941
allow seuser_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 6941
allow seuser_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 6941

#line 6941

#line 6941

#line 6941
# Grant read/search permissions to most of /proc.
#line 6941

#line 6941
# Read system information files in /proc.
#line 6941
allow seuser_t proc_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t proc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6941

#line 6941
# Stat /proc/kmsg and /proc/kcore.
#line 6941
allow seuser_t proc_kmsg_t:file { getattr };
#line 6941
allow seuser_t proc_kcore_t:file { getattr };
#line 6941

#line 6941
# Read system variables in /proc/sys.
#line 6941
allow seuser_t sysctl_modprobe_t:file { read getattr lock ioctl };
#line 6941
allow seuser_t sysctl_t:file { read getattr lock ioctl };
#line 6941
allow seuser_t sysctl_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t sysctl_fs_t:file { read getattr lock ioctl };
#line 6941
allow seuser_t sysctl_fs_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t sysctl_kernel_t:file { read getattr lock ioctl };
#line 6941
allow seuser_t sysctl_kernel_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t sysctl_net_t:file { read getattr lock ioctl };
#line 6941
allow seuser_t sysctl_net_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t sysctl_vm_t:file { read getattr lock ioctl };
#line 6941
allow seuser_t sysctl_vm_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t sysctl_dev_t:file { read getattr lock ioctl };
#line 6941
allow seuser_t sysctl_dev_t:dir { read getattr lock search ioctl };
#line 6941

#line 6941

#line 6941
# Grant read/search permissions to many system file types.
#line 6941

#line 6941

#line 6941
# Get attributes of file systems.
#line 6941
allow seuser_t fs_type:filesystem getattr;
#line 6941

#line 6941

#line 6941
# Read /.
#line 6941
allow seuser_t root_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t root_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6941

#line 6941
# Read /home.
#line 6941
allow seuser_t home_root_t:dir { read getattr lock search ioctl };
#line 6941

#line 6941
# Read /usr.
#line 6941
allow seuser_t usr_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t usr_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6941

#line 6941
# Read bin and sbin directories.
#line 6941
allow seuser_t bin_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6941
allow seuser_t sbin_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6941

#line 6941

#line 6941
# Read directories and files with the readable_t type.
#line 6941
# This type is a general type for "world"-readable files.
#line 6941
allow seuser_t readable_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t readable_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6941

#line 6941
# Stat /...security and lost+found.
#line 6941
allow seuser_t file_labels_t:dir getattr;
#line 6941
allow seuser_t lost_found_t:dir getattr;
#line 6941

#line 6941
# Read the devpts root directory.  
#line 6941
allow seuser_t devpts_t:dir { read getattr lock search ioctl };
#line 6941

#line 6941

#line 6941
# Read the /tmp directory and any /tmp files with the base type.
#line 6941
# Temporary files created at runtime will typically use derived types.
#line 6941
allow seuser_t tmp_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t tmp_t:{ file lnk_file } { read getattr lock ioctl };
#line 6941

#line 6941
# Read /var.
#line 6941
allow seuser_t var_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t var_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6941

#line 6941
# Read /var/catman.
#line 6941
allow seuser_t catman_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t catman_t:{ file lnk_file } { read getattr lock ioctl };
#line 6941

#line 6941
# Read /var/lib.
#line 6941
allow seuser_t var_lib_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t var_lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6941
allow seuser_t var_lib_nfs_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t var_lib_nfs_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6941

#line 6941

#line 6941
allow seuser_t tetex_data_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t tetex_data_t:{ file lnk_file } { read getattr lock ioctl };
#line 6941

#line 6941

#line 6941
# Read /var/yp.
#line 6941
allow seuser_t var_yp_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t var_yp_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6941

#line 6941
# Read /var/spool.
#line 6941
allow seuser_t var_spool_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t var_spool_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6941

#line 6941
# Read /var/run, /var/lock, /var/log.
#line 6941
allow seuser_t var_run_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t var_run_t:{ file lnk_file } { read getattr lock ioctl };
#line 6941
allow seuser_t var_log_t:dir { read getattr lock search ioctl };
#line 6941
#allow seuser_t var_log_t:{ file lnk_file } r_file_perms;
#line 6941
allow seuser_t var_log_sa_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t var_log_sa_t:{ file lnk_file } { read getattr lock ioctl };
#line 6941
allow seuser_t var_log_ksyms_t:{ file lnk_file } { read getattr lock ioctl };
#line 6941

#line 6941
allow seuser_t var_lock_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t var_lock_t:{ file lnk_file } { read getattr lock ioctl };
#line 6941

#line 6941
# Read /var/run/utmp and /var/log/wtmp.
#line 6941
allow seuser_t initrc_var_run_t:file { read getattr lock ioctl };
#line 6941
allow seuser_t wtmp_t:file { read getattr lock ioctl };
#line 6941

#line 6941
# Read /boot, /boot/System.map*, and /vmlinuz*
#line 6941
allow seuser_t boot_t:dir { search getattr };
#line 6941
allow seuser_t boot_t:file getattr;
#line 6941
allow seuser_t system_map_t:{ file lnk_file } { read getattr lock ioctl };
#line 6941

#line 6941
allow seuser_t boot_t:lnk_file read;
#line 6941

#line 6941
# Read /etc.
#line 6941
allow seuser_t etc_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t etc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6941
allow seuser_t etc_runtime_t:{ file lnk_file } { read getattr lock ioctl };
#line 6941
allow seuser_t etc_aliases_t:{ file lnk_file } { read getattr lock ioctl };
#line 6941
allow seuser_t etc_mail_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t etc_mail_t:{ file lnk_file } { read getattr lock ioctl };
#line 6941
allow seuser_t resolv_conf_t:{ file lnk_file } { read getattr lock ioctl };
#line 6941
allow seuser_t ld_so_cache_t:file { read getattr lock ioctl };
#line 6941

#line 6941
# Read /lib.
#line 6941
allow seuser_t lib_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t lib_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6941

#line 6941
# Read the linker, shared library, and executable types.
#line 6941
allow seuser_t ld_so_t:{ file lnk_file } { read getattr lock ioctl };
#line 6941
allow seuser_t shlib_t:{ file lnk_file } { read getattr lock ioctl };
#line 6941
allow seuser_t exec_type:{ file lnk_file } { read getattr lock ioctl };
#line 6941

#line 6941
# Read man directories and files.
#line 6941
allow seuser_t man_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t man_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6941

#line 6941
# Read /usr/src.
#line 6941
allow seuser_t src_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t src_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 6941

#line 6941
# Read module-related files.
#line 6941
allow seuser_t modules_object_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t modules_object_t:{ file lnk_file } { read getattr lock ioctl };
#line 6941
allow seuser_t modules_dep_t:{ file lnk_file } { read getattr lock ioctl };
#line 6941
allow seuser_t modules_conf_t:{ file lnk_file} { read getattr lock ioctl };
#line 6941

#line 6941
# Read /dev directories and any symbolic links.
#line 6941
allow seuser_t device_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t device_t:lnk_file { read getattr lock ioctl };
#line 6941

#line 6941
# Read /dev/random and /dev/zero.
#line 6941
allow seuser_t random_device_t:chr_file { read getattr lock ioctl };
#line 6941
allow seuser_t zero_device_t:chr_file { read getattr lock ioctl };
#line 6941

#line 6941
# Read the root directory of a tmpfs filesytem and any symbolic links.
#line 6941
allow seuser_t tmpfs_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t tmpfs_t:lnk_file { read getattr lock ioctl };
#line 6941

#line 6941
# Read any symbolic links on a devfs file system.
#line 6941
allow seuser_t device_t:lnk_file { read getattr lock ioctl };
#line 6941

#line 6941
# Read the root directory of a usbdevfs filesystem, and
#line 6941
# the devices and drivers files.  Permit stating of the
#line 6941
# device nodes, but nothing else.
#line 6941
allow seuser_t usbdevfs_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t usbdevfs_t:{ file lnk_file } { read getattr lock ioctl };
#line 6941
allow seuser_t usbdevfs_device_t:file getattr;
#line 6941

#line 6941

#line 6941
# Grant write permissions to a small set of system file types.
#line 6941
# No permission to create files is granted here.  Use allow rules to grant 
#line 6941
# create permissions to a type or use file_type_auto_trans rules to set up
#line 6941
# new types for files.
#line 6941

#line 6941

#line 6941
# Read and write /dev/tty and /dev/null.
#line 6941
allow seuser_t devtty_t:chr_file { ioctl read getattr lock write append };
#line 6941
allow seuser_t { null_device_t zero_device_t }:chr_file { ioctl read getattr lock write append };
#line 6941

#line 6941
# Do not audit write denials to /etc/ld.so.cache.
#line 6941
dontaudit seuser_t ld_so_cache_t:file write;
#line 6941

#line 6941

#line 6941
# Execute from the system shared libraries.
#line 6941
# No permission to execute anything else is granted here.
#line 6941
# Use can_exec or can_exec_any to grant the ability to execute within a domain.
#line 6941
# Use domain_auto_trans for executing and changing domains.
#line 6941

#line 6941
allow seuser_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t ld_so_t:file { read getattr lock execute ioctl };
#line 6941
allow seuser_t ld_so_t:file execute_no_trans;
#line 6941
allow seuser_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 6941
allow seuser_t shlib_t:file { read getattr lock execute ioctl };
#line 6941
allow seuser_t shlib_t:lnk_file { read getattr lock ioctl };
#line 6941
allow seuser_t ld_so_cache_t:file { read getattr lock ioctl };
#line 6941
allow seuser_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 6941

#line 6941

#line 6941
# read localization information
#line 6941
allow seuser_t locale_t:dir { read getattr lock search ioctl };
#line 6941
allow seuser_t locale_t:{file lnk_file} { read getattr lock ioctl };
#line 6941

#line 6941
# Obtain the context of any SID, the SID for any context, 
#line 6941
# and the list of active SIDs.
#line 6941
allow seuser_t security_t:security { sid_to_context context_to_sid get_sids };
#line 6941

#line 6941

#line 6941

#line 6941
# Grant permissions needed to create TCP and UDP sockets and 
#line 6941
# to access the network.
#line 6941

#line 6941
#
#line 6941
# Allow the domain to create and use UDP and TCP sockets.
#line 6941
# Other kinds of sockets must be separately authorized for use.
#line 6941
allow seuser_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 6941
allow seuser_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 6941

#line 6941
#
#line 6941
# Allow the domain to send UDP packets.
#line 6941
# Since the destination sockets type is unknown, the generic
#line 6941
# any_socket_t type is used as a placeholder.
#line 6941
#
#line 6941
allow seuser_t any_socket_t:udp_socket sendto;
#line 6941

#line 6941
#
#line 6941
# Allow the domain to send using any network interface.
#line 6941
# netif_type is a type attribute for all network interface types.
#line 6941
#
#line 6941
allow seuser_t netif_type:netif { tcp_send udp_send rawip_send };
#line 6941

#line 6941
#
#line 6941
# Allow packets sent by the domain to be received on any network interface.
#line 6941
#
#line 6941
allow seuser_t netif_type:netif { tcp_recv udp_recv rawip_recv };
#line 6941

#line 6941
#
#line 6941
# Allow the domain to receive packets from any network interface.
#line 6941
# netmsg_type is a type attribute for all default message types.
#line 6941
#
#line 6941
allow seuser_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
#line 6941

#line 6941
#
#line 6941
# Allow the domain to initiate or accept TCP connections 
#line 6941
# on any network interface.
#line 6941
#
#line 6941
allow seuser_t netmsg_type:tcp_socket { connectto acceptfrom };
#line 6941

#line 6941
#
#line 6941
# Receive resets from the TCP reset socket.
#line 6941
# The TCP reset socket is labeled with the tcp_socket_t type.
#line 6941
#
#line 6941
allow seuser_t tcp_socket_t:tcp_socket recvfrom;
#line 6941

#line 6941
dontaudit seuser_t tcp_socket_t:tcp_socket connectto;
#line 6941

#line 6941
#
#line 6941
# Allow the domain to send to any node.
#line 6941
# node_type is a type attribute for all node types.
#line 6941
#
#line 6941
allow seuser_t node_type:node { tcp_send udp_send rawip_send };
#line 6941

#line 6941
#
#line 6941
# Allow packets sent by the domain to be received from any node.
#line 6941
#
#line 6941
allow seuser_t node_type:node { tcp_recv udp_recv rawip_recv };
#line 6941

#line 6941
#
#line 6941
# Allow the domain to send NFS client requests via the socket
#line 6941
# created by mount.
#line 6941
#
#line 6941
allow seuser_t mount_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 6941

#line 6941
#
#line 6941
# Bind to the default port type.
#line 6941
# Other port types must be separately authorized.
#line 6941
#
#line 6941
allow seuser_t port_t:udp_socket name_bind;
#line 6941
allow seuser_t port_t:tcp_socket name_bind;
#line 6941

#line 6941


# Use capabilities to self
allow seuser_t self:capability { dac_override setuid setgid } ;

# Read permissions for seuser.conf file
allow seuser_t seuser_conf_t:file { read getattr lock ioctl } ;


###################################################################
# Policy section: Define the ability to change and load policies
###################################################################

# seuser_t domain needs to transition to the checkpolicy and loadpolicy 
# domains in order to install and load new policies.

#line 6956

#line 6956

#line 6956
#
#line 6956
# Allow the process to transition to the new domain.
#line 6956
#
#line 6956
allow seuser_t checkpolicy_t:process transition;
#line 6956

#line 6956
#
#line 6956
# Allow the process to execute the program.
#line 6956
# 
#line 6956
allow seuser_t checkpolicy_exec_t:file { getattr execute };
#line 6956

#line 6956
#
#line 6956
# Allow the process to reap the new domain.
#line 6956
#
#line 6956
allow checkpolicy_t seuser_t:process sigchld;
#line 6956

#line 6956
#
#line 6956
# Allow the new domain to inherit and use file 
#line 6956
# descriptions from the creating process and vice versa.
#line 6956
#
#line 6956
allow checkpolicy_t seuser_t:fd use;
#line 6956
allow seuser_t checkpolicy_t:fd use;
#line 6956

#line 6956
#
#line 6956
# Allow the new domain to write back to the old domain via a pipe.
#line 6956
#
#line 6956
allow checkpolicy_t seuser_t:fifo_file { ioctl read getattr lock write append };
#line 6956

#line 6956
#
#line 6956
# Allow the new domain to read and execute the program.
#line 6956
#
#line 6956
allow checkpolicy_t checkpolicy_exec_t:file { read getattr lock execute ioctl };
#line 6956

#line 6956
#
#line 6956
# Allow the new domain to be entered via the program.
#line 6956
#
#line 6956
allow checkpolicy_t checkpolicy_exec_t:file entrypoint;
#line 6956

#line 6956
type_transition seuser_t checkpolicy_exec_t:process checkpolicy_t;
#line 6956


#line 6957

#line 6957

#line 6957
#
#line 6957
# Allow the process to transition to the new domain.
#line 6957
#
#line 6957
allow seuser_t load_policy_t:process transition;
#line 6957

#line 6957
#
#line 6957
# Allow the process to execute the program.
#line 6957
# 
#line 6957
allow seuser_t load_policy_exec_t:file { getattr execute };
#line 6957

#line 6957
#
#line 6957
# Allow the process to reap the new domain.
#line 6957
#
#line 6957
allow load_policy_t seuser_t:process sigchld;
#line 6957

#line 6957
#
#line 6957
# Allow the new domain to inherit and use file 
#line 6957
# descriptions from the creating process and vice versa.
#line 6957
#
#line 6957
allow load_policy_t seuser_t:fd use;
#line 6957
allow seuser_t load_policy_t:fd use;
#line 6957

#line 6957
#
#line 6957
# Allow the new domain to write back to the old domain via a pipe.
#line 6957
#
#line 6957
allow load_policy_t seuser_t:fifo_file { ioctl read getattr lock write append };
#line 6957

#line 6957
#
#line 6957
# Allow the new domain to read and execute the program.
#line 6957
#
#line 6957
allow load_policy_t load_policy_exec_t:file { read getattr lock execute ioctl };
#line 6957

#line 6957
#
#line 6957
# Allow the new domain to be entered via the program.
#line 6957
#
#line 6957
allow load_policy_t load_policy_exec_t:file entrypoint;
#line 6957

#line 6957
type_transition seuser_t load_policy_exec_t:process load_policy_t;
#line 6957


# allow load_policy and checkpolicy domains access to seuser_tmp_t
# files in order for their stdout/stderr able to be put into
# seuser's tmp files.
#
# Since both these domains carefully try to limit where the
# assoicated program can read from, we won't use the standard
# rw_file_perm macro, but instead only grant the minimum needed
# to redirect output, write and getattr.
allow checkpolicy_t seuser_tmp_t:file { getattr write } ;
allow load_policy_t seuser_tmp_t:file { getattr write } ;

# FIX:  Temporarily allow seuser_t permissions for executing programs with a 
# bint_t type without changing domains. We have to give seuser_t the following 
# access because we use the policy make process to build new plicy.conf files. 
# At some point, a new policy management infrastructure should remove the ability 
# to modify policy source files with arbitrary progams
#

#line 6976
allow seuser_t bin_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 6976


#line 6977
allow seuser_t shell_exec_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 6977



# Read/write permission to the login context files in /etc/security
allow seuser_t login_contexts:file { create ioctl read getattr lock write setattr append link unlink rename } ;

# Read/write permission to the policy source and its' directory
allow seuser_t policy_src_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir } ;
allow seuser_t policy_src_t:file { create ioctl read getattr lock write setattr append link unlink rename } ;

# Allow search and stat for policy_config_t
allow seuser_t policy_config_t:dir { search getattr } ;
allow seuser_t policy_config_t:file { getattr };


#line 7005

#line 7008


# seuser_t domain needs execute access to the library files so that it can run.

#line 7011
allow seuser_t lib_t:file { { read getattr lock execute ioctl } execute_no_trans };
#line 7011


# Access ttys
allow seuser_t sysadm_tty_device_t:chr_file { ioctl read getattr lock write append } ;
allow seuser_t sysadm_devpts_t:chr_file { ioctl read getattr lock write append } ;

#DESC Snort - Network sniffer
#
# Author: Shaun Savage <savages@pcez.com> 
# Modified by Russell Coker <russell@coker.com.au>
#


#line 7023

#line 7023
type snort_t, domain, privlog ;
#line 7023
type snort_exec_t, file_type, sysadmfile, exec_type;
#line 7023

#line 7023
role system_r types snort_t;
#line 7023

#line 7023

#line 7023

#line 7023

#line 7023
#
#line 7023
# Allow the process to transition to the new domain.
#line 7023
#
#line 7023
allow initrc_t snort_t:process transition;
#line 7023

#line 7023
#
#line 7023
# Allow the process to execute the program.
#line 7023
# 
#line 7023
allow initrc_t snort_exec_t:file { getattr execute };
#line 7023

#line 7023
#
#line 7023
# Allow the process to reap the new domain.
#line 7023
#
#line 7023
allow snort_t initrc_t:process sigchld;
#line 7023

#line 7023
#
#line 7023
# Allow the new domain to inherit and use file 
#line 7023
# descriptions from the creating process and vice versa.
#line 7023
#
#line 7023
allow snort_t initrc_t:fd use;
#line 7023
allow initrc_t snort_t:fd use;
#line 7023

#line 7023
#
#line 7023
# Allow the new domain to write back to the old domain via a pipe.
#line 7023
#
#line 7023
allow snort_t initrc_t:fifo_file { ioctl read getattr lock write append };
#line 7023

#line 7023
#
#line 7023
# Allow the new domain to read and execute the program.
#line 7023
#
#line 7023
allow snort_t snort_exec_t:file { read getattr lock execute ioctl };
#line 7023

#line 7023
#
#line 7023
# Allow the new domain to be entered via the program.
#line 7023
#
#line 7023
allow snort_t snort_exec_t:file entrypoint;
#line 7023

#line 7023
type_transition initrc_t snort_exec_t:process snort_t;
#line 7023

#line 7023

#line 7023
# Inherit and use descriptors from init.
#line 7023
allow snort_t init_t:fd use;
#line 7023
allow snort_t init_t:process sigchld;
#line 7023
allow snort_t privfd:fd use;
#line 7023
allow snort_t newrole_t:process sigchld;
#line 7023
allow snort_t self:process { { sigchld sigkill sigstop signull signal } fork };
#line 7023

#line 7023

#line 7023
allow snort_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 7023
allow snort_t ld_so_t:file { read getattr lock execute ioctl };
#line 7023
allow snort_t ld_so_t:file execute_no_trans;
#line 7023
allow snort_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 7023
allow snort_t shlib_t:file { read getattr lock execute ioctl };
#line 7023
allow snort_t shlib_t:lnk_file { read getattr lock ioctl };
#line 7023
allow snort_t ld_so_cache_t:file { read getattr lock ioctl };
#line 7023
allow snort_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 7023

#line 7023

#line 7023
allow snort_t { self proc_t }:dir { read getattr lock search ioctl };
#line 7023
allow snort_t { self proc_t }:lnk_file read;
#line 7023

#line 7023
allow snort_t device_t:dir { getattr search };
#line 7023
allow snort_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 7023
allow snort_t console_device_t:chr_file { ioctl read getattr lock write append };
#line 7023
allow snort_t initrc_devpts_t:chr_file { ioctl read getattr lock write append };
#line 7023

#line 7023
# Create pid file.
#line 7023
allow snort_t var_t:dir { getattr search };
#line 7023
type var_run_snort_t, file_type, sysadmfile, pidfile;
#line 7023

#line 7023

#line 7023

#line 7023

#line 7023
#
#line 7023
# Allow the process to modify the directory.
#line 7023
#
#line 7023
allow snort_t var_run_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 7023

#line 7023
#
#line 7023
# Allow the process to create the file.
#line 7023
#
#line 7023

#line 7023
allow snort_t var_run_snort_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 7023
allow snort_t var_run_snort_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 7023

#line 7023

#line 7023

#line 7023
type_transition snort_t var_run_t:dir var_run_snort_t;
#line 7023
type_transition snort_t var_run_t:{ file lnk_file sock_file fifo_file } var_run_snort_t;
#line 7023

#line 7023

#line 7023

#line 7023

#line 7023
allow snort_t devtty_t:chr_file { ioctl read getattr lock write append };
#line 7023

#line 7023
# for daemons that look at /root on startup
#line 7023
dontaudit snort_t sysadm_home_dir_t:dir search;
#line 7023

#line 7023
# for df
#line 7023
allow snort_t fs_type:filesystem getattr;
#line 7023



#line 7025
type snort_log_t, file_type, sysadmfile, logfile;
#line 7025

#line 7025

#line 7025

#line 7025

#line 7025
#
#line 7025
# Allow the process to modify the directory.
#line 7025
#
#line 7025
allow snort_t var_log_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 7025

#line 7025
#
#line 7025
# Allow the process to create the file.
#line 7025
#
#line 7025

#line 7025
allow snort_t snort_log_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 7025
allow snort_t snort_log_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 7025

#line 7025

#line 7025

#line 7025
type_transition snort_t var_log_t:dir snort_log_t;
#line 7025
type_transition snort_t var_log_t:{ file lnk_file sock_file fifo_file } snort_log_t;
#line 7025

#line 7025

#line 7025

#line 7025


#line 7026
#
#line 7026
# Allow the domain to create and use UDP and TCP sockets.
#line 7026
# Other kinds of sockets must be separately authorized for use.
#line 7026
allow snort_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 7026
allow snort_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 7026

#line 7026
#
#line 7026
# Allow the domain to send UDP packets.
#line 7026
# Since the destination sockets type is unknown, the generic
#line 7026
# any_socket_t type is used as a placeholder.
#line 7026
#
#line 7026
allow snort_t any_socket_t:udp_socket sendto;
#line 7026

#line 7026
#
#line 7026
# Allow the domain to send using any network interface.
#line 7026
# netif_type is a type attribute for all network interface types.
#line 7026
#
#line 7026
allow snort_t netif_type:netif { tcp_send udp_send rawip_send };
#line 7026

#line 7026
#
#line 7026
# Allow packets sent by the domain to be received on any network interface.
#line 7026
#
#line 7026
allow snort_t netif_type:netif { tcp_recv udp_recv rawip_recv };
#line 7026

#line 7026
#
#line 7026
# Allow the domain to receive packets from any network interface.
#line 7026
# netmsg_type is a type attribute for all default message types.
#line 7026
#
#line 7026
allow snort_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
#line 7026

#line 7026
#
#line 7026
# Allow the domain to initiate or accept TCP connections 
#line 7026
# on any network interface.
#line 7026
#
#line 7026
allow snort_t netmsg_type:tcp_socket { connectto acceptfrom };
#line 7026

#line 7026
#
#line 7026
# Receive resets from the TCP reset socket.
#line 7026
# The TCP reset socket is labeled with the tcp_socket_t type.
#line 7026
#
#line 7026
allow snort_t tcp_socket_t:tcp_socket recvfrom;
#line 7026

#line 7026
dontaudit snort_t tcp_socket_t:tcp_socket connectto;
#line 7026

#line 7026
#
#line 7026
# Allow the domain to send to any node.
#line 7026
# node_type is a type attribute for all node types.
#line 7026
#
#line 7026
allow snort_t node_type:node { tcp_send udp_send rawip_send };
#line 7026

#line 7026
#
#line 7026
# Allow packets sent by the domain to be received from any node.
#line 7026
#
#line 7026
allow snort_t node_type:node { tcp_recv udp_recv rawip_recv };
#line 7026

#line 7026
#
#line 7026
# Allow the domain to send NFS client requests via the socket
#line 7026
# created by mount.
#line 7026
#
#line 7026
allow snort_t mount_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 7026

#line 7026
#
#line 7026
# Bind to the default port type.
#line 7026
# Other port types must be separately authorized.
#line 7026
#
#line 7026
allow snort_t port_t:udp_socket name_bind;
#line 7026
allow snort_t port_t:tcp_socket name_bind;
#line 7026

type snort_etc_t, file_type, sysadmfile;

# Create temporary files.

#line 7030
type snort_tmp_t, file_type, sysadmfile, tmpfile ;
#line 7030

#line 7030

#line 7030

#line 7030

#line 7030
#
#line 7030
# Allow the process to modify the directory.
#line 7030
#
#line 7030
allow snort_t tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 7030

#line 7030
#
#line 7030
# Allow the process to create the file.
#line 7030
#
#line 7030

#line 7030
allow snort_t snort_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 7030
allow snort_t snort_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 7030

#line 7030

#line 7030

#line 7030
type_transition snort_t tmp_t:dir snort_tmp_t;
#line 7030
type_transition snort_t tmp_t:{ file lnk_file sock_file fifo_file } snort_tmp_t;
#line 7030

#line 7030

#line 7030

#line 7030


# use iptable netlink
allow snort_t self:netlink_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
allow snort_t self:packet_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
allow snort_t self:capability { setgid setuid net_admin net_raw };


#line 7037
allow snort_t snort_etc_t:dir { read getattr lock search ioctl };
#line 7037
allow snort_t snort_etc_t:{ file lnk_file } { read getattr lock ioctl };
#line 7037

allow snort_t etc_t:file { getattr read };
allow snort_t etc_t:lnk_file read;

allow snort_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
allow snort_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };

# for start script
allow initrc_t snort_etc_t:file read;
#DESC SSH - SSH daemon
#
# Authors:  Anthony Colatrella (NSA) <amcolat@epoch.ncsc.mil>
# Modified by: Russell Coker <russell@coker.com.au>
#

type ssh_port_t, port_type;

#line 7140

#################################
#
# Rules for the sshd_t domain, et al.
#
# sshd_t is the domain for the sshd program.
# sshd_login_t is the domain for sshds login spawn
# sshd_exec_t is the type of the sshd executable.
# sshd_key_t is the type of the ssh private key files
#

#line 7150
type sshd_t, domain, privuser, privrole, privlog, privowner, privfd;
#line 7150
role system_r types sshd_t;
#line 7150

#line 7150
# Access other processes in the same domain.
#line 7150
allow sshd_t self:process *;
#line 7150

#line 7150
# Access /proc/PID files for processes in the same domain.
#line 7150
allow sshd_t self:dir { read getattr lock search ioctl };
#line 7150
allow sshd_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 7150

#line 7150
# Access file descriptions, pipes, and sockets
#line 7150
# created by processes in the same domain.
#line 7150
allow sshd_t self:fd *;
#line 7150
allow sshd_t self:fifo_file { ioctl read getattr lock write append };
#line 7150
allow sshd_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 7150
allow sshd_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 7150

#line 7150
# Allow the domain to communicate with other processes in the same domain.
#line 7150
allow sshd_t self:unix_dgram_socket sendto;
#line 7150
allow sshd_t self:unix_stream_socket connectto;
#line 7150

#line 7150
# Access System V IPC objects created by processes in the same domain.
#line 7150
allow sshd_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 7150
allow sshd_t self:msg  { send receive };
#line 7150
allow sshd_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 7150
allow sshd_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 7150

#line 7150

#line 7150

#line 7150
allow sshd_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 7150
allow sshd_t ld_so_t:file { read getattr lock execute ioctl };
#line 7150
allow sshd_t ld_so_t:file execute_no_trans;
#line 7150
allow sshd_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 7150
allow sshd_t shlib_t:file { read getattr lock execute ioctl };
#line 7150
allow sshd_t shlib_t:lnk_file { read getattr lock ioctl };
#line 7150
allow sshd_t ld_so_cache_t:file { read getattr lock ioctl };
#line 7150
allow sshd_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 7150

#line 7150

#line 7150
# Read system information files in /proc.
#line 7150
allow sshd_t proc_t:dir { read getattr lock search ioctl };
#line 7150
allow sshd_t proc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 7150

#line 7150
# Get attributes of file systems.
#line 7150
allow sshd_t fs_type:filesystem getattr;
#line 7150

#line 7150

#line 7150
# Read /.
#line 7150
allow sshd_t root_t:dir { read getattr lock search ioctl };
#line 7150
allow sshd_t root_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 7150

#line 7150
# Read /home.
#line 7150
allow sshd_t home_root_t:dir { read getattr lock search ioctl };
#line 7150

#line 7150
# Read /usr.
#line 7150
allow sshd_t usr_t:dir { read getattr lock search ioctl };
#line 7150
allow sshd_t usr_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 7150

#line 7150
# Read bin and sbin directories.
#line 7150
allow sshd_t bin_t:dir { read getattr lock search ioctl };
#line 7150
allow sshd_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 7150
allow sshd_t sbin_t:dir { read getattr lock search ioctl };
#line 7150
allow sshd_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 7150

#line 7150

#line 7150
# Read the devpts root directory.
#line 7150
allow sshd_t devpts_t:dir { read getattr lock search ioctl };
#line 7150

#line 7150
# Read /var.
#line 7150
allow sshd_t var_t:dir { read getattr lock search ioctl };
#line 7150
allow sshd_t var_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 7150

#line 7150
# Read /var/log.
#line 7150
allow sshd_t var_log_t:dir { read getattr lock search ioctl };
#line 7150
allow sshd_t var_log_t:{ file lnk_file } { read getattr lock ioctl };
#line 7150

#line 7150
# Read /etc.
#line 7150
allow sshd_t etc_t:dir { read getattr lock search ioctl };
#line 7150
allow sshd_t etc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 7150
allow sshd_t etc_runtime_t:{ file lnk_file } { read getattr lock ioctl };
#line 7150
allow sshd_t resolv_conf_t:{ file lnk_file } { read getattr lock ioctl };
#line 7150

#line 7150
# Read the linker, shared library, and executable types.
#line 7150
allow sshd_t ld_so_t:{ file lnk_file } { read getattr lock ioctl };
#line 7150
allow sshd_t shlib_t:{ file lnk_file } { read getattr lock ioctl };
#line 7150
allow sshd_t exec_type:{ file lnk_file } { read getattr lock ioctl };
#line 7150

#line 7150
# Read /dev directories and any symbolic links.
#line 7150
allow sshd_t device_t:dir { read getattr lock search ioctl };
#line 7150
allow sshd_t device_t:lnk_file { read getattr lock ioctl };
#line 7150

#line 7150
# Read and write /dev/tty and /dev/null.
#line 7150
allow sshd_t devtty_t:chr_file { ioctl read getattr lock write append };
#line 7150
allow sshd_t { null_device_t zero_device_t }:chr_file { ioctl read getattr lock write append };
#line 7150

#line 7150
# Read /dev/random and /dev/zero.
#line 7150
allow sshd_t random_device_t:chr_file { read getattr lock ioctl };
#line 7150
#allow sshd_t zero_device_t:chr_file r_file_perms;
#line 7150

#line 7150
# Read PID files in /var/run.  pidfile is a type attribute for
#line 7150
# all types used for such files.
#line 7150
allow sshd_t pidfile:file { read getattr lock ioctl };
#line 7150

#line 7150

#line 7150
#allow sshd_t security_t:security { sid_to_context context_to_sid get_sids };
#line 7150
allow sshd_t security_t:security { sid_to_context context_to_sid };
#line 7150

#line 7150
#
#line 7150
# Allow the domain to create and use UDP and TCP sockets.
#line 7150
# Other kinds of sockets must be separately authorized for use.
#line 7150
allow sshd_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 7150
allow sshd_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 7150

#line 7150
#
#line 7150
# Allow the domain to send UDP packets.
#line 7150
# Since the destination sockets type is unknown, the generic
#line 7150
# any_socket_t type is used as a placeholder.
#line 7150
#
#line 7150
allow sshd_t any_socket_t:udp_socket sendto;
#line 7150

#line 7150
#
#line 7150
# Allow the domain to send using any network interface.
#line 7150
# netif_type is a type attribute for all network interface types.
#line 7150
#
#line 7150
allow sshd_t netif_type:netif { tcp_send udp_send rawip_send };
#line 7150

#line 7150
#
#line 7150
# Allow packets sent by the domain to be received on any network interface.
#line 7150
#
#line 7150
allow sshd_t netif_type:netif { tcp_recv udp_recv rawip_recv };
#line 7150

#line 7150
#
#line 7150
# Allow the domain to receive packets from any network interface.
#line 7150
# netmsg_type is a type attribute for all default message types.
#line 7150
#
#line 7150
allow sshd_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
#line 7150

#line 7150
#
#line 7150
# Allow the domain to initiate or accept TCP connections 
#line 7150
# on any network interface.
#line 7150
#
#line 7150
allow sshd_t netmsg_type:tcp_socket { connectto acceptfrom };
#line 7150

#line 7150
#
#line 7150
# Receive resets from the TCP reset socket.
#line 7150
# The TCP reset socket is labeled with the tcp_socket_t type.
#line 7150
#
#line 7150
allow sshd_t tcp_socket_t:tcp_socket recvfrom;
#line 7150

#line 7150
dontaudit sshd_t tcp_socket_t:tcp_socket connectto;
#line 7150

#line 7150
#
#line 7150
# Allow the domain to send to any node.
#line 7150
# node_type is a type attribute for all node types.
#line 7150
#
#line 7150
allow sshd_t node_type:node { tcp_send udp_send rawip_send };
#line 7150

#line 7150
#
#line 7150
# Allow packets sent by the domain to be received from any node.
#line 7150
#
#line 7150
allow sshd_t node_type:node { tcp_recv udp_recv rawip_recv };
#line 7150

#line 7150
#
#line 7150
# Allow the domain to send NFS client requests via the socket
#line 7150
# created by mount.
#line 7150
#
#line 7150
allow sshd_t mount_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 7150

#line 7150
#
#line 7150
# Bind to the default port type.
#line 7150
# Other port types must be separately authorized.
#line 7150
#
#line 7150
allow sshd_t port_t:udp_socket name_bind;
#line 7150
allow sshd_t port_t:tcp_socket name_bind;
#line 7150

#line 7150

#line 7150
allow sshd_t self:capability { chown dac_override fowner fsetid setgid setuid net_bind_service sys_tty_config };
#line 7150
allow sshd_t shadow_t:file { read getattr };
#line 7150
allow sshd_t { home_root_t user_home_dir_type sysadm_home_dir_t }:dir { search getattr };
#line 7150

#line 7150
# Run shells in user_t by default
#line 7150

#line 7150

#line 7150

#line 7150
#
#line 7150
# Allow the process to transition to the new domain.
#line 7150
#
#line 7150
allow sshd_t user_t:process transition;
#line 7150

#line 7150
#
#line 7150
# Allow the process to execute the program.
#line 7150
# 
#line 7150
allow sshd_t shell_exec_t:file { getattr execute };
#line 7150

#line 7150
#
#line 7150
# Allow the process to reap the new domain.
#line 7150
#
#line 7150
allow user_t sshd_t:process sigchld;
#line 7150

#line 7150
#
#line 7150
# Allow the new domain to inherit and use file 
#line 7150
# descriptions from the creating process and vice versa.
#line 7150
#
#line 7150
allow user_t sshd_t:fd use;
#line 7150
allow sshd_t user_t:fd use;
#line 7150

#line 7150
#
#line 7150
# Allow the new domain to write back to the old domain via a pipe.
#line 7150
#
#line 7150
allow user_t sshd_t:fifo_file { ioctl read getattr lock write append };
#line 7150

#line 7150
#
#line 7150
# Allow the new domain to read and execute the program.
#line 7150
#
#line 7150
allow user_t shell_exec_t:file { read getattr lock execute ioctl };
#line 7150

#line 7150
#
#line 7150
# Allow the new domain to be entered via the program.
#line 7150
#
#line 7150
allow user_t shell_exec_t:file entrypoint;
#line 7150

#line 7150
type_transition sshd_t shell_exec_t:process user_t;
#line 7150

#line 7150

#line 7150

#line 7150
#
#line 7150
# Allow the process to transition to the new domain.
#line 7150
#
#line 7150
allow sshd_t unpriv_userdomain:process transition;
#line 7150

#line 7150
#
#line 7150
# Allow the process to execute the program.
#line 7150
# 
#line 7150
allow sshd_t shell_exec_t:file { getattr execute };
#line 7150

#line 7150
#
#line 7150
# Allow the process to reap the new domain.
#line 7150
#
#line 7150
allow unpriv_userdomain sshd_t:process sigchld;
#line 7150

#line 7150
#
#line 7150
# Allow the new domain to inherit and use file 
#line 7150
# descriptions from the creating process and vice versa.
#line 7150
#
#line 7150
allow unpriv_userdomain sshd_t:fd use;
#line 7150
allow sshd_t unpriv_userdomain:fd use;
#line 7150

#line 7150
#
#line 7150
# Allow the new domain to write back to the old domain via a pipe.
#line 7150
#
#line 7150
allow unpriv_userdomain sshd_t:fifo_file { ioctl read getattr lock write append };
#line 7150

#line 7150
#
#line 7150
# Allow the new domain to read and execute the program.
#line 7150
#
#line 7150
allow unpriv_userdomain shell_exec_t:file { read getattr lock execute ioctl };
#line 7150

#line 7150
#
#line 7150
# Allow the new domain to be entered via the program.
#line 7150
#
#line 7150
allow unpriv_userdomain shell_exec_t:file entrypoint;
#line 7150

#line 7150

#line 7150
# Allow shells to be run in sysadm_t as well.
#line 7150
# Commented out.  Use newrole rather than directly entering sysadm_t.
#line 7150
#domain_trans(sshd_t, shell_exec_t, sysadm_t)
#line 7150

#line 7150
# Update utmp.
#line 7150
allow sshd_t initrc_var_run_t:file { ioctl read getattr lock write append };
#line 7150

#line 7150
# Update wtmp.
#line 7150
allow sshd_t wtmp_t:file { ioctl read getattr lock write append };
#line 7150

#line 7150
# Obtain the SID to use for relabeling ptys
#line 7150
allow sshd_t security_t:security change_sid;
#line 7150

#line 7150
# Allow read access to login context
#line 7150
allow sshd_t default_context_t:file { read getattr lock ioctl };
#line 7150

#line 7150
# Determine the set of legal user SIDs that can be reached.
#line 7150
allow sshd_t security_t:security get_user_sids;
#line 7150

#line 7150

allow sshd_t initrc_devpts_t:chr_file { ioctl read getattr lock write append };
allow sshd_t ssh_port_t:tcp_socket name_bind;

#line 7153
type sshd_login_t, domain, privuser, privrole, privlog, privowner, privfd;
#line 7153
role system_r types sshd_login_t;
#line 7153

#line 7153
# Access other processes in the same domain.
#line 7153
allow sshd_login_t self:process *;
#line 7153

#line 7153
# Access /proc/PID files for processes in the same domain.
#line 7153
allow sshd_login_t self:dir { read getattr lock search ioctl };
#line 7153
allow sshd_login_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 7153

#line 7153
# Access file descriptions, pipes, and sockets
#line 7153
# created by processes in the same domain.
#line 7153
allow sshd_login_t self:fd *;
#line 7153
allow sshd_login_t self:fifo_file { ioctl read getattr lock write append };
#line 7153
allow sshd_login_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 7153
allow sshd_login_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 7153

#line 7153
# Allow the domain to communicate with other processes in the same domain.
#line 7153
allow sshd_login_t self:unix_dgram_socket sendto;
#line 7153
allow sshd_login_t self:unix_stream_socket connectto;
#line 7153

#line 7153
# Access System V IPC objects created by processes in the same domain.
#line 7153
allow sshd_login_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 7153
allow sshd_login_t self:msg  { send receive };
#line 7153
allow sshd_login_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 7153
allow sshd_login_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 7153

#line 7153

#line 7153

#line 7153
allow sshd_login_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 7153
allow sshd_login_t ld_so_t:file { read getattr lock execute ioctl };
#line 7153
allow sshd_login_t ld_so_t:file execute_no_trans;
#line 7153
allow sshd_login_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 7153
allow sshd_login_t shlib_t:file { read getattr lock execute ioctl };
#line 7153
allow sshd_login_t shlib_t:lnk_file { read getattr lock ioctl };
#line 7153
allow sshd_login_t ld_so_cache_t:file { read getattr lock ioctl };
#line 7153
allow sshd_login_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 7153

#line 7153

#line 7153
# Read system information files in /proc.
#line 7153
allow sshd_login_t proc_t:dir { read getattr lock search ioctl };
#line 7153
allow sshd_login_t proc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 7153

#line 7153
# Get attributes of file systems.
#line 7153
allow sshd_login_t fs_type:filesystem getattr;
#line 7153

#line 7153

#line 7153
# Read /.
#line 7153
allow sshd_login_t root_t:dir { read getattr lock search ioctl };
#line 7153
allow sshd_login_t root_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 7153

#line 7153
# Read /home.
#line 7153
allow sshd_login_t home_root_t:dir { read getattr lock search ioctl };
#line 7153

#line 7153
# Read /usr.
#line 7153
allow sshd_login_t usr_t:dir { read getattr lock search ioctl };
#line 7153
allow sshd_login_t usr_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 7153

#line 7153
# Read bin and sbin directories.
#line 7153
allow sshd_login_t bin_t:dir { read getattr lock search ioctl };
#line 7153
allow sshd_login_t bin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 7153
allow sshd_login_t sbin_t:dir { read getattr lock search ioctl };
#line 7153
allow sshd_login_t sbin_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 7153

#line 7153

#line 7153
# Read the devpts root directory.
#line 7153
allow sshd_login_t devpts_t:dir { read getattr lock search ioctl };
#line 7153

#line 7153
# Read /var.
#line 7153
allow sshd_login_t var_t:dir { read getattr lock search ioctl };
#line 7153
allow sshd_login_t var_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 7153

#line 7153
# Read /var/log.
#line 7153
allow sshd_login_t var_log_t:dir { read getattr lock search ioctl };
#line 7153
allow sshd_login_t var_log_t:{ file lnk_file } { read getattr lock ioctl };
#line 7153

#line 7153
# Read /etc.
#line 7153
allow sshd_login_t etc_t:dir { read getattr lock search ioctl };
#line 7153
allow sshd_login_t etc_t:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 7153
allow sshd_login_t etc_runtime_t:{ file lnk_file } { read getattr lock ioctl };
#line 7153
allow sshd_login_t resolv_conf_t:{ file lnk_file } { read getattr lock ioctl };
#line 7153

#line 7153
# Read the linker, shared library, and executable types.
#line 7153
allow sshd_login_t ld_so_t:{ file lnk_file } { read getattr lock ioctl };
#line 7153
allow sshd_login_t shlib_t:{ file lnk_file } { read getattr lock ioctl };
#line 7153
allow sshd_login_t exec_type:{ file lnk_file } { read getattr lock ioctl };
#line 7153

#line 7153
# Read /dev directories and any symbolic links.
#line 7153
allow sshd_login_t device_t:dir { read getattr lock search ioctl };
#line 7153
allow sshd_login_t device_t:lnk_file { read getattr lock ioctl };
#line 7153

#line 7153
# Read and write /dev/tty and /dev/null.
#line 7153
allow sshd_login_t devtty_t:chr_file { ioctl read getattr lock write append };
#line 7153
allow sshd_login_t { null_device_t zero_device_t }:chr_file { ioctl read getattr lock write append };
#line 7153

#line 7153
# Read /dev/random and /dev/zero.
#line 7153
allow sshd_login_t random_device_t:chr_file { read getattr lock ioctl };
#line 7153
#allow sshd_login_t zero_device_t:chr_file r_file_perms;
#line 7153

#line 7153
# Read PID files in /var/run.  pidfile is a type attribute for
#line 7153
# all types used for such files.
#line 7153
allow sshd_login_t pidfile:file { read getattr lock ioctl };
#line 7153

#line 7153

#line 7153
#allow sshd_login_t security_t:security { sid_to_context context_to_sid get_sids };
#line 7153
allow sshd_login_t security_t:security { sid_to_context context_to_sid };
#line 7153

#line 7153
#
#line 7153
# Allow the domain to create and use UDP and TCP sockets.
#line 7153
# Other kinds of sockets must be separately authorized for use.
#line 7153
allow sshd_login_t self:udp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 7153
allow sshd_login_t self:tcp_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 7153

#line 7153
#
#line 7153
# Allow the domain to send UDP packets.
#line 7153
# Since the destination sockets type is unknown, the generic
#line 7153
# any_socket_t type is used as a placeholder.
#line 7153
#
#line 7153
allow sshd_login_t any_socket_t:udp_socket sendto;
#line 7153

#line 7153
#
#line 7153
# Allow the domain to send using any network interface.
#line 7153
# netif_type is a type attribute for all network interface types.
#line 7153
#
#line 7153
allow sshd_login_t netif_type:netif { tcp_send udp_send rawip_send };
#line 7153

#line 7153
#
#line 7153
# Allow packets sent by the domain to be received on any network interface.
#line 7153
#
#line 7153
allow sshd_login_t netif_type:netif { tcp_recv udp_recv rawip_recv };
#line 7153

#line 7153
#
#line 7153
# Allow the domain to receive packets from any network interface.
#line 7153
# netmsg_type is a type attribute for all default message types.
#line 7153
#
#line 7153
allow sshd_login_t netmsg_type:{ udp_socket tcp_socket rawip_socket } recvfrom;
#line 7153

#line 7153
#
#line 7153
# Allow the domain to initiate or accept TCP connections 
#line 7153
# on any network interface.
#line 7153
#
#line 7153
allow sshd_login_t netmsg_type:tcp_socket { connectto acceptfrom };
#line 7153

#line 7153
#
#line 7153
# Receive resets from the TCP reset socket.
#line 7153
# The TCP reset socket is labeled with the tcp_socket_t type.
#line 7153
#
#line 7153
allow sshd_login_t tcp_socket_t:tcp_socket recvfrom;
#line 7153

#line 7153
dontaudit sshd_login_t tcp_socket_t:tcp_socket connectto;
#line 7153

#line 7153
#
#line 7153
# Allow the domain to send to any node.
#line 7153
# node_type is a type attribute for all node types.
#line 7153
#
#line 7153
allow sshd_login_t node_type:node { tcp_send udp_send rawip_send };
#line 7153

#line 7153
#
#line 7153
# Allow packets sent by the domain to be received from any node.
#line 7153
#
#line 7153
allow sshd_login_t node_type:node { tcp_recv udp_recv rawip_recv };
#line 7153

#line 7153
#
#line 7153
# Allow the domain to send NFS client requests via the socket
#line 7153
# created by mount.
#line 7153
#
#line 7153
allow sshd_login_t mount_t:udp_socket { ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 7153

#line 7153
#
#line 7153
# Bind to the default port type.
#line 7153
# Other port types must be separately authorized.
#line 7153
#
#line 7153
allow sshd_login_t port_t:udp_socket name_bind;
#line 7153
allow sshd_login_t port_t:tcp_socket name_bind;
#line 7153

#line 7153

#line 7153
allow sshd_login_t self:capability { chown dac_override fowner fsetid setgid setuid net_bind_service sys_tty_config };
#line 7153
allow sshd_login_t shadow_t:file { read getattr };
#line 7153
allow sshd_login_t { home_root_t user_home_dir_type sysadm_home_dir_t }:dir { search getattr };
#line 7153

#line 7153
# Run shells in user_t by default
#line 7153

#line 7153

#line 7153

#line 7153
#
#line 7153
# Allow the process to transition to the new domain.
#line 7153
#
#line 7153
allow sshd_login_t user_t:process transition;
#line 7153

#line 7153
#
#line 7153
# Allow the process to execute the program.
#line 7153
# 
#line 7153
allow sshd_login_t shell_exec_t:file { getattr execute };
#line 7153

#line 7153
#
#line 7153
# Allow the process to reap the new domain.
#line 7153
#
#line 7153
allow user_t sshd_login_t:process sigchld;
#line 7153

#line 7153
#
#line 7153
# Allow the new domain to inherit and use file 
#line 7153
# descriptions from the creating process and vice versa.
#line 7153
#
#line 7153
allow user_t sshd_login_t:fd use;
#line 7153
allow sshd_login_t user_t:fd use;
#line 7153

#line 7153
#
#line 7153
# Allow the new domain to write back to the old domain via a pipe.
#line 7153
#
#line 7153
allow user_t sshd_login_t:fifo_file { ioctl read getattr lock write append };
#line 7153

#line 7153
#
#line 7153
# Allow the new domain to read and execute the program.
#line 7153
#
#line 7153
allow user_t shell_exec_t:file { read getattr lock execute ioctl };
#line 7153

#line 7153
#
#line 7153
# Allow the new domain to be entered via the program.
#line 7153
#
#line 7153
allow user_t shell_exec_t:file entrypoint;
#line 7153

#line 7153
type_transition sshd_login_t shell_exec_t:process user_t;
#line 7153

#line 7153

#line 7153

#line 7153
#
#line 7153
# Allow the process to transition to the new domain.
#line 7153
#
#line 7153
allow sshd_login_t unpriv_userdomain:process transition;
#line 7153

#line 7153
#
#line 7153
# Allow the process to execute the program.
#line 7153
# 
#line 7153
allow sshd_login_t shell_exec_t:file { getattr execute };
#line 7153

#line 7153
#
#line 7153
# Allow the process to reap the new domain.
#line 7153
#
#line 7153
allow unpriv_userdomain sshd_login_t:process sigchld;
#line 7153

#line 7153
#
#line 7153
# Allow the new domain to inherit and use file 
#line 7153
# descriptions from the creating process and vice versa.
#line 7153
#
#line 7153
allow unpriv_userdomain sshd_login_t:fd use;
#line 7153
allow sshd_login_t unpriv_userdomain:fd use;
#line 7153

#line 7153
#
#line 7153
# Allow the new domain to write back to the old domain via a pipe.
#line 7153
#
#line 7153
allow unpriv_userdomain sshd_login_t:fifo_file { ioctl read getattr lock write append };
#line 7153

#line 7153
#
#line 7153
# Allow the new domain to read and execute the program.
#line 7153
#
#line 7153
allow unpriv_userdomain shell_exec_t:file { read getattr lock execute ioctl };
#line 7153

#line 7153
#
#line 7153
# Allow the new domain to be entered via the program.
#line 7153
#
#line 7153
allow unpriv_userdomain shell_exec_t:file entrypoint;
#line 7153

#line 7153

#line 7153
# Allow shells to be run in sysadm_t as well.
#line 7153
# Commented out.  Use newrole rather than directly entering sysadm_t.
#line 7153
#domain_trans(sshd_login_t, shell_exec_t, sysadm_t)
#line 7153

#line 7153
# Update utmp.
#line 7153
allow sshd_login_t initrc_var_run_t:file { ioctl read getattr lock write append };
#line 7153

#line 7153
# Update wtmp.
#line 7153
allow sshd_login_t wtmp_t:file { ioctl read getattr lock write append };
#line 7153

#line 7153
# Obtain the SID to use for relabeling ptys
#line 7153
allow sshd_login_t security_t:security change_sid;
#line 7153

#line 7153
# Allow read access to login context
#line 7153
allow sshd_login_t default_context_t:file { read getattr lock ioctl };
#line 7153

#line 7153
# Determine the set of legal user SIDs that can be reached.
#line 7153
allow sshd_login_t security_t:security get_user_sids;
#line 7153

#line 7153


type sshd_exec_t, file_type, exec_type, sysadmfile;

#line 7156

#line 7156

#line 7156
#
#line 7156
# Allow the process to transition to the new domain.
#line 7156
#
#line 7156
allow initrc_t sshd_t:process transition;
#line 7156

#line 7156
#
#line 7156
# Allow the process to execute the program.
#line 7156
# 
#line 7156
allow initrc_t sshd_exec_t:file { getattr execute };
#line 7156

#line 7156
#
#line 7156
# Allow the process to reap the new domain.
#line 7156
#
#line 7156
allow sshd_t initrc_t:process sigchld;
#line 7156

#line 7156
#
#line 7156
# Allow the new domain to inherit and use file 
#line 7156
# descriptions from the creating process and vice versa.
#line 7156
#
#line 7156
allow sshd_t initrc_t:fd use;
#line 7156
allow initrc_t sshd_t:fd use;
#line 7156

#line 7156
#
#line 7156
# Allow the new domain to write back to the old domain via a pipe.
#line 7156
#
#line 7156
allow sshd_t initrc_t:fifo_file { ioctl read getattr lock write append };
#line 7156

#line 7156
#
#line 7156
# Allow the new domain to read and execute the program.
#line 7156
#
#line 7156
allow sshd_t sshd_exec_t:file { read getattr lock execute ioctl };
#line 7156

#line 7156
#
#line 7156
# Allow the new domain to be entered via the program.
#line 7156
#
#line 7156
allow sshd_t sshd_exec_t:file entrypoint;
#line 7156

#line 7156
type_transition initrc_t sshd_exec_t:process sshd_t;
#line 7156

type sshd_key_t, file_type, sysadmfile;

# so a tunnel can point to another ssh tunnel...

#line 7160
allow sshd_t sshd_t:tcp_socket { connectto recvfrom };
#line 7160
allow sshd_t sshd_t:tcp_socket { acceptfrom recvfrom };
#line 7160
allow sshd_t tcp_socket_t:tcp_socket { recvfrom };
#line 7160
allow sshd_t tcp_socket_t:tcp_socket { recvfrom };
#line 7160


type sshd_tmp_t, file_type, sysadmfile, tmpfile;

#line 7163

#line 7163

#line 7163

#line 7163
#
#line 7163
# Allow the process to modify the directory.
#line 7163
#
#line 7163
allow sshd_t tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 7163

#line 7163
#
#line 7163
# Allow the process to create the file.
#line 7163
#
#line 7163

#line 7163
allow sshd_t sshd_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 7163
allow sshd_t sshd_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 7163

#line 7163

#line 7163

#line 7163
type_transition sshd_t tmp_t:dir sshd_tmp_t;
#line 7163
type_transition sshd_t tmp_t:{ file lnk_file sock_file fifo_file } sshd_tmp_t;
#line 7163

#line 7163

#line 7163


# Inherit and use descriptors from init.
allow sshd_t init_t:fd use;

# Can create ptys

#line 7169

#line 7169
type sshd_devpts_t, file_type, sysadmfile, ptyfile ;
#line 7169

#line 7169
# Allow the pty to be associated with the file system.
#line 7169
allow sshd_devpts_t devpts_t:filesystem associate;
#line 7169

#line 7169
# Access the pty master multiplexer.
#line 7169
allow sshd_t ptmx_t:chr_file { ioctl read getattr lock write append };
#line 7169

#line 7169
# Label pty files with a derived type.
#line 7169
type_transition sshd_t devpts_t:chr_file sshd_devpts_t;
#line 7169

#line 7169
# Read and write my pty files.
#line 7169
allow sshd_t sshd_devpts_t:chr_file { setattr { ioctl read getattr lock write append } };
#line 7169

#line 7169

#line 7169

#line 7169


# Execute Login

#line 7172

#line 7172

#line 7172
#
#line 7172
# Allow the process to transition to the new domain.
#line 7172
#
#line 7172
allow sshd_t sshd_login_t:process transition;
#line 7172

#line 7172
#
#line 7172
# Allow the process to execute the program.
#line 7172
# 
#line 7172
allow sshd_t login_exec_t:file { getattr execute };
#line 7172

#line 7172
#
#line 7172
# Allow the process to reap the new domain.
#line 7172
#
#line 7172
allow sshd_login_t sshd_t:process sigchld;
#line 7172

#line 7172
#
#line 7172
# Allow the new domain to inherit and use file 
#line 7172
# descriptions from the creating process and vice versa.
#line 7172
#
#line 7172
allow sshd_login_t sshd_t:fd use;
#line 7172
allow sshd_t sshd_login_t:fd use;
#line 7172

#line 7172
#
#line 7172
# Allow the new domain to write back to the old domain via a pipe.
#line 7172
#
#line 7172
allow sshd_login_t sshd_t:fifo_file { ioctl read getattr lock write append };
#line 7172

#line 7172
#
#line 7172
# Allow the new domain to read and execute the program.
#line 7172
#
#line 7172
allow sshd_login_t login_exec_t:file { read getattr lock execute ioctl };
#line 7172

#line 7172
#
#line 7172
# Allow the new domain to be entered via the program.
#line 7172
#
#line 7172
allow sshd_login_t login_exec_t:file entrypoint;
#line 7172

#line 7172
type_transition sshd_t login_exec_t:process sshd_login_t;
#line 7172


# Use capabilities.
allow sshd_t self:capability { sys_chroot sys_resource };

# Create /var/run/sshd.pid
type sshd_var_run_t, file_type, sysadmfile, pidfile;

#line 7179

#line 7179

#line 7179

#line 7179
#
#line 7179
# Allow the process to modify the directory.
#line 7179
#
#line 7179
allow sshd_t var_run_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 7179

#line 7179
#
#line 7179
# Allow the process to create the file.
#line 7179
#
#line 7179

#line 7179
allow sshd_t sshd_var_run_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 7179
allow sshd_t sshd_var_run_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 7179

#line 7179

#line 7179

#line 7179
type_transition sshd_t var_run_t:dir sshd_var_run_t;
#line 7179
type_transition sshd_t var_run_t:{ file lnk_file sock_file fifo_file } sshd_var_run_t;
#line 7179

#line 7179

#line 7179


# Access key files
allow sshd_t sshd_key_t:file { ioctl read getattr lock write append };

# Update /var/log/lastlog.
allow sshd_t lastlog_t:file { ioctl read getattr lock write append };



# Signal the user domains.
allow sshd_t unpriv_userdomain:process signal;

# Relabel and access ptys created by sshd
allow sshd_t sshd_devpts_t:chr_file { setattr getattr relabelfrom relabelto };
allow sshd_t userpty_type:chr_file { setattr relabelto { ioctl read getattr lock write append } };

#################################
#
# Rules for the sshd_login_t domain
#
# sshd_login_t is the domain of a login process
# spawned by sshd

# Use the pty created by sshd
allow sshd_login_t sshd_devpts_t:chr_file { setattr { ioctl read getattr lock write append } };
allow sshd_login_t ptyfile:chr_file { setattr { ioctl read getattr lock write append } };

# Write to /var/log/lastlog
allow sshd_login_t lastlog_t:file { ioctl read getattr lock write append };

# Relabel ptys created by sshd
allow sshd_login_t sshd_devpts_t:chr_file { relabelfrom relabelto };
allow sshd_login_t userpty_type:chr_file { getattr relabelfrom relabelto };

# read localization information
allow sshd_t locale_t:dir { read getattr lock search ioctl };
allow sshd_t locale_t:{file lnk_file} { read getattr lock ioctl };

# Allow checking user's mail at login
allow sshd_t mail_spool_t:dir search;
allow sshd_t mail_spool_t:lnk_file read;
allow sshd_t mail_spool_t:file getattr;
#
# Author:  Stephen Smalley <sds@epoch.ncsc.mil>
#

# Type for the ssh executable.
type ssh_exec_t, file_type, exec_type, sysadmfile;

allow sysadm_ssh_t user_home_dir_type:dir search;

#line 7230
allow sysadm_ssh_t user_home_ssh_t:dir { read getattr lock search ioctl };
#line 7230
allow sysadm_ssh_t user_home_ssh_t:{ file lnk_file } { read getattr lock ioctl };
#line 7230


# Everything else is in the ssh_domain macro in
# macros/program/ssh_macros.te.

allow sshd_t var_spool_t:file { execute getattr read };
allow sshd_t var_yp_t:dir { search };
allow sshd_t var_yp_t:file { read };

# added to run society using acme 
allow sshd_t nfs_t:dir { getattr search };
allow sshd_t nfs_t:file { getattr read };
allow sshd_t var_log_ksyms_t:file { lock write };


#DESC Su - Run shells with substitute user and group
#
# Domains for the su program.

#
# su_exec_t is the type of the su executable.
#
type su_exec_t, file_type, sysadmfile, exec_type;

allow sysadm_su_t user_home_dir_type:dir search;

# Everything else is in the su_domain macro in
# macros/program/su_macros.te.
#DESC Syslogd - System log daemon
#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
#

#################################
#
# Rules for the syslogd_t domain.
#
# syslogd_t is the domain of syslogd.
# syslogd_exec_t is the type of the syslogd executable.
# devlog_t is the type of the Unix domain socket created 
# by syslogd.
#
type syslogd_t, domain;
role system_r types syslogd_t;

#line 7274
allow syslogd_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 7274
allow syslogd_t ld_so_t:file { read getattr lock execute ioctl };
#line 7274
allow syslogd_t ld_so_t:file execute_no_trans;
#line 7274
allow syslogd_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 7274
allow syslogd_t shlib_t:file { read getattr lock execute ioctl };
#line 7274
allow syslogd_t shlib_t:lnk_file { read getattr lock ioctl };
#line 7274
allow syslogd_t ld_so_cache_t:file { read getattr lock ioctl };
#line 7274
allow syslogd_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 7274

type syslogd_exec_t, file_type, sysadmfile, exec_type;

#line 7276

#line 7276

#line 7276
#
#line 7276
# Allow the process to transition to the new domain.
#line 7276
#
#line 7276
allow initrc_t syslogd_t:process transition;
#line 7276

#line 7276
#
#line 7276
# Allow the process to execute the program.
#line 7276
# 
#line 7276
allow initrc_t syslogd_exec_t:file { getattr execute };
#line 7276

#line 7276
#
#line 7276
# Allow the process to reap the new domain.
#line 7276
#
#line 7276
allow syslogd_t initrc_t:process sigchld;
#line 7276

#line 7276
#
#line 7276
# Allow the new domain to inherit and use file 
#line 7276
# descriptions from the creating process and vice versa.
#line 7276
#
#line 7276
allow syslogd_t initrc_t:fd use;
#line 7276
allow initrc_t syslogd_t:fd use;
#line 7276

#line 7276
#
#line 7276
# Allow the new domain to write back to the old domain via a pipe.
#line 7276
#
#line 7276
allow syslogd_t initrc_t:fifo_file { ioctl read getattr lock write append };
#line 7276

#line 7276
#
#line 7276
# Allow the new domain to read and execute the program.
#line 7276
#
#line 7276
allow syslogd_t syslogd_exec_t:file { read getattr lock execute ioctl };
#line 7276

#line 7276
#
#line 7276
# Allow the new domain to be entered via the program.
#line 7276
#
#line 7276
allow syslogd_t syslogd_exec_t:file entrypoint;
#line 7276

#line 7276
type_transition initrc_t syslogd_exec_t:process syslogd_t;
#line 7276

type devlog_t, file_type, sysadmfile;
allow syslogd_t self:process { fork signal };

# if something can log to syslog they should be able to log to the console
allow privlog console_device_t:chr_file { ioctl read write getattr };

type syslogd_tmp_t, file_type, sysadmfile, tmpfile;

#line 7284

#line 7284

#line 7284

#line 7284
#
#line 7284
# Allow the process to modify the directory.
#line 7284
#
#line 7284
allow syslogd_t tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 7284

#line 7284
#
#line 7284
# Allow the process to create the file.
#line 7284
#
#line 7284

#line 7284
allow syslogd_t syslogd_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 7284
allow syslogd_t syslogd_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 7284

#line 7284

#line 7284

#line 7284
type_transition syslogd_t tmp_t:dir syslogd_tmp_t;
#line 7284
type_transition syslogd_t tmp_t:{ file lnk_file sock_file fifo_file } syslogd_tmp_t;
#line 7284

#line 7284

#line 7284

type syslogd_var_run_t, file_type, sysadmfile, pidfile;

#line 7286

#line 7286

#line 7286

#line 7286
#
#line 7286
# Allow the process to modify the directory.
#line 7286
#
#line 7286
allow syslogd_t var_run_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 7286

#line 7286
#
#line 7286
# Allow the process to create the file.
#line 7286
#
#line 7286

#line 7286
allow syslogd_t syslogd_var_run_t:file { create ioctl read getattr lock write setattr append link unlink rename };
#line 7286

#line 7286

#line 7286

#line 7286
type_transition syslogd_t var_run_t:file syslogd_var_run_t;
#line 7286

#line 7286

#line 7286

allow syslogd_t var_t:dir { read getattr lock search ioctl };

# read files in /etc
allow syslogd_t etc_t:file { read getattr lock ioctl };
allow syslogd_t resolv_conf_t:{ file lnk_file } { read getattr lock ioctl };

# read localization information
allow syslogd_t locale_t:dir { read getattr lock search ioctl };
allow syslogd_t locale_t:{file lnk_file} { read getattr lock ioctl };

# Use capabilities.
allow syslogd_t syslogd_t:capability { net_bind_service dac_override };

# Inherit and use descriptors from init.
allow syslogd_t init_t:fd use;
allow syslogd_t { initrc_devpts_t console_device_t }:chr_file { read write };

# Modify/create log files.

#line 7305
allow syslogd_t var_log_t:dir { read getattr search add_name write };
#line 7305
allow syslogd_t var_log_t:file { create ioctl getattr setattr append link };
#line 7305


# Create and bind to /dev/log or /var/run/log.

#line 7308

#line 7308

#line 7308

#line 7308
#
#line 7308
# Allow the process to modify the directory.
#line 7308
#
#line 7308
allow syslogd_t { device_t var_run_t }:dir { read getattr lock search ioctl add_name remove_name write };
#line 7308

#line 7308
#
#line 7308
# Allow the process to create the file.
#line 7308
#
#line 7308

#line 7308
allow syslogd_t devlog_t:sock_file { create ioctl read getattr lock write setattr append link unlink rename };
#line 7308

#line 7308

#line 7308

#line 7308
type_transition syslogd_t { device_t var_run_t }:sock_file devlog_t;
#line 7308

#line 7308

#line 7308

allow syslogd_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
allow syslogd_t self:unix_dgram_socket { sendto };
allow syslogd_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
allow syslogd_t self:unix_stream_socket { listen accept };
allow syslogd_t devlog_t:unix_stream_socket name_bind;
allow syslogd_t devlog_t:unix_dgram_socket name_bind;

# Domains with the privlog attribute may log to syslogd.
allow privlog devlog_t:sock_file { ioctl read getattr lock write append };

#line 7318
allow privlog syslogd_t:unix_dgram_socket sendto;
#line 7318


#line 7319
allow privlog syslogd_t:unix_stream_socket connectto;
#line 7319

# allow /dev/log to be a link elsewhere for chroot setup
allow privlog devlog_t:lnk_file read;

# Write to the cron log.
allow syslogd_t cron_log_t:file { ioctl read getattr lock write append };

# Added by Us
allow syslogd_t any_socket_t:udp_socket { sendto };
allow syslogd_t netif_eth0_t:netif { udp_send };
allow syslogd_t netif_lo_t:netif { udp_recv udp_send };
allow syslogd_t netmsg_eth0_t:udp_socket { recvfrom };
allow syslogd_t node_lo_t:node { udp_recv udp_send };
allow syslogd_t node_t:node { udp_send };
allow syslogd_t port_t:udp_socket { name_bind };
allow syslogd_t syslogd_t:udp_socket { bind connect create read setopt write };
allow syslogd_t var_spool_t:file { execute getattr read };
allow syslogd_t var_yp_t:dir { search };


#DESC Tmpreaper - Monitor and maintain temporary files
#
# Author:  Russell Coker <russell@coker.com.au>
#

#################################
#
# Rules for the tmpreaper_t domain.
#
type tmpreaper_t, domain, privlog;
type tmpreaper_exec_t, file_type, sysadmfile, exec_type;

role system_r types tmpreaper_t;


#line 7353

#line 7353

#line 7353
#
#line 7353
# Allow the process to transition to the new domain.
#line 7353
#
#line 7353
allow system_crond_t tmpreaper_t:process transition;
#line 7353

#line 7353
#
#line 7353
# Allow the process to execute the program.
#line 7353
# 
#line 7353
allow system_crond_t tmpreaper_exec_t:file { getattr execute };
#line 7353

#line 7353
#
#line 7353
# Allow the process to reap the new domain.
#line 7353
#
#line 7353
allow tmpreaper_t system_crond_t:process sigchld;
#line 7353

#line 7353
#
#line 7353
# Allow the new domain to inherit and use file 
#line 7353
# descriptions from the creating process and vice versa.
#line 7353
#
#line 7353
allow tmpreaper_t system_crond_t:fd use;
#line 7353
allow system_crond_t tmpreaper_t:fd use;
#line 7353

#line 7353
#
#line 7353
# Allow the new domain to write back to the old domain via a pipe.
#line 7353
#
#line 7353
allow tmpreaper_t system_crond_t:fifo_file { ioctl read getattr lock write append };
#line 7353

#line 7353
#
#line 7353
# Allow the new domain to read and execute the program.
#line 7353
#
#line 7353
allow tmpreaper_t tmpreaper_exec_t:file { read getattr lock execute ioctl };
#line 7353

#line 7353
#
#line 7353
# Allow the new domain to be entered via the program.
#line 7353
#
#line 7353
allow tmpreaper_t tmpreaper_exec_t:file entrypoint;
#line 7353

#line 7353
type_transition system_crond_t tmpreaper_exec_t:process tmpreaper_t;
#line 7353


#line 7354
allow tmpreaper_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 7354
allow tmpreaper_t ld_so_t:file { read getattr lock execute ioctl };
#line 7354
allow tmpreaper_t ld_so_t:file execute_no_trans;
#line 7354
allow tmpreaper_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 7354
allow tmpreaper_t shlib_t:file { read getattr lock execute ioctl };
#line 7354
allow tmpreaper_t shlib_t:lnk_file { read getattr lock ioctl };
#line 7354
allow tmpreaper_t ld_so_cache_t:file { read getattr lock ioctl };
#line 7354
allow tmpreaper_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 7354

allow tmpreaper_t crond_t:fd use;
allow tmpreaper_t crond_t:fifo_file { read write };
allow tmpreaper_t tmpfile:dir { { read getattr lock search ioctl add_name remove_name write } rmdir };
allow tmpreaper_t tmpfile:{ file lnk_file sock_file fifo_file } { getattr unlink };
allow tmpreaper_t home_type:{ file lnk_file sock_file fifo_file } { getattr unlink };
allow tmpreaper_t self:process { fork sigchld };
allow tmpreaper_t self:capability { dac_override dac_read_search fowner };
allow tmpreaper_t fs_t:filesystem getattr;


#line 7364
allow tmpreaper_t etc_t:dir { read getattr lock search ioctl };
#line 7364
allow tmpreaper_t etc_t:{ file lnk_file } { read getattr lock ioctl };
#line 7364

allow tmpreaper_t var_t:dir { getattr search };

#line 7366
allow tmpreaper_t var_lib_t:dir { read getattr lock search ioctl };
#line 7366
allow tmpreaper_t var_lib_t:{ file lnk_file } { read getattr lock ioctl };
#line 7366

allow tmpreaper_t device_t:dir { getattr search };

#line 7372

#DESC Useradd - Manage system user accounts
#
# Authors:  Chris Vance <cvance@tislabs.com>
#

#################################
#
# Rules for the useradd_t domain.
#
# useradd_t is the domain of the useradd/userdel programs when
# executed through the suseradd/suserdel wrapper.
#
type useradd_t, domain, privlog, auth, privowner;
role sysadm_r types useradd_t;


#line 7388
# Access other processes in the same domain.
#line 7388
allow useradd_t self:process *;
#line 7388

#line 7388
# Access /proc/PID files for processes in the same domain.
#line 7388
allow useradd_t self:dir { read getattr lock search ioctl };
#line 7388
allow useradd_t self:{ file lnk_file sock_file fifo_file } { read getattr lock ioctl };
#line 7388

#line 7388
# Access file descriptions, pipes, and sockets
#line 7388
# created by processes in the same domain.
#line 7388
allow useradd_t self:fd *;
#line 7388
allow useradd_t self:fifo_file { ioctl read getattr lock write append };
#line 7388
allow useradd_t self:unix_dgram_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown };
#line 7388
allow useradd_t self:unix_stream_socket { create ioctl read getattr write setattr append bind connect getopt setopt shutdown listen accept };
#line 7388

#line 7388
# Allow the domain to communicate with other processes in the same domain.
#line 7388
allow useradd_t self:unix_dgram_socket sendto;
#line 7388
allow useradd_t self:unix_stream_socket connectto;
#line 7388

#line 7388
# Access System V IPC objects created by processes in the same domain.
#line 7388
allow useradd_t self:sem  { associate getattr setattr create destroy read write unix_read unix_write };
#line 7388
allow useradd_t self:msg  { send receive };
#line 7388
allow useradd_t self:msgq { associate getattr setattr create destroy read write enqueue unix_read unix_write };
#line 7388
allow useradd_t self:shm  { associate getattr setattr create destroy read write lock unix_read unix_write };
#line 7388

#line 7388
;


#line 7390
allow useradd_t { root_t usr_t lib_t etc_t }:dir { read getattr lock search ioctl };
#line 7390
allow useradd_t ld_so_t:file { read getattr lock execute ioctl };
#line 7390
allow useradd_t ld_so_t:file execute_no_trans;
#line 7390
allow useradd_t ld_so_t:lnk_file { read getattr lock ioctl };
#line 7390
allow useradd_t shlib_t:file { read getattr lock execute ioctl };
#line 7390
allow useradd_t shlib_t:lnk_file { read getattr lock ioctl };
#line 7390
allow useradd_t ld_so_cache_t:file { read getattr lock ioctl };
#line 7390
allow useradd_t null_device_t:chr_file { ioctl read getattr lock write append };
#line 7390
;

type useradd_exec_t, file_type, sysadmfile, exec_type;

#line 7393

#line 7393

#line 7393
#
#line 7393
# Allow the process to transition to the new domain.
#line 7393
#
#line 7393
allow sysadm_t useradd_t:process transition;
#line 7393

#line 7393
#
#line 7393
# Allow the process to execute the program.
#line 7393
# 
#line 7393
allow sysadm_t useradd_exec_t:file { getattr execute };
#line 7393

#line 7393
#
#line 7393
# Allow the process to reap the new domain.
#line 7393
#
#line 7393
allow useradd_t sysadm_t:process sigchld;
#line 7393

#line 7393
#
#line 7393
# Allow the new domain to inherit and use file 
#line 7393
# descriptions from the creating process and vice versa.
#line 7393
#
#line 7393
allow useradd_t sysadm_t:fd use;
#line 7393
allow sysadm_t useradd_t:fd use;
#line 7393

#line 7393
#
#line 7393
# Allow the new domain to write back to the old domain via a pipe.
#line 7393
#
#line 7393
allow useradd_t sysadm_t:fifo_file { ioctl read getattr lock write append };
#line 7393

#line 7393
#
#line 7393
# Allow the new domain to read and execute the program.
#line 7393
#
#line 7393
allow useradd_t useradd_exec_t:file { read getattr lock execute ioctl };
#line 7393

#line 7393
#
#line 7393
# Allow the new domain to be entered via the program.
#line 7393
#
#line 7393
allow useradd_t useradd_exec_t:file entrypoint;
#line 7393

#line 7393
type_transition sysadm_t useradd_exec_t:process useradd_t;
#line 7393


# Add/remove user home directories

#line 7396

#line 7396

#line 7396

#line 7396
#
#line 7396
# Allow the process to modify the directory.
#line 7396
#
#line 7396
allow useradd_t home_root_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 7396

#line 7396
#
#line 7396
# Allow the process to create the file.
#line 7396
#
#line 7396

#line 7396
allow useradd_t user_home_dir_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 7396
allow useradd_t user_home_dir_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 7396

#line 7396

#line 7396

#line 7396
type_transition useradd_t home_root_t:dir user_home_dir_t;
#line 7396
type_transition useradd_t home_root_t:{ file lnk_file sock_file fifo_file } user_home_dir_t;
#line 7396

#line 7396

#line 7396


#line 7397

#line 7397

#line 7397

#line 7397
#
#line 7397
# Allow the process to modify the directory.
#line 7397
#
#line 7397
allow useradd_t user_home_dir_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 7397

#line 7397
#
#line 7397
# Allow the process to create the file.
#line 7397
#
#line 7397

#line 7397
allow useradd_t user_home_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 7397
allow useradd_t user_home_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 7397

#line 7397

#line 7397

#line 7397
type_transition useradd_t user_home_dir_t:dir user_home_t;
#line 7397
type_transition useradd_t user_home_dir_t:{ file lnk_file sock_file fifo_file } user_home_t;
#line 7397

#line 7397

#line 7397


# create mail spool file in /var/mail
allow useradd_t mail_spool_t:dir {search write add_name remove_name};
allow useradd_t mail_spool_t:file {create setattr getattr unlink};
# /var/mail is a link to /var/spool/mail
allow useradd_t mail_spool_t:lnk_file {read};

# Use capabilities.
allow useradd_t useradd_t:capability { fowner chown dac_override fsetid setuid sys_resource };

# Allow access to context for shadow file
allow useradd_t security_t:security { context_to_sid };

# Inherit and use descriptors from login.
allow useradd_t privfd:fd use;

# Execute /usr/bin/{passwd,chfn,chsh} and /usr/sbin/{useradd,vipw}.
allow useradd_t { bin_t sbin_t }:dir { read getattr lock search ioctl };

#line 7416
allow useradd_t { bin_t sbin_t shell_exec_t }:file { { read getattr lock execute ioctl } execute_no_trans };
#line 7416


# allow checking if a shell is executable
allow useradd_t shell_exec_t:file execute;

# Update /etc/shadow and /etc/passwd

#line 7422

#line 7422

#line 7422

#line 7422
#
#line 7422
# Allow the process to modify the directory.
#line 7422
#
#line 7422
allow useradd_t etc_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 7422

#line 7422
#
#line 7422
# Allow the process to create the file.
#line 7422
#
#line 7422

#line 7422
allow useradd_t shadow_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 7422
allow useradd_t shadow_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 7422

#line 7422

#line 7422

#line 7422
type_transition useradd_t etc_t:dir shadow_t;
#line 7422
type_transition useradd_t etc_t:{ file lnk_file sock_file fifo_file } shadow_t;
#line 7422

#line 7422

#line 7422

allow useradd_t etc_t:file { create ioctl read getattr lock write setattr append link unlink rename };

allow useradd_t { etc_t shadow_t }:file { relabelfrom relabelto };

# allow vipw to create temporary files under /var/tmp/vi.recover

#line 7428
type useradd_tmp_t, file_type, sysadmfile, tmpfile ;
#line 7428

#line 7428

#line 7428

#line 7428

#line 7428
#
#line 7428
# Allow the process to modify the directory.
#line 7428
#
#line 7428
allow useradd_t tmp_t:dir { read getattr lock search ioctl add_name remove_name write };
#line 7428

#line 7428
#
#line 7428
# Allow the process to create the file.
#line 7428
#
#line 7428

#line 7428
allow useradd_t useradd_tmp_t:{ file lnk_file sock_file fifo_file } { create ioctl read getattr lock write setattr append link unlink rename };
#line 7428
allow useradd_t useradd_tmp_t:dir { create read getattr lock setattr link unlink rename search add_name remove_name reparent write rmdir };
#line 7428

#line 7428

#line 7428

#line 7428
type_transition useradd_t tmp_t:dir useradd_tmp_t;
#line 7428
type_transition useradd_t tmp_t:{ file lnk_file sock_file fifo_file } useradd_tmp_t;
#line 7428

#line 7428

#line 7428

#line 7428


# /usr/bin/userdel locks the user being deleted, allow write access to utmp
allow useradd_t initrc_var_run_t:file { write };

# useradd/userdel request read/write for /var/log/lastlog, and read of /dev, 
# but will operate without them.
dontaudit useradd_t { device_t var_t }:dir { search };

# Access terminals.
allow useradd_t ttyfile:chr_file { ioctl read getattr lock write append };
allow useradd_t ptyfile:chr_file { ioctl read getattr lock write append };

#DESC Xauth - X authority file utility
#
# Domains for the xauth program.

# Author: Russell Coker <russell@coker.com.au>
#
# xauth_exec_t is the type of the xauth executable.
#
type xauth_exec_t, file_type, sysadmfile, exec_type;

# Everything else is in the xauth_domain macro in
# macros/program/xauth_macros.te.
##############################
#
# Assertions for the type enforcement (TE) configuration.
#

#
# Authors:  Stephen Smalley <sds@epoch.ncsc.mil> and Timothy Fraser  
#

##################################
#
# Access vector assertions.
#
# An access vector assertion specifies permissions that should not be in
# an access vector based on a source type, a target type, and a class.
# If any of the specified permissions are in the corresponding access
# vector, then the policy compiler will reject the policy configuration.
# Currently, there is only one kind of access vector assertion, neverallow, 
# but support for the other kinds of vectors could be easily added.  Access 
# vector assertions use the same syntax as access vector rules.
#

#
# Verify that every type that can be entered by
# a domain is also tagged as a domain.
#
neverallow domain ~domain:process transition;

#
# Verify that only the insmod_t, ifconfig_t, and kernel_t domains 
# have the sys_module capability.
#
neverallow ~{ insmod_t ifconfig_t kernel_t } self:capability sys_module;

#
# Verify that executable types, the system dynamic loaders, and the
# system shared libraries can only be modified by administrators.
#
neverallow ~{ldconfig_t admin} { exec_type ld_so_t shlib_t }:file { write append unlink rename };

#
# Verify that other system software can only be modified by administrators.
#
neverallow ~{ldconfig_t admin} { lib_t bin_t sbin_t }:dir { add_name remove_name rename };
neverallow ~admin { lib_t bin_t sbin_t }:file { write append unlink rename };

#
# Verify that only certain domains have access to the raw disk devices.
#
neverallow ~{  fsadm_t mount_t } fixed_disk_device_t:{ chr_file blk_file } { read write append };

#
# Verify that only the X server and klogd have access to memory devices.
#
neverallow ~privmem memory_device_t:{ chr_file blk_file } { read write append };

#
# Verify that /proc/kmsg is only accessible to klogd.
#
neverallow ~klogd_t proc_kmsg_t:file ~{ getattr };

#
# Verify that /proc/kcore is inaccessible.
#
neverallow * proc_kcore_t:file ~{ getattr };

#
# Verify that sysctl variables are only changeable
# by initrc and administrators.
#
neverallow ~{ initrc_t admin kernel_t insmod_t } sysctl_t:file { write append };
neverallow ~{ initrc_t admin } sysctl_fs_t:file { write append };
neverallow ~{ init_t initrc_t admin kernel_t insmod_t } sysctl_kernel_t:file { write append };
neverallow ~{ initrc_t admin } sysctl_net_t:file { write append };
neverallow ~{ initrc_t admin } sysctl_net_unix_t:file { write append };
neverallow ~{ initrc_t admin } sysctl_vm_t:file { write append };
neverallow ~{ initrc_t admin } sysctl_dev_t:file { write append };
neverallow ~{ initrc_t admin } sysctl_modprobe_t:file { write append };

#
# Verify that certain domains are limited to only being
# entered by their entrypoint types and to only executing
# the dynamic loader without a transition to another domain.
#

#line 7542



#line 7544
    neverallow getty_t ~getty_exec_t:file entrypoint; neverallow getty_t ~{ getty_exec_t ld_so_t }:file execute_no_trans;

#line 7545
    neverallow klogd_t ~klogd_exec_t:file entrypoint; neverallow klogd_t ~{ klogd_exec_t ld_so_t }:file execute_no_trans;




#line 7549
    neverallow syslogd_t ~syslogd_exec_t:file entrypoint; neverallow syslogd_t ~{ syslogd_exec_t ld_so_t }:file execute_no_trans;






#line 7559

#line 7559
neverallow { local_login_t remote_login_t } ~login_exec_t:file entrypoint;
#line 7559
neverallow { local_login_t remote_login_t } ~ld_so_t:file execute_no_trans;
#line 7559


#
# Verify that the passwd domain can only be entered by its
# entrypoint type and can only execute the dynamic loader
# and the ordinary passwd program without a transition to another domain.
#
#line 7568
neverallow passwd_t ~{ admin_passwd_exec_t passwd_exec_t }:file entrypoint;
#line 7568
neverallow passwd_t ~{ bin_t sbin_t shell_exec_t ld_so_t passwd_real_exec_t }:file execute_no_trans;

#
# Verify that only the admin domains and initrc_t have avc_toggle.
#
neverallow ~{ admin initrc_t } kernel_t:system avc_toggle;
#line 1 "rbac"
################################################
#
# Role-based access control (RBAC) configuration.
#

#line 9

#line 13

#line 15

########################################
#
# Role allow rules.
#
# A role allow rule specifies the allowable
# transitions between roles on an execve.
# If no rule is specified, then the change in
# roles will not be permitted.  Additional
# controls over role transitions based on the
# type of the process may be specified through
# the constraints file.
#
# The syntax of a role allow rule is:
# 	allow current_role new_role ;
#

#
# Allow the system_r role to transition 
# into the sysadm_r role.
#
allow system_r sysadm_r;

#
# Allow the user and admin role to transition to httpd_admin_r
#
#line 43


# 
# Allow the admin role to transition to the system
# role for run_init.
#
allow sysadm_r system_r;



