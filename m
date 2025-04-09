Return-Path: <linux-integrity+bounces-5723-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC56DA82F78
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 20:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7CE719E77C5
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Apr 2025 18:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A057F27CB24;
	Wed,  9 Apr 2025 18:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CsTLtt5V"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA6F627CB00
	for <linux-integrity@vger.kernel.org>; Wed,  9 Apr 2025 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224839; cv=none; b=KmT1bfTDSIdz+Dr31dXLQ7aetTM351bQvIO/MiVIWUBTVf9vP69mHsrwv/N+obNKaibMc0qCLUQTPLrPQQf8fN99aTB/guATV804qlWeC8qz7zW3vEdDxA+0XRJ9W7fRdFXBYcsPypL1MmN9dLxj83zbKahxTw7RdY6oYNg5BG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224839; c=relaxed/simple;
	bh=EOhKFjWPk2W+JME5T82mhmndtBkKJ4lU4BvvjUFikbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VAlpkpupmWqSkYbF07t8na7WghIXa/DfM3L81CSMo6rJs4j0sXwXORM8IKhoV4MaNokIaNjB+RCllZYaniuw6RJ77VgH5eGNnLvJRmoADIwEwIcBTv/rctcrCpKriwGGWpNKx96Xmzyd17ssLNubXVaHP7WqiWo3tbybOPXn700=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CsTLtt5V; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6ecf0e07947so658446d6.0
        for <linux-integrity@vger.kernel.org>; Wed, 09 Apr 2025 11:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224836; x=1744829636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FznqwKTb5apAKN7+PdryvYkHD8cDOK5T7aoHaw7NUu0=;
        b=CsTLtt5Vw0RXkken0N8YjsPORF8mLyHFZ0YXh/8IbHm44jrOdpKe6MDn6jvI2WPG2w
         w86XA9Ia6zquksFtR5r0aErwZLEfDVxGkqhgWtWF453+g+4wkWtEbweADVmhwcbFMwmn
         SD/LsqvvLZdZQpVVBX/N/kSplrKirdbSHXlbdisQQQBoGQV81GnJKiiU+ijmfzl/GahL
         J+dP/AM6JbH7WRIAWHnnbq8cFgR+ibIqocWO5F3mfehzv1vxIQ9HvGmsQhIsQHSiEKTi
         +oWF1vf24K1MsMuUZsSHmyNyuF2wNOHrFOQdYF3AjitEh85qtBD5AYVWNukCziwlwyx8
         PyQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224836; x=1744829636;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FznqwKTb5apAKN7+PdryvYkHD8cDOK5T7aoHaw7NUu0=;
        b=G7G6HymczU8PpHjZi126YZXCtHTKiJlfc3wEcE5cLqR7RJzY+oFX5J0Jf1mcuSAxSC
         OMNvuf2l9FbsVGJx8rtUG5rZ0Lp/M2UBEL1eU7VBk4tTIG6vTTjF5J+JT2xx8TnScDE6
         uvU6gQJXL3KCbR8qzCpYsBLVcKAbC9bamXBZs9ifao4dIGkh85JrNXowiG8mkVlqo9TH
         GaF5SqV23e5Jzc4TvFwlqMMS7aAtDcuuRj64uSW/yAsj8ECGjIDcRUMhNOcHdWhDhil+
         YiDKxb3DUx6oH71F3ilofk8FzSmiIWa8ePylxvkeokEP4PW0DhamTVgxHign1DV34N5g
         mfMA==
X-Forwarded-Encrypted: i=1; AJvYcCVJ8x1BG0ZiW1ysH0CKrYjvmIlKgokXU56lGGeIWaPevzo1hWumooo+8PWwpDanQ8zXJiBlnaF+C571RGlirFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVePH23xd8RlkO7QlwriIDw6wRgbFtXUhAC7cRL1ifm7q3zJoN
	D8UABfHSE7uErDvwO4wq9btu3E05XVmzDmy2TKz2Rc3y3VCfN13y9ttjQyl/eg==
