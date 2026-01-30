Return-Path: <linux-integrity+bounces-8378-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEGGItgzfWntQgIAu9opvQ
	(envelope-from <linux-integrity+bounces-8378-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 23:42:32 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC972BF318
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 23:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B14EC302AE25
	for <lists+linux-integrity@lfdr.de>; Fri, 30 Jan 2026 22:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5D138A9B2;
	Fri, 30 Jan 2026 22:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Jq9a381o"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271DF38A9A2
	for <linux-integrity@vger.kernel.org>; Fri, 30 Jan 2026 22:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769812801; cv=none; b=KPc54tMdOmUC8VVN8bOvn+AMOVn37BFFmEYedqZTD5Az4oguZO5H653JtqbQTpXJiRXDekN/Ir2hYUk7TkKCHTp2q4mpfmXcMXwPjMIrzCKBrBlN7WAeCkOuhNIXMil6pn/K1ktDM6PMHViY95mIpLUXf2H1+A+j7FnYWZoyH3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769812801; c=relaxed/simple;
	bh=aLz0imPCdZ5/xhHXVEXnm6aMGct2xh+/QvnHHIV6ZGM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=abEgVLe8cFjLJL6aX9KoZQRL2lQf9ZL3q405BmPRJPGF9CHQ3FLEYaqJmN8WHjOFEf5q5+WYvWcV4zFDKPhJIwduvEVleZO17fywozO+yH/FXAiBZQoDLA5GHLM4TwwMFBSMaHF97irEJvgv1n4HtR1zUOhvCEwpnRztUD7Y+yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Jq9a381o; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-45c8b850f96so1718508b6e.0
        for <linux-integrity@vger.kernel.org>; Fri, 30 Jan 2026 14:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1769812799; x=1770417599; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5JXQIpD9vtshlTXqhw48iqAmLq3K2vm+ya6rB2Yrxp4=;
        b=Jq9a381ojltn9KLup+HmGYB0xBdCM+WYTSqlOG3KAvfRJayGcg0+SN/WmQcbdhrB2G
         3kAUVl/0j8DxU1O5HCFgU9YYwFWi8NHPc+0SzBfQ/ihLGpohEQNzH5CeL1DVXFzsMXYZ
         FSYVLxCR9iA9sTioQa+xOOIVAl1f68vrgN6fNzZP6ZYHH2hw9FeAckCjn51On7S0ZXXD
         B1BP2VFFG4sspoc641YRxiQvwWTae9tHSGpommqLQNVRXJa3x6LGKS4XiTi0+HZ+VZrd
         zMh1t6gfDK9KCot4xhRdGdJY4Ddun20hsyvH3TOID9c7YwI9Gy5+UxYqXV0ldotcaz4+
         neoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769812799; x=1770417599;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5JXQIpD9vtshlTXqhw48iqAmLq3K2vm+ya6rB2Yrxp4=;
        b=KgPxrkcdih8vmL66/S3ZDLDqks1E5cqdBi9uXc8hUGIuwfdvvi7hux5ejhxtpmIPl/
         S2ycif2GPN4lvSh9x0OONp6YL0j0GLsUbM6VRA4W7wrRDYCfJtUBbSKWwQCiHgEAUodN
         HFWapkl+/ixw1hKaYU55F2GZkR1oS5s7YUPZzzYvVMOHJeucukzUBhWmKh7FXpP1ge9+
         H5VB35wnWKuSuTNk891CBBvjPx3X8qdvDyKyQxU4nDZL80tW+zY4Xse5TBiJj41/pNM7
         h2RT3ioXL/CEjEMPPHatIvG5TSfNfjGqBBbr9xXv3DpmDWbuJlEKVTZoYxQvXh0ADtdH
         ucag==
X-Forwarded-Encrypted: i=1; AJvYcCX/jqQ59AJubDjk2t8oxowz1X9gYJDzooebekdrdvv90j9DA1ZPcYTcOiPuz8+UTL6Y8G5iBf9IF1vG4whLB7o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBkmZRtQiskTM0+r5vObI4B7FTz8holO3gzYcdphAaehdq1RJt
	8+R1mepDSAcqLFXI9/FO7v9eQ+W0KRh3kQgUuqiCFB+t1uRxuiumcqjh+ADipo7uj4Y=
X-Gm-Gg: AZuq6aKyvi1tsC3RZVyhRJ7Zjf/koCsy+pCGL6l6N30L8qfMYR/8tr6kBDk5+OG61bF
	BJUR093JFE7ql8b+I7rjMKA298WRDodY9DJ64rWIURyJBfmHgOBTOd9uGKOOSdQCb90WAQDqwe9
	Oych2UXf2a7Fz0rIzulfBFRDgVinSVQcW1eKS+uYRDR4+JjLY45LU4+8W1O27+Ptm7D+74YFsDe
	DBvEJyjMaSsw64FdEkI0Tc2KmiaAsCRk9oXucZr2nYuoBghZD1zCMrTaIOKmdTLXyOqmd/7y7Qj
	mjSYcYuvbY36hwOSeMFrzj0H3fk8hRpB7+bTyzAbzu/ithliKBPTGkkEM4I90ObFO7ibrkIkjfM
	ys8H7CKbs9zMUmPeXe4D0m+N8aUSguuArOU2U7UNkUI7f4TTT0h+7EEX9btY++5yu7ozGuyw=
X-Received: by 2002:a05:6808:4702:b0:459:9961:5114 with SMTP id 5614622812f47-45f34bcc989mr2086789b6e.16.1769812798959;
        Fri, 30 Jan 2026 14:39:58 -0800 (PST)
Received: from [127.0.1.1] ([2a09:bac5:947d:4e6::7d:80])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45f08f20e38sm5400250b6e.10.2026.01.30.14.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:39:58 -0800 (PST)
From: Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH v5 0/3] ima: Detect changes to files via kstat changes
 rather than i_version
