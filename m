Return-Path: <linux-integrity+bounces-7111-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B85BB7D2EB
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 14:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A90561BC400E
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 22:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83042F6597;
	Tue, 16 Sep 2025 22:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CxNvk2fD"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20AE2C0270
	for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 22:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060828; cv=none; b=RV6EO3Aad5wRimeknuI/Mev/te62KT5L7+Jtb7mQpchENxpKcNHR/PMqsl0hWlGylI9bdhi5qF/p5SX84hI5lhHBuu/AuUV1jNnAHsy1/PsuBTD/fiGJDHMz5upp3syxc6Efc/LN82gIAmUk48nhKHawXpD66cUdbiJhDObjvrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060828; c=relaxed/simple;
	bh=9+rZddv2qo+xd/s5UYlf8vprAZ6qDrWG77BSi7z2FlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pgb77PBsYyqxVmtu5BOccLUOQ6hotNsxNfiperTaX8epPWEwezj2EMK52HVtybaPIb4oC/covbHWL2LfK1A2E18MjjKQHPpPDRex40akVkqRKOvEB5owRTHStRYC5wzGN7L7m1e8FE93lZKhlsUS0uXF2y1fG2K7+YUeKmhwXi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CxNvk2fD; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-7240eb21ccaso2878476d6.0
        for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 15:13:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060826; x=1758665626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nXuhypsxRUZ8Mxxpk52Nehj4qfdEBuoFOv0z8ETV42g=;
        b=CxNvk2fDghU+wPtueIGEqxbSHHKTx0EVHQMnQfE/BhSO/+EbD4tuQ1Ge7akW/gXewT
         vEkrUljwvfzArJkEKBHxdjTst3n+oj2Q1ikRe33Hb+HDM0pjAzGWeUfV49AXYxYP0jPD
         XbGYijNP+8UkqbkU1HJ88rL0PSH7h3t9vSgKCTFVv5O6ew7sgvEspprTFiD+y3JVaNzh
         42Zh4uSHJWURaP5s3GF9zKDVG1vm5Ut+rIh6es2G7tcZGfaPKGdKw/oiAEvV8P9C/LeV
         ZaBii/22Ml9y84TYOaY8VqDTVAUVK9E3WaeXji5L4OwhJbn7Tylm/qF9YssdEb34iHEu
         j7dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060826; x=1758665626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nXuhypsxRUZ8Mxxpk52Nehj4qfdEBuoFOv0z8ETV42g=;
        b=qGYoLdEZVh4WxtNci/btvXAQoHIUirUk99VxvYm9QsBv8HMvgAO0zaAIgtAAc4jv0z
         GsshMQ68rPbCPHyegqvQ9dxLyaOTPyOdjkm3wgznGS8f/GFV3Qj0ufhXaj4yHOHXPf0b
         bdPhkjRQaqmem6Z3op4bl/nEVIYeGD8rluQ/MlF4/I1w/E5VA9gBHfKI8U0ynKdxFkWY
         ZodRDASo0XEmm0wUvkJdOOhAiM16rCvOCMhJr9FaMjRTU2+xK9VYWV7trpD2PLupUq4J
         pOL8bggqaRHsi6UmRm9hYLMQSY8ppvMY/QQ2XeUpzYtJs+I/oDxxavctQwzd6EJlrtdW
         pFYQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7kt+rXlVrNMlaUfQWudoNeqTGZmsMK3h7fdRs9MY2JpULKSXYANnc5KiV1NNppasF1ngcjMu1jgFfb5Dr2Mk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcQTMe9aYR5o/9ipPsugAjibmuR+g/UnpOgOVqWSToCIaCqrAy
	hRi21pmUdj4FK5WoWH0IZncMj3sAHcAdq0dQHqiO1ufEN8omnkUPV74Wfp9noAuEVA==
X-Gm-Gg: ASbGncuKRMAUKM9p+5+KzoT+838njfLMqIOF5N7Ji8bao/qPM1myLTHDOop3cU53CON
	wRMqSjeOGrLugBUWX2MZONtRy+5mIPAlNanyEg/252abXzVH01YGaX7UEUgeg3LyEtqtJJTwl7Y
	QprAjkccuxIZVgJhMs4duv8jv6QD8aTYL/hsuSu+1/jY8zRtuJaqoc0L+ttlVasqolviQfPxBKG
	ldQv8yrBogekHiRus5XanO6O6qDu6/M3yyLVxXauvXHjGzWOsrBY25awVMz6YYHy+l7RFgI/j/8
	uFW5wS8WlLJIj8lkWpnMgbB0ATk/F/miBZYXMtkceSf/HYc5EwCLmqx0OHFN4idoZJc1ex7EAje
	dbQIPVrkM8UTYVphAWXqYxOXVLZ9mNpgdh2qotQjyhDhTgQNbZhhztcNiNmA2ZS4cWqok
