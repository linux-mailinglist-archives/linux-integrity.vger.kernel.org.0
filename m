Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6445D43AA1E
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Oct 2021 04:13:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbhJZCPa (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 25 Oct 2021 22:15:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbhJZCPa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 25 Oct 2021 22:15:30 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A266EC061745;
        Mon, 25 Oct 2021 19:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=4BpBMwhbp4cTdNECy5/dl0DfX2nI7p9CavpwvyepbW4=; b=ptW6/KAO6ueAdVlkOR1gy4orSa
        LOhnYmctq5RxtMX+q398vEWanUvV1+roVW3vSJu9Xi2fRxQUnWr8t1Nu49ImzzxjhenP6mfqVthvf
        rrGBIlRFR95tCiTRV++WN12vtkGqbCIRxmPSkyXOVz6imgQWdOG49+U6O+xLyCVbHLVLqYxqN0wIU
        n5SzmxD++SxVeTAHS0OpgwVaKNzslrygJbqXE/E7KaRr/WtxzHUprsJezlBE7cg3MwZ/MvNh10UiV
        5gOhBLNCFQYWUobMuoHMMV6M5v/GMwf7Fwi5zIVLHlr8tMFfvZ+efDhNr1vFQ+oZyZIB1Q8vpbRkz
        6klKLr3g==;
Received: from 83-245-197-237.elisa-laajakaista.fi ([83.245.197.237] helo=localhost)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <jarkko.sakkinen@iki.fi>)
        id 1mfBxU-0004Qi-BB; Tue, 26 Oct 2021 05:13:00 +0300
Date:   Tue, 26 Oct 2021 05:12:59 +0300
From:   Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        jmorris@namei.org, dhowells@redhat.com, peterhuewe@gmx.de
Subject: [GIT PULL] TPM DEVICE DRIVER changes for v5.16
Message-ID: <YXdkK4IH9J1xcMXb@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SA-Exim-Connect-IP: 83.245.197.237
X-SA-Exim-Mail-From: jarkko.sakkinen@iki.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

HI,

This pull request contains only bug fixes.

/Jarkko

The following changes since commit 3906fe9bb7f1a2c8667ae54e967dc8690824f4ea:

  Linux 5.15-rc7 (2021-10-25 11:30:31 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.16

for you to fetch changes up to 7eba41fe8c7bb01ff3d4b757bd622375792bc720:

  tpm_tis_spi: Add missing SPI ID (2021-10-26 05:03:34 +0300)

----------------------------------------------------------------
tpmdd updates for Linux v5.16

----------------------------------------------------------------
Cai Huoqing (1):
      tpm: tis: Kconfig: Add helper dependency on COMPILE_TEST

Dan Carpenter (1):
      tpm: Check for integer overflow in tpm2_map_response_body()

Hao Wu (1):
      tpm: fix Atmel TPM crash caused by too frequent queries

Mark Brown (1):
      tpm_tis_spi: Add missing SPI ID

 drivers/char/tpm/Kconfig            |  2 +-
 drivers/char/tpm/tpm2-space.c       |  3 +++
 drivers/char/tpm/tpm_tis_core.c     | 26 ++++++++++++++++++--------
 drivers/char/tpm/tpm_tis_core.h     |  4 ++++
 drivers/char/tpm/tpm_tis_spi_main.c |  1 +
 include/linux/tpm.h                 |  1 +
 6 files changed, 28 insertions(+), 9 deletions(-)
