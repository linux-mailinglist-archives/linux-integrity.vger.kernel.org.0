Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D8A2724CE
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Sep 2020 15:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727459AbgIUNKz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Sep 2020 09:10:55 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43372 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727447AbgIUNKx (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Sep 2020 09:10:53 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9D90D2A83FCA30DE087F;
        Mon, 21 Sep 2020 21:10:52 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Mon, 21 Sep 2020 21:10:45 +0800
From:   Qinglang Miao <miaoqinglang@huawei.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Arnd Bergmann" <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Qinglang Miao <miaoqinglang@huawei.com>
Subject: [PATCH -next] tpm/st33zp24: simplify the return expression of st33zp24_spi_probe()
Date:   Mon, 21 Sep 2020 21:11:09 +0800
Message-ID: <20200921131109.93319-1-miaoqinglang@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Simplify the return expression.

Signed-off-by: Qinglang Miao <miaoqinglang@huawei.com>
---
 drivers/char/tpm/st33zp24/spi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/spi.c b/drivers/char/tpm/st33zp24/spi.c
index a75dafd39..4580bddbe 100644
--- a/drivers/char/tpm/st33zp24/spi.c
+++ b/drivers/char/tpm/st33zp24/spi.c
@@ -384,13 +384,8 @@ static int st33zp24_spi_probe(struct spi_device *dev)
 static int st33zp24_spi_remove(struct spi_device *dev)
 {
 	struct tpm_chip *chip = spi_get_drvdata(dev);
-	int ret;
 
-	ret = st33zp24_remove(chip);
-	if (ret)
-		return ret;
-
-	return 0;
+	return st33zp24_remove(chip);
 }
 
 static const struct spi_device_id st33zp24_spi_id[] = {
-- 
2.23.0

