Return-Path: <linux-integrity+bounces-7119-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA22BB7D437
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 14:23:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2070017E9CF
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 22:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE921323F66;
	Tue, 16 Sep 2025 22:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WyXm4pzm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E91E2C0270
	for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 22:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060844; cv=none; b=Xj+g1lvTm1dnr/wGYy+5Jg3TaWWL+n8xNNamdZhxRJmDtpCdOuNS3ZindrXpTY0KTg35ZwT8N/0yqrHONyDpMAO/jYww/AtO6Ut6fdcQpplNBnF14h42tW1VzzzZk3CO3p3W0T9DCtXlxyFrx0Ur/o/sGKO0TDF6ETEqBLv9lFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060844; c=relaxed/simple;
	bh=rjn2ffjd4ifcuufei25Ylxlmb0K5Nl9bGbQJG2/I+fg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mYzQPjwAXw3IXytB49t8iOwMapChluagpjMM9xpp6QdVhd6n2pDIZgMIGTCVY6DnmWhRfMroL3Bc3eOTe2k5B/0XeA61aE9oPJ+foFgcT5KQpy/puS+xoZnezbDTZeKqezNRou6ou5yC2HFXEHjQslyIXkxG5fU049bN3ESbFLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WyXm4pzm; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-827ec18434aso365438585a.0
        for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 15:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060842; x=1758665642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQMUld4u+e4WeW6bejoEvG5qUwMCp/YRRFxPQyzYnh8=;
        b=WyXm4pzm579fwoltHgNG9Ped4/T0hNiBw+pa9ddj5nVQOJdOk7gsHvUXg+tXfjdU0f
         WHzqVYQjL2H9BHHXPmr2Kn2UxI4w1IgRKUJu+TSzvNiFp8ZWyRYCtbntc7n4CgkxJG0e
         X9a9tkJFYpD0ZoXcq5ZBtZ6Cb2tkUTj5EMdw0GBHG574d0P1Ln22q0UHzcwmmNiv0vRi
         xXOqw9IG+r8kxNtxmAyPdTAjb5zbkAwzTcGLpJHjz4vQ0dAYuaTy9L7fPrLJr4EZsftu
         JDUcQntZxGwkC9WLmDLfm5qbhWELiRQzMAj2K//zz+nmF6M0l2VEmlFMR0Bv8nzqY+gH
         MyBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060842; x=1758665642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQMUld4u+e4WeW6bejoEvG5qUwMCp/YRRFxPQyzYnh8=;
        b=ExD6pJixG6O5RdrWxaM+d52NAcDEPyIHXgFCi2W6OmlUdr4/ylAeA6QcLXnepmXhLZ
         RnXdH1lN7goBsjjutY4oKU9c4SVvV8n+c/oawZC/QLg70a0EWjSKkiR4vX2SewgFeqNk
         gMExY+CvDaHjm5SZpjbS0MVuO4vZLeKmrRRpBbp/vBL6rAxwjKwOMggWJWTXSO+P0nUM
         BaoKCnsVadE+wwGctncWP5enqFwut12jfffLd6YMwITcxbJdsX1ypu3EU0gAyCUlh/7Q
         Ge0A59tbaFwopxO5NOE5t/APxOMrxyse0UCaA43ZotUgoOtOf2Ul3rzJHCAg8sJBSBtQ
         VgZA==
X-Forwarded-Encrypted: i=1; AJvYcCVi6g1M4+skCWNYD6xON9Nx9FP1QCW8Y4JHIvWLuNM1cOpRwLbt/MYfv9hlbyVB8uehF0Cj2mHWcacb/9lWeLk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKaCh8LlJd7XY6h3YzXws64YWjyerOUJQO4beUz+W6ne8diZS7
	hDH1MuLP/T/Tc28lNJ3ZGWvFk7TYrOWnqQ9lOAmnR9fYr1QbT0AVfAnfItp/xBiyqA==
X-Gm-Gg: ASbGnculcQBMVQJi/P0TmD41TT4DGqXLiuF3UcpyUzqRCx4XRGkvGIZJkHuZsbUgiTl
	1gq9HrbzuaqZCtEjr7uhTS6x+00Yne+CrcHTA93LoaptZWdHcC0pYzgKdhcU45VeHvnpC3iD403
	NTJvpolqTPqGce4JSTRV78ibHRoLni022LZ+NtCZZLPLr3vWQTz1fwXDMCvgz/s40ZgtF50UQ9f
	sJg05E2A5JPm1YGDnPiOZd4OG6wu9J6igMX0bkisotUbJA7BDNGSeJ1u41dRXXsC46fsrWZvQea
	vFns7PaDmklQr+1dJYhZT/8gypVSI1ymELQqKb3MBxkFt/FQhw0Z5NDkhiAFsR+nJfORU9ZaCAN
	YaeNCBI2khPDSkpr4LDWIQch7D2u1DhGxjvhdMSVmKldapBbSiwBgxEZtOqugZiKE+n0X
