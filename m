Return-Path: <linux-integrity+bounces-2362-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 758018C2F59
	for <lists+linux-integrity@lfdr.de>; Sat, 11 May 2024 05:22:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 157EA1F22F8E
	for <lists+linux-integrity@lfdr.de>; Sat, 11 May 2024 03:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F044424B5B;
	Sat, 11 May 2024 03:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N14iFgO+"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4915B2E644;
	Sat, 11 May 2024 03:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715397757; cv=none; b=feJ97wxfqhVWKsMPEX28+BWFEizfPzrpt0RiUkxiZmgoeq9ic9BkJTfFSUnPa63E2qYOw/ryxfZYKDiUt5msYkS44Dy2DQD6xGJFs3n2rHVB0aGK4w2B5ZuSX2tm7/1MEQKefz6sp2+KZ0qDyLFMCIBpIE/p7r8U18Xt4AO9yAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715397757; c=relaxed/simple;
	bh=h84WJ7H+w15XmJ2O66TOYlk/zKdLB2pIjpHeUK0wgBM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iGGk03uLvW1QTh/WxJmK0Cewzjk9iEQTKtvsLXP6GX72we4zuO13COVJ9kT9d2+3/b95M3h5b8K+gHEiJ/gINM2KkVaMnbHO1cu6q2zyyCj/tCHikSxIKvLXWq8RW/Xk2QFmH44L/aNKOnoaka0FZ8YPFqld1KBfrQHpaYs3DPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N14iFgO+; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2b12b52fbe0so2057575a91.0;
        Fri, 10 May 2024 20:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715397754; x=1716002554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uMB81L/0jjAxWQ09aWZO4NxBHzsdYbHe8XIc7QrtT1U=;
        b=N14iFgO+o2KJmYRrIocCbJOO+ahyzuuEXPzXep+paiUlqnT7rEGtvYgEFjFNJWm94N
         tZMLfuvyVVS3IV4h73dk+DEnN7Ekrf+5nmvCEtiNLu1lOrbEuSOZQyq76QemggDLsKvT
         41wK+1wgwiDu1tbpobD9QNJyAlTccgrBmlwd8i1olrme1PfW4dPbNCQekROtZe6UWgAj
         Uy9pTXUvL84XrFeZUtpP10D4cK6V7W2oK71tF4qt8KCJo1Rs5MIweP00AxXbg+OJK2dd
         EE+MgHPks5Aj3/D3oRQdR4F9ZZqrEdEVVf+KdHOMao+cPd6KdbrXThJf5MlI9HWU1sGq
         7ShA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715397754; x=1716002554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uMB81L/0jjAxWQ09aWZO4NxBHzsdYbHe8XIc7QrtT1U=;
        b=n9KBeGG6GRlBGxDrA2x+Ftn8yfgL1VA2bg1qYubbmEhw6bxx8jhkU7/UWBkb4mKSO5
         CasPn3+p/xvUOptKcLuLZQdz9UmRDQ1Zu6Z4P+2jpp92amyQn1L5ERuxjhaDFVmgwIbj
         ZEOqFiZWJjLE04FkTMohdJx5Ls86YXg5QM4N2xJQXH7LVLBSI2sL2/gARhuhGJ5t5eON
         Zj4xkaDK4MWEwC3B66swrATCjlf6GFoIDXHV2IRI72xlD0lVO9ycPA5ASMj2fXc7+7Cs
         9Z5NJd0QLtohSN13W6YQSMzKZqWDInIFAKCNNQGdBfPJGmQoBfU2JlbsX04Rlg3i7Yla
         ONrQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlRQOuv3RIKSEOBMYQXOCGgH3vUntRLX20bGU4UmYm4OWw3HdGU1ocd8aYzKi1C8KS1T6zS2gSAGk3++PNOmoKGwLMiebsHS+a0OzTxuQF67ETxEIYjj7efJ4b3NAaJ/Q2FQfkGtLX5bCptvGnT5WTS6JfdqIPwVL9eu0uf6oHRqdXJCsNVR9kkXCpzVA=
X-Gm-Message-State: AOJu0Yye8z4INSAnnAZpImCTL0IJp/Ul0+u8k7H+JZYEHoOfbaybsRfn
	GxICAntBQy0KheVUXyGI8+JnerjuYtFaMAFQd+BG+fGSd31jIRIOQFIh6fZ0
X-Google-Smtp-Source: AGHT+IHfescNvFV9wlrE33urRclbhE1c8q8C0H9oiBiwGCf40u0JXrBpAK0bHD8nRWhhgwtTMs5CRg==
X-Received: by 2002:a17:90a:dc82:b0:2b5:6e92:1096 with SMTP id 98e67ed59e1d1-2b6cc87abadmr4579606a91.28.1715397754463;
        Fri, 10 May 2024 20:22:34 -0700 (PDT)
Received: from localhost.localdomain ([114.111.24.234])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0b9d18basm39877875ad.57.2024.05.10.20.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 20:22:34 -0700 (PDT)
From: Yusong Gao <a869920004@gmail.com>
To: jarkko@kernel.org,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-integrity@vger.kernel.org,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	trivial@kernel.org
Subject: [PATCH] integrity: Update comment for load_moklist_certs()
Date: Sat, 11 May 2024 03:22:24 +0000
Message-Id: <20240511032224.818418-1-a869920004@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After commit 45fcd5e521cd ("integrity: add new keyring handler for
mok keys"), the comment about load_moklist_certs() is out-of-date.
Change keyring name from platform to machine.

Signed-off-by: Yusong Gao <a869920004@gmail.com>
---
 security/integrity/platform_certs/load_uefi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/platform_certs/load_uefi.c b/security/integrity/platform_certs/load_uefi.c
index d1fdd113450a..e954776d3cfb 100644
--- a/security/integrity/platform_certs/load_uefi.c
+++ b/security/integrity/platform_certs/load_uefi.c
@@ -97,7 +97,7 @@ static __init void *get_cert_list(efi_char16_t *name, efi_guid_t *guid,
  * load_moklist_certs() - Load MokList certs
  *
  * Load the certs contained in the UEFI MokListRT database into the
- * platform trusted keyring.
+ * machine keyring.
  *
  * This routine checks the EFI MOK config table first. If and only if
  * that fails, this routine uses the MokListRT ordinary UEFI variable.
-- 
2.34.1


