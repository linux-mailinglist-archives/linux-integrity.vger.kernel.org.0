Return-Path: <linux-integrity+bounces-9082-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPH1LuYKw2nQnwQAu9opvQ
	(envelope-from <linux-integrity+bounces-9082-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 23:06:30 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A3D731D1D9
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 23:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1AFA53092ACA
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 22:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDA923B612;
	Tue, 24 Mar 2026 22:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K6NhXgbl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98C135295C
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 22:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389870; cv=none; b=AL4RpMs1u2P5v6iDhLMFBW00B+ySGkV71H2DgcBTJmPQlHU//KoNme1Ks9skcmJ0nkrq2szLbxJpYhhXq2/XU2yt5Hvtlc+fsAyr9WlLUSSH1kOBg6eaASg9whR2ftY91w7KaIiQkPxIQBP/pZnQrIdPHDohtrpFyFO5bvOvEl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389870; c=relaxed/simple;
	bh=mWv4o5rPlNjCC5EIZP/FmU7uQTDMEWM97rQMkAlPMq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PWtHlfABz3NdhUh0K/lGuBigfGlAxX8JXsWlfssrEI3VrOCjVNIwIl4ZSn12gHlzWR1jXiXkjK2BWsTO6OcRwvNw4/mcczlgbuGWQaRL1Zx/pSF5xbMZfiBWg0FbnickPvacZwHiP7aylYiQSqOtWvEmolOrQlSjg+JkI0gBk9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K6NhXgbl; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OHNstR641818;
	Tue, 24 Mar 2026 22:03:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AHlK4iyhlKvVaH/pn
	vVgr9BNhaJaNelSwKBWaUsGS84=; b=K6NhXgblu17PfQkyd++g+43cSWdbExGLb
	STAqo+RDMw5jKzzUy0qiPu7o59GKkb4CfbnirzCb2gHXR4Jr6lT2zo8cCRSHWLpe
	ovETeGLJ5XkIfdMV3qXcKfzkoeLpD48PSIJHz85tuQgbhVC+cs0Ly6N3TAgo0Gws
	pFlyMkXhCypMIHNkFCsU7o3liCFIrJLSU2BRMksKsBxZLwEyI2eFN4tkW1LK2kce
	6KVXxOV8VN/evdDfd1dn5WS9huHy6KeSlk8q5bCrM1FlS7Vb373Hv0Rz9j79xNAe
	tiewvwh9OZMRfhwTd3FM0VmmLAr5aPEGkVdYBeKLo5rEsRKy3N+zA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kw9wwm3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 22:03:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OIdaho005969;
	Tue, 24 Mar 2026 22:03:19 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d261ym59f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 22:03:19 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OM3HQM23462436
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 22:03:18 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E10FE58056;
	Tue, 24 Mar 2026 22:03:17 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93A0358052;
	Tue, 24 Mar 2026 22:03:17 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 22:03:17 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils: PATCH 1/8] Implement imaevm_create_sigv3 for creating V3 signatures
Date: Tue, 24 Mar 2026 18:03:07 -0400
Message-ID: <20260324220314.743709-2-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: uM5_f5boAHUB2_-a8NqyAH1tBFAkyMXT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE2OCBTYWx0ZWRfXzwENrCyJaCNE
 PqmHvnxD0H5ViQDYXzUjuszoQcyksL5Y8qdtsbGQvFSc3rKwHpPmz1CRV6DiHYk2GaGb9FvpRjS
 pqt8ZR+rJNhUDZgbX4WDrevv6NFKTr29BjHnW+0R3pNIKj5KwC3KrxA2MocJg5n89yh378nxUHT
 fjNksB73QgIXgwpM6qbpBzEXkedHYwuOljr5WbP5coXe5rScJHsq3D4O/DFVutnwa4+k4FXJBZl
 LRVB+yWFOepkbkQQqZE6OxcIIOfsoQmg0KTAL/OpZE1n746/K03JFuz/ZuGM9EVvF13Zq+YLK8V
 8QAlptqq33HjrjQjsPaLRyxp11kvgdNweyEp+EB8+EEre6MVAfI1HGtGtLMMBhlLrrTNPOH7hhL
 90zJ/o39piEIopzNCp3PaaVA9QrvAxP5T6hL0bbbgiOvu8Eac6udzigYCQRNKq+ojYO6Y7hWuda
 D5sTbxv0dusrKDi04gg==
X-Proofpoint-GUID: uM5_f5boAHUB2_-a8NqyAH1tBFAkyMXT
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c30a28 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=J_aLqOt9Vw-xw-7SAykA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240168
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9082-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 3A3D731D1D9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement imaevm_create_sigv3 that creates v3 signatures. This function
will now also allocate a buffer if the caller did not provide one.
Further, it will write the full signature into the signature buffer,
including the leading xattr type byte.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/imaevm.h    |  7 +++++
 src/libimaevm.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/src/imaevm.h b/src/imaevm.h
