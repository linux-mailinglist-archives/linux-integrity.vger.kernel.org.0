Return-Path: <linux-integrity+bounces-3235-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F08F93AACE
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jul 2024 03:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4499E284213
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jul 2024 01:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21E09BA47;
	Wed, 24 Jul 2024 01:57:04 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D14A1171C;
	Wed, 24 Jul 2024 01:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721786224; cv=none; b=GMrPaToXtqaTbumDupcCAmxMyJkEkU9P7PWmX+fTJ1u2dGBlhVinWinGHyIsTpkmENc8h1uQd6VNDncqTpASMISXl5Q1t/VIaytXCdRzgd+p7mjek9Gh+hjKIAvBbxyT8BdZkLAh6DlUAETvZxeRnK7VtSl16ddevQTFvGrmrh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721786224; c=relaxed/simple;
	bh=WJWRcqsesXwYwAt1BcpzmR0xuMOTS3AEdFL6VnirlvM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c+yISQdOC4QbwYp1OLAy3Oxbr9kXQY33kDKK/721+miPjtKw5YtZkQxgyPmD1VYEmi3jPcXPBjVlTHde3yfj13vJ59wzdq2Vo9WGdKfY3d1GYyqCU8LRuDp6U9FW6ZNXfIWryDk2dmiNDoNpxRmpJ09l6NdSi1Y8WPI99DG3AdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WTHF24TVdz4f3kw5;
	Wed, 24 Jul 2024 09:56:38 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 2EF6D1A190F;
	Wed, 24 Jul 2024 09:56:52 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP1 (Coremail) with SMTP id cCh0CgDXw3VgX6BmaKTZAw--.12072S4;
	Wed, 24 Jul 2024 09:56:51 +0800 (CST)
From: Xu Kuohai <xukuohai@huaweicloud.com>
To: linux-security-module@vger.kernel.org,
	selinux@vger.kernel.org,
	linux-unionfs@vger.kernel.org,
	linux-integrity@vger.kernel.org
Cc: Paul Moore <paul@paul-moore.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	James Morris <jmorris@namei.org>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Snowberg <eric.snowberg@oracle.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>,
	Ondrej Mosnacek <omosnace@redhat.com>
Subject: [PATCH v1 2/2] lsm: Refactor return value of LSM hook inode_copy_up_xattr
Date: Wed, 24 Jul 2024 10:06:59 +0800
Message-Id: <20240724020659.120353-3-xukuohai@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240724020659.120353-1-xukuohai@huaweicloud.com>
References: <20240724020659.120353-1-xukuohai@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDXw3VgX6BmaKTZAw--.12072S4
X-Coremail-Antispam: 1UD129KBjvJXoWxAw1kXF4DJFWkXFWrJF1fJFb_yoWrZF1fpa
	1Dtan2qr1rJFy7XFykJa17ua1F93yrGFWUC39xuw12kFZ3Xrs3Wryayr12kr45Wry8JF4v
	qanFvrs8C3W5t3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUFSdy
	UUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

To be consistent with most LSM hooks, convert the return value of
hook inode_copy_up_xattr to 0 or a negative error code.

Before:
- Hook inode_copy_up_xattr returns 0 when accepting xattr, 1 when
  discarding xattr, -EOPNOTSUPP if it does not know xattr, or any
  other negative error code otherwise.

