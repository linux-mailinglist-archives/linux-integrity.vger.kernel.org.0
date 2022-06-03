Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B972453CB97
	for <lists+linux-integrity@lfdr.de>; Fri,  3 Jun 2022 16:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiFCOfu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 3 Jun 2022 10:35:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230390AbiFCOft (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Jun 2022 10:35:49 -0400
Received: from smtp14.infineon.com (smtp14.infineon.com [IPv6:2a00:18f0:1e00:4::6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3767D5045E;
        Fri,  3 Jun 2022 07:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1654266949; x=1685802949;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hKkj64qgHkXAPRzFlIQz7qBHbCyzr6tJpcfe1l/AAoM=;
  b=RMAoGFNOvYkDUS8ayhtR4BUZWnFrlF16l8dh19v6l1RGj5eZhvTVaejz
   ixgEkaiqBaYfKlqjo0eD7hzKM3CRTZydRxHsthIBEL2xX6XLjjRTNzRez
   I9rkOFgdThvD5mLlizplCoD4XY7nYKcDfAe0CuyR1RM+d3T9EK/UwQSVL
   c=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6400,9594,10366"; a="125104036"
X-IronPort-AV: E=Sophos;i="5.91,274,1647298800"; 
   d="scan'208";a="125104036"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp14.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2022 16:35:47 +0200
Received: from MUCSE805.infineon.com (MUCSE805.infineon.com [172.23.29.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS;
        Fri,  3 Jun 2022 16:35:46 +0200 (CEST)
Received: from MUCSE817.infineon.com (172.23.29.43) by MUCSE805.infineon.com
 (172.23.29.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Fri, 3 Jun 2022
 16:35:46 +0200
Received: from ISCNPC0VBFBX.infineon.com (172.23.8.247) by
 MUCSE817.infineon.com (172.23.29.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Fri, 3 Jun 2022 16:35:45 +0200
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
To:     <jarkko@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>
CC:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        <krzysztof.kozlowski+dt@linaro.org>,
        Johannes Holland <johannes.holland@infineon.com>,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v5 0/3] tpm_tis_i2c
Date:   Fri, 3 Jun 2022 16:35:29 +0200
Message-ID: <20220603143532.8202-1-Alexander.Steffen@infineon.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE814.infineon.com (172.23.29.40) To
 MUCSE817.infineon.com (172.23.29.43)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Changelog:
 * v5:
   * Rename tpm_tis-i2c to tpm-tis-i2c
   * Remove unused includes
 * v4:
   * Move changelog to cover letter
   * Add compatibles to trivial-devices.yaml
   * Split patch for CRC interface and implementation
   * Add tpm_tis_i2c prefix to all functions
   * Improve documentation for guard time and sanity check
   * Use for loop instead of while for retries
 * v3:
   * Document address_to_register function
   * Add tpm_tis_i2c prefix to address_to_register
   * Add #ifdef CONFIG_OF to of_tis_i2c_match
   * Fix typos
 * v2:
   * move CCs from copyright comment to commit message
   * fix an unchecked return code

Alexander Steffen (3):
  dt-bindings: trivial-devices: Add two I2C TPM devices
  tpm: Add tpm_tis_verify_crc to the tpm_tis_phy_ops protocol layer
  tpm: Add tpm_tis_i2c backend for tpm_tis_core

 .../devicetree/bindings/trivial-devices.yaml  |   4 +
 drivers/char/tpm/Kconfig                      |  12 +
 drivers/char/tpm/Makefile                     |   1 +
 drivers/char/tpm/tpm_tis_core.c               |  14 +
 drivers/char/tpm/tpm_tis_core.h               |  10 +
 drivers/char/tpm/tpm_tis_i2c.c                | 392 ++++++++++++++++++
 6 files changed, 433 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_tis_i2c.c

-- 
2.25.1

