Return-Path: <linux-integrity+bounces-82-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 126B37F0797
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 17:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADF30280D7A
	for <lists+linux-integrity@lfdr.de>; Sun, 19 Nov 2023 16:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68B3A1427E;
	Sun, 19 Nov 2023 16:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AFsM1WiD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84749C2
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 08:50:59 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJGmgr0019561
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:50:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=CwkBaa4lsiRhYPNLE1On08nuVo9v/3eOSjH+gO+zC0M=;
 b=AFsM1WiDgCC/tuaAa5o3OR2kjhC6a7fSLTG60XQXxGnys0bBezSsodOT5vqkpd2vzO1D
 nOlwqJcSXPWit4tRVx87daWkVWryoYJ1WAxbpqyVVgjkjpcBlpfG2tz7mbDCenjvQRuO
 oriSR25S3jB/wuEhaesQ6CsWrB+3nfbQthuCMATJHlPZRO6nBMkq1y8h/0pq3VdZJHVQ
 pIKtw7SawbmjtzDkIAJ4Jb2KmDPYLmkkcgtSnUVvNHZC8upAxKTUBl+ULHTcQ5TUSZp7
 FjZM2/caatdRV0l8U+A1fX38I14lxeV8wUlqLwMp8mVz4e1KD80MSbX1LTMLwpHHud3P kg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ufp6s00sr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:50:58 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AJEEK7L007577
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:50:57 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ufaa1khsm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Sun, 19 Nov 2023 16:50:57 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AJGotCE17236692
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 19 Nov 2023 16:50:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E3DCA20049;
	Sun, 19 Nov 2023 16:50:54 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E5F520040;
	Sun, 19 Nov 2023 16:50:54 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com.com (unknown [9.61.134.108])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 19 Nov 2023 16:50:53 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH 01/12] Rename "public_keys" to "g_public_keys"
Date: Sun, 19 Nov 2023 11:50:32 -0500
Message-Id: <20231119165043.46960-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231119165043.46960-1-zohar@linux.ibm.com>
References: <20231119165043.46960-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 98aBu5pSH5DfblVSr6abE6xmHIkZ9GwV
X-Proofpoint-ORIG-GUID: 98aBu5pSH5DfblVSr6abE6xmHIkZ9GwV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-19_15,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 spamscore=0 mlxscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311190128

In preparation for replacing the library global public_keys variable,
which is not concurrency-safe, with a local variable, rename public_keys
to g_public_keys.

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/libimaevm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 5b224625644e..117a1a72b60c 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -370,14 +370,14 @@ struct public_key_entry {
 	char name[9];
 	EVP_PKEY *key;
 };
-static struct public_key_entry *public_keys = NULL;
+static struct public_key_entry *g_public_keys = NULL;
 
 static EVP_PKEY *find_keyid(uint32_t keyid)
 {
-	struct public_key_entry *entry, *tail = public_keys;
+	struct public_key_entry *entry, *tail = g_public_keys;
 	int i = 1;
 
-	for (entry = public_keys; entry != NULL; entry = entry->next) {
+	for (entry = g_public_keys; entry != NULL; entry = entry->next) {
 		if (entry->keyid == keyid)
 			return entry->key;
 		i++;
@@ -394,7 +394,7 @@ static EVP_PKEY *find_keyid(uint32_t keyid)
 	if (tail)
 		tail->next = entry;
 	else
-		public_keys = entry;
+		g_public_keys = entry;
 	log_err("key %d: %x (unknown keyid)\n", i, __be32_to_cpup(&keyid));
 	return 0;
 }
@@ -429,8 +429,8 @@ void init_public_keys(const char *keyfiles)
 		calc_keyid_v2(&entry->keyid, entry->name, entry->key);
 		sprintf(entry->name, "%x", __be32_to_cpup(&entry->keyid));
 		log_info("key %d: %s %s\n", i++, entry->name, keyfile);
-		entry->next = public_keys;
-		public_keys = entry;
+		entry->next = g_public_keys;
+		g_public_keys = entry;
 	}
 	free(keyfiles_free);
 }
-- 
2.39.3


