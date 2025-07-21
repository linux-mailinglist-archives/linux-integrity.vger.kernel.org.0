Return-Path: <linux-integrity+bounces-6678-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CD5B0CDE3
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Jul 2025 01:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CAB6C49F6
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Jul 2025 23:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1916A24EF6B;
	Mon, 21 Jul 2025 23:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="GE560v5v"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71D8248865
	for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 23:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140260; cv=none; b=fvZmbyDUoCZ7ECGLe+F9t2fAd0bi3WEI1k/B3Iv3WyW9YfbC0e++Pf2E2dcDtA+eqn0Y8vrh8sHTPbLT5XkQO2Wf/Bqo2AF2GQP3h1OFD4gexwGqHTygG9EWrMkNSDv8xaVKakTuh0d6ElOQKU29gdBOx5KuyOMX9OAlPlN+CbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140260; c=relaxed/simple;
	bh=tFJg3FPLCyjfTSZF8+Cebqkf8Ex8dAjp7GGqk4/KfTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V0J2LSn/k0NtmhDhyZux6n5SJ6IddEBjBa0efj/DFDqa9OHsxO3Duy2yKdh2V6pcHpg5O0vHP9H6Q3ORZTqeBxxy+Lt6OBDu/emk72vqm9fSVeozqocONfVWmm4ZtNE0ohjI5W47On8/wXOv2THKovrFP9BaLWlXSdD3LRwH6tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=GE560v5v; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4ab380b8851so42846931cf.2
        for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 16:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140258; x=1753745058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4W+AGCJXFD8/kmcKf7pUUCcO80BxTBwsBo4Hsl006Xs=;
        b=GE560v5vtMf8y4bM2T5B9ehIdfkXWgOKARpIsAkcRTFo+1ay0CFF/tOBir1k3DRJvr
         v94Ovpz3rEojgfAJ4uCkGCbOvZNeA7f8PkW4SN0RbpmLxn/0lvGyfMFGD0SlXmhEQ5uB
         djfwaKoemxFJ6NTZygBgSWtnLbsdLqAwhPcUJfrJD7g8aIBZAaUPL+SoIG2l7f4SvyA0
         qhKYVXACwS1twOkFr+ZNu46uOPgIgcd+E36lRvbYapUd6Jm9ZgOVMzroLggpx32+wPX3
         UZZe8bgyF5aY9DYpSqRJIN6R4MV2AhQpjEheEPWSWkyXN6k2u7TRqyGOtgkC7b7kq/qa
         8P0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140258; x=1753745058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4W+AGCJXFD8/kmcKf7pUUCcO80BxTBwsBo4Hsl006Xs=;
        b=Rv/qFdGCPeDClj8yqX9vwrZZwq3w9T+figCewCCBxEqP5XfE4pbll39wbL+BEOY7XP
         FIZJQ3S/BA8iYxkBktQXPUqOdz2aOUPBnBF9/t22j3uzSRIW4e0DhMUMgAhTxxg+lWUZ
         WDFJq3C5nfMJuVHXYLY+GcdkTn6isdIhVufnVc4un4Yy2fsr233GaCuBgLowaXbxj25h
         Wol/olDD6ocV/P+fKLLqi7FAjN/bgZHPfPTzptTmFrp0g5QueTrs3k6VUzttIs5mYhVc
         +IU4vWyp3pA03KB+T8qTGxqkUcG8aOOa75SZ5NPpGQrsovDVq6VqDtWPXkrZ0znJ5cVF
         Zueg==
X-Forwarded-Encrypted: i=1; AJvYcCWSbIAn/nc11iyrZqRSwNPsWlH42HG6D3Ez8osQNkpqUqDtXnugb4o81KRq+yi1+6zWjvfOhou+4h7mg84zaTQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YziY66UozI38kL1vGUQV2GANwKTgAQ17MQ0bME7U0hZcATrtoza
	zGPFqnxjZTc1UteoJApMN2LUDQHC3GCC30nklTnERdLuOp2J5qwiJG30OrfrJAZV3w==
