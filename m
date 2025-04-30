Return-Path: <linux-integrity+bounces-6079-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C75AA4586
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 10:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 257583A6B4B
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 08:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2297E20DD63;
	Wed, 30 Apr 2025 08:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NES86Moc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6341F2A8D0;
	Wed, 30 Apr 2025 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746002087; cv=none; b=LQKHbzKHXGmGLbUGcLc95dKvIK+yA8S1DwN9ElPTXZdQYfRFa8lst6uyaafCIyS+Fw/s80S+9tiYF9Nj1P4Ga1TslfUnvp+ul2P7nsVrgkszsFd8OXFC3BeEzWoIBqUzWhpI8ZmsZXp+K1a9cqFmSxY1J3B9hAyOm8GXDYcAkIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746002087; c=relaxed/simple;
	bh=UnYWe9kS0tbtlW+ZD6CrLdA8tcTFve6dkf/Mz8gxI1s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=T7w+LbJ2DpVRvQF55U/+5ppnreK7ZfOjBngKtXwpMNTpBd7CgKBk8sSG1kMap8fhsQ+f04vdKG81tdQhhpL12aNWZv4e4GyVSA1unKj6G6oG1+OYODPZGM8ZifUrhMr8HZ0LyQmZi2vBSgBJTivH6U7nDXX2Ob+y1tFlBqrGIu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NES86Moc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43690d4605dso53301125e9.0;
        Wed, 30 Apr 2025 01:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746002083; x=1746606883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OMUYWfUGXzGMBrrk4yB89sthiGGaTwLPzgNP1Z3b+8Y=;
        b=NES86MoccYEC1GU+mwUNnEZfPMEhB5UGxrN7qIrfkoBDXUDZGW10YtSBxUvWoFnmXd
         ZNn6KngOmJqaEKUUQXn3Ydp8HbQUslc3IuX7Z4ohne47BdZbLkRW4VkIyHExZQJVdDZ0
         Nlk8f1+5SlOph70A/JT2AiupxA6e4fjFIEnu64BnwGREM+pwQoAI97fXLYpguKotVkKU
         seQtv72g27pPtY82YgyLiNZiRBeuB14h010Xr9ViHGeMmD5JGKWbfHhutHjMxIlcu1ZS
         tIQSZG4qiURXefRRpvkd8wTIfdN68QfzphGBPdI89oId2DxtBOiF/bOZuqg46hSkJ4il
         jECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746002083; x=1746606883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OMUYWfUGXzGMBrrk4yB89sthiGGaTwLPzgNP1Z3b+8Y=;
        b=T/2QznYY77VZ06uBT+7zpGJbZFFITuKecX1YcH7BMu1uhUlfbM+EZmmhWHI26IkCoc
         mzwvT+ERXIe36IEZWirB+jOIUpGcnzXPeNMzbN6QfDHUxH5k7g31fgOTJXnTHgXElWRC
         Y2kX3pTPGLjgshCtQWjyyzFeqVf5M+1gXpF3O+bJo53szbJVYnrzwZ8ZuQE9Hw0p9RBU
         pyMQs7uPG4YyxxknrX3ekdNxdrQ7xrOQ8zBCBx+dU0nhHaJ2xzx4E/GcS6Y+faKC/Bxq
         J9jEetoGr2T3WFGEW8ljl0NyAoFkVeTHw4Rzr7H0yO7A8MOWdrfyCfN9g4UpDDiQYTei
         dmcg==
X-Forwarded-Encrypted: i=1; AJvYcCUM31Nw9f6EzEHlSm5Xvta17wFWNkeva5qXYZdTnQ+FsofGopsvImIe/hiILmuETeS3+0d3W8+5/+Ka0jzn@vger.kernel.org, AJvYcCXBVvoKNDLKMTp1crAwZgd+uU7DmRrKu4Bdmc+fjb15vpa8ReEk9nY3LcPYJ12EthKXcUZsx7bll5TC5Z39E+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLRCjLY2Ay4o+uUTKxuMkbPinYZDkp58ap3uG31KkBq9VD+Uri
	Rk3VcN4WVkjPTv1TzILFnXgOljwP5Ogsh2ud8bU8TFPccM//nGvF
X-Gm-Gg: ASbGnct5u/BKENCGihD/YBKytN4JmIXpXBG1ZJ9Gllt09CaQwLHmHC3HxKZMfsfhnnD
	dEFRg5zaLvLwlA7ZcF2nWHe0D7pZk4vAdeqqBMFN5CokwU0cVA9UyMm/FZmUf8EoNeEh/S++VHv
	Tov52l1mX+aUP8LxAkx5U8y4/arIHm5nIyYv4ctQ4l2gFs9GK8X6zZr5+LNW/Yt5gmKtSVjGz9d
	ie4bkPGcYdDurY08MEAlCl+Vb+uDjzkrYZOpREkWWkvvNcs6gYY2HHsidxIuZVq1PLewxKgkJO8
	9RuAkThLCAKclIXwLzn5Ya/IKfzdWkqTxl68opwjsw==
X-Google-Smtp-Source: AGHT+IEQMS/RL4C5UdU30+j5/UxnzZDQOdloHncizZ181zgcG4olTGvWOXNWY8o3mrgUKo2UMzbnPg==
X-Received: by 2002:a05:600c:19cc:b0:43c:e7a7:1e76 with SMTP id 5b1f17b1804b1-441b2634d59mr13824145e9.1.1746002083636;
        Wed, 30 Apr 2025 01:34:43 -0700 (PDT)
Received: from localhost ([194.120.133.25])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-441b2b97293sm16222245e9.2.2025.04.30.01.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 01:34:43 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next][V4] tpm: remove kmalloc failure error message
Date: Wed, 30 Apr 2025 09:34:35 +0100
Message-ID: <20250430083435.860146-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The kmalloc failure message is just noise. Remove it and
replace -EFAULT with -ENOMEM as standard for out of memory
allocation error returns.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
V1: remove trailing space after \n
V2: remove entire message, originally just removed a trailing space
V3: replace -EFAULT with -ENOMEM
V4: send correct fix for V3, actually return -ENOMEM
---

 drivers/char/tpm/eventlog/tpm1.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
index 12ee42a31c71..e7913b2853d5 100644
--- a/drivers/char/tpm/eventlog/tpm1.c
+++ b/drivers/char/tpm/eventlog/tpm1.c
@@ -257,11 +257,8 @@ static int tpm1_ascii_bios_measurements_show(struct seq_file *m, void *v)
 	    (unsigned char *)(v + sizeof(struct tcpa_event));
 
 	eventname = kmalloc(MAX_TEXT_EVENT, GFP_KERNEL);
-	if (!eventname) {
-		printk(KERN_ERR "%s: ERROR - No Memory for event name\n ",
-		       __func__);
-		return -EFAULT;
-	}
+	if (!eventname)
+		return -ENOMEM;
 
 	/* 1st: PCR */
 	seq_printf(m, "%2d ", do_endian_conversion(event->pcr_index));
-- 
2.49.0


