Return-Path: <linux-integrity+bounces-7468-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA45BEBABB
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 22:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49B061AE36B8
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 20:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D35354AD2;
	Fri, 17 Oct 2025 20:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Q/qd64BP"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AD7354AEF
	for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 20:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760732967; cv=none; b=a15TXWJQpgq56EfMhNrbc0SoBUIVhgnfjbVeUZDAIAMYvN7/0U4UkTSHeJhK+t9ERDNX2x3vAucYzxJvv2LPt+qPYTP9RH/7av6h5B3dv3fwaFVuvOpjp9dAaU08eJsgQtyOe0+vXDZRplZ0fbeuE8YhpbVrIdZ7H+tbxucFWOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760732967; c=relaxed/simple;
	bh=muxbOgaJg9v5tPWdzg/bAbRNyQbeJYHw0DoxAC0u+LE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D+ilsUpFdAGHBCaZ8s4tFurVG6KCjXYYDc8HZvYWKG6f7zGCjrfBk2xasjN7yGxrSysidZcnxvxQt23ACjRHYrh+MLOG1KUCdnXWcjMmRFu7dN3VazYeyL+8F/RKLkIo5YxjRUlOeOQTgnQ9t2+lok4PXF/TmnGPkm6evthuwho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Q/qd64BP; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-891667bcd82so114354685a.1
        for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 13:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760732965; x=1761337765; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m5DJxtIQfhKWC0mHs93epjwMCboY2q/zrsHtIm8xqcQ=;
        b=Q/qd64BPkqzOuaHX8yODyvAV5Wz9BaRdjbV+C3IH9Vm2LRl3qbe9qXSqe64sqz5DCY
         2wLnK7jOqdiQMLAunE7fEzxRvyZodXDA0A3yXydZYwb75AW3Z5tWXqFmPRX1rdceqkU1
         pOTx7TkMgK+hpJdjXg1D1p0CSbRZ5plgpLqCd22Y2DnuZ/5Kj8j/dBLAZvFvSOiu9KCI
         uAg6hZJN0PlaJD8eWe4h2rWmlALGGcUlyK24cTJlLUVOSJd3KTKU91sarAUB8aZmGbvQ
         2yeHTxJCJkSwIeFXt0RghqOgeuqh0CJjlUUY16afdkM4EJFmRreesiJSm5RIJ5iaEdAL
         4ixA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760732965; x=1761337765;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m5DJxtIQfhKWC0mHs93epjwMCboY2q/zrsHtIm8xqcQ=;
        b=UN78MCyjAqJobe9+MVE1vTELCsRRNuxIX3MXwOexNFMWk0lcBbQSwhhpf10fdw8Ai4
         G6BWD1MIEWISJEqFE0gFZ/SrgEXxpvqHp8T39gsgW1xqe8AooqClrnTx1Lc5pOSAfJTu
         GQ3cZHwCzgO6R6SWza2jNuartAZjODscaf6IeAyvr8yFD+S8cROT+4tDH5NCc/pJ8M6B
         2MUGKHWzEG+SzLUqWp8YBxpgfI7lg6g2PpdhLk5HGuSWcFaZp0JU/eCQZB39LASLkW6u
         C+SYhl3MpIJwu7hKiNXpD6mDYwPF5If+n5K/x52eB+bJ0TjuVk88NwEnscw5Xbi1c77x
         3+hg==
X-Forwarded-Encrypted: i=1; AJvYcCW17NaoJ5ErC2HADiL68gS5O3vT0A9b0OcVU6whyPCgYPJ7fsoMxzaE/JgR0rlkBLf5K7Y5G/zWstoI73mvEVw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQJWMMVC3csYh2Kv4Feokwf8pk4VtOK9R00rSDNWiGvld1BKcv
	XvpJvvjwD9DRaj1HFJNzvqzPvgj3UbuzA5EW1di4Elv6wGJqEtrTbJRphxgBrvSw9w==
X-Gm-Gg: ASbGncuPJ0a4sDDHVc7iZbik4ukDU3rfjFRjVaVdwaSZT9j9XExZSnuVfck+42O+nOz
	j1SqL/7gEAQ955A6SuA6CW2LW9pxCOFdpKjp+Rqq/2+hZ3+JBdm+bF/J5J78RrnsVCT/+RX2fH3
	2Hir8JI8Tq9m3C0HzFiK0mrB500WYbDiLJ5yT/47zSIoklMrlKoKVOtFfugtDVAUHNcohPeyl8P
	i2CR6ywmhhUH2tTuv5kW4j+IS001bCUxoKpAkroz458Tukw1BrgEB9lt0hwpS7tfdTLvTr53wl+
	DyrXKzuBB+s7OQOmuWzcG/dGfubkmwPj7JYjD4d7Tx/Yhv2dxViLm4WCCs7La4TnEWufhml/lUf
	wVz9mh7XdlI3IlqWHIcUHgxZEDQQxLVZT/LbUjJiS6Yev2Ex54CUb8r3aSqnDc9fBu8eYf+nuHa
	8StPgk89V/4I9YdTxbFjiApvlOjm4kArch3BgIPbJcZSIJifxsS9uUrlmr
