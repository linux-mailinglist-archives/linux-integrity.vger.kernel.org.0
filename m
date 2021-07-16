Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E19F3CBCAA
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jul 2021 21:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhGPTgB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Jul 2021 15:36:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:12508 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231266AbhGPTgA (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Jul 2021 15:36:00 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16GJDQPO048701
        for <linux-integrity@vger.kernel.org>; Fri, 16 Jul 2021 15:33:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=p4lzwWOZYNEAaxFmF81Q6WJUfTJmFupR3dq2pCPor+o=;
 b=ZtZ1hwGVErpNOZ7RFnImdqrjhRScIYevtocOaZ9lotXV2P7vF2y4GWLbc4trarTEuEC9
 J5N869IB/Rz+sWXUMSddzJlg/2M0MV+BEFq2t/yCmscy6s0ktRkhbJtTcJoY3IEMk+ya
 AZzfZFd6VaTzk2rY3mpB0EOi8HesPeE9DnIKm1u3ht70H6VG29i78sLiBA1y/L53XJIN
 sep/5wqVYvHadMKmIpsUWnyygnpnIda0wVk9RVh3pMxzaaoXX2M2m2tupScTUwQil6EQ
 fGxOm88UWnxGV/0C7YLko4HfsDxkEnbUFoiXw1x0opYgrt3DF39ipwg+muf0xnalM0n8 FA== 
Received: from ppma03wdc.us.ibm.com (ba.79.3fa9.ip4.static.sl-reverse.com [169.63.121.186])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39ueb4ucb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 16 Jul 2021 15:33:05 -0400
Received: from pps.filterd (ppma03wdc.us.ibm.com [127.0.0.1])
        by ppma03wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16GJSLd7021061
        for <linux-integrity@vger.kernel.org>; Fri, 16 Jul 2021 19:33:04 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma03wdc.us.ibm.com with ESMTP id 39q36ed0c1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 16 Jul 2021 19:33:04 +0000
Received: from b03ledav003.gho.boulder.ibm.com (b03ledav003.gho.boulder.ibm.com [9.17.130.234])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16GJX2Tm49152448
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jul 2021 19:33:02 GMT
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C4A3F6A05D;
        Fri, 16 Jul 2021 19:33:02 +0000 (GMT)
Received: from b03ledav003.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76F616A057;
        Fri, 16 Jul 2021 19:33:02 +0000 (GMT)
Received: from sbct-5.. (unknown [9.47.158.155])
        by b03ledav003.gho.boulder.ibm.com (Postfix) with ESMTP;
        Fri, 16 Jul 2021 19:33:02 +0000 (GMT)
From:   Stefan Berger <stefanb@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     zohar@linux.ibm.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH] evmctl: Remove left-over check S_ISDIR() for directory signing
Date:   Fri, 16 Jul 2021 15:33:00 -0400
Message-Id: <20210716193300.135084-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -eNF-ek_CJQWlcXS90a1oW4rMdpkK99q
X-Proofpoint-GUID: -eNF-ek_CJQWlcXS90a1oW4rMdpkK99q
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-16_09:2021-07-16,2021-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 bulkscore=0
 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0 mlxlogscore=995
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107160113
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Since we are not signing directory entries, remove the left-over check
with S_ISDIR().

Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/evmctl.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 04f14af..4b5a808 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -362,9 +362,7 @@ static int calc_evm_hash(const char *file, unsigned char *hash)
 		st.st_mode = strtoul(mode_str, NULL, 10);
 
 	if (!evm_immutable) {
-		if ((S_ISREG(st.st_mode) || S_ISDIR(st.st_mode)) && !generation_str) {
-			/* we cannot at the momement to get generation of
-			   special files kernel API does not support it */
+		if (S_ISREG(st.st_mode) && !generation_str) {
 			int fd = open(file, 0);
 
 			if (fd < 0) {
@@ -1115,9 +1113,7 @@ static int calc_evm_hmac(const char *file, const char *keyfile, unsigned char *h
 		goto out;
 	}
 
-	if (S_ISREG(st.st_mode) || S_ISDIR(st.st_mode)) {
-		/* we cannot at the momement to get generation of special files..
-		 * kernel API does not support it */
+	if (S_ISREG(st.st_mode)) {
 		int fd = open(file, 0);
 
 		if (fd < 0) {
-- 
2.31.1

