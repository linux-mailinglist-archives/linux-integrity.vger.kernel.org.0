Return-Path: <linux-integrity+bounces-5705-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB4EA82F90
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 20:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 254E97B138F
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 18:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE50F279341;
	Wed,  9 Apr 2025 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="N7tekTIm"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A48027C14A
	for <linux-integrity@vger.kernel.org>; Wed,  9 Apr 2025 18:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224822; cv=none; b=W2CFkhJlO0dbBzBXaDY+5IEYpXpdeoHtL03PYEeUxw6yn5Rjl7Ojj76t1xq1sD9Gy17WEsdLAQ3B/SIAff5QDWakgf4HjNJG9L4Bqm8udrpE6SNyMSZaKu+569p2JiJ1/WkD3929KAhEPxgg4Pr7oN/XRii0HLgkYTN+Oqt6PjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224822; c=relaxed/simple;
	bh=578od+KOKp0Zt5/G5juxhdeXYFulKkNW5mxLTRLFSTE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDbeHuRXPIsYzlbbHDcIDb0Vhy/3VQBECqFaahmPfDHVUFSc17QUOBdWeDNzPfBa7G2996Ofh2JsnYOmCYugPKkmI2i6IPXCXFyvxpC1ILqEgHyh5YOigeJvrPIRV04K8b6W20ZJxU9dy33aaVQmJyrRyM7VmPthuMnRWmOs1sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=N7tekTIm; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-47664364628so524431cf.1
        for <linux-integrity@vger.kernel.org>; Wed, 09 Apr 2025 11:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224820; x=1744829620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fM+bz3BaSY4cr5+X5vDEIDHe3dga52xK7vJorYPABfU=;
        b=N7tekTIm/VpWkeqBUSW2G5hY2qUH7PpvqZ6DPRLxqJrbD+HJZ+GAh1QUEdl/ozZwB5
         oY9OvYASHq9VQS0DpWok3OQLvNA+uKavJSB8mmuRlZU/uik4l5BPk2mWGGQuvGPOOtFH
         aRvU0wbufVjm3ccu2YLSCvRoiE/+HGxmE8RwUya1buTh766UI0TM/0FkX+YBkLGuXKIW
         8nvjrvq/bRq8aYacU/QBvIuLSHRI+Uz4eApZonyotbs90/PdgjD0b3XuBjF+VkShu941
         fA7aokSmGN0A9vY8yOtFU2WC5UYhpmZpAk05ypUYvG+JUT+eJ9+QIpxIfrtBp7TrE+Lr
         cZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224820; x=1744829620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fM+bz3BaSY4cr5+X5vDEIDHe3dga52xK7vJorYPABfU=;
        b=WBrix2HZ0Nuc0gZGKYx6wl9T+QJZ5Joyb+oX/zZW409AkOthK3naiRQv1LvYEGF1c5
         pO94ztw/qJGi/KWi5C77knlJ3H2SBairUN4hhcH6xPX0nr9aQhIv58sHIno8BaSaXODM
         fveLGUbOrQvAlBccb8SShEzrFQJ6G3SkKsA44h+SayWOL1Ym9OWZA9IOUceBzBwatDGO
         OviVolrVv6Xv89X4ewFr/avY6ZPA5xwH6Zj5Ih1VrxYE1VZ4D9kHOkf1AjVsssSpuW6j
         VzvSWPpeF7sWL9X0NxOStVCEu8eL/euknEargIrn1Dj+VOQfXXUHQoZ64Bvf5iVDSU//
         imMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJCDZuAE8F7iVIWruTCA+MS/PT6NKE4mUxqbK9uaPQSnTzOamYug22eF0y0oOsSxLo0h0nEBBbIcnrISkbmjE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8n0zJobyb6Zx41tGZrd/EMQV7QQrRFM5cVjatbgX/PPwwATb4
	aN4YGTHBevaZ0/9ky8Chkuo4flRRdzTPL0LUVJhABz4WNpD2zFAvwyK3Y8ivTZyvfYwuZMun1R4
	=
X-Gm-Gg: ASbGncvmRakY4zg4qm7P3tuXYYas7G3dsiFIsiZGqR4AqNqMBtXJMXpiviBvhJiVoUJ
	ayjHAAiBMXurqEK5O496CTBKIBffi0pNdNkXJ7+rfzTa1OvEyJL2mBMijCYa6SXmKa0a3FLtqlF
	7QiSbzWth1xsTxdn1wW452HYG6wgKYw039vzTxpYPKsdNz1S6U+abCPM1FV0Y8KiZ/FUX2qWt2n
	5IbHlmTqGslMm4LktCNu3zTVam5xWPYNFbb3fBsf4MqFeGvGanhsMNtZmyzp4+GfQ1TO9aMSOk1
	V+jCRQSueCkozQ5ReDQIXiKgIBjhFhtHK8t+bmTZNsGL0adgRLeG4yJC5LEJGtymo/hH/b17Cwn
	hWpXPeOqFfw==
