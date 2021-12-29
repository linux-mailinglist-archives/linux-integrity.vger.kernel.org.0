Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8D6480EEE
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Dec 2021 03:33:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238398AbhL2CdZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 28 Dec 2021 21:33:25 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:34728 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhL2CdY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 28 Dec 2021 21:33:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B5896116D;
        Wed, 29 Dec 2021 02:33:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 570A6C36AEB;
        Wed, 29 Dec 2021 02:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640745203;
        bh=27QGy6tcsDryLMWNMkI1zKPKtVGmZ/7l48wgukdkdJY=;
        h=Date:From:To:Cc:Subject:From;
        b=r/TnGmlJI+HG2ZMquOTe6zs9zxFNvvM8965htoF+gW6awGAkXV2UbwtJ3x8r2iH50
         icuh4nWhSIlt5ftHnjH4k87s7hnpIxOEKIb8JrP73HAkLMsBfxA7FgGkDPT+9/3KQl
         renRv6KTIG3yg0mmQzhT5g1LdTT1H7S6/zI/AU4Wk7NRV9Ls3ObMuRXP5IZuFEdYRC
         CjbIDLl3RwW1tSTjHeNbDKQ2Q5MKJiLxTSPZDeS+tyOlgNJzSqhnuDIMsY3WmoxNPm
         rDRRu3d0L6H2nQrHlhqcLu2eUqayVb1qgX+VLxP36BI7cR10rGwUgLaOrLSk1FKwa3
         42WV5e4rbqQ0w==
Date:   Wed, 29 Dec 2021 04:33:21 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Andrew Zaborowski <andrew.zaborowski@intel.com>
Subject: [GIT PULL] TPM DEVICE DRIVER updates for v5.17
Message-ID: <YcvI8Uki51C2aMqe@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

Other than bug fixes for TPM, includes a patch for asymmetric keys to allow
to look up and verify with self-signed certificates (keys without so called
Authority Key Identifier (AKID)) using a new "dn:" prefix in the query.

BR,
Jarkko

The following changes since commit e7c124bd04631973a3cc0df19ab881b56d8a2d50:

  Merge tag 'selinux-pr-20211228' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux (2021-12-28 13:33:06 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.17

for you to fetch changes up to 035d19ee9b906f8a6937d44cc1dd1bf065be8641:

  tpm: fix NPE on probe for missing device (2021-12-29 03:44:50 +0200)

----------------------------------------------------------------
tpmdd updates for Linux v5.17

----------------------------------------------------------------
Andrew Zaborowski (1):
      keys: X.509 public key issuer lookup without AKID

AngeloGioacchino Del Regno (1):
      tpm: tpm_tis_spi_cr50: Add default RNG quality

Chen Jun (1):
      tpm: add request_locality before write TPM_INT_ENABLE

Christophe Jaillet (1):
      tpm_tis: Fix an error handling path in 'tpm_tis_core_init()'

Lino Sanfilippo (1):
      tpm: fix potential NULL pointer access in tpm_del_char_device

Patrick Williams (1):
      tpm: fix NPE on probe for missing device

Rob Barnes (1):
      char: tpm: cr50: Set TPM_FIRMWARE_POWER_MANAGED based on device property

Sohaib Mohamed (1):
      tpm/st33zp24: drop unneeded over-commenting

axelj (1):
      tpm: Add Upgrade/Reduced mode support for TPM2 modules

 crypto/asymmetric_keys/asymmetric_type.c  |  57 ++++++++++----
 crypto/asymmetric_keys/pkcs7_trust.c      |   6 +-
 crypto/asymmetric_keys/restrict.c         |  48 +++++++-----
 crypto/asymmetric_keys/x509_cert_parser.c |  10 +++
 crypto/asymmetric_keys/x509_public_key.c  |  10 +++
 drivers/char/tpm/st33zp24/st33zp24.c      | 122 +++++-------------------------
 drivers/char/tpm/tpm-chip.c               |  37 ++++++---
 drivers/char/tpm/tpm-sysfs.c              |   3 +
 drivers/char/tpm/tpm2-cmd.c               |   6 ++
 drivers/char/tpm/tpm_tis_core.c           |  14 +++-
 drivers/char/tpm/tpm_tis_i2c_cr50.c       |  16 +++-
 drivers/char/tpm/tpm_tis_spi_cr50.c       |  20 ++++-
 include/crypto/public_key.h               |   2 +-
 include/keys/asymmetric-type.h            |   3 +-
 include/linux/tpm.h                       |  10 +++
 15 files changed, 205 insertions(+), 159 deletions(-)
