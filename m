Return-Path: <linux-integrity+bounces-6055-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3231AA11B6
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Apr 2025 18:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E0F93B7A8E
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Apr 2025 16:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7108D2459FF;
	Tue, 29 Apr 2025 16:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsAeS7Ww"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAD2221719;
	Tue, 29 Apr 2025 16:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745944753; cv=none; b=lcFfBb3oSyAFwHIhLNHkNpRkjjozWdz+tAVAR3g8kstmCH39xEo7xLfs1PG5+8f5bG3GTyOxd8R5jHFPnmTXCFdghbrKne0cwMb6r8vfGvTQ61hIFZseOHw0ZAwM6XvtIonCbNwFaASLlHSF54UCUOlbzN4zV4DiYUu9jhozfk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745944753; c=relaxed/simple;
	bh=9cnUo42bVH6Ako8kUSAekQfAcAXta7oVIeRa+ZeBl/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UAhK8gltHnYRrREniE15dg9RbaffCUDqUY1Tl6XpEMG+Kme8Wex59dnVVNYslyvUSmwxUbx5eEGntNz5MvKxeYXpqKItJX+N1HQ5bMeFqH7XQIbsSes1w02gH9c+YCN+GXfgadl9Dfd8M8Z5zETvQHarSfGwZ3/SrsuUXwvEjyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsAeS7Ww; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so24545865e9.1;
        Tue, 29 Apr 2025 09:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745944748; x=1746549548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OfxB7ueWMJHOfVdTrigCt7WRfmfJvpUb5F90S4PMLb0=;
        b=YsAeS7WwWTyz21+32JfiE165puqWH/VjGlL5wbqgRIJPJs2uLOGKFarDyFeIoW8jrf
         SbxubVVh7SAZf8RGom2JM01EYQIKY22XhcAAhFCV+UppkTqGW49ldz1N5coIlWYaL2YH
         CxE8VC0mXDJgJJjrOOzNaCtjicAntuvpRWE3idZsV6UNIyQ8jHMhEphxrjJ4xhwjQXN4
         NhTmSLBWcgHCtzyIjwJGfhNBpi78tTqV8gnZug1/IeKE++qdqRw3ioi+UquPEZiopJj+
         VlMWJ+U0VFTr4W+9GC+cUasFXqGLb06dphHhnHZpX9JkUoEOk32CGIETv0bkWJpy012P
         5jmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745944748; x=1746549548;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OfxB7ueWMJHOfVdTrigCt7WRfmfJvpUb5F90S4PMLb0=;
        b=STe8OFGepwyc5ZmtcdPlyvDGNtQ2SKddhPGFqZuoiXUaq0tWW39we40CcV7RMoMq5h
         XiizInKmDwGk3USQkZLZPs7LeONxVlMA0N77Jahlt0Ti5ZQbr567HBsE/hLtBTxfe3fS
         WDPuQtcVxa+Eome2uXgGcAsxzq0BqvtzpwZoNkM2G5CTTwyWaB2l+/HRep+tEl2zlvHJ
         ZY3fQkh6NHx8TMUcsrtkooYjg8+jUApStCZ/Pcp82WoXINU3iexc09QgcBrvEXfXg2Pg
         ukpleBEOzoMEbxPvsSL9ZHGzYK34inMy4z4UYBFN0hspx9IDUydM+IhzhJX8vZcc9pcG
         Uxvg==
X-Forwarded-Encrypted: i=1; AJvYcCWP6YYFgffzVSst6ks6YZkHY2yOYABdFvM1C7NGm7TB3OHielRJreWa03ZFvE3JHFXoA8ooNE9ARNDcU+DAYSk=@vger.kernel.org, AJvYcCXHMFITRnuJaD/4QhUPTyre2CZXqUwpg/4lBqVJkvik2RWS7B4EQn0oMG+CEw83xJERgDbizIQUXJzeF3RT@vger.kernel.org
X-Gm-Message-State: AOJu0YzbEtFSQjA091k8MLDuhm0nrR68OGxjQfgtWZIRHdv21sXULDKK
	b3tIp7JuyOP4NpYkcGB8IW88kdKhjvJ901qCEFePTwTgjkcCvWnA
X-Gm-Gg: ASbGnctzn3Q1Ot8arVnU2pL94kMI2QRejpqnmxCqXlcO7QOPxh+6S/gx62z9TI+Uq3b
	dUm7Aa+IUyxSrfaVXMXwNwueKnxwz0iHB27Q+oNP097W6vh0UxQTywzPSs+vcGRmZgiw5+/dwII
	9/LmxQYrlLFv2vZ6pUyeCdXxh02LFVG77iQbx4qdGAlL/rIzOc4NkZZ8mTh0LrXdaElzR+IZBxf
	7MrpKvgO2Hf7sSkxYxuabQbIzP9mNVu8NtdUXkbVR1KCw8jeHlw83fvNgSShgq60szEHpsoNzr4
	FPlRRqjCo906dMuMpbyFP69JAgkagRyeh5/wm8Q19A==
X-Google-Smtp-Source: AGHT+IEwn1kuyd7yIBmkob/jd/orK5Et2W92kV3id4CopJGSgQ+gR90AEwMrSeL1WSrlpBwGddY34w==
X-Received: by 2002:a05:600c:c0f:b0:43d:563:6fef with SMTP id 5b1f17b1804b1-440ab848800mr113084645e9.21.1745944747617;
        Tue, 29 Apr 2025 09:39:07 -0700 (PDT)
Received: from localhost ([194.120.133.77])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4409d2d8479sm200434295e9.29.2025.04.29.09.39.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 09:39:07 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] tpm: remove extraneous space after newline \n
Date: Tue, 29 Apr 2025 17:38:59 +0100
Message-ID: <20250429163859.823531-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is an extraneous space after a \n in a printk statement.
Remove it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/char/tpm/eventlog/tpm1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
index 12ee42a31c71..566f4df58d48 100644
--- a/drivers/char/tpm/eventlog/tpm1.c
+++ b/drivers/char/tpm/eventlog/tpm1.c
@@ -258,7 +258,7 @@ static int tpm1_ascii_bios_measurements_show(struct seq_file *m, void *v)
 
 	eventname = kmalloc(MAX_TEXT_EVENT, GFP_KERNEL);
 	if (!eventname) {
-		printk(KERN_ERR "%s: ERROR - No Memory for event name\n ",
+		printk(KERN_ERR "%s: ERROR - No Memory for event name\n",
 		       __func__);
 		return -EFAULT;
 	}
-- 
2.49.0


