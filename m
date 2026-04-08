Return-Path: <linux-integrity+bounces-9147-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKf5JPmT1mmiGQgAu9opvQ
	(envelope-from <linux-integrity+bounces-9147-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 08 Apr 2026 19:44:25 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF1AF3BFC41
	for <lists+linux-integrity@lfdr.de>; Wed, 08 Apr 2026 19:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB8BB30182AE
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Apr 2026 17:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FBF386550;
	Wed,  8 Apr 2026 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SrhHEmCQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BEE33A9F8;
	Wed,  8 Apr 2026 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775670130; cv=none; b=can7bgTN/EMhhAccPKUlU7SA7PbIsYpXfG72cDZwE31LsyxKSiWkcusnLmhYaZPMTy4YlbbIA8BMPXs0XL7p7kYtrNVjoWhOugp1W+APqww1DX6k3v/ZYdS6IRU351Ei/tQOp1HQFywB1H/HuR5VinS0mdIvFRhX45owcw6KAao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775670130; c=relaxed/simple;
	bh=VffJ3U4k2l7pQdgyy08SxjbO5rRNGagE1DF2g+EXWvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uzg2CEI5YiPQRjzlB9+A9/0u+CrLX+/Qs/MrE1tPLAODiX8JgxnZYAzknbo/NIyw5wvMZ/V+jd3NZ/RpDeXdRSgA3Ll2bizjOtI4+PEjXtXPGPug4G35Gp/i8B1/NGuQ8W5QQ/Q9pyiDGQn650Db7ycedAHdXRjTOdFaRzhiclE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SrhHEmCQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6386SJkH2299537;
	Wed, 8 Apr 2026 17:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ljsXZyjvZBW0dqpuj
	VQ2iby7FO11MxaPslmIMj/tcCw=; b=SrhHEmCQiYMot7eTBkc4dq2a0d8YtbFEF
	uIq1XSH9RHOYAoDTrhSNfmd41Dr8eV4XO4ydei84l7WGP7bTr+URwbYhpG2bEAeI
	efCuqLWyPmIzmmyb4p//HjV8Aos/EtgQ80fNXtXDNQJneaYaDoAC1Q6hhl4ahb9Z
	zMiaujAtO4TzPlGeJebREYiuaIMvkgOSCAvH2orlzsoPyl+oe1aGG5U96QSMkPDg
	XtdpC3fJ+3U6kz/4mobY36eZPmBVN/KHJYNB/QFydTRvD1UlQvYiwszdwOkhZdxu
	1LuUmoM86t47rlVN/rwhnaemn9Xio7wpGAyXXDH7rp7W7fuLgguBw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2g0mcn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 17:41:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 638GDh3Z030030;
	Wed, 8 Apr 2026 17:41:58 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcme7gbxe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 17:41:58 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 638HfvCG19202620
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 17:41:57 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6271A5805A;
	Wed,  8 Apr 2026 17:41:57 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E0BDE58051;
	Wed,  8 Apr 2026 17:41:56 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 17:41:56 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        roberto.sassu@huawei.com, ebiggers@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 1/2] integrity: Refactor asymmetric_verify for reusability
