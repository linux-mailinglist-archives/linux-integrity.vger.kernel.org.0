Return-Path: <linux-integrity+bounces-6846-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A6CDB2729C
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 00:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 837E81CE05AB
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Aug 2025 22:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81D6283CBE;
	Thu, 14 Aug 2025 22:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="fnLncjD8"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336C328469C
	for <linux-integrity@vger.kernel.org>; Thu, 14 Aug 2025 22:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212098; cv=none; b=OZdPteNXToFO8CeAsAI5wHYydn0AVKsD3PTFFqmtNsC3lf43tDBLzt3We1WqS5IhsQ5+YC2Njt3xZTUog1wC3LGiVh11mvJ8guq2PME2nQyxU1NJ/py9kfOrkhHRFpxzOOMWkq57BnM/NgCn1Ubq1mIvH7Na1b6Rg3sGKFyd+Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212098; c=relaxed/simple;
	bh=fXylwXXBB6mvLKxQHAl/i0nDwp3GIxUSzI5Ds9tCq5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NROw56SRZ6JvbZv/IcJDsr8ybtMJLTWcutH8fLXt+pHFfHCrqidfYqrFHH0s3ExUZrfGGNhUwAUvBwBBo/pFhiyg0WpcLixpKZxXHGvbm7NU8CtuLj3Q7bWYhCOxZkbaFs/WSnT22OxoBhDxLzOdp54GROGeZjWtOhrWj8sr7ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=fnLncjD8; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4b1098d1bbaso22207421cf.1
        for <linux-integrity@vger.kernel.org>; Thu, 14 Aug 2025 15:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212096; x=1755816896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AChpKruSXH4shBW9tTAspXM8SkY0T38J4dZ44b7wxoM=;
        b=fnLncjD8vgSAVXoS4TJe2Rd+VDe//S2N+fNYCrYsoiU0rHFFUEeZS+4az7Kq6NFKEF
         NN/Cvq3vSGm8v31UJzNkTVTYhAZuGWC8Ot9ctjB2PBuUDc0aGKzwX3qkSXUB5chLityY
         iHjysZmxoVe+M0YGXX+FWPaiPccd/vlgxZHqWpSF7+/ca9Fi3YbKN2lUA/rqhEr3mOK+
         E0CbGaZUNuF2NnGASuqAsdqtXSlHAdlElFAEUO2L2SpE+8P5n1LJKbBA8MgxheNrlN8u
         1BmZMbbw81arZgu3Rmnu1KRw9nMnQNFikjGvvvzPswsIIVSWy4To2VxpUcr0887dcm+f
         0Hbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212096; x=1755816896;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AChpKruSXH4shBW9tTAspXM8SkY0T38J4dZ44b7wxoM=;
        b=GLedtDkxVj8R3EtBjqPBRyb5K6uhN1xcy69HnHUfysSGED5+9fRS+H7dRHe6Ebr+LR
         qbi+wgQ17gGQIkyjQvEba6u0EvVz7xusQza1I+nZr7Hj6MTK+Xo37vMWV/CBfEhwv8Qb
         DbH4wBoqIwZENpU076AcnmNY3Qws0BBiG/Peks8NchCEfiSBmZXIoWz2VwdarczS4I69
         vwnlYWxjgITGyHrxjbz4/kaK4xo/+J6ZKFoFp322n0tDwlXu4DK9+6hmhxsjyiDArUzQ
         PeM+wOwcudd4pG16wFLnu6LeXwQ5w2tOa6nzNJVVJiBvnKPwcPfWHV3B3wnJL/HBcw/R
         dqqw==
X-Forwarded-Encrypted: i=1; AJvYcCXdI1DNtVR6PSKOSEspTcUMoYACKQbZjXQG10uW10rH4BlkWugQrC39ZQ0r93ot+jAhBzHhJLbTHLZMmzIrEVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfKeW5SHCLXYtoNRIvSzpcLGcurOQ/tYP1S4x8oTpYr+xxFRhY
	+Eq5QVqLehIjOgdPGuQcs1Ew1g6syGgovsmmJFjTbrht3MIeRBaXXFhN4X2S95xsxw==
