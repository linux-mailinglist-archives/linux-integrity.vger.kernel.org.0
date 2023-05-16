Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C07704203
	for <lists+linux-integrity@lfdr.de>; Tue, 16 May 2023 02:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245635AbjEPACX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 May 2023 20:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245404AbjEPACW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 May 2023 20:02:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A21C5;
        Mon, 15 May 2023 17:02:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E47A96338F;
        Tue, 16 May 2023 00:02:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0390DC4339B;
        Tue, 16 May 2023 00:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684195339;
        bh=LnKHbAdRpI1KJD4fiXyTZMrBKkuwWBIC90dCzzd2R0I=;
        h=From:To:Cc:Subject:Date:From;
        b=agxgsPv129i8vSu5G32C1cUBmOEUo7ipN5KtnNxddydJYAWCRWr0ENRyU/qHiCg27
         WrvIkKeMM1KNhfGkhM7Dvqjded8ruMUDP68lIog3+j0Js4dUA23FEYYnn8nATB7qYX
         M/Ppg2+KB+/aqN49S4deBzCNYzkdyGtk75Vtd5HtK7cJntydSko0MiSegYCOYQrtQJ
         p4p0iwsJVp5LJs4Uf24Mn6pL7Sc5pn1uA/sciLW/TA7HUhd4g+ZbbsIaVgTcarh33W
         wov0OcFeHP/MD8wyZqTk6U95vXPd7jYT6DCLlc9w5gcvsCcGLXkYYaWU5bH/r2RFwX
         1C5Tc05xipxPw==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] tpmdd: three bug fixes for v6.4-rc2
Date:   Tue, 16 May 2023 03:02:08 +0300
Message-Id: <20230516000208.4008443-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The following changes since commit f1fcbaa18b28dec10281551dfe6ed3a3ed80e3d6:

  Linux 6.4-rc2 (2023-05-14 12:51:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkkojs/linux-tpmdd.git/ tpmdd-v6.4-rc2

for you to fetch changes up to e7d3e5c4b1dd50a70b31524c3228c62bb41bbab2:

  tpm/tpm_tis: Disable interrupts for more Lenovo devices (2023-05-16 02:48:23 +0300)

----------------------------------------------------------------
Hi, this pull request contains three bug fixes for recently discovered
issues.

BR, Jarkko

----------------------------------------------------------------
Jarkko Sakkinen (2):
      tpm_tis: Use tpm_chip_{start,stop} decoration inside tpm_tis_resume
      tpm: Prevent hwrng from activating during resume

Jerry Snitselaar (1):
      tpm/tpm_tis: Disable interrupts for more Lenovo devices

 drivers/char/tpm/tpm-chip.c      |  4 ++++
 drivers/char/tpm/tpm-interface.c | 10 ++++++++++
 drivers/char/tpm/tpm_tis.c       | 16 +++++++++++++++
 drivers/char/tpm/tpm_tis_core.c  | 43 ++++++++++++++++++----------------------
 include/linux/tpm.h              |  1 +
 5 files changed, 50 insertions(+), 24 deletions(-)
