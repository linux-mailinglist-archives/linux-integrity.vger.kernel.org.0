Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9590A1FC32D
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jun 2020 03:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726601AbgFQBFH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Jun 2020 21:05:07 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:55838 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgFQBFH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Jun 2020 21:05:07 -0400
Received: from localhost (unknown [192.168.167.70])
        by lucky1.263xmail.com (Postfix) with ESMTP id 4AE05B00CF;
        Wed, 17 Jun 2020 09:00:47 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED: 0
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.246.122.242])
        by smtp.263.net (postfix) whith ESMTP id P9955T140607548782336S1592355640986958_;
        Wed, 17 Jun 2020 09:00:46 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <9f3c78971883cd7b636e8bbecb83ec40>
X-RL-SENDER: zhoubinbin@uniontech.com
X-SENDER: zhoubinbin@uniontech.com
X-LOGIN-NAME: zhoubinbin@uniontech.com
X-FST-TO: peterhuewe@gmx.de
X-SENDER-IP: 58.246.122.242
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Binbin Zhou <zhoubinbin@uniontech.com>
To:     peterhuewe@gmx.de, jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca
Cc:     linux-integrity@vger.kernel.org, christophe.ricard@gmail.com,
        zhoubb.aaron@gmail.com, Binbin Zhou <zhoubinbin@uniontech.com>
Subject: [PATCH v2] tpm/st33zp24: fix spelling mistake "drescription" -> "description"
Date:   Wed, 17 Jun 2020 09:00:38 +0800
Message-Id: <20200617010038.32493-1-zhoubinbin@uniontech.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Trivial fix, the spelling of "drescription" is incorrect
in function comment.

Fix this.

Signed-off-by: Binbin Zhou <zhoubinbin@uniontech.com>
---
v2:
   Fix the checkpatch issue.

 drivers/char/tpm/st33zp24/i2c.c      | 2 +-
 drivers/char/tpm/st33zp24/spi.c      | 4 ++--
 drivers/char/tpm/st33zp24/st33zp24.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/char/tpm/st33zp24/i2c.c b/drivers/char/tpm/st33zp24/i2c.c
index 35333b65acd1..7c617edff4ca 100644
--- a/drivers/char/tpm/st33zp24/i2c.c
+++ b/drivers/char/tpm/st33zp24/i2c.c
@@ -210,7 +210,7 @@ static int st33zp24_i2c_request_resources(struct i2c_client *client)
 
 /*
  * st33zp24_i2c_probe initialize the TPM device
- * @param: client, the i2c_client drescription (TPM I2C description).
+ * @param: client, the i2c_client description (TPM I2C description).
  * @param: id, the i2c_device_id struct.
  * @return: 0 in case of success.
  *	 -1 in other case.
diff --git a/drivers/char/tpm/st33zp24/spi.c b/drivers/char/tpm/st33zp24/spi.c
index 26e09de50f1e..a75dafd39445 100644
--- a/drivers/char/tpm/st33zp24/spi.c
+++ b/drivers/char/tpm/st33zp24/spi.c
@@ -329,7 +329,7 @@ static int st33zp24_spi_request_resources(struct spi_device *dev)
 
 /*
  * st33zp24_spi_probe initialize the TPM device
- * @param: dev, the spi_device drescription (TPM SPI description).
+ * @param: dev, the spi_device description (TPM SPI description).
  * @return: 0 in case of success.
  *	 or a negative value describing the error.
  */
@@ -378,7 +378,7 @@ static int st33zp24_spi_probe(struct spi_device *dev)
 
 /*
  * st33zp24_spi_remove remove the TPM device
- * @param: client, the spi_device drescription (TPM SPI description).
+ * @param: client, the spi_device description (TPM SPI description).
  * @return: 0 in case of success.
  */
 static int st33zp24_spi_remove(struct spi_device *dev)
diff --git a/drivers/char/tpm/st33zp24/st33zp24.c b/drivers/char/tpm/st33zp24/st33zp24.c
index 37bb13f516be..4ec10ab5e576 100644
--- a/drivers/char/tpm/st33zp24/st33zp24.c
+++ b/drivers/char/tpm/st33zp24/st33zp24.c
@@ -502,7 +502,7 @@ static const struct tpm_class_ops st33zp24_tpm = {
 
 /*
  * st33zp24_probe initialize the TPM device
- * @param: client, the i2c_client drescription (TPM I2C description).
+ * @param: client, the i2c_client description (TPM I2C description).
  * @param: id, the i2c_device_id struct.
  * @return: 0 in case of success.
  *	 -1 in other case.
-- 
2.17.1



