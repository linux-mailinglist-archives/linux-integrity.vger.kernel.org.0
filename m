Return-Path: <linux-integrity+bounces-6831-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FE9B2726D
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 00:54:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EADCA22BE8
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Aug 2025 22:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688E6283130;
	Thu, 14 Aug 2025 22:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="UhEG+JXS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1D22820B1
	for <linux-integrity@vger.kernel.org>; Thu, 14 Aug 2025 22:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212068; cv=none; b=LvUs8gY+GGFG4/0HQv05EGDFBKikjmK9QbyZ80J0/67KIwCtkcplSUvVMmAJ/BtvQmeh3gb9AxFm2cXdp/u5vkcQBYBOPLjA4S1JezwYbOtyvTuDrisUTJmr71ofR71PKZXMKj7AxWAP6pgRI8uCeDn2Re/RLoTA4Bf6rvcHjO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212068; c=relaxed/simple;
	bh=HKF67OsLeT1myJnqi9Pxbz0WOcMY5KN76H+/4VbDStk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4QMj/RrUaV6EF2WBf67jawGRLtcGecTSfqYU3yNVymbQxAEJ1wMDRNsBp689QEy/3T2nikLnfT+qgDlmhdOa0TgaJIUfFYuuV0VjDwUvtM8MiqtXM3Zug1JggQl/n8seHa8ByUO5H38/RLkPHp1z+KXpyifj1kRbrmQ3hoEkxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=UhEG+JXS; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-70a88db0bd8so14238396d6.0
        for <linux-integrity@vger.kernel.org>; Thu, 14 Aug 2025 15:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212066; x=1755816866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0RgZUydMw7BqGwhxivjtden0TclXeRXnZzEmr97SIM=;
        b=UhEG+JXSJZm3pMmCgTBDtcfaQHZcYvD2ZES3k0HPMrEpDZNkNzMjwncLiPGR3/FIUD
         hlJp7U7bvRkixtJkZeRxlASAvWlOVYa+FDLKEPnNws0uQe8ikhDrD+8CI9X0GeffH8Ec
         It8csLRcUwnT0ocHn+fJymqGjizPJI4KMDQEtDa60FRPDbSsRgEfFGjiLKIhzbqX0ow7
         PwVuYszfiPbQsgHVE69LTEWAmEbv0LI3Ytg5fz6ZNsjkreP3G+WzIpzmEattm4HEzS8w
         PB5xBe1WRQXzY+ufXRW33HVNNxFDovUXrC7tOIQIiRHFZ/NTG2SkCnJzA+fbp98wLZZy
         w+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212066; x=1755816866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0RgZUydMw7BqGwhxivjtden0TclXeRXnZzEmr97SIM=;
        b=kDmeOxqiC19lwqZwPsG5oZbgTTE45LUL4+t6bbv1qBa/Hk9foXoMXMogMVV5l3Ypm0
         43ptq+40PsZ2j+S4IcSyzFmD3yhS64d7Q/UForK97cVbbfcv+o+Ns1AiEj649GRk7CxT
         RDsSWaur7MEvMfz7A57CrIHAjAhvm19YphUTvDNpUzJJhLpkitUnq8MV8Wk2FVxguqJn
         I+1FDxuxXKd8z5uKkqrv1Qo2IKIj8NY6Wr2Z010VToyXZQgpTENVnTC7hmg2X/dSp6Ui
         m5HP4szCVEOSa6OgbxUMf5+5ClqEfHkgdzb7D3/rpdceRHLd94RyoWr3icq3OiCKmJyg
         G/fg==
X-Forwarded-Encrypted: i=1; AJvYcCXOiXzmfvKf+9PZIgyLR7Dh7gppQbjLYyP/Ecl510ygPKFLwUstnOzzRqLQSwR9UMFg0waN8GggWoIhe7Kjg9w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6AwPel7NKw2zncOZa86c0Fs8J5R1fhXp/xDPrriw+aHXd0U+P
	UhKO6Avzz0P+brS1Q1gLo2DMXeRLoWu2uv9dn85ArCv+GLpfbas37do10JGdur3UIt3Z0GY+Ocl
	J7ak=
