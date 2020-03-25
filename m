Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F5431933C1
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Mar 2020 23:27:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgCYW1d (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Mar 2020 18:27:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:23438 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727389AbgCYW1d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Mar 2020 18:27:33 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02PM4YEO077105
        for <linux-integrity@vger.kernel.org>; Wed, 25 Mar 2020 18:27:29 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywe7v6bf4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 25 Mar 2020 18:27:29 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 25 Mar 2020 22:27:26 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 25 Mar 2020 22:27:24 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02PMRNdV44761246
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 22:27:23 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE8574C044;
        Wed, 25 Mar 2020 22:27:23 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99D274C040;
        Wed, 25 Mar 2020 22:27:22 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.132.168])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 25 Mar 2020 22:27:22 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [RFC PATCH 1/3] ima-evm-utils: tests: verify boot_aggregate
Date:   Wed, 25 Mar 2020 18:26:15 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1585175177-20739-1-git-send-email-zohar@linux.ibm.com>
References: <1585175177-20739-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20032522-0028-0000-0000-000003EBD2BC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032522-0029-0000-0000-000024B14208
Message-Id: <1585175177-20739-2-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-25_13:2020-03-24,2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 bulkscore=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 suspectscore=1 malwarescore=0
 priorityscore=1501 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003250166
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Calculate the boot_aggregate for each TPM bank and verify that the
boot_aggregate in the IMA measurement list matches one of them.

A software TPM may be used to verify the boot_aggregate.  If a
software TPM is not already running on the system, this test
starts one and initializes the TPM PCR banks by walking the sample
binary_bios_measurements event log, included in this directory, and
extending the TPM PCRs.  The associated ascii_runtime_measurements
for verifying the calculated boot_aggregate is included in this
directory as well.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 tests/Makefile.am                     |   2 +-
 tests/boot_aggregate.test             | 144 ++++++++++++++++++++++++++++++++++
 tests/test_ascii_runtime_measurements |   3 +
 tests/test_binary_bios_measurements   | Bin 0 -> 23248 bytes
 4 files changed, 148 insertions(+), 1 deletion(-)
 create mode 100755 tests/boot_aggregate.test
 create mode 100644 tests/test_ascii_runtime_measurements
 create mode 100644 tests/test_binary_bios_measurements

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 029f2ffd5efb..ff928e177406 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -1,7 +1,7 @@
 check_SCRIPTS =
 TESTS = $(check_SCRIPTS)
 
-check_SCRIPTS += ima_hash.test sign_verify.test
+check_SCRIPTS += ima_hash.test sign_verify.test boot_aggregate.test
 
 clean-local:
 	-rm -f *.txt *.out *.sig *.sig2
