Return-Path: <linux-integrity+bounces-7475-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 012A0BEBBE1
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 22:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A9D9D4EE84F
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Oct 2025 20:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2885126C39E;
	Fri, 17 Oct 2025 20:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Pe/AgVAO"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5420126C3A2
	for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 20:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734147; cv=none; b=bnJ9Vgajm4cz3AESNjFDTo+0lsYQK5afrYbij25YPNLgrI2YGZ6Ae4lAQynd6/Dvra1BPhVeZhsvNoybIqtA04/BDCgsigwInsOzENRnU3r8q2CZg6h2Tr/amvR3TZlacDHaFuyWOOoKGXOOWjnQDjEvejj51sydFzUVVVk03/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734147; c=relaxed/simple;
	bh=yHHngQpeJUhcXZ8Tk8ygkCfx0smf6LjcNEh85Agei0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qUymSKSRNgh7gVJxEeH9cw7kMvrT6jA9qYmSb48XpAoJ+fPqaGc3SZdG0KEsgGUp3/+7EBf4jTnLm1qdyCAG896u++/5DFH1tiaYF2ELDVhOgsQ0WcThy2eWF5FLpIkqzGj7zDJuCqRZoZ6Lw6ZbxcHDv/Mli8wK7ug1rtJ7oH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Pe/AgVAO; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-7946137e7a2so40796966d6.0
        for <linux-integrity@vger.kernel.org>; Fri, 17 Oct 2025 13:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760734144; x=1761338944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=de5ug2mVr6qNuprssovqUXozxrrm7m9gudds73sIQ4M=;
        b=Pe/AgVAOskLoUzfIoRRZRbXuKmjB48t6lvvjNoh3Rp8dUQmVJBK2wNNErT8Wdfyr2H
         qJYMySBP/nTJVknHp6NUJLCatvH5PHypSPIqUV9b7let522tRKimVDkMKLuyJF4bRtQg
         oLEj9Ruq3yi2UYTlGBO0G7erXne4NQh75ytjsYeDZhZ/PHloD/h1XYGW2/wF2aF0Y7Pt
         9P/wjuzkPitoe2+qXQOJmtcIkFW/2gPFglh5pzjwasyPiZzbrQyv4JOnqB0lJ7BrsnvF
         jJo1JbQxqFEtq/GPvmDnAXROKFTSm/nIuWkojpufnn4tgIggjO6kHRpaLboLzE3XYut0
         aX9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760734144; x=1761338944;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=de5ug2mVr6qNuprssovqUXozxrrm7m9gudds73sIQ4M=;
        b=f9qII5VerAaGPEyyagkZXPCOiUGWPnYK2keWZeK8LCBNAAEBlYMk4qjcx/2WX6G8vN
         JXVx2YfJgR/Mh01XAIC+YCkfg7MD4fPqXbufWT1SmCDp5qFLu94rUCaPPhsYFw+UbWbM
         9A2QgvVR6Cbu3bpjx0wZdHPPDNSGC91dsGEh6emko4K8hp+N3snCRAXI06lGJ4wc32jd
         mMp/tMxKJQxtdLHVTjtCG7JIjpsFiXB95lDMFw5N3ODQW/aozUreMpHNzQbkooNJlv1B
         WXFEtVkX4ziMxtRDIcB+6WwbUv4TsLfkUKyFSJNT8Fm6peBo52feLT73MhLT5AKTlZA+
         e0xQ==
X-Forwarded-Encrypted: i=1; AJvYcCV0NYguCdYgW0XhseF0Ao+lQf/1u6KMY3mvOE+z5cMtHHWuIUoUW9lQxy/73ASv8rR/ItbfG73MmG34/I+Sw8w=@vger.kernel.org
X-Gm-Message-State: AOJu0YygJoBpL84G5GYbWtPkSoQgTgRlKBitB7I3TW6W3GnlbgQsailq
	5LhONIJUkK7RUPKAVV3xXvxIqxOWQDgCJIioWNi/klKTaPy+xVmjeI5jNAtk2QkwNQ==
