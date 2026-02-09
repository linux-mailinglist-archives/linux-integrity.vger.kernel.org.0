Return-Path: <linux-integrity+bounces-8481-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6BTuBfpPimmbJQAAu9opvQ
	(envelope-from <linux-integrity+bounces-8481-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 09 Feb 2026 22:22:02 +0100
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 33967114BC1
	for <lists+linux-integrity@lfdr.de>; Mon, 09 Feb 2026 22:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 131AC3007A65
	for <lists+linux-integrity@lfdr.de>; Mon,  9 Feb 2026 21:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A4930F921;
	Mon,  9 Feb 2026 21:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="M0rQgl3H"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BB830E836
	for <linux-integrity@vger.kernel.org>; Mon,  9 Feb 2026 21:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770672115; cv=none; b=i+2Nuogm69i54tljmbQUvPBMCrb+MV2qQmZQsfh2Rumd3hOGhw5n81kkMN9EgSkLwtdIkAfESsx8Q4H/yTPuju+z6Y4DpHC1wjGFIBizKgQPY2JA1KjoXqNp++M34+ipLKuWWyQPXl+IZ+WqXsHw8QNFAeowg0a7IMuIEWen5I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770672115; c=relaxed/simple;
	bh=qM+AUMPPSOsO/xFhj9Od+YUAH9S8lYo+uEY1V7e0Ehs=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nbUdPOpwMhFQYghZVST2JpBPOKUBR0LOx1007+fBbFRZ8qYYm4AULSDFgv/LNyUPvHQqylGmxsbrrnAG+Fzig+uhBKkUacY44KlEdUWQYEurnA0rBeBNfshongrKsqxjAArYtqSlPbrFAp4ya0l/nqvbGC7XkOzWEQ8RWt4DYSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=M0rQgl3H; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-66ee7b9af94so690184eaf.0
        for <linux-integrity@vger.kernel.org>; Mon, 09 Feb 2026 13:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1770672112; x=1771276912; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bf/ok2KALFW8VblL1bFh6P+HrccoXJ2oopKC4NTt0RY=;
        b=M0rQgl3HhyvQ4gLR55NLX75GsoHZe3qrRWK1uke2iR9s2NNpG2YUndH1vbNEVfCk6b
         9ZGSBgxpbCiuW2VaeJ1vxVN0W44PyFwB/j+UHzME3NvPn1iRIEAuQ7lXpnST1iw5M+rL
         NK9U67RQbiI+PEuahnwZRcTdBMzUDp/ua68z6H2Ji8ozigNWPULP1kC2M/vnoKgPHt0Z
         MuZRGLr+GVyQ9dDh0pf0y7AS5R49txhQtx7fVR1Daqa2cQABEG8UcsiodWI95aqs9UWy
         gxg3aqShWjgm5g3h0F++93qgb2la4ZcwF8ph98Y38VGhCAdnKzpOGGhKIfdeM8sHqs3C
         m7+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770672112; x=1771276912;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bf/ok2KALFW8VblL1bFh6P+HrccoXJ2oopKC4NTt0RY=;
        b=YRjFD+XfBrKcVQVajrX3LH6zslRpg/WN5IkCU7lnTZVZJZLNdPBcRh94UpSmq/LcWG
         21VZDkqe9QKOqe78xoAsYriuvAa/hc2yDE4T6s5Nlk398TQ/v7DzNlAkdlcbhDAMxTCd
         tUA9Da5CDcSQJeIMpvl6RRiWUmnVfJGaJdqwTjTpTS3lay3i8lvM8PmNAz7W8Ua6+vsT
         4P0IsgxjGmtJhbAh7IM8oIV+6GPJ3jFnD3NqiWiQ3c//dWXLxqNhrkD7AMvvf2PDoyLN
         6S0gU2UjXGwEDsGD0dkvw9fq2hSS4Za+s8B481BxrTPJjrFLZZX6TkC2tCUjPdSn44r6
         se/g==
X-Forwarded-Encrypted: i=1; AJvYcCUhdMlh5fRI3HbHtGsNGDoB7/BisrZi3996nhE9Sle8Wdp0fEvjckER9w3mXSE3azQc8UHLGL3ip3nHxccd6+o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOLYg7jmSZRHIZsLjIzLLBeOLfob3+OMFMxB83qNd/yxD+3wO2
	zTbe04BowCVSFltG5EeELfg1TDA2BinQsiTln9L5Di64b6hRKQRhk3xntXlBXqzigxk=
X-Gm-Gg: AZuq6aLVAVdJM2wpkg/iy/j6xqbQYzJWzXYEPg6/YWi439jcmx8ks6RZHu3njyH+cEX
	MHOfRBjIwQvd6oorwCNcYghAUk5vFW6aKbCTm/HVyKQYhP6D1nPohcH0ea59F3HFdHZPEolmnLg
	ajUM3VDg75f22ArOlvEpqPVkyQttJ2ZAk+UtBaUAHFlEobFf+peaQ8GBQMajBc0OPzgDESCS2VZ
	Vc/Nq19GNTAzDHLv+c8yzDZNUG+D8cWnoUCWEHv3AOZjwB/opDXRkToQvsbsoHQWwn4EhhYDCOH
	eeh3wUjB0J7RencBeU3nid6s9h6yFYykBqFxKxZ0kZwcpsecxqzpbAQKArtpr+2SquGQTG4MoUS
	C1RVgdnluFGYK/Lutf2asMJNiRSec/7VgN4O12LSXazXkfsdTliOJzEu9jPzpEC+0x3k7kuJZ6A
	==
X-Received: by 2002:a05:6820:2293:b0:662:fc95:1f8b with SMTP id 006d021491bc7-66d0a47957dmr4593250eaf.29.1770672111997;
        Mon, 09 Feb 2026 13:21:51 -0800 (PST)
Received: from [127.0.1.1] ([2a09:bac5:947d:1b37::2b6:46])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-66d390b935asm6591730eaf.5.2026.02.09.13.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Feb 2026 13:21:51 -0800 (PST)
From: Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH v6 0/3] ima: Detect changes to files via kstat changes
 rather than i_version
