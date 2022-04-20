Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F171507F7A
	for <lists+linux-integrity@lfdr.de>; Wed, 20 Apr 2022 05:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348984AbiDTDO6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 19 Apr 2022 23:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239231AbiDTDO6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 19 Apr 2022 23:14:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D39612AF2;
        Tue, 19 Apr 2022 20:12:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2252616BA;
        Wed, 20 Apr 2022 03:12:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A92C385A7;
        Wed, 20 Apr 2022 03:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650424330;
        bh=Z5A8KlK9YEUt/DZ98fQJQCZ64hHMli/Zer7k5Vx667E=;
        h=Date:From:To:Cc:Subject:From;
        b=TQVXBTawNSgo8k0bE1cnoSn+6ejUPzSwOA2fWQwzCHSWinZNA6tR99/jxHRC+jXrG
         3B/ZKGGoKhyoI8nuwozpEGJ78Bwnlwoi9zrHREEYUIi1C0zBDmHTfhPUT4WoWmMVmF
         KDjxEPm8mlOPe3/QtTygidQD9RLHepuMlj8OiH9D9sJNEur7k/Nlik6gs3awmMlyUD
         fSFm4tmPYNf0Eij51R6k3KjmmDJBNpHOomRXsJmss5D+ipSvxiE/JJOAQk0LBFDU1k
         KGNmhmfxaMnuJWYYMF3+r8n3FrmVp3GjG67qSqjjTW3f9sAlOTpwX6Hnz8PU5xS/oz
         AoneKOmc9TQ0Q==
Date:   Wed, 20 Apr 2022 06:10:59 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>
Subject: [GIT PULL] TPM DEVICE DRIVER updates for tpmdd-next-v5.18-rc4
Message-ID: <Yl95wykQMHc/tIq8@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

Mickaël's patches to add signed hash to the blacklist keyring that were
left out from the original v5.18 PR. They should be safe to include to
rc4 as they've been in circulation for ages, and have been tested
throughly.

BR, Jarkko

The following changes since commit b7f73403a3e922c20bb278ba3cfcc3c61930d82a:

  Merge tag 'spi-fix-v5.18-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi (2022-04-19 10:30:43 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.18-rc4

for you to fetch changes up to fad7eba9464e58146ccc458afcf6f0667b5b27f8:

  certs: Explain the rationale to call panic() (2022-04-19 22:11:56 +0300)

----------------------------------------------------------------
tpmdd updates for Linux v5.18-rc4

----------------------------------------------------------------
Mickaël Salaün (6):
      tools/certs: Add print-cert-tbs-hash.sh
      certs: Factor out the blacklist hash creation
      certs: Make blacklist_vet_description() more strict
      certs: Check that builtin blacklist hashes are valid
      certs: Allow root user to append signed hashes to the blacklist keyring
      certs: Explain the rationale to call panic()

 MAINTAINERS                                        |   2 +
 certs/.gitignore                                   |   1 +
 certs/Kconfig                                      |  17 +-
 certs/Makefile                                     |  14 +-
 certs/blacklist.c                                  | 227 ++++++++++++++++-----
 crypto/asymmetric_keys/x509_public_key.c           |   3 +-
 include/keys/system_keyring.h                      |  14 +-
 scripts/check-blacklist-hashes.awk                 |  37 ++++
 .../integrity/platform_certs/keyring_handler.c     |  26 +--
 tools/certs/print-cert-tbs-hash.sh                 |  91 +++++++++
 10 files changed, 352 insertions(+), 80 deletions(-)
 create mode 100755 scripts/check-blacklist-hashes.awk
 create mode 100755 tools/certs/print-cert-tbs-hash.sh
