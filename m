Return-Path: <linux-integrity+bounces-7121-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A881B7D44A
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 14:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1EB117EBEB
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 22:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA4F306B04;
	Tue, 16 Sep 2025 22:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="exzqZ+jC"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B2A29BD9C
	for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 22:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060848; cv=none; b=KdiKOZ7mWylheUAB5c3KjabZ39TIx0aRUWHum4k9uajFu7zKIBDuEfIKs+eX8jA2SuTf2riS0C4AvFoF9pPnCbyAeJKBtl37mO7Ib1vlwTme0QlklZJB4JJOWxoiOChy34qlVaTx19kBpNSK0Y0EflFQUVHWYND3/18TAs/2Zrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060848; c=relaxed/simple;
	bh=3GFz75+pgXuExyfdB0UrHZ6YMZucLji/ZI4WfsyWv58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iS2sed1P7goUWq+hNpNdqunb3ZmcDIpvYTVmrE1JgGg4qyTaa0yK21BhXyC0ryYWivZgGieNVy/hn59EHK4fvLTrD9qOF0F2L8a6xVgogofMQFE8reCLj7I7lgbAXyuiOfyaWXdEPMnZlrb/jke81bGUVWr3kO4DeuwUHgTmZt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=exzqZ+jC; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8116af074e2so566865885a.0
        for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 15:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060843; x=1758665643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aquDpFi6EPnUyUpVuWQPcP3hbc226yXojkZjW2fiqEU=;
        b=exzqZ+jCjaJn7/Zu+osuvhXYXqsLu/PaSi4XeVEmq5yU/6qC7FSalnVtHeTuuB7zs9
         fXcfGe5rB7Ucsp/Jdr3Z5FZ0L2yK67c60S3IZ6wtPCJzy8hvmLM1vHsCzp+7erauNU7N
         PqWAXaiR8Nrn79TWY3dbRItyC0FIpupwEK+VhNDyDHz2dPB0Yb4sYEGyhXs3tJPHOdx0
         BliP5Ppmnd0WNAoiMRwPD8LfwhTeDSMF0bhfKtBCOI1p4jFrFFWD3L29aeDVXsq18luK
         0ZaJHeb7yXdj3Q8HIrlREFggLP7hupNymtBZ9JqpDnxTFvZ/NfuV/cjrgFCjycVGUIlH
         xyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060843; x=1758665643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aquDpFi6EPnUyUpVuWQPcP3hbc226yXojkZjW2fiqEU=;
        b=VHVEwvTDzEf+tlNzQ09rzsKyMiCUHAD8QGfCbm78UY2ohA2GwaWRTangPtGC9akUOv
         yvjYgxpRkpE8SJ8D4PE0xeyA5Fzduhec0F4m1MgDdHsTli63LbjDESeMT8gBP+GuL6yE
         TLjQubY4498JOEvJEi5TTN/VsRRRUiopQSu/xiAXJCaeq/7d8fGrfRFuPZ+wEqzPONpp
         ol7x9anbYR1P7KEuIOJ1RTCRl3IexU1RCbE/jQHae7YyxPQ+acB6pVVvUxnt1wTM21kP
         2Czew0pnKi7mp7bAsyyYIAI37RNVAz/ACbcWJt+W3XmgvlMU0hA0O1dsc1uClhf9Cvbw
         48Fg==
X-Forwarded-Encrypted: i=1; AJvYcCXRMEryPwy+V55aC1BzTdZz6QYr8X0h7xvSjKjVWpZqm9YSjma9vp5B2kL3c4xgEzBKojCDmCxuJNsV2XCUR9g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOB/zAyTqmVXrRMJsPmD5vqClOBWHK5+rkCFHzND3YgJDhlD1w
	4oLuJGwbskWh0XIUF9pszn4LSew45swZXCB37HpDlBUtL48lwZfhUrJVhmuM75WvvSg5046CNhL
	aCmY=
X-Gm-Gg: ASbGncvIwDd/HRdlQB6uA4YX+ZRJr5/a0WHsKnrjmsbhmY/SWQOD4NXE+LN9Bx6r8wy
	CoLQDMP93Wo88LLaHD3cGIwcM5NPwUhGjnj2rvFvwFwbjaNHu0uXvktomqBI4RYo7EfFDjIs7Kd
	INGm55w2lFgyWm+isG7K/coEtVwYwK6dTGUdsEz6JiR7icMRVPeFhWd64l4WJtes72xkflw27iP
	4ta6/jexnoYNCqOaqYZgttAd3VvC6pbBunoUX9n6FixM+wI4vyAYpEyJfxQIZFCOSKFMGiXMLMn
	2rkOYsMJPJ33hQZ0VkyOyJV7NinMZBeDxip47NO+hfvWKwiKeIpRyiHM5FYHQ3aElVaP50QTQQN
	PmbDvr3cjBchay3Br8gz4D1ps4aR1XaiwqqwHG4p/YqjboKPcxmW4Z12pXk9Ptlc4OIq5
