Return-Path: <linux-integrity+bounces-9407-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLj/Js6792m5lgIAu9opvQ
	(envelope-from <linux-integrity+bounces-9407-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Sun, 03 May 2026 23:19:10 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1E24B7749
	for <lists+linux-integrity@lfdr.de>; Sun, 03 May 2026 23:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E688B301544E
	for <lists+linux-integrity@lfdr.de>; Sun,  3 May 2026 21:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83FB73A380F;
	Sun,  3 May 2026 21:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgVz/Z8O"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D3437CD20
	for <linux-integrity@vger.kernel.org>; Sun,  3 May 2026 21:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777843123; cv=none; b=huNSUii2wK8Ve+PHgZ6Ib2W74tRk8zCOs9CPC+wI1yB5/HUycUUYIn1GjegnouAV7tE8bTnZNT2vh8yuofS/7mp3T+XJEH2XAgTTeUDRzAv0ffct/5k0nItZM6c/EGGwAnfI1lEKbFqMOMixjpuLK9yJrmBHSfzqeIeHLUPOPbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777843123; c=relaxed/simple;
	bh=shilgt/ju0EtBqdACE4zTHew0vvnTHJFGHknCSry7tg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CtowT6A3fEYOvHijFMsJmF7r2WuaO1ERVug3GBL8pHBRUgDXh2dD8BfkhQdL18kYaeJ7XbH0QNiisWGmoITbB3vr1z9u29+NZyNfZa1m9KWHcE1gp/tgahOdhpidgh//HAWxmGlR8VbzTbkPhXLHGbsILBrFSPbXZ3Brtd4zOFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgVz/Z8O; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8d68f702851so402395685a.0
        for <linux-integrity@vger.kernel.org>; Sun, 03 May 2026 14:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777843119; x=1778447919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIsVCjxLnTj+8m8eZIzRMNCAMhlmFhy9YcwEKNyPJXI=;
        b=BgVz/Z8OzZtLunHOnHxoQhPifTju5pcNBPnzzeuAX5nNzm08YAsT2Nrd3e2a7jugQy
         5qH+akiPjWYvz3UBXKVvf9h9x/q5JnpYqJTeKhf8AP9X76JFJMtGuSQTEQACSgH6q4t1
         kUbQsNyTn/QE9T0q5hmpzMmIpDM3xC2o4sLsNL/G8uzL8wT9H5sHZiyzOcJVR2oLtJxV
         AjFQkmytw877bNrm/tqbGmWxuchy2s36hjdFDJLiBtOjK631hStSBvkW2ii5t+lU5s/z
         drS+0BVVbqfckAI8cBamk3S9wd9xwKpQNjZkgh+zswZvoXlFpAXkMmRtjvYl/JPSmPJJ
         T9Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777843119; x=1778447919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SIsVCjxLnTj+8m8eZIzRMNCAMhlmFhy9YcwEKNyPJXI=;
        b=X6atHHacD3lsudSdBk0LKVSfQTPqckDXRwRLQw8q+d4iA/lLy5UwxqqDOCYyyBqOZr
         2GUwFkfmv4qreY6Q2DHQT67mv/5+2VN5jBuYPSU9NosAZJrGoadogxooYmYjV9NxSYm9
         aQdepwEA2Tnj+Np27V26XDaSuc6PuRCJ1cYuRCHmv2u9iibeliMFmhvIR1usm8Bc8tG/
         DRQ6G2r1tqLoEU6N5x+rXrsf1LonS4USQfdgI9NdpBXzRSveUQntbTOTbQi0jsAiQi6w
         hACI0GT8/rG9Qv23cXZRb2fcULR/phmL+yH+MmumiIauDQ25zMZsOBxCREJuRw2xas/c
         rwJg==
X-Forwarded-Encrypted: i=1; AFNElJ9RM1s7pnAaBnrDJ4tS5FojwlYVrLSeKp3uaQU52pFo9IyCtH6FLjldKTGjC0kWIDkjrO7tOYx2dX0eMF13b0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxP3obZptG9FXwopzAcV7xxReqUkIx/GG0KGcv1TYeKYWOh2N7z
	olHu0DGnFY+ZXKzhkvgs0TQBUMfdOjfYJGQvAtITg4+6gb6o8XaEDncP
X-Gm-Gg: AeBDiesDkXeatlWLooYA0KlSmKiSBilteewRju2bYCxZ4N5aR1/I+u1W04ZzBH8li1N
	Fej5RufOvhxAtJ4f67tcl0YUvq3gqbM16bvv32ffxVlexufsEluMVSUp9PGvR0ICW2mrz6YByU9
	ZVihagRAyxusQtbPhy3suLkvtDKfgRNAU0z239JwQm41NOll2TZN1UI9f6KhpF1n4BeHi6Ia+Rx
	kVJT9ixUTbnd0W4c6Mp0laIdhsCnt11wAdMBe+fNH2HW1TfdCD6aGaKryx4TkCBi+JBVSKh4o5h
	cjNzWTxFhCpxMx4Bsb5SSH8hzST9wD/3pRqLub0T6PdEJx6sQEZcNIxjIz/lS/C3vUU7gYJykAp
	GMVdWuroCOwLiIaU92hHuQAyxuoKAHhqywAv0htV3HnuUxEoX85CZu9I4+yeUnue9WtRokTip1P
	Tnk4A61khhjCGoFFz1LpgkeStD+bZ4ZlOvjdLuo363UmdtyYSjay+H34mwKrP6ghSaq7XUfHpFx
	zfLkUFmYx7gSQ8r5McJ6t7kUlvE+UZtgcZk149Zd+aE8E6/vFNj
X-Received: by 2002:a05:6214:328c:b0:8ac:a9f1:6cf4 with SMTP id 6a1803df08f44-8b66815b667mr179045526d6.37.1777843118887;
        Sun, 03 May 2026 14:18:38 -0700 (PDT)
Received: from battery.lan (pool-100-15-227-251.washdc.fios.verizon.net. [100.15.227.251])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b53d831651sm96146346d6.47.2026.05.03.14.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 14:18:38 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Casey Schaufler <casey@schaufler-ca.com>
Cc: Song Liu <song@kernel.org>,
	Jan Kara <jack@suse.cz>,
	John Fastabend <john.fastabend@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v2 1/2] bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
