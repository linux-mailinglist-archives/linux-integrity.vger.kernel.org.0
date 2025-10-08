Return-Path: <linux-integrity+bounces-7397-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA53BC4A32
	for <lists+linux-integrity@lfdr.de>; Wed, 08 Oct 2025 13:55:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D8CD19E0EDD
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Oct 2025 11:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984F92F4A0A;
	Wed,  8 Oct 2025 11:55:09 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3200E2EC542;
	Wed,  8 Oct 2025 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759924509; cv=none; b=PPH9bdEFNbaywqKsgIJfTwSejQJr+ur+5P6eN4hLTRh/t7BYTSJ945OtyrDZRCmRmm3bgLSUmD+LN1EucHAPT+9sF1Yh5QSEhoavaOQJU7GQ0dCGNqy5rFnS0inWWgjSUFTc26ScDI+v+nWaBD7NMYPfDGIOOdAM9sk9sKeCKKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759924509; c=relaxed/simple;
	bh=8TrVwN/q3Nk7L6pUZrAiLWRdDBPrOqJoGid4/qG/l4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ivjGEPPco37agiTqX66Xwt1srzs5TTlAEbOOeb6gzMUH7jhiJ8MVXfyb5cNLT4MwXkMNF9ruTgT5ZKvVktnbebMqRVD0YX9nxw1s5crrij4tzZSGRlNI+5kW2z8f6AgSCLV6BEr8A6x9VggnXeZKPg9PkzArPbJ1EM/pIsbpRnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4chWCr5tnXzpSvj;
	Wed,  8 Oct 2025 19:35:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 4367B1402DA;
	Wed,  8 Oct 2025 19:36:15 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCXsJKkTOZoNH9JAQ--.56566S2;
	Wed, 08 Oct 2025 12:36:14 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Matthew Garrett <mjg59@srcf.ucam.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Jann Horn <jannh@google.com>,
	Christian Brauner <brauner@kernel.org>,
	Kees Cook <keescook@chromium.org>
Subject: [PATCH] ima: Attach CREDS_CHECK IMA hook to bprm_creds_from_file LSM hook
Date: Wed,  8 Oct 2025 13:35:03 +0200
Message-ID: <20251008113503.2433343-1-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:GxC2BwCXsJKkTOZoNH9JAQ--.56566S2
X-Coremail-Antispam: 1UD129KBjvJXoWxtFWxKw13JryxtryrXw4rAFb_yoW7tr1rpa
	9agay5JrWDGF1xCr1fGa17ZF1Sk3yrJrW3WF9Ig3s5Zas8Ar10vrWaqFn0vFy5JryFy3Zr
	t3ya9rW7Aa4qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvFb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAa
	w2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AK
	xVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvj
	xUF1v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAPBGjmC20DGgAAs4

From: Roberto Sassu <roberto.sassu@huawei.com>

Since commit 56305aa9b6fa ("exec: Compute file based creds only once"), the
credentials to be applied to the process after execution are not calculated
anymore for each step of finding intermediate interpreters (including the
final binary), but only after the final binary to be executed without
interpreter has been found.

In particular, that means that the bprm_check_security LSM hook will not
see the updated cred->e[ug]id for the intermediate and for the final binary
to be executed, since the function doing this task has been moved from
prepare_binprm(), which calls the bprm_check_security hook, to
bprm_creds_from_file().

This breaks the IMA expectation for the CREDS_CHECK hook, introduced with
commit d906c10d8a31 ("IMA: Support using new creds in appraisal policy"),
which expects to evaluate "the credentials that will be committed when the
new process is started". This is clearly not the case for the CREDS_CHECK
IMA hook, which is attached to bprm_check_security.

This issue does not affect systems which load a policy with the BPRM_CHECK
hook with no other criteria, as is the case with the built-in "tcb" and/or
"appraise_tcb" IMA policies. The "tcb" built-in policy measures all
executions regardless of the new credentials, and the "appraise_tcb" policy
is written in terms of the file owner, rather than IMA hooks.

