Return-Path: <linux-integrity+bounces-7461-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67CA6BEBA88
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 22:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2AD31AE3639
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 20:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D45354ACB;
	Fri, 17 Oct 2025 20:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RPoo7lxA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C15D24729A
	for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 20:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732954; cv=none; b=f7Gf7gsrw5XLzWhdmopln+abtcXCGq1bV5lgsM6M/ej8tt2YM9+mnWmr3MrGINJu9GnLNHOn0bGSq3O5ZzQYsOnogWSut9iwVsZO7RCQ+WqUBRa82gzCKE7vR7pkEDiEwqaKqGUPO/Ykk8RYzkZecs5yxqIXA9YEGWUveBlf/ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732954; c=relaxed/simple;
	bh=0ARNTbjqo5w7fHcXTt/PrX3CrXpL0V7SuQTNbX9ZQt4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cm1NiTYQoKCoWF5fDCpxNaazxf9UvfYQ0NhUQYB0UtD1Q+be0obrO9l50Svc9NiOINMeSkQkPEdaUDu+uzQI4GqyKIfB13CogxMUkNDYz/YVHuZY/skc8suquqdFmWNjMN5otykHpyX79aIpgtA1CKbSW5d9MMpTqz6i/kyyTXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RPoo7lxA; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-8907af237ceso201696385a.3
        for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 13:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760732952; x=1761337752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jsMv4hxAnObrkHFZoYBItWDCr7amEmuVwwwwZZ0QcVQ=;
        b=RPoo7lxABX7lAkmuEQxB7HYtQSPjMly8ujCOMSmC20exz87s30usHyiJmnyywUTOSh
         4TWaU3zaIQ62+due8gGMT8CrNiU31M1Qw7EwcJ56RfyJuqkTsW4YaeVPHFI/g/6j3IMs
         T14Z5glLdR8yRdR96hHRUtHaJnADYxAhEdUWFzgaGqTuh7p9LxD/r8ZtDJisepHvyDjZ
         l9Us/HEHA/HU8BZ7tw1GGFsr2s52MNE2ypF84O4WN9+bqqNjAlalVz47cQKlVmbK63Vo
         XeRMZ02v7TYvngqcd5yg72y1CpJ/2gcZJ+4YoQnC9Bzco3tsqwVuGV0K3de6C0UqfKSV
         ql8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732952; x=1761337752;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jsMv4hxAnObrkHFZoYBItWDCr7amEmuVwwwwZZ0QcVQ=;
        b=e1WDIi+Cn0FbKgfF2Gif+KK9HqCP98hqQXkHfrMKqHhXf3HxJMJF0jYMep45bGYIlV
         u+li95vFTlmMFYHQwRcJPDSJjvjYRHfotIqKOmX/H9GpXJW2E+q7TbIzRCD0dTbSkCBx
         BKE9SJMSNPLghvw1j+itbVf9HEVsS4LRxkJ7j/wL3VRtuB+7fchPMxEnRNwFlF3OYc9C
         FYHyzBd0gdGkUz7hNkloD0T7XMSaQ96HxgMyYTErXwSwfo3gqRhf8fGl0iEyLYFIZkvO
         f0cZs8fbsJOKCXMLuLki39iDnvUiJ17D8jqDEXoIHzUNlAyQ3KpssTk7l5NavmD0ZyOs
         BTQg==
X-Forwarded-Encrypted: i=1; AJvYcCWSe0nB9D0nDcWiIoO50na3pBs3ua4zVXKO+S2X2rvPo6TmOf5+qeyTQJMCl2RgIZNcPw5qk+33FKVPWgWvp78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9GkG6Yp4BiaLCnO5qxgQj1p9/BMtAyxhzKRMU8vCFfoCsTX+W
	Ite+HPhRLuKc2cslL0YvfX3CVCmXh1AG0nohuCtEx9bRbXio/FaAmvbf+9rgd/EcaP9QsZPrl5r
	vmD4l0g==
