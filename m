Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4D52819A7
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Oct 2020 19:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388465AbgJBRjR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 2 Oct 2020 13:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388392AbgJBRil (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 2 Oct 2020 13:38:41 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09F1AC0613AC
        for <linux-integrity@vger.kernel.org>; Fri,  2 Oct 2020 10:38:41 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g9so724293pgh.8
        for <linux-integrity@vger.kernel.org>; Fri, 02 Oct 2020 10:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+iQNrYs3FwbgO/D5wBu/XH+65XZOVsrx8jBX4xhrznE=;
        b=EDfqStII1nyquW6vCDUJ0Tjh5LqLIxTDOCBsRG+Y5BOdp3rp+5tjRqeEdCtoyMHPmx
         MyVLigCKUXuy8gVZ4U6zpvuk9pmCPNlcQ2lULK3/4ExxQylIYS0LevTl1aWHi9IX8858
         bhAQjK9Gpnc8WDPfEOCWZjhiE9R39MQAiqYfY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+iQNrYs3FwbgO/D5wBu/XH+65XZOVsrx8jBX4xhrznE=;
        b=FpB0mKaiUzGeQndFTeM7G/uP7WAxxpjH5EdNewXsD79hGKgTmhUqhmXjBVPb+UGNAv
         VSH01CxKBZPWOXUNefejmIk9vC+wAcgEjoXq7w75XHR34lUY9hglD8KSDjp+rx+q/GBz
         OkmO14oAo7iu2kKFjmAeSvlJCz0RB8k5LygBtxH8TO8ONuDI1C2YyzmbyTUVYGEfw74f
         0JhYar2DSbBP7PvBf65/aiRT2zpzVrsM5izaXaAXaD21Mb8p3aNymdJJihqN30UTWyPL
         IrcQcwWps6c3HbR360iL1ifHQ6ZvIQA76/Xw285Eq0WnXveCa93vII94yvLbsBcyY91p
         ZkRQ==
X-Gm-Message-State: AOAM533xhwEEMHpOcaUidXzxBDEBQeWoJgX/8SfCyZIe/khAmK7O1DD1
        FnTZK8RxNIjSoTf9pxq0ChDpfg==
X-Google-Smtp-Source: ABdhPJyTPCXP4kCQY9q8tHg/I40D0cpppwMhWrbNdfV+VWl5wPSAP7pjwzJcV4nQvitE40P+5c9z6Q==
X-Received: by 2002:a63:5b04:: with SMTP id p4mr3258880pgb.121.1601660320583;
        Fri, 02 Oct 2020 10:38:40 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id q18sm2653154pfg.158.2020.10.02.10.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 10:38:36 -0700 (PDT)
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
Subject: [PATCH v5 12/16] IMA: Add support for file reads without contents
Date:   Fri,  2 Oct 2020 10:38:24 -0700
Message-Id: <20201002173828.2099543-13-keescook@chromium.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201002173828.2099543-1-keescook@chromium.org>
References: <20201002173828.2099543-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
---
 security/integrity/ima/ima_main.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 939f53d02627..82c9d62bcb11 100644
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

