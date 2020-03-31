Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 57326199592
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Mar 2020 13:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbgCaLq0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Mar 2020 07:46:26 -0400
Received: from maillog.nuvoton.com ([202.39.227.15]:40904 "EHLO
        maillog.nuvoton.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbgCaLqZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Mar 2020 07:46:25 -0400
Received: from NTHCCAS02.nuvoton.com (nthccas02.nuvoton.com [10.1.8.29])
        by maillog.nuvoton.com (Postfix) with ESMTP id 7E4E71C80E2B;
        Tue, 31 Mar 2020 19:34:14 +0800 (CST)
Received: from NTILML02.nuvoton.com (10.190.1.46) by NTHCCAS02.nuvoton.com
 (10.1.8.29) with Microsoft SMTP Server (TLS) id 15.0.1130.7; Tue, 31 Mar 2020
 19:34:13 +0800
Received: from NTILML02.nuvoton.com (10.190.1.47) by NTILML02.nuvoton.com
 (10.190.1.47) with Microsoft SMTP Server (TLS) id 15.0.1130.7; Tue, 31 Mar
 2020 14:34:11 +0300
Received: from taln70.nuvoton.co.il (10.191.1.70) by NTILML02.nuvoton.com
 (10.190.1.46) with Microsoft SMTP Server id 15.0.1130.7 via Frontend
 Transport; Tue, 31 Mar 2020 14:34:11 +0300
Received: from taln60.nuvoton.co.il (taln60 [10.191.1.180])
        by taln70.nuvoton.co.il (Postfix) with ESMTP id 9DCA3250;
        Tue, 31 Mar 2020 14:34:11 +0300 (IDT)
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id 8F234639AF; Tue, 31 Mar 2020 14:33:41 +0300 (IDT)
From:   <amirmizi6@gmail.com>
To:     <Eyal.Cohen@nuvoton.com>, <jarkko.sakkinen@linux.intel.com>,
        <oshrialkoby85@gmail.com>, <alexander.steffen@infineon.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>, <arnd@arndb.de>, <gregkh@linuxfoundation.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>, <oshri.alkoby@nuvoton.com>,
        <tmaimon77@gmail.com>, <gcwilson@us.ibm.com>,
        <kgoldman@us.ibm.com>, <Dan.Morav@nuvoton.com>,
        <oren.tanami@nuvoton.com>, <shmulik.hager@nuvoton.com>,
        <amir.mizinski@nuvoton.com>, Amir Mizinski <amirmizi6@gmail.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [PATCH v4 1/7] tpm: tpm_tis: Make implementation of read16 read32 write32 optional
Date:   Tue, 31 Mar 2020 14:32:01 +0300
Message-ID: <20200331113207.107080-2-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200331113207.107080-1-amirmizi6@gmail.com>
References: <20200331113207.107080-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

Only tpm_tis can use memory mapped I/O, which is truly mapped into
the kernel's memory space. So using ioread16/ioread32/iowrite32 turn into a
straightforward pointer dereference.
Every other driver require more complicated operations to read more than 1
byte at a time and will just fall back to read_bytes/write_bytes.
Therefore, move this common code out of tpm_tis_spi into tpm_tis_core, so
that it is automatically used when low-level drivers do not implement the
specialized methods.

Co-developed-by: Alexander Steffen <Alexander.Steffen@infineon.com>
Signed-off-by: Alexander Steffen <Alexander.Steffen@infineon.com>
Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
---
 drivers/char/tpm/tpm_tis_core.h     | 38 +++++++++++++++++++++++++++++++---
 drivers/char/tpm/tpm_tis_spi_main.c | 41 -------------------------------------
 2 files changed, 35 insertions(+), 44 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_core.h b/drivers/char/tpm/tpm_tis_core.h
index 7337819..d06c65b 100644
--- a/drivers/char/tpm/tpm_tis_core.h
+++ b/drivers/char/tpm/tpm_tis_core.h
@@ -122,13 +122,35 @@ static inline int tpm_tis_read8(struct tpm_tis_data *data, u32 addr, u8 *result)
 static inline int tpm_tis_read16(struct tpm_tis_data *data, u32 addr,
                                 u16 *result)
 {
-       return data->phy_ops->read16(data, addr, result);
+       __le16 result_le;
+       int rc;
+
+       if (data->phy_ops->read16)
+               return data->phy_ops->read16(data, addr, result);
+
+       rc = data->phy_ops->read_bytes(data, addr, sizeof(u16),
+                                      (u8 *)&result_le);
+       if (!rc)
+               *result = le16_to_cpu(result_le);
+
+       return rc;
 }

 static inline int tpm_tis_read32(struct tpm_tis_data *data, u32 addr,
                                 u32 *result)
 {
-       return data->phy_ops->read32(data, addr, result);
+       __le32 result_le;
+       int rc;
+
+       if (data->phy_ops->read32)
+               return data->phy_ops->read32(data, addr, result);
+
+       rc = data->phy_ops->read_bytes(data, addr, sizeof(u32),
+                                      (u8 *)&result_le);
+       if (!rc)
+               *result = le32_to_cpu(result_le);
+
+       return rc;
 }

 static inline int tpm_tis_write_bytes(struct tpm_tis_data *data, u32 addr,
@@ -145,7 +167,17 @@ static inline int tpm_tis_write8(struct tpm_tis_data *data, u32 addr, u8 value)
 static inline int tpm_tis_write32(struct tpm_tis_data *data, u32 addr,
                                  u32 value)
 {
-       return data->phy_ops->write32(data, addr, value);
+       __le32 value_le;
+       int rc;
+
+       if (data->phy_ops->write32)
+               return data->phy_ops->write32(data, addr, value);
+
+       value_le = cpu_to_le32(value);
+       rc = data->phy_ops->write_bytes(data, addr, sizeof(u32),
+                                       (u8 *)&value_le);
+
+       return rc;
 }

 static inline bool is_bsw(void)
diff --git a/drivers/char/tpm/tpm_tis_spi_main.c b/drivers/char/tpm/tpm_tis_spi_main.c
index d1754fd..95fef9d 100644
--- a/drivers/char/tpm/tpm_tis_spi_main.c
+++ b/drivers/char/tpm/tpm_tis_spi_main.c
@@ -152,44 +152,6 @@ static int tpm_tis_spi_write_bytes(struct tpm_tis_data *data, u32 addr,
        return tpm_tis_spi_transfer(data, addr, len, NULL, value);
 }

-int tpm_tis_spi_read16(struct tpm_tis_data *data, u32 addr, u16 *result)
-{
-       __le16 result_le;
-       int rc;
-
-       rc = data->phy_ops->read_bytes(data, addr, sizeof(u16),
-                                      (u8 *)&result_le);
-       if (!rc)
-               *result = le16_to_cpu(result_le);
-
-       return rc;
-}
-
-int tpm_tis_spi_read32(struct tpm_tis_data *data, u32 addr, u32 *result)
-{
-       __le32 result_le;
-       int rc;
-
-       rc = data->phy_ops->read_bytes(data, addr, sizeof(u32),
-                                      (u8 *)&result_le);
-       if (!rc)
-               *result = le32_to_cpu(result_le);
-
-       return rc;
-}
-
-int tpm_tis_spi_write32(struct tpm_tis_data *data, u32 addr, u32 value)
-{
-       __le32 value_le;
-       int rc;
-
-       value_le = cpu_to_le32(value);
-       rc = data->phy_ops->write_bytes(data, addr, sizeof(u32),
-                                       (u8 *)&value_le);
-
-       return rc;
-}
-
 int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_phy *phy,
                     int irq, const struct tpm_tis_phy_ops *phy_ops)
 {
@@ -205,9 +167,6 @@ int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_phy *phy,
 static const struct tpm_tis_phy_ops tpm_spi_phy_ops = {
        .read_bytes = tpm_tis_spi_read_bytes,
        .write_bytes = tpm_tis_spi_write_bytes,
-       .read16 = tpm_tis_spi_read16,
-       .read32 = tpm_tis_spi_read32,
-       .write32 = tpm_tis_spi_write32,
 };

 static int tpm_tis_spi_probe(struct spi_device *dev)
--
2.7.4



===========================================================================================
The privileged confidential information contained in this email is intended for use only by the addressees as indicated by the original sender of this email. If you are not the addressee indicated in this email or are not responsible for delivery of the email to such a person, please kindly reply to the sender indicating this fact and delete all copies of it from your computer and network server immediately. Your cooperation is highly appreciated. It is advised that any unauthorized use of confidential information of Nuvoton is strictly prohibited; and any information in this email irrelevant to the official business of Nuvoton shall be deemed as neither given nor endorsed by Nuvoton.
