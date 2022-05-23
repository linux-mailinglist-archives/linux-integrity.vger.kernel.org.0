Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A448531C9E
	for <lists+linux-integrity@lfdr.de>; Mon, 23 May 2022 22:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbiEWQ7j (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 May 2022 12:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238994AbiEWQ7h (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 May 2022 12:59:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C5C340D5;
        Mon, 23 May 2022 09:59:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 135E2614AB;
        Mon, 23 May 2022 16:59:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF590C385AA;
        Mon, 23 May 2022 16:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653325175;
        bh=JD4vUg5P0ha+qnAxEQ/1K+c2zyCjSh6N/g9oM1/e13s=;
        h=From:To:Cc:Subject:Date:From;
        b=hHEVLd+W+IKAK7huRJaRTprXZYDkmj/tkJXO5eY1IwPr4caapKhNueUPpQzFc57za
         NgyyRmm8MvuMsbpiiVWbf+k2cKQfe1y7iGbodIelhjKJ1Q+shafuEydxAm1REbARIa
         8Q5JKYumb4AFVVttum0/cu83SRg3uZHMiUN6yBfEbJc/Djhy660C1xqPD6p4nVI+fe
         lOFFezmlIAT5HhlHTvcaEiZFTTdGTKjW3G2wtTgtERDwuHZf+Hgm80pJFHK2rUY560
         /nELiROQKN6SCm3DSswNB+qkN9fnl9ldPDRo++t46tIQdWf4ma4DD4ERlPrBCA0OJc
         7Aw1nDWeYNjgg==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] TPM DEVICE DRIVER updates for v5.19-rc1
Date:   Mon, 23 May 2022 19:57:44 +0300
Message-Id: <20220523165744.48234-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The following changes since commit 4b0986a3613c92f4ec1bdc7f60ec66fea135991f:

  Linux 5.18 (2022-05-22 09:52:31 -1000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.19-rc1

for you to fetch changes up to 7f3113e3b9f7207f0bd57b5fdae1a1b9c8215e08:

  MAINTAINERS: add KEYS-TRUSTED-CAAM (2022-05-23 18:47:50 +0300)

----------------------------------------------------------------
tpmdd updates for v5.19-rc1

- Strictened validation of key hashes for SYSTEM_BLACKLIST_HASH_LIST.  An
  invalid hash format causes a compilation error.  Previously, they got
  included to the kernel binary but were silently ignored at run-time.
- Allow root user to append new hashes to the blacklist keyring.
- Trusted keys backed with Cryptographic Acceleration and Assurance Module
  (CAAM), which part of some of the new NXP's SoC's.  Now there is total
  three hardware backends for trusted keys: TPM, ARM TEE and CAAM.
- A scattered set of fixes and small improvements for the TPM driver.

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

----------------------------------------------------------------
Ahmad Fatoum (7):
      KEYS: trusted: allow use of TEE as backend without TCG_TPM support
      KEYS: trusted: allow use of kernel RNG for key material
      crypto: caam - determine whether CAAM supports blob encap/decap
      crypto: caam - add in-kernel interface for blob generator
      KEYS: trusted: Introduce support for NXP CAAM-based trusted keys
      doc: trusted-encrypted: describe new CAAM trust source
      MAINTAINERS: add KEYS-TRUSTED-CAAM

Haowen Bai (1):
      tpm/tpm_ftpm_tee: Return true/false (not 1/0) from bool functions

Jes B. Klinke (1):
      tpm: cr50: Add new device/vendor ID 0x504a6666

Johannes Holland (1):
      tpm: Remove read16/read32/write32 calls from tpm_tis_phy_ops

Mickaël Salaün (6):
      tools/certs: Add print-cert-tbs-hash.sh
      certs: Factor out the blacklist hash creation
      certs: Make blacklist_vet_description() more strict
      certs: Check that builtin blacklist hashes are valid
      certs: Allow root user to append signed hashes to the blacklist keyring
      certs: Explain the rationale to call panic()

Stefan Mahnke-Hartmann (2):
      tpm: Fix buffer access in tpm2_get_tpm_pt()
      tpm: Add field upgrade mode support for Infineon TPM2 modules

Uwe Kleine-König (1):
      char: tpm: cr50_i2c: Suppress duplicated error message in .remove()

Xiu Jianfeng (1):
      tpm: ibmvtpm: Correct the return value in tpm_ibmvtpm_probe()

 Documentation/admin-guide/kernel-parameters.txt    |  11 +
 Documentation/security/keys/trusted-encrypted.rst  |  60 +++++-
 MAINTAINERS                                        |  11 +
 certs/.gitignore                                   |   1 +
 certs/Kconfig                                      |  17 +-
 certs/Makefile                                     |  14 +-
 certs/blacklist.c                                  | 227 ++++++++++++++++-----
 crypto/asymmetric_keys/x509_public_key.c           |   3 +-
 drivers/char/tpm/tpm2-cmd.c                        |  17 +-
 drivers/char/tpm/tpm_ftpm_tee.c                    |   2 +-
 drivers/char/tpm/tpm_ibmvtpm.c                     |   1 +
 drivers/char/tpm/tpm_tis.c                         |  67 +++---
 drivers/char/tpm/tpm_tis_core.h                    |  58 ++++--
 drivers/char/tpm/tpm_tis_i2c_cr50.c                |  11 +-
 drivers/char/tpm/tpm_tis_spi.h                     |   4 -
 drivers/char/tpm/tpm_tis_spi_cr50.c                |   7 +-
 drivers/char/tpm/tpm_tis_spi_main.c                |  45 +---
 drivers/char/tpm/tpm_tis_synquacer.c               |  98 ++++-----
 drivers/crypto/caam/Kconfig                        |   3 +
 drivers/crypto/caam/Makefile                       |   1 +
 drivers/crypto/caam/blob_gen.c                     | 182 +++++++++++++++++
 drivers/crypto/caam/ctrl.c                         |  17 +-
 drivers/crypto/caam/intern.h                       |   1 +
 drivers/crypto/caam/regs.h                         |   4 +-
 include/keys/system_keyring.h                      |  14 +-
 include/keys/trusted-type.h                        |   2 +-
 include/keys/trusted_caam.h                        |  11 +
 include/soc/fsl/caam-blob.h                        | 103 ++++++++++
 scripts/check-blacklist-hashes.awk                 |  37 ++++
 .../integrity/platform_certs/keyring_handler.c     |  26 +--
 security/keys/Kconfig                              |  18 +-
 security/keys/trusted-keys/Kconfig                 |  38 ++++
 security/keys/trusted-keys/Makefile                |  10 +-
 security/keys/trusted-keys/trusted_caam.c          |  80 ++++++++
 security/keys/trusted-keys/trusted_core.c          |  45 +++-
 tools/certs/print-cert-tbs-hash.sh                 |  91 +++++++++
 36 files changed, 1056 insertions(+), 281 deletions(-)
 create mode 100644 drivers/crypto/caam/blob_gen.c
 create mode 100644 include/keys/trusted_caam.h
 create mode 100644 include/soc/fsl/caam-blob.h
 create mode 100755 scripts/check-blacklist-hashes.awk
 create mode 100644 security/keys/trusted-keys/Kconfig
 create mode 100644 security/keys/trusted-keys/trusted_caam.c
 create mode 100755 tools/certs/print-cert-tbs-hash.sh
