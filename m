Return-Path: <linux-integrity+bounces-7118-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 048D8B7D2DF
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 14:21:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 046811BC455D
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 22:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A5952E611B;
	Tue, 16 Sep 2025 22:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d7mPqEgE"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6D52BEFFF
	for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 22:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060843; cv=none; b=bz39gX6o4GHE3n97RfProYec5K/iy35/1nKmn3uHp/4SUwKD7Dn/ssKWOqmO1n76POFatC6MWdb+4enDM8KI0buCI3D1QsOhJTAp88sZDM/kBfZe8Z/OTez6tTbD9BDbWkCP+C2d9LySEnZeMvUnxtEzOYlYdRVaEZxNsjjAhFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060843; c=relaxed/simple;
	bh=aoJzL0zvwesCTIvlX/F9QZwoHp4U+tIMCWP4GVn5BuA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Td2KYcEEs/nE9wQXgsiu3KXaO49wWSYz606xkkrwIuvc2hfB4i5imyn7YSJkGTaUcP8a/MUZX4vREjfkV8tU5Z42nQrOz+nmpsQnSZOS3fbT/07ZTb24sfJbXOnR0CUcMENYuwJGj7EcCEx9zbEu7Ec2fnRd3HYAGYLCfFWN8tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d7mPqEgE; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-7748879b06aso32237856d6.3
        for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 15:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060840; x=1758665640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IpXPIJ+QtsWyxw0RIg3MqwBgOomzYRXuOxvS3I0TZ0=;
        b=d7mPqEgEYbDN5A0Qd1dviHtjFh3IfiL/zlgE/PYnyJ1tAmyN1AYTAX58YUJxwypZnW
         iT/GkcI1nM4advVpP6+Zl9hOf03HqCqbuTAe+d62CQQglYXLArRPjbQl5Fuw4rvJhpes
         bpw3lIQvUYLtnFIT9q+nd0k1SuaqzETjgB482QPcYm9LmqndlwQoQyDRuPIbWR3y8hDl
         yImiVQ5cpi6HjqAJK45JDCIfouPCme0jl4qLcJEGq6C1fTGOn5fxQuhQZct1V2RYIFIJ
         V/mQdwhRbqCg+LVS+o1ym0sQEXmbVv/wZnnM9wGCEDJnotRBP3YqNNAb41lspzNl0kZo
         h0eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060840; x=1758665640;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IpXPIJ+QtsWyxw0RIg3MqwBgOomzYRXuOxvS3I0TZ0=;
        b=XJ0TKdaG8U/hd5vsy9YUfMisOALiOqJn+aOPD6XdNbf780bppMwfmlDvT+iAL5HhDA
         DQ7eQd2YfBZ/N1wTLwE9EiCSc6qH2O3+inZSYPdpt8rAK7c41cLZTEJbLcnuQfO0Pe+M
         UD6XZ6XzuLO2Eqq7nY0EgSqGZI18pjYhYz0iki6OnelLDqLoHfyghbi7u4o7vxIWTOo8
         Ci0s71X1Ff317vcXGJdEsDI3LNfV50Yxp2/Mb2tdpxT2m/bhhFIdbBDGe3MhR091miNS
         roF/Of7eFfrxxUmfAVcgcDXRpw4j+Pw4OiVWwvxbpXNL0Sp4y4ZlyG+bdxtLny2dfcig
         FJiw==
X-Forwarded-Encrypted: i=1; AJvYcCXmxhquPi27rH2R4NOSBNDwdCKnre8jmLHMO7wfiGw3dbS7/RArnQQXM41EYpcQ1hyqAw/6L5ifAZtcGDQkJUo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwB/IFIcrHlo6maWH2YCeSkGxU4V4YFpmlRlwQQ53OseR53RV3u
	X5g/aXTjhyb33B+B2SSO8qiF8b+DKfhq1ODRHhTw1cfpN3bxUp8AlxIgFRfi6bXsaQ==
X-Gm-Gg: ASbGncszEpON6uxXyPU/xy2EOW6FW5iPxCsemPZ6RB7p0PyNFRGfW6cSCLZFkoECe6i
	ypS/ZZOtWgu3iLSnKAxa/QEFTJdN93CiiyopkXGcN4J/v584H2x5w0KB3VJkL0sSlx7Vq9bAtI1
	WbTGBQwlBzvUM1MpnFL8SRca+LyvuBvU3iKlu+U0Qbg2PXoihzw+D9m5SJCUmYs6Yp2+YZoRUwV
	lg6MmtusMD7DmmAhrAbgGp+QD0HFE98V8eT/rXRRRbodqmb4P3oIZn/+cGsu4THu9HpQRGhESjZ
	gKTqUz+bNpdsy46sieTj9VcTLl9jI6NWEsdvV/eLrN+pArt+ixmgXOZ1oVM45TFt17SDJzc0BQw
	3PSlaJepvXhGEacbpDc82dmSYQsrhBGBii/CAPGdDO81j3uEwe9ZERoO/zGckBQDDnEkO
