Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E12B37BE58
	for <lists+linux-integrity@lfdr.de>; Wed, 12 May 2021 15:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhELNk6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 12 May 2021 09:40:58 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2644 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbhELNk6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 May 2021 09:40:58 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FgG620t23zQmRW;
        Wed, 12 May 2021 21:36:26 +0800 (CST)
Received: from thunder-town.china.huawei.com (10.174.177.72) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Wed, 12 May 2021 21:39:42 +0800
From:   Zhen Lei <thunder.leizhen@huawei.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity <linux-integrity@vger.kernel.org>
CC:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: [PATCH v2 1/1] tpm: fix error return code in tpm2_get_cc_attrs_tbl()
Date:   Wed, 12 May 2021 21:39:26 +0800
Message-ID: <20210512133926.6326-2-thunder.leizhen@huawei.com>
X-Mailer: git-send-email 2.26.0.windows.1
In-Reply-To: <20210512133926.6326-1-thunder.leizhen@huawei.com>
References: <20210512133926.6326-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

If the total number of commands queried through TPM2_CAP_COMMANDS is
different from that queried through TPM2_CC_GET_CAPABILITY, it indicates
an unknown error. In this case, an appropriate error code -EFAULT should
be returned. However, we currently do not explicitly assign this error
code to 'rc'. As a result, 0 was incorrectly returned.

Fixes: 58472f5cd4f6("tpm: validate TPM 2.0 commands")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
---
 drivers/char/tpm/tpm2-cmd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index eff1f12d981ab27..c84d239512197aa 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -656,6 +656,7 @@ int tpm2_get_cc_attrs_tbl(struct tpm_chip *chip)
 
 	if (nr_commands !=
 	    be32_to_cpup((__be32 *)&buf.data[TPM_HEADER_SIZE + 5])) {
+		rc = -EFAULT;
 		tpm_buf_destroy(&buf);
 		goto out;
 	}
-- 
2.26.0.106.g9fadedd