Date: Wed,  8 Apr 2026 13:41:53 -0400
Message-ID: <20260408174154.139606-2-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408174154.139606-1-stefanb@linux.ibm.com>
References: <20260408174154.139606-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d69367 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=Tf38nk726vcbPy_It_cA:9
X-Proofpoint-ORIG-GUID: -OkZiZkFq5QLn-rAIoJkQCjlBavOVd0X
X-Proofpoint-GUID: -OkZiZkFq5QLn-rAIoJkQCjlBavOVd0X
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE2MSBTYWx0ZWRfXyLtwpyYfcKAy
 VYUUF1S7NDcppoCVrMeByyDUjuMcWrUJG3ZUlUq7DxqI3ZrwaaslPcNYixJtDCuRrrbkSPybeUu
 viEhz7UBJYsL3m00MP6I4L6atW66vn0VebKF6PNEkqANu2v7bwvnZM4Ytrjcn7WQcHUWljOkUTo
 IDfy8lMziHrsCr2Eyct9B78P9ihCy85jSUvYQh7u1D/de/cc2KoIKClhZ2uChHwPHroxHL1SKqC
 ETachZaBtPYZLFHzd6OJI8yi9IHiMrk6OYNlj/j99/BpUdlu85cAzkfQCqWm7D4U/4and6te3o/
 6Wdtsm2AyfX6uBfMTF93TzGd+yYqIyproAIHwMqtLlKfTvQg3GmUsXuhtH3R6CfI+s8HhLx2goc
 zLmMflVCq5YsMC9rHWCVtHs5SsWXD7c75fKgV/0XK6+/PAehIZ0d86fdWH7soKBA7Q+BfCV4hpZ
 TUy7ZSsn4wpMLmRv/2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_05,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0
 clxscore=1015 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080161
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9147-lists,linux-integrity=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: EF1AF3BFC41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Refactor asymmetric_verify for reusability. Have it call
asymmetric_verify_common with the signature verification key and the
public_key structure as parameters. sigv3 support for ML-DSA will need to
check the public key type first to decide how to do the signature
verification and therefore will have these parameters available for
calling asymmetric_verify_common.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/integrity/digsig_asymmetric.c | 42 +++++++++++++++++---------
 1 file changed, 28 insertions(+), 14 deletions(-)

diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index 6e68ec3becbd..e29ed73f15cd 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -79,18 +79,15 @@ static struct key *request_asymmetric_key(struct key *keyring, uint32_t keyid)
 	return key;
 }
 
-int asymmetric_verify(struct key *keyring, const char *sig,
-		      int siglen, const char *data, int datalen)
+static int asymmetric_verify_common(const struct key *key,
+				    const struct public_key *pk,
+				    const char *sig, int siglen,
+				    const char *data, int datalen)
 {
-	struct public_key_signature pks;
 	struct signature_v2_hdr *hdr = (struct signature_v2_hdr *)sig;
-	const struct public_key *pk;
-	struct key *key;
+	struct public_key_signature pks;
 	int ret;
 
-	if (siglen <= sizeof(*hdr))
-		return -EBADMSG;
-
 	siglen -= sizeof(*hdr);
 
 	if (siglen != be16_to_cpu(hdr->sig_size))
@@ -99,15 +96,10 @@ int asymmetric_verify(struct key *keyring, const char *sig,
 	if (hdr->hash_algo >= HASH_ALGO__LAST)
 		return -ENOPKG;
 
-	key = request_asymmetric_key(keyring, be32_to_cpu(hdr->keyid));
-	if (IS_ERR(key))
-		return PTR_ERR(key);
-
 	memset(&pks, 0, sizeof(pks));
 
 	pks.hash_algo = hash_algo_name[hdr->hash_algo];
 
-	pk = asymmetric_key_public_key(key);
 	pks.pkey_algo = pk->pkey_algo;
 	if (!strcmp(pk->pkey_algo, "rsa")) {
 		pks.encoding = "pkcs1";
@@ -127,11 +119,33 @@ int asymmetric_verify(struct key *keyring, const char *sig,
 	pks.s_size = siglen;
 	ret = verify_signature(key, &pks);
 out:
-	key_put(key);
 	pr_debug("%s() = %d\n", __func__, ret);
 	return ret;
 }
 
+int asymmetric_verify(struct key *keyring, const char *sig,
+		      int siglen, const char *data, int datalen)
+{
+	struct signature_v2_hdr *hdr = (struct signature_v2_hdr *)sig;
+	const struct public_key *pk;
+	struct key *key;
+	int ret;
+
+	if (siglen <= sizeof(*hdr))
+		return -EBADMSG;
+
+	key = request_asymmetric_key(keyring, be32_to_cpu(hdr->keyid));
+	if (IS_ERR(key))
+		return PTR_ERR(key);
+	pk = asymmetric_key_public_key(key);
+
+	ret = asymmetric_verify_common(key, pk, sig, siglen, data, datalen);
+
+	key_put(key);
+
+	return ret;
+}
+
 /*
  * calc_file_id_hash - calculate the hash of the ima_file_id struct data
  * @type: xattr type [enum evm_ima_xattr_type]
-- 
2.53.0


