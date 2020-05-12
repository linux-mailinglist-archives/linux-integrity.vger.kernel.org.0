Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF0FC1CF6BF
	for <lists+linux-integrity@lfdr.de>; Tue, 12 May 2020 16:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbgELOP5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 12 May 2020 10:15:57 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:48548 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726891AbgELOPo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 12 May 2020 10:15:44 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 04CEF4SB011237;
        Tue, 12 May 2020 17:15:04 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id F28C7639BE; Tue, 12 May 2020 17:15:03 +0300 (IDT)
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
        Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v8 0/8] Add tpm i2c ptp driver
Date:   Tue, 12 May 2020 17:14:23 +0300
Message-Id: <20200512141431.83833-1-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

This patch set adds support for TPM devices that implement the I2C.
Interface defined by TCG PTP specification:
https://trustedcomputinggroup.org/wp-content/uploads/TCG_PC_Client_Platform_TPM_Profile_PTP_2.0_r1.03_v22.pdf

The driver was tested on Raspberry-Pie 3, using Nuvoton NPCT75X TPM.

Interrupts are not implemented yet, preparing it for the next patch.
This patch is based on initial work by oshri Alkoby, Alexander Steffen and Christophe Ricard

Changes since version 1:
-"char:tpm:Add check_data handle to tpm_tis_phy_ops in order to check data integrity"
        - Fixed and extended commit description.
        - Fixed an issue regarding handling max retries.
-"dt-bindings: tpm: Add YAML schema for TPM TIS I2C options":
        -Converted "tpm_tis_i2c.txt" to "tpm-tis-i2c.yaml".
        - Renamed "tpm_tis-i2c" to "tpm-tis-i2c".
        - Removed interrupts properties.
-"char: tpm: add tpm_tis_i2c driver"
        - Replaced "tpm_tis-i2c" with "tpm-tis-i2c" in "tpm_tis_i2c.c".
Addressed comments from:
 - Jarkko Sakkinen: https://patchwork.kernel.org/patch/11236257/
 - Rob Herring: https://patchwork.kernel.org/patch/11236253/

Changes since version 2:
- Added 2 new commits with improvements suggested by Benoit Houyere.
        -"Fix expected bit handling and send all bytes in one shot without last byte in exception"
        -"Handle an exception for TPM Firmware Update mode."
- Updated patch to latest v5.5
-"dt-bindings: tpm: Add YAML schema for TPM TIS I2C options"
        - Added "interrupts" and "crc-checksum" to properties.
        - Updated binding description and commit info.
-"char: tpm: add tpm_tis_i2c driver" (suggested by Benoit Houyere)
        - Added repeat I2C frame after NACK.
        - Checksum I2C feature activation in DTS file configuration.
Addressed comments from:
 - Rob Herring: https://lore.kernel.org/patchwork/patch/1161287/

Changes since version 3:
- Updated patch to latest v5.6
- Updated commits headlines and development credit format by Jarkko Sakkinen suggestion
-"tpm: tpm_tis: Make implementation of read16 read32 write32 optional"
        - Updated commit description.
-"dt-bindings: tpm: Add YAML schema for TPM TIS I2C options"
        - Fixed 'make dt_binding_check' errors on YAML file.
        - Removed interrupts from required and examples since there is no use for them in current patch.
Addressed comments from:
 - Jarkko Sakkinen: https://lore.kernel.org/patchwork/patch/1192101/
 - Rob Herring: https://lore.kernel.org/patchwork/patch/1192099/

Changes since version 4:
-"tpm: tpm_tis: Make implementation of read16 read32 write32 optional"
        -Added a "Reviewed-by" tag:
-"tpm: tpm_tis: Add check_data handle to tpm_tis_phy_ops in order to check data integrity"
        -Fixed credit typos.
-"tpm: tpm_tis: rewrite "tpm_tis_req_canceled()""
        -Added fixes tag and removed changes for STM.
-"tpm: tpm_tis: Fix expected bit handling and send all bytes in one shot without last byte in exception"
        -Fixed typos, edited description to be clearer, and added a "Suggested-by" tag.
-"tpm: Handle an exception for TPM Firmware Update mode."
        -Added a "Suggested-by" tag.
-"dt-bindings: tpm: Add YAML schema for TPM TIS I2C options"
        -Fixed 'make dt_binding_check' errors.
-"tpm: tpm_tis: add tpm_tis_i2c driver"
        -Added tested-by tag by Eddie James.
        -Fixed indent in Kconfig file.
        -Fixed 'MODULE_DESCRIPTION'.
