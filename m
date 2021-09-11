Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18E6240761A
	for <lists+linux-integrity@lfdr.de>; Sat, 11 Sep 2021 12:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235593AbhIKKjr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 11 Sep 2021 06:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235443AbhIKKjq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 11 Sep 2021 06:39:46 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5293AC061574;
        Sat, 11 Sep 2021 03:38:33 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id bq5so9607569lfb.9;
        Sat, 11 Sep 2021 03:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:from:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=5gTjgRp958Lm3C8Lq+LwTG1yU4/o02PLROabVx2qqcQ=;
        b=NZKdSLm4N82fXUxPhGwk0h1L+ApN3CDSYHoA12ppGziYfre4lrqOSlHf2jA6d46ofn
         fHmFb81BOzm/bAgpPKeZrpz05Go43F36hm9VUM7tB7y9g/AvZrudoLBCdI0ja34cd+Xt
         lUz23xNoNuQGrzTwHSn2gpNdYpeJFhj84AomRs02AAXA5n4iGl+SPHCgZyIZ95EDbCyn
         XA1eMYkMO5Ae0bEO2JCf243CDgWlScjPqxhijE6s5XDNABtoNqIVrzK8B7G54VwJ8HYQ
         7aecHYmnyYKdV1IHyF31qjnn1/2GgyrNPX3iMiDXz0rW7OLrNfOh6oAQdtNtg0OYgQXo
         ODZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:from:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5gTjgRp958Lm3C8Lq+LwTG1yU4/o02PLROabVx2qqcQ=;
        b=570I+Y0/pskcay0T/kww8sKoXnX0Q08tlzu45JqSBO9fQbg1fkqISG5JoCicBXe3yU
         j7chNO9PQ+JWlhx2XDDBTZOJS4XAPeFmvt2pP33LIh4aKY7vM9j9BNNuYFF4PGeV05rp
         y6lX7D/OAJjR2T76mIKrBi4/mRi7EZB9dIEBlyZlK8PtWLNiv+cHr+UB2Hmu1aJeXBiN
         7IGR1147a0g08JdHwcO1uv6h7+EAQGV0S9FVWASMMsNCSvReqJPyyUMtLQRCpWiG+p0q
         b/j1mfMf0yqCjyQdfex06TXGU4Zq1a4np6ZOAjTz3V9Miukg+T/Mr/5BGAdarjeCvupV
         LzAg==
X-Gm-Message-State: AOAM532XQM4FgbJEWClYaAoviTWuj6FpLs2dhjljlWiYP2HV3w7vbQC3
        7PaUHCkh/KY0Ywuj1xigrb9CHl8cgiUyOQ==
X-Google-Smtp-Source: ABdhPJyYsK2ADQ/9jsyUtJTbwfVgFpbKmlum/98BjDx6WAMYB7EjeObd/QlQJ9xx6S46ZgwCRfjeEw==
X-Received: by 2002:a05:6512:3c94:: with SMTP id h20mr1657371lfv.170.1631356710825;
        Sat, 11 Sep 2021 03:38:30 -0700 (PDT)
Received: from [192.168.0.150] (0855025014.static.corbina.ru. [89.179.245.198])
        by smtp.gmail.com with ESMTPSA id l7sm162871lfj.81.2021.09.11.03.38.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Sep 2021 03:38:30 -0700 (PDT)
Subject: [PATCH v6 1/1] NAX LSM: Add initial support
From:   Igor Zhbanov <izh1979@gmail.com>
To:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        THOBY Simon <Simon.THOBY@viveris.fr>,
        J Freyensee <why2jjj.linux@gmail.com>,
        linux-kernel@vger.kernel.org
