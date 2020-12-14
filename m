Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A16BA2DA343
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Dec 2020 23:21:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438568AbgLNWUh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Dec 2020 17:20:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:44236 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2438470AbgLNWUh (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Dec 2020 17:20:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4461DAF32;
        Mon, 14 Dec 2020 22:19:55 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v5 4/4] ima_tpm.sh: Fix calculating PCR aggregate
Date:   Mon, 14 Dec 2020 23:19:46 +0100
Message-Id: <20201214221946.6340-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201214221946.6340-1-pvorel@suse.cz>
References: <20201214221946.6340-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

for TPM 2.0 and support more evmctl versions.

Because exporting PCR registers for TPM 2.0 has not been upstreamed [1],
we use user space code, which requires evmctl >= 1.3.1 and tsspcrread.
Using evmctl allows to test for TPM devices which does not export event
log (/sys/kernel/security/tpm0/binary_bios_measurements).

For TPM 1.2 read tpm0 device's pcrs file from sysfs. (tss1pcrread could
be also used, but it's not yet packaged by distros.)

For old kernels which use SHA1/MD5, any evmctl version is required (evmctl
ima_measurement was introduced in very old v0.7), but
* newer sysctl path /sys/class/tpm/tpm0/device/pcrs requires evmctl 1.1
* using ima_policy=tcb requires 1.3.1 due --ignore-violations

We now support output format of ima_measurement command for various
evmctl versions:
* 1.3: "sha256: TPM PCR-10:" (or other algorithm, e.g. "sha1:")
* 1.1-1.2.1: "HW PCR-10:" (the only previously supported format)
* 0.7-1.0: "PCR-10:"

NOTE: we ignore evmctl failure for evmctl < 1.3.1 (missing --ignore-violations,
also evmctl < 1.1 fails with "PCRAgg does not match PCR-10")

As for previous commit fix testing with TPM 2.0 device which does not
export event log (/sys/kernel/security/tpm0/binary_bios_measurements):
not wrongly assuming TPM-bypass when kernel didn't export other TPM
2.0 files we check in get_tpm_version() but bios boot aggregate is
correct (i.e. not 0x00s). In that case evmctl ima_boot_aggregate can get
boot aggregate even without TPM event log.

[1] https://patchwork.kernel.org/patch/11759729/

Co-developed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Changes v4->v5:
* improved TPM 2.0 detection (e.g. check for /dev/tpmrm0 and /dev/tpm0)
* test2: if evmctl ima_measurement fails, run again with --ignore-violations
* test2: assume TPM 2, if not detected
* print TPM kernel config
* cleanup

 .../security/integrity/ima/tests/ima_setup.sh |  14 +-
 .../security/integrity/ima/tests/ima_tpm.sh   | 176 +++++++++++++-----
 2 files changed, 144 insertions(+), 46 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
index dbf8a1db4..59a7ffeac 100644
--- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
@@ -93,7 +93,7 @@ require_ima_policy_content()
 	fi
 }
 
-require_ima_policy_cmdline()
+check_ima_policy_cmdline()
 {
 	local policy="$1"
 	local i
@@ -101,10 +101,18 @@ require_ima_policy_cmdline()
 	grep -q "ima_$policy" /proc/cmdline && return
 	for i in $(cat /proc/cmdline); do
 		if echo "$i" | grep -q '^ima_policy='; then
-			echo "$i" | grep -q -e "|[ ]*$policy" -e "$policy[ ]*|" -e "=$policy" && return
+			echo "$i" | grep -q -e "|[ ]*$policy" -e "$policy[ ]*|" -e "=$policy" && return 0
 		fi
 	done
-	tst_brk TCONF "IMA measurement tests require builtin IMA $policy policy (e.g. ima_policy=$policy kernel parameter)"
+	return 1
+}
+
+require_ima_policy_cmdline()
+{
+	local policy="$1"
+
+	check_ima_policy_cmdline $policy || \
+		tst_brk TCONF "IMA measurement tests require builtin IMA $policy policy (e.g. ima_policy=$policy kernel parameter)"
 }
 
 mount_helper()
diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
index 195fcb16c..233fdeed8 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
@@ -7,13 +7,14 @@
 # Verify the boot and PCR aggregates.
 
 TST_CNT=2