X-Gm-Gg: ASbGncvdYF3w1faO8Bbwq2lUSoF+NW7EIjKqeIRiQO6VCBjTRR5EGFhedA3wthiwSJm
	gvQoM0I1MsbhDkTXM1pGeAxoOJbW0MnCI8l1m3Rl2f88rzb4e86MisP9X/lbNywaWYpB2Vok/N7
	NY4KQmqJYJD0FN7XFAmoafxl6A6URahgOzDHayTU7ZabBi4/xSpDgILClyEBjzEk8ZZutSWOVQ4
	XRgDeW4YGoUXH306FM67O+pkxRo2wEQ8nrpkKg5gG7MZwKPusRL2JnQ5s6UCr+4NO80Al9cd+PR
	e3RaG9TB1OXzrZdHaAGlcBf8VQbVaPoDC4U8wNNW1RALyhSqBpJ7PJ2cyi9E4Zez2+AkLYSFoWz
	D42RsgAWNzIe+0r4oNnt+/KJGMtUVWw0r4newVVe7X0CK/1kheL092ckDoCWA4GWEPjcU/D6U2G
	OpwZJ4hWi9hsuV0v9XXssb/Zv3rs4DjnaSI2mBxVoR9j+dKA==
X-Google-Smtp-Source: AGHT+IHR1s7Oyx2idoI3ZOawjagf9Epm8GCD5AewBeSUmlHVNbALzFXJS04/Sk1NfTEi3qtoDqA34g==
X-Received: by 2002:a05:620a:4110:b0:844:cb8f:7999 with SMTP id af79cd13be357-8906e7b2f48mr633722585a.17.1760732951676;
        Fri, 17 Oct 2025 13:29:11 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cc8d5edasm41017485a.7.2025.10.17.13.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:29:10 -0700 (PDT)
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
Subject: [PATCH v5 14/34] lsm: rename/rework append_ordered_lsm() into lsm_order_append()
Date: Fri, 17 Oct 2025 16:24:42 -0400
Message-ID: <20251017202456.484010-50-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5159; i=paul@paul-moore.com; h=from:subject; bh=0ARNTbjqo5w7fHcXTt/PrX3CrXpL0V7SuQTNbX9ZQt4=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qZDMTtJeMRYBdf54CxDk78rbuV6vciEXYI8d 1zheaUwFIWJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKmQwAKCRDqIPLalzeJ c+D4EADclTAsnHj+AM/ijBKYnaMAP5Fr26HoksbvoBg7i/zTticMtSrlAFARXu8q8TjRPXt0rXz dacJwrPpSSWzi/EkMxMKBUKq1JqZ2aKjKEmMyX/l/ARr6vLKkeqNTysFYEU9wYvhdzWcHHer+ob YeCunPg2eAOle0o6JKcBZLYM98yrDCurRO84bCxYfb/ff0FpYi08MZ+HVPQVK96f6lFvlVLOEny zMfqV3Je5X6aaC3sSYZ7SwFLDV0YalZxcOnf3HpgBDR6rj5HQ/pSL36HR7sNyDPBo3BVKGWmx+J U9WPTuGLZRLvCVtBXi3e0O5cdCGp3CHGAIFzQ1OApBh6sqaavB4aNZ8rupOhUAji6zBqjOjARm3 S+dLoOYmttel/zqZ1KYStR3BWABwj60zseH+tylr/iqi2Y7P/hSAm2laQY3giFh4BMVKNUjV9VG vyYmZybi9wHTltNfk2e1C8CfFCcv9y3062GIJtstVNhjXzqeuHrP8CFBIzXYGu3QZ+I/eyytg0a RjwG9PuzC1zorAK+luIgcxM6RT7sVg9jwAlY7vNyNDa7meLSIs+zWyHfZ3bqZ17M6J4RuyYC5Y9 3K7J5cyy8UMZLB7rucVwmc213fK9rgrpqKx/FzJl/e6ijqY/nkVLQMo6T2atxuhjTCYAqCArly2 3IAOvhQwNTGQngQ==
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
index 4b66a8cfe8eb..1881cd28f0a0 100644
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
2.51.1.dirty


