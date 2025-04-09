Return-Path: <linux-integrity+bounces-5710-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D028FA82F99
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 20:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F72F7B186B
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 18:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8A127780B;
	Wed,  9 Apr 2025 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Y8IJAB+D"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F206827C154
	for <linux-integrity@vger.kernel.org>; Wed,  9 Apr 2025 18:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224827; cv=none; b=jyuI/13agQGdzGm23o5McjeXCDmqmSG3E36vynxbwJqDHK8rmEbfiDlclDukig7c5qibLl3RJNFt6DDIntQnJMp5u+iIabm0E5Zy8LTm3huKiYwLrGCsjFk3L92dOULzXXBJmhD4aaCeT0RFjm0N8F3/VZg1xyCywM9dx0/4sio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224827; c=relaxed/simple;
	bh=m5SDi/Ws99YGf4fQxXOcnXDyD5cqe3LLHIxu36oK/q8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bVR/V4RRqb7Hqbp8Icbi7085scgiaR7JqrjD2P5+QDQAidpQHCh8g3eZtHg3aZ+06WZvRFbkusQYxO+xa2z6sYsUS8t0iT7vaUotOO6FRVT42sBrXRkQ1GzzU2lfP1oixFmOBjv8f5+g+lAyIbxTRTZMpZvT/xw1T5PtXuXM0kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Y8IJAB+D; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6e8f8657f29so58504056d6.3
        for <linux-integrity@vger.kernel.org>; Wed, 09 Apr 2025 11:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224825; x=1744829625; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3LwGa6v7K37aPAxJoM9V/ORkpt6P9aeqeyafgjS7XL0=;
        b=Y8IJAB+DJZ7BbDLN9TdbqpfWx1mdqevwHgaRphZ12fi004z5LiCVzGuWcgPDJfmMcc
         P6uF8la97ulU+xU6k16KSXX2Qdp+uvElfQjn5Zvy61bor5pCEkmVo6Bn3auMuSPoxU3z
         9dE+WAEkYV5eUDOK1e3eE9ljdGQaZG5ZFcVrZI1tzC433P8Bik2ACxIIVbijLAwP+x9t
         zkNDM8Y+WYjvqkPBaOVvp+x2ooJTgvSpyOXDGFU3kY4GxCK1lL3hsf+VPy5XgOWOxgEs
         cOJJCUC1TaMioI0Dh3oRzHIWza6noFdXrtb+I4/P7VoBKpdCKrhf6qtKDz3pxt9Uwz19
         OPLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224825; x=1744829625;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3LwGa6v7K37aPAxJoM9V/ORkpt6P9aeqeyafgjS7XL0=;
        b=hl7saz+k/GGQsPxj0w/J18gC1fL7S6vv5LjzHEe5j21oCrV1FzMpbQSB+jBdYnwdx2
         r2hkud/55R7uZqyRcsLwIomLgCleLv0hsOU6UrT2S7iJR5cZ5i+ABNNudroRpwpFKDGg
         uFABrKIvFhXJO+j6CCjEroFgPgS+olsoVHYyP0Vngp1hmRwan6ioZbXjf+gZkfS9LLBK
         2+6xx/OCGtseQVNQA26YTkAEnC0W6q9USFkPEzEYr5mYuEDEIxhuxfThWBvVgQwsKQJ4
         Yk+wCHUy8P6ZbZLsM0SGPwiIx+OVGAI4ADnCFSVh1EJ7qyz2lbp08bF1ZAOb8VAQmDLw
         XeLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWwBm0k8kTejprUFakLGFXuiCsr5J63PqrHkPZ6+7gx8XgRBUeOtufLPz9aApg7c9qiEqWfhRxEmDGRHwzl07k=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjgxQmuk/F9OezeqgEf2yefDhFjg1M2g+S7yvjD6iLoy3IwaNE
	FtzlTKUa2wwZaZTyle0snePLMMjlu/Tm4rWG3PyQVseInmHodcO2/l7lKcRm0Q==
X-Gm-Gg: ASbGncu1rtwMLB0TfkZGWkwwdDVrZsMthkFOZ9gNy1Y8TKOIS4bgKNXqvyx04Wb2z42
	k0s52pFG/mRA5SUrbHGazziXJSJMD8LXr4EaD5JOpZSrsvG1qBxfmgQAwO91FXQPNsd7pxGj2LJ
	9gm6cAVzN/HiEh1hWTwFb94wl5SVgyvyA/5PLWMiTKOjPULh4pv/bMdM4KtLEQwsciOpQl/aKF6
	Ho1FxbMfMpwm7rto6ptbrVsnhwuHVMrpFHKUXAA5WWN/a8uQ6NNYgyfSIG1dlze4aCmSxyvH90W
	7s3fB6MPXePr15BaWbw9UNLfjA9yX8xwXXYmpi3qXvi2iaRqAqi/lz924Z2K+zQnUxgrz74qC/W
	EvzcEnoZomQ==
