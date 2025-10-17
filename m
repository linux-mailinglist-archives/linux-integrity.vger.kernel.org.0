Return-Path: <linux-integrity+bounces-7453-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79BCEBEBAE5
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 22:30:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9F137454A6
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 20:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51175354AE3;
	Fri, 17 Oct 2025 20:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YsmF28rt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F82354ACE
	for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 20:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732938; cv=none; b=ntL9cvapSbv5yTXD855m9LMTNJP6hQ5EcyBSBIePE317DjS0GdEpY3apcImE0s3JBrIZm7/cJd+/sK0XHyI9ZqixGHwM5FvBRry1RnYrTMSIhLyveT8mEKx6il1ab+mdutydkprBbglSkSASurnrLI9o+cbMsoWBlXWV+GRaAfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732938; c=relaxed/simple;
	bh=qdUnMpBaVn9BGNCw1u96yzFWHDjooLF/olbdGuAgc44=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3NI7OzqXRjTr2MkYwnn3WVHC88lpjVcMyLHuqG/XHucpWSHMr1+qNr8fsLgYrpy43SBvnEqqpy9prJ/bx0TeQTFrlkdbpJ4Sl0KDgTeIE6IE/7prD+kCzWjxI/+XsAuNU3qwgS5Pg2Y+knHKhIM/ELXSCF4a5OiiNT/fMhiF30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YsmF28rt; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-88ed6837e2eso495840885a.1
        for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 13:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760732936; x=1761337736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gnyH9cbKjBW9gdzFmBf71O1ujrCNxqhuDpvD2UTHCA=;
        b=YsmF28rtD/Loadb1Ibn1BWaS9s2Lo1BPts6rJMB55WRrKYGOS2mlqlc1kEjLjUzZX8
         ksIagJcPr2d1DJxLhaqMzbSZUaGArWbvt+7e3kyYLOho8RsWByWaVoU2kzQZ4t56QcEe
         Fcna7xZsOxEfwF3L6W6inHy5enLUAPZ80dTL930nrhqRnML3/Z+JEil48KALjd7y4SA4
         8mVD3hObLCBZsDXVu7jBHA9n8S0e40YROt7czGPC1DtpP7zev/R058i5sFI5v5cKGf27
         DUwZMHrmZXhwnl3Ld+RuxZGqXdbf3GpNrKtRFUgDj1sqkf1+h6xLPfPb7PPHPvsc/bZD
         Gv3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732936; x=1761337736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gnyH9cbKjBW9gdzFmBf71O1ujrCNxqhuDpvD2UTHCA=;
        b=DRE+b6KaqJ4YwP7K6/GgKbbhWDFioHBqatVrIHixWeOJBgbhcZlaIPqzVPOUCAxDmg
         /GJ5yX8j+3ZrotGT1tQ/NM/Y3i1ad18xZ6L7cZwrJ5t7fhx1+NWJ6chlfZT94lCXzbdM
         LUnnwb2jzVwUdyzkMWg0tlnw3iwqsxSCQfbZHRl2LckNPo0Awsibz1tVpPxw5mLH47jx
         TYCCisaOwthtvKRtTt3IA/EXQh76iN1PZjCgcimHEeS65mLLGmVeARx+PDV7nFUkTwBq
         ueYNDmJzku1QyrsRxNP8ll9goW/NZ1ZfAAS6P9mgrZBlxyaLik7GMwVG7thp6qARn58D
         qBFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeBOusnqA5l7dePtGKZyWRWLsNmjSPBjh6Zj/4Hxrn9b9irQEGr3f00LHrBrT/mI0CE+GuF4Xgde51N3wmzzY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4yYLJDBso/UEixPk51wK3k2K5IVj2ze3c5Lxt3RNC5enqLBjZ
	DMnYcUtjbDc27sryjxgoa3O4Lx5SjhUGJlaDNlGyiiYNylDhwFs/gmZNiT1Lga5eaQ==
