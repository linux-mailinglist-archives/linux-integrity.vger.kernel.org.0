Return-Path: <linux-integrity+bounces-7139-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B176FB7D5CD
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Sep 2025 14:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C82BD3A29F6
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Sep 2025 22:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A8A305E10;
	Tue, 16 Sep 2025 22:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LVzHf5MV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBE932B497
	for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 22:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060884; cv=none; b=k/KSoeFD7hRq0X3w0aApN7bgRXi3kshlrvahaGPcx/t2pZmrStamTFcf6ci6LtT2ilzzgZvBTGB1ztJYp8X7tNclKCmnFC4FpPqRIjJoQQ5N36LZNPWMkqF3jUN3mJUdolAZqyTCvX7BXzzTz/HJ+b1LmC0yE8Fx/ikSrYjwIUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060884; c=relaxed/simple;
	bh=aCC82L2q0ysTfaRazG/CWqQeq8HFWa6+t3PPs9R+FMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NG1UtBW4eUIAypGBd6RGM6FfD3/bMQNP30385K5XAeuatXGfoewCYGfTaBkmxEq1joUZubFj1m9K7D1aDeJlO71RSG/Ydh3GPTOcv+rfxsvbMmB+g0arRaO67DCpz63EOukN00XDrPuW2Q3VWZHZddtUwYbPyNavYHrIJ43NxRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LVzHf5MV; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-77967339d30so37286426d6.0
        for <linux-integrity@vger.kernel.org>; Tue, 16 Sep 2025 15:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060882; x=1758665682; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=01szfj2Cz8qfgT6cyE8Os4+shA0fv2T2/bVUGDyEzf8=;
        b=LVzHf5MVNE643XNPSSlSg2haxWFxB/Oq9OD+GrC7bYouRY9dbJBeGZ2CxMng4dWQVP
         Ez4R/dtHWFd2dgxVhfc86I4snrnlZLN5Lx3xDMPda4bIrXqwAJgxGS4X8y/0Gny38KD0
         yfFz9n5CZkJRjLJKoqCf8Q6dfS6GPc5oB40C7CSpN5jVv3Mn5Hij0uUJPUb4UXnWN2H5
         uNpHQj9dpyY98eR9JJmT/QxmVCIT42U+QVAKJwVxu34qxyEXWOrfDuXhIp8mbo8TqM3h
         MXJCwo/0fEMvHtEQoms2mNHkiDpgTb6HjglgWQEDLKTk59gNU7mQw2hRqgVKulJDQnQG
         t8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060882; x=1758665682;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=01szfj2Cz8qfgT6cyE8Os4+shA0fv2T2/bVUGDyEzf8=;
        b=FxypGVjs84NjFj3DX3Yr0RRiDRbD81Or9lBgklPy7XQbr6h7yIkMcGwYJ8GtPjJrd8
         +SyxaJzdNhvXdP9KFX2ob/bZebPNN+KQwJy2SmlGGTqZfYhrL7elEl5+mt4WZMAd367B
         wIrR2/lhBwsbxPE1VO27t2EEsTpVJgb3c8dsi8PjNYH1J0pcFiVVPiunIxEldpKi5mzP
         eC+AyEwb2pHkuPjpvJ5S5BSxnxBB0LV0i/urPAVcPpCVQkOfF+sgQmBNTld33+0NnrhL
         cLhd8WAjQJz8ZljGjx9KZF6fBn/CxJAYwRE7YEJRi4DpALqSvvvVKjqG1eiBko0MCq4W
         7Ftw==
X-Forwarded-Encrypted: i=1; AJvYcCVP1sRNmE5CKnhvYxlwDVvRZ4XesKEvcTo7vmGFidbwDS+nQFRLLWPvH+7dIbRyUMQWgK5j5G3JrxuHUBxlfzA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Jr9JWvPRK0pMm1kWQl/24OVcvkUi5hRrf6Sme2xME+LhsNVZ
	UhJg3vKULAUTcAlwJopmn320GneGoMF6jubw3KTj36F3WbCVBTjSqQxOrgaLh6zWVg==
