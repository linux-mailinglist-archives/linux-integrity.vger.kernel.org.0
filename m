Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2F343BE080
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 03:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhGGBNW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 6 Jul 2021 21:13:22 -0400
Received: from mxout03.lancloud.ru ([45.84.86.113]:35620 "EHLO
        mxout03.lancloud.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229834AbhGGBNW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 6 Jul 2021 21:13:22 -0400
Received: from LanCloud
DKIM-Filter: OpenDKIM Filter v2.11.0 mxout03.lancloud.ru C9BD720E56D3
Received: from LanCloud
Received: from LanCloud
Received: from LanCloud
To:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
CC:     Igor Zhbanov <izh1979@gmail.com>, Mimi Zohar <zohar@linux.ibm.com>
From:   Igor Zhbanov <i.zhbanov@omp.ru>
Subject: [PATCH 1/1] NAX LSM: Add initial support support
Message-ID: <db1c1de0-3672-4bae-ef45-c554379f36f4@omp.ru>
Date:   Wed, 7 Jul 2021 04:03:53 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: ru-RU
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.11.198]
X-ClientProxiedBy: LFEXT02.lancloud.ru (fd00:f066::142) To
 LFEX1909.lancloud.ru (fd00:f066::79)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

NAX (No Anonymous Execution) is a Linux Security Module that extends DAC
by making impossible to make anonymous and modified pages executable for
privileged processes.

The module intercepts anonymous executable pages created with mmap() and
mprotect() system calls.

Depending on the settings, the module can block and log violating system
calls or log and kill the violating process.

Signed-off-by: Igor Zhbanov <i.zhbanov@omp.ru>
---
 Documentation/admin-guide/LSM/NAX.rst   |  48 ++++
 Documentation/admin-guide/LSM/index.rst |   1 +
 security/Kconfig                        |  11 +-
 security/Makefile                       |   2 +
 security/nax/Kconfig                    |  71 +++++
 security/nax/Makefile                   |   4 +
 security/nax/nax-lsm.c                  | 344 ++++++++++++++++++++++++
 7 files changed, 476 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/admin-guide/LSM/NAX.rst
 create mode 100644 security/nax/Kconfig
 create mode 100644 security/nax/Makefile
 create mode 100644 security/nax/nax-lsm.c

diff --git a/Documentation/admin-guide/LSM/NAX.rst b/Documentation/admin-guide/LSM/NAX.rst
new file mode 100644
index 000000000000..b742f881f3d7
--- /dev/null
+++ b/Documentation/admin-guide/LSM/NAX.rst
@@ -0,0 +1,48 @@
+=======
+NAX LSM
+=======
+
+:Author: Igor Zhbanov
+
+NAX (No Anonymous Execution) is a Linux Security Module that extends DAC
+by making impossible to make anonymous and modified pages executable for
+privileged processes. The module intercepts anonymous executable pages
+created with mmap() and mprotect() system calls.
+
+To select it at boot time, specify ``security=nax`` (though this will
+disable any other LSM).
+
+The privileged process is a process for which any of the following is true:
+
+- ``uid   == 0``
+- ``euid  == 0``
+- ``suid  == 0``
+- ``fsuid == 0``
+- ``cap_effective`` has any capability except of ``kernel.nax.allowed_caps``
+- ``cap_permitted`` has any capability except of ``kernel.nax.allowed_caps``
+
+The following sysctl parameters are available:
+
+* ``kernel.nax.allowed_caps``:
+
+ Hexadecimal number representing allowed capabilities set for the privileged
+ processes.
+
+* ``kernel.nax.enforcing``:
+
+ - 0: Only log errors (when enabled by ``kernel.nax.quiet``)
+ - 1: Forbid unsafe pages mappings (default)
+
+* ``kernel.nax.locked``:
+
+ - 0: Changing of the module's sysctl parameters is allowed
+ - 1: Further changing of the module's sysctl parameters is forbidden
+
+ Setting this parameter to ``1`` after initial setup during the system boot
+ will prevent the module disabling at the later time.
+
+* ``kernel.nax.quiet``:
+
+ - 0: Log violations (default)
+ - 1: Be quiet
+ - 2: Kill the violating process and log
diff --git a/Documentation/admin-guide/LSM/index.rst b/Documentation/admin-guide/LSM/index.rst
index a6ba95fbaa9f..e9df7fc9a461 100644
--- a/Documentation/admin-guide/LSM/index.rst
+++ b/Documentation/admin-guide/LSM/index.rst
@@ -42,6 +42,7 @@ subdirectories.
 
    apparmor
    LoadPin
