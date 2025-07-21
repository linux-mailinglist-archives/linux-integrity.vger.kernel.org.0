Return-Path: <linux-integrity+bounces-6691-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45B58B0CE02
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Jul 2025 01:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DBE417BCB8
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Jul 2025 23:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2F82566D9;
	Mon, 21 Jul 2025 23:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CBzCQrjU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F06246BC6
	for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 23:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140274; cv=none; b=kcNZZjwuqBBeFS3D64u8tXlAYfmI3w17GndejdkROToU8vZLoPGlqK5gXAK7XJKlz3oCG7sI2vseYhRTRxtqSLgmmFR9DcDpLB9Sy9vYBkdyVdt8mcyKiaNhjaXfu6uJa8gXiJ9h9o4ZLc2JIwiM3AaIezVPbzCoFSdSUbDEN8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140274; c=relaxed/simple;
	bh=dtTlDf9Zs1w3qXgBN4kcfoXdJ9Galgh9dd6NXDYVJZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMBL9XNy1smyGSbbdojlf3AXOkuPMOHv+8ozVZXGsHxz6gYFQ8f/fpXMVhs5AVgMFBSv+N47ypZ72gr+HvvWBO39mkgcVo/ArIriTIKTfaEuUZN9ckJhKt3z3puJzsUKTF2OW4LgfdYkqp3lga1wQwc1d699QBbmQDpjOHP/u+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CBzCQrjU; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7e372c8a9a4so131932785a.2
        for <linux-integrity@vger.kernel.org>; Mon, 21 Jul 2025 16:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140272; x=1753745072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4osn1cU2KHpyctysVPOujBHcpLOdAZCknxigtl4erg=;
        b=CBzCQrjUfV4R8fFYnokVkLgmzsFVP8Gg17oYQ29VLVoAtQlGemi1aOEIJ05eDsPSNN
         +Hakb8SVfIL8l73OA7So8wpyLjqMibcs2nV567iz5HFn+tGTJLlZ00w0vbmTDkoqBwtG
         Aby96dwIEZyCjFsazDD1KpU82BfM4ofQJ4bL9H57UEil0l7UlzMS2NpuoPjNQS7XoRTh
         6OKutoI5/I6czFZWiJZMZzNxhwLbEnx2b7WYRko7B0OicKiLnPa9OzKctECFqbdE7fcb
         5FE1sbFZFTWBPo+5pBIwf3wnu6lD/q0Tsy6WoP6UEQ1ZsKH3MMwhJBqhb06Q/pX7Xudm
         KzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140272; x=1753745072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4osn1cU2KHpyctysVPOujBHcpLOdAZCknxigtl4erg=;
        b=wuLM+PsdypQj+gnkzefaMR9GccJQhUhb528QEwWES8hpqzhGwBJeZmleBCyNnCqMVQ
         +Nd3GCp8iYL1f7ZSpll6Z7QmNqhf7r0KyaMXElFH3N92FFz3YU1Dq+ksavkzQ0+ijtop
         HYO6ey54aCqrNST93nDVYrq5GxjjziCpq1wsOeN0lPuLxUz570apuCwbDB3HtxXgHEzF
         gHf1bgHgaRhoKBU2uVIC+RNoaPsOuPyZLFvb40mISCWGHTdIfOp+taRG4KkbHqYJcStI
         hE3L9AVR1KcKIoD9GrsIHDEnW9JF7JsdZQeBIGVpqKBVOHBfs92kHY/q8fA45ERaj4XB
         E8wg==
X-Forwarded-Encrypted: i=1; AJvYcCUR7rNucdx4szpQ15hXF1+rFjxyV5r+/45/u14oXjVYKHiV6mgiX7bTmze0fzhctf59tZR9WCBDaYmF2vLIjfg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNnxjmmIQKe7sAE3/KrOC8c448KWZKWNoGbq9amjWsS/+5u+nX
	Cv1v7IFga/R3PX4uxvRkCyYrSvyQrU72t4NrRjYXc9/hyAweZTfxWZ1l1ROyZzLUnQ==
