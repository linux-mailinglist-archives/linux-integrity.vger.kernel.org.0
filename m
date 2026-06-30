Return-Path: <linux-integrity+bounces-9854-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CoCOAMoORGownwoAu9opvQ
	(envelope-from <linux-integrity+bounces-9854-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jun 2026 20:45:30 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC7E6E7473
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jun 2026 20:45:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=rz4TG94i;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9854-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9854-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5616E31653E2
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jun 2026 18:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37787477980;
	Tue, 30 Jun 2026 18:40:06 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3074534A3
	for <linux-integrity@vger.kernel.org>; Tue, 30 Jun 2026 18:40:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844805; cv=none; b=XSx3LuaO+tj1Ji6F5J2mqspzql3PcHCpN3b0HiREOJQI+vlPkfAF9/cO+GFsjzv10G0/OXID/gEBE7pbYidm3ZxeQIOFXDktLAw91/DjVCk5cmOG5tJPjedSysEiFjc8NYsUTkq4TtO+TWGXLppmfFIYDqDgmhTRs6GSwMtmeHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844805; c=relaxed/simple;
	bh=BiKlN3d8qvLzGFVeEtYcZ6pTPmcjFUcEmBIxD9smRQY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6oWve73yhdTG43C10UjVAf5hthnPgqye1POdChjLO1oMO1pxkF20lQhLxxg7pj5V8qaIYXNZuqtdVunGriniPjQtn293sEroyCwVMRZs3ufKpTum7Jstu0zgZpbV6n6mofOEWEz0uEzw1Drn0ZxAGkVlwk5ncm5b3wuA3hcQD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rz4TG94i; arc=none smtp.client-ip=209.85.222.173
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-92e4fd65b2bso205366985a.0
        for <linux-integrity@vger.kernel.org>; Tue, 30 Jun 2026 11:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782844801; x=1783449601; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iKEgmOHWUkhjnwoe0M45LunoQ2TOBgmWOHV8NbIxVxQ=;
        b=rz4TG94iO7IYO+5KguO+B2CZ3OCRMEL7JBGpxq7KEkoexfAcXNg2dsLDCaEPf3YwIQ
         4uNf8tuRNdFAH8A7QYviIRc4nBpxO53QrUIJpfYxkbU8bt2Q8OJppreWRANYzvRUbLly
         wrI7aRwLHityPaW6kn5Oju4fxSktpy2Hk+21EoQ8p2+7GB3NOiye3Q4ysQa+DR6bNj6C
         gZJhr9qNnsou7KcY5afMkEHjrIQTYBq3oeUw0Oc8Y9ZbgHpj8PhxZ9RSEOpsbkNDy/SL
         C7Z/7H7PS07TQgffwa/qG107rusfVNL6tPtshs5tLiyZkGSlnXOg4C3NQjRQWAby95ns
         +0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782844801; x=1783449601;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iKEgmOHWUkhjnwoe0M45LunoQ2TOBgmWOHV8NbIxVxQ=;
        b=bWgu83DsSKK1MpIqr3CmQExu/d4YGQyRvMUMDnt1EeNqAGOraJNEfrqGJl6yaA8NfS
         sLtUwqUroNbtydDMezyRZwAuKLVc3tarEhg54DZJPudNuIOlfOg2CdBG1UM4+T1S5/0M
         E2uFRCjcMaEEpPKCrOoCm+cdCKjKHOpkMD2A45nJHAieac07cxKl/v2F7WXWnabzaCWl
         EX+PxxbUENqbfH3UDnpLfX18AVzrqneuhDr3K6fciLZjAexTy+jwpo1N+7Yifbonn1XK
         jL6qSFho7/v4Gf7wB1zOMczQgr6yBPh1INPfBuT2i7WR9GAqSShxegxQ9sQJt/q9NCPB
         K0Nw==
X-Forwarded-Encrypted: i=1; AFNElJ+icODJwaHPQlb81VGdrMMkv3wMsaz/mBNoUELpvMJgDYugy9umm59VTBhssS4eiZ8ttrER7Rc+LR8vED94IrE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfAuXg/4c0NNiCQLcFemhU/vp5Nf8YlUVzZmV3vTv8LtmCldGH
	8VlN8iRb03s5MqoxheHbw5iIjZ4K9uylq0mUaV1QgyKqjnGSypUQsWbe
X-Gm-Gg: AfdE7ckAqnIfpdNTzrQHDpg8R6zVe/9kGjhTTh6lUBhfGLWgxts3lpYLp9kK+05BEP9
	bRwGnEIhxB8HvFnz61dwjdvT8R1c/+INcuy05xC3BJpjeBdzXM/OAm6BabY93PUcNjdgzeCesPA
	pUmYms/3CuKdk3ld5ZyuWOKuuJAD1XcEvjk6pDm8TvWKaXkwoOkOVFTfnJdrzddX7LYG18nlH2I
	6S9oMgE8VJIXc2K6cq8DyE1kE313uiz9JOCgGUQgacvet8viemPx/UtEuhMtaFLcUYHgtdh6bMI
	65/gnCTAKttqkG7lpIIm9qj+7h91XrGpKgtfNIr2G1il6DZ+0BB6Q19Crg1rzggkfTVmUsQNWQ2
	aNIrVSaWvL+XPsU/Hijcqbvi25zlO2MJBJLznSHB8zqCl7de8BxOqeiqElwq6tTLgWssQbktM6y
	JUjhLdp7d3wewNY0lNy+x2RweFXKzi7xozQdAxozFejodwnL29hNvHwv10SqK4WiFSa5wMjR16n
	7MxPHIkCG1/yA8=
X-Received: by 2002:a05:620a:8805:b0:90d:c28d:9666 with SMTP id af79cd13be357-92e6261a6a5mr812438985a.30.1782844801109;
        Tue, 30 Jun 2026 11:40:01 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e62191b18sm326961285a.18.2026.06.30.11.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:40:00 -0700 (PDT)
From: David Windsor <dwindsor@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Matt Bobrowski <mattbobrowski@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Shuah Khan <shuah@kernel.org>
Cc: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Windsor <dwindsor@gmail.com>
Subject: [PATCH v4 bpf-next 2/3] bpf: add bpf_init_inode_xattr kfunc for atomic inode labeling
Date: Tue, 30 Jun 2026 14:39:54 -0400
Message-ID: <20260630183956.281293-3-dwindsor@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260630183956.281293-1-dwindsor@gmail.com>
References: <20260630183956.281293-1-dwindsor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9854-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,etsalapatis.com,google.com,paul-moore.com,namei.org,hallyn.com,schaufler-ca.com,redhat.com,linux.ibm.com,huawei.com,oracle.com,zeniv.linux.org.uk,suse.cz];
	FORGED_SENDER(0.00)[dwindsor@gmail.com,linux-integrity@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[35];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:martin.lau@linux.dev,m:eddyz87@gmail.com,m:song@kernel.org,m:yonghong.song@linux.dev,m:john.fastabend@gmail.com,m:kpsingh@kernel.org,m:jolsa@kernel.org,m:memxor@gmail.com,m:emil@etsalapatis.com,m:mattbobrowski@google.com,m:paul@paul-moore.com,m:jmorris@namei.org,m:serge@hallyn.com,m:casey@schaufler-ca.com,m:stephen.smalley.work@gmail.com,m:omosnace@redhat.com,m:zohar@linux.ibm.com,m:roberto.sassu@huawei.com,m:dmitry.kasatkin@gmail.com,m:eric.snowberg@oracle.com,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:shuah@kernel.org,m:bpf@vger.kernel.org,m:linux-security-module@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-integrity@vger.kernel.org,m:selinux@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:dwindsor@gmail.com,m:johnfastabend@gmail.com,m:stephensmalleywork@gmail.com,m:dmitrykasatkin@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dwindsor@gmail.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,kernsec.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8AC7E6E7473

Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically set
xattrs via the inode_init_security hook using lsm_get_xattr_slot(). The
hook now passes its xattr state as a single struct lsm_xattrs object,
which the kfunc takes directly.

The kfunc is only usable from lsm/inode_init_security programs: no other
hook exposes a struct lsm_xattrs argument, so the verifier rejects calls
from elsewhere. Restrict the xattr names that may be set via this kfunc
to the bpf.* namespace.

BPF reserves BPF_LSM_INODE_INIT_XATTRS slots via lbs_xattr_count, and the
kfunc enforces that BPF never consumes more slots than it reserved,
returning -ENOSPC once the budget is exhausted.

A previous attempt [1] required a kmalloc string output protocol for
the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSMs to
provide xattrs for inode_init_security hook") [2], the xattr name is no
longer allocated; it is a static constant.

Link: https://kernsec.org/pipermail/linux-security-module-archive/2022-October/034878.html [1]
Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=6bcdfd2cac55 [2]
Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 fs/bpf_fs_kfuncs.c      | 79 +++++++++++++++++++++++++++++++++++++++++
 include/linux/bpf_lsm.h |  3 ++
 kernel/bpf/bpf_lsm.c    |  1 +
 security/bpf/hooks.c    |  1 +
 4 files changed, 84 insertions(+)

diff --git a/fs/bpf_fs_kfuncs.c b/fs/bpf_fs_kfuncs.c
index 768aca2dc0f0..c4023c82f21e 100644
--- a/fs/bpf_fs_kfuncs.c
+++ b/fs/bpf_fs_kfuncs.c
@@ -10,6 +10,7 @@
 #include <linux/fsnotify.h>
 #include <linux/file.h>
 #include <linux/kernfs.h>
+#include <linux/lsm_hooks.h>
 #include <linux/mm.h>
 #include <linux/xattr.h>
 
@@ -374,6 +375,83 @@ __bpf_kfunc struct inode *bpf_real_inode(struct dentry *dentry)
 	return d_real_inode(dentry);
 }
 
