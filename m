Return-Path: <linux-integrity+bounces-9066-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eD/6Fpv2wmkEngQAu9opvQ
	(envelope-from <linux-integrity+bounces-9066-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 21:39:55 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DDB231C69D
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 21:39:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 50428300D4FC
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 20:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBB334A77D;
	Tue, 24 Mar 2026 20:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lVNd/ckF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD8C32D0F5
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 20:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774384789; cv=none; b=DFDzXoQep+SrLxVHb+KTclsHRf/55QryDpNNTOr0Sd2y4wSmTQY2xeYp+FrKk/O0Qh1Kjc6uWdhQeI2S5ejJUD0LA/oNV3ITEf64Q8y5aCrrXz1zsNo3nVGG4qQKgylA5sNmJYwPAvxqUpz/SFR+wbMX7Pgq/nFHwkhRs7XmFJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774384789; c=relaxed/simple;
	bh=UDA68rXYw4BnFPGV+0ALpAgBYecShCC8jrbHWVBYleQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BqfayMHxDL5WlZ5SD0H4j3VOdMfQKu2mahMZnZS02DHk3oYQAONOxQQA2FhB0SJH/y7BL09xP0r5LPHtuC65QLz/rslP3G5qgifD3Dhby3bIyTEMwzOeMjgw3YvKZpjsfzaB6rpVEJKPp78WJQwcTM0JXVrnWTqTiUWrtkMwSgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lVNd/ckF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OJtAMf511484;
	Tue, 24 Mar 2026 20:39:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=VB+xssmaRvgmpBOWl
	jNYbAxNyZXEdRJMcfIQqIbH+mo=; b=lVNd/ckFxdtnJP1A7z1/w9Ez8BL2CuOGI
	+zD0+VGnCGIgg6RIXcsyhGzufQ5R4prjB8X1Fjjf6zgyWTPw6zwCNQeFS0tm/NaF
	jvHsBit1GM8GoyrcONyVKsJ2Dm2znd9GLZF5T+LqWiJFcEu5RkSXSkpjgDKSoKUv
	+Niil8LvvQz+o7ZHMdU7D0OwcMjtYnszOHIQ6T4E4X2PoVE+Qu4Y2jDElgYOIgSS
	3tQx5KWFHGMkhar1mJIS1M0YXKWooQyIivXIfqRC0Md3rmA/nXrydAcGSli6TScU
	kt2tq0SEfjr7IwUZSz3OKPWs3WQ0YIY4hxhekjuZnoCQGllqp6syw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kw9wnaj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 20:39:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OH25dm011789;
	Tue, 24 Mar 2026 20:39:43 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4d27vk3k5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 20:39:43 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OKdear44302634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 20:39:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2A372004B;
	Tue, 24 Mar 2026 20:39:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8A0220040;
	Tue, 24 Mar 2026 20:39:38 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.fios-router.home (unknown [9.61.188.204])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 20:39:38 +0000 (GMT)
From: Mimi Zohar <zohar@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Eric Biggers <ebiggers@kernel.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 1/3] ima: Define asymmetric_verify_v3() to verify IMA sigv3 signatures
Date: Tue, 24 Mar 2026 16:39:27 -0400
Message-ID: <20260324203929.2475782-2-zohar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260324203929.2475782-1-zohar@linux.ibm.com>
References: <20260324203929.2475782-1-zohar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Xz_iZ1Dc_Zz8wj8_ry_5hOG1nYhopmpU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE1NyBTYWx0ZWRfX73nea6+FSamZ
 hsmTtl0exHofjMMH9N67tBRFGcfksG5u9uEKwsMiGWTBJJtVy9yV+LemQfU/JnkYCEyesPd0gNY
 BfMlEpAeVJJQyCRlPBYSKjjP+WC+djCHrRlfVj0AZUg2yylbAM3Hg3ft+KneuOUhf23BzMXGqJ8
 V/HssPTyJ2V+AP9lXVIGSRevkTRV+XNU1MD8P7yuIwjFyZoQNTgaGdwIeTZE36ZIEmV4KH7VDDM
 yENhcangvM8kvSZcMVGpn5SXUhvneQD/gqddY86gmk20YWjJph8K4P2fVI/0gbvOQJJlp0ehg7b
 i7+NPPAmtW62vzZ2TMpFKmEdtTj9z6hvSd21ptPXEOUaNClhey525WjTDKKmHl19es96zrTFw7D
 bBPXdeM6VKA5VhLdTy3IWzgnLrlEvfSChmIB/Ljrky8KfDvPg4atn31NY6K74WB2kigCPoHoEJK
 Q9Ui3z9k4x5qM8l731w==
