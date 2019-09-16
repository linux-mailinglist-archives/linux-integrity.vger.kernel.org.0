Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C38ECB381F
	for <lists+linux-integrity@lfdr.de>; Mon, 16 Sep 2019 12:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730124AbfIPKe7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 16 Sep 2019 06:34:59 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46327 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730032AbfIPKe7 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 16 Sep 2019 06:34:59 -0400
Received: by mail-pl1-f195.google.com with SMTP id q24so264182plr.13
        for <linux-integrity@vger.kernel.org>; Mon, 16 Sep 2019 03:34:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=jk4c4zL/SV4/PrtilS4c+jFyOdQUNqO3ciQy1rIE/SY=;
        b=quevloJw4lR3MVUUciTFxdwTWDGH8dVsv0zO3X31eKful7n7wB3M39yO6SW535tQMe
         xh3aGQZN25OyEMUmIU0k2uOymwc9vAWrL/FU20drZjUB8Zt4RDsPay3Vgzu/LLF0Szgf
         NBq76R/s9CLnmawH3+rhr44u/lIG9mODdgl4vPO94jgobvoignbJ+RjklOFVbxarqloi
         G1ehDQLxP78K21Q7R/+6+hY6vxqs59CmemKERAxt0ILhesRMmx6Yf7B988mcf7LlUPac
         8CLxzGsElZU78Dl5h0Bth6wafPySFHW1L3EBeYQQq5RQxO2flFEna13ZxDbx5aNHn+24
         4wGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jk4c4zL/SV4/PrtilS4c+jFyOdQUNqO3ciQy1rIE/SY=;
        b=Uhwq3CtJ1ga2qHaIg9q4Qi4Yhel7cqm0gExC7KkO7vy8XVB6RKOMmdsQ3OcOlUNfxU
         oEeebToSE1UQ0Ag+F+orT2JaRUpz4Xd5LsfhdOyKmXpSYtsXKfrA/awJiwzMenZLY45I
         /dE/92dDpUWy7YUARKb5lgrjC8faa4VuCuww7jMKM2GRjAevML6wvxfZP9laU32Z7e5/
         XaqbTCLzH86r5j1Vg12Fn1pxYB0WFZuJ+vkZ/0bt9u81J9yr3dHfhD+bY6lZCUrXfgbj
         J0xzjKYSmuAZO8lLLNPDhZaHHXnlo810VfBgWb22u5OEbKwsW01Auq3sy5Vg/U69tMbH
         2sTQ==
X-Gm-Message-State: APjAAAV42cGPmJdTtRQ8PVI7Uxa1Dc5keTVkjnamtSv4ImFFUXVIe6qD
        Ajh/WaZnsJEKLbSWZHFz9LOJWA==
X-Google-Smtp-Source: APXvYqxfcYkBTvJ7uuwN3uBS+HBZqwsL/gzNCNxd1XaFzZDDDNNOJaOUREQNLcpjdsfnMYNo612W+A==
X-Received: by 2002:a17:902:a983:: with SMTP id bh3mr62036620plb.311.1568630098536;
        Mon, 16 Sep 2019 03:34:58 -0700 (PDT)
Received: from localhost.localdomain ([117.252.69.68])
        by smtp.gmail.com with ESMTPSA id d14sm58256914pfh.36.2019.09.16.03.34.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 16 Sep 2019 03:34:57 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     jarkko.sakkinen@linux.intel.com, dhowells@redhat.com,
        peterhuewe@gmx.de
Cc:     keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-crypto@vger.kernel.org,
        linux-security-module@vger.kernel.org, herbert@gondor.apana.org.au,
        davem@davemloft.net, jgg@ziepe.ca, arnd@arndb.de,
        gregkh@linuxfoundation.org, jejb@linux.ibm.com,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        jsnitsel@redhat.com, linux-kernel@vger.kernel.org,
        daniel.thompson@linaro.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [Patch v6 0/4] Create and consolidate trusted keys subsystem
Date:   Mon, 16 Sep 2019 16:04:20 +0530
Message-Id: <1568630064-14887-1-git-send-email-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch-set does restructuring of trusted keys code to create and
consolidate trusted keys subsystem.

Also, patch #2 replaces tpm1_buf code used in security/keys/trusted.c and
crypto/asymmertic_keys/asym_tpm.c files to use the common tpm_buf code.

Changes in v6:
1. Switch TPM asymmetric code also to use common tpm_buf code. These
   changes required patches #1 and #2 update, so I have dropped review
   tags from those patches.
2. Incorporated miscellaneous comments from Jarkko.

Changes in v5:
1. Drop 5/5 patch as its more relavant along with TEE patch-set.
2. Add Reviewed-by tag for patch #2.
3. Fix build failure when "CONFIG_HEADER_TEST" and
   "CONFIG_KERNEL_HEADER_TEST" config options are enabled.
4. Misc changes to rename files.

Changes in v4:
1. Separate patch for export of tpm_buf code to include/linux/tpm.h
2. Change TPM1.x trusted keys code to use common tpm_buf
3. Keep module name as trusted.ko only

Changes in v3:

Move TPM2 trusted keys code to trusted keys subsystem.

Changes in v2:

Split trusted keys abstraction patch for ease of review.

Sumit Garg (4):
  tpm: Move tpm_buf code to include/linux/
  KEYS: Use common tpm_buf for trusted and asymmetric keys
  KEYS: trusted: Create trusted keys subsystem
  KEYS: trusted: Move TPM2 trusted keys code

 crypto/asymmetric_keys/asym_tpm.c                  | 101 +++---
 drivers/char/tpm/tpm-chip.c                        |   1 +
 drivers/char/tpm/tpm-interface.c                   |  56 ----
 drivers/char/tpm/tpm.h                             | 230 -------------
 drivers/char/tpm/tpm2-cmd.c                        | 308 +----------------
 include/Kbuild                                     |   1 -
 include/keys/{trusted.h => trusted_tpm.h}          |  49 +--
 include/linux/tpm.h                                | 270 ++++++++++++++-
 security/keys/Makefile                             |   2 +-
 security/keys/trusted-keys/Makefile                |   8 +
 .../{trusted.c => trusted-keys/trusted_tpm1.c}     |  92 +++---
 security/keys/trusted-keys/trusted_tpm2.c          | 368 +++++++++++++++++++++
 12 files changed, 728 insertions(+), 758 deletions(-)
 rename include/keys/{trusted.h => trusted_tpm.h} (77%)
 create mode 100644 security/keys/trusted-keys/Makefile
 rename security/keys/{trusted.c => trusted-keys/trusted_tpm1.c} (94%)
 create mode 100644 security/keys/trusted-keys/trusted_tpm2.c

-- 
2.7.4

