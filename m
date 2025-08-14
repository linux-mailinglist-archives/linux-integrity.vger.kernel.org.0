Return-Path: <linux-integrity+bounces-6843-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C85B27295
	for <lists+linux-integrity@lfdr.de>; Fri, 15 Aug 2025 00:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D47F188313D
	for <lists+linux-integrity@lfdr.de>; Thu, 14 Aug 2025 22:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87AB2836B4;
	Thu, 14 Aug 2025 22:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JHEm5t6f"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5181828314E
	for <linux-integrity@vger.kernel.org>; Thu, 14 Aug 2025 22:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755212092; cv=none; b=tpy/vlLd100uvXoeNH4Rq3NJXtXao906f28Lx+llmLvd4cQcmWFBZ6OhywutiVWCzwHM3kQ2BQUKYoUnEdQngh7G/zr8rp4eikcw9mhuKAdrRRXpcCXT4cfllkqgDUXNRjmPd58YhOGYbdBmBewlnXO9AD5oGaDSfod2fDSB4zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755212092; c=relaxed/simple;
	bh=IofOLPqFk103DpDSz3vcDIcRnYYkeXQGoibj3GbkQnA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QT4KesnEm2ebFEWmnUFCGArKlbfP6hOBKuIWn9eNQ+5dTF7s25SbXEhTScr2kdE7WXodWPcbZabs8VhFlh0zR8Q1AAn/egyktQEOJmOzZBt0lNGFayzEt7cEgkhNNLovWVLtYRct+0CNft+jjC+n6m+RTQ1J0axccYCTjLbmzLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JHEm5t6f; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7e8704cdc76so146628685a.1
        for <linux-integrity@vger.kernel.org>; Thu, 14 Aug 2025 15:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755212090; x=1755816890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8eshVoT55p858G+JJIp3jnxqorUxhQOHxqjzPEYjU7o=;
        b=JHEm5t6fftfHMxN9HgdrtOGOT2UqOemb6I/rHjxJUlpAlx2Kla9DzS/qrZpxQcxZkZ
         1KTgbpmKZ36ss1hSJ8Gvipau2asPYokjqp9etXD8zw+xjnIT8f2C1cocH3RYcuj99x6x
         U18c/zkE6op+A9u3mvcI2usVwRxzlhBRnMg3cAR1M6Oyd08OS6zo50VEC6ZOjnEzC/Hu
         Q24zdSY3Q6dBW5ZKg2sXUdoEkjbunrUbg9P0w30FErcl1YzMeUWFNLjOZm9MiE4uTj1B
         iGDIk6dx2tmH4+qzcpmWCai4sRORMrzE9uvf2NUU9JiaBXfWol8HCqUFcuuA1yhHGNaD
         Jr/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755212090; x=1755816890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8eshVoT55p858G+JJIp3jnxqorUxhQOHxqjzPEYjU7o=;
        b=gUuXVZ4IgOZwSew24jiDCSvv/ciqLZy5Qy5ZWKFyFG9NwhvGvHNbpUORDNxTFriPdL
         UtiJOLlZ5vIAk40jDzWIEzCag2pcaQZFGsh6s5KqZxKqUlRRsV8qg4TB4NFYPkUce1+B
         7abCnSTqplOLcpnNKm32MswKjY+BKwpfzIYn97ooWjCI2nrFFQVuP/4A+bIt4367D/e3
         9JGxQgXg6QlU0uZBhe9VktYCpHid4lYBGDOFTrZqXWtwO5haUvzgUD6A+eoEESsgPXpz
         P3YQ/c8xS5lm+hCe36p4utEvGp36pdE4YdgIaRWm1QjUWremsxJ1USMdQQdduhU73FiE
         UNPA==
X-Forwarded-Encrypted: i=1; AJvYcCUoAAk1bsRqhquee11MkmfWxAqrfzLAmqJH0Fp97AgbxKUYCW8+t3MQZjsB4HrLKJBeRvQNrkumpqDZaoYTBIw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKsfhtms50TdzEAF2k1zaG2eGGfgTISZqJtQdAdwp109F/C4Ge
	PGItalV36A/uzJ3UsQAoYrXayKaUVn8W3TEu1cN/H4PBuADj8QSkRwNAwhax/nJImA==
X-Gm-Gg: ASbGncvrcmA7rEFuPO+5vEVvXsoHBEStHMGJ6a/jJnSK2sMKg0W/PFFJ3JrzyK1Gx8s
	I2bgHKHUoG/L3yx7nGttKrjBisUBkwENyMR0VgwgC/X9/GuP58TIoINVZm6I57Q9tZevk2119XZ
	FvjLYIZ9OvWxKPu211KRnY9MKvy3FtnM2MH2DBMpESJNnSrCtRNWqyjLJp0PJj9f22LTz62jHT0
	w/+xcILsuSSsYprbr8R/rE54G0+OhFNfqBSPUdcTmS2G0RNRdI/kBTKrIc3oeeIhAKIcR2X/xiO
	yRkFbF8dZWtEXrS+wVi0JoEj3MiZRHiJOPho0sPOWuMkfHvB/7Izk/Y28NKHv8Izj2aW3lKPcJX
	6GdKW6PpMou0wF+4DXrG/o06/7k+Andh7EriwqaagqUznpvZlUrEWm9raYLKcn4X4Iew=
