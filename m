Return-Path: <linux-integrity+bounces-7110-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90FBAB7D27B
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 14:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59268526397
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 22:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737AC2F0689;
	Tue, 16 Sep 2025 22:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NxSYn4GB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1E92C0270
	for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 22:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060826; cv=none; b=aKOGn1u84/I+u1J+N//5p+DX96UbxizurqsrDnSw5dx9eo/UMfIIQC6Z8d1GaWEtcjCBevGp/XfskMiqWkJ4w6BTOyDbg4tXiVFd+rX3xxlVb0yx3wl8A7tD4I2L1ul2OypYfupDGlVMRSE5nYv5dGmujor7wsHZ/Fw5E6EZTbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060826; c=relaxed/simple;
	bh=NxdZ/tWxuHzB8hyuiHIRRp3Cv3mrcJQv+riXTlFds/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WRKyM4UGGUIgcHr9EiOQ0TJhZ5DqTnGZHehPOc4EJ0YfVEN2b2gT/nzSWhIy+oJA1t2Q8vWRRCmAww8Cj1jmvStwelFtDS79mPSuQmJt7j+fbhG1NHwzfOlGF3mlr2+erkFOyZOmCwP7DDBgbKdtwIFl/2WF0gky0Js2Rx8rB9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NxSYn4GB; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4b79a332631so38996821cf.0
        for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 15:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060824; x=1758665624; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T/5qYzOhU0hrJaBYmqNHrquPI+z7sd6TYqgmLaAdNBc=;
        b=NxSYn4GBRMO84iAnRf7A3X9awj+60Sm5E/B12cM0M5n0soRwaEdQmLbKh2QbA/q85J
         GE1vajRlVetl/cgE4WgxsZEbWvY5lFuf89wyh9DY/s6vUyVHPyt30GItRU05RtN2hUKO
         T62kutA4+BxUm1TPvCny2yQgvvsLlffIvwk0dWIlMYt4xqmVV6TJSJqTtof3KUy9re11
         HE0eayCOMXPioyQy67MWC2xdZx0oNpAswPoZs+e5SXuiqQTpzDJemqablBto5JAap+qU
         RcNNv4+dFipe1nLqyqoK85J1wK+36quoiyiW6ZMIPOSoMNAsYetDsNr9jTjEqqFKoKDz
         Bt8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060824; x=1758665624;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T/5qYzOhU0hrJaBYmqNHrquPI+z7sd6TYqgmLaAdNBc=;
        b=UfZLGQGvY1JceWlkUM666qnxzLVt5mXKDxJlmwVcNoyuDp/OppgqGVKaFy1FmfOfES
         iQLT9CGpAMCFgz7kno3mB0KdhNFWoyIaIFJQbueWW0BAmFeHlqHPMzK3faPEIvWu2izk
         icH0PAckl8Zi2J86SmVLtqlsRJm179IEUDNAyTL+2z4FAOpzynodI9NLIg9BsnEMbJeV
         AzbjKoFrRP2xaAZZpIPzkhEW2mMzA9yluIGL7H/lZkoZ8Vx3lZyTJ2FqQy47tLwswafw
         Ici+dndzyYYswk0WQOtRfd4evUKYmLe2TKN+QrvY8oHlxaTuz3M6lNMQiP1hOMKT1Y2z
         vZlw==
X-Forwarded-Encrypted: i=1; AJvYcCU+dnO00vzwDag8FdKEHIrQ5Jp1bG6fApS+r66+2sTEJLSyuFWcTiA/BEso0HBwixcEuT94e188cmvU3JX2ma0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkQRXH8YL5TEQQuxnvjQLMxY746ams7TuI/q0GMPvwK/YGE88W
	Hh0NyQmJQqymFHF0Obx3xxOHnunL/40PSGTLvmBYm/ogILhWPWkVHVYluK95LFAJdotc9+zbGoO
	ss4Y=
X-Gm-Gg: ASbGnctQ0U7GufgBbzYJnqb0Br2FeVjPPmT1S05GpL18PxUDLC+HvqnEcjKHJt9LRbR
	B7WMVVdPFHjZWLelCnJIonwyn+h8A2fD2DlENNyvZ2VR9n0o3y9OCZZT0MYAz/2AwiBPwyhfG3X
	KUZobVE6EHGjHG/wW/AYWOMrqPWfeRyjiDmj7bKGqByo1+Z5uKSDdIjHBnS+XLpXfT5w+elrlwG
	W4bHe8DuFbKJllbfkpMBohP+9XlL/rIYKb1hu9TfOJ5/oOxR/eZQ9Z6amlf1okmNUpbR88+t2D0
	B6wPPtvru+PkaPqAvxCW14Ng32VScwWRAtClrRYQiAXSXgW9n462eklrmhjghZGVrR/5Y9u38PO
	YOmFosxlV1tO03mD7PheNmNAZbJBYkOF04mjH+v5OfPO2qYE1N0Wc4QVXALUqAY8ZLhxF
