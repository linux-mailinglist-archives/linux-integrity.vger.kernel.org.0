Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27CD12219A9
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jul 2020 03:56:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726984AbgGPB4n (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jul 2020 21:56:43 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:58780 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726905AbgGPB4n (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jul 2020 21:56:43 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06G1W5G1161094;
        Wed, 15 Jul 2020 21:56:40 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 329cum2m6d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 21:56:40 -0400
Received: from m0098399.ppops.net (m0098399.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 06G1Xr67169094;
        Wed, 15 Jul 2020 21:56:40 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 329cum2m5w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 15 Jul 2020 21:56:40 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06G1o2YD004391;
        Thu, 16 Jul 2020 01:56:37 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 327527w6a4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Jul 2020 01:56:37 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06G1uZgo59703324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jul 2020 01:56:35 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8AA34AE051;
        Thu, 16 Jul 2020 01:56:35 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B60B6AE04D;
        Thu, 16 Jul 2020 01:56:34 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.155.184])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 16 Jul 2020 01:56:34 +0000 (GMT)
Message-ID: <1594864594.12900.359.camel@linux.ibm.com>
Subject: Re: [PATCH 1/3 v1] ima-evm-utils: address new compiler complaints
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Bruno Meneguele <bmeneg@redhat.com>
Date:   Wed, 15 Jul 2020 21:56:34 -0400
In-Reply-To: <1594845435-19164-1-git-send-email-zohar@linux.ibm.com>
References: <1594845435-19164-1-git-send-email-zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-15_12:2020-07-15,2020-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 adultscore=0 spamscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=1 mlxlogscore=999 mlxscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007160005
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
Changelog v1:

- Fix fread() tests

 src/evmctl.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 8439bec0d7ee..f910e2752516 100644
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
+			if (len != 1) {
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
+		if (len != 1) {
+			log_errno("Failed reading event data (short read)\n");
+			break;
+		}
 	}
 	fclose(fp);
 
-- 
2.7.5
