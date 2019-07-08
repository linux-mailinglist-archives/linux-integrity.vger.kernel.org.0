Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C0F3361F68
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Jul 2019 15:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726284AbfGHNQn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Jul 2019 09:16:43 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:10542 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727352AbfGHNQm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Jul 2019 09:16:42 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x68DDj4e010090
        for <linux-integrity@vger.kernel.org>; Mon, 8 Jul 2019 09:16:41 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tm4jsw2j1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Mon, 08 Jul 2019 09:16:41 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Mon, 8 Jul 2019 14:16:39 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 8 Jul 2019 14:16:37 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x68DGOQB23789940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Jul 2019 13:16:24 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 508DAA405B;
        Mon,  8 Jul 2019 13:16:36 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9EDC0A4062;
        Mon,  8 Jul 2019 13:16:35 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.110.58])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Jul 2019 13:16:35 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Vitaly Chikunov <vt@altlinux.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 2/2] ima-evm-utils: support template "buf" field
Date:   Mon,  8 Jul 2019 09:15:50 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1562591750-14234-1-git-send-email-zohar@linux.ibm.com>
References: <1562591750-14234-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19070813-0020-0000-0000-000003514F4E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070813-0021-0000-0000-000021A4F9C2
Message-Id: <1562591750-14234-2-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-08_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907080166
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Other than the "boot-aggregate" measurement entry in the IMA
measuremeent list, all other measurements are of file data.  Kernel
support was recently added to support measuring the kexec boot command
line buffer, which is stored in a new template field named 'buf'.

This patch adds support for a new template named "ima-buf", defined as
"d-ng|n-ng|buf".

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/evmctl.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index f6046637d8f6..a6d07c981453 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -1443,8 +1443,8 @@ void ima_ng_show(struct template_entry *entry)
 {
 	uint8_t *fieldp = entry->template;
 	uint32_t field_len;
-	int total_len = entry->template_len, digest_len, len, sig_len;
-	uint8_t *digest, *sig = NULL;
+	int total_len = entry->template_len, digest_len, len, sig_len, fbuf_len;
+	uint8_t *digest, *sig = NULL, *fbuf = NULL;
 	char *algo, *path;
 	int found;
 	int err;
@@ -1488,6 +1488,18 @@ void ima_ng_show(struct template_entry *entry)
 			fieldp += field_len;
 			total_len -= field_len;
 		}
+	} else if (!strcmp(entry->name, "ima-buf")) {
+		field_len = *(uint32_t *)fieldp;
+		fieldp += sizeof(field_len);
+		total_len -= sizeof(field_len);
+		if (field_len) {
+			fbuf = fieldp;
+			fbuf_len = field_len;
+
+			/* move to next field */
+			fieldp += field_len;
+			total_len -= field_len;
+		}
 	}
 
 	/* ascii_runtime_measurements */
@@ -1497,6 +1509,10 @@ void ima_ng_show(struct template_entry *entry)
 		log_info(" %s %s", entry->name, algo);
 		log_dump_n(digest, digest_len);
 		log_info(" %s", path);
+		if (fbuf) {
+			log_info(" ");
+			log_dump_n(fbuf, fbuf_len);
+		}
 	}
 
 	if (sig) {
-- 
2.7.5