X-Gm-Gg: ASbGncsCu8NpHY9vrl8QQL5d6t3by4M0Cuavrz9Bz7xd8txe15rjGcf7fXl6Cs3QIPi
	vHRPgcGxwl/S8tFqMBjWHonIA0ZSwMbkcdyG9Q+xBfPKlBVwJcX+Gdyrxcj0JU284V/SMq/tSue
	4jsVopgf2PaI7d8Tv9mXEXHtGjZZ8D3wN6ypp8Ggkzn2XOCKOAbM4Yrm6Gi3YCDgPvGViTlOFVN
	antlmhcvVT7JfOyq51WMtc3UepTOXAxx3TNTdo81/CvXcNG4Y8wGvVhb/+aak0K1qvfp2N8htg6
	I4dEqCUNAKfEBc284xtQB7FKzfwP+rrLpBLqTAmgSjzEiUYysIS0fqiVB+OKRmUas9dvY5AW6Cx
	/Y3NnnTgZBaCYQHF9zWWyMa/nRvMfwDMw+YWuattfNXiMpUpFiWHR4aVvsbXFEqIuzW0fKTzEBA
	+3/2ZDH5WchajJyXTDKLks8bP2c6tHaGLXIshHEPeEMlLcgAkUA8Vtt5S7
X-Google-Smtp-Source: AGHT+IHQIBfcE+nIWOaxuE8TLpwMaeLiAUUd6n8/4MfK+EyLxPxrOWP5Phio26ynqjU/WCoGKSrodA==
X-Received: by 2002:a05:620a:701c:b0:88f:561:d95b with SMTP id af79cd13be357-8906e2d0126mr717378085a.7.1760732935665;
        Fri, 17 Oct 2025 13:28:55 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cefba740sm39301785a.29.2025.10.17.13.28.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:28:54 -0700 (PDT)
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
Subject: [PATCH v5 06/34] lsm: integrate lsm_early_cred() and lsm_early_task() into caller
Date: Fri, 17 Oct 2025 16:24:34 -0400
Message-ID: <20251017202456.484010-42-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2054; i=paul@paul-moore.com; h=from:subject; bh=qdUnMpBaVn9BGNCw1u96yzFWHDjooLF/olbdGuAgc44=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qYoWn5623fTKZwAy24y+L8F9fHQE+JKWV8eX vDWwYgACKSJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKmKAAKCRDqIPLalzeJ c4lrD/9KkEaJZF4fWCcnp/FqSd1LGB3hjfs9oF/aj9gL6UMe78OILLDZYYLj1AaNi5ddVIehpuk 2QwBovxW8dPJUOAuujnj9kyx5pvAFb4mU6p5zXI5udSzngtIn2qbz9hSPoxQkj//JCazECkewVa uqVhRulE6PAC11DdyTPc1gwm92hqNldFEZimS6V6mB1C8OUnrLx/RmNJCoyskQQk8IdfzzKt+JX dPpvwireTCAwi3bD8o88Na8DqDrZrSoNp9Ai2UP3hBkS+goSSwkhoSa1VZ5+BaGFEo3WGjmBLPC doWkLCVX8xcI1y+VXx8y01jaIozJkjne1/ZdqiZFZ4oP127UCr7Yeftc/xDCDDU4SHWZIZnF83j b6nNhe8DixfGSIAOW6sUidXVxuWlmaGw5kJmP680JkNDs2sRBkWz6m2kjI6NV46ZXfFL8fH2rfk JsORpgVal5/YGiaL1dsaxKv/PIJGxQgjuj6xzfatoOu40gZPWJBbf315bVL18XquxhJohRnjjh3 euY8Rt7ovrUv7RQ5zI0afCwF8AwcBF7YLhgugns8Fw6xggfABFNu4U06YTPe750nE8JZca3UJZF rLnE036lEcSXsPjbCQpxGq0vA7MVMFHvbzFZ4PAHo9afwXeuhGc0Pwlnh1iV/dyT1Nl08dksWHG FWUeOhlI3ILIomA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

With only one caller of lsm_early_cred() and lsm_early_task(), insert
the functions' code directly into the caller and ger rid of the two
functions.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 35 +++++------------------------------
 1 file changed, 5 insertions(+), 30 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 09afa7ad719e..8bb473aca113 100644
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
+	if (lsm_cred_alloc((struct cred __rcu *)current->cred, GFP_KERNEL))
+		panic("%s: early cred alloc failed.\n", __func__);
+	if (lsm_task_alloc(current))
+		panic("%s: early task alloc failed.\n", __func__);
+
 	lsm_order_for_each(lsm) {
 		initialize_lsm(*lsm);
 	}
-- 
2.51.1.dirty


