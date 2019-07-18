Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C89066D27C
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Jul 2019 19:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbfGRREQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 Jul 2019 13:04:16 -0400
Received: from smtp2.infineon.com ([217.10.52.18]:8977 "EHLO
        smtp2.infineon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfGRREQ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 Jul 2019 13:04:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1563469454; x=1595005454;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4hO0cYXFvWHEsG55ryUcflS5zrXrsimLMhm8pJE0GnA=;
  b=oFZN8ctE3TW1zMnAXyELWLuwXYss/26D9GKIMX81zETIO3WuMHk5/9ds
   90tnFGdsShC3W7bCbt5PxAKn7nH5nqZvAJ6JEFX5zmRbxUoORl2E6mmWI
   JSaM/2lQJhJSHvO9QJvjmTsLQLNqYy+wMLFJ+s68MhCWGWxf1117ghQLQ
   s=;
IronPort-SDR: RqXuz9YDGrG14LKBfWsSpdJWarjIO/crD7Rpo1rPMQSVEd9Zbpqm94BlwTcwAjuqa0L3Ok9aaK
 xmVd7F8fo+Mw==
X-SBRS: None
X-IronPort-AV: E=McAfee;i="6000,8403,9322"; a="6919386"
X-IronPort-AV: E=Sophos;i="5.64,278,1559512800"; 
   d="scan'208";a="6919386"
Received: from unknown (HELO mucxv002.muc.infineon.com) ([172.23.11.17])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2019 19:04:13 +0200
Received: from MUCSE708.infineon.com (MUCSE708.infineon.com [172.23.7.82])
        by mucxv002.muc.infineon.com (Postfix) with ESMTPS;
        Thu, 18 Jul 2019 19:04:13 +0200 (CEST)
Received: from ISCNPC0VBFBX.infineon.com (172.23.8.247) by
 MUCSE708.infineon.com (172.23.7.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P256) id
 15.1.1591.10; Thu, 18 Jul 2019 19:04:13 +0200
From:   Alexander Steffen <Alexander.Steffen@infineon.com>
To:     <linux-integrity@vger.kernel.org>,
        <jarkko.sakkinen@linux.intel.com>
CC:     <tmaimon77@gmail.com>, <oshrialkoby85@gmail.com>,
        <Eyal.Cohen@nuvoton.com>, <Dan.Morav@nuvoton.com>,
        Alexander Steffen <Alexander.Steffen@infineon.com>
Subject: [RFC PATCH 0/2] tpm: Simple implementation of tpm_tis_i2c
Date:   Thu, 18 Jul 2019 19:03:53 +0200
Message-ID: <20190718170355.6464-1-Alexander.Steffen@infineon.com>
X-Mailer: git-send-email 2.18.0.windows.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.23.8.247]
X-ClientProxiedBy: MUCSE707.infineon.com (172.23.7.81) To
 MUCSE708.infineon.com (172.23.7.82)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Following the discussion in https://lkml.org/lkml/2019/7/5/303 I went ahead and created what I had in mind, trying to keep it as simple as possible. It is meant more as a starting point than a final implementation, as I'm not sure yet how to best integrate it with the existing tpm_tis_core (hence RFC):

It would probably be a cleaner interface, if locality and register address were two separate parameters. I did not implement it here, since that would have meant touching all the tpm_tis_core-based drivers. Also, I noticed that the kernel only ever uses locality 0 anyway. So maybe it would be even better to remove the locality parameter completely and just hardcode locality to 0 where necessary?

I also did not introduce any abstraction for register addresses, but simply remap the well-known addresses from the old TIS versions (which are used within tpm_tis_core) to the corresponding new addresses for I2C before accessing them. Again, it might be cleaner to have maybe an enum to address registers within tpm_tis_core and then a lookup table for the actual addresses in the low-level drivers?

IRQ support is deactivated for the moment, though it probably would work (or at least fall back to polling without catastrophic failures). But I'm not sure what exactly happens when the IRQ code path in tpm_tis_core accesses TPM_INT_VECTOR, which does not exist for I2C. Those accesses should just get ignored by the TPM, but actually testing it would have been more effort.

Speaking of tests, I only verified that basic communication with the TPM (i.e. reading/writing registers) works. For more tests, more test devices would be really helpful, which is why asked for that (https://lkml.org/lkml/2019/7/17/110).

Alexander Steffen (2):
  tpm: Make implementation of read16/read32/write32 optional
  tpm: Add tpm_tis_i2c backend for tpm_tis_core

 drivers/char/tpm/Kconfig        |  11 ++
 drivers/char/tpm/Makefile       |   1 +
 drivers/char/tpm/tpm_tis_core.h |  41 +++++-
 drivers/char/tpm/tpm_tis_i2c.c  | 233 ++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm_tis_spi.c  |  41 ------
 5 files changed, 283 insertions(+), 44 deletions(-)
 create mode 100644 drivers/char/tpm/tpm_tis_i2c.c

-- 
2.17.1

