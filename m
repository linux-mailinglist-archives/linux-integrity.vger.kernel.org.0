Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D13A831E48C
	for <lists+linux-integrity@lfdr.de>; Thu, 18 Feb 2021 04:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhBRDcX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Feb 2021 22:32:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:41628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229885AbhBRDcW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Feb 2021 22:32:22 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2104F60C3D;
        Thu, 18 Feb 2021 03:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613619101;
        bh=c7ZJ7SvGbLoYA4yllijdf6qOTWsWiQ5Rkd+YYUthhQo=;
        h=Date:From:To:Cc:Subject:From;
        b=hubX+h+oP6mb2WCOFKZxsAabsFB2DAoaUej6SLrivWfT8AJMx1aq+9rHLC/+mCfon
         OVwu6B35eGviudUgWdobiC7T1FE1HtG3hYW6X4jArsY3nhwd2UjhN69sbBG6qRhk3+
         2gWS+DQJYHhzgXedcryXfkjDnCPMgeu5DEwq9id3drWK5c18Fy5uUXKh6VJndRVcpP
         vufocbL8024qhD+CizlgqIdIIxJCjr1rdgvrOBLRAgX8+YAARsLw/UaYRcmTTd6auf
         1GqOajlkS0L22aFAFcLxOCutwLXvoKj0uHgMBGs0uPq/sNCBMztUtHVu5ZyvXJANwW
         NTTvrA7NJj2RA==
Date:   Thu, 18 Feb 2021 05:31:29 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jmorris@namei.org, dhowells@redhat.com, peterhuewe@gmx.de
Subject: [GIT PULL] TPM DEVICE DRIVER changes for v5.12
Message-ID: <YC3fkU2pLncCkeps@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Linus,

This now my "official" first PR for v5.12. There's still some known issues
in the tpm_tis driver *not& fixed in this first pull request, which trigger a
warning but do not overally collapse the kernel by any means.

The fixes are in good progress, but unfortunately there's still some fine
tuning required before I can include to a pull request. I'm sure we will
get them done around rc2/rc3. Better to make sure that the fixes do right
things right, rather than rush them to a PR.

That's also the reason why this comes so late. Sorry about that. I have
also kind of "reorg" going on with my maintainer workflows, given the
increased review activity in keyrings and SGX, which temporarily causes
a bit overhead until becoming "status quo".

New features
============

1. Cr50 I2C TPM driver.
2. Sysfs exports of PCR registers in TPM 2.0 chips.

Bug fixes
=========

*  This contains bug fixes for tpm_tis driver, which had a racy wait for
   hardware state change to be ready to send a command to the TPM chip. The
   bug has existed already since 2006, but has only made itself known in
   recent past. This is the same as the "last time" :-)
*  Otherwise there's bunch of fixes for not as alarming regressions. I
   think the list is about the same as last time, except I added fixes for
   some disjoint bugs in trusted keys that I found some time ago.

/Jarkko

The following changes since commit f40ddce88593482919761f74910f42f4b84c004b:

  Linux 5.11 (2021-02-14 14:32:24 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.12-rc1-v2

for you to fetch changes up to 8c657a0590de585b1115847c17b34a58025f2f4b:

  KEYS: trusted: Reserve TPM for seal and unseal operations (2021-02-16 10:40:28 +0200)

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
      tpm_tis: Fix check_locality for correct locality acquisition
      tpm_tis: Clean up locality release
      tpm: add sysfs exports for all banks of PCR registers
      ABI: add sysfs description for tpm exports of PCR registers

Jarkko Sakkinen (3):
      KEYS: trusted: Fix incorrect handling of tpm_get_random()
      KEYS: trusted: Fix migratable=1 failing
      KEYS: trusted: Reserve TPM for seal and unseal operations

Rikard Falkeborn (1):
      tpm/ppi: Constify static struct attribute_group

Sebastian Andrzej Siewior (1):
      tpm: Remove tpm_dev_wq_lock

 Documentation/ABI/stable/sysfs-class-tpm  |  14 +
 crypto/asymmetric_keys/restrict.c         |   7 +-
 drivers/char/tpm/Kconfig                  |  10 +
 drivers/char/tpm/Makefile                 |   2 +
 drivers/char/tpm/eventlog/tpm1.c          |   1 +
 drivers/char/tpm/tpm-chip.c               |   2 +
 drivers/char/tpm/tpm-dev-common.c         |   1 -
 drivers/char/tpm/tpm-sysfs.c              | 179 +++++++
 drivers/char/tpm/tpm.h                    |   4 -
 drivers/char/tpm/tpm_ppi.c                |   2 +-
 drivers/char/tpm/tpm_tis_core.c           |  50 +-
 drivers/char/tpm/tpm_tis_i2c_cr50.c       | 790 ++++++++++++++++++++++++++++++
 include/linux/tpm.h                       |  14 +-
 security/keys/trusted-keys/trusted_tpm1.c |  22 +-
 security/keys/trusted-keys/trusted_tpm2.c |  22 +-
 15 files changed, 1054 insertions(+), 66 deletions(-)
 create mode 100644 drivers/char/tpm/tpm_tis_i2c_cr50.c
