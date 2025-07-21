Return-Path: <linux-integrity+bounces-6674-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F956B0CDD1
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Jul 2025 01:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18FFA6C4020
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Jul 2025 23:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB44724A061;
	Mon, 21 Jul 2025 23:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eYbb7Ip+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37202246764
	for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 23:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140255; cv=none; b=ImBQqAFCYZc9km/ri/sfag3XOT007bO+6fapXNlqAUomNCMp+u9tE3LqvRMXGl9//V3zKQy1lM7rAvgj/uWyTqFRb5z7rb6KmzkGn4CQkOQEEC6WEZiWH4d0kkyL2+chEz0W2U0GYyGFNiApx1OgHtzWkTdVYc3fA30IhOjTDdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140255; c=relaxed/simple;
	bh=mwF3ZjAzSHlGtLJaNMcChK9N/YSg9AZ/qVLLLHNmcZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tAwcy04Y5fzri4HR5dzIFz3AaIINjOfRBcDxB9/by9j6ONvF1/as+DHeZCqPulSBpjMiCNg64+SZ/0tVCW0es/BFV0yz/5vY5Of8rz+i/IG6qmjkatRZeQIfdzr0UjMOR6zL2YMTN0fBHme9so9eRXWdq9zek3yqaZL3qHC1Nd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eYbb7Ip+; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7dd8773f9d9so472039885a.2
        for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 16:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140253; x=1753745053; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laSC4A4BTyLjXy+3yuNmVRhYLbVBWD8DtjxqkjjPiWY=;
        b=eYbb7Ip+ck0a/FVeqTqhDdqim/NB3ZY/jAVpkl3pljbWmMEoSRvOW+EdXwbDe518Mb
         LXEnvbepZGVc1+7/EO9DV5rXhoRjGP/OJOg34N8bwAwvqC08P5NnRUpx9hRrXPCW075m
         qOnNXqJMwRkTUZ/QMb7FaT1G2zWviyJXXhpxouEj3RdMURwEHeWh33eI/vB153hQ4BN2
         yjpHad7bTFaBXA9gkWd/xj2I+YuIW5CErOvjhVONvnPefxeNfwrXhafu0pCKiNpFGBBb
         1izaop58RYHT8ej3iUxozwnhdsLvEvkIKHbGxSPG9wUXL6Sywxd8YuYFwmO8pCnGLq1N
         bAZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140253; x=1753745053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laSC4A4BTyLjXy+3yuNmVRhYLbVBWD8DtjxqkjjPiWY=;
        b=aAnBghX0VdpV65es6ArS0fLLYvyw06HpC3btSuFt65z5oTuEuHgnWo2+9HAkoXwgmp
         pVG6T1OUs7eumLUroYBAT5Ac6GDdJV3cmat0yaHny5ekLe0FSWeWwcVj/z5fRPqw1hLO
         jSJrmW2C8oTAIvzM9GntQz9WVTbqZRsBvW0syaBxbWJZuHZWIT+D3dJW5NnpGZO4XP3o
         BRemrdC4e+NvTUCUVHcUCUMzPp2qPpJotX2Y79uTAZUn7idrmrfhHmcE15I018j88pqK
         DrHyYGUx+IKFUVAQV1gemA5CZpPRyGLZlZtoMr/gNr8A8Ct9RFiYVp9ewk8GD6kmzGt3
         I5tA==
X-Forwarded-Encrypted: i=1; AJvYcCV/qkZajwxJAQgn4Q7RsAhLeGdOVAfXhHBwB5pN0SHjdWKSaCuIM999fWf/eDhqzNk8YgTSaG+dQrzTSVxoOLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJ8/7M2daXAN+N8PLowAUowkekIEKSHqN3u2eDm1RF+4H8hVGn
	ePj1Ny7MsugbY7tD6Dx3BnK6VC2CX0Ken155CuiWtQMRi5DJnYS+E6HEd75CTqiq6A==
