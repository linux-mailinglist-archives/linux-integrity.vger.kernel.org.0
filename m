Return-Path: <linux-integrity+bounces-7132-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAEA8B7D218
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 14:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2817852652D
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 22:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5329328588;
	Tue, 16 Sep 2025 22:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HFcvaS5R"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC71306B19
	for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 22:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060870; cv=none; b=bRkMQ24BdmXZo0yz/hmiToWOujrtlMkZyoERhQh+FYrmAYzoZQh5TYvGTpKTpHdjikn49a7fQXVpHvhFFE1fGU4rkJr96auOPMHPx3Qz2FQsE7qvy0RyfQochHvBTc0VpePah1cKln7UuoEKa3Bia+2pWCyTCsnE/exy/N79hN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060870; c=relaxed/simple;
	bh=Z7S4xcjbsRxSnskH6u2sgsO64cQUeNwrIJgepGqwuaM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBh1y0WRHJsGNFVwt0RTZ4EOSm8ldaR2NJi0FIBk6xMIxzC7lYpfUXaULJUNkJ3y4lyybYFwhwyOJPl9peXOQslK/YhSjeZ7joXBpXew8lk0O865BvC7PafDCPfDnabg6Tp5t5j07uOdLdz2eMhsib7Nepasau9J6LQcCDKfBxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HFcvaS5R; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4b5e35453acso71100791cf.2
        for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 15:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060868; x=1758665668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0BNnTd7dEGfUewaukpbaylkI9cLSrvRhPcg+4SKOI0=;
        b=HFcvaS5RTNsDXTCyaCGJ1DhER6NCxe6T9UVaIqXk47uruAmnbataDk+y2LzqOn9xK6
         AkbyI/65diEnikqlizBGkV1UZI4Cp9JhpuCCMkA40E7OKzgXVzhEBAIb0vCUaIWpaDRi
         dY3fCrbdqW/Ir960lSJfQk3cYTwXyOMLipJkZ2y2xfDg31IFUX/oh5F195R2nYM9aUhg
         r82JzdABGZkrGIzOJ6HAO6rkzFqLg2c7dSM6izUOtP1c39viKqzTaCB521sHQAq4pBPg
         F5ceXxf7bcbz9KUOXUXJIWJGI9N21iIGVsX5be125cPG5rmWVzZlX6pXDPZUASDOWKWq
         +Efw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060868; x=1758665668;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0BNnTd7dEGfUewaukpbaylkI9cLSrvRhPcg+4SKOI0=;
        b=NiZX3oe6wiJTVHnxqy7cgOnPpEj6z7jUoZlUkGS0sRhnj0mSub72l85ow84XieA02J
         PypmA3t32cj10TbD/gN24+tdrqeCgpWp1uOyjiCtxn1TUUhwI0fLRk4h9FrjWTMtytxk
         ojK4T/zE/S6EhZ12ybqEZwk+/4Lsb0em6sbWpsPSdhuwK4mfhNwCUhjGy+DsvnQEdPk6
         BUDupgcx/hMSWgTNLnkrj1LRPo1ruevy6DOOIJkxmhlwQUaXJkqyimy5GG6zPhPzDo3W
         lkgeUraD67LqmduXB5rW4reZnjWmF50abS7M6Nm0ZyF1PDMFKE41PrNGFzgqFyXpxjJJ
         at1A==
X-Forwarded-Encrypted: i=1; AJvYcCXryOd1vf+mSHkwZPKaM+PBwoB5DzOr5UTtlmZoWL3VcAh3IL7FxUqxygTzeVStM9j/x842dM7NlUwhvw+Y0o4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg0j5+hwwwtkIn/L5JgbA9OIOC0rsNDCSgkjVvjXrPV76pXwDC
	NunxOmAWTkLODVFlM3mZ4OnBDIysW7A7TV+Gir2cD5CXt3yewXM7zsVaUoLrHWeQPA==
