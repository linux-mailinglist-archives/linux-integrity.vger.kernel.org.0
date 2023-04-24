Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0130E6ED06F
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Apr 2023 16:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjDXOli (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Apr 2023 10:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjDXOli (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Apr 2023 10:41:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2350A61AB;
        Mon, 24 Apr 2023 07:41:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6500619F4;
        Mon, 24 Apr 2023 14:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9714FC433D2;
        Mon, 24 Apr 2023 14:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682347296;
        bh=fSrcPcZw/GPmGI8FgVzCOdJ5NelYMqDiFY1OsK1Lsgs=;
        h=From:To:Cc:Subject:Date:From;
        b=Z5+L3YkKOEerC6ue9wx2P+AUWTXrB4HFZ452zckBf6Nb9lUGt/oqqRm8l/rCm1Z85
         6vuyM9+GEIz7wkbvVGET3vQDuWQ1HcKsCrAWcN5XbSwcD5Mnle6oOVOboMS5P3VPbu
         sLjnTgfPiZZuvk9ebWQAumNrRgx78fYkVAQSNEWeQWeSLdOWRh3k2vA/QrmD1fhSLN
         o0l+QGEsdSzFptQNxH+OCQVcQUye4gMyeG9unGDClkZ/CvBGmLXzD6tQJd4Tf4Qk6B
         iLf6NXWbE1IvRuOCOQjmwbKPURtwRQmaGcCZrNG8xqDJUP9i8RDEtCnCYYedApV+lA
         U9xWUXUslokeA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Martin Dimov <martin@dmarto.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] tpmdd: changes for v6.4-rc1
Date:   Mon, 24 Apr 2023 17:41:30 +0300
Message-Id: <20230424144130.1084795-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The following changes since commit 457391b0380335d5e9a5babdec90ac53928b23b4:

  Linux 6.3 (2023-04-23 12:02:52 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-v6.4-rc1

for you to fetch changes up to bd8621ca1510e6e802df9855bdc35a04a3cfa932:

  tpm: Add !tpm_amd_is_rng_defective() to the hwrng_unregister() call site (2023-04-24 16:15:53 +0300)

----------------------------------------------------------------
Two major features are included into this pull request. The links for
the landed patch sets are below.

The .machine keyring, used for Machine Owner Keys (MOK), acquired the
ability to store only CA enforced keys, and put rest to the .platform
keyring, thus separating the code signing keys from the keys that are
used to sign certificates. This essentially unlocks the use of the
.machine keyring as a trust anchor for IMA. It is an opt-in feature,
meaning that the additional contraints won't brick anyone who does not
care about them.

The 2nd feature is the enablement of interrupt based transactions with
discrete TPM chips (tpm_tis). There was code for this existing but it
never really worked so I consider this a new feature rather than a bug
fix. Before the driver just falled back to the polling mode.

Link: https://lore.kernel.org/linux-integrity/a93b6222-edda-d43c-f010-a59701f2aeef@gmx.de/
Link: https://lore.kernel.org/linux-integrity/20230302164652.83571-1-eric.snowberg@oracle.com/

----------------------------------------------------------------
Eric Snowberg (6):
      KEYS: Create static version of public_key_verify_signature
      KEYS: Add missing function documentation
      KEYS: X.509: Parse Basic Constraints for CA
      KEYS: X.509: Parse Key Usage
      KEYS: CA link restriction
      integrity: machine keyring CA configuration

Haris Okanovic (1):
      tpm_tis: fix stall after iowrite*()s

Jarkko Sakkinen (1):
      tpm: Add !tpm_amd_is_rng_defective() to the hwrng_unregister() call site

Krzysztof Kozlowski (2):
      tpm: st33zp24: Mark ACPI and OF related data as maybe unused
      tpm: tpm_tis_spi: Mark ACPI and OF related data as maybe unused

Lino Sanfilippo (14):
      tpm, tpm_tis: Avoid cache incoherency in test for interrupts
      tpm, tpm_tis: Claim locality before writing TPM_INT_ENABLE register
      tpm, tpm_tis: Disable interrupts if tpm_tis_probe_irq() failed
      tpm, tpm_tis: Do not skip reset of original interrupt vector
      tpm, tpm_tis: Claim locality before writing interrupt registers
      tpm, tpm_tis: Only handle supported interrupts
      tpm, tpm_tis: Move interrupt mask checks into own function
      tpm, tpm_tis: do not check for the active locality in interrupt handler
      tpm, tpm: Implement usage counter for locality
      tpm, tpm_tis: Request threaded interrupt handler
      tpm, tpm_tis: Claim locality in interrupt handler
      tpm, tpm_tis: Claim locality when interrupts are reenabled on resume
      tpm, tpm_tis: startup chip before testing for interrupts
      tpm, tpm_tis: Enable interrupt test

Mark Hasemeyer (1):
      tpm: cr50: i2c: use jiffies to wait for tpm ready irq

Uwe Kleine-König (3):
      tpm/tpm_ftpm_tee: Convert to platform remove callback returning void
      tpm/tpm_tis: Convert to platform remove callback returning void
      tpm/tpm_tis_synquacer: Convert to platform remove callback returning void

Yu Zhe (1):
      tpm: remove unnecessary (void*) conversions

 certs/system_keyring.c                    |  14 +-
 crypto/asymmetric_keys/restrict.c         |  40 ++++
 crypto/asymmetric_keys/x509_cert_parser.c |  50 +++++
 drivers/char/tpm/eventlog/common.c        |   6 +-
 drivers/char/tpm/st33zp24/i2c.c           |   4 +-
 drivers/char/tpm/st33zp24/spi.c           |   4 +-
 drivers/char/tpm/tpm-chip.c               |  41 ++--
 drivers/char/tpm/tpm.h                    |   1 +
 drivers/char/tpm/tpm_ftpm_tee.c           |   6 +-
 drivers/char/tpm/tpm_tis.c                |  51 ++++-
 drivers/char/tpm/tpm_tis_core.c           | 299 ++++++++++++++++++------------
 drivers/char/tpm/tpm_tis_core.h           |   5 +-
 drivers/char/tpm/tpm_tis_i2c_cr50.c       |   3 +-
 drivers/char/tpm/tpm_tis_spi_main.c       |   4 +-
 drivers/char/tpm/tpm_tis_synquacer.c      |   6 +-
 include/crypto/public_key.h               |  28 +++
 security/integrity/Kconfig                |  23 ++-
 security/integrity/digsig.c               |   8 +-
 18 files changed, 431 insertions(+), 162 deletions(-)
