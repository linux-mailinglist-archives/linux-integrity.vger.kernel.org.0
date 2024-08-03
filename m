Return-Path: <linux-integrity+bounces-3261-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 029369467AC
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Aug 2024 08:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2401E1C20D00
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Aug 2024 06:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA1214F11D;
	Sat,  3 Aug 2024 06:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="n17SCVDc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ECCF14D2AC;
	Sat,  3 Aug 2024 06:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722665330; cv=none; b=TunKwRrc83vpI5qSaA5YO+aKEaGVNBb5z+mmh4nPo7lvgyHFBmkAjXvSyi/M+1Ot9kRMO4XMv5iBsQzGOeqsTYJyepScHZ5kD+GuC2cOx736BKmiGklMcuA42xbLs+86+05GBbyQbTYBCsRA5wIBwL8BztPI4Lp6fGETlk/BoD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722665330; c=relaxed/simple;
	bh=sy6NBm7410TH9PETxs9BxIS8V23ww+2VGqUQ4Q/m2J8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=eLmuEj4y9+SBnD9PUhqWWyWSfK5Y2tRrZzBoL7JzmPY3gSU2VWOeJqXr5ZytwwIh/DaIxSgCC3zSeuQ3dyFlxeleGmeXxGuzShlY823puZQJ36qNx9eY9mrsHi8JcWnNUWLeEsyBALfeKpKeebVO3VITBn+BvE9Dl25NpfUqgwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=n17SCVDc; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id DC99320B7408; Fri,  2 Aug 2024 23:08:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DC99320B7408
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722665320;
	bh=NRI1M+kKAFqAQzE8ALTQyDtvYuEm+/cmnGvSKIeyRtE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n17SCVDc/JwtiGPtabmPLUEapLxp3EvP8yX7jQM7xWF6xFhTpMxAPq26IjWADfufp
	 pwVXr0o5JIVzBqVsN1Kl6y0SNqk8oGlT2IoDoejA4GtuqrFAGgOk2i+cVOkqMeYRHH
	 V0RT3NU/PwzahX6B/zPw03MSoQU/1pNpgmVxz/r4=
From: Fan Wu <wufan@linux.microsoft.com>
To: corbet@lwn.net,
	zohar@linux.ibm.com,
	jmorris@namei.org,
	serge@hallyn.com,
	tytso@mit.edu,
	ebiggers@kernel.org,
	axboe@kernel.dk,
	agk@redhat.com,
	snitzer@kernel.org,
	mpatocka@redhat.com,
	eparis@redhat.com,
	paul@paul-moore.com
Cc: linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	fsverity@lists.linux.dev,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	audit@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Fan Wu <wufan@linux.microsoft.com>
Subject: [PATCH v20 14/20] security: add security_inode_setintegrity() hook
Date: Fri,  2 Aug 2024 23:08:28 -0700
Message-Id: <1722665314-21156-15-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
References: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

This patch introduces a new hook to save inode's integrity
data. For example, for fsverity enabled files, LSMs can use this hook to
save the existence of verified fsverity builtin signature into the inode's
security blob, and LSMs can make access decisions based on this data.

Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

--
v1-v14:
  + Not present

v15:
  + Introduced

v16:
  + Switch to call_int_hook()

v17:
  + Fix a typo

v18:
  + No changes

v19:
  + Refactor hook declaration

v20:
  + No changes
---
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      | 10 ++++++++++
 security/security.c           | 20 ++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 909cf6f4b9fe..3c82d4e37ec8 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -179,6 +179,8 @@ LSM_HOOK(void, LSM_RET_VOID, inode_getsecid, struct inode *inode, u32 *secid)
 LSM_HOOK(int, 0, inode_copy_up, struct dentry *src, struct cred **new)
 LSM_HOOK(int, -EOPNOTSUPP, inode_copy_up_xattr, struct dentry *src,
 	 const char *name)
+LSM_HOOK(int, 0, inode_setintegrity, const struct inode *inode,
+	 enum lsm_integrity_type type, const void *value, size_t size)
 LSM_HOOK(int, 0, kernfs_init_security, struct kernfs_node *kn_dir,
 	 struct kernfs_node *kn)
 LSM_HOOK(int, 0, file_permission, struct file *file, int mask)
diff --git a/include/linux/security.h b/include/linux/security.h
index 0604893f2f9e..e0adf599efe4 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -410,6 +410,9 @@ int security_inode_listsecurity(struct inode *inode, char *buffer, size_t buffer
 void security_inode_getsecid(struct inode *inode, u32 *secid);
 int security_inode_copy_up(struct dentry *src, struct cred **new);
 int security_inode_copy_up_xattr(struct dentry *src, const char *name);
+int security_inode_setintegrity(const struct inode *inode,
+				enum lsm_integrity_type type, const void *value,
+				size_t size);
 int security_kernfs_init_security(struct kernfs_node *kn_dir,
 				  struct kernfs_node *kn);
 int security_file_permission(struct file *file, int mask);
@@ -1026,6 +1029,13 @@ static inline int security_inode_copy_up(struct dentry *src, struct cred **new)
 	return 0;
 }
 
+static inline int security_inode_setintegrity(const struct inode *inode,
+					      enum lsm_integrity_type type,
+					      const void *value, size_t size)
+{
+	return 0;
+}
+
 static inline int security_kernfs_init_security(struct kernfs_node *kn_dir,
 						struct kernfs_node *kn)
 {
diff --git a/security/security.c b/security/security.c
index 9baab988be7b..39841ec33ab7 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2708,6 +2708,26 @@ int security_inode_copy_up_xattr(struct dentry *src, const char *name)
 }
 EXPORT_SYMBOL(security_inode_copy_up_xattr);
 
+/**
+ * security_inode_setintegrity() - Set the inode's integrity data
+ * @inode: inode
+ * @type: type of integrity, e.g. hash digest, signature, etc
+ * @value: the integrity value
+ * @size: size of the integrity value
+ *
+ * Register a verified integrity measurement of a inode with LSMs.
+ * LSMs should free the previously saved data if @value is NULL.
+ *
+ * Return: Returns 0 on success, negative values on failure.
+ */
+int security_inode_setintegrity(const struct inode *inode,
+				enum lsm_integrity_type type, const void *value,
+				size_t size)
+{
+	return call_int_hook(inode_setintegrity, inode, type, value, size);
+}
+EXPORT_SYMBOL(security_inode_setintegrity);
+
 /**
  * security_kernfs_init_security() - Init LSM context for a kernfs node
  * @kn_dir: parent kernfs node
-- 
2.44.0


