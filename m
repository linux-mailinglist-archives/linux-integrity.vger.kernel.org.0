Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CF6423D6D2
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jun 2019 21:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405461AbfFKTap (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 Jun 2019 15:30:45 -0400
Received: from mx2.suse.de ([195.135.220.15]:48766 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404926AbfFKTap (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 Jun 2019 15:30:45 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BAFF2AE1D;
        Tue, 11 Jun 2019 19:30:44 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Ignaz Forster <iforster@suse.de>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v3 4/4] ima: Add overlay test + doc
Date:   Tue, 11 Jun 2019 21:30:21 +0200
Message-Id: <20190611193021.17651-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190611193021.17651-1-pvorel@suse.cz>
References: <20190611193021.17651-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

test demonstrate a bug on overlayfs on current mainline kernel when
combining IMA with EVM.

Based on reproducer made by Ignaz Forster <iforster@suse.de>
used for not upstreamed patchset [1] and previous report [2].
IMA only behavior has already been fixed [3].

NOTE: backup variables are needed because ima_setup.sh calling
tst_mount as well when TMPDIR is on tmpfs device.

Documentation is based on Ignaz Forster instructions for openSUSE [4].

[1] https://www.spinics.net/lists/linux-integrity/msg05926.html
[2] https://www.spinics.net/lists/linux-integrity/msg03593.html
[3] https://patchwork.kernel.org/patch/10776231/
[4] http://lists.linux.it/pipermail/ltp/2019-May/011956.html

Tested-by: Ignaz Forster <iforster@suse.de>
Acked-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Ignaz, you specified in [4] ima_appraise=appraise_tcb. IMHO this option
for ima_appraise does not exist. It works "triggers bug" for me without it.

Mimi, can you have a brief look on docs?

Kind regards,
Petr
---
 runtest/ima                                   |  1 +
 .../security/integrity/ima/tests/README.md    | 82 ++++++++++++++++
 .../integrity/ima/tests/evm_overlay.sh        | 94 +++++++++++++++++++
 .../security/integrity/ima/tests/ima_setup.sh |  4 +-
 4 files changed, 179 insertions(+), 2 deletions(-)
 create mode 100644 testcases/kernel/security/integrity/ima/tests/README.md
 create mode 100755 testcases/kernel/security/integrity/ima/tests/evm_overlay.sh

diff --git a/runtest/ima b/runtest/ima
index bcae16bb7..f3ea88cf0 100644
--- a/runtest/ima
+++ b/runtest/ima
@@ -3,3 +3,4 @@ ima_measurements ima_measurements.sh
 ima_policy ima_policy.sh
 ima_tpm ima_tpm.sh
 ima_violations ima_violations.sh
+evm_overlay evm_overlay.sh
diff --git a/testcases/kernel/security/integrity/ima/tests/README.md b/testcases/kernel/security/integrity/ima/tests/README.md
new file mode 100644
index 000000000..e1d106c0f
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/tests/README.md
@@ -0,0 +1,82 @@
+IMA + EVM testing
+=================
+
+IMA tests
+---------
+
+`ima_measurements.sh` require builtin IMA tcb policy to be loaded
+(`ima_policy=tcb` or `ima_policy=appraise_tcb` kernel parameter).
+Although custom policy which contains tcb can be loaded via dracut,
+systemd or later manually from user space, detecting it would require
+`IMA_READ_POLICY=y` therefore ignore this option.
+
+Mandatory kernel configuration for IMA:
+```
+CONFIG_INTEGRITY=y
+CONFIG_IMA=y
+```
+
+EVM tests
+---------
+
+`evm_overlay.sh` requires to builtin IMA appraise tcb policy (`ima_policy=appraise_tcb`
+kernel parameter) which appraises the integrity of all files owned by root.  and EVM setup.
+Again, for simplicity ignore possibility to have IMA appraise tcb policy loaded in custom policy.
+
+Mandatory kernel configuration for IMA & EVM:
+```
+CONFIG_INTEGRITY=y
+CONFIG_INTEGRITY_SIGNATURE=y
+CONFIG_IMA=y
+CONFIG_IMA_APPRAISE=y
+CONFIG_EVM=y
+CONFIG_KEYS=y
+CONFIG_TRUSTED_KEYS=y
+CONFIG_ENCRYPTED_KEYS=y
+```
+
+Example of installing IMA + EVM on openSUSE:
+
+* Boot install system with `ima_policy=appraise_tcb ima_appraise=fix evm=fix` kernel parameters
+  (for IMA measurement, IMA appraisal and EVM protection)
+* Proceed with installation until summary screen, but do not start the installation yet
+* Select package `dracut-ima` (required for early boot EVM support) for installation
+  (Debian based distros already contain IMA + EVM support in `dracut` package)
+* Change to a console window and run commands to generate keys required by EVM:
+```
+# mkdir /etc/keys
+# user_key=$(keyctl add user kmk-user "`dd if=/dev/urandom bs=1 count=32 2>/dev/null`" @u)
+# keyctl pipe "$user_key" > /etc/keys/kmk-user.blob
+# evm_key=$(keyctl add encrypted evm-key "new user:kmk-user 64" @u)
+# keyctl pipe "$evm_key" >/etc/keys/evm.blob
+# cat <<END >/etc/sysconfig/masterkey
+MASTERKEYTYPE="user"
+MASTERKEY="/etc/keys/kmk-user.blob"
+END
+# cat <<END >/etc/sysconfig/evm
+EVMKEY="/etc/keys/evm.blob"
+END
+# mount -t securityfs security /sys/kernel/security
+# echo 1 >/sys/kernel/security/evm
+```
+
+* Go back to the installation summary screen and start the installation
+* During the installation execute the following commands from the console:
+```
+# cp -r /etc/keys /mnt/etc/ # Debian based distributions: use /target instead of /mnt
+# cp /etc/sysconfig/{evm,masterkey} /mnt/etc/sysconfig/
+```
+
+This should work on any distribution using dracut.
+Loading EVM keys is also possible with initramfs-tools (Debian based distributions).
+
+Of course it's possible to install OS usual way, add keys later and fix missing xattrs with:
+```
+evmctl -r ima_fix /
+```
+
+or with `find` if evmctl not available:
+```
+find / \( -fstype rootfs -o -fstype ext4 -o -fstype btrfs -o -fstype xfs \) -exec sh -c "< '{}'" \;
+```
+Again, fixing requires `ima_policy=appraise_tcb ima_appraise=fix evm=fix` kernel parameters.
diff --git a/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh b/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh
new file mode 100755
index 000000000..054b19428
--- /dev/null
+++ b/testcases/kernel/security/integrity/ima/tests/evm_overlay.sh
@@ -0,0 +1,94 @@
+#!/bin/sh
+# Copyright (c) 2019 Petr Vorel <pvorel@suse.cz>
+# Based on reproducer and further discussion with Ignaz Forster <iforster@suse.de>
+# Reproducer for not upstreamed patchset [1] and previous report [2].
+# [1] https://www.spinics.net/lists/linux-integrity/msg05926.html
+# [2] https://www.spinics.net/lists/linux-integrity/msg03593.html
+
+TST_SETUP="setup"
+TST_CLEANUP="cleanup"
+TST_NEEDS_DEVICE=1
+TST_CNT=4
+. ima_setup.sh
+
+setup()
+{
+	EVM_FILE="/sys/kernel/security/evm"
+
+	[ -f "$EVM_FILE" ] || tst_brk TCONF "EVM not enabled in kernel"
+	[ $(cat $EVM_FILE) -eq 1 ] || tst_brk TCONF "EVM not enabled for this boot"
+
+	grep -q -e appraise_tcb /proc/cmdline || \
+		tst_brk TCONF "Test requires specify IMA builtin appraise policy as kernel parameter"
+
+	lower="$TST_MNTPOINT/lower"
+	upper="$TST_MNTPOINT/upper"
+	work="$TST_MNTPOINT/work"
+	merged="$TST_MNTPOINT/merged"
+	mkdir -p $lower $upper $work $merged
+
+	device_backup="$TST_DEVICE"
+	TST_DEVICE="overlay"
+
+	fs_type_backup="$TST_FS_TYPE"
+	TST_FS_TYPE="overlay"
+
+	mntpoint_backup="$TST_MNTPOINT"
+	TST_MNTPOINT="$merged"
+
+	params_backup="$TST_MNT_PARAMS"
+	TST_MNT_PARAMS="-o lowerdir=$lower,upperdir=$upper,workdir=$work"
+
+	tst_mount
+	mounted=1
+}
+
+test1()
+{
+	local file="foo1.txt"
+
+	tst_res TINFO "overwrite file in overlay"
+	EXPECT_PASS echo lower \> $lower/$file
+	EXPECT_PASS echo overlay \> $merged/$file
+}
+
+test2()
+{
+	local file="foo2.txt"
+
+	tst_res TINFO "append file in overlay"
+	EXPECT_PASS echo lower \> $lower/$file
+	EXPECT_PASS echo overlay \>\> $merged/$file
+}
+
+test3()
+{
+	local file="foo3.txt"
+
+	tst_res TINFO "create a new file in overlay"
+	EXPECT_PASS echo overlay \> $merged/$file
+}
+
+test4()
+{
+	local f
+
+	tst_res TINFO "read all created files"
+	for f in $(find $TST_MNTPOINT -type f); do
+		EXPECT_PASS cat $f \> /dev/null 2\> /dev/null
+	done
+}
+
+cleanup()
+{
+	[ -n "$mounted" ] || return 0
+
+	tst_umount $TST_DEVICE
+
+	TST_DEVICE="$device_backup"
+	TST_FS_TYPE="$fs_type_backup"
+	TST_MNTPOINT="$mntpoint_backup"
+	TST_MNT_PARAMS="$params_backup"
+}
+
+tst_run
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index da49eb1b2..08aa5300a 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -64,14 +64,14 @@ print_ima_config()
 	local config="/boot/config-$(uname -r)"
 	local i
 
-	tst_res TINFO "/proc/cmdline: $(cat /proc/cmdline)"
-
 	if [ -r "$config" ]; then
 		tst_res TINFO "IMA kernel config:"
 		for i in $(grep ^CONFIG_IMA $config); do
 			tst_res TINFO "$i"
 		done
 	fi
+
+	tst_res TINFO "/proc/cmdline: $(cat /proc/cmdline)"
 }
 
 ima_setup()
-- 
2.21.0

