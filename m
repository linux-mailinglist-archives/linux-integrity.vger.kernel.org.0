Return-Path: <linux-integrity+bounces-7122-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E566B7D715
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 14:28:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D68147ADBC7
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 22:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C121323F73;
	Tue, 16 Sep 2025 22:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TQ2shi31"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764232EAB85
	for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 22:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060850; cv=none; b=Zy6/LGg0QkUaRnCkYwlrWTaLihM7aJYK7tIHD8IBErDwhFUjXGaQQbHg8wqcxJXGMpbPuiRYkjX7UrIKnm1uwWnm93J9MfHuO+MkRUJ0U8K+Yf7dSKs99AOm8c2Gep7HMZwoIDpRiUfAoD58QytbUsVzPzjAUAi+596tTQnVuf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060850; c=relaxed/simple;
	bh=6iVN3OLOmVoFwnICeJlzLw8HdvALLuk2uFZVFrho5+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LDxdGUuHW27r2JU515fNceFfx4xSTbZOxL7Rwd7lLmUk+GdsPf1jFXbOl9LgZNZZiIAXgSX6TBzSVbR6LaVPhl4lO4YRUwfrjKERCgZEh3OhLJ7i+5DE2veJ6TK4wV0C2F+K0l2kj5eS/n6xOLdrYNGh5KrJpumrvjABUoRLvb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TQ2shi31; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-826fe3b3e2bso400056785a.0
        for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 15:14:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060847; x=1758665647; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=899Mh3zDZ5uvyplQuSo5916+rpf69KLdR09DwYYFEII=;
        b=TQ2shi31G0oANGY4sFqMwuJDemJG7+o1qMBUXpEsyWsxEb/XgKP72YHkU38yjCZ2g4
         ewl0HKToZXGfpXfBpXyiEiZsfAq5N0Y/m05x1nMuk3K3uNKH1OCHzgCq9rHtcHlU2n2M
         NyxqMW8eeOcF6XzKh7QBtB4IQ4hIN1VTpx6MubH2zORFdRC/x+BK/NBWj6QHu/xf4K/C
         N0IK1ykVBx6iE//LWDzIKh/DGn3Hfn3cu5d71IFyf5wOz9kzTrjNw2BBWxuTbyg9XPQo
         GHEJ6hzJ8S5dPfU148YrWn2NKMMbgZ/ppySywep7WaiR0PnMHjBHl8JcfBPBPs1y6saC
         Jl2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060847; x=1758665647;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=899Mh3zDZ5uvyplQuSo5916+rpf69KLdR09DwYYFEII=;
        b=UQH+/1e/76c1blQs1yZhxIYyc7Ga7RhLLdwBUIVjjat2munfi6FYgOkhfoB0onEIl7
         0Uuxm5DzteSKpk2qncuI1hC1t5B7g8qtIlrehlP+E89ucLONXwx0B55CkYwH/zy3ClTl
         Hh0S5Wn6nCIteNnDGEBBKIwwHLxTmiYsGB8Q7rLlKCfrMc0k4y2qgrPC5YwbYuE5ohhM
         wi1FSPzC1eg7nHaSBU9XGb3a2LAqG6GoI95N2doIDh54M+5wJWXEoIw5ywigei7TqfUj
         cASsNiCvIGF9VCaFdXLwAXKPbYyewyNpvM3CcUlk2Lt23SC+nxrLsGiL/vRP3V8MKEOq
         If5w==
X-Forwarded-Encrypted: i=1; AJvYcCXDRQrkH8TiARoBUwsV70zQI1gxrxJmCxKM38NKkGd4c4XvENqSgyIeea/Ir685BzDYy6cXJNLaLWNbCaDiDuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YylglvDOgYvGOBbj015aiV7K1cjhUw7cM5XN7bpO87XJp2M9VbD
	4IShMnndJEjFtC5oAauhO0mJknHPPuk41651UFT1LGN6x4YnvwwyJF+ezS6iEiWG4Q==
X-Gm-Gg: ASbGnctWiMkyaFC/5KkRIJI13Y/hIo6PMD3v6CxQSXV2dk8Y/7ahx4T/jfu+jqDqB95
	IPWzuCJfzy7tawBdbqaW4+jkq4iwd9pYuSToY9Amt4s7J7lHZXSBDf2VxUi0x+kBDK6qeQ7xj2K
	Oo3TXx0pBP/FgumhMddCHNl524LYI49GyZswlBs5aOAyEDO8+sJcxGYCWOQ7bqml87PxZeWSWeO
	mG/qXKXjSFnVaTLstcFkcM6be4kNfqRBqq9hCD+J+kK9zys9ttmTVgeIczQBfaCesEJT7s8yHGh
	PdV8jFB7xhlppX0kjGPk2HPWZjknbiO98T9UOBPOGZvrqfOL2zHzZEOq0S4Ji7pqqSpeopo4o0a
	Nxa8W7FLZvkffwIk3080ld2W21czJArloHOKJL8Ovxet5rDvD41vXr5qFA7bUE+YuvGKd
