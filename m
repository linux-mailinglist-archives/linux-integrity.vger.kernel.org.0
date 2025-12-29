Return-Path: <linux-integrity+bounces-8142-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E94C6CE7C5F
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Dec 2025 18:52:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98FF330022A9
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Dec 2025 17:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F9E3329E43;
	Mon, 29 Dec 2025 17:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Snsn1Xyb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E59226ED40
	for <linux-integrity@vger.kernel.org>; Mon, 29 Dec 2025 17:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767030749; cv=none; b=QxIV4rBCW2zDeta3xdcTojZA+4IK9GvfVv1FTffX5KBnMozHFVcMBiP4DaD6cZv/2SUv48b2635QQ2nl/H+MMaQ1u9FCJolqL1V7gVUpXQ3lkdIJg2TTptxTauvjjIUbA2QPGJBK92zX5Bd4Ln/BuEQF7DdLOsxyCNLQqyncu+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767030749; c=relaxed/simple;
	bh=ljPh5zUq+sEpFurhxtR6bIxbAZnlXR6NT2B3m5B2m7w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Im7VnUKvA49OQb3JojpPHKUAS0g1+ccPQVrtq1qP/6ZDBLTKZ420FSmcl/dCNkiN7boS38F33Rs+eCjQvDD/GCwikhQgxGrr9Z5W0p3auGxXDyMK5BARlerBrsEm9o3fjWTkjmOxwLyq8w5QNNp7G92bloGPHPb1kR6ZpSekPmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Snsn1Xyb; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7c6cc366884so4436323a34.1
        for <linux-integrity@vger.kernel.org>; Mon, 29 Dec 2025 09:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1767030746; x=1767635546; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=60NTgoLdyDcoabkcaburHQ0p7+ekpPML9FmXy7cbJ70=;
        b=Snsn1Xybpte7bZFJMuHr+C1nu9QUSbI3wmQrO6Bv2+LrdjlR8qWOTAaO2B/atHhGOC
         DrMVs/Vp+0lKy8cpgFy/3aFke2/1JBH1ibZgY0whO1C8T/qkqYME9YbUrkGdY4L1zKqW
         Zafg4UQAV9bNOudIe4/UarAYVd0Tf2C4qrq/+n5h3N/qiQyqTwRBfvA1rHl3WV2fn4Kn
         6zo5Hu7ZguMwcZYkMRFuu5fQNzrTLUV5J2eWF+Nk/p0j25dRM0ol6EFiNdtW9VNMf7qb
         LDvc0lL4l8QLgObbkjzxDoV7zJFHX/KEnAgwWfUEEXHaydWmlxn09iCckQhqX3Onb/wN
         SU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767030746; x=1767635546;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60NTgoLdyDcoabkcaburHQ0p7+ekpPML9FmXy7cbJ70=;
        b=cDXVJjB7FQxIruW5sVZIlRUnn2XHJlYGrinbFCtrE9zYw4S1B7S/mHtgf6VZtb7ZGu
         VRIbb1EfqFXQXMK5OuBg1MCIUTafQJmUXfb+lbvPMgXBcvmvBi0/beT9NkQv/ckvBXCQ
         7XduoA54iXp+tyV5tLfp1iHwLfO/ZdZBIVIm/V1+uWmdnwJO8K1k3f/DcQSDTBl2XjHZ
         QCOaGikoVTCWi3cdLWdiVIKUeGPmRwwwU2IJ+OixDeODfmvi71FTsxg5aSfkKdIMOh6h
         gWe5QyZwVUODsQdZ8Hx6/yqsORC8kK+kyR9auce5/ubzoR3iloQ+KamMYqr2D4kcNZjT
         t8Ow==
X-Forwarded-Encrypted: i=1; AJvYcCWv5koOCdHQushkn/VmY4IAIQ1+OqfvbAiXII5RMwYDcYYAYdmJ6nZQBz61XOzhFewUkXxR+IkWbNEy9y/YiMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIpYbPFcWln0FlMb4+zwEh0zqPntQ09ANWAoiSAFjIl5wjL/kR
	X2F6xSMaWEoY5mCFVFmBv3AMYX8Fu6iSF+W6owrPpDcTV28cV3IPq+tWzH3AvRIzdoELt4etvI4
	4FqjCLRU=
