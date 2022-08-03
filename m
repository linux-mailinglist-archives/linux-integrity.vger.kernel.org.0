Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F365893DF
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Aug 2022 23:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238779AbiHCVCu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Aug 2022 17:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238619AbiHCVCs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Aug 2022 17:02:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D715C975;
        Wed,  3 Aug 2022 14:02:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AE1E4B8227F;
        Wed,  3 Aug 2022 21:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC5CEC433C1;
        Wed,  3 Aug 2022 21:02:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659560565;
        bh=e+grTF5BE4esl7EzfvSL6GjdlRB7jhRFfHvw7jH6pxg=;
        h=From:To:Cc:Subject:Date:From;
        b=OZk4UIopQVoEbylvtTkTJUwOrpHDwWqYwZDK5TqVpbsJnc/OBciMhmH/iIaTNPk+m
         BQrT/EwwHs2eAjPdXNb2gphNWUp+XlFj3Rc25cQioXWtbOzjZ9CX6ffnLMwMwftgs/
         fiz3wM3DI7e7Wnmfw+BaEsqoxW9MEAccOobYTJ51TV+J9ThZQOIi2A1ZuMkwH/UcOI
         MTH2JL3rLzmdEswbZvY4HmyNafn6Tsifr5L9mYMhZC4pAVYiiHgL+ko0KyUYbwQkUB
         eaN6pOzDPOk3S/HBgbQgt9BlaSpL+dMG/BezZ3aXFJe5WyaUHwpZWgEd3cjJ3/CVlL
         AKtgWprzmiW0w==
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
Subject: [GIT PULL] tpmdd updates for v5.20
Date:   Thu,  4 Aug 2022 00:02:28 +0300
Message-Id: <20220803210228.158993-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Contains mostly TPM and also few keyring fixes.

BR, Jarkko

The following changes since commit 200e340f2196d7fd427a5810d06e893b932f145a:

  Merge tag 'pull-work.dcache' of git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs (2022-08-03 11:43:12 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.20

for you to fetch changes up to 863ed94c589fcd1984f4e3080f069d30508044bb:

  tpm: Add check for Failure mode for TPM2 modules (2022-08-03 23:56:20 +0300)

----------------------------------------------------------------
tpmdd updates for Linux v5.20

----------------------------------------------------------------
Alexander Steffen (3):
      dt-bindings: trivial-devices: Add Infineon SLB9673 TPM
      tpm: Add tpm_tis_verify_crc to the tpm_tis_phy_ops protocol layer
      tpm: Add tpm_tis_i2c backend for tpm_tis_core

Elvira Khabirova (1):
      pkcs7: support EC-RDSA/streebog in SignerInfo

Huacai Chen (1):
      tpm: eventlog: Fix section mismatch for DEBUG_SECTION_MISMATCH

Mårten Lindahl (1):
      tpm: Add check for Failure mode for TPM2 modules

Stefan Mahnke-Hartmann (1):
      tpm: Add upgrade/reduced mode support for TPM1.2 modules

Tianjia Zhang (4):
      X.509: Support parsing certificate using SM2 algorithm
      sign-file: Fix confusing error messages
      pkcs7: parser support SM2 and SM3 algorithms combination
      KEYS: asymmetric: enforce SM2 signature use pkey algo

Yang Li (1):
      tpm: fix platform_no_drv_owner.cocci warning

 .../devicetree/bindings/trivial-devices.yaml       |   2 +
 crypto/asymmetric_keys/pkcs7_parser.c              |  18 +
 crypto/asymmetric_keys/public_key.c                |   7 +-
 crypto/asymmetric_keys/x509_cert_parser.c          |   3 +
 drivers/char/tpm/Kconfig                           |  12 +
 drivers/char/tpm/Makefile                          |   1 +
 drivers/char/tpm/tpm.h                             |   1 +
 drivers/char/tpm/tpm1-cmd.c                        |   7 +-
 drivers/char/tpm/tpm2-cmd.c                        |   6 +
 drivers/char/tpm/tpm_tis_core.c                    |  14 +
 drivers/char/tpm/tpm_tis_core.h                    |  10 +
 drivers/char/tpm/tpm_tis_i2c.c                     | 390 +++++++++++++++++++++
 include/linux/tpm_eventlog.h                       |   2 +-
 scripts/sign-file.c                                |   2 +-
 14 files changed, 470 insertions(+), 5 deletions(-)
 create mode 100644 drivers/char/tpm/tpm_tis_i2c.c