-TST_NEEDS_CMDS="awk cut"
+TST_NEEDS_CMDS="awk cut tail"
 TST_SETUP="setup"
 
 . ima_setup.sh
 
 EVMCTL_REQUIRED='1.3.1'
 ERRMSG_EVMCTL="=> install evmctl >= $EVMCTL_REQUIRED"
+ERRMSG_TPM="TPM hardware support not enabled in kernel or no TPM chip found"
 
 setup()
 {
@@ -31,7 +32,7 @@ setup()
 
 	TPM_VERSION="$(get_tpm_version)"
 	if [ -z "$TPM_VERSION" ]; then
-		tst_res TINFO "TPM hardware support not enabled in kernel or no TPM chip found, testing TPM-bypass"
+		tst_res TINFO "$ERRMSG_TPM, testing TPM-bypass"
 	else
 		tst_res TINFO "TMP major version: $TPM_VERSION"
 	fi
@@ -121,6 +122,93 @@ get_tpm_version()
 	fi
 }
 
+read_pcr_tpm1()
+{
+	local pcrs_path="/sys/class/tpm/tpm0/device/pcrs"
+	local evmctl_required="1.1"
+	local hash pcr
+
+	if [ ! -f "$pcrs_path" ]; then
+		pcrs_path="/sys/class/misc/tpm0/device/pcrs"
+	elif ! check_evmctl $evmctl_required; then
+		echo "evmctl >= $evmctl_required required"
+		return 32
+	fi
+
+	if [ ! -f "$pcrs_path" ]; then
+		echo "missing PCR file $pcrs_path ($ERRMSG_TPM)"
+		return 32
+	fi
+
+	while read line; do
+		pcr="$(echo $line | cut -d':' -f1)"
+		hash="$(echo $line | cut -d':' -f2 | awk '{ gsub (" ", "", $0); print tolower($0) }')"
+		echo "$pcr: $hash"
+	done < $pcrs_path
+
+	return 0
+}
+
+# NOTE: TPM 1.2 would require to use tss1pcrread which is not fully adopted
+# by distros yet.
+read_pcr_tpm2()
+{
+	local pcrmax=23
+	local pcrread="tsspcrread -halg $ALGORITHM"
+	local i pcr
+
+	tst_check_cmds tsspcrread || return 1
+
+	for i in $(seq 0 $pcrmax); do
+		pcr=$($pcrread -ha "$i" -ns)
+		if [ $? -ne 0 ]; then
+			echo "tsspcrread failed: $pcr"
+			return 1
+		fi
+		printf "PCR-%02d: %s\n" $i "$pcr"
+	done
+
+	return 0
+}
+
+get_pcr10_aggregate()
+{
+	local cmd="evmctl -vv ima_measurement $BINARY_MEASUREMENTS"
+	local msg="$ERRMSG_EVMCTL"
+	local res=TCONF
+	local pcr ret
+
+	if [ -z "$MISSING_EVMCTL" ]; then
+		msg=
+		res=TFAIL
+	fi
+
+	$cmd > hash.txt 2>&1
+	ret=$?
+	if [ $ret -ne 0 -a -z "$MISSING_EVMCTL" ]; then
+		tst_res TFAIL "evmctl failed, trying with --ignore-violations"
+		cmd="$cmd --ignore-violations"
+		$cmd > hash.txt 2>&1
+		ret=$?
+	elif [ $ret -ne 0 -a "$MISSING_EVMCTL" = 1 ]; then
+		tst_brk TFAIL "evmctl failed $msg"
+	fi
+
+	[ $ret -ne 0 ] && tst_res TWARN "evmctl failed, trying to continue $msg"
+
+	pcr=$(grep -E "^($ALGORITHM: )*PCRAgg(.*10)*:" hash.txt | tail -1 \
+		| awk '{print $NF}')
+
+	if [ -z "$pcr" ]; then
+		tst_res $res "failed to find aggregate PCR-10 $msg"
+		tst_res TINFO "hash file:"
+		cat hash.txt >&2
+		return
+	fi
+
+	echo "$pcr"
+}
+
 test1_tpm_bypass_mode()
 {
 	local zero=$(echo $DIGEST | awk '{gsub(/./, "0")}; {print}')
@@ -139,8 +227,10 @@ test1_hw_tpm()
 	local cmd="evmctl ima_boot_aggregate -v"
 	local boot_aggregate
 
-	[ -z "$TPM_VERSION" ] && \
+	if [ -z "$TPM_VERSION" ]; then
 		tst_res TWARN "TPM-bypass failed, trying to test TPM device (unknown TPM version)"
+		MAYBE_TPM2=1
+	fi
 
 	if [ "$MISSING_EVMCTL" = 1 ]; then
 		if [ ! -f "$tpm_bios" ]; then
@@ -174,57 +264,57 @@ test1()
 	[ -z "$TPM_VERSION" ] && test1_tpm_bypass_mode || test1_hw_tpm
 }
 
