Return-Path: <linux-integrity+bounces-7469-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F0786BEBAC4
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 22:29:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA488500AE5
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 20:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62062354AC3;
	Fri, 17 Oct 2025 20:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="F1vEkAyg"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D75354ACB
	for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 20:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732970; cv=none; b=M4SccPJdtCAXh8KYwOmtSQuY8RSz9Epqnax/OWOQTD/mb0/VJ5Igh3TWkD8y70jjJi4lyYFNZChs/RP461/iNIHij5z9623yFHFefw+rjerMP4DX9xc5sOwUPBJK0PfaZBKWkdGMuswpWHynkOlJ4DU3eGpsFDFuvwclMkF0h+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732970; c=relaxed/simple;
	bh=buJBnNY6xRAiYvKynjWYzclkfyX8UJG0i5UEwl0AnV8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z7aoyH1mByZUUFnyoDotuR0p7tEH387bHDbbsy1VDWXSvZAHPxznEFhST4ZcQl3JzukYp79zAyaqreN4kRzkKr8THK9VmdMYz8bD7RC5yCsvyemIWaNwn3NtZTnGKk4EmOy4I5XTPGJ1fBAYNialnwwahlSS90IQgcbBU6BMI0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=F1vEkAyg; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-87c1877b428so40369536d6.1
        for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 13:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760732967; x=1761337767; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CmouHXyAlCdfISQnPeQnDz4oV75mD2MuR+ljlGK2IOQ=;
        b=F1vEkAyg1e6B5Yg/sE57JcdnfFjW3i7I0F+T0rJFNNgTHzySkxfiMgTkuBmsfZdaDo
         rok2NREvEFlzy7shzLqfoMvuk6JarOBOT0bxN95/bHzkwgP37xJe3PSnFtt+kP8tXOtk
         7qQjvkMO4ZFC/qX3+zIhidXB5Z9o3a7tmYvllpxMFtoz7a5vI+mqyQCtgcszfghuIfu4
         nBC0Y8q7/kJf1lybkUMRL8ejTNVJjNWNKO7PXgCrCvutS0CbmHZ2kBbMLLuvmjOvUamY
         /03dNZjPuQ/N/BC7qghzEbm7QXiyJAPMK4AvjKiyb+hOSrOCdagGeOcWTlpxiOKRjhU0
         poMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732967; x=1761337767;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CmouHXyAlCdfISQnPeQnDz4oV75mD2MuR+ljlGK2IOQ=;
        b=t0Av+dpZ5tuZI2Ni00b2HEazcL3DrJkV0CEJokQDxVV+4k1gnorinljIZtr5Y85RI/
         F+Hrxpsx0AtNt78tzczZJNh4GLZijREZvEplg1UgwhwzMvIZAfLXAZWujbqFAGVXaNPE
         PK+V3PuTkQ8B6RmBU56VQiXbs+3qRKCjv4LXMHYq75rj5PMjkiblNlFfwfWv9ybfZbgi
         jspebj4UcgptssqFWqTIxKq9FJ2FASI58fpTJI/nrcO0Hyb/SW0tuSqPngv5OIh4BdL9
         XpNLYHT4dhKBND1+XmAFTuXX18J+jzHS4LCzQTzefhrV1YUxZIddQncF5FkaVZP7kjTT
         qgqA==
X-Forwarded-Encrypted: i=1; AJvYcCU+sCwuOh4013n5Dvks9vgpR4CKjpkWoT/RLpQGpqcAsZ6lY/c0MRuozIu8Ah6SU8sJeI7riQQYE+MtY0faYEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YySRA0jOfaHB7kyDvjNewal+iEAXDoMC5WXSwM1fWmvGVnlREIS
	xk2SEeD7etbyxvkR0lY6gIZLuKgaI79RgSXv4RXNbjGku4zm+7DhgbFEqHmX2ALNsg==
X-Gm-Gg: ASbGnct22uPd18dzOvxiDX/J/QQHamttBUDTfLcERusS5TPdHa16eK8BTZ2ha9/vjep
	VZzCXMpnsO0gzgblBzw06GLUCcVzbiWSN7fiDbEUIcaT1/UPSZm/YR+OcP/2Mc0CVs//LgDsGfS
	VR3pdxBfphxeS6b0HDU2yv0/5CshlrUe96YR3M0pwkZQiabsqjlvckMKPY2Yf3kfQPnCGwtkUP8
	9Woyd23ziD8+ujTQhLDXP2UGhg4DzsFDu9eQUpWc5IOnizYhPbDM5JfWtmUn1Lk7QUniKMtBlzN
	3ebPvLIrQO7W4KInHkKlW33Zfx0bs5WRbI4Gg4g63p/9iSahzvokV2HdxyWxprTj11KsO3kdx6c
	yj1piiKhfFPvfmEtp92dAONLbU22Ay+Xqv5oHhhiFXDh+YyPfsysN7F85+jVvaQdZtmVu0aNRRB
	TajaAZ0V3lw/wPOnU4LygJ2SB+ndXUt7xlRPM8+8hvdES9Cg==