X-Google-Smtp-Source: AGHT+IE3gXuncNdhkFFyVyee4Fp4ebQN5wcKsTalKx1WkrbaTo2XnuU9p3aBx9XVl0yfaqpOoklqaQ==
X-Received: by 2002:a05:620a:c50:b0:80a:fc34:5646 with SMTP id af79cd13be357-823ff7cf99cmr2378838685a.37.1758060843296;
        Tue, 16 Sep 2025 15:14:03 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-82aeb24fcebsm285420585a.56.2025.09.16.15.14.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:14:02 -0700 (PDT)
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
Subject: [PATCH v4 15/34] lsm: rename/rework ordered_lsm_parse() to lsm_order_parse()
Date: Tue, 16 Sep 2025 18:03:42 -0400
Message-ID: <20250916220355.252592-51-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4897; i=paul@paul-moore.com; h=from:subject; bh=3GFz75+pgXuExyfdB0UrHZ6YMZucLji/ZI4WfsyWv58=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd769jU4AXqIZKQQZ9wVroUx2pWy3VkSDN7hX kwRIWb2vfGJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMne+gAKCRDqIPLalzeJ cyqbEADdNoBfwYJJXE1+7Z3Wara/7C40NN3+up9v0+x4kKGXkaQRd/GCJx7wGy/307HrY9ChuaW uFsInaCSHkk5ACWBI1TZZZvPDeKT0KmtQOlyLeMw7eEeF4uyfdt0lA9RVBX0vSM9rtJQTaWixMx r64KjMDdD6/2tQJKJXKiipNgzHwysPDw5BIpipFhFVhaFsbCaZEzJveqJ456Qerd+LRrS2NWO51 u1FMtEjTCNTDSnLNr5UiemhEqwKs5M65ApICHbV0IWESReZI0ETWkkraXztZs75V0mbrIVaWvHw 5CNYQ1iYcQD7QTzMgNg9pi64zDN2xAIfYtoHOr97yHJoDxWNkjCbDA5SCJ+exy06ter33ZwraUs JuxL/m3HJucldQUiVmVm4BynPKEybR5YRPACF2U8dtALVjuardgXYR3AQ0LG2MeruMV+fxE2BBr r672V6K6pHlsbS/IQN0HD58+qi2YUDmPfFY1azlNgs3bKVqVNGSv/fZRnwZTe6EdWY0LFexSl+y KZxmlMTY2fraJPv7ri5tyBSJDpRUqvngImFlNgTn+McK4+hHvv64tZWh11ho9iS080WT9vSzZ5S TmvZEZdCE6Rlmz+fxQzsjSa2/EODAe2wKb9Q9/io5n9QqLG0fXDVEgKPv1F2oW5bOjrGsvBDqTm QMj97Qw/NFz+wYQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Rename ordered_lsm_parse() to lsm_order_parse() for the sake of
consistency with the other LSM initialization routines, and also
do some minor rework of the function.  Aside from some minor style
decisions, the majority of the rework involved shuffling the order
of the LSM_FLAG_LEGACY and LSM_ORDER_FIRST code so that the
LSM_FLAG_LEGACY checks are handled first; it is important to note
that this doesn't affect the order in which the LSMs are registered.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 82 ++++++++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 45 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index a314484d7c2f..7b2491120fc8 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -228,83 +228,75 @@ static void __init initialize_lsm(struct lsm_info *lsm)
 	}
 }
 
