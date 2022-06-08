Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D55543A77
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jun 2022 19:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbiFHRcE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jun 2022 13:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiFHRb4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jun 2022 13:31:56 -0400
Received: from smtp11.infineon.com (smtp11.infineon.com [IPv6:2a00:18f0:1e00:4::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A126F1CF;
        Wed,  8 Jun 2022 10:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1654709514; x=1686245514;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JU9DjpCG30LpZ+9PeqI7jIXrafkc1BEYv9uUrbRLnzI=;
  b=Rr4765dbHuudrLsHFeL3xKHCYIiZ0G4fjw9jdR+QJVins5UcE0evosO7
   IbjNty+88E/YWOw5L2ifu+gJ7IzsUiDbVFPYYTB9gPPcBvhECYuhFGZml
   RXOkL0jDEOM7RLQ9qqtXFUWF7lSqheC0kFmY/a1SsjdWULhwtTfFfKG84
   M=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="300189234"
X-IronPort-AV: E=Sophos;i="5.91,286,1647298800"; 
   d="scan'208";a="300189234"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 19:31:48 +0200
Received: from MUCSE814.infineon.com (MUCSE814.infineon.com [172.23.29.40])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS;
        Wed,  8 Jun 2022 19:31:47 +0200 (CEST)
Received: from MUCSE817.infineon.com (172.23.29.43) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.26; Wed, 8 Jun 2022
 19:31:47 +0200
Received: from ISCNPC0VBFBX.infineon.com (172.23.8.247) by
 MUCSE817.infineon.com (172.23.29.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.26; Wed, 8 Jun 2022 19:31:47 +0200
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
To:     <jarkko@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>
CC:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        <krzysztof.kozlowski+dt@linaro.org>,
        Johannes Holland <johannes.holland@infineon.com>,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v6 0/3] tpm_tis_i2c
Date:   Wed, 8 Jun 2022 19:31:10 +0200
Message-ID: <20220608173113.9232-1-Alexander.Steffen@infineon.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE804.infineon.com (172.23.29.30) To
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
 * v6:
   * Remove tpm-tis-i2c compatible for now
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
  dt-bindings: trivial-devices: Add Infineon SLB9673 TPM
  tpm: Add tpm_tis_verify_crc to the tpm_tis_phy_ops protocol layer
  tpm: Add tpm_tis_i2c backend for tpm_tis_core

 .../devicetree/bindings/trivial-devices.yaml  |   2 +
 drivers/char/tpm/Kconfig                      |  12 +
 drivers/char/tpm/Makefile                     |   1 +
 drivers/char/tpm/tpm_tis_core.c               |  14 +
 drivers/char/tpm/tpm_tis_core.h               |  10 +
 drivers/char/tpm/tpm_tis_i2c.c                | 391 ++++++++++++++++++
 6 files changed, 430 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_tis_i2c.c

-- 
2.25.1

