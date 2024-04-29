Return-Path: <linux-integrity+bounces-2252-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C468E8B61B4
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 21:09:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AEFB1C21323
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 19:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A16F13AA32;
	Mon, 29 Apr 2024 19:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="abMADxFc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE6A13AA5A
	for <linux-integrity@vger.kernel.org>; Mon, 29 Apr 2024 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417795; cv=none; b=fmuhOM2qcBQ5gWtiRTmFvmPo8FsMhK+sCWb2aPUwWI1+V4UKPjqnYRzFBueGM35L6QacMPonnIqr4jL+fER8yIOHHVHEN8AvwTjB7DzDE5ewBPD+prSsW8k5Y86hY2DAyK+dg+WGeGHdxlao4V6VVlNzezTAyxnDgPhEAIL1srs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417795; c=relaxed/simple;
	bh=mQ8Yj6I65tvOpGShqYbXyCaHUkiBf534bR8C0bQlybQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sbVQYcuDRu53yz+w6aOk5wqfFBRG/KlWGucatHIMx4U1zPXGPJ4+lv0vc8nGzNY1B4nIwZu0R9j6v/ZQ/8aCKHeMbW/suw8iUIfENvl2vocldGf5tWkvlmtG1mQ8BNfLajfyDYRxZhBuenpwntoJDqUt0/KwIFwGTtn4WsB67+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=abMADxFc; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TIuSm4013916;
	Mon, 29 Apr 2024 19:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=b35Kuzf9feTnDh3KmJ2S1+iwR8tOInt8dB5fO6ZBSvs=;
 b=abMADxFcuBnZuSZ1xZQUFTIioO9aLAcJihToesg8mfXRlY16RhK5CNR94Fs+hcWXfbI8
 OUIGlo83cpot0NdvQelL+NS9XCVYdyu5Ko6Hq9p/61YouFCOj4ffVLBa5+sjz6NoYRq6
 e2coNs9olGAmtQlx17wJCJq/wfmQPGWOwu9XvBogQJM1/biQxLles19YJ/7WfxB79Ew1
 FEkZ+LS6I2JYVpCGmw8LSCXX5ZqbRS7olJgL+g7sply5axLYQdFxJz/Y9IR0ip1iiDlL
 0cdffwJw2vaaEtkI/53pLXD+9oKWqcBX28VKAaINt8WQlzZ2t/p6fX0SwoFZk2dNVsEZ BQ== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xtfx9g88r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 19:09:40 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 43TGEcIL015545;
	Mon, 29 Apr 2024 19:09:39 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3xsed2rpju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Apr 2024 19:09:39 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 43TJ9axv25952930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Apr 2024 19:09:38 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4DF4D58058;
	Mon, 29 Apr 2024 19:09:36 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA1095805B;
	Mon, 29 Apr 2024 19:09:35 +0000 (GMT)
Received: from sbct-3.bos2.lab (unknown [9.47.158.153])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 29 Apr 2024 19:09:35 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH ima-evm-utils] First try to get keyid from cert then fall back to calculating
Date: Mon, 29 Apr 2024 15:09:24 -0400
Message-ID: <20240429190924.3149435-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EwVEWODHK8oSYzv14IdJOWHwI7iyh543
X-Proofpoint-ORIG-GUID: EwVEWODHK8oSYzv14IdJOWHwI7iyh543
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_16,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 spamscore=0 suspectscore=0 phishscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290125

When trying to verify signatures then verification may fail if the key id
derived from the subject key identifier (skid) is different from the one
that is being calculated from the public key. Therefore, first try to get
the key id from the skid of a certificate and only if this does not work
then fall back to calculating it from the public key. This way signature
verification will first use the same method to get the key id as the Linux
kernel does.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/libimaevm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/libimaevm.c b/src/libimaevm.c
index 89330c4..729be7b 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -71,6 +71,9 @@
 #include "imaevm.h"
 #include "hash_info.h"
 
+static int read_keyid_from_cert(uint32_t *keyid_be, const char *certfile,
+				int try_der);
+
 /* Names that are primary for OpenSSL. */
 static const char *const pkey_hash_algo[PKEY_HASH__LAST] = {
 	[PKEY_HASH_MD4]		= "md4",
@@ -458,7 +461,9 @@ int imaevm_init_public_keys(const char *keyfiles,
 			continue;
 		}
 
-		calc_keyid_v2(&entry->keyid, entry->name, entry->key);
+		if (read_keyid_from_cert(&entry->keyid, keyfile, 1) < 0)
+			calc_keyid_v2(&entry->keyid, entry->name, entry->key);
+
 		sprintf(entry->name, "%x", __be32_to_cpup(&entry->keyid));
 		log_info("key %d: %s %s\n", i++, entry->name, keyfile);
 		entry->next = *public_keys;
-- 
2.34.1


