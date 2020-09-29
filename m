Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0B4727D3E5
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Sep 2020 18:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728911AbgI2Qu3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Sep 2020 12:50:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:43388 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728385AbgI2Qu3 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Sep 2020 12:50:29 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 35FBFB289;
        Tue, 29 Sep 2020 16:50:27 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v3 3/4] ima_tpm.sh: Fix calculating boot aggregate
Date:   Tue, 29 Sep 2020 18:50:20 +0200
Message-Id: <20200929165021.11731-4-pvorel@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929165021.11731-1-pvorel@suse.cz>
References: <20200929165021.11731-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

for TPM 2.0 or kernel >= v5.8-rc1:
6f1a1d103b48 ima: ("Switch to ima_hash_algo for boot aggregate")

Test still fails with TPM 2.0 on kernel < v5.8-rc1.

Test was failing, because it expect SHA1 hash, but for TPM 2.0 is
now used IMA default hash algorithm (by default default SHA256).
This is similar for entries in IMA measurement list so we can reuse
already existing code.

Reading other algorithms than sha1 or TPM 2.0 requires evmctl >= 1.3.
Although recent evmctl is recommended, to support older kernels when
sha1 is used, get boot aggregate with old our legacy ima_boot_aggregate.c.

Also fixed test without TPM device (when IMA TPM-bypass is tested)
as some TPM 2.0 devices does not export event log
(/sys/kernel/security/tpm0/binary_bios_measurements).
This does not require evmctl at all.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v2->v3:
* separate testing real HW and IMA TPM-bypass into it's own functions
* fixed checking in check_evmctl
* improve get_tpm_version to not depend on having dmesg on IMA TPM-bypass

Kind regards,
Petr

 .../security/integrity/ima/tests/ima_tpm.sh   | 153 +++++++++++++++---
 1 file changed, 131 insertions(+), 22 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
index dc958eb5c..7eb3a9409 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
@@ -7,41 +7,150 @@
 # Verify the boot and PCR aggregates.
 
 TST_CNT=2
-TST_NEEDS_CMDS="awk cut ima_boot_aggregate"
+TST_NEEDS_CMDS="awk cut"
+TST_SETUP="setup"
 
 . ima_setup.sh
 
