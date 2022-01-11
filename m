Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA8548A547
	for <lists+linux-integrity@lfdr.de>; Tue, 11 Jan 2022 02:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346267AbiAKBpK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jan 2022 20:45:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243903AbiAKBpJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jan 2022 20:45:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F797C06173F;
        Mon, 10 Jan 2022 17:45:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1CCBE6143F;
        Tue, 11 Jan 2022 01:45:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0802DC36AE9;
        Tue, 11 Jan 2022 01:45:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641865508;
        bh=977QHeQeMpm3HTrba7hyaODbT4x+9gGpD7XYJjWOC5A=;
        h=Date:From:To:Cc:Subject:From;
        b=W4hJYfaYXjmj8zc9Vk1CtHskIwUL1NmkTVK+NvbfWfpUWf7B3hyVy+nBDFKubpn07
         Im5RLwNfvbstlzlhBvBX4Lqk97YnreIpvF30h/dKiHK4mumHX4RFRGR3ABHXF1Nkxi
         lthgw2f0ybNvhukccHrDTCIqCYvBvNYB14Eeu0nYy2wJQbC7vAIhzfetiTFrAwcdyo
         Q+AAMExR34HB7pt9tWTeVNvijjB4cEXaESDQiKIRYPSH91lt0fUygeFxj56wZ4p28j
         Qpq6CrF14inXHTlK/vMJe6D5n/hX3DNozD1polje/NhgOxi8p9JcgWqUZQGtQl86os
         Qjn5lLnq5SsLg==
Date:   Tue, 11 Jan 2022 03:44:57 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [GIT PULL] TPM DEVICE DRIVER updates for v5.17 (fixed)
Message-ID: <YdzhGWLSIbc4muBZ@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

This is the same PR as eaerlier, expect the fixes tag has been corrected for
"tpm: fix potential NULL pointer access in tpm_del_char_device". The
earlier transcript follows after this sentence.

Other than bug fixes for TPM, includes a patch for asymmetric keys to allow
to look up and verify with self-signed certificates (keys without so called
Authority Key Identifier (AKID)) using a new "dn:" prefix in the query.

BR,
Jarkko

The following changes since commit e7c124bd04631973a3cc0df19ab881b56d8a2d50:

  Merge tag 'selinux-pr-20211228' of git://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux (2021-12-28 13:33:06 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.17-fixed

for you to fetch changes up to d99a8af48a3de727173415ccb17f6b6ba60d5573:

  lib: remove redundant assignment to variable ret (2022-01-09 00:18:54 +0200)

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

Colin Ian King (1):
      lib: remove redundant assignment to variable ret

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
 lib/asn1_encoder.c                        |   2 -
 16 files changed, 205 insertions(+), 161 deletions(-)
