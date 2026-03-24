Return-Path: <linux-integrity+bounces-9074-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GJTsDDMKw2lKnwQAu9opvQ
	(envelope-from <linux-integrity+bounces-9074-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 23:03:31 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F57431D162
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 23:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 944713008896
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Mar 2026 22:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A580C2C11D9;
	Tue, 24 Mar 2026 22:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Vig+4n95"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C9F419343E
	for <linux-integrity@vger.kernel.org>; Tue, 24 Mar 2026 22:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774389808; cv=none; b=WTj6lNYcWlLvFdeDPjOZgDv10RmTgmL+PdyW6qKD7EPcfrYNGtpiW5cmOXlhqioslqlSC8YBB0ju0TMnoB+WDoyJN95zSqBSp3jztUoQdUvRkgmKmjkGsjLxZ2ZJdnpQJHQ/Qe5wOD8/QltlkaMdfavLxHPAmSSqGvq/+cxsGNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774389808; c=relaxed/simple;
	bh=47M7NPi9nVmIrLmCwHsf4K6CjPEZQjyrgPIIu0rS9ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bbEtw5nPZZo8lIHXyPv9MjB344BO6Erpz9AxUxxSRMIDzYZ3KikOgCdcYD33EwvRl7qv5tG8bU+BDjDTadaFhRNT7d9zItUk+lUHcP1UIDyaAHTcLLrCBWVKa75jmD5xGGRzZ2AUd6tbvbAqE6vhUTEUrCa3caeyBsirbRYn4YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Vig+4n95; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62OI46JJ4120967;
	Tue, 24 Mar 2026 22:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Fk9YZPcVtowSDKzD/
	rKM5tYQD51GpFXR5P3197tMgug=; b=Vig+4n95SGDQMrQAzUQ3aEmPpCbOJv09A
	863aBOaCSDCLefvohiizO3yEQSEZ+avyIdmUYb05zYKO9gcgFhtW6ZhUcUDMl+sn
	+dFU3eB9efG+w53PQr6SHe2kTJ5juke4D17GoGpdFLzRpa8gNGL0A0wMif2l2TXW
	+6fO2d4Ra/OfYoMJdjbAtmBUoU+PJGLt15uBVmsoIAFpRNiQ7IRayvXrh9PNW4Pi
	gxVJ9cgOkK1iKjS80n++z6bwJrqKS+dzwrA9ntc0EadLuN+ZPj6oaTxTR+Qb6vNF
	ksoGVye+yGRz3zGdSLZJocuj/3SShcZuaUcLxUiv//ki6uj2bPj+A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kw9wwm5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 22:03:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62OJcW28026681;
	Tue, 24 Mar 2026 22:03:19 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275kuydj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 24 Mar 2026 22:03:19 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62OM3IY632244378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Mar 2026 22:03:18 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51B835805A;
	Tue, 24 Mar 2026 22:03:18 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04A7458052;
	Tue, 24 Mar 2026 22:03:18 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 24 Mar 2026 22:03:17 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: [ima-evm-utils: PATCH 2/8] Implement support for IMA signatures V3 signing scheme
Date: Tue, 24 Mar 2026 18:03:08 -0400
Message-ID: <20260324220314.743709-3-stefanb@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 3JxTBSqeZcrAkZgnA-iOXjDpNWNUo2Ve
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE2OCBTYWx0ZWRfX4eaWATRWdfHf
 oFWvgDxz/sSRnXVSGSEEbohqzI0b+Fe6oH57Md06pwwXxt4yh5fEMY4vb/0CiqvuNvOoAvR554s
 fg7Bv48hbu5I+ZSFU2HOxZmmJv8I5w6OARvwahLFobs3eaLlwnoV5HHUliLW64REGKPat5ZxX34
 m/XHQTY+4mg7JF6lPT8sLqQQrgZ6+69XpPTJreGa6a4mY0QLCEA889W93CEoQXOeyTqKfPYsF3o
 6wlb3zpje3Oi0PKSI11cHpCAbNkHnV9DB9VtDgoR8V+myco4oV+A7ymUESQN3ar1tBqC3x+blgw
 MldIaGiNO9gHJTZyqy+Jt1jdN23k7pRaHNpfMjjdZrC7bt8QYFvjnuXsMZX0tGha1qVIrZff8SJ
 kb2OQLnkJwo47i3X3BdXaXJG6k8pOSe78O/PvQIjstO/DcKtHfV+WCNgUlsi1B/JBjT9e4ViJhn
 mHIS5auRDtOU+EIRPEw==
X-Proofpoint-GUID: 3JxTBSqeZcrAkZgnA-iOXjDpNWNUo2Ve
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c30a28 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=yFDnSj8cqcWKfcMObJcA:9
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
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9074-lists,linux-integrity=lfdr.de];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[ibm.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stefanb@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.ibm.com:mid];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 9F57431D162
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for creating IMA signatures with the V3 signing scheme.
Introduce a global variable that states which signing scheme to
use and for now set it to SIGNATURE_V2. Implement the SIGNATURE_V3
case where necessary for IMA.

Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 src/evmctl.c | 87 ++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 67 insertions(+), 20 deletions(-)

