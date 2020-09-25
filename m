Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD0327911E
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Sep 2020 20:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbgIYSul (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Sep 2020 14:50:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:33918 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729691AbgIYSul (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Sep 2020 14:50:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 22A57AF8D;
        Fri, 25 Sep 2020 18:50:40 +0000 (UTC)
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     Petr Vorel <pvorel@suse.cz>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Subject: [PATCH v2 4/4] ima_tpm.sh: Fix calculating PCR aggregate
Date:   Fri, 25 Sep 2020 20:50:34 +0200
Message-Id: <20200925185034.24155-5-pvorel@suse.cz>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925185034.24155-1-pvorel@suse.cz>
References: <20200925185034.24155-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

for TPM 2.0 and never evmctl versions.

Because exporting PCR registers for TPM 2.0 has not been upstreamed [1],
we use user space code, which requires evmctl 1.3.1 and tsspcrread.
Using evmctl allows to test for TPM devices which does not export event
log (/sys/kernel/security/tpm0/binary_bios_measurements).

For TPM 1.2 read tpm pcrs file (tss1pcrread could be also used, but
it's not yet packaged by distros).

Add support for never evmctl versions (>= 1.3) and very old versions,
which has different output format for ima_measurement command:
* 1.3 adds prefix for algorithm and TPM, e.g.: "sha256: TPM PCR-10:"
* old versions (v1.0, v0.9) printed only "PCR-10:"
Previously supported "HW PCR-10:" was format for ima_measurement for
evmctl 1.1.

[1] https://patchwork.kernel.org/patch/11759729/

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .../security/integrity/ima/tests/ima_tpm.sh   | 145 ++++++++++++------
 1 file changed, 102 insertions(+), 43 deletions(-)

diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
index 1fccc844b..78e81ed64 100755
--- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
+++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
@@ -14,6 +14,7 @@ TST_SETUP="setup"
 
 EVMCTL_REQUIRED='1.3'
 ERRMSG_EVMCTL="install evmctl >= $EVMCTL_REQUIRED"
+ERRMSG_TPM="TPM hardware support not enabled in kernel or no TPM chip found"
 
 setup()
 {
@@ -68,6 +69,83 @@ check_evmctl()
 	return 0
 }
 
+# prints major version 1: TPM 1.2, 2: TPM 2.0
+# or nothing when version not detected
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
+	tst_check_cmds dmesg || return
+	if dmesg | grep -q '1\.2 TPM (device-id'; then
+		echo 1
+	elif dmesg | grep -q '2\.0 TPM (device-id'; then
+		echo 2
+	fi
+}
+
+read_pcr_tpm1()
+{
+	local pcr_path="/sys/class/tpm/tpm0/device/pcrs"
+	local pcr hash
+
+	if [ ! -f "$pcrs_path" ]; then
+		pcrs_path="/sys/class/misc/tpm0/device/pcrs"
+	fi
+
+	if [ ! -f "$pcr_path" ]; then
+		tst_brk TCONF "missing PCR file $pcrs_path ($ERRMSG_TPM)"
+	fi
+
+	while read line; do
+		pcr="$(echo $line | cut -d':' -f1)"
+		hash="$(echo $line | cut -d':' -f2 | awk '{ gsub (" ", "", $0); print tolower($0) }')"
+		echo "$pcr: $hash"
+	done < $pcr_path
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
+			tst_brk TBROK "tsspcrread failed: $pcr"
+		fi
+		printf "PCR-%02d: %s\n" $i "$pcr"
+	done
+}
+
+get_pcr10_aggregate()
+{
+	local pcr
+
+	if ! evmctl -v ima_measurement $BINARY_MEASUREMENTS > hash.txt 2>&1; then
+		tst_res TBROK "evmctl failed:"
+		cat hash.txt >&2
+		return 1
+	fi
+	pcr=$(grep -E "^($ALGORITHM: TPM |HW )*PCR-10:" hash.txt \
+		| awk '{print $NF}')
+
+	echo "$pcr"
+}
+
 test1()
 {
 	tst_res TINFO "verify boot aggregate"
@@ -88,7 +166,7 @@ test1()
 
 	boot_aggregate=$($cmd | grep "$ALGORITHM:" | cut -d':' -f2)
 	if [ -z "$boot_aggregate" ]; then
-		tst_res TINFO "TPM hardware support not enabled in kernel or no TPM chip found"
+		tst_res TINFO "$ERRMSG_TPM"
 
 		zero=$(echo $DIGEST | awk '{gsub(/./, "0")}; {print}')
 		if [ "$DIGEST" = "$zero" ]; then
@@ -108,57 +186,38 @@ test1()
 	fi
 }
 
-# Probably cleaner to programmatically read the PCR values directly
-# from the TPM, but that would require a TPM library. For now, use
-# the PCR values from /sys/devices.
-validate_pcr()
+test2()
 {
-	tst_res TINFO "verify PCR (Process Control Register)"
+	local hash pcr_aggregate
 
-	local dev_pcrs="$1"
-	local pcr hash aggregate_pcr
+	tst_res TINFO "verify PCR values"
 
-	aggregate_pcr="$(evmctl -v ima_measurement $BINARY_MEASUREMENTS 2>&1 | \
-		grep 'HW PCR-10:' | awk '{print $3}')"
-	if [ -z "$aggregate_pcr" ]; then
-		tst_res TFAIL "failed to get PCR-10"
-		return 1
+	tpm_version="$(get_tpm_version)"
+	if [ -z "$tpm_version" ]; then
+		tst_brk TCONF "TMP version not detected ($ERRMSG_TPM)"
 	fi
+	tst_res TINFO "TMP major version: $tpm_version"
 
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
-
-test2()
-{
-	tst_res TINFO "verify PCR values"
-	tst_check_cmds evmctl || return
-
-	tst_res TINFO "evmctl version: $(evmctl --version)"
+	read_pcr_tpm$tpm_version > pcr.txt
+	hash=$(grep "^PCR-10" pcr.txt | cut -d' ' -f2)
+	if [ -z "$hash" ]; then
+		tst_res TBROK "PCR-10 hash not found"
+		cat pcr.txt
+		return 1
+	fi
+	tst_res TINFO "real PCR-10: '$hash'"
 
-	local pcrs_path="/sys/class/tpm/tpm0/device/pcrs"
-	if [ -f "$pcrs_path" ]; then
-		tst_res TINFO "new PCRS path, evmctl >= 1.1 required"
-	else
-		pcrs_path="/sys/class/misc/tpm0/device/pcrs"
+	pcr_aggregate="$(get_pcr10_aggregate)"
+	if [ -z "$pcr_aggregate" ]; then
+		tst_res TFAIL "failed to get aggregate PCR-10"
+		return
 	fi
+	tst_res TINFO "aggregate PCR-10: '$hash'"
 
-	if [ -f "$pcrs_path" ]; then
-		validate_pcr $pcrs_path
-		if [ $? -eq 0 ]; then
-			tst_res TPASS "aggregate PCR value matches real PCR value"
-		else
-			tst_res TFAIL "aggregate PCR value does not match real PCR value"
-		fi
+	if [ "$hash" = "$pcr_aggregate" ]; then
+		tst_res TPASS "aggregate PCR value matches real PCR value"
 	else
-		tst_res TCONF "TPM Hardware Support not enabled in kernel or no TPM chip found"
+		tst_res TFAIL "aggregate PCR value does not match real PCR value"
 	fi
 }
 
-- 
2.28.0