Date: Sun,  3 May 2026 17:18:30 -0400
Message-ID: <20260503211835.16103-2-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260503211835.16103-1-dwindsor@gmail.com>
References: <20260503211835.16103-1-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: EA1E24B7749
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,suse.cz,gmail.com,linux.dev,oracle.com,redhat.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-9407-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[zeniv.linux.org.uk,kernel.org,iogearbox.net,gmail.com,google.com,paul-moore.com,namei.org,hallyn.com,linux.ibm.com,huawei.com,schaufler-ca.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwindsor@gmail.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-integrity];
	NEURAL_HAM(-0.00)[-0.993];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically set
xattrs via the inode_init_security hook using lsm_get_xattr_slot().

The inode_init_security hook previously took the xattr array and count
as two separate output parameters (struct xattr *xattrs, int
*xattr_count), which BPF programs cannot write to. Pass the xattr state
as a single context object (struct lsm_xattr_ctx) instead, and have
bpf_init_inode_xattr() take that context directly. Update the existing
in-tree callers of inode_init_security to take and forward the new
lsm_xattr_ctx.

Because we rely on the hook-specific ctx layout, the kfunc is
restricted to lsm/inode_init_security. Restrict the xattr names that
may be set via this kfunc to the bpf.* namespace.

Suggested-by: Song Liu <song@kernel.org>
Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 fs/bpf_fs_kfuncs.c                | 106 +++++++++++++++++++++++++++++-
 include/linux/bpf_lsm.h           |   3 +
 include/linux/evm.h               |   9 +--
 include/linux/lsm_hook_defs.h     |   4 +-
 include/linux/lsm_hooks.h         |  16 ++---
 include/linux/security.h          |   5 ++
 kernel/bpf/bpf_lsm.c              |   1 +
 security/bpf/hooks.c              |   1 +
 security/integrity/evm/evm_main.c |   8 ++-
 security/security.c               |   7 +-
 security/selinux/hooks.c          |   4 +-
 security/smack/smack_lsm.c        |  13 ++--
 12 files changed, 147 insertions(+), 30 deletions(-)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 9d27be058494..193accc00796 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -10,6 +10,7 @@
 #include <linux/fsnotify.h>
 #include <linux/file.h>
 #include <linux/kernfs.h>
