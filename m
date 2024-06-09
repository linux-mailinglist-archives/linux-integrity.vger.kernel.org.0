Return-Path: <linux-integrity+bounces-2850-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8391D90154F
	for <lists+linux-integrity@lfdr.de>; Sun,  9 Jun 2024 11:30:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C8051C2154E
	for <lists+linux-integrity@lfdr.de>; Sun,  9 Jun 2024 09:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0AA1CAAF;
	Sun,  9 Jun 2024 09:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="iH8cWDkF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D741CD29
	for <linux-integrity@vger.kernel.org>; Sun,  9 Jun 2024 09:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717925406; cv=none; b=XhYzR8t+GLmIXWRFazsdz2BcR+c0szpiNRS7jR6i22pTWBJMR702tHRWIBM3ZLc4haGBGwvuJwoGsk0z9zr61E6GQplQs8lHFbNHXWmB1wZgy4Oe7NJv7jMYa+54g59ZMmXyZgZKex2Y0bITgJqJE7YqudGOPiSnPa6iJ1gjR/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717925406; c=relaxed/simple;
	bh=rp0xaRniMXYUPmbbXAeeCdLixzbn1ampxHzMePNTqAU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VOAxkbfpEhFQqgZ8kEx+XQwQ3JdF7RoQdg/8fHc5UEwCuZJZPG4j0ac6YE62EtyxUyKM3BM1aNiBI1hFvnXBOincehfg6Mo3v5G1WEgw+9P+wCtq08lJeIFYI4MOQfIbDwfwGGeKkOzu89s7l9arwG2/KMo9kEuhBdPeioALWr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=iH8cWDkF; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1f47f07aceaso30184735ad.0
        for <linux-integrity@vger.kernel.org>; Sun, 09 Jun 2024 02:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1717925403; x=1718530203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wZ4zM5FqUy9BzgIW/hsuBa/MZlxgzE24Gi8nDjm8gPw=;
        b=iH8cWDkF2xpIlynOO1Z7CMQGP7b4qMBguq250ayrdFQo5C71nId03lRxiQhExiOEXs
         64Nf3oRN27vnEqKepsA2SLZOmh2KBmExTvfuR8j6DFjG1ZKjBKbtgD54brvrGYpgoMX8
         CsrwZfP+eTmqJptE01uVCRbbLaPiiM/zEPDF5H3M9oEP0DWILBZD5Ot3ZQLMVhCq/8nZ
         6FHjpLzWGyLheqzGQr6qHLKuLu04pWcdbH4nQV2M9gWFrgCCwnIZjU7aiNc3QAIrrcX7
         gm4TTmgBWrSVpZiIErOOkwHYmt6Itu10Mi3vAJ5fAIepx/rUB3SG9MDjYsAOOxww40iI
         xrKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717925403; x=1718530203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wZ4zM5FqUy9BzgIW/hsuBa/MZlxgzE24Gi8nDjm8gPw=;
        b=OWE/Oc3lGgQC8m6nKucqkMXsnAu4Wd5N0mdZQIUY+VQtTeB4zpDA0+7hGf3vJk0EJ7
         bFjddKUXEKT+Gqy2r4uWRZTzd/O/DX1cbodBe8MXs4QkMmMRq6KV7RR+1PYlsAdVsl01
         7sJ590DQJ4uilD6sDI9AgFcLgZP064g3wy+WIWvy6KUYUNxk3odYyxcB7L8SoRmk1+Ku
         WZKnWXKPO4WFVEkF6vVwWksQleIgvaHoBsvnOfMYqHEuNy0BrdFL9D/oNlu+pUkhAyFC
         6ZWQy/B0SbTG+GNcAW6QnwoX9ypRX8Ek8hIJx7FxoN0KdO4eggDaGFr78pzAPZVLA6M4
         B5/A==
X-Forwarded-Encrypted: i=1; AJvYcCV4Dr/tTZtw6EUz1Ksriufrbyff+c7AEoAb4g+/XrA2nM3z29wqTQ8P2CfdXWxjEecqRS9+MrEKNn33p5yingsyccF7ZC+tuvVKZMXhZdSk
X-Gm-Message-State: AOJu0Yxot55ih02Cuo+sHaTagY59aw/ZlDy99io8Z7hMlbr67ogLIneo
	3TeZrkjLK/vd41S2RWsn+el65fa8ZdYLBLeeILlDgIX2j24mSG09jLD0/HuUnasexAzFa1LqD0B
	kSAk=
X-Google-Smtp-Source: AGHT+IE8/xceKBUKr6AD90nLjNkgJfQRtdAtQtuZz2DgyhKYqu0z7s7LSbVN8jB4xa3gVpovHEhJMA==
X-Received: by 2002:a17:902:e74d:b0:1f3:903:5c9a with SMTP id d9443c01a7336-1f6d03e576emr79261095ad.58.1717925403616;
        Sun, 09 Jun 2024 02:30:03 -0700 (PDT)
Received: from localhost.localdomain (h163-058-210-208.hikari.itscom.jp. [163.58.210.208])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6bd7e5cc4sm64044825ad.235.2024.06.09.02.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Jun 2024 02:30:03 -0700 (PDT)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: peterhuewe@gmx.de,
	jarkko@kernel.org
Cc: jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH] char: tpm: Fix possible memory leak in tpm_bios_measurements_open()
Date: Sun,  9 Jun 2024 18:29:37 +0900
Message-Id: <20240609092937.2874379-1-joe@pf.is.s.u-tokyo.ac.jp>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In tpm_bios_measurements_open(), get_device() is called on the device
embedded in struct tpm_chip. In the error path, however, put_device() is
not called. This could result in a reference count leak, which could
prevent the device from being properly released. This commit makes sure
to call put_device() when the tpm_bios_measurements_open() fails.

Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
 drivers/char/tpm/eventlog/common.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/char/tpm/eventlog/common.c b/drivers/char/tpm/eventlog/common.c
index 639c3f395a5a..df213ec428ca 100644
--- a/drivers/char/tpm/eventlog/common.c
+++ b/drivers/char/tpm/eventlog/common.c
@@ -44,11 +44,13 @@ static int tpm_bios_measurements_open(struct inode *inode,
 
 	/* now register seq file */
 	err = seq_open(file, seqops);
-	if (!err) {
-		seq = file->private_data;
-		seq->private = chip;
+	if (err) {
+		put_device(&chip->dev);
+		return err;
 	}
 
+	seq = file->private_data;
+	seq->private = chip;
 	return err;
 }
 
-- 
2.34.1


