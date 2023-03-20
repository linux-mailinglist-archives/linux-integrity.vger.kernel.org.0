Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4BB6C1396
	for <lists+linux-integrity@lfdr.de>; Mon, 20 Mar 2023 14:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjCTNhs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 20 Mar 2023 09:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbjCTNh3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 20 Mar 2023 09:37:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7251E25E22;
        Mon, 20 Mar 2023 06:37:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 11B40B80E8E;
        Mon, 20 Mar 2023 13:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD2DC433A7;
        Mon, 20 Mar 2023 13:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679319441;
        bh=T4iLvr9YDa5MXIlY9g1xcyhE6mTGTJL0Mvf2DbqSgVU=;
        h=Date:From:To:Cc:Subject:From;
        b=EObs2b4VEkBN7oFKIKGRInW7YLs7CopkP1jeCpB5zK6lKOyt+BKT+Ch4pQrcXhTuq
         XUI4nyT/vmfx7w/QG63f4xD1u07uS8KkAVcqd/Eny2y+l0m55qn8X5SS/NKeJu+4QZ
         wlwL8nPKG75N7PYYEEUkeLlUFQXLectIepMaGGLcCTCKV5BWwZui1nKIn7H2YrTCcc
         L3EZGLHVey3MeKkVd+r59LOYU2Py46sq9QSv6FJU8DR+qixiXkvzdCDE4JOYoiKkjR
         29FfPo9r9FrzIjQtSeDvJxVSzcTNbxsD6rxE+4PfRw5i1bJceKWrwPWmafckptYJLk
         n5LYFv5+7B8Gw==
Date:   Mon, 20 Mar 2023 15:37:18 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas =?utf-8?B?PT9JU08tODg1OS0xP1E/V2VpPURGc2NodWg/PQ==?= 
        <linux@weissschuh.net>, Matthew Garrett <mgarrett@aurora.tech>,
        Uwe =?utf-8?B?PT9JU08tODg1OS0xP1E/S2xlaW5lLUs9RjZuaWc/PQ==?= 
        <u.kleine-koenig@pengutronix.de>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] tpm: changes for v6.3-rc4
Message-ID: <20230320133718.m2z4kal4nxhofvbx@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

Sent because of a build fix for previous PR. Also couple of less important
fixes.

BR, Jarkko

The following changes since commit e8d018dd0257f744ca50a729e3d042cf2ec9da65:

  Linux 6.3-rc3 (2023-03-19 13:27:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpm-v6.3-rc4

for you to fetch changes up to 923c8dfa9a3640d4dcedd7df12b53254f7e6e4fc:

  tpm: fix build break in tpm-chip.c caused by AMD fTPM quirk (2023-03-20 15:27:03 +0200)

----------------------------------------------------------------
tpm: v6.3-rc4

----------------------------------------------------------------
James Bottomley (1):
      tpm: fix build break in tpm-chip.c caused by AMD fTPM quirk

Mark Hasemeyer (1):
      tpm: cr50: i2c: use jiffies to wait for tpm ready irq

Yu Zhe (1):
      tpm: remove unnecessary (void*) conversions

 drivers/char/tpm/eventlog/common.c  | 6 +++---
 drivers/char/tpm/tpm-chip.c         | 2 +-
 drivers/char/tpm/tpm_tis_i2c_cr50.c | 3 +--
 3 files changed, 5 insertions(+), 6 deletions(-)
