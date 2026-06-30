Return-Path: <linux-integrity+bounces-9853-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NbWOALYORGotnwoAu9opvQ
	(envelope-from <linux-integrity+bounces-9853-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jun 2026 20:45:10 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9F16E7465
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jun 2026 20:45:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PDlKoR2h;
	spf=pass (mail.lfdr.de: domain of "linux-integrity+bounces-9853-lists+linux-integrity=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-integrity+bounces-9853-lists+linux-integrity=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E07730C3C14
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Jun 2026 18:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3E1472760;
	Tue, 30 Jun 2026 18:40:04 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE5231352A
	for <linux-integrity@vger.kernel.org>; Tue, 30 Jun 2026 18:40:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782844804; cv=none; b=u8PtA3Os9PX21GjieCWkzyOoYiw+13/xhaJNnYIZlhKJw5WzU9gD5Yhpt7xnC3SxV1wFz8PMJvDPhdn8k393gBTZowl8Gkm9N9Zdjb6SqXH9MZ78Kw7n66mWC8vYfjHsbAnM2rBUEay8lFG1ONpeCkBtKplyD7ptvueoR5/Xz+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782844804; c=relaxed/simple;
	bh=EBoG5qIZUZ+mQ0U34p7TR4IAoPoqEP3/VhdLF5gYqkc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TKk7kWTB1GDc+lAKYt4swLn7WbIOeHFiHHqaBWJrjKcxyYsbkDTBg/w0oqkIOH/qx7mDtO6/RcarKyuFEC7V1IHaDOLpc0UuGhHlduBG4yoaI/RWwmKrSkDVGNgN9cnOo/UbRynT+1CasZkJWpFplRGCuKkP8CRKq+/5N9lefoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDlKoR2h; arc=none smtp.client-ip=209.85.222.171
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-9159951f05aso587477685a.0
        for <linux-integrity@vger.kernel.org>; Tue, 30 Jun 2026 11:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782844800; x=1783449600; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=srGxQq4VgFJq45xrO6uTXnfhhE8WUmdjoPQztn2Duw4=;
        b=PDlKoR2hsfrdMN8oN/AiKzxQ19c0meZqTQ0LikFkDTeMiXddYNxCjr8mdcEwB5vWbB
         17FeZov5XM/ESUHP6L1aJ4zRJ9n8HLxB+le2b1lWpjyEnE2hdbwMUtO6Wc22UZ67vpej
         n8lleR1xvKn5Ho9la60PhuScGhOj97k6EiQjDI6Wzc2LCLgpzg10FM2U5y2ZBh/SsX1g
         EOaXyAkUBAg8heOumqbf5H40ftG6k/nTuB1f+kqKvaperVWnSyzuf08c3R9gqROmESrg
         lthYaVtK8FSbsYRamNvKh7gUA01cTK4KOTUFte2QJlofVPwJoOx5vZ2GGD7MQ4NTnW/3
         lU7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782844800; x=1783449600;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=srGxQq4VgFJq45xrO6uTXnfhhE8WUmdjoPQztn2Duw4=;
        b=BkyMXajX21EfoA0He7ylr5oDEz8a+pvH8lm5PSAWUIj28eNXUMu407m0/miawYuqqk
         K6JCy8nggyNTIDR4/BidAmcOIeLliJqU+9XlgEavGPKDBGQu2LyzyG/7K/DGyRR5sJjF
         gy92aVVW2B1wWWYeIkDGxWQofQzeoWbWFC8oujm+aKuFORcWbgvvpP3j4XwVhcziGRah
         bP7ZowzFfbBclYTtzatp3Zrl3ncVoKLYMRhcc6cAXnOaDOUw9Q0nFHFCN6DozwudzBKa
         SRbpVzg7k6rMFTXo+211xlSzoYqm0JxdpxC31mmqNH+Z7dxGxSSjySgzgAEAhF4DhWH9
         QSYg==
X-Forwarded-Encrypted: i=1; AFNElJ+alugQjgcR3WXb4DIs8XwUgSRM41CdzTxU0mcaqPtMA0NBKU9s+bKQMgcwuMApEnNVKwCa367Q5Kt71eKwbWE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt31d+AiTKWA0LA8bWv0oPlN+U/nTS31s7WneTSiHwmOsPVV8x
	gtMdDJ4OFBZuH/i7ACkMkhcJAeWz/vFmY/cqKpd5jVZxPYpWXQmZfsKr
X-Gm-Gg: AfdE7cmJKGeEx4hmSTs4TGjY65MH0kVgT21r/95BUaKCRCuZ601GgCXDNorO97S1ytN
	ZNMFHdXRvBOw9yO8zLrUjdqrpSoAJMAWiyQYi+spCytUAmZqnioWePOp5Tfci8WYCSgGltL5096
	l5mT0EPggzHX+6Wvhan1wBhzXRYI2gu8JaN0AX0cja3G6jZzKchzII2gtPvxhLJ08Be25EMtW97
	jEj/Fdwp8OjKehrjgkyZ0uig2eXM7UDm0R0IKwU16edHrkFxEX0ofOdnmY8YEXg7/87sEY4vGfM
	JGS0dkKex5dijllawGP2/IdkF+3wlP87B72mQAnWdp0vbWkG69WW5DGNEksUOdDVVrhHQmY78wc
	2BnEVtGbiydAZ9X8w/cZvT8kj+kW2G8JdQchoc+6yBaGmdO8A3PmumFcltyduiTtaN70iqbeHgD
	s4kXcU2sqHL1Wt1lHWY2DR6WAOK3xtDbzdllMYOinC93vri+O3INf9psxjID2VjctlD34Mksl4g
	0fLHAMNIedSk7bI9c4SVtMzBQ==
X-Received: by 2002:a05:620a:4411:b0:92e:6c8a:2a1a with SMTP id af79cd13be357-92e6c8a3c36mr333047485a.7.1782844799832;
        Tue, 30 Jun 2026 11:39:59 -0700 (PDT)
Received: from battery.lan (pool-138-88-31-60.washdc.fios.verizon.net. [138.88.31.60])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92e62191b18sm326961285a.18.2026.06.30.11.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 11:39:59 -0700 (PDT)
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
Subject: [PATCH v4 bpf-next 1/3] security: pass inode_init_security xattrs via struct lsm_xattrs
Date: Tue, 30 Jun 2026 14:39:53 -0400
Message-ID: <20260630183956.281293-2-dwindsor@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9853-lists,linux-integrity=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8E9F16E7465

inode_init_security receives the LSM xattr array and its count as
separate parameters. For better compatibility with the bpf verifier,
update inode_init_security and its callers to consolidate these
parameters into a single context object: struct lsm_xattrs.

Signed-off-by: David Windsor <dwindsor@gmail.com>
---
 include/linux/evm.h               |  9 +++++----
 include/linux/lsm_hook_defs.h     |  4 ++--
 include/linux/lsm_hooks.h         | 16 +++++++---------
 include/linux/security.h          |  5 +++++
 security/integrity/evm/evm_main.c |  8 +++++---
 security/security.c               | 24 ++++++++++++------------
 security/selinux/hooks.c          |  4 ++--
 security/smack/smack_lsm.c        | 27 ++++++++++++---------------
 8 files changed, 50 insertions(+), 47 deletions(-)

diff --git a/include/linux/evm.h b/include/linux/evm.h
index 913f4573b203..528f360f3308 100644
--- a/include/linux/evm.h
+++ b/include/linux/evm.h
@@ -12,6 +12,8 @@
 #include <linux/integrity.h>
 #include <linux/xattr.h>
 
+struct lsm_xattrs;
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
+			    struct lsm_xattrs *xattrs);
 extern bool evm_revalidate_status(const char *xattr_name);
 extern int evm_protected_xattr_if_enabled(const char *req_xattr_name);
 extern int evm_read_protected_xattrs(struct dentry *dentry, u8 *buffer,
@@ -63,8 +65,7 @@ static inline int evm_fix_hmac(struct dentry *dentry, const char *xattr_name,
 
 static inline int evm_inode_init_security(struct inode *inode, struct inode *dir,
 					  const struct qstr *qstr,
-					  struct xattr *xattrs,
-					  int *xattr_count)
+					  struct lsm_xattrs *xattrs)
 {
 	return 0;
 }
diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 65c9609ec207..5b2de7865ce8 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -116,8 +116,8 @@ LSM_HOOK(int, 0, inode_alloc_security, struct inode *inode)
 LSM_HOOK(void, LSM_RET_VOID, inode_free_security, struct inode *inode)
 LSM_HOOK(void, LSM_RET_VOID, inode_free_security_rcu, void *inode_security)
 LSM_HOOK(int, -EOPNOTSUPP, inode_init_security, struct inode *inode,
-	 struct inode *dir, const struct qstr *qstr, struct xattr *xattrs,
-	 int *xattr_count)
+	 struct inode *dir, const struct qstr *qstr,
+	 struct lsm_xattrs *xattrs)
 LSM_HOOK(int, 0, inode_init_security_anon, struct inode *inode,
 	 const struct qstr *name, const struct inode *context_inode)
 LSM_HOOK(int, 0, inode_create, struct inode *dir, struct dentry *dentry,
diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index b4f8cad53ddb..7afe06a8d4c6 100644
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
+static inline struct xattr *lsm_get_xattr_slot(struct lsm_xattrs *ctx)
 {
-	if (unlikely(!xattrs))
+	if (unlikely(!ctx || !ctx->xattrs))
 		return NULL;
-	return &xattrs[(*xattr_count)++];
+	return &ctx->xattrs[ctx->xattr_count++];
 }
 
 #endif /* ! __LINUX_LSM_HOOKS_H */
diff --git a/include/linux/security.h b/include/linux/security.h
index 153e9043058f..0be590c40689 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -68,6 +68,11 @@ struct watch;
 struct watch_notification;
 struct lsm_ctx;
 
+struct lsm_xattrs {
+	struct xattr *xattrs;
+	unsigned int xattr_count;
+};
+
 /* Default (no) options for the capable function */
 #define CAP_OPT_NONE 0x0
 /* If capable should audit the security request */
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index b59e3f121b8a..b7158fc63543 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -1062,14 +1062,16 @@ static int evm_inode_copy_up_xattr(struct dentry *src, const char *name)
  * evm_inode_init_security - initializes security.evm HMAC value
  */
 int evm_inode_init_security(struct inode *inode, struct inode *dir,
-			    const struct qstr *qstr, struct xattr *xattrs,
-			    int *xattr_count)
+			    const struct qstr *qstr,
+			    struct lsm_xattrs *lsm_xattrs)
 {
 	struct evm_xattr *xattr_data;
 	struct xattr *xattr, *evm_xattr;
+	struct xattr *xattrs;
 	bool evm_protected_xattrs = false;
 	int rc;
 
+	xattrs = lsm_xattrs ? lsm_xattrs->xattrs : NULL;
 	if (!(evm_initialized & EVM_INIT_HMAC) || !xattrs)
 		return 0;
 
@@ -1087,7 +1089,7 @@ int evm_inode_init_security(struct inode *inode, struct inode *dir,
 	if (!evm_protected_xattrs)
 		return 0;
 
-	evm_xattr = lsm_get_xattr_slot(xattrs, xattr_count);
+	evm_xattr = lsm_get_xattr_slot(lsm_xattrs);
 	/*
 	 * Array terminator (xattr name = NULL) must be the first non-filled
 	 * xattr slot.
diff --git a/security/security.c b/security/security.c
index 71aea8fdf014..2ad7f09c1a61 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1333,8 +1333,8 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 				 const initxattrs initxattrs, void *fs_data)
 {
 	struct lsm_static_call *scall;
-	struct xattr *new_xattrs = NULL;
-	int ret = -EOPNOTSUPP, xattr_count = 0;
+	struct lsm_xattrs xattrs = {};
+	int ret = -EOPNOTSUPP;
 
 	if (unlikely(IS_PRIVATE(inode)))
 		return 0;
@@ -1344,15 +1344,15 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 
 	if (initxattrs) {
 		/* Allocate +1 as terminator. */
-		new_xattrs = kcalloc(blob_sizes.lbs_xattr_count + 1,
-				     sizeof(*new_xattrs), GFP_NOFS);
-		if (!new_xattrs)
+		xattrs.xattrs = kcalloc(blob_sizes.lbs_xattr_count + 1,
+					sizeof(*xattrs.xattrs), GFP_NOFS);
+		if (!xattrs.xattrs)
 			return -ENOMEM;
 	}
 
 	lsm_for_each_hook(scall, inode_init_security) {
-		ret = scall->hl->hook.inode_init_security(inode, dir, qstr, new_xattrs,
-						  &xattr_count);
+		ret = scall->hl->hook.inode_init_security(inode, dir, qstr,
+							  &xattrs);
 		if (ret && ret != -EOPNOTSUPP)
 			goto out;
 		/*
@@ -1364,14 +1364,14 @@ int security_inode_init_security(struct inode *inode, struct inode *dir,
 	}
 
 	/* If initxattrs() is NULL, xattr_count is zero, skip the call. */
-	if (!xattr_count)
+	if (!xattrs.xattr_count)
 		goto out;
 
-	ret = initxattrs(inode, new_xattrs, fs_data);
+	ret = initxattrs(inode, xattrs.xattrs, fs_data);
 out:
-	for (; xattr_count > 0; xattr_count--)
-		kfree(new_xattrs[xattr_count - 1].value);
-	kfree(new_xattrs);
+	for (; xattrs.xattr_count > 0; xattrs.xattr_count--)
+		kfree(xattrs.xattrs[xattrs.xattr_count - 1].value);
+	kfree(xattrs.xattrs);
 	return (ret == -EOPNOTSUPP) ? 0 : ret;
 }
 EXPORT_SYMBOL(security_inode_init_security);
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 1a713d96206f..6bba6b212e17 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2962,7 +2962,7 @@ static int selinux_dentry_create_files_as(struct dentry *dentry, int mode,
 
 static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 				       const struct qstr *qstr,
-				       struct xattr *xattrs, int *xattr_count)
+				       struct lsm_xattrs *xattrs)
 {
 	const struct cred_security_struct *crsec = selinux_cred(current_cred());
 	struct superblock_security_struct *sbsec;
@@ -2992,7 +2992,7 @@ static int selinux_inode_init_security(struct inode *inode, struct inode *dir,
 	    !(sbsec->flags & SBLABEL_MNT))
 		return -EOPNOTSUPP;
 
-	xattr = lsm_get_xattr_slot(xattrs, xattr_count);
+	xattr = lsm_get_xattr_slot(xattrs);
 	if (xattr) {
 		rc = security_sid_to_context_force(newsid,
 						   &context, &clen);
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index ff115068c5c0..4501078430ca 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -981,10 +981,10 @@ smk_rule_transmutes(struct smack_known *subject,
 }
 
 static int
-xattr_dupval(struct xattr *xattrs, int *xattr_count,
+xattr_dupval(struct lsm_xattrs *xattrs,
 	     const char *name, const void *value, unsigned int vallen)
 {
-	struct xattr * const xattr = lsm_get_xattr_slot(xattrs, xattr_count);
+	struct xattr * const xattr = lsm_get_xattr_slot(xattrs);
 
 	if (!xattr)
 		return 0;
@@ -1003,14 +1003,13 @@ xattr_dupval(struct xattr *xattrs, int *xattr_count,
  * @inode: the newly created inode
  * @dir: containing directory object
  * @qstr: unused
- * @xattrs: where to put the attributes
- * @xattr_count: current number of LSM-provided xattrs (updated)
+ * @xattrs: where to put attributes and update count
  *
  * Returns 0 if it all works out, -ENOMEM if there's no memory
  */
 static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 				     const struct qstr *qstr,
-				     struct xattr *xattrs, int *xattr_count)
+				     struct lsm_xattrs *xattrs)
 {
 	struct task_smack *tsp = smack_cred(current_cred());
 	struct inode_smack * const issp = smack_inode(inode);
@@ -1057,21 +1056,19 @@ static int smack_inode_init_security(struct inode *inode, struct inode *dir,
 		if (S_ISDIR(inode->i_mode)) {
 			transflag = SMK_INODE_TRANSMUTE;
 
-			if (xattr_dupval(xattrs, xattr_count,
-				XATTR_SMACK_TRANSMUTE,
-				TRANS_TRUE,
-				TRANS_TRUE_SIZE
-			))
+			if (xattr_dupval(xattrs,
+					 XATTR_SMACK_TRANSMUTE,
+					 TRANS_TRUE,
+					 TRANS_TRUE_SIZE))
 				rc = -ENOMEM;
 		}
 	}
 
 	if (rc == 0)
-		if (xattr_dupval(xattrs, xattr_count,
-			    XATTR_SMACK_SUFFIX,
-			    issp->smk_inode->smk_known,
-		     strlen(issp->smk_inode->smk_known)
-		))
+		if (xattr_dupval(xattrs,
+				 XATTR_SMACK_SUFFIX,
+				 issp->smk_inode->smk_known,
+				 strlen(issp->smk_inode->smk_known)))
 			rc = -ENOMEM;
 instant_inode:
 	issp->smk_flags |= (SMK_INODE_INSTANT | transflag);
-- 
2.53.0