Addressed comments from:
 - Jarkko Sakkinen: https://patchwork.kernel.org/patch/11467645/
                https://patchwork.kernel.org/patch/11467655/
                https://patchwork.kernel.org/patch/11467643/
                https://patchwork.kernel.org/patch/11467659/
                https://patchwork.kernel.org/patch/11467651/
 - Rob Herring: https://patchwork.kernel.org/patch/11467653/
 - Randy Dunlap: https://patchwork.kernel.org/patch/11467651/
 - Eddie James: https://lore.kernel.org/patchwork/patch/1192104/

Changes since version 5:
-"tpm: tpm_tis: Add check_data handle to tpm_tis_phy_ops"
        -Updated short description and fixed long description to be more clear.
Addressed comments from:
 - Jarkko Sakkinen: https://lkml.org/lkml/2020/4/6/748

Changes since version 6:
-"tpm: tpm_tis: Make implementation of read16, read32 and write32 optional"
        -Fixed short description.
        -fixed long description proofreading issues.
-"tpm: tpm_tis: Add check_data handle to tpm_tis_phy_ops"
        -Fixed long description by Jarkko comments and proofreading issues.
        -Replaced "check_data" with verify_data_integrity".
        -New line before return statement.
-"tpm: tpm_tis: rewrite "tpm_tis_req_canceled()"
        -Fixed line over 80 characters.
        -fixed long description proofreading issues.
-" tpm: tpm_tis: Fix expected bit handling and send all bytes in one shot"
        -fixed long description proofreading issues.
-"dt-bindings: tpm: Add YAML schema for TPM TIS I2C option"
        -Replaced "tpm-tis-i2c@2e" with "tpm_tis@2e".
        -Fixed CRC_Checksum description.
-"tpm: tpm_tis: add tpm_tis_i2c driver"
        -Replaced "depends on CRC_CCIT" with "select CRC_CCIT".
        -Added tested-by tag by Joel Stanley.
        -Fixed checkpatch.pl warnings.
Addressed comments from:
 - Jarkko Sakkinen:
        https://lore.kernel.org/patchwork/patch/1221336/
        https://lore.kernel.org/patchwork/patch/1221337/
        https://lore.kernel.org/patchwork/patch/1221339/
 - Joel Stanley:
        https://lore.kernel.org/patchwork/patch/1220543/
 - Rob Herring:
        https://lore.kernel.org/patchwork/patch/1221334/


Changes since version 7:
- Added a new commit with improvements suggested by Benoit Houyere.
        -"tpm: tpm_tis: verify TPM_STS register is valid after locality request"
-"tpm: tpm_tis: Rewrite "tpm_tis_req_canceled()""
        -Fixed Hash for Fixes tag.
-"tpm: Add YAML schema for TPM TIS I2C options"
        -Added a compatible string specific to the nuvoton npct75x chip.
-"tpm: tpm_tis: add tpm_tis_i2c driver"
        - added a compatible string according to yaml file.
Addressed comments from:
 - Jarkko Sakkinen:
        https://lore.kernel.org/patchwork/patch/1231524/
 - Rob Herring:
        https://lore.kernel.org/patchwork/patch/1231526/

Amir Mizinski (8):
  tpm: tpm_tis: Make implementation of read16, read32 and write32
    optional
  tpm: tpm_tis: Add verify_data_integrity handle toy tpm_tis_phy_ops
  tpm: tpm_tis: Rewrite "tpm_tis_req_canceled()"
  tpm: tpm_tis: Fix expected bit handling and send all bytes in one shot
    without last byte in exception
  tpm: Handle an exception for TPM Firmware Update mode.
  verify TPM_STS register is valid after      locality request
  tpm: Add YAML schema for TPM TIS I2C options
  tpm: tpm_tis: add tpm_tis_i2c driver

 .../bindings/security/tpm/tpm-tis-i2c.yaml         |  51 ++++
 drivers/char/tpm/Kconfig                           |  12 +
 drivers/char/tpm/Makefile                          |   1 +
 drivers/char/tpm/tpm2-cmd.c                        |   4 +
 drivers/char/tpm/tpm_tis_core.c                    | 188 +++++++------
 drivers/char/tpm/tpm_tis_core.h                    |  41 ++-
 drivers/char/tpm/tpm_tis_i2c.c                     | 292 +++++++++++++++++++++
 drivers/char/tpm/tpm_tis_spi_main.c                |  41 ---
 include/linux/tpm.h                                |   1 +
 9 files changed, 502 insertions(+), 129 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
 create mode 100644 drivers/char/tpm/tpm_tis_i2c.c

-- 
2.7.4

