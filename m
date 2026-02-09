Return-Path: <linux-integrity+bounces-8483-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MDvIAz1QimmmJQAAu9opvQ
	(envelope-from <linux-integrity+bounces-8483-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 09 Feb 2026 22:23:09 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F16E114C3C
	for <lists+linux-integrity@lfdr.de>; Mon, 09 Feb 2026 22:23:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 314EC303A253
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Feb 2026 21:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5EF0311956;
	Mon,  9 Feb 2026 21:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AdkOuKxV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B19D2EA173
	for <linux-integrity@vger.kernel.org>; Mon,  9 Feb 2026 21:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770672120; cv=none; b=H2zAL9L9NtlHdhuvo3Iyp4H/JawUqHagbjZHA8Yqrx4m3/ZuesIxq0Dct02GvKyy/owKCwR7JIrEhM7RPymY3Xfi0N+BNd4Qe62GdjBFROO42mXii2yrPQnFj3L53KVFecdUoszSA38FtW3vfZ6XAWqufrkb3otO6Vy2+BHhwAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770672120; c=relaxed/simple;
	bh=ztNZlDveaPUFY/UJADcT7rgx3Ng5Aaxpnl+M/Z3Ef+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hxrrcKPclFIe7lVyvKr+CwzeNktZXEr+zXUc1SbvstWGpphB/zJPnaRgesN+Ux9ez3h27WfqTFvntvbMSf8oyaQ7FKk5+ckTt9CDpm4xASb9Ehld3dYEPGIRU2gLMu5BEzfpPWkJzZWeu2Z54akTkcahikl48MI21+izjqgMt5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AdkOuKxV; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-40a62601731so2895969fac.0
        for <linux-integrity@vger.kernel.org>; Mon, 09 Feb 2026 13:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1770672116; x=1771276916; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EEOdTViLab98einqbzjv+bLBxVlmu1ZicZOYO4doJ/M=;
        b=AdkOuKxV/l1Cmjz1/n3r/3oBXUiNUVTkh6X8ih1Pop6/Tsq/w+gl6jvZ3Kw/35S6Xg
         a2IcnySyTuFFoo5VIXn8W4umLNPePWhmpIlXD8SP5YnU+Y2L29nlWJuUg5VCPGHl8PhM
         kPuUJMCqmIXvz/BvDAtrk+smBfGNVuP4KnDgZB7Yuzx6aeVGzX8XHDGdM1uQrtweBhnA
         hXn1mqQIL0c0M81zb3WPzSknt+5GHJv1Bap65LiM/8UYL4ULmNqQy5NtgvHvmTkxfF5Y
         7gimRU7WepRoQxMRiU/cpuebB+P8xudaUetb3FDIVQZEEoKRJXk4scbprhv8E/vdtK6b
         2LuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770672116; x=1771276916;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EEOdTViLab98einqbzjv+bLBxVlmu1ZicZOYO4doJ/M=;
        b=KMbC0CVI8qwQNEKW/Ea43nDE2Ki2Nye8JXRDniWAO0GFcrQslO4DxSuQzWU9KZHjD1
         VYuBYTYIp8z1sBDWwB5m2tSgoU7RoTWpWtrTL1PyGr414K+eL72T5LkbeQn3K7sS4y4n
         LEeXaJmeDRlzlrzH6RswkOaOkq8Drm4QTWFVmT2hnIssttsiFZ+tVHL//QWPykZDH8By
         tGO3oIlW4rBreKuiHrmQM1aLt4p9ZDNHPpF16gTcUvfoJ1m0N1qGu2vOFSMEGnxmCHcy
         n+ILH5h9XqRfXieCGwU5y+H8YMA1jKWENd7bYWgY2a/rNQeilInUL5ye7MfntXvD0Zcp
         MFtQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZsdCPPbJLjY9NOsFxP3ye8IIZ4qsCL27y07l/0Y8hqRe7P682icPBOoQnp4NeOgMTy9pNFIiCeMCMLQPrmoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyb+ai5evEYtXsP4McB+S9vcnnkpkr1iWmpKcFibqgMLTaD7XoF
	TgYknSdLVapZeS5NnKmkSe7PZGz9y010qPaW5ETLvoBBj/qn0gviCHMGrvfiZX2tGt8=
X-Gm-Gg: AZuq6aIgSdGA13E9IDeI20hkGcz8rCA7fMzL8UFqsgCN24sZs9AtvafwmoIW0DsmzwD
	FeKNkfsSReFOybZ2IbSNVWt0uPdK+j7+Sn5oG2wNcX5kz9lVaKHytFiOHkFPF1b4+Y+4sYhyZmf
	KBKGTzYZRfpbAOEwfpQ+Atx/0x8pd4eFBCowocLYWmUO/IbFinRVTXe/qXHEJlZP2RPBqAfNIkm
	OeWtxQdduQC2xUcBdsIPsji6earN9M5IkOEox056kIhIeADpk7R4DzPmJVu6DbT7acZ7vZOVP2R
	M9JPfxOxsGorevvdflSOg8Y5x2yH/PUX4ma8jRqedUdiB60hvAPPVuF5npjEUrReFTePPuAoN5c
	HvjB2Gcy8o9fi0jCpMI+GPrUBhswHRkz8zhq3bbcGbg5Ou5A0yNesN92miVKNiHcBjmxTL6Ym2g
	==
X-Received: by 2002:a05:6820:1689:b0:66e:d9c5:ad53 with SMTP id 006d021491bc7-66ed9c5b0b7mr3532440eaf.34.1770672116144;
        Mon, 09 Feb 2026 13:21:56 -0800 (PST)
Received: from [127.0.1.1] ([2a09:bac5:947d:1b37::2b6:46])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66d390b935asm6591730eaf.5.2026.02.09.13.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 13:21:55 -0800 (PST)
From: Frederick Lawler <fred@cloudflare.com>
Date: Mon, 09 Feb 2026 15:21:50 -0600
Subject: [PATCH v6 3/3] ima: Use kstat.ctime as a fallback for change
 detection
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260209-xfs-ima-fixup-v6-3-72f576f90e67@cloudflare.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4301; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=ztNZlDveaPUFY/UJADcT7rgx3Ng5Aaxpnl+M/Z3Ef+Q=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBpik/uqKQQioRcbHzyxd0bXzo3VM3vGk+7dbzuj
 N2KQ20tVoiJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCaYpP7gAKCRCrJbR2A5LT
 bdGoEADcOZn+QasfYluvP2C6autDQWR7y9dc4cDhBWt32bXHpyJE+6zt7qEk1qi8wunHSwImqOp
 cPfEAfzrZPvnY/6+himefudeSXKSR71TzZn1MbxL1FLxbnpxlYQpTCvKbWHzjz8Mo72wsVVbCYW
 OxTA5yU2K3v3Op4z7hRDfH+w1dBYF9lAtPTxX/1nr14Uqt1s5/7narziUiJb4enRb+xF0yM5VFz
 TheiRBJAJkdf8F/5gNPkQHYNteAQSJitZ1KziY9hQ1zHskQLpb1b1RBkIgMWs1UA9cePCgDfiXV
 58g+Wv6aLuPkBQRARiWez5Rh7itkw1LSxW+8PAKVesMwWKMb6CQEYgDCjmI5dsUQ7BnTwWEpfUC
 wCa33F9VO4cFOn4dNS6Qtxc9/wpUCN3KYkId8XzXybAY3SYYj40By5w3noEPU+8rfHMvpMorApM
 RiDWXhQgTAbCpNrympaLOliuYUFrwwrgw1e5Uv3Dxn2ejjhgtILGrJKJ7wAsSUOKAsck2X1fYUD
 iyDG3gB3GpAXF4StVHmuA3rqeG4zaweq3Ir+al7LqzgLdicdK00NiQCALTHXYc+zJ7fqy/njV1b
 m2BWzyrqmNb83Bors9j0fl9KpcrECKm67FkcDfJnoObOYJ0tR2g++IkWwypLjAdYL9x+8fIaxT5
 PinBdX15AGcqMYQ==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8483-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,kernel.org,toxicpanda.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fred@cloudflare.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:mid,cloudflare.com:dkim,cloudflare.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9F16E114C3C
X-Rspamd-Action: no action

IMA performs unnecessary measurements on files in file systems
that do not set STATX_CHANGE_COOKIE in the vfs_getattr_nosec()'s
result mask.

Commit 1cf7e834a6fb ("xfs: switch to multigrain timestamps") introduced
multigrain timestamps to XFS, and this made XFS no longer report an
inode's i_version used by ima_collect_measurement() for change detection.

Additionally, ima_check_last_writer() & integrity_inode_attributes_change()
think there's a change for a file, when there may have not been.

Most file systems already use ctime for change detection, therefore, make
IMA fall back to compare against ctime when a file system does not report
an i_version to the kstat.change_cookie.

If neither fields are reported by vfs_getattr_nosec(), assume the file
changed.

timespec64_to_ns() is chosen to avoid adding extra storage to
integrity_inode_attributes by leveraging the existing version field.

XFS is just one example. There may be more file systems that adopt
multigrain timestamps in the future.

Link: https://lore.kernel.org/all/aTspr4_h9IU4EyrR@CMGLRV3
Fixes: 1cf7e834a6fb ("xfs: switch to multigrain timestamps")
Suggested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
 include/linux/integrity.h         |  6 +++++-
 security/integrity/ima/ima_api.c  | 11 ++++++++---
 security/integrity/ima/ima_main.c |  2 +-
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index 382c783f0fa3ae4a938cdf9559291ba1903a378e..ec2c94907f417c4a71ecce29ac79edac9bc2c6f8 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -10,6 +10,7 @@
 #include <linux/fs.h>
 #include <linux/iversion.h>
 #include <linux/kernel.h>
+#include <linux/time64.h>
 
 enum integrity_status {
 	INTEGRITY_PASS = 0,
@@ -58,6 +59,9 @@ integrity_inode_attrs_stat_changed
 	if (stat->result_mask & STATX_CHANGE_COOKIE)
 		return stat->change_cookie != attrs->version;
 
+	if (stat->result_mask & STATX_CTIME)
+		return timespec64_to_ns(&stat->ctime) != (s64)attrs->version;
+
 	return true;
 }
 
@@ -84,7 +88,7 @@ integrity_inode_attrs_changed(const struct integrity_inode_attributes *attrs,
 	 * only for IMA if vfs_getattr_nosec() fails.
 	 */
 	if (!file || vfs_getattr_nosec(&file->f_path, &stat,
-				       STATX_CHANGE_COOKIE,
+				       STATX_CHANGE_COOKIE | STATX_CTIME,
 				       AT_STATX_SYNC_AS_STAT))
 		return !IS_I_VERSION(inode) ||
 		       !inode_eq_iversion(inode, attrs->version);
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index c35ea613c9f8d404ba4886e3b736c3bab29d1668..e47d6281febc15a0ac1bd2ea1d28fea4d0cd5c58 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -272,10 +272,15 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
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
+		else if (stat.result_mask & STATX_CTIME)
+			i_version = timespec64_to_ns(&stat.ctime);
+	}
 	hash.hdr.algo = algo;
 	hash.hdr.length = hash_digest_size[algo];
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 8cb17c9d446caaa5a98f5ec8f027c17ba7babca8..776db158b0bd8a0d053729ac0cc15af8b6020a98 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -199,7 +199,7 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
 					    &iint->atomic_flags);
 		if ((iint->flags & IMA_NEW_FILE) ||
 		    vfs_getattr_nosec(&file->f_path, &stat,
-				      STATX_CHANGE_COOKIE,
+				      STATX_CHANGE_COOKIE | STATX_CTIME,
 				      AT_STATX_SYNC_AS_STAT) ||
 		    integrity_inode_attrs_stat_changed(&iint->real_inode,
 						       &stat)) {

-- 
2.43.0


