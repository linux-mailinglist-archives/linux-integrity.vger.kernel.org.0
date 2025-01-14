Return-Path: <linux-integrity+bounces-4549-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F101CA10562
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 12:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE9C167C04
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Jan 2025 11:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC15224B07;
	Tue, 14 Jan 2025 11:29:29 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FBE24335A
	for <linux-integrity@vger.kernel.org>; Tue, 14 Jan 2025 11:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736854169; cv=none; b=nx35lRfDDEYMYav20S3ZR6VIjEt3kK4pHcDDCsLso1Y17mnCftT7bFWA8K/7pDRXjdoUx8WxT9aLIsaU28h6+/fcXexE6Js7Pu/BaMHLUs4JJVShg+PY8h7UxsgbMFfUU+oCi7KEz7b11teRmmaiOqRbQ891tsKEoM0nf6mDupw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736854169; c=relaxed/simple;
	bh=UuaYUxK/SAMpzTOQicsMlZXUIud0UBXcgo+2cmQ+eAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WNP/iNM5yLxEz3vioSHSmfnJ9oaTN7s+qyCRyA33EfjCpzeaeJf/H3M/txBgOmZLqI0pyX91Jx3c3DTd5crntRezuzLOGxbVUV6Sl1Ck0kAau4tNw/GQlPUDxG3++FO4Q1+axb0fuw3l2eppfjUplqqmNK/4fs3bom3b4LDpWjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 6DDE31F395;
	Tue, 14 Jan 2025 11:29:25 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4908B139CB;
	Tue, 14 Jan 2025 11:29:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id gF2AEJVKhmeMIAAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 14 Jan 2025 11:29:25 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
	Mimi Zohar <zohar@linux.ibm.com>,
	linux-integrity@vger.kernel.org
Subject: [PATCH v3 08/10] ima_setup.sh: Allow to load predefined policy
Date: Tue, 14 Jan 2025 12:29:13 +0100
Message-ID: <20250114112915.610297-9-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250114112915.610297-1-pvorel@suse.cz>
References: <20250114112915.610297-1-pvorel@suse.cz>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 6DDE31F395
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

environment variable LTP_IMA_LOAD_POLICY=1 tries to load example policy
if available. This should be used only if tooling running LTP tests
allows to reboot afterwards because policy may be writable only once,
e.g. missing CONFIG_IMA_WRITE_POLICY=y, or policies can influence each
other.

Loading may fail due various reasons (e.g. previously mentioned missing
CONFIG_IMA_WRITE_POLICY=y and policy already loaded or when secure boot is
enabled and the kernel is configured with CONFIG_IMA_ARCH_POLICY enabled, an
appraise func=POLICY_CHECK appraise_type=imasig rule is loaded, requiring the
IMA policy itself to be signed).

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/users/setup_tests.rst                     |  3 +
 .../kernel/security/integrity/ima/README.md   | 12 ++++
 .../security/integrity/ima/tests/ima_kexec.sh |  1 +
 .../security/integrity/ima/tests/ima_keys.sh  |  1 +
 .../integrity/ima/tests/ima_measurements.sh   |  2 +-
 .../integrity/ima/tests/ima_selinux.sh        |  1 +
 .../security/integrity/ima/tests/ima_setup.sh | 72 ++++++++++++++++---
 7 files changed, 82 insertions(+), 10 deletions(-)

diff --git a/doc/users/setup_tests.rst b/doc/users/setup_tests.rst
index 721ec6bb5e..9d7f9b2cd9 100644
--- a/doc/users/setup_tests.rst
+++ b/doc/users/setup_tests.rst
@@ -59,6 +59,9 @@ users.
        both up and down with this multiplier. This is not yet implemented in the
        shell API.
 
+   * - LTP_IMA_LOAD_POLICY
+     - Load IMA example policy, see :master:`testcases/kernel/security/integrity/ima/README.md`.
+
    * - LTP_VIRT_OVERRIDE
      - Overrides virtual machine detection in the test library. Setting it to
        empty string, tells the library that system is not a virtual machine.
