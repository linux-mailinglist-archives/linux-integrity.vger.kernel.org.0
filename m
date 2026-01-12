Return-Path: <linux-integrity+bounces-8210-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD291D15953
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Jan 2026 23:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E2563029E84
	for <lists+linux-integrity@lfdr.de>; Mon, 12 Jan 2026 22:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CDC92853F7;
	Mon, 12 Jan 2026 22:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="evaT8ofy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C3C284B54
	for <linux-integrity@vger.kernel.org>; Mon, 12 Jan 2026 22:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768257152; cv=none; b=SYh4rd+fOmLLIh4CzM3n4PY7RZGz5J03n7o/1drpVjnjjdA3RMNW9GSl+KY8TMk03+cRKo+zyvp976TCfCQIsELnVdUQfIxezQP1ONfwxvuz3tjpPqGEdE84i+/JF2knhxeGH+7uVmuHeOvdtCMbtM7Be/v7Ftv/gvsLDLKzYII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768257152; c=relaxed/simple;
	bh=yOssaKkkw2iAx6491xbib5C1uy630m7uN2SB3Mu6dhQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=b3GTODCKCXz5FQlkr2lLZ8XflpkSD1RLBw6prviQX++ymiq9++mNbr+4+xrG3tDws4eh0hstLsD1QqlrhUffQIh67GYo7rPefp7hH9FZB0G8qMTodEXJQF3J+1l4AZgU5Lfeqnzp9oxHBnYwZN29VEQ6qo0Mnxce2MK/7VcroC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=evaT8ofy; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7ce229972d9so4279856a34.0
        for <linux-integrity@vger.kernel.org>; Mon, 12 Jan 2026 14:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1768257149; x=1768861949; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d/Pn36f4CVwcyKQEmMGgZAoi/SQb5tzc9kTCj15I8TY=;
        b=evaT8ofyYm9+sEl64EaFYytqRiL+u7ZCQ4I8a1SkvSjRH40UcMUdnc+LbymrKWW7hT
         jI0Yrloxle8SfHIA81VixN7eeTr3WyH3/HKVZK+i+Ow5N15mPxC8blfQfLpLReOt4ERh
         7yLmdt1Um41KUsE5DbzbR4QGxswH9lo8KO9WfU/Zh9aDdDw8loRrc/U5CaR7L2xwWhtE
         4Th7Cv3YVr1LJfjkDY+oydKHKbErSTfYxDCyx/0XjZknfwCKT7EEHhu21hHo5NkuMzTJ
         nX6wq1X/kvlndBm0dWZwa87mEfE+Hg0uQN3SwFZIYWrDEcSW7UQ3ls+lSgIocNvj+Brf
         PIhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768257149; x=1768861949;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d/Pn36f4CVwcyKQEmMGgZAoi/SQb5tzc9kTCj15I8TY=;
        b=H+uvqaSkb1Y33lDI0PA+peKjjZIDXcIt3ts9qw9xVPaQMd27XA+b2nv5irALof7jcV
         mCFKwR2Z4zHbDZxyYb5ChRfqIIhuqSeAtnthHQZlZiGrMJ9oxGUy7I5h4Pd7/EL10lQR
         7L+MEcBLPKLN50DAZCDq+9dD6jYFQp/91e3nm60eLx/Xa1N9mTLxvUgLQKBtS9pJiq5g
         aosRFtR3IynFNUTf02EoIrhhXq/AuGJNhDYFd1gExt8I5hJwHMEs/63F7jbNvTL8KxMH
         S7GP5lRChYnlbPcce2ADH6uPDVcvL0yu3pSe/K5XOAUpHovRiUyc0acSLF6kedLoIS/3
         kirQ==
X-Forwarded-Encrypted: i=1; AJvYcCXG25LaqngmgidqgnWIeXAqaqgAAoRmxb220ZpKfnT+Wksx6isswpKAPD/Acj2/WXmvQwUmYvePWt0GpKLP2uo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM36CSm+sjeQnoHjZMsRhxH87WVN/peLith1ynp9h4nAVD6BGS
	sNSRvqjrIYymq3k23CPQkeZ+2eGIsypZeN+o6W4wRyRriEH3Zmbg+i5KWEPI0+LGis4=
