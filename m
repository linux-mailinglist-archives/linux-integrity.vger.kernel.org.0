Return-Path: <linux-integrity+bounces-7279-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C1FBA1FD7
	for <lists+linux-integrity@lfdr.de>; Fri, 26 Sep 2025 01:45:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B6A41C044C3
	for <lists+linux-integrity@lfdr.de>; Thu, 25 Sep 2025 23:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34EE2ED15F;
	Thu, 25 Sep 2025 23:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FVBmFKgR"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D099B74420
	for <linux-integrity@vger.kernel.org>; Thu, 25 Sep 2025 23:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758843925; cv=none; b=rgHv6QOwjaaGrHD+bhSVX4EWSFY9mmhZ8OCOr0djZdnmA8vFykZQVMEPCAHEGxRiGMMrik+o0oIoddRdZC/6j8fJ3BBGpw3zV872eSacuMbu9eB9SG12rpefKRNioUMeKQTSZGHA4ULGfNbfdeVyF7Vd/kwpaunihqVHcH5JhTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758843925; c=relaxed/simple;
	bh=qnzcSqkrw05lFjyonOVGGDH1fyI94qn3kHI5lWyeGfs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jj0+DzhI5MSbSoHtdPmu+ljZp8cvm4P9OnweSgQZuu44QxgedcueHm+RC+tZrrR2lNYY7ON9ggatUJDAPCY2QsuhIimNEzXegcxOIlljXUxkrNCA79vGHf2LnZisJZ82Bs8WVvmy4YoK4GzdHsWDaEOpkhade+G7eSY+Rw0ICnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FVBmFKgR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-46e32c0e273so15405e9.1
        for <linux-integrity@vger.kernel.org>; Thu, 25 Sep 2025 16:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1758843922; x=1759448722; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k+/60p2igLHxhXduVxBRgrzlVIOHLKXxhij7umLu7HU=;
        b=FVBmFKgRSiWKavs2FK96pagDgBR8GumPp2+fIA8XIZLeZPfVIePvH5Rh/PVP5x8BJw
         Ynu5PduS16zDXWaqrAne10hoA3xYNg3WzQ6JpY1D9nXe2VgPZ3VE3OKiLDf8GSrM8deq
         jIuI4vdBDLsvX9tVR+5vYQTHvsHztb0m17LszZn8Qq2mykvOmz79ijXophDnKHGU6q72
         XT0l0qxonGCsJIl/beLXB9rRAsWqn6a9CvL+Pnxejz2zRFSvwEXdhF23u5oWeGsPI2qQ
         rvrS+fjfLlXFDVsS9McT9KNk/Jrkq7sd3ufIU/linVb7UInLmM0IuVBeu6IUgH2Fb+6Q
         LCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758843922; x=1759448722;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k+/60p2igLHxhXduVxBRgrzlVIOHLKXxhij7umLu7HU=;
        b=cLfWB2xqSN3AvRV8zsBFJaKJjCFQcFr52bO0cnINl+tD0LpB739vhlA7/6/zfbo65q
         4Mwliw8aZesdoTDinYXTBdDiSKvSw0pHZDuYmCZ52O37SYwr1TRaPTmd2DTw31OJpDGa
         mAQNsHUFp/3F5GBXAlzAzp3OXEA8iaCAVHs5cj4EDHkhWloWqBDlV2WHEdtusSbYtY63
         1wK/oDtEYrDkoWi/hvgp6KsUSdVLrAj+47KSNZLhxMwLG7axNXZ3Sgcax1zolQTQXasg
         iHTkKGIf5h0qEzOF3fDx5BTPgSgptQtd03BhRTavOTdKON0RGkRoE9aB5onPOTZLRmeb
         d+9w==
X-Forwarded-Encrypted: i=1; AJvYcCVCbf6QuFjhNSCk8JqmbaSw1Xt5HMtbDvTOwoR7jNTbXERfqepjvWLpNVM4Bt8HDmbBkTJIv/X3cz3Jp6xrkKQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YykA0biYZS8VxMERu7I/dK26xYFnUmv5MaagE8e6wcwsbVqMBc+
	gAj/1eEZfrk3S5q3v5FnV+RjPlkpIf4JJ67qbXauHAfD4+Uj5hCxp/BnzWKRswtNPg==
X-Gm-Gg: ASbGncvBYrMJBi0ABLLmbPJ0PZDcLEYYqvGKTpToPg1aQMgXeYlb2JmcSeg7iD/Gbo5
	UB2icYGg0G3wYSBPoU3xJ4oNXNwm7jaM5HmzhGtT9fVjaHNq+vlN2zdFB5Ano9+ylUq6JcimAfD
	9Rc+xYzqUCcIVqHcNm2wm9L1lL/mgvv2edEnbdxW1+Oq8A5X1nudfGEysCFSFHA2oSRXW+Kkelv
	c5yLKSlubMy8UUtbzryxNkzeNum/lDumBnAkstmCmH+he5GPfCezPkgSdlLE81zdyosDy1RohSd
	5F84o7xTZAqQCwVE+R/fw+IQcw4mWYUzNcUJrA5bP+JR83QikG0Yn18w2UFhzzGoMHFKyHa6XK4
	Yml+vJDRAA93kdCdLgmQ/fpgBBDc=
