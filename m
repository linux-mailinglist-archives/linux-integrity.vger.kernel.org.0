Return-Path: <linux-integrity+bounces-2895-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBCF911272
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Jun 2024 21:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFFF5284A48
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Jun 2024 19:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914152D61B;
	Thu, 20 Jun 2024 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KRj7/3+H"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31B643AD7
	for <linux-integrity@vger.kernel.org>; Thu, 20 Jun 2024 19:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718912805; cv=none; b=VFYrQhtnfN4nDHUUktibecY6HWKAZTsOBJ8TitbrL2qYU2PB5VDXIwJbaX/kC0dXzyu1g2+iHGiOTQ9hNgqqn96tkN7wkbVFfAE9jGSRAOYZ/cQtWRilmfsiXgdEE6KkDY20DpgKXy6O/SwcKLxt64HzmFEqSPueNXUWWg+DlA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718912805; c=relaxed/simple;
	bh=vcwVOJ61Gpae/LX+9cD/aqwtaOHmCbKKSIq7DbHOJVo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZG/gkrrpKh5vrVH+DQWLLtSRDoUsR2R6CToL5G7274gIC9flv7ATOZVC78rziDnNkDK9k7JmxF9NJGMuRA42xk7FRfk6vaCPgRDSbyOc3dBuA+oPhlSVLW4/IjfrMIdHVFniPzLIYkj/yK5xruWwwh9vBjrN3cryjJqnckQmO0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KRj7/3+H; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KHBAmZ009912;
	Thu, 20 Jun 2024 19:46:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=corp-2023-11-20; bh=nYuHbtVcuB57bk
	XSiHUDfKgHs8Zk3yJD7awWgpAJ8zU=; b=KRj7/3+HlWyDySA5wCr+zBKgKS2aUa
	2W/w/hAjVLZmtStlgTs91TVTip3SmStPEp9Wcfw8q8tSnYSgQQFatZRcsjv3/gbg
	lt7o0tdqDrMuTGlEi5xkT2qGXCl9hAraOKgDHiUanciL/UjWL8766ZcKIQ83n5B4
	bT9cD5fw43gUPC0DLtwgwly7FQXeo124zs+EeXZex+Kr/3LAKacB0e2peCcVnw90
	r6uqtVMw2D0ajnIBFvs8NrqLMR5dfQ5u7ZzgRMaqz1hkcMhQA6CUIt7vJPrMW7D4
	UzxsNWbt4freKwIABL9HOnZm0xdFLby6ZZT1+d90k4x0Kom2ll+Co/Iw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yvrkj09ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 19:46:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45KIv7eQ019425;
	Thu, 20 Jun 2024 19:46:34 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yvrn2whe8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 19:46:34 +0000
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 45KJhMaF029566;
	Thu, 20 Jun 2024 19:46:33 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 3yvrn2whe1-1;
	Thu, 20 Jun 2024 19:46:33 +0000
From: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
To: zohar@linux.ibm.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com
Cc: eric.snowberg@oracle.com, linux-integrity@vger.kernel.org,
        samasth.norway.ananda@oracle.com
Subject: [PATCH ] ima: fix buffer overrun in ima_eventdigest_init_common
Date: Thu, 20 Jun 2024 12:46:32 -0700
Message-ID: <20240620194632.3996068-1-samasth.norway.ananda@oracle.com>
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
 definitions=2024-06-20_08,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406200143
X-Proofpoint-GUID: tBgechtRdU0b0lwjxmb17zRzVaggq9c7
X-Proofpoint-ORIG-GUID: tBgechtRdU0b0lwjxmb17zRzVaggq9c7

Function ima_eventdigest_init() can call ima_eventdigest_init_common()
with HASH_ALGO__LAST which is then used to access the array
hash_digest_size[] leading to buffer overrun. Have a conditional
statement to handle this.

Fixes: 9fab303a2cb3 ("ima: fix violation measurement list record")
Signed-off-by: Samasth Norway Ananda <samasth.norway.ananda@oracle.com>
---
 security/integrity/ima/ima_template_lib.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 4183956c53af..14c000fe8312 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -320,13 +320,17 @@ static int ima_eventdigest_init_common(const u8 *digest, u32 digestsize,
 
 	if (digest)
 		memcpy(buffer + offset, digest, digestsize);
-	else
+	else {
 		/*
 		 * If digest is NULL, the event being recorded is a violation.
 		 * Make room for the digest by increasing the offset by the
 		 * hash algorithm digest size.
 		 */
-		offset += hash_digest_size[hash_algo];
+		if (hash_algo < HASH_ALGO__LAST)
+                        offset += hash_digest_size[hash_algo];
+               else
+                        offset += IMA_DIGEST_SIZE;
+	}
 
 	return ima_write_template_field_data(buffer, offset + digestsize,
 					     fmt, field_data);
-- 
2.45.2