X-Gm-Gg: ASbGnculVGz6UhAavxdEs2lu0CyavC093ZoYwBZjjzG/EAGuGi8PvZl/1MDAroDUwX5
	g0zptr/qb/D31HwrrqcMl9TlYYDaapIUyGAhTJprF0XMK5xh/Pl9zlcSyuWvwkGD0hE8jD3xPPS
	apxvaTeBHUYDEzkWB+rvhK/ChZwjAScihHqhO1iaPMLPZrBXFYOsyBa/NswxI7AM8n02RRz7YNF
	bAHkXKWshT/+jzfEgtQ4KqW+9pZiJGSFvJmYFUx8FoLGnqyM/NrnSIC8gGC8ecukNMzDMsNGPQi
	uYCh3rx+tGX1hQuxNEE3xixEB2hLQKdXrEyrVelby8fAYnIebRWuCDaUF1lZafY9oew309brbwY
	d3bi8t6UPy6IPZkaxAGUuhnsLby2l3gR2X+29j+cyn9kFGYUaFqWfBkgzw079hdq8qEc=
X-Google-Smtp-Source: AGHT+IHh2BCGfCJjFaxhrZ6UEEVwCUY3ho0STniHHyk7SGBUx0PDnA6eNOmbxfA7FxP7oHlb2waXqg==
X-Received: by 2002:ad4:5d47:0:b0:709:ee6f:1488 with SMTP id 6a1803df08f44-70ba4748493mr9032146d6.6.1755212065892;
        Thu, 14 Aug 2025 15:54:25 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-70af5b0877fsm19436466d6.39.2025.08.14.15.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:24 -0700 (PDT)
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
Subject: [PATCH v3 13/34] lsm: rename exists_ordered_lsm() to lsm_order_exists()
Date: Thu, 14 Aug 2025 18:50:22 -0400
Message-ID: <20250814225159.275901-49-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1933; i=paul@paul-moore.com; h=from:subject; bh=HKF67OsLeT1myJnqi9Pxbz0WOcMY5KN76H+/4VbDStk=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmi2U/3Rly9V4RLpMZZBjXhJ2cx+k41/pVuwn 2o2a8TT4uaJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5otgAKCRDqIPLalzeJ c5cxD/wOmfbUQfVVe+5soKKBDJgtVrsao4bUezJLejtAizCf6JW9qs7a5qCezwdNVHLv+4n72vA ErEezJn1hOOIopYmLHZEq4oao503iTWQr5CV057LD7BWNQFNxMBi9HFncYFJoWYz7ptGdWtKAWx O5vo28xFuowbBBdI+lOEiZLbCJfzmEbLN7L5JBmB0DlRXey59RqTnGu9lciNHnCQxPvRlWN5JI0 gMisrf8HLhKIgK9hT8MyxgK17ZGO0wiQeajefuxUfakCziZ8g9PK6MnKHAZ/egO8EeIMZ6on7dN KBAx7g6eJ5mdTf83zHxjAUV7g2miocATKtv+yzZOWpp5UqCFBwEONiEiZ1xGHgVyOHQ6Cx+l8Qe lymhf7bRTX1XfgyAtBSTsNbVB4+tNu5u1QttIWYMGkPrFAdWorfTvzjEPtl7RIJPvW7DhTUV9Yi 7WXWMHF/Npn1ynqcFqzdRZN0jsGZr9pDxo2bDVg4wPSq0mDayZEi9ccYXxZlXA+nh6Jp2t+oM3q H39g5Nkd1qFyCfUxelPp3/YiwNZQY6ZK3tcsPprCgMqK+dtG+WYMtO5wU68vGqaYzv2pL3u0HDg 07jnw82QnjBErldyC0kx7M/jwOWkH1NcoKNTYGXVabts4Uto7LCiBmAC/TLpkWAsD9xKnMfYX9+ tfIzumRTo/p9Vng==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Also add a header comment block to the function.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
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
2.50.1