Date: Fri, 30 Jan 2026 16:39:53 -0600
Message-Id: <20260130-xfs-ima-fixup-v5-0-57e84ea91712@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADkzfWkC/23QPU/DMBAG4L9SecbId5fYTicQCyMDG2LwJ7XUN
 pVNo6Iq/x0nCKlKOp6t97lXd2Ul5BQK226uLIchldQf69A+bJjbmeNX4MnXmaHAFhCQX2Lh6WB
 4TJfziXcESgsj0aFjNXPKoX7M3gd7e35/eWWf9XmXyneff+YtA8yffyB2C3AADlwaBcp11EXln
 ty+P/u4Nzk8uv4wLalRKWDVZY5qD2SlEECAy+jUZMD/7ZVAsSSwEpEIg/HaiobuEnRLrFpQJVA
 QtUYbo0neJZpbYnWDZrqBtbrzUVlp1i3GcfwFtu64oLoBAAA=
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4621; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=aLz0imPCdZ5/xhHXVEXnm6aMGct2xh+/QvnHHIV6ZGM=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBpfTM8Kp4GDHqdBKyd7DxYvWKvsa/OMUR83SHtV
 RIkXtQQ+MmJAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCaX0zPAAKCRCrJbR2A5LT
 bXAVD/0TfJPV/Cj/+SY8aAa2AjzMlTk8gHHJRaQtHZJLln+be1Lm4p7q7l46X5AEWx5zIgfTTxY
 Jr6fger804BwHhlTHD4ukoZCly0zb3FP2j/KOydPfgdBj5ckSHY3e39RKD0hJoiHcRqaKiX4USm
 st3wMhCAINOneC+3JaUzo+8kh8HKB3C6jaeZ9UZ9loUIy+zX0hzWoyU9gX+3olIl1sOMg/cc3Zb
 +BH01Cx4hbNFiNBup1l54n0aF9dg3fGhsohISS++YPSjQ4GoYvrR9xsnXDb+gFxz92BpyJtQv6U
 7bFuDH6fH+WF6VDBv/aTl9TkTJom5RvYYxsslq6NHvnktBbn3xg2jD06LPp1LIr02voTgdBJkin
 V6TjRmb7xGTbtD+uQTqGazusvCoeDWel4o5tOKnpumQivatbltmhZV+x/ypNvpRyuwhoU44xNf7
 V23ICL+ItKo/Fy9p6yRlknJIGDdAuLlX8LkoHBhaa361OwLSnS976yusHGCDoMx7dk77l/1MXK4
 Gfnq/NPFgsqYEgjpw4vmGBhS+yhB268YrwPjKAqw25fjk4FUiTxeItujZUXrn0Mx0RX2uIJDwwG
 u8bYyTCZDAhEzv8WTMbQ4vdbofJmPr3W5jF6JWA7SOZCt8E3Ccre8DYU8s+1MnqK1nHbNr2fJU/
 f+m+LFc6dhJlj1Q==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8378-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,kernel.org,toxicpanda.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fred@cloudflare.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cloudflare.com:email,cloudflare.com:dkim,cloudflare.com:mid]
