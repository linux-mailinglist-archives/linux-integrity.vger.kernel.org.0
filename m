Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A36C6CFB4
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jul 2019 16:31:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726040AbfGROar (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jul 2019 10:30:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727848AbfGROar (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jul 2019 10:30:47 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6IEUe0i076837
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jul 2019 10:30:46 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tttb2gnb0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jul 2019 10:30:44 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 18 Jul 2019 15:30:31 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 18 Jul 2019 15:30:30 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6IEUSjY62587088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 18 Jul 2019 14:30:28 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 68C7752059;
        Thu, 18 Jul 2019 14:30:28 +0000 (GMT)
Received: from localhost.ibm.com (unknown [9.80.110.122])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id E25EC5204E;
        Thu, 18 Jul 2019 14:30:27 +0000 (GMT)
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v3 2/2] ima-evm-utils: log unknown keyid's as errors
Date:   Thu, 18 Jul 2019 10:29:54 -0400
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1563460194-21569-1-git-send-email-zohar@linux.ibm.com>
References: <1563460194-21569-1-git-send-email-zohar@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19071814-0020-0000-0000-000003551290
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071814-0021-0000-0000-000021A8EB33
Message-Id: <1563460194-21569-2-git-send-email-zohar@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-18_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=904 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907180151
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Each tima a new unknown key is encountered, emit a message of the format
"key #: <keyid> unknown".  The individual files using unknown keys are
then only logged in verbose mode.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/libimaevm.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 43eb4ef2412c..d2194a6ca0f8 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -402,13 +402,26 @@ static struct public_key_entry *public_keys = NULL;
 
 static EVP_PKEY *find_keyid(uint32_t keyid)
 {
-	struct public_key_entry *entry;
+	struct public_key_entry *entry, *tail = public_keys;
+	int i = 1;
 
 	for (entry = public_keys; entry != NULL; entry = entry->next) {
 		if (entry->keyid == keyid)
 			return entry->key;
+		i++;
+		tail = entry;
 	}
-	return NULL;
+
+	/* add unknown keys to list */
+	entry = calloc(1, sizeof(struct public_key_entry));
+	if (!entry) {
+		perror("calloc");
+		return 0;
+	}
+	entry->keyid = keyid;
+	tail->next = entry;
+	log_err("key %d: %x unknown\n", i,  __be32_to_cpup(&keyid));
+	return 0;
 }
 
 void init_public_keys(const char *keyfiles)
@@ -470,8 +483,8 @@ static int verify_hash_v2(const char *file, const unsigned char *hash, int size,
 
 	pkey = find_keyid(keyid);
 	if (!pkey) {
-		log_err("%s: unknown keyid: %x\n",
-			file, __be32_to_cpup(&keyid));
+		log_info("%s: unknown keyid: %x\n",
+			 file, __be32_to_cpup(&keyid));
 		return -1;
 	}
 
-- 
2.7.5

