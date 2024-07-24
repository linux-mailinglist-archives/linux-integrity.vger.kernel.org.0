Return-Path: <linux-integrity+bounces-3234-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EB0A93AAC8
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jul 2024 03:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0422E28443B
	for <lists+linux-integrity@lfdr.de>; Wed, 24 Jul 2024 01:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE077EEAB;
	Wed, 24 Jul 2024 01:56:57 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CE8BA47;
	Wed, 24 Jul 2024 01:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721786217; cv=none; b=j0i5sE3TrzYqZVppx8WG6JBbbLXn4KFr7z1c6i9FQ4PgxkOs2SDnRQgCFJkYIlQO0h7rJXSzmavoSzPrBOj0wXbuwXL17k7hr5+B6iYOn/sz8ju3uCzI8k55M5ZX10uERFY5EifE/TDCqzuEI2MjJr/ZNFiTZ73C/enXnvOWINI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721786217; c=relaxed/simple;
	bh=5DRU7wCB037mq/JvSTnFtR6YaqJrWFenXiKBaslAv5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VjqgK/mopgR6tjONP7D+1JXiCltDyrqpO3If2UNsvomVi47q5I0S9Ju5j8KsJ4lVvge3FIcrVMFwK8RtTS+9xWD/8z5R+BHDE+YlcVWpSG55DdjQIHytGuGuewdfDEFw9w5hMlwXZaqWsIAefIt/xlzu2crO3RjjRk/O3a1bOEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WTHF34txPz4f3jsV;
	Wed, 24 Jul 2024 09:56:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 15F781A0359;
	Wed, 24 Jul 2024 09:56:52 +0800 (CST)
Received: from k01.huawei.com (unknown [10.67.174.197])
	by APP1 (Coremail) with SMTP id cCh0CgDXw3VgX6BmaKTZAw--.12072S3;
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
Subject: [PATCH v1 1/2] lsm: Refactor return value of LSM hook vm_enough_memory
Date: Wed, 24 Jul 2024 10:06:58 +0800
Message-Id: <20240724020659.120353-2-xukuohai@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgDXw3VgX6BmaKTZAw--.12072S3
X-Coremail-Antispam: 1UD129KBjvJXoWxur48GF1DAw17Kr47ur1rWFg_yoW7Gr1UpF
	4rKa13KrWvkFyxWrs7GanxC3W3t34fWF4UKrWUu34Fk3ZFvr17KF4UA3s0kr17trW8tasF
	qFW29rs3C3Wqq37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPFb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
	A2048vs2IY020Ec7CjxVAFwI0_Gr0_Xr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI
	0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG
	67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r4a6rW5MI
	IYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E
	14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJV
	W8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU2HGQ
	DUUUU
X-CM-SenderInfo: 50xn30hkdlqx5xdzvxpfor3voofrz/

From: Xu Kuohai <xukuohai@huawei.com>

To be consistent with most LSM hooks, convert the return value of
hook vm_enough_memory to 0 or a negative error code.

Before:
- Hook vm_enough_memory returns 1 if permission is granted, 0 if not.
- LSM_RET_DEFAULT(vm_enough_memory_mm) is 1.

After:
- Hook vm_enough_memory reutrns 0 if permission is granted, negative
  error code if not.
- LSM_RET_DEFAULT(vm_enough_memory_mm) is 0.

Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
---
 include/linux/lsm_hook_defs.h |  2 +-
 include/linux/security.h      |  2 +-
 security/commoncap.c          | 11 +++--------
 security/security.c           | 11 +++++------
 security/selinux/hooks.c      | 15 ++++-----------
 5 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.h
index 1d113a727098..06265e70013c 100644
--- a/include/linux/lsm_hook_defs.h
+++ b/include/linux/lsm_hook_defs.h
@@ -48,7 +48,7 @@ LSM_HOOK(int, 0, quota_on, struct dentry *dentry)
 LSM_HOOK(int, 0, syslog, int type)
 LSM_HOOK(int, 0, settime, const struct timespec64 *ts,
 	 const struct timezone *tz)
