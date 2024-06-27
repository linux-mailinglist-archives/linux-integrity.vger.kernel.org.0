Return-Path: <linux-integrity+bounces-2936-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C09BB919F59
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jun 2024 08:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4BD1F221B9
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Jun 2024 06:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBF322EE4;
	Thu, 27 Jun 2024 06:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b="LfIkd8wf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759751CAB7
	for <linux-integrity@vger.kernel.org>; Thu, 27 Jun 2024 06:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719470202; cv=none; b=vGbU2kDe8AyDMeBtn0KH+/fNYdB4x/P1P+XyHkgtfTIVWkpPrDD0sYDw6CbfDZ4Nh3fmNZ4q/wC7oPxKt+o4Bvh5c1IAfAe+GusctRz6gsaAx1BFxhhRjlnqPURV9ZlMkQ3RDzg/ZvoTpaQy2KEJlU2gc+3M+bcFkoi8xpWZjXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719470202; c=relaxed/simple;
	bh=M0wLcNU/BeTuuohEgxMB3gbOO+PhYurxfT7UgvaKQTg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gMyC8DRBeLmd6Time85Bcg7Jipsu9hBLds59I5CP4HclHAyVLLVuCDMGkp7HPtvw/MGqv1GtoTVbPHX1Um2PVbL08qfhsZON14tn2wwhJsYQen7AO+NADqv1ZrY2yflAFwaa0Xsfa82KocmOjM1pboMxuoodXY2/77lSu53iUXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp; dkim=pass (2048-bit key) header.d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.i=@pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com header.b=LfIkd8wf; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=pf.is.s.u-tokyo.ac.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=pf.is.s.u-tokyo.ac.jp
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-70656b43fd4so4674567b3a.0
        for <linux-integrity@vger.kernel.org>; Wed, 26 Jun 2024 23:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pf-is-s-u-tokyo-ac-jp.20230601.gappssmtp.com; s=20230601; t=1719470199; x=1720074999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NKqizyh8XSn6mH10NxE9X9AFr5AwyCB3pJHvwsBkhUE=;
        b=LfIkd8wf1IX9A+DHZXBkngSf68a3qMi3NeLnJ41z7JDpwyky7KP+eJkuTaQknVl0G0
         pEIWka7LWlA6ZhMkOB58qvLIVR6wPH24/xcPJCFOVbRa3rnfMTmNofbO34aK9K26jTd7
         CKdViscZTLjxqZ3S0abCzOx85UfCXB9gbISdiarXAnvcD2U0pRHKn81LXUf9h007H5f2
         SeIoa4srKOcEbV4h0JQG1aRocrI2ItnGrbqbJOnrViGXHSQOMoTYYM6sQJFyEMgJ8KJe
         4A2U/q2EJciwwN0D6VwxLV8vlymVp/p2GpquP05SlwaTKxWLXuJH5564ifpaS0T54FRl
         z/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719470199; x=1720074999;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NKqizyh8XSn6mH10NxE9X9AFr5AwyCB3pJHvwsBkhUE=;
        b=VYJS9ZOg0dc4g6vIcr3UU+5AzAVcSjVCupe+CTV/TdI1v69B3GD4NxSBn0MEHFywTB
         yCX+49012dWE6Dix8+O/pzZz2CLT2O0nwYbyl0ZSIg9h5cKLk1Tq2u2TJq5jL4yU25h5
         n2ft6lhSXOrcxfYiTxdAye6hVB01VyKSt5Q261p/iTBiIhr0mxbQ11hxzQl+3rytZhyv
         mw5rF9OY+j6+qITSQq40Hl8bRHq7lBBtSausdpzl1hzDwCNfuI+JGjmzI8ZZxtLuieC3
         uH8TuXI0vVF/YG7Rsnm+wcA1JIEFU9kU0Xvb3Uwu2s/DQeknA/ET+UUqBIfug41+yApR
         BfYA==
X-Forwarded-Encrypted: i=1; AJvYcCVbRztzfNLOD4mwZ1LHlH5wm1umEEb6aw0SGFYT2XwC8s/Pls4yz/FAL6z6AD9kmhS8yYcO8yADCHirS24iJPGQsv5K4kzqHeJqy3mwH94b
X-Gm-Message-State: AOJu0YyIPWkes8N6bqsXxYA8dHul0tW+ZeEtkA3Dsr/OkA8KJRMrSVcQ
	itgfqquIvG3YXYRwYY3TIn9944eGzx7VQnAk4Mli6N55lkdwrshQ+0okzk0wgFE=
X-Google-Smtp-Source: AGHT+IFU0s/YoFbgmqqiMGaiaCo1qHFQmmss6XInf3FRtoFQ/hNKlJhJELQW3TpYpxvODWHC0cKmnA==
X-Received: by 2002:a05:6a00:3c94:b0:705:9ddb:db6b with SMTP id d2e1a72fcca58-706745aaf1fmr14466716b3a.13.1719470199557;
        Wed, 26 Jun 2024 23:36:39 -0700 (PDT)
Received: from localhost.localdomain ([150.249.244.44])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72748e8544bsm476406a12.59.2024.06.26.23.36.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 23:36:39 -0700 (PDT)
From: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
To: jarkko@kernel.org,
	peterhuewe@gmx.de
Cc: jgg@ziepe.ca,
	linux-integrity@vger.kernel.org,
	Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Subject: [PATCH v2] char: tpm: Fix possible memory leak in tpm_bios_measurements_open()
Date: Thu, 27 Jun 2024 15:31:09 +0900
Message-Id: <20240627063109.1239467-1-joe@pf.is.s.u-tokyo.ac.jp>
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
not called. This results in a reference count leak, which prevents the
device from being properly released. This commit makes sure to call
put_device() when the seq_open() call fails.

Fixes: 9b01b5356629 ("tpm: Move shared eventlog functions to common.c")
Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
---
Changes since v1:
- Keep the code diff minimal.
- Fix the commit message.
- Add a Fixes tag.
---
 drivers/char/tpm/eventlog/common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/char/tpm/eventlog/common.c b/drivers/char/tpm/eventlog/common.c
index 639c3f395a5a..4c0bbba64ee5 100644
--- a/drivers/char/tpm/eventlog/common.c
+++ b/drivers/char/tpm/eventlog/common.c
@@ -47,6 +47,8 @@ static int tpm_bios_measurements_open(struct inode *inode,
 	if (!err) {
 		seq = file->private_data;
 		seq->private = chip;
+	} else {
+		put_device(&chip->dev);
 	}
 
 	return err;
-- 
2.34.1