However, it does affect systems without a BPRM_CHECK policy rule or with a
BPRM_CHECK policy rule that does not include what CREDS_CHECK evaluates. As
an extreme example, taking a standalone rule like:

measure func=CREDS_CHECK euid=0

This will not measure for example sudo (because CREDS_CHECK still sees the
bprm->cred->euid set to the regular user UID), but only the subsequent
commands after the euid was applied to the children.

Make set[ug]id programs measured/appraised again by splitting
ima_bprm_check() in two separate hook implementations (CREDS_CHECK now
being implemented by ima_creds_check()), and by attaching CREDS_CHECK to
the bprm_creds_from_file LSM hook.

The limitation of this approach is that CREDS_CHECK will not be invoked
anymore for the intermediate interpreters, like it was before, but only for
the final binary. This limitation can be removed only by reverting commit
56305aa9b6fa ("exec: Compute file based creds only once").

Link: https://github.com/linux-integrity/linux/issues/3
Fixes: 56305aa9b6fa ("exec: Compute file based creds only once")
Cc: Serge E. Hallyn <serge@hallyn.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Jann Horn <jannh@google.com>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Kees Cook <keescook@chromium.org>
Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_main.c | 42 ++++++++++++++++++++++++-------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index cdd225f65a62..ebaebccfbe9a 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -573,18 +573,41 @@ static int ima_file_mprotect(struct vm_area_struct *vma, unsigned long reqprot,
  */
 static int ima_bprm_check(struct linux_binprm *bprm)
 {
-	int ret;
 	struct lsm_prop prop;
 
 	security_current_getlsmprop_subj(&prop);
-	ret = process_measurement(bprm->file, current_cred(),
-				  &prop, NULL, 0, MAY_EXEC, BPRM_CHECK);
-	if (ret)
-		return ret;
-
-	security_cred_getlsmprop(bprm->cred, &prop);
-	return process_measurement(bprm->file, bprm->cred, &prop, NULL, 0,
-				   MAY_EXEC, CREDS_CHECK);
+	return process_measurement(bprm->file, current_cred(),
+				   &prop, NULL, 0, MAY_EXEC, BPRM_CHECK);
+}
+
+/**
+ * ima_creds_check - based on policy, collect/store measurement.
+ * @bprm: contains the linux_binprm structure
+ * @file: contains the file descriptor of the binary being executed
+ *
+ * The OS protects against an executable file, already open for write,
+ * from being executed in deny_write_access() and an executable file,
+ * already open for execute, from being modified in get_write_access().
+ * So we can be certain that what we verify and measure here is actually
+ * what is being executed.
+ *
+ * The difference from ima_bprm_check() is that ima_creds_check() is invoked
+ * only after determining the final binary to be executed without interpreter,
+ * and not when searching for intermediate binaries. The reason is that since
+ * commit 56305aa9b6fab ("exec: Compute file based creds only once"), the
+ * credentials to be applied to the process are calculated only at that stage
+ * (bprm_creds_from_file security hook instead of bprm_check_security).
+ *
+ * On success return 0.  On integrity appraisal error, assuming the file
+ * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
+ */
+static int ima_creds_check(struct linux_binprm *bprm, const struct file *file)
+{
+	struct lsm_prop prop;
+
+	security_current_getlsmprop_subj(&prop);
+	return process_measurement((struct file *)file, bprm->cred, &prop, NULL,
+				   0, MAY_EXEC, CREDS_CHECK);
 }
 
 /**
@@ -1242,6 +1265,7 @@ static int __init init_ima(void)
 static struct security_hook_list ima_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(bprm_check_security, ima_bprm_check),
 	LSM_HOOK_INIT(bprm_creds_for_exec, ima_bprm_creds_for_exec),
+	LSM_HOOK_INIT(bprm_creds_from_file, ima_creds_check),
 	LSM_HOOK_INIT(file_post_open, ima_file_check),
 	LSM_HOOK_INIT(inode_post_create_tmpfile, ima_post_create_tmpfile),
 	LSM_HOOK_INIT(file_release, ima_file_free),
-- 
2.43.0