X-Google-Smtp-Source: AGHT+IGJB3GEyjhz+uQqndf2tkbRwKtGTQPG96aiLoH9bW/V8p9c3nIVwNiHDTGOoXUqRqcslPVEBg==
X-Received: by 2002:a05:620a:25d4:b0:80a:436f:18e6 with SMTP id af79cd13be357-82400ffa501mr2045028885a.70.1758060847298;
        Tue, 16 Sep 2025 15:14:07 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-820cf8c8b87sm1027022785a.68.2025.09.16.15.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:14:06 -0700 (PDT)
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
Subject: [PATCH v4 17/34] lsm: cleanup initialize_lsm() and rename to lsm_init_single()
Date: Tue, 16 Sep 2025 18:03:44 -0400
Message-ID: <20250916220355.252592-53-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2206; i=paul@paul-moore.com; h=from:subject; bh=6iVN3OLOmVoFwnICeJlzLw8HdvALLuk2uFZVFrho5+E=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd8Ag0K8rFp25ZbJ7VtTqeRLjyAZFCPXUS04/ WQO7lxNsOuJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMnfAAAKCRDqIPLalzeJ c1gxD/wODltP1SVkhWVSDXKCZiltKi1KLW4GhjngNBbvDAuQkKSpu0BsCmF9deVEOskFB/5BCcQ LuV0uFJUHKWGhSazTaAlz4ecbBv7h/c+PjkKd7WxQ94LIBWUkv5grnv6NrV7KBPJJMP9B45WY4L hIkL8Dv3I+dLVFMDSsl747sH+8FjvFEr57DoUW4eMv7437EpENCdp1LCfdEEvCSOmGddjhB3leR f2EwqvWb0xXAlY8UpGv0ClJ7+TaTMfTAicuMnCg/jsECWv5diGZ9s8ZqUyOKWqTawQkEb7u8SAc WNCChBN2bl5GnELpLL3kI3QsuAU0ddAR9kfc5SX/wr/YBBRdnl976dMOvjrZ1AMDcV64M6WpcIH iVmXXoK9prIBryLE+fWGjO5uT0dXrHAA0XBy3UDjvuqVLZh0ZPtVmQmATEIMmkvjse3ZN6UDdHw splQz7fB6vsNd1ZXmm+eIKTRLDwgCEhHIla9L7MESLaSBWfolunghCGxQBGk7TGz8dRVxevLMFi s4HhPD3Q/ml93grPdRjUEa3UNnT+0NQdmO6oGmMpb4dwmTrjeSSzYm/pAWqryqKGtmOiV82BfJV jGmDvWMf6i5M4NJ9eXOJoxDGytyOGPoWcuzBuGwlBKZxXPRy33pQRqkUHRrQQ+cwL+nyN4WdUBc x/ye0Fps9U+5HnA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Rename initialize_lsm() to be more consistent with the rest of the LSM
initialization changes and rework the function itself to better fit
with the "exit on fail" coding pattern.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 5249aa044d9d..1f64222925c1 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -169,6 +169,7 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
 }
 
+
 /**
  * lsm_blob_size_update - Update the LSM blob size and offset information
  * @sz_req: the requested additional blob size
@@ -225,16 +226,20 @@ static void __init lsm_prepare(struct lsm_info *lsm)
 	lsm_blob_size_update(&blobs->lbs_bpf_token, &blob_sizes.lbs_bpf_token);
 }
 
-/* Initialize a given LSM, if it is enabled. */
-static void __init initialize_lsm(struct lsm_info *lsm)
+/**
+ * lsm_init_single - Initialize a given LSM
+ * @lsm: LSM definition
+ */
+static void __init lsm_init_single(struct lsm_info *lsm)
 {
-	if (lsm_is_enabled(lsm)) {
-		int ret;
+	int ret;
 
-		init_debug("initializing %s\n", lsm->id->name);
-		ret = lsm->init();
-		WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
-	}
+	if (!lsm_is_enabled(lsm))
+		return;
+
+	init_debug("initializing %s\n", lsm->id->name);
+	ret = lsm->init();
+	WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
 }
 
 /**
@@ -379,7 +384,7 @@ static void __init lsm_init_ordered(void)
 		panic("%s: early task alloc failed.\n", __func__);
 
 	lsm_order_for_each(lsm) {
-		initialize_lsm(*lsm);
+		lsm_init_single(*lsm);
 	}
 }
 
@@ -429,7 +434,7 @@ int __init early_security_init(void)
 		lsm_enabled_set(lsm, true);
 		lsm_order_append(lsm, "early");
 		lsm_prepare(lsm);
-		initialize_lsm(lsm);
+		lsm_init_single(lsm);
 	}
 
 	return 0;
-- 
2.51.0


