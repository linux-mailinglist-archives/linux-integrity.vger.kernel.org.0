Return-Path: <linux-integrity+bounces-5716-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC55A82FA9
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 20:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F18E7B1D31
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 18:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B1D927C858;
	Wed,  9 Apr 2025 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="W/LggYET"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54499279357
	for <linux-integrity@vger.kernel.org>; Wed,  9 Apr 2025 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224832; cv=none; b=tXAyR7JxKCEkJYC75qsUInOzattQfPUyNL8uuHUwL4tXNonJqjcklAheQDgBHlyEwyjx87S7FCdZFzc4RqIzvh4eaPivy6kNNyT0c/ileLfvXQGcNaFpOMPhOYECJERG3Tu1CIJrD+KsX6iTG4jrx51zlbknNVlhso1BXiCkSXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224832; c=relaxed/simple;
	bh=ncP3ipv/bV6iSyC9l86b4mFrIDnsVn2iRTu/Di2SXUk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/MpZQrcAd1+65a7mIgHOrkJA9gPxiMp/lRSKOupjlvTDJZwvE0pfufgTAx+ArfSpkT03RHld8VgOJdyY/72nyk7BHYGf9GqP8TOnDh41yI6Qi/nK9O78K8ddBnjlzTxAFD6FpoTaIij1wT5HrYRRWOotxKBl7YhiUT8T23CiH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=W/LggYET; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6e8fb83e137so63322876d6.0
        for <linux-integrity@vger.kernel.org>; Wed, 09 Apr 2025 11:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224829; x=1744829629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5sXS9/0vT6l4p41gXbqSfGFGiz2UswVqMs3yG5LFyNk=;
        b=W/LggYETnLpTLb0g9Ue+wdRfslprOAjhBy0PNhyciVkcc/uALWRtz5g0h04B5rZFLx
         YxOEpPJ2bGxIdC5Sn573x7txiQoOtn8AEwsFwiuNYVwsfgsmOBUvPaO0gESZmmG8duMZ
         4l+ECvAUg9uWuVzaV3wOMr0rVsVmL/benCYs4E9Ym7YWmh0+g0Nc55vX4pU5Cf0CGpbG
         yLUJSVJTyuDvyHstM/GSThZiYwW+6bN3U/p/cBzjO6Pbn+YfjDx1YERKjPNZjpAOMHDn
         4weI12tTh1AV5ueWM/8KryXOZqh0PpLn2bip5BjQIv1SgbLOp7wI095LHGtP/cPbHkj7
         DLEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224829; x=1744829629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5sXS9/0vT6l4p41gXbqSfGFGiz2UswVqMs3yG5LFyNk=;
        b=mxEtuJMzzuZcNCSxFB46DV9k2igplN7pZGJgWW204cg76jTIK+g4ppkBYdJvj369lf
         EkKoNa1r/b5/A2EIbKrYf8Z7qlen/E7+jdl3pTIDJCHb8mBXzfisljuP8qgby9mZ5a+V
         UhgbHIivQytWlgxbkr/szJP+PKgiGIopLaTKNqc3QTzlp/GfLNqsKVz4yE0vDuNAtj+V
         C+hFbVYsBR5ZeSuVXWIIKNFyuY28NqUvsyTtqPMlDfZhS1EaSq4B4ph+wGcpBSyAWeJu
         7hdxHlLYzog5NsSGtIeGcT0IKZfHi74xnFVfIQT9AnWK21K24oJRq0szTj+NOHkbbKc0
         YNZw==
X-Forwarded-Encrypted: i=1; AJvYcCUiNwfshGWPxHCiGrtx/T/vFacPAbz8IQLPucyIyZJyXGAvJDbfcU+p/EZnnm4t39WfLvxRy7v/GfWTOZN1CSE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV/FSAA9n/tp7XBprwYCJaIV4GorftTQhV0VB4/zO54m+aozVP
	gkm9dj8JGkp5bmHDbX8T3nnWK/hbdpzZd3okBZM9DG4d7w6GfJmQtfFG5nXdhA==
X-Gm-Gg: ASbGncuWr07EGZgFZ1nes/uFR2ClGSWdMAPtuQFS2AtVE3aBrFD0h4PLwPbUPXHEs0f
	OXMU82ffHegRq56Jbur8tUNu9Z5SE97l5dNUVf9Xxpk6yK7IVvdpeWWsyjXlTvAFVO+0Gvzxab2
	w+DuBbQRIc7j5tq7heApgyDsFuHJO4CIHggTP9gPjalgNbkPPu/8eBMLPwE9ds0PDJfgVE/o2jL
	5guSwReZiIyLBjzz2N1TwyYVabGywZeWhGOpdNSa8qh+jyL7ei0UrEUjfl8l/5MXF5ldQ+l7iZk
	5xZsb11ZynAiHDJ3FY3DK/7j/5f+1EUl+Qs0ER+zjE8nHbXvCpFTTLZzRaD0Yov8vUELBBTEgMk
	LG5VsI4Grl+/iELT2p1Zi
