Return-Path: <linux-integrity+bounces-7464-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA6BBEBB09
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 22:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC52745DE5
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 20:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF7B26C39E;
	Fri, 17 Oct 2025 20:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ds/LhzGr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25AF261B9F
	for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 20:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732961; cv=none; b=DEVyulKfrJBgJYgv+VEnB16DyesCedsH4a4EvU1H0bNLyMX0yeoc5/C9XDQ6KSCV7byS+eedKQntzaNT8UCuXmiO+jvHehcJBAjPCz3hC9nwrj9I0k2H501PB6belClHUfzKRxJ/13N+RPF2C+5O7ydQcV4/5aS5yGYXbGrmzC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732961; c=relaxed/simple;
	bh=tEGvzM0yE7tsW/7RDSgG9uPwSZjbKV6W5Wg560tmEIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LcGsHY9DjZdOsJam0QOitqprfhv040BMz+ww45pziy0H5CD1Oqdpqy5+Lnwu++fpigy9v1LEyAEQ3WvINKQxLqR1WYruxVX30Fslnhi8SKryK3NOvBby2rEFAhoc0J4aUyzQkwRFzUcQkVK3Lyq0Bx+mkOGPpJFSduVXKzRfJ1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ds/LhzGr; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-87c11268b97so37157166d6.3
        for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 13:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760732957; x=1761337757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IFq46WoeSKwSJE4jGKjOq638fSUHXtPRAD2nM+CSlBI=;
        b=ds/LhzGrIK8s6TLf2xfZTWg7zlcgACEFGapG1wqaK2DCMrqhUT5bbq6nvm9zjEc3o7
         m3KKNLaZ3TCitGuQ0Z4kan6Dm36cWjBCiRqSRK1PZU3jLMsf6ERhnozy+mH84CrM22IT
         K2k0hxf7nE9q2681t0ebzBW/n0eu75Vgi33jj2rPNAYo329eVXdJYbeecjPEjivfi7vV
         kQMp0aJKcY3EIjoehO/9ST3Ns2oiCVAjtwDp1aX8D5o6IJLng14pCxgKOc0reY8Fpez4
         LPglXNhrQ6ZyEaQTDQ29eXgt1iEIOHswiTyR8ngEbaqkHF1yhIHpfqjaJVHS9B0xXKsg
         NEBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732957; x=1761337757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IFq46WoeSKwSJE4jGKjOq638fSUHXtPRAD2nM+CSlBI=;
        b=POvpDXmyZY/xSrm+7GQHGcLBdSOotzPAzdZnCWHgzXpn+s1f3gJP23xOVrqweY/C3L
         xVHYeihc2MX1R1L3WQ5NdMrYjj2/c53Z7KGq87AEXKMiaG6p5PVtpDM4xBVNT7jnUGWv
         qAvTZgohFQj50SFZoUDe95sDXyRVDCPBLlwnlQL+3K48+jeTYGcfhWamzxmgcYtjW6NZ
         bdHwbqeZkjAN7ZhnOXSSvRFvNTopi0w2l0HEIkUZEkM+s9iC/K+HeiDRPFR0mB/rVUAH
         3+XgAqWmu8qcGjOckXxsGS1fEqNCNhAVLGG3hswwECNgugzk2xVjbNaP+SquGmp5/cAy
         TFiA==
X-Forwarded-Encrypted: i=1; AJvYcCX1WLL3hQvWzT4rkjWCg4C22+ZHM4rCemV9FObdHVngSDN96fcv/pCsjQSBKeOnkwskwBbAQUOFKwjKxUAKtl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhFbyTrThzZo1k0T/Vg5XdK7X35IAHw51KSucyGgsh3vpWzo8O
	okhCrGrcA+WcASUUEhmSSBOaJd45A4R4jr6QZ+FTo/36nX+LEAiCwFHBgERT4zdj/w==