X-Gm-Gg: ASbGnctBHbmLQTHPSHysCnx8MdcNuD58ur61sxJramj9dOAGoC51B/Xjqv+q8YKUrhz
	hLK2fpYgBhQ+UpvQ+a6nr6rBPQiUX6H95rDvM6FwdYSdEnFpfJwrDorPZg6UsXLEueHVYf3ThIW
	J9a64udi9JPMCEVKxyNpd/z1eSupORU2riS6VrB1t34Oyau1+2VBj+yD8YAP4SsBESgzfmjoxOA
	cHSluJblZHr85FKNva6NK7zarbzgs5cgzG3cODDvGpg7221ZzkR78Bc0gEVZtDtrAWYVy2hD78T
	hpcLklKSmKNoW6wAtZEFlXoFnd+r+kFgImJmAOQCDBsrhuCr4TOskGxRyf/JPrUwrDG8MK+Tcfg
	151HifG7d4JP9I6rHsJln9sibUq1YXTE45MT5xp8Emnv/8v8nuZdPzdZ+DVeG+KrsKDzX
X-Google-Smtp-Source: AGHT+IF1dqpDXLNbt8CmRok87Jh+UImED7Clfzg7Ej4N3+L8YwCkf8OUBsmT+MP+k7B+bCivdtcyOA==
X-Received: by 2002:ad4:5e89:0:b0:77c:eb84:8de0 with SMTP id 6a1803df08f44-77ceb848f79mr134501036d6.26.1758060881918;
        Tue, 16 Sep 2025 15:14:41 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-763b3f49139sm101521606d6.9.2025.09.16.15.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:14:40 -0700 (PDT)
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
Subject: [PATCH v4 34/34] lsm: add a LSM_STARTED_ALL notification event
Date: Tue, 16 Sep 2025 18:04:01 -0400
Message-ID: <20250916220355.252592-70-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1130; i=paul@paul-moore.com; h=from:subject; bh=aCC82L2q0ysTfaRazG/CWqQeq8HFWa6+t3PPs9R+FMg=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd846bpw0/+yoZxyQYOyFvIbV8lN+aCviDkZP XEGukbIvcmJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMnfOAAKCRDqIPLalzeJ c/j4EACQv3IyAp1a6CGB5WxKeCmgzNhL+HZiDLDBIaW/iAbkiZpvYBFCsvOWOuZbe7VTC02tQG/ RNj0eRQ50N6xdM8yRdp1kUHQjGys1aOGlFN2PwLEDoCZb5Y4ZFCxm3ctvJnwTCw8CfzdlCJLcXC sR+lUfGdHuYQuG3H6Ddf2Asq5bnOjTP53DzGPbJHkCciHrJCZkZAv5IbBpy1PQXLXm83EBz6cep CSNc3O/sOWEqk+grtxeS6nTcdLjFM7has+QIuP9jNshkoGffl37Ltw6pvLoW0ku0iSpsT22MW/l 4d4Mf0ghXp61Ayd8Ay+bNoVGERvh+0n78PhWN5tjZLPNqKaIlSylR3/UX6xGnkiKUJDseCl/3v6 I289CwjJhRWbR7K7gCqGItzETYHvsQXQkZXoObI1QDv+MmedJGiDNtrBaWG+fjIVEKjDFZQVi8n Or38t1N/cBoSV8sogiABL29Eq5kcgVgRPd9LCngb4pti7H8bSR2wQOoVWXlPj37LVSuIpeuczd/ 8CZBedW7Roi9c7nG7Z3oelDSrSMimGR4QQF9OnpxwIa7stfupQrW0748FQPjZH+4HpCKLerN+8e Dj6E96LTEvDq+Jv04p8z3F/gos5IYhZE4aJ4k1WWrkf/BwFNwxM5LiYq5Pk0k/WG0EYeXJrIBhs +e3X68c3GRynkYw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Add a new LSM notifier event, LSM_STARTED_ALL, which is fired once at
boot when all of the LSMs have been started.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/security.h | 1 +
 security/lsm_init.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 8560c50edd2e..c13f0a849024 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -85,6 +85,7 @@ struct timezone;
 
 enum lsm_event {
 	LSM_POLICY_CHANGE,
+	LSM_STARTED_ALL,
 };
 
 struct dm_verity_digest {
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 2bd705836df8..af4046c5c581 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -556,6 +556,7 @@ static int __init security_initcall_late(void)
 
 	rc = lsm_initcall(late);
 	lsm_pr_dbg("all enabled LSMs fully activated\n");
+	call_blocking_lsm_notifier(LSM_STARTED_ALL, NULL);
 
 	return rc;
 }
-- 
2.51.0


