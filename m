Return-Path: <linux-integrity+bounces-8458-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +J0TCzFVhWmnAAQAu9opvQ
	(envelope-from <linux-integrity+bounces-8458-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 06 Feb 2026 03:42:57 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 98190F9675
	for <lists+linux-integrity@lfdr.de>; Fri, 06 Feb 2026 03:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3474D300DF45
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Feb 2026 02:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CE427E1D7;
	Fri,  6 Feb 2026 02:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="AVa+xyAZ";
	dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b="rAWjGykW"
X-Original-To: linux-integrity@vger.kernel.org
Received: from devnull.danielhodges.dev (vps-2f6e086e.vps.ovh.us [135.148.138.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D7726B777;
	Fri,  6 Feb 2026 02:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.148.138.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770345774; cv=none; b=CN6zWiqDg7tTiD2aVbGz9J6qEHgacKNESsVl/47RclRmnDwuWrlFEZweyPHVDwWFoBLFfjo+57JP37xfmDmJuDggqh36mBaUHsnKON+6yv2O91w2vUaso9PNm4LDEvJ9Hzx82hwEL4q9XC/WK6RW4nv3TTRzOxAIgBM2OJDohRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770345774; c=relaxed/simple;
	bh=EjqcTqvJgyfifjv1G9eHM9eyrpQWYCxokryihyoaUpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XExHVydi+PgopaHIvPqUZEZJV4jyOpcLUWJbW3xCRm66CqGpuYBdZWLyV4iDiYb8rPf421BLMcpHO05Un8Ki0Ln4iyYpkXMvNi22/tcUeVdOkosQ1eJMPCJtnrb+WdDctQUMSE/itz6612V+sM8fFTLCQzzpREVH8amOyJdWqmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev; spf=pass smtp.mailfrom=danielhodges.dev; dkim=pass (2048-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=AVa+xyAZ; dkim=permerror (0-bit key) header.d=danielhodges.dev header.i=@danielhodges.dev header.b=rAWjGykW; arc=none smtp.client-ip=135.148.138.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=danielhodges.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=danielhodges.dev
DKIM-Signature: v=1; a=rsa-sha256; s=202510r; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1770345760; bh=zk/+zbGyL20Elhq5fy6FzET
	paBH9kdAS3LdzpVqUqqY=; b=AVa+xyAZJcZeuNsVzvoW+Hy5e3065hX9zSu2+h8jp8N+19QSo/
	JyrnjLZUrosbDzvUt5a777ts6CKQ0SnQoM952cyrma5DlWxsnt1+j9K9MqxQ7l4f02e5pVTRoDp
	RJZXo0ftyalqouVpjlf07e5mC2+jqevVPS9hO1GNELBhPZ59AHeKR1zkIu6KwUZutsO7YaL1S8A
	v6lBFf8yULUlp52/iXCd8yqB/muE4DUMDpNQF96IDEsmx8TtsT/boQA1ClM3qP4GFlhMQYYGk7V
	mAkTzKYMBsKm/5XfnHdrOdMe6KAlE7QXzAwnU5p1Pvcx6n7rj9iXp7VqBrmFjHt3W8w==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202510e; d=danielhodges.dev; c=relaxed/relaxed;
	h=Message-ID:Date:Subject:To:From; t=1770345760; bh=zk/+zbGyL20Elhq5fy6FzET
	paBH9kdAS3LdzpVqUqqY=; b=rAWjGykWNlU9SttuqYBaoGIGqYDCSP9KtHogIEicxRjP7+0GA9
	T3JFPvW1MioeRDIepN15AlNlQxWc4tyyzRCQ==;
From: Daniel Hodges <git@danielhodges.dev>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Hodges <git@danielhodges.dev>
Subject: [PATCH v2 v2] evm: check return values of crypto_shash functions
Date: Thu,  5 Feb 2026 21:42:40 -0500
Message-ID: <20260206024240.19059-1-git@danielhodges.dev>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <aYNprpzxppKE0Gf2@fb.com>
References: <aYNprpzxppKE0Gf2@fb.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[danielhodges.dev,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[danielhodges.dev:s=202510r,danielhodges.dev:s=202510e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8458-lists,linux-integrity=lfdr.de];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org,danielhodges.dev];
	DKIM_TRACE(0.00)[danielhodges.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[git@danielhodges.dev,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 98190F9675
X-Rspamd-Action: no action

The crypto_shash_update() and crypto_shash_final() functions can fail
and return error codes, but their return values were not being checked
in several places in security/integrity/evm/evm_crypto.c:

- hmac_add_misc() ignored returns from crypto_shash_update() and
  crypto_shash_final()
- evm_calc_hmac_or_hash() ignored returns from crypto_shash_update()
- evm_init_hmac() ignored returns from crypto_shash_update()

If these hash operations fail silently, the resulting HMAC could be
invalid or incomplete, which could weaken the integrity verification
security that EVM provides.

This patch converts hmac_add_misc() from void to int return type and
adds proper error checking and propagation for all crypto_shash_*
function calls. All callers are updated to handle the new return values.
Additionally, error messages are logged when cryptographic operations
fail to provide visibility into the failure rather than silently
returning error codes.

Fixes: 66dbc325afce ("evm: re-release")
Signed-off-by: Daniel Hodges <git@danielhodges.dev>
---
 security/integrity/evm/evm_crypto.c | 55 ++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index a5e730ffda57..402eb1ca64ce 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -139,7 +139,7 @@ static struct shash_desc *init_desc(char type, uint8_t hash_algo)
  * (Additional directory/file metadata needs to be added for more complete
  * protection.)
  */
-static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
+static int hmac_add_misc(struct shash_desc *desc, struct inode *inode,
 			  char type, char *digest)
 {
 	struct h_misc {
@@ -149,6 +149,7 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
 		gid_t gid;
 		umode_t mode;
 	} hmac_misc;
+	int error;
 
 	memset(&hmac_misc, 0, sizeof(hmac_misc));
 	/* Don't include the inode or generation number in portable
@@ -169,14 +170,28 @@ static void hmac_add_misc(struct shash_desc *desc, struct inode *inode,
 	hmac_misc.uid = from_kuid(&init_user_ns, inode->i_uid);
 	hmac_misc.gid = from_kgid(&init_user_ns, inode->i_gid);
 	hmac_misc.mode = inode->i_mode;
-	crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_misc));
+	error = crypto_shash_update(desc, (const u8 *)&hmac_misc, sizeof(hmac_misc));
+	if (error) {
+		pr_err("crypto_shash_update() failed: %d\n", error);
+		return error;
+	}
 	if ((evm_hmac_attrs & EVM_ATTR_FSUUID) &&
-	    type != EVM_XATTR_PORTABLE_DIGSIG)
-		crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid, UUID_SIZE);
-	crypto_shash_final(desc, digest);
+	    type != EVM_XATTR_PORTABLE_DIGSIG) {
+		error = crypto_shash_update(desc, (u8 *)&inode->i_sb->s_uuid, UUID_SIZE);
+		if (error) {
+			pr_err("crypto_shash_update() failed: %d\n", error);
+			return error;
+		}
+	}
+	error = crypto_shash_final(desc, digest);
+	if (error) {
+		pr_err("crypto_shash_final() failed: %d\n", error);
+		return error;
+	}
 
 	pr_debug("hmac_misc: (%zu) [%*phN]\n", sizeof(struct h_misc),
 		 (int)sizeof(struct h_misc), &hmac_misc);
+	return 0;
 }
 
 /*
@@ -260,9 +275,12 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 
 		if ((req_xattr_name && req_xattr_value)
 		    && !strcmp(xattr->name, req_xattr_name)) {
-			error = 0;
-			crypto_shash_update(desc, (const u8 *)req_xattr_value,
+			error = crypto_shash_update(desc, (const u8 *)req_xattr_value,
 					     req_xattr_value_len);
+			if (error) {
+				pr_err("crypto_shash_update() failed: %d\n", error);
+				goto out;
+			}
 			if (is_ima)
 				ima_present = true;
 
@@ -286,15 +304,20 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 			pr_debug("file %s: xattr %s size mismatch (kernel: %d, user: %d)\n",
 				 dentry->d_name.name, xattr->name, size,
 				 user_space_size);
-		error = 0;
 		xattr_size = size;
-		crypto_shash_update(desc, (const u8 *)xattr_value, xattr_size);
+		error = crypto_shash_update(desc, (const u8 *)xattr_value, xattr_size);
+		if (error) {
+			pr_err("crypto_shash_update() failed: %d\n", error);
+			goto out;
+		}
 		if (is_ima)
 			ima_present = true;
 
 		dump_security_xattr(xattr->name, xattr_value, xattr_size);
 	}
-	hmac_add_misc(desc, inode, type, data->digest);
+	error = hmac_add_misc(desc, inode, type, data->digest);
+	if (error)
+		goto out;
 
 	if (inode != d_backing_inode(dentry) && iint) {
 		if (IS_I_VERSION(inode))
@@ -401,6 +424,7 @@ int evm_init_hmac(struct inode *inode, const struct xattr *xattrs,
 {
 	struct shash_desc *desc;
 	const struct xattr *xattr;
+	int error;
 
 	desc = init_desc(EVM_XATTR_HMAC, HASH_ALGO_SHA1);
 	if (IS_ERR(desc)) {
@@ -412,12 +436,17 @@ int evm_init_hmac(struct inode *inode, const struct xattr *xattrs,
 		if (!evm_protected_xattr(xattr->name))
 			continue;
 
-		crypto_shash_update(desc, xattr->value, xattr->value_len);
+		error = crypto_shash_update(desc, xattr->value, xattr->value_len);
+		if (error) {
+			pr_err("crypto_shash_update() failed: %d\n", error);
+			goto out;
+		}
 	}
 
-	hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
+	error = hmac_add_misc(desc, inode, EVM_XATTR_HMAC, hmac_val);
+out:
 	kfree(desc);
-	return 0;
+	return error;
 }
 
 /*
-- 
2.52.0


