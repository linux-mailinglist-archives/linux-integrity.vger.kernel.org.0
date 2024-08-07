Return-Path: <linux-integrity+bounces-3299-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E50A294AEDD
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Aug 2024 19:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2200E1C2125F
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Aug 2024 17:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105F313BC1B;
	Wed,  7 Aug 2024 17:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hqIvG2KF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E5E13C9CF
	for <linux-integrity@vger.kernel.org>; Wed,  7 Aug 2024 17:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723051649; cv=none; b=etH1HIrXvNCsUqvW+29m9E/vO1CnxDL9Hj4vdmRcoBzZHvO2i6oESh1Iu/3blRfxpwaNdRomH8GlfjEADCqIiiLn2fzr8bgIMh/Aaz7rvj858TrGEA5cj4XiqxbwhqCalPC7IcFIV4BwgSv6qsZolmLr3MjtLMsT4To84Zdbkvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723051649; c=relaxed/simple;
	bh=gmS3d60Xozc11AFo4bglYIrKfWnl+d/Qny/Bv2a3Fjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dkfpdCTyqjPhYPyRbWdAYJ4/sEOSVg3SdtUB1v3ksFPsl2/uGToVB0fryvkki8IN71IkNLWRfphLoFWZ7yqCpjNopxPz+BBFsIKROB4OOCjdlQXl6VAxwkkRvAj5GVq/MbHOHwJs7kzDXunJMPWcMPNN7eoFXFA7Fu0tB6i5i6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hqIvG2KF; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477HMZLJ002858;
	Wed, 7 Aug 2024 17:27:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=+yZKoNZBXTqfDR
	7Etww9G6var+eSmam2PYicV/nbO00=; b=hqIvG2KFzblzBoFEVCozQQGX3qqUru
	2eg16LR6rLx1L/Yc8CM0Ps9lut50px088fpPp2hBc5qb8jvQ59T4XORnVoZarY+0
	x8twggKqn5Z4IvfiBqF6X1A6GnaVNchpTMltKvtZbsBAfsjghNmoEqYY8CvAbafm
	P48laKnj8pw9IlVLRhxpWxHvnjJXQ1sXQNtiY5XEmAUttxRE4df7S8JnrATxzcSo
	yKFh2W2sdl7KLS9FS/co3J33oHY7VBp6SL9ZR9cfhk692aWdRG8R2kIRwmedY0lJ
	W8e34xQ00v/yruv21/dzzUPLAWwCy1fAruN/bIqUHgw078fhP7n8ClTg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40saye82xu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Aug 2024 17:27:16 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 477GJCnk017024;
	Wed, 7 Aug 2024 17:27:15 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0bkerw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Aug 2024 17:27:15 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 477HREHA019875;
	Wed, 7 Aug 2024 17:27:14 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 40sb0bkeqg-1;
	Wed, 07 Aug 2024 17:27:14 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: zohar@linux.ibm.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com
Cc: eric.snowberg@oracle.com, linux-integrity@vger.kernel.org,
        enrico.bravi@huawei.com, samasth.norway.ananda@oracle.com
Subject: [PATCH v2] ima: fix buffer overrun in ima_eventdigest_init_common
Date: Wed,  7 Aug 2024 10:27:13 -0700
Message-ID: <20240807172713.1692608-1-samasth.norway.ananda@oracle.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_11,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0
 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408070122
X-Proofpoint-ORIG-GUID: RYEzrWE70uxye8i5Vrx5TovaXzxBcqhh
X-Proofpoint-GUID: RYEzrWE70uxye8i5Vrx5TovaXzxBcqhh

Function ima_eventdigest_init() can call ima_eventdigest_init_common()
with HASH_ALGO__LAST which is then used to access the array
hash_digest_size[] leading to buffer overrun. Have a conditional
statement to handle this.

Fixes: 9fab303a2cb3 ("ima: fix violation measurement list record")
Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
 security/integrity/ima/ima_template_lib.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 4183956c53af..0e627eac9c33 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -318,15 +318,21 @@ static int ima_eventdigest_init_common(const u8 *digest, u32 digestsize,
 				      hash_algo_name[hash_algo]);
 	}
 
-	if (digest)
+	if (digest) {
 		memcpy(buffer + offset, digest, digestsize);
-	else
+	} else {
 		/*
 		 * If digest is NULL, the event being recorded is a violation.
 		 * Make room for the digest by increasing the offset by the
-		 * hash algorithm digest size.
+		 * hash algorithm digest size. If the hash algorithm is not
+		 * specified increase the offset by IMA_DIGEST_SIZE which
+		 * fits SHA1 or MD5
 		 */
-		offset += hash_digest_size[hash_algo];
+		if (hash_algo < HASH_ALGO__LAST)
+			offset += hash_digest_size[hash_algo];
+		else
+			offset += IMA_DIGEST_SIZE;
+	}
 
 	return ima_write_template_field_data(buffer, offset + digestsize,
 					     fmt, field_data);
-- 
2.45.2


