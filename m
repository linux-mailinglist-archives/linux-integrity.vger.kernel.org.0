Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28676232401
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Jul 2020 19:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727937AbgG2R7d (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Jul 2020 13:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727936AbgG2R7H (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Jul 2020 13:59:07 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F59C0619E3
        for <linux-integrity@vger.kernel.org>; Wed, 29 Jul 2020 10:59:06 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id o13so14698806pgf.0
        for <linux-integrity@vger.kernel.org>; Wed, 29 Jul 2020 10:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d+cxh7Adx01Lz+PZ0BqdBZD0tuhqHe+fIcb3T8VVshI=;
        b=ZZB5JK//OYdCgnZb/fU8QzTjp427UrGSGiw79T8stn6rtJuQa9EpnWg2nqhPKWluxW
         W6G5fG+ztYpEQLf1lCq0MlQ9zNk4q/Y5m3gxLuSfvTXmmiKW5Rv4D1MaN0sW3Ja7Djt+
         EOHWd0VX606jZjeyOdUtx/H0g56YaQIalcg6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d+cxh7Adx01Lz+PZ0BqdBZD0tuhqHe+fIcb3T8VVshI=;
        b=nU3AapdfPWADf17fw33xokw6qnEQcX90Ps+uaFhLV2Q+ypm6TgLs9TBZXtrebXJNJb
         4++tdNIuW5td83WHLFEfS98B6tM8Vm4+fTL3uC4cuMN+jVOflQOfJJRE7bbpXxLaVMDf
         7OkzDGyGzae0+iBFb6klsDu6uqFM7CneCcwOKbVW7mcEkBdj/WilGmM8yBmt0qhZmH/w
         fYQ6TZHV1fN8KbCiupLadLOGi5yx6Wddt7bguy9oJB+d0M/S/jB60LwUZTyXbZD4oXOS
         /mU0HJaOqs2SfQ2G/BOU37Ew7jissTFtNi2uQtsPznzWk8uruzg0OG51Zn55JV9zH9sG
         Ds3w==
X-Gm-Message-State: AOAM533gcHZqBlFhFTGMsu4TKtyduKCsiLUlT/5hjXe4aqhH5InwCUnx
        jOz8rEsIkJL2HsQ62eEtpyHqCg==
X-Google-Smtp-Source: ABdhPJzwV8yZ+vHoQE7rb6HkYEvIykxXV/ucl+4R0uhyvLJBDEppIOQPIpaDe7F8tvEjOO8IV+mKow==
X-Received: by 2002:a63:ce41:: with SMTP id r1mr31178572pgi.203.1596045546377;
        Wed, 29 Jul 2020 10:59:06 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y10sm3081590pff.187.2020.07.29.10.58.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 10:59:04 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, Jessica Yu <jeyu@kernel.org>,
        SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 13/17] IMA: Add support for file reads without contents
Date:   Wed, 29 Jul 2020 10:58:41 -0700
Message-Id: <20200729175845.1745471-14-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200729175845.1745471-1-keescook@chromium.org>
References: <20200729175845.1745471-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Scott Branden <scott.branden@broadcom.com>

When the kernel_read_file LSM hook is called with contents=false, IMA
can appraise the file directly, without requiring a filled buffer. When
such a buffer is available, though, IMA can continue to use it instead
of forcing a double read here.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
Link: https://lore.kernel.org/lkml/20200706232309.12010-10-scott.branden@broadcom.com/
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 security/integrity/ima/ima_main.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index dc4f90660aa6..de57fce5bced 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -613,11 +613,8 @@ void ima_post_path_mknod(struct dentry *dentry)
 int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 		  bool contents)
 {
-	/* Reject all partial reads during appraisal. */
-	if (!contents) {
-		if (ima_appraise & IMA_APPRAISE_ENFORCE)
-			return -EACCES;
-	}
+	enum ima_hooks func;
+	u32 secid;
 
 	/*
 	 * Do devices using pre-allocated memory run the risk of the
@@ -626,7 +623,20 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id,
 	 * buffers? It may be desirable to include the buffer address
 	 * in this API and walk all the dma_map_single() mappings to check.
 	 */
-	return 0;
+
+	/*
+	 * There will be a call made to ima_post_read_file() with
+	 * a filled buffer, so we don't need to perform an extra
+	 * read early here.
+	 */
+	if (contents)
+		return 0;
+
+	/* Read entire file for all partial reads. */
+	func = read_idmap[read_id] ?: FILE_CHECK;
+	security_task_getsecid(current, &secid);
+	return process_measurement(file, current_cred(), secid, NULL,
+				   0, MAY_READ, func);
 }
 
 const int read_idmap[READING_MAX_ID] = {
-- 
2.25.1