X-Gm-Gg: AY/fxX6/3o0GUph2CZ4CXtfEvtfkOpnNcZgiDuLN5NMSm2SeB98di7qVE1AhlolCWgu
	XsZAlGrBdyTmIY8ZOycUNbA8UgHlmTn4U2evlpnOuUi5eiM5JMwO+Wk3fcYAIYiC1MDjawsJRN/
	JCqR32AfqQc1K00k3AKnSsAk2ElD8t1FmKXxUSymWyMsbOe2ofLjNRBqpM4FxfN2WtYe81v/W6N
	p0CRss15lUri00vefkHtr8xx4O9uZzwKxghxxx8zivxEfiNmdN+uJkda9lYHYGeR2pUWNzOCjAz
	pSKpZ5/06BJgQ/1dC0Qf2EoGWmeHOOZrxpqvHeV8niR0dJJhDpkgXCmffZXg42QnzOy0Fi3iEef
	9z35kv5Kj+1ZbSoGhT9TK3+5Zy1y8VvI7O8LXcSt9McgoEEiIBbfU8SW9SILDIsl7k1UHX6WbBu
	9hEe9J0g==
X-Google-Smtp-Source: AGHT+IEI5lOT00G21ccWwQH/w8No/A8zKWvp8qtAwnhhRywPTYKImfEoGUyWdvXruBHSuBH13g1d/A==
X-Received: by 2002:a05:6830:438d:b0:7c9:5a1d:333a with SMTP id 46e09a7af769-7cc667f3d57mr14820512a34.0.1767030746456;
        Mon, 29 Dec 2025 09:52:26 -0800 (PST)
Received: from [127.0.1.1] ([2a09:bac5:947d:4e6::7d:91])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cc6673bdabsm20820644a34.10.2025.12.29.09.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Dec 2025 09:52:26 -0800 (PST)
From: Frederick Lawler <fred@cloudflare.com>
Date: Mon, 29 Dec 2025 11:52:19 -0600
Subject: [PATCH RFC] ima: Fallback to a ctime guard without i_version
 updates
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251229-xfs-ima-fixup-v1-1-6a717c939f7c@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIANK/UmkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDI0Mj3Yq0Yt3M3ETdtMyK0gJdS2NDcwuDRDOjZKNkJaCegqJUoATYvGi
 lIDdnpdjaWgDCPadVZAAAAA==
X-Change-ID: 20251212-xfs-ima-fixup-931780a62c2c
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
 "Darrick J. Wong" <djwong@kernel.org>, 
 Christian Brauner <brauner@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
 linux-security-module@vger.kernel.org, kernel-team@cloudflare.com, 
 Frederick Lawler <fred@cloudflare.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=8956; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=ljPh5zUq+sEpFurhxtR6bIxbAZnlXR6NT2B3m5B2m7w=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBpUr/ZQbNwWzaDTFY/TpRB9D/+LL4KSiHniMGRw
 TE257C7WzSJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCaVK/2QAKCRCrJbR2A5LT
 bVojD/42MGU+o7C+7ym1BsA3mkCXKD1KEPgy7BEo8LDe9khHyBdpVS4pdg/G1zaZwT2wsZbtvOr
 uIH8bt3mSgZBZLmLmhRjLt4HYghgry4tyA2hy1ALBpP3nJNlm1tuh8xz6cDlmErMCpkUwsS4wDr
 UUzDf8AdxEsQTiwCznF1S5tHLFaHmfBo3fB1Nf2EMKoc5nErHLQsLmImurpIT4cFxgLHKn+zKBX
 z7dHomsJVQ1X4gbmRuXaYePS8W1XlXP5OqtPm71ejrdO7aeNuDzo92TdpA4r1eIT9gJ5ew8LRn2
 Bfalhfp3SxHF5Tc0pbWui658khDIJnnIZxn/CqdOwH+m8mYH+asuXka3l4N5Q9dv5kA3NEVTNw1
 E6pfbwRtpDd/dj5SCz62LK3/mRf9XOWyDT72cd2F/L5MJdqOAVe7ltLPv0tlQfDubC+992ECkPD
 t8O/TivlnpSbji0/d85n0pVRKw+O3pszsBETjdDgOyjMQnZkaHPyp22NHDz7lW+ulmzVCMgzv8p
 +ro/yGWRlSHKRoi47ToeyPetjh1QcPyLwiFtpcfZwLnEfjPS7d78APi66YRlgOsrYR1FSk5weO+
 AHTja2d57VdjGgSuqQEycIv86N32RyCdDWq4DRnDjFEZ39ktHngpSG6Ofcb6jMG7bD/paDwECnj
 s5kEU3QoXiTapjg==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

