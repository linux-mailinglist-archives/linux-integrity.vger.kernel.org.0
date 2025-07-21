Return-Path: <linux-integrity+bounces-6689-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 10382B0CE01
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Jul 2025 01:25:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D566C4A71
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Jul 2025 23:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4583255F27;
	Mon, 21 Jul 2025 23:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XKasALV3"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EACD02550D4
	for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 23:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140272; cv=none; b=abQ9a/rIWczgvZMB6oN1Db2p8phuKe34nKn7G+sc3SJgCHRhhhAMR5Y+2QrzkD7UbmXRyGyIvtdGTfM1Je8PVqIqcCPzX2IyDQVnouoGX7ZUd1U3jC5UujY6t21TPWMtga40NN/SpWk3vonBMzLqRCxQMaervgTGdxBR3t6OeHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140272; c=relaxed/simple;
	bh=fXylwXXBB6mvLKxQHAl/i0nDwp3GIxUSzI5Ds9tCq5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hlp/CwPN0dA4uk/YrLNYLOQsmmFWQZ9dhynHsz3LuNKW5qKmgDaZEXtQfv9wrzBI2d0h9Jgl1SYUlNuiiiFsBCjrURTiBgeTgTE6pYiNOqbyfJcqMQPp0TV1mLKypm9cOPsObQqCAETYlopZfdZxu7upSup1TGZh2cxLH8nm3nA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XKasALV3; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-4ab3802455eso64351521cf.2
        for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 16:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140270; x=1753745070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AChpKruSXH4shBW9tTAspXM8SkY0T38J4dZ44b7wxoM=;
        b=XKasALV3LJrz5ajU9kxUT6ZT/vK1/OZInY0wwKGGsgBEkOLl+eIosDwGJ+6jLuYp0H
         93jFF06ecSnzmdc9GL1vg0Qmg4Ezis8nmCZxZJaen0LN8b/T3khuM1RPhINTkcUOzFsA
         Lsu6domA3ofNKXS8qSD4etALwWyWKcZkr0/1TKfAeZzbXBx91gvwT2wttWVmG8hCKfTo
         dfRJiUxmwEsmy5odbyGAFAU4euFkjD0WOSVcamnDEP1mNCYYT4p3xgJc5AL83Xpdlk6o
         ru+IJ3XoPzGfDF6ZHrO2vhvaQzxP0stNrHBSorxzA+j0ypbdpLSA3OFW3bm8AgblmgHv
         jrTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140270; x=1753745070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AChpKruSXH4shBW9tTAspXM8SkY0T38J4dZ44b7wxoM=;
        b=gvfHwJ/tMKLf7qOYOUlQlgTPCm+YhuZEbKhXoxuZ8eQKc49Tn4cbLA70EjYL/3Ua/H
         x4k/7yhpAzXX+nD7XCbh+CyTelswh7mv1vGyr9fy2zUMFUi9HpKDUQTjkBJrEbkE+QXo
         FoGWOole0aQMExNCx8RisWtacZI5XESOgSYZ7fEEN3AfW81iOgKaZzCOPXYR2vJ4IWDY
         vGS5ACcuvOofFbIomoWFSZ6CQQu5ZYM8O1PWXVEnw9byhppaUdqCX42j75P2K8kJbUt6
         RaLepelUmymUJNTVUKZpDoGiOlEb5rybCJ6balsk2MwX1gOqaGpnQY7XBhWfFUQuM8Uw
         16PQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjhlxJQoqowv2yHh3cuZk1jMszmgDWMjjJwawHjWAVhoJxYNT1sc7cJ9B+KxcXxGfd1icCbnu/AQgWR5IlzLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMX4LI2n54ed/XCHYgQSX5lo6RaqHZKsaZFf6khKdNjlDJF3L0
	5OOF3GaKfeMWPALeSPtLJFoMnKIL2hTAQZ+M07cy3wM+lFLaOM4hHtQ1qk3R9hbrIB/yjn6czSd
	nies=
X-Gm-Gg: ASbGncu5k+yYIT/NdLLSQeo0xpJ3PdPZf+IbET/EcSqnqpUnAvGw1O1TjnUqgwroWbX
	GLIJcteDmyO5ksPIDm/7i/cl1CM4Z7VVbwsGPe6q6yFy/6vz3RgSP4lSZP1rJxJyS/opqSZtZIU
	iQSzfOQZrGQ4zaAEYrriKnCxo3FucVXXlGUqupU6DZpswsImk4DjZFxsOSfk+46Tak0F08w/O3o
	AsH8Owa8xEjKHuvfINxX5glPlRUZfDpB4amwGojxp9uZbHqni3bkC968uXcyop+pxs2rbKCh/Fy
	Lgo+VQAxDiTJPAjatlgWE/UAFo5j0N6cBNm4T4BqjIlfoqSYR2weH/tEStDB7Y6xe0vEQZSxKUs
	J0RD3MW9d6rYHbtZc8y2OkD0djKwc5Tt8HY9ZEf8D3PMA3A/Q+S4d5x9hZ0Ii+ReFwZeuXaDruj
	1Vzg==
