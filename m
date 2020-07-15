Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 242A8221657
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jul 2020 22:39:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727043AbgGOUhc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 16:37:32 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41108 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726650AbgGOUhb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 16:37:31 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06FKWRIc064071;
        Wed, 15 Jul 2020 16:37:28 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 329xq84pns-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 16:37:28 -0400
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06FKWU4c064462;
        Wed, 15 Jul 2020 16:37:28 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0b-001b2d01.pphosted.com with ESMTP id 329xq84pnd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 16:37:28 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06FKRS96010090;
        Wed, 15 Jul 2020 20:37:26 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06fra.de.ibm.com with ESMTP id 328rbqs8cm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 20:37:26 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06FKbOV428836280
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 20:37:24 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 31986A4040;
        Wed, 15 Jul 2020 20:37:24 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B773A404D;
        Wed, 15 Jul 2020 20:37:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.155.184])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 15 Jul 2020 20:37:23 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH 1/3] ima-evm-utils: address new compiler complaints
Date:   Wed, 15 Jul 2020 16:37:13 -0400
Message-Id: <1594845435-19164-1-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_12:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1 phishscore=0
 adultscore=0 impostorscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007150154
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Address the new compiler complaints:
- while reading the template data
- while reading the exported TPM 1.2 PCRs
- while reading the TPM event log

Reported-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 8439bec0d7ee..cd5d96f1714b 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1380,7 +1380,7 @@ static char *misc_pcrs = "/sys/class/misc/tpm0/device/pcrs";
 static int tpm_pcr_read(struct tpm_bank_info *tpm_banks, int len)
 {
 	FILE *fp = NULL;
-	char *p, pcr_str[7], buf[70]; /* length of the TPM string */
+	char *p, pcr_str[8], buf[70]; /* length of the TPM string */
 	int result = -1;
 	int i = 0;
 
@@ -1399,7 +1399,7 @@ static int tpm_pcr_read(struct tpm_bank_info *tpm_banks, int len)
 
 	for (;;) {
 		p = fgets(buf, sizeof(buf), fp);
-		if (!p)
+		if (!p || i > 99)
 			break;
 		sprintf(pcr_str, "PCR-%2.2d", i);
 		if (!strncmp(p, pcr_str, 6))
@@ -1980,11 +1980,21 @@ static int ima_measurement(const char *file)
 			 * in the template data hash calculation.
 			 */
 			len = fread(&field_len, sizeof(field_len), 1, fp);
-			if (field_len > TCG_EVENT_NAME_LEN_MAX)
+			if (len <= 0) {
+				log_errno("Failed reading file name length\n");
+				goto out;
+			}
+			if (field_len > TCG_EVENT_NAME_LEN_MAX) {
 				log_err("file pathname is too long\n");
+				goto out;
+			}
 
-			fread(entry.template + SHA_DIGEST_LENGTH,
-			      field_len, 1, fp);
+			len = fread(entry.template + SHA_DIGEST_LENGTH,
+				    field_len, 1, fp);
+			if (len != field_len) {
+				log_errno("Failed reading file name\n");
+				goto out;
+			}
 
 			/*
 			 * The template data is fixed sized, zero out
@@ -2069,6 +2079,7 @@ static int read_binary_bios_measurements(char *file, struct tpm_bank_info *bank)
 	FILE *fp;
 	SHA_CTX c;
 	int err = 0;
+	int len;
 	int i;
 
 	fp = fopen(file, "r");
@@ -2100,7 +2111,11 @@ static int read_binary_bios_measurements(char *file, struct tpm_bank_info *bank)
 			err = 1;
 			break;
 		}
-		fread(event.data, event.header.len, 1, fp);
+		len = fread(event.data, event.header.len, 1, fp);
+		if (len != event.header.len) {
+			log_errno("Failed reading event data (short read)\n");
+			break;
+		}
 	}
 	fclose(fp);
 
-- 
2.7.5

