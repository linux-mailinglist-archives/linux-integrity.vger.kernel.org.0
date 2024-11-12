Return-Path: <linux-integrity+bounces-4089-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 387049C6413
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2024 23:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F06F8B877BB
	for <lists+linux-integrity@lfdr.de>; Tue, 12 Nov 2024 19:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EBD21CF95;
	Tue, 12 Nov 2024 19:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="m17VB18I"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-8faf.mail.infomaniak.ch (smtp-8faf.mail.infomaniak.ch [83.166.143.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98288218D7D
	for <linux-integrity@vger.kernel.org>; Tue, 12 Nov 2024 19:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731439169; cv=none; b=V8y/tup8C5ILVxj2ItPiDZD3cClTN797Kj1n+FciLWLqKgC7dAmnxEB7fQx9gMwur4vRqtotSL58b29pCPIwCx8nRzq28A0rOMpvMQOuEzYE/mwwK9QPg0KPWZPhcuMCIpypGWLSGfihKkyFcvHQebTZHQNNcZbeq2UPXyIgQzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731439169; c=relaxed/simple;
	bh=8l6WIt8jauLTFZW37gg+gO70sjS/nOaptdN3i1E50ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YsE+HJL9E4A652g1HQhpwbjXJq00qmyTOXtkbhrGKotApvhD5C6+5epG7gaYPXQY50KJSgtVAFVtYPtd/PI/bXt6dFBjQX/zABvEg3ZLTPjWis+rqG3ymGxdiUQVD+x/PMhlyIoDjjOqoz+lhRXnEwaNIsv3fAMNOdZyOAXwUGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=m17VB18I; arc=none smtp.client-ip=83.166.143.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4Xnx6t5bLszGfN;
	Tue, 12 Nov 2024 20:19:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1731439158;
	bh=7mV7wClTY5Z4sedq3JSpTrEVFPZKjdLcM++OUIKH1+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m17VB18Iks0Fs6DzzYlsVCfuwPrBW08i6VsgDgwt9CmUbFnnUOjgeelTJOkECl6m+
	 Kbgk3NFrK/KUP0DNiT0yCDfjiG9aH3HMogfdOZl6zfU2atFdfwc4xvvu1WYBXr+Iw6
	 eFOEyOi4qgnRYdE6DrWol8Y+A537+vHjaYVy0Wdo=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4Xnx6s0NL5zqsY;
	Tue, 12 Nov 2024 20:19:17 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	Serge Hallyn <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Adhemerval Zanella Netto <adhemerval.zanella@linaro.org>,
	Alejandro Colomar <alx@kernel.org>,
	Aleksa Sarai <cyphar@cyphar.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Christian Heimes <christian@python.org>,
	Dmitry Vyukov <dvyukov@google.com>,
	Elliott Hughes <enh@google.com>,
	Eric Biggers <ebiggers@kernel.org>,
	Eric Chiang <ericchiang@google.com>,
	Fan Wu <wufan@linux.microsoft.com>,
	Florian Weimer <fweimer@redhat.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	James Morris <jamorris@linux.microsoft.com>,
	Jan Kara <jack@suse.cz>,
	Jann Horn <jannh@google.com>,
	Jeff Xu <jeffxu@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Jordan R Abrahams <ajordanr@google.com>,
	Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Luca Boccassi <bluca@debian.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	"Madhavan T . Venkataraman" <madvenka@linux.microsoft.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	Matthew Wilcox <willy@infradead.org>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Nicolas Bouchinet <nicolas.bouchinet@ssi.gouv.fr>,
	Scott Shell <scottsh@microsoft.com>,
	Shuah Khan <shuah@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Steve Dower <steve.dower@python.org>,
	Steve Grubb <sgrubb@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Thibaut Sautereau <thibaut.sautereau@ssi.gouv.fr>,
	Vincent Strubel <vincent.strubel@ssi.gouv.fr>,
	Xiaoming Ni <nixiaoming@huawei.com>,
	Yin Fengwei <fengwei.yin@intel.com>,
	kernel-hardening@lists.openwall.com,
	linux-api@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH v21 2/6] security: Add EXEC_RESTRICT_FILE and EXEC_DENY_INTERACTIVE securebits
Date: Tue, 12 Nov 2024 20:18:54 +0100
Message-ID: <20241112191858.162021-3-mic@digikod.net>
In-Reply-To: <20241112191858.162021-1-mic@digikod.net>
References: <20241112191858.162021-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

The new SECBIT_EXEC_RESTRICT_FILE, SECBIT_EXEC_DENY_INTERACTIVE, and
their *_LOCKED counterparts are designed to be set by processes setting
up an execution environment, such as a user session, a container, or a
security sandbox.  Unlike other securebits, these ones can be set by
unprivileged processes.  Like seccomp filters or Landlock domains, the
securebits are inherited across processes.

When SECBIT_EXEC_RESTRICT_FILE is set, programs interpreting code should
control executable resources according to execveat(2) + AT_EXECVE_CHECK
(see previous commit).

When SECBIT_EXEC_DENY_INTERACTIVE is set, a process should deny
execution of user interactive commands (which excludes executable
regular files).

Being able to configure each of these securebits enables system
administrators or owner of image containers to gradually validate the
related changes and to identify potential issues (e.g. with interpreter
or audit logs).

It should be noted that unlike other security bits, the
SECBIT_EXEC_RESTRICT_FILE and SECBIT_EXEC_DENY_INTERACTIVE bits are
dedicated to user space willing to restrict itself.  Because of that,
they only make sense in the context of a trusted environment (e.g.
sandbox, container, user session, full system) where the process
changing its behavior (according to these bits) and all its parent
processes are trusted.  Otherwise, any parent process could just execute
its own malicious code (interpreting a script or not), or even enforce a
seccomp filter to mask these bits.

Such a secure environment can be achieved with an appropriate access
control (e.g. mount's noexec option, file access rights, LSM policy) and
an enlighten ld.so checking that libraries are allowed for execution
e.g., to protect against illegitimate use of LD_PRELOAD.

Ptrace restrictions according to these securebits would not make sense
because of the processes' trust assumption.

Scripts may need some changes to deal with untrusted data (e.g. stdin,
environment variables), but that is outside the scope of the kernel.

See chromeOS's documentation about script execution control and the
related threat model:
https://www.chromium.org/chromium-os/developer-library/guides/security/noexec-shell-scripts/

Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
Link: https://lore.kernel.org/r/20241112191858.162021-3-mic@digikod.net
---

Changes since v20:
* Move UAPI documentation to a dedicated RST file and format it.

Changes since v19:
* Replace SECBIT_SHOULD_EXEC_CHECK and SECBIT_SHOULD_EXEC_RESTRICT with
  SECBIT_EXEC_RESTRICT_FILE and SECBIT_EXEC_DENY_INTERACTIVE:
  https://lore.kernel.org/all/20240710.eiKohpa4Phai@digikod.net/
* Remove the ptrace restrictions, suggested by Andy.
* Improve documentation according to the discussion with Jeff.

New design since v18:
https://lore.kernel.org/r/20220104155024.48023-3-mic@digikod.net
---
 Documentation/userspace-api/check_exec.rst | 97 ++++++++++++++++++++++
 include/uapi/linux/securebits.h            | 24 +++++-
 security/commoncap.c                       | 29 +++++--
 3 files changed, 143 insertions(+), 7 deletions(-)

diff --git a/Documentation/userspace-api/check_exec.rst b/Documentation/userspace-api/check_exec.rst
index ad1aeaa5f6c0..1df5c7534af9 100644
--- a/Documentation/userspace-api/check_exec.rst
+++ b/Documentation/userspace-api/check_exec.rst
@@ -2,6 +2,21 @@
 Executability check
 ===================
 
+The ``AT_EXECVE_CHECK`` :manpage:`execveat(2)` flag, and the
+``SECBIT_EXEC_RESTRICT_FILE`` and ``SECBIT_EXEC_DENY_INTERACTIVE`` securebits
+are intended for script interpreters and dynamic linkers to enforce a
+consistent execution security policy handled by the kernel.  See the
+`samples/check-exec/inc.c`_ example.
+
+Whether an interpreter should check these securebits or not depends on the
+security risk of running malicious scripts with respect to the execution
+environment, and whether the kernel can check if a script is trustworthy or
+not.  For instance, Python scripts running on a server can use arbitrary
+syscalls and access arbitrary files.  Such interpreters should then be
+enlighten to use these securebits and let users define their security policy.
+However, a JavaScript engine running in a web browser should already be
+sandboxed and then should not be able to harm the user's environment.
+
 AT_EXECVE_CHECK
 ===============
 
@@ -32,3 +47,85 @@ be executable, which also requires integrity guarantees.
 To avoid race conditions leading to time-of-check to time-of-use issues,
 ``AT_EXECVE_CHECK`` should be used with ``AT_EMPTY_PATH`` to check against a
 file descriptor instead of a path.
+
+SECBIT_EXEC_RESTRICT_FILE and SECBIT_EXEC_DENY_INTERACTIVE
+==========================================================
+
+When ``SECBIT_EXEC_RESTRICT_FILE`` is set, a process should only interpret or
+execute a file if a call to :manpage:`execveat(2)` with the related file
+descriptor and the ``AT_EXECVE_CHECK`` flag succeed.
+
+This secure bit may be set by user session managers, service managers,
+container runtimes, sandboxer tools...  Except for test environments, the
+related ``SECBIT_EXEC_RESTRICT_FILE_LOCKED`` bit should also be set.
+
+Programs should only enforce consistent restrictions according to the
+securebits but without relying on any other user-controlled configuration.
+Indeed, the use case for these securebits is to only trust executable code
+vetted by the system configuration (through the kernel), so we should be
+careful to not let untrusted users control this configuration.
+
+However, script interpreters may still use user configuration such as
+environment variables as long as it is not a way to disable the securebits
+checks.  For instance, the ``PATH`` and ``LD_PRELOAD`` variables can be set by
+a script's caller.  Changing these variables may lead to unintended code
+executions, but only from vetted executable programs, which is OK.  For this to
+make sense, the system should provide a consistent security policy to avoid
+arbitrary code execution e.g., by enforcing a write xor execute policy.
+
+When ``SECBIT_EXEC_DENY_INTERACTIVE`` is set, a process should never interpret
+interactive user commands (e.g. scripts).  However, if such commands are passed
+through a file descriptor (e.g. stdin), its content should be interpreted if a
+call to :manpage:`execveat(2)` with the related file descriptor and the
+``AT_EXECVE_CHECK`` flag succeed.
+
+For instance, script interpreters called with a script snippet as argument
+should always deny such execution if ``SECBIT_EXEC_DENY_INTERACTIVE`` is set.
+
+This secure bit may be set by user session managers, service managers,
+container runtimes, sandboxer tools...  Except for test environments, the
+related ``SECBIT_EXEC_DENY_INTERACTIVE_LOCKED`` bit should also be set.
+
+Here is the expected behavior for a script interpreter according to combination
+of any exec securebits:
+
+1. ``SECBIT_EXEC_RESTRICT_FILE=0`` and ``SECBIT_EXEC_DENY_INTERACTIVE=0``
+
+   Always interpret scripts, and allow arbitrary user commands (default).
+
+   No threat, everyone and everything is trusted, but we can get ahead of
+   potential issues thanks to the call to :manpage:`execveat(2)` with
+   ``AT_EXECVE_CHECK`` which should always be performed but ignored by the
+   script interpreter.  Indeed, this check is still important to enable systems
+   administrators to verify requests (e.g. with audit) and prepare for
+   migration to a secure mode.
+
+2. ``SECBIT_EXEC_RESTRICT_FILE=1`` and ``SECBIT_EXEC_DENY_INTERACTIVE=0``
+
+   Deny script interpretation if they are not executable, but allow
+   arbitrary user commands.
+
+   The threat is (potential) malicious scripts run by trusted (and not fooled)
+   users.  That can protect against unintended script executions (e.g. ``sh
+   /tmp/*.sh``).  This makes sense for (semi-restricted) user sessions.
+
+3. ``SECBIT_EXEC_RESTRICT_FILE=0`` and ``SECBIT_EXEC_DENY_INTERACTIVE=1``
+
+   Always interpret scripts, but deny arbitrary user commands.
+
+   This use case may be useful for secure services (i.e. without interactive
+   user session) where scripts' integrity is verified (e.g.  with IMA/EVM or
+   dm-verity/IPE) but where access rights might not be ready yet.  Indeed,
+   arbitrary interactive commands would be much more difficult to check.
+
+4. ``SECBIT_EXEC_RESTRICT_FILE=1`` and ``SECBIT_EXEC_DENY_INTERACTIVE=1``
+
+   Deny script interpretation if they are not executable, and also deny
+   any arbitrary user commands.
+
+   The threat is malicious scripts run by untrusted users (but trusted code).
+   This makes sense for system services that may only execute trusted scripts.
+
+.. Links
+.. _samples/check-exec/inc.c:
+   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/samples/check-exec/inc.c
diff --git a/include/uapi/linux/securebits.h b/include/uapi/linux/securebits.h
index d6d98877ff1a..3fba30dbd68b 100644
--- a/include/uapi/linux/securebits.h
+++ b/include/uapi/linux/securebits.h
@@ -52,10 +52,32 @@
 #define SECBIT_NO_CAP_AMBIENT_RAISE_LOCKED \
 			(issecure_mask(SECURE_NO_CAP_AMBIENT_RAISE_LOCKED))
 
+/* See Documentation/userspace-api/check_exec.rst */
+#define SECURE_EXEC_RESTRICT_FILE		8
+#define SECURE_EXEC_RESTRICT_FILE_LOCKED	9  /* make bit-8 immutable */
+
+#define SECBIT_EXEC_RESTRICT_FILE (issecure_mask(SECURE_EXEC_RESTRICT_FILE))
+#define SECBIT_EXEC_RESTRICT_FILE_LOCKED \
+			(issecure_mask(SECURE_EXEC_RESTRICT_FILE_LOCKED))
+
+/* See Documentation/userspace-api/check_exec.rst */
+#define SECURE_EXEC_DENY_INTERACTIVE		10
+#define SECURE_EXEC_DENY_INTERACTIVE_LOCKED	11  /* make bit-10 immutable */
+
+#define SECBIT_EXEC_DENY_INTERACTIVE \
+			(issecure_mask(SECURE_EXEC_DENY_INTERACTIVE))
+#define SECBIT_EXEC_DENY_INTERACTIVE_LOCKED \
+			(issecure_mask(SECURE_EXEC_DENY_INTERACTIVE_LOCKED))
+
 #define SECURE_ALL_BITS		(issecure_mask(SECURE_NOROOT) | \
 				 issecure_mask(SECURE_NO_SETUID_FIXUP) | \
 				 issecure_mask(SECURE_KEEP_CAPS) | \
-				 issecure_mask(SECURE_NO_CAP_AMBIENT_RAISE))
+				 issecure_mask(SECURE_NO_CAP_AMBIENT_RAISE) | \
+				 issecure_mask(SECURE_EXEC_RESTRICT_FILE) | \
+				 issecure_mask(SECURE_EXEC_DENY_INTERACTIVE))
 #define SECURE_ALL_LOCKS	(SECURE_ALL_BITS << 1)
 
+#define SECURE_ALL_UNPRIVILEGED (issecure_mask(SECURE_EXEC_RESTRICT_FILE) | \
+				 issecure_mask(SECURE_EXEC_DENY_INTERACTIVE))
+
 #endif /* _UAPI_LINUX_SECUREBITS_H */
