Return-Path: <linux-integrity+bounces-9148-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNi7OQmU1mmiGQgAu9opvQ
	(envelope-from <linux-integrity+bounces-9148-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 08 Apr 2026 19:44:41 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7035C3BFC5F
	for <lists+linux-integrity@lfdr.de>; Wed, 08 Apr 2026 19:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FD48304AAC2
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Apr 2026 17:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF362329E7E;
	Wed,  8 Apr 2026 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S4/dKUTj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C3BB3D75CB;
	Wed,  8 Apr 2026 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775670131; cv=none; b=I1Q2BqTA/fB/bcNhdOevV8CRRGo3ae+3xrIXk4RhTi4BtXt+ZzgMLt11N2q9b6QBDmoVqfaecp/b5CPYG8NAB+2k3tYr/Q/AbJPT2yZHDhh/8bZCfHJFmilrqB6yTocrCgTvBZA/BY3sFJmpY76Uc0dWrtJgKkPFi4/PHe+KEGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775670131; c=relaxed/simple;
	bh=BrMuetVpaBFLHhRA+jbk9HT15gBvymjXI4KagFTnBkg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wuz+3Peao4TbOA62aMZNzIM+YyE1tTJ47vBoik6hO4JKDeOSgF3lCcueIFvrA/O8nTsXguooCB9n/R4j7c7VdrsnUz+pmLCdqGiKa6zp/Xi7fs94opuWd0HK4NW25zAQTcXxiPNo9Oay9MucopSBaThiSSHZPg41k9FTz3MPYhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S4/dKUTj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6385lhaG2297936;
	Wed, 8 Apr 2026 17:42:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HPEa+WMuqJ0euATJo
	oXjk7D58G3/Mhr/wTJMYWghzCY=; b=S4/dKUTj54hRKOOf6x4Mxc7AvVewHW60h
	BRezzDSwrvStoo6JWhXfunmp20yns8HT8KNlyUFreaeKdnBHjFLt9XDQ1cqVYumY
	Eg3uK55p4vkE4Ky9b6sMy3DfkDFkohAZ0FGMnN3H1E8JAunK0CDg/vKIuj2QvZ53
	Tm09pcpjc1IK0E2WForHTHR74EIVEVksUqRPpsA/EaFm98uFQB+knwnW8ufnJhcI
	VEPhsynL3eBdFCH3xCComCfn2B8waY4r1xEwbJ3XSls6Tyzh0uheqrIphlhtPUH0
	UAX/8Pr4wUFRa0/55pyFVwzhE65GS/0RNvtuEGZ8DhhTd+wGnu5+A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2g0mcq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 17:42:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 638FP1ir018952;
	Wed, 8 Apr 2026 17:41:59 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dcme9gcmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 17:41:59 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 638HfwEq33423894
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 17:41:58 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E83B45805A;
	Wed,  8 Apr 2026 17:41:57 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A6AF58051;
	Wed,  8 Apr 2026 17:41:57 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 17:41:57 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        roberto.sassu@huawei.com, ebiggers@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 2/2] integrity: Add support for sigv3 verification using ML-DSA keys
Date: Wed,  8 Apr 2026 13:41:54 -0400
Message-ID: <20260408174154.139606-3-stefanb@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=KeridwYD c=1 sm=1 tr=0 ts=69d69368 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=l4_6J5y0UeJh4BTlO3gA:9
X-Proofpoint-ORIG-GUID: Cr2FbTONnOn3jHHypiqwm_PVfF_s7Bu2
X-Proofpoint-GUID: Cr2FbTONnOn3jHHypiqwm_PVfF_s7Bu2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDE2MSBTYWx0ZWRfX8R8wPRJBxojz
 yUE47XtOoKNcn32C8WpYQkHNZ/QjIwxnGwnEar/1a2bjT/KbC+SBzp5ZP9m0sJPafzLYgo8X0hD
 OT/pS4h/XalqLbCPGKvYgDExJt1YJyw3aDSziGxFpvlac9VLnYuooO6jb8izx6NC6PlRmUJCM5p
 A1q9jxmAMyNn55e4gJqbsyr6gIMGTamkuYM3ILKqRZFjNh4v39NgaChINorgUkdKsEfFdiI2UW+
 6hCjbs+7LK5LRA4YCEHzlc0vg/L5tcgoPMPIX1m9hcJ5DKC26VXjBDBBPx8Eqlzkbm2MuX5b6Sy
 NhLd+LmpyGtSA9r+9OopvX4Av0G6CPbLDrprLk+ux2pkuJ2HHzRQf1R5JJ+pmUY28qx/A62L4MV
 AkPoH7fsEIzoTfco9Zc0Il8D3L/SbadRBtY2JcITY7Bu4QiH1Dh8/Lkt4kk/OtXfuL5sMyykRGP
 BIk7MrfWmtPOtEZqZSQ==
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9148-lists,linux-integrity=lfdr.de];
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
X-Rspamd-Queue-Id: 7035C3BFC5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for sigv3 signature verification using ML-DSA in pure mode.
When a sigv3 signature is verified, first check whether the key to use
for verification is an ML-DSA key and therefore uses a hashless signature
verification scheme. The hashless signature verification method uses the
ima_file_id structure directly for signature verification rather than
its digest.

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>