X-Gm-Gg: AY/fxX7jdJ0kNYTv+ZSIGT9lytq+hZtUeKcFucrq7SpTEFOMMiPdWfNiGclSPbwja7L
	zjf19W9XclUKbziDpky+J1Yn4NiesjT4cChgwz5T2/b+6tVY9CJmQ/ztyF5qMBTGTteT/qLRiZ5
	Dmb/Q8tHgzpg+q1xgmt+VBn/gKbOdw+V3OkCtgxKhQ4ApKsKH2t3RvnhrDI1zcNw7N0E/jWN6VN
	PjB7uALX4I6YUo+/iL7K166OxxraRW+PX/x1F9pCsrBNaWIa4q3KW7xftRD5ac3Ef5kvQPmk4bl
	7Uz5S328PCgr2pwr47Q5ejwiMbD711LTWhNEZ39rqhvl7XL6+H7MsKDrvI21ntkhg//2fo3+Um0
	m/skXI4B49dvkjn9+SR1cfRSUkM6uJLQvfpZvreEANnagZacs/26wfMH/pGX11pJQFDiM8dGM
X-Google-Smtp-Source: AGHT+IHTfYNDsvMCP+2C9EKp5Ze0XqFffPsnKdvc0RwzeTbz2V/JkiwnE668haqFlDsUiy6084llmQ==
X-Received: by 2002:a05:6830:2b28:b0:7c7:586c:846c with SMTP id 46e09a7af769-7ce50b8d34fmr11685071a34.19.1768257149105;
        Mon, 12 Jan 2026 14:32:29 -0800 (PST)
Received: from [127.0.1.1] ([2a09:bac5:947d:1b37::2b6:f])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ce4762eefbsm15594751a34.0.2026.01.12.14.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 14:32:28 -0800 (PST)
From: Frederick Lawler <fred@cloudflare.com>
Date: Mon, 12 Jan 2026 16:32:23 -0600
Subject: [PATCH] ima: Detect changes to files via kstat changes rather than
 i_version
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-xfs-ima-fixup-v1-1-8d13b6001312@cloudflare.com>
X-B4-Tracking: v=1; b=H4sIAHZ2ZWkC/12NsQ6CMBRFf4W82Wd4JVLrpHFxdHAzDE1p5SVAS
 SsEQ/h3G9wc7z255y4QbWAb4ZQtEOzEkX2fAu0yMI3uXxa5ThlELg4kSODsInKn0fE8DqgKksd
 cl8IIA2kzBJvA5nvC/fK43qBKdcPx7cNne5logz+hUH/CiZCw1JKkUYVy0pxN68fatTrYvfEdV
 Ou6fgEU343mtgAAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10538; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=yOssaKkkw2iAx6491xbib5C1uy630m7uN2SB3Mu6dhQ=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBpZXZ7JXcqxtI9CjvtzJkgScH6QG9UNGeb6xS18
 /vCZ68p9CWJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCaWV2ewAKCRCrJbR2A5LT
 bcxgD/0TyCnG6wEJGijFeCJigHDxJ3YQ2IDTY21q/plO5a98SofV4d84W5rWCtk5V6vSmbILVTK
 OnRIcr5i9q0KMSyJAN3OtixyPLG91gOdm+vRoiiC940LEONjQVR7STv2yPR0l9hrcODEGdKxORi
 aqzRNsBeezmC1r4KibH7NWxjbRyNBAFTLDpM/QU57TExbJyc1jw+zAIRLid4qOL+0P45nutfNyi
 ED1eZPyfcwMQylZVyN2xanW/9wcIgcj2Gs2lW2xjHip7YnWiIPhDe100n390fsQ3DiPRoflghcf
 LN97fa7RWhUOzPIMOHurPXlsHsA5BccTB1C2c5eL54SQ95UgGaYcHbwlyqVk8vt6pE4vFeVJhZh
 rTEWfOGnrv98MZrvXAvltMQZWWfiAVA/a+Z4KgvMWPUc5DGUIw0xlqdZ37+2tytpjAs6MJ1fvly
 peJ6AqOr7LaWi0IIPlZUJLK4ooEMNzr0UOWqtW521GBLGS5QsrH/m0rltFcNWTY6Y6ztY/klwYP
 HdwaDZdSnTAoLv65KF2tPP3RsNT5L+31f4lU7ZZd2ZmWL3iYYd6vkRjwVsolNfdKHV4NM5E8/gE
 PRu9OorNLlX5i5B74VtM+Xim7sRS2vue9wJEvU0rcyRjs5cO1V9KfeEyhA5kpXvlBwjo4rbuhHB
 8CCmQa3rl30EeBg==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D

