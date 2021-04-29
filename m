Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B9F36E62B
	for <lists+linux-integrity@lfdr.de>; Thu, 29 Apr 2021 09:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231465AbhD2HkX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 29 Apr 2021 03:40:23 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16931 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbhD2HkW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 29 Apr 2021 03:40:22 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FW6lQ0v7qzvV4Q;
        Thu, 29 Apr 2021 15:37:06 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.498.0; Thu, 29 Apr 2021 15:39:27 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <jarkko@kernel.org>, <peterhuewe@gmx.de>
CC:     <linux-integrity@vger.kernel.org>,
        Tian Tao <tiantao6@hisilicon.com>
Subject: [PATCH v2] tpm_crb: Use IOMEM_ERR_PTR when function returns iomem
Date:   Thu, 29 Apr 2021 15:39:39 +0800
Message-ID: <1619681979-542-1-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This is to simplify the code, and IOMEM_ERR_PTR(err) is same with
(__force void __iomem *)ERR_PTR(err).

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---

v2: rewrite the commit message.
---
 drivers/char/tpm/tpm_crb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/tpm/tpm_crb.c b/drivers/char/tpm/tpm_crb.c
index a9dcf31..1860665 100644
--- a/drivers/char/tpm/tpm_crb.c
+++ b/drivers/char/tpm/tpm_crb.c
@@ -464,7 +464,7 @@ static void __iomem *crb_map_res(struct device *dev, struct resource *iores,
 
 	/* Detect a 64 bit address on a 32 bit system */
 	if (start != new_res.start)
-		return (void __iomem *) ERR_PTR(-EINVAL);
+		return IOMEM_ERR_PTR(-EINVAL);
 
 	if (!iores)
 		return devm_ioremap_resource(dev, &new_res);
-- 
2.7.4

