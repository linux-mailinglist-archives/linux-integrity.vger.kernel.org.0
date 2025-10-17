Return-Path: <linux-integrity+bounces-7457-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D32FABEBA70
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 22:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B08694FF403
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 20:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B2F354AED;
	Fri, 17 Oct 2025 20:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EqKzJ5/Y"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977F6354ACC
	for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 20:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732948; cv=none; b=tDNcgI2iEtzH+bzYPmSWW+XtS9C0yxDPkCSxflN83b4YF3eJceYRHTjgDnKPs0zgPOoR+tkcanL8SYcECpxmzR1L33ziYceYwIRiQpzhxgq2J/nYOhGEAjs8Wigyh9ssrm1mb2G/yXptCnE6VlEaLvJHUbzt3DCUS3vrHweDTRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732948; c=relaxed/simple;
	bh=83Vo5HvqAjc/lgvBhTja2wjt9bDFMSvsGhWzU63ltCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGGepZX09rOfuT9eoNLMhYgurvmO+9uN3PCvSK0H/dYAN1e6DBPCtzE1IZSP08sZ7rxfxW3Wfg4TLV7z61cV1BRzCFE1dqR5Enex5MYb68tmzoeXcho5iBpxx/gq1e1JJF+5DfLCuwK+SqX/WjEJosvT3Z5njo3CXopCVI7Pwq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EqKzJ5/Y; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-88e4704a626so340166985a.0
        for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 13:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760732944; x=1761337744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sv10Yvg8poDHRXar8VHP+s5rj8Fg5CQ2bSFzXfA0WR0=;
        b=EqKzJ5/YBWO0QtrYrN3J+ndjsJS00kC2JOJRUDoVMf4z0l4hlYNNTpp68tyfCWTRvV
         Svpiq2VxeQxs1jhQtdGSFJvqQ5xFN/Sm2Jdf0AEU8S5T4oDq1UHfnETjZ1Yp/avNBVbU
         RWwSRiuVwVOwayoNKFdeHJ/Ih4+NFLT0yMxlGhNwWesn4aB43DvHr7X3FQRhEs8GSLqC
         9bdbfl4vz5fdb5gznhrvo9J+FrpjwfljvP4TyLOyw9spgLkf6G5D5PweaH+LPcINnQb+
         aitYDk2BSYdMnB07yLnzOy+y2m6Wil4g6JQMjx/opVLVIIBV/c7tiNDOFouxPhSif6tT
         ehAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732944; x=1761337744;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sv10Yvg8poDHRXar8VHP+s5rj8Fg5CQ2bSFzXfA0WR0=;
        b=dydWKBcdPn2IUJvmEljjD9vVIPaNIFu5MpU5rE7EIKjvjVMdT2BB1LeAZrJ8a9jShS
         5CgRtto5u0fEViiuaD/dnhjhuXkEw7hG682RZ4xDcHDoOXT+migYP6Myg4RFtr44kvG6
         0aVzgkpZL41EhW3RzTmA1XmNzDg1z3V4SEHhkeEG67toIZuqrXMsqNPALsP8QYHZB5IB
         SQOtUuVZSn7MRmjOZtGImxdaYgYttI5eN3tCKg+M32Zh0RTDF+cGLxGdjc+gxysFY5z5
         1btP7MfvL2vDNvAglNgrflqEiiIxkIpzTSFl0D5YPAVHcF3PX3joq9C1vg3Al5UjNn3x
         llzA==
X-Forwarded-Encrypted: i=1; AJvYcCXDX7Kb0k9tKWp778s46P21gE68UtFwii62WTyicdBkJ2boegB/WMf1Xt8Fi4C+MpPc0jZ3SJvVra2rp2zYY6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxU4/SPiO8hspUdATEYZa6ka4586OZYAEM9m1YYoQHZCFYRUfxB
	b1P+lIQgeS4Qpo1zhOj2MPRZTb8DIp9L3rqx7H+9W+b6vhpILdBLH8CKSBc0BUtyaw==
X-Gm-Gg: ASbGncuuJLrKq/Dhwkac9bkUpyS8sPPaI6ApO68L2cCdQb8UUu5i3BG1rAA4ppVY8gF
	XEtYH6KKGIKZlfEhIcVwmvQ/ILSlMtwgmnqRcQQjpRE1+PL7LPeGdIQIT16BZe3eY8G7oteJS8L
	hRrmjH7ooBNhLlvp0A1kCKreZA+qqblzUzk7igFvOr3bW8QYIDUF8XvtsEc/LopSglyJ16TlDQf
	ONogDnGMPp/suyMbrd2/UfbS8bn/A41cjSqFcN7TxOldpAKu4NQPSZHY9Z82DKar6ksEP1U+CUm
	Z4l52yjTaCQ6F/mdEfFyipNR017a2hUdNoNv4TobiZ8UNPOcqh+7HMuVtMagVsEPhZlGhvkLiMc
	IvOgQ0PGBxDnG7atfEbe+jcVudwmEFiEO5DaLZBOCkzosFnhWM4HTcZ4R9ygsPNt/NcADFzW+aa
	Y95B+v9jxCJJTu9rApbpV0xdvOi9p7l/wm6ME6EKQL/gfQ95zNKS0/uwGG
