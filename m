Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E50E542EF7
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jun 2022 13:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237532AbiFHLQY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jun 2022 07:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237682AbiFHLQX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jun 2022 07:16:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54D5362EE0;
        Wed,  8 Jun 2022 04:16:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1D4A3616C3;
        Wed,  8 Jun 2022 11:16:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECEB9C34116;
        Wed,  8 Jun 2022 11:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654686981;
        bh=plP+v2AIp7gGdkcdfZoN3vVzn7iA8FHDwNj6OCWSdQQ=;
        h=From:To:Cc:Subject:Date:From;
        b=V2A56f9GNMGDd69nDbWZPaewMHXDrGVKgM9Ccxjo2bBSh6WO1bB6P2cCRPsTMMfS4
         z9xxdEO2KTJnZfG2o3EmU/4nkPSwQ2EKapGIwsGkK8Q2wtK591R115wOMl1VIRM49V
         JCleIgQWnjxx4tZG2ltG6S8XSw02BthCd2wp495TCjvM658doBDhV2ukf5NFMPOY1j
         1ZfjqUhieTT7VXlWFigFT6LTym3TDhMUjG9pQogYx7PeiLf0JFAxFVsjudD+hGelFN
         V6TnM69RqM8xh+OWEyUtEg+UG9NJCi64/7oVZNZOUpHTLtDNF7dYFoN2AYIJmymuFr
         J83J6vHwzuBrA==
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
Subject: [GIT PULL] tpmdd updates for v5.19-rc2-v2
Date:   Wed,  8 Jun 2022 14:14:17 +0300
Message-Id: <20220608111418.3081578-1-jarkko@kernel.org>
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

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.19-rc2-v2

for you to fetch changes up to dda5384313a40ecbaafd8a9a80f47483255e4c4d:

  KEYS: trusted: tpm2: Fix migratable logic (2022-06-08 14:12:13 +0300)

----------------------------------------------------------------
A bug fix for migratable (whether or not a key is tied to the TPM chip
soldered to the machine) handling for TPM2 trusted keys.

----------------------------------------------------------------
David Safford (1):
      KEYS: trusted: tpm2: Fix migratable logic

 security/keys/trusted-keys/trusted_tpm2.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)
