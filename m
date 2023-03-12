Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F1C46B6BC6
	for <lists+linux-integrity@lfdr.de>; Sun, 12 Mar 2023 22:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230240AbjCLVej (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 12 Mar 2023 17:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjCLVej (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 12 Mar 2023 17:34:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB24F305FC;
        Sun, 12 Mar 2023 14:34:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7F01660FE7;
        Sun, 12 Mar 2023 21:34:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F7A2C433D2;
        Sun, 12 Mar 2023 21:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678656876;
        bh=9UIug+mulbOycf4PKg6C3pefbSOW5DKGXI217kgj4fI=;
        h=Subject:From:To:Cc:Date:From;
        b=WttPcBCboYpTbzw13ic+GAUktti3CLkWQxphfapf6XdZ8m8VG4/BM98Us0JVKoqRz
         4DBXcD7u5BS/qZOtqU6AD3SKAB5hrIk/q17vZaeodMH/blFQ4Rk318Qb2tUCYUYhJe
         KzO+n92V2h0swg8bSY+gNWdpT0awx1UydhGerIs6+ymQx5Bq6zCQgQUM1p59cY/yiv
         WT0NG53mWOd/U7ecvXZ5JpSYzqBjldtwoBAfi0m/4AS+DTtNJMvdJbziXd9HVGyKJd
         0g3OOL+SpsZ3kDuYGdw/nakbpUBuvAhlOjIb94x1wPJqHOpMZVlaazBi2NHUQl2/W/
         Q0m25mYmlNmaw==
Message-ID: <698049d487a816fe3579200b2e02648d8d60b2be.camel@kernel.org>
Subject: [GIT PULL] tpm: changes for v6.3-rc3
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>,
        Matthew Garrett <mgarrett@aurora.tech>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Sun, 12 Mar 2023 23:34:33 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

Here's two additional bug fixes for v6.3.

BR, Jarkko

The following changes since commit 2e545d69bd43a97879309493864529194661bb43=
:

  Merge tag 'xfs-6.3-fixes-1' of git://git.kernel.org/pub/scm/fs/xfs/xfs-li=
nux (2023-03-12 09:47:08 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags=
/tpm-v6.3-rc3

for you to fetch changes up to f1324bbc4011ed8aef3f4552210fc429bcd616da:

  tpm: disable hwrng for fTPM on some AMD designs (2023-03-12 23:28:10 +020=
0)

----------------------------------------------------------------
tpm: v6.3-rc3

----------------------------------------------------------------
Mario Limonciello (1):
      tpm: disable hwrng for fTPM on some AMD designs

Morten Linderud (1):
      tpm/eventlog: Don't abort tpm_read_log on faulty ACPI address

 drivers/char/tpm/eventlog/acpi.c |  6 +++-
 drivers/char/tpm/tpm-chip.c      | 60 ++++++++++++++++++++++++++++++++-
 drivers/char/tpm/tpm.h           | 73 ++++++++++++++++++++++++++++++++++++=
++++
 3 files changed, 137 insertions(+), 2 deletions(-)