---
v2: Set hash_algo in public_key_signature to "none"
---
 security/integrity/digsig_asymmetric.c | 84 ++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 5 deletions(-)

diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index e29ed73f15cd..c80cb2b117a6 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -190,17 +190,91 @@ static int calc_file_id_hash(enum evm_ima_xattr_type type,
 	return rc;
 }
 
+/*
+ * asymmetric_verify_v3_hashless - Use hashless signature verification on sigv3
+ * @key: The key to use for signature verification
+ * @pk: The associated public key
+ * @encoding: The encoding the key type uses
+ * @sig: The signature
+ * @siglen: The length of the xattr signature
+ * @algo: The hash algorithm
+ * @digest: The file digest
+ *
+ * Create an ima_file_id structure and use it for signature verification
+ * directly. This can be used for ML-DSA in pure mode for example.
+ */
+static int asymmetric_verify_v3_hashless(struct key *key,
+					 const struct public_key *pk,
+					 const char *encoding,
+					 const char *sig, int siglen,
+					 u8 algo,
+					 const u8 *digest)
+{
+	struct signature_v2_hdr *hdr = (struct signature_v2_hdr *)sig;
+	struct ima_file_id file_id = {
+		.hash_type = hdr->type,
+		.hash_algorithm = algo,
+	};
+	size_t digest_size = hash_digest_size[algo];
+	struct public_key_signature pks = {
+		.m = (u8 *)&file_id,
+		.m_size = sizeof(file_id) - (HASH_MAX_DIGESTSIZE - digest_size),
+		.s = hdr->sig,
+		.s_size = siglen - sizeof(*hdr),
+		.pkey_algo = pk->pkey_algo,
+		.hash_algo = "none",
+		.encoding = encoding,
+	};
+	int ret;
+
+	if (hdr->type != IMA_VERITY_DIGSIG &&
+	    hdr->type != EVM_IMA_XATTR_DIGSIG &&
+	    hdr->type != EVM_XATTR_PORTABLE_DIGSIG)
+		return -EINVAL;
+
+	if (pks.s_size != be16_to_cpu(hdr->sig_size))
+		return -EBADMSG;
+
+	memcpy(file_id.hash, digest, digest_size);
+
+	ret = verify_signature(key, &pks);
+	pr_debug("%s() = %d\n", __func__, ret);
+	return ret;
+}
+
 int asymmetric_verify_v3(struct key *keyring, const char *sig, int siglen,
 			 const char *data, int datalen, u8 algo)
 {
 	struct signature_v2_hdr *hdr = (struct signature_v2_hdr *)sig;
 	struct ima_max_digest_data hash;
+	const struct public_key *pk;
+	struct key *key;
 	int rc;
 
-	rc = calc_file_id_hash(hdr->type, algo, data, &hash);
-	if (rc)
-		return -EINVAL;
+	if (siglen <= sizeof(*hdr))
+		return -EBADMSG;
+
+	key = request_asymmetric_key(keyring, be32_to_cpu(hdr->keyid));
+	if (IS_ERR(key))
+		return PTR_ERR(key);
 
-	return asymmetric_verify(keyring, sig, siglen, hash.digest,
-				 hash.hdr.length);
+	pk = asymmetric_key_public_key(key);
+	if (!strncmp(pk->pkey_algo, "mldsa", 5)) {
+		rc = asymmetric_verify_v3_hashless(key, pk, "raw",
+						   sig, siglen, algo, data);
+	} else {
+		rc = calc_file_id_hash(hdr->type, algo, data, &hash);
+		if (rc) {
+			rc = -EINVAL;
+			goto err_exit;
+		}
+
+		rc = asymmetric_verify_common(key, pk, sig, siglen, hash.digest,
+					      hash.hdr.length);
+	}
+
+err_exit:
+	key_put(key);
+
+	return rc;
 }
-- 
2.53.0