diff --git a/security/commoncap.c b/security/commoncap.c
index cefad323a0b1..52ea01acb453 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1302,21 +1302,38 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
 		     & (old->securebits ^ arg2))			/*[1]*/
 		    || ((old->securebits & SECURE_ALL_LOCKS & ~arg2))	/*[2]*/
 		    || (arg2 & ~(SECURE_ALL_LOCKS | SECURE_ALL_BITS))	/*[3]*/
-		    || (cap_capable(current_cred(),
-				    current_cred()->user_ns,
-				    CAP_SETPCAP,
-				    CAP_OPT_NONE) != 0)			/*[4]*/
 			/*
 			 * [1] no changing of bits that are locked
 			 * [2] no unlocking of locks
 			 * [3] no setting of unsupported bits
-			 * [4] doing anything requires privilege (go read about
-			 *     the "sendmail capabilities bug")
 			 */
 		    )
 			/* cannot change a locked bit */
 			return -EPERM;
 
+		/*
+		 * Doing anything requires privilege (go read about the
+		 * "sendmail capabilities bug"), except for unprivileged bits.
+		 * Indeed, the SECURE_ALL_UNPRIVILEGED bits are not
+		 * restrictions enforced by the kernel but by user space on
+		 * itself.
+		 */
+		if (cap_capable(current_cred(), current_cred()->user_ns,
+				CAP_SETPCAP, CAP_OPT_NONE) != 0) {
+			const unsigned long unpriv_and_locks =
+				SECURE_ALL_UNPRIVILEGED |
+				SECURE_ALL_UNPRIVILEGED << 1;
+			const unsigned long changed = old->securebits ^ arg2;
+
+			/* For legacy reason, denies non-change. */
+			if (!changed)
+				return -EPERM;
+
+			/* Denies privileged changes. */
+			if (changed & ~unpriv_and_locks)
+				return -EPERM;
+		}
+
 		new = prepare_creds();
 		if (!new)
 			return -ENOMEM;
-- 
2.47.0


