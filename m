Return-Path: <linux-integrity+bounces-7670-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AB2C83199
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Nov 2025 03:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C8C23A1677
	for <lists+linux-integrity@lfdr.de>; Tue, 25 Nov 2025 02:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0340F27713;
	Tue, 25 Nov 2025 02:31:54 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from unicom145.biz-email.net (unicom145.biz-email.net [210.51.26.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954503FFD;
	Tue, 25 Nov 2025 02:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.51.26.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764037913; cv=none; b=sGBDFFffF7MdPOyxYt+f1GweqOniWg7TJVEHItP1TXMRNgZSNigryxkKGq+REBAlI/4YOAKMVQU8PKDVevc+LGsYiP7cSjp6DAGaaezOYYd/7WEXWnnaW/+XMi1bElKyfeQxOjJFpFl6ZabiMlrxWAFN4WPjBl9bhlxTXgDJWjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764037913; c=relaxed/simple;
	bh=b6Wq5/VIXwqQ7OSZnx4oUud0gaZaOAaoEYc+b3o+GEE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tGJOjVbh+Ig69WAXzEDt/lKYMuT3qmMPDVb+h/M1EMKSqPGV0YUO/l2FFo7JnArVnES4KSmHOJfVbb9m1AQ3n19UAkStVb0NU6xbZovNAJZ9zsfSZRdSckYcDxzMPUwHsIE0UY09DEdc689PbcH1rHlHuczw2NFm/CXhzKS/YJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com; spf=pass smtp.mailfrom=inspur.com; arc=none smtp.client-ip=210.51.26.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspur.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inspur.com
Received: from Jtjnmail201616.home.langchao.com
        by unicom145.biz-email.net ((D)) with ASMTP (SSL) id 202511251030364146;
        Tue, 25 Nov 2025 10:30:36 +0800
Received: from jtjnmailAR01.home.langchao.com (10.100.2.42) by
 Jtjnmail201616.home.langchao.com (10.100.2.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 25 Nov 2025 10:30:36 +0800
Received: from inspur.com (10.100.2.96) by jtjnmailAR01.home.langchao.com
 (10.100.2.42) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 25 Nov 2025 10:30:36 +0800
Received: from localhost.localdomain.com (unknown [10.94.14.191])
	by app1 (Coremail) with SMTP id YAJkCsDwOTXKFCVpXSgFAA--.153S4;
	Tue, 25 Nov 2025 10:30:35 +0800 (CST)
From: Chu Guangqing <chuguangqing@inspur.com>
To: <peterhuewe@gmx.de>, <jarkko@kernel.org>, <jgg@ziepe.ca>
CC: <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Chu
 Guangqing <chuguangqing@inspur.com>
Subject: [PATCH 1/1] tpm_crb: Fix a spelling mistake
Date: Tue, 25 Nov 2025 10:30:30 +0800
Message-ID: <20251125023030.3023-1-chuguangqing@inspur.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: YAJkCsDwOTXKFCVpXSgFAA--.153S4
X-Coremail-Antispam: 1UD129KBjvdXoWruw48XrW5tFW5Xw1kArWrZrb_yoW3Krb_Cw
	4kX3Z7Wry0kryqq3WDJr1fCFyrKw45WFnYgFs2q345Z3W0yr18Gry0vrs8JFyrWrs0kFZI
	9ws2qFyfur1agjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_GcCE
	3s1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_
	Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxV
	WUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI
	7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r
	4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI
	42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUr2-eDUUUU
X-CM-SenderInfo: 5fkxw35dqj1xlqj6x0hvsx2hhfrp/
X-CM-DELIVERINFO: =?B?PTEfXZRRTeOiUs3aOqHZ50hzsfHKF9Ds6CbXmDm38RucXu3DYXJR7Zlh9zE0nt/Iac
	D+KejMZjpuEfUYyjebTlf5J7XMswGns/RYFkZrCtTOE0xaYSMSrw+ft7hOcoeUpAosrEzS
	yjTmwGedb1fjMsqRwgo=
Content-Type: text/plain
tUid: 202511251030371ca34b7ebb469a6797c6f827d180f341
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com

The spelling of the word "requrest" is incorrect; it should be "request".

Signed-off-by: Chu Guangqing <chuguangqing@inspur.com>
---
 drivers/char/tpm/tpm_crb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index c75a531cfb98..e094c517b96e 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -412,7 +412,7 @@ static int crb_do_acpi_start(struct tpm_chip *chip)
 #ifdef CONFIG_ARM64
 /*
  * This is a TPM Command Response Buffer start method that invokes a
- * Secure Monitor Call to requrest the firmware to execute or cancel
+ * Secure Monitor Call to request the firmware to execute or cancel
  * a TPM 2.0 command.
  */
 static int tpm_crb_smc_start(struct device *dev, unsigned long func_id)
-- 
2.43.7


