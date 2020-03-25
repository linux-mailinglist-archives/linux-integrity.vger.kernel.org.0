Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA1E1933C2
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Mar 2020 23:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727389AbgCYW1e (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Mar 2020 18:27:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37856 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727358AbgCYW1d (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Mar 2020 18:27:33 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02PM5oIs002500
        for <linux-integrity@vger.kernel.org>; Wed, 25 Mar 2020 18:27:32 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywdr7u0nq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 25 Mar 2020 18:27:32 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 25 Mar 2020 22:27:28 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 25 Mar 2020 22:27:25 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02PMRQXA47186402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 22:27:26 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F3564C04A;
        Wed, 25 Mar 2020 22:27:26 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AC7D4C040;
        Wed, 25 Mar 2020 22:27:25 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.132.168])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 25 Mar 2020 22:27:25 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [RFC PATCH 3/3] ima_evm_utils: tests: color boot_aggregate.test tty output
Date:   Wed, 25 Mar 2020 18:26:17 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1585175177-20739-1-git-send-email-zohar@linux.ibm.com>
References: <1585175177-20739-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20032522-0012-0000-0000-0000039817EE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032522-0013-0000-0000-000021D5116D
Message-Id: <1585175177-20739-4-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-25_13:2020-03-24,2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 suspectscore=1 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250162
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Use the "functions.sh" tty color scheme, which defines SKIP as CYAN.

FAILURE: RED (31)
SUCCESS: GREEN (32)
SKIP: CYAN (36)

Should VERBOSE or informational messages be color coded?

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 tests/boot_aggregate.test | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/boot_aggregate.test b/tests/boot_aggregate.test
index 73af423e30a1..38084d5cbf45 100755
--- a/tests/boot_aggregate.test
+++ b/tests/boot_aggregate.test
@@ -49,7 +49,7 @@ swtpm_start() {
 	local swtpm="$(which tpm_server)"
 
 	if [ -z ${swtpm} ]; then
-		echo "SKIP: Softare TPM (tpm_server) not found"
+		echo $CYAN"SKIP: Softare TPM (tpm_server) not found"$NORM
 		return $SKIP
 	fi
 
@@ -68,7 +68,7 @@ swtpm_start() {
 # Initialize the software TPM using the sample binary_bios_measurements log.
 swtpm_init() {
 	if [ ! -f ${TSSDIR}/tssstartup ] || [ ! -f ${TSSDIR}/tsseventextend ]; then
-		echo "SKIP: tssstartup and tsseventextend needed for test"
+		echo $CYAN"SKIP: tssstartup and tsseventextend needed for test"$NORM
 		return $SKIP
 	fi
 
@@ -108,7 +108,7 @@ check() {
 	echo "INFO: Calculating the boot_aggregate (PCRs 0 - 7) for multiple banks"
 	bootaggr=$(evmctl ima_boot_aggregate)
 	if [ $? -ne 0 ]; then
-		echo "SKIP: evmctl ima_boot_aggregate: $bootaggr"
+		echo $CYAN"SKIP: evmctl ima_boot_aggregate: $bootaggr"$NORM
 		exit $SKIP
 	fi
 
@@ -120,11 +120,11 @@ check() {
 			echo "$hash"
 		fi
 		if grep -e "boot_aggregate$" -e "boot_aggregate.$" "${ASCII_RUNTIME_MEASUREMENTS}" | tail -n 1 | grep -q "${hash}"; then
-			echo "SUCCESS: boot_aggregate ${hash} found"
+			echo $GREEN"SUCCESS: boot_aggregate ${hash} found"$NORM
 			return $OK
 		fi
 	done
-	echo "FAILURE: boot_aggregate not found"
+	echo $RED"FAILURE: boot_aggregate not found"$NORM
 	return $FAIL
 }
 
-- 
2.7.5

