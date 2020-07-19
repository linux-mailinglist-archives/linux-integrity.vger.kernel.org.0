Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C91322252AD
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Jul 2020 18:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726109AbgGSQCZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 19 Jul 2020 12:02:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40564 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726131AbgGSQCY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 19 Jul 2020 12:02:24 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06JG1A3w066644;
        Sun, 19 Jul 2020 12:02:22 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32btpvdhqn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Jul 2020 12:02:22 -0400
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06JG1Vx0067756;
        Sun, 19 Jul 2020 12:02:21 -0400
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 32btpvdhqa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Jul 2020 12:02:21 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06JG0vKF004255;
        Sun, 19 Jul 2020 16:02:20 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03ams.nl.ibm.com with ESMTP id 32brq7hech-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Jul 2020 16:02:20 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06JG0sEZ49152464
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 19 Jul 2020 16:00:54 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C77C1AE05D;
        Sun, 19 Jul 2020 16:02:17 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 16395AE053;
        Sun, 19 Jul 2020 16:02:17 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.150.54])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 19 Jul 2020 16:02:16 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH 3/3] ima_evm_utils: indicate "--verify" template data digest failures
Date:   Sun, 19 Jul 2020 12:02:04 -0400
Message-Id: <1595174524-4976-3-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1595174524-4976-1-git-send-email-zohar@linux.ibm.com>
References: <1595174524-4976-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-19_03:2020-07-17,2020-07-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 adultscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 suspectscore=1
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007190119
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Helps to indicate when the template data digest verification fails.
Indicate the problematic record in the measurement list based on
log level and fail verification.

fixes: ff26f9704ec4 ("ima-evm-utils: calculate and verify the template
data digest")

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 06a2ffb879d9..faddc3c361a0 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1444,14 +1444,21 @@ static int verify = 0;
 static int ima_verify_template_hash(struct template_entry *entry)
 {
 	uint8_t digest[SHA_DIGEST_LENGTH];
+	static int line = 0;
+
+	line++;
 
 	if (!memcmp(zero, entry->header.digest, sizeof(digest)))
 		return 0;
 
 	SHA1(entry->template, entry->template_len, digest);
 
-	if (memcmp(digest, entry->header.digest, sizeof(digest)))
+	if (memcmp(digest, entry->header.digest, sizeof(digest))) {
+		if (imaevm_params.verbose > LOG_INFO)
+			log_info("Failed to verify template data digest(line %d).\n",
+				  line);
 		return 1;
+	}
 
 	return 0;
 }
@@ -1892,6 +1899,7 @@ static int ima_measurement(const char *file)
 
 	struct template_entry entry = { .template = 0 };
 	FILE *fp;
+	int verified_template_digest = 0;
 	int err_padded = -1;
 	int err = -1;
 
@@ -2020,8 +2028,12 @@ static int ima_measurement(const char *file)
 		extend_tpm_banks(&entry, num_banks, pseudo_banks,
 				 pseudo_padded_banks);
 
-		if (verify)
-			ima_verify_template_hash(&entry);
+		/* Recalculate and verify template data digest */
+		if (verify) {
+			err = ima_verify_template_hash(&entry);
+			if (err)
+				verified_template_digest = 1;
+		}
 
 		if (is_ima_template)
 			ima_show(&entry);
@@ -2058,6 +2070,11 @@ static int ima_measurement(const char *file)
 			log_info("Failed to match per TPM bank or SHA1 padded TPM digest(s).\n");
 	}
 
+	if (verified_template_digest) {
+		log_info("Failed to verify template data digest.\n");
+		err = 1;
+	}
+
 out:
 	fclose(fp);
 	return err;
-- 
2.7.5

