Return-Path: <linux-integrity+bounces-8282-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gBhqIDn4b2mLUgAAu9opvQ
	(envelope-from <linux-integrity+bounces-8282-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jan 2026 22:48:41 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 571D54C854
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jan 2026 22:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4EA6D9001E0
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Jan 2026 20:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C083A63F2;
	Tue, 20 Jan 2026 20:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="W9W83T75"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEAA738FF18
	for <linux-integrity@vger.kernel.org>; Tue, 20 Jan 2026 20:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768940443; cv=none; b=Im423r6CQ8c68tz6o3PN9vkOvl7mQLfJp73xbPyryqcPQpQ7feoMVv6pBzOxS+rhnZtP60Z0x5Tnutj6upiZJQ2QmZzY07JJfxvCY3YPdCrviFniAyaVIo11l5zrAoy/H22FS4R+z4Xz+WxogKYTFLfJToRStH5RABGDwhxgU0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768940443; c=relaxed/simple;
	bh=dBOX75E+YxrCrvlhmS+Eqpje6dDJi3XQRiMO7ht8Fa8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YAi4TW/2hcVkVXL5Mmq9zW5TWmlTTqikKpqZRCIs564+/RtPTzI5LuEuxPWwQ79nl10dIHmw711ypRpYpqFtxp7NvcG6zZ7M1C/OoUuqhBwrhHzGZ97a4r0UMV4zHfBs0Hj+l3LJyJS1+svQTq072WlDWwJxf4QbZqwOuKq4DoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=W9W83T75; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7cfd5d34817so3818952a34.1
        for <linux-integrity@vger.kernel.org>; Tue, 20 Jan 2026 12:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768940440; x=1769545240; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pRgHEalZu663fb7KQKXFPsy1uxjqlpRaZezxtg+ZFAo=;
        b=W9W83T75kZ+89HOWm46Xqll7P64OZ/thMs8OgBA+ERVKZtPoP0juQl1jrCW5DaafrS
         itdeOHFVmENttkAPDymUnFzP88V2GY4JpwFl3dSmziBVd9a/0d5be36OHbetX9vyVSL7
         m8vVX0h/0vuuPHr+ZB0QUbhELLu8Ey6P/117xDL8MWIPvom36twSVClRFwujMNshLYgw
         yyeGyouV7/cOWfUxEH0vVO/u+xVhoqh6dRtnF8qYttM6lH3XF0vv0fyeEBGZtaLzqa4m
         y1IIFvwVnFmGiH4eUK3P04L1HSJXjhmvs2GWFsEGkkAHYbwtSbWSKhNlNoZbP5up0G5d
         BFzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768940440; x=1769545240;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pRgHEalZu663fb7KQKXFPsy1uxjqlpRaZezxtg+ZFAo=;
        b=fnNUiND4bxcAQCI3TTedZdtFFPsAGBNOXpc4yArfxsjBbgWrVUV1PC7N85suKNDUgg
         Xlp5TV4v2lwuKH0BOYaVjo2NDliqLr/AGkRyWI6omizOMGeIsOEfVmSZuTv4pM0Pum1d
         Mt07zY4r0B8QH//PBhQMPGxZHqUpf4/b0R93E1canRyE892IdIjp77fuWuaghpzePWiH
         HK+vfkNbGxSWZ/xTcM8/udhkV9PY9Rpu6RrwEkfvTCu3dBj93GYWmk9aCGcfyA5sV0cO
         I99286Mya8Yu+XCl0dZYF8eIDXKnG6sTjy5//RjGYTbmIkgBrXf8t57rjsqDItgvWinj
         KQiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXFSzq16XcZBtrWC4b4zXWev0yF+u211gCDuV+rsA0IRyfPd1UdlE+20YwJMI+Z1F6YDxypSuw5W/qHp31DCBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6UxHkR2MME+dnrqS2srZpLpFwBHC9iiK74Na5hiINZiPBP6CV
	wUUMr0LJocFQhXWhdKlZwSeqZkmfXInnPoeMcTnFDsMLhwDhaaLpHLkgHaocpnMucdY=
X-Gm-Gg: AY/fxX4nttB0Bp+dkJKoCLEluuCdtwxK0PMKHTb3H55LysasolNk/ilu2WtfXcK651P
	ztGgRUXTQw0JaOnGJdfY47Uj4RTN45TVM9Wmj89SvMiidCOZQlFAn6Km4MVvLiNT1vNZzbbyaUA
	kBFOcPKRk6AURJTwnYn0Hg2cBCSvBRTJLyYAs877YnSqOw1eM+cKDPTsyHD86iaFOyTukF20K/a
	hHH9vcVj9ggteEg/idpUzoB6d5DIKpwE/U65WURc9hpjd/QbkNPkZUJPhj750WIRFg1vDXhmOUg
	2oXuc8oDvmvdEngSYAOWycCuQek0Q6y86QdGZcWXwqoLw9jcVFcJX1zFs7ozm3ZqGSGPkcAjZGV
	9aS/I0pcjG9c4+Rc0HMJn2P0K9gnKmglf9ue6VQR7GPrh6sUd8fgv4ZWigHl/S8O2Vqmy4u8=
X-Received: by 2002:a05:6830:1bec:b0:7cf:e57f:def6 with SMTP id 46e09a7af769-7cfe57fe038mr5143004a34.6.1768940439572;
        Tue, 20 Jan 2026 12:20:39 -0800 (PST)
Received: from [127.0.1.1] ([2a09:bac5:947d:4e6::7d:47])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7cfdf0d915dsm9011188a34.4.2026.01.20.12.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jan 2026 12:20:39 -0800 (PST)
From: Frederick Lawler <fred@cloudflare.com>
Date: Tue, 20 Jan 2026 14:20:31 -0600
Subject: [PATCH v2] ima: Fallback to ctime check for FS without
 kstat.change_cookie
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260120-xfs-ima-fixup-v2-1-f332ead8b043@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIAI7jb2kC/2WOPQ+CMBRF/4p5szV9jwjUSePi6OBmGGpppQlfa
 YVgCP/dWjcc77s5574ZvHZWezhsZnB6tN52bQi03YCqZPvUzJYhA3HaIyGxyXhmG8mMnYaeiQS
 znMuUFCkITO90KKLvDtfT7XyBIpwr61+de8eVEWP5E5JYCUdkyFKZYaZEIkymjqruhtLU0umd6
 prvSEBTjn+/RDQvMXmknGOCtEaLZVk+vC5CUvEAAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=12825; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=dBOX75E+YxrCrvlhmS+Eqpje6dDJi3XQRiMO7ht8Fa8=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBpb+OVOo0nTTbbQfKX6PmaolHUtiujW+2dnH0gr
 krS+NT/lzmJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCaW/jlQAKCRCrJbR2A5LT
 bbWxD/9DAS7fM2CN2ECRONCrbUZWy3eAfmoQ0WqqSbiCurHi64muLs4ds6zd+oJOnfga8DycJO8
 LIprntKa0IA2dyDkWJ4NhzivzcZ/9FBlZUtWexqQnugepFrYk1uItDmvQtiJRgG7zX0TpLdN3hy
 G+JDZOOl12CRI2DMMQClxAi6MHOhKf4ramk9ZtakUKVJC2GuYoLjiNxXWdxGtehD794S9QdmLaw
 bw9wC3BzoKLUOtgclR4SoQAqfVQv0uRwAaIMwdGR3wHCKz6UZE/khDWSlF/XVGMsEpzCp06mi4f
 yZqe96nmieslmMxZZFieXUSwMH8E404GtwkK/vjrb9iBWKEB+v78q77s8GOIUou0QI+Z51n6uWY
 fW9g95btDaAicSwucpjvDbauJrXNa3zpWSnHBpfNPpVzTB5vz9DXCSDS6OkE7XgzuIPIyfQ+hHW
 w7anGCw5w8yw+ko9oWo3y24+pkMI4GUMbjDdZfbBF5P9WPDlYoeSOsE8rkq1frEhMym7NwwNMKT
 mWbJyfEpy2KqUuUJoRki0Q8PnHMJC5qtZ9Seh5zUvJ9BKsP+JX4vmfOtsnoam7nrSkYvB4FvyHL
 AxfxdXezVqta/mYW+Uz/6dCX/rMS9OPbrwiROaIiuKaBvw93fDgpgoOgyxZlULD4NlZmGXD5AMH
 5EHly4O7pN4BiXg==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D
X-Spamd-Result: default: False [-7.46 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8282-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,kernel.org,toxicpanda.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DMARC_POLICY_ALLOW(0.00)[cloudflare.com,reject];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fred@cloudflare.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,cloudflare.com:email,cloudflare.com:dkim,cloudflare.com:mid]
X-Rspamd-Queue-Id: 571D54C854
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Commit 1cf7e834a6fb ("xfs: switch to multigrain timestamps")
introduced a means to track change detection for an inode
via ctime updates, opposed to setting kstat.change_cookie to
an i_version when calling into xfs_vn_getattr().

This introduced a regression for IMA such that an action
performed on a LOWER inode on a stacked file systems always
requires a re-evaluation if the LOWER file system does not
leverage kstat.change_cookie to track inode i_version or lacks
i_version support all together.

In the case of stacking XFS on XFS, an action on either the LOWER or UPPER
will require re-evaluation. Stacking TPMFS on XFS for instance, once the
inode is UPPER is mutated, IMA resumes normal behavior because TMPFS
leverages generic_fillattr() to update the change cookie.

This is because IMA caches kstat.change_cookie to compare against an
inode's i_version directly in integrity_inode_attrs_changed(), and thus
could be out of date depending on how file systems set
kstat.change_cookie.

To address this, require integrity_inode_attrs_changed() to query
vfs_getattr_nosec() to compare the cached version against
kstat.change_cookie directly. This ensures that when updates occur,
we're accessing the same changed inode version on changes, and fallback
to compare against kstat.ctime when STATX_CHANGE_COOKIE is missing from
result mask.

Lastly, because EVM still relies on querying and caching a inode's
i_version directly, the integrity_inode_attrs_changed() falls back to the
original inode.i_version != cached comparison.

Link: https://lore.kernel.org/all/aTspr4_h9IU4EyrR@CMGLRV3
Suggested-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
We uncovered a case in kernels >= 6.13 where XFS is no longer updating
struct kstat.change_cookie on i_op getattr() access calls. Instead, XFS is
using multigrain ctime (as well as other file systems) for
change detection in commit 1cf7e834a6fb ("xfs: switch to
multigrain timestamps").

Because file systems may implement i_version as they see fit, IMA
caching may be behind as well as file systems that don't support/export
i_version. Thus we're proposing to compare against the kstat.change_cookie
directly to the cached version, and fall back to a ctime guard when
that's not updated.

EVM is largely left alone since there's no trivial way to query a file
directly in the LSM call paths to obtain kstat.change_cookie &
kstat.ctime to cache. Thus retains accessing i_version directly.

Regression tests will be added to the Linux Test Project instead of
selftest to help catch future file system changes that may impact
future evaluation of IMA.

I'd like this to be backported to at least 6.18 if possible.

Below is a simplified test that demonstrates the issue:

_fragment.config_
CONFIG_XFS_FS=y
CONFIG_OVERLAY_FS=y
CONFIG_IMA=y
CONFIG_IMA_WRITE_POLICY=y
CONFIG_IMA_READ_POLICY=y

_./test.sh_

IMA_POLICY="/sys/kernel/security/ima/policy"
TEST_BIN="/bin/date"
MNT_BASE="/tmp/ima_test_root"

mkdir -p "$MNT_BASE"
mount -t tmpfs tmpfs "$MNT_BASE"
mkdir -p "$MNT_BASE"/{xfs_disk,upper,work,ovl}

dd if=/dev/zero of="$MNT_BASE/xfs.img" bs=1M count=300
mkfs.xfs -q "$MNT_BASE/xfs.img"
mount "$MNT_BASE/xfs.img" "$MNT_BASE/xfs_disk"
cp "$TEST_BIN" "$MNT_BASE/xfs_disk/test_prog"

mount -t overlay overlay -o \
"lowerdir=$MNT_BASE/xfs_disk,upperdir=$MNT_BASE/upper,workdir=$MNT_BASE/work" \
"$MNT_BASE/ovl"

echo "audit func=BPRM_CHECK uid=$(id -u nobody)" > "$IMA_POLICY"

target_prog="$MNT_BASE/ovl/test_prog"
setpriv --reuid nobody "$target_prog"
setpriv --reuid nobody "$target_prog"
setpriv --reuid nobody "$target_prog"

audit_count=$(dmesg | grep -c "file=\"$target_prog\"")

if [[ "$audit_count" -eq 1 ]]; then
        echo "PASS: Found exactly 1 audit event."
else
        echo "FAIL: Expected 1 audit event, but found $audit_count."
        exit 1
fi
---
Changes since RFC:
- Remove calls to I_IS_VERSION()
- Function documentation/comments
- Abide IMA/EVM change detection fallback invariants
- Combined ctime guard into version for attributes struct
- Link to RFC: https://lore.kernel.org/r/20251229-xfs-ima-fixup-v1-1-6a717c939f7c@cloudflare.com
---
Changes in v2:
- Updated commit description + message to clarify the problem.
- compare struct timespec64 to avoid collision possibility [Roberto].
- Don't check inode_attr_changed() in ima_check_last_writer()
- Link to v1: https://lore.kernel.org/r/20260112-xfs-ima-fixup-v1-1-8d13b6001312@cloudflare.com
---
 include/linux/integrity.h           | 40 ++++++++++++++++++++++++++++++++-----
 security/integrity/evm/evm_crypto.c |  4 +++-
 security/integrity/evm/evm_main.c   |  5 ++---
 security/integrity/ima/ima_api.c    | 20 +++++++++++++------
 security/integrity/ima/ima_main.c   | 18 ++++++++++-------
 5 files changed, 65 insertions(+), 22 deletions(-)

diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index f5842372359be5341b6870a43b92e695e8fc78af..46f57402b790c9c275b85f0b30819fa196fc20c7 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -9,6 +9,8 @@
 
 #include <linux/fs.h>
 #include <linux/iversion.h>
+#include <linux/kernel.h>
+#include <linux/time64.h>
 
 enum integrity_status {
 	INTEGRITY_PASS = 0,
@@ -31,6 +33,7 @@ static inline void integrity_load_keys(void)
 
 /* An inode's attributes for detection of changes */
 struct integrity_inode_attributes {
+	struct timespec64 ctime;
 	u64 version;		/* track inode changes */
 	unsigned long ino;
 	dev_t dev;
@@ -42,8 +45,10 @@ struct integrity_inode_attributes {
  */
 static inline void
 integrity_inode_attrs_store(struct integrity_inode_attributes *attrs,
-			    u64 i_version, const struct inode *inode)
+			    u64 i_version, struct timespec64 ctime,
+			    const struct inode *inode)
 {
+	attrs->ctime = ctime;
 	attrs->version = i_version;
 	attrs->dev = inode->i_sb->s_dev;
 	attrs->ino = inode->i_ino;
@@ -51,14 +56,39 @@ integrity_inode_attrs_store(struct integrity_inode_attributes *attrs,
 
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
+				       STATX_CHANGE_COOKIE | STATX_CTIME,
+				       AT_STATX_SYNC_AS_STAT))
+		return !IS_I_VERSION(inode) ||
+			!inode_eq_iversion(inode, attrs->version);
+
+	if (stat.result_mask & STATX_CHANGE_COOKIE)
+		return stat.change_cookie != attrs->version;
+
+	if (stat.result_mask & STATX_CTIME)
+		return !timespec64_equal(&stat.ctime, &attrs->ctime);
+
+	return true;
 }
 
 
diff --git a/security/integrity/evm/evm_crypto.c b/security/integrity/evm/evm_crypto.c
index a5e730ffda57fbc0a91124adaa77b946a12d08b4..361ee7b216247a0d6d2f518e82fb6e92dc355afe 100644
--- a/security/integrity/evm/evm_crypto.c
+++ b/security/integrity/evm/evm_crypto.c
@@ -297,10 +297,12 @@ static int evm_calc_hmac_or_hash(struct dentry *dentry,
 	hmac_add_misc(desc, inode, type, data->digest);
 
 	if (inode != d_backing_inode(dentry) && iint) {
+		struct timespec64 ctime = {0};
+
 		if (IS_I_VERSION(inode))
 			i_version = inode_query_iversion(inode);
 		integrity_inode_attrs_store(&iint->metadata_inode, i_version,
-					    inode);
+					    ctime, inode);
 	}
 
 	/* Portable EVM signatures must include an IMA hash */
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
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index c35ea613c9f8d404ba4886e3b736c3bab29d1668..0d8e0a3ebd34b70bb1b4cc995aae5d4adc90a585 100644
--- a/security/integrity/ima/ima_api.c
+++ b/security/integrity/ima/ima_api.c
@@ -254,6 +254,7 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 	int length;
 	void *tmpbuf;
 	u64 i_version = 0;
+	struct timespec64 ctime = {0};
 
 	/*
 	 * Always collect the modsig, because IMA might have already collected
@@ -272,10 +273,15 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
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
+		if (stat.result_mask & STATX_CTIME)
+			ctime = stat.ctime;
+	}
 	hash.hdr.algo = algo;
 	hash.hdr.length = hash_digest_size[algo];
 
@@ -305,11 +311,13 @@ int ima_collect_measurement(struct ima_iint_cache *iint, struct file *file,
 
 	iint->ima_hash = tmpbuf;
 	memcpy(iint->ima_hash, &hash, length);
-	if (real_inode == inode)
+	if (real_inode == inode) {
 		iint->real_inode.version = i_version;
-	else
+		iint->real_inode.ctime = ctime;
+	} else {
 		integrity_inode_attrs_store(&iint->real_inode, i_version,
-					    real_inode);
+					    ctime, real_inode);
+	}
 
 	/* Possibly temporary failure due to type of read (eg. O_DIRECT) */
 	if (!result)
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 5770cf691912aa912fc65280c59f5baac35dd725..54b638663c9743d39e5fb65711dbd9698b38e39b 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -22,12 +22,14 @@
 #include <linux/mount.h>
 #include <linux/mman.h>
 #include <linux/slab.h>
+#include <linux/stat.h>
 #include <linux/xattr.h>
 #include <linux/ima.h>
 #include <linux/fs.h>
 #include <linux/iversion.h>
 #include <linux/evm.h>
 #include <linux/crash_dump.h>
+#include <linux/time64.h>
 
 #include "ima.h"
 
@@ -199,10 +201,13 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
 					    &iint->atomic_flags);
 		if ((iint->flags & IMA_NEW_FILE) ||
 		    vfs_getattr_nosec(&file->f_path, &stat,
-				      STATX_CHANGE_COOKIE,
-				      AT_STATX_SYNC_AS_STAT) ||
-		    !(stat.result_mask & STATX_CHANGE_COOKIE) ||
-		    stat.change_cookie != iint->real_inode.version) {
+			    STATX_CHANGE_COOKIE | STATX_CTIME,
+			    AT_STATX_SYNC_AS_STAT) ||
+		    ((stat.result_mask & STATX_CHANGE_COOKIE) ?
+		      stat.change_cookie != iint->real_inode.version :
+		      (!(stat.result_mask & STATX_CTIME) ||
+			!timespec64_equal(&stat.ctime,
+					  &iint->real_inode.ctime)))) {
 			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
 			iint->measured_pcrs = 0;
 			if (update)
@@ -328,9 +333,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
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

---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251212-xfs-ima-fixup-931780a62c2c

Best regards,
-- 
Frederick Lawler <fred@cloudflare.com>


