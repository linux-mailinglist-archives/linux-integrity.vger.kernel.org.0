Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135C25FE563
	for <lists+linux-integrity@lfdr.de>; Fri, 14 Oct 2022 00:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiJMWhI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Oct 2022 18:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiJMWhF (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Oct 2022 18:37:05 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E1EBC613
        for <linux-integrity@vger.kernel.org>; Thu, 13 Oct 2022 15:37:00 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id m6so3275886pfb.0
        for <linux-integrity@vger.kernel.org>; Thu, 13 Oct 2022 15:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RwwHIW9ubgGCNZI9bpt1owrfiGZeXb5wwl1H6trWtBY=;
        b=NPbuugnsa8ZjJmuKOsOOSrzjod1kIYqRgRjmTGaTWJUUqeqq4o26Thx5EwcjH8ntOg
         2FXLuaMoSoMJWiLmgy0LqmQpFgBGbd/D2jky5NbREy2VZpMXlHQhUgKFk4GR4LHv+2Yh
         AhE40vgIjDEMlzjYgT0H7Xngnyh4qql/BXqpA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RwwHIW9ubgGCNZI9bpt1owrfiGZeXb5wwl1H6trWtBY=;
        b=qKzqb5vYBRTHDNV8ODCcj5Zzg9uduC0D9j2WJgLW9ZdSEu6iboXHoH+urjRsVA+LCi
         D+t+zMQ7usdLgwbob0HOdF8gWALubiWDd/9FLGLJglUQlfdbRN6yDavCsTERkhQqO2G+
         v1k9ozDwO8f1MQo+Na4t8sq3EJTZkt5g6ho0ce3soKHLORjv8tb2s4YnM9JHzn9J4V9j
         nbkNmhnwm/dntBaQelh3hqn1aI3uT4A3a6/ENcUWe1JDFlAKE9rWYCnKbjGJ+yeM7t6p
         01CFvx7soCGVAggs2EmATXrM6gEgf4zRJjUOamEX9nn5VXkGMT/mstB2suFId0no1BWk
         Y1gw==
X-Gm-Message-State: ACrzQf0y4JF9cQ2jrWAifnlNs49qQfWo3qWyoK9xZXA48gCqdK+I5H71
        p6oIvy1vOSyzlnjeaomKzquD6Q==
X-Google-Smtp-Source: AMsMyM7usifpi6LURddo97Cesgs33dYbMjwLNWCksMM3VKB/UvdMIMsKuI4q2JXtvsvm+MCed0mIbA==
X-Received: by 2002:a63:4753:0:b0:462:b3f0:a984 with SMTP id w19-20020a634753000000b00462b3f0a984mr1760357pgk.501.1665700619583;
        Thu, 13 Oct 2022 15:36:59 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902710600b0016d773aae60sm363047pll.19.2022.10.13.15.36.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 15:36:56 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Petr Vorel <pvorel@suse.cz>,
        Jonathan McDowell <noodles@fb.com>,
        Borislav Petkov <bp@suse.de>, Takashi Iwai <tiwai@suse.de>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
        KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH 4/9] ima: Move ima_file_free() into LSM
