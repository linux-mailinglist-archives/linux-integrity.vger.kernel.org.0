Return-Path: <linux-integrity+bounces-7127-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5FDB7D226
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 14:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A3FB526361
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 22:14:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF182F6597;
	Tue, 16 Sep 2025 22:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OaKfbXyq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92503294F3
	for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 22:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060861; cv=none; b=hnrIg1+6K5ECYFWHFdRm99WosEfS5csK03HsVpOB/0gs7kYhLgRXzIDpKdgKrMNnpROq2KbMrHGztZAeLu32NoZ4suMF+7EoG9yPQdXoPebwZvqHyRrk/HDj6SkUH6CkmPar+FDpc4JPRyfw3OZhRLuFJQLB0+7Ed8YZBpRKxt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060861; c=relaxed/simple;
	bh=8gCDEDrBlFQUqi4hn+jg4/j7pBAGN/YYTD8L/S06LaU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aWlOuAmrvfJClefjh6OhrijmASOXQcz+ia4yDk9eo6iRY3ghHXNqB7u4xbPdy7MvF1ZbcPyhIHNJwYcW6CfayKkePf1LzUa9/8pWxFBESNgjQAZ5C5d08LQAIs51g2ZriW0esynz7+EAjrD5BFcWm9wS/L2Wztjd7aJ4R+x6SRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OaKfbXyq; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4b38d4de61aso56929821cf.0
        for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 15:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060858; x=1758665658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WZBA0Bz23Qx6udSljh8iUgDakvWyzWbN4XBApDh/JEA=;
        b=OaKfbXyqiuQ/Sn05+gK7RnE1DfH5H1byQDct/RmsAWuTUpLP3gcd/+bIiTCkdMcxwL
         dWI0/8fNET/k8MRspr296V87Ra6PV11Al9nUgbsXjFm6wAwRptyy27qDCKUav54woa9a
         PefafhEfHk7fg7qD9uiWgZoCKZ/P1zHSX8Vy60ihnc3HQdDcLhKmKGKdboUNmo7CC0dy
         tnVGZreP6J98H2sjzuUsigF6lUQJkbPoP79G8H2+qJgUGFFQyw7I2ebYkgKyU6ziq9P0
         aMdJyNv7D0Ba6pFMyotIHawzrW21HPLpXzkBS9TmBGaznnn8x4g2HTZk+h/VY3HD+mQx
         sPqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060858; x=1758665658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WZBA0Bz23Qx6udSljh8iUgDakvWyzWbN4XBApDh/JEA=;
        b=SV3KDBBmJalqOI6c2e2ilPhpExZ3wK+kUOx+H8x9ntTaBQxUi1aMj64KVW5UTWWKi3
         cgQWVfvuxmNr+WoFHLSgUgPF/8ZxI6a9eOItvcsKL825SsV1Ji5NNh1RdRjE/7Ro/ARH
         rb/c3omnnZsPsdc7PNbYRAZozipCAf1/Lx3ijEaIGXI6n+uVH0W00ukIaoTTejSyqD+X
         pgRtmKbsU/JEeR1Yoyr15Ec/uIaUar1K0dy7o6/+bo3uZ2o2yZKJU3/5ZroUxvzpEQdb
         R9K9uqlpot0sFLvsanrEFwqSDcZwaaeW/zzYFlyuLp0GRIAMP61X2jbe3MuHWpJ8rOvD
         Vw0g==
X-Forwarded-Encrypted: i=1; AJvYcCWAR2NLItNR4JngdmI9sWiwic1TqVN2TcJYvL/ATHwdCpFHh89oh/MjVMPacssamQHRyYKu/NIX2uAm9ziOzeA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtPGdbR/IDd9AUP14Yj1nhYfMdTyy/mBnYEFZlsVN5mzMRbOol
	ZvKFGJqcecTXfW4pdW7p1m5NdHLlKUb79ZFxhNsAzpQ5bmEpa58viRf7wbjzDlnYQVeoY0krX8k
	Gr7w=
