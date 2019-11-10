Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 13F48F6A24
	for <lists+linux-integrity@lfdr.de>; Sun, 10 Nov 2019 17:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKJQdQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 10 Nov 2019 11:33:16 -0500
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:44397 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726832AbfKJQdQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 10 Nov 2019 11:33:16 -0500
X-Greylist: delayed 642 seconds by postgrey-1.27 at vger.kernel.org; Sun, 10 Nov 2019 11:33:15 EST
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id xAAGLhXP013894;
        Sun, 10 Nov 2019 18:21:43 +0200
Received: by taln60.nuvoton.co.il (Postfix, from userid 10140)
        id 613EA60275; Sun, 10 Nov 2019 18:21:43 +0200 (IST)
From:   amirmizi6@gmail.com
To:     Eyal.Cohen@nuvoton.com, jarkko.sakkinen@linux.intel.com,
        oshrialkoby85@gmail.com, alexander.steffen@infineon.com,
        robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jgg@ziepe.ca, arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, oshri.alkoby@nuvoton.com,
        tmaimon77@gmail.com, gcwilson@us.ibm.com, kgoldman@us.ibm.com,
        ayna@linux.vnet.ibm.com, Dan.Morav@nuvoton.com,
        oren.tanami@nuvoton.com, shmulik.hagar@nuvoton.com,
        amir.mizinski@nuvoton.com, Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v1 0/5] add tpm i2c ptp driver
Date:   Sun, 10 Nov 2019 18:21:32 +0200
Message-Id: <20191110162137.230913-1-amirmizi6@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

From: Amir Mizinski <amirmizi6@gmail.com>

*This patch set adds support for TPM devices that implement the I2C
interface defined by TCG PTP specification:
https://trustedcomputinggroup.org/wp-content/uploads/TCG_PC_Client_Platform_TPM_Profile_PTP_2.0_r1.03_v22.pdf

The driver was tested on Raspberry-Pie 3, using Nuvoton NPCT75X TPM.

interupts are not implemented yet, preparing it for the next patch.
this patch is based on initial work by oshri Alkoby, Alexander Steffen and Christophe Ricard

Amir Mizinski (5):
  char: tpm: Make implementation of read16 read32 write32 optional
  char: tpm: Add check_data handle to tpm_tis_phy_ops in order to check
    data integrity
  char: tpm: rewrite "tpm_tis_req_canceled()"
  dt-bindings: tpm: Add the TPM TIS I2C device tree binding documentaion
  char: tpm: add tpm_tis_i2c driver

 .../bindings/security/tpm/tpm_tis_i2c.txt          |  24 ++
 drivers/char/tpm/Kconfig                           |  12 +
 drivers/char/tpm/Makefile                          |   1 +
 drivers/char/tpm/tpm_tis_core.c                    | 109 +++++----
 drivers/char/tpm/tpm_tis_core.h                    |  41 +++-
 drivers/char/tpm/tpm_tis_i2c.c                     | 272 +++++++++++++++++++++
 drivers/char/tpm/tpm_tis_spi.c                     |  41 ----
 7 files changed, 407 insertions(+), 93 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm_tis_i2c.txt
 create mode 100644 drivers/char/tpm/tpm_tis_i2c.c

-- 
2.7.4

