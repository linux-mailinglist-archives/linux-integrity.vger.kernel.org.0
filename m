Return-Path: <linux-integrity+bounces-9123-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UKHILHfs0mk6cQcAu9opvQ
	(envelope-from <linux-integrity+bounces-9123-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Apr 2026 01:12:55 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E8A3A01AE
	for <lists+linux-integrity@lfdr.de>; Mon, 06 Apr 2026 01:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 751F53008500
	for <lists+linux-integrity@lfdr.de>; Sun,  5 Apr 2026 23:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 153243845D1;
	Sun,  5 Apr 2026 23:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="njei4LkJ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67CF2EF67A;
	Sun,  5 Apr 2026 23:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775430771; cv=none; b=FcyHh1799/9w6xXZH8aohTKST3VSh4Ynr5PDyRcmjefP9N9DPceKGIjePGCo1tJmjJ/LZL3GuDir7Hpl57offkqDGlfAnkkbcgiQohf8IQGDhS8M4UJCAixADJMKUOKLroQpD6IrplzXFFT8LxYRnYEpkpPFP6kGkQ4mHhQ2q+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775430771; c=relaxed/simple;
	bh=VffJ3U4k2l7pQdgyy08SxjbO5rRNGagE1DF2g+EXWvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WEzZ5eEPrmNNKOThVLcdeJfl2f+CVIRfPxMJaAerfKNKfYPoXXYSwUkibx+tBL4DB0ro3NVrE+j0ClWfamgg04mSK1HIEf3Euien+pg4Rw2U+TopasfJx8GS6gckUcka6eHF94Y+Truel8l8qtIFLSdZg/XXwoJyj3BLEFKmf7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=njei4LkJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 635MrTg63686441;
	Sun, 5 Apr 2026 23:12:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ljsXZyjvZBW0dqpuj
	VQ2iby7FO11MxaPslmIMj/tcCw=; b=njei4LkJJhqL5AHRfZbpWMDCO3FYjLDdw
	MgIpkdIJteoHCQhdTHmg0LxQaySpRvu7FnuhDVp9N4d/N+8EJMWsnvvS4t5xY44R
	L20t4veMXU0Ltv9gvnqBStTajKHxlgQxdVGd8FxIdGTWyzYZcGgVphn5plxBy1wG
	KbHp8cICQoumpfp4+F0l5doTBZdnYyifc+lEL8FqDpSL7/Metu7HlKH4SM0o7Z+T
	eiv8Fki0y0sqk0c8yAW6QuKwPT+9dIkg7HS/LaYVJ2PNEydoVMgDNnxHdus5AWGa
	hQEBNwVzLOz5FcneuSYRHmwFIBtwA7IBtv/UthWGWxGP+HPzCDoBw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4das2bv9ru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 Apr 2026 23:12:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 635MFMgD021114;
	Sun, 5 Apr 2026 23:12:35 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dbdbyarh0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 05 Apr 2026 23:12:35 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 635NCYCp53281132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 5 Apr 2026 23:12:34 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 39D925805B;
	Sun,  5 Apr 2026 23:12:34 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85DF958059;
	Sun,  5 Apr 2026 23:12:33 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  5 Apr 2026 23:12:33 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        roberto.sassu@huawei.com, ebiggers@kernel.org,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH 2/3] integrity: Refactor asymmetric_verify for reusability
Date: Sun,  5 Apr 2026 19:12:23 -0400
Message-ID: <20260405231224.4008298-3-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: ubKsXJGNsCiycAayMo8eoB6PBLeKKeWH
X-Proofpoint-GUID: ubKsXJGNsCiycAayMo8eoB6PBLeKKeWH
X-Authority-Analysis: v=2.4 cv=U9qfzOru c=1 sm=1 tr=0 ts=69d2ec64 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=Tf38nk726vcbPy_It_cA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA1MDIzNyBTYWx0ZWRfX6w6F6LqURbt0
 mpKmalHtbe8QyVIiXYk17iRGUgUXOT0jTcmsQ70JRbEV1r54y+bNFSAgUel8yD1gMopldGiBpJu
 l0jpIfjrG2T7AHsj+8rhXaGPFuqu4DAr+doo+sf/l/a5tek9dJtf9nRzm2Ic5jvLOpx/B82dedK
 58ubH5KlEzX0EeZQID5yjw6wSUa9auRJbiVqyiTjWV/PIGWiv/WGcrxPxpoLmnJo6T4dDcu7WR0
 dgcpi47OiLediq/uxZKTHj822Ep/f/ViYrwo68a490AZ4hf6zhioQ0lX49J6t03vhW69VGSuQWQ
 Xj7ihPXOCa3q58KwG8Zoy4Jus1MxSW2lFlGzBqaTBJ9smC41M9YTRlaLNAHcHv28T/rxt1e0zgY
 GDSrGUqloLLN+aNrEc9RWcnO0qV1ajRaI1ShoB7bc1e/Se66AqTRYuoTJsx0M5mUpF2ZClJ+EQG
 C5HRZpLZIaf304W/gUw==
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9123-lists,linux-integrity=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.ibm.com:mid];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 54E8A3A01AE
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


