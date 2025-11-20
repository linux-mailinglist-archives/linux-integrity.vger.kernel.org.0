Return-Path: <linux-integrity+bounces-7646-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A6BC7297E
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Nov 2025 08:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C090A350BB9
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Nov 2025 07:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5637115539A;
	Thu, 20 Nov 2025 07:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="23XWQtGq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C729372AA1;
	Thu, 20 Nov 2025 07:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763623798; cv=none; b=nTS5qTaCV1BJVk/TW14D4oU87RBo4XNzJriE96s0+MaEF4JP3QUv4wavW41zfhDwXDd5gIRGQrZLIL3fDTyOkSn7lcKoPLRy5542JsyXfaoHPrIB9VE1H7sr51Sc8yyCsti4y+KohBz9iVU3j6ciL2NSB2P8L6mS7iKy/cBpwrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763623798; c=relaxed/simple;
	bh=T/4g+8nwEXYNB0TZCSPGrW1LBoQgDHihoejRe5qB9c4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ytj0fuYkGeD94pW4M5m4oFMxxdmFiLIOHXB5B4ivJF+NabMjuMZZ8AHmDI+Okq71irKf3vtaOwPEwTOwkAqU13PT0fD2/sRieWzpD+s0BA+On/NXBuCIeKpwT5KE6EZR9k0gdZX1rHmANBPpSc0y+m9abUAfzOgcKLNJ343qP6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=23XWQtGq; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=lXWYzpe5aBkCK5IQCyuQty13G2znCzDHUWYV/gNIt+U=;
	b=23XWQtGqOFINLF0PqU4N7E9NeIDgMvZn0RI7Jp4WT/chARX77MWBtT7zWl02IvknEHFh7tkc5
	2EwPFYSeKk/vJ9on3Op9yiSOkRsfsxOF5fUC/162KiRhwsbPYpKljUDkfTDaicvkGk9rRQqLaxb
	hmwSf+SDASios4G+nZkRZmk=
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dBqhK5H1Mz1T4GQ;
	Thu, 20 Nov 2025 15:28:17 +0800 (CST)
Received: from kwepemh500010.china.huawei.com (unknown [7.202.181.141])
	by mail.maildlp.com (Postfix) with ESMTPS id 0EFFF18047F;
	Thu, 20 Nov 2025 15:29:52 +0800 (CST)
Received: from huawei.com (10.67.175.67) by kwepemh500010.china.huawei.com
 (7.202.181.141) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 20 Nov
 2025 15:29:51 +0800
From: Zhao Yipeng <zhaoyipeng5@huawei.com>
To: <zohar@linux.ibm.com>, <roberto.sassu@huawei.com>,
	<dmitry.kasatkin@gmail.com>, <eric.snowberg@oracle.com>
CC: <lujialin4@huawei.com>, <linux-integrity@vger.kernel.org>,
	<linux-security-module@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH -next] ima: Handle error code returned by ima_filter_rule_match()
Date: Thu, 20 Nov 2025 15:18:05 +0800
Message-ID: <20251120071805.1604864-1-zhaoyipeng5@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 kwepemh500010.china.huawei.com (7.202.181.141)

In ima_match_rules(), if ima_filter_rule_match() returns -ENOENT due to
the rule being NULL, the function incorrectly skips the 'if (!rc)' check
and sets 'result = true'. The LSM rule is considered a match, causing
extra files to be measured by IMA.

This issue can be reproduced in the following scenario:
After unloading the SELinux policy module via 'semodule -d', if an IMA
measurement is triggered before ima_lsm_rules is updated,
in ima_match_rules(), the first call to ima_filter_rule_match() returns
-ESTALE. This causes the code to enter the 'if (rc == -ESTALE &&
!rule_reinitialized)' block, perform ima_lsm_copy_rule() and retry. In
ima_lsm_copy_rule(), since the SELinux module has been removed, the rule
becomes NULL, and the second call to ima_filter_rule_match() returns
-ENOENT. This bypasses the 'if (!rc)' check and results in a false match.

Call trace:
  selinux_audit_rule_match+0x310/0x3b8
  security_audit_rule_match+0x60/0xa0
  ima_match_rules+0x2e4/0x4a0
  ima_match_policy+0x9c/0x1e8
  ima_get_action+0x48/0x60
  process_measurement+0xf8/0xa98
  ima_bprm_check+0x98/0xd8
  security_bprm_check+0x5c/0x78
  search_binary_handler+0x6c/0x318
  exec_binprm+0x58/0x1b8
  bprm_execve+0xb8/0x130
  do_execveat_common.isra.0+0x1a8/0x258
  __arm64_sys_execve+0x48/0x68
  invoke_syscall+0x50/0x128
  el0_svc_common.constprop.0+0xc8/0xf0
  do_el0_svc+0x24/0x38
  el0_svc+0x44/0x200
  el0t_64_sync_handler+0x100/0x130
  el0t_64_sync+0x3c8/0x3d0

Fix this by changing 'if (!rc)' to 'if (rc <= 0)' to ensure that error
codes like -ENOENT do not bypass the check and accidentally result in a
successful match.

Fixes: 4af4662fa4a9d ("integrity: IMA policy")
Signed-off-by: Zhao Yipeng <zhaoyipeng5@huawei.com>
---
 security/integrity/ima/ima_policy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
index 128fab897930..db6d55af5a80 100644
--- a/security/integrity/ima/ima_policy.c
+++ b/security/integrity/ima/ima_policy.c
@@ -674,7 +674,7 @@ static bool ima_match_rules(struct ima_rule_entry *rule,
 				goto retry;
 			}
 		}
-		if (!rc) {
+		if (rc <= 0) {
 			result = false;
 			goto out;
 		}
-- 
2.34.1