References: <cb5276ea-d345-54ae-4ba4-646403789388@gmail.com>
Message-ID: <139a008c-d790-8500-613b-132d93360457@gmail.com>
Date:   Sat, 11 Sep 2021 13:38:45 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <cb5276ea-d345-54ae-4ba4-646403789388@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add initial support for NAX (No Anonymous Execution), which is a Linux
Security Module that extends DAC by making impossible to make anonymous
and modified pages executable for privileged processes.

Intercepts anonymous executable pages created with mmap() and mprotect()
system calls.

Log violations (in non-quiet mode) and block the action or kill the
offending process, depending on the enabled settings.

See Documentation/admin-guide/LSM/NAX.rst.

Signed-off-by: Igor Zhbanov <izh1979@gmail.com>
---
 Documentation/admin-guide/LSM/NAX.rst         |  69 +++
 Documentation/admin-guide/LSM/index.rst       |   1 +
 .../admin-guide/kernel-parameters.rst         |   1 +
 .../admin-guide/kernel-parameters.txt         |  32 ++
 security/Kconfig                              |  11 +-
 security/Makefile                             |   1 +
 security/nax/Kconfig                          | 113 +++++
 security/nax/Makefile                         |   4 +
 security/nax/nax-lsm.c                        | 469 ++++++++++++++++++
 9 files changed, 696 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/admin-guide/LSM/NAX.rst
 create mode 100644 security/nax/Kconfig
 create mode 100644 security/nax/Makefile
 create mode 100644 security/nax/nax-lsm.c

diff --git a/Documentation/admin-guide/LSM/NAX.rst b/Documentation/admin-guide/LSM/NAX.rst
new file mode 100644
index 000000000000..7a870e27ce03
--- /dev/null
+++ b/Documentation/admin-guide/LSM/NAX.rst
@@ -0,0 +1,69 @@
+=======
+NAX LSM
+=======
+
+:Author: Igor Zhbanov
+
+NAX (No Anonymous Execution) is a Linux Security Module that extends DAC
+by making impossible to make anonymous and modified pages executable for
+processes. The module intercepts anonymous executable pages created with
+mmap() and mprotect() system calls.
+
+To select it at boot time, add ``nax`` to ``security`` kernel command-line
+parameter.
+
+The following sysctl parameters are available:
+
+* ``kernel.nax.check_all``:
+ - 0: Check all processes.
+ - 1: Check only privileged processes. The privileged process is a process
+      for which any of the following is true:
+      - ``uid  == 0``
+      - ``euid == 0``
+      - ``suid == 0``
+      - ``cap_effective`` has any capability except for the ones allowed
+        in ``kernel.nax.allowed_caps``
+      - ``cap_permitted`` has any capability except for the ones allowed
+        in ``kernel.nax.allowed_caps``
+
+ Checking of uid/euid/suid is important because a process may call seteuid(0)
+ to gain privileges (if SECURE_NO_SETUID_FIXUP secure bit is not set).
+
+* ``kernel.nax.allowed_caps``:
+
+ Hexadecimal number representing the set of capabilities a non-root
+ process can possess without being considered "privileged" by NAX LSM.
+
+ For the meaning of the capabilities bits and their value, please check
+ ``include/uapi/linux/capability.h`` and ``capabilities(7)`` manual page.
+
+ For example, ``CAP_SYS_PTRACE`` has a number 19. Therefore, to add it to
+ allowed capabilities list, we need to set 19'th bit (2^19 or 1 << 19)
+ or 80000 in hexadecimal form. Capabilities can be bitwise ORed.
+
+* ``kernel.nax.mode``:
+
+ - 0: Only log errors (when enabled by ``kernel.nax.quiet``) (default mode)
+ - 1: Forbid unsafe pages mappings (and log when enabled)
+ - 2: Kill the violating process (and log when enabled)
+
+* ``kernel.nax.quiet``:
+
+ - 0: Log violations (default)
+ - 1: Be quiet
+
+* ``kernel.nax.locked``:
+
+ - 0: Changing of the module's sysctl parameters is allowed
+ - 1: Further changing of the module's sysctl parameters is forbidden
+
+ Setting this parameter to ``1`` after initial setup during the system boot
+ will prevent the module disabling at the later time.
+
+There are matching kernel command-line parameters (with the same values):
+
+- ``nax_allowed_caps``
+- ``nax_check_all``
+- ``nax_mode``
+- ``nax_quiet``
+- ``nax_locked``
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
diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 01ba293a2d70..f4e91dc729f0 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -136,6 +136,7 @@ parameter is applicable::
 	MOUSE	Appropriate mouse support is enabled.
 	MSI	Message Signaled Interrupts (PCI).
 	MTD	MTD (Memory Technology Device) support is enabled.
