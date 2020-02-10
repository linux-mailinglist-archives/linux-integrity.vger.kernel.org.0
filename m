Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4A71580C1
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Feb 2020 18:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727621AbgBJRKI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Feb 2020 12:10:08 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:36755 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727536AbgBJRKI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Feb 2020 12:10:08 -0500
X-Greylist: delayed 2425 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Feb 2020 12:09:57 EST
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id 01AGSn2X011282;
        Mon, 10 Feb 2020 18:28:49 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id 612B76032E; Mon, 10 Feb 2020 18:28:49 +0200 (IST)
From:   amirmizi6@gmail.com
To:     Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        Dan.Morav@nuvoton.com, oren.tanami@nuvoton.com,
        shmulik.hager@nuvoton.com, amir.mizinski@nuvoton.com,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v3 0/7] add tpm i2c ptp driver
Date:   Mon, 10 Feb 2020 18:28:31 +0200
Message-Id: <20200210162838.173903-1-amirmizi6@gmail.com>
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

Addressed comments from:
 - Jarkko Sakkinen: https://patchwork.kernel.org/patch/11236257/
 - Rob Herring: https://patchwork.kernel.org/patch/11236253/

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


Changes since version 2:
- Added 2 new commits with improvements suggested by Benoit Houyere.
        -"Fix expected bit handling  and send all bytes in one shot without last byte in exception"
        -"Handle an exeption for TPM Firmware Update mode."
- Updated patch to latest v5.5
-"dt-bindings: tpm: Add YAML schema for TPM TIS I2C options"
        - Added "interrupts" and "crc-checksum" to properties.
        - Updated binding description and commit info.
-"char: tpm: add tpm_tis_i2c driver" (suggested by Benoit Houyere)
        - Added repeat I2C frame after NACK.
        - Checksum I2C feature activation in DTS file configuration.

Amir Mizinski (7):
  char: tpm: Make implementation of read16 read32 write32 optional
  char: tpm: Add check_data handle to tpm_tis_phy_ops in order to check
    data integrity
  char: tpm: rewrite "tpm_tis_req_canceled()"
  char: tpm: Fix expected bit handling and send all bytes in one shot
    without last byte in exception
  tpm: Handle an exception for TPM Firmware Update mode.
  dt-bindings: tpm: Add YAML schema for TPM TIS I2C options
  char: tpm: add tpm_tis_i2c driver

 .../bindings/security/tpm/tpm-tis-i2c.yaml         |  43 +++
 drivers/char/tpm/Kconfig                           |  12 +
 drivers/char/tpm/Makefile                          |   1 +
 drivers/char/tpm/tpm2-cmd.c                        |   4 +
 drivers/char/tpm/tpm_tis_core.c                    | 182 ++++++-------
 drivers/char/tpm/tpm_tis_core.h                    |  41 ++-
 drivers/char/tpm/tpm_tis_i2c.c                     | 292 +++++++++++++++++++++
 drivers/char/tpm/tpm_tis_spi.c                     |  41 ---
 include/linux/tpm.h                                |   1 +
 9 files changed, 482 insertions(+), 135 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
 create mode 100644 drivers/char/tpm/tpm_tis_i2c.c

-- 
2.7.4

