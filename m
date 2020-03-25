Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A05361933C0
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Mar 2020 23:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbgCYW1c (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Mar 2020 18:27:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:27048 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727358AbgCYW1c (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Mar 2020 18:27:32 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02PM57Uw050351
        for <linux-integrity@vger.kernel.org>; Wed, 25 Mar 2020 18:27:30 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ywewvwmhn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 25 Mar 2020 18:27:30 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 25 Mar 2020 22:27:24 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 25 Mar 2020 22:27:21 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02PMROcU41943104
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 25 Mar 2020 22:27:24 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD6554C044;
        Wed, 25 Mar 2020 22:27:24 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D8A004C040;
        Wed, 25 Mar 2020 22:27:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.132.168])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 25 Mar 2020 22:27:23 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Roberto Sassu <roberto.sassu@huawei.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Patrick Uiterwijk <puiterwi@redhat.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [RFC PATCH 2/3] ima-evm-utils: tests: verify the last "boot_aggregate" record
Date:   Wed, 25 Mar 2020 18:26:16 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1585175177-20739-1-git-send-email-zohar@linux.ibm.com>
References: <1585175177-20739-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 20032522-4275-0000-0000-000003B35FB4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20032522-4276-0000-0000-000038C89F5A
Message-Id: <1585175177-20739-3-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-25_13:2020-03-24,2020-03-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=1 spamscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2003250162
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

For each kexec, an additional "boot_aggregate" will appear in the
measurement list, assuming the previous measurement list is carried
across kexec.

Verify that the last "boot_aggregate" record in the IMA measurement list
matches.  The "boot_aggregate" is either the last field (e.g. "ima-ng")
or the second to last field (e.g. "ima-sig") in the measurement list
record.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 tests/boot_aggregate.test | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tests/boot_aggregate.test b/tests/boot_aggregate.test
index 307a309433fe..73af423e30a1 100755
--- a/tests/boot_aggregate.test
+++ b/tests/boot_aggregate.test
@@ -98,6 +98,12 @@ display_pcrs() {
 }
 
 # The first entry in the IMA measuremnet list is the "boot_aggregate".
+# For each kexec, an additional "boot_aggregate" will appear in the
+# measurement list, assuming the previous measurement list is carried
+# across the kexec.
+#
+# Verify that the last "boot_aggregate" record in the IMA measurement
+# list matches.
 check() {
 	echo "INFO: Calculating the boot_aggregate (PCRs 0 - 7) for multiple banks"
 	bootaggr=$(evmctl ima_boot_aggregate)
@@ -113,7 +119,7 @@ check() {
 		if [ "$VERBOSE" != "0" ]; then
 			echo "$hash"
 		fi
-		if grep -q "${hash}" "${ASCII_RUNTIME_MEASUREMENTS}"; then
+		if grep -e "boot_aggregate$" -e "boot_aggregate.$" "${ASCII_RUNTIME_MEASUREMENTS}" | tail -n 1 | grep -q "${hash}"; then
 			echo "SUCCESS: boot_aggregate ${hash} found"
 			return $OK
 		fi
-- 
2.7.5