X-Gm-Gg: ASbGncskElujgp8x2q+qytOrqyDKGq1WJCsj7poyhQZmH04pPt8ciHVQ/KtlyXTSTuE
	CjRjZp/U22NWKZUsfMDQiDGJ7DihzY0x8ZXXjo9Mr4jwLoXQNMS3ob7ZMsD3F+terBjfDcEwfA/
	LFm5X/xDzow8Lq70bUwzPceqSebUO1JZAbMZykVYX/LT1//XrqDZths9UdJzKUsc1VjvP/Ys/Lv
	Yh7qiamiudXPzCiECHDouqKrmlIjWfDkxgABh2wVpmo2vnWU38j7sakKzM1tQJf+xwDgt2nwh/r
	fR/Mqa7tXUdD6RJWHnaLn75kWnJ+80cJ6Y5letnWC6qQrbwxIOdd2ntwPo9huQ4kfhfFU3ux8cA
	ddJZn0F6iQyPxJK0FBaaTxr9tfzMt3HjHlpBNJWVDKw8sBsAtJflRhlAC/YcLOrSlkQ9u80HZkg
	GcgpkIQ5s7gzvw82RMFLJbuzJ0KYBaa5EJYAP6jWky1Mc/mPryUxC9xsYy
X-Google-Smtp-Source: AGHT+IEYJmrjzDT9K864SuCp7sxuJyWWaXrvY1Fk78ny0HD8OrrSO2cVj40cf/XLne/qfT3Stj/vdQ==
X-Received: by 2002:a05:6214:2307:b0:86a:7c95:126f with SMTP id 6a1803df08f44-87c205a72d8mr73592276d6.27.1760734144281;
        Fri, 17 Oct 2025 13:49:04 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028966fasm5125866d6.33.2025.10.17.13.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:49:03 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: john.johansen@canonical.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	wufan@kernel.org,
	mic@digikod.net,
	gnoack@google.com,
	kees@kernel.org,
	mortonm@chromium.org,
	casey@schaufler-ca.com,
	penguin-kernel@I-love.SAKURA.ne.jp,
	nicolas.bouchinet@oss.cyber.gouv.fr,
	xiujianfeng@huawei.com
Subject: [PATCH v5 07/11] lockdown: move initcalls to the LSM framework
Date: Fri, 17 Oct 2025 16:48:21 -0400
Message-ID: <20251017204815.505363-18-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017204815.505363-12-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
 <20251017204815.505363-12-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=890; i=paul@paul-moore.com; h=from:subject; bh=yHHngQpeJUhcXZ8Tk8ygkCfx0smf6LjcNEh85Agei0c=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBo8quiqxWeas4jEgIZPsHE0eeK7NugKpzhvoo9Q HkksUQVL1WJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaPKrogAKCRDqIPLalzeJ c5xvEAC7aR1LlzJJg1z391U47fb3R+GNViN6q6HOIsS5bdJiyQaVKF7rhXe3325zz4ZsTk9mmHd 9cpq0irofr6aDY0huPN75OH/aYcltJB7OZqO2hMKYafg6Desd3hcQAvt5/8XwHd5WjbQvdPPvLQ YI6FU/+TiHmEZFNj1b4BC2MEVBICy78YDAIFR78fSe2il84+XtOQyVNEr4WjmiXE+Qm+tt3uoq8 FnSUyNgB+NWa8Vbwq/3DGjnp659tBrOqTpUJjS+dC2iO4s2jop16uFwpOSNjvrpbwzhtZJFq2SK thD7/XvE2Ht6X5OJs6tFyjqPO22+PqdjigT0tWy51eKcj9KU1O2z7Wj9K7qTlZnuoUNqNAkjnfc xNpF0B2stNrhd0T6smvBJ3a/lgcPyjhFmzgGZaE8Cs0WZ89Lh53VUvFI0t5XpTVicRLwD1gKmCD xiOqGGEzcxqUUSDikJVgCHXriqZqoAAUhsti2F/NHUQTZeoUhSmvi7qRTdE5W/fmNVVfOFBUYrm kEKc19sahbCr8wBOZP7i3J6l18yVNUBH2Ef7Yt3pYH321IKvp7jGkSH3a0fP2wcnGvah8vF4vzN 8Be81CqN5TLKUvjcfzP2vboDi6Z6Ez/DdH792CzdzZY0Dn86Dyrbr7ld2E0E8AZXNl5IqFNhVFL +FYEg8/ZNe1hovg==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
Acked-by: Xiu Jianfeng <xiujianfeng@huawei.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
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
2.51.1.dirty