X-Gm-Gg: ASbGncvF+9f6d9R/4gx0BgPn0CXkeaEyEDwDdkh0lCOhrxC5ordioBxMA69vKTU8Maf
	JRxtF9JekJ0qMgpGXC8Mh30u5ASOA79xdqMxamrYC9QEZI/hWa02b7cApvsv31ad8a0nIZcZ5rS
	cecgfXipu5mjLSqkRgQqNukcKMa98xcF59Erbj7n+ypeCfHaEkjLzEQvD1bRp7iWc4BI1uXyi4P
	kMloSg/Y7M7nga9qIxcpGE2wEUMAXALbQ5CkdWAHSiee9kAuWbV9QfAa2Hbprt/ameSNxcNH9Ug
	lVf85qN3/lTgMHccC3SFi7gVHzHoOAzb5/dZTJXaO/ToNTL7/kjyWb3B2EN/47zxUMiEVu7UAol
	t7M9kFa16ZqXSlwofcqAqV76CriyoxBJtRvr+9P1eo7+szq2S7onQssmm6cOTvqHg8kc=
X-Google-Smtp-Source: AGHT+IHG0+hnq1queyYlWuZxewv9D0CnHIlLuYop0aXb8+J/bvqxPEP+d8C6eJNa1TXIkGn5Nkyb9A==
X-Received: by 2002:ac8:598e:0:b0:4af:68f3:4a17 with SMTP id d75a77b69052e-4b10bf86485mr66398491cf.14.1755212096096;
        Thu, 14 Aug 2025 15:54:56 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87b32ef87sm44199885a.7.2025.08.14.15.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:54 -0700 (PDT)
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
Subject: [PATCH v3 28/34] safesetid: move initcalls to the LSM framework
Date: Thu, 14 Aug 2025 18:50:37 -0400
Message-ID: <20250814225159.275901-64-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1823; i=paul@paul-moore.com; h=from:subject; bh=fXylwXXBB6mvLKxQHAl/i0nDwp3GIxUSzI5Ds9tCq5k=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmjnk4z0QvdJFbI8xzz63crkC3dDkkM1dTnFz NCzwCtbYEqJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5o5wAKCRDqIPLalzeJ cxpJEACArlVukrEIGt63PCXe+PPT1fK0R4Hxejf4S2xYZwnEjQYzuG7Ca63NUaODnxOym7e5/e4 lL3Gml5G7xg88pk1tK4bPFmVrAcpvzUf4RzFUALDbJosYNLB7wxFLrx/gOTvGQn6JXaXU/P3xQT s3E7yNbUyyacv8hfCb1H/IXvH0UhQpczPiYcgyZ1JsgC1zVr79gCse+FYbaueMAAmNCqMFf9Np7 AHL1j+/4f0Dke0LAEZHzS2mJh7Jw8EXlSqDmecEPzXVXog1R0ReJjEsuk7Kvz0QADOBUbX0IDhA ALEJrWsr0pqTTcFWRXVL2dI8QGTXpdGQ3qyxJFaVBDT7yhV+kDr9z99G0iYWi46IQsq4mC+M/SB HKTVbGGtIEVjaS/fjTt1/THl/k3DMaCCWLJVbFIY3cShoLNta7t/SifTcm0ZBE2G4sCEeJMmRpO eGB3V6U8l62/r+jf+TDBhjaUQ8kKHR+gIxvR7lbzjwzcj/brnwBbv4M20nlLF/2p0oZ+PVuDhAi +YQgSjHU8mpis2KUDfHuaEpXJSMoaP6iYaeEuSk3QvF0AQVcGXOkPetGABCjPxMgq+G7HTUScZR r5NXhSf/K1tfmKhvqpej/9JzC+bmPhMwsIbqNcACdOsKG1k/Z9Jf5eQ2X30aNIxGJxCtcjB5RrD jzSqs6QW/dwKuHA==
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