X-Gm-Gg: ASbGnct5wuNCezAZV0RKEtdkkDvjIakOC6yGCYGPRwzrPYakx7/VuiVRMbpUKwyT6fG
	V4o3U3p3CriDazSTZHns6d4DswdKj1GRw9nTOXbQZa3N7fYvNakj7ycWi/QJip8ZGoZujDCVQ2X
	TqSSaHq8nD6uVb87sb92pML1FEUc/8I/ldDefFQoecejHXDhhwbuzSWSzojSU+0tadBFMMYvknS
	rGd5NE+8pAW9ZtJ3NjL6eHoTuML6Jz3b3nhQneuMibSCzNXTFl07Frx8WxGKuPGbN+YZ7AfLXrA
	L2rA6mz+WZ30844lICzLNW6UCd9FjH2cD86IxuLeCBuG15kl73RivvTZ2JJ4lkugknAWTk5PW6z
	HbUdwzkOkDHbYjvXQHnD1tBTFwOwKsMs1L7h34IdsngFNbAelJC9z0iNtiZTp8vrp8AxBskpgS5
	J1zM0=
X-Google-Smtp-Source: AGHT+IFfO72+ft90JsRUrPgzExk1rzqG7yc2BivD/ExyJqSnjBvEMKHqekh68XscMqCTI7G4CJ/RAQ==
X-Received: by 2002:a05:622a:4116:b0:4b5:fc2a:f37e with SMTP id d75a77b69052e-4ba6b93accbmr884921cf.42.1758060867754;
        Tue, 16 Sep 2025 15:14:27 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-82885187d80sm603925885a.8.2025.09.16.15.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:14:26 -0700 (PDT)
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
Subject: [PATCH v4 27/34] tomoyo: move initcalls to the LSM framework
Date: Tue, 16 Sep 2025 18:03:54 -0400
Message-ID: <20250916220355.252592-63-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1889; i=paul@paul-moore.com; h=from:subject; bh=Z7S4xcjbsRxSnskH6u2sgsO64cQUeNwrIJgepGqwuaM=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd8hQiYnKm/y49nZgKHyh8NGlWbOQS3tyEgYC g70k3bFThmJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMnfIQAKCRDqIPLalzeJ c2ghD/99XOdicSL+FgNW1rdZrIY7jul5T1Z23ZIf0KcsklhNNxZcaIdy3e6kgeVKCuIECTxV8UH uUX9QDP7riAlWWrE2tLrU3sC5MtX/LebyHrunOpCnOZgitm1Qeu2b4BycB0AWytqhki9703jaTM bAfVjgWcXfasnEjv1r4NqpI8uQgdhwfXvwTjyyMSIe8h7KfIoRtJ6wSJtRE+4MjJNaR8IG3/X6Q +RZlIpPZQOYHieU4aJ8Ilormu71lYjxtEN1m//Ys/cYpr8IBczTuEUq1VY3c8gBGfH+76HOMUXi BpPGrRU+EQgPHml65LX/f3q5ScxP7pnhxS90k9Z2M9OoW7mpGxd9utfY/ZCWKwMRL4KFnVPomrS RlqfCFE+4R3p0Yjb2LPQPYncAwXbDzJCGTcr/HNIkQ2OR0r48hPID30JlaRKovDzxQnmRV6aEEk qXTb0HW+bilHZGQslHdpqJXiACnaBvRhtxb3sKh6NWIAmzYWOFZ8I/bkNky6cwDS73LvjhMqdXx 4ViySUTr7BABNOKpZdVN/Y4MgTKKSTHKyETP6RxowOf/qU132HawDG0MovFkq3Ihp3egD99FX15 e6HDPa0tHQ61DQpMUVJX9Z/3pAsgZkUBUWXflFqKszA6/PYkYL3+3o5Lza/6EiEh/6xoZpoS+Ms nrir/ihR2xzRLDQ==
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
2.51.0