After:
- Hook inode_copy_up_xattr returns 0 when accepting xattr, *-ECANCELED*
  when discarding xattr, -EOPNOTSUPP if it does not know xattr, or
  any other negative error code otherwise.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 fs/overlayfs/copy_up.c            |  6 +++---
 security/integrity/evm/evm_main.c |  2 +-
 security/security.c               | 11 +++--------
 security/selinux/hooks.c          |  4 ++--
 security/smack/smack_lsm.c        |  6 +++---
 5 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index a5ef2005a2cc..337a5be99ac9 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -115,12 +115,12 @@ int ovl_copy_xattr(struct super_block *sb, const struct path *oldpath, struct de
 			continue;
 
 		error = security_inode_copy_up_xattr(old, name);
-		if (error < 0 && error != -EOPNOTSUPP)
-			break;
-		if (error == 1) {
+		if (error == -ECANCELED) {
 			error = 0;
 			continue; /* Discard */
 		}
+		if (error < 0 && error != -EOPNOTSUPP)
+			break;
 
 		if (is_posix_acl_xattr(name)) {
 			error = ovl_copy_acl(OVL_FS(sb), oldpath, new, name);
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 62fe66dd53ce..6924ed508ebd 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -1000,7 +1000,7 @@ static int evm_inode_copy_up_xattr(struct dentry *src, const char *name)
 	case EVM_XATTR_HMAC:
 	case EVM_IMA_XATTR_DIGSIG:
 	default:
-		rc = 1; /* discard */
+		rc = -ECANCELED; /* discard */
 	}
 
 	kfree(xattr_data);
diff --git a/security/security.c b/security/security.c
index ff5cca992ee1..ca93d43ad475 100644
--- a/security/security.c
+++ b/security/security.c
@@ -2760,19 +2760,14 @@ EXPORT_SYMBOL(security_inode_copy_up);
  * lower layer to the union/overlay layer.   The caller is responsible for
  * reading and writing the xattrs, this hook is merely a filter.
  *
- * Return: Returns 0 to accept the xattr, 1 to discard the xattr, -EOPNOTSUPP
- *         if the security module does not know about attribute, or a negative
- *         error code to abort the copy up.
+ * Return: Returns 0 to accept the xattr, -ECANCELED to discard the xattr,
+ *         -EOPNOTSUPP if the security module does not know about attribute,
+ *         or a negative error code to abort the copy up.
  */
 int security_inode_copy_up_xattr(struct dentry *src, const char *name)
 {
 	int rc;
 
-	/*
-	 * The implementation can return 0 (accept the xattr), 1 (discard the
-	 * xattr), -EOPNOTSUPP if it does not know anything about the xattr or
-	 * any other error code in case of an error.
-	 */
 	rc = call_int_hook(inode_copy_up_xattr, src, name);
 	if (rc != LSM_RET_DEFAULT(inode_copy_up_xattr))
 		return rc;
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index af7467cdd181..81fbfa5b80d4 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3531,8 +3531,8 @@ static int selinux_inode_copy_up_xattr(struct dentry *dentry, const char *name)
 	 * xattrs up.  Instead, filter out SELinux-related xattrs following
 	 * policy load.
 	 */
-	if (selinux_initialized() && strcmp(name, XATTR_NAME_SELINUX) == 0)
-		return 1; /* Discard */
+	if (selinux_initialized() && !strcmp(name, XATTR_NAME_SELINUX))
+		return -ECANCELED; /* Discard */
 	/*
 	 * Any other attribute apart from SELINUX is not claimed, supported
 	 * by selinux.
diff --git a/security/smack/smack_lsm.c b/security/smack/smack_lsm.c
index b0e0205a5724..09ff7f24c0c6 100644
--- a/security/smack/smack_lsm.c
+++ b/security/smack/smack_lsm.c
@@ -4902,10 +4902,10 @@ static int smack_inode_copy_up(struct dentry *dentry, struct cred **new)
 static int smack_inode_copy_up_xattr(struct dentry *src, const char *name)
 {
 	/*
-	 * Return 1 if this is the smack access Smack attribute.
+	 * Return -ECANCELED if this is the smack access Smack attribute.
 	 */
-	if (strcmp(name, XATTR_NAME_SMACK) == 0)
-		return 1;
+	if (!strcmp(name, XATTR_NAME_SMACK))
+		return -ECANCELED;
 
 	return -EOPNOTSUPP;
 }
-- 
2.39.2


