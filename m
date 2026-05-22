Return-Path: <linux-integrity+bounces-9635-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CYiGwkREGrJTAYAu9opvQ
	(envelope-from <linux-integrity+bounces-9635-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 10:17:13 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6875B06AB
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 10:17:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1BF52300D7A1
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 08:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207C43A75A2;
	Fri, 22 May 2026 08:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KC/mSt6m"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6EA3A71B0;
	Fri, 22 May 2026 08:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779437812; cv=none; b=Guc1ovn9iNvf6i6Ua43ZO61yfaRzIoWc801Vqtpd1rRjI2+vTOTNt23OMfQFT1jBqAY9mmht8FASuBsBgV4a2XmcJaHztADCLD33v4OX22JGqZYIP6LnjZzJg/iIXusF1IhWHjtU/okZACmSzR3S3znKZNZNThcTts1QRRYaOuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779437812; c=relaxed/simple;
	bh=90uLSZaNL08XOF3/eK8EjhEfIuSaorlnwiwx5LC6NDk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FJ9YYdiVUNEBLI4u27fnEgJqqgAzK+KDqrTvr8/3CH5S0FngZlnbSwiIKfaY/bIxttl6KZ8rLK9hC+wqaT+sMSzu2AqcHNXY9rbRY6W0wSWRjz9S8gPsxnSvgE0PH+Lwhp7Ni0YvkY2qumF/UEi3Rgw8z8s7ChdSvkOC0RFL/YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KC/mSt6m; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M7R9V1470901;
	Fri, 22 May 2026 08:16:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Ej2vVNOCjSDBAHeB98o52cRVREv7u9/C0Pu6inOZX
	ww=; b=KC/mSt6m/F/JVMhL9CUU34IT2NK+sxNpIwpN6MsMN2758ju5YRwlCl5Rk
	VpElL/42JNo0yYxpfqxnuk74eOyXBrIqRWyuGHK7BfOmykElJpsfQKrdqgonJ+FA
	gRFWyX9HPfMGFT3ZeO3pD5rTTFCdilHZC9zfMtLq95ao+tMaIRScFfJ5ADMoUqfl
	Tq/8upsz/2RzpsdwULQn/AS2Ku84/QoM8GztiE4lVE7nH0CA8FgZhfKoyym9MACH
	nuNrXgDLZLqmJfl38VYRsOMou//pva+PQqtGd85h8nUuPbrsgUhZYS0q5RCcUvJ3
	h/258mUT+lEhyTGN1+E560n+ml3Lg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h88sjwv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 08:16:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64M897qu018867;
	Fri, 22 May 2026 08:16:44 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75kyft10-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 08:16:44 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64M8Gf8C52691202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 08:16:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 048F120049;
	Fri, 22 May 2026 08:16:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6538D20040;
	Fri, 22 May 2026 08:16:38 +0000 (GMT)
Received: from li-fc74f8cc-3279-11b2-a85c-ef5828687581.bl1-in.ibm.com (unknown [9.123.14.23])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 08:16:38 +0000 (GMT)
From: Srish Srinivasan <ssrish@linux.ibm.com>
To: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org
Cc: James.Bottomley@HansenPartnership.com, stefanb@linux.ibm.com,
        jarkko@kernel.org, zohar@linux.ibm.com, nayna@linux.ibm.com,
        rnsastry@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, ssrish@linux.ibm.com
Subject: [PATCH v3] keys/trusted_keys: move TPM-specific fields into trusted_tpm_options
Date: Fri, 22 May 2026 13:46:37 +0530
Message-ID: <20260522081637.189546-1-ssrish@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xVbpNSSIVWfJcpjfTOV5omD4yaDcAzz8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDA4MCBTYWx0ZWRfX4LxZGgTyNvHp
 xPeX9Zpl0dsX6wCDIccyT32HfxpbCkpV5CLBThPdNMQSg5joLx9dOp3zoK+qWI+c+G4ugF+JOsb
 ITIGnzPMOR4JrbS3oSw8LFGkDhIZxYP6yypX01sLc+E3aSDsJ2Geix36qjqdZejm/bnlN9lrctp
 zW9/VvFE8eAS92pFjbo8cT/m6C/JLjk+ElQfGXxx4ts9zCFthQQsNnTfi2YkuDebVXndVDlpqCW
 y5p1Y6MaiwPhFcrHc+4+1GR4RnuPJL1nz6u1Gj2y+w0pIybl7Ca0V7y7hlcClWIDUiBfv6OnHEN
 jmrDTwiKDVe9vWBg7vmWHFTgcXSRJjx3kot8ZduzCqiH5qJ92kXosJnEgxUMC6zi7qM7s8e6vxS
 iXHOE+DjFFmGqxBNYy/NVqbVSug4Tk37iGkxSZnowdVGavyVp3usQlT3aJIuj8CpDH9s/sGKG/h
 8IX1qGlOKWmIKDFQNmQ==
X-Proofpoint-GUID: xVbpNSSIVWfJcpjfTOV5omD4yaDcAzz8
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a1010ed cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=jlqkl6CpOdNBEKQX7CEA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_01,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220080
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9635-lists,linux-integrity=lfdr.de];
	DKIM_TRACE(0.00)[ibm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linux.ibm.com:mid];
	TAGGED_RCPT(0.00)[linux-integrity];
	FROM_NEQ_ENVFROM(0.00)[ssrish@linux.ibm.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 1D6875B06AB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The trusted_key_options struct contains TPM-specific fields (keyhandle,
keyauth, blobauth_len, blobauth, pcrinfo_len, pcrinfo, pcrlock, hash,
policydigest_len, policydigest, and policyhandle). This leads to the
accumulation of backend-specific fields in the generic options structure.

Define a trusted_tpm_options structure and move the TPM-specific fields
there. Store a pointer to trusted_tpm_options in trusted_key_options's
private.

No functional change intended.

Signed-off-by: Srish Srinivasan <ssrish@linux.ibm.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
---
This patch depends on 9ec4175a30eb ("KEYS: trusted: Debugging as a
feature"), which is in linux-tpmdd/master but not yet in mainline.

Please apply on top of linux-tpmdd/master.

base-commit: 67657fb65aa9f2d7dd46235246b1677792bd103e

Changelog:
 v3:
  - Exclude the preparatory clean up patch as the problem has been addressed
    in commit 9ec4175a30eb ("KEYS: trusted: Debugging as a feature")

 v2:
  - Exclude the bug-fix patch as it has already been applied to 6.19-rc7
  - Rename instances of trusted_tpm_options from tpm_opts to private
  - Use pr_debug and KERN_DEBUG for logging debug messages (preparatory clean
    up patch)
  - Address other minor comments from Jarkko

 include/keys/trusted-type.h               | 11 ---
 include/keys/trusted_tpm.h                | 14 ++++
 security/keys/trusted-keys/trusted_tpm1.c | 95 ++++++++++++++---------
 security/keys/trusted-keys/trusted_tpm2.c | 51 ++++++------
 4 files changed, 102 insertions(+), 69 deletions(-)

diff --git a/include/keys/trusted-type.h b/include/keys/trusted-type.h
index 9f9940482da4..3db61b57cf73 100644
--- a/include/keys/trusted-type.h
+++ b/include/keys/trusted-type.h
@@ -39,17 +39,6 @@ struct trusted_key_payload {
 
 struct trusted_key_options {
 	uint16_t keytype;
-	uint32_t keyhandle;
-	unsigned char keyauth[TPM_DIGEST_SIZE];
-	uint32_t blobauth_len;
-	unsigned char blobauth[TPM_DIGEST_SIZE];
-	uint32_t pcrinfo_len;
-	unsigned char pcrinfo[MAX_PCRINFO_SIZE];
-	int pcrlock;
-	uint32_t hash;
-	uint32_t policydigest_len;
-	unsigned char policydigest[MAX_DIGEST_SIZE];
-	uint32_t policyhandle;
 	void *private;
 };
 
diff --git a/include/keys/trusted_tpm.h b/include/keys/trusted_tpm.h
index 0fadc6a4f166..355ebd36cbfd 100644
--- a/include/keys/trusted_tpm.h
+++ b/include/keys/trusted_tpm.h
@@ -7,6 +7,20 @@
 
 extern struct trusted_key_ops trusted_key_tpm_ops;
 
+struct trusted_tpm_options {
+	uint32_t keyhandle;
+	unsigned char keyauth[TPM_DIGEST_SIZE];
+	uint32_t blobauth_len;
+	unsigned char blobauth[TPM_DIGEST_SIZE];
+	uint32_t pcrinfo_len;
+	unsigned char pcrinfo[MAX_PCRINFO_SIZE];
+	int pcrlock;
+	uint32_t hash;
+	uint32_t policydigest_len;
+	unsigned char policydigest[MAX_DIGEST_SIZE];
+	uint32_t policyhandle;
+};
+
 int tpm2_seal_trusted(struct tpm_chip *chip,
 		      struct trusted_key_payload *payload,
 		      struct trusted_key_options *options);
diff --git a/security/keys/trusted-keys/trusted_tpm1.c b/security/keys/trusted-keys/trusted_tpm1.c
index 13513819991e..21360a41d290 100644
--- a/security/keys/trusted-keys/trusted_tpm1.c
+++ b/security/keys/trusted-keys/trusted_tpm1.c
@@ -49,15 +49,17 @@ enum {
 #ifdef CONFIG_TRUSTED_KEYS_DEBUG
 static inline void dump_options(struct trusted_key_options *o)
 {
+	struct trusted_tpm_options *private = o->private;
+
 	if (!trusted_debug)
 		return;
 
 	pr_debug("sealing key type %d\n", o->keytype);
-	pr_debug("sealing key handle %0X\n", o->keyhandle);
-	pr_debug("pcrlock %d\n", o->pcrlock);
-	pr_debug("pcrinfo %d\n", o->pcrinfo_len);
+	pr_debug("sealing key handle %0X\n", private->keyhandle);
+	pr_debug("pcrlock %d\n", private->pcrlock);
+	pr_debug("pcrinfo %d\n", private->pcrinfo_len);
 	print_hex_dump_debug("pcrinfo ", DUMP_PREFIX_NONE,
-			     16, 1, o->pcrinfo, o->pcrinfo_len, 0);
+			     16, 1, private->pcrinfo, private->pcrinfo_len, 0);
 }
 
 static inline void dump_sess(struct osapsess *s)
@@ -631,6 +633,7 @@ static int tpm_unseal(struct tpm_buf *tb,
 static int key_seal(struct trusted_key_payload *p,
 		    struct trusted_key_options *o)
 {
+	struct trusted_tpm_options *private = o->private;
 	struct tpm_buf tb;
 	int ret;
 
@@ -641,9 +644,10 @@ static int key_seal(struct trusted_key_payload *p,
 	/* include migratable flag at end of sealed key */
 	p->key[p->key_len] = p->migratable;
 
-	ret = tpm_seal(&tb, o->keytype, o->keyhandle, o->keyauth,
+	ret = tpm_seal(&tb, o->keytype, private->keyhandle, private->keyauth,
 		       p->key, p->key_len + 1, p->blob, &p->blob_len,
-		       o->blobauth, o->pcrinfo, o->pcrinfo_len);
+		       private->blobauth, private->pcrinfo,
+		       private->pcrinfo_len);
 	if (ret < 0)
 		pr_info("srkseal failed (%d)\n", ret);
 
@@ -657,6 +661,7 @@ static int key_seal(struct trusted_key_payload *p,
 static int key_unseal(struct trusted_key_payload *p,
 		      struct trusted_key_options *o)
 {
+	struct trusted_tpm_options *private = o->private;
 	struct tpm_buf tb;
 	int ret;
 
@@ -664,8 +669,8 @@ static int key_unseal(struct trusted_key_payload *p,
 	if (ret)
 		return ret;
 
-	ret = tpm_unseal(&tb, o->keyhandle, o->keyauth, p->blob, p->blob_len,
-			 o->blobauth, p->key, &p->key_len);
+	ret = tpm_unseal(&tb, private->keyhandle, private->keyauth, p->blob,
+			 p->blob_len, private->blobauth, p->key, &p->key_len);
 	if (ret < 0)
 		pr_info("srkunseal failed (%d)\n", ret);
 	else
@@ -702,6 +707,7 @@ static const match_table_t key_tokens = {
 static int getoptions(char *c, struct trusted_key_payload *pay,
 		      struct trusted_key_options *opt)
 {
+	struct trusted_tpm_options *private = opt->private;
 	substring_t args[MAX_OPT_ARGS];
 	char *p = c;
 	int token;
@@ -717,7 +723,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 	if (tpm2 < 0)
 		return tpm2;
 
-	opt->hash = tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
+	private->hash = tpm2 ? HASH_ALGO_SHA256 : HASH_ALGO_SHA1;
 
 	if (!c)
 		return 0;
@@ -731,11 +737,11 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 
 		switch (token) {
 		case Opt_pcrinfo:
-			opt->pcrinfo_len = strlen(args[0].from) / 2;
-			if (opt->pcrinfo_len > MAX_PCRINFO_SIZE)
+			private->pcrinfo_len = strlen(args[0].from) / 2;
+			if (private->pcrinfo_len > MAX_PCRINFO_SIZE)
 				return -EINVAL;
-			res = hex2bin(opt->pcrinfo, args[0].from,
-				      opt->pcrinfo_len);
+			res = hex2bin(private->pcrinfo, args[0].from,
+				      private->pcrinfo_len);
 			if (res < 0)
 				return -EINVAL;
 			break;
@@ -744,12 +750,12 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 			if (res < 0)
 				return -EINVAL;
 			opt->keytype = SEAL_keytype;
-			opt->keyhandle = handle;
+			private->keyhandle = handle;
 			break;
 		case Opt_keyauth:
 			if (strlen(args[0].from) != 2 * SHA1_DIGEST_SIZE)
 				return -EINVAL;
-			res = hex2bin(opt->keyauth, args[0].from,
+			res = hex2bin(private->keyauth, args[0].from,
 				      SHA1_DIGEST_SIZE);
 			if (res < 0)
 				return -EINVAL;
@@ -760,21 +766,23 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 			 * hex strings.  TPM 2.0 authorizations are simple
 			 * passwords (although it can take a hash as well)
 			 */
-			opt->blobauth_len = strlen(args[0].from);
+			private->blobauth_len = strlen(args[0].from);
 
-			if (opt->blobauth_len == 2 * TPM_DIGEST_SIZE) {
-				res = hex2bin(opt->blobauth, args[0].from,
+			if (private->blobauth_len == 2 * TPM_DIGEST_SIZE) {
+				res = hex2bin(private->blobauth, args[0].from,
 					      TPM_DIGEST_SIZE);
 				if (res < 0)
 					return -EINVAL;
 
-				opt->blobauth_len = TPM_DIGEST_SIZE;
+				private->blobauth_len = TPM_DIGEST_SIZE;
 				break;
 			}
 
-			if (tpm2 && opt->blobauth_len <= sizeof(opt->blobauth)) {
-				memcpy(opt->blobauth, args[0].from,
-				       opt->blobauth_len);
+			if (tpm2 &&
+			    private->blobauth_len <=
+			    sizeof(private->blobauth)) {
+				memcpy(private->blobauth, args[0].from,
+				       private->blobauth_len);
 				break;
 			}
 
@@ -792,14 +800,14 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 			res = kstrtoul(args[0].from, 10, &lock);
 			if (res < 0)
 				return -EINVAL;
-			opt->pcrlock = lock;
+			private->pcrlock = lock;
 			break;
 		case Opt_hash:
 			if (test_bit(Opt_policydigest, &token_mask))
 				return -EINVAL;
 			for (i = 0; i < HASH_ALGO__LAST; i++) {
 				if (!strcmp(args[0].from, hash_algo_name[i])) {
-					opt->hash = i;
+					private->hash = i;
 					break;
 				}
 			}
@@ -811,14 +819,14 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 			}
 			break;
 		case Opt_policydigest:
-			digest_len = hash_digest_size[opt->hash];
+			digest_len = hash_digest_size[private->hash];
 			if (!tpm2 || strlen(args[0].from) != (2 * digest_len))
 				return -EINVAL;
-			res = hex2bin(opt->policydigest, args[0].from,
+			res = hex2bin(private->policydigest, args[0].from,
 				      digest_len);
 			if (res < 0)
 				return -EINVAL;
-			opt->policydigest_len = digest_len;
+			private->policydigest_len = digest_len;
 			break;
 		case Opt_policyhandle:
 			if (!tpm2)
@@ -826,7 +834,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 			res = kstrtoul(args[0].from, 16, &handle);
 			if (res < 0)
 				return -EINVAL;
-			opt->policyhandle = handle;
+			private->policyhandle = handle;
 			break;
 		default:
 			return -EINVAL;
@@ -837,6 +845,7 @@ static int getoptions(char *c, struct trusted_key_payload *pay,
 
 static struct trusted_key_options *trusted_options_alloc(void)
 {
+	struct trusted_tpm_options *private;
 	struct trusted_key_options *options;
 	int tpm2;
 
@@ -849,14 +858,23 @@ static struct trusted_key_options *trusted_options_alloc(void)
 		/* set any non-zero defaults */
 		options->keytype = SRK_keytype;
 
-		if (!tpm2)
-			options->keyhandle = SRKHANDLE;
+		private = kzalloc_obj(*private);
+		if (!private) {
+			kfree_sensitive(options);
+			options = NULL;
+		} else {
+			if (!tpm2)
+				private->keyhandle = SRKHANDLE;
+
+			options->private = private;
+		}
 	}
 	return options;
 }
 
 static int trusted_tpm_seal(struct trusted_key_payload *p, char *datablob)
 {
+	struct trusted_tpm_options *private = NULL;
 	struct trusted_key_options *options = NULL;
 	int ret = 0;
 	int tpm2;
@@ -874,7 +892,8 @@ static int trusted_tpm_seal(struct trusted_key_payload *p, char *datablob)
 		goto out;
 	dump_options(options);
 
-	if (!options->keyhandle && !tpm2) {
+	private = options->private;
+	if (!private->keyhandle && !tpm2) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -888,20 +907,22 @@ static int trusted_tpm_seal(struct trusted_key_payload *p, char *datablob)
 		goto out;
 	}
 
-	if (options->pcrlock) {
-		ret = pcrlock(options->pcrlock);
+	if (private->pcrlock) {
+		ret = pcrlock(private->pcrlock);
 		if (ret < 0) {
 			pr_info("pcrlock failed (%d)\n", ret);
 			goto out;
 		}
 	}
 out:
+	kfree_sensitive(options->private);
 	kfree_sensitive(options);
 	return ret;
 }
 
 static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
 {
+	struct trusted_tpm_options *private = NULL;
 	struct trusted_key_options *options = NULL;
 	int ret = 0;
 	int tpm2;
@@ -919,7 +940,8 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
 		goto out;
 	dump_options(options);
 
-	if (!options->keyhandle && !tpm2) {
+	private = options->private;
+	if (!private->keyhandle && !tpm2) {
 		ret = -EINVAL;
 		goto out;
 	}
@@ -931,14 +953,15 @@ static int trusted_tpm_unseal(struct trusted_key_payload *p, char *datablob)
 	if (ret < 0)
 		pr_info("key_unseal failed (%d)\n", ret);
 
-	if (options->pcrlock) {
-		ret = pcrlock(options->pcrlock);
+	if (private->pcrlock) {
+		ret = pcrlock(private->pcrlock);
 		if (ret < 0) {
 			pr_info("pcrlock failed (%d)\n", ret);
 			goto out;
 		}
 	}
 out:
+	kfree_sensitive(options->private);
 	kfree_sensitive(options);
 	return ret;
 }
diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
index 6340823f8b53..94e01249b921 100644
--- a/security/keys/trusted-keys/trusted_tpm2.c
+++ b/security/keys/trusted-keys/trusted_tpm2.c
@@ -24,6 +24,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 			   struct trusted_key_options *options,
 			   u8 *src, u32 len)
 {
+	struct trusted_tpm_options *private = options->private;
 	const int SCRATCH_SIZE = PAGE_SIZE;
 	u8 *scratch = kmalloc(SCRATCH_SIZE, GFP_KERNEL);
 	u8 *work = scratch, *work1;
@@ -46,7 +47,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 	work = asn1_encode_oid(work, end_work, tpm2key_oid,
 			       asn1_oid_len(tpm2key_oid));
 
-	if (options->blobauth_len == 0) {
+	if (private->blobauth_len == 0) {
 		unsigned char bool[3], *w = bool;
 		/* tag 0 is emptyAuth */
 		w = asn1_encode_boolean(w, w + sizeof(bool), true);
@@ -69,7 +70,7 @@ static int tpm2_key_encode(struct trusted_key_payload *payload,
 		goto err;
 	}
 
-	work = asn1_encode_integer(work, end_work, options->keyhandle);
+	work = asn1_encode_integer(work, end_work, private->keyhandle);
 	work = asn1_encode_octet_string(work, end_work, pub, pub_len);
 	work = asn1_encode_octet_string(work, end_work, priv, priv_len);
 
@@ -102,6 +103,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
 			   struct trusted_key_options *options,
 			   u8 **buf)
 {
+	struct trusted_tpm_options *private = options->private;
 	int ret;
 	struct tpm2_key_context ctx;
 	u8 *blob;
@@ -121,7 +123,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
 		return -ENOMEM;
 
 	*buf = blob;
-	options->keyhandle = ctx.parent;
+	private->keyhandle = ctx.parent;
 
 	memcpy(blob, ctx.priv, ctx.priv_len);
 	blob += ctx.priv_len;
@@ -233,6 +235,7 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		      struct trusted_key_payload *payload,
 		      struct trusted_key_options *options)
 {
+	struct trusted_tpm_options *private = options->private;
 	off_t offset = TPM_HEADER_SIZE;
 	struct tpm_buf buf, sized;
 	int blob_len = 0;
@@ -240,11 +243,11 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 	u32 flags;
 	int rc;
 
-	hash = tpm2_find_hash_alg(options->hash);
+	hash = tpm2_find_hash_alg(private->hash);
 	if (hash < 0)
 		return hash;
 
-	if (!options->keyhandle)
+	if (!private->keyhandle)
 		return -EINVAL;
 
 	rc = tpm_try_get_ops(chip);
@@ -268,18 +271,19 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 		goto out_put;
 	}
 
-	rc = tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
+	rc = tpm_buf_append_name(chip, &buf, private->keyhandle, NULL);
 	if (rc)
 		goto out;
 
 	tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_DECRYPT,
-				    options->keyauth, TPM_DIGEST_SIZE);
+				    private->keyauth, TPM_DIGEST_SIZE);
 
 	/* sensitive */
-	tpm_buf_append_u16(&sized, options->blobauth_len);
+	tpm_buf_append_u16(&sized, private->blobauth_len);
 
-	if (options->blobauth_len)
-		tpm_buf_append(&sized, options->blobauth, options->blobauth_len);
+	if (private->blobauth_len)
+		tpm_buf_append(&sized, private->blobauth,
+			       private->blobauth_len);
 
 	tpm_buf_append_u16(&sized, payload->key_len);
 	tpm_buf_append(&sized, payload->key, payload->key_len);
@@ -292,14 +296,15 @@ int tpm2_seal_trusted(struct tpm_chip *chip,
 
 	/* key properties */
 	flags = 0;
-	flags |= options->policydigest_len ? 0 : TPM2_OA_USER_WITH_AUTH;
+	flags |= private->policydigest_len ? 0 : TPM2_OA_USER_WITH_AUTH;
 	flags |= payload->migratable ? 0 : (TPM2_OA_FIXED_TPM | TPM2_OA_FIXED_PARENT);
 	tpm_buf_append_u32(&sized, flags);
 
 	/* policy */
-	tpm_buf_append_u16(&sized, options->policydigest_len);
-	if (options->policydigest_len)
-		tpm_buf_append(&sized, options->policydigest, options->policydigest_len);
+	tpm_buf_append_u16(&sized, private->policydigest_len);
+	if (private->policydigest_len)
+		tpm_buf_append(&sized, private->policydigest,
+			       private->policydigest_len);
 
 	/* public parameters */
 	tpm_buf_append_u16(&sized, TPM_ALG_NULL);
@@ -373,6 +378,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 			 u32 *blob_handle)
 {
 	u8 *blob_ref __free(kfree) = NULL;
+	struct trusted_tpm_options *private = options->private;
 	struct tpm_buf buf;
 	unsigned int private_len;
 	unsigned int public_len;
@@ -392,7 +398,7 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 	}
 
 	/* new format carries keyhandle but old format doesn't */
-	if (!options->keyhandle)
+	if (!private->keyhandle)
 		return -EINVAL;
 
 	/* must be big enough for at least the two be16 size counts */
@@ -433,11 +439,11 @@ static int tpm2_load_cmd(struct tpm_chip *chip,
 		return rc;
 	}
 
-	rc = tpm_buf_append_name(chip, &buf, options->keyhandle, NULL);
+	rc = tpm_buf_append_name(chip, &buf, private->keyhandle, NULL);
 	if (rc)
 		goto out;
 
-	tpm_buf_append_hmac_session(chip, &buf, 0, options->keyauth,
+	tpm_buf_append_hmac_session(chip, &buf, 0, private->keyauth,
 				    TPM_DIGEST_SIZE);
 
 	tpm_buf_append(&buf, blob, blob_len);
@@ -481,6 +487,7 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 			   struct trusted_key_options *options,
 			   u32 blob_handle)
 {
+	struct trusted_tpm_options *private = options->private;
 	struct tpm_header *head;
 	struct tpm_buf buf;
 	u16 data_len;
@@ -502,10 +509,10 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 	if (rc)
 		goto out;
 
-	if (!options->policyhandle) {
+	if (!private->policyhandle) {
 		tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_ENCRYPT,
-					    options->blobauth,
-					    options->blobauth_len);
+					    private->blobauth,
+					    private->blobauth_len);
 	} else {
 		/*
 		 * FIXME: The policy session was generated outside the
@@ -518,9 +525,9 @@ static int tpm2_unseal_cmd(struct tpm_chip *chip,
 		 * could repeat our actions with the exfiltrated
 		 * password.
 		 */
-		tpm2_buf_append_auth(&buf, options->policyhandle,
+		tpm2_buf_append_auth(&buf, private->policyhandle,
 				     NULL /* nonce */, 0, 0,
-				     options->blobauth, options->blobauth_len);
+				     private->blobauth, private->blobauth_len);
 		if (tpm2_chip_auth(chip)) {
 			tpm_buf_append_hmac_session(chip, &buf, TPM2_SA_ENCRYPT, NULL, 0);
 		} else  {

-- 
2.51.0


