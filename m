Return-Path: <linux-integrity+bounces-5719-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B87A82FB4
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 20:57:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB7C08A51AB
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 18:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9109327C86F;
	Wed,  9 Apr 2025 18:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="B4B8KgAN"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035BB27C861
	for <linux-integrity@vger.kernel.org>; Wed,  9 Apr 2025 18:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224834; cv=none; b=X39H39c4CQYGZvL2helmaSZtorM+XU8u3n6+O/9K7hhvJHsL5epK0c8B/77Jw4ovToXiPVsk7mMPDFWbQt9NLe1K4ClokaRhBnAfx4x9XsORqVDTk7hPLPswhD+vMsoVe2S6nkLcFDr5G+Y0G4X+1ZYvuChyMSwlRYxoVRxtbYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224834; c=relaxed/simple;
	bh=MkPoYwIG4TinjPfNk0EXrsRLK59ADeRUmFIT97JZOE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9vRqATdw+yXQ2xVLZ7G67OO7TsFk2OcJZCjz235B2E3EHcM6ZdEI1YGjOwy+awxgykv+cwv2TH++U73oGIRhnummp4Pt3t0zYoXxEUDZWyz89piO93buY5ihO4FWlgTKIKimVpZWG9ZezFLMRN/uXYdugn5QhZAfIMgDBXmI/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=B4B8KgAN; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-477282401b3so72173871cf.1
        for <linux-integrity@vger.kernel.org>; Wed, 09 Apr 2025 11:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224832; x=1744829632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpBxHpsE71g/suNoRLUwEmP3N3oQiPkN9k6/6tTBThM=;
        b=B4B8KgANTO2yMHa4TLnCd7wW9aprQd1uLNDJqAGyqZttnLaxWL9lv7pxK/OfibSkpF
         2IZAosKKF44VVLw3o+Ue9afWSUy2g9LDKaa3JyOCsRsY92f6S8bFjcuT0VYbiajqzb+d
         HYkaYUx/gX4kzY6Yr5uQTcepv0zlFp7aJ9rIQVKlIIjhBkmUa6Qp2dZJ8HlzYX7ZMJpu
         xqM1gXbaW/BMqE4Yw1Cvi66D4kvr5PBHE/rhsZi5AaWUsaiT36wjy1xV+rTdFJMkI9C3
         QQUl+hK3d3wHEwORezgDTZp3MA7mrBarFVXwv6P0FlojDv1DOj/+h+ji6wdZg2zTkMuu
         uHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224832; x=1744829632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpBxHpsE71g/suNoRLUwEmP3N3oQiPkN9k6/6tTBThM=;
        b=D8S6STN7FeRalhvNyHqllJgW1nBZP2CGh4+hUef6eVTy1QpUmF7S3+6pYbzfQZ4uHE
         fgpWfG4Gd7kfntii5wdjGcwe8CK/LpzD4Zs6QYbgy13xmWvci9fZ6PepdR6f68xufg+K
         zey7/JpbDw6fERzhDslGzZL4yz8hL0k64QbXmnRUmpd66cSLeDgnpjg1TqCycJ5INUCK
         CFjz/C1eTyV4lgo0JSoP2Pw5Gz9JIijz3FHTE5zWEXqush3wy0nJgQIGp9cQpj2TfSzf
         N/FG4PRwwxLLe6bwOioNY2tP8Yh5YB3Z6+yVySzijyzUTNLMHYOp2I8hHOcCZLRx4C6b
         GCWw==
X-Forwarded-Encrypted: i=1; AJvYcCWYX3nmdXvXkHNW1A+JCAdklWtErMLLFNna+w12rJ/WEqCaSQDGf670zG12pBuFc6XfJ6M3p1ga3qXP39nY+f0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcRK3yStHQRO5zrE695rePaOwbnTGCGeHPUFHh6hUouP8GZENq
	SigG/TofKBvlI7QlKWKRl8WaxzUuxMZ1vyubiGOZ9/UkW0lf2tlgw/ck/ysOXw==