X-Gm-Gg: ASbGncvWXu4ecgUH3lgtK5NS6B8mGLb5+Ub2gSBAh2aVsmNOiu5JZpjS9SFsCTZn0Nn
	CONB1KgZ5AjvZG5/o8at2rrt42g2DmKRYdtYLMW3jlEKdT3gEIIII38wk8rOLr+o3Oz4oj5dw9f
	3GT+9rLIgz4nuUebjKlcsea3aTQWuLwAdIGIgNZv8G6dgetkmoaVSqSpXwPth3wXg7G5tOUMcgO
	bt5CDp9Th5PdrTsNot6MTnzfl6HgUo+jFsL1ZTo9SZ/LgxzknwtAWSmz8oHt5/cHBH+QipuTkMj
	LtbTMhYfvqoUYH8yPSFBz2631qzAyl/N7aa+BrOfCwZOYD3KLnw90epfwEDK1Dn6KrbT1EZW8HS
	uUqgRoMI9bRjsUDYFOTGmBrV9e+8CZDXWoB2ufqqhQ6yXpKDYti8DQ5Mrfnbm0WkoAW4=
X-Google-Smtp-Source: AGHT+IGR3ndRwfwcpR2AZDSxZ5D6qDOEkxCXXuwJKc2a6LVCAkBimE7QkoSpZmkzlqzjkDJWiHCy7Q==
X-Received: by 2002:a05:620a:2556:b0:7e3:404d:8dd9 with SMTP id af79cd13be357-7e342ab2721mr2843036585a.23.1753140253177;
        Mon, 21 Jul 2025 16:24:13 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e356b4677csm459128285a.32.2025.07.21.16.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:12 -0700 (PDT)
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
Subject: [RFC PATCH v2 13/34] lsm: rename exists_ordered_lsm() to lsm_order_exists()
Date: Mon, 21 Jul 2025 19:21:16 -0400
Message-ID: <20250721232142.77224-49-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1878; i=paul@paul-moore.com; h=from:subject; bh=mwF3ZjAzSHlGtLJaNMcChK9N/YSg9AZ/qVLLLHNmcZE=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsu3I2CF2dWmc/V5ahR5wheUO+S6kvfLvkal5 srUcV2JrKOJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7LtwAKCRDqIPLalzeJ c0fWEAChRKn+FJl4HDckECX4DwusW4Ag8Xd1LeMR+B3gFLexRjxyekaHpFAQcvIV25XY7B/cRsr Qbv48MCrLBUGH/Ea0oEtRpEAuWssrT3hPUEw5DbtNSj6O4kU6o1bSj9YUW6PIW+vl1TFuJKL/0a yhT44n/VHkQM4iKnfuaLgx5kVCnd2iWA6aT3Z2GCZixrGwefJwqJFNbzNDt0t5M0cUjISR7Kn4L KrfZl8XX5g9BL6MJ/M4ZrHuiKdcQm9BPHhpWTilE5M3cpj2OdrTsKAFom3SyVtWLhqOXGTLX5E1 VnZEwTyhef6QLlUEKZR8SO5BtwggXYM+BhfYQtMnomCj5dIlPdLUfjKKb4ddPJ8WyGNJSqxwRCF gevkrLky2chEuU7ujyFQajZ8vxcBiAk93EG+eHGEiO0/kONRK9V7GYuqgEi80DWcfS0Jfl2hMRE CMhw8PoxKn39XZCWuwPikgrLGyuLXIj9aWaM8c6w8qvrkhGB8BXoe+RFtJN+Mgw1I3t6rK9mcvU ZTqNhoRwFRQ+9fY1T6RsXhwpNwYLqyI/M4FWC0W2ufUej49GhSJQ19e4cIwUuryxchq+js/H9ps nLTbIw0t03ysGjkmN53G3Bka3Vm6fZifbq1o1Ojz+vQUsFu7MMFM6m9hZihXwUYqcVBcFHVg5hO PEP4D1g6Mtx5QkQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Also add a header comment block to the function.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 14bb6f4b4628..01825da2755f 100644
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
@@ -266,7 +269,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 	/* Process "security=", if given. */
 	if (lsm_order_legacy) {
 		lsm_for_each_raw(lsm) {
-			if (exists_ordered_lsm(lsm))
+			if (lsm_order_exists(lsm))
 				continue;
 			if (strcmp(lsm->id->name, lsm_order_legacy) == 0)
 				append_ordered_lsm(lsm, "security=");
@@ -281,7 +284,7 @@ static void __init ordered_lsm_parse(const char *order, const char *origin)
 
 	/* Disable all LSMs not in the ordered list. */
 	lsm_for_each_raw(lsm) {
-		if (exists_ordered_lsm(lsm))
+		if (lsm_order_exists(lsm))
 			continue;
 		lsm_enabled_set(lsm, false);
 		init_debug("%s skipped: %s (not in requested order)\n",
-- 
2.50.1