X-Gm-Gg: ASbGncs8g+1BJWvsf4/bDbUWKPvisfwpM1ZdzFlYWLG3TNGRT9Prtqujo3z2MccgfAA
	kwf14OzyL+cLTIiVMcf2L3fQNS/2n/CjgaaHDLm4fX7KRTXLmb5/jTQi+y7BVk1MlCG9OR/vuLV
	+kHHlDffZAWnBhjjqqoOT6yl2D4jWPfi013zD0B3merQqUw8WK6WBt4y8RmDLzRCFV/hABP2Yzb
	Xfsdlv9dc+e23/T4g6DKnxI9kJ6b76g+1jwtVjuUIzgfbS0UgKgmi0vbS7ZdQrQGN19GjMg2j75
	WFa//XhJ4K1E0a39luil9tOoQeKIKshsbgJPwqw1DjrU7nd/XGIFB0uwYIkQChNGhE1tUlOXxms
	dH2Mu8MCF0Bi0RbPbXq8AAkNpEEW1QgWOoKcOsKmVe8MKr5eextXo3ugp/X8aJMatKrvP
X-Google-Smtp-Source: AGHT+IF0XA7xsbOvhtVRYvZRiE/r4WnDWwodWixFo66wQMCRv2q/zwQvSs50KBUjyn02dBdUTj4Jhw==
X-Received: by 2002:a05:622a:1b0b:b0:4b5:1086:9371 with SMTP id d75a77b69052e-4ba69d35169mr1137711cf.42.1758060857618;
        Tue, 16 Sep 2025 15:14:17 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b639daba5dsm89972301cf.31.2025.09.16.15.14.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:14:16 -0700 (PDT)
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
Subject: [PATCH v4 22/34] lsm: group lsm_order_parse() with the other lsm_order_*() functions
Date: Tue, 16 Sep 2025 18:03:49 -0400
Message-ID: <20250916220355.252592-58-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4913; i=paul@paul-moore.com; h=from:subject; bh=8gCDEDrBlFQUqi4hn+jg4/j7pBAGN/YYTD8L/S06LaU=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd8RMZI97m71yqQS9QR+wbesGCt97m/apCS4C l0oN0wTiNiJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMnfEQAKCRDqIPLalzeJ c6MaD/46vU2UEsgFeka5DkMAUPA1jsez0naCS6Ob9CyFuhs6CTFBdE+yz5NJSoCWUl7g9TLxo17 pBtIirEdfspeW/WK6iQubIawWXcNhIChJh/IEipXGCnCVEb5NA8o18WkTZStfuM3Q98BY1Cjly+ lOMDdTNWN3NK3DAoAuXBxTA/ItZ80LDPnxnj8HGaFzyEhqxxJylXYoLh9mGAncgBKUD4G1IcpFH WjIF9h5Lr7mSN9j/GYVM31IsncPAdWjKr1DeYdzn2jM2qOgu+suem6726DYkPdhMOqjwTK7ykkJ DODt244bCtikYFsxtaD9iL9uD3aPwUVSBVq1nZnAPQBA+2IJsndGHqWtYDyFb5WvXCXGHkVlHdz uEIKor/0GmqNaAqyIcyM+dfmLQTxRgvH6NJaHZB0BxB+2jnJtcqfEyh6U4+85azkUxrHM+mDwEu TmxqXMC/t20Eq3ayDep5LdJ5Va+ra0BtV07P/CAyeZPbsmvpjmt0qj6krKLnulqggsZPQrwuUDp Vw+Cc11upj/sobrjkaQOj3+3xnR4cJ1SEEeGeco8POBpHeNLALLGkk4S+gaUxq9JrdsDCyVXtbK mY/wDQ39H1f7muPlRFFefuSb3ijYSUnploPtSDTH6ZfDnJ2Egx6nLDUv0rGL7iy4XF1icG0Ka92 gIsDZtGUWTDWqNA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Move the lsm_order_parse() function near the other lsm_order_*()
functions to improve readability.

No code changes.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 140 ++++++++++++++++++++++----------------------
 1 file changed, 70 insertions(+), 70 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index c6aea57a01e6..363aac92a8da 100644
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
2.51.0