Commit 1cf7e834a6fb ("xfs: switch to multigrain timestamps")
introduced a means to track change detection for an inode
via ctime updates, opposed to setting kstat.change_cookie when
calling into xfs_vn_getattr().

This introduced a regression because IMA caches kstat.change_cookie
to compare against an inode's i_version directly in
integrity_inode_attrs_changed(), and thus could be out of date
depending on how file systems increment i_version.

To address this, require integrity_inode_attrs_changed() to query
vfs_getattr_nosec() to compare the cached version against
kstat.change_cookie directly. This ensures that when updates occur,
we're accessing the same changed inode version on changes, and fallback
to compare against an artificial version generated from kstat.ctime
via integrity_ctime_guard() when there's no detected change
to the kstat.change_cookie.

This ensures that in the absence of i_version support for file systems,
and in the absence of a kstat.change_cookie update, we ultimately have a
unique-enough version to compare against.

The exact implementation for integrity_ctime_guard() is to ensure that
if tv_sec or tv_nsec are zero, there's some value to store back into
struct integrity_inode_attributes.version. This also avoids the need to
add additional storage and comparisons.

Lastly, because EVM still relies on querying and caching a backing inode's
i_version, the integrity_inode_attrs_changed() falls back to the
original inode.i_version != cached comparison. This maintains the
invariant that a re-evaluation in unknown change detection circumstances
is required.

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
 include/linux/integrity.h         | 42 +++++++++++++++++++++++++++++++++++----
 security/integrity/evm/evm_main.c |  5 ++---
 security/integrity/ima/ima_api.c  | 11 +++++++---
 security/integrity/ima/ima_main.c | 15 +++++---------
 4 files changed, 53 insertions(+), 20 deletions(-)

diff --git a/include/linux/integrity.h b/include/linux/integrity.h
index f5842372359be5341b6870a43b92e695e8fc78af..5eca8aa2769f9238c68bb40885ecc46910524f11 100644
--- a/include/linux/integrity.h
+++ b/include/linux/integrity.h
@@ -9,6 +9,7 @@
 
 #include <linux/fs.h>
 #include <linux/iversion.h>
+#include <linux/kernel.h>
 
 enum integrity_status {
 	INTEGRITY_PASS = 0,
@@ -36,6 +37,14 @@ struct integrity_inode_attributes {
 	dev_t dev;
 };
 
+/*
+ * Wrapper to generate an artificial version for a file.
+ */
+static inline u64 integrity_ctime_guard(struct kstat stat)
+{
+	return stat.ctime.tv_sec ^ stat.ctime.tv_nsec;
+}
+
 /*
  * On stacked filesystems the i_version alone is not enough to detect file data
  * or metadata change. Additional metadata is required.
@@ -51,14 +60,39 @@ integrity_inode_attrs_store(struct integrity_inode_attributes *attrs,
 
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
+		return integrity_ctime_guard(stat) != attrs->version;
+
+	return true;
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
diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
index c35ea613c9f8d404ba4886e3b736c3bab29d1668..8096986f3689781d3cdf6595f330033782f9cc45 100644
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
+			i_version = integrity_ctime_guard(stat);
+	}
 	hash.hdr.algo = algo;
 	hash.hdr.length = hash_digest_size[algo];
 
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 5770cf691912aa912fc65280c59f5baac35dd725..3a4c32e254f925bba85cb91b63744ac142b3b049 100644
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
@@ -191,18 +192,13 @@ static void ima_check_last_writer(struct ima_iint_cache *iint,
 
 	mutex_lock(&iint->mutex);
 	if (atomic_read(&inode->i_writecount) == 1) {
-		struct kstat stat;
-
 		clear_bit(IMA_EMITTED_OPENWRITERS, &iint->atomic_flags);
 
 		update = test_and_clear_bit(IMA_UPDATE_XATTR,
 					    &iint->atomic_flags);
 		if ((iint->flags & IMA_NEW_FILE) ||
-		    vfs_getattr_nosec(&file->f_path, &stat,
-				      STATX_CHANGE_COOKIE,
-				      AT_STATX_SYNC_AS_STAT) ||
-		    !(stat.result_mask & STATX_CHANGE_COOKIE) ||
-		    stat.change_cookie != iint->real_inode.version) {
+		    integrity_inode_attrs_changed(&iint->real_inode, file,
+						  inode)) {
 			iint->flags &= ~(IMA_DONE_MASK | IMA_NEW_FILE);
 			iint->measured_pcrs = 0;
 			if (update)
@@ -328,9 +324,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
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


