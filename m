Return-Path: <linux-integrity+bounces-6845-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 50019B27291
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 00:55:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB20B4E5CC5
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Aug 2025 22:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7C0F2853E7;
	Thu, 14 Aug 2025 22:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dY69fvJr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E122853ED
	for <linux-integrity@vger.kernel.org>; Thu, 14 Aug 2025 22:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212096; cv=none; b=VpSt9LwJqZYzFJtwGbX+g7eOv/I3u5K8OWGylGPLPXoVxWRNYVYwH9uEWNOM2JQWp8o4t0w2nKAIpVTimPO8JTHVe8W7VaIPGtWKBO/C92RKqhHyCt4AG4RJxp34+LV4HL1H3gbc6uzXbtPalRg4+UlOMZGblMleTYXLJijKdEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212096; c=relaxed/simple;
	bh=I6ppTevKSz4qSPY3lg/Lq3qMQ5mFXCHTmhEYBYpMo6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYiWRuNFjZMLmFQlv584EU3JWqYrLq0Ed/p7lkoighuSRWlq8nkXF3I6zmV4Ro2ECkUItKy+sXLjygaQ5MLEEZ9Tvy5gPgNSj/6oYtRYKfE36b8DVsAC7SHBIdsuoGwgfWhK3J6kuaFDyuCdgc1M18oJCqsqisOPckP/RRsMKpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dY69fvJr; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e870636870so139822685a.2
        for <linux-integrity@vger.kernel.org>; Thu, 14 Aug 2025 15:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212094; x=1755816894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlbKJNVrnIuy1LKQSyFS71oHYCZmuhjOpIeXDddHJuk=;
        b=dY69fvJrLeBdvz0pi+Gpcn0trOlYv1towZI0HH3UrWkwofyqE+e+dVj3EPb4cidoK+
         Opy0j1SxlbhCEH819eQdaq/hAxPUnifsDOGZ1th2qcZMF20THQ4Um98SnCjbPoU4a32a
         BuhqY7T10d4GNGEa/grrCooVA6V+TJmP+D25LUpotaGaeik7L3R8TMX64PYuwuA86Bjd
         aE/pL6VOlaklEtg63cGe6Emfvng4wrN4Hy/KWSJALYEp5w38LAa2io3sqw98X4MOQgFC
         Zb26AwR8nwtTLM9yLBo6Yo9fUWwCRu6nWALDYhXjijDWqUYUfQhMLkssGIeq8WXtlyDH
         NYGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212094; x=1755816894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlbKJNVrnIuy1LKQSyFS71oHYCZmuhjOpIeXDddHJuk=;
        b=b5yQr7YkbrZJ1iQLPy82AlROVdsN+vJqnxYxpUdgrVEPwsQLGmb5c5e/ijeoPs1+pS
         GtOipsz8E83fSZQqoJoHOSsguhHfz1lGSalQkfnNZLavYgYr7oCvwkZGAEO97VBR5N0O
         lc212a30axBlp6PwlMA9fSqk0bkAYalmoWgIu2HckzPozN1tMY/Eu223p4t1ynd50rhp
         bFW8xk2kCdBAUr4+K+jQ9DVaAJlx6Yoify/r0+aIi2FB0ZHuGllNghtlW0yfeV1E+fcj
         d7euOk2OPYCAPFhyTxQVkny21Hp0xGbTpWBIZlj0uvrfcyrO1TpNxSZ6egrIUrdUMWKP
         HEIg==
X-Forwarded-Encrypted: i=1; AJvYcCWTtgkVy7I2aC2uYp85QbNSMZolh1e1wjk8lJ39kLSkungdYgjz1RSVQV2dKqKaBhWvMN23C7BBOrtKi+Azgx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHIgK/m9h6Pj7eUoOjSf7f0xZGN/cBflEApQigdGANkFdPkXt7
	YLQT1wbNzAb+6lLcsuQO5nkbnpS8j1DTNmrX54GhA/5rJK6nF5ReFJMiahO3wJKkGA==
