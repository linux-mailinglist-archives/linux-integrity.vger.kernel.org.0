Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2D992D2C20
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Dec 2020 14:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728318AbgLHNjd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Dec 2020 08:39:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:26604 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727322AbgLHNjd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Dec 2020 08:39:33 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B8DYPkv060586;
        Tue, 8 Dec 2020 08:38:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references; s=pp1;
 bh=iW4WVj6XX1HS1UJ4/hk7vW6MfFQHuVHyoJwKWcsg/sg=;
 b=QurStv8qyA3Cn1HobAq0UCxrd7n4/C+oxy/F06bZ2GeXK52DzKW4X454YkjSbjZ7USrE
 /BmCmPSW6awo8FrBNPeuBEeOQIG/GzAfBjsokxDFrez6VgtMwBTQhgLgBSYb2Dnq3xpX
 KW18WD1lXf+eJBvX6rLoVyMUKKVwRMsaMgg+/2WAEL/pwuTTKi+tWm7za5ZSfZedO+05
 /SXcrF977YEOQj0g6nZX/ZNV1BVgx9CvTYklvhA04dBJ/Mrh55BowQDPHicCAGKb1BUr
 3ZJuGwpFlsDu99lViEgixvQx4Ny8qTOcaRmmSuhW95VOz/cs89k655tpodI1gqq4NqO+ Vg== 
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35a61x871c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 08:38:19 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B8Dbt9E003471;
        Tue, 8 Dec 2020 13:38:17 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03fra.de.ibm.com with ESMTP id 3581u8naqj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 13:38:17 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B8Db0Sv9110226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Dec 2020 13:37:00 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5A5EF4203F;
        Tue,  8 Dec 2020 13:37:00 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 65B5F42045;
        Tue,  8 Dec 2020 13:36:59 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.65.221.14])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  8 Dec 2020 13:36:59 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Vitaly Chikunov <vt@altlinux.org>,
        Roberto Sassu <roberto.sassu@huawei.com>
Subject: [ima-evm-utils][PATCH 2/2] tests: add test to verify EVM portable and immutable signatures
Date:   Tue,  8 Dec 2020 08:36:39 -0500
Message-Id: <20201208133639.538269-3-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20201208133639.538269-1-zohar@linux.ibm.com>
References: <20201208133639.538269-1-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-08_09:2020-12-08,2020-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=946
 impostorscore=0 spamscore=0 suspectscore=1 phishscore=0 clxscore=1015
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012080084
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Now that evmctl supports verifying EVM portable and immutable signatures,
add the test.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 tests/sign_verify.test | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/tests/sign_verify.test b/tests/sign_verify.test
index 288e1330184e..d1ae17b58aa1 100755
--- a/tests/sign_verify.test
+++ b/tests/sign_verify.test
@@ -328,9 +328,14 @@ try_different_sigs() {
     expect_fail check_verify TYPE=ima
   fi
 
-  # Test --portable
-  expect_pass check_sign OPTS="$OPTS --portable" PREFIX=0x05
-  # Cannot be verified for now, until that support is added to evmctl
+  # Test --portable (only supported for V2 signatures)
+  if expect_pass check_sign OPTS="$OPTS --portable --imahash" PREFIX=0x05; then
+     if [[ "$OPTS" =~ --rsa ]]; then
+        expect_fail check_verify
+     else
+        expect_pass check_verify
+     fi
+  fi
 
   # Test -i (immutable)
   expect_pass check_sign OPTS="$OPTS -i" PREFIX=0x0303
-- 
2.18.4