-test1()
-{
-	tst_res TINFO "verify boot aggregate"
+EVMCTL_REQUIRED='1.3'
+ERRMSG_EVMCTL="install evmctl >= $EVMCTL_REQUIRED"
 
-	local zero="0000000000000000000000000000000000000000"
-	local tpm_bios="$SECURITYFS/tpm0/binary_bios_measurements"
-	local ima_measurements="$ASCII_MEASUREMENTS"
-	local boot_aggregate boot_hash line
+setup()
+{
+	local line tmp
 
-	# IMA boot aggregate
-	read line < $ima_measurements
-	boot_hash=$(echo $line | awk '{print $(NF-1)}' | cut -d':' -f2)
+	read line < $ASCII_MEASUREMENTS
+	if tmp=$(get_algorithm_digest "$line"); then
+		ALGORITHM=$(echo "$tmp" | cut -d'|' -f1)
+		DIGEST=$(echo "$tmp" | cut -d'|' -f2)
+	else
+		tst_res TBROK "failed to get algorithm/digest: $tmp"
+	fi
+	tst_res TINFO "used algorithm: $ALGORITHM"
 
-	if [ ! -f "$tpm_bios" ]; then
-		tst_res TINFO "TPM Hardware Support not enabled in kernel or no TPM chip found"
+	TPM_VERSION="$(get_tpm_version)"
+	if [ "$TPM_VERSION" ]; then
+		tst_res TINFO "TMP major version: $TPM_VERSION"
+	fi
 
-		if [ "$boot_hash" = "$zero" ]; then
-			tst_res TPASS "bios boot aggregate is 0"
-		else
-			tst_res TFAIL "bios boot aggregate is not 0"
+	if ! check_evmctl $EVMCTL_REQUIRED; then
+		if [ "$ALGORITHM" != "sha1" ]; then
+			tst_brk TCONF "algorithm not sha1 ($ALGORITHM), $ERRMSG_EVMCTL"
 		fi
+		MISSING_EVMCTL=1
+	fi
+}
+
+# check_evmctl REQUIRED_TPM_VERSION
+# return: 0: evmctl is new enough, 1: too old version (or version > v0.9)
+check_evmctl()
+{
+	local required="$1"
+
+	local r1="$(echo $required | cut -d. -f1)"
+	local r2="$(echo $required | cut -d. -f2)"
+	local r3="$(echo $required | cut -d. -f3)"
+	[ -z "$r3" ] && r3=0
+
+	tst_is_int "$r1" || tst_brk TBROK "required major version not int ($v1)"
+	tst_is_int "$r2" || tst_brk TBROK "required minor version not int ($v2)"
+	tst_is_int "$r3" || tst_brk TBROK "required patch version not int ($v3)"
+
+	tst_check_cmds evmctl || return 1
+
+	local v="$(evmctl --version | cut -d' ' -f2)"
+	[ -z "$v" ] && return 1
+	tst_res TINFO "evmctl version: $v"
+
+	local v1="$(echo $v | cut -d. -f1)"
+	local v2="$(echo $v | cut -d. -f2)"
+	local v3="$(echo $v | cut -d. -f3)"
+	[ -z "$v3" ] && v3=0
+
+	if [ $v1 -lt $r1 ] || [ $v1 -eq $r1 -a $v2 -lt $r2 ] || \
+		[ $v1 -eq $r1 -a $v2 -eq $r2 -a $v3 -lt $r3 ]; then
+		return 1
+	fi
+	return 0
+}
+
+# prints major version 1: TPM 1.2, 2: TPM 2.0
+# or nothing when version not detected (no TPM device)
+get_tpm_version()
+{
+	if [ -f /sys/class/tpm/tpm0/tpm_version_major ]; then
+		cat /sys/class/tpm/tpm0/tpm_version_major
+		return
+	fi
+
+	if [ -f /sys/class/tpm/tpm0/device/caps -o \
+		-f /sys/class/misc/tpm0/device/caps ]; then
+		echo 1
+		return
+	fi
+
+	if [ ! -d /sys/class/tpm/tpm0/ -a ! -d /sys/class/misc/tpm0/ ]; then
+		return
+	fi
+
+	tst_check_cmds dmesg || return
+	if dmesg | grep -q '1\.2 TPM (device-id'; then
+		echo 1
+	elif dmesg | grep -q '2\.0 TPM (device-id'; then
+		echo 2
+	fi
+}
+
+test1_virtual_tpm()
+{
+	local zero=$(echo $DIGEST | awk '{gsub(/./, "0")}; {print}')
+
+	tst_res TINFO "TPM hardware support not enabled in kernel or no TPM chip found, testing TPM-bypass"
+
+	if [ "$DIGEST" = "$zero" ]; then
+		tst_res TPASS "bios boot aggregate is $zero"
 	else
-		boot_aggregate=$(ima_boot_aggregate -f $tpm_bios | grep "sha1:" | cut -d':' -f2)
-		if [ "$boot_hash" = "$boot_aggregate" ]; then
-			tst_res TPASS "bios aggregate matches IMA boot aggregate"
-		else
-			tst_res TFAIL "bios aggregate does not match IMA boot aggregate"
+		tst_res TFAIL "bios boot aggregate is not $zero ($DIGEST)"
+	fi
+}
+
+test1_hw_tpm()
+{
+	local tpm_bios="$SECURITYFS/tpm0/binary_bios_measurements"
+	local cmd="evmctl ima_boot_aggregate"
+	local boot_aggregate
+
+	if [ "$MISSING_EVMCTL" = 1 ]; then
+		if [ ! -f "$tpm_bios" ]; then
+			tst_res TCONF "missing $tpm_bios, $ERRMSG_EVMCTL"
+			return
 		fi
+		tst_check_cmds ima_boot_aggregate || return
+		cmd="ima_boot_aggregate -f $tpm_bios"
+	fi
+	tst_res TINFO "using command: $cmd"
+
+	boot_aggregate=$($cmd | grep "$ALGORITHM:" | cut -d':' -f2)
+	if [ -z "$boot_aggregate" ]; then
+		tst_res TBROK "failed to get boot aggregate"
+		return
+	fi
+	tst_res TINFO "IMA boot aggregate: '$boot_aggregate'"
+
+	if [ "$DIGEST" = "$boot_aggregate" ]; then
+		tst_res TPASS "bios boot aggregate matches IMA boot aggregate"
+	else
+		tst_res TFAIL "bios boot aggregate does not match IMA boot aggregate ($DIGEST)"
 	fi
 }
 
+test1()
+{
+	tst_res TINFO "verify boot aggregate"
+
+	[ -z "$TPM_VERSION" ] && test1_virtual_tpm || test1_hw_tpm
+}
+
 # Probably cleaner to programmatically read the PCR values directly
 # from the TPM, but that would require a TPM library. For now, use
 # the PCR values from /sys/devices.
-- 
2.28.0

