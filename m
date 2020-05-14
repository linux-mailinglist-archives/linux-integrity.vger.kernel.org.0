Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 890701D36F3
	for <lists+linux-integrity@lfdr.de>; Thu, 14 May 2020 18:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726100AbgENQuC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 14 May 2020 12:50:02 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:48766 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726090AbgENQuB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 14 May 2020 12:50:01 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 04EGnFxN006865;
        Thu, 14 May 2020 19:49:15 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id 205E7639C0; Thu, 14 May 2020 19:49:15 +0300 (IDT)
From:   amirmizi6@gmail.com
To:     Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        robh+dt@kernel.org,
        "benoit.houyere@st.com--to=mark.rutland"@arm.com,
        peterhuewe@gmx.de, christophe-h.richard@st.com, jgg@ziepe.ca,
        arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Amir Mizinski <amirmizi6@gmail.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v1] tpm: tpm_tis: make implementation of read16, read32 and write32 optional fix
Date:   Thu, 14 May 2020 19:48:25 +0300
Message-Id: <20200514164825.35377-2-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200514164825.35377-1-amirmizi6@gmail.com>
References: <20200514164825.35377-1-amirmizi6@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

Removed SPI extern function definitions and unused callback functions for
CR50 driver.

Fixes: fa05dc792ea0 ("tpm: tpm_tis: make implementation of read16, read32 and write32 optional")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Amir Mizinski <amirmizi6@gmail.com>
---
 drivers/char/tpm/tpm_tis_spi.h      | 4 ----
 drivers/char/tpm/tpm_tis_spi_cr50.c | 3 ---
 2 files changed, 7 deletions(-)

diff --git a/drivers/char/tpm/tpm_tis_spi.h b/drivers/char/tpm/tpm_tis_spi.h
index bba7397..d0f66f6 100644
--- a/drivers/char/tpm/tpm_tis_spi.h
+++ b/drivers/char/tpm/tpm_tis_spi.h
@@ -31,10 +31,6 @@ extern int tpm_tis_spi_init(struct spi_device *spi, struct tpm_tis_spi_phy *phy,
 extern int tpm_tis_spi_transfer(struct tpm_tis_data *data, u32 addr, u16 len,
 				u8 *in, const u8 *out);
 
-extern int tpm_tis_spi_read16(struct tpm_tis_data *data, u32 addr, u16 *result);
-extern int tpm_tis_spi_read32(struct tpm_tis_data *data, u32 addr, u32 *result);
-extern int tpm_tis_spi_write32(struct tpm_tis_data *data, u32 addr, u32 value);
-
 #ifdef CONFIG_TCG_TIS_SPI_CR50
 extern int cr50_spi_probe(struct spi_device *spi);
 #else
diff --git a/drivers/char/tpm/tpm_tis_spi_cr50.c b/drivers/char/tpm/tpm_tis_spi_cr50.c
index 37d72e8..f339d20 100644
--- a/drivers/char/tpm/tpm_tis_spi_cr50.c
+++ b/drivers/char/tpm/tpm_tis_spi_cr50.c
@@ -215,9 +215,6 @@ static int tpm_tis_spi_cr50_write_bytes(struct tpm_tis_data *data, u32 addr,
 static const struct tpm_tis_phy_ops tpm_spi_cr50_phy_ops = {
 	.read_bytes = tpm_tis_spi_cr50_read_bytes,
 	.write_bytes = tpm_tis_spi_cr50_write_bytes,
-	.read16 = tpm_tis_spi_read16,
-	.read32 = tpm_tis_spi_read32,
-	.write32 = tpm_tis_spi_write32,
 };
 
 static void cr50_print_fw_version(struct tpm_tis_data *data)
-- 
2.7.4