+	NAX	NAX support is enabled.
 	NET	Appropriate network support is enabled.
 	NUMA	NUMA support is enabled.
 	NFS	Appropriate NFS support is enabled.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 828d11441ebf..17ea58580a69 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3126,6 +3126,38 @@
 
 	n2=		[NET] SDL Inc. RISCom/N2 synchronous serial card
 
+	nax_allowed_caps= [NAX] Hexadecimal number representing the set of
+			capabilities a non-root process can possess without
+			being considered "privileged" by NAX LSM.
+
+			For the meaning of the capabilities bits and their
+			value, please check include/uapi/linux/capability.h
+			and capabilities(7) manual page.
+
+			For example, `CAP_SYS_PTRACE` has a number 19.
+			Therefore, to add it to allowed capabilities list,
+			we need to set 19'th bit (2^19 or 1 << 19) or 80000
+			in hexadecimal form. Capabilities can be bitwise ORed.
+
+	nax_check_all=	[NAX] NAX LSM processes checking mode:
+			0 - Check only privileged processes (default).
+			1 - Check all processes.
+
+	nax_locked=	[NAX] NAX LSM settings' locking mode:
+			0 - Changing NAX sysctl parameters is allowed.
+			1 - Changing NAX sysctl parameters is forbidden until
+			    reboot.
+
+	nax_mode=	[NAX] NAX LSM violation reaction mode:
+			0 - Only log errors (when not in quiet mode; default).
+			1 - Forbid unsafe pages mappings (and log when
+			    enabled).
+			2 - Kill the violating process (and log when enabled).
+
+	nax_quiet=	[NAX] NAX LSM log verbosity:
+			0 - Log messages to syslog.
+			1 - Be quiet.
+
 	netdev=		[NET] Network devices parameters
 			Format: <irq>,<io>,<mem_start>,<mem_end>,<name>
 			Note that mem_start is often overloaded to mean
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
index 18121f8f85cd..54b69a7621ed 100644
--- a/security/Makefile
+++ b/security/Makefile
@@ -24,6 +24,7 @@ obj-$(CONFIG_SECURITY_LOCKDOWN_LSM)	+= lockdown/
 obj-$(CONFIG_CGROUPS)			+= device_cgroup.o
 obj-$(CONFIG_BPF_LSM)			+= bpf/
 obj-$(CONFIG_SECURITY_LANDLOCK)		+= landlock/
+obj-$(CONFIG_SECURITY_NAX)		+= nax/
 
 # Object integrity file lists
 obj-$(CONFIG_INTEGRITY)			+= integrity/