X-Gm-Gg: ASbGncuWTe+7EHyEkaTxx64uYF9UfwYWXoPdhn27wch59s+jgeIuaCefmuwp/AEHMQ8
	rAxsK53h3r5E1TVGoOuMHTnJp35hQXNqmR2qzjkH7L1CXHAww/iE6FZsOPJlIyLAhW8HmWR9FHI
	8fFQR1p50iRG2JCMkEIfwQ2d6ppelHlordrfp/unFpWrlSjS32tmD2W3PWY7Jmf2Q2c8C3AlLGq
	yzqxO2ZihTzxmyOfN7+e8J8hG4uuVbdSyl/NzPjEO3SSEVGFAMsxWAdsecfgXxO1Wv2a5Ze+t6L
	m9gZR4YYOalw1KFMHor20iRHultDl/2iLOWYVF/JmY2jFaBt5xXHOHcATVtFwE+ceCrxI6tOAGo
	+A0udwKPeHXsf+zyQwpJuNG4tluUzYL/Qf6ef+/ddyPo1+YBx4TW/DA+ocxcOejSwmpU=
X-Google-Smtp-Source: AGHT+IGqgbWieF4Qa+ogfYBXO6K5bK3JKPfbrnEAi85ZWmUGuNrkMAbc32HQLhM9fzeLgV7UWwyuzg==
X-Received: by 2002:a05:620a:270b:b0:7e6:9a4f:a299 with SMTP id af79cd13be357-7e87041fe25mr710624385a.16.1755212094051;
        Thu, 14 Aug 2025 15:54:54 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87b4f1afdsm42646785a.68.2025.08.14.15.54.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:52 -0700 (PDT)
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
Subject: [PATCH v3 27/34] tomoyo: move initcalls to the LSM framework
Date: Thu, 14 Aug 2025 18:50:36 -0400
Message-ID: <20250814225159.275901-63-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1769; i=paul@paul-moore.com; h=from:subject; bh=I6ppTevKSz4qSPY3lg/Lq3qMQ5mFXCHTmhEYBYpMo6U=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmjkZjREpIWCuSqwTbW2LA6XsI/tTkqOKa1zE fnJ5aHe0h6JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5o5AAKCRDqIPLalzeJ c9auD/9uZ/dQQaC0bxAH4Bv8/Et+xXv32FkTYeUGaD1GEC6467HBs4Q0n9e9r45kZgg2pVA48tm ZrBt/sAJn67WCot8JV+SZZ1NwG8HVCWGhEJDdm+1Q3HPR/aaOKzrwweciEMd+jfbwd6JN0RLrNS FtxfHvySOZE0l9hKAPcAkwM7E7JMttI+4R38TBfHU8J0zoYhMWuj0bcuNaXhIQaVkZOdkhWKMJt 5JG0NYN4eh1YdzokrMC+siYctkdzMFgKAy+HjfPTE8rFpiUGFfvVZf+wDUpjZyuxEP5TU7F93Ek tpfgSUzfGmNIfRJhqRmxlDVmxZxLynpyuQfQXcIMJn1dJRHF0gO8zoMmmvdFV/le1AsOeSaB9tW d5sGF8ZNrHrzMaHiXBdFgY9Vlt8zV70wFB7mhmIzzLFglfXXxo/enMVACJkkuGNpQ5OPHFEQZpK TWfWKTvnsVxbjZSMDR41+O6hE9oQZB7IyG2uMEHCh1Ebgia9qskSOHTWKjzgk2VmZeNwi/nU7Xx 3zB4bG7p+fOPVS9tdyIy94PTQnGQOIlO0e1V3o+bFvuCkykEXc7yA34yIKXcAaD0SQ6GxHNb5L1 pO0C/ryNSZZel/6onKnzBoSAhj0QkbMxu6DqgOcbfuedvK5VzD7phWwqO7iN9lEWQh6sft9798f x+wCYHcDJQONnwQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
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
2.50.1


