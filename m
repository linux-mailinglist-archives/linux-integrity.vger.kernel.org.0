Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9903082BE
	for <lists+linux-integrity@lfdr.de>; Fri, 29 Jan 2021 01:55:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhA2AzJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 Jan 2021 19:55:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:40050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229885AbhA2AzI (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 Jan 2021 19:55:08 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C7B364D99;
        Fri, 29 Jan 2021 00:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611881667;
        bh=OVZCXw8xUR4DgoBTz5oEYi6C77szTOrH6Jp+YE8Le7k=;
        h=Date:From:To:Cc:Subject:From;
        b=DVUGX0COHMvCh2ecG+AJxFqQtVszuyqwTOBATKE5MR4yFDAHpOfAHoMKGR78MZAbc
         fQcOp8pbwQ9hJsZRGCbbYL3GdSGYymFdGSu700KOgdJ2ViSCJTtTWSJNBcTFdiNA5I
         LTTSc7RjskUO8FAVwzT9G0Sf7K325Qif+iepGZCZMo16NAMYWCqRQpZ1UuuP7gkmAY
         nEZJtwYRnglkx3fiuMFowoF4qoc9CyjglBwr+TjFGOFjCqPX+J3BxskPwp9yUUiIih
         I3Rba0OfTTLbkp7JBCqvF+swfWIFCp16kHqJ36BmThwS9oFuy9OPPagePIdhXD6jLx
         AMTXlw744re1Q==
Date:   Fri, 29 Jan 2021 02:54:23 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jmorris@namei.org, dhowells@redhat.com, peterhuewe@gmx.de
Subject: [GIT PULL] tpmdd updates for v5.12-rc1
Message-ID: <YBNcv8jLEDE8C/IW@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

This contains bug fixes for tpm_tis driver, which had a racy wait for
hardware state change to be ready to send a command to the TPM chip. The
bug has existed already since 2006, but has only made itself known in
recent past.

There's also couple of new features:

1. Cr50 I2C driver.
2. Sysfs exports of PCR registers in TPM 2.0 chips.

/Jarkko

The following changes since commit 909b447dcc45db2f9bd5f495f1d16c419812e6df:

  Merge tag 'net-5.11-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2021-01-28 15:24:43 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-v5.12-rc1

for you to fetch changes up to 6171fb34b146ecb5ccc6864e1c34526941fe5d83:

  tpm_tis: Clean up locality release (2021-01-29 02:27:15 +0200)

----------------------------------------------------------------
tpmdd updates for Linux v5.12-rc1

----------------------------------------------------------------
Andrew Zaborowski (1):
      keys: Update comment for restrict_link_by_key_or_keyring_chain

Duncan Laurie (1):
      char: tpm: add i2c driver for cr50

Gustavo A. R. Silva (1):
      tpm: Fix fall-through warnings for Clang

James Bottomley (4):
      tpm: add sysfs exports for all banks of PCR registers
      ABI: add sysfs description for tpm exports of PCR registers
      tpm_tis: Fix check_locality for correct locality acquisition
      tpm_tis: Clean up locality release

Sebastian Andrzej Siewior (1):
      tpm: Remove tpm_dev_wq_lock

 Documentation/ABI/stable/sysfs-class-tpm |  14 +
 crypto/asymmetric_keys/restrict.c        |   7 +-
 drivers/char/tpm/Kconfig                 |  10 +
 drivers/char/tpm/Makefile                |   2 +
 drivers/char/tpm/eventlog/tpm1.c         |   1 +
 drivers/char/tpm/tpm-dev-common.c        |   1 -
 drivers/char/tpm/tpm-sysfs.c             | 179 +++++++
 drivers/char/tpm/tpm_tis_core.c          |  50 +-
 drivers/char/tpm/tpm_tis_i2c_cr50.c      | 790 +++++++++++++++++++++++++++++++
 include/linux/tpm.h                      |   9 +-
 10 files changed, 1011 insertions(+), 52 deletions(-)
 create mode 100644 drivers/char/tpm/tpm_tis_i2c_cr50.c
