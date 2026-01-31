Return-Path: <linux-integrity+bounces-8383-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id stQ0Lx9Jfml1WwIAu9opvQ
	(envelope-from <linux-integrity+bounces-8383-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sat, 31 Jan 2026 19:25:35 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18732C37F9
	for <lists+linux-integrity@lfdr.de>; Sat, 31 Jan 2026 19:25:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB32230097FC
	for <lists+linux-integrity@lfdr.de>; Sat, 31 Jan 2026 18:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FD9322B9F;
	Sat, 31 Jan 2026 18:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="SMP3ApnO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532B03EBF39
	for <linux-integrity@vger.kernel.org>; Sat, 31 Jan 2026 18:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769883930; cv=none; b=S5o55PSb3xQle/ytq1c5lSEtTLTQ8/hBikY3PkAQZopoHJL4zScIyg4OiZ1d4ltwVhEsp43CvVuGIip84De7DlsCgM3lW/PZgV94g3kSgecC3pWLyl7Gi9bJE7GCx8m+JoOd6P6nD1AhTPlaqt5+4vTK8MtFaihSRVlv3Fi916g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769883930; c=relaxed/simple;
	bh=QwQwpCaTYYo7goXQ5iqS/jJz3iMfJpEZ9tI+tyRyxKw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P/8IeGW/gxLAfYAtqcEhJ5UjYYD7fuJD/RJY3b2iqYBl9+WIgAPDbs5TU7jLdR2f+AR9YmSwdvhgryPdgbWj4WxLZDxHFvwB8r90MrT6cz5yTxMWd6IdEDFnTBzTR3yAq3/ZpNtiEWDqHA9Ks7UkQXdnaoxWmURVCfWVCucpXbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=SMP3ApnO; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60VAuxFf1201432
	for <linux-integrity@vger.kernel.org>; Sat, 31 Jan 2026 10:25:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=LVinyxA7r0hBV7ehjn
	wPVpN9/NAHUZwKZWKoXceTfxg=; b=SMP3ApnOPntGF3mDm4Go1T3/UyfdSzc98x
	uq0RrbWZH2XGQETb4H7H10wkQBAFQdD0aq76XW4vIW+Qd5c2KukH244rgpjRCrTo
	ZiRCLjrz2GEAsvOLF9pglp5sv3OQHLMmmXOOu8wHQbO+Q1Qup9qdwF25nbHQL4XH
	nFQa5Yf2HHje8ptbsjeArCeNG47/BOyuB1E3y54Q/CDdvUA+or1inBJtla79K1Cn
	GPTzslRYLFHXW+JqwgARKYH1VVJYOFIYQ2RreqXOiZrVsGjwdta7vnIZYIunQPA2
	vE0uvNnzyiuxhG5f4ijGC4zEqnAQ/piZ+qqW+hJ6yguTcI/6iU6g==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c1ge92dfu-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Sat, 31 Jan 2026 10:25:27 -0800 (PST)
Received: from twshared26871.17.frc2.facebook.com (2620:10d:c0a8:1b::8e35) by
 mail.thefacebook.com (2620:10d:c0a9:6f::8fd4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Sat, 31 Jan 2026 18:25:26 +0000
Received: by devbig010.atn3.facebook.com (Postfix, from userid 224791)
	id 2687074A873; Sat, 31 Jan 2026 10:22:36 -0800 (PST)
From: Daniel Hodges <hodgesd@meta.com>
To: <zohar@linux.ibm.com>, <roberto.sassu@huawei.com>
CC: <dmitry.kasatkin@gmail.com>, <eric.snowberg@oracle.com>,
        <paul@paul-moore.com>, <jmorris@namei.org>, <serge@hallyn.com>,
        <linux-integrity@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Daniel Hodges <hodgesd@meta.com>
Subject: [PATCH] evm: check return values of crypto_shash functions
Date: Sat, 31 Jan 2026 10:22:33 -0800
Message-ID: <20260131182233.2365157-1-hodgesd@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: 0LpPVBjZFIeFeVDVskYZYL5v8E6Nl-Va
X-Proofpoint-ORIG-GUID: 0LpPVBjZFIeFeVDVskYZYL5v8E6Nl-Va
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMxMDE1NiBTYWx0ZWRfX53EynFOJTQoI
 2wwWPyQht5QkhO1TNPjdUcnHXDSZNOBmZL1md9aCQ80tAUmTGgMRbG+7iZORKrGDEdHLVgxH/T7
 +MC++6DbfSjVNpLwPNr3JC4QpLAgTRNMjD7loxPIABHhoL10Riu5c1Qe5GQHzjUNiLjrdXaI/uG
 AZaw9kncCPlsERJAN3MhOEQtPS77k2m2f5GkXBEPRD/zpOUzuTYg5OI6PRgo5/kYESIqLD+hjnE
 Z6M5Jp9mZXx7im4uEFOyXOcTzTYb3nGXklN/wiUWmWepdO3a3vtK1y0KQy2QGq2W2Mjc2katNz/
 LCIkbnx/0ifRhRGHjxM3DucmoA232YseJU8vJzREvUe1SF7wnQdiUblm1zB7QhIOjyS4T8n9oYo
 5sguNuwriKSBcZhtof7QoymHDPsRCq1b1IG1v+sk1hSQs9O1iF+Y56kQbzFtPItli34AO6CgiNa
 EnFMRNIsC69B37kv70g==
X-Authority-Analysis: v=2.4 cv=B8i0EetM c=1 sm=1 tr=0 ts=697e4917 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VabnemYjAAAA:8
 a=PphV3nvnGzEUW2V__sIA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-31_03,2026-01-30_04,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8383-lists,linux-integrity=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,meta.com];
	DKIM_TRACE(0.00)[meta.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hodgesd@meta.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 18732C37F9
X-Rspamd-Action: no action

The crypto_shash_update() and crypto_shash_final() functions can fail
and return error codes, but their return values were being ignored in
several places in evm_crypto.c:

  - hmac_add_misc(): ignores returns from crypto_shash_update() and
    crypto_shash_final()
  - evm_calc_hmac_or_hash(): ignores returns from crypto_shash_update()
  - evm_init_hmac(): ignores returns from crypto_shash_update()

If these hash operations fail silently, the resulting HMAC could be
invalid or incomplete. This could potentially allow integrity
verification to pass with incorrect HMACs, weakening EVM's security
guarantees.

Fix this by:
  - Changing hmac_add_misc() from void to int return type
  - Checking and propagating error codes from all crypto_shash calls
  - Updating all callers to check the return values

Fixes: 66dbc325afce ("evm: re-release")
Signed-off-by: Daniel Hodges <hodgesd@meta.com>
---
 security/integrity/evm/evm_crypto.c | 45 +++++++++++++++++++----------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm=
/evm_crypto.c
index a5e730ffda57..286f23a1a26b 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -132,58 +132,65 @@ static struct shash_desc *init_desc(char type, uint=
8_t hash_algo)
 	}
 	return desc;
 }
