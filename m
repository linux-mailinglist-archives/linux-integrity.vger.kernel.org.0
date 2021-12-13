Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F6AB473153
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Dec 2021 17:11:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237133AbhLMQLs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Dec 2021 11:11:48 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:37822 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236838AbhLMQLr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Dec 2021 11:11:47 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B1B971F3BA;
        Mon, 13 Dec 2021 16:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1639411906; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UC9vX+yzI1xib8kQHkMFXmkpNsL/m9Qgumk8tsYtvSg=;
        b=eGCvssb8vEV2yt1Njr+JAraRlJm6rKiG7bUaZg0vfCV3/amox1nYJe8NXDFanLFQ9HGIVi
        wj4uGBgZKnA9kpEekAmX3CtEFi/TRgUSj7SUQMzvKB45u4ycPkuxwxd2fZH5DYCNDOi+bG
        vcr9Gghhwaabaw/RjCOO9u8n09raDxA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1639411906;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=UC9vX+yzI1xib8kQHkMFXmkpNsL/m9Qgumk8tsYtvSg=;
        b=PxJPf/HRpVg8K3qDcLtB2sIxfCA53rVkMpXOdUjet6u4UFIOZ4Gk0RxrrHz/caQiNf+0yl
        7TcQ3gt97lxsEVAw==
Received: from alsa1.nue.suse.com (alsa1.suse.de [10.160.4.42])
        by relay2.suse.de (Postfix) with ESMTP id A86C6A3B84;
        Mon, 13 Dec 2021 16:11:46 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joey Lee <jlee@suse.com>
Subject: [PATCH] ima: Fix undefined arch_ima_get_secureboot() and co
Date:   Mon, 13 Dec 2021 17:11:45 +0100
Message-Id: <20211213161145.3447-1-tiwai@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Currently arch_ima_get_secureboot() and arch_get_ima_policy() are
defined only when CONFIG_IMA is set, and this makes the code calling
those functions without CONFIG_IMA failing.  Although there is no such
in-tree users, but the out-of-tree users already hit it.

Move the declaration and the dummy definition of those functions
outside ifdef-CONFIG_IMA block for fixing the undefined symbols.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/linux/ima.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/ima.h b/include/linux/ima.h
index b6ab66a546ae..426b1744215e 100644
--- a/include/linux/ima.h
+++ b/include/linux/ima.h
@@ -50,21 +50,6 @@ static inline void ima_appraise_parse_cmdline(void) {}
 extern void ima_add_kexec_buffer(struct kimage *image);
 #endif
 
-#ifdef CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
-extern bool arch_ima_get_secureboot(void);
-extern const char * const *arch_get_ima_policy(void);
-#else
-static inline bool arch_ima_get_secureboot(void)
-{
-	return false;
-}
-
-static inline const char * const *arch_get_ima_policy(void)
-{
-	return NULL;
-}
-#endif
-
 #else
 static inline enum hash_algo ima_get_current_hash_algo(void)
 {
@@ -155,6 +140,21 @@ static inline int ima_measure_critical_data(const char *event_label,
 
 #endif /* CONFIG_IMA */
 
+#ifdef CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
+extern bool arch_ima_get_secureboot(void);
+extern const char * const *arch_get_ima_policy(void);
+#else
+static inline bool arch_ima_get_secureboot(void)
+{
+	return false;
+}
+
+static inline const char * const *arch_get_ima_policy(void)
+{
+	return NULL;
+}
+#endif
+
 #ifndef CONFIG_IMA_KEXEC
 struct kimage;
 
-- 
2.31.1

