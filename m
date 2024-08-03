Return-Path: <linux-integrity+bounces-3257-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1851694679A
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Aug 2024 08:09:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C01F91C20C6A
	for <lists+linux-integrity@lfdr.de>; Sat,  3 Aug 2024 06:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CAE14D457;
	Sat,  3 Aug 2024 06:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WyWfsoKS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FDB13D8B6;
	Sat,  3 Aug 2024 06:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722665328; cv=none; b=Jm5b0GYEqTmSccm5vrqd7xfxFk/nzL9F8gtBbtAOF9+wPk6BIYJoIHpxTC2goYCkQ1krD3Blb1nLEuMok22Clp5Meo366O0yCSJJfIe3eXRhl0QOeV8MnR0l2bRdpUJFhzrqmUPkK5qFgNSsa/ljGMfYAbURSZpnDtz3fkjxcpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722665328; c=relaxed/simple;
	bh=FbbjoEJWtRg0tu+QiXU/sS7HGCx9RUDF461Ew5L3Diw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=rf1uWuFcfKGYAS0d6Ylan9a9Ddnob4NjNMJxGSAAnECkiZx5nkA8J/Ywsp7UC4MkZqufgf1kJt90KKHTd79hD+6LRJQcjpnvJylcAv6x2H0Aw7mL7Ei6hynBS4A+T9wM4hpekOxffdiPr3aGrueRErPJhrUhvYyAzLiSC/KHlmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WyWfsoKS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1052)
	id 5A23220B7009; Fri,  2 Aug 2024 23:08:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5A23220B7009
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1722665320;
	bh=+xwZZ0ZSndF+Fn5ZmGROZ4NabyOx7lvuqXUT/ULZVeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WyWfsoKSQTY9T+XUTCc59l1ZfTGTZlpgB8LtFU85TTSgG4fFWXE7j4dQh0r29X205
	 ewlBrBusBsVIov0LPoQkN40e44c2ULF8B/aPjwQCv7LUrhdyGptavGgh/wfZN9q6dM
	 dJYC0iTUama/HwD3nue6f5GIDimqGTsnfFWxLIHc=
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
Subject: [PATCH v20 05/20] initramfs|security: Add a security hook to do_populate_rootfs()
Date: Fri,  2 Aug 2024 23:08:19 -0700
Message-Id: <1722665314-21156-6-git-send-email-wufan@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
References: <1722665314-21156-1-git-send-email-wufan@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>

This patch introduces a new hook to notify security system that the
content of initramfs has been unpacked into the rootfs.

Upon receiving this notification, the security system can activate
a policy to allow only files that originated from the initramfs to
execute or load into kernel during the early stages of booting.

This approach is crucial for minimizing the attack surface by
ensuring that only trusted files from the initramfs are operational
in the critical boot phase.

Signed-off-by: Fan Wu <wufan@linux.microsoft.com>

---
v1-v11:
  + Not present

v12:
  + Introduced

v13:
  + Rename the hook name to initramfs_populated()

v14:
  + No changes

v15:
  + No changes

v16:
  + No changes

v17:
  + Fix ocumentation style issues

v18:
  + No changes

v19:
  + No changes

v20:
  + Move the hook call after the done tag in do_populate_rootfs()
---
 include/linux/lsm_hook_defs.h |  2 ++
 include/linux/security.h      |  8 ++++++++
 init/initramfs.c              |  3 +++
 security/security.c           | 10 ++++++++++
 4 files changed, 23 insertions(+)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 855db460e08b..078161e51bd9 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -452,3 +452,5 @@ LSM_HOOK(int, 0, uring_override_creds, const struct cred *new)
 LSM_HOOK(int, 0, uring_sqpoll, void)
 LSM_HOOK(int, 0, uring_cmd, struct io_uring_cmd *ioucmd)
 #endif /* CONFIG_IO_URING */
+
+LSM_HOOK(void, LSM_RET_VOID, initramfs_populated, void)
diff --git a/include/linux/security.h b/include/linux/security.h
index 1390f1efb4f0..a4ccaf1d7bd5 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -2256,4 +2256,12 @@ static inline int security_uring_cmd(struct io_uring_cmd *ioucmd)
 #endif /* CONFIG_SECURITY */
 #endif /* CONFIG_IO_URING */
 
+#ifdef CONFIG_SECURITY
+extern void security_initramfs_populated(void);
+#else
+static inline void security_initramfs_populated(void)
+{
+}
+#endif /* CONFIG_SECURITY */
+
 #endif /* ! __LINUX_SECURITY_H */
diff --git a/init/initramfs.c b/init/initramfs.c
index 814241b64827..bc911e466d5b 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -17,6 +17,7 @@
 #include <linux/namei.h>
 #include <linux/init_syscalls.h>
 #include <linux/umh.h>
+#include <linux/security.h>
 
 #include "do_mounts.h"
 
@@ -712,6 +713,8 @@ static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 	}
 
 done:
+	security_initramfs_populated();
+
 	/*
 	 * If the initrd region is overlapped with crashkernel reserved region,
 	 * free only memory that is not part of crashkernel region.
diff --git a/security/security.c b/security/security.c
index 8218c745d5e2..5126a3321a41 100644
--- a/security/security.c
+++ b/security/security.c
@@ -5704,3 +5704,13 @@ int security_uring_cmd(struct io_uring_cmd *ioucmd)
 	return call_int_hook(uring_cmd, ioucmd);
 }
 #endif /* CONFIG_IO_URING */
+
+/**
+ * security_initramfs_populated() - Notify LSMs that initramfs has been loaded
+ *
+ * Tells the LSMs the initramfs has been unpacked into the rootfs.
+ */
+void security_initramfs_populated(void)
+{
+	call_void_hook(initramfs_populated);
+}
-- 
2.44.0


