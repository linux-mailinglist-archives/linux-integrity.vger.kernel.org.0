Return-Path: <linux-integrity+bounces-7473-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2BFBEBBB7
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 22:49:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FB4C58827D
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 20:49:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925A8270569;
	Fri, 17 Oct 2025 20:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BEAsUfw0"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D06E9233155
	for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 20:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734141; cv=none; b=RPzpO/9Wj13C/eZmWqwdlQDaD+GpMCqY5MJwHAnRE/nN7U6j8iwdpZoK30aY6X7WZpqhwyEFitXwS4SAlGA5hdRM/KiPlSweYutvkLJeIfLhmNrIGivSrSI8ZZSaa5t2GEeaSgWwCnD31E2CthmcFdxwcyjNAoowWcJaSMQekJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734141; c=relaxed/simple;
	bh=3nN+Lf2xoX8WCto15YACwl8uoSNV/UuSmv+Lj7xFNSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rop3qEKex7zt8WzqmoBBWfJXVkoypzuJhh9a8wGYxv+KRyAeoCYKrpZ5n0C6Z3mHbsjPR9LVgZyB8XvfVkoJxa4fjjUSRr/+FN1lKCi45yvQfKdHaq2f2LbrYLSuTYd4z1/tHlSY80EFfVLSuMG8wFLZETgBHO14gkBEcMZm4ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BEAsUfw0; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-88e525f912fso349316985a.1
        for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 13:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760734139; x=1761338939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zTjzhsNjIDUZSYUv02RN7INkAicrlPW3NA8BHgcVnfg=;
        b=BEAsUfw0/AnOPKK2JmIER3XD1EpzBYcY5YEOuVrtRMLcbGEvaciMEHn7z6Ph2/C3K0
         nr8mp5SFmG80PuMAq5mdLJ90nSJBxg7AaoAhbWVPIv5od1ZPRZ8+lpeHzjqfl9qn0Fa0
         dkY7SfhDd30yVrZjto1H3nYY4tpKbEEyFC2Tz07XPmAYywQiqnBITP1h+fTi8oMpHa0O
         b1W0230ib/QUe4FurRFhsTqAQ6XGsV+vXUHDXLcYoi3twxbi4/ABGebr7P/d9g+cEvni
         J0S9hrcX3ugcEwMoqpK9ujIimKz+Z1SvlQkyDxF2BxaJfC9jKpiFSvAFwzPmYq8Gq2Ah
         WvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760734139; x=1761338939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zTjzhsNjIDUZSYUv02RN7INkAicrlPW3NA8BHgcVnfg=;
        b=vv7T9g9GGtKEcMeeZ90RjRXxvUJYhiSS6oPpS+LoTDSZzUbOIvF1s+jG1Be2Gn4YMX
         Oc1Ag76DcdaIa02lJKIby1nYH8q5jSVZxYtLNzSmITkoKSDq3lpqlQwHpAtfOiJgLAuT
         RdvKZDB2F9CnkAlAbTHuXMWF4ccRwfmEsOWSMS6c3VJZrrUQV0BUT7oKIf7ZKTyx7lBa
         WFxYOyFcjBRUp4H4QcQd7/1ad1XTAwLHXCqNL32QQV1Z5GHvsXiZtX7mJaU7em/qzsz9
         v2Elajk+keWxCQpcZwOCRojyYs47i1gUHIGQLgn5g9axubCJgSxwlvI5wqL1jof43m9K
         4ehQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtowt3DMzMo2ijiPq7hRKLcC7xG6NjWXWCwcLG6+11F+M9hjhYiAd7zqMgDBnY5unxbfkYCGG9VBVj2cQmv/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YypkdGpy3DoZKs2m344EWErXWOwyt/3FIlBgqa2JP6BF3ZDeKCU
	CeLxfRsdWtGcKMq7OEKe6SDlxTO/OL35lVUSaGlQNRBPkH23Gu3HwNi/UMWo46ztSA==
