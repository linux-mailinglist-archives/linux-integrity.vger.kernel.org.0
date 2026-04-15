Return-Path: <linux-integrity+bounces-9194-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8NVZOmJn32lSSgAAu9opvQ
	(envelope-from <linux-integrity+bounces-9194-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 12:24:34 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F228F4033D3
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 12:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1A04B300600D
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Apr 2026 10:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D2B31AF24;
	Wed, 15 Apr 2026 10:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="CZfQtgjl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E884329E6A;
	Wed, 15 Apr 2026 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776248668; cv=none; b=sUIELwR9oEqc4U1jj5HJtfC2xP+q4PaxT5lvHR+FWfH5Ycz6+Gk1WBooW5RBLvaKHIOOxEkFcAOD8CHtKPThXW8Z2EVNLhva2E2I493g8gFbgZsu9dtsrf+N8FIWO0YKDsSy89CCwLNNvrbZKs7dnD4UlZVW6JfABSplyxBK62s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776248668; c=relaxed/simple;
	bh=X8MTe7N3re8Sqge6R+Ni6U6JM6fHYLzny2opo5dpi+0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ikI0j71FrtdzTU6wmL99DO16kJHqQI6zbaaikyJRk/3xcuHwWIttgaDJGe4T8TqMQgYUmH+Go4XSM++l8n5YDAEKRBjJHotiLgWfOeDzsbq7q4ZGLrYyoYvaW++W6QcjIkZCFJ4Dt8iTQosj4gRQjzYY8YajyfsgegUxOVlt/jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=CZfQtgjl; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=eA
	ynssCax413IIMCRY32MI0qtNfH4VfXY4d4ozuSCq0=; b=CZfQtgjl6Ws0tFlu7j
	paxhs//rTrqxD7Fyl8scP6VZo7Zw+ylAahGViQP4i4Hk8Y89NezaPQKcwHVeWWV+
	fRjCkFC5+JcKQj+Jzv/W5vZMSYgF2k0zb7W+jppzzWRfLpcVQaBni6D3SIp9PkbD
	9UoAQXeQB4/QBuiYQjET7uVEA=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3OGYYZ99pzEBbFA--.60597S2;
	Wed, 15 Apr 2026 18:23:22 +0800 (CST)
From: Chi Wang <wangchi05@163.com>
To: zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chi Wang <wangchi@kylinos.cn>
Subject: [PATCH] ima: Use KEXEC_SIG_FORCE for rejecting unsigned kexec images
Date: Wed, 15 Apr 2026 18:23:19 +0800
Message-Id: <20260415102319.431379-1-wangchi05@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3OGYYZ99pzEBbFA--.60597S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZryUXFWrtFy7uF1kZw43Jrb_yoW8Jw4fpa
	1DtFyxtry5XF1j9w4kGa429FWrW397GrWUWa1Dta48tFs5JF1kXryDJw17uF13KFyYq3W0
	y3sFy345Ca1qvFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbAwsUUUUU=
X-CM-SenderInfo: 5zdqwulklqkqqrwthudrp/xtbC-hoyVWnfZxqxQQAA34
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[163.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[163.com:s=s110527];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com];
	TAGGED_FROM(0.00)[bounces-9194-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[163.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wangchi05@163.com,linux-integrity@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[163.com:+];
	NEURAL_HAM(-0.00)[-0.996];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F228F4033D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Chi Wang <wangchi@kylinos.cn>

Following the split of KEXEC_VERIFY_SIG into KEXEC_SIG and KEXEC_SIG_FORCE,
only KEXEC_SIG_FORCE indicates that unsigned kernel images must be rejected.
KEXEC_SIG alone enables signature verification but permits unsigned images,
so it should not trigger the IMA appraisal denial for kexec_load.

Update the condition in ima_load_data() to check for KEXEC_SIG_FORCE
instead of KEXEC_SIG.

Fixes: 99d5cadfde2b ("kexec_file: split KEXEC_VERIFY_SIG into KEXEC_SIG and KEXEC_SIG_FORCE")

Signed-off-by: Chi Wang <wangchi@kylinos.cn>
---
 security/integrity/ima/ima_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 1d6229b156fb..ec70e78ab8cd 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -953,7 +953,7 @@ static int ima_load_data(enum kernel_load_data_id id, bool contents)

 	switch (id) {
 	case LOADING_KEXEC_IMAGE:
-		if (IS_ENABLED(CONFIG_KEXEC_SIG)
+		if (IS_ENABLED(CONFIG_KEXEC_SIG_FORCE)
 		    && arch_ima_get_secureboot()) {
 			pr_err("impossible to appraise a kernel image without a file descriptor; try using kexec_file_load syscall.\n");
 			return -EACCES;
--
2.25.1


