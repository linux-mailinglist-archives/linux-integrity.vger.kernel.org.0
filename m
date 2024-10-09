Return-Path: <linux-integrity+bounces-3757-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67E6E996EF8
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Oct 2024 16:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA691F214B8
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Oct 2024 14:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B151A0AFA;
	Wed,  9 Oct 2024 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L9tlrYfy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1DA1925BB;
	Wed,  9 Oct 2024 14:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728485941; cv=none; b=Z0SE3PgC8AlVwWKQlq9637UTFZifTbAzK0PJTKd1vDo3HH4p6WE+/Nr7tzOxwQLHAitvCID79jHVtchgyTkaNpUGF4Xm8Nn5IptwHv1YLvQIMHwuyhP9LDZwsGv0/kVjc9TXTvH1I88uLf2oPz9kVd5scUDSHjjr+XvaP16Jy3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728485941; c=relaxed/simple;
	bh=jhOWPTnLy5STHoWvZVLZJEP1Q7YrHr3h2fSsKzTfeQg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OR7/Ctao5ejQJUQ0EH/lKgaXbebZOv+RdsEAkwV8HZ5uTonStSr/GJ87Ktghaac/VqWnCl7Y9nFNR93/bgMrZafnN3GrZf4V7AsKDRUhxABoeHgNIAAy2U9ArvIOUktw1WPhCnOdEW7O0EhFVf3EAtkUoQ6VTrR8kj3wmDsBMbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L9tlrYfy; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499DfcCs029962;
	Wed, 9 Oct 2024 14:53:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=eTcaNQd5pWBwQngr+JkyDuUjKM/IG
	0KVrbirD+kH8YU=; b=L9tlrYfy+9KH8KerZ0IoHq4lPuE/MwZZGrdABfy0i/zhh
	omTP2LmIG01e7rb8HACGDzkCHfZqpdcAF9iJ7mG1TSMQzxpeQWBK84RZ4z6MK7wx
	mrshNvqGtL5Qp9wCu25MFEfw4xl6ZjvFQNd0PxDHiD0FEcnMHhiP4eBe8vanVPag
	5HDNjEqMumU+8/Q0/NKz/Of50FUreu94jbLHvUSd3w4hFv5S6z0sBTxytpSonjip
	kEKLCTk9yhcNrMP/4oe+NIDhOeCdVkzZWvpk1bN9py3DGlBlZdoyA+mGFMBz1h1P
	R6qGYauH92cQp66/4+ucRZYSLFniDhpr6LrhLuv2Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423063rf48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 14:53:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499Dqb4Y019135;
	Wed, 9 Oct 2024 14:53:38 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uwf0hmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 14:53:38 +0000
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 499ErbH9039489;
	Wed, 9 Oct 2024 14:53:37 GMT
Received: from localhost.localdomain ([100.99.32.179])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 422uwf0hkq-1;
	Wed, 09 Oct 2024 14:53:37 +0000
From: David Fernandez Gonzalez <david.fernandez.gonzalez@oracle.com>
To: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: harshit.m.mogalapalli@oracle.com, vegard.nossum@oracle.com,
        david.fernandez.gonzalez@oracle.com
Subject: [PATCH] ima: Fix OOB read when violation occurs with ima template.
Date: Wed,  9 Oct 2024 14:53:34 +0000
Message-ID: <20241009145335.1297855-1-david.fernandez.gonzalez@oracle.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_14,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 mlxscore=0
 malwarescore=0 bulkscore=0 mlxlogscore=999 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410090092
X-Proofpoint-ORIG-GUID: Y_RPZEiWuMxK7o-8jjvsCen5A37ffX5Z
X-Proofpoint-GUID: Y_RPZEiWuMxK7o-8jjvsCen5A37ffX5Z

When processing a violation inside ima_eventdigest_init,
ima_eventdigest_init_common will be called with cur_digest
being NULL. hash_algo is always set to HASH_ALGO__LAST.

Inside ima_eventdigest_init_common, since digest is NULL,
offset will be calculated by accessing hash_digest_size
with HASH_ALGO__LAST, one element OOB.

This will be used to calculate the amount of bytes
to be copied as file content hash. Depending on the memory,
this could lead to the 0 hash not being recorded if offset is 0,
the violation not being recorded at all if offset is too big
(as it will be used to allocate the buffer in
ima_write_template_field_data), or potentially leaking
memory values into the measurements file, if offset is big
enough but can still be used to allocate the buffer.

UBSAN: array-index-out-of-bounds in security/integrity/ima/ima_template_lib.c:329:29
index 23 is out of range for type 'int [23]'
CPU: 0 UID: 0 PID: 383 Comm: journal-offline Not tainted 6.12.0-rc2 #14
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0x64/0x80
 __ubsan_handle_out_of_bounds+0xc6/0x100
 ima_eventdigest_init_common+0x297/0x2c0
 ? ima_add_violation+0x10b/0x260
 ? __pfx_ima_eventdigest_init_common+0x10/0x10
 ? path_openat+0x739/0x1ba0
 ? do_filp_open+0x168/0x290
 ? do_sys_openat2+0x126/0x160
 ima_eventdigest_init+0xba/0x280
 ? __pfx_ima_eventdigest_init+0x10/0x10
 ? srso_alias_return_thunk+0x5/0xfbef5
 ? __kmalloc_noprof+0x1cd/0x490
 ? ima_alloc_init_template+0xd8/0x2f0
 ima_alloc_init_template+0x1d1/0x2f0
 ima_add_violation+0x10b/0x260
 ...

HASH_ALGO__LAST is only passed to ima_eventdigest_init_common
for ima template. This change ensures to set an appropriate hash_algo
value before calculating the offset.

Cc: stable@vger.kernel.org
Fixes: 9fab303a2cb3 ("ima: fix violation measurement list record")
Signed-off-by: David Fernandez Gonzalez <david.fernandez.gonzalez@oracle.com>
---
 security/integrity/ima/ima_template_lib.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/security/integrity/ima/ima_template_lib.c b/security/integrity/ima/ima_template_lib.c
index 4183956c53af..7a46d720303b 100644
--- a/security/integrity/ima/ima_template_lib.c
+++ b/security/integrity/ima/ima_template_lib.c
@@ -318,15 +318,19 @@ static int ima_eventdigest_init_common(const u8 *digest, u32 digestsize,
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
 		 * hash algorithm digest size.
 		 */
+		if (hash_algo == HASH_ALGO__LAST) /* To handle ima template case */
+			hash_algo = ima_template_hash_algo_allowed(ima_hash_algo) ?
+				ima_hash_algo : HASH_ALGO_SHA1;
 		offset += hash_digest_size[hash_algo];
+	}
 
 	return ima_write_template_field_data(buffer, offset + digestsize,
 					     fmt, field_data);
-- 
2.43.0