+   NAX
    SELinux
    Smack
    tomoyo
diff --git a/security/Kconfig b/security/Kconfig
index 0ced7fd33e4d..771419647ae1 100644
--- a/security/Kconfig
+++ b/security/Kconfig
@@ -239,6 +239,7 @@ source "security/yama/Kconfig"
 source "security/safesetid/Kconfig"
 source "security/lockdown/Kconfig"
 source "security/landlock/Kconfig"
+source "security/nax/Kconfig"
 
 source "security/integrity/Kconfig"
 
@@ -278,11 +279,11 @@ endchoice
 
 config LSM
 	string "Ordered list of enabled LSMs"
-	default "landlock,lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
-	default "landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
-	default "landlock,lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
-	default "landlock,lockdown,yama,loadpin,safesetid,integrity,bpf" if DEFAULT_SECURITY_DAC
-	default "landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"
+	default "nax,landlock,lockdown,yama,loadpin,safesetid,integrity,smack,selinux,tomoyo,apparmor,bpf" if DEFAULT_SECURITY_SMACK
+	default "nax,landlock,lockdown,yama,loadpin,safesetid,integrity,apparmor,selinux,smack,tomoyo,bpf" if DEFAULT_SECURITY_APPARMOR
+	default "nax,landlock,lockdown,yama,loadpin,safesetid,integrity,tomoyo,bpf" if DEFAULT_SECURITY_TOMOYO
+	default "nax,landlock,lockdown,yama,loadpin,safesetid,integrity,bpf" if DEFAULT_SECURITY_DAC
+	default "nax,landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,smack,tomoyo,apparmor,bpf"
 	help
 	  A comma-separated list of LSMs, in initialization order.
 	  Any LSMs left off this list will be ignored. This can be
diff --git a/security/Makefile b/security/Makefile
index 47e432900e24..5c261bbf4659 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -14,6 +14,7 @@ subdir-$(CONFIG_SECURITY_SAFESETID)    += safesetid
 subdir-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown
 subdir-$(CONFIG_BPF_LSM)		+= bpf
 subdir-$(CONFIG_SECURITY_LANDLOCK)	+= landlock
+subdir-$(CONFIG_SECURITY_NAX)		+= nax
 
 # always enable default capabilities
 obj-y					+= commoncap.o
@@ -34,6 +35,7 @@ obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
 obj-$(CONFIG_CGROUPS)			+= device_cgroup.o
 obj-$(CONFIG_BPF_LSM)			+= bpf/
 obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
+obj-$(CONFIG_SECURITY_NAX)		+= nax/
 
 # Object integrity file lists
 subdir-$(CONFIG_INTEGRITY)		+= integrity
