Return-Path: <linux-integrity+bounces-9211-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gB6kK3sD4WmJoQAAu9opvQ
	(envelope-from <linux-integrity+bounces-9211-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2026 17:42:51 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CDAD4111E8
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2026 17:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D376A3023365
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Apr 2026 15:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B10CD3E3D91;
	Thu, 16 Apr 2026 15:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T7hyl2tp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A60B3ACA7C;
	Thu, 16 Apr 2026 15:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776354063; cv=none; b=Yu6+Ipu/ZuvTKSo8SsdYZtTmIBDImEGrS1fWiCVGzjQz/nVQWHNELn4XPLm1i0Y2cQksvCeskuZ4Cjy+GjpmSGDukVNf6vR/cFb5X4k9aiJ6E27sjTcODW1kRQDqaBFKKNpRfP8C9T8Cp5TPU2ZyKALP5mHG5YtWuBQYb4soL5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776354063; c=relaxed/simple;
	bh=jKkY1DW1o2uZ8cBOITo74r/GLnXXZXS2gNDmAUtsaNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gneOsFf1eLzVI5aAnkH7pqlGnq7JzRZ/RVMFMtcYsAQFzth1u1hb1NiIaDVgTCzJ++JnGXB3AS9GMgGyGRc/L9zhlSIgbqEtcSe87hRR+5Gy6rloB8mWgL0cCpTtq2h2VVLI5i1r8Du0+9yyOfGIehJgKQNngRtxV+TsGdnuhhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T7hyl2tp; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63G2h2fB1804464;
	Thu, 16 Apr 2026 15:40:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nHn0510uijP7eaJx7
	OGZT/Jhy0mOgnJ0u3FOhaWquq0=; b=T7hyl2tpSCsiIBvMNhuxhYghq7mad3nWE
	14CUmjg7P1Ro/hHncbbkcFq968d2tSwGG1t/ioNy42p7MhoPhX9IIbVLiXNM2UEG
	AvXnerBvQx4tIuqJOY3whBqm4WrTXX5btLutZBb5no+CPn2ytwoso5tU4jbUvVKq
	9fhK5RJmb7zS2Hy9YtS9OXklnVaH4lTd5zr/BnEIJaTf1WuXQ9vjRZDasX6EroMN
	KRAthbIkbP9EgbVDDr4b7zavKSG+lwRkmoNjGHbobpNGn4SUwpTuDblswKZDmx1T
	CDP1cMCQcRgUrYVgKP2fr/i9z1vKUstfpiprrwMnx2Hdkbc7O19NQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89kdb7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 15:40:50 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63GCk8oZ003379;
	Thu, 16 Apr 2026 15:40:50 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4djbh953d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Apr 2026 15:40:50 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63GFemHV28508902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Apr 2026 15:40:48 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F5815804E;
	Thu, 16 Apr 2026 15:40:48 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6D43F5803F;
	Thu, 16 Apr 2026 15:40:47 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Apr 2026 15:40:47 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        roberto.sassu@huawei.com, ebiggers@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v3 4/4] integrity: Add support for sigv3 verification using ML-DSA keys
Date: Thu, 16 Apr 2026 11:40:39 -0400
Message-ID: <20260416154039.1648083-5-stefanb@linux.ibm.com>
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
X-Proofpoint-GUID: AVkZHtKH1cAhDNA7H7qV9XZFKpT-f3GT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE2MDE0NiBTYWx0ZWRfXzUp6tydPMLiz
 L8DRPSJxKAnTVc2E+1Apy88AW8IqcFb7ccSqOhyAQoSWsgnkt+C6SBzWFy9geLlNm15iF1JuyZp
 pHLSMzTfrlb9ICRhfC3QzEX7ufZ3fncdpD4cOaJiv+PSIftAuMGmKAnJSDmtc+At8M99BxGylV+
 PCbhg/bJ9M+3G1pc2noymLnJvD9CdMVKsCRTCLawiO7Qjv1Qgd2kL0I8I5YUsfBzYPLHMeb74JW
 zhf0SrZkjtTYkT/OJzxoYIav7nXPrIrkNgo6AJu07do0tB/NRe5Hpr5ki1XxwJ4Bhy6dMYUdaPr
 Fm4YbdyQnT+YbnCXmq10kcd1n/ljRG6fr/S+lbAK4X/LV0OUk6wnoHMcd5+g2DJU+jAoaz7Iluu
 0pdfwr8d39I2IKo0yuR9fU+30Voyhr++yX5DeXiLuNjdqBKez6jHthKLGaKokixw6xhhDyEPvlM
 pS8pk1okx95KYUedKrw==
X-Proofpoint-ORIG-GUID: AVkZHtKH1cAhDNA7H7qV9XZFKpT-f3GT
X-Authority-Analysis: v=2.4 cv=W60IkxWk c=1 sm=1 tr=0 ts=69e10302 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=d50OJDrPnbFUXeFJyOIA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-16_03,2026-04-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
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
	TAGGED_FROM(0.00)[bounces-9211-lists,linux-integrity=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.ibm.com:mid];
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
X-Rspamd-Queue-Id: 0CDAD4111E8
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
v3:
  - Renamed err_exit label to 'out'
  - Updated kernel-doc for new function
  - Relying on algo verified by caller of asymmetric_verify_v3_hashless
  - NULL pointer check on asymmetric_key_public_key return value

v2: Set hash_algo in public_key_signature to "none"
---
 security/integrity/digsig_asymmetric.c | 89 ++++++++++++++++++++++++--
 1 file changed, 84 insertions(+), 5 deletions(-)

diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index a4eb73bba6d2..b4c23a0ed68f 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -204,20 +204,99 @@ static int calc_file_id_hash(enum evm_ima_xattr_type type,
 	return rc;
 }
 
+/**
+ * asymmetric_verify_v3_hashless - Use hashless signature verification on sigv3
+ * @key: The key to use for signature verification; caller must free it
+ * @pk: The associated public key; must not be NULL
+ * @encoding: The encoding the key type uses
+ * @sig: The xattr signature
+ * @siglen: The length of the xattr signature; must be at least
+ *          sizeof(struct signature_v2_hdr)
+ * @algo: hash algorithm [enum hash_algo]; caller must ensure valid value
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
 
 	if (algo >= HASH_ALGO__LAST)
 		return -ENOPKG;
 
-	rc = calc_file_id_hash(hdr->type, algo, data, &hash);
-	if (rc)
-		return -EINVAL;
+	if (siglen <= sizeof(*hdr))
+		return -EBADMSG;
 
-	return asymmetric_verify(keyring, sig, siglen, hash.digest,
-				 hash.hdr.length);
+	key = request_asymmetric_key(keyring, be32_to_cpu(hdr->keyid));
+	if (IS_ERR(key))
+		return PTR_ERR(key);
+
+	pk = asymmetric_key_public_key(key);
+	if (!pk) {
+		rc = -ENOKEY;
+		goto out;
+	}
+	if (!strncmp(pk->pkey_algo, "mldsa", 5)) {
+		rc = asymmetric_verify_v3_hashless(key, pk, "raw",
+						   sig, siglen, algo, data);
+	} else {
+		rc = calc_file_id_hash(hdr->type, algo, data, &hash);
+		if (rc) {
+			rc = -EINVAL;
+			goto out;
+		}
+
+		rc = asymmetric_verify_common(key, pk, sig, siglen, hash.digest,
+					      hash.hdr.length);
+	}
+
+out:
+	key_put(key);
+
+	return rc;
 }
-- 
2.53.0


