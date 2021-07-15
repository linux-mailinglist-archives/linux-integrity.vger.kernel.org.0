Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96F4D3C9536
	for <lists+linux-integrity@lfdr.de>; Thu, 15 Jul 2021 02:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbhGOAmO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 14 Jul 2021 20:42:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53624 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229928AbhGOAmO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 14 Jul 2021 20:42:14 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16F0XwYs188346
        for <linux-integrity@vger.kernel.org>; Wed, 14 Jul 2021 20:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=HnXkZNkBVCSUt4NsiDtWxaD6jjtjvaj1d7mqNm6WxkQ=;
 b=H5/3stLxk26dzJtcen+OyH4ceCXN/Ldd/SOkgt3LP6rVS7ExVrJSbUQ9tetuueJSzN+D
 kvz/OisqgmbZWhiur4Amv8EwPMuyfKjdGi8gBmsTERtqtReNebDJW6IPIf3eMsu3nXip
 WKe/S6iljApZFWa8Vnv+9w6ldDcBLvyuvqEcte4kdEn8HhMpclWoUfs7UGiGSi2kkk9b
 Y755zs8qJx9Jgm/QKl4j9C4nU0+LE9Xr4ghQlMTJmJHshsFQee6vEkdFFQ1D9pvwjGcI
 crH2EbUxHi5vLgxDh5RJ+Uko53NVyteApn1HE3KmHIM0/Ydc2LmeUSxNapzDeKILwZv/ tQ== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 39sde28s60-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 14 Jul 2021 20:39:21 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16F0dKx2028996
        for <linux-integrity@vger.kernel.org>; Thu, 15 Jul 2021 00:39:20 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma02fra.de.ibm.com with ESMTP id 39s3p78fym-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 15 Jul 2021 00:39:19 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16F0dGQJ30736750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 15 Jul 2021 00:39:16 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E0745204E;
        Thu, 15 Jul 2021 00:39:16 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.127.85])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 5F7CE52050;
        Thu, 15 Jul 2021 00:39:15 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH ima-evm-utils] tests: list crypto algorithm tests skipped
Date:   Wed, 14 Jul 2021 20:39:11 -0400
Message-Id: <20210715003911.827646-1-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: XGSOSCohOY3JWOUK55r8uJvY8nMYfgps
X-Proofpoint-ORIG-GUID: XGSOSCohOY3JWOUK55r8uJvY8nMYfgps
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-14_14:2021-07-14,2021-07-14 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 spamscore=0 clxscore=1015 mlxlogscore=999 impostorscore=0 adultscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107150003
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Include the list and number of crypto tests skipped in the output.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 build.sh | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/build.sh b/build.sh
index b922fa69ef04..c4d28f1302c6 100755
--- a/build.sh
+++ b/build.sh
@@ -79,8 +79,16 @@ VERBOSE=1 make check || ret=$?
 
 title "logs"
 if [ $ret -eq 0 ]; then
-	tail -3 tests/ima_hash.log
-	tail -3 tests/sign_verify.log
+	if [ -f tests/ima_hash.log ]; then
+		tail -3 tests/ima_hash.log
+		grep "skipped" tests/ima_hash.log  && \
+		   grep "skipped" tests/ima_hash.log | wc -l
+	fi
+	if [ -f tests/sign_verify.log ]; then
+		tail -3 tests/sign_verify.log
+		grep "skipped" tests/sign_verify.log  && \
+		   grep "skipped" tests/sign_verify.log | wc -l
+	fi
 	tail -20 tests/boot_aggregate.log
 	exit 0
 fi
-- 
2.27.0