X-Google-Smtp-Source: AGHT+IE/UP+Tgrhv8CukewwDsH4njav3pf0K/xuBK7KpANvlk9kvTIrqyL/7jPJ/3dgc4O2SlpA4Bg==
X-Received: by 2002:ac8:5841:0:b0:471:fc73:b656 with SMTP id d75a77b69052e-4796b95122dmr10953001cf.12.1744224820071;
        Wed, 09 Apr 2025 11:53:40 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47964ef607fsm10303201cf.75.2025.04.09.11.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:39 -0700 (PDT)
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
Subject: [RFC PATCH 11/29] lsm: cleanup initialize_lsm() and rename to lsm_init_single()
Date: Wed,  9 Apr 2025 14:49:56 -0400
Message-ID: <20250409185019.238841-42-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1717; i=paul@paul-moore.com; h=from:subject; bh=578od+KOKp0Zt5/G5juxhdeXYFulKkNW5mxLTRLFSTE=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sGs6dlM6SxnBucmXuaDFaCMCCh8i2n8VNoWz hFMonzWXF2JAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bBrAAKCRDqIPLalzeJ c/5wD/sEmeiG2IGjN6YHPlgEIeL7I2ozz5bYdjZvFV8W0QPGA7e6OK1nRE3/kTYeQEZh5y90zIp qPSBV7+sa8V8hFyCgfgOF4viD6qKVdT1dZAV8WPYFyPSBHT6wsplyk+r+y72tyJE3moVJWj1hP4 0/SszWMhwYuedWR7/50VGMMiUMpG7B0ZXhARQV4+j10a3dcluMccLUiltXYu20QoKjhjHhReD/C w9ClkTa7e7DZUUBzwYK4wU8hfwpQa7E2ERPgkvYI6HttbSBA3mdAgG8zRISn7kktxdkuSwVUQUr g1wcJFNgyXQXHRAbFovnvMyhFCg0R3k6/VffjSTrclZLATFZd4dfjkdHEi5S/1bwbgx4TcREhcp HP0j1Golz13++5m7zTjtxRSCYqnZ7z6PsfVM4+VKGk7p1sUkjIeWRv7oAJmEIv3aLYi7/FIiJcD CnwHFmEC6mQxVOzGqepqGARFT7W35I9JHiWtahZ3kDjt8/ZBzrnp7qBYNo/WaV6W4lJW3DGS5zr z2QWWn0GlJJXUJ319zzDbMoMzRzPA0TvwVYPzVKtrCB95NoARwm4aKI/xdxZZi/lxWAzRs+pdfq tdveGfZTSgThrpBEyNsimTnKg383hT7t2cBWBca4WUp6hSS09bX6wFy1wyYEBMaRI+l4DTRAlPQ XR4vGI2bKza/IIw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

One part of a larger effort to cleanup the LSM framework initialization
code.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index 9bb4b4fc9888..163fc2a1a952 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -214,16 +214,20 @@ static void __init lsm_prep_single(struct lsm_info *lsm)
 	lsm_blob_size_update(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
 }
 
-/* Initialize a given LSM, if it is enabled. */
-static void __init initialize_lsm(struct lsm_info *lsm)
+/**
+ * lsm_init_single - Initialize a given LSM
+ * @lsm: LSM definition
+ */
+static void __init lsm_init_single(struct lsm_info *lsm)
 {
-	if (lsm_is_enabled(lsm)) {
-		int ret;
+	int ret;
 
-		init_debug("initializing %s\n", lsm->id->name);
-		ret = lsm->init();
-		WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
-	}
+	if (!lsm_is_enabled(lsm))
+		return;
+
+	init_debug("initializing %s\n", lsm->id->name);
+	ret = lsm->init();
+	WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
 }
 
 /* Populate ordered LSMs list from comma-separated LSM name list. */
@@ -374,7 +378,7 @@ static void __init lsm_init_ordered(void)
 		panic("%s: early task alloc failed.\n", __func__);
 
 	lsm_order_for_each(lsm) {
-		initialize_lsm(*lsm);
+		lsm_init_single(*lsm);
 	}
 }
 
@@ -423,7 +427,7 @@ int __init early_security_init(void)
 	lsm_early_for_each_raw(lsm) {
 		lsm_enabled_set(lsm, true);
 		lsm_prep_single(lsm);
-		initialize_lsm(lsm);
+		lsm_init_single(lsm);
 	}
 
 	return 0;
-- 
2.49.0


