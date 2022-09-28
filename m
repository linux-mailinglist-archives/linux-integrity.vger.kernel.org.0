Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4C75ED253
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Sep 2022 02:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbiI1A67 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 27 Sep 2022 20:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbiI1A67 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 27 Sep 2022 20:58:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D050115F7F;
        Tue, 27 Sep 2022 17:58:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1FC661CCB;
        Wed, 28 Sep 2022 00:58:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B613C433D6;
        Wed, 28 Sep 2022 00:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664326737;
        bh=3DddTk1dXHvfN9c0by+e0pAk5XXBE1VCE00TpTF6dDo=;
        h=From:To:Cc:Subject:Date:From;
        b=MXBk7YjOssZ1oz4ySvSwgAylDmV/tM3q/ouIILxsXh8biS0IeZdydPSm8s7EIC3VU
         UeqQ4FxM6/AEFbgc4PYZLNQf0iF/HNrUDXEskMUEr/80QzYrvMbdPPUaSvbNDBSy00
         Zum9+kb1QuI0O/Lwi1ert60ES0o8CvQaV6884f0zGn/eu7K5p7P64iu7ryya+0OkTb
         Btg5E78O2Rh1tlqwCdcwT2g21tHuCfl6vd49TITALzK4gNar7mU5MfMgCjO9O8APPv
         8AXg2GQcdCilr+yKVXPNUzNqICzHGCYUySCoDdfd/G9EvfGi4vpHicAQr3Gj7hfF/i
         4ga6IAIVInyJA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] linux-tpmdd updates for v6.0-rc1
Date:   Wed, 28 Sep 2022 03:58:52 +0300
Message-Id: <20220928005852.10729-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

Just some bug fixes.

BR, Jarkko

The following changes since commit f76349cf41451c5c42a99f18a9163377e4b364ff:

  Linux 6.0-rc7 (2022-09-25 14:01:02 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v6.0-rc1

for you to fetch changes up to 603fd3d42e144ca36e8340c81b0144c5e7f8b9c2:

  selftest: tpm2: Add Client.__del__() to close /dev/tpm* handle (2022-09-28 03:53:47 +0300)

----------------------------------------------------------------
tpmdd updates for Linux v6.0-rc1

----------------------------------------------------------------
Stefan Berger (1):
      selftest: tpm2: Add Client.__del__() to close /dev/tpm* handle

Vincenzo Frascino (1):
      security/keys: Remove inconsistent __user annotation

Wolfram Sang (1):
      char: move from strlcpy with unused retval to strscpy

 drivers/char/tpm/tpm_ppi.c           | 2 +-
 security/keys/keyring.c              | 2 +-
 tools/testing/selftests/tpm2/tpm2.py | 4 ++++
 3 files changed, 6 insertions(+), 2 deletions(-)