X-Gm-Gg: ASbGnctWQ7WIUuCLNtcd8hK0noWAZIV3R8DdK8ftmKBz6kGFA6mE3VncTQYvKzgAgJc
	Fm8IYI/Mjxb9+8kqV7rt95AiA1KdTrsGfOGQsSpAdSGzkHawFVcBRqWZGpSinOi1m6n/snCeYOv
	4pVRFRBhnHyKgwWNKelSIF7NWDPTBJhx0nCoT1bx4LMmrV+bprmMCV6SeIPpAgLOi0Cn6OIsH4a
	oGwTpdU++GKNTQJJGyoYYkqbSiotAl5KCuQ3RUl2j7b7firAtTI1d6P42X222eeJaa/NwkGsxP9
	N0lO0evSYVJQk3KptoEKRjraEwSPJ3g/DJGPVhKBpX9uQKK79T4cee39XBLwdbpTU4/TMsN2sUR
	2y9n8+uB+bA==
X-Google-Smtp-Source: AGHT+IGKjEcW8b/8GPzhZUHT1zNIKNgDIj/v7fuhXJr44NKDkgr4AuVO0W+EG6FcVrakZVdFk11qZA==
X-Received: by 2002:ac8:5844:0:b0:476:80ce:a61f with SMTP id d75a77b69052e-4795f3598ffmr68385611cf.39.1744224832022;
        Wed, 09 Apr 2025 11:53:52 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47964da3c4asm10539011cf.21.2025.04.09.11.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:51 -0700 (PDT)
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
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 24/29] lockdown: move initcalls to the LSM framework
Date: Wed,  9 Apr 2025 14:50:09 -0400
Message-ID: <20250409185019.238841-55-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=734; i=paul@paul-moore.com; h=from:subject; bh=MkPoYwIG4TinjPfNk0EXrsRLK59ADeRUmFIT97JZOE0=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sH7zz2TyyNFtvO3UgRZnEV312ilpaAUNyWAI hQx5NGZYJCJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bB+wAKCRDqIPLalzeJ cwNwEACfZo0wxnpfxkfjEszjRYFP9SCK/ie6gsYwcnTay9PKHXK8dv/Z4Hkt3MEWRmw3yIhWk2x 7bhGuKKRKWE4yrAbvkiEtFiApt10TVNU8JbiwrAJ6tVn2P47KPw0xGf70X5FLCvTKepz/k6+n9h D9jcyIOM5XE5nOUB6ojFqnLxOH/6C1QbrYBsg9238A1T1MVqk438tnlXYt1vQ5shxMM5nMYRGjQ yLAFBk9r5KP6f81vUEOVBA9gi2FgAYt1tWfUxWlOdUmTb7b0zAH/FL5K3Hga5NWgt2L/sr8D4Yb jBSh0HFxlXRGUe+ImUxEmqjZAREIwIP6KZuN4Q1hItmkTijpeY30koe3NF+o3f1+M/NvlC/I6xw alM7u43vHu5uP+1ehpTTS4VkdeDfv2a5Z86Mk/fZ7c0k+gDkaDBIuFEpnDuIGKxeoRZkIUut7zH kNg1TRNxeU4HxyJ9kSvhuX+VzgunlavA7XD6KFeQA3rrscdJPiLTQPT+NKxCKxrJ+7MxO5WKkCM ovXoKMxLPvHVbTbBYiPkhmOUEOsBcCQie+JGS6MTZSQlgyqAH3/l9O/s19FdSZO4OeAHQyGZb0U rt9tBhntZiEZ4EzbFllxU1uO+BhsfCtmhPWzQpWqYdAeSXS94BWyheG32ouvcy9XiUH1co/8qVn uNrcYeQ+acXJCew==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

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
2.49.0


