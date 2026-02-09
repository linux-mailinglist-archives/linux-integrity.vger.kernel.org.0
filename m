Return-Path: <linux-integrity+bounces-8482-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Ma9JAVQimmbJQAAu9opvQ
	(envelope-from <linux-integrity+bounces-8482-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 09 Feb 2026 22:22:13 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB66114BE0
	for <lists+linux-integrity@lfdr.de>; Mon, 09 Feb 2026 22:22:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89BA63028359
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Feb 2026 21:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF1331194C;
	Mon,  9 Feb 2026 21:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="dV61Z9B2"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 093F230F94D
	for <linux-integrity@vger.kernel.org>; Mon,  9 Feb 2026 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770672119; cv=none; b=F1xbm0T/JFZUAPJH1wa0IaHT+sJnCP0bfAijZJw7QPuxjtcJ8B9L21xXEMblrFmScuiNSq0KdqH3rQ35v2nHvkV0GmjHaN9smZkUlRxTIfTEyxq1ibQDd+kNrffk+1d0QlwD86VgWoIPSUZbz4M8yK0q23jzM8X50naiVivBiwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770672119; c=relaxed/simple;
	bh=TX9rHp/Pj8GgIw4dA5Yoqxlk0qyrxnklITQknLJzz4I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EJzyBaH2IhWzmVdbhpQ6skMsYMYzaiQ4rcKygThbNTSIrO2dKyFtYgo4QbKIXeCIBO4g5p0Ev7B9HtXyWZAISLjjruMuYplsQFxXa9Pi8V0NpbtxYUYeUudp3Qj6rYQQVBCu/A+bs1olFzr+/ZwSrrqZ99Ogi86s8qAq66qdhuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=dV61Z9B2; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-66e3100515dso111507eaf.2
        for <linux-integrity@vger.kernel.org>; Mon, 09 Feb 2026 13:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1770672115; x=1771276915; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=69ZWznBHU8ZtJ75qnJkt451Oe/QcmRriy+JTmMGalhA=;
        b=dV61Z9B2aBs/XfDX2AHJ//a6Opf4+0hpP6ahNipSd1YFUZSBPaQwhhVJqoouDyXaHK
         Q4J7xiAvd0IuajK+mFdQdoLvYWOxp1cYfPNJ4nROTyB0naSB9D8Zdcw1xSHYa/zgJtOi
         /Ib1cJ97VhLin3GDgPEwoM2R+K8MUqMJhQFVoMB/d3oEsa2NGDoUpAV7EGSLM90B7pBs
         WHeZLiWia60E/GbIE2tyK3u3LKLbi1eqyYOOs1OAJzXRUo+nXuBXSAgHmF9SIJx+zksg
         9YpWG+WcaOH3NOWEY0ZF0N+8hH6ahOb9jAoD6flr6Yx5TJCuQS2IULGbZrUbHmDEhYH5
         I+Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770672115; x=1771276915;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=69ZWznBHU8ZtJ75qnJkt451Oe/QcmRriy+JTmMGalhA=;
        b=bzPZDvuvNqQWTbZy/ggflBwdKulLA6rT4ndgKyCgLQsvxGxu5CFEnxM2uksEptlTkL
         ksWcWvZg1Bt77ewCf63MFY1U94z/4pyb8EGNrooANurbAXLwHrlj1AzSUtJ9Tbriwroo
         7VzqQMQ7h/5SG/o54pRkBMLWMJE+PXfkWxOtbJezivLDUOog9PJ5HTx56beaIvmaO4CI
         H6P0Rq7z0Ce40f08kuMY3DzEWLASBHb4qtepQRTBqi78oIwpWbHAP/j/MJMTBZ1WAPKx
         Sf4Wtiqt0SIirVXr9cdN1W+nfD97hNdIdV8DicRk+5p+N3oUE33AU7P74p4QxNI/fXKx
         Cfcw==
X-Forwarded-Encrypted: i=1; AJvYcCXDbVyE6Mhs1F10a8sd9Cs9Nap6Ck2lLKuCqo6UrM7JY9EGKJb7L74Fwzq1dFL0LjyLCVNfdVKgZTxxWe/W/Iw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTON1Z6oWwH9Yvd7qPRXAk9oEVRVmWXJ4Rf1YaHGAlqMzZwdQ5
	PCG7VrmQR87qSRH/qODsa4NmwTrW2hMmb0xvAyBlmiGzPQ/+tIL4b8s3MTHE8C7ZnY0=
X-Gm-Gg: AZuq6aIChPKU8H4BqUP0mIsx1kB1poueQbeGX+5IQ6l0ilhSZvbEAA17HWs9OOa/t0l
	9OMCiWwva3RIjtLtrxQvwEC+yDY5At9WnJViTH1xFu50RqmjTYBhDi4tSDWOF2hwMdLHzalDiSI
	JsJ3/4mZWrQcJvDourcS1qvXEOmacJsAvqD+aq0nIpdflpzH+xjbS5wskOG4lxE2PG9rstqKvnh
	3e6hqwx4cOcu8Q947DbW5o7zdhqvW8u8wmcU6fFUauG7CPofwEa+cTu1/Q29EAsJj+8kBboNkBU
	XkCfUdOJ0AKhzC9H4Yneo7XPoVJJf7jvI9o9f4LUBe0Ul4EP/BN3hgdZBAgroE1O0u/U3DhlZUf
	JEWTpUJDP1oh85CjA3PVaZQsIDUXrDhuMnFSYWrB0agX6sQoW8pnIq3EK14lbiSQvWZrmOOopJt
	eXsdBKikWe6A==
X-Received: by 2002:a05:6820:1624:b0:672:9d81:a77c with SMTP id 006d021491bc7-6729d81ab19mr486589eaf.30.1770672114905;
        Mon, 09 Feb 2026 13:21:54 -0800 (PST)
Received: from [127.0.1.1] ([2a09:bac5:947d:1b37::2b6:46])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66d390b935asm6591730eaf.5.2026.02.09.13.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 13:21:54 -0800 (PST)
From: Frederick Lawler <fred@cloudflare.com>
Date: Mon, 09 Feb 2026 15:21:49 -0600
Subject: [PATCH v6 2/3] ima: Make integrity_inode_attrs_changed() call into
 VFS
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-xfs-ima-fixup-v6-2-72f576f90e67@cloudflare.com>
References: <20260209-xfs-ima-fixup-v6-0-72f576f90e67@cloudflare.com>
In-Reply-To: <20260209-xfs-ima-fixup-v6-0-72f576f90e67@cloudflare.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3773; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=TX9rHp/Pj8GgIw4dA5Yoqxlk0qyrxnklITQknLJzz4I=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBpik/uM1stBZIG2q8wdWvlsbql8mRfZqvfFDcs7
 pnuT4IBbauJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCaYpP7gAKCRCrJbR2A5LT
 bdPQEACPwJwidmEj9QW5vUmcKoFdTF2JI7eZx+6C7f7Vak0WqfIbANRYG/Ste0Zbvod5g1DSO0q
 h2z1dTAY6+1FOKUpHk4bo5d5ZMbqUcfQgLlCkq825fhyn3kB+0jqEZFqSA7amw1gPcOo4O1KMiH
 BAqFQ8fQ86NlSg5HtnI+/5lTpXzIIejzZ2oxIRepOxoJkEpS55aAWWLd+GPlb2A4X1jzAZwaTS9
 KsvXXKvtI79obHeh2wzYSCt2e8qhEypuKE8My7+y20ACC6nqzSvGP91BD5hZTKOt6wq3Nhn57nb
 Xk8hWlbV43DRMH8hqvecOif2tlUtd2qNDjqojQJKgHkouxryge/GKmtpW+Y4rozT53rupvyu20g
 Ir0uQoPPA90+Y8z39DmzqRTeRzr7v1Jf2ihR7S5LX3Zxug/j1N/HDQHSWTg/uo39BXeI6o/zesF
 upFtkhNgjREJWY/JIueGbKtxHpY28KlIDfeIrzcM6mMeMmIRlShIc+OxP1AX6Bhe8WPYt7tDPXn
 PFma2bJ/L5iVbmY9EaL1my4hW7PK92/iwSQrP4mBVSJCTllpypR4sABtVF7CwfY0/EhHhpdx0pN
 OTSXkQ1CG2DVcNHkUL2uIfbmeWSDZ8O+DLRo/wdji171JpCh5DbxXz2YGVdkKvU5MhA46tgUWMT
 8kYpLKsZlwDGg0g==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8482-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,kernel.org,toxicpanda.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fred@cloudflare.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:mid,cloudflare.com:dkim,cloudflare.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2AB66114BE0
X-Rspamd-Action: no action

ima_check_last_writer() is already comparing kstat.change_cookie
against the cached attribute's version set by
ima_collect_masurement(). Make integrity_inode_attrs_changed()
call into the VFS as well. For file systems that do not set the
change cookie, IMA still treats the file as changed.

Fall back to current behavior if VFS cannot obtain it.

No logical change intended.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
 include/linux/integrity.h         | 28 ++++++++++++++++++++++++----
 security/integrity/evm/evm_main.c |  5 ++---
 security/integrity/ima/ima_main.c |  5 ++---
 3 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index beb9ab19fa6257e79266b58bcb5f55b0c5445828..382c783f0fa3ae4a938cdf9559291ba1903a378e 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -9,6 +9,7 @@
 
 #include <linux/fs.h>
 #include <linux/iversion.h>
+#include <linux/kernel.h>
 
 enum integrity_status {
 	INTEGRITY_PASS = 0,
@@ -62,14 +63,33 @@ integrity_inode_attrs_stat_changed
 
 /*
  * On stacked filesystems detect whether the inode or its content has changed.
+ *
+ * Must be called in process context.
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
+	might_sleep();
+
+	if (inode->i_sb->s_dev != attrs->dev || inode->i_ino != attrs->ino)
+		return true;
+
+	/*
+	 * EVM currently relies on backing inode i_version. While IS_I_VERSION
+	 * is not a good indicator of i_version support, this still retains
+	 * the logic such that a re-evaluation should still occur for EVM, and
+	 * only for IMA if vfs_getattr_nosec() fails.
+	 */
+	if (!file || vfs_getattr_nosec(&file->f_path, &stat,
+				       STATX_CHANGE_COOKIE,
+				       AT_STATX_SYNC_AS_STAT))
+		return !IS_I_VERSION(inode) ||
+		       !inode_eq_iversion(inode, attrs->version);
+
+	return integrity_inode_attrs_stat_changed(attrs, &stat);
 }
 
 
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 73d500a375cb37a54f295b0e1e93fd6e5d9ecddc..6a4e0e246005246d5700b1db590c1759242b9cb6 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -752,9 +752,8 @@ bool evm_metadata_changed(struct inode *inode, struct inode *metadata_inode)
 	bool ret = false;
 
 	if (iint) {
-		ret = (!IS_I_VERSION(metadata_inode) ||
-		       integrity_inode_attrs_changed(&iint->metadata_inode,
-						     metadata_inode));
+		ret = integrity_inode_attrs_changed(&iint->metadata_inode,
+						    NULL, metadata_inode);
 		if (ret)
 			iint->evm_status = INTEGRITY_UNKNOWN;
 	}
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 6570ad10887b9ea1172c78274cf62482350e87ff..8cb17c9d446caaa5a98f5ec8f027c17ba7babca8 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -328,9 +328,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	real_inode = d_real_inode(file_dentry(file));
 	if (real_inode != inode &&
 	    (action & IMA_DO_MASK) && (iint->flags & IMA_DONE_MASK)) {
-		if (!IS_I_VERSION(real_inode) ||
-		    integrity_inode_attrs_changed(&iint->real_inode,
-						  real_inode)) {
+		if (integrity_inode_attrs_changed(&iint->real_inode,
+						  file, real_inode)) {
 			iint->flags &= ~IMA_DONE_MASK;
 			iint->measured_pcrs = 0;
 		}

-- 
2.43.0


