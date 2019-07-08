Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4AF61F67
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jul 2019 15:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728922AbfGHNQl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Jul 2019 09:16:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8696 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726284AbfGHNQl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Jul 2019 09:16:41 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x68DEHqK016043
        for <linux-integrity@vger.kernel.org>; Mon, 8 Jul 2019 09:16:40 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tm60yshjr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 08 Jul 2019 09:16:39 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 8 Jul 2019 14:16:37 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 8 Jul 2019 14:16:36 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x68DGZpo32178546
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Jul 2019 13:16:35 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D159A4060;
        Mon,  8 Jul 2019 13:16:35 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B8696A405B;
        Mon,  8 Jul 2019 13:16:34 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.110.58])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Jul 2019 13:16:34 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Vitaly Chikunov <vt@altlinux.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 1/2] ima-evm-utils: limit "remain unprocessed data" messages
Date:   Mon,  8 Jul 2019 09:15:49 -0400
X-Mailer: git-send-email 2.7.5
X-TM-AS-GCONF: 00
x-cbid: 19070813-0008-0000-0000-000002FAF0EA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070813-0009-0000-0000-000022684D75
Message-Id: <1562591750-14234-1-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-08_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=799 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907080166
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

New, unknown template formats containing unknown fields are not
processed, resulting in "remain unprocessed data" messages.  Processing
these unknown fields is unnecessary for walking the measurement list to
re-calculate the PCRs.

The "remain unproccessed data" may also be emitted for malformed, known
template records.

This patch limits the number of messages emitted to once per template
format and includes the template name in the message.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 37 +++++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 7ce20225c89d..f6046637d8f6 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1411,6 +1411,34 @@ void ima_show(struct template_entry *entry)
 	log_debug_dump(entry->header.digest, sizeof(entry->header.digest));
 }
 
+/*
+ * Keep track of unknown or malformed template names.
+ *
+ * Return 1 for found, return 0 for not found.
+ */
+static int lookup_template_name_entry(char *template_name)
+{
+	struct template_name_entry {
+		struct template_name_entry *next;
+		char name[];
+	} *entry;
+	static struct template_name_entry *template_names = NULL;
+
+	for (entry = template_names; entry != NULL; entry = entry->next) {
+		if (strcmp(entry->name, template_name) == 0)
+			return 1;
+	}
+
+	entry = malloc(sizeof(struct template_name_entry) +
+			strlen(template_name) + 1);
+	if (entry) {
+		strcpy(entry->name, template_name);
+		entry->next = template_names;
+		template_names = entry;
+	}
+	return 0;
+}
+
 void ima_ng_show(struct template_entry *entry)
 {
 	uint8_t *fieldp = entry->template;
@@ -1418,6 +1446,7 @@ void ima_ng_show(struct template_entry *entry)
 	int total_len = entry->template_len, digest_len, len, sig_len;
 	uint8_t *digest, *sig = NULL;
 	char *algo, *path;
+	int found;
 	int err;
 
 	/* get binary digest */
@@ -1487,8 +1516,12 @@ void ima_ng_show(struct template_entry *entry)
 			log_info("\n");
 	}
 
-	if (total_len)
-		log_err("Remain unprocessed data: %d\n", total_len);
+	if (total_len) {
+		found = lookup_template_name_entry(entry->name);
+		if (!found)
+			log_err("Template \"%s\" contains unprocessed data: "
+				 "%d bytes\n", entry->name, total_len);
+	}
 }
 
 static int ima_measurement(const char *file)
-- 
2.7.5