X-Gm-Gg: ASbGncuILdGomvFJkxSZH+Evs1U8Haf8Vp+Hb4r4y/YdbaPTyvTaGqs+9HryNMkzQca
	0D0NPr/73/vRLYt3gb0rsojHzG/MUvZt5AK2YHe3tMLBB656N9POppvYGefRXsXMlYRjKUZubvO
	n43lEIqkSH5GjZvw/pSmLxxU9oq4VuaQEBQjnIUIzuRvLT6yQYjvt3y5KuY1JH142ReKFlACUH5
	nL1Hc/d1Kmnf7b6uGg39Dd0zkREF5AqH6TNxo9hWo5hdh+BG88CKHCgCH192x8e2F1I7nqxA250
	NjE6eYdo7/y0hkE65XOxJRQhFFSqmcajSnLSuztNopNxdaU/hEoHveBrqq/7Q3z0NIBamdMbe55
	tSCQgICwsH1OGEeOw036/TS+n1LKkyVRkaWYigA/+70A7WLIbHDeHr7/R+MiWJfwzqlE=
X-Google-Smtp-Source: AGHT+IGVG5mNOV2oIGIR3ZsQzm1k6HWMoz3Jah8srUlq1yREcg/vnaBfgaRhghrD/o1P3EnqBow8zQ==
X-Received: by 2002:ac8:5a46:0:b0:4a4:41d5:2a03 with SMTP id d75a77b69052e-4ab93c51478mr356799961cf.4.1753140257672;
        Mon, 21 Jul 2025 16:24:17 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4abb4b3106bsm47375141cf.60.2025.07.21.16.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:17 -0700 (PDT)
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
Subject: [RFC PATCH v2 17/34] lsm: cleanup initialize_lsm() and rename to lsm_init_single()
Date: Mon, 21 Jul 2025 19:21:20 -0400
Message-ID: <20250721232142.77224-53-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2141; i=paul@paul-moore.com; h=from:subject; bh=tFJg3FPLCyjfTSZF8+Cebqkf8Ex8dAjp7GGqk4/KfTg=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsvF7iNgUscodZaDnW8HbM4aIT/+R1EQALP3h 2WU2VXNbyyJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7LxQAKCRDqIPLalzeJ c9a9EADMX8JHYKBF6Rv5k9CIVzrzvIAlI+E3Z6hueyIKH0i8pBu0mc45qPHVZKqKRMHy2J9hbG5 72NUEGKK5Nn9wE7uaTVa5SvHsOKwliaBW9yyzI8yF7oj3aXGoiEvdXf32ZPLLhFc4xds+VLXMqR kiYG71j4d7VAZC1vnXaghmdt/8GREHz/gYwbsCjt6jv6zwQf+KgkxTqpzORxk7f2JIIXGWCyTt0 RT+3PMZTHtsBkSPZIrfYWqVmMRS3F+7JTuC6gxNXjoay98g9t23Zlhzkdrmz08+9uLDcWKRgjb1 kja43BgAcku2NeCjM7KdvXzXk/Govmp/zwUyxoaSm1KuCLydNFXzt7wSoeYC7r1vPPj/urxVfof ceGm9O9JK34VGldPa7UGnb444McwadfX2n5BaJca+MFYuVokzlHw6pLe0EBzS2dUW0KMqiC20JB RJMnxrPQMKJiCG0iOKmokBRfBexqxWPF51vJk6fBZSIO1meYzzLK24TgCKdMMuCP9j4WIMfDsFo aASijye2IHrU2wMX11uBaWugMxg87lW/g98An+TxDudspxoAtAFOR6yz4TLRFLSbMqhbcRSr29E B4bcrAMDuLJ6tmoSs7OfZ0hscYItFqthSfseH8RCa4HrYhUi7UdAx2RyUPu5y2JgduHnh660rig T/PZqiY7mVUX0/Q==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Rename initialize_lsm() to be more consistent with the rest of the LSM
initialization changes and rework the function itself to better fit
with the "exit on fail" coding pattern.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index aad363e37140..49f93383e551 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -169,6 +169,7 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
 		   lsm_is_enabled(lsm) ? "enabled" : "disabled");
 }
 
+
 /**
  * lsm_blob_size_update - Update the LSM blob size and offset information
  * @sz_req: the requested additional blob size
@@ -222,16 +223,20 @@ static void __init lsm_prepare(struct lsm_info *lsm)
 	lsm_blob_size_update(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
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
@@ -373,7 +378,7 @@ static void __init lsm_init_ordered(void)
 		panic("%s: early task alloc failed.\n", __func__);
 
 	lsm_order_for_each(lsm) {
-		initialize_lsm(*lsm);
+		lsm_init_single(*lsm);
 	}
 }
 
@@ -423,7 +428,7 @@ int __init early_security_init(void)
 		lsm_enabled_set(lsm, true);
 		lsm_order_append(lsm, "early");
 		lsm_prepare(lsm);
-		initialize_lsm(lsm);
+		lsm_init_single(lsm);
 	}
 
 	return 0;
-- 
2.50.1


