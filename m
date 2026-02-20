Return-Path: <linux-integrity+bounces-8531-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHDEL1ypmGmvKgMAu9opvQ
	(envelope-from <linux-integrity+bounces-8531-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Feb 2026 19:35:08 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64BA316A193
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Feb 2026 19:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9CC64301BCF2
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Feb 2026 18:34:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9F42E7BC2;
	Fri, 20 Feb 2026 18:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="otqZ8Rtn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C144934575F;
	Fri, 20 Feb 2026 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771612484; cv=none; b=poY9eBpe47r/XOVGNdtGx1V6NBgBSpeGos20q+UapQQH4DzA1q8ht7jIGIMTLb/ag5mdkQsPp1ZijxgyQ1vb5VJR5wv7e6hr10the7ZQCWpoaYPZnnaABfPfRyhn1mgSKbVar7cYvXzveyvfP8HsdgG5nLzIabpFlZwvmnuFPFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771612484; c=relaxed/simple;
	bh=H0cwYYtV4pBiRH4iKFq+Hz3gXsJSK0HMomrq9ILCgBI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXbMUz3Hj4Emr8WGNYy+Kr5jk/RixMYHdLAPtkuXkHrE66i2OdxpDPfjELPrvv3wSYNHELh+XlevUpqyOorKpMlbY8sGOBEYRi0LsNoI0XDBDwB/E293J0/Rwx5ovMSarwkj30wqf1Lr41VrVmGbdXMVMVWgIMfyXXuag0ce0Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=otqZ8Rtn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61KE9JU21273842;
	Fri, 20 Feb 2026 18:34:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6jE2K5M6bzA64hhCN
	SjvCMGQBj/dtWws+p8yTqmzJg4=; b=otqZ8RtnGWXL7wW0T+yq3O1G970Rer8KN
	FGps44VMbItf+jTPYTji72P2A7fHI8onFFOZ0VKv5CnZnXcXfo9G+DOfnMRD/L+e
	u+eONUhacIdYSOhKxRZGxjM5zLQvMaLOEdWF9KroQxGl99ASs1cf7PhAxQdvXmK3
	tdXAVZHS3ATKVrKOfMpNL66Y5ZATH/urkWX3uzLfBu3Jrsm9F+snzfCeyNN8TAPM
	X4CmVeHDsH0KsMSy37p/UhrY/Xi+Mseddq0nzydR8hhZXKcMaUTVebvYCQjrTzLA
	kRD8C+cSX8YAbSwCvxvq0CpOo6JT2vTAgKY5HpFHzfpA/QNJh3nRg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4caj6v4hxv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 18:34:40 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61KEHtZg024324;
	Fri, 20 Feb 2026 18:34:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ccb45hjyg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Feb 2026 18:34:39 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 61KIYZ6V60883274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Feb 2026 18:34:35 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C477820300;
	Fri, 20 Feb 2026 18:34:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BBD1202F9;
	Fri, 20 Feb 2026 18:34:30 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.ibm.com.com (unknown [9.39.26.213])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Feb 2026 18:34:30 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, jarkko@kernel.org,
        zohar@linux.ibm.com, stefanb@linux.ibm.com, nayna@linux.ibm.com,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        ssrish@linux.ibm.com
Subject: [PATCH v2 1/2] keys/trusted_keys: clean up debug message logging in the tpm backend
Date: Sat, 21 Feb 2026 00:04:25 +0530
Message-ID: <20260220183426.80446-2-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260220183426.80446-1-ssrish@linux.ibm.com>
References: <20260220183426.80446-1-ssrish@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E+/AZKdl c=1 sm=1 tr=0 ts=6998a940 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=VnNF1IyMAAAA:8 a=MBxKtJUSPDA0k7jbNj0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjIwMDE1MyBTYWx0ZWRfX3zv9Th8p8Wo0
 8IrnknrXkeMe6rOTzOLoxd9h9YQbsSPbo2yv/KT2GWql0iHrp7C4GJwtETmZaAr8lDQ5mCp9z3A
 OqfrUTjb9szD3n8DX1/tmOXWuElohgmj9CD3UPMV6Hn7U/Llnji1XQfkJEpAx4nxYcQ+d3/369y
 FQy/uCiC7dnt1fhisE0fk92zsQwE0ohu+euCvxDYrvWZGMDrZkT5hc0X13m3c6Z/Y/srLMQxxJO
 7WP3x7Qb0KqD0gEjD9YLsOsfiEe7fQQ2ruWf7l1aIuJNG9zi+rHHePjNefMeFqYJOsFIwDr22QP
 KOFtlrGBj/0WavBw9xjbzcAxPPM3Xh5bD26odO3tygkkfNmnM768e+Lls3N85M7qFYW2xRIGHJa
 mFUcfRDjMq0KxIXgqT4lY4o+fmBYIj69zC9EBt2mjZWPogAeyQ4T+2KmGxu2sZav6rj0WXr2+Ia
 R713iwxAsWHSPmMw5UQ==
X-Proofpoint-ORIG-GUID: VpYtXAoQLdfpJDQoTNbdMnQyiTZHlJaV
X-Proofpoint-GUID: VpYtXAoQLdfpJDQoTNbdMnQyiTZHlJaV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-20_02,2026-02-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2602200153
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8531-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-integrity];
	FROM_NEQ_ENVFROM(0.00)[ssrish@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 64BA316A193
X-Rspamd-Action: no action

The TPM trusted-keys backend uses a local TPM_DEBUG guard and pr_info()
for logging debug information.

Replace pr_info() with pr_debug(), and use KERN_DEBUG for print_hex_dump().
Remove TPM_DEBUG.

No functional change intended.

Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
 security/keys/trusted-keys/trusted_tpm1.c | 40 +++++++----------------
 1 file changed, 12 insertions(+), 28 deletions(-)

diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index c865c97aa1b4..216caef97ffc 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -46,28 +46,25 @@ enum {
 	SRK_keytype = 4
 };
 
-#define TPM_DEBUG 0
-
-#if TPM_DEBUG
 static inline void dump_options(struct trusted_key_options *o)
 {
-	pr_info("sealing key type %d\n", o->keytype);
-	pr_info("sealing key handle %0X\n", o->keyhandle);
-	pr_info("pcrlock %d\n", o->pcrlock);
-	pr_info("pcrinfo %d\n", o->pcrinfo_len);
-	print_hex_dump(KERN_INFO, "pcrinfo ", DUMP_PREFIX_NONE,
+	pr_debug("sealing key type %d\n", o->keytype);
+	pr_debug("sealing key handle %0X\n", o->keyhandle);
+	pr_debug("pcrlock %d\n", o->pcrlock);
+	pr_debug("pcrinfo %d\n", o->pcrinfo_len);
+	print_hex_dump(KERN_DEBUG, "pcrinfo ", DUMP_PREFIX_NONE,
 		       16, 1, o->pcrinfo, o->pcrinfo_len, 0);
 }
 
 static inline void dump_sess(struct osapsess *s)
 {
-	print_hex_dump(KERN_INFO, "trusted-key: handle ", DUMP_PREFIX_NONE,
+	print_hex_dump(KERN_DEBUG, "trusted-key: handle ", DUMP_PREFIX_NONE,
 		       16, 1, &s->handle, 4, 0);
-	pr_info("secret:\n");
-	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE,
+	pr_debug("secret:\n");
+	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_NONE,
 		       16, 1, &s->secret, SHA1_DIGEST_SIZE, 0);
-	pr_info("trusted-key: enonce:\n");
-	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE,
+	pr_debug("trusted-key: enonce:\n");
+	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_NONE,
 		       16, 1, &s->enonce, SHA1_DIGEST_SIZE, 0);
 }
 
@@ -75,23 +72,10 @@ static inline void dump_tpm_buf(unsigned char *buf)
 {
 	int len;
 
-	pr_info("\ntpm buffer\n");
+	pr_debug("\ntpm buffer\n");
 	len = LOAD32(buf, TPM_SIZE_OFFSET);
-	print_hex_dump(KERN_INFO, "", DUMP_PREFIX_NONE, 16, 1, buf, len, 0);
-}
-#else
-static inline void dump_options(struct trusted_key_options *o)
-{
-}
-
-static inline void dump_sess(struct osapsess *s)
-{
-}
-
-static inline void dump_tpm_buf(unsigned char *buf)
-{
+	print_hex_dump(KERN_DEBUG, "", DUMP_PREFIX_NONE, 16, 1, buf, len, 0);
 }
-#endif
 
 static int TSS_rawhmac(unsigned char *digest, const unsigned char *key,
 		       unsigned int keylen, ...)
-- 
2.43.0


