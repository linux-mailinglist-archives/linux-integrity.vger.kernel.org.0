Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65E0F6F2935
	for <lists+linux-integrity@lfdr.de>; Sun, 30 Apr 2023 16:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbjD3Ods (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 30 Apr 2023 10:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbjD3Odr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 30 Apr 2023 10:33:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4283B1BFF;
        Sun, 30 Apr 2023 07:33:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D062B60B3C;
        Sun, 30 Apr 2023 14:33:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9B3AC433EF;
        Sun, 30 Apr 2023 14:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682865225;
        bh=D6PyAACGGIHCjf0/eKaiMxPT+GM7jDwLMPX8hGlS7D8=;
        h=From:To:Cc:Subject:Date:From;
        b=FUauZpC8UD+Q1hLnNevFkdl3QJ6fGoNTj5DHpuPXWuu/xWe1ARiFbCS30BUD0nwZ/
         /gOL1kd3HvSs+G/diOW1+8W0QeoovJZ0l4BmYCMXB0u7VC1t/aouUcMlkSKQiyb+yR
         1eWBJBWVLJAW1zTvbQH64d3sufBw/t9qR1YOPoyMbr9HGtxAhB9Z/rhkqlq6RuycNm
         8o/yboIiTvrNFui4gkary/ln8sj72kwf1zRvGwtD+Nvj6MYUb4sDxE96B/z8kADVvG
         avUktsL4v8yIAdaWvdajRhD0d4ppoIFK1adGkQp0YHe8oZcV/FARvi5J1tACNbhGve
         o3SHHry2p/Scg==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] tpmdd: a critical bug fix for v6.4-rc1 (v2)
Date:   Sun, 30 Apr 2023 17:33:42 +0300
Message-Id: <20230430143342.790113-1-jarkko@kernel.org>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-v6.4-rc1-fix-v2

for you to fetch changes up to 0c8862de05c1a087795ee0a87bf61a6394306cc0:

  tpm: Re-enable TPM chip boostrapping non-tpm_tis TPM drivers (2023-04-28 13:06:36 +0000)

----------------------------------------------------------------
This PR fixes a critical bug in my first pull request. I fixed the
cherry pick issue and tested with real hardare and libvirt/qemu plus
swtpm.

----------------------------------------------------------------
Jarkko Sakkinen (1):
      tpm: Re-enable TPM chip boostrapping non-tpm_tis TPM drivers

 drivers/char/tpm/tpm-chip.c     | 22 +++++++++++++++++++---
 drivers/char/tpm/tpm.h          |  2 +-
 drivers/char/tpm/tpm_tis_core.c |  2 +-
 include/linux/tpm.h             | 13 +++++++------
 4 files changed, 28 insertions(+), 11 deletions(-)
