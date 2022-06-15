Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAF554D145
	for <lists+linux-integrity@lfdr.de>; Wed, 15 Jun 2022 21:01:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242173AbiFOTB3 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jun 2022 15:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239945AbiFOTB2 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jun 2022 15:01:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E2A5003C;
        Wed, 15 Jun 2022 12:01:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 719D4B81D81;
        Wed, 15 Jun 2022 19:01:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DD46C34115;
        Wed, 15 Jun 2022 19:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655319685;
        bh=Qy3C78QNyFeJXZqCKviEM5fZjl3ArDFvWJxIFv9WMmc=;
        h=From:To:Cc:Subject:Date:From;
        b=p93f1K/23X5iAmwtne1iGvfX+uBZTya3MQCvxjhSUx4Mkv9s1RO0h23hv8ky52TMP
         nYw8uPPZ9m1E7C8P9Jju3eUcALOL9OBbmVR7LzdFk+mYb062/vTiSoGLPp87tP6MH0
         7/IC70HJX5GNLc/+TZzBhSjEogUyFdlrSTvfFlRM1122VgNeftbEc152Buo86BrvBM
         4W4R+rvD41wjQf25Smm8MQTP+7N1GuoT6ShttHTq4ciMvnsC2/COijRUs/NqN37ocN
         TBSftnGvXsR2+Y8liZHcVAdpH4LxSf9Rb1jFDERxGigJq1ZYcqcIrxtEf6zQy4XDuo
         OUMofXLpgEevA==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: [GIT PULL] tpmdd updates for v5.19-rc3
Date:   Wed, 15 Jun 2022 21:59:12 +0300
Message-Id: <20220615185912.40987-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The following changes since commit 979086f5e0066b4eff66e1eee123da228489985c:

  Merge tag 'fs.fixes.v5.19-rc3' of git://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux (2022-06-15 09:04:55 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git tags/tpmdd-next-v5.19-rc3

for you to fetch changes up to 27b5b22d252c6d71a2a37a4bdf18d0be6d25ee5a:

  certs: fix and refactor CONFIG_SYSTEM_BLACKLIST_HASH_LIST build (2022-06-15 21:52:32 +0300)

----------------------------------------------------------------
Hi,

Two fixes for rc1 PR.

BR, Jarkko

----------------------------------------------------------------
Masahiro Yamada (2):
      certs/blacklist_hashes.c: fix const confusion in certs blacklist
      certs: fix and refactor CONFIG_SYSTEM_BLACKLIST_HASH_LIST build

 certs/.gitignore         |  2 +-
 certs/Makefile           | 20 ++++++++++----------
 certs/blacklist_hashes.c |  4 ++--
 3 files changed, 13 insertions(+), 13 deletions(-)
