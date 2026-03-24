Return-Path: <linux-integrity+bounces-9078-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOOBA7sKw2nQnwQAu9opvQ
	(envelope-from <linux-integrity+bounces-9078-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 23:05:47 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8E831D1BC
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 23:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0CEBB301F9F5
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 22:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DECBB19343E;
	Tue, 24 Mar 2026 22:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qg1g+TuD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8043D35F5E6
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 22:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389810; cv=none; b=HgDSrMnbvwubHxH9dIysWjLjk1Hei5aggjZcKaRV3IsedeQbMDopihvMfr6Y+0FOysfqwu7ZcmQurk/FBup17zzYfh3/9hfY+rGDU1i2IEAIfAEyNBu762A8/q2bbAA53a8pglnEUixKQTNaS9JGOR0Nub5bJuLvLH4zQGXd8DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389810; c=relaxed/simple;
	bh=vPJOK6SH3kOSai71Obcb8NhSHPFhYVq2vRqkvx0mq5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B406l6KmDfaDtks70BquQYfSSniomEzkGsBoQxMhbN5EI+pkSh3sqWMVdiZhP2Y9RSoSfOOeOgM365jkAZBd5zly/+FaBKZ2ScxcXIsxDv68F7M4ZbYZxCKDLZAbYh7Ml48Fyz468ZcfsDqxbbmGOtubdVz4+fu4dXvvovzlXNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qg1g+TuD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OG2vsN3317009;
	Tue, 24 Mar 2026 22:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QbSY7pj4hlBNtyA5p
	JC5kofZY5n5RHBzZCYgTN3+c8k=; b=qg1g+TuDldWO/79LBzPIk0arg2LlDpf66
	BUkHb1qUevmwc2AVWYmbPqA1GzL0jnDPcEHWNKy5LRQvPI6hdfRzVkomntMDL9Ba
	ZXNBIHH2bzCyr+WCz81QQnJ/LjfY6fsBSitKW29kPp2x8ySmiwhVb5TNpvrWiqBT
	wAHYfgcCOltAxTDkz8q4TkmpQiCeC68uxtKha93hvTDRZzuzUIbhAuHaBOeV84Zq
	YYiOw4E300uHCJLf88+2rz0S2UnSdTDGJZ/pTJXcr5jnYTlQAPSTvNjB/cMWXULr
	J0uu4nBW/q9wI++plOORWrVMkB4nfLmxyD6Jp8U35dkYY4h2qadOw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky055mm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 22:03:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OJLoB7008749;
	Tue, 24 Mar 2026 22:03:19 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nnm2p3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 22:03:19 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OM3Ihg20447866
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 22:03:18 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B70BC58062;
	Tue, 24 Mar 2026 22:03:18 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6903E58052;
	Tue, 24 Mar 2026 22:03:18 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 22:03:18 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils: PATCH 3/8] Implement support for EVM signatures V3 signing scheme
Date: Tue, 24 Mar 2026 18:03:09 -0400
Message-ID: <20260324220314.743709-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324220314.743709-1-stefanb@linux.ibm.com>
References: <20260324220314.743709-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE2OCBTYWx0ZWRfX0URpV4yrRv6f
 Xhu4H76MoCu+wLRA6J2PCPAsOVLRdTvpfby0NPoC1c93Bc5pQYx02K2ttD/B5H/g4MZwuT8PKI0
 8qN+Y1WT1TarW1HSMNP+gJWu/LRFxnpBAfNlGdW3VSYbxE/B80zyEPX62i7h7Rebdmmiwf2Sn9P
 WmHOTajKt2HT9rmZkR9vllcR2rkoIcLbvFWS2dgkhlfgZHche5vIMotGJbh8CZAmQZoMPpUDABQ
 B1Z53mCKzTXReCM5w/l1QoE120CC7L2Ok0bs8LZ7xyGzEa4N7o+vCttKEYYVqbAF8bmevgospPY
 AaIbXL49rCsG0/nXbhgrejZaPYeKzQ6/kTJdc8lNlPjuuM4ECfgmbdQi+YRcEXgr5aFegHPRT40
 yeg3B3AD7LJqTiqmZDD7JiUzVjNM8bCCZc/T2Jr9wN2ovf52+640VPjBFSEBKbTjRXTEvzPWCu6
 7fPXFvqXPoDERBQa44Q==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c30a28 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=onSM0Qx_BTKqystz1eMA:9
X-Proofpoint-ORIG-GUID: yxj_bE_xfo2KwMLRH6oKLRp9JMonQiZH
X-Proofpoint-GUID: yxj_bE_xfo2KwMLRH6oKLRp9JMonQiZH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240168
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9078-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 6A8E831D1BC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for creating EVM signatures with the V3 signing scheme.
Implement the SIGNATURE_v3 case where necessary for EVM.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/evmctl.c | 45 +++++++++++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 14 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 8b44ee0..aab5af9 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -564,8 +564,10 @@ out:
 
 static int sign_evm(const char *file, char *hash_algo, const char *key)
 {
-	unsigned char hash[MAX_DIGEST_SIZE];
 	unsigned char sig[MAX_SIGNATURE_SIZE];
+	unsigned char hash[MAX_DIGEST_SIZE];
+	enum evm_ima_xattr_type xattr_type;
+	unsigned char *psig;
 	size_t len;
 	int err;
 
@@ -575,22 +577,37 @@ static int sign_evm(const char *file, char *hash_algo, const char *key)
 	len = (size_t)err;
 	assert(len <= sizeof(hash));
 
-	err = imaevm_signhash(hash_algo, hash, len, key, g_keypass,
-			      sig + 1, sigflags, &access_info, imaevm_keyid);
-	if (err <= 1)
-		return err;
-	len = (size_t)err;
-	assert(len <= sizeof(sig));
-
-	/* add header */
-	len++;
 	if (evm_portable)
-		sig[0] = EVM_XATTR_PORTABLE_DIGSIG;
+		xattr_type = EVM_XATTR_PORTABLE_DIGSIG;
 	else
-		sig[0] = EVM_IMA_XATTR_DIGSIG;
+		xattr_type = EVM_IMA_XATTR_DIGSIG;
 
-	if (evm_immutable)
-		sig[1] = 3; /* immutable signature version */
+	switch (g_signature_version) {
+	case SIGNATURE_V3:
+		psig = sig;
+		err = imaevm_create_sigv3(hash_algo, hash, len, key, g_keypass,
+					  &psig, sizeof(sig), sigflags,
+					  xattr_type, &access_info,
+					  imaevm_keyid);
+		if (err <= 1)
+			return err;
+		len = (size_t)err;
+		assert(len <= sizeof(sig));
+		break;
+	case SIGNATURE_V2:
+		err = imaevm_signhash(hash_algo, hash, len, key, g_keypass,
+				      sig + 1, sigflags, &access_info, imaevm_keyid);
+		if (err <= 1)
+			return err;
+		len = (size_t)err;
+		assert(len <= sizeof(sig));
+		/* add header */
+		len++;
+		sig[0] = xattr_type;
+		if (evm_immutable)
+			sig[1] = 3; /* immutable signature version */
+		break;
+	}
 
 	if (sigdump || imaevm_params.verbose >= LOG_INFO)
 		imaevm_hexdump(sig, len);
-- 
2.53.0


