Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55AA52F192
	for <lists+linux-integrity@lfdr.de>; Fri, 20 May 2022 19:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240292AbiETRYw (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 May 2022 13:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352198AbiETRYv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 May 2022 13:24:51 -0400
Received: from smtp11.infineon.com (smtp11.infineon.com [IPv6:2a00:18f0:1e00:4::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BEA187DA3;
        Fri, 20 May 2022 10:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1653067489; x=1684603489;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BILEFO7OFJnSGLDg0SNK5vxBLhA8zQLyjIg6JwTmdXo=;
  b=BvvtvLV5RozgNr7Pftn81AIOS3leKR+bLut+9BhWoKQWzEZWHYP72glR
   FglSrZON9bsegM4xuDbdyAXLDJX3Ab0NV9YsaOT0vvTOClpgYkWFxzdad
   YS4zV2Cc0l68EtCP4zY+PiGK5/ox2PPPbt2MzLW8sEdPP9UqCAvf9N0dT
   8=;
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="296154464"
X-IronPort-AV: E=Sophos;i="5.91,240,1647298800"; 
   d="scan'208";a="296154464"
Received: from unknown (HELO mucxv003.muc.infineon.com) ([172.23.11.20])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 19:24:47 +0200
Received: from MUCSE819.infineon.com (MUCSE819.infineon.com [172.23.29.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mucxv003.muc.infineon.com (Postfix) with ESMTPS;
        Fri, 20 May 2022 19:24:46 +0200 (CEST)
Received: from MUCSE817.infineon.com (172.23.29.43) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Fri, 20 May
 2022 19:24:46 +0200
Received: from ISCNPC0VBFBX.infineon.com (172.23.8.247) by
 MUCSE817.infineon.com (172.23.29.43) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 20 May 2022 19:24:45 +0200
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
To:     <jarkko@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-integrity@vger.kernel.org>
CC:     Alexander Steffen <Alexander.Steffen@infineon.com>,
        <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        <krzysztof.kozlowski+dt@linaro.org>,
        Johannes Holland <johannes.holland@infineon.com>,
        Amir Mizinski <amirmizi6@gmail.com>
Subject: [PATCH v3 0/2] tpm_tis_i2c
Date:   Fri, 20 May 2022 19:24:20 +0200
Message-ID: <20220520172422.4309-1-Alexander.Steffen@infineon.com>
X-Mailer: git-send-email 2.28.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE824.infineon.com (172.23.29.55) To
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

Johannes asked me to take over this series. I've decided to split off the
later patches from this series, since it was suggested to split those changes
into multiple patches and I don't want to blow up this series with too many
changes that are not strictly necessary for the I2C driver to work correctly.
So let's first concentrate on getting the basic functionality right, then we
can work on additional improvements.

I've addressed all review comments for patch 1/2.

Patch 2/2 is unmodified.

Johannes Holland (2):
  tpm: Add tpm_tis_i2c backend for tpm_tis_core
  tpm: Add tpm_tis_verify_crc to the tpm_tis_phy_ops protocol layer

 drivers/char/tpm/Kconfig        |  12 +
 drivers/char/tpm/Makefile       |   1 +
 drivers/char/tpm/tpm_tis_core.c |  14 ++
 drivers/char/tpm/tpm_tis_core.h |  10 +
 drivers/char/tpm/tpm_tis_i2c.c  | 405 ++++++++++++++++++++++++++++++++
 5 files changed, 442 insertions(+)
 create mode 100644 drivers/char/tpm/tpm_tis_i2c.c

-- 
2.25.1