index 3b720d5..5a8441b 100644
--- a/src/imaevm.h
+++ b/src/imaevm.h
@@ -282,4 +282,11 @@ int imaevm_hash_algo_from_sig(unsigned char *sig);
 const char *imaevm_hash_algo_by_id(int algo);
 int calc_hash_sigv3(enum evm_ima_xattr_type type, const char *algo, const unsigned char *in_hash, unsigned char *out_hash);
 
+int imaevm_create_sigv3(const char *hash_algo, const unsigned char *hash, int size,
+			const char *keyfile, const char *keypass,
+			unsigned char **sig, size_t siglen, long sigflags,
+			enum evm_ima_xattr_type xattr_type,
+			const struct imaevm_ossl_access *access_info,
+			uint32_t keyid);
+
 #endif
diff --git a/src/libimaevm.c b/src/libimaevm.c
index d8d5dbc..7c78432 100644
--- a/src/libimaevm.c
+++ b/src/libimaevm.c
@@ -605,7 +605,7 @@ struct ima_file_id {
 int calc_hash_sigv3(enum evm_ima_xattr_type type, const char *algo,
 		    const unsigned char *in_hash, unsigned char *out_hash)
 {
-	struct ima_file_id file_id = { .hash_type = IMA_VERITY_DIGSIG };
+	struct ima_file_id file_id = { .hash_type = type };
 	uint8_t *data = (uint8_t *) &file_id;
 
 	const EVP_MD *md;
@@ -622,8 +622,9 @@ int calc_hash_sigv3(enum evm_ima_xattr_type type, const char *algo,
 	int hash_size;
 	unsigned int unused;
 
-	if (type != IMA_VERITY_DIGSIG) {
-		log_err("Only fsverity supports signature format v3 (sigv3)\n");
+	if (type != IMA_VERITY_DIGSIG &&
+	    type != EVM_IMA_XATTR_DIGSIG) {
+		log_err("Only fsverity and IMA/EVM support signature format v3 (sigv3)\n");
 		return -EINVAL;
 	}
 
@@ -1449,6 +1450,67 @@ int imaevm_signhash(const char *hashalgo, const unsigned char *hash, int size,
 			    access_info, keyid);
 }
 
+/*
+ * Create a v3 signature given a file hash
+ *
+ * @hash_algo: The hash algorithm to use for hashing
+ * @hash: The file hash
+ * @size: The size of the file hash
+ * @sig: A pointer to signature buffer pointer; if pointing to NULL, then
+ *       this function will allocate a buffer large enough for the signature
+ * @siglen: Size of the given signature buffer; if it is too small then
+ *          an error will be returned
+ * @sigflag: Flags related to the signature
+ * @xattr_type: Type of xattr that will be written; needed for creating
+ *              ima_file_id structure
+ * @access_info: Needed in case an engine or provider is used
+ * @keyid: The key id to use
+ *
+ * Note: This function behaves slightly different than older signature creation
+ *       functions because it already writes the xattr type to offset 0 in the
+ *       signature buffer.
+ */
+int imaevm_create_sigv3(const char *hash_algo, const unsigned char *hash, int size,
+			const char *keyfile, const char *keypass,
+			unsigned char **sig, size_t siglen, long sigflags,
+			enum evm_ima_xattr_type xattr_type,
+			const struct imaevm_ossl_access *access_info,
+			uint32_t keyid)
+{
+	unsigned char sigv3_hash[MAX_DIGEST_SIZE];
+	/* buffer capable of holding (more than) RSA-4096 signature; */
+	unsigned char sigbuf[1024];
+	int len, slen, err;
+
+	len = calc_hash_sigv3(xattr_type, hash_algo, hash, sigv3_hash);
+	if (len < 0 || len == 1) {
+		log_err("Failure to calculate v3 file hash\n");
+		return len;
+	}
+	assert(len <= sizeof(sigv3_hash));
+
+	err = imaevm_signhash(hash_algo, sigv3_hash, len, keyfile, keypass,
+			      &sigbuf[1], sigflags, access_info, keyid);
+	/* err holds error or signature length */
+	if (err < 0)
+		return err;
+	slen = 1 + err; /* will prepend xattr type */
+
+	if (!*sig) {
+		*sig = malloc(slen);
+		if (!*sig)
+			return -1;
+	} else if (siglen < slen) {
+		/* provided buffer is too small */
+		return -1;
+	}
+
+	sigbuf[0] = xattr_type;
+	sigbuf[1] = DIGSIG_VERSION_3;
+	memcpy(*sig, sigbuf, slen);
+
+	return slen;
+}
 
 int sign_hash(const char *hashalgo, const unsigned char *hash, int size,
 	      const char *keyfile, const char *keypass, unsigned char *sig)
-- 
2.53.0


