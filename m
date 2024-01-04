Return-Path: <linux-integrity+bounces-648-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C461824894
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 20:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8282282919
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jan 2024 19:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7A328E21;
	Thu,  4 Jan 2024 19:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hlNpG4mQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568B728E2B
	for <linux-integrity@vger.kernel.org>; Thu,  4 Jan 2024 19:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 404HSPRj026191
	for <linux-integrity@vger.kernel.org>; Thu, 4 Jan 2024 19:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Qv/a0F7cJyEs0qPwJUu7Eg+VPqyQ/pvfKdhpRA7WgZc=;
 b=hlNpG4mQoimSgtptBD9iuO4PwNhUic7YWAx/oqtEc2CYGfo3BTUPOWZurNzGdbMBClt8
 HteS8iHLrGLqU1ymKELy0Kj+sFOpeL3VvZ6KTkj/ZYvs7ZQju89Xmmzm2tqKHT6fD3aA
 oYqCXlOHwFvJzpRhqeUnesYNX/M+pj3uPiKz5bz02La22aGm/UAEyuGeJM14LyCDRtay
 2J9l9x3o3R38i/EWp10g4fbXpdwUQFsiQi3bMHNtHmzasSR+YZTdwDE3sg3ugLm72NCB
 uUhcv+tTjHN+X2YNn7ZpkQs0hD0yJPLPMDSrfwK6Ssoo4PdGQBCsNG/EynXzKe5SqMIA Mg== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ve13pu9u9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 04 Jan 2024 19:06:10 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 404IO3S4024559
	for <linux-integrity@vger.kernel.org>; Thu, 4 Jan 2024 19:06:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3vb082jmfa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Thu, 04 Jan 2024 19:06:09 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 404J66ub47776058
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jan 2024 19:06:06 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50F8E20043;
	Thu,  4 Jan 2024 19:06:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 639E920040;
	Thu,  4 Jan 2024 19:06:05 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.90])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Jan 2024 19:06:05 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Stefan Berger <stefanb@linux.ibm.com>, Mimi Zohar <zohar@linux.ibm.com>
Subject: [ima-evm-utils PATCH v3 01/13] Rename "public_keys" to "g_public_keys"
Date: Thu,  4 Jan 2024 14:05:46 -0500
Message-Id: <20240104190558.3674008-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240104190558.3674008-1-zohar@linux.ibm.com>
References: <20240104190558.3674008-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wPnETQemPluHMGtAk8ldyW12WYUzikKA
X-Proofpoint-GUID: wPnETQemPluHMGtAk8ldyW12WYUzikKA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-04_11,2024-01-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1015 bulkscore=0
 spamscore=0 impostorscore=0 mlxscore=0 adultscore=0 lowpriorityscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401040149

In preparation for replacing the library global public_keys variable,
which is not concurrency-safe, with a local variable, rename public_keys
to g_public_keys.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 src/libimaevm.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 5b224625644e..244774d01805 100644
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
+	for (entry = g_public_keys; entry; entry = entry->next) {
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


