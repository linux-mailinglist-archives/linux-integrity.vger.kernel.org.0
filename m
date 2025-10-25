Return-Path: <linux-integrity+bounces-7526-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5096BC09594
	for <lists+linux-integrity@lfdr.de>; Sat, 25 Oct 2025 18:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AA16A34E023
	for <lists+linux-integrity@lfdr.de>; Sat, 25 Oct 2025 16:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7723064A0;
	Sat, 25 Oct 2025 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zb9tm1cY"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F9D1E47CA;
	Sat, 25 Oct 2025 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761409086; cv=none; b=kOTcRO0creEmFkJz+kLfkNF0lifHawg9acWs5kb/7u/07lWMisfmlPNZfr66YRFi0txpRqyts2zXRU5p7X1QDbfqNXATAPuk7aQN4+b+b6I7jHc0e8lTkPlec6G9PdlBUBkNCav8Mqh4QsnWlracUsy/kHY/8g2ed54jXbAv/zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761409086; c=relaxed/simple;
	bh=7RUbxDK3uZi4QeCLWgS+4Pt/PG4aZFa3mYuS/G/lvwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U2Y3ANsiPx7mDJSIf1bx2WtUYmuNsLdShW815Byb7fCTEOZeVOw+PgX5BhMFKv2+U7U9TW/Wx39Jva+/9xYBgqLmrUHbdINPZKWhYh38zaeovW0ZNMwEDXxYe2TGccE+Ame/VtvJZ91VNZwJ2TRNxgwjc+xxONR/0PmF8ZljMJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zb9tm1cY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C141C4CEFB;
	Sat, 25 Oct 2025 16:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761409086;
	bh=7RUbxDK3uZi4QeCLWgS+4Pt/PG4aZFa3mYuS/G/lvwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Zb9tm1cYY4pDXuKYiKFMEDcW/NUK3d6rFUurxHpHRcJY/pWxj7PEjIwr/hNsknVnc
	 4weRDut1gxdOwgfimxkNnNjPzIWepu+JWggqnoU4RnQMpk4TUUDpCXT/iPv2evABeA
	 6ZyT/NtrcnCV31ymnCTYdP3nlB/ucBgMttGqEK4VA4WJl/0BnE+eka9TwAEj/wDVxm
	 YaOsuyJIczsMBC1ljPIT+Nmy8bzeFO4C1LyLymhf5XKKtgRGyUcS9ZrTRnaVeno0m5
	 9NIfeykiU4UbWBaaHUjirNpqLjTzQXlTiy1TShWFa75P69UYwp5e9zrjBMjv52eVqb
	 KEUEDoVGyis9A==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Coiby Xu <coxu@redhat.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	linux-integrity@vger.kernel.org
Subject: [PATCH AUTOSEL 6.17-6.6] ima: don't clear IMA_DIGSIG flag when setting or removing non-IMA xattr
Date: Sat, 25 Oct 2025 11:57:08 -0400
Message-ID: <20251025160905.3857885-197-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025160905.3857885-1-sashal@kernel.org>
References: <20251025160905.3857885-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.17.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Coiby Xu <coxu@redhat.com>

[ Upstream commit 88b4cbcf6b041ae0f2fc8a34554a5b6a83a2b7cd ]

Currently when both IMA and EVM are in fix mode, the IMA signature will
be reset to IMA hash if a program first stores IMA signature in
security.ima and then writes/removes some other security xattr for the
file.

For example, on Fedora, after booting the kernel with "ima_appraise=fix
evm=fix ima_policy=appraise_tcb" and installing rpm-plugin-ima,
installing/reinstalling a package will not make good reference IMA
signature generated. Instead IMA hash is generated,

    # getfattr -m - -d -e hex /usr/bin/bash
    # file: usr/bin/bash
    security.ima=0x0404...

This happens because when setting security.selinux, the IMA_DIGSIG flag
that had been set early was cleared. As a result, IMA hash is generated
when the file is closed.

Similarly, IMA signature can be cleared on file close after removing
security xattr like security.evm or setting/removing ACL.

Prevent replacing the IMA file signature with a file hash, by preventing
the IMA_DIGSIG flag from being reset.

Here's a minimal C reproducer which sets security.selinux as the last
step which can also replaced by removing security.evm or setting ACL,

    #include <stdio.h>
    #include <sys/xattr.h>
    #include <fcntl.h>
    #include <unistd.h>
    #include <string.h>
    #include <stdlib.h>

    int main() {
        const char* file_path = "/usr/sbin/test_binary";
        const char* hex_string = "030204d33204490066306402304";
        int length = strlen(hex_string);
        char* ima_attr_value;
        int fd;

        fd = open(file_path, O_WRONLY|O_CREAT|O_EXCL, 0644);
        if (fd == -1) {
            perror("Error opening file");
            return 1;
        }

        ima_attr_value = (char*)malloc(length / 2 );
        for (int i = 0, j = 0; i < length; i += 2, j++) {
            sscanf(hex_string + i, "%2hhx", &ima_attr_value[j]);
        }

        if (fsetxattr(fd, "security.ima", ima_attr_value, length/2, 0) == -1) {
            perror("Error setting extended attribute");
            close(fd);
            return 1;
        }

        const char* selinux_value= "system_u:object_r:bin_t:s0";
        if (fsetxattr(fd, "security.selinux", selinux_value, strlen(selinux_value), 0) == -1) {
            perror("Error setting extended attribute");
            close(fd);
            return 1;
        }

        close(fd);

        return 0;
    }