diff --git a/src/evmctl.c b/src/evmctl.c
index 7c940fa..8b44ee0 100644
--- a/src/evmctl.c
+++ b/src/evmctl.c
@@ -123,6 +123,13 @@ static bool hwtpm;
 static char *g_hash_algo = DEFAULT_HASH_ALGO;
 static char *g_keypass;
 
+enum signature_version {
+	SIGNATURE_V2 = 2,
+	SIGNATURE_V3,
+};
+
+static enum signature_version g_signature_version = SIGNATURE_V2;
+
 #define HMAC_FLAG_NO_UUID	0x0001
 #define HMAC_FLAG_CAPS_SET	0x0002
 
@@ -652,6 +659,7 @@ static int sign_ima(const char *file, char *hash_algo, const char *key)
 {
 	unsigned char hash[MAX_DIGEST_SIZE];
 	unsigned char sig[MAX_SIGNATURE_SIZE];
+	unsigned char *psig;
 	size_t len;
 	int err;
 
@@ -661,16 +669,35 @@ static int sign_ima(const char *file, char *hash_algo, const char *key)
 	len = (size_t)err;
 	assert(len <= sizeof(hash));
 
-	err = imaevm_signhash(hash_algo, hash, len, key, g_keypass,
-			      sig + 1, sigflags, &access_info, imaevm_keyid);
-	if (err <= 1)
-		return err;
-	len = (size_t)err;
-	assert(len < sizeof(sig));
-
-	/* add header */
-	len++;
-	sig[0] = EVM_IMA_XATTR_DIGSIG;
+	switch (g_signature_version) {
+	case SIGNATURE_V3:
+		psig = sig;
+		err = imaevm_create_sigv3(hash_algo, hash, len, key, g_keypass,
+					  &psig, sizeof(sig), sigflags,
+					  EVM_IMA_XATTR_DIGSIG, &access_info,
+					  imaevm_keyid);
+		if (err <= 1)
+			return err;
+		len = (size_t)err;
+		assert(len <= sizeof(sig));
+		break;
+	case SIGNATURE_V2:
+		err = imaevm_signhash(hash_algo, hash, len, key, g_keypass,
+				      sig + 1, sigflags, &access_info,
+				      imaevm_keyid);
+		if (err <= 1)
+			return err;
+		len = (size_t)err;
+		assert(len < sizeof(sig));
+		/* add header */
+		len++;
+		sig[0] = EVM_IMA_XATTR_DIGSIG;
+		break;
+	default:
+		log_err("Internal error: Unsupported signature version: %d\n",
+			g_signature_version);
+		return -1;
+	}
 
 	if (sigdump || imaevm_params.verbose >= LOG_INFO)
 		imaevm_hexdump(sig, len);
@@ -791,6 +818,7 @@ static int cmd_sign_hash(struct command *cmd)
 	size_t hashlen = 0;
 	int siglen;
 	char *line = NULL, *token, *hashp;
+	unsigned char *psig;
 	size_t line_len = 0;
 	const char *key;
 	char algo[7];	/* Current maximum fsverity hash algo name length */
@@ -863,20 +891,39 @@ static int cmd_sign_hash(struct command *cmd)
 			assert(hashlen / 2 <= sizeof(hash));
 			hex2bin(hash, line, hashlen / 2);
 
-			siglen = imaevm_signhash(g_hash_algo, hash,
-						 hashlen / 2, key, g_keypass,
-						 sig + 1, sigflags,
-						 &access_info, imaevm_keyid);
-			sig[0] = EVM_IMA_XATTR_DIGSIG;
+			switch (g_signature_version) {
+			case SIGNATURE_V3:
+				psig = sig;
+				siglen = imaevm_create_sigv3(g_hash_algo, hash,
+							     hashlen / 2, key, g_keypass,
+							     &psig, sizeof(sig), sigflags,
+							     EVM_IMA_XATTR_DIGSIG,
+							     &access_info, imaevm_keyid);
+				if (siglen <= 1)
+					return siglen;
+				assert(siglen <= (int)sizeof(sig));
+				break;
+			case SIGNATURE_V2:
+				siglen = imaevm_signhash(g_hash_algo, hash,
+							 hashlen / 2, key, g_keypass,
+							 sig + 1, sigflags,
+							 &access_info, imaevm_keyid);
+				if (siglen <= 1)
+					return siglen;
+				assert(siglen < (int)sizeof(sig));
+				siglen++;
+				sig[0] = EVM_IMA_XATTR_DIGSIG;
+				break;
+			default:
+				log_err("Internal error: Unsupported signature version: %d\n",
+					g_signature_version);
+				return -1;
+			}
 		}
 
-		if (siglen <= 1)
-			return siglen;
-		assert(siglen < (int)sizeof(sig));
-
 		fwrite(line, len, 1, stdout);
 		fprintf(stdout, " ");
-		bin2hex(sig, siglen + 1, stdout);
+		bin2hex(sig, siglen, stdout);
 		fprintf(stdout, "\n");
 	}
 
-- 
2.53.0


