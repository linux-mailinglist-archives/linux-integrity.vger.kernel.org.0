Return-Path: <linux-integrity+bounces-6680-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAE5DB0CDE8
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Jul 2025 01:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C595A6C4B85
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Jul 2025 23:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A75A252287;
	Mon, 21 Jul 2025 23:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NQmR0R4d"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD571248F55
	for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 23:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140262; cv=none; b=QY8LjYwQtuR7FLILvFejS/cfTavm1bVixDwMqtDMr5rv5/VpRofDB8pdOk0ZoHyz75BkvHlurVWxcnR5SX0JpeX+f8PLlfhPtymkntatcKDa//94blFhSV46J4ylKhpXaGEC5gkhZxDObu4GqhN2In8sLFJpMzzfLz/ZSIZzl74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140262; c=relaxed/simple;
	bh=fidhY7A2GG1L6WcBRW+xXRpj5fg56e27Zf53wY+JHrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GONJV6rIE3PYcFQjE/2Ez0RmIXuk+0OYwaJDHH7pSGnSw1ZqP5+5vAbxiZihr1LHSmBMkr1Z/p3WNzI3U5ABtjCgAsYEziZGXDCvJb5hACR2Kv2EbAFBD2GxumkgvxKibuIhtUBHFs7buWvNv0HNarl3sCqejw3QLYFbZhdme1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NQmR0R4d; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-700c7e4c048so78431666d6.3
        for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 16:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140260; x=1753745060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRnwbk9lPTHMa8PngQqUNoOqehgPrJsVsru9KsQBvfY=;
        b=NQmR0R4dlOg5GounD19mizyA5W9iSmBiIL7a1P65XU078zessM46ZYIyhZMeA7Bk/Z
         OXni8iI6m5+/y8KcNCuwhusoQE15ukRvcRhnGBeMxJw/ycheke6Bqi5KZx58f6Ezh+l5
         2cLo/TgB2RIWxC5sQ1UyQ43w9gJmnlxasiS2W9NyWpCsQlP+QDPQLnz77W8FsyrgetGk
         l4v+Ufh/TZAn7ij6Jjf9NEIoC4GptmJ9sob8U5JLDuK9xgnvCFk2DJsLfOlDZAHSmuMK
         3VeBCf99Fk5z3B/bMZSpuExzp7BJbJE/RQR9qBmFgF3BsFWKCIm1/aMEk7cKXPF6/fMG
         GnzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140260; x=1753745060;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRnwbk9lPTHMa8PngQqUNoOqehgPrJsVsru9KsQBvfY=;
        b=HableJbeXBi1BZGgIqwgJYGJ2B41cZoOxWA6UrvDKsWPmts+Lz3qR9qr1LBn0mO2PT
         6xA9FGC/uiGIR323wLck9wo11B6i/mzLBbpWmzEeWuOqiKGeOsnv7gpJwH8ZqRA072V0
         liV5bVlSUDupM/ClsfSKrGmDdrhHyV32FpGIAFfZT6nCS9WbQzIJOBkJU3qHifXSl8Lv
         bLNwFQp3S3QUt3U86ZvwBiGNc4reDTUWBzUF1IcuO/jWB7bu5wFPSs8Po0ETSRwuxz9O
         +PxO+knRizA3OP0ONx40Cl7ai2pcs4MW8KLKCwwTN4TOV1todu3xhZXY97m9DD67RXaJ
         S5UQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVnCRYGcuEufgA1ccgO4Hp0Mhre/FKvp2Kzi82K6RHzT+x3DojuoUJJtTVJvHfIIu9zlNvnSiMWEm0QL3K/Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxboxj+NlXKpYGTusUQRuhlL5Eg83Z5NT7VN+ggczuT75PCwAw/
	iYyg1oxHTwPEYYK9En4uZMmliTt4VPyZ1+B1BJv9O98UnvXEVcmA5LBHmb+BQYjUGA==
