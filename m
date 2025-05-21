Return-Path: <linux-integrity+bounces-6273-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1529AABF6F9
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 16:02:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89A2418952E6
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 14:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40A418D643;
	Wed, 21 May 2025 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b="LnX3c0Rw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.nightmared.fr (mail.nightmared.fr [51.158.148.24])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2066417A309;
	Wed, 21 May 2025 14:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.158.148.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747836116; cv=none; b=aYBnMjbgqqlrF8f55vNLO6IZItEdQBJPRatJEcv5B4EhIP/9OO3Fm+FN6J/8ydbREwx7nLWEEiaQa8jVOBHieZRkHHK+L2va7FtKRfywcdmEnrlbctbU53SObE9JGnCDzQxjP/4heeYwH2SwRCGPcrZdL8CYgs50hgvY5qtIMMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747836116; c=relaxed/simple;
	bh=JvZv+5sKjWcEgjgYX1g5O1upGZhajlfkv5y/F1DWRcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JNtbFuSWZ+qpUoQgahPTPrwtKphQoaQiEU/LaJiHCei0hEJ1OcGZFjUMKKhAE4FujylB+0rknzAmIDe7ajMvBv6nSha/0/x3iZ5zGhIDedirDL0eh/RA+bJ6nye0rYirK+jgpyxDKo5nTcvVrb/7K/ksyZLvWASs7p5QF3D3Npw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr; spf=pass smtp.mailfrom=nightmared.fr; dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b=LnX3c0Rw; arc=none smtp.client-ip=51.158.148.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nightmared.fr
Received: from localhost.localdomain (atoulon-651-1-170-218.w83-113.abo.wanadoo.fr [83.113.65.218])
	by mail.nightmared.fr (Postfix) with ESMTPSA id B824A1087A46;
	Wed, 21 May 2025 14:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nightmared.fr;
	s=docker; t=1747836108;
	bh=JvZv+5sKjWcEgjgYX1g5O1upGZhajlfkv5y/F1DWRcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LnX3c0RwFlUeM2rku6fW/3JMtpwy3/P30iQ7YkBH8Sk8a0GlBJgI6X/hnIN/WX6I0
	 MdCfcp/YGSMcuJCaVKzBen2ySV9cBzwp7bG3PDua+zaqQahVTWmNRppSfBmfRtOtpo
	 aQEBuDEywBQMWCDzB0fC0fSSP4fJtGZRmjvYzL6zlqaH1wezOUjlCE05QDkA5vY1ez
	 RuSqtLOcGHidHOVncixZVOFPSNODOJw4Zp0NSvNkkY1Sy2e2NU2NywIdwj9U+t9um4
	 7eOsx2SDWgh2N/8q6jyTNRZR+50UzPzisVYZr+kFEvFCkONNRx+m0CC3YwupjCwHV0
	 7t17tlCuJdJvg==
From: Simon THOBY <git@nightmared.fr>
To: linux-security-module@vger.kernel.org
Cc: Simon THOBY <git@nightmared.fr>,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [RFC PATCH 7/9] module: expose the list of blacklisted modules
Date: Wed, 21 May 2025 16:01:11 +0200
Message-ID: <20250521140121.591482-8-git@nightmared.fr>
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

Other kernel components (e.g. the Loadpol LSM) may need to access the
modules blacklist.

Signed-off-by: Simon THOBY <git@nightmared.fr>
---
 include/linux/module.h | 3 +++
 kernel/module/main.c   | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/include/linux/module.h b/include/linux/module.h
index b6b8d6f7f599..2ef50d81dc8d 100644
--- a/include/linux/module.h
+++ b/include/linux/module.h
@@ -781,6 +781,9 @@ void set_module_sig_enforced(void);
 
 void module_for_each_mod(int(*func)(struct module *mod, void *data), void *data);
 
+/* return a comma-separated list of blacklisted kernel modules */
+const char *get_blacklisted_modules(void);
+
 #else /* !CONFIG_MODULES... */
 
 static inline struct module *__module_address(unsigned long addr)
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 12a1a5f4d823..8f0afbc57df7 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -2765,6 +2765,11 @@ static bool blacklisted(const char *module_name)
 }
 core_param(module_blacklist, module_blacklist, charp, 0400);
 
+const char *get_blacklisted_modules(void)
+{
+	return module_blacklist;
+}
+
 static struct module *layout_and_allocate(struct load_info *info, int flags)
 {
 	struct module *mod;
-- 
2.49.0


