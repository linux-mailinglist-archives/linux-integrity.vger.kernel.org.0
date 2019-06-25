Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BDC7D55C29
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Jun 2019 01:21:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726179AbfFYXVo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Jun 2019 19:21:44 -0400
Received: from 212.199.177.27.static.012.net.il ([212.199.177.27]:36754 "EHLO
        herzl.nuvoton.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725782AbfFYXVn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Jun 2019 19:21:43 -0400
X-Greylist: delayed 2751 seconds by postgrey-1.27 at vger.kernel.org; Tue, 25 Jun 2019 19:21:42 EDT
Received: from taln60.nuvoton.co.il (ntil-fw [212.199.177.25])
        by herzl.nuvoton.co.il (8.13.8/8.13.8) with ESMTP id x5PMZ754025278;
        Wed, 26 Jun 2019 01:35:08 +0300
Received: by taln60.nuvoton.co.il (Postfix, from userid 20053)
        id EA30261FCB; Wed, 26 Jun 2019 01:35:07 +0300 (IDT)
From:   Oshri Alkoby <oshrialkoby85@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com, peterhuewe@gmx.de,
        jarkko.sakkinen@linux.intel.com, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org, oshrialkoby85@gmail.com,
        oshri.alkoby@nuvoton.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-integrity@vger.kernel.org, gcwilson@us.ibm.com,
        kgoldman@us.ibm.com, nayna@linux.vnet.ibm.com,
        tomer.maimon@nuvoton.com
Subject: [PATCH v1 0/2] char: tpm: add new driver for tpm i2c ptp
Date:   Wed, 26 Jun 2019 01:35:01 +0300
Message-Id: <20190625223503.367710-1-oshrialkoby85@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch set adds support for TPM devices that implement the I2C
interface defined by TCG PTP specification.

The driver was tested on Raspberry-Pie 3, using Nuvoton NPCT75X TPM.

Oshri Alkoby (2):
  dt-bindings: tpm: add the TPM I2C PTP device tree binding
    documentation
  char: tpm: add new driver for tpm i2c ptp

 .../bindings/security/tpm/tpm-i2c-ptp.txt     |   17 +
 drivers/char/tpm/Kconfig                      |   22 +
 drivers/char/tpm/Makefile                     |    1 +
 drivers/char/tpm/tpm_i2c_ptp.c                | 1099 +++++++++++++++++
 4 files changed, 1139 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/security/tpm/tpm-i2c-ptp.txt
 create mode 100644 drivers/char/tpm/tpm_i2c_ptp.c

-- 
2.18.0

