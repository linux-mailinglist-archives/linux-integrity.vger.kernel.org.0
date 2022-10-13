Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 061505FE577
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Oct 2022 00:38:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiJMWiu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Oct 2022 18:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiJMWif (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Oct 2022 18:38:35 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7532819C041
        for <linux-integrity@vger.kernel.org>; Thu, 13 Oct 2022 15:37:03 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id fw14so3272143pjb.3
        for <linux-integrity@vger.kernel.org>; Thu, 13 Oct 2022 15:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUjOn5k+MDTd5PUbkTwlrTScouGBjar5cnIPsWYV3Wg=;
        b=XGpcmGIGlJvbK+PB64IhAkNpyqWLSCW2DYyaXePgdi05Efu5gl3N0K/4rH7qa7wR2G
         NhgH5dEPf4bukJHrR7zvYZrFreOBcpgAzxeVjzSSwrYkx4aMtW4lC77LLu3BXkyNO5Mx
         WRVlvhh8AeS/RL37yp6cImouUfSHqHYIF71eE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BUjOn5k+MDTd5PUbkTwlrTScouGBjar5cnIPsWYV3Wg=;
        b=6LTSGDZSnSZz12v6Mc3clokEPUHpr2/bacVdL/FNpnII22fFzFogUsY0qqbjYQgx7m
         unw3PH68oe/gGi7hxDV2V9KUFzdX0JQobtNpkpvtfvQkPqyeOeKjIKHmWBreTzYifMx1
         tAryLuViU/JTKNXkarkTROwwfFgGG8bG8cZ94yaksySEwzDOS3o4GsveQjhas6bevdKF
         5TSGrL8Tm1GJ7MDjdL7kI73+O5SHxxHprZFrJm8DJlNa04JM5/4cDTWKLIOSIWRyT1Ud
         DRjEGNqzkIjczMbb5SYOjIf/1YI/JnkxFn/GK1F2T1NeW5v4xXExLJ7fmisWEc7Fuo7/
         WPPQ==
X-Gm-Message-State: ACrzQf1sce2bGSHfVdzmkQJKpBZ7FneRSAwdPlCD1I1rT5u/TPkuVdBe
        j2LdIkGNecwG2JQepZHTbC6CiA==
X-Google-Smtp-Source: AMsMyM7lmGE7iSzcgY7jgVxZ9Mj/vs91Xdkm9UEpv0CL1c5bc3mYipHsQLdJBURHMD2yFwzNrwyn2g==
X-Received: by 2002:a17:90b:180f:b0:20d:4e7f:5f52 with SMTP id lw15-20020a17090b180f00b0020d4e7f5f52mr13961271pjb.119.1665700622896;
        Thu, 13 Oct 2022 15:37:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902ce8800b00179eb1576bbsm322449plg.190.2022.10.13.15.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 15:37:00 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jonathan McDowell <noodles@fb.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 7/9] ima: Move ima_file_check() into LSM
Date:   Thu, 13 Oct 2022 15:36:52 -0700
Message-Id: <20221013223654.659758-7-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221013222702.never.990-kees@kernel.org>
References: <20221013222702.never.990-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5346; h=from:subject; bh=riUsZQZoVxlZeA/zVYk5CSKXRI6ewCrtesJchBkc+2o=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjSJMF+CD8myWrdyIkpdz8Alc9mimWJRlQS/0/dBUs QZL6Lr2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0iTBQAKCRCJcvTf3G3AJprMD/ 9DPdjF0nwZkAf61pNj44lk1w0pWPPsk+HTALzRGT8PvX4Qvtb+QPpOc+DSnxDdxsG1ExBqHxyr7PwY QKSjmLiFPdg77UH6m5Ifh8aXoRh7/Go0JSkxa8fLFjiuyqCzHSg5qsNwlUgGDuF+1tq/Obcl5272w0 zfvSXVlJxLxilUYRIm8jBLu5sQt9sFpBh2v4OlCdwo9Yfd2iP6wRBOY3XHSFQ6WNhPZkCPFQ/2eaCe aOHcJzozEs+UJ3k8VpfAybP2MK6ULPjPHEq7Nn+89BLF0DhnQLFKPoTqpG87NbtJuEHwcvKuPaqsjK epfWQ5HPx/WUNCbCPLkWrG3RJ5aYI/ZdHoWrhEGwPLILXvGO1xMyfgONsq3O89wwqROU95CEal7mqm 0bNbFa+3i1Qr7rHNNb7pXMtjr4H21i9/Uds+CZSMWkqaD/VLq1ahOxnoRHRuP8b4EpjZjUZxJY5XJp gro3IQrX94VDspAGt+cbC94kD5veVUHLyK0K3KyFbpc2vAvsmPP9XzupgcI84gEE0Voobxv4bGcBDU qJ+a7mbzxlbv9e3e2rzF9Twie6YgFoYm5r2iGk1VuNy88PEpTY28MpO474gixLp0ejVmwclt4uriEa PZzfyuo3/VsLdMZ3MrVpZ6/Y/jhjTOD9IPJdoIQq/LAwm+ES2ll6ez08qjfg==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The "file_open" hook in the LSM is the correct place to add the
ima_file_check() callback. Rename it to ima_file_open(), and use the
newly created helper to construct the permissions mask from the file
flags and fmode.

