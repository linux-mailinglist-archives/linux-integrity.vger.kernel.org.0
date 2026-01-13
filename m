Return-Path: <linux-integrity+bounces-8230-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26509D19901
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Jan 2026 15:43:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1DDFE30240AF
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Jan 2026 14:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E063C287254;
	Tue, 13 Jan 2026 14:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YXWYkXPb"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BF3329D277
	for <linux-integrity@vger.kernel.org>; Tue, 13 Jan 2026 14:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768315112; cv=none; b=uJoqSFWtvj4sl6ZCF4HklAIdus5/kAxTvv+RdMKiSSzPhyfTYQQJ+OmtpczGvjHCslx5h+dXZgXgzpr7vTGTkGlpfwrFqNTtsSLCxLzcLaneQlOwgcrttxgnzisYAZ4pDZKwUOwI2k43ezfeVhlJ/Tqr80Ebl5a4T4RkafSbNwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768315112; c=relaxed/simple;
	bh=bv1yaH5EQk2ChzwUcstriXdO+QCpJWJNyBkYzvqKM3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uG8DjJqp9FWjZHhFpNuzyYRyR31VYh7a/vfFXnsCxw4vn1jAWIOjkTCMoWuTv9B3etf+ARKLeZlfm86TjicQ3gjupJzBFGtnEL843fGsPP/qjF6p1efbo9LCk6OCVjK0cSWVfStx+KaABB/PabKw4geaJyXnvIOOVi3R972aYuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YXWYkXPb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-47edd6111b4so5067415e9.1
        for <linux-integrity@vger.kernel.org>; Tue, 13 Jan 2026 06:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1768315109; x=1768919909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W74bGBgFK/hOVn7wDmizyI3ZTIrz3Q9IO5DO/QfmZFA=;
        b=YXWYkXPbKLOC8rbvU58tsDHhQxdJftJ0xYK5ETIsGgBdn1IJPgItsUQiWIV6lT2tZb
         l1R3c5ORpdInPOig3kr2VbMkupaXCQjMHLxKQYSiX0DLGqRtyY5ojQNSwWFIpE//7PfS
         D8BltWGa9WmL70Ft7F5K0jws364+cwo1Q5xlWuuPUKWH4PZVS46uFgai2tTZcSZHB2G3
         wd6W6KpTjNgSZv4zW50DRvmjk9oq0BOIU1epID0MeGy8i+Ma3Bt9NqcmRIH7wEDIS4JU
         V3QFxoLkc24tC/H8k4NKlWC1U0RxbcjhCF7UE2i8N2fpxqdoymJPHDiLRTyDfR6CpBIs
         tjyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768315109; x=1768919909;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W74bGBgFK/hOVn7wDmizyI3ZTIrz3Q9IO5DO/QfmZFA=;
        b=c+or82LDATbain1yNmEU1RhplINtaWJ7i/GUwrp9pYGtVzaEXaGSHvrFOTDy6QW9Kl
         UdDwULhX6XlfixCqgOua7X3cyRaCK5rVea5iQK8O2gl/XKo54THNV404PMQncfyig+i1
         Uq7hJff1FIeplCj36j7guuE/7NABcCHGn37ZoEcW2SCglU+z5hctNeSsuqpEzV5/XSSg
         S4YOR3/Uu/JPJDHR+a1JeV/Yxly+NHxajRsI9Fqby8EPr8YoO5hEAqQOu42QKQfpfatD
         QjJ9yaHA5i46eonJ7rE41Qbl4ra7WywExoOl8+uU6z6BPzRsjsbDVarn9Ye1CRNLglB+
         XdKg==
X-Forwarded-Encrypted: i=1; AJvYcCWBrzXGgg/rMLu9Xca6Jv1FyPzie/jOstZdBtd5WVIVkUuTUvrHSRtpm8zd7cVwyuJFikW8hxJfLCl9x9SGrR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbUZSO1+Bps3EwC3GKVJcrhNwsxsDj3QwKUZJN2dKNQdGQTUTP
	T8JD59yuU9C86W6k+fndLW/lhXss+5ltmVDCKq3ANdd0m5y+w2DesKQdKrrxbRgfhtU=