-/* Populate ordered LSMs list from comma-separated LSM name list. */
-static void __init ordered_lsm_parse(const char *order, const char *origin)
+/**
+ * lsm_order_parse - Parse the comma delimited LSM list
+ * @list: LSM list
+ * @src: source of the list
+ */
+static void __init lsm_order_parse(const char *list, const char *src)
 {
 	struct lsm_info *lsm;
 	char *sep, *name, *next;
 
-	/* LSM_ORDER_FIRST is always first. */
-	lsm_for_each_raw(lsm) {
-		if (lsm->order == LSM_ORDER_FIRST)
-			lsm_order_append(lsm, "  first");
-	}
-
-	/* Process "security=", if given. */
+	/* Handle any Legacy LSM exclusions if one was specified. */
 	if (lsm_order_legacy) {
-		struct lsm_info *major;
-
 		/*
-		 * To match the original "security=" behavior, this
-		 * explicitly does NOT fallback to another Legacy Major
-		 * if the selected one was separately disabled: disable
-		 * all non-matching Legacy Major LSMs.
+		 * To match the original "security=" behavior, this explicitly
+		 * does NOT fallback to another Legacy Major if the selected
+		 * one was separately disabled: disable all non-matching
+		 * Legacy Major LSMs.
 		 */
-		lsm_for_each_raw(major) {
-			if ((major->flags & LSM_FLAG_LEGACY_MAJOR) &&
-			    strcmp(major->id->name, lsm_order_legacy) != 0) {
-				lsm_enabled_set(major, false);
+		lsm_for_each_raw(lsm) {
+			if ((lsm->flags & LSM_FLAG_LEGACY_MAJOR) &&
+			     strcmp(lsm->id->name, lsm_order_legacy)) {
+				lsm_enabled_set(lsm, false);
 				init_debug("security=%s disabled: %s (only one legacy major LSM)\n",
-					   lsm_order_legacy, major->id->name);
+					   lsm_order_legacy, lsm->id->name);
 			}
 		}
 	}
 
-	sep = kstrdup(order, GFP_KERNEL);
+	/* LSM_ORDER_FIRST */
+	lsm_for_each_raw(lsm) {
+		if (lsm->order == LSM_ORDER_FIRST)
+			lsm_order_append(lsm, "first");
+	}
+
+	/* Normal or "mutable" LSMs */
+	sep = kstrdup(list, GFP_KERNEL);
 	next = sep;
 	/* Walk the list, looking for matching LSMs. */
 	while ((name = strsep(&next, ",")) != NULL) {
-		bool found = false;
-
 		lsm_for_each_raw(lsm) {
-			if (strcmp(lsm->id->name, name) == 0) {
-				if (lsm->order == LSM_ORDER_MUTABLE)
-					lsm_order_append(lsm, origin);
-				found = true;
-			}
+			if (!strcmp(lsm->id->name, name) &&
+			    lsm->order == LSM_ORDER_MUTABLE)
+				lsm_order_append(lsm, src);
 		}
-
-		if (!found)
-			init_debug("%s ignored: %s (not built into kernel)\n",
-				   origin, name);
 	}
+	kfree(sep);
 
-	/* Process "security=", if given. */
+	/* Legacy LSM if specified. */
 	if (lsm_order_legacy) {
 		lsm_for_each_raw(lsm) {
-			if (lsm_order_exists(lsm))
-				continue;
-			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
-				lsm_order_append(lsm, "security=");
+			if (!strcmp(lsm->id->name, lsm_order_legacy))
+				lsm_order_append(lsm, src);
 		}
 	}
 
-	/* LSM_ORDER_LAST is always last. */
+	/* LSM_ORDER_LAST */
 	lsm_for_each_raw(lsm) {
 		if (lsm->order == LSM_ORDER_LAST)
-			lsm_order_append(lsm, "   last");
+			lsm_order_append(lsm, "last");
 	}
 
-	/* Disable all LSMs not in the ordered list. */
+	/* Disable all LSMs not previously enabled. */
 	lsm_for_each_raw(lsm) {
 		if (lsm_order_exists(lsm))
 			continue;
 		lsm_enabled_set(lsm, false);
 		init_debug("%s skipped: %s (not in requested order)\n",
-			   origin, lsm->id->name);
+			   src, lsm->id->name);
 	}
-
-	kfree(sep);
 }
 
 /**
@@ -322,9 +314,9 @@ static void __init lsm_init_ordered(void)
 				lsm_order_legacy, lsm_order_cmdline);
 			lsm_order_legacy = NULL;
 		}
-		ordered_lsm_parse(lsm_order_cmdline, "cmdline");
+		lsm_order_parse(lsm_order_cmdline, "cmdline");
 	} else
-		ordered_lsm_parse(lsm_order_builtin, "builtin");
+		lsm_order_parse(lsm_order_builtin, "builtin");
 
 	lsm_order_for_each(lsm) {
 		lsm_prepare(*lsm);
-- 
2.51.0