Since commit 1cf7e834a6fb ("xfs: switch to multigrain timestamps"), IMA
is no longer able to correctly track inode.i_version due to the struct
kstat.change_cookie no longer containing an updated i_version.

Introduce a fallback mechanism for IMA that instead tracks a
integrity_ctime_guard() in absence of or outdated i_version
for stacked file systems.

EVM is left alone since it mostly cares about the backing inode.

Link: https://lore.kernel.org/all/aTspr4_h9IU4EyrR@CMGLRV3
Fixes: 1cf7e834a6fb ("xfs: switch to multigrain timestamps")
Suggested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
The motivation behind this was that file systems that use the
cookie to set the i_version for stacked file systems may still do so.
Then add in the ctime_guard as a fallback if there's a detected change.
The assumption is that the ctime will be different if the i_version is
different anyway for non-stacked file systems.

I'm not too pleased with passing in struct file* to
integrity_inode_attrs_changed() since EVM doesn't currently use
that for now, but I couldn't come up with another idea to get the
stat without coming up with a new stat function to accommodate just
the file path, fully separate out IMA/EVM checks, or lastly add stacked
file system support to EVM (which doesn't make much sense to me
at the moment).

I plan on adding in self test infrastructure for the v1, but I would
like to get some early feedback on the approach first.
---
 include/linux/integrity.h           | 29 ++++++++++++++++++++++++-----
 security/integrity/evm/evm_crypto.c |  2 +-
 security/integrity/evm/evm_main.c   |  2 +-
 security/integrity/ima/ima_api.c    | 21 +++++++++++++++------
 security/integrity/ima/ima_main.c   | 17 ++++++++++-------
 5 files changed, 51 insertions(+), 20 deletions(-)

diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index f5842372359be5341b6870a43b92e695e8fc78af..4964c0f2bbda0ca450d135b9b738bc92256c375a 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -31,19 +31,27 @@ static inline void integrity_load_keys(void)
 
 /* An inode's attributes for detection of changes */
 struct integrity_inode_attributes {
+	u64 ctime_guard;
 	u64 version;		/* track inode changes */
 	unsigned long ino;
 	dev_t dev;
 };
 
+static inline u64 integrity_ctime_guard(struct kstat stat)
+{
+	return stat.ctime.tv_sec ^ stat.ctime.tv_nsec;
+}
+
 /*
  * On stacked filesystems the i_version alone is not enough to detect file data
  * or metadata change. Additional metadata is required.
  */
 static inline void
 integrity_inode_attrs_store(struct integrity_inode_attributes *attrs,
-			    u64 i_version, const struct inode *inode)
+			    u64 i_version, u64 ctime_guard,
+			    const struct inode *inode)
 {
+	attrs->ctime_guard = ctime_guard;
 	attrs->version = i_version;
 	attrs->dev = inode->i_sb->s_dev;
 	attrs->ino = inode->i_ino;
@@ -54,11 +62,22 @@ integrity_inode_attrs_store(struct integrity_inode_attributes *attrs,
  */
 static inline bool
 integrity_inode_attrs_changed(const struct integrity_inode_attributes *attrs,
-			      const struct inode *inode)
+			      struct file *file, struct inode *inode)
 {
-	return (inode->i_sb->s_dev != attrs->dev ||
-		inode->i_ino != attrs->ino ||
-		!inode_eq_iversion(inode, attrs->version));
+	struct kstat stat;
+
+	if (inode->i_sb->s_dev != attrs->dev ||
+	    inode->i_ino != attrs->ino)
+		return true;
+
+	if (inode_eq_iversion(inode, attrs->version))
+		return false;
+
+	if (!file || vfs_getattr_nosec(&file->f_path, &stat, STATX_CTIME,
+				       AT_STATX_SYNC_AS_STAT))
+		return true;
+
+	return attrs->ctime_guard != integrity_ctime_guard(stat);
 }
 
 
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index a5e730ffda57fbc0a91124adaa77b946a12d08b4..2d89c0e8d9360253f8dad52d2a8168127bb4d3b8 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -300,7 +300,7 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 		if (IS_I_VERSION(inode))
 			i_version = inode_query_iversion(inode);
 		integrity_inode_attrs_store(&iint->metadata_inode, i_version,
-					    inode);
+					    0, inode);
 	}
 
 	/* Portable EVM signatures must include an IMA hash */
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 73d500a375cb37a54f295b0e1e93fd6e5d9ecddc..0712802628fd6533383f9855687e19bef7b771c7 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -754,7 +754,7 @@ bool evm_metadata_changed(struct inode *inode, struct inode *metadata_inode)
 	if (iint) {
 		ret = (!IS_I_VERSION(metadata_inode) ||
 		       integrity_inode_attrs_changed(&iint->metadata_inode,
-						     metadata_inode));
+			       NULL, metadata_inode));
 		if (ret)
 			iint->evm_status = INTEGRITY_UNKNOWN;
 	}
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index c35ea613c9f8d404ba4886e3b736c3bab29d1668..72bba8daa588a0f4e45e4249276edb54ca3d77ef 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -254,6 +254,7 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 	int length;
 	void *tmpbuf;
 	u64 i_version = 0;
