Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 265CCAF32D
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2019 01:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfIJXSn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 10 Sep 2019 19:18:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4710 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725876AbfIJXSn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 10 Sep 2019 19:18:43 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8ANGuXZ008464
        for <linux-integrity@vger.kernel.org>; Tue, 10 Sep 2019 19:18:42 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uxgb0s7q8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 10 Sep 2019 19:18:42 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 11 Sep 2019 00:18:40 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 11 Sep 2019 00:18:37 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8ANIakl36438526
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 10 Sep 2019 23:18:36 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 793B011C04A;
        Tue, 10 Sep 2019 23:18:36 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 685F111C058;
        Tue, 10 Sep 2019 23:18:35 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.200.169])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 10 Sep 2019 23:18:35 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH] selftest/trustedkeys: TPM 1.2 trusted keys test
Date:   Tue, 10 Sep 2019 19:18:31 -0400
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 19091023-4275-0000-0000-0000036433E3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091023-4276-0000-0000-00003876899A
Message-Id: <1568157511-5464-1-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-10_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=665 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909100218
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Create, save and load trusted keys test

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 tools/testing/selftests/tpm2/Makefile            |  2 +-
 tools/testing/selftests/tpm2/test_trustedkeys.sh | 99 ++++++++++++++++++++++++
 2 files changed, 100 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/tpm2/test_trustedkeys.sh

diff --git a/tools/testing/selftests/tpm2/Makefile b/tools/testing/selftests/tpm2/Makefile
index 9dd848427a7b..6c76495c9a69 100644
--- a/tools/testing/selftests/tpm2/Makefile
+++ b/tools/testing/selftests/tpm2/Makefile
@@ -1,4 +1,4 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 include ../lib.mk
 
-TEST_PROGS := test_smoke.sh test_space.sh
+TEST_PROGS := test_smoke.sh test_space.sh test_trustedkey.sh
diff --git a/tools/testing/selftests/tpm2/test_trustedkeys.sh b/tools/testing/selftests/tpm2/test_trustedkeys.sh
new file mode 100755
index 000000000000..00b041d31646
--- /dev/null
+++ b/tools/testing/selftests/tpm2/test_trustedkeys.sh
@@ -0,0 +1,99 @@
+#!/bin/sh
+
+VERBOSE="${VERBOSE:-1}"
+TRUSTEDKEY1="$(mktemp -u XXXX).blob"
+TRUSTEDKEY2="$(mktemp -u XXXX).blob"
+trap "{ rm -f $TRUSTEDKEY1 $TRUSTEDKEY2 ; }" EXIT
+
+log_info()
+{
+        [ $VERBOSE -ne 0 ] && echo "[INFO] $1"
+}
+
+# The ksefltest framework requirement returns 0 for PASS.
+log_pass()
+{
+        [ $VERBOSE -ne 0 ] && echo "$1 [PASS]"
+        exit 0
+}
+
+# The ksefltest framework requirement returns 1 for FAIL.
+log_fail()
+{
+        [ $VERBOSE -ne 0 ] && echo "$1 [FAIL]"
+        exit 1
+}
+
+# The ksefltest framework requirement returns 4 for SKIP.
+log_skip()
+{
+        [ $VERBOSE -ne 0 ] && echo "$1"
+        exit 4
+}
+
+is_tpm1()
+{
+	local pcrs_path="/sys/class/tpm/tpm0/device/pcrs"
+	if [ ! -f "$pcrs_path" ]; then
+		pcrs_path="/sys/class/misc/tpm0/device/pcrs"
+	fi
+
+	if [ ! -f "$pcrs_path" ]; then
+		log_skip "TPM 1.2 chip not found"
+	fi
+}
+
+takeownership_info()
+{
+	which tcsd > /dev/null 2>&1 || \
+		log_skip "tcsd not found, install trousers"
+
+	which tpm_takeownership > /dev/null 2>&1 || \
+		log_skip "tpm_takeownerhip not found, install tpm-tools"
+
+	log_info "creating trusted key failed, probably requires taking TPM ownership:"
+	log_info "	systemctl start tcsd"
+	log_info "	tpm_takeownership -u -z"
+	log_fail "creating trusted key"
+}
+
+test_trustedkey()
+{
+	local keyid="$(keyctl add trusted kmk-test "new 64" @u)" &> /dev/null
+	if [ -z "$keyid" ]; then
+		takeownership_info
+	fi
+
+	if [ $? -eq 0 ]; then
+		log_info "creating trusted key succeeded"
+	else
+		log_fail "creating trusted key failed"
+	fi
+
+	# save newly created trusted key and remove from keyring
+	keyctl pipe "$keyid" > "$TRUSTEDKEY1"
+	keyctl unlink "$keyid" &> /dev/null
+
+	keyid=$(keyctl add trusted kmk-test "load `cat $TRUSTEDKEY1`" @u)
+	if [ $? -eq 0 ]; then
+		log_info "loading trusted key succeeded"
+	else
+		log_fail "loading trusted key failed"
+	fi
+
+	# save loaded trusted key and remove from keyring again
+	keyctl pipe "$keyid" > "$TRUSTEDKEY2"
+	keyctl unlink "$keyid" &> /dev/null
+
+	# compare trusted keys
+	diff "$TRUSTEDKEY1" "$TRUSTEDKEY2" &> /dev/null
+	ret=$?
+	if [ $ret -eq 0 ]; then
+		log_pass "trusted key test succeeded"
+	else
+		log_fail "trusted key test failed"
+	fi
+}
+
+is_tpm1
+test_trustedkey
-- 
2.7.5