X-Gm-Gg: ASbGncsRoCto1B+9QhUDxa6cmtyyzGnBJJwTeYPkkU4+jEZhW3MNV4aw8xZwv3SNWh2
	U4aIucri4P2L4O59/1gBaDSZy0hGQQTeR7Z4Sntm/jNUIaWa92Ia1N5M1C/LWgkWatpRCeNGUjT
	s/PVstd0eH6ywoDLQYz/HuLnVNT0Ihmfn8Rt7mzuOLF8fO6/0dD1vGM7b6/dnbeaig0KZiLQFeP
	cZ8YiobycgPO33mAZlXbJY05WHHyZRLTDcBTQOtGyUOJTEXZBAy6fq2Rfgs7hmcGQAgjmd+ESMX
	XjOrR3kekA1NxtVJ7pB5sxv2vpv4eUuYH5o0csOb8byWXYzBH/6/sF++G3/H1gwe/wdCl0dy4YR
	+RKdtpuNH7RESwI8HFuLaNwSn1LE3TfO6pf0kn5/Y+DRdcoOGOwxjgYcsaFNF55+vNZn/ArabWg
	1zCarXdDdGGtYzX1g1ZWQuE3R15hPOtEqej1KRzuk/QuMSyeD8ryfgN7wA
X-Google-Smtp-Source: AGHT+IF/yOqma9LHBrtpnU4BLwdvNtEMxqp24eCaxSiApP791JcRbDi5Cbt0lu0LsI2CEhLnP2gk4g==
X-Received: by 2002:a05:6214:2aa6:b0:81c:ded8:7099 with SMTP id 6a1803df08f44-87c2081e90bmr73693616d6.58.1760732957597;
        Fri, 17 Oct 2025 13:29:17 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d02d8e5a2sm4723256d6.60.2025.10.17.13.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:29:16 -0700 (PDT)
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
Subject: [PATCH v5 17/34] lsm: cleanup initialize_lsm() and rename to lsm_init_single()
Date: Fri, 17 Oct 2025 16:24:45 -0400
Message-ID: <20251017202456.484010-53-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2259; i=paul@paul-moore.com; h=from:subject; bh=tEGvzM0yE7tsW/7RDSgG9uPwSZjbKV6W5Wg560tmEIw=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qZNpqw4tiXjV62E3BPwgqFwok7VAGgRmLN0Y WYHaYFAP+OJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKmTQAKCRDqIPLalzeJ c1gLD/0aC5QVe1wm3u8cV2Z/OeG2CbmpsRwhy8Q3NOWX2TIB3//xJrwBZSBXbmQHCs8xjEAYyL6 RULxzmr93gnXCPkn+QUWXoWV2Itl5p6z42ui8p43LRaDhAK6x7iq04yTz3bfwNpnceZSRvNahHe /W1CW+XkMFItsky9TBH/g8gUyR+bjAJqewXKf0stx4Vhun9j2A3WIdDIgRC8SpSMC2dHfkKNrVn 66DdSxXaeXPlO0+V6+I+hd9Hs3K4VYfRpzYTAX/KglM0JQXlHw6G4Ymp2cO/UVkWzE9k/eCCF/4 h1CZ0WyNWfYnylf2g/xmFHqXNPgBKe0pMAkMbtZYWO5AJrSvMViNGqanj88sOeS9ula1g+dGuNu OX1CpJzJ3mxF3D4be6HzVo7B1GS3JZPxv/FcR064ZCToCTK/Ws/ewQX+56d3DjHCj6oRVre5G1v qnbeFpgeUDzhbOxJMlj+k23/WXi/zs02z4nk+5DU25uJCF5n2zNoqgtfYkXxWFYi+pxnmlB7bmF 2jfWIjsPQYyYcFUfUpqkl3hDGje0FTe1qVlDiit96t63+CkyglyOzC6kNoY+Lu4zwYC+9L9cpZI WVKT7Ir/YKWaaPiNHWo24v2ZmF1dZ/I5zdyKxLy7CuLIGpWy1Y+a5qyXcyB82RnyVcqnD2gIDrn Ezc8n2/VHy5Gbmw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Rename initialize_lsm() to be more consistent with the rest of the LSM
initialization changes and rework the function itself to better fit
with the "exit on fail" coding pattern.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 6b1f8f18a43c..eb473f982ddb 100644
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
2.51.1.dirty