X-Proofpoint-GUID: Xz_iZ1Dc_Zz8wj8_ry_5hOG1nYhopmpU
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c2f690 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=UvSFq85gdjxu-dxzRUkA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240157
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9066-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zohar@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.ibm.com:mid];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 5DDB231C69D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Define asymmetric_verify_v3() to calculate the hash of the struct
ima_file_id, before calling asymmetric_verify() to verify the
signature.

Move and update the existing calc_file_id_hash() function with a
simpler, self contained version.  In addition to the existing hash
data and hash data length arguments, also pass the hash algorithm.

Suggested-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/digsig.c            |  8 ++--
 security/integrity/digsig_asymmetric.c | 58 ++++++++++++++++++++++++
 security/integrity/evm/evm_main.c      |  3 +-
 security/integrity/ima/ima_appraise.c  | 63 ++++++--------------------
 security/integrity/integrity.h         | 14 +++++-
 5 files changed, 90 insertions(+), 56 deletions(-)

diff --git a/security/integrity/digsig.c b/security/integrity/digsig.c
index 75c684cce370..1ed686154d7a 100644
--- a/security/integrity/digsig.c
+++ b/security/integrity/digsig.c
@@ -59,7 +59,7 @@ static struct key *integrity_keyring_from_id(const unsigned int id)
 }
 
 int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
-			    const char *digest, int digestlen)
+			    const char *digest, int digestlen, u8 algo)
 {
 	struct key *keyring;
 
@@ -76,9 +76,11 @@ int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
 		return digsig_verify(keyring, sig + 1, siglen - 1, digest,
 				     digestlen);
 	case 2: /* regular file data hash based signature */
-	case 3: /* struct ima_file_id data based signature */
 		return asymmetric_verify(keyring, sig, siglen, digest,
-					 digestlen);
+					    digestlen);
+	case 3: /* struct ima_file_id data based signature */
+		return asymmetric_verify_v3(keyring, sig, siglen, digest,
+					    digestlen, algo);
 	}
 
 	return -EOPNOTSUPP;
diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index 87be85f477d1..dc5313746609 100644
--- a/security/integrity/digsig_asymmetric.c
+++ b/security/integrity/digsig_asymmetric.c
@@ -131,3 +131,61 @@ int asymmetric_verify(struct key *keyring, const char *sig,
 	pr_debug("%s() = %d\n", __func__, ret);
 	return ret;
 }