X-Google-Smtp-Source: AGHT+IHt88Q+YL16jUiFmmJzbYiEQoNtpomEOX1cPRjTwZv3ZHJJRwPN8CCSxJ1NxsMWtIwIICJG6g==
X-Received: by 2002:ad4:5be2:0:b0:87c:1ec5:8424 with SMTP id 6a1803df08f44-87c2061009amr76069636d6.31.1760732967544;
        Fri, 17 Oct 2025 13:29:27 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028932d3sm4757226d6.41.2025.10.17.13.29.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:29:25 -0700 (PDT)
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
Subject: [PATCH v5 22/34] lsm: group lsm_order_parse() with the other lsm_order_*() functions
Date: Fri, 17 Oct 2025 16:24:50 -0400
Message-ID: <20251017202456.484010-58-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4966; i=paul@paul-moore.com; h=from:subject; bh=buJBnNY6xRAiYvKynjWYzclkfyX8UJG0i5UEwl0AnV8=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qZdkJO6Oogbr1vQS8mGfhhQxCbYl8GnYlQz1 729sjBbxCeJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKmXQAKCRDqIPLalzeJ c8j3D/sFucwJ2ywzEBVUhSowcPHTVOF/6QaJIo9KtEII007FfdvHhxiDQLpVALzQzjQ+1+cYpHZ Efy6HmBmuZUCdG9xKUiNB32eRbB0fZ7PSfgFgOriR0Xl1JTijxIKYVmG7eBaUqvoycxKmCFUlTr NnXQ8/hSdMMFHY7VUT+rcBSVpU5Gk7zykFp6RnyqGVES/z1uG806a7dilAXXCC5UX87fgBdPeGi dsL7MsLUoGN0WpSbC6fNbv5g3la8WAE+AdHvYONwG8zTdt0EQC+hZ5fM8Z1CNlp52eiqfLyNFC2 9xZv0IpF65om3XmD86OsdAV0thxI7mahdthhn2uTugbKjOewx93A+zK4/XeVIKu/CGYJElt84r/ S7b7zOoMxtPlHl4REcuEKBKtbVfgORes+3canXRpZ8WzvKulF0rCHLIEPSRC/ENBixXfua/oDGx JdalhSykE1aMuE9Ej8kuvZ4AOo2ZBrZmiVcHRRTVD9HBc8J8HW68kTrBC2khwJhKap8pnDZqLKh NxrtpplQfUALhya/7/CYGJ+YcBwqIw6IZPvzmLeWfCn989gKJ8cRTvViEhIH045Zhn7WIg9pQYM ZLOQVxC/CkcHIeg70NgeTTuvQ0KsuP0Y0xURIIEBtCsrE9zMsgiM2HNSRfXuqtr0LwK14DUHe7M edhleZs7AQqFzEA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Move the lsm_order_parse() function near the other lsm_order_*()
functions to improve readability.

No code changes.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 140 ++++++++++++++++++++++----------------------
 1 file changed, 70 insertions(+), 70 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index cfcf3bf7127f..fd69bde9112e 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -169,6 +169,76 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 	lsm_pr_dbg("enabling LSM %s:%s\n", src, lsm->id->name);
 }
 