=20
 /* Protect against 'cutting & pasting' security.evm xattr, include inode
  * specific info.
  *
  * (Additional directory/file metadata needs to be added for more comple=
te
  * protection.)
  */
-static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
-			  char type, char *digest)
+static int hmac_add_misc(struct shash_desc *desc, struct inode *inode,
+			 char type, char *digest)
 {
 	struct h_misc {
 		unsigned long ino;
 		__u32 generation;
 		uid_t uid;
 		gid_t gid;
 		umode_t mode;
 	} hmac_misc;
+	int ret;
=20
 	memset(&hmac_misc, 0, sizeof(hmac_misc));
 	/* Don't include the inode or generation number in portable
 	 * signatures
 	 */
 	if (type !=3D EVM_XATTR_PORTABLE_DIGSIG) {
 		hmac_misc.ino =3D inode->i_ino;
 		hmac_misc.generation =3D inode->i_generation;
 	}
 	/* The hmac uid and gid must be encoded in the initial user
 	 * namespace (not the filesystems user namespace) as encoding
 	 * them in the filesystems user namespace allows an attack
 	 * where first they are written in an unprivileged fuse mount
 	 * of a filesystem and then the system is tricked to mount the
 	 * filesystem for real on next boot and trust it because
 	 * everything is signed.
 	 */
 	hmac_misc.uid =3D from_kuid(&init_user_ns, inode->i_uid);
 	hmac_misc.gid =3D from_kgid(&init_user_ns, inode->i_gid);
 	hmac_misc.mode =3D inode->i_mode;
-	crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_misc));
+	ret =3D crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_m=
isc));
+	if (ret)
+		return ret;
 	if ((evm_hmac_attrs & EVM_ATTR_FSUUID) &&
-	    type !=3D EVM_XATTR_PORTABLE_DIGSIG)
-		crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid, UUID_SIZE);
-	crypto_shash_final(desc, digest);
+	    type !=3D EVM_XATTR_PORTABLE_DIGSIG) {
+		ret =3D crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid, UUID_SIZ=
E);
+		if (ret)
+			return ret;
+	}
+	ret =3D crypto_shash_final(desc, digest);
=20
 	pr_debug("hmac_misc: (%zu) [%*phN]\n", sizeof(struct h_misc),
 		 (int)sizeof(struct h_misc), &hmac_misc);