+
+/*
+ * calc_file_id_hash - calculate the hash of the ima_file_id struct data
+ * @type: xattr type [enum evm_ima_xattr_type]
+ * @algo: hash algorithm [enum hash_algo]
+ * @digest: pointer to the digest to be hashed
+ * @hash: (out) pointer to the hash
+ *
+ * IMA signature version 3 disambiguates the data that is signed by
+ * indirectly signing the hash of the ima_file_id structure data.
+ *
+ * Return 0 on success, error code otherwise.
+ */
+static int calc_file_id_hash(enum evm_ima_xattr_type type,
+			     enum hash_algo algo, const u8 *digest,
+			     struct ima_max_digest_data *hash)
+{
+	struct ima_file_id file_id = {.hash_type = type, .hash_algorithm = algo};
+	size_t digest_size = hash_digest_size[algo];
+	struct crypto_shash *tfm;
+	size_t file_id_size;
+	int rc;
+
+	if (type != IMA_VERITY_DIGSIG)
+		return -EINVAL;
+
+	tfm = crypto_alloc_shash(hash_algo_name[algo], 0, 0);
+	if (IS_ERR(tfm))
+		return PTR_ERR(tfm);
+
+	memcpy(file_id.hash, digest, digest_size);
+
+	/* Calculate the ima_file_id struct hash on the portion used. */
+	file_id_size = sizeof(file_id) - (HASH_MAX_DIGESTSIZE - digest_size);
+
+	hash->hdr.algo = algo;
+	hash->hdr.length = digest_size;
+	rc = crypto_shash_tfm_digest(tfm, (const u8 *)&file_id, file_id_size,
+				     hash->digest);
+
+	crypto_free_shash(tfm);
+	return rc;
+}
+
+int asymmetric_verify_v3(struct key *keyring, const char *sig, int siglen,
+			 const char *data, int datalen, u8 algo)
+{
+	struct signature_v2_hdr *hdr = (struct signature_v2_hdr *)sig;
+	struct ima_max_digest_data hash;
+	int rc;
+
+	rc = calc_file_id_hash(hdr->type, algo, data, &hash);
+	if (rc)
+		return -EINVAL;
+
+	return asymmetric_verify(keyring, sig, siglen, hash.digest,
+				 hash.hdr.length);
+}
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 1b0089b4b796..b15d9d933b84 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -266,7 +266,8 @@ static enum integrity_status evm_verify_hmac(struct dentry *dentry,
 			break;
 		rc = integrity_digsig_verify(INTEGRITY_KEYRING_EVM,
 					(const char *)xattr_data, xattr_len,
-					digest.digest, digest.hdr.length);
+					digest.digest, digest.hdr.length,
+					digest.hdr.algo);
 		if (!rc) {
 			if (xattr_data->type == EVM_XATTR_PORTABLE_DIGSIG) {
 				if (iint)
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 0d41d102626a..5b42307ac254 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -234,40 +234,6 @@ int ima_read_xattr(struct dentry *dentry,
 	return ret;
 }
 
-/*
- * calc_file_id_hash - calculate the hash of the ima_file_id struct data
- * @type: xattr type [enum evm_ima_xattr_type]
- * @algo: hash algorithm [enum hash_algo]
- * @digest: pointer to the digest to be hashed
- * @hash: (out) pointer to the hash
- *
- * IMA signature version 3 disambiguates the data that is signed by
- * indirectly signing the hash of the ima_file_id structure data.
- *
- * Signing the ima_file_id struct is currently only supported for
- * IMA_VERITY_DIGSIG type xattrs.
- *
- * Return 0 on success, error code otherwise.
- */
-static int calc_file_id_hash(enum evm_ima_xattr_type type,
-			     enum hash_algo algo, const u8 *digest,
-			     struct ima_digest_data *hash)
-{
-	struct ima_file_id file_id = {
-		.hash_type = IMA_VERITY_DIGSIG, .hash_algorithm = algo};
-	unsigned int unused = HASH_MAX_DIGESTSIZE - hash_digest_size[algo];
-
-	if (type != IMA_VERITY_DIGSIG)
-		return -EINVAL;
-
-	memcpy(file_id.hash, digest, hash_digest_size[algo]);
-
-	hash->algo = algo;
-	hash->length = hash_digest_size[algo];
-
-	return ima_calc_buffer_hash(&file_id, sizeof(file_id) - unused, hash);
-}
-
 /*
  * xattr_verify - verify xattr digest or signature
  *
@@ -279,7 +245,6 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
 			struct evm_ima_xattr_data *xattr_value, int xattr_len,
 			enum integrity_status *status, const char **cause)
 {
-	struct ima_max_digest_data hash;
 	struct signature_v2_hdr *sig;
 	int rc = -EINVAL, hash_start = 0;
 	int mask;
@@ -341,7 +306,8 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
 					     (const char *)xattr_value,
 					     xattr_len,
 					     iint->ima_hash->digest,
-					     iint->ima_hash->length);
+					     iint->ima_hash->length,
+					     iint->ima_hash->algo);
 		if (rc == -EOPNOTSUPP) {
 			*status = INTEGRITY_UNKNOWN;
 			break;
@@ -352,7 +318,9 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
 						     (const char *)xattr_value,
 						     xattr_len,
 						     iint->ima_hash->digest,
-						     iint->ima_hash->length);
+						     iint->ima_hash->length,
+						     iint->ima_hash->algo);
+
 		if (rc) {
 			*cause = "invalid-signature";
 			*status = INTEGRITY_FAIL;
@@ -378,21 +346,16 @@ static int xattr_verify(enum ima_hooks func, struct ima_iint_cache *iint,
 			break;
 		}
 
-		rc = calc_file_id_hash(IMA_VERITY_DIGSIG, iint->ima_hash->algo,
-				       iint->ima_hash->digest,
-				       container_of(&hash.hdr,
-					       struct ima_digest_data, hdr));
-		if (rc) {
-			*cause = "sigv3-hashing-error";
-			*status = INTEGRITY_FAIL;
-			break;
-		}
-
 		rc = integrity_digsig_verify(INTEGRITY_KEYRING_IMA,
 					     (const char *)xattr_value,
-					     xattr_len, hash.digest,
-					     hash.hdr.length);
-		if (rc) {
+					     xattr_len,
+					     iint->ima_hash->digest,
+					     iint->ima_hash->length,
+					     iint->ima_hash->algo);
+		if (rc == -EOPNOTSUPP) {
+			*status = INTEGRITY_UNKNOWN;
+			break;
+		} else if (rc) {
 			*cause = "invalid-verity-signature";
 			*status = INTEGRITY_FAIL;
 		} else {
diff --git a/security/integrity/integrity.h b/security/integrity/integrity.h
index 4636629533af..0c581c03c5da 100644
--- a/security/integrity/integrity.h
+++ b/security/integrity/integrity.h
@@ -131,7 +131,7 @@ struct modsig;
 #ifdef CONFIG_INTEGRITY_SIGNATURE
 
 int integrity_digsig_verify(const unsigned int id, const char *sig, int siglen,
-			    const char *digest, int digestlen);
+			    const char *digest, int digestlen, u8 algo);
 int integrity_modsig_verify(unsigned int id, const struct modsig *modsig);
 
 int __init integrity_init_keyring(const unsigned int id);
@@ -142,7 +142,8 @@ int __init integrity_load_cert(const unsigned int id, const char *source,
 
 static inline int integrity_digsig_verify(const unsigned int id,
 					  const char *sig, int siglen,
-					  const char *digest, int digestlen)
+					  const char *digest, int digestlen,
+					  u8 algo)
 {
 	return -EOPNOTSUPP;
 }
@@ -170,12 +171,21 @@ static inline int __init integrity_load_cert(const unsigned int id,
 #ifdef CONFIG_INTEGRITY_ASYMMETRIC_KEYS
 int asymmetric_verify(struct key *keyring, const char *sig,
 		      int siglen, const char *data, int datalen);
+int asymmetric_verify_v3(struct key *keyring, const char *sig,
+			 int siglen, const char *data, int datalen, u8 algo);
 #else
 static inline int asymmetric_verify(struct key *keyring, const char *sig,
 				    int siglen, const char *data, int datalen)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline int asymmetric_verify_v3(struct key *keyring,
+				       const char *sig, int siglen,
+				       const char *data, int datalen, u8 algo)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 #ifdef CONFIG_IMA_APPRAISE_MODSIG
-- 
2.53.0


