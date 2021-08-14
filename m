Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58223EC165
	for <lists+linux-integrity@lfdr.de>; Sat, 14 Aug 2021 10:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237450AbhHNI21 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 14 Aug 2021 04:28:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237426AbhHNI21 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 14 Aug 2021 04:28:27 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4402DC06175F;
        Sat, 14 Aug 2021 01:27:59 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso19470461pjb.1;
        Sat, 14 Aug 2021 01:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TTT7tWdh4cjIutAwW4KPW5eOxCd5OB9OazN7ATKrsNw=;
        b=A0lpoSPq41usL0zUBaK+Yw2NCD/ApVc7G2rf/NHKfOJg9fFkWhF8HSzKPIv0Bxo0KH
         kIYanzW1zVLjZPMQCWT9S4yT4cZMulNbPkuF+YMkvMSw1pLkS4YhKTByopHNOI89hO3v
         jsa6Gw1Nwd6Qj6BYTAlMEnoNWZE4OiiLbMwyNkfb+dB/5D0ct+qxX69qKim9+tfPgrbp
         iED0VmVKd2cpuOVR1WVczG4CHtLBF8hAQCH5y3WwH0JheRBfInrkOaM/ktFW2riJrkJ9
         btac0W3rVujJRBCpzSjG0hS79QCc4VAQT6D1REkbwDPyIjEmd5UH71/lNKX1WwU7xpct
         ZGPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TTT7tWdh4cjIutAwW4KPW5eOxCd5OB9OazN7ATKrsNw=;
        b=ug7izTEVeJwzIlhtrxfluuDcxc63l9dC4yWHjEZURu54iOJo7UDwU/PsnQS9OX4+yU
         ACUv068z2FnHxjlXEosiKaC2vRsIDDflOKD00OISabB1lP91NX7jIsTooBpAmqItTSW5
         wWofKVWhTAvyY3ywGlA9TG6QWm0rJKp/uUUzBtT7oGMLOzGBDYE4jUZ8SGVR+4T8VBNd
         OMNIZfzUoxjoDNT7NKYaHvpkRdJlTzPTXp3LJ9nprW/TO6IrfwsFyEXK9nVmYg+nwVYi
         QKwq/0bhpuSedTcq392sUq+AxeQYq8uc/Uvvw+gOpCpE8kHSkfadm8tnt1PxCPhgzFbR
         HPKA==
X-Gm-Message-State: AOAM530lfg3UCOjRvHGZPp4IooQ+ca6I1h0Ie+pfOzzkAfolTZROvntz
        5zrPBuClLGU2GG/jLJsZVUo5db4xN6aNvdpb
X-Google-Smtp-Source: ABdhPJyazibiXh+ieZulvePaFVpy/LHnKoeg0qfE5WYrjtXi1iWGpni0uW7o3UyKWaex1oOlbH1ETQ==
X-Received: by 2002:a17:902:d511:b029:12d:5f23:339b with SMTP id b17-20020a170902d511b029012d5f23339bmr5190895plg.68.1628929678626;
        Sat, 14 Aug 2021 01:27:58 -0700 (PDT)
Received: from localhost ([119.3.119.21])
        by smtp.gmail.com with ESMTPSA id r10sm4718358pff.7.2021.08.14.01.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Aug 2021 01:27:58 -0700 (PDT)
From:   Tianxing Zhang <anakinzhang96@gmail.com>
To:     zohar@linux.ibm.com
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tianxing Zhang <anakinzhang96@gmail.com>
Subject: [PATCH 1/1] ima: check control characters in policy file path
Date:   Sat, 14 Aug 2021 16:27:23 +0800
Message-Id: <20210814082723.261-1-anakinzhang96@gmail.com>
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

