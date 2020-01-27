Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0EDE14A7B4
	for <lists+linux-integrity@lfdr.de>; Mon, 27 Jan 2020 17:02:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbgA0QCS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 27 Jan 2020 11:02:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7096 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729146AbgA0QCS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 27 Jan 2020 11:02:18 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00RFtQcq146484
        for <linux-integrity@vger.kernel.org>; Mon, 27 Jan 2020 11:02:16 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xrg629w4a-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 27 Jan 2020 11:02:16 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 27 Jan 2020 16:02:14 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 27 Jan 2020 16:02:11 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 00RG2AKr38928892
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Jan 2020 16:02:10 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61F32A405B;
        Mon, 27 Jan 2020 16:02:10 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A03BDA4040;
        Mon, 27 Jan 2020 16:02:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.185.238])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 27 Jan 2020 16:02:09 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jerry Snitselaar <jsnitsel@redhat.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-kernel@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 1/2] ima: use the IMA configured hash algo to calculate the boot aggregate
Date:   Mon, 27 Jan 2020 11:01:58 -0500
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 20012716-0020-0000-0000-000003A46F40
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20012716-0021-0000-0000-000021FC1588
Message-Id: <1580140919-6127-1-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-27_05:2020-01-24,2020-01-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=1 phishscore=0 adultscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 bulkscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1911200001 definitions=main-2001270134
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The boot aggregate is a cumulative SHA1 hash over TPM registers 0 - 7.
NIST has depreciated the usage of SHA1 in most instances.  Instead of
continuing to use SHA1 to calculate the boot_aggregate, use the
configured IMA default hash algorithm.

Although the IMA measurement list boot_aggregate template data contains
the hash algorithm followed by the digest, allowing verifiers (e.g.
attesttaion servers) to calculate and verify the boot_aggregate, the
verifiers might not have the knowledge of what constitutes a good value
based on a different hash algorithm.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_init.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima_init.c b/security/integrity/ima/ima_init.c
index 195cb4079b2b..b1b334fe0db5 100644
--- a/security/integrity/ima/ima_init.c
+++ b/security/integrity/ima/ima_init.c
@@ -27,7 +27,7 @@ struct tpm_chip *ima_tpm_chip;
 /* Add the boot aggregate to the IMA measurement list and extend
  * the PCR register.
  *
- * Calculate the boot aggregate, a SHA1 over tpm registers 0-7,
+ * Calculate the boot aggregate, a hash over tpm registers 0-7,
  * assuming a TPM chip exists, and zeroes if the TPM chip does not
  * exist.  Add the boot aggregate measurement to the measurement
  * list and extend the PCR register.
@@ -51,14 +51,14 @@ static int __init ima_add_boot_aggregate(void)
 	int violation = 0;
 	struct {
 		struct ima_digest_data hdr;
-		char digest[TPM_DIGEST_SIZE];
+		char digest[TPM_MAX_DIGEST_SIZE];
 	} hash;
 
 	memset(iint, 0, sizeof(*iint));
 	memset(&hash, 0, sizeof(hash));
 	iint->ima_hash = &hash.hdr;
-	iint->ima_hash->algo = HASH_ALGO_SHA1;
-	iint->ima_hash->length = SHA1_DIGEST_SIZE;
+	iint->ima_hash->algo = ima_hash_algo;
+	iint->ima_hash->length = hash_digest_size[ima_hash_algo];
 
 	if (ima_tpm_chip) {
 		result = ima_calc_boot_aggregate(&hash.hdr);
-- 
2.7.5