Signed-off-by: Coiby Xu <coxu@redhat.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

YES – this is a focused bug fix that should go to stable.

- The core issue is that `ima_reset_appraise_flags()` used to treat the
  `digsig` argument as boolean, so any non-IMA xattr update passed the
  default `0` and cleared `IMA_DIGSIG`, triggering `ima_update_xattr()`
  to overwrite an existing signature with a hash in fix mode (see
  `security/integrity/ima/ima_appraise.c:628-646`). The reported Fedora
  reproducer shows this breaks IMA/EVM deployments running
  `ima_appraise=fix`.
- The patch makes `digsig` tri-state: `ima_reset_appraise_flags()` now
  only toggles the bit when given `0`/`1`, leaving it untouched for `-1`
  (`security/integrity/ima/ima_appraise.c:706-721`). All non-IMA paths
  (generic xattrs, ACL set/remove, non-IMA removals) now pass `-1`, so
  they still force re-appraisal via `IMA_CHANGE_XATTR` but stop
  clobbering the signature
  (`security/integrity/ima/ima_appraise.c:788-835`).
- Actual signature operations keep their old behavior: setting
  `security.ima` still sets `IMA_DIGSIG`, and removing it still clears
  the flag (`security/integrity/ima/ima_appraise.c:793-835`), so there’s
  no functional change for legitimate signature updates or removals.
- I checked older releases (e.g. `v6.1`) and they still have the pre-
  patch boolean handling, so the regression affects long-term stable
  trees. No new APIs or dependencies are introduced; the change is
  confined to one file and keeps existing call sites in sync.
- Risk is low: the patch just stops clearing the digital-signature bit
  for unrelated xattr/ACL changes, which is precisely what breakage
  reports show is required. It preserves hash-update behavior for
  unsigned files and keeps the IMA/EVM synchronization logic intact.

Given the user-visible security impact (signed packages ending up with
only hashes) and the minimal, targeted fix, this commit is a strong
stable backport candidate. Suggested follow-up: validate on a stable
branch with `ima_appraise=fix evm=fix` to ensure reference signatures
persist across SELinux xattr/ACL churn.

 security/integrity/ima/ima_appraise.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index f435eff4667f8..5149ff4fd50d2 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -694,6 +694,15 @@ static int ima_protect_xattr(struct dentry *dentry, const char *xattr_name,
 	return 0;
 }
 
+/*
+ * ima_reset_appraise_flags - reset ima_iint_cache flags
+ *
+ * @digsig: whether to clear/set IMA_DIGSIG flag, tristate values
+ *          0: clear IMA_DIGSIG
+ *          1: set IMA_DIGSIG
+ *         -1: don't change IMA_DIGSIG
+ *
+ */
 static void ima_reset_appraise_flags(struct inode *inode, int digsig)
 {
 	struct ima_iint_cache *iint;
@@ -706,9 +715,9 @@ static void ima_reset_appraise_flags(struct inode *inode, int digsig)
 		return;
 	iint->measured_pcrs = 0;
 	set_bit(IMA_CHANGE_XATTR, &iint->atomic_flags);
-	if (digsig)
+	if (digsig == 1)
 		set_bit(IMA_DIGSIG, &iint->atomic_flags);
-	else
+	else if (digsig == 0)
 		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
 }
 
@@ -794,6 +803,8 @@ static int ima_inode_setxattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		digsig = (xvalue->type == EVM_IMA_XATTR_DIGSIG);
 	} else if (!strcmp(xattr_name, XATTR_NAME_EVM) && xattr_value_len > 0) {
 		digsig = (xvalue->type == EVM_XATTR_PORTABLE_DIGSIG);
+	} else {
+		digsig = -1;
 	}
 	if (result == 1 || evm_revalidate_status(xattr_name)) {
 		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
@@ -807,7 +818,7 @@ static int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 			     const char *acl_name, struct posix_acl *kacl)
 {
 	if (evm_revalidate_status(acl_name))
-		ima_reset_appraise_flags(d_backing_inode(dentry), 0);
+		ima_reset_appraise_flags(d_backing_inode(dentry), -1);
 
 	return 0;
 }
@@ -815,11 +826,13 @@ static int ima_inode_set_acl(struct mnt_idmap *idmap, struct dentry *dentry,
 static int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry *dentry,
 				 const char *xattr_name)
 {
-	int result;
+	int result, digsig = -1;
 
 	result = ima_protect_xattr(dentry, xattr_name, NULL, 0);
 	if (result == 1 || evm_revalidate_status(xattr_name)) {
-		ima_reset_appraise_flags(d_backing_inode(dentry), 0);
+		if (!strcmp(xattr_name, XATTR_NAME_IMA))
+			digsig = 0;
+		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
 		if (result == 1)
 			result = 0;
 	}
-- 
2.51.0


