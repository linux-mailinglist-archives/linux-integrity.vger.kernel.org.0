Return-Path: <linux-integrity+bounces-6190-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CEC6AB5731
	for <lists+linux-integrity@lfdr.de>; Tue, 13 May 2025 16:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7B343A477E
	for <lists+linux-integrity@lfdr.de>; Tue, 13 May 2025 14:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0270195B37;
	Tue, 13 May 2025 14:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="OSMGaQmM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45549482F2;
	Tue, 13 May 2025 14:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747146701; cv=none; b=Q/6REiL+35TNeQJsyUCnL2GeMRlqEjOwNfYDx/kEHd1+HM4qSeqihnjUqkto+uYMQ/D8bSihkEOsVzHFIG+lfbELdR+kV4kgVO3IijvMCMPWxlTYR5sX3ZjRnh/yryS06/hkbHAlLiknlayTZu9ahiUrctb4t+nJqBA/700GQhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747146701; c=relaxed/simple;
	bh=9K09BHnQCAoVS9IR8GUictDs7Daxob0pge7qSfIwLxQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GeS7wbZ8Doz2KIaYIBlFsOLjVZ5Xjrq5tmKIr/4XIr9HAy7ZnXFfeqnBGFoOo1NA897Qdi+YVa7cVfsfO5+n9X7BwObM1l7gGVZ6X7Rukf7eIlrZEi82bsAi4W6023aIwlAkb1bPkLmOkIOKXSZ9kipx1HNG5kxnNnw72Sx6TZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=OSMGaQmM; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from DESKTOP-VOT081N.hsd1.ga.comcast.net (unknown [20.110.218.7])
	by linux.microsoft.com (Postfix) with ESMTPSA id DEAB3201DB25;
	Tue, 13 May 2025 07:31:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DEAB3201DB25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1747146699;
	bh=CrG5JCMO4jYURJHK9ELmzS8KkDxV+BeLbEnzcZyD8y8=;
	h=From:To:Cc:Subject:Date:From;
	b=OSMGaQmM5SwvZO3A1bwH2mUdhDs/VhcR0TgRB6kul68ZhUrtKwLxKU5ZpLGEdqvKE
	 GvFZ0bzAmSYhqg0GN/fisk0jkE5eRn6yVFGNw1fwrPPzDHUZPKuoJkl/H9HpgSsjuC
	 9Ls8Ot60JbL8UcoHNGs8PYZpm5zN8kiteKH/ctG8=
From: steven chen <chenste@linux.microsoft.com>
To: zohar@linux.ibm.com,
	stefanb@linux.ibm.com,
	roberto.sassu@huaweicloud.com,
	roberto.sassu@huawei.com,
	eric.snowberg@oracle.com,
	ebiederm@xmission.com,
	paul@paul-moore.com,
	code@tyhicks.com,
	bauermann@kolabnow.com,
	linux-integrity@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: madvenka@linux.microsoft.com,
	nramas@linux.microsoft.com,
	James.Bottomley@HansenPartnership.com,
	bhe@redhat.com
Subject: [PATCH V2] ima: do not copy measurement list to kdump kernel
Date: Tue, 13 May 2025 07:31:29 -0700
Message-ID: <20250513143129.1165-1-chenste@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Steven Chen <chenste@linux.microsoft.com>

Kdump kernel doesn't need IMA to do integrity measurement.
Hence the measurement list in 1st kernel doesn't need to be copied to
kdump kernel.

Here skip allocating buffer for measurement list copying if loading
kdump kernel. Then there won't be the later handling related to
ima_kexec_buffer.

Signed-off-by: Steven Chen <chenste@linux.microsoft.com>
Tested-by: Baoquan He <bhe@redhat.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
V1 - https://lore.kernel.org/all/20250502200337.6293-1-chenste@linux.microsoft.com/
V2 - Incorporated feedback from the community (Baoquan He and Mimi Zohar) on v1

 security/integrity/ima/ima_kexec.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/security/integrity/ima/ima_kexec.c b/security/integrity/ima/ima_kexec.c
index 38cb2500f4c3..7362f68f2d8b 100644
--- a/security/integrity/ima/ima_kexec.c
+++ b/security/integrity/ima/ima_kexec.c
@@ -146,6 +146,9 @@ void ima_add_kexec_buffer(struct kimage *image)
 	void *kexec_buffer = NULL;
 	int ret;
 
+	if (image->type == KEXEC_TYPE_CRASH)
+		return;
+
 	/*
 	 * Reserve extra memory for measurements added during kexec.
 	 */
-- 
2.43.0