diff --git a/tests/boot_aggregate.test b/tests/boot_aggregate.test
new file mode 100755
index 000000000000..307a309433fe
--- /dev/null
+++ b/tests/boot_aggregate.test
@@ -0,0 +1,144 @@
+#!/bin/bash
+
+#
+# Calculate the boot_aggregate for each TPM bank, verifying that the
+# boot_aggregate in the IMA measurement list matches one of them.
+#
+# A software TPM may be used to verify the boot_aggregate.  If a
+# software TPM is not already running on the system, this test
+# starts one and initializes the TPM PCR banks by walking the sample
+# binary_bios_measurements event log, included in this directory, and
+# extending the TPM PCRs.  The associated ascii_runtime_measurements
+# for verifying the calculated boot_aggregate is included in this
+# directory as well.
+
+trap cleanup SIGINT SIGTERM EXIT
+
+# Base VERBOSE on the environment variable, if set.
+VERBOSE="${VERBOSE:-0}"
+
+cd $(dirname $0)
+export PATH=../src:$PATH
+export LD_LIBRARY_PATH=$LD_LIBRARY_PATH
+. ./functions.sh
+_require evmctl
+TSSDIR=$(dirname -- $(which tssstartup))
+
+if [ $(id -u) = 0 ] && [ -c "/dev/tpm0" ]; then
+	ASCII_RUNTIME_MEASUREMENTS="/sys/kernel/security/ima/ascii_runtime_measurements"
+else
+	BINARY_BIOS_MEASUREMENTS="./test_binary_bios_measurements"
+	ASCII_RUNTIME_MEASUREMENTS="./test_ascii_runtime_measurements"
+	export TPM_INTERFACE_TYPE="socsim"
+	export TPM_COMMAND_PORT=2321
+fi
+
+# Only stop this test's software TPM.  Preferred method: "tsstpmcmd -stop"
+cleanup() {
+	if [ ! -z ${SWTPM_PPID} ]; then
+		if [ -f ${TSSDIR}/tsstpmcmd ]; then
+			${TSSDIR}/tsstpmcmd -stop
+		else
+			pkill -P ${SWTPM_PPID}
+		fi
+	fi
+}
+
+# Try to start a software TPM if needed.
+swtpm_start() {
+	local swtpm="$(which tpm_server)"
+
+	if [ -z ${swtpm} ]; then
+		echo "SKIP: Softare TPM (tpm_server) not found"
+		return $SKIP
+	fi
+
+	ps -ael | grep -q tpm_server
+	if [ $? -eq 0 ]; then
+		echo "INFO: Software TPM (tpm_server) already running"
+		return 114
+	else
+		echo "INFO: Starting software TPM: ${swtpm}"
+		$(${swtpm}) 2>1 > /dev/null &
+		SWTPM_PPID=$!
+	fi
+	return 0
+}
+
+# Initialize the software TPM using the sample binary_bios_measurements log.
+swtpm_init() {
+	if [ ! -f ${TSSDIR}/tssstartup ] || [ ! -f ${TSSDIR}/tsseventextend ]; then
+		echo "SKIP: tssstartup and tsseventextend needed for test"
+		return $SKIP
+	fi
+
+	echo "INFO: Walking ${BINARY_BIOS_MEASUREMENTS} initializing the software TPM"
+	$(${TSSDIR}/tssstartup)
+	$(${TSSDIR}/tsseventextend -tpm -if "${BINARY_BIOS_MEASUREMENTS}" -v) 2>1 > /dev/null
+}
+
+# In VERBOSE mode, display the calculated TPM PCRs for the different banks.
+display_pcrs() {
+	local PCRMAX=7
+	local banks=("sha1" "sha256")
+	local i;
+
+	for bank in "${banks[@]}"; do
+		echo "INFO: Displaying ${bank} TPM bank (PCRs 0 - 7)"
+		for i in `seq 0 $PCRMAX`; do
+			rc=0
+			pcr=$(${TSSDIR}/tsspcrread -halg "${bank}" -ha "${i}" -ns)
+			if [ $rc -ne 0 ]; then
+				echo "INFO: tsspcrread failed: $tpm1"
+				break
+			fi
+			echo "$i: $pcr"
+		done
+	done
+}
+
+# The first entry in the IMA measuremnet list is the "boot_aggregate".
+check() {
+	echo "INFO: Calculating the boot_aggregate (PCRs 0 - 7) for multiple banks"
+	bootaggr=$(evmctl ima_boot_aggregate)
+	if [ $? -ne 0 ]; then
+		echo "SKIP: evmctl ima_boot_aggregate: $bootaggr"
+		exit $SKIP
+	fi
+
+	boot_aggr=( $bootaggr )
+
+	echo "INFO: Searching for the boot_aggregate in ${ASCII_RUNTIME_MEASUREMENTS}"
+	for hash in "${boot_aggr[@]}"; do
+		if [ "$VERBOSE" != "0" ]; then
+			echo "$hash"
+		fi
+		if grep -q "${hash}" "${ASCII_RUNTIME_MEASUREMENTS}"; then
+			echo "SUCCESS: boot_aggregate ${hash} found"
+			return $OK
+		fi
+	done
+	echo "FAILURE: boot_aggregate not found"
+	return $FAIL
+}
+
+# Start and initialize a software TPM as needed
+if [ $(id -u) != 0 ] || [ ! -c "/dev/tpm0" ]; then
+	swtpm_start
+	error=$?
+	if [ $error -eq $SKIP ]; then
+		exit $SKIP
+	fi
+
+	if [ $error -eq 0 ]; then
+		swtpm_init
+		if [ $? -eq $SKIP ]; then
+			exit $SKIP
+		fi
+	fi
+	if [ "$VERBOSE" != "0" ]; then
+		display_pcrs
+	fi
+fi
+
+expect_pass check
diff --git a/tests/test_ascii_runtime_measurements b/tests/test_ascii_runtime_measurements
new file mode 100644
index 000000000000..937b5038127e
--- /dev/null
+++ b/tests/test_ascii_runtime_measurements
@@ -0,0 +1,3 @@
+10 cf41b43c4031672fcc2bd358b309ad33b977424f ima-ng sha256:f1b4c7c9b27e94569f4c2b64051c452bc609c3cb891dd7fae06b758f8bc83d14 boot_aggregate
+10 983dcd8e6f7c84a1a5f10e762d1850623966ceab ima-ng sha256:ae06e032a65fed8102aff5f8f31c678dcf2eb25b826f77ecb699faa0411f89e0 /init
+10 b6e4d01c73f6e4b698eaf48e7d76a2bae0c02514 ima-ng sha256:4b1764ee112aa8b2a6ae9a3a2f1e272b6601681f610708497673cd49e5bd2f5c /bin/sh
diff --git a/tests/test_binary_bios_measurements b/tests/test_binary_bios_measurements
new file mode 100644
index 0000000000000000000000000000000000000000..338ba22f9e41e9039ff5ce81bb18197c5ac1647c
GIT binary patch
literal 23248
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

literal 0
HcmV?d00001

-- 
2.7.5