X-Google-Smtp-Source: AGHT+IFkYqArttlIZ4C0hP7BuEYgfHvcQK2ujMBKSE1TAKJP/b3y5+AOhn5SM5XCm8+U8tYdQ0ZjoA==
X-Received: by 2002:a05:6214:240e:b0:76a:59a2:8869 with SMTP id 6a1803df08f44-78d5d1565admr40742186d6.12.1758060825655;
        Tue, 16 Sep 2025 15:13:45 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-78d971f79casm14468056d6.56.2025.09.16.15.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:13:44 -0700 (PDT)
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
Subject: [PATCH v4 06/34] lsm: integrate lsm_early_cred() and lsm_early_task() into caller
Date: Tue, 16 Sep 2025 18:03:33 -0400
Message-ID: <20250916220355.252592-42-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1995; i=paul@paul-moore.com; h=from:subject; bh=9+rZddv2qo+xd/s5UYlf8vprAZ6qDrWG77BSi7z2FlQ=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd7cZJYwx4TirbVrit/W+EPMndfkQBs+neRSs 6OSfRDeYN6JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMne3AAKCRDqIPLalzeJ c9K0D/4lYOvfFFY7IEVd25BEa3tYzHq7CA04RWghf6Im+/SMI6MVU0aGHALI56BCLwukOciCPaI ADhN6hw6bOsozoayKtH1vpK7BEh9gAHKAavopLu1/BkXiz3i3Xt2leEZo/EgmpwMvYccUrxuVUM C4DdLOHTwOdqtdKZyipJElOtlPgLjkFYqR3tVszbFmFj1w+O9cwjG+7vFAPjWXuUW+cIVMFWNOp jV/flJzRBGSlGcYe16i5QNFA7m9Qzg0CGJD88vfHRm9uNTX74cP38kaUSBpOzgg1AQIquUJJIGp I4DOUeqjIV7+iTEgY4sSf8St7kbibcq3eQ3xEtFoGKKywbN9CApVM7cIZdJzcKmU0fyqySSEmRj 8lc1h30D+b3h0OiIhtIDq/9MuqYaixlTPRjv/2lHz3sPhbxpc53zrFgBdIINFpCdnHBwU3o7WrK npIDQL9gHh+vnczj75OJxXKjEwkFpgTJgoZuwA40dO/9hcRBX+AxbNpeSqkUF/+5zIClxDmUWaq dQI/naX6lLaZe6a74CH9Nm3WhnkIGb1IaKlAJuzJQYRp8lb7k6kK9xRqKoggZml6uMmKGtbpeYH SoFVIxz8sihWmuOkQAjG/XhE4mm5AHpPLv14DptDA455gqcTCiKs0Dg9tBAGadxmQ7x36uBf4on OTvcB+Lk+SPtMfg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

With only one caller of lsm_early_cred() and lsm_early_task(), insert
the functions' code directly into the caller and ger rid of the two
functions.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 35 +++++------------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 09afa7ad719e..a8b82329c76a 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -291,34 +291,6 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	kfree(sep);
 }
 
-/**
- * lsm_early_cred - during initialization allocate a composite cred blob
- * @cred: the cred that needs a blob
- *
- * Allocate the cred blob for all the modules
- */
-static void __init lsm_early_cred(struct cred *cred)
-{
-	int rc = lsm_cred_alloc(cred, GFP_KERNEL);
-
-	if (rc)
-		panic("%s: Early cred alloc failed.\n", __func__);
-}
-
-/**
- * lsm_early_task - during initialization allocate a composite task blob
- * @task: the task that needs a blob
- *
- * Allocate the task blob for all the modules
- */
-static void __init lsm_early_task(struct task_struct *task)
-{
-	int rc = lsm_task_alloc(task);
-
-	if (rc)
-		panic("%s: Early task alloc failed.\n", __func__);
-}
-
 static void __init ordered_lsm_init(void)
 {
 	unsigned int first = 0;
@@ -382,8 +354,11 @@ static void __init ordered_lsm_init(void)
 						    blob_sizes.lbs_inode, 0,
 						    SLAB_PANIC, NULL);
 
-	lsm_early_cred((struct cred *) current->cred);
-	lsm_early_task(current);
+	if (lsm_cred_alloc((struct cred *)current->cred, GFP_KERNEL))
+		panic("%s: early cred alloc failed.\n", __func__);
+	if (lsm_task_alloc(current))
+		panic("%s: early task alloc failed.\n", __func__);
+
 	lsm_order_for_each(lsm) {
 		initialize_lsm(*lsm);
 	}
-- 
2.51.0