+	u64 ctime_guard = 0;
 
 	/*
 	 * Always collect the modsig, because IMA might have already collected
@@ -272,10 +273,16 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 	 * to an initial measurement/appraisal/audit, but was modified to
 	 * assume the file changed.
 	 */
-	result = vfs_getattr_nosec(&file->f_path, &stat, STATX_CHANGE_COOKIE,
+	result = vfs_getattr_nosec(&file->f_path, &stat,
+				   STATX_CHANGE_COOKIE | STATX_CTIME,
 				   AT_STATX_SYNC_AS_STAT);
-	if (!result && (stat.result_mask & STATX_CHANGE_COOKIE))
-		i_version = stat.change_cookie;
+	if (!result) {
+		if (stat.result_mask & STATX_CHANGE_COOKIE)
+			i_version = stat.change_cookie;
+
+		if (stat.result_mask & STATX_CTIME)
+			ctime_guard = integrity_ctime_guard(stat);
+	}
 	hash.hdr.algo = algo;
 	hash.hdr.length = hash_digest_size[algo];
 
@@ -305,11 +312,13 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 
 	iint->ima_hash = tmpbuf;
 	memcpy(iint->ima_hash, &hash, length);
-	if (real_inode == inode)
+	if (real_inode == inode) {
 		iint->real_inode.version = i_version;
-	else
+		iint->real_inode.ctime_guard = ctime_guard;
+	} else {
 		integrity_inode_attrs_store(&iint->real_inode, i_version,
-					    real_inode);
+				ctime_guard, real_inode);
+	}
 
 	/* Possibly temporary failure due to type of read (eg. O_DIRECT) */
 	if (!result)
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 5770cf691912aa912fc65280c59f5baac35dd725..6051ea4a472fc0b0dd7b4e81da36eff8bd048c62 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -22,6 +22,7 @@
 #include <linux/mount.h>
 #include <linux/mman.h>
 #include <linux/slab.h>
+#include <linux/stat.h>
 #include <linux/xattr.h>
 #include <linux/ima.h>
 #include <linux/fs.h>
@@ -185,6 +186,7 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
 {
 	fmode_t mode = file->f_mode;
 	bool update;
+	int ret;
 
 	if (!(mode & FMODE_WRITE))
 		return;
@@ -197,12 +199,13 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
 
 		update = test_and_clear_bit(IMA_UPDATE_XATTR,
 					    &iint->atomic_flags);
-		if ((iint->flags & IMA_NEW_FILE) ||
-		    vfs_getattr_nosec(&file->f_path, &stat,
-				      STATX_CHANGE_COOKIE,
-				      AT_STATX_SYNC_AS_STAT) ||
-		    !(stat.result_mask & STATX_CHANGE_COOKIE) ||
-		    stat.change_cookie != iint->real_inode.version) {
+		ret = vfs_getattr_nosec(&file->f_path, &stat,
+					STATX_CHANGE_COOKIE | STATX_CTIME,
+					AT_STATX_SYNC_AS_STAT);
+		if ((iint->flags & IMA_NEW_FILE) || ret ||
+		    (!ret && stat.change_cookie != iint->real_inode.version) ||
+		    (!ret && integrity_ctime_guard(stat) !=
+		     iint->real_inode.ctime_guard)) {
 			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
 			iint->measured_pcrs = 0;
 			if (update)
@@ -330,7 +333,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	    (action & IMA_DO_MASK) && (iint->flags & IMA_DONE_MASK)) {
 		if (!IS_I_VERSION(real_inode) ||
 		    integrity_inode_attrs_changed(&iint->real_inode,
-						  real_inode)) {
+						  file, real_inode)) {
 			iint->flags &= ~IMA_DONE_MASK;
 			iint->measured_pcrs = 0;
 		}

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251212-xfs-ima-fixup-931780a62c2c

Best regards,
-- 
Frederick Lawler <fred@cloudflare.com>