X-Google-Smtp-Source: AGHT+IGikOQWcj33KIm5rOskseWH/Yr6wXc7U+ofTbx3SIVskx7NHnm6yUKGbKIPuI6qNIrMd7NHZA==
X-Received: by 2002:a05:6214:d8d:b0:6e8:f166:b19e with SMTP id 6a1803df08f44-6f0e5a7764fmr726926d6.17.1744224829253;
        Wed, 09 Apr 2025 11:53:49 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0de95f8besm10578896d6.10.2025.04.09.11.53.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:48 -0700 (PDT)
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
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 21/29] tomoyo: move initcalls to the LSM framework
Date: Wed,  9 Apr 2025 14:50:06 -0400
Message-ID: <20250409185019.238841-52-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1727; i=paul@paul-moore.com; h=from:subject; bh=ncP3ipv/bV6iSyC9l86b4mFrIDnsVn2iRTu/Di2SXUk=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sHoju/juiH/zVZi9WwQKm+CMvHYUamYCfM6H 9mASMylxUOJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bB6AAKCRDqIPLalzeJ c/WbEADf0j6M1iz4BcrNyNfco3AIMMOUeG94gDrwdaYGx0kQ26rRMWRKjyseQ6+Kn6ZAJzATNzT SHBx+ON6VTqMHm8cVtMET2Es0dOVG8ZBf7NF2e4WPP5KfROq7OI7YGMzZLBhHP/UOilArfMT5Iy GqMpA8Hx1LEoC2rxvxtZqVcLMuiBWW7jn4ta/L/0+W25JAmhHY4+G+HFXOFOuCDxPy/4Ru2X33F oMA0GQQVsTWKRIZSBRZZNHrLGWNYHoSGYRNygbf25G3AbE3pvr+Kg4mmtdi61IXtFriUEIMVzHB V57rkGShdnV88dG3FM2farEGXWwkB0hsTLDkWxmH8PL0KyRqvKEYM81U/dpg/Od0qW1IdD+hUy6 oPiRuvdBounRwNQTK0GCGvbY+Ub49xOvgI09tg9Dw8sDFlNdT7kfV9DjIYPsDKYBkMxuhFDTI0Z +vFa0rb3awovFPra5a9LA2EViyasxmzDUP+C1ukFdc3MhmPPFNuc4dsb9QqsbujhNzhpMrGj1TH WHOawO5bhZ5mtdPKoNQgB5yf2GLZcwHH9YPhMlNINkFcNnyTTjjEBF8P774dYasB9ReTykiyZ5Y 42Cb7gikVJg8rbZF5aWuyOgsSvLtnrFG1zeg+c3TnwQ7diJx8j+mXG5ZN5zqBaJiLphX4tNu/dV bvkltXm/UQgAU4A==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/tomoyo/common.h        | 2 ++
 security/tomoyo/securityfs_if.c | 4 +---
 security/tomoyo/tomoyo.c        | 1 +
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/tomoyo/common.h b/security/tomoyo/common.h
index 0e8e2e959aef..3b2a97d10a5d 100644
--- a/security/tomoyo/common.h
+++ b/security/tomoyo/common.h
@@ -924,6 +924,8 @@ struct tomoyo_task {
 
 /********** Function prototypes. **********/
 
+int tomoyo_interface_init(void);
+
 bool tomoyo_address_matches_group(const bool is_ipv6, const __be32 *address,
 				  const struct tomoyo_group *group);
 bool tomoyo_compare_number_union(const unsigned long value,
diff --git a/security/tomoyo/securityfs_if.c b/security/tomoyo/securityfs_if.c
index 7e69747b2f77..33933645f5b9 100644
--- a/security/tomoyo/securityfs_if.c
+++ b/security/tomoyo/securityfs_if.c
@@ -233,7 +233,7 @@ static void __init tomoyo_create_entry(const char *name, const umode_t mode,
  *
  * Returns 0.
  */
-static int __init tomoyo_interface_init(void)
+int __init tomoyo_interface_init(void)
 {
 	struct tomoyo_domain_info *domain;
 	struct dentry *tomoyo_dir;
@@ -269,5 +269,3 @@ static int __init tomoyo_interface_init(void)
 	tomoyo_load_builtin_policy();
 	return 0;
 }
-
-fs_initcall(tomoyo_interface_init);
diff --git a/security/tomoyo/tomoyo.c b/security/tomoyo/tomoyo.c
index ed0f7b052a85..a015cf0c4a00 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -617,4 +617,5 @@ DEFINE_LSM(tomoyo) = {
 	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.blobs = &tomoyo_blob_sizes,
 	.init = tomoyo_init,
+	.initcall_fs = tomoyo_interface_init,
 };
-- 
2.49.0