+	return ret;
 }
=20
 /*
  * Dump large security xattr values as a continuous ascii hexadecimal st=
ring.
  * (pr_debug is limited to 64 bytes.)
  */
 static void dump_security_xattr_l(const char *prefix, const void *src,
 				  size_t count)
 {
 #if defined(DEBUG) || defined(CONFIG_DYNAMIC_DEBUG)
@@ -253,23 +260,24 @@ static int evm_calc_hmac_or_hash(struct dentry *den=
try,
=20
 		/*
 		 * Skip non-enabled xattrs for locally calculated
 		 * signatures/HMACs.
 		 */
 		if (type !=3D EVM_XATTR_PORTABLE_DIGSIG && !xattr->enabled)
 			continue;
=20
 		if ((req_xattr_name && req_xattr_value)
 		    && !strcmp(xattr->name, req_xattr_name)) {
-			error =3D 0;
-			crypto_shash_update(desc, (const u8 *)req_xattr_value,
-					     req_xattr_value_len);
+			error =3D crypto_shash_update(desc, (const u8 *)req_xattr_value,
+						    req_xattr_value_len);
+			if (error)
+				goto out;
 			if (is_ima)
 				ima_present =3D true;
=20
 			dump_security_xattr(req_xattr_name,
 					    req_xattr_value,
 					    req_xattr_value_len);
 			continue;
 		}
 		size =3D vfs_getxattr_alloc(&nop_mnt_idmap, dentry, xattr->name,
 					  &xattr_value, xattr_size, GFP_NOFS);
@@ -279,29 +287,32 @@ static int evm_calc_hmac_or_hash(struct dentry *den=
try,
 		}
 		if (size < 0)
 			continue;
=20
 		user_space_size =3D vfs_getxattr(&nop_mnt_idmap, dentry,
 					       xattr->name, NULL, 0);
 		if (user_space_size !=3D size)
 			pr_debug("file %s: xattr %s size mismatch (kernel: %d, user: %d)\n",
 				 dentry->d_name.name, xattr->name, size,
 				 user_space_size);
-		error =3D 0;
 		xattr_size =3D size;
-		crypto_shash_update(desc, (const u8 *)xattr_value, xattr_size);
+		error =3D crypto_shash_update(desc, (const u8 *)xattr_value, xattr_siz=
e);
+		if (error)
+			goto out;
 		if (is_ima)
 			ima_present =3D true;
=20
 		dump_security_xattr(xattr->name, xattr_value, xattr_size);
 	}
-	hmac_add_misc(desc, inode, type, data->digest);
+	error =3D hmac_add_misc(desc, inode, type, data->digest);
+	if (error)
+		goto out;
=20
 	if (inode !=3D d_backing_inode(dentry) && iint) {
 		if (IS_I_VERSION(inode))
 			i_version =3D inode_query_iversion(inode);
 		integrity_inode_attrs_store(&iint->metadata_inode, i_version,
 					    inode);
 	}
=20
 	/* Portable EVM signatures must include an IMA hash */
 	if (type =3D=3D EVM_XATTR_PORTABLE_DIGSIG && !ima_present)
@@ -394,37 +405,41 @@ int evm_update_evmxattr(struct dentry *dentry, cons=
t char *xattr_name,
 		rc =3D __vfs_removexattr(&nop_mnt_idmap, dentry, XATTR_NAME_EVM);
 	}
 	return rc;
 }
=20
 int evm_init_hmac(struct inode *inode, const struct xattr *xattrs,
 		  char *hmac_val)
 {
 	struct shash_desc *desc;
 	const struct xattr *xattr;
+	int ret;
=20
 	desc =3D init_desc(EVM_XATTR_HMAC, HASH_ALGO_SHA1);
 	if (IS_ERR(desc)) {
 		pr_info("init_desc failed\n");
 		return PTR_ERR(desc);
 	}
=20
 	for (xattr =3D xattrs; xattr->name; xattr++) {
 		if (!evm_protected_xattr(xattr->name))
 			continue;
=20
-		crypto_shash_update(desc, xattr->value, xattr->value_len);
+		ret =3D crypto_shash_update(desc, xattr->value, xattr->value_len);
+		if (ret)
+			goto out;
 	}
=20
-	hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
+	ret =3D hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
+out:
 	kfree(desc);
-	return 0;
+	return ret;
 }
=20
 /*
  * Get the key from the TPM for the SHA1-HMAC
  */
 int evm_init_key(void)
 {
 	struct key *evm_key;
 	struct encrypted_key_payload *ekp;
 	int rc;
--=20
2.47.3