X-Gm-Gg: ASbGncu80z/NzQcDTBVuuXFfs9UMMpcv2cFvfkYx1l9b1s8G9yyv8Lv/Cf96qUIoNcN
	AKK+2QlF1eIuKilFatScVoO4byknrfFthPywia5QSpOQIo9mXw633XFLtZrxNpXOuMcM7L7oIA8
	zt4M8b18lP2ZG/nk23YBR7GCipMnUaciE0GHGwDACSGVnAQFvntb5a2s9hcQvQlFg5Skmicy3R6
	GuwXoVcYPSkEmI16+rJZfMfzFqW+6ZNPOIIn6pXX/DHBhb9QYb4k2/SrA1sjuC2GlVz+IN05ZIl
	MDdP3K6VyKqdQ4pV3sYVNxXX+K4fcSV3/Ke/Vh596OnUrhY987iQmAXsKkMiam9y+HppTSrZtQ6
	Kdf/XpUGPWV3glQKQTb2ON43966qkbNrMybV7OCUt8TBzRw9H1aJyVPbem8cWQMRhkv67TDjjJO
	MYVYVzwuKM8grkH9+3Qh83/jeIcq1rGA/mq677WYua45F2EmFGobpZNecT
X-Google-Smtp-Source: AGHT+IHicyBQ95yOsVG+sT/sDWfpw2MK015YQ7gM54Wnw8Y95CKJfoAVamgfEMm9rAgzcgYNKKBH0A==
X-Received: by 2002:ac8:7d8a:0:b0:4e8:a6c3:4322 with SMTP id d75a77b69052e-4e8a6c343dbmr31965431cf.68.1760734138594;
        Fri, 17 Oct 2025 13:48:58 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cefba8f0sm42490285a.40.2025.10.17.13.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:48:57 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: john.johansen@canonical.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	wufan@kernel.org,
	mic@digikod.net,
	gnoack@google.com,
	kees@kernel.org,
	mortonm@chromium.org,
	casey@schaufler-ca.com,
	penguin-kernel@I-love.SAKURA.ne.jp,
	nicolas.bouchinet@oss.cyber.gouv.fr,
	xiujianfeng@huawei.com
Subject: [PATCH v5 04/11] tomoyo: move initcalls to the LSM framework
Date: Fri, 17 Oct 2025 16:48:18 -0400
Message-ID: <20251017204815.505363-15-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017204815.505363-12-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
 <20251017204815.505363-12-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1895; i=paul@paul-moore.com; h=from:subject; bh=3nN+Lf2xoX8WCto15YACwl8uoSNV/UuSmv+Lj7xFNSc=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8quYRZW1vHN9gN6QmYxFAglkZ5tHHx+hvPTJk s7MsGvYHHuJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKrmAAKCRDqIPLalzeJ c6DUD/kB/LfjEcv1Lj+kjNlh5nwM00Tb9fVsgQ1QLqTFcKi8ro4VvEdAtsf1j7te8yTv0byxPrf bf5tO+H+YDc2zH228OoSV1ayvEiaerL/byhf4Usvm1iDqzJ+2QvanG0WLsvaq65W/XFxgklY3G7 GQvCJ+oO/ZEpRXr25gDWDoTiKphL8k5sKJ1nwsUa74qmcWpKrluPTjZHFOW1Q5+H9mqVf9JufOl qNYh3cRP8XCC00mZQboQrkr5JmZeYXhFYHoFaL48tW50Fb4B5xnmwGz28MPr3rQom3Y6m4H06Qi iFGSzexu/UsE62w8Dnaa4EB/nSNzr5q3GFud7RfMPfQxHMRKiXn66VNgFzTeqmsMDx0SemnK+7X IsP5fpvYwEW1IhCfylkmLNkvicT0BiKl0TyW9X2OoytIgDqQOUpGjuR2OVkoxwirYvDCg4vp/ni Ju2jD0AxZplPSXAvUd0UBSQ6RsT5JWOgGRBg9ML4Rqj/ikexrbOa487YX6uJ0tFS8EdaOmeMsT8 xbq5ua38AgdvwKk5fGfK2LsZGG9zGNuhwVHKd3tlloJrn1B0hbiTewTZ/NGAfQI4N6dg3CmX6Qr qnGNmQEhU+Us6qSdbwVQlCHemCv/kF+rO7PJ6ykIPflrX2f5tvyRiMNCv7ilCQnlJ8Y90okITIX 4mB+iWdjyASGdoQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Acked-by: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
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
index cb003c460dc2..c66e02ed8ee3 100644
--- a/security/tomoyo/tomoyo.c
+++ b/security/tomoyo/tomoyo.c
@@ -617,4 +617,5 @@ DEFINE_LSM(tomoyo) = {
 	.flags = LSM_FLAG_LEGACY_MAJOR,
 	.blobs = &tomoyo_blob_sizes,
 	.init = tomoyo_init,
+	.initcall_fs = tomoyo_interface_init,
 };
-- 
2.51.1.dirty


