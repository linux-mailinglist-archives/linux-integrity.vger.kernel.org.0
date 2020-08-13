Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78F15243BEF
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Aug 2020 16:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgHMOuB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Aug 2020 10:50:01 -0400
Received: from smtp-42aa.mail.infomaniak.ch ([84.16.66.170]:47413 "EHLO
        smtp-42aa.mail.infomaniak.ch" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726574AbgHMOtt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Aug 2020 10:49:49 -0400
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4BS8bZ2pDnzlhdFf;
        Thu, 13 Aug 2020 16:49:14 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [94.23.54.103])
        by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4BS8bX057hzlh8TN;
        Thu, 13 Aug 2020 16:49:11 +0200 (CEST)
Subject: Re: [PATCH v7 5/7] fs,doc: Enable to enforce noexec mounts or file
 exec through O_MAYEXEC
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, Aleksa Sarai <cyphar@cyphar.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Christian Heimes <christian@python.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Deven Bowers <deven.desai@linux.microsoft.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Eric Chiang <ericchiang@google.com>,
        Florian Weimer <fweimer@redhat.com>,
        James Morris <jmorris@namei.org>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Matthew Garrett <mjg59@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        =?UTF-8?Q?Philippe_Tr=c3=a9buchet?= 
        <philippe.trebuchet@ssi.gouv.fr>,
        Scott Shell <scottsh@microsoft.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Steve Dower <steve.dower@python.org>,
        Steve Grubb <sgrubb@redhat.com>,
        Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
        Thibaut Sautereau <thibaut.sautereau@clip-os.org>,
        Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
        kernel-hardening@lists.openwall.com, linux-api@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20200723171227.446711-1-mic@digikod.net>
 <20200723171227.446711-6-mic@digikod.net>
 <87364tkl99.fsf@x220.int.ebiederm.org>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <79e4d55f-a80b-5361-e18d-d8fa67ae640b@digikod.net>
Date:   Thu, 13 Aug 2020 16:49:11 +0200
User-Agent: 
MIME-Version: 1.0
In-Reply-To: <87364tkl99.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Antivirus: Dr.Web (R) for Unix mail servers drweb plugin ver.6.0.2.8
X-Antivirus-Code: 0x100000
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 11/08/2020 21:58, Eric W. Biederman wrote:
> Mickaël Salaün <mic@digikod.net> writes:
> 
>> Allow for the enforcement of the O_MAYEXEC openat2(2) flag.  Thanks to
>> the noexec option from the underlying VFS mount, or to the file execute
>> permission, userspace can enforce these execution policies.  This may
>> allow script interpreters to check execution permission before reading
>> commands from a file, or dynamic linkers to allow shared object
>> loading.
> 
> Ick!!!!!
> 
> This feels like being so open minded your brains fall out.

Really? :)

> 
> I can see having a sysctl that allows the new open flag to be ignored
> so that the existing lack of enforcement when the flag is passed
> continues.

And that could break distros (i.e. multiple interpreters, with or
without O_MAYEXEC, different versions, and different kernels).

> 
> But having the sysctl be fine grained seems like way too much rope.

This follow the same rational: file permissions and mount options can
change but they are controled by the sysadmin, how also configure sysctl
values.

> 
> I don't think the code needs to do more than enforce or not enforce this
> logic.

I think this is the more viable behavior for an eclectic set of distros
(and different use cases).

> 
> You can test the sysctl once when you process O_MAYEXEC.  But code such
> as may_open should not have the conditional behavior.  It should get an
> appropriate set of flags that are always enforced.  With the madness of
> what to do left at the edge of userspace.

The problem is that this userspace is not in charge of the system-wide
policy, the sysadmin is. As pointed out by the commit message, please
take a look at the rational:
https://lore.kernel.org/lkml/1477d3d7-4b36-afad-7077-a38f42322238@digikod.net/

> 
> Anything else appears to be madness, overengineering, and a failure to
> separate concerns.

Oh! What a conclusion! :)

I'd say it is a pragmatic approach.