Date: Mon, 09 Feb 2026 15:21:47 -0600
Message-Id: <20260209-xfs-ima-fixup-v6-0-72f576f90e67@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOtPimkC/22QvW7DMAyEXyXQXBUiaesnU4suHTt0KzrQstQIS
 OLAbowUgd+9sosChu2RJO67491FF9oUOrHf3UUb+tSl5pwH/bAT/sDnryBTnWeBCktAQHmLnUw
 nljHdrhfpCIxVrNGjF1lzaUM+TLwP8fb8/vIqPvP6kLrvpv2ZXHqYjn9AdAtgDxKkZgPGO3LR+
 Cd/bK51PHIbHn1zGk2yVCtYZZmktgaqtFJAgEvpmKTHf/eMQLVEYEZEIgxc20oVtImgOWKVgjI
 CFVHJltmS3kQUc8Sqg2LsoKqsq6OpNG+nKGcIWj1SSiVLE2wR2IHZ6GIYhl/lU1q7/QEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4605; i=fred@cloudflare.com;
 h=from:subject:message-id; bh=qM+AUMPPSOsO/xFhj9Od+YUAH9S8lYo+uEY1V7e0Ehs=;
 b=owEBbQKS/ZANAwAKAasltHYDktNtAcsmYgBpik/tEhamzz+u1nbpst2YvQ+dPU1OGY1iJmMYg
 jNblVKV/t2JAjMEAAEKAB0WIQTLNBqMVmu1PHvjOe2rJbR2A5LTbQUCaYpP7QAKCRCrJbR2A5LT
 beDyD/4r+Xpu/c71CZ+P8NnaoZ0SlBXsD7XohtI+RtA078plY8dE8W4WeoNFdvFb1wxg6/iC8iJ
 0hCm8f2h7PJrSEHB37OC5qtCmyJqwlUCDiCVnl4qYj4Qlt/vn2DP8exzr8pnJ2dEcI/rH7qRGIa
 fil52RbDaQpytIZ5pHcYuSIbitg7tX4Cvwb8IB6zV5tlse/JR3lz0unlQlKFjXW6QpR0Bk0D24/
 shpK4PNQYn+/EU2330we7bV9CNoGoSZvt7DiPxL04vv//iGWyOw261dT9yZhf3va8E4Tgq2GQc6
 RZR1BRqE9kq8VwsaNjv27IntU/7fxG+sqM0vWmC9TZzBnR4UFi0meuO9AggUKT1BqPy9KNgEjWf
 FvW61sy/xaOmU0aCCxjF9xNsLKYVQr6tshVpoT2/jWTDFNLJJ3cZdO04lwX4Dh64ChrpRc3aO1V
 R2Ki322wfm8YmSR2qd21gy5vN/GXcnBMLcZhUVeromxuZswLun6qfEqjbo1olBfRluKgsiyb3Ll
 f1VqoAU0wXw1MnbKDx6vbtfaI/MnBjbcF7hCavCy7ona4cjIUMX6I4nwxZlaA6Px9pJvfQsMtDO
 2L507pjOvrYi4yqd6TkPburqrVQxK8dIw/dh0gI9XHz5bRejZhFw3wmF5JFrqDeK6yE5Ss4k3s1
 Y9qd0ZOrkNFGPZw==
X-Developer-Key: i=fred@cloudflare.com; a=openpgp;
 fpr=CB341A8C566BB53C7BE339EDAB25B4760392D36D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[cloudflare.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cloudflare.com,reject];
	R_DKIM_ALLOW(-0.20)[cloudflare.com:s=google09082023];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8481-lists,linux-integrity=lfdr.de];
	FREEMAIL_TO(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,kernel.org,toxicpanda.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fred@cloudflare.com,linux-integrity@vger.kernel.org];
	DKIM_TRACE(0.00)[cloudflare.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cloudflare.com:mid,cloudflare.com:dkim,cloudflare.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 33967114BC1
X-Rspamd-Action: no action

We uncovered a case in kernels >= 6.13 where XFS is no longer updating
struct kstat.change_cookie on i_op getattr() access calls. Instead, XFS is
using multigrain ctime (as well as other file systems) for
change detection in commit 1cf7e834a6fb ("xfs: switch to
multigrain timestamps").

Because file systems may implement i_version as they see fit, IMA
unnecessarily measures files.

We're proposing to compare against the kstat.change_cookie
directly to the cached version, and fall back to a ctime comparison,
if STATX_CHANGE_COOKIE is not supplied by vfs_getattr_nosec()'s result
mask.

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
Changes in v6:
- Patch 1: No changes
- All other patches including cover letter have descriptions updated.
- Link to v5: https://lore.kernel.org/r/20260130-xfs-ima-fixup-v5-0-57e84ea91712@cloudflare.com

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
      ima: Make integrity_inode_attrs_changed() call into VFS
      ima: Use kstat.ctime as a fallback for change detection

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