X-Gm-Gg: ASbGncts1Snwl3F4kpLs8hENQEvALVovB1IOzF/dOtc15Xgx1klQaj14wsMLy6FqNrA
	tcMqv/94x42/H0GUlQQG/qM2Qe73ApGFKdQZRSd90mY9g2OM+MnvbH1vEXysgJvshMEHFFPrOvC
	XDFpyRk+vpWf6HtBPXLhKGu9EEkEL/1S/f0Lcfvi8yTzfh6tfZHg5+/XmpUxwRdFsJrlmujToyy
	lJNXcebDyg76MX+xiyQ1B9urj08IhNsy6PXPmWTvDsZDoUffrs2o5B/DPU5tLGCkNTC37K4DSjm
	wb093v0m00L3DzoIqrkOoaRrONAMOHimCol9tHa0mBFP26hHF2Xr7T5rFnBOVjlANhTS7tVWooG
	Enb5eY4tBlYhN0twrD2I+/Rfwa1mB6IIPsdj4A85xYhmM7+ElLoHPfyLTHrO7EsrMnow=
X-Google-Smtp-Source: AGHT+IH9IQfwEip3Zt047yAPVHjA/lrnVk3FQWqrGgPKNMqgrc26LMN3+kGJ1u2fLGhsg0sQ/DZCeg==
X-Received: by 2002:a05:6214:5192:b0:704:95c6:f5f1 with SMTP id 6a1803df08f44-7051a15125fmr247201716d6.34.1753140259780;
        Mon, 21 Jul 2025 16:24:19 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7051b8e0512sm44672116d6.28.2025.07.21.16.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:19 -0700 (PDT)
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
Subject: [RFC PATCH v2 19/34] lsm: add/tweak function header comment blocks in lsm_init.c
Date: Mon, 21 Jul 2025 19:21:22 -0400
Message-ID: <20250721232142.77224-55-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1793; i=paul@paul-moore.com; h=from:subject; bh=fidhY7A2GG1L6WcBRW+xXRpj5fg56e27Zf53wY+JHrs=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsvMC6Rp97jlSGqqAJ6AS0uOBcwCHGxLqjYFC Bc+O4GX2LKJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7LzAAKCRDqIPLalzeJ c7p2D/9RZgxDXM6i/5ySB+QBfn/HFUQ8lIdd4Nk5wXEaH3tSiMh19UxYdWxTrjQdN8oJveX8TTq mwxWtnfb4Px2JLiT+aztBGyMrgMY7hOPgBuzPAj493fSjJbaWkx/rEBj4wqks3RCdq8+jOdt1Np y5RtePZoEWsZldo89U5sb4ewmGqcQq8LHE9yaEc/VrtWK4gcWx3nlF4Da5gqDrVydSSSfpcRje8 znByyGgb7ck2l0+hdK7K8xMd+OK48DbVFslvvXXb22n490SDG3nFUACOOc33mukabPBfcH6+sV2 nbl2yq9XDDufeuVWYJ14/1XU6tOR3oG2movSbXpJ61UwyUitkuBA2uVikt52z6r1v3RusaCeVNx u0ZcSJ2VRyuA5EDnL5o8QusNx411dxovDjadeH9nT2hY4G4YdkYVJBnNVS/KllMLR7+i4wxpBKW m95HBSSeq/ezu1WC0CgGHM+XobqVMr3dclBpWLIbM8VjBcspJscaQ/LpmbWFHmK7fJ9NkVkhP2L CLPyZknHnLe0JJfyahsGer2bI5fZxYgwe/Jc3vHpmTNfmaXyg+MY6pZzQ9ymqD1UCk2KfzRH5PJ 9Z6EH9cVU56xU8L6siFNe6/pBsHTEHzs4zgJTy3BjCCMFalF65Zi+lgN+K8gN5yrTjEBxRIzYeg Uyp8FD61XvK5ODQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Add function header comments for lsm_static_call_init() and
early_security_init(), tweak the existing comment block for
security_add_hooks().

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 25fe0c89e884..75e97f6b530c 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -312,6 +312,10 @@ static void __init lsm_order_parse(const char *list, const char *src)
 	}
 }
 
+/**
+ * lsm_static_call_init - Initialize a LSM's static calls
+ * @hl: LSM hook list
+ */
 static void __init lsm_static_call_init(struct security_hook_list *hl)
 {
 	struct lsm_static_call *scall = hl->scalls;
@@ -332,12 +336,12 @@ static void __init lsm_static_call_init(struct security_hook_list *hl)
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
@@ -350,6 +354,9 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
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


