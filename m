Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59A164745B
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Dec 2022 17:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiLHQdW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 8 Dec 2022 11:33:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLHQdU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 8 Dec 2022 11:33:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81AF61533;
        Thu,  8 Dec 2022 08:33:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 44E8761FD3;
        Thu,  8 Dec 2022 16:33:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9F1C433D2;
        Thu,  8 Dec 2022 16:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670517198;
        bh=eP1E6RkrVjyINFJHL+hVeqSDWsVXBEt1602/LPV10Bs=;
        h=From:To:Cc:Subject:Date:From;
        b=i9TwCW/wcwgG3gZobIVdF1rZ5ICljOXCgVi6M3Tb3BzW+G624iorxweE0dgtTGWab
         pCSPP7ff+YXqeQWklrBC71MDiHRLEAlGNm0QXa1ozPtAQph299eOM5Q0uZINKrM5vS
         Oz6o6TM2kR0fisErMX/7WlhURyrln4C3H11XEsUhKmL/uX5GX9lr0LDNQXc2MJ5g34
         ZtVQwzRALpCdTqh9/PNWje8M99arNKYQwl69NWQlzoDES8RP2bUXCFTq62cU87giIw
         ikLofJiluOQwsGYm5bPu/1vNFMc879SsY2JZ9txR8rtsvylsgUGER9eCm0sM1ad2Jt
         x6+UJYGsjSYYQ==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] tpmdd updates for tpmdd-next-v6.2-rc1
Date:   Thu,  8 Dec 2022 16:33:08 +0000
Message-Id: <20221208163308.9989-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

This PR contains an unsorted collection of TPM fixes and one bug fix
for trusted keys.

BR, Jarkko

The following changes since commit 479174d402bcf60789106eedc4def3957c060bad:

  Merge tag 'platform-drivers-x86-v6.1-5' of git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86 (2022-12-07 12:37:35 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v6.2-rc1

for you to fetch changes up to eaabc245b02a0e0063068178624d2fc12ba91d69:

  tpm: st33zp24: remove pointless checks on probe (2022-12-08 16:20:47 +0000)

----------------------------------------------------------------
tpmdd updates for Linux v6.2-rc1

----------------------------------------------------------------
Ard Biesheuvel (1):
      tpm: Avoid function type cast of put_device()

Dmitry Torokhov (3):
      tpm: st33zp24: drop support for platform data
      tpm: st33zp24: switch to using gpiod API
      tpm: st33zp24: remove pointless checks on probe

Eddie James (2):
      tpm: tis_i2c: Fix sanity check interrupt enable mask
      tpm: Add flag to use default cancellation policy

Hanjun Guo (3):
      tpm: acpi: Call acpi_put_table() to fix memory leak
      tpm: tpm_crb: Add the missed acpi_put_table() to fix memory leak
      tpm: tpm_tis: Add the missed acpi_put_table() to fix memory leak

Michael Kelley (1):
      tpm/tpm_crb: Fix error message in __crb_relinquish_locality()

Sumit Garg (1):
      KEYS: trusted: tee: Make registered shm dependency explicit

Yuan Can (1):
      tpm/tpm_ftpm_tee: Fix error handling in ftpm_mod_init()

 drivers/char/tpm/eventlog/acpi.c         |  12 ++-
 drivers/char/tpm/st33zp24/i2c.c          | 142 +-----------------------------
 drivers/char/tpm/st33zp24/spi.c          | 145 +------------------------------
 drivers/char/tpm/st33zp24/st33zp24.c     |  39 +++++++--
 drivers/char/tpm/st33zp24/st33zp24.h     |   7 +-
 drivers/char/tpm/tpm-chip.c              |   7 +-
 drivers/char/tpm/tpm_crb.c               |  31 ++++---
 drivers/char/tpm/tpm_ftpm_tee.c          |   8 +-
 drivers/char/tpm/tpm_tis.c               |   9 +-
 drivers/char/tpm/tpm_tis_core.c          |  20 +++--
 drivers/char/tpm/tpm_tis_core.h          |   1 +
 drivers/char/tpm/tpm_tis_i2c.c           |   3 +-
 include/linux/platform_data/st33zp24.h   |  16 ----
 security/keys/trusted-keys/trusted_tee.c |   3 +-
 14 files changed, 108 insertions(+), 335 deletions(-)
 delete mode 100644 include/linux/platform_data/st33zp24.h