diff --git a/security/nax/Kconfig b/security/nax/Kconfig
new file mode 100644
index 000000000000..60ef0964f00a
--- /dev/null
+++ b/security/nax/Kconfig
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config SECURITY_NAX
+	bool "NAX support"
+	depends on SECURITY
+	default n
+	help
+	  This selects NAX (No Anonymous Execution), which extends DAC
+	  support with additional system-wide security settings beyond
+	  regular Linux discretionary access controls. Currently available
+	  is restriction to make anonymous and modified pages executable
+	  to privileged processes. Like capabilities, this security module
+	  stacks with other LSMs. Further information can be found in
+	  Documentation/admin-guide/LSM/NAX.rst.
+
+	  If you are unsure how to answer this question, answer N.
+
+config SECURITY_NAX_LOCKED
+	bool "Lock NAX settings"
+	depends on SECURITY_NAX
+	help
+	  If selected, it will not be possible to change enforcing and quiet
+	  settings via sysctl or the kernel command line. If not selected,
+	  it can be enabled at boot with the kernel parameter "nax_locked=1"
+	  or "kernel.nax_locked=1" sysctl (if the settings are not locked).
+
+config SECURITY_NAX_QUIET
+	bool "Silence NAX messages"
+	depends on SECURITY_NAX
+	help
+	  If selected, NAX will not print violations. If not selected, it can
+	  be enabled at boot with the kernel parameter "nax_quiet=1" or
+	  "kernel.nax_quiet=1" sysctl (if the settings are not locked).
+
+choice
+	prompt "NAX violation action mode"
+	default SECURITY_NAX_MODE_LOG
+	depends on SECURITY_NAX
+	help
+	  Select the NAX violation action mode.
+
+	  In the default permissive mode the violations are only logged
+	  (if logging is not suppressed). In the enforcing mode the violations
+	  are prohibited. And in the kill mode the process is terminated.
+
+	  The value can be changed at boot with the kernel parameter
+	  "nax_mode" (0, 1, 2) or "kernel.nax_mode=" (0, 1, 2) sysctl (if the
+	  settings are not locked).
+
+	config SECURITY_NAX_MODE_LOG
+		bool "Permissive mode"
+		help
+		  In this mode violations are only logged (if logging is not
+		  suppressed).
+	config SECURITY_NAX_MODE_ENFORCING
+		bool "Enforcing mode"
+		help
+		  In this mode violations are prohibited and logged (if
+		  logging is not suppressed).
+	config SECURITY_NAX_MODE_KILL
+		bool "Kill mode"
+		help
+		  In this mode the voilating process is terminated. The event
+		  is logged (if logging is not suppressed).
+endchoice
+
+config SECURITY_NAX_MODE
+        int
+        depends on SECURITY_NAX
+        default 0 if SECURITY_NAX_MODE_LOG
+        default 1 if SECURITY_NAX_MODE_ENFORCING
+        default 2 if SECURITY_NAX_MODE_KILL
diff --git a/security/nax/Makefile b/security/nax/Makefile
new file mode 100644
index 000000000000..9c3372210c77
--- /dev/null
+++ b/security/nax/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_SECURITY_NAX) := nax.o
+
+nax-y := nax-lsm.o
diff --git a/security/nax/nax-lsm.c b/security/nax/nax-lsm.c
new file mode 100644
index 000000000000..ef99d9b36a9d
--- /dev/null
+++ b/security/nax/nax-lsm.c
@@ -0,0 +1,344 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright (C) 2016-2021 Open Mobile Platform LLC.
+ *
+ * Written by: Igor Zhbanov <i.zhbanov@omp.ru, izh1979@gmail.com>
+ *
+ * NAX (No Anonymous Execution) Linux Security Module
+ * This module prevents execution of the code in anonymous or modified pages.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation. */
+
+#define pr_fmt(fmt) "NAX: " fmt
+
+#include <linux/capability.h>
+#include <linux/cred.h>
+#include <linux/ctype.h>
+#include <linux/lsm_hooks.h>
+#include <linux/mman.h>
+#include <linux/sched.h>
+#include <linux/securebits.h>
+#include <linux/security.h>
+#include <linux/sysctl.h>
+#include <linux/uidgid.h>
+
+#define NAX_MODE_PERMISSIVE 0 /* Log only             */
+#define NAX_MODE_ENFORCING  1 /* Enforce and log      */
+#define NAX_MODE_KILL       2 /* Kill process and log */
+
+static int mode   = CONFIG_SECURITY_NAX_MODE,
+	   quiet  = IS_ENABLED(CONFIG_SECURITY_NAX_QUIET),
+	   locked = IS_ENABLED(CONFIG_SECURITY_NAX_LOCKED);
+
+#define ALLOWED_CAPS_HEX_LEN (_KERNEL_CAPABILITY_U32S * 8)
+
+static char allowed_caps_hex[ALLOWED_CAPS_HEX_LEN + 1];
+static kernel_cap_t allowed_caps = CAP_EMPTY_SET;
+
+static int
+is_privileged_process(void)
+{
+	const struct cred *cred;
+	kuid_t root_uid;
+
+	cred = current_cred();
+	root_uid = make_kuid(cred->user_ns, 0);
+	/* We count a process as privileged if it any of its IDs is zero
+	 * or it has any unsafe capability (even in a user namespace) */
+	if ((!issecure(SECURE_NOROOT) && (uid_eq(cred->uid,   root_uid) ||
+					  uid_eq(cred->euid,  root_uid) ||
+					  uid_eq(cred->suid,  root_uid) ||
+					  uid_eq(cred->fsuid, root_uid))) ||
+	    (!cap_issubset(cred->cap_effective, allowed_caps)) ||
+	    (!cap_issubset(cred->cap_permitted, allowed_caps)))
+		return 1;
+
+	return 0;
+}
+
+static void
+log_warn(const char *reason)
+{
+	if (quiet)
+		return;
+
+	pr_warn_ratelimited("%s: pid=%d, uid=%u, comm=\"%s\"\n",
+		            reason, current->pid,
+		            from_kuid(&init_user_ns, current_cred()->uid),
+	                              current->comm);
+}
+
+static void
+kill_current_task(void)
+{
+	pr_warn("Killing pid=%d, uid=%u, comm=\"%s\"\n",
+		current->pid, from_kuid(&init_user_ns, current_cred()->uid),
+		current->comm);
+	force_sig(SIGKILL);
+}
+
+static int
+nax_mmap_file(struct file *file, unsigned long reqprot,
+	      unsigned long prot, unsigned long flags)
+{
+	int ret = 0;
+
+	if (mode == NAX_MODE_PERMISSIVE && quiet)
+		return 0; /* Skip further checks in this case */
+
+	if (!(prot & PROT_EXEC)) /* Not executable memory */
+		return 0;
+
+	if (!is_privileged_process())
+		return 0; /* Not privileged processes can do anything */
+
+	if (!file) { /* Anonymous executable memory */
+		log_warn("MMAP_ANON_EXEC");
+		ret = -EACCES;
+	} else if (prot & PROT_WRITE) { /* Mapping file RWX */
+		log_warn("MMAP_FILE_WRITE_EXEC");
+		ret = -EACCES;
+	}
+
+	if (mode == NAX_MODE_KILL)
+		kill_current_task();
+
+	return (mode != NAX_MODE_PERMISSIVE) ? ret : 0;
+}
+
+static int
+nax_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
+		  unsigned long prot)
+{
+	if (mode == NAX_MODE_PERMISSIVE && quiet)
+		return 0; /* Skip further checks in this case */
+
+	if (!(prot & PROT_EXEC)) /* Not executable memory */
+		return 0;
+
+	if (!is_privileged_process())
+		return 0; /* Not privileged processes can do anything */
+
+	if (!(vma->vm_flags & VM_EXEC)) {
+		int ret = 0;
+
+		if (vma->vm_start >= vma->vm_mm->start_brk &&
+		    vma->vm_end   <= vma->vm_mm->brk) {
+			log_warn("MPROTECT_EXEC_HEAP");
+			ret = -EACCES;
+		} else if (!vma->vm_file &&
+			   ((vma->vm_start <= vma->vm_mm->start_stack &&
+			     vma->vm_end   >= vma->vm_mm->start_stack) ||
+			    vma_is_stack_for_current(vma))) {
+			log_warn("MPROTECT_EXEC_STACK");
+			ret = -EACCES;
+		} else if (vma->vm_file && vma->anon_vma) {
+			/* We are making executable a file mapping that has
+			 * had some COW done. Since pages might have been
+			 * written, check ability to execute the possibly
+			 * modified content. This typically should only
+			 * occur for text relocations. */
+			log_warn("MPROTECT_EXEC_MODIFIED");
+			ret = -EACCES;
+		}
+
+		if (ret) {
+			if (mode == NAX_MODE_KILL)
+				kill_current_task();
+
+			return (mode != NAX_MODE_PERMISSIVE) ? ret : 0;
+		}
+	}
+
+	return nax_mmap_file(vma->vm_file, reqprot, prot,
+			     vma->vm_flags & VM_SHARED);
+}
+
+static struct security_hook_list nax_hooks[] __lsm_ro_after_init = {
+	LSM_HOOK_INIT(mmap_file, nax_mmap_file),
+	LSM_HOOK_INIT(file_mprotect, nax_file_mprotect),
+};
+
+#ifdef CONFIG_SYSCTL
+
+static int
+nax_dointvec_minmax(struct ctl_table *table, int write,
+		    void *buffer, size_t *lenp, loff_t *ppos)
+{
+	if (write && (!capable(CAP_SYS_ADMIN) || locked))
+		return -EPERM;
+
+	return proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+}
+
+static int
+nax_dostring(struct ctl_table *table, int write, void *buffer,
+             size_t *lenp, loff_t *ppos)
+{
+	if (write) {
+		int error;
+		char *buf = (char *)buffer;
+		size_t len = *lenp, i;
+		kernel_cap_t caps = CAP_EMPTY_SET;
+
+		if (!capable(CAP_SYS_ADMIN) || locked)
+			return -EPERM;
+
+		/* Do not allow trailing garbage or excessive length */
+		if (len == ALLOWED_CAPS_HEX_LEN + 1) {
+			if (buf[--len] != '\n')
+				return -EINVAL;
+		} else if (len > ALLOWED_CAPS_HEX_LEN || len <= 0)
+			return -EINVAL;
+
+		if ((error = proc_dostring(table, write, buffer, lenp, ppos)))
+			return error;
+
+		len = strlen(allowed_caps_hex);
+		for (i = 0; i < len; i++)
+			if (!isxdigit(allowed_caps_hex[i]))
+				return -EINVAL;
+
+		for (i = 0; i < _KERNEL_CAPABILITY_U32S; i++) {
+			unsigned long l;
+
+			if (kstrtoul(allowed_caps_hex +
+			             (len >= 8 ? len - 8 : 0), 16, &l))
+				return -EINVAL;
+
+			caps.cap[i] = l;
+			if (len < 8)
+				break;
+
+			len -= 8;
+			allowed_caps_hex[len] = '\0';
+		}
+
+		allowed_caps = cap_intersect(caps, CAP_FULL_SET);
+		return 0;
+	} else {
+		unsigned i;
+
+		CAP_FOR_EACH_U32(i)
+			snprintf(allowed_caps_hex + i * 8, 9, "%08x",
+			         allowed_caps.cap[CAP_LAST_U32 - i]);
+
+		return proc_dostring(table, write, buffer, lenp, ppos);
+	}
+}
+
+struct ctl_path nax_sysctl_path[] = {
+	{ .procname = "kernel" },
+	{ .procname = "nax"    },
+	{ }
+};
+
+static int max_mode = NAX_MODE_KILL;
+
+static struct ctl_table nax_sysctl_table[] = {
+	{
+		.procname     = "allowed_caps",
+		.data         = allowed_caps_hex,
+		.maxlen       = ALLOWED_CAPS_HEX_LEN + 1,
+		.mode         = 0644,
+		.proc_handler = nax_dostring,
+	}, {
+		.procname     = "locked",
+		.data         = &locked,
+		.maxlen       = sizeof(int),
+		.mode         = 0644,
+		.proc_handler = nax_dointvec_minmax,
+		.extra1       = SYSCTL_ZERO,
+		.extra2       = SYSCTL_ONE,
+	}, {
+		.procname     = "mode",
+		.data         = &mode,
+		.maxlen       = sizeof(int),
+		.mode         = 0644,
+		.proc_handler = nax_dointvec_minmax,
+		.extra1       = SYSCTL_ZERO,
+		.extra2       = &max_mode,
+	}, {
+		.procname     = "quiet",
+		.data         = &quiet,
+		.maxlen       = sizeof(int),
+		.mode         = 0644,
+		.proc_handler = nax_dointvec_minmax,
+		.extra1       = SYSCTL_ZERO,
+		.extra2       = SYSCTL_ONE,
+	},
+	{ }
+};
+
+static void __init
+nax_init_sysctl(void)
+{
+	if (!register_sysctl_paths(nax_sysctl_path, nax_sysctl_table))
+		panic("NAX: sysctl registration failed.\n");
+}
+
+#else /* !CONFIG_SYSCTL */
+
+static inline void
+nax_init_sysctl(void)
+{
+
+}
+
+#endif /* !CONFIG_SYSCTL */
+
+static int __init setup_mode(char *str)
+{
+	unsigned long val;
+
+	if (!locked && !kstrtoul(str, 0, &val)) {
+		if (val > max_mode){
+			pr_err("Invalid 'nax_mode' parameter value (%s)\n",
+			       str);
+			val = max_mode;
+		}
+
+		mode = val;
+	}
+
+	return 1;
+}
+__setup("nax_mode=", setup_mode);
+
+static int __init setup_quiet(char *str)
+{
+	unsigned long val;
+
+	if (!locked && !kstrtoul(str, 0, &val))
+		quiet = val ? 1 : 0;
+
+	return 1;
+}
+__setup("nax_quiet=", setup_quiet);
+
+static int __init setup_locked(char *str)
+{
+	unsigned long val;
+
+	if (!locked && !kstrtoul(str, 0, &val))
+		locked = val ? 1 : 0;
+
+	return 1;
+}
+__setup("nax_locked=", setup_locked);
+
+static __init int
+nax_init(void)
+{
+	pr_info("Starting.\n");
+	security_add_hooks(nax_hooks, ARRAY_SIZE(nax_hooks), "nax");
+	nax_init_sysctl();
+
+	return 0;
+}
+
+DEFINE_LSM(nax) = {
+	.name = "nax",
+	.init = nax_init,
+};
-- 
2.26.2