-# Probably cleaner to programmatically read the PCR values directly
-# from the TPM, but that would require a TPM library. For now, use
-# the PCR values from /sys/devices.
-validate_pcr()
+test2()
 {
-	tst_res TINFO "verify PCR (Process Control Register)"
+	local hash pcr_aggregate out ret
 
-	local dev_pcrs="$1"
-	local pcr hash aggregate_pcr
+	tst_res TINFO "verify PCR values"
 
-	aggregate_pcr="$(evmctl -v ima_measurement $BINARY_MEASUREMENTS 2>&1 | \
-		grep 'HW PCR-10:' | awk '{print $3}')"
-	if [ -z "$aggregate_pcr" ]; then
-		tst_res TFAIL "failed to get PCR-10"
-		return 1
+	if [ "$MAYBE_TPM2" = 1 ]; then
+		tst_res TINFO "TMP version not detected ($ERRMSG_TPM), assume TPM 2"
+		TPM_VERSION=2
 	fi
 
-	while read line; do
-		pcr="$(echo $line | cut -d':' -f1)"
-		if [ "$pcr" = "PCR-10" ]; then
-			hash="$(echo $line | cut -d':' -f2 | awk '{ gsub (" ", "", $0); print tolower($0) }')"
-			[ "$hash" = "$aggregate_pcr" ]
-			return $?
-		fi
-	done < $dev_pcrs
-	return 1
-}
+	if [ -z "$TPM_VERSION" ]; then
+		tst_brk TCONF "TMP version not detected ($ERRMSG_TPM)"
+	fi
 
-test2()
-{
-	tst_res TINFO "verify PCR values"
-	tst_check_cmds evmctl || return
+	if [ "$ALGORITHM" = "sha1" -a "$MISSING_EVMCTL" = 1 ]; then
+		tst_check_cmds evmctl || return 1
+	fi
 
-	tst_res TINFO "evmctl version: $(evmctl --version)"
+	out=$(read_pcr_tpm$TPM_VERSION)
+	ret=$?
 
-	local pcrs_path="/sys/class/tpm/tpm0/device/pcrs"
-	if [ -f "$pcrs_path" ]; then
-		tst_res TINFO "new PCRS path, evmctl >= 1.1 required"
-	else
-		pcrs_path="/sys/class/misc/tpm0/device/pcrs"
+	if [ $ret -ne 0 ]; then
+		case "$ret" in
+			1) tst_res TFAIL "$out";;
+			32) tst_res TCONF "$out";;
+			*) tst_brk TBROK "unsupported return type '$1'";;
+		esac
+		return
 	fi
 
-	if [ -f "$pcrs_path" ]; then
-		validate_pcr $pcrs_path
-		if [ $? -eq 0 ]; then
-			tst_res TPASS "aggregate PCR value matches real PCR value"
-		else
-			tst_res TFAIL "aggregate PCR value does not match real PCR value"
-		fi
+	hash=$(echo "$out" | grep "^PCR-10" | cut -d' ' -f2)
+
+	if [ -z "$out" ]; then
+		tst_res TFAIL "PCR-10 hash not found"
+		return
+	fi
+
+	tst_res TINFO "real PCR-10: '$hash'"
+
+	get_pcr10_aggregate > tmp.txt
+	pcr_aggregate="$(cat tmp.txt)"
+	if [ -z "$pcr_aggregate" ]; then
+		return
+	fi
+	tst_res TINFO "aggregate PCR-10: '$pcr_aggregate'"
+
+	if [ "$hash" = "$pcr_aggregate" ]; then
+		tst_res TPASS "aggregate PCR value matches real PCR value"
 	else
-		tst_res TCONF "TPM Hardware Support not enabled in kernel or no TPM chip found"
+		tst_res TFAIL "aggregate PCR value does not match real PCR value"
 	fi
 }
 
-- 
2.29.2