X-Rspamd-Queue-Id: EC972BF318
X-Rspamd-Action: no action

We uncovered a case in kernels >= 6.13 where XFS is no longer updating
struct kstat.change_cookie on i_op getattr() access calls. Instead, XFS is
using multigrain ctime (as well as other file systems) for
change detection in commit 1cf7e834a6fb ("xfs: switch to
multigrain timestamps").

Because file systems may implement i_version as they see fit, IMA
unnecessarily measures files in stacked file systems. This is due
to the LOWER or UPPER FS not updating kstat.change_cookie to the
recent i_version on request. Thus, for XFS, zero is being compared
against the inode's i_version directly, and is always behind.

We're proposing to compare against the kstat.change_cookie
directly to the cached version, and fall back to a ctime comparison,
if STATX_CHANGE_COOKIE is not supplied in the result mask.

EVM is largely left alone since there's no trivial way to query a file
directly in the LSM call paths to obtain kstat.change_cookie &
kstat.ctime to cache. Thus retains accessing i_version directly.

Regression tests will be added to the Linux Test Project instead of
selftest to help catch future file system changes that may impact
future evaluation of IMA.

I'd like this to be backported to at least 6.18 if possible.

Patches 1 & 2 are preparation patches. Ideally patch 2 is squashed into
3, though not strictly necessary.

Below is a simplified test that demonstrates the issue such that
there are multiple unnecessary measurements occurring for actions on
a file in a stacked TMPFS on XFS, prior to the file moved over to TMPFS:

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

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
Changes in v5:
- Split into patch series. [Mimi]
- Link to v4: https://lore.kernel.org/r/20260129-xfs-ima-fixup-v4-1-6bb89df7b6a3@cloudflare.com

Changes in v4:
- No functional changes.
- Add Reviewed-by & Fixes tags.
- Link to v3: https://lore.kernel.org/r/20260122-xfs-ima-fixup-v3-1-20335a8aa836@cloudflare.com

Changes in v3:
- Prefer timespec64_to_ns() to leverage attr.version. [Roberto]
- s/TPMFS/TMPFS/ in description.
- Link to v2: https://lore.kernel.org/r/20260120-xfs-ima-fixup-v2-1-f332ead8b043@cloudflare.com

Changes in v2:
- Updated commit description + message to clarify the problem.
- compare struct timespec64 to avoid collision possibility [Roberto].
- Don't check inode_attr_changed() in ima_check_last_writer()
- Link to v1: https://lore.kernel.org/r/20260112-xfs-ima-fixup-v1-1-8d13b6001312@cloudflare.com

Changes since RFC:
- Remove calls to I_IS_VERSION()
- Function documentation/comments
- Abide IMA/EVM change detection fallback invariants
- Combined ctime guard into version for attributes struct
- Link to RFC: https://lore.kernel.org/r/20251229-xfs-ima-fixup-v1-1-6a717c939f7c@cloudflare.com

---
Frederick Lawler (3):
      ima: Unify vfs_getattr_nosec() stat comparisons under helper function
      ima: Make integrity_inode_attrs_changed() call into vfs
      ima: Use kstat.ctime as a fallback change detection for stacked fs

 include/linux/integrity.h         | 43 +++++++++++++++++++++++++++++++++++----
 security/integrity/evm/evm_main.c |  5 ++---
 security/integrity/ima/ima_api.c  | 11 +++++++---
 security/integrity/ima/ima_main.c | 11 +++++-----
 4 files changed, 54 insertions(+), 16 deletions(-)
---
base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
change-id: 20251212-xfs-ima-fixup-931780a62c2c

Best regards,
-- 
Frederick Lawler <fred@cloudflare.com>


