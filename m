Return-Path: <linux-integrity+bounces-6688-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61676B0CDFB
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Jul 2025 01:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8396D17BA63
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Jul 2025 23:25:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783292475C7;
	Mon, 21 Jul 2025 23:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TmmDNThK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8382472AC
	for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 23:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140271; cv=none; b=ifQZRVgt+ivtDrauX+pa2bh1lOcClWt16F2Grt4+ZNXqWsNYpFDLNVGFGYZG1iIaaPyNgghqPt4Nz3yg87vGvTo+SQXwTBXjwAceoWZWwvnNgB6ZNSlJ9yQZl5N3ibAo6mvs9H3eTFf/MzxLzdo8cM9X8tdbqPo7hfm3/ve86dA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140271; c=relaxed/simple;
	bh=I6ppTevKSz4qSPY3lg/Lq3qMQ5mFXCHTmhEYBYpMo6U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dqexxjY/C/IAchWlKy3r3DWWDs3UBrjPMadfvK9BFkV08Vo4/ZjraNN+7vgOfyHDR6wp5SGjo1jEPPyGSmtjU7yjV/ezXpUTCqtLUE/TZtXajFgQ8XMvPP1lb9Lkxy/WeRW9jLc3bXgtKF20BE9XhtZ8fK0fJYcE2RYV7YWitck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TmmDNThK; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e32c5a174cso468182385a.1
        for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 16:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140269; x=1753745069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RlbKJNVrnIuy1LKQSyFS71oHYCZmuhjOpIeXDddHJuk=;
        b=TmmDNThKxLJb+DiJEXNcNTro5FBtvxXf6eUKmXEyVvaMKH5bK2lPxJSTG41m6zGp1U
         WVb+0AgNYxni37FaWOf38NBpTqZXjhVaH+XFEQNbOLXYw4jueDf639kyX1Fe/27n1rCd
         SAiUpw36XHpIbkgTcCHck7nFYe1Kbk9pdtAIpFVK2BOlLL5dHFdEvT5Vi82hQp7394//
         0tI59oQ15pYAXilIcVCMC5HSjTSB6y7wS8ZbiVSoS0cyAykgVMbTUVSzdcewDhqtEcbE
         M2dqUSkU02CTdrXRfkmdEQlkD0AcLCnjdXkIxN6DPMjVyjeByuElmW66h3HniMhr7SfO
         l2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140269; x=1753745069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RlbKJNVrnIuy1LKQSyFS71oHYCZmuhjOpIeXDddHJuk=;
        b=venG+AbOFS7s9RJ/qXBYZUfA1HVnH68S51+lKAtzubMjMaK0hdIYhgSaQvR0rYxuNs
         K3f2ey7yutpSKFI4eo9WzOn06dJdtwzmx1g2YcsBFxlXwPNPqTwxcDh8p2E6yQjp1Edh
         Uq2aFvcqUMl34WIApTe5jWSm+qPaXAfFvuvkI0PMVH5RoyRbbIgBi1YzrTP8z9VmqYdE
         cLN3VinrKBZOwloMX+YeQ1s59KXMiGa8wFgnFOucu9mf+Vf7K8NhqSr3KLeSEvM8rXx+
         goj0R3Dv5Bn5Ft8lwITHwrewwbkDS0bSjBHHuVZHWt0tpLWVY9G5DV6Kv2GUYMzu7MWv
         8DPg==
X-Forwarded-Encrypted: i=1; AJvYcCXpCg/LqQqTdVnMdrUfExw1xcwGe7iQ+1lfgCtNCRm9Mjqf+PqIKp1zTISobDZCSuJ0AnjQtYsjO/ajLIyrKwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxweYjF+3NlgM0SW4d9IMFUE0UiKqCk7m/27p0EyVXzwpWS0vHA
	D6wvkkShNh3leJ6B2OoZ8ToOMkJ+Qpv3TWu+iBF5clS5uKtnZUWvHrh5sQvFKLYXzw==