+#include <linux/lsm_hooks.h>
 #include <linux/mm.h>
 #include <linux/xattr.h>
 
@@ -353,6 +354,97 @@ __bpf_kfunc int bpf_cgroup_read_xattr(struct cgroup *cgroup, const char *name__s
 }
 #endif /* CONFIG_CGROUPS */
 
+static int bpf_xattrs_used(const struct lsm_xattr_ctx *ctx)
+{
+	const size_t prefix_len = sizeof(XATTR_BPF_LSM_SUFFIX) - 1;
+	int i, n = 0;
+
+	for (i = 0; i < *ctx->xattr_count; i++) {
+		const char *name = ctx->xattrs[i].name;
+
+		if (name && !strncmp(name, XATTR_BPF_LSM_SUFFIX, prefix_len))
+			n++;
+	}
+	return n;
+}
+
+static int __bpf_init_inode_xattr(struct lsm_xattr_ctx *xattr_ctx,
+				  const char *name__str,
+				  const struct bpf_dynptr *value_p)
+{
+	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
+	size_t name_len;
+	void *xattr_value;
+	struct xattr *xattr;
+	struct xattr *xattrs;
+	int *xattr_count;
+	const void *value;
+	u32 value_len;
+
+	if (!xattr_ctx || !name__str)
+		return -EINVAL;
+
+	xattrs = xattr_ctx->xattrs;
+	xattr_count = xattr_ctx->xattr_count;
+	if (!xattrs || !xattr_count)
+		return -EINVAL;
+	if (bpf_xattrs_used(xattr_ctx) >= BPF_LSM_INODE_INIT_XATTRS)
+		return -ENOSPC;
+
+	name_len = strlen(name__str);
+	if (name_len == 0 || name_len > XATTR_NAME_MAX)
+		return -EINVAL;
+	if (strncmp(name__str, XATTR_BPF_LSM_SUFFIX,
+		    sizeof(XATTR_BPF_LSM_SUFFIX) - 1))
+		return -EPERM;
+
+	value_len = __bpf_dynptr_size(value_ptr);
+	if (value_len == 0 || value_len > XATTR_SIZE_MAX)
+		return -EINVAL;
+
+	value = __bpf_dynptr_data(value_ptr, value_len);
+	if (!value)
+		return -EINVAL;
+
+	/* Combine xattr value + name into one allocation. */
+	xattr_value = kmalloc(value_len + name_len + 1, GFP_KERNEL);
+	if (!xattr_value)
+		return -ENOMEM;
+
+	memcpy(xattr_value, value, value_len);
+	memcpy(xattr_value + value_len, name__str, name_len);
+	((char *)xattr_value)[value_len + name_len] = '\0';
+
+	xattr = lsm_get_xattr_slot(xattr_ctx);
+	if (!xattr) {
+		kfree(xattr_value);
+		return -ENOSPC;
+	}
+
+	xattr->value = xattr_value;
+	xattr->name = (const char *)xattr_value + value_len;
+	xattr->value_len = value_len;
+
+	return 0;
+}
+
+/**
+ * bpf_init_inode_xattr - set an xattr on a new inode from inode_init_security
+ * @xattr_ctx: inode_init_security xattr state from the hook context
+ * @name__str: xattr name (e.g., "bpf.file_label")
+ * @value_p: dynptr containing the xattr value
+ *
+ * Only callable from lsm/inode_init_security programs.
+ *
+ * Return: 0 on success, negative error on failure.
+ */
+__bpf_kfunc int bpf_init_inode_xattr(struct lsm_xattr_ctx *xattr_ctx,
+				     const char *name__str,
+				     const struct bpf_dynptr *value_p)
+{
+	return __bpf_init_inode_xattr(xattr_ctx, name__str, value_p);
+}
+
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
@@ -363,13 +455,25 @@ BTF_ID_FLAGS(func, bpf_get_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
+BTF_ID_FLAGS(func, bpf_init_inode_xattr, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
+BTF_ID_LIST(bpf_lsm_inode_init_security_btf_ids)
+BTF_ID(func, bpf_lsm_inode_init_security)
+
+BTF_ID_LIST(bpf_init_inode_xattr_btf_ids)
+BTF_ID(func, bpf_init_inode_xattr)
+
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
 	if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
-	    prog->type == BPF_PROG_TYPE_LSM)
+	    prog->type == BPF_PROG_TYPE_LSM) {
+		/* bpf_init_inode_xattr only attaches to inode_init_security. */
+		if (kfunc_id == bpf_init_inode_xattr_btf_ids[0] &&
+		    prog->aux->attach_btf_id != bpf_lsm_inode_init_security_btf_ids[0])
+			return -EACCES;
 		return 0;
+	}
 	return -EACCES;
 }
 
diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 643809cc78c3..b97a3d79529d 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -19,6 +19,9 @@
 #include <linux/lsm_hook_defs.h>
 #undef LSM_HOOK
 
+/* max bpf xattrs per inode */
+#define BPF_LSM_INODE_INIT_XATTRS 1
+
 struct bpf_storage_blob {
 	struct bpf_local_storage __rcu *storage;
 };
diff --git a/include/linux/evm.h b/include/linux/evm.h
index 913f4573b203..dff930bc10ba 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -12,6 +12,8 @@
 #include <linux/integrity.h>
 #include <linux/xattr.h>
 
+struct lsm_xattr_ctx;
+
 #ifdef CONFIG_EVM
 extern int evm_set_key(void *key, size_t keylen);
 extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
@@ -21,8 +23,8 @@ extern enum integrity_status evm_verifyxattr(struct dentry *dentry,
 int evm_fix_hmac(struct dentry *dentry, const char *xattr_name,
 		 const char *xattr_value, size_t xattr_value_len);
 int evm_inode_init_security(struct inode *inode, struct inode *dir,
-			    const struct qstr *qstr, struct xattr *xattrs,
-			    int *xattr_count);
+			    const struct qstr *qstr,
+			    struct lsm_xattr_ctx *xattr_ctx);
 extern bool evm_revalidate_status(const char *xattr_name);
 extern int evm_protected_xattr_if_enabled(const char *req_xattr_name);
 extern int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
@@ -63,8 +65,7 @@ static inline int evm_fix_hmac(struct dentry *dentry, const char *xattr_name,
 
 static inline int evm_inode_init_security(struct inode *inode, struct inode *dir,
 					  const struct qstr *qstr,
-					  struct xattr *xattrs,
-					  int *xattr_count)
+					  struct lsm_xattr_ctx *xattr_ctx)
 {
 	return 0;
 }
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 2b8dfb35caed..0df364ebb0a5 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -116,8 +116,8 @@ LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
 LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
 LSM_HOOK(void, LSM_RET_VOID, inode_free_security_rcu, void *inode_security)
 LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