X-Google-Smtp-Source: AGHT+IFtmYmgHPN/6BN0SC8km0Tu12vbQt4dWnNje4CEmpk648nkvsXUHENQpz8NafC00gIT1jqE8Q==
X-Received: by 2002:a05:620a:4494:b0:7e1:5efc:6f6 with SMTP id af79cd13be357-7e87057e546mr635800685a.47.1755212090120;
        Thu, 14 Aug 2025 15:54:50 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7e87b37a00asm44301585a.32.2025.08.14.15.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 15:54:48 -0700 (PDT)
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
Subject: [PATCH v3 25/34] ipe: move initcalls to the LSM framework
Date: Thu, 14 Aug 2025 18:50:34 -0400
Message-ID: <20250814225159.275901-61-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250814225159.275901-36-paul@paul-moore.com>
References: <20250814225159.275901-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1600; i=paul@paul-moore.com; h=from:subject; bh=IofOLPqFk103DpDSz3vcDIcRnYYkeXQGoibj3GbkQnA=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBonmjdwWYgrKhvk31wwxpOdsfNDjWhMlI00rab3 Xulm9tc9OyJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaJ5o3QAKCRDqIPLalzeJ c9PBD/9q7vJf8ZVwgynRNEUeU6jag3w/uDeFgLzQj+5l7iGhn4T4y90Aiv2oa71oXcxBFRxf7WA AV9GAWJ3otFaOxKtC+JgXv6VIOiNxqxfjcidiWJdjmhrS6zol+1LClENmHot4hRuLZKmMMdszn2 PFscqsb5b6FgWSXAs0XR/07dtS7bm0luivExo4mbTrTlLJjniQT1kINNv8gFN1KwyaVy0tkB0LH gWOproti159lO2sDYg5+ln6g02jNgGp6YZG8DJFMFCm2C1xEaCC8xRf3l1IcrHqwdbk3OomL4UA 1nI2L8R+yuU2GW5sM/SsMxH1fvr2MJPK4Qr9xPwnOD8TTbsPaK4BQgHwZQxHi+qMt7R+NQaH8yj FZhDlC1xBaMYzQCaADatCK/dafAzK+7m/e2ckOnBCBj3hfBIqAtNw4Z+vpe2+dMhBg7P7BCNqzA 8Z9MBpCGP3PyTBk/YuAaX5WiO+xoCWIu32ftyE+FwQin37EAVFjz0/TyZNGWUYlRG4Sse3pztbe FO8mkZr0Mu+iAoM5ARv65StoiT60wva9fjF7pxMEaYdBMU0TK4jSFNlwb3NvS6nzwTv1qX+dGP+ 2GiTBafSpTwN7/bjtIt4vm6TRHAcPvEpPvEgwpilJuXEAk9q3OZ6IjrtYoqnIVgZY6b2/YDt1mV O+JzmomYx0DOxGg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
Tested-by: Fan Wu <wufan@kernel.org>
Acked-by: Fan Wu <wufan@kernel.org>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/ipe/fs.c  | 4 +---
 security/ipe/ipe.c | 1 +
 security/ipe/ipe.h | 2 ++
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/security/ipe/fs.c b/security/ipe/fs.c
index 0bb9468b8026..076c111c85c8 100644
--- a/security/ipe/fs.c
+++ b/security/ipe/fs.c
@@ -193,7 +193,7 @@ static const struct file_operations enforce_fops = {
  * Return: %0 on success. If an error occurs, the function will return
  * the -errno.
  */
-static int __init ipe_init_securityfs(void)
+int __init ipe_init_securityfs(void)
 {
 	int rc = 0;
 	struct ipe_policy *ap;
@@ -244,5 +244,3 @@ static int __init ipe_init_securityfs(void)
 	securityfs_remove(root);
 	return rc;
 }
-
-fs_initcall(ipe_init_securityfs);
diff --git a/security/ipe/ipe.c b/security/ipe/ipe.c
index 2426441181dc..71644748ed56 100644
--- a/security/ipe/ipe.c
+++ b/security/ipe/ipe.c
@@ -95,4 +95,5 @@ DEFINE_LSM(ipe) = {
 	.id = &ipe_lsmid,
 	.init = ipe_init,
 	.blobs = &ipe_blobs,
+	.initcall_fs = ipe_init_securityfs,
 };
diff --git a/security/ipe/ipe.h b/security/ipe/ipe.h
index fb37513812dd..25cfdb8f0c20 100644
--- a/security/ipe/ipe.h
+++ b/security/ipe/ipe.h
@@ -23,4 +23,6 @@ struct ipe_bdev *ipe_bdev(struct block_device *b);
 struct ipe_inode *ipe_inode(const struct inode *inode);
 #endif /* CONFIG_IPE_PROP_FS_VERITY_BUILTIN_SIG */
 
+int ipe_init_securityfs(void);
+
 #endif /* _IPE_H */
-- 
2.50.1


