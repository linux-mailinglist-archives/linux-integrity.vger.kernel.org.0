Return-Path: <linux-integrity+bounces-6069-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1A9AA3D4F
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 01:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69F5F7B2435
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Apr 2025 23:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A378272773;
	Tue, 29 Apr 2025 23:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7AKq4d7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4217227276D;
	Tue, 29 Apr 2025 23:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970655; cv=none; b=A3tg7OeHHvbhcMOAJ9ayC0fmMvHTFhQ9YfxBLMxRhDt07Sp7gEmvMknxVnnSz1gqJkbVGcNZxF9Fzsf6NiT6LtMg7zWXnb+jcbQG2/jr05uR4A+pDECvkimGpWrXOJfCYm0LGlJ7U4IrrX/9spc997r/379EeTpAY4xSMbNH84s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970655; c=relaxed/simple;
	bh=41ABFjClMBGA0nWlECmrZkLAQRu/08sJgg9YS19HDHI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dyf8pdm3tJfvn0qruDBAhZIRSwIrNIqc32lP7c+IHwt5IvKfrGjycmkREV4jtaE/NOWHkBgh7oU4p9APZoSYUEXfxWILCbU4MNs7r44njZ4qHKPdyXtZbj4wzxdvDb+79jeJx+8+B7V7A9/xa+VvWs1HFu6RTy2bN4L0Op39bY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7AKq4d7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0A4C4CEED;
	Tue, 29 Apr 2025 23:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970654;
	bh=41ABFjClMBGA0nWlECmrZkLAQRu/08sJgg9YS19HDHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l7AKq4d7kSsUoEn74CZ8OjHL9AVwzhFNu1ItjPLBBIl7EI4nt4o+VUncNFiGPVpHV
	 8R5E/fM/Dvngh5WHAa7quTLnBC3pnGAvIJdE6KH9hxdazkrrYkav1tcLtODtWSjG0g
	 HYJ8uRGA/KCpSBLSYrvScminuyCCxbMRkEwo7Oj9jNZJpMmNlxrshYeMDqoa2Dq10w
	 HGshN2hSsH3NPKfnypPqWfSXpW+N4fjpTduXpSt+smIzitfYBnAzLfsaBtv9lL5Irt
	 mAOFfioiDMRz++MqDS2lhlXXrbMzh8nW7nYoh/ErnN+TkrsXA9ocj5Ef5GB6gNhDpe
	 LDljevX0apWCw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frederick Lawler <fred@cloudflare.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	dmitry.kasatkin@gmail.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 25/39] ima: process_measurement() needlessly takes inode_lock() on MAY_READ
Date: Tue, 29 Apr 2025 19:49:52 -0400
Message-Id: <20250429235006.536648-25-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235006.536648-1-sashal@kernel.org>
References: <20250429235006.536648-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.4
Content-Transfer-Encoding: 8bit

From: Frederick Lawler <fred@cloudflare.com>

[ Upstream commit 30d68cb0c37ebe2dc63aa1d46a28b9163e61caa2 ]

On IMA policy update, if a measure rule exists in the policy,
IMA_MEASURE is set for ima_policy_flags which makes the violation_check
variable always true. Coupled with a no-action on MAY_READ for a
FILE_CHECK call, we're always taking the inode_lock().

This becomes a performance problem for extremely heavy read-only workloads.
Therefore, prevent this only in the case there's no action to be taken.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
Acked-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/integrity/ima/ima_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f3e7ac513db3f..f99ab1a3b0f09 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -245,7 +245,9 @@ static int process_measurement(struct file *file, const struct cred *cred,
 				&allowed_algos);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK ||
 			    func == MMAP_CHECK_REQPROT) &&
-			   (ima_policy_flag & IMA_MEASURE));
+			   (ima_policy_flag & IMA_MEASURE) &&
+			   ((action & IMA_MEASURE) ||
+			    (file->f_mode & FMODE_WRITE)));
 	if (!action && !violation_check)
 		return 0;
 
-- 
2.39.5