> 
> Eric
> 
> 
>> Add a new sysctl fs.open_mayexec_enforce to enable system administrators
>> to enforce two complementary security policies according to the
>> installed system: enforce the noexec mount option, and enforce
>> executable file permission.  Indeed, because of compatibility with
>> installed systems, only system administrators are able to check that
>> this new enforcement is in line with the system mount points and file
>> permissions.  A following patch adds documentation.
>>
>> Being able to restrict execution also enables to protect the kernel by
>> restricting arbitrary syscalls that an attacker could perform with a
>> crafted binary or certain script languages.  It also improves multilevel
>> isolation by reducing the ability of an attacker to use side channels
>> with specific code.  These restrictions can natively be enforced for ELF
>> binaries (with the noexec mount option) but require this kernel
>> extension to properly handle scripts (e.g., Python, Perl).  To get a
>> consistent execution policy, additional memory restrictions should also
>> be enforced (e.g. thanks to SELinux).
>>
>> Because the O_MAYEXEC flag is a meant to enforce a system-wide security
>> policy (but not application-centric policies), it does not make sense
>> for userland to check the sysctl value.  Indeed, this new flag only
>> enables to extend the system ability to enforce a policy thanks to (some
>> trusted) userland collaboration.  Moreover, additional security policies
>> could be managed by LSMs.  This is a best-effort approach from the
>> application developer point of view:
>> https://lore.kernel.org/lkml/1477d3d7-4b36-afad-7077-a38f42322238@digikod.net/
>>
>> Signed-off-by: Mickaël Salaün <mic@digikod.net>
>> Reviewed-by: Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>
>> Cc: Aleksa Sarai <cyphar@cyphar.com>
>> Cc: Al Viro <viro@zeniv.linux.org.uk>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: Kees Cook <keescook@chromium.org>
>> Cc: Randy Dunlap <rdunlap@infradead.org>
>> ---
>>
>> Changes since v6:
>> * Allow opening pipes, block devices and character devices with
>>   O_MAYEXEC when there is no enforced policy, but forbid any non-regular
>>   file opened with O_MAYEXEC otherwise (i.e. for any enforced policy).
>> * Add a paragraph about the non-regular files policy.
>> * Move path_noexec() calls out of the fast-path (suggested by Kees
>>   Cook).
>>
>> Changes since v5:
>> * Remove the static enforcement configuration through Kconfig because it
>>   makes the code more simple like this, and because the current sysctl
>>   configuration can only be set with CAP_SYS_ADMIN, the same way mount
>>   options (i.e. noexec) can be set.  If an harden distro wants to
>>   enforce a configuration, it should restrict capabilities or sysctl
>>   configuration.  Furthermore, an LSM can easily leverage O_MAYEXEC to
>>   fit its need.
>> * Move checks from inode_permission() to may_open() and make the error
>>   codes more consistent according to file types (in line with a previous
>>   commit): opening a directory with O_MAYEXEC returns EISDIR and other
>>   non-regular file types may return EACCES.
>> * In may_open(), when OMAYEXEC_ENFORCE_FILE is set, replace explicit
>>   call to generic_permission() with an artificial MAY_EXEC to avoid
>>   double calls.  This makes sense especially when an LSM policy forbids
>>   execution of a file.
>> * Replace the custom proc_omayexec() with
>>   proc_dointvec_minmax_sysadmin(), and then replace the CAP_MAC_ADMIN
>>   check with a CAP_SYS_ADMIN one (suggested by Kees Cook and Stephen
>>   Smalley).
>> * Use BIT() (suggested by Kees Cook).
>> * Rename variables (suggested by Kees Cook).
>> * Reword the kconfig help.
>> * Import the documentation patch (suggested by Kees Cook):
>>   https://lore.kernel.org/lkml/20200505153156.925111-6-mic@digikod.net/
>> * Update documentation and add LWN.net article.
>>
>> Changes since v4:
>> * Add kernel configuration options to enforce O_MAYEXEC at build time,
>>   and disable the sysctl in such case (requested by James Morris).
>> * Reword commit message.
>>
>> Changes since v3:
>> * Update comment with O_MAYEXEC.
>>
>> Changes since v2:
>> * Cosmetic changes.
>>
>> Changes since v1:
>> * Move code from Yama to the FS subsystem (suggested by Kees Cook).
>> * Make omayexec_inode_permission() static (suggested by Jann Horn).
>> * Use mode 0600 for the sysctl.
>> * Only match regular files (not directories nor other types), which
>>   follows the same semantic as commit 73601ea5b7b1 ("fs/open.c: allow
>>   opening only regular files during execve()").
>> ---
>>  Documentation/admin-guide/sysctl/fs.rst | 49 +++++++++++++++++++++++++
>>  fs/namei.c                              | 24 ++++++++++++
>>  include/linux/fs.h                      |  1 +
>>  kernel/sysctl.c                         | 12 +++++-
>>  4 files changed, 84 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/admin-guide/sysctl/fs.rst b/Documentation/admin-guide/sysctl/fs.rst
>> index 2a45119e3331..ce6e2081d3a9 100644
>> --- a/Documentation/admin-guide/sysctl/fs.rst
>> +++ b/Documentation/admin-guide/sysctl/fs.rst
>> @@ -37,6 +37,7 @@ Currently, these files are in /proc/sys/fs:
>>  - inode-nr
>>  - inode-state
>>  - nr_open
>> +- open_mayexec_enforce
>>  - overflowuid
>>  - overflowgid
>>  - pipe-user-pages-hard
>> @@ -165,6 +166,54 @@ system needs to prune the inode list instead of allocating
>>  more.
>>  
>>  
>> +open_mayexec_enforce
>> +--------------------
>> +
>> +While being ignored by :manpage:`open(2)` and :manpage:`openat(2)`, the
>> +``O_MAYEXEC`` flag can be passed to :manpage:`openat2(2)` to only open regular
>> +files that are expected to be executable.  If the file is not identified as
>> +executable, then the syscall returns -EACCES.  This may allow a script
>> +interpreter to check executable permission before reading commands from a file,
>> +or a dynamic linker to only load executable shared objects.  One interesting
>> +use case is to enforce a "write xor execute" policy through interpreters.
>> +
>> +The ability to restrict code execution must be thought as a system-wide policy,
>> +which first starts by restricting mount points with the ``noexec`` option.
>> +This option is also automatically applied to special filesystems such as /proc .
>> +This prevents files on such mount points to be directly executed by the kernel
>> +or mapped as executable memory (e.g. libraries).  With script interpreters
>> +using the ``O_MAYEXEC`` flag, the executable permission can then be checked
>> +before reading commands from files. This makes it possible to enforce the
>> +``noexec`` at the interpreter level, and thus propagates this security policy
>> +to scripts.  To be fully effective, these interpreters also need to handle the
>> +other ways to execute code: command line parameters (e.g., option ``-e`` for
>> +Perl), module loading (e.g., option ``-m`` for Python), stdin, file sourcing,
>> +environment variables, configuration files, etc.  According to the threat
>> +model, it may be acceptable to allow some script interpreters (e.g. Bash) to
>> +interpret commands from stdin, may it be a TTY or a pipe, because it may not be
>> +enough to (directly) perform syscalls.
>> +
>> +There are two complementary security policies: enforce the ``noexec`` mount
>> +option, and enforce executable file permission.  These policies are handled by
>> +the ``fs.open_mayexec_enforce`` sysctl (writable only with ``CAP_SYS_ADMIN``)
>> +as a bitmask:
>> +
>> +1 - Mount restriction: checks that the mount options for the underlying VFS
>> +    mount do not prevent execution.
>> +
>> +2 - File permission restriction: checks that the to-be-opened file is marked as
>> +    executable for the current process (e.g., POSIX permissions).
>> +
>> +Note that as long as a policy is enforced, opening any non-regular file with
>> +``O_MAYEXEC`` is denied (e.g. TTYs, pipe), even when such a file is marked as
>> +executable or is on an executable mount point.
>> +
>> +Code samples can be found in tools/testing/selftests/openat2/omayexec_test.c
>> +and interpreter patches (for the original O_MAYEXEC version) may be found at
>> +https://github.com/clipos-archive/clipos4_portage-overlay/search?q=O_MAYEXEC .
>> +See also an overview article: https://lwn.net/Articles/820000/ .
>> +
>> +
>>  overflowgid & overflowuid
>>  -------------------------
>>  
>> diff --git a/fs/namei.c b/fs/namei.c
>> index 3f074ec77390..8ec13c7fd403 100644
>> --- a/fs/namei.c
>> +++ b/fs/namei.c
>> @@ -39,6 +39,7 @@
>>  #include <linux/bitops.h>
>>  #include <linux/init_task.h>
>>  #include <linux/uaccess.h>
>> +#include <linux/sysctl.h>
>>  
>>  #include "internal.h"
>>  #include "mount.h"
>> @@ -425,6 +426,11 @@ static int sb_permission(struct super_block *sb, struct inode *inode, int mask)
>>  	return 0;
>>  }
>>  
>> +#define OPEN_MAYEXEC_ENFORCE_MOUNT	BIT(0)
>> +#define OPEN_MAYEXEC_ENFORCE_FILE	BIT(1)
>> +
>> +int sysctl_open_mayexec_enforce __read_mostly;
>> +
>>  /**
>>   * inode_permission - Check for access rights to a given inode
>>   * @inode: Inode to check permission on
>> @@ -2861,11 +2867,29 @@ static int may_open(const struct path *path, int acc_mode, int flag)
>>  	case S_IFSOCK:
>>  		if (acc_mode & MAY_EXEC)
>>  			return -EACCES;
>> +		/*
>> +		 * Opening devices (e.g. TTYs) or pipes with O_MAYEXEC may be
>> +		 * legitimate when there is no enforced policy.
>> +		 */
>> +		if ((acc_mode & MAY_OPENEXEC) && sysctl_open_mayexec_enforce)
>> +			return -EACCES;
>>  		flag &= ~O_TRUNC;
>>  		break;
>>  	case S_IFREG:
>>  		if ((acc_mode & MAY_EXEC) && path_noexec(path))
>>  			return -EACCES;
>> +		if (acc_mode & MAY_OPENEXEC) {
>> +			if ((sysctl_open_mayexec_enforce & OPEN_MAYEXEC_ENFORCE_MOUNT)
>> +					&& path_noexec(path))
>> +				return -EACCES;
>> +			if (sysctl_open_mayexec_enforce & OPEN_MAYEXEC_ENFORCE_FILE)
>> +				/*
>> +				 * Because acc_mode may change here, the next and only
>> +				 * use of acc_mode should then be by the following call
>> +				 * to inode_permission().
>> +				 */
>> +				acc_mode |= MAY_EXEC;
>> +		}
>>  		break;
>>  	}
>>  
>> diff --git a/include/linux/fs.h b/include/linux/fs.h
>> index 56f835c9a87a..071f37707ccc 100644
>> --- a/include/linux/fs.h
>> +++ b/include/linux/fs.h
>> @@ -83,6 +83,7 @@ extern int sysctl_protected_symlinks;
>>  extern int sysctl_protected_hardlinks;
>>  extern int sysctl_protected_fifos;
>>  extern int sysctl_protected_regular;
>> +extern int sysctl_open_mayexec_enforce;
>>  
>>  typedef __kernel_rwf_t rwf_t;
>>  
>> diff --git a/kernel/sysctl.c b/kernel/sysctl.c
>> index db1ce7af2563..5008a2566e79 100644
>> --- a/kernel/sysctl.c
>> +++ b/kernel/sysctl.c
>> @@ -113,6 +113,7 @@ static int sixty = 60;
>>  
>>  static int __maybe_unused neg_one = -1;
>>  static int __maybe_unused two = 2;
>> +static int __maybe_unused three = 3;
>>  static int __maybe_unused four = 4;
>>  static unsigned long zero_ul;
>>  static unsigned long one_ul = 1;
>> @@ -888,7 +889,6 @@ static int proc_taint(struct ctl_table *table, int write,
>>  	return err;
>>  }
>>  
>> -#ifdef CONFIG_PRINTK
>>  static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
>>  				void *buffer, size_t *lenp, loff_t *ppos)
>>  {
>> @@ -897,7 +897,6 @@ static int proc_dointvec_minmax_sysadmin(struct ctl_table *table, int write,
>>  
>>  	return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
>>  }
>> -#endif
>>  
>>  /**
>>   * struct do_proc_dointvec_minmax_conv_param - proc_dointvec_minmax() range checking structure
>> @@ -3264,6 +3263,15 @@ static struct ctl_table fs_table[] = {
>>  		.extra1		= SYSCTL_ZERO,
>>  		.extra2		= &two,
>>  	},
>> +	{
>> +		.procname       = "open_mayexec_enforce",
>> +		.data           = &sysctl_open_mayexec_enforce,
>> +		.maxlen         = sizeof(int),
>> +		.mode           = 0600,
>> +		.proc_handler	= proc_dointvec_minmax_sysadmin,
>> +		.extra1		= SYSCTL_ZERO,
>> +		.extra2		= &three,
>> +	},
>>  #if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)
>>  	{
>>  		.procname	= "binfmt_misc",