X-Gm-Gg: ASbGnct+gPSSzeDKfiohTqWbvXPECNMaZLK0F5X9ZMOcnjH20TP7Adw942nopO/SBX/
	tv2Wkw7B85SLUTxt1trElE37oWfJA/aiooWhsvycBKP4dJ2YtytAevNYJTSOsJtbUGeDJMe1aRi
	QBuqqQaX/MALUX67syuJ6+mIULiVJu3zpGFaK1jgLLcYVSayfQbO1ojw2WYJVmIy1p3zneDyfp0
	7BA1M00JKzsuGiZHvmcIALWXAYsnYbKoVp97Rv0DFbzyoqQr8u+z4JFGt6dD1cZOqCm75mpQhKl
	6eAKOku6kfAfS6p1qEe4Gm3uk1e8B5+F3kJj0LYRglHI2qqQt+b4XcgaAroyc8P8Gu7FkSWtmlR
	rAl5nLPh36Jc0DKTxuY+BYQQadtgJWOB7uTtnrU8dNdqRobCqaMSkKNS5wl6GiluVCQo=
X-Google-Smtp-Source: AGHT+IEaSOHzNkoV4TK0oT5nkZeI4V4uFr/pidvvZi/Rd7gG+KFDSaOSYj/4LxYUoFdky2FuqHBeOA==
X-Received: by 2002:a05:620a:640a:b0:7e1:90b9:6cd9 with SMTP id af79cd13be357-7e34d8f79e7mr2237083285a.16.1753140268880;
        Mon, 21 Jul 2025 16:24:28 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e356b27ae1sm473709385a.1.2025.07.21.16.24.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:28 -0700 (PDT)
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
Subject: [RFC PATCH v2 27/34] tomoyo: move initcalls to the LSM framework
Date: Mon, 21 Jul 2025 19:21:30 -0400
Message-ID: <20250721232142.77224-63-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1769; i=paul@paul-moore.com; h=from:subject; bh=I6ppTevKSz4qSPY3lg/Lq3qMQ5mFXCHTmhEYBYpMo6U=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsvoZjREpIWCuSqwTbW2LA6XsI/tTkqOKa1zE fnJ5aHe0h6JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7L6AAKCRDqIPLalzeJ c8iPD/4mAh2paigqx5VS6lwRH9npSDmf+UYE45kX2ZeVTCKzJudhcZ/1SLafLdPB7Rs46LLcngs k9ZLnHHP+9+XxgRNtmqSjhlSHtgXgF0QPDrEE67f+bKyG83NNVouTyzlawvq/ZHfG9d5hnGKBbe O3F/yotrG/VogaVkPx39ZJjvFfGYxwU1QRwgkWGhl5vfOpBpLWemVK6Zd6nbLYWDy8p8n5FDcCU tDmx9y+/yGrErqPJAWDm7kSlPqUwKJ3bPgDiwZ+oyk1vffrHzMFRoLNAf8YP5GUtU8N7+Hakvw2 fAATFDwYnpW/Gh1C48+zTOizUF7om+QuHkZSmz9rn4RFW2lM/L2FT5/ztd3Lc0gh1tpz7NR+cwj CAOQu4e30ywYgE8n6RtMmIQ576nOVn53i5Q0PiWOhbxPivxsncEgoYXJcwJmWtH2P2MKvMcguo1 xAYEzWP0LK20pVRkDQ5NtXpmxz4jviUP70wyHdew4osn/5NAiYAzLkNlYcqPaBjPFFsaxiv3okh FXY2O938F4xfKVpm2MmRvRj+8lYEFMHJX7O9R0o2gtnfI8JEgkRJWAhnNPf1NCNPFq5iN6nNDuV W7qG87MMGlu/YqmWpLCUtdfao20+/Pdc/B5WB1zOM3dTQAptE4s9z+TLmL2BnSCC2akKF00HCrp hQqc+oIJVFr6VZg==
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