X-Google-Smtp-Source: AGHT+IGvipOQUpMR75ywkJ1ouJNB/HrssBSg7L2LeZFx0VYdbO4zeO2N2UoJ6qWuyv+mvBKsYV3AAQ==
X-Received: by 2002:a05:620a:c54:b0:810:3637:a176 with SMTP id af79cd13be357-823fbde8c1dmr2123218785a.2.1758060839829;
        Tue, 16 Sep 2025 15:13:59 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4b639dc8d9bsm92201681cf.38.2025.09.16.15.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:13:57 -0700 (PDT)
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
Subject: [PATCH v4 13/34] lsm: rename exists_ordered_lsm() to lsm_order_exists()
Date: Tue, 16 Sep 2025 18:03:40 -0400
Message-ID: <20250916220355.252592-49-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1992; i=paul@paul-moore.com; h=from:subject; bh=aoJzL0zvwesCTIvlX/F9QZwoHp4U+tIMCWP4GVn5BuA=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd7z4BBrHd0T5+XEuc9rvyp8s0RjkxImmq0uX noAe4j1YQyJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMne8wAKCRDqIPLalzeJ c0XMD/0ScZ9SexhYgqYSU3iyQfX9YFV9DVDfBJiJxrw8pToTEaPl8m1Slk+Y+3xpzpi+7tBUT9D QYUcHmH/bvam4no4+oSuUh3aDm88k5AACJg5hQDj5MjuWyP1Vc8ghTdPB6KORJhhKS0KC4AdAO5 2Ce0S7SkQeygLbKvD4daR04sVSInprsHXmKBKVovtk+Co64RhcG5DOwZAQAx6gMUxGZM7fFA8cK 8Gde1t8XpED6zEIkEowRWrRtUZpycLIkYcb/FgyKODlE8Kr+KIoBS1OtMnUUjEBJa+OSqe3EkMm X/vbYggTQeFMzNKOJmNGWeLrukGLqvCz7H6kSaF++FyOGdmI9aEc51faXuo89uD5b4/fpRRWZlt nqG1PZxme5Lh4vPG7EiURFz1x2/LDonlINv6K81us7xBGs7xxynSuWWiQIo1ITjGBgkxjIImeEl tdvFk7jZKhov2GkpXQM/lJqog8uFHCIX82f+TxC5Y38Ua+N+ns2hhkhgDHCZSKIoYodNwOlnULr 5Fp9fyHhPLoCMTRy4V1ju6cEzz+FOOTSqHYGxrDEbAnNbIyWkCyGP6QdObvlAknJMdB6oD7Fi/v ZP1QakAbY7Y1i0kn/iyRltqYjIdX/TeQuwMoowU2oa/JYIFpCq5EJFQkD+PYY2a5NglljeMP5/K cJS2AT3JTMfvltQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Also add a header comment block to the function.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 2cfd72ade6fb..ec46ddb18e1e 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -108,8 +108,11 @@ static inline bool lsm_is_enabled(struct lsm_info *lsm)
 	return (lsm->enabled ? *lsm->enabled : false);
 }
 
-/* Is an LSM already listed in the ordered LSMs list? */
-static bool __init exists_ordered_lsm(struct lsm_info *lsm)
+/**
+ * lsm_order_exists - Determine if a LSM exists in the ordered list
+ * @lsm: LSM definition
+ */
+static bool __init lsm_order_exists(struct lsm_info *lsm)
 {
 	struct lsm_info **check;
 
@@ -126,7 +129,7 @@ static int last_lsm __initdata;
 static void __init append_ordered_lsm(struct lsm_info *lsm, const char *from)
 {
 	/* Ignore duplicate selections. */
-	if (exists_ordered_lsm(lsm))
+	if (lsm_order_exists(lsm))
 		return;
 
 	if (WARN(last_lsm == MAX_LSM_COUNT, "%s: out of LSM static calls!?\n", from))
@@ -269,7 +272,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	/* Process "security=", if given. */
 	if (lsm_order_legacy) {
 		lsm_for_each_raw(lsm) {
-			if (exists_ordered_lsm(lsm))
+			if (lsm_order_exists(lsm))
 				continue;
 			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
 				append_ordered_lsm(lsm, "security=");
@@ -284,7 +287,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 
 	/* Disable all LSMs not in the ordered list. */
 	lsm_for_each_raw(lsm) {
-		if (exists_ordered_lsm(lsm))
+		if (lsm_order_exists(lsm))
 			continue;
 		lsm_enabled_set(lsm, false);
 		init_debug("%s skipped: %s (not in requested order)\n",
-- 
2.51.0


