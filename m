Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA51A321AFC
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Feb 2021 16:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhBVPOR (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 22 Feb 2021 10:14:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbhBVPNz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 22 Feb 2021 10:13:55 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20545C0617A7;
        Mon, 22 Feb 2021 07:12:51 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id i9so3926585wml.5;
        Mon, 22 Feb 2021 07:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LLkuX0+ITGWZ/iVnAzMULSxwtPPckweuLMISePt9ssw=;
        b=BPykAZVvUp4icbQV3I8OKq3dgj9xE7I0bXvTLRa+lLFvT2T9S46GpK5rzpalk0vka7
         EMAebBc4xNncmRW0iYtFoKILmLT9xpNRKjXNkKgGb+RdrBDYrM86Ih0zaynkmOTCb5LP
         NaKo4wGex24T0J5JuUZcwofRPEBZMW4HusebFD6CYD7Muei1Q9Ep+FX3tFJoNNyi6fQ4
         vE8B0dAximKDBpReNOj1/mEWaFJRZGAdbJ6d3RmzX4lwPElZ4tQbzdIkzl+VgYesDdXm
         1qtG97aM1OEtTOrV6g9qGUbFcX4kZio/WjmW8dJAY8W54ikoDB+MgxYkLUCWt2nF9F/v
         xpkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LLkuX0+ITGWZ/iVnAzMULSxwtPPckweuLMISePt9ssw=;
        b=t8e3DWaynfASCENevG8YlmPo5GrYiVVFXKIj9scJ4wmW7RynSfmcyWx8RNxMa4dY2K
         F+hYXyZFTgExhFu0DrdQ89vIttPIna6bawPKhnn5GerNQqxhH2927l5X4B4M7eF3L5SF
         1CGCeQ66o8XBoCrD5IY5VoIC6qJlxRUzgTUaDbgL+IaFvIDJ56b9mwVGTFVR25HZ3COT
         r+q0TzDVhq1nDNyuIlJhNb7r7JRoxkY0keZwYoJxae3Fm2pgcEZw9539LtpTwdcrpYKf
         SVl2hZOJithkUpaUeALs3ibL1OJUQEpjvQ/4oqGlKRtbOvDj5tNoe1r2RU6jX0zYq3YA
         q/TQ==
X-Gm-Message-State: AOAM531b8Eans2ce0nyTMOWOYumrv9SMuw51RGgOL9qcbOSDd43PqSGS
        UO/6S3ILaVhNsr0onNxUSX9/d8FXEVc5Zc30VGY=
X-Google-Smtp-Source: ABdhPJxc30UcYQVY9SrjO7shc//rXjLfBfc8tuVxMSyonaZSmDzTDDA/bQLZBQpXRC/u5O+PvGH7Xw==
X-Received: by 2002:a1c:2094:: with SMTP id g142mr20921780wmg.101.1614006769655;
        Mon, 22 Feb 2021 07:12:49 -0800 (PST)
Received: from debby (176-141-241-253.abo.bbox.fr. [176.141.241.253])
        by smtp.gmail.com with ESMTPSA id l15sm26251391wmh.21.2021.02.22.07.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 07:12:49 -0800 (PST)
From:   Romain Perier <romain.perier@gmail.com>
To:     Kees Cook <keescook@chromium.org>,
        kernel-hardening@lists.openwall.com,
        Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Cc:     Romain Perier <romain.perier@gmail.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 06/20] ima: Manual replacement of the deprecated strlcpy() with return values
Date:   Mon, 22 Feb 2021 16:12:17 +0100
Message-Id: <20210222151231.22572-7-romain.perier@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210222151231.22572-1-romain.perier@gmail.com>
References: <20210222151231.22572-1-romain.perier@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The strlcpy() reads the entire source buffer first, it is dangerous if
the source buffer lenght is unbounded or possibility non NULL-terminated.
It can lead to linear read overflows, crashes, etc...

As recommended in the deprecated interfaces [1], it should be replaced
by strscpy.

This commit replaces all calls to strlcpy that handle the return values
by the corresponding strscpy calls with new handling of the return
values (as it is quite different between the two functions).

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strlcpy

Signed-off-by: Romain Perier <romain.perier@gmail.com>
---
 security/integrity/ima/ima_policy.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 9b45d064a87d..1a905b8b064f 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -790,8 +790,14 @@ static int __init ima_init_arch_policy(void)
 	for (rules = arch_rules, i = 0; *rules != NULL; rules++) {
 		char rule[255];
 		int result;
+		ssize_t len;
 
-		result = strlcpy(rule, *rules, sizeof(rule));
+		len = strscpy(rule, *rules, sizeof(rule));
+		if (len == -E2BIG) {
+			pr_warn("Internal copy of architecture policy rule '%s' "
+				"failed. Skipping.\n", *rules);
+			continue;
+		}
 
 		INIT_LIST_HEAD(&arch_policy_entry[i].list);
 		result = ima_parse_rule(rule, &arch_policy_entry[i]);

