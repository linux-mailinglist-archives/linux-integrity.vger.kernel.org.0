Return-Path: <linux-integrity+bounces-3461-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F34C96DE0E
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Sep 2024 17:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8A54CB25C29
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Sep 2024 15:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB7319D060;
	Thu,  5 Sep 2024 15:26:25 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0960C7F7FC;
	Thu,  5 Sep 2024 15:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725549985; cv=none; b=TcMPLCFVI0Bd0JJlVBY82b3hXB+F1Con0/g8yCQ4pR1h5hoWHpFZ3TYsXewUh0ZV8Y4kAKFCNI4B9BW4u2waQ5r00J2L6p9UdwMa6QPW4elIr147UqFueGKzvEDW8kVU7rXu6tj0sqbyzSZW6z1+pt4zTsCxFNReZilpggQwAJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725549985; c=relaxed/simple;
	bh=2gDqI6Rt3WKkG11Zo++GHx33QkYLkbEFQr9IeeDnNSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Juu2fl3DETuVBvv8dPZ4NvqM+lpyiyzt1Ps9iIrJb21SmCAShxq5bBY8OwbOzo3Vvffy5eUMU6Os2OJizImxPvaSAT1YPkFaUYcNB4Uf4jUqWXTa7rZX5lS192S6c4jEz3paClaQd53Dj/+BIujrNS3CeTgUdfxVjNe04au2oN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4X02l74S7Qz9v7NK;
	Thu,  5 Sep 2024 23:06:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id CEAD7140A0E;
	Thu,  5 Sep 2024 23:26:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDXGjJrzdlmK4RUAA--.19788S4;
	Thu, 05 Sep 2024 16:26:09 +0100 (CET)
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: corbet@lwn.net,
	zohar@linux.ibm.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com
Cc: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	wufan@linux.microsoft.com,
	pbrobinson@gmail.com,
	zbyszek@in.waw.pl,
	hch@lst.de,
	mjg59@srcf.ucam.org,
	pmatilai@redhat.com,
	jannh@google.com,
	dhowells@redhat.com,
	jikos@kernel.org,
	mkoutny@suse.com,
	ppavlu@suse.com,
	petr.vorel@gmail.com,
	mzerqung@0pointer.de,
	kgold@linux.ibm.com,
	Roberto Sassu <roberto.sassu@huawei.com>
Subject: [RFC][PATCH v3 02/10] ima: Nest iint mutex for DIGEST_LIST_CHECK hook
Date: Thu,  5 Sep 2024 17:25:04 +0200
Message-Id: <20240905152512.3781098-3-roberto.sassu@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240905152512.3781098-1-roberto.sassu@huaweicloud.com>
References: <20240905152512.3781098-1-roberto.sassu@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:LxC2BwDXGjJrzdlmK4RUAA--.19788S4
X-Coremail-Antispam: 1UD129KBjvJXoW7ZrW7tw1rJF4fZFW3CrWDtwb_yoW8Ww1rpa
	9Ik3WUGrykuFyI9rs8Ca12vFWrK398WFWUuan8Ja4UAF47Ar1qqry7Gry2gryrGrWrAwnx
	tr1qgws5Cw4jyFJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPab4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW8JVW5JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ew
	Av7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY
	6r1j6r4UM4x0Y48IcxkI7VAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14
	v26rWY6Fy7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8C
	rVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXw
	CIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxV
	W8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26F4UJVW0obIYCTnIWIevJa73UjIFyTuYvjxU
	VBMNUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQARBGbZE3MLPwAFs6

From: Roberto Sassu <roberto.sassu@huawei.com>

Invoking digest_cache_get() inside the iint->mutex critical region can
cause deadlocks due to the fact that IMA can be recursively invoked for
reading the digest list. The deadlock would occur if the Integrity Digest
Cache attempts to read the same inode that is already locked by IMA.

However, since the Integrity Digest Cache makes sure that the above
situation never happens, as it checks the inodes, it is safe to call
digest_cache_get() inside the critical region and nest the iint->mutex
when the DIGEST_LIST_CHECK hook is executed.

Change the mutex_lock() call for the iint mutex into mutex_lock_nested(),
and add a subclass that is 0 if the IMA hook executed is not
DIGEST_LIST_CHECK, and 1 if it is.

Specifying the subclass does not interfere with the class annotation in
ima_iint_lockdep_annotate(), to make IMA work with overlayfs.

Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
---
 security/integrity/ima/ima_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index cff8b5a12512..06ee99bd7886 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -266,7 +266,7 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	if (!action)
 		goto out;
 
-	mutex_lock(&iint->mutex);
+	mutex_lock_nested(&iint->mutex, func == DIGEST_LIST_CHECK);
 
 	if (test_and_clear_bit(IMA_CHANGE_ATTR, &iint->atomic_flags))
 		/* reset appraisal flags if ima_inode_post_setattr was called */
-- 
2.34.1


