Return-Path: <linux-integrity+bounces-9083-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iC3KKjcow2n2ogQAu9opvQ
	(envelope-from <linux-integrity+bounces-9083-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Mar 2026 01:11:35 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E90D31DEA8
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Mar 2026 01:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B0261304166D
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Mar 2026 00:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 351B013AF2;
	Wed, 25 Mar 2026 00:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gYYkp9hW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0671F4A35;
	Wed, 25 Mar 2026 00:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774397493; cv=none; b=YNeZTn6RGJV5KOLkgRYBYaRgem4VFnpfq1SCHprZqS/W3QEZ+fxFnrW8Halz7GWBmGYr43mVmtRdEtsebVQ2jrFLqr3CUPSBu0IslmffcEuhfraqBkxiBzE4VcrvcnljXnqmsH/vkDpobkZvblmVRP/yyUIb4XUymxVSzsAwt1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774397493; c=relaxed/simple;
	bh=uIorWTZWgTZVMHoRTs0Im0qK4t4jvXiMGAlSTLwugAA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gbIF2TXT8F9wzYa8Njr6q+zP0N1c33SFQCu8L9bxJTWl1VAI7QbpsxdENwEFUtnxn5nOioOY5RheJtZ7ZjDPyAi4ssvRtzpo62GHPAPPIcHxigSg25B8oTf2HNz9PtPaAgw3gt2xpv5y0oSTcHzCHDFjyTBa5/lcpGFgS/7/lMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gYYkp9hW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OJOHjQ826235;
	Wed, 25 Mar 2026 00:11:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Uhhmf3Yy7ioyocANGCnACGhjSI129Jke5G9koze/N
	zc=; b=gYYkp9hWdpA0q5vR0tq5UZBY+pRucRgtxZWikv/uu69feWBz2Bv+aeoVI
	PZUxksj32w6v0FcE/Z3MTggS2zH0GGQLSdD4t5UK9ft3NkiiNm6qjpqzfxXl5YEU
	/xCsp7MyPaYqwhTq9rk8vi1v+l0qNWoh6mCTw2gy9exaLw6fOdZ4Bd5curLEYc/n
	jS92VDqXaHhtg0ZXNXmRNyRMlGO+6PLql04h3etfMV5jCbuR9HlC3pU57e6FXCHj
	R/N6ulL22B931M/3Fwydq9/P+CdPYSCDPB7i2SWpYHkvrd2ultQN1V6J7gSGlpYF
	jAAjJ1VzPGQCQdY7SkncZtAENOjaQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kxqe7q6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 00:11:03 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62P03foS031631;
	Wed, 25 Mar 2026 00:11:02 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d25nsvg67-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 00:11:02 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62P0B0bO20054592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 00:11:00 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94CB858058;
	Wed, 25 Mar 2026 00:11:00 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EAE675805E;
	Wed, 25 Mar 2026 00:10:59 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 00:10:59 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, ebiggers@kernel.org, zohar@linux.ibm.com,
        roberto.sassu@huawei.com, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH] integrity: Allow sigv3 verification on EVM_XATTR_PORTABLE_DIGSIG
Date: Tue, 24 Mar 2026 20:10:51 -0400
Message-ID: <20260325001051.754093-1-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: B8CD-AT6hvq7MJfhwUThvotqqTb_xZ0C
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE4NCBTYWx0ZWRfX1MjR4eTbE2Y9
 5RuXAaR8sQ2O4j7UFy3cuRkhF6b4LLPZ9O26Vh/7tF4dT/hXPyp4JQHVd6a0ICB9ALAXEKZIQeU
 m0CmyUY0htxTlR2FB0wfBIzRMiFNzbmvt55b06uFGztaGLE7xfx/NVfftcoYdwgvQN+9OCUa3Qo
 tE5AEF6VQcOlBgUu+qxGLwqwCTjVk0JSY09RDBd++1otBeWdPBDY3NAl3Dk6WpfZHNVPtnRGBAW
 SgICOXfSHibDkYvZsvaybTj/JwIiVFXXW4gzSUTtJcGHnZyYhyX9Rn7FddYlTIoR7X9gkRbzhhf
 FdOi7UpmQ5zskTekzCsVEpEq/ItpkatGJTEZ6+kem9ZZbDPuCDoYDlVXbOYNOm2Y3pJZbZllgxV
 1ldHNI88v+VAKyIjReh/X2nVE2bD523MOt05O96RhvnRZx6x3UNZVw73tJksBg1oQ3H9Vu0O6FK
 KFInKttfhZoL1VFa3ag==
X-Authority-Analysis: v=2.4 cv=bLEb4f+Z c=1 sm=1 tr=0 ts=69c32817 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=uN4yorV44qNG5XsAaIAA:9
 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: B8CD-AT6hvq7MJfhwUThvotqqTb_xZ0C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_04,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 bulkscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603240184
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9083-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.ibm.com:mid];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 4E90D31DEA8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Allow sigv3 verification on EVM_XATTR_PORTABLE_DIGSIG on RSA, ECDSA,
ECRDSA, and SM2 signatures.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/digsig_asymmetric.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index 6b21b9bf829e..6e68ec3becbd 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -154,7 +154,8 @@ static int calc_file_id_hash(enum evm_ima_xattr_type type,
 	size_t file_id_size;
 	int rc;
 
-	if (type != IMA_VERITY_DIGSIG && type != EVM_IMA_XATTR_DIGSIG)
+	if (type != IMA_VERITY_DIGSIG && type != EVM_IMA_XATTR_DIGSIG &&
+	    type != EVM_XATTR_PORTABLE_DIGSIG)
 		return -EINVAL;
 
 	tfm = crypto_alloc_shash(hash_algo_name[algo], 0, 0);

base-commit: 3fa0dea50084da8279fb4b1175b3a9b4fc16f052
-- 
2.53.0