diff --git a/security/nax/Kconfig b/security/nax/Kconfig
new file mode 100644
index 000000000000..71fc0175cfb2
--- /dev/null
+++ b/security/nax/Kconfig
@@ -0,0 +1,113 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config SECURITY_NAX
+	bool "NAX support"
+	depends on SECURITY
+	help
+	  This selects NAX (No Anonymous Execution), which extends DAC
+	  support with additional system-wide security settings beyond
+	  regular Linux discretionary access controls. Currently, the only
+	  available behavior is restricting the execution of anonymous and
+	  modified pages.
+
+	  The module can restrict either privileged or all processes,
+	  depending on the settings. It is possible to configure action,
+	  performed when the violation is detected (log, log + block,
+	  log + kill).
+
+	  Further information can be found in
+	  Documentation/admin-guide/LSM/NAX.rst.
+
+	  If you are unsure how to answer this question, answer N.
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
+	  The value can be overridden at boot time with the kernel command-line
+	  parameter "nax_mode=" (0, 1, 2) or "kernel.nax.mode=" (0, 1, 2)
+	  sysctl parameter (if the settings are not locked).
+
+	config SECURITY_NAX_MODE_LOG
+		bool "Permissive mode"
+		help
+		  In this mode violations are only logged (if logging is not
+		  suppressed by the "kernel.nax.quiet" parameter). The
+		  violating system call will not be prohibited.
+	config SECURITY_NAX_MODE_ENFORCING
+		bool "Enforcing mode"
+		help
+		  In this mode violations are prohibited and logged (if
+		  logging is not suppressed by the "kernel.nax.quiet"
+		  parameter). The violating system call will return -EACCES
+		  error.
+	config SECURITY_NAX_MODE_KILL
+		bool "Kill mode"
+		help
+		  In this mode the violating process is terminated on the
+		  first violation system call. The violation event is logged
+		  (if logging is not suppressed by the "kernel.nax.quiet"
+		  parameter).
+endchoice
+
+config SECURITY_NAX_MODE
+	int
+	depends on SECURITY_NAX
+	default 0 if SECURITY_NAX_MODE_LOG
+	default 1 if SECURITY_NAX_MODE_ENFORCING
+	default 2 if SECURITY_NAX_MODE_KILL
+
+config SECURITY_NAX_CHECK_ALL
+	bool "Check all processes"
+	depends on SECURITY_NAX
+	help
+	  If selected, NAX will check all processes. If not selected, NAX
+	  will check only privileged processes (which is determined either
+	  by having zero uid, euid, suid or fsuid; or by possessing
+	  capabilities outside of allowed set).
+
+	  The value can also be overridden at boot time with the kernel
+	  command-line parameter "nax_check_all=" (0, 1) or
+	  "kernel.nax.check_all=" (0, 1) sysctl parameter (if the settings
+	  are not locked).
+
+config SECURITY_NAX_ALLOWED_CAPS
+	hex "Process capabilities ignored by NAX"
+	default 0x0
+	range 0x0 0xffffffffffff
+	depends on SECURITY_NAX
+	help
+	  Hexadecimal number representing the set of capabilities
+	  a non-root process can possess without being considered
+	  "privileged" by NAX LSM.
+
+	  The value can be overridden at boot time with the command-line
+	  parameter "nax_allowed_caps=" or "kernel.nax.allowed_caps=" sysctl
+	  parameter (if the settings are not locked).
+
+config SECURITY_NAX_QUIET
+	bool "Silence NAX messages"
+	depends on SECURITY_NAX
+	help
+	  If selected, NAX will not print violations.
+
+	  The value can be overridden at boot with the command-line
+	  parameter "nax_quiet=" (0, 1) or "kernel.nax.quiet=" (0, 1) sysctl
+	  parameter (if the settings are not locked).
+
+config SECURITY_NAX_LOCKED
+	bool "Lock NAX settings"
+	depends on SECURITY_NAX
+	help
+	  Prevent any update to the settings of the NAX LSM. This applies to
+	  both sysctl writes and the kernel command line.
+
+	  If not selected, it can be enabled at boot time with the kernel
+	  command-line parameter "nax_locked=1" or "kernel.nax_locked=1"
+	  sysctl parameter (if the settings are not locked).
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
index 000000000000..6186c07a6828
--- /dev/null
+++ b/security/nax/nax-lsm.c
@@ -0,0 +1,469 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2016-2021 Open Mobile Platform LLC.
+ *
+ * Written by: Igor Zhbanov <i.zhbanov@omp.ru, izh1979@gmail.com>
+ *
+ * NAX (No Anonymous Execution) Linux Security Module
+ * This module prevents execution of the code in anonymous or modified pages.
+ * For more details, see Documentation/admin-guide/LSM/NAX.rst and
+ * Documentation/admin-guide/kernel-parameters.rst
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2, as
+ * published by the Free Software Foundation.
+ */
+
+#define pr_fmt(fmt) "NAX: " fmt
+
+#include <linux/capability.h>
+#include <linux/cred.h>
+#include <linux/ctype.h>
+#include <linux/lsm_hooks.h>
+#include <linux/mman.h>
+#include <linux/rcupdate.h>
+#include <linux/sched.h>
+#include <linux/securebits.h>
+#include <linux/security.h>
+#include <linux/spinlock.h>
+#include <linux/sysctl.h>
+#include <linux/uidgid.h>
+
+#define NAX_MODE_PERMISSIVE 0 /* Log only             */
+#define NAX_MODE_ENFORCING  1 /* Enforce and log      */
+#define NAX_MODE_KILL       2 /* Kill process and log */
+
+static int max_mode = NAX_MODE_KILL;
+
+static int mode      = CONFIG_SECURITY_NAX_MODE,
+	   quiet     = IS_ENABLED(CONFIG_SECURITY_NAX_QUIET),
+	   locked    = IS_ENABLED(CONFIG_SECURITY_NAX_LOCKED),
+	   check_all = IS_ENABLED(CONFIG_SECURITY_NAX_CHECK_ALL);
+
+#define ALLOWED_CAPS_HEX_LEN (_KERNEL_CAPABILITY_U32S * 8)
+
+static char allowed_caps_hex[ALLOWED_CAPS_HEX_LEN + 1];
+static kernel_cap_t __rcu *allowed_caps;
+DEFINE_SPINLOCK(allowed_caps_mutex);
+
+static bool
+is_interesting_process(void)
+{
+	bool ret = false;
+	const struct cred *cred;
+	kuid_t root_uid;
+	kernel_cap_t *caps;
+
+	if (check_all)
+		return true;
+
+	cred = current_cred();
+	root_uid = make_kuid(cred->user_ns, 0);
+
+	rcu_read_lock();
+	caps = rcu_dereference(allowed_caps);
+	/*
+	 * We count a process as interesting if it any of its uid/euid/suid
+	 * is zero (because it may call seteuid(0) to gain privileges) or
+	 * it has any not allowed capability (even in a user namespace)
+	 */
+	if ((!issecure(SECURE_NO_SETUID_FIXUP) &&
+	     (uid_eq(cred->uid,  root_uid) ||
+	      uid_eq(cred->euid, root_uid) ||
+	      uid_eq(cred->suid, root_uid))) ||
+	    (!cap_issubset(cred->cap_effective, *caps)) ||
+	    (!cap_issubset(cred->cap_permitted, *caps)))
+		ret = true;
+
+	rcu_read_unlock();
+	return ret;
+}
+
+static void
+log_warn(const char *reason)
+{
+	if (quiet)
+		return;
+
+	pr_warn_ratelimited("%s: pid=%d, uid=%u, comm=\"%s\"\n",
+			    reason, current->pid,
+			    from_kuid(&init_user_ns, current_cred()->uid),
+				      current->comm);
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
+	if (!is_interesting_process())
+		return 0; /* Not interesting processes can do anything */
+
+	if (!file) { /* Anonymous executable memory */
+		log_warn("MMAP_ANON_EXEC");
+		ret = -EACCES;
+	} else if (prot & PROT_WRITE) { /* Mapping file RWX */
+		log_warn("MMAP_FILE_WRITE_EXEC");
+		ret = -EACCES;
+	}
+
+	if (ret && mode == NAX_MODE_KILL)
+		kill_current_task();
+
+	return (mode != NAX_MODE_PERMISSIVE) ? ret : 0;
+}
+
+static int
+nax_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
+		  unsigned long prot)
+{
+	int ret = 0;
+
+	if (mode == NAX_MODE_PERMISSIVE && quiet)
+		return 0; /* Skip further checks in this case */
+
+	if (!(prot & PROT_EXEC)) /* Not executable memory */
+		return 0;
+
+	if (!is_interesting_process())
+		return 0; /* Not interesting processes can do anything */
+
+	if (!(vma->vm_flags & VM_EXEC)) {
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
+			/*
+			 * We are making executable a file mapping that has
+			 * had some COW done. Since pages might have been
+			 * written, check ability to execute the possibly
+			 * modified content. This typically should only
+			 * occur for text relocations.
+			 */
+			log_warn("MPROTECT_EXEC_MODIFIED");
+			ret = -EACCES;
+		}
+	}
+
+	if (!ret) {
+		if (!vma->vm_file) { /* Anonymous executable memory */
+			log_warn("MPROTECT_ANON_EXEC");
+			ret = -EACCES;
+		} else if (prot & PROT_WRITE) { /* Remapping file as RWX */
+			log_warn("MPROTECT_FILE_WRITE_EXEC");
+			ret = -EACCES;
+		}
+	}
+
+	if (ret && mode == NAX_MODE_KILL)
+		kill_current_task();
+
+	return (mode != NAX_MODE_PERMISSIVE) ? ret : 0;
+}
+
+static struct security_hook_list nax_hooks[] __lsm_ro_after_init = {
+	LSM_HOOK_INIT(mmap_file, nax_mmap_file),
+	LSM_HOOK_INIT(file_mprotect, nax_file_mprotect),
+};
+
+static void
+update_allowed_caps(kernel_cap_t *caps)
+{
+	kernel_cap_t *old_caps;
+
+	*caps = cap_intersect(*caps, CAP_FULL_SET); /* Drop unsupported */
+	spin_lock(&allowed_caps_mutex);
+	old_caps = rcu_dereference_protected(allowed_caps,
+					     lockdep_is_held(&allowed_caps_mutex));
+	rcu_assign_pointer(allowed_caps, caps);
+	spin_unlock(&allowed_caps_mutex);
+	synchronize_rcu();
+	kfree(old_caps);
+}
+
+static int
+set_default_allowed_caps(void)
+{
+	size_t i;
+	kernel_cap_t *caps;
+
+	caps = kmalloc(sizeof(*caps), GFP_KERNEL);
+	if (!caps)
+		return -ENOMEM;
+
+	CAP_FOR_EACH_U32(i)
+		caps->cap[i] = (CONFIG_SECURITY_NAX_ALLOWED_CAPS >> (i * 8)) &
+			       0xff;
+
+	update_allowed_caps(caps);
+	return 0;
+}
+
+static int
+parse_and_set_caps(char *str)
+{
+	size_t len, i;
+	kernel_cap_t *caps;
+
+	/* len is guaranteed not to exceed ALLOWED_CAPS_HEX_LEN */
+	len = strlen(str);
+	for (i = 0; i < len; i++)
+		if (!isxdigit(str[i]))
+			return -EINVAL;
+
+	caps = kmalloc(sizeof(*caps), GFP_KERNEL);
+	if (!caps)
+		return -ENOMEM;
+
+	CAP_FOR_EACH_U32(i) {
+		unsigned long l;
+
+		if (kstrtoul(str + (len >= 8 ? len - 8 : 0), 16, &l))
+			return -EINVAL;
+
+		caps->cap[i] = l;
+		if (len < 8)
+			break;
+
+		len -= 8;
+		str[len] = '\0';
+	}
+
+	update_allowed_caps(caps);
+	return 0;
+}
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
+	     size_t *lenp, loff_t *ppos)
+{
+	int ret;
+
+	if (write) { /* A user is setting the allowed capabilities */
+		int error;
+		char *buf = (char *)buffer;
+		size_t len = *lenp;
+
+		if (!capable(CAP_SYS_ADMIN) || locked)
+			return -EPERM;
+
+		/* Do not allow trailing garbage or excessive length */
+		if (len == ALLOWED_CAPS_HEX_LEN + 1) {
+			if (buf[--len] != '\n')
+				return -EINVAL;
+		} else if (len > ALLOWED_CAPS_HEX_LEN || len <= 0) {
+			return -EINVAL;
+		}
+
+		error = proc_dostring(table, write, buffer, lenp, ppos);
+		if (error)
+			return error;
+
+		ret = parse_and_set_caps(allowed_caps_hex);
+	} else { /* A user is getting the allowed capabilities */
+		unsigned int i;
+		kernel_cap_t *caps;
+
+		rcu_read_lock();
+		caps = rcu_dereference(allowed_caps);
+		CAP_FOR_EACH_U32(i)
+			snprintf(allowed_caps_hex + i * 8, 9, "%08x",
+				 caps->cap[CAP_LAST_U32 - i]);
+
+		rcu_read_unlock();
+		ret = proc_dostring(table, write, buffer, lenp, ppos);
+	}
+
+	return ret;
+}
+
+struct ctl_path nax_sysctl_path[] = {
+	{ .procname = "kernel" },
+	{ .procname = "nax"    },
+	{ }
+};
+
+static struct ctl_table nax_sysctl_table[] = {
+	{
+		.procname     = "allowed_caps",
+		.data         = allowed_caps_hex,
+		.maxlen       = ALLOWED_CAPS_HEX_LEN + 1,
+		.mode         = 0644,
+		.proc_handler = nax_dostring,
+	}, {
+		.procname     = "check_all",
+		.data         = &check_all,
+		.maxlen       = sizeof(int),
+		.mode         = 0644,
+		.proc_handler = nax_dointvec_minmax,
+		.extra1       = SYSCTL_ZERO,
+		.extra2       = SYSCTL_ONE,
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
+static int __init setup_allowed_caps(char *str)
+{
+	/* Do not allow trailing garbage or excessive length */
+	if (strnlen(str, ALLOWED_CAPS_HEX_LEN + 1) > ALLOWED_CAPS_HEX_LEN) {
+		pr_err("Invalid 'nax_allowed_caps' parameter value (%s)\n",
+		       str);
+		return 1;
+	}
+
+	strscpy(allowed_caps_hex, str, sizeof(allowed_caps_hex));
+	if (parse_and_set_caps(allowed_caps_hex))
+		pr_err("Invalid 'nax_allowed_caps' parameter value (%s)\n",
+		       str);
+
+	return 1;
+}
+__setup("nax_allowed_caps=", setup_allowed_caps);
+
+static int __init setup_check_all(char *str)
+{
+	unsigned long val;
+
+	if (!kstrtoul(str, 0, &val))
+		check_all = val ? 1 : 0;
+
+	return 1;
+}
+__setup("nax_quiet=", setup_check_all);
+
+static int __init setup_locked(char *str)
+{
+	unsigned long val;
+
+	if (!kstrtoul(str, 0, &val))
+		locked = val ? 1 : 0;
+
+	return 1;
+}
+__setup("nax_locked=", setup_locked);
+
+static int __init setup_mode(char *str)
+{
+	unsigned long val;
+
+	if (!kstrtoul(str, 0, &val)) {
+		if (val > max_mode) {
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
+	if (!kstrtoul(str, 0, &val))
+		quiet = val ? 1 : 0;
+
+	return 1;
+}
+__setup("nax_quiet=", setup_quiet);
+
+static __init int
+nax_init(void)
+{
+	int rc;
+
+	pr_info("Starting.\n");
+	rc = set_default_allowed_caps();
+	if (rc < 0)
+		return rc;
+
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