X-Google-Smtp-Source: AGHT+IGgaqmfp5XWsFxY1xA/2lqF9f3q6zJGWlTf8/5spXPhIo85zJjIag/SaVzmO3byEJrZK8qH/w==
X-Received: by 2002:a0c:e5c7:0:b0:6e8:f6d2:e074 with SMTP id 6a1803df08f44-6f0e5bf4d63mr515436d6.28.1744224824755;
        Wed, 09 Apr 2025 11:53:44 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0de95f6f5sm10546076d6.7.2025.04.09.11.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:44 -0700 (PDT)
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
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 16/29] lsm: output available LSMs when debugging
Date: Wed,  9 Apr 2025 14:50:01 -0400
Message-ID: <20250409185019.238841-47-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1491; i=paul@paul-moore.com; h=from:subject; bh=m5SDi/Ws99YGf4fQxXOcnXDyD5cqe3LLHIxu36oK/q8=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sHKChmrczEfCENzDC+pQCGE4BSux72u/rOKi LyDwGDcHkWJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bBygAKCRDqIPLalzeJ c0liEACBjtJdV3P9wJwmBVYcpndOIjNNDeoEg5cXOjcXj0zt8UxLXmlzgtSgeqlgViWqhXcJ3/Z gzv8bkkMpYHWMdcKjcgwm4l2g+SYC/54zYW0GbDX+8hYi7vVafzMm0urmzVezfWXf2bWI2kAf0G Vth24pdK4ECfiZbv9ahaQ92l43GP4OeCcTaj8aPJnela4idSxxGqwPLxkKFcsBisW1cxXoXw6/e 9ngPRZjdSheh9EVe+r+yX1xIoCxsfYNylqFvCokCGiq5i2kv/z2QnymzmQdgEPFX2nvPQX4casB skGrc/GdFHexG3OzeqFxqC261T1s2V0H2htV7p1jjYmhNC/Z+cbzjAYzEeTsMEMqcGrYka897lA JfM1K91gFmHdOFixHHdccoGxuc5uaHbJh49SIvfb/lf1StSAQy594dBQOBeZBzqXS4YdV2zfbV3 DUZvBdWDEZbGLKnIGrmvpIXIyzj7+Cd2M+ipufGklHhQJmR/YKM63TzuNA5zCnjgFN30fYbWL/s UKeNtnrVY5cr3Ma1KSnQAVQ3I/v+TQp0Lr6Pp2fH7XjWiXrzlidJWE3BclbBTAWSr9nbYyLxw2Y UFklhUZDe2pkSPWp3bXINAbLuIy8G/zOTDWQEUg1UMiq63moES3c1IDeLttNOMSrQPTgn89CBEB dsPntWBtJ2AJUng==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

This will display all of the LSMs built into the kernel, regardless
of if they are enabled or not.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index aba1253ffc4c..8e00afeb84cf 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -363,6 +363,8 @@ int __init early_security_init(void)
 {
 	struct lsm_info *lsm;
 
+	/* NOTE: lsm_pr_dbg() doesn't work here as lsm_debug is not yet set */
+
 	lsm_early_for_each_raw(lsm) {
 		lsm_enabled_set(lsm, true);
 		lsm_order_append(lsm, "early");
@@ -385,9 +387,24 @@ int __init security_init(void)
 	struct lsm_info **lsm;
 
 	if (lsm_debug) {
-		lsm_pr("built-in LSM list: %s\n", lsm_order_builtin);
+		struct lsm_info *i;
+
+		cnt = 0;
+		lsm_pr("available LSMs: ");
+		lsm_early_for_each_raw(i)
+			lsm_pr_cont("%s%s(E)", (cnt++ ? "," : ""), i->id->name);
+		lsm_for_each_raw(i)
+			lsm_pr_cont("%s%s", (cnt++ ? "," : ""), i->id->name);
+		lsm_pr_cont("\n");
+
+		lsm_pr("built-in LSM config: %s\n", lsm_order_builtin);
+
 		lsm_pr("legacy LSM parameter: %s\n", lsm_order_legacy);
 		lsm_pr("boot LSM parameter: %s\n", lsm_order_cmdline);
+
+		/* see the note about lsm_pr_dbg() in early_security_init() */
+		lsm_early_for_each_raw(i)
+			lsm_pr("enabled LSM early:%s\n", i->id->name);
 	}
 
 	if (lsm_order_cmdline) {
-- 
2.49.0


