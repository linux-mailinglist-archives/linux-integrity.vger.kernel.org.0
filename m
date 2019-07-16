Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0E66AA9B
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Jul 2019 16:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfGPObM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jul 2019 10:31:12 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726997AbfGPObM (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jul 2019 10:31:12 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6GERaCO121961
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jul 2019 10:31:11 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tsg41h0fk-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 16 Jul 2019 10:31:11 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 16 Jul 2019 15:31:08 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 16 Jul 2019 15:31:07 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6GEV5Rv62259424
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 16 Jul 2019 14:31:05 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 165DD4C05C;
        Tue, 16 Jul 2019 14:31:05 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9FD004C066;
        Tue, 16 Jul 2019 14:31:04 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.82.148])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 16 Jul 2019 14:31:04 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 2/2] ima_evm_utils: limit duplicate "Failed to open keyfile" messages
Date:   Tue, 16 Jul 2019 10:30:17 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1563287417-31780-1-git-send-email-zohar@linux.ibm.com>
References: <1563287417-31780-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19071614-0008-0000-0000-000002FDB1AC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071614-0009-0000-0000-0000226B2807
Message-Id: <1563287417-31780-2-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-16_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907160178
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Unlike the user provided list of public keys, we don't know which
default public key file to use until verify_hash().  As a result, the
"Failed to open keyfile" message may be repeated multiple times.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/libimaevm.c | 33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 472ab53c7b42..793643331f4b 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -296,18 +296,49 @@ err:
 	return err;
 }
 
+/*
+ * Keep track of missing keyfile names.
+ *
+ * Return 1 for found, return 0 for not found.
+ */
+static int lookup_keyfile_name(const char *keyfile_name)
+{
+	struct keyfile_name_entry {
+		struct keyfile_name_entry *next;
+		char name[];
+	} *entry;
+	static struct keyfile_name_entry *keyfile_names = NULL;
+
+	for (entry = keyfile_names; entry != NULL; entry = entry->next) {
+		if (strcmp(entry->name, keyfile_name) == 0)
+			return 1;
+	}
+
+	entry = malloc(sizeof(struct keyfile_name_entry) +
+			strlen(keyfile_name) + 1);
+	if (entry) {
+		strcpy(entry->name, keyfile_name);
+		entry->next = keyfile_names;
+		keyfile_names = entry;
+	}
+	return 0;
+}
+
 EVP_PKEY *read_pub_pkey(const char *keyfile, int x509)
 {
 	FILE *fp;
 	X509 *crt = NULL;
 	EVP_PKEY *pkey = NULL;
+	int found;
 
 	if (!keyfile)
 		return NULL;
 
 	fp = fopen(keyfile, "r");
 	if (!fp) {
-		log_err("Failed to open keyfile: %s\n", keyfile);
+		found = lookup_keyfile_name(keyfile);
+		if (!found)
+			log_err("Failed to open keyfile: %s\n", keyfile);
 		return NULL;
 	}
 
-- 
2.7.5

