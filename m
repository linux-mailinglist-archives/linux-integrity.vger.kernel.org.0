Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C076542C16
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jun 2022 11:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbiFHJ4I (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jun 2022 05:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235573AbiFHJzt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jun 2022 05:55:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 284AB24F2F;
        Wed,  8 Jun 2022 02:28:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CF7ADB8261A;
        Wed,  8 Jun 2022 09:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A42C341C0;
        Wed,  8 Jun 2022 09:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654680531;
        bh=wOVr/dCNZRUfPSwMKEqJLx2UBk01tuUU75xmtsI1B0Q=;
        h=From:To:Cc:Subject:Date:From;
        b=r9UxDHNEYlVWkZOPxRH6/ovMv7Lphv18/HAcUU6owe+Ec/pIeGiNW9c1YhmMIM7Jb
         0DnndUrpkfpr65b7w0vU3JwN2OACu0o+He3L5JCtYUIkoM3bkgIgBtHotCtHNTnzbH
         GVCegA0V9268mLWJLHwuGp6BMrhm5CasTzdJZXlfOAY8rA778cWvfhe/faI3p6svYy
         Glru8LgrtAE0uGXeinddoq26itBnC8QeiuuR6zZp8kCdN7hPKbFsImm0+Jy2XGbc8m
         NZn3G4exFCaNqy/7cMMIfBYT8S9Nk89+vNljxi6oT/JmYGq7H+0AUKsE3JCeguAXeJ
         s0hPy3C364jEg==
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
Subject: [GIT PULL] tpmdd updates for v5.19-rc2
Date:   Wed,  8 Jun 2022 12:26:46 +0300
Message-Id: <20220608092646.3074700-1-jarkko@kernel.org>
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

The following changes since commit 9886142c7a2226439c1e3f7d9b69f9c7094c3ef6:

  Merge tag 'input-for-v5.19-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input (2022-06-07 15:00:29 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.19-rc2

for you to fetch changes up to 967a4b757b51164a3dc3307234fcb48b7be2745b:

  KEYS: trusted: tpm2: Fix migratable logic (2022-06-08 12:13:26 +0300)

----------------------------------------------------------------
A bug fix for migratable (whether or not a key is tied to the TPM chip
soldered to the machine) handling for TPM2 trusted keys.

----------------------------------------------------------------
david.safford@gmail.com (1):
      KEYS: trusted: tpm2: Fix migratable logic

 security/keys/trusted-keys/trusted_tpm2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
