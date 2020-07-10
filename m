Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847DD21BA31
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jul 2020 18:01:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgGJQBR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jul 2020 12:01:17 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36294 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727989AbgGJQBR (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jul 2020 12:01:17 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06AFXKtQ100425;
        Fri, 10 Jul 2020 12:01:14 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 326bpshbbv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 12:01:14 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06AFZAob113542;
        Fri, 10 Jul 2020 12:01:14 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 326bpshbar-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 12:01:14 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06AFvam5023653;
        Fri, 10 Jul 2020 16:01:12 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma06ams.nl.ibm.com with ESMTP id 326bahrqr9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 10 Jul 2020 16:01:12 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06AG1Amn60883144
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Jul 2020 16:01:10 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 481544203F;
        Fri, 10 Jul 2020 16:01:10 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9C31F42041;
        Fri, 10 Jul 2020 16:01:09 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.158.149])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 10 Jul 2020 16:01:09 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH v2 6/8] ima-evm-utils: the IMA measurement list may have too many measurements
Date:   Fri, 10 Jul 2020 12:00:57 -0400
Message-Id: <1594396859-9232-7-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1594396859-9232-1-git-send-email-zohar@linux.ibm.com>
References: <1594396859-9232-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-10_10:2020-07-10,2020-07-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 mlxlogscore=999 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 bulkscore=0 malwarescore=0 mlxscore=0 phishscore=0 adultscore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007100104
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Reading the TPM PCRs before walking the measurement list guarantees
the measurement list contains all the records, possibly too many records.
Compare the re-calculated hash after each extend with both the per bank
TPM PCR digests and the SHA1 paddeded TPM PCR digests.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 33 ++++++++++++++++++++++-----------
 1 file changed, 22 insertions(+), 11 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 5787887882b4..88fd8e4c31f0 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1881,6 +1881,7 @@ static int ima_measurement(const char *file)
 
 	struct template_entry entry = { .template = 0 };
 	FILE *fp;
+	int err_padded = -1;
 	int err = -1;
 
 	errno = 0;
@@ -2006,24 +2007,34 @@ static int ima_measurement(const char *file)
 			ima_show(&entry);
 		else
 			ima_ng_show(&entry);
+
+		if (!tpmbanks)
+			continue;
+
+		/* The measurement list might contain too many entries,
+		 * compare the re-calculated TPM PCR values after each
+		 * extend.
+		 */
+		err = compare_tpm_banks(num_banks, pseudo_banks, tpm_banks);
+		if (!err)
+			break;
+
+		/* Compare against original SHA1 zero padded TPM PCR values */
+		err_padded = compare_tpm_banks(num_banks, pseudo_padded_banks,
+					       tpm_banks);
+		if (!err_padded)
+			break;
 	}
 
 	if (tpmbanks == 0)
 		log_info("Failed to read any TPM PCRs\n");
 	else {
-		err = compare_tpm_banks(num_banks, pseudo_banks, tpm_banks);
 		if (!err)
 			log_info("Matched per TPM bank calculated digest(s).\n");
-
-		/* On failure, check older SHA1 zero padded hashes */
-		if (err) {
-			err = compare_tpm_banks(num_banks, pseudo_padded_banks,
-						tpm_banks);
-			if (!err)
-				log_info("Matched SHA1 padded TPM digest(s).\n");
-		}
-
-		if (err)
+		else if (!err_padded) {
+			log_info("Matched SHA1 padded TPM digest(s).\n");
+			err = 0;
+		} else
 			log_info("Failed to match per TPM bank or SHA1 padded TPM digest(s).\n");
 	}
 
-- 
2.7.5

