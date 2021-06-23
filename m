Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85EB53B1BB4
	for <lists+linux-integrity@lfdr.de>; Wed, 23 Jun 2021 15:56:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhFWN6U (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 23 Jun 2021 09:58:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:48822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231196AbhFWN6U (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 23 Jun 2021 09:58:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B5F66108E;
        Wed, 23 Jun 2021 13:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624456562;
        bh=ZxR4BovY53uDvOMSdze/R9rMzx/+26TaCSgXVB/sj1Q=;
        h=Date:From:To:Cc:Subject:From;
        b=k5I2pQA+lzyZhAXauzOM3OgRNgK20OwqM8AMBJtbLjIscKbp7oUuFtaIKNvQ2neUu
         HsDawwvt7r70fTimZSbHPhJRS3ZVqikroQiN5G5uLVVWOCM09JQ1FGT6UjRKCj6mja
         AUQTs/FpTK3SADxQHe+vFZXxcyKkZRlbog6npvGK5LohDzFW0wAK4gz1lqwg9IMOK8
         4nCQIJaBi6k94HIYGC42TxNx76RxUwF4HoEB0eJB24tLhyQTY2Pahhea6NuJ82f4eL
         qDzCxPUn7Tda0VxZ5MVqvcnuoNfilWaCPti9GcoCW1WQfKAcZGONH2il2zLxHX9fto
         vDL8GrPA8hEEg==
Date:   Wed, 23 Jun 2021 16:56:00 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jmorris@namei.org, dhowells@redhat.com, peterhuewe@gmx.de
Subject: [GIT PULL] TPM DEVICE DRIVER changes for v5.14
Message-ID: <20210623135600.n343aglmvu272fsg@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

Contains bug fixes for TPM, and support for signing modules using elliptic
curve keys, which I promised to pick up to my tree.

/Jarkko

The following changes since commit 0c18f29aae7ce3dadd26d8ee3505d07cc982df75:

  module: limit enabling module.sig_enforce (2021-06-22 11:13:19 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.14-rc1

for you to fetch changes up to 87e9688481163dee836c7f86e02f9aaf3240af2e:

  certs: Add support for using elliptic curve keys for signing modules (2021-06-23 16:51:04 +0300)

----------------------------------------------------------------
tpmdd updates for Linux v5.14-rc1

----------------------------------------------------------------
Amir Mizinski (1):
      tpm: add longer timeout for TPM2_CC_VERIFY_SIGNATURE

Jarkko Sakkinen (1):
      tpm: Replace WARN_ONCE() with dev_err_once() in tpm_tis_status()

Javier Martinez Canillas (1):
      tpm_tis_spi: add missing SPI device ID entries

Liguang Zhang (1):
      tpm_tis_spi: set default probe function if device id not match

Stefan Berger (2):
      certs: Trigger creation of RSA module signing key if it's not an RSA key
      certs: Add support for using elliptic curve keys for signing modules

Tian Tao (2):
      tpm_crb: Use IOMEM_ERR_PTR when function returns iomem
      char: tpm: move to use request_irq by IRQF_NO_AUTOEN flag

Yang Yingliang (1):
      tpm: fix some doc warnings in tpm1-cmd.c

Zhen Lei (1):
      tpm_tis: Use DEFINE_RES_MEM() to simplify code

 certs/Kconfig                         | 26 ++++++++++++++++++++++++++
 certs/Makefile                        | 21 +++++++++++++++++++++
 crypto/asymmetric_keys/pkcs7_parser.c |  8 ++++++++
 drivers/char/tpm/tpm1-cmd.c           |  4 ++--
 drivers/char/tpm/tpm2-cmd.c           |  2 +-
 drivers/char/tpm/tpm_crb.c            |  2 +-
 drivers/char/tpm/tpm_tis.c            |  6 +-----
 drivers/char/tpm/tpm_tis_core.c       | 25 ++++++++++++++++++-------
 drivers/char/tpm/tpm_tis_core.h       |  3 ++-
 drivers/char/tpm/tpm_tis_i2c_cr50.c   |  4 ++--
 drivers/char/tpm/tpm_tis_spi_main.c   | 14 ++++++++++----
 11 files changed, 92 insertions(+), 23 deletions(-)