X-Gm-Gg: AY/fxX7OYKjHqOlH91d3pdK6upsQOxY3hE5A5f/YNWHS6nBDb1ZBficX7k315MM8w2B
	cuHSLYnRL965E8rjVZAAjFSpQy9bF32cTYACVA+KUBLDeJuYxWvbi3/IiWkWYp/sNtzi8nwdka5
	9Ye0cOTiEuL9ycUBmmscdUYQ0XSOMZcmhcIoJc4zTuHv0rrJi5wZRuPYgxytqR2kTAQGSCbD36U
	tMxBgiykUBTkU1YtSWS8SmIECoOi0Sex7EdYhe2T8CRSUKfz85WCqQslPmoyrTY7pJv7D+/6BIq
	a/O7yFFoACZykwGjArCbu+p3FzQJaOO4krHVv0x0VQjoiYWc0jWki1OhKuaVNzjIoURUWsR1Qeq
	myKa1PIQ5u0ekKhTHcavJe6l4DkvL6GbZ9ZKmtXXPgd00lAQK4KVTIRczxVtVyHXzcdi88fmLdu
	1GVhqmtqZC0SimdTUSL7MAynUcHexJEyHDAigUE1hs/mcT3a63lYoHab4HP46ATbo0/8tw9GrOz
	aQ=
X-Google-Smtp-Source: AGHT+IFhQFRKLHLPUIv8Ub5JMni/oYRcfzQxDY3eX8L9+76+bBCMjvx/OwK8+nL/LNykEUxdCBt7WA==
X-Received: by 2002:a05:600c:5285:b0:47e:e20e:bbbe with SMTP id 5b1f17b1804b1-47ee20ebeb1mr980895e9.25.1768315108593;
        Tue, 13 Jan 2026 06:38:28 -0800 (PST)
Received: from localhost (p200300f65f20eb04fab5de2138b6a8fa.dip0.t-ipconnect.de. [2003:f6:5f20:eb04:fab5:de21:38b6:a8fa])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-47ee0b3429dsm1883095e9.8.2026.01.13.06.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 06:38:28 -0800 (PST)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: Peter Huewe <peterhuewe@gmx.de>,
	Jarkko Sakkinen <jarkko@kernel.org>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Sumit Garg <sumit.garg@oss.qualcomm.com>,
	linux-integrity@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] tpm/tpm_ftpm_tee: Fix kdoc after function renames
Date: Tue, 13 Jan 2026 15:38:15 +0100
Message-ID: <20260113143816.1600893-2-u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1298; i=u.kleine-koenig@baylibre.com; h=from:subject; bh=bv1yaH5EQk2ChzwUcstriXdO+QCpJWJNyBkYzvqKM3A=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBpZljYr7WZONsdn9G0Y6iL4wZiaI7ALi2TEK0DK wZgh3aQZIWJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCaWZY2AAKCRCPgPtYfRL+ ThT6CACjkpZ/MxTtgBcltZeCYuWlhTG4FUH2YgIU0L4yZcbjM2xtIHfFmROaysGHGf24INsPX+C Kj2UFbgwTxWxNR61C2mbpLuiZx+Ps73hqWMqTb/PBAK37/nEl8AFd3vlplXC/0vImkk7rKwM+DD IMjajaofH097zOeD3+yrq4QtcP715ar1si4oVWcO9QfCcLusGfIZeV+9x0br7PzhlB0ud6GeGeu OZnc+P8JjVLUfHJHfOUGBwuTw6oV84OYx07qhYkj2281PcIJ2BuXmWjNlAB0AFlDBhQuvZiR2ta 0clYwXtdbKeysv4YeG/OXwDiNCxRk+YQ8jbIVJ1LXPHKv68d
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Recently ftpm_tee_probe() and ftpm_tee_remove() grew a suffix in their
function name but I failed to adapt the kernel doc when doing so. This
change aligns the kernel doc to the actual function name (again).

Fixes: 92fad96aea24 ("tpm/tpm_ftpm_tee: Make use of tee bus methods")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202601132105.9lgSsC4U-lkp@intel.com/
---
 drivers/char/tpm/tpm_ftpm_tee.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/tpm/tpm_ftpm_tee.c b/drivers/char/tpm/tpm_ftpm_tee.c
index 20294d1953a3..b82490439633 100644
--- a/drivers/char/tpm/tpm_ftpm_tee.c
+++ b/drivers/char/tpm/tpm_ftpm_tee.c
@@ -163,7 +163,7 @@ static int ftpm_tee_match(struct tee_ioctl_version_data *ver, const void *data)
 }
 
 /**
- * ftpm_tee_probe() - initialize the fTPM
+ * ftpm_tee_probe_generic() - initialize the fTPM
  * @dev: the device description.
  *
  * Return:
@@ -266,7 +266,7 @@ static int ftpm_plat_tee_probe(struct platform_device *pdev)
 }
 
 /**
- * ftpm_tee_remove() - remove the TPM device
+ * ftpm_tee_remove_generic() - remove the TPM device
  * @dev: the device description.
  *
  * Return:

base-commit: 92fad96aea24fc19abe1eae2249402b61de3a3e2
-- 
2.47.3


