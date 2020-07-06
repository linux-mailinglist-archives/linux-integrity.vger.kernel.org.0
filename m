Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A17216238
	for <lists+linux-integrity@lfdr.de>; Tue,  7 Jul 2020 01:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728158AbgGFXYf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 6 Jul 2020 19:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728150AbgGFXYe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 6 Jul 2020 19:24:34 -0400
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E98EC08C5E0
        for <linux-integrity@vger.kernel.org>; Mon,  6 Jul 2020 16:24:34 -0700 (PDT)
Received: by mail-ed1-x544.google.com with SMTP id d16so30129391edz.12
        for <linux-integrity@vger.kernel.org>; Mon, 06 Jul 2020 16:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Np0f/K9JCHn9yQ2Y6VtpcddFY7JlGiSYQ3d1AFD5TSY=;
        b=UOnXE0KOObFP97sC9mOHpQxcLEmx/eRYxGl2jrDRpCpX2Hq4FAVwoYYV3ytL8zRCnS
         ePvW2++3exFAxbMFaYCn2CAcZSo5FyA8HQ82HH2odvbuBQSsNOS7MX89kR+1INlwOzbX
         34+9nzRNJnFZDvbK2Bcj9wDw0B6t8FAXVK8nk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Np0f/K9JCHn9yQ2Y6VtpcddFY7JlGiSYQ3d1AFD5TSY=;
        b=TGnW7oyluaKA56sJx1i6FUEVjs68Pi/t4uacTE9eoRnrRLmzl+XaeFEOWHfMREpuzN
         dmekQaE8g5b6YmsvxJ35vRjslx1EtLAhMmjbPLXYuRQ1z3mmLZ5mOnj2VTI7/PgVMMcw
         selKYAD961yOnxNffxXLsagsZwOcY/4u/o0TX+tOF0xKu5vaQe4O+uC40axp8ZZn0nDV
         gOgiqCJpNJyqKH6vF6zh94pWXjxu0X7WbxrPNryqC/lF9/2g7q1Spd/fAe9bcSwx6+PX
         fMn8op5AfkwfH6coBUy0WdEJs1Xu+/Grn0hPVYRONmegvCLilL/851f7lqMYc/DC0xTp
         M99Q==
X-Gm-Message-State: AOAM530d8M5nyFO9x1t1kSfmR9l4DqOjnDlHOc0rQ4qnwZwrMxoIu53c
        baeRTkacgLOFMgdXFj48lIceAQ==
X-Google-Smtp-Source: ABdhPJzmPzlZfsPo2d3fSMfNVxWPo4ni5RTv92j4hAFh5Wn7Uz2cD/fbRT5QGFXvqj8J/fsAlBp/xA==
X-Received: by 2002:aa7:c54e:: with SMTP id s14mr59139165edr.81.1594077872808;
        Mon, 06 Jul 2020 16:24:32 -0700 (PDT)
Received: from lbrmn-lnxub113.broadcom.net ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id i2sm4002567ejp.114.2020.07.06.16.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2020 16:24:32 -0700 (PDT)
From:   Scott Branden <scott.branden@broadcom.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        Wolfram Sang <wsa@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Brown <david.brown@linaro.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Shuah Khan <shuah@kernel.org>, bjorn.andersson@linaro.org,
        Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        BCM Kernel Feedback <bcm-kernel-feedback-list@broadcom.com>,
        Olof Johansson <olof@lixom.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Colin Ian King <colin.king@canonical.com>,
        Kees Cook <keescook@chromium.org>,
        Takashi Iwai <tiwai@suse.de>, linux-kselftest@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>
Subject: [PATCH v10 9/9] ima: add FIRMWARE_PARTIAL_READ support
Date:   Mon,  6 Jul 2020 16:23:09 -0700
Message-Id: <20200706232309.12010-10-scott.branden@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200706232309.12010-1-scott.branden@broadcom.com>
References: <20200706232309.12010-1-scott.branden@broadcom.com>
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Add FIRMWARE_PARTIAL_READ support for integrity
measurement on partial reads of firmware files.

Signed-off-by: Scott Branden <scott.branden@broadcom.com>
---
 security/integrity/ima/ima_main.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 15f29fed6d9f..04a431924265 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -611,6 +611,9 @@ void ima_post_path_mknod(struct dentry *dentry)
  */
 int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 {
+	enum ima_hooks func;
+	u32 secid;
+
 	/*
 	 * READING_FIRMWARE_PREALLOC_BUFFER
 	 *
@@ -619,11 +622,27 @@ int ima_read_file(struct file *file, enum kernel_read_file_id read_id)
 	 * of IMA's signature verification any more than when using two
 	 * buffers?
 	 */
-	return 0;
+	if (read_id != READING_FIRMWARE_PARTIAL_READ)
+		return 0;
+
+	if (!file) {
+		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
+		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
+			pr_err("Prevent firmware loading_store.\n");
+			return -EACCES;	/* INTEGRITY_UNKNOWN */
+		}
+		return 0;
+	}
+
+	func = read_idmap[read_id] ?: FILE_CHECK;
+	security_task_getsecid(current, &secid);
+	return process_measurement(file, current_cred(), secid, NULL,
+				   0, MAY_READ, func);
 }
 
 const int read_idmap[READING_MAX_ID] = {
 	[READING_FIRMWARE] = FIRMWARE_CHECK,
+	[READING_FIRMWARE_PARTIAL_READ] = FIRMWARE_CHECK,
 	[READING_FIRMWARE_PREALLOC_BUFFER] = FIRMWARE_CHECK,
 	[READING_MODULE] = MODULE_CHECK,
 	[READING_KEXEC_IMAGE] = KEXEC_KERNEL_CHECK,
@@ -650,6 +669,9 @@ int ima_post_read_file(struct file *file, void *buf, loff_t size,
 	enum ima_hooks func;
 	u32 secid;
 
+	if (read_id == READING_FIRMWARE_PARTIAL_READ)
+		return 0;
+
 	if (!file && read_id == READING_FIRMWARE) {
 		if ((ima_appraise & IMA_APPRAISE_FIRMWARE) &&
 		    (ima_appraise & IMA_APPRAISE_ENFORCE)) {
-- 
2.17.1