+static int bpf_xattrs_used(const struct lsm_xattrs *ctx)
+{
+	const size_t prefix_len = sizeof(XATTR_BPF_LSM_SUFFIX) - 1;
+	unsigned int i, n = 0;
+
+	for (i = 0; i < ctx->xattr_count; i++) {
+		const char *name = ctx->xattrs[i].name;
+
+		if (name && !strncmp(name, XATTR_BPF_LSM_SUFFIX, prefix_len))
+			n++;
+	}
+	return n;
+}
+
+/**
+ * bpf_init_inode_xattr - set an xattr on a new inode from inode_init_security
+ * @xattrs: inode_init_security xattr state from the hook context
+ * @name__str: xattr name (e.g., "bpf.file_label")
+ * @value_p: dynptr containing the xattr value
+ *
+ * Only callable from lsm/inode_init_security programs.
+ *
+ * Return: 0 on success, negative error on failure.
+ */
+__bpf_kfunc int bpf_init_inode_xattr(struct lsm_xattrs *xattrs,
+				     const char *name__str,
+				     const struct bpf_dynptr *value_p)
+{
+	struct bpf_dynptr_kern *value_ptr = (struct bpf_dynptr_kern *)value_p;
+	size_t name_len;
+	void *xattr_value;
+	struct xattr *xattr;
+	const void *value;
+	u32 value_len;
+
+	if (!xattrs || !xattrs->xattrs || !name__str)
+		return -EINVAL;
+	if (bpf_xattrs_used(xattrs) >= BPF_LSM_INODE_INIT_XATTRS)
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
+	xattr_value = kmalloc(value_len + name_len + 1, GFP_NOFS);
+	if (!xattr_value)
+		return -ENOMEM;
+
+	memcpy(xattr_value, value, value_len);
+	memcpy(xattr_value + value_len, name__str, name_len);
+	((char *)xattr_value)[value_len + name_len] = '\0';
+
+	xattr = lsm_get_xattr_slot(xattrs);
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
 __bpf_kfunc_end_defs();
 
 BTF_KFUNCS_START(bpf_fs_kfunc_set_ids)
@@ -385,6 +463,7 @@ BTF_ID_FLAGS(func, bpf_get_file_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_set_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_remove_dentry_xattr, KF_SLEEPABLE)
 BTF_ID_FLAGS(func, bpf_real_inode, KF_SLEEPABLE | KF_RET_NULL)
+BTF_ID_FLAGS(func, bpf_init_inode_xattr, KF_SLEEPABLE)
 BTF_KFUNCS_END(bpf_fs_kfunc_set_ids)
 
 static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfunc_id)
diff --git a/include/linux/bpf_lsm.h b/include/linux/bpf_lsm.h
index 143775a27a2a..b655c708818e 100644
--- a/include/linux/bpf_lsm.h
+++ b/include/linux/bpf_lsm.h
@@ -19,6 +19,9 @@
 #include <linux/lsm_hook_defs.h>
 #undef LSM_HOOK
 
+/* max bpf xattrs per inode */
+#define BPF_LSM_INODE_INIT_XATTRS 4
+
 struct bpf_storage_blob {
 	struct bpf_local_storage __rcu *storage;
 };
diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index 564071a92d7d..1c3f84a92420 100644
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
-- 
2.53.0