X-Google-Smtp-Source: AGHT+IFGIvIwa8WNF1menjGeEMvSBVjGCT6kAL+y2Eh1Z2cmIw9BZdm96N5Lr7Wk4HOPV+6hqxnwqA==
X-Received: by 2002:a05:622a:1b86:b0:4ab:42a5:7f1b with SMTP id d75a77b69052e-4aba3e1e339mr338330681cf.47.1753140269911;
        Mon, 21 Jul 2025 16:24:29 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-4abb4b246b7sm46898641cf.57.2025.07.21.16.24.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:29 -0700 (PDT)
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
Subject: [RFC PATCH v2 28/34] safesetid: move initcalls to the LSM framework
Date: Mon, 21 Jul 2025 19:21:31 -0400
Message-ID: <20250721232142.77224-64-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1823; i=paul@paul-moore.com; h=from:subject; bh=fXylwXXBB6mvLKxQHAl/i0nDwp3GIxUSzI5Ds9tCq5k=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsvrk4z0QvdJFbI8xzz63crkC3dDkkM1dTnFz NCzwCtbYEqJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7L6wAKCRDqIPLalzeJ c7qDD/9OUnm2rpgD5G+DPGb0vSJv0Pf+Zl3c0qosUmKqR4w3q4tW51edfhPgBJEZi1QOJNe9rgO O8pj8PFMZUHnFCP/08hUsmiAFLxC+TyHg7XAC9taKHDR7zLH39vILPAdCUxCmktun9QIj73CX/s ehAMdY+kYADRID34MvUiRAOqjG/KJiB8kM7Pmg4p0JEDPzHZXTfEdVFMnt+v13Cxl+rycJQin3z 8uX6MdVJG2sKjJyu/dN1XwB20EErcDTO3LsJEMaIjmtUjP08iG8UmGYUGSWxBPVhFXUhUZaevQB Z7psoYdfHRj/1o+17v7dbvndThCOqfd4IJAh3M5Qy/mYXLOwOT+ZwYR0axyTO1zE53O6V5SEhNm Ov4uDtu3n6Vrb94VwLBv8AKyTdK+6p+iEJBgmWQTQX+mTXo9VysMUARTNTEfXYmsC8ZGDe4nEB5 OiOGMLlpoWFcJ4VkMjECHgMPtaOQI9Kw6S6whs9yaN4gPZuS8jJMjllt9k+CV8OliuGAEYistwy wdWk/kbgpQBCbSN1H6nwUzBdB7x2oo86dOm5q5A7045ptGiC9XYT/uwS1w4/EatnYC2TmmLOkXB Cn77viBHeeVvU6O5hxGoKBfInkcllihGTMSU/vvo1lGGmEajnuxUbv/wAi2DTRfyBKwtUrOCoaR 40JpZztB60hZzQA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
Acked-by: Micah Morton <mortonm@chromium.org>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/safesetid/lsm.c        | 1 +
 security/safesetid/lsm.h        | 2 ++
 security/safesetid/securityfs.c | 3 +--
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index 9a7c68d4e642..d5fb949050dd 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -289,4 +289,5 @@ static int __init safesetid_security_init(void)
 DEFINE_LSM(safesetid_security_init) = {
 	.id = &safesetid_lsmid,
 	.init = safesetid_security_init,
+	.initcall_fs = safesetid_init_securityfs,
 };
diff --git a/security/safesetid/lsm.h b/security/safesetid/lsm.h
index d346f4849cea..bf5172e2c3f7 100644
--- a/security/safesetid/lsm.h
+++ b/security/safesetid/lsm.h
@@ -70,4 +70,6 @@ enum sid_policy_type _setid_policy_lookup(struct setid_ruleset *policy,
 extern struct setid_ruleset __rcu *safesetid_setuid_rules;
 extern struct setid_ruleset __rcu *safesetid_setgid_rules;
 
+int safesetid_init_securityfs(void);
+
 #endif /* _SAFESETID_H */
diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
index 8e1ffd70b18a..ece259f75b0d 100644
--- a/security/safesetid/securityfs.c
+++ b/security/safesetid/securityfs.c
@@ -308,7 +308,7 @@ static const struct file_operations safesetid_gid_file_fops = {
 	.write = safesetid_gid_file_write,
 };
 
-static int __init safesetid_init_securityfs(void)
+int __init safesetid_init_securityfs(void)
 {
 	int ret;
 	struct dentry *policy_dir;
@@ -345,4 +345,3 @@ static int __init safesetid_init_securityfs(void)
 	securityfs_remove(policy_dir);
 	return ret;
 }
-fs_initcall(safesetid_init_securityfs);
-- 
2.50.1


