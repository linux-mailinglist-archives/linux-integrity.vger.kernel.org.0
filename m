Return-Path: <linux-integrity+bounces-9124-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCDlIJTs0mk6cQcAu9opvQ
	(envelope-from <linux-integrity+bounces-9124-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Apr 2026 01:13:24 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1905F3A01E4
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Apr 2026 01:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 205563014C2A
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Apr 2026 23:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1280338552A;
	Sun,  5 Apr 2026 23:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j9/sZUyT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A087C3845BC;
	Sun,  5 Apr 2026 23:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775430772; cv=none; b=pm0jDpPBfW6bLTusecTYvyEW4O2BXKvsfVN4698bZAaMvw/p50nIqQVLsOXPcXI9Ye3M/YOsEb5gsw2Qp2JKB6EBgYcqB2OOnnO+iJFOPko+ij9/cbcWV8Txb9HBVid3XbsBCBGbEZYXfXACXC9b4QQmk1z5ievLr9TGDAg3nAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775430772; c=relaxed/simple;
	bh=dn53yqD4Wjmd6Y+hzxn3Ebd4wRsg5tAZZnZygTLFDzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lTN0yhr1wfa7WzjDQX2Ul0JVidd4V5Nq6ZCytViXq5WDj86VZ67T0YbS/a6SPIxfD0xPTeSDzOjzWUlRS2u41QPaS5m10A8H3JMXMyifAvOThjIrPWhxbljJnGl2C+0gqqwrYtAtWtuX7bRgjmyjU/5a4OsuVkTrwpymfiffZIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j9/sZUyT; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 635MtUGd3691761;
	Sun, 5 Apr 2026 23:12:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ds8sox4K1GduJHJ76
	em70Ce1TsAyhn2hJfA0Nmii33Y=; b=j9/sZUyTpzgb7LI2lsnJ2tRF2WYqetzcz
	eqtTcD4hfJqn6dF1KJxPY0BJuHfVHOEScdqmyYakRpTA1oVcDDGnrD3P5C8u12vl
	EngesoReGeGRoQdjr02vuCwRNUN1ozKCiy5d7RPBvKNXkOSvfv9YvXIH5C5fbLiH
	C2/Hp3n5quFqOLXOXTuw70ZHqhFORoy9L5vDwfLF0EG2UdslBr6yzyEx2bA0M4/l
	GxxZILWm9s4wdvxZbsW9Av07WAbq0mJ8TcOCSMxXs74vZbmIwxD2CsNTfMy5kbL5
	4aRo7wqtTmneBAC7jMYwUHS/HKtWpU4ER85lW+rsTmpCf7ekULTcA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4das2bv9rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 Apr 2026 23:12:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 635LVjFe018571;
	Sun, 5 Apr 2026 23:12:36 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dbcystt7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 Apr 2026 23:12:36 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 635NCZFF16908838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 5 Apr 2026 23:12:35 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1197A5805B;
	Sun,  5 Apr 2026 23:12:35 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E5E858059;
	Sun,  5 Apr 2026 23:12:34 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  5 Apr 2026 23:12:34 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        roberto.sassu@huawei.com, ebiggers@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 3/3] integrity: Add support for sigv3 verification using ML-DSA keys
Date: Sun,  5 Apr 2026 19:12:24 -0400
Message-ID: <20260405231224.4008298-4-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260405231224.4008298-1-stefanb@linux.ibm.com>
References: <20260405231224.4008298-1-stefanb@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 9krQvPjCsB-EYXjdgyggbp37_aS2no4i
X-Proofpoint-GUID: 9krQvPjCsB-EYXjdgyggbp37_aS2no4i
X-Authority-Analysis: v=2.4 cv=U9qfzOru c=1 sm=1 tr=0 ts=69d2ec65 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=X1lcmyak3i-AM5LTbrQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDIzNyBTYWx0ZWRfXxqlGtebHMVQ6
 m5P9TDMJBAv0a0qOo3AizCnsDyOLNxUVsM1JPM2HaRvF1gnZ/GFzYH8EgjgL2Zb9w6IoWud1Zie
 4E2K76SLxXfxrALit4o77Q/+aOT8HjyuYgS3f0ykhgMJu1n1YYbXjJvEVMHkAsCgJVWVcMZg+S+
 OjWGx4fQUKWzI94FDiocW+Xt9mQcEcUmRU9LEnn6AiZ9z6ucLR/JNKst+4uh1IiXSyHtwwNEwX6
 Xo+ynGchK6miWx7Sn0XnsJ1aAQPi6RRf9L7Zxh167J26qXHcG9DdtLV6XzXPN4Sc97p63YDkngK
 93lA5sZWJbyr9TuwXLO6oZUhsawBSeDkUe5N2GbsU3eXO/n9rZfiP2DxcXH7WwKG7Fw/PEImSBL
 i0NbrB24DhKTUW2AD6tUrJzFfV6oTcjzy51SSSH17GmdYhqTEEaCLOorbFgFdn5CmB42EpWy57x
 OKNe7sgNgGQvPxWWTlQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-05_07,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604050237
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
	TAGGED_FROM(0.00)[bounces-9124-lists,linux-integrity=lfdr.de];
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
X-Rspamd-Queue-Id: 1905F3A01E4
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
 security/integrity/digsig_asymmetric.c | 84 ++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 5 deletions(-)

diff --git a/security/integrity/digsig_asymmetric.c b/security/integrity/digsig_asymmetric.c
index e29ed73f15cd..e25534117c16 100644
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
+		.hash_algo = hash_algo_name[hdr->hash_algo],
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