X-Google-Smtp-Source: AGHT+IECKiHCrw4OFdF7Hw1xBFjzqPOtq+lpl5yRhb4L/72TC53JFs4AETBjUAQIgVLQ0POP7wFs6Q==
X-Received: by 2002:a05:622a:1827:b0:4b7:a98b:893a with SMTP id d75a77b69052e-4ba66d17384mr1077061cf.22.1758060823557;
        Tue, 16 Sep 2025 15:13:43 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b639a61502sm91267071cf.0.2025.09.16.15.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:13:42 -0700 (PDT)
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
Subject: [PATCH v4 05/34] lsm: integrate report_lsm_order() code into caller
Date: Tue, 16 Sep 2025 18:03:32 -0400
Message-ID: <20250916220355.252592-41-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2117; i=paul@paul-moore.com; h=from:subject; bh=NxdZ/tWxuHzB8hyuiHIRRp3Cv3mrcJQv+riXTlFds/Q=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd7ZRzJe/5snBS5G5Aj/nK8O9I8nsIWXm/b5l DHkynqKdYSJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMne2QAKCRDqIPLalzeJ cwp6EACIIL6giPq7uH3ejYHVkyIU3CM6RXFgYRgk3GcoCJ/eVkvGIN/lI5tt+HdamtVdbAfwzFs PMsyqTRuRthY3gIQMiR2sdWvv/tgnpepGeDmVxbGHI8uoeU8KOKAgV3o6ZSg5jtmPS0q/9Qk+cK Y5jqfA/AV49jkCI5krnMLXRgnmPzVmBQRmjcFDz+R50MgArCEHJm2l35Qa/YrsfW0K2+4E2b+tB AauLMiva062YFUrZ3cFZ+18sdegDBgF+xBNWXwW1fN36c1A2mxbvM7mBVcOovp6H4Falsuhbez/ oaV5HptTIOGXXeUBmmvdgitx6bSzXFqOupnUSzRWnFwIPkkJbKQW5bWDICz1fXEI0EAIYTkt2tk cFePC8oAcDZT08S/p1DOi6w/rMW/hekBwsgAPZOwQxUTHjs5UNpmPXko14V/6iiYzjEYcSMGnA+ HCRi1v7GOM79QKfc6PwJTwwz2sVidNYSDChAHRrLF4vUhj4VCXkLSgPWFNjDEVL1RPxH9DBIY9t KkfYGAv7OKdvAljEa4+mAbajqNXC6xbACHhyLMzGVre/idoBKNvZXH4J0HU/ZiF1rKHTiEMAFjc cqYn5FV/06evghIdF/ZU8lMKAd16j3/TjLFem1ga6Om9uLI9EX2mJ6tbdJ2j0s3yf+BQQo/JEhR RDW8slobgIbOWvw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

With only one caller of report_lsm_order(), insert the function's code
directly into the caller and ger rid of report_lsm_order().

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 33 ++++++++++++---------------------
 1 file changed, 12 insertions(+), 21 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 18828a65c364..09afa7ad719e 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -291,26 +291,6 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	kfree(sep);
 }
 
-static void __init report_lsm_order(void)
-{
-	struct lsm_info **lsm, *early;
-	int first = 0;
-
-	pr_info("initializing lsm=");
-
-	/* Report each enabled LSM name, comma separated. */
-	lsm_early_for_each_raw(early) {
-		if (is_enabled(early))
-			pr_cont("%s%s", first++ == 0 ? "" : ",", early->name);
-	}
-	lsm_order_for_each(lsm) {
-		if (is_enabled(*lsm))
-			pr_cont("%s%s", first++ == 0 ? "" : ",", (*lsm)->name);
-	}
-
-	pr_cont("\n");
-}
-
 /**
  * lsm_early_cred - during initialization allocate a composite cred blob
  * @cred: the cred that needs a blob
@@ -341,7 +321,9 @@ static void __init lsm_early_task(struct task_struct *task)
 
 static void __init ordered_lsm_init(void)
 {
+	unsigned int first = 0;
 	struct lsm_info **lsm;
+	struct lsm_info *early;
 
 	if (chosen_lsm_order) {
 		if (chosen_major_lsm) {
@@ -357,7 +339,16 @@ static void __init ordered_lsm_init(void)
 		lsm_prepare(*lsm);
 	}
 
-	report_lsm_order();
+	pr_info("initializing lsm=");
+	lsm_early_for_each_raw(early) {
+		if (is_enabled(early))
+			pr_cont("%s%s", first++ == 0 ? "" : ",", early->name);
+	}
+	lsm_order_for_each(lsm) {
+		if (is_enabled(*lsm))
+			pr_cont("%s%s", first++ == 0 ? "" : ",", (*lsm)->name);
+	}
+	pr_cont("\n");
 
 	init_debug("cred blob size       = %d\n", blob_sizes.lbs_cred);
 	init_debug("file blob size       = %d\n", blob_sizes.lbs_file);
-- 
2.51.0


