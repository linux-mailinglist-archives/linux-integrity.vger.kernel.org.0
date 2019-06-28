Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5AF8159E8A
	for <lists+linux-integrity@lfdr.de>; Fri, 28 Jun 2019 17:14:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbfF1POI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 Jun 2019 11:14:08 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:37008 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726835AbfF1POI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 Jun 2019 11:14:08 -0400
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x5SFDUEl004543;
        Fri, 28 Jun 2019 18:13:30 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 20053)
        id 58EE361FCC; Fri, 28 Jun 2019 18:13:30 +0300 (IDT)
From:   Oshri Alkoby <oshrialkoby85@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org, oshrialkoby85@gmail.com,
        oshri.alkoby@nuvoton.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, gcwilson@us.ibm.com,
        kgoldman@us.ibm.com, nayna@linux.vnet.ibm.com,
        dan.morav@nuvoton.com, tomer.maimon@nuvoton.com
Subject: [PATCH v2 0/2] char: tpm: add new driver for tpm i2c ptp
Date:   Fri, 28 Jun 2019 18:13:25 +0300
Message-Id: <20190628151327.206818-1-oshrialkoby85@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch set adds support for TPM devices that implement the I2C
interface defined by TCG PTP specification:
https://trustedcomputinggroup.org/wp-content/uploads/TCG_PC_Client_Platform_TPM_Profile_PTP_2.0_r1.03_v22.pdf

The driver was tested on Raspberry-Pie 3, using Nuvoton NPCT75X TPM.

changes
-------

v2:
- Extended device tree binding description

v1:
- Initial version

Oshri Alkoby (2):
  dt-bindings: tpm: add the TPM I2C PTP device tree binding
    documentation
  char: tpm: add new driver for tpm i2c ptp

 .../bindings/security/tpm/tpm-i2c-ptp.txt     |   24 +
 drivers/char/tpm/Kconfig                      |   22 +
 drivers/char/tpm/Makefile                     |    1 +
 drivers/char/tpm/tpm_i2c_ptp.c                | 1099 +++++++++++++++++
 4 files changed, 1146 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-i2c-ptp.txt
 create mode 100644 drivers/char/tpm/tpm_i2c_ptp.c

-- 
2.18.0

