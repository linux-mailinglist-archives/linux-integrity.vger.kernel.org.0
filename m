Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B283D5F4AEF
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Oct 2022 23:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbiJDVaL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Oct 2022 17:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiJDVaJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Oct 2022 17:30:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E60EEE13;
        Tue,  4 Oct 2022 14:30:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 39ED06152F;
        Tue,  4 Oct 2022 21:30:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 386ACC433C1;
        Tue,  4 Oct 2022 21:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664919007;
        bh=u/tqsKkNVQghdOr3hJaurm14WPQ10nJ++8FrC5pLGgU=;
        h=From:To:Cc:Subject:Date:From;
        b=DnYXd6PHmTXWt4gTqLSXBgpCCNzk0I2HGmN5NCCkooQ4EMAAF7ro2WKBarSUPba0e
         4UJjPB0uvoSO9HYlIjs1i5W43qa4QvUOZa5MYXkoETnKp1JadG9XMlnJvEoN7TMUcn
         ZaYqVZEfZrAscRmhehWKsBq29lMCGYZ7IjB+weqAdl8ht/f6vSlk309iyGEnhmb+Wb
         xSnZngETukTw9c2BxGIM05lu8sp9Ht9FZjjHxwJj3Ix8SxvpTvGd6QBkpRavGJha4x
         oV5ChtnVntbgmIpc8f4CchTCb61RIbHNOApu7lh2yPnbe3Bu1AsjZGU5pfCiJkQOQ+
         cSslYRJkKfllQ==
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
Subject: [GIT PULL] tpmdd updates for Linux v6.1-rc1
Date:   Wed,  5 Oct 2022 00:30:02 +0300
Message-Id: <20221004213003.57166-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
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

Just a few bug fixes this time.

BR, Jarkko

The following changes since commit 4fe89d07dcc2804c8b562f6c7896a45643d34b2f:

  Linux 6.0 (2022-10-02 14:09:07 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v6.1-rc1

for you to fetch changes up to 2d869f0b458547386fbcd8cf3004b271b7347b7f:

  selftest: tpm2: Add Client.__del__() to close /dev/tpm* handle (2022-10-05 00:25:56 +0300)

----------------------------------------------------------------
tpmdd updates for Linux v6.1-rc1

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