-	 struct inode *dir, const struct qstr *qstr, struct xattr *xattrs,
-	 int *xattr_count)
+	 struct inode *dir, const struct qstr *qstr,
+	 struct lsm_xattr_ctx *xattr_ctx)
 LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
 	 const struct qstr *name, const struct inode *context_inode)
 LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index b4f8cad53ddb..2133b729e87d 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -200,20 +200,18 @@ extern struct lsm_static_calls_table static_calls_table __ro_after_init;
 
 /**
  * lsm_get_xattr_slot - Return the next available slot and increment the index
- * @xattrs: array storing LSM-provided xattrs
- * @xattr_count: number of already stored xattrs (updated)
+ * @ctx: xattr state shared by inode_init_security hooks
  *
- * Retrieve the first available slot in the @xattrs array to fill with an xattr,
- * and increment @xattr_count.
+ * Retrieve the first available slot in the @ctx->xattrs array to fill with an
+ * xattr, and increment @ctx->xattr_count.
  *
- * Return: The slot to fill in @xattrs if non-NULL, NULL otherwise.
+ * Return: The slot to fill in @ctx->xattrs if non-NULL, NULL otherwise.
  */
-static inline struct xattr *lsm_get_xattr_slot(struct xattr *xattrs,
-					       int *xattr_count)
+static inline struct xattr *lsm_get_xattr_slot(struct lsm_xattr_ctx *ctx)
 {
-	if (unlikely(!xattrs))
+	if (unlikely(!ctx || !ctx->xattrs || !ctx->xattr_count))
 		return NULL;
-	return &xattrs[(*xattr_count)++];
+	return &ctx->xattrs[(*ctx->xattr_count)++];
 }
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/include/linux/security.h b/include/linux/security.h
index 41d7367cf403..a2fc72e63ada 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -68,6 +68,11 @@ struct watch;
 struct watch_notification;
 struct lsm_ctx;
 
+struct lsm_xattr_ctx {
+	struct xattr *xattrs;
+	int *xattr_count;
+};
+
 /* Default (no) options for the capable function */
 #define CAP_OPT_NONE 0x0
 /* If capable should audit the security request */
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index c5c925f00202..fbbb4e1c04fc 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -315,6 +315,7 @@ BTF_ID(func, bpf_lsm_inode_create)
 BTF_ID(func, bpf_lsm_inode_free_security)
 BTF_ID(func, bpf_lsm_inode_getattr)
 BTF_ID(func, bpf_lsm_inode_getxattr)
+BTF_ID(func, bpf_lsm_inode_init_security)
 BTF_ID(func, bpf_lsm_inode_mknod)
 BTF_ID(func, bpf_lsm_inode_need_killpriv)
 BTF_ID(func, bpf_lsm_inode_post_setxattr)