Date:   Thu, 13 Oct 2022 15:36:49 -0700
Message-Id: <20221013223654.659758-4-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221013222702.never.990-kees@kernel.org>
References: <20221013222702.never.990-kees@kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3106; h=from:subject; bh=j7SUgkDxPUE08MqOt4a9Z07kxHXSo2qyUDZKl6O5dvY=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBjSJME98uVBOBVBjxVK8UcpHvXl8yakzz5L2nvmUUm /7U1ct+JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCY0iTBAAKCRCJcvTf3G3AJlXUD/ 9LlocRqLBjy5RTiLduzQ0vovRa//i2jiaWLU4i+ih50alFhDMD02D29Huhx1Bpfkxw3tEd5uirD4Qm woZnL++HqvBws+6hGWHagdC04silwQ+UneqsQ9+EwvYKkgPjAXUf8EqEiroy2E5PW6tvyWQGp7DE04 5fMsRSD1C33QHyVeVM7PoXVrtGzW7ZXZRlq9qLdxpIfMps7lsUPsMQTc2kI0mXBsFDmzmFC+dvs9Kk TBA2b7kANBV4ws5RZBLHQlcNlcorhUbixldb3SD4Igl+MJgA67JGenetiOgFwYTBZT1K73uJbk5yUk WZQc601AOB4dC1ijypfacOlZMsqn3UAybG24Vl3JBK6k9KVLuk//880teg87CIZ3aouwk8oaGFjJCb MGXsSIxvhXFzaDBaD+6ZerRPCd6plADAlHpnOft2dB4URCIbURA0fsBQocvf8yBHNcbIDACPNQ+vsD o2HdBbh3bSEvxx+IZz7MNSOJtcgg19X9ybRdJ2DWUahXj4tAVcVFScJ9Y59q3grUFY4qHgtvQuDUsV VXEVwWI71XFXuUiZWOk3URctGgJ8R6g+ke4PyNtO7Os8N9dDI8SUiFqBidQyChnIfDZLrBJ3kZBTvq Fucu8VZ0mHiRAoMrfyl5lQR9vABa7Kxyt11ZCZCO9fEMV4YrarDv6b7dG5ZA==
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

The file_free_security hook already exists for managing notification of
released files. Use the LSM hook instead of open-coded stacking.

Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>
Cc: James Morris <jmorris@namei.org>
Cc: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Petr Vorel <pvorel@suse.cz>
Cc: Jonathan McDowell <noodles@fb.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/file_table.c                   | 1 -
 include/linux/ima.h               | 6 ------
 security/integrity/ima/ima_main.c | 3 ++-
 3 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/fs/file_table.c b/fs/file_table.c
index 99c6796c9f28..fa707d221a43 100644
--- a/fs/file_table.c
+++ b/fs/file_table.c
@@ -311,7 +311,6 @@ static void __fput(struct file *file)
 	eventpoll_release(file);
 	locks_remove_file(file);
 
-	ima_file_free(file);
 	if (unlikely(file->f_flags & FASYNC)) {
 		if (file->f_op->fasync)
 			file->f_op->fasync(-1, file, 0);
diff --git a/include/linux/ima.h b/include/linux/ima.h
index 6dc5143f89f2..9f18df366064 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -19,7 +19,6 @@ extern enum hash_algo ima_get_current_hash_algo(void);
 extern int ima_file_check(struct file *file, int mask);
 extern void ima_post_create_tmpfile(struct user_namespace *mnt_userns,
 				    struct inode *inode);
-extern void ima_file_free(struct file *file);
 extern void ima_post_path_mknod(struct user_namespace *mnt_userns,
 				struct dentry *dentry);
 extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
@@ -56,11 +55,6 @@ static inline void ima_post_create_tmpfile(struct user_namespace *mnt_userns,
 {
 }
 
-static inline void ima_file_free(struct file *file)
-{
-	return;
-}
-
 static inline void ima_post_path_mknod(struct user_namespace *mnt_userns,
 				       struct dentry *dentry)
 {
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index b3b79d030a67..94379ba40b58 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -183,7 +183,7 @@ static void ima_check_last_writer(struct integrity_iint_cache *iint,
  *
  * Flag files that changed, based on i_version
  */
-void ima_file_free(struct file *file)
+static void ima_file_free(struct file *file)
 {
 	struct inode *inode = file_inode(file);
 	struct integrity_iint_cache *iint;
@@ -1085,6 +1085,7 @@ static struct security_hook_list ima_hooks[] __lsm_ro_after_init = {
 	LSM_HOOK_INIT(bprm_check_security, ima_bprm_check),
 	LSM_HOOK_INIT(mmap_file, ima_file_mmap),
 	LSM_HOOK_INIT(file_mprotect, ima_file_mprotect),
+	LSM_HOOK_INIT(file_free_security, ima_file_free),
 	LSM_HOOK_INIT(kernel_read_file, ima_read_file),
 	LSM_HOOK_INIT(kernel_post_read_file, ima_post_read_file),
 	LSM_HOOK_INIT(kernel_load_data, ima_load_data),
-- 
2.34.1