+/**
+ * lsm_order_parse - Parse the comma delimited LSM list
+ * @list: LSM list
+ * @src: source of the list
+ */
+static void __init lsm_order_parse(const char *list, const char *src)
+{
+	struct lsm_info *lsm;
+	char *sep, *name, *next;
+
+	/* Handle any Legacy LSM exclusions if one was specified. */
+	if (lsm_order_legacy) {
+		/*
+		 * To match the original "security=" behavior, this explicitly
+		 * does NOT fallback to another Legacy Major if the selected
+		 * one was separately disabled: disable all non-matching
+		 * Legacy Major LSMs.
+		 */
+		lsm_for_each_raw(lsm) {
+			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) &&
+			     strcmp(lsm->id->name, lsm_order_legacy)) {
+				lsm_enabled_set(lsm, false);
+				lsm_pr_dbg("skip legacy LSM conflict %s:%s\n",
+					   src, lsm->id->name);
+			}
+		}
+	}
+
+	/* LSM_ORDER_FIRST */
+	lsm_for_each_raw(lsm) {
+		if (lsm->order == LSM_ORDER_FIRST)
+			lsm_order_append(lsm, "first");
+	}
+
+	/* Normal or "mutable" LSMs */
+	sep = kstrdup(list, GFP_KERNEL);
+	next = sep;
+	/* Walk the list, looking for matching LSMs. */
+	while ((name = strsep(&next, ",")) != NULL) {
+		lsm_for_each_raw(lsm) {
+			if (!strcmp(lsm->id->name, name) &&
+			    lsm->order == LSM_ORDER_MUTABLE)
+				lsm_order_append(lsm, src);
+		}
+	}
+	kfree(sep);
+
+	/* Legacy LSM if specified. */
+	if (lsm_order_legacy) {
+		lsm_for_each_raw(lsm) {
+			if (!strcmp(lsm->id->name, lsm_order_legacy))
+				lsm_order_append(lsm, src);
+		}
+	}
+
+	/* LSM_ORDER_LAST */
+	lsm_for_each_raw(lsm) {
+		if (lsm->order == LSM_ORDER_LAST)
+			lsm_order_append(lsm, "last");
+	}
+
+	/* Disable all LSMs not previously enabled. */
+	lsm_for_each_raw(lsm) {
+		if (lsm_order_exists(lsm))
+			continue;
+		lsm_enabled_set(lsm, false);
+		lsm_pr_dbg("skip disabled LSM %s:%s\n", src, lsm->id->name);
+	}
+}
+
 /**
  * lsm_blob_size_update - Update the LSM blob size and offset information
  * @sz_req: the requested additional blob size
@@ -241,76 +311,6 @@ static void __init lsm_init_single(struct lsm_info *lsm)
 	WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
 }
 
-/**
- * lsm_order_parse - Parse the comma delimited LSM list
- * @list: LSM list
- * @src: source of the list
- */
-static void __init lsm_order_parse(const char *list, const char *src)
-{
-	struct lsm_info *lsm;
-	char *sep, *name, *next;
-
-	/* Handle any Legacy LSM exclusions if one was specified. */
-	if (lsm_order_legacy) {
-		/*
-		 * To match the original "security=" behavior, this explicitly
-		 * does NOT fallback to another Legacy Major if the selected
-		 * one was separately disabled: disable all non-matching
-		 * Legacy Major LSMs.
-		 */
-		lsm_for_each_raw(lsm) {
-			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) &&
-			     strcmp(lsm->id->name, lsm_order_legacy)) {
-				lsm_enabled_set(lsm, false);
-				lsm_pr_dbg("skip legacy LSM conflict %s:%s\n",
-					   src, lsm->id->name);
-			}
-		}
-	}
-
-	/* LSM_ORDER_FIRST */
-	lsm_for_each_raw(lsm) {
-		if (lsm->order == LSM_ORDER_FIRST)
-			lsm_order_append(lsm, "first");
-	}
-
-	/* Normal or "mutable" LSMs */
-	sep = kstrdup(list, GFP_KERNEL);
-	next = sep;
-	/* Walk the list, looking for matching LSMs. */
-	while ((name = strsep(&next, ",")) != NULL) {
-		lsm_for_each_raw(lsm) {
-			if (!strcmp(lsm->id->name, name) &&
-			    lsm->order == LSM_ORDER_MUTABLE)
-				lsm_order_append(lsm, src);
-		}
-	}
-	kfree(sep);
-
-	/* Legacy LSM if specified. */
-	if (lsm_order_legacy) {
-		lsm_for_each_raw(lsm) {
-			if (!strcmp(lsm->id->name, lsm_order_legacy))
-				lsm_order_append(lsm, src);
-		}
-	}
-
-	/* LSM_ORDER_LAST */
-	lsm_for_each_raw(lsm) {
-		if (lsm->order == LSM_ORDER_LAST)
-			lsm_order_append(lsm, "last");
-	}
-
-	/* Disable all LSMs not previously enabled. */
-	lsm_for_each_raw(lsm) {
-		if (lsm_order_exists(lsm))
-			continue;
-		lsm_enabled_set(lsm, false);
-		lsm_pr_dbg("skip disabled LSM %s:%s\n", src, lsm->id->name);
-	}
-}
-
 /**
  * lsm_static_call_init - Initialize a LSM's static calls
  * @hl: LSM hook list
-- 
2.51.1.dirty


