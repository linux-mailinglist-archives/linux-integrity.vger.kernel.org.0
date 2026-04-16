Return-Path: <linux-integrity+bounces-9212-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GND+MdQD4WmJoQAAu9opvQ
	(envelope-from <linux-integrity+bounces-9212-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2026 17:44:20 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDE9411293
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2026 17:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A02631809ED
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2026 15:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 169B13ACA7C;
	Thu, 16 Apr 2026 15:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ewrprYnw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C503022A80D;
	Thu, 16 Apr 2026 15:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776354124; cv=none; b=ZfNUSVQaj/kMmxyFsVO/vyb8SC28zF1BvCjSYZCTU9s2bELUagTWx0W1rWqr8XiXrsqjSurNyWt9BcDc0zTUohwScsgcLt/AMCXgEt1lUVH1d0VWIZWh5Wb2qO2zqYIK9cIa2G365KVClY+77//VOI2wjGLzjCWFOo7KWX7yDSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776354124; c=relaxed/simple;
	bh=Rgf8Y0sL+2EzuyaQuiNdJwtnN/IKPsFTL9EbJ/ggnPA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Epw1LzmRUDxKDPOn/JGaa6/MZXJ5tEKaLyJ0pkd/He65elu+0EHsSYrlz4X2A45CUonf8zQKHpBxQ9YBnE2V/3bcO98rIj9XnCCmt6L0p5/y/b++rfK6ObJz9A/5slI+4NwDIUubMAd+1hNbXoSxqV8xs4V1vg6BqOuLQo+BWK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ewrprYnw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G9rHL41833140;
	Thu, 16 Apr 2026 15:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=TE5km50Vc83kAjEgo
	Qf5mL5coAwifb5RbTpDZdm3SA8=; b=ewrprYnwhRkmiGWX35dcuwTqQRz3DyJHM
	5i+Wky3S9+tlz6z+gwPVLq2W/93YBCIGE+iidyUAwfep50c89tkAfirOnH7S3kR4
	264HmN7YVdNcdK1xHnvjfprUnDYAkawqjnVbtoHaHdgb4E8VUy+Jgjs6NJzlIQ9Z
	zofsm1p3gVbFlWYeiiw/JeK0rrQWFJXdTKkXHlsl5f58YEXa44bvI4raEaFouScw
	ZupTfUBQ/h3W1mo3UDvQtWqRW2DppBWNFI+xFHinEtyaibTBAx7/vMfjGeG2oMo6
	iOoySBLzrO/n6ahkjlm2Qwr3O3MMO1rIyaCpvRI98wRCVKweWG1+Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89rp8xa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 15:40:50 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63GBuMwZ003594;
	Thu, 16 Apr 2026 15:40:49 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dg1mnkfs6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 15:40:49 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63GFel1H65405274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 15:40:47 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4841B5804E;
	Thu, 16 Apr 2026 15:40:47 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9491B5803F;
	Thu, 16 Apr 2026 15:40:46 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Apr 2026 15:40:46 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        roberto.sassu@huawei.com, ebiggers@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 3/4] integrity: Refactor asymmetric_verify for reusability
Date: Thu, 16 Apr 2026 11:40:38 -0400
Message-ID: <20260416154039.1648083-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416154039.1648083-1-stefanb@linux.ibm.com>
References: <20260416154039.1648083-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE0NiBTYWx0ZWRfX6RhnbVqPmk0V
 kyGE4dgfAls/LXhkin60u718t8RSjL2xzniEscc69YTyJYc2odkdHWIGI8Bzr7XkuU93nUDdQYg
 +q6Qepldc/nE6vj2Xfhxz2P+77/FkHNDQ8WdaU2pvCpJWuCXPrAylXjX2SP+pUab/PDWwoaEs8B
 Xnii7etAB/E19gVY3xFJAeeV12Ptr1gahOPWLxAhI3ROJKmMWwZQdNbt0Kd6/N1Gm3/AkeGYm/t
 Kj91KqNEuHIDs6AnEesvseYBJ6ouI0YbCcvG218MhmZ1NcVqDqqB3I1OH56TA49XKx0gMy1snSJ
 lTMCPsAES6y46KGK/FUegoWKKH0EyRWyXricoliWiSddn8Gvn7WNF1lmRqak1W1wUFE84R/3Ec/
 R+ZomPJ81zOTZAvxHQWnLpXhAHeEgHoRcfOUuoiNcXTEOs1BVxo6miCwmd99nVML7WxnDYlg1XE
 iIl9aUzqcaGpTlSMMnw==
X-Proofpoint-ORIG-GUID: k01mjgMGWmLyHlIbLFvyKNCNzwqldau5
X-Proofpoint-GUID: k01mjgMGWmLyHlIbLFvyKNCNzwqldau5
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69e10302 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=0zGWYjSCjxdcbThUK0gA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604160146
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9212-lists,linux-integrity=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[ibm.com:+];
	TAGGED_RCPT(0.00)[linux-integrity];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 5CDE9411293
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
 v3:
   - added kernel-doc
   - NULL pointer check on asymmetric_key_public_key return value
---
 security/integrity/digsig_asymmetric.c | 62 ++++++++++++++++++--------
 1 file changed, 43 insertions(+), 19 deletions(-)

diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index ed171a627d18..a4eb73bba6d2 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -79,18 +79,25 @@ static struct key *request_asymmetric_key(struct key *keyring, uint32_t keyid)
 	return key;
 }
 
-int asymmetric_verify(struct key *keyring, const char *sig,
-		      int siglen, const char *data, int datalen)
+/**
+ * asymmetric_verify_common -- sigv2 and sigv3 common verify function
+ * @key: The key to use for signature verification; caller must free it
+ * @pk: The associated public key; must not be NULL
+ * @sig: The xattr signature
+ * @siglen: The length of the xattr signature; must be at least
+ *          sizeof(struct signature_v2_hdr)
+ * @data: The data to verify the signature on
+ * @datalen: Length of @data
+ */
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
@@ -99,19 +106,9 @@ int asymmetric_verify(struct key *keyring, const char *sig,
 	if (hdr->hash_algo >= HASH_ALGO__LAST)
 		return -ENOPKG;
 
-	key = request_asymmetric_key(keyring, be32_to_cpu(hdr->keyid));
-	if (IS_ERR(key))
-		return PTR_ERR(key);
-
 	memset(&pks, 0, sizeof(pks));
 
 	pks.hash_algo = hash_algo_name[hdr->hash_algo];
-
-	pk = asymmetric_key_public_key(key);
-	if (!pk) {
-		ret = -ENOKEY;
-		goto out;
-	}
 	pks.pkey_algo = pk->pkey_algo;
 	if (!strcmp(pk->pkey_algo, "rsa")) {
 		pks.encoding = "pkcs1";
@@ -131,11 +128,38 @@ int asymmetric_verify(struct key *keyring, const char *sig,
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
+	if (!pk) {
+		ret = -ENOKEY;
+		goto out;
+	}
+
+	ret = asymmetric_verify_common(key, pk, sig, siglen, data, datalen);
+
+out:
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