X-Gm-Gg: ASbGncsZuLyT69DC9ocIP0v5zro/DgjKqrrtDGe3TKMeKvV+JLjFVC9gn2w1fy+cjkj
	i2qr0+0rZhPJnAzMmwWWP1D1ZSavT8FpkEDvf7A0wXOw89RxwgDaXYqdjS7Lg8xccoRSkFaRI+s
	WEU6MTpNqUoVVXbJvoohzR65gg4yMy8CT5426SjCX6msYW9JtvAthUO2R/zpnxV0GQ4Vo7TRwLw
	hv7lN5TFQEuriuXepHMyjV7GKz3fOwoyiDb21R8b2m8bQt4UfouxmwtwIEqSK8hi6c9KErs8//V
	+RmttOLqAR3tf79aBP9Eqwq7EgHr6cIWguJ52lubPAdtsyrr2NEjCTdqW0npXp3vyQacEF2a/L8
	YatT7jqbQfA==
X-Google-Smtp-Source: AGHT+IFcpDIpn9yzoagNWWHWb0KRZQDu1+LHtagATeLv2Xto1aKeAbvvTuZ3Ieu6WEHXP5eExSlB2Q==
X-Received: by 2002:a0c:da0b:0:b0:6e1:715f:cdf5 with SMTP id 6a1803df08f44-6f0e4cd95d2mr9685806d6.15.1744224835695;
        Wed, 09 Apr 2025 11:53:55 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0de95fdd1sm10572126d6.18.2025.04.09.11.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:55 -0700 (PDT)
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
Subject: [RFC PATCH 28/29] lsm: add a LSM_STARTED_ALL notification event
Date: Wed,  9 Apr 2025 14:50:13 -0400
Message-ID: <20250409185019.238841-59-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=974; i=paul@paul-moore.com; h=from:subject; bh=EOhKFjWPk2W+JME5T82mhmndtBkKJ4lU4BvvjUFikbE=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sIVMDPtmaBS3eTRatijsag/DCisyb4Lmzoy2 Rs47FQHppuJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bCFQAKCRDqIPLalzeJ c/RFD/4o3uzOvFwpzkMnP8y/Ozb/Np5gbUiHvWCt3vtNSOHqvzf0kuvVf7K5dmKldtN9VG7Fezu fWYpsoGhZq1z49oePGfOIAM4XWj0xIayB/J7ufugfCI31/BQHMPk34mgdIpFiRlFjMTJD1KFpWg ZYWf+18CAuYoS9wIZmHMJlsCWtYzYOXy/ahoakG3nmIJ4Z+GmMq+ofY3qFV4zo2Eo6v+61VGyNZ Uq6hHMbSW2PfT0Is3JBP2lOhMOmnFKkhRKKCwDoLihPwYTIQdtu+qaK7y8LC7ucVTU0cAXT6RGL eFpYPjQJaKBmUvbBLfxv5Tc42Uv7cWQ+q1qfZo5bHyN48RutQHFZVbvJ1D7JWF0vsgj114lQaeZ m7Mu4Gms3TrcFwXePRReawxy9shpXmPvBOZQxu1ZRpfm9M+jkSy6x4QzBNaWT5LogVX85zm3m8A 7ibswbi2ktT2WSqTN3qF9mYhOoMAKnaEGmvyWG/7hPZTAHtTZx9SMnExdo1qacaqvgfKszoEnqK IGORQ4NgoeRN3eDQ//A1nhOVv5t2+yBkmRYY36PlyByhrLMSyspPDATpYz+WAEnV70rUObVJ8Xe BYGN0lmKkTl2Eketjbl9HRhYZkElCMGP+VjXuLOBTTDLVDMDDP4fF1NBNSYKygjirwv9SRmxVEc osl1Vp92YTaoFUg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Add a new LSM notifier event, LSM_STARTED_ALL, which is fired once at
boot when all of the LSMs have been started.

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/security.h | 1 +
 security/lsm_init.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 8aac21787a9f..a0ff4fc69375 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -85,6 +85,7 @@ struct timezone;
 
 enum lsm_event {
 	LSM_POLICY_CHANGE,
+	LSM_STARTED_ALL,
 };
 
 struct dm_verity_digest {
diff --git a/security/lsm_init.c b/security/lsm_init.c
index c0881407ca3f..cad6d243a2a6 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -553,6 +553,7 @@ static int __init security_initcall_late(void)
 
 	rc = lsm_initcall(late);
 	lsm_pr_dbg("all enabled LSMs fully activated\n");
+	call_blocking_lsm_notifier(LSM_STARTED_ALL, NULL);
 
 	return rc;
 }
-- 
2.49.0