diff --git a/testcases/kernel/security/integrity/ima/README.md b/testcases/kernel/security/integrity/ima/README.md
index 5b261a1914..c5b3db1a5a 100644
--- a/testcases/kernel/security/integrity/ima/README.md
+++ b/testcases/kernel/security/integrity/ima/README.md
@@ -8,6 +8,18 @@ CONFIG_INTEGRITY=y
 CONFIG_IMA=y
 ```
 
+### Loading policy for testing (optional)
+Setting environment variable `LTP_IMA_LOAD_POLICY=1` tries to load example
+policy if available. This should be used only if tooling running LTP tests
+allows to reboot afterwards because policy may be writable only once, e.g.
+missing `CONFIG_IMA_WRITE_POLICY=y`, or policies can influence each other.
+
+Loading may fail due various reasons (e.g. previously mentioned missing
+`CONFIG_IMA_WRITE_POLICY=y` and policy already loaded or when secure boot is
+enabled and the kernel is configured with `CONFIG_IMA_ARCH_POLICY` enabled, an
+`appraise func=POLICY_CHECK appraise_type=imasig` rule is loaded, requiring the
+IMA policy itself to be signed).
+
 ### IMA measurement tests
 `ima_measurements.sh` require builtin IMA tcb policy to be loaded
 (`ima_policy=tcb` kernel parameter).
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
index 95e6186bb5..5d178494b7 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
@@ -7,6 +7,7 @@
 # Verify that kexec cmdline is measured correctly.
 # Test attempts to kexec the existing running kernel image.
 # To kexec a different kernel image export IMA_KEXEC_IMAGE=<pathname>.
+# Test requires example IMA policy loadable with LTP_IMA_LOAD_POLICY=1.
 
 TST_NEEDS_CMDS="grep kexec sed"
 TST_CNT=3
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
index a2e9c77738..fb1636a8b8 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
@@ -5,6 +5,7 @@
 # Author: Lachlan Sneff <t-josne@linux.microsoft.com>
 #
 # Verify that keys are measured correctly based on policy.
+# Test requires example IMA policy loadable with LTP_IMA_LOAD_POLICY=1.
 
 TST_NEEDS_CMDS="cmp cut grep sed"
 TST_CNT=2
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
index 41d53aa03b..c42c31c898 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
@@ -5,7 +5,7 @@
 # Author: Mimi Zohar <zohar@linux.ibm.com>
 #
 # Verify that measurements are added to the measurement list based on policy.
-# Test requires ima_policy=tcb.
+# Test requires either ima_policy=tcb or example policy loadable with LTP_IMA_LOAD_POLICY=1.
 
 TST_NEEDS_CMDS="awk cut sed"
 TST_SETUP="setup"
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
index 45fd741b5f..97c5d64ec5 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
@@ -5,6 +5,7 @@
 # Author: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
 #
 # Verify measurement of SELinux policy hash and state.
+# Test requires example IMA policy loadable with LTP_IMA_LOAD_POLICY=1.
 #
 # Relevant kernel commits:
 # * fdd1ffe8a812 ("selinux: include a consumer of the new IMA critical data hook")
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index 1f01f18cf6..5213763ee0 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -75,14 +75,20 @@ require_policy_readable()
 	fi
 }
 
-require_policy_writable()
+check_policy_writable()
 {
-	local err="IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y)"
-
-	[ -f $IMA_POLICY ] || tst_brk TCONF "$err"
-	# CONFIG_IMA_READ_POLICY
+	[ -f $IMA_POLICY ] || return 1
+	# workaround for kernels < v4.18 without fix
+	# ffb122de9a60b ("ima: Reflect correct permissions for policy")
 	echo "" 2> log > $IMA_POLICY
-	grep -q "Device or resource busy" log && tst_brk TCONF "$err"
+	grep -q "Device or resource busy" log && return 1
+	return 0
+}
+
+require_policy_writable()
+{
+	check_policy_writable || tst_brk TCONF \
+		"IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y)"
 }
 
 check_ima_policy_content()
@@ -182,16 +188,58 @@ verify_ima_policy()
 			# check IMA policy content
 			while read line; do
 				if ! grep -q "$line" $IMA_POLICY; then
-					tst_brk TCONF "missing required policy '$line'"
+					tst_res TINFO "WARNING: missing required policy content: '$line'"
+					return 1
 				fi
-				IMA_POLICY_CHECKED=1
 			done < $file
+			IMA_POLICY_CHECKED=1
 		else
 			tst_res TINFO "policy is not readable, failure will be treated as TCONF"
 			IMA_FAIL="TCONF"
 			IMA_BROK="TCONF"
+			return 1
 		fi
 	fi
+	return 0
+}
+
+load_ima_policy()
+{
+	local file="$TST_DATAROOT/$REQUIRED_POLICY_CONTENT"
+
+	if [ "$LTP_IMA_LOAD_POLICY" != 1 -a "$IMA_POLICY_CHECKED" != 1 ]; then
+		tst_res TCONF "missing required policy, example policy can be loaded with LTP_IMA_LOAD_POLICY=1"
+		return 0
+	fi
+
+	if [ "$IMA_POLICY_CHECKED" = 1 ]; then
+		tst_res TINFO "valid policy already loaded, ignore LTP_IMA_LOAD_POLICY=1"
+	fi
+
+	tst_res TINFO "trying to load '$file' policy:"
+	cat $file
+	if ! check_policy_writable; then
+		tst_res TINFO "WARNING: IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y), reboot required, failures will be treated as TCONF"
+		IMA_FAIL="TCONF"
+		IMA_BROK="TCONF"
+		LTP_IMA_LOAD_POLICY=
+		return
+	fi
+
+	cat "$file" 2> log > $IMA_POLICY
+	if grep -q "Device or resource busy" log; then
+		tst_brk TBROK "loading policy failed"
+	fi
+
+	if grep -q "write error: Permission denied" log; then
+		tst_brk TCONF "loading unsigned policy failed"
+	fi
+
+	IMA_POLICY_LOADED=1
+
+	tst_res TINFO "example policy successfully loaded"
+	IMA_FAIL="TFAIL"
+	IMA_BROK="TBROK"
 }
 
 ima_setup()
@@ -216,7 +264,9 @@ ima_setup()
 		cd "$TST_MNTPOINT"
 	fi
 
-	verify_ima_policy
+	if ! verify_ima_policy; then
+		load_ima_policy
+	fi
 
 	[ -n "$TST_SETUP_CALLER" ] && $TST_SETUP_CALLER
 }
@@ -230,6 +280,10 @@ ima_cleanup()
 	for dir in $UMOUNT; do
 		umount $dir
 	done
+
+	if [ "$IMA_POLICY_LOADED" = 1 ]; then
+		tst_res TINFO "WARNING: policy loaded via LTP_IMA_LOAD_POLICY=1, reboot recommended"
+	fi
 }
 
 set_digest_index()
-- 
2.47.1


