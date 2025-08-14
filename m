Return-Path: <linux-integrity+bounces-6837-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AD247B2727F
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 00:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 812B6A22E9D
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Aug 2025 22:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1560D285047;
	Thu, 14 Aug 2025 22:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EwELvnSU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A23E284B42
	for <linux-integrity@vger.kernel.org>; Thu, 14 Aug 2025 22:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212081; cv=none; b=hY862ZVq260hAzE/AV/UxK6tNbTe2AUnwh6/efCXMXm1r3/DmYhIVjJWu0qFP9/ZnQC4yCJb9vKhEBLqSgxIDgcnWeNBHC1jo3SRpas2EqXnptvG8E2+9/qqjHK6joFr86rh5UrpJ9k20Pgt6L8h96fZAQf4mqWRR2DPZ5z8K64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212081; c=relaxed/simple;
	bh=Y3OuBAfJj2L0PqvbZIjrXdDxw22/e6oMlZYQWyZudio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1a4uLEJihPMaJvbidEi3La7J+2jPb5K8I9lq4Sa9cjOqtxzwz9196tfh6d/Pvmy0NXEmZyS0/OwwgEeRwRyPg+DBoT1fmTTBKqi1oLGkKdMu7St3ch6+iOqCfwuCxCd2YB1JgfJUsscN774UHq29NsA4quqaId0gCpsQufhe3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EwELvnSU; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-70a927d4aaaso13466236d6.1
        for <linux-integrity@vger.kernel.org>; Thu, 14 Aug 2025 15:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212078; x=1755816878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CWJkDdIda33c/xNcCXmr9ZId/P5gWn4X7HG7bQO9qB8=;
        b=EwELvnSU/u6wzIyUgMzfTyR0nGKBDXYtMwuOXSKr8MGaf+RrIWaDqbaFY34pc5BPUM
         qjRel0/dKFPQpU1u3sBGrpNTTZMXJmwiS8nVsZs0u1y8M4BRWgUaeKSTthS7I8n1RFgN
         DVsTTZF9gQOoEOS18eOF9+4TsWFYHeSlJb4mh72KGDmi5Ogfgb7jN9Zp+3NS6WU35qVR
         3UgvOaCR6jRKkc3bYOm1FtQlnjvBq4Wa0I+/0kX0Hw6JWvEmd/8VeBUKPtx3CxGDK22k
         VnMo704NZHN6Eljbm7iPFUVFZ99FgPSWJ/valYAHai4hxF4bZsfcmvw5Sll3NupzBIgU
         a2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212078; x=1755816878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CWJkDdIda33c/xNcCXmr9ZId/P5gWn4X7HG7bQO9qB8=;
        b=tmDm5vvJnbCEVb69SS+XIJYf9t56hFEGWgRFP/bnip8xSNUkYAOJhNDe1SEvXlXC1E
         JU/9yxrIvjWERz1gqxE+A5Z7gKBJNIfEIPO7QqBAkjrJBbFQ/SAhve+mdxOA2sZSJMxV
         hvexDI7wf/Ra0H7+6uVJOjz5r1bJ9bjZySHaxj2eLBbZMK7sYRflEplWjLI10YNrMMfr
         SBjv2OACKqz1H8c5SBrJfPUr7dRx1teejQXQ3KD4sKqN1VFVt6Fx5ARU2TI6m6tngOIn
         xWgyJgxxE9zpiOHSGiV13E1hidTaHb3XrbmbiR2cSFgVM3vZMJuivvX/DStgjPIw+x3V
         hAvA==
X-Forwarded-Encrypted: i=1; AJvYcCVuwClf/FmV+sIBBY5r4eyQIJZz5JOdPuOa2+Akj6HA20p/wvILysUGjVB++IAPrL6ZaGOIfpKmGdYu+eQSYB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxqptUeJx9QzxFH3Dczv4UvPt/O8ka9uTXOhWg4VGMQ2WjQC/b
	M3vQECdZnRMgQWP2MnXqWJpsYXvb7mx/qUM+ma0ez921W128NDo/24x3saifqg7UUQ==
X-Gm-Gg: ASbGncsruELzIH3CURMCVzHeVHuiNfsvqawSLwefo8hxevFGOGeOro9aClHPBll+s+h
	+zWJdj5OCYgL/BRqwvOUr/w38q6RWbGDQrEhvUxv9Mb+Po2etmMOrNOq3Uy9BCcNqCCEZYHa3Dh
	6vm7okCGAT3f7jH4C69Dhc2NOv9moxE1kQZgkC8WMUp1bFFPxdhghUCsScTaJK+EBRI0s/p9d4P
	gcDJUsFDlnt0ZKAiuEQd6jGq4ZWsqVo+bRcxDkprW3Sr0dlVvSvUdY8GvpvMjJ2fzcaz1NsM2sC
	W82gPTR9ajYdSClv3jVOOna+M0M8MgbXVL7yTMDzuW1UblQuzhVTw1Z9MFnOTI3gA7ZmNDodXo9
	N9bt1y2oetqD0NP7Vju8q1YKT6RbCMvziQiN6uySeKc87i5r8zOA7o0Wo2p+5IJcKMys=
