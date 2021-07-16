Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D71AA3CB867
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Jul 2021 16:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232915AbhGPOIl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 16 Jul 2021 10:08:41 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49616 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232808AbhGPOIk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Jul 2021 10:08:40 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16GE4EiU076392
        for <linux-integrity@vger.kernel.org>; Fri, 16 Jul 2021 10:05:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=W3mD0s2duS/0VkUN1NWMfwsn17WQwP1kcuufhPOBG14=;
 b=bZoB50mfgZGY+ymJkoAKh7mabAsAh1tsd1/hxPHc3RQj/qHca2bkW5hgPokcTskfqeKa
 UHCpKT0y8C/LqdUQvX29LxqynfhYNANe2pGg7n+Z1zfoJvNxQYZVcxr90dxbGjsLwsbP
 2QHTXPotJpLAH0K2MN0+1Qldgz0LALt4A6AtxI9zQAD3qjiN22YEwTs29UbYB+7r0npN
 j1AH7RtSMr9CptM9F6aUPrtHqIWYyFNSwa9G/J+U/3q0/3yRJuSN3VkzyqGGe0ndPXY/
 0Dxxei8WphBEHspzO7VGxG7ATdJ5iY/xf58uHRzSNepT3HiswJaGCt82mtqkRBtAsOe2 fg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39twt8n8k0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 16 Jul 2021 10:05:44 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16GE5gLQ008036
        for <linux-integrity@vger.kernel.org>; Fri, 16 Jul 2021 14:05:42 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma02fra.de.ibm.com with ESMTP id 39s3p78w83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 16 Jul 2021 14:05:41 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16GE5cJE21823762
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Jul 2021 14:05:38 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A68DD5204E;
        Fri, 16 Jul 2021 14:05:38 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.160.55.33])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 29E4652052;
        Fri, 16 Jul 2021 14:05:38 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH ima-evm-utils 2/3] Address "ignoring number of bytes read" messages
Date:   Fri, 16 Jul 2021 10:05:30 -0400
Message-Id: <20210716140531.945013-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210716140531.945013-1-zohar@linux.ibm.com>
References: <20210716140531.945013-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qEXq4cm1rlAG0q3D1uWYW6WkosmvMcC6
X-Proofpoint-ORIG-GUID: qEXq4cm1rlAG0q3D1uWYW6WkosmvMcC6
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-16_04:2021-07-16,2021-07-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 clxscore=1015 bulkscore=0 impostorscore=0 phishscore=0
 spamscore=0 suspectscore=0 lowpriorityscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107160086
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Coverity complains about the existing "if (!fread(....))" and inverse
syntax.  Change it to make Coverity happy.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c    | 4 ++--
 src/libimaevm.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index e1464ade4837..23be73d9bb97 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -2011,7 +2011,7 @@ static int ima_measurement(const char *file)
 		}
 	}
 
-	while (fread(&entry.header, sizeof(entry.header), 1, fp)) {
+	while (fread(&entry.header, sizeof(entry.header), 1, fp) == 1) {
 		entry_num++;
 		if (entry.header.pcr >= NUM_PCRS) {
 			log_err("Invalid PCR %d.\n", entry.header.pcr);
@@ -2233,7 +2233,7 @@ static int read_binary_bios_measurements(char *file, struct tpm_bank_info *bank)
 		log_info("Reading the TPM 1.2 event log %s.\n", file);
 
 	/* Extend the pseudo TPM PCRs with the event digest */
-	while (fread(&event, sizeof(event.header), 1, fp)) {
+	while (fread(&event, sizeof(event.header), 1, fp) == 1) {
 		if (imaevm_params.verbose > LOG_INFO) {
 			log_info("%02u ", event.header.pcr);
 			log_dump(event.header.digest, SHA_DIGEST_LENGTH);
diff --git a/src/libimaevm.c b/src/libimaevm.c
index 6591d20c7662..261712717368 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -156,7 +156,7 @@ static int add_file_hash(const char *file, EVP_MD_CTX *ctx)
 
 	for (size = stats.st_size; size; size -= len) {
 		len = MIN(size, bs);
-		if (!fread(data, len, 1, fp)) {
+		if (fread(data, len, 1, fp) != 1) {
 			if (ferror(fp)) {
 				log_err("fread() failed\n\n");
 				goto out;
-- 
2.27.0

