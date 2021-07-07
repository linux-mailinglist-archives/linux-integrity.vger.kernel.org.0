Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 318753BE763
	for <lists+linux-integrity@lfdr.de>; Wed,  7 Jul 2021 13:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhGGLtg (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 7 Jul 2021 07:49:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbhGGLtg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 7 Jul 2021 07:49:36 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C889C061574;
        Wed,  7 Jul 2021 04:46:55 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id 145so1920527pfv.0;
        Wed, 07 Jul 2021 04:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TTT7tWdh4cjIutAwW4KPW5eOxCd5OB9OazN7ATKrsNw=;
        b=AU9utQ1YGqOFvZns6ejTn6RKYSC/n4rx3l/fVsqc4sAp/ydr3SNdMGirJKKJNnVe6L
         Qmd72MHSaG83bAYzeml0Z+BIqMUypgNEMSsh5v4qKL5m8HL/tbtlu9611JIIKu0b06ac
         ezxHKZuDAJ4CPaSdaWXs6RcSzl+g7+44Vfrl9LZQr4xDXJ9OauurL1AaP3EoORC0WTfW
         rnXPSX7qCcSKDwMPi9r0s51ehNa6Z+dtqokRer3JMZwlsXJILf/71b7ZWaMvfpcoh2Y2
         zNUD2dvkuESJ8b82VlHKYI8V0QKdUztrlWFMm/PP0l9J8b9HZ2W2yb1V11itWD6cPR6C
         KGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TTT7tWdh4cjIutAwW4KPW5eOxCd5OB9OazN7ATKrsNw=;
        b=qHjj/gSfsxqBsgJeCohNwgdCs+bcnKAvmMhmAcJGEYDRKOX0J3rIreDJFmkLl6OcSW
         UFv/EfYBHrpVN95BBEmrgFDjj+bQRKofP2Voi/OC9OqLGmcG1pzgSC8h82OqT5uQBF0P
         2JzMU9ka6wfUq6Aq6l81P4qIcXakHVQsMWRU0KjtSLl8ehtKgz4/ZmY3X0GQh91EyaUb
         vE7NrvhsUcP4XcRQlfV7s0UEWqbTmA/xXiwQC+dV98UQ46cVKDhC/V2f7hn8uK7+4lq6
         3jqyUWapErz1ywHyerHoNYfeKHYJSiUT6EdBlJ8zK0PVRETqa2iYEEB3XXFpLc4cw7fV
         5APg==
X-Gm-Message-State: AOAM531kE7aSbhY8N1FEiypZ+aRjtNZ03FQTIAado7dBamXDSViQuA0f
        HU1atRW6vXoMUX8++9XR5jw=
X-Google-Smtp-Source: ABdhPJxeZ419Fxj/xcRp4tSs4dZ0pd7yzgJq/+rGJFdrQzt1l+SjGbW+Kh/mAyunEUwPL1IJ3SllkQ==
X-Received: by 2002:a62:507:0:b029:31c:c439:83ab with SMTP id 7-20020a6205070000b029031cc43983abmr18766668pff.65.1625658415044;
        Wed, 07 Jul 2021 04:46:55 -0700 (PDT)
Received: from localhost ([60.186.106.159])
        by smtp.gmail.com with ESMTPSA id q5sm12971947pgt.46.2021.07.07.04.46.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 04:46:54 -0700 (PDT)
From:   Tianxing Zhang <anakinzhang96@gmail.com>
To:     zohar@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Tianxing Zhang <anakinzhang96@gmail.com>
Subject: [PATCH] ima: check control characters in policy path
Date:   Wed,  7 Jul 2021 19:45:41 +0800
Message-Id: <20210707114541.3578-1-anakinzhang96@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

When a policy file path contains control characters like '\r' or '\b',
invalid error messages can be printed to overwrite system messages:

$ echo -e "/\rtest 12345678" > /sys/kernel/security/ima/policy

This patch rejects policy paths with control characters.

Signed-off-by: Tianxing Zhang <anakinzhang96@gmail.com>
---
 security/integrity/ima/ima_fs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima_fs.c
index 3d8e9d5db5aa..e6daa138de89 100644
--- a/security/integrity/ima/ima_fs.c
+++ b/security/integrity/ima/ima_fs.c
@@ -316,6 +316,7 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 {
 	char *data;
 	ssize_t result;
+	int i;
 
 	if (datalen >= PAGE_SIZE)
 		datalen = PAGE_SIZE - 1;
@@ -331,6 +332,14 @@ static ssize_t ima_write_policy(struct file *file, const char __user *buf,
 		goto out;
 	}
 
+	for (i = 0; data[i] != '\n' && data[i] != '\0'; i++) {
+		if (iscntrl(data[i])) {
+			pr_err_once("file path with no control characters required\n");
+			result = -EINVAL;
+			goto out_free;
+		}
+	}
+
 	result = mutex_lock_interruptible(&ima_write_mutex);
 	if (result < 0)
 		goto out_free;
-- 
2.25.1

