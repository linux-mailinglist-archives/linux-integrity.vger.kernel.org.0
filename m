Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A6871357E
	for <lists+linux-integrity@lfdr.de>; Sat,  4 May 2019 00:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726939AbfECWZg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 May 2019 18:25:36 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38152 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbfECWZe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 May 2019 18:25:34 -0400
Received: by mail-pf1-f193.google.com with SMTP id 10so3563136pfo.5;
        Fri, 03 May 2019 15:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vw/WCoWJC8LG27VjrkL+CC1VMWeROo418tAMf4jQKGQ=;
        b=mdGH1SaHShD+kgLt/Fx6BWhW6AJ0v4kausIuhDquzZhHChDRtQZM/OK/MHkvW4xUQl
         WCusueh03W4KqzU2NPxy/5BZ1p1pR6tOamo1uDRB+7/z4vXp6lMkNIuAMBmJnnFsAkFn
         5XJ6Tmexbpzdv6RHSqiW8HjXN3PgtrZHoaCprVtCtYraLjgNZQ5xYxShCIAohXx3j44y
         LxPaIx2eMTv/5BY1O/mHjfPFoGSnGxAc8TrPWBlgspy7I/TGxEsszBrpcvku8euWSo2m
         o8fVgp5Uor0whNnbajXLVzVIR6VbGuze5KOX/L5k8eUiT8lwz+/nJLmxrshnhgti9jAI
         QRPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vw/WCoWJC8LG27VjrkL+CC1VMWeROo418tAMf4jQKGQ=;
        b=nGp+dMHsrN93DsWxXY9qKayGNQx7Lc+5aghXnhOOKqCT4enu6zK/RV11B3oFKC0rJi
         O5S/QGWQ1VnjxR5twYvdCBYTeWY2v8/W0JXL3ybLRGmQASAxx3CrtKCTzyyXYrvJXFPQ
         y4kCueLjUr8EAGgSRPgRFnwFvX0x0o8I2APIVycgtmc1IhCiDwQIBASZz2SlcgmHY5ZZ
         0mAAb3KlF9siqVcKWs2QDqT00qNFoRPmBesDdHFKawiS0BSa90YltzB6UN7JStrFwCRE
         Y2b3wC+Pg1dzVY54+IazZjAwaALoZ2WVQrvhIt2fOEEJF96aEVTYdJA0BJ8leWi2jq99
         WD0A==
X-Gm-Message-State: APjAAAVmE9NeROVQC/uP2Beb7JRNLmhE4Qa1dWZ6YYoJx/6+AKRnJsAl
        B2Y6sOwkPpRcApMxJqjJ7U0el+GIqQg=
X-Google-Smtp-Source: APXvYqzwVBUrpU+9GszPOlMwB4DPuKWzEhuImiw055hwutotb6LgPxCQ/3G9Jj33vn4zAtmHrGCH7A==
X-Received: by 2002:a62:5915:: with SMTP id n21mr14163364pfb.180.1556922333427;
        Fri, 03 May 2019 15:25:33 -0700 (PDT)
Received: from prsriva-linux.corp.microsoft.com ([2001:4898:80e8:b:3170:1a6b:a13a:7ff])
        by smtp.gmail.com with ESMTPSA id j22sm4314337pfi.139.2019.05.03.15.25.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 15:25:32 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
X-Google-Original-From: Prakhar Srivastava
To:     linux-integrity@vger.kernel.org,
        linux-secuirty-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, ebiederm@xmission.com, vgoyal@redhat.com,
        nayna@linux.ibm.com, nramas@microsoft.com, prsriva@microsoft.com,
        Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH 4/5 v4] added LSM hook to call ima_buffer_check
Date:   Fri,  3 May 2019 15:25:22 -0700
Message-Id: <20190503222523.6294-5-prsriva02@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503222523.6294-1-prsriva02@gmail.com>
References: <20190503222523.6294-1-prsriva02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Prakhar Srivastava <prsriva02@gmail.com>

add a LAM hook for kexec_cmldine args to be made available to
other LSMs.

Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
---
 include/linux/lsm_hooks.h | 3 +++
 include/linux/security.h  | 3 +++
 kernel/kexec_internal.h   | 4 +++-
 security/security.c       | 6 ++++++
 4 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
index a240a3fc5fc4..f18562c1eb24 100644
--- a/include/linux/lsm_hooks.h
+++ b/include/linux/lsm_hooks.h
@@ -1672,6 +1672,8 @@ union security_list_options {
 	int (*inode_setsecctx)(struct dentry *dentry, void *ctx, u32 ctxlen);
 	int (*inode_getsecctx)(struct inode *inode, void **ctx, u32 *ctxlen);
 
+	int (*buffer_check)(const void *buff, int size, const char *eventname);
+
 #ifdef CONFIG_SECURITY_NETWORK
 	int (*unix_stream_connect)(struct sock *sock, struct sock *other,
 					struct sock *newsk);
@@ -1945,6 +1947,7 @@ struct security_hook_heads {
 	struct hlist_head inode_notifysecctx;
 	struct hlist_head inode_setsecctx;
 	struct hlist_head inode_getsecctx;
+	struct hlist_head buffer_check;
 #ifdef CONFIG_SECURITY_NETWORK
 	struct hlist_head unix_stream_connect;
 	struct hlist_head unix_may_send;
diff --git a/include/linux/security.h b/include/linux/security.h
index 49f2685324b0..8dece6da0dda 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -388,6 +388,7 @@ void security_inode_invalidate_secctx(struct inode *inode);
 int security_inode_notifysecctx(struct inode *inode, void *ctx, u32 ctxlen);
 int security_inode_setsecctx(struct dentry *dentry, void *ctx, u32 ctxlen);
 int security_inode_getsecctx(struct inode *inode, void **ctx, u32 *ctxlen);
+void security_buffer_measure(const void *buff, int size, char *eventname);
 #else /* CONFIG_SECURITY */
 
 static inline int call_lsm_notifier(enum lsm_event event, void *data)
@@ -1188,6 +1189,8 @@ static inline int security_inode_getsecctx(struct inode *inode, void **ctx, u32
 {
 	return -EOPNOTSUPP;
 }
+static inline void security_buffer_measure(const void *buff, int size, char *eventname)
+{ }
 #endif	/* CONFIG_SECURITY */
 
 #ifdef CONFIG_SECURITY_NETWORK
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 48aaf2ac0d0d..9f967fbb5aa0 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -12,7 +12,9 @@ int kimage_load_segment(struct kimage *image, struct kexec_segment *segment);
 void kimage_terminate(struct kimage *image);
 int kimage_is_destination_range(struct kimage *image,
 				unsigned long start, unsigned long end);
-
+int kexec_cmdline_prepend_img_name(char **outbuf, int kernel_fd,
+				const char *cmdline_ptr,
+				unsigned long cmdline_len);
 extern struct mutex kexec_mutex;
 
 #ifdef CONFIG_KEXEC_FILE
diff --git a/security/security.c b/security/security.c
index 23cbb1a295a3..2b575a40470e 100644
--- a/security/security.c
+++ b/security/security.c
@@ -754,6 +754,12 @@ int security_bprm_check(struct linux_binprm *bprm)
 	return ima_bprm_check(bprm);
 }
 
+void security_buffer_measure(const void *buff, int size, char *eventname)
+{
+	call_void_hook(buffer_check, buff, size, eventname);
+	return ima_buffer_check(buff, size, eventname);
+}
+
 void security_bprm_committing_creds(struct linux_binprm *bprm)
 {
 	call_void_hook(bprm_committing_creds, bprm);
-- 
2.20.1