X-Google-Smtp-Source: AGHT+IGW7cn57f1ygyww7b7WKh/wgetiJnHeAfExk6/1SlD9D8BgILc+YwfD4/6SexqTLRGG2HFd1g==
X-Received: by 2002:a05:622a:210:b0:4b5:e644:67e with SMTP id d75a77b69052e-4ba6799d534mr1289281cf.16.1758060841964;
        Tue, 16 Sep 2025 15:14:01 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-820c8bb8f46sm1010494385a.10.2025.09.16.15.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:14:00 -0700 (PDT)
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
Subject: [PATCH v4 14/34] lsm: rename/rework append_ordered_lsm() into lsm_order_append()
Date: Tue, 16 Sep 2025 18:03:41 -0400
Message-ID: <20250916220355.252592-50-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5153; i=paul@paul-moore.com; h=from:subject; bh=rjn2ffjd4ifcuufei25Ylxlmb0K5Nl9bGbQJG2/I+fg=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd723J2kDVo3hNuerInCeaVsrStTGdkecTqQM 8v4q4dSS6KJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMne9gAKCRDqIPLalzeJ c6C7D/0a50k/6uv74qgqHxTzifQuVENfe3axM6opzc5qGK8yDL2uFBzcaXeeehNaydXkRiSd+Hf ejMttnvwj/NaJ/vWO4Hpef19y7r1o1NS8DowAoYpzZKU9EXHJOV/HCe4J6vFuTtJfqo6kw0zf3z mB6rbjvVen5q04Vtupay94fB4suXZVBgjiRg+8uFU6BQsRhtPStOJG09/ulmD2MLv78TINx2HIx LK0u5yIAzvhxtXtXBnXMCiGXLYbzk0zLxzCmc040MXv/24Xn5Wib/Wyd1ve2VFOvqkjP1Gm7Sch PtcSbWIKEPVR2tmHmxYOgCKmmQWnnpU1HKvSaLHmu8pcQrbn9oG9w6P6CjAmQyx3hNIUjMU4y98 a+tFdzxN0vD5MzLIxZJeUA+mEB3zIQaf3tDWW/axHZj0TL/n1Vc5V2C/qTcxBsGmPS6hkuPbsP2 gYfc/FspNUKkI7pGIe/5mMJmAnfnaC8GT8bnUDY4iCM4PMgvuQJZI7ngKd8Pl1yLE7mN16V8LlT lnDiw0Kq2nxrCNrf4Z8Qw+VQcUXbPw/xcX+EZ20idSwI1nVV/t6B8oLXRrhnnjwALAtRf7hOg91 sFrAH62Ph6nOxUZ3FCT+zqlt/2l4aGbyWYzJyX7TgpErIPDclz7Fc7k5eLNoHRK7wW0dQbWJnxC f9ptOvY4uDN7poA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Rename append_ordered_lsm() to lsm_order_append() to better match
convention and do some rework.  The rework includes moving the
LSM_FLAG_EXCLUSIVE logic from lsm_prepare() to lsm_order_append()
in order to consolidate the individual LSM append/activation code,
and adding logic to skip appending explicitly disabled LSMs to the
active LSM list.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 76 +++++++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 33 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index ec46ddb18e1e..a314484d7c2f 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -124,24 +124,48 @@ static bool __init lsm_order_exists(struct lsm_info *lsm)
 	return false;
 }
 