X-Google-Smtp-Source: AGHT+IFzbz2KIT/3HbXsSe0WjqHBANAb1FGTnrCBb9l0sQLH421A2LZ/Jpds8CH8Z+BbtGLFwHITAw==
X-Received: by 2002:a05:6214:29ea:b0:70b:a280:208e with SMTP id 6a1803df08f44-70ba4834a28mr8828106d6.34.1755212078100;
        Thu, 14 Aug 2025 15:54:38 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70ae6cccc5dsm19595826d6.27.2025.08.14.15.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:36 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [PATCH v3 19/34] lsm: add/tweak function header comment blocks in lsm_init.c
Date: Thu, 14 Aug 2025 18:50:28 -0400
Message-ID: <20250814225159.275901-55-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1848; i=paul@paul-moore.com; h=from:subject; bh=Y3OuBAfJj2L0PqvbZIjrXdDxw22/e6oMlZYQWyZudio=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmjK288u79ih/3X/EAs8f5ib9UTus8qDfYWED N9t/xn7NTWJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5oygAKCRDqIPLalzeJ c9P8D/9GGLSGMoO2Vy9gChu4IqTMbm3zepQVEuTI62dwz7ieLNKxbXezMnzuiQ/TNmLVP0j+t94 2Py5E153WWKMkOw3r5clgQcon8rtA7fOsPW7M/bDVGItuIQyocDByDJARn6egN91MZCXKkfxJER paMyCrNP1GeyYf/fpjIkZeML0DbVwpY/RSQdLHSY7DS2WGvyRXaOFIZSNq3Z5hm/ySMyoevm38X JwR4mv5yb/V4IalTxC+WQRi1eXejhZ7W7qu18Gcoe+VwxdCtZwY2x5hlG77Dt/b2WlA2VltGWHz 4hX/uH4geROWgk8lt5yIxMteHUuWpfvA4jcfDeZbJM+J2togGcHbsKnhSTck/SKW9DDBvWg7vNn yvKKgSU2lTA2DbklAE3/hlfy9quTsmmPtC0FOxjJaDH01yMKwXFiDlTyAEyudyCybixozfzbbHD RHkW5ky6nMQPR/gj2l/H1cy4Md5XOGteg58aiBV/nQTNvm2jm73phgBsGZHfyINTrjvfIxnA9PF b8vX8ie/iHvWa8nDzRGmOGtTwlU6qoYhBUCj49J0rfsSo+wdf9QBq79KxsJefobsIWJSH5958hX Juqg5FueyhRccrP2CtGUGQ9B3k7USwKxLM+7rmTUSh/B3KUa11jrCfevK8itCuaUMZ5ei9pMwHb zPyt5iw0XB87AeA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Add function header comments for lsm_static_call_init() and
early_security_init(), tweak the existing comment block for
security_add_hooks().

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index f87f5441617b..37593805ba9e 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -315,6 +315,10 @@ static void __init lsm_order_parse(const char *list, const char *src)
 	}
 }
 
+/**
+ * lsm_static_call_init - Initialize a LSM's static calls
+ * @hl: LSM hook list
+ */
 static void __init lsm_static_call_init(struct security_hook_list *hl)
 {
 	struct lsm_static_call *scall = hl->scalls;
@@ -335,12 +339,12 @@ static void __init lsm_static_call_init(struct security_hook_list *hl)
 }
 
 /**
- * security_add_hooks - Add a modules hooks to the hook lists.
- * @hooks: the hooks to add
- * @count: the number of hooks to add
- * @lsmid: the identification information for the security module
+ * security_add_hooks - Add a LSM's hooks to the LSM framework's hook lists
+ * @hooks: LSM hooks to add
+ * @count: number of hooks to add
+ * @lsmid: identification information for the LSM
  *
- * Each LSM has to register its hooks with the infrastructure.
+ * Each LSM has to register its hooks with the LSM framework.
  */
 void __init security_add_hooks(struct security_hook_list *hooks, int count,
 			       const struct lsm_id *lsmid)
@@ -353,6 +357,9 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	}
 }
 
+/**
+ * early_security_init - Initialize the early LSMs
+ */
 int __init early_security_init(void)
 {
 	struct lsm_info *lsm;
-- 
2.50.1


