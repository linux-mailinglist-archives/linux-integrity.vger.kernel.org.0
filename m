Return-Path: <linux-integrity+bounces-6058-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7639AA14C7
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Apr 2025 19:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19853BA83C
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Apr 2025 17:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646A42517A8;
	Tue, 29 Apr 2025 17:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WpKPTIAA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835A02512DE;
	Tue, 29 Apr 2025 17:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946906; cv=none; b=eb1z3j/Hnz2rmF3MM4aRMp2qIlETmPdXMR4k7I9W1W9qZXPijSty/M/Pg1Vxn7DK/JU7nSaSm3tI7uXnD2Mnz6YPl3omIjBbraO/F5qksP4AjzoCYvx3M9BRV/9rMSTo6I64ImQk2FfraK9ofBW2O8L44pwlmproJ4iapAhwZ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946906; c=relaxed/simple;
	bh=4bU/60XLhCRICnbnAdjtNPgTQVGxjlURq88JqEISok0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YxnVOO5OMZSsWHPfPpkcgH8kITm2T741DJrcXlptCgrfCyVAuSMEaeg1JvWKPtIQHD6prGrzJcz6uYsQoDVpPljUwm6E7tfgWeyydCWoAp/HcunmPu2BAOYiCxRFr4UO8v5ihuzZRMxCbsFSx59bBnpt//gdJn8bnvWlk+9i3po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WpKPTIAA; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39ee5a5bb66so4128335f8f.3;
        Tue, 29 Apr 2025 10:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745946903; x=1746551703; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R7qjrFHKLI/Z2TQdhWZlwWId58ZcPSokDL9PYUoeSC8=;
        b=WpKPTIAAMDrSleguGLigS5jzQlWxqL6ZTpxJLKinxgDfjFKR+aaD4WSRN3GW7JGIm7
         1QmzW4uDPDZEuQyBPIA9ujmQyVBKqt7rbm4tPm33LhIrhMUGBRUx4A+Hx0bjRlRmXqdv
         qP0BYTxFb5H4RxtdjdOJWjg0jX+Blrbuizi5tb+D+agKldEGLnCHeRBxY37U1Olc0vW/
         VpBdaixgXePFjsEHMq0yFoTXBiovUWb464KhohxoUes6QOuw7YMWaZUC2b0bGPid5XUU
         Z/3EXSbJRzV/mt7efl3+RuPGetgEC57m2xT6tHBcX5u0hVoflfsgL1H2JewVcB+Y+wUy
         8VXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745946903; x=1746551703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R7qjrFHKLI/Z2TQdhWZlwWId58ZcPSokDL9PYUoeSC8=;
        b=BALwY++FYaOX3n4N9sRIFu3vVN9NgygLyMURtztcMPtB2wROwSVyatcsaSz2z/K2Tp
         mnyS3UM3WVx+xXVcfxsv/NWIhQIuH2TfU5ybkGPtm1Y0H7vHE+ApY+9tKDBsoD+0DMqw
         dLJk/Onnd3KPwBHmA6E6m3MePjqi6ekP5i/OOw/4l8uD5HmC2ciZRbmznUEvY77orlqu
         jhXUBkRDWnMTkBwD9AJD/ub90bYFQDeitMJHl9A/zpZcITbVO/rzUeiu5r6XTbZ9gjKD
         +JUdXSq4n9QFAVIGX4kCR5Kbtoy2cBekFmewaHyyTyrmc290rGTryennWnM0HSpooviM
         kfTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrROx4mJjD7ElbTVtYJIg8etHgN2UMMfKt2wJM+MrqlGDFadj23ONgHCv4EXsyO0/uF0BkXRcVEDFAFsTG@vger.kernel.org, AJvYcCX+ECKHWm2Um/9WOVRGM0ptRpbscmuuCGau74kwz5VmvN5is9xinHTxJGMHMS55zlKfvm29gnOKqtH+RS6wmYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9ZDJ3oijyad9vJn0Un7nxHjRwlcn06PMhfSYtCQJ7msaufjtA
	vYq8a/HIq9vRb2fH9gpeN6h6ifN2H+G5E4pZA4cOXpj00uq4GwmE
X-Gm-Gg: ASbGncsnRxViGBjwTDp98nD5ykeE/xmdqjPI6S4Y+zV9C0Pbl47tBdBWfkQEsUlrR/o
	Z8NmAJpqp2vcUJXDTfqGWQXeYpW0Mu7m2n33xv+FYLnFO+WjKd0D+EBpSIH2eFnY6+Es9Pr00Zo
	mNrDCuAJUHHKpHBRHsMKQZzeIrEtc8JKLhHPbnhxaP+d+p87asn7qoxYB4HDKT1kQEYHUl1RQa8
	iIe9f34jc5hxKP95qiVJnNaKUCHNtPlwWpz8Iw7I85z4BV26XyuVlGGX58+VuakuhirNy3/x9Yq
	Hl91E+dsqY/5l2Dvf3EDUmId/PzvKRRj4JHwfHgSZouE3vXLfT7i
X-Google-Smtp-Source: AGHT+IEuw8+G36XdLryYeQSkUnQgTVT20d1IxfWq+nlh9LSp6Z7MH7ayC6DJLe3eufZtopk9tRZBQA==
X-Received: by 2002:a5d:64e5:0:b0:391:4389:f36a with SMTP id ffacd0b85a97d-3a08f7b7bcamr160477f8f.48.1745946902550;
        Tue, 29 Apr 2025 10:15:02 -0700 (PDT)
Received: from localhost ([194.120.133.77])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a073cbf030sm14431871f8f.46.2025.04.29.10.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 10:15:02 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	linux-integrity@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] tpm: remove kmalloc failure error message
Date: Tue, 29 Apr 2025 18:14:54 +0100
Message-ID: <20250429171454.828003-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The kmalloc failure message is just noise. Remove it.

---

V2: remove entire message, originally just removed a trailing space

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/char/tpm/eventlog/tpm1.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/char/tpm/eventlog/tpm1.c b/drivers/char/tpm/eventlog/tpm1.c
index 12ee42a31c71..773e9e537991 100644
--- a/drivers/char/tpm/eventlog/tpm1.c
+++ b/drivers/char/tpm/eventlog/tpm1.c
@@ -257,11 +257,8 @@ static int tpm1_ascii_bios_measurements_show(struct seq_file *m, void *v)
 	    (unsigned char *)(v + sizeof(struct tcpa_event));
 
 	eventname = kmalloc(MAX_TEXT_EVENT, GFP_KERNEL);
-	if (!eventname) {
-		printk(KERN_ERR "%s: ERROR - No Memory for event name\n ",
-		       __func__);
+	if (!eventname)
 		return -EFAULT;
-	}
 
 	/* 1st: PCR */
 	seq_printf(m, "%2d ", do_endian_conversion(event->pcr_index));
-- 
2.49.0