diff --git a/security/bpf/hooks.c b/security/bpf/hooks.c
index 40efde233f3a..d7c44c5c0e30 100644
--- a/security/bpf/hooks.c
+++ b/security/bpf/hooks.c
@@ -30,6 +30,7 @@ static int __init bpf_lsm_init(void)
 
 struct lsm_blob_sizes bpf_lsm_blob_sizes __ro_after_init = {
 	.lbs_inode = sizeof(struct bpf_storage_blob),
+	.lbs_xattr_count = BPF_LSM_INODE_INIT_XATTRS,
 };
 
 DEFINE_LSM(bpf) = {
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index b59e3f121b8a..c25301f25a0a 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -1062,14 +1062,16 @@ static int evm_inode_copy_up_xattr(struct dentry *src, const char *name)
  * evm_inode_init_security - initializes security.evm HMAC value
  */
 int evm_inode_init_security(struct inode *inode, struct inode *dir,
-			    const struct qstr *qstr, struct xattr *xattrs,
-			    int *xattr_count)
+			    const struct qstr *qstr,
+			    struct lsm_xattr_ctx *xattr_ctx)
 {
 	struct evm_xattr *xattr_data;
 	struct xattr *xattr, *evm_xattr;
+	struct xattr *xattrs;
 	bool evm_protected_xattrs = false;
 	int rc;
 
+	xattrs = xattr_ctx ? xattr_ctx->xattrs : NULL;
 	if (!(evm_initialized & EVM_INIT_HMAC) || !xattrs)
 		return 0;
 
@@ -1087,7 +1089,7 @@ int evm_inode_init_security(struct inode *inode, struct inode *dir,
 	if (!evm_protected_xattrs)
 		return 0;
 
-	evm_xattr = lsm_get_xattr_slot(xattrs, xattr_count);
+	evm_xattr = lsm_get_xattr_slot(xattr_ctx);
 	/*
 	 * Array terminator (xattr name = NULL) must be the first non-filled
 	 * xattr slot.
diff --git a/security/security.c b/security/security.c
index 4e999f023651..4cd43914ce93 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1334,6 +1334,7 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 {
 	struct lsm_static_call *scall;
 	struct xattr *new_xattrs = NULL;
+	struct lsm_xattr_ctx xattr_ctx;
 	int ret = -EOPNOTSUPP, xattr_count = 0;
 
 	if (unlikely(IS_PRIVATE(inode)))
@@ -1349,10 +1350,12 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 		if (!new_xattrs)
 			return -ENOMEM;
 	}
+	xattr_ctx.xattrs = new_xattrs;
+	xattr_ctx.xattr_count = &xattr_count;
 
 	lsm_for_each_hook(scall, inode_init_security) {
-		ret = scall->hl->hook.inode_init_security(inode, dir, qstr, new_xattrs,
-						  &xattr_count);
+		ret = scall->hl->hook.inode_init_security(inode, dir, qstr,
+							  &xattr_ctx);
 		if (ret && ret != -EOPNOTSUPP)
 			goto out;
 		/*
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 97801966bf32..dca81a22bf83 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2962,11 +2962,11 @@ static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
 
 static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 				       const struct qstr *qstr,
-				       struct xattr *xattrs, int *xattr_count)
+				       struct lsm_xattr_ctx *xattr_ctx)
 {
 	const struct cred_security_struct *crsec = selinux_cred(current_cred());
 	struct superblock_security_struct *sbsec;
-	struct xattr *xattr = lsm_get_xattr_slot(xattrs, xattr_count);
+	struct xattr *xattr = lsm_get_xattr_slot(xattr_ctx);
 	u32 newsid, clen;
 	u16 newsclass;
 	int rc;
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index 3f9ae05039a2..ea9549c666a1 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -981,10 +981,10 @@ smk_rule_transmutes(struct smack_known *subject,
 }
 
 static int
-xattr_dupval(struct xattr *xattrs, int *xattr_count,
+xattr_dupval(struct lsm_xattr_ctx *xattr_ctx,
 	     const char *name, const void *value, unsigned int vallen)
 {
-	struct xattr * const xattr = lsm_get_xattr_slot(xattrs, xattr_count);
+	struct xattr * const xattr = lsm_get_xattr_slot(xattr_ctx);
 
 	if (!xattr)
 		return 0;
@@ -1003,14 +1003,13 @@ xattr_dupval(struct xattr *xattrs, int *xattr_count,
  * @inode: the newly created inode
  * @dir: containing directory object
  * @qstr: unused
- * @xattrs: where to put the attributes
- * @xattr_count: current number of LSM-provided xattrs (updated)
+ * @xattr_ctx: where to put attributes and update count
  *
  * Returns 0 if it all works out, -ENOMEM if there's no memory
  */
 static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr,
-				     struct xattr *xattrs, int *xattr_count)
+				     struct lsm_xattr_ctx *xattr_ctx)
 {
 	struct task_smack *tsp = smack_cred(current_cred());
 	struct inode_smack * const issp = smack_inode(inode);
@@ -1057,7 +1056,7 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 		if (S_ISDIR(inode->i_mode)) {
 			transflag = SMK_INODE_TRANSMUTE;
 
-			if (xattr_dupval(xattrs, xattr_count,
+			if (xattr_dupval(xattr_ctx,
 				XATTR_SMACK_TRANSMUTE,
 				TRANS_TRUE,
 				TRANS_TRUE_SIZE
@@ -1067,7 +1066,7 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 	}
 
 	if (rc == 0)
-		if (xattr_dupval(xattrs, xattr_count,
+		if (xattr_dupval(xattr_ctx,
 			    XATTR_SMACK_SUFFIX,
 			    issp->smk_inode->smk_known,
 		     strlen(issp->smk_inode->smk_known)
-- 
2.53.0


