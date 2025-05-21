Return-Path: <linux-integrity+bounces-6271-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB72ABF6F7
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 16:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 909BA3B8148
	for <lists+linux-integrity@lfdr.de>; Wed, 21 May 2025 14:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80585189513;
	Wed, 21 May 2025 14:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b="EOPPLhyU"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail.nightmared.fr (mail.nightmared.fr [51.158.148.24])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC6170830;
	Wed, 21 May 2025 14:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.158.148.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747836115; cv=none; b=imEdaKvF06KpDBUVSAMMULYZo2GafmMftytFfs6yY2Oe82WI5ZclqTaXOBVNun3kYlgMI3mBfwhx27EwKpyU6DbBfuV/RasAgfaVVT8jiopIUKJKwYI1TZmnh0Cu8gOQtRZgzFnLnHv7Sh4kE2mdlqwbQKlP0TPhiw7ySxlwgn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747836115; c=relaxed/simple;
	bh=PORCLUTtbHg0liQ9+fwRmNNkrW0epbHx7vY+INFzv64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qjEldgZREOEzAg56yWj0D2ytHbSutj2P2E2RwK99vZPU9Rq6Kb21YuHZdoVlskjYCwEPALkp3oCRbYnpmWqTPM8OYhvdL7dusrhigWxLLNtCHfwcnP/R8Y0Xit+0dwVd3wlwSXQdfNmdwrWyhN/VnQmqUfI8Wfx7U9Kf0rVLNZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr; spf=pass smtp.mailfrom=nightmared.fr; dkim=pass (2048-bit key) header.d=nightmared.fr header.i=@nightmared.fr header.b=EOPPLhyU; arc=none smtp.client-ip=51.158.148.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nightmared.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nightmared.fr
Received: from localhost.localdomain (atoulon-651-1-170-218.w83-113.abo.wanadoo.fr [83.113.65.218])
	by mail.nightmared.fr (Postfix) with ESMTPSA id 17F881087A48;
	Wed, 21 May 2025 14:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nightmared.fr;
	s=docker; t=1747836108;
	bh=PORCLUTtbHg0liQ9+fwRmNNkrW0epbHx7vY+INFzv64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EOPPLhyUiIgYSE0j7BAjBsijWBM33boD5aT7KGveroR2XRNo8ApDjMWfh8djHBHgD
	 uBQgxjM3DTsMg+r7s0LY69kGlgNVp41DnJlVX7qs77jwuYgaMbqC8+sYtkDPmuykYT
	 0fLBPgTwuneo8SJi+DSQqWI59LszzZAJen/tyKh96WOkTGnvC1qjIe5SmYNBLiyhhk
	 bjJcIp6RWJb67IDjkOJUKscQ9oQ6OAIlmLGpC0r2NrnKqefIQQzfaCC3mex9OuTQwM
	 p3Z08XQqlxdth2eNTqA7btEPitKWER6IoV3WcNecg9DFL6/1onTI9PKdUCb3RH84YI
	 2XXNEK6jv0Vmw==
From: Simon THOBY <git@nightmared.fr>
To: linux-security-module@vger.kernel.org
Cc: Simon THOBY <git@nightmared.fr>,
	linux-integrity@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [RFC PATCH 5/9] Loadpol LSM: add a sysctl to lock the policy
Date: Wed, 21 May 2025 16:01:09 +0200
Message-ID: <20250521140121.591482-6-git@nightmared.fr>
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

Once the policy is properly configurd, users may want to lock that
policy to ensure no future change can be applied to it.

Add a sysctl that can be toggled to lock the policy.

Signed-off-by: Simon THOBY <git@nightmared.fr>
---
 security/loadpol/loadpol_fs.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/security/loadpol/loadpol_fs.c b/security/loadpol/loadpol_fs.c
index 9134d11718a0..1fec94de9f40 100644
--- a/security/loadpol/loadpol_fs.c
+++ b/security/loadpol/loadpol_fs.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
 #include "linux/array_size.h"
+#include <linux/sysctl.h>
 #include <linux/security.h>
 
 #include "loadpol.h"
@@ -8,8 +9,22 @@
 static struct dentry *securityfs_dir;
 static struct dentry *securityfs_policy;
 
+static bool policy_locked;
 static DEFINE_MUTEX(policy_write_mutex);
 
+static const struct ctl_table sysctls[] = {
+	{
+		.procname	= "locked",
+		.data		= &policy_locked,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		/* only allow a transition from 0 (not locked) to 1 (locked) */
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ONE,
+		.extra2		= SYSCTL_ONE,
+	},
+};
+
 static const struct seq_operations loadpol_policy_seqops = {
 	.start = loadpol_policy_start,
 	.next = loadpol_policy_next,
@@ -33,6 +48,13 @@ static ssize_t loadpol_write_policy(struct file *file, const char __user *buf,
 	char *data;
 	ssize_t ret;
 
+	/* Once the policy is locked, modifications are blocked */
+	if (policy_locked) {
+		pr_warn("Loadpol is locked, the policy cannot be modified");
+		ret = -EPERM;
+		goto out;
+	}
+
 	/*
 	 * arbitrary size limit (to prevent a DoS but still allow loading a policy with a few
 	 * thousands of entries)
@@ -81,8 +103,15 @@ static const struct file_operations loadpol_policy_ops = {
 
 static int __init loadpol_init_fs(void)
 {
+	struct ctl_table_header *sysctl_hdr = NULL;
 	int ret;
 
+	sysctl_hdr = register_sysctl_sz("security/" LOADPOL_NAME, sysctls, ARRAY_SIZE(sysctls));
+	if (IS_ERR(sysctl_hdr)) {
+		ret = PTR_ERR(sysctl_hdr);
+		goto err;
+	}
+
 	securityfs_dir = securityfs_create_dir(LOADPOL_NAME, NULL);
 	if (IS_ERR(securityfs_dir)) {
 		ret = PTR_ERR(securityfs_dir);
@@ -99,6 +128,8 @@ static int __init loadpol_init_fs(void)
 
 	return 0;
 err:
+	if (!IS_ERR(sysctl_hdr))
+		unregister_sysctl_table(sysctl_hdr);
 	securityfs_remove(securityfs_policy);
 	securityfs_remove(securityfs_dir);
 	return ret;
-- 
2.49.0