X-Google-Smtp-Source: AGHT+IEz2hWe0OAF1xfrMn5cxI9HIMPzaCkVI3uGSO08f+4fy9htghcYQ8g2PHAnMdYx9bbwSJlwFA==
X-Received: by 2002:ac8:578c:0:b0:4e8:a95f:9a61 with SMTP id d75a77b69052e-4e8a95f9d13mr28033391cf.84.1760732944408;
        Fri, 17 Oct 2025 13:29:04 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cf0af579sm39814485a.41.2025.10.17.13.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:29:02 -0700 (PDT)
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
Subject: [PATCH v5 10/34] lsm: rework lsm_active_cnt and lsm_idlist[]
Date: Fri, 17 Oct 2025 16:24:38 -0400
Message-ID: <20251017202456.484010-46-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3088; i=paul@paul-moore.com; h=from:subject; bh=83Vo5HvqAjc/lgvBhTja2wjt9bDFMSvsGhWzU63ltCM=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qY1/lTSJU8Yui3usS7r9sApGSJrkTprrPuiM B+LEB451TyJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKmNQAKCRDqIPLalzeJ cw4fEACCBqZtYqcG1lXxZY9RDDrNaP+KlPvmHoMV7ccphZgrGCXTj/oalu+6IriVPPYjuoPRj7Z d0TtpyocNtukGkKi+row07zgObvf3iyR02w/m1Hfykr2GiRQDLEPYI0+yxso8WH6cS1zjaP4ufD 9l+Hpg2O7o8jZ+BESJNHQcmzGqul6B0Xw715HZk3BIQQS1EQ/5JaiwK7MjbxhoNr8MosTZNmp4x RyIB6eNvY0wgk/kRf8IgWaY0CwHNZ1MNU6lu2u01Qbnql8j7sjuE0NtQZ40vvMA/5nf4sRdH1CR 1uEZvPWZyTyzWqsELce0nNyZnOoQ2SKTZN+QDQ2+FH1mbY6En7agpL/aGYwIPRyC4FqTwkI2US8 +sAsRSoWb9tOrY1To4dooyxxI949WqvQgsysjzbHNZOb6cNbwHV9S7bsMGG3UvTGQhmY81/xPas F9cyayrPOMvkCBC6UFLH3/auQgDFiK6YjAuOYKDKOsUwmXPELQB34Foj9cVEohYFITS/5DCJFx/ vvWPZ74lFiRQyoejAgDf9QeyKFPZbz0VfdmVjmeGRW41xSINFBMytAT80AZflg7BtgHZcs14JnV jIoez5JtsCgH4k/Kzv9WPLe4evGUhrpBPFg7GW0ZVb70PRy1gNie0fbPtobVdVkXz3T2qAUqQCS MjoSX2yckZpCoWw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Move the LSM active count and lsm_id list declarations out of a header
that is visible across the kernel and into a header that is limited to
the LSM framework.  This not only helps keep the include/linux headers
smaller and cleaner, it helps prevent misuse of these variables.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/security.h | 2 --
 security/lsm.h           | 5 +++++
 security/lsm_init.c      | 6 ------
 security/lsm_syscalls.c  | 2 ++
 security/security.c      | 3 +++
 5 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 92ac3f27b973..556890ea2e83 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -167,8 +167,6 @@ struct lsm_prop {
 };
 
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
-extern u32 lsm_active_cnt;
-extern const struct lsm_id *lsm_idlist[];
 
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
diff --git a/security/lsm.h b/security/lsm.h
index 0e1731bad4a7..dbe755c45e57 100644
--- a/security/lsm.h
+++ b/security/lsm.h
@@ -7,6 +7,11 @@
 #define _LSM_H_
 
 #include <linux/lsm_hooks.h>
+#include <linux/lsm_count.h>
+
+/* List of configured LSMs */
+extern unsigned int lsm_active_cnt;
+extern const struct lsm_id *lsm_idlist[];
 
 /* LSM blob configuration */
 extern struct lsm_blob_sizes blob_sizes;
diff --git a/security/lsm_init.c b/security/lsm_init.c
index a0785ca081c7..d40f31e79bd5 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -217,12 +217,6 @@ static void __init initialize_lsm(struct lsm_info *lsm)
 	}
 }
 
-/*
- * Current index to use while initializing the lsm id list.
- */
-u32 lsm_active_cnt __ro_after_init;
-const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
-
 /* Populate ordered LSMs list from comma-separated LSM name list. */
 static void __init ordered_lsm_parse(const char *order, const char *origin)
 {
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index 8440948a690c..5648b1f0ce9c 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -17,6 +17,8 @@
 #include <linux/lsm_hooks.h>
 #include <uapi/linux/lsm.h>
 
+#include "lsm.h"
+
 /**
  * lsm_name_to_attr - map an LSM attribute name to its ID
  * @name: name of the attribute
diff --git a/security/security.c b/security/security.c
index dc9734f0d45c..b4eec4f00730 100644
--- a/security/security.c
+++ b/security/security.c
@@ -73,6 +73,9 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
+unsigned int lsm_active_cnt __ro_after_init;
+const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
+
 struct lsm_blob_sizes blob_sizes;
 
 struct kmem_cache *lsm_file_cache;
-- 
2.51.1.dirty


