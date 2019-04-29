Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0A498EC44
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2019 23:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729564AbfD2Vr5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 29 Apr 2019 17:47:57 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:44274 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729561AbfD2Vr4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 29 Apr 2019 17:47:56 -0400
Received: by mail-pl1-f196.google.com with SMTP id l2so2940000plt.11;
        Mon, 29 Apr 2019 14:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vC2GXHNilPvXhdB73Lv0ZCT32JKOSQmVgBIM8AzGRek=;
        b=dFjhYTdwh18s7b32WrTelepOdhNieNtMScS26bG9wWe6fkjHx971LFmOwEhBD6Y+7l
         KaXpTnPW9xJWYTQzPrkNG3UMF9vBuBEpjfixDTT52IhwuR03dqdiSxS6ffSBYLjJvx27
         RUVsWBFNiqpQ/a4ekoYKDVIu+h2lzsMfCT0BDFsqsqM+uuqQbPiL+VWTQD6H1XcGJ1+J
         FdASScm1XtCCPGWmk1cZ7mH0VIXiemTTUDOhnZVVg6eZgudcTNQSG3LGCzTXuPM74cUB
         yvmgre00dbHOx4MNPkhNKTLP1HgP3RmrflHlENmYgplaimDQjWkrLZc23u69LU1syRNS
         v5fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vC2GXHNilPvXhdB73Lv0ZCT32JKOSQmVgBIM8AzGRek=;
        b=BstKEjW1BNrOpEWFg+RYCwdhFp04GcFx4sabA6+LLr1QiihJoZb/fCaqdhvSnxqany
         zzxYOZpU0IiR0G3JRqJHhJGdc7aDqPPLa7FpxmCY03XjCmhZSJE6Z+PE2JTjKAm7y3qL
         v3JxnhztPvmpgonFwR5T7+EVGVvJvFxTcgZzpkHHAVGXnNg3vbyE+/28imqD1OAuble8
         8Gf01Dm/dnHkjjqP/se9E/Lt290k+EAtICZ3Ha/9Z8n1OU/ZVrTbK9fbupoxkmByI3am
         KmhmcwFvdvZFjiuc2Q3RZmFv9UzYdhBnNN2nI5KpkhmV+PUHX+OewFjHbNZPPt92jiOO
         yMog==
X-Gm-Message-State: APjAAAUcf2TtFmCt9d5aZlMmNcccpElg4OWqaXPW6Vw+ebPFkYiFG2RL
        LuJCpTeyfLmmW7s91Bx74SLliZMK3Gk=
X-Google-Smtp-Source: APXvYqy0xpqS3GbEpDuOqGiXNpEQo/qf3QWg4j/4GKLG/5bfroYvApFQoIMGEUUpzG57fASBgJjxsg==
X-Received: by 2002:a17:902:6b:: with SMTP id 98mr49167313pla.271.1556574475155;
        Mon, 29 Apr 2019 14:47:55 -0700 (PDT)
Received: from prsriva-linux.corp.microsoft.com ([2001:4898:80e8:9:445d:9822:2ddb:fb8c])
        by smtp.gmail.com with ESMTPSA id f66sm1941623pfg.55.2019.04.29.14.47.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 14:47:54 -0700 (PDT)
From:   Prakhar Srivastava <prsriva02@gmail.com>
X-Google-Original-From: Prakhar Srivastava
To:     linux-integrity@vger.kernel.org,
        linux-secuirty-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     zohar@linux.ibm.com, ebiederm@xmission.com, vgoyal@redhat.com,
        nayna@linux.ibm.com, Prakhar Srivastava <prsriva02@gmail.com>
Subject: [PATCH v3 4/4] added LSM hook to call ima_buffer_check
Date:   Mon, 29 Apr 2019 14:47:43 -0700
Message-Id: <20190429214743.4625-5-prsriva02@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190429214743.4625-1-prsriva02@gmail.com>
References: <20190429214743.4625-1-prsriva02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Prakhar Srivastava <prsriva02@gmail.com>

added LSM hook to call ima_buffer_check

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
2.19.1

