Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E53EA10EAEB
	for <lists+linux-integrity@lfdr.de>; Mon,  2 Dec 2019 14:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbfLBNfx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 2 Dec 2019 08:35:53 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:45923 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727406AbfLBNfx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 2 Dec 2019 08:35:53 -0500
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id xB2DYIId015793;
        Mon, 2 Dec 2019 15:34:18 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id A95E160275; Mon,  2 Dec 2019 15:34:18 +0200 (IST)
From:   amirmizi6@gmail.com
To:     Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        ayna@linux.vnet.ibm.com, Dan.Morav@nuvoton.com,
        oren.tanami@nuvoton.com, shmulik.hager@nuvoton.com,
        amir.mizinski@nuvoton.com, Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v2 0/5] add tpm i2c ptp driver
Date:   Mon,  2 Dec 2019 15:33:27 +0200
Message-Id: <20191202133332.178110-1-amirmizi6@gmail.com>
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

Interupts are not implemented yet, preparing it for the next patch.
This patch is based on initial work by oshri Alkoby, Alexander Steffen and Christophe Ricard

Addressed comments from:
 - Jarkko Sakkinen: https://patchwork.kernel.org/patch/11236257/
 - Rob Herring: https://patchwork.kernel.org/patch/11236253/

Changes since version 1:
 - Commit 2/5:
  - Fixed and extended commit description.
  - Fixed an issue regarding handeling max retries.
 - Commit 4/5:
  - Converted "tpm_tis_i2c.txt" to "tpm-tis-i2c.yaml".
  - Renamed "tpm_tis-i2c" to "tpm-tis-i2c".
  - Removed interrupts properties.
 - Commit 5/5: Replaced "tpm_tis-i2c" with "tpm-tis-i2c" in "tpm_tis_i2c.c".

Amir Mizinski (5):
  char: tpm: Make implementation of read16 read32 write32 optional
  char: tpm: Add check_data handle to tpm_tis_phy_ops in order to check
    data integrity
  char: tpm: rewrite "tpm_tis_req_canceled()"
  dt-bindings: tpm: Add YAML schema for TPM TIS I2C options
  char: tpm: add tpm_tis_i2c driver

 .../bindings/security/tpm/tpm-tis-i2c.yaml         |  38 +++
 drivers/char/tpm/Kconfig                           |  12 +
 drivers/char/tpm/Makefile                          |   1 +
 drivers/char/tpm/tpm_tis_core.c                    | 113 +++++----
 drivers/char/tpm/tpm_tis_core.h                    |  41 +++-
 drivers/char/tpm/tpm_tis_i2c.c                     | 272 +++++++++++++++++++++
 drivers/char/tpm/tpm_tis_spi.c                     |  41 ----
 7 files changed, 425 insertions(+), 93 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-tis-i2c.yaml
 create mode 100644 drivers/char/tpm/tpm_tis_i2c.c

-- 
2.7.4

