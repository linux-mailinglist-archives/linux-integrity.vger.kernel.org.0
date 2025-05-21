Return-Path: <linux-integrity+bounces-6275-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 969DEABF6F3
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 16:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6524716F323
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 14:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC4618EFD1;
	Wed, 21 May 2025 14:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b="VsXppkHj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.nightmared.fr (mail.nightmared.fr [51.158.148.24])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 206AA17B505;
	Wed, 21 May 2025 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.158.148.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747836117; cv=none; b=Qu+3ktn1+ghcmAda4c04KwTDJGNs/Gihd8gSmKsB+rzBsdwx7CFO9+WVL4f89twzDMCd/7tVsCbDfUHMW13ksKwvGkWdIslQU3Sah5PCMRMYTZh2KKp+S55CLckHYtljxKR/PXEY8wSXEZhERR71TJWbglBoMjsoLegGxBGoYTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747836117; c=relaxed/simple;
	bh=CFx8m8+qK2O5c3RmK0fDtyHby/n2rR/M2/EtMuebFdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIv+f5AiZsWGSaE8VzeO/Se9H4zyzDDrB+UntEM1rQ9PP0I3qpkjY35Z3fKBt5cOSp38wsLvpXl2rgWGsMpFThlQ5set9FId2u66pljGEFNcKTa6+vZd9w7Z+Cnnz6BCRZm1kWEDi40Zuyx59OY61ql07qF2SVOHuejVcqpe9L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr; spf=pass smtp.mailfrom=nightmared.fr; dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b=VsXppkHj; arc=none smtp.client-ip=51.158.148.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nightmared.fr
Received: from localhost.localdomain (atoulon-651-1-170-218.w83-113.abo.wanadoo.fr [83.113.65.218])
	by mail.nightmared.fr (Postfix) with ESMTPSA id 0BF451087A4D;
	Wed, 21 May 2025 14:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nightmared.fr;
	s=docker; t=1747836109;
	bh=CFx8m8+qK2O5c3RmK0fDtyHby/n2rR/M2/EtMuebFdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VsXppkHjlG1M0sIi4whWJJsowKxQ2prcVEL9R3NT5x9lRRPTTSKIXqvo17YeMPse6
	 ZDY6aNMscGI9UWD7msQAEY2gOFpQ3y2NNYvwjhlsf3oHiUDrF0/M9HeKKWMoUgoyFh
	 LyzSNALpLFk0Ok0DtzJXBhQSoJ4mbiUmcxmRKKf7kggqaaC6vX/jpVk5YlXxvNebAX
	 wBFTdSe4Kx3iWO/wvsQy4RTO4pvuaQbrZycZwgfwvPa56KmO2CQ11PR71PNrNyfIBk
	 4lfr7oVgrBgbHg6ObTleZ8G69spCDKOUvau5BzUv6WYOoiPHUz8MydCpJdWl3cG57X
	 d9fjVeLl6+vUQ==
From: Simon THOBY <git@nightmared.fr>
To: linux-security-module@vger.kernel.org
Cc: Simon THOBY <git@nightmared.fr>,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [RFC PATCH 8/9] Loadpol LSM: include the blacklisted kernel modules in the policy
Date: Wed, 21 May 2025 16:01:12 +0200
Message-ID: <20250521140121.591482-9-git@nightmared.fr>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250521140121.591482-1-git@nightmared.fr>
References: <20250521140121.591482-1-git@nightmared.fr>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When kernel modules are blacklisted, list them explicitly in the loadpol
policy.

Signed-off-by: Simon THOBY <git@nightmared.fr>
---
 security/loadpol/loadpol.c | 35 ++++++++++++++++++++++++++++++-----
 1 file changed, 30 insertions(+), 5 deletions(-)

diff --git a/security/loadpol/loadpol.c b/security/loadpol/loadpol.c
index 4d1a495a1462..c3c1846a3398 100644
--- a/security/loadpol/loadpol.c
+++ b/security/loadpol/loadpol.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include "linux/array_size.h"
+#include <linux/module.h>
 #include <linux/lsm_hooks.h>
 #include <uapi/linux/lsm.h>
 
@@ -33,12 +34,36 @@ DEFINE_LSM(LOADPOL_NAME) = {
 
 static int __init loadpol_init(void)
 {
+	struct loadpol_policy_entry *entry;
+	char *module_name;
+
+	const char *module_blacklist = get_blacklisted_modules();
+
+	if (module_blacklist) {
+		size_t len;
+
+		for (const char *p = module_blacklist; *p; p += len) {
+			len = strcspn(p, ",");
+
+			module_name = kstrndup(p, len, GFP_KERNEL);
+			entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+			if (!module_name || !entry)
+				return -ENOMEM;
+
+			entry->origin = (ORIGIN_USERSPACE | ORIGIN_KERNEL);
+			entry->action = ACTION_DENY;
+			entry->module_name = module_name;
+			list_add_tail(&entry->list, loadpol_policy);
+
+			if (p[len] == ',')
+				len++;
+		}
+	}
+
 	for (int i = 0; i < ARRAY_SIZE(default_policy_entries); i++) {
-		struct loadpol_policy_entry *entry = kmemdup(
-			&default_policy_entries[i],
-			sizeof(struct loadpol_policy_entry),
-			GFP_KERNEL
-		);
+		entry = kmemdup(&default_policy_entries[i],
+				sizeof(struct loadpol_policy_entry),
+				GFP_KERNEL);
 		if (!entry)
 			return -ENOMEM;
 
-- 
2.49.0


