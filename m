Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12A55693FC9
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Feb 2023 09:38:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjBMIij (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Feb 2023 03:38:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbjBMIid (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Feb 2023 03:38:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 390E94C0A;
        Mon, 13 Feb 2023 00:38:30 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5D9D60EE0;
        Mon, 13 Feb 2023 08:38:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACDF2C433EF;
        Mon, 13 Feb 2023 08:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676277509;
        bh=FKtCydh9BD0e/LHKfKCIJTVoObje2MGUwpf/rlBD/OY=;
        h=Date:From:To:Cc:Subject:From;
        b=OoKbJzb/LKp0SqzjPLOahO8ejh9BisPvo/RLq66V5+mPYJaMoSF4YV4kB/hTDOaQX
         DzWyUl8wo+DO2uNxkLygN9Z/xWqK8B2Nr8o+g7vUhJZjU4nDhvqoevwRG3LpOjcO7t
         wKgwLogsVNqb1sJnVI/JHHua37NMkGQRd4VFwj70R/sMTxR6R7VsWGX8S3Sb/QtJcU
         8N1k/5sTCzsnrt54miZka0tR+EUzCtsl0H7m/NUY0Elk1mgBw+0qXv168+i3ae7CR2
         shyqXVuw9rkAJyfvHsi7No3LbmNfYqtatC0KYxuVx+My4xKPvzKBLrJILN8wjUbUsX
         fHfybME90AoZA==
Date:   Mon, 13 Feb 2023 10:38:26 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Matthew Garrett <mgarrett@aurora.tech>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] tpm: changes for v6.3-rc1
Message-ID: <Y+n3AoInyQkuyTfM@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
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

In additon to bug fixes, these are noteworthy changes:

* In TPM I2C drivers, migrate from probe() to probe_new() (a new
  driver model in I2C).
* TPM CRB: Pluton support
* Add duplicate hash detection to the blacklist keyring in order to
  give more meaningful klog output than e.g. [1].

[1] https://askubuntu.com/questions/1436856/ubuntu-22-10-blacklist-problem-blacklisting-hash-13-message-on-boot

The following changes since commit ceaa837f96adb69c0df0397937cd74991d5d821a:

  Linux 6.2-rc8 (2023-02-12 14:10:17 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpm-v6.3-rc1

for you to fetch changes up to 85b93bbd1c9768d09adebbe9f33bab0d4ec94404:

  tpm: add vendor flag to command code validation (2023-02-13 10:11:20 +0200)

----------------------------------------------------------------
tpm: v6.3-rc1

----------------------------------------------------------------
Arnd Bergmann (1):
      crypto: certs: fix FIPS selftest dependency

Denis Kenzior (1):
      KEYS: asymmetric: Fix ECDSA use via keyctl uapi

Eddie James (2):
      tpm: Use managed allocation for bios event log
      tpm: Add reserved memory event log

Julien Gomes (1):
      tpm: add vendor flag to command code validation

Matthew Garrett (1):
      tpm_crb: Add support for CRB devices based on Pluton

Thomas Weißschuh (3):
      certs: make blacklisted hash available in klog
      KEYS: Add new function key_create()
      certs: don't try to update blacklist keys

Uwe Kleine-König (5):
      tpm: st33zp24: Convert to i2c's .probe_new()
      tpm: tpm_i2c_atmel: Convert to i2c's .probe_new()
      tpm: tpm_i2c_infineon: Convert to i2c's .probe_new()
      tpm: tpm_i2c_nuvoton: Convert to i2c's .probe_new()
      tpm: tis_i2c: Convert to i2c's .probe_new()

 certs/blacklist.c                     |  21 +++---
 crypto/asymmetric_keys/Kconfig        |   2 +-
 crypto/asymmetric_keys/pkcs7_verify.c |   1 +
 crypto/asymmetric_keys/public_key.c   |  24 +++++-
 drivers/char/tpm/eventlog/acpi.c      |   5 +-
 drivers/char/tpm/eventlog/efi.c       |  13 ++--
 drivers/char/tpm/eventlog/of.c        |  35 ++++++++-
 drivers/char/tpm/st33zp24/i2c.c       |   5 +-
 drivers/char/tpm/tpm-chip.c           |   1 -
 drivers/char/tpm/tpm2-cmd.c           |   4 +-
 drivers/char/tpm/tpm_crb.c            | 100 ++++++++++++++++++++++---
 drivers/char/tpm/tpm_i2c_atmel.c      |   5 +-
 drivers/char/tpm/tpm_i2c_infineon.c   |   5 +-
 drivers/char/tpm/tpm_i2c_nuvoton.c    |   6 +-
 drivers/char/tpm/tpm_tis_i2c.c        |   5 +-
 include/acpi/actbl3.h                 |   1 +
 include/linux/key.h                   |   8 ++
 include/linux/tpm.h                   |   1 +
 security/keys/key.c                   | 137 +++++++++++++++++++++++++---------
 19 files changed, 293 insertions(+), 86 deletions(-)