X-Google-Smtp-Source: AGHT+IE+j2fVZsQswXCdvfIWquJQ5ZGZIswl73bX1lz8S4ZzuxTPXlcCq5bfd1nvRoqrZhxuItOXfA==
X-Received: by 2002:a05:620a:4449:b0:843:69b0:29c6 with SMTP id af79cd13be357-88f0ec96859mr1355434285a.2.1760732965114;
        Fri, 17 Oct 2025 13:29:25 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-891cfb56807sm39397285a.63.2025.10.17.13.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:29:23 -0700 (PDT)
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
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [PATCH v5 21/34] lsm: output available LSMs when debugging
Date: Fri, 17 Oct 2025 16:24:49 -0400
Message-ID: <20251017202456.484010-57-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017202456.484010-36-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1658; i=paul@paul-moore.com; h=from:subject; bh=muxbOgaJg9v5tPWdzg/bAbRNyQbeJYHw0DoxAC0u+LE=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8qZaXuPIMjruQi3evlea3BOAk7VHfw9UtI6cg ZPV4cdzrw6JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKmWgAKCRDqIPLalzeJ czuYEACsVrztiycgCr/u6S4++lnKdEhkHuinpbKgsRtFTPfM5IDL9xcjMncjLDRDjctlkCGF9WL MToWHPA8hzQvZ4dbDHtJBIVeWLvs+M+npfb3jV/ITIazyBIxZ3Lpf99p9gMSbwk+R474f7dyxem wwADGZMIM1qrCm5YpQXDNUg9jaHmHNm3PT7FFivLzopvH938ET0wTaX4157hS6vi4TCXriDk5ha 9q3pfzh0TeR1psPA8XSqZWYQa0uFPk7NNT82TXRw23NiHkU9HFmNldXg6GcD2nsDp9gw+SxIEpz VbYfqVo1CfZ0sfCdV1k9dekmTtnnwbFhEdDu+hlxYK+mcAFr8k4NCbUykTrZsVDt7+uYC3Oraoc mdQXqIy0egfbDK1kpVfiY1xorS8Wn8OAhMSoWhjnl6oGIEDtt9hgVonrE9ogp5Fy+46e+ziUPxR tTyUL+/Qfbq0UYp7Nihqy7/+IN//zFgAroEaYL0J1s+DmbRrvnAYm5Bzg7K6MmTzvNlfjy8/SiZ 9w4CvH6l+kFJcyvUJ+AUXq1cl3IuU0uKMgunoiiGR/Py1r8V/nxnYBgHZrjoTAwISop3dCAXGyU ky9keWn4K7euDbET4LuWwTGOF87+fDUFka03fp+9ZOPVVE77fZGu/v7RpJ6kx6D4Mdxs8PuhNWE 4nSkmrjtaDjTa+Q==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

This will display all of the LSMs built into the kernel, regardless
of if they are enabled or not.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index cd1779e03497..cfcf3bf7127f 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -363,6 +363,8 @@ int __init early_security_init(void)
 {
 	struct lsm_info *lsm;
 
+	/* NOTE: lsm_pr_dbg() doesn't work here as lsm_debug is not yet set */
+
 	lsm_early_for_each_raw(lsm) {
 		lsm_enabled_set(lsm, true);
 		lsm_order_append(lsm, "early");
@@ -385,9 +387,24 @@ int __init security_init(void)
 	struct lsm_info **lsm;
 
 	if (lsm_debug) {
-		lsm_pr("built-in LSM list: %s\n", lsm_order_builtin);
+		struct lsm_info *i;
+
+		cnt = 0;
+		lsm_pr("available LSMs: ");
+		lsm_early_for_each_raw(i)
+			lsm_pr_cont("%s%s(E)", (cnt++ ? "," : ""), i->id->name);
+		lsm_for_each_raw(i)
+			lsm_pr_cont("%s%s", (cnt++ ? "," : ""), i->id->name);
+		lsm_pr_cont("\n");
+
+		lsm_pr("built-in LSM config: %s\n", lsm_order_builtin);
+
 		lsm_pr("legacy LSM parameter: %s\n", lsm_order_legacy);
 		lsm_pr("boot LSM parameter: %s\n", lsm_order_cmdline);
+
+		/* see the note about lsm_pr_dbg() in early_security_init() */
+		lsm_early_for_each_raw(i)
+			lsm_pr("enabled LSM early:%s\n", i->id->name);
 	}
 
 	if (lsm_order_cmdline) {
-- 
2.51.1.dirty