X-Google-Smtp-Source: AGHT+IEI1KfavPKBZUkfMpl0ut11FyDudWgx4jPvjefzfrIyZcrrL6+wiJ9w8Z8vTR/+ZXY7evgJfw==
X-Received: by 2002:a05:600c:c112:b0:45a:2861:3625 with SMTP id 5b1f17b1804b1-46e3b014890mr435905e9.4.1758843921935;
        Thu, 25 Sep 2025 16:45:21 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:802b:ac1b:7bf0:4c9a])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-40fc88b0779sm4547044f8f.58.2025.09.25.16.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 16:45:21 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Fri, 26 Sep 2025 01:45:06 +0200
Subject: [PATCH 1/2] ima: add dont_audit action to suppress audit actions
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250926-ima-audit-v1-1-64d75fdc8fdc@google.com>
References: <20250926-ima-audit-v1-0-64d75fdc8fdc@google.com>
In-Reply-To: <20250926-ima-audit-v1-0-64d75fdc8fdc@google.com>
To: Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, 
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
 Eric Snowberg <eric.snowberg@oracle.com>
Cc: Frank Dinoff <fdinoff@google.com>, linux-kernel@vger.kernel.org, 
 linux-integrity@vger.kernel.org, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758843915; l=3033;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=qnzcSqkrw05lFjyonOVGGDH1fyI94qn3kHI5lWyeGfs=;
 b=WpV3JAso+B4JtzmfkpfNA6IW1wg12HJNMo/QnUy96JxFE53vQ9eNMALgdy1bT0bXMVr2BW2ZV
 wsPqi/reRJdCOjebvufGVMmZ9JHjorJ6xo4ejdgDnRMzlgtJ0RNJYVq
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

"measure", "appraise" and "hash" actions all have corresponding "dont_*"
actions, but "audit" currently lacks that. This means it is not
currently possible to have a policy that audits everything by default,
but excludes specific cases.

This seems to have been an oversight back when the "audit" action was
added.

Add a corresponding "dont_audit" action to enable such uses.

Signed-off-by: Jann Horn <jannh@google.com>
---
 Documentation/ABI/testing/ima_policy |  2 +-
 security/integrity/ima/ima_policy.c  | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/ima_policy b/Documentation/ABI/testing/ima_policy
index c2385183826c..5d548dd2c6e7 100644
--- a/Documentation/ABI/testing/ima_policy
+++ b/Documentation/ABI/testing/ima_policy
@@ -20,7 +20,7 @@ Description:
 		  rule format: action [condition ...]
 
 		  action: measure | dont_measure | appraise | dont_appraise |
-			  audit | hash | dont_hash
+			  audit | dont_audit | hash | dont_hash
 		  condition:= base | lsm  [option]
 			base:	[[func=] [mask=] [fsmagic=] [fsuuid=] [fsname=]
 				[uid=] [euid=] [gid=] [egid=]
diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 128fab897930..c5bad3a0c43a 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -45,6 +45,7 @@
 #define APPRAISE	0x0004	/* same as IMA_APPRAISE */
 #define DONT_APPRAISE	0x0008
 #define AUDIT		0x0040
+#define DONT_AUDIT	0x0080
 #define HASH		0x0100
 #define DONT_HASH	0x0200
 
@@ -1064,7 +1065,7 @@ void ima_update_policy(void)
 enum policy_opt {
 	Opt_measure, Opt_dont_measure,
 	Opt_appraise, Opt_dont_appraise,
-	Opt_audit, Opt_hash, Opt_dont_hash,
+	Opt_audit, Opt_dont_audit, Opt_hash, Opt_dont_hash,
 	Opt_obj_user, Opt_obj_role, Opt_obj_type,
 	Opt_subj_user, Opt_subj_role, Opt_subj_type,
 	Opt_func, Opt_mask, Opt_fsmagic, Opt_fsname, Opt_fsuuid,
@@ -1086,6 +1087,7 @@ static const match_table_t policy_tokens = {
 	{Opt_appraise, "appraise"},
 	{Opt_dont_appraise, "dont_appraise"},
 	{Opt_audit, "audit"},
+	{Opt_dont_audit, "dont_audit"},
 	{Opt_hash, "hash"},
 	{Opt_dont_hash, "dont_hash"},
 	{Opt_obj_user, "obj_user=%s"},
@@ -1478,6 +1480,14 @@ static int ima_parse_rule(char *rule, struct ima_rule_entry *entry)
 
 			entry->action = AUDIT;
 			break;
+		case Opt_dont_audit:
+			ima_log_string(ab, "action", "dont_audit");
+
+			if (entry->action != UNKNOWN)
+				result = -EINVAL;
+
+			entry->action = DONT_AUDIT;
+			break;
 		case Opt_hash:
 			ima_log_string(ab, "action", "hash");
 
@@ -2097,6 +2107,8 @@ int ima_policy_show(struct seq_file *m, void *v)
 		seq_puts(m, pt(Opt_dont_appraise));
 	if (entry->action & AUDIT)
 		seq_puts(m, pt(Opt_audit));
+	if (entry->action & DONT_AUDIT)
+		seq_puts(m, pt(Opt_dont_audit));
 	if (entry->action & HASH)
 		seq_puts(m, pt(Opt_hash));
 	if (entry->action & DONT_HASH)

-- 
2.51.0.536.g15c5d4f767-goog