X-Gm-Gg: ASbGncvPVEiANmVucU5+cMHJEOzkNQwO7zbdVTaVU7E7NqnLrr5qMiKOFis2nZLYMfY
	h8Q2pd+ra+XX1Nw+s6MualgoNHWeIovCkm+mpOFiMOe5zooTukmamjUwexsFolj8haWlUpqesHV
	LwMokzehQ9x62PL5AXIP5Z1P2KBoQS0w4Zuqm2z8AdJOnRxgYi1EFGp7yvXkEjUi5EDSBXAs6Hs
	iljYDGOXahWOQmalpxaLWhWUXYolGAbCkRXHpPZcMY+M46iN7CuLQwFcP96U4e2tMgA+Cr8ADPY
	fXtqE3AslWKLlmWr9qjHzoGoOvIIgIOqKgyTQ5oiWl/DhsP3J9E0VidvQXiMhh9PyFCVS7kGgMv
	1q8H6R931rHQMxH3Eu08tQl9/MplVfaSQ8psFS6KR+1f32eAA4PRwVpNxfTWCAtyyJ9A=
X-Google-Smtp-Source: AGHT+IFkxGCxtcFnWVigtUFhdyx2aVzIyfYem/1oEuP3/Zm9qp6xaLQfWlhY3zSnEccPCMBAk1ecng==
X-Received: by 2002:a05:620a:12c6:b0:7d3:c4c7:75d6 with SMTP id af79cd13be357-7e34d9d33dbmr2054160585a.47.1753140272445;
        Mon, 21 Jul 2025 16:24:32 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7051b92394fsm44367576d6.51.2025.07.21.16.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:32 -0700 (PDT)
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
Subject: [RFC PATCH v2 30/34] lockdown: move initcalls to the LSM framework
Date: Mon, 21 Jul 2025 19:21:33 -0400
Message-ID: <20250721232142.77224-66-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=776; i=paul@paul-moore.com; h=from:subject; bh=dtTlDf9Zs1w3qXgBN4kcfoXdJ9Galgh9dd6NXDYVJZs=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsvy3UEZdfYgB23vwGfEkd84LDlsFR4wF6KP+ yniXnVb3q2JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7L8gAKCRDqIPLalzeJ c+btEACauTWNp5Gu8YrkRQgdA4davHACFivPcXvrQ0Il6ENbXpajLH2TWVTaUlQU3YZhIJyT23v cRM868Poy+cb7oob11+8scn9nuO92G3E2YdladXyFnt0c0QUG6PlU4f2H6lm2VR8Ti+d+AJYCtz zrIVH8io5PiTjgy4qxyDJOUafdDbJODKMJvAY/wKcGARa8yGXH1KZmrpnHMDz1kGj3A1uhaIOnz ggR0W0+fFO/dGkrRgAm2FctkVHlGBXNxJCWEbgPevx8gxx7QUZYZFUOSU8wywc++Dtodq8J3rmW e8piOK9TgjyFcJgWnGms3TP3YacJ2LOYJhsH4KtjQLFgLPmYUaE2GtFZNvi5Pj4aDjC6CNM0d59 ihkl3WL88A3fDwtlJdJH28MLimjtz0NLTJrpuTUI6FypLQapA5U8P9fKV+JgwOGsaw+3XsRRI6u xaJiVpBfGAV7dhw6aibup9vYOG0yRVAE6/G9sMiGvVm0gp/uGup5muMix6FwmrWcMK3oQSkHQkF ZizYDYcJDr7rbDXgvUcHV6FzVOz1RNrwxn5HyJ0IBgsLYWGelAdYq0J6m8XrU3LYlu3RT5Jc7zp MjnoSIzrKUqklG6PCsA0vaitp64IbcxUY+AB/uoghzqnRdyOpzLW9rsNgey3cffgxwpYecYLt3p 9J5j0FwPnbh9EFA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lockdown/lockdown.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 4813f168ff93..8d46886d2cca 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -161,8 +161,6 @@ static int __init lockdown_secfs_init(void)
 	return PTR_ERR_OR_ZERO(dentry);
 }
 
-core_initcall(lockdown_secfs_init);
-
 #ifdef CONFIG_SECURITY_LOCKDOWN_LSM_EARLY
 DEFINE_EARLY_LSM(lockdown) = {
 #else
@@ -170,4 +168,5 @@ DEFINE_LSM(lockdown) = {
 #endif
 	.id = &lockdown_lsmid,
 	.init = lockdown_lsm_init,
+	.initcall_core = lockdown_secfs_init,
 };
-- 
2.50.1


