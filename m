Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 976EC232402
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Jul 2020 19:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgG2R7e (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Jul 2020 13:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbgG2R7F (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Jul 2020 13:59:05 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CEFEC0619DA
        for <linux-integrity@vger.kernel.org>; Wed, 29 Jul 2020 10:59:05 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id p3so14673080pgh.3
        for <linux-integrity@vger.kernel.org>; Wed, 29 Jul 2020 10:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2dckHYDBSef92hBk0hdLw37DCCWMtjung/PzGLRIGlQ=;
        b=PeYr3jVB7W6UcW212/oJZmLRi4czVPcQjfijK3aeH7rdxGYPMC62JtlyIoOxj7gwy5
         c2dWpHJMjKgNg5+GOs7lE5ptFlJbitvkjzFCMkK2BuSsglPWQHHRYHbZXOmZVOOvVeL9
         AXbaJuHNrbC7ktjkX3HyAY7OqVwqAjEvn/WKk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2dckHYDBSef92hBk0hdLw37DCCWMtjung/PzGLRIGlQ=;
        b=cEZcjaom9aN20gWhO5WQyjBmimIMmIFBl0csHkMZ4Q6po608PhKZhd94zdmFU4u7/5
         vCX1sjI1zbpO3rrp/0NIcBDrtB3tjXd4Cagdbd1f74fftKV5FORFVi9cenuLAefvRsjG
         a2LYVxOxStqSntofuubFQtK2LhTiJ8DeJC5s9zPnqaJbOXdc/utT1bFdNU73k8zkJPXF
         BE5aP7FX01tt1avggRCA1QiEsZS6qH2vsj7DP35nZD7VMEZpojf7j/C9p6iWYYYLtnaB
         8k+ZI4le1cFrcVKwChbUziM2vhfTBKiesRfiRDj+e0470jRX4JY8LqsXt3zQl8W31x/O
         GCgA==
X-Gm-Message-State: AOAM532nNPzzKrQKCdShizEttUjlL9wQClm3dx57Eo5yRvKAFN+4L+mN
        iExhFb6R7LJNtVrBvs6OtAsEbw==
X-Google-Smtp-Source: ABdhPJx0d4Pms05JWWdUqTfjeGaSa2h+B6c1vOgjK6stye4AbmKSEHfAQSNgfmrRFdWMcscCi/9fDQ==
X-Received: by 2002:a65:64c5:: with SMTP id t5mr30425186pgv.28.1596045544724;
        Wed, 29 Jul 2020 10:59:04 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id t73sm3172293pfc.78.2020.07.29.10.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2020 10:58:58 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Kees Cook <keescook@chromium.org>, Jessica Yu <jeyu@kernel.org>,
        Scott Branden <scott.branden@broadcom.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Takashi Iwai <tiwai@suse.de>, SeongJae Park <sjpark@amazon.de>,
        KP Singh <kpsingh@chromium.org>, linux-efi@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/17] module: Call security_kernel_post_load_data()
Date:   Wed, 29 Jul 2020 10:58:39 -0700
Message-Id: <20200729175845.1745471-12-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200729175845.1745471-1-keescook@chromium.org>
References: <20200729175845.1745471-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Now that there is an API for checking loaded contents for modules
loaded without a file, call into the LSM hooks.

Cc: Jessica Yu <jeyu@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 kernel/module.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/kernel/module.c b/kernel/module.c
index d773f32f8dfd..72e33e25d7b9 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2970,7 +2970,7 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
 	if (info->len < sizeof(*(info->hdr)))
 		return -ENOEXEC;
 
-	err = security_kernel_load_data(LOADING_MODULE, false);
+	err = security_kernel_load_data(LOADING_MODULE, true);
 	if (err)
 		return err;
 
@@ -2980,11 +2980,17 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
 		return -ENOMEM;
 
 	if (copy_chunked_from_user(info->hdr, umod, info->len) != 0) {
-		vfree(info->hdr);
-		return -EFAULT;
+		err = -EFAULT;
+		goto out;
 	}
 
-	return 0;
+	err = security_kernel_post_load_data((char *)info->hdr, info->len,
+					     LOADING_MODULE);
+out:
+	if (err)
+		vfree(info->hdr);
+
+	return err;
 }
 
 static void free_copy(struct load_info *info)
-- 
2.25.1

