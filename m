Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E53421640A
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2020 04:28:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727097AbgGGC2t (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jul 2020 22:28:49 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46950 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726900AbgGGC2t (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jul 2020 22:28:49 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06722OGI193332;
        Mon, 6 Jul 2020 22:28:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 324faph59m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 22:28:47 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0672GB3N045909;
        Mon, 6 Jul 2020 22:28:46 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0b-001b2d01.pphosted.com with ESMTP id 324faph58s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Jul 2020 22:28:46 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0672QLOO025189;
        Tue, 7 Jul 2020 02:28:44 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma02fra.de.ibm.com with ESMTP id 322hd82ws1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 07 Jul 2020 02:28:44 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0672RRS461735102
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 7 Jul 2020 02:27:27 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C4B4A404D;
        Tue,  7 Jul 2020 02:27:27 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CB790A4040;
        Tue,  7 Jul 2020 02:27:26 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.174.194])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  7 Jul 2020 02:27:26 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Petr Vorel <pvorel@suse.cz>,
        Bruno Meneguele <bmeneg@redhat.com>
Subject: [PATCH 1/3] ima-evm-utils: support the original "ima" template
Date:   Mon,  6 Jul 2020 22:27:15 -0400
Message-Id: <1594088837-27526-2-git-send-email-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1594088837-27526-1-git-send-email-zohar@linux.ibm.com>
References: <1594088837-27526-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-07_01:2020-07-06,2020-07-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 phishscore=0
 spamscore=0 adultscore=0 mlxscore=0 suspectscore=1 malwarescore=0
 lowpriorityscore=0 cotscore=-2147483648 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007070010
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The original "ima" template digest included just a SHA1 file data hash
and a fixed 255 character pathname in the hash calculation.  Two main
differences exist between the "ima" template and other template formats.
The other template data formats are prefixed with the template data
length and each field is prefixed with the field length,

These differences simplify verifying the other template formats against
the TPM PCRs without necessarily understanding each and every template
field.

Support for the original "ima" templat formate is based on the original
LTP and IMA standalone versions.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 79 ++++++++++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 66 insertions(+), 13 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 9162de2a5aeb..b157c452839b 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1424,18 +1424,22 @@ static int ima_verify_template_hash(struct template_entry *entry)
 
 	SHA1(entry->template, entry->template_len, digest);
 
-	if (memcmp(digest, entry->header.digest, sizeof(digest))) {
-		log_err("template hash error\n");
+	if (memcmp(digest, entry->header.digest, sizeof(digest)))
 		return 1;
-	}
 
 	return 0;
 }
 
 void ima_show(struct template_entry *entry)
 {
-	log_debug("ima, digest: ");
-	log_debug_dump(entry->header.digest, sizeof(entry->header.digest));
+	if (imaevm_params.verbose <= LOG_INFO)
+		return;
+
+	log_info("%d ", entry->header.pcr);
+	log_dump_n(entry->header.digest, sizeof(entry->header.digest));
+	log_info(" %s ", entry->name);
+	log_dump_n(entry->template, SHA_DIGEST_LENGTH);
+	log_info(" %s\n", entry->template + SHA_DIGEST_LENGTH);
 }
 
 /*
@@ -1826,6 +1830,7 @@ static int ima_measurement(const char *file)
 {
 	struct tpm_bank_info *pseudo_banks;
 	struct tpm_bank_info *tpm_banks;
+	int is_ima_template;
 	int num_banks = 0;
 
 	struct template_entry entry = { .template = 0 };
@@ -1851,16 +1856,31 @@ static int ima_measurement(const char *file)
 		init_public_keys("/etc/keys/x509_evm.der");
 
 	while (fread(&entry.header, sizeof(entry.header), 1, fp)) {
+		if (entry.header.name_len > TCG_EVENT_NAME_LEN_MAX) {
+			log_err("%d ERROR: event name too long!\n",
+				entry.header.name_len);
+		       fclose(fp);
+		       exit(1);
+		}
+
+		memset(entry.name, 0x00, sizeof(entry.name));
 		if (!fread(entry.name, entry.header.name_len, 1, fp)) {
 			log_err("Unable to read template name\n");
 			goto out;
 		}
 
-		entry.name[entry.header.name_len] = '\0';
+		is_ima_template = strcmp(entry.name, "ima") == 0 ? 1 : 0;
 
-		if (!fread(&entry.template_len, sizeof(entry.template_len), 1, fp)) {
-			log_err("Unable to read template length\n");
-			goto out;
+		/* The "ima" template data is not length prefixed.  Skip it. */
+		if (!is_ima_template) {
+			if (!fread(&entry.template_len,
+				   sizeof(entry.template_len), 1, fp)) {
+				log_err("Unable to read template length\n");
+				goto out;
+			}
+		} else {
+			entry.template_len = SHA_DIGEST_LENGTH +
+					     TCG_EVENT_NAME_LEN_MAX + 1;
 		}
 
 		if (entry.template_buf_len < entry.template_len) {
@@ -1869,9 +1889,42 @@ static int ima_measurement(const char *file)
 			entry.template = malloc(entry.template_len);
 		}
 
-		if (!fread(entry.template, entry.template_len, 1, fp)) {
-			log_err("Unable to read template\n");
-			goto out;
+		if (!is_ima_template) {
+			if (!fread(entry.template, entry.template_len, 1, fp)) {
+				log_errno("Unable to read template\n");
+				goto out;
+			}
+		} else {
+			uint32_t field_len;
+			uint32_t len;
+
+			/*
+			 * The "ima" template data format is digest,
+			 * filename length, filename.
+			 */
+			if (!fread(entry.template, SHA_DIGEST_LENGTH, 1, fp)) {
+				log_errno("Unable to read file data hash\n");
+				goto out;
+			}
+
+			/*
+			 * Read the filename length, but it isn't included
+			 * in the template data hash calculation.
+			 */
+			len = fread(&field_len, sizeof(field_len), 1, fp);
+			if (field_len > TCG_EVENT_NAME_LEN_MAX)
+				log_err("file pathname is too long\n");
+
+			fread(entry.template + SHA_DIGEST_LENGTH,
+			      field_len, 1, fp);
+
+			/*
+			 * The template data is fixed sized, zero out
+			 * the remaining memory.
+			 */
+			len = SHA_DIGEST_LENGTH + field_len;
+			memset(entry.template + len, 0x00,
+			       entry.template_buf_len - len);
 		}
 
 		extend_tpm_banks(&entry, num_banks, pseudo_banks);
@@ -1879,7 +1932,7 @@ static int ima_measurement(const char *file)
 		if (verify)
 			ima_verify_template_hash(&entry);
 
-		if (!strcmp(entry.name, "ima"))
+		if (is_ima_template)
 			ima_show(&entry);
 		else
 			ima_ng_show(&entry);
-- 
2.7.5

