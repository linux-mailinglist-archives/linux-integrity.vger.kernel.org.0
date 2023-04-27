Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF796F04C3
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Apr 2023 13:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243264AbjD0LLc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 27 Apr 2023 07:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243111AbjD0LLb (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 27 Apr 2023 07:11:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 955B010F3;
        Thu, 27 Apr 2023 04:11:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2C5DB63C9F;
        Thu, 27 Apr 2023 11:11:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04595C433D2;
        Thu, 27 Apr 2023 11:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682593889;
        bh=3qkdGkDVhAzlokV4bH3J7Mc6rEoeNzp0/7iDn+iZF8g=;
        h=From:To:Cc:Subject:Date:From;
        b=PFWd5JcZvRwQpmplkE0CStlz9cu42zEE+DSGLQAV0CcG5vJkBfc4moTFJH/MAU6zz
         x190DKJb/iUtYi4YAffeVihCnlvHgrPcyhKc5y372wirHPnBtW2tFu125ELMPBfIbv
         invITwIm3UtXn5OrN3Zm4ZSvJ/O6SL7ZCxzwKZq7WAi6rVbyq2LT3zx3c1qItx7vAT
         G2p61VAhNZm+FkZd5fZNu8M5LPEhVf8TFcH8OhjzH7Ur4rTzqTKvKqfZ6WlGgnPr/Q
         zkCcheVNUWaINF75+nVJwxhQK7KGXgyTyx4G3KYMDjycOPzgQR0SA3CNDn2gUoDmXi
         JqjH3Ip+nmWtw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] tpmdd: a critical bug fix for v6.4-rc1
Date:   Thu, 27 Apr 2023 14:11:25 +0300
Message-Id: <20230427111125.13769-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The following changes since commit 6e98b09da931a00bf4e0477d0fa52748bf28fcce:

  Merge tag 'net-next-6.4' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2023-04-26 16:07:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-v6.4-rc1-fix

for you to fetch changes up to e2f14081c68395f0b0f9072bbf5e56450b1cb3f8:

  tpm: Re-enable TPM chip boostrapping non-tpm_tis TPM drivers (2023-04-27 14:01:45 +0300)

----------------------------------------------------------------
This PR fixes a critical bug in my first pull request.

Link: https://lore.kernel.org/all/ZEjqhwHWBnxcaRV5@xpf.sh.intel.com/

----------------------------------------------------------------
Jarkko Sakkinen (1):
      tpm: Re-enable TPM chip boostrapping non-tpm_tis TPM drivers

 drivers/char/tpm/tpm-chip.c     | 22 +++++++++++++++++++---
 drivers/char/tpm/tpm.h          |  2 +-
 drivers/char/tpm/tpm_tis_core.c |  2 +-
 include/linux/tpm.h             | 15 +++++++++------
 4 files changed, 30 insertions(+), 11 deletions(-)