For reference, the LSM hooks across an open are:

    do_filp_open(dfd, filename, open_flags)
        path_openat(nameidata, open_flags, flags)
            file = alloc_empty_file(open_flags, current_cred());
            do_open(nameidata, file, open_flags)
                may_open(path, acc_mode, open_flag)
                    inode_permission(inode, MAY_OPEN | acc_mode)
---->                   security_inode_permission(inode, acc_mode)
                vfs_open(path, file)
                    do_dentry_open(file, path->dentry->d_inode, open)
---->                   security_file_open(f)
                        open()

The open-coded hook in the VFS and NFS are removed, as they are fully
covered by the security_file_open() hook.

Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Jonathan McDowell <noodles@fb.com>
Cc: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/namei.c                        |  2 --
 fs/nfsd/vfs.c                     |  6 ------
 include/linux/ima.h               |  6 ------
 security/integrity/ima/ima_main.c | 14 +++++++-------
 4 files changed, 7 insertions(+), 21 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 53b4bc094db2..d9bd3887e823 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3555,8 +3555,6 @@ static int do_open(struct nameidata *nd,
 	error = may_open(mnt_userns, &nd->path, acc_mode, open_flag);
 	if (!error && !(file->f_mode & FMODE_OPENED))
 		error = vfs_open(&nd->path, file);
-	if (!error)
-		error = ima_file_check(file, op->acc_mode);
 	if (!error && do_truncate)
 		error = handle_truncate(mnt_userns, file);
 	if (unlikely(error > 0)) {
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 9f486b788ed0..33fe326272df 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -762,12 +762,6 @@ __nfsd_open(struct svc_rqst *rqstp, struct svc_fh *fhp, umode_t type,
 		goto out_nfserr;
 	}
 
-	host_err = ima_file_check(file, may_flags);
-	if (host_err) {
-		fput(file);
-		goto out_nfserr;
-	}
-
 	if (may_flags & NFSD_MAY_64BIT_COOKIE)
 		file->f_mode |= FMODE_64BITHASH;
 	else
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 70180b9bd974..cf1e48a2d97d 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -16,7 +16,6 @@ struct linux_binprm;
 
 #ifdef CONFIG_IMA
 extern enum hash_algo ima_get_current_hash_algo(void);
-extern int ima_file_check(struct file *file, int mask);
 extern void ima_post_create_tmpfile(struct user_namespace *mnt_userns,
 				    struct inode *inode);
 extern void ima_post_path_mknod(struct user_namespace *mnt_userns,
@@ -45,11 +44,6 @@ static inline enum hash_algo ima_get_current_hash_algo(void)
 	return HASH_ALGO__LAST;
 }
 
-static inline int ima_file_check(struct file *file, int mask)
-{
-	return 0;
-}
-
 static inline void ima_post_create_tmpfile(struct user_namespace *mnt_userns,
 					   struct inode *inode)
 {
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index ffebd3236f24..823d660b53ec 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -12,7 +12,7 @@
  *
  * File: ima_main.c
  *	implements the IMA hooks: ima_bprm_check, ima_file_mmap,
- *	and ima_file_check.
+ *	and ima_file_open.
  */
 
 #include <linux/module.h>
@@ -504,25 +504,24 @@ static int ima_bprm_check(struct linux_binprm *bprm)
 }
 
 /**
- * ima_file_check - based on policy, collect/store measurement.
+ * ima_file_open - based on policy, collect/store measurement.
  * @file: pointer to the file to be measured
- * @mask: contains MAY_READ, MAY_WRITE, MAY_EXEC or MAY_APPEND
  *
  * Measure files based on the ima_must_measure() policy decision.
  *
  * On success return 0.  On integrity appraisal error, assuming the file
  * is in policy and IMA-appraisal is in enforcing mode, return -EACCES.
  */
-int ima_file_check(struct file *file, int mask)
+static int ima_file_open(struct file *file)
 {
+	u32 perms = file_to_perms(file);
 	u32 secid;
 
 	security_current_getsecid_subj(&secid);
+
 	return process_measurement(file, current_cred(), secid, NULL, 0,
-				   mask & (MAY_READ | MAY_WRITE | MAY_EXEC |
-					   MAY_APPEND), FILE_CHECK);
+				   perms, FILE_CHECK);
 }
-EXPORT_SYMBOL_GPL(ima_file_check);
 
 static int __ima_inode_hash(struct inode *inode, struct file *file, char *buf,
 			    size_t buf_size)
@@ -1085,6 +1084,7 @@ static struct security_hook_list ima_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(bprm_check_security, ima_bprm_check),
 	LSM_HOOK_INIT(mmap_file, ima_file_mmap),
 	LSM_HOOK_INIT(file_mprotect, ima_file_mprotect),
+	LSM_HOOK_INIT(file_open, ima_file_open),
 	LSM_HOOK_INIT(file_free_security, ima_file_free),
 	LSM_HOOK_INIT(kernel_read_file, ima_read_file),
 	LSM_HOOK_INIT(kernel_post_read_file, ima_post_read_file),
-- 
2.34.1