-LSM_HOOK(int, 1, vm_enough_memory, struct mm_struct *mm, long pages)
+LSM_HOOK(int, 0, vm_enough_memory, struct mm_struct *mm, long pages)
 LSM_HOOK(int, 0, bprm_creds_for_exec, struct linux_binprm *bprm)
 LSM_HOOK(int, 0, bprm_creds_from_file, struct linux_binprm *bprm, const struct file *file)
 LSM_HOOK(int, 0, bprm_check_security, struct linux_binprm *bprm)
diff --git a/include/linux/security.h b/include/linux/security.h
index 21cf70346b33..ed4deff36fff 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -634,7 +634,7 @@ static inline int security_settime64(const struct timespec64 *ts,
 
 static inline int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 {
-	return __vm_enough_memory(mm, pages, cap_vm_enough_memory(mm, pages));
+	return __vm_enough_memory(mm, pages, !cap_vm_enough_memory(mm, pages));
 }
 
 static inline int security_bprm_creds_for_exec(struct linux_binprm *bprm)
diff --git a/security/commoncap.c b/security/commoncap.c
index 162d96b3a676..cefad323a0b1 100644
--- a/security/commoncap.c
+++ b/security/commoncap.c
@@ -1396,17 +1396,12 @@ int cap_task_prctl(int option, unsigned long arg2, unsigned long arg3,
  * Determine whether the allocation of a new virtual mapping by the current
  * task is permitted.
  *
- * Return: 1 if permission is granted, 0 if not.
+ * Return: 0 if permission granted, negative error code if not.
  */
 int cap_vm_enough_memory(struct mm_struct *mm, long pages)
 {
-	int cap_sys_admin = 0;
-
-	if (cap_capable(current_cred(), &init_user_ns,
-				CAP_SYS_ADMIN, CAP_OPT_NOAUDIT) == 0)
-		cap_sys_admin = 1;
-
-	return cap_sys_admin;
+	return cap_capable(current_cred(), &init_user_ns, CAP_SYS_ADMIN,
+			   CAP_OPT_NOAUDIT);
 }
 
 /**
diff --git a/security/security.c b/security/security.c
index 12e402b7230f..ff5cca992ee1 100644
--- a/security/security.c
+++ b/security/security.c
@@ -1218,15 +1218,14 @@ int security_vm_enough_memory_mm(struct mm_struct *mm, long pages)
 	int rc;
 
 	/*
-	 * The module will respond with a positive value if
-	 * it thinks the __vm_enough_memory() call should be
-	 * made with the cap_sys_admin set. If all of the modules
-	 * agree that it should be set it will. If any module
-	 * thinks it should not be set it won't.
+	 * The module will respond with 0 if it thinks the __vm_enough_memory()
+	 * call should be made with the cap_sys_admin set. If all of the modules
+	 * agree that it should be set it will. If any module thinks it should
+	 * not be set it won't.
 	 */
 	lsm_for_each_hook(scall, vm_enough_memory) {
 		rc = scall->hl->hook.vm_enough_memory(mm, pages);
-		if (rc <= 0) {
+		if (rc < 0) {
 			cap_sys_admin = 0;
 			break;
 		}
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index 0939816e9671..af7467cdd181 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -2202,23 +2202,16 @@ static int selinux_syslog(int type)
 }
 
 /*
- * Check that a process has enough memory to allocate a new virtual
- * mapping. 0 means there is enough memory for the allocation to
- * succeed and -ENOMEM implies there is not.
+ * Check permission for allocating a new virtual mapping. Returns
+ * 0 if permission is granted, negative error code if not.
  *
  * Do not audit the selinux permission check, as this is applied to all
  * processes that allocate mappings.
  */
 static int selinux_vm_enough_memory(struct mm_struct *mm, long pages)
 {
-	int rc, cap_sys_admin = 0;
-
-	rc = cred_has_capability(current_cred(), CAP_SYS_ADMIN,
-				 CAP_OPT_NOAUDIT, true);
-	if (rc == 0)
-		cap_sys_admin = 1;
-
-	return cap_sys_admin;
+	return cred_has_capability(current_cred(), CAP_SYS_ADMIN,
+				   CAP_OPT_NOAUDIT, true);
 }
 
 /* binprm security operations */
-- 
2.39.2