-/* Append an LSM to the list of ordered LSMs to initialize. */
-static int last_lsm __initdata;
-static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
+/**
+ * lsm_order_append - Append a LSM to the ordered list
+ * @lsm: LSM definition
+ * @src: source of the addition
+ *
+ * Append @lsm to the enabled LSM array after ensuring that it hasn't been
+ * explicitly disabled, is a duplicate entry, or would run afoul of the
+ * LSM_FLAG_EXCLUSIVE logic.
+ */
+static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 {
 	/* Ignore duplicate selections. */
 	if (lsm_order_exists(lsm))
 		return;
 
-	if (WARN(last_lsm == MAX_LSM_COUNT, "%s: out of LSM static calls!?\n", from))
-		return;
+	/* Skip explicitly disabled LSMs. */
+	if (lsm->enabled && !lsm_is_enabled(lsm))
+		goto out;
 
-	/* Enable this LSM, if it is not already set. */
-	if (!lsm->enabled)
-		lsm->enabled = &lsm_enabled_true;
-	lsm_order[last_lsm] = lsm;
-	lsm_idlist[last_lsm++] = lsm->id;
+	if (WARN(lsm_active_cnt == MAX_LSM_COUNT,
+		 "%s: out of LSM static calls!?\n", src)) {
+		lsm_enabled_set(lsm, false);
+		goto out;
+	}
 
-	init_debug("%s ordered: %s (%s)\n", from, lsm->id->name,
+	if (lsm->flags & LSM_FLAG_EXCLUSIVE) {
+		if (lsm_exclusive) {
+			init_debug("exclusive disabled: %s\n", lsm->id->name);
+			lsm_enabled_set(lsm, false);
+			goto out;
+		} else {
+			init_debug("exclusive chosen:   %s\n", lsm->id->name);
+			lsm_exclusive = lsm;
+		}
+	}
+
+	lsm_enabled_set(lsm, true);
+	lsm_order[lsm_active_cnt] = lsm;
+	lsm_idlist[lsm_active_cnt++] = lsm->id;
+
+out:
+	init_debug("%s ordered: %s (%s)\n", src, lsm->id->name,
 		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
 }
 
@@ -163,26 +187,12 @@ static void __init lsm_set_blob_size(int *need, int *lbs)
  */
 static void __init lsm_prepare(struct lsm_info *lsm)
 {
-	struct lsm_blob_sizes *blobs;
+	struct lsm_blob_sizes *blobs = lsm->blobs;
 
-	if (!lsm_is_enabled(lsm)) {
-		lsm_enabled_set(lsm, false);
+	if (!blobs)
 		return;
-	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && lsm_exclusive) {
-		init_debug("exclusive disabled: %s\n", lsm->id->name);
-		lsm_enabled_set(lsm, false);
-		return;
-	}
-
-	/* Mark the LSM as enabled. */
-	lsm_enabled_set(lsm, true);
-	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !lsm_exclusive) {
-		init_debug("exclusive chosen:   %s\n", lsm->id->name);
-		lsm_exclusive = lsm;
-	}
 
 	/* Register the LSM blob sizes. */
-	blobs = lsm->blobs;
 	lsm_set_blob_size(&blobs->lbs_cred, &blob_sizes.lbs_cred);
 	lsm_set_blob_size(&blobs->lbs_file, &blob_sizes.lbs_file);
 	lsm_set_blob_size(&blobs->lbs_ib, &blob_sizes.lbs_ib);
@@ -227,7 +237,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	/* LSM_ORDER_FIRST is always first. */
 	lsm_for_each_raw(lsm) {
 		if (lsm->order == LSM_ORDER_FIRST)
-			append_ordered_lsm(lsm, "  first");
+			lsm_order_append(lsm, "  first");
 	}
 
 	/* Process "security=", if given. */
@@ -259,7 +269,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 		lsm_for_each_raw(lsm) {
 			if (strcmp(lsm->id->name, name) == 0) {
 				if (lsm->order == LSM_ORDER_MUTABLE)
-					append_ordered_lsm(lsm, origin);
+					lsm_order_append(lsm, origin);
 				found = true;
 			}
 		}
@@ -275,14 +285,14 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 			if (lsm_order_exists(lsm))
 				continue;
 			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
-				append_ordered_lsm(lsm, "security=");
+				lsm_order_append(lsm, "security=");
 		}
 	}
 
 	/* LSM_ORDER_LAST is always last. */
 	lsm_for_each_raw(lsm) {
 		if (lsm->order == LSM_ORDER_LAST)
-			append_ordered_lsm(lsm, "   last");
+			lsm_order_append(lsm, "   last");
 	}
 
 	/* Disable all LSMs not in the ordered list. */
@@ -415,8 +425,8 @@ int __init early_security_init(void)
 	struct lsm_info *lsm;
 
 	lsm_early_for_each_raw(lsm) {
-		if (!lsm->enabled)
-			lsm->enabled = &lsm_enabled_true;
+		lsm_enabled_set(lsm, true);
+		lsm_order_append(lsm, "early");
 		lsm_prepare(lsm);
 		initialize_lsm(lsm);
 	}
-- 
2.51.0


