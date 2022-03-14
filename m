Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FE544D79B7
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Mar 2022 04:43:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229836AbiCNDoQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 13 Mar 2022 23:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbiCNDoP (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 13 Mar 2022 23:44:15 -0400
X-Greylist: delayed 571 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 13 Mar 2022 20:43:05 PDT
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 633C8BC93
        for <linux-integrity@vger.kernel.org>; Sun, 13 Mar 2022 20:43:02 -0700 (PDT)
Received: from localhost (91-154-92-187.elisa-laajakaista.fi [91.154.92.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sakkinen)
        by meesny.iki.fi (Postfix) with ESMTPSA id 9CDFE200B9;
        Mon, 14 Mar 2022 05:33:23 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1647228803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=uQhyjB8j73qzl+ChbP8kn0vO6yWGcJ/9Sw43XmwkW0w=;
        b=qtgMfRcX/anqtLCrek/LRwovjkV4rOYVySov8PlNI3nvO0kkuvNbvQb6lb+g3Yb2nlwZbu
        3fsuK7vwA1IIptx4tGLclTjNt0rXnXLk/snLB4hEcEzENnMvdTT86hkH9XiU/uvv4O823Z
        yf4zB5xs3eY7o6/sCtZ13w1xb/4tM4g=
Date:   Mon, 14 Mar 2022 05:32:39 +0200
From:   Jarkko Sakkinen <jarkko.sakkinen@iki.fi>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [GIT PULL] TPM DEVICE DRIVER updates for v5.18
Message-ID: <Yi63V9wVfSJ3ioSm@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1647228803; a=rsa-sha256; cv=none;
        b=VkNC55aZDMNRTZe+joMuK+lUobPyayMtVcgd8DvapbiJacXtQCdhCQULukkb4i1wt5u4XT
        3K13qkpzNve6+K8FkgUP1XHqTch9oEsXZLiPhuHG6ErVrqKGxoX04tKMGZu5tN0kBr75nJ
        b7JUUA8GNK3PIW0LqOMKQPws4jqbGhM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1647228803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=uQhyjB8j73qzl+ChbP8kn0vO6yWGcJ/9Sw43XmwkW0w=;
        b=s0jz8gNi6Ri+XWWPt/Y18RxoBAOBZiKT6ExSRpRIHDhbUbfAdxDp0RfowlVOyj77wGmuGc
        WuyB3y3KbO1jv7Ycd+duiT1WK909IzoXSnCYkf1u1tEwgsD76O1TG9zCEMAfdUkQsOnB/F
        46PHXqTd1QYur8A9b89aozdtzYJac+Y=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The following changes since commit ea4424be16887a37735d6550cfd0611528dbe5d9:

  Merge tag 'mtd/fixes-for-5.17-rc8' of git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux (2022-03-07 11:43:22 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/ tags/tpmdd-next-v5.18-v2

for you to fetch changes up to fb5abce6b2bb5cb3d628aaa63fa821da8c4600f9:

  tpm: use try_get_ops() in tpm-space.c (2022-03-10 01:47:25 +0200)

----------------------------------------------------------------
tpmdd updates for Linux v5.18

----------------------------------------------------------------
Andreas Rammhold (1):
      KEYS: trusted: Fix trusted key backends when building as module

Dave Kleikamp (1):
      KEYS: trusted: Avoid calling null function trusted_key_exit

Eric Biggers (8):
      KEYS: fix length validation in keyctl_pkey_params_get_2()
      KEYS: x509: clearly distinguish between key and signature algorithms
      KEYS: x509: remove unused fields
      KEYS: x509: remove never-set ->unsupported_key flag
      KEYS: x509: remove dead code that set ->unsupported_sig
      KEYS: remove support for asym_tpm keys
      KEYS: asymmetric: enforce that sig algo matches key algo
      KEYS: asymmetric: properly validate hash_algo and encoding

Eric Snowberg (8):
      integrity: Fix warning about missing prototypes
      integrity: Introduce a Linux keyring called machine
      integrity: add new keyring handler for mok keys
      KEYS: store reference to machine keyring
      KEYS: Introduce link restriction for machine keys
      efi/mokvar: move up init order
      integrity: Trust MOK keys if MokListTrustedRT found
      integrity: Only use machine keyring when uefi_check_trust_mok_keys is true

Gustavo A. R. Silva (1):
      tpm: xen-tpmfront: Use struct_size() helper

James Bottomley (1):
      tpm: use try_get_ops() in tpm-space.c

Lino Sanfilippo (1):
      tpm: fix reference counting for struct tpm_chip

Stefan Berger (1):
      selftests: tpm2: Determine available PCR bank

Tadeusz Struk (2):
      tpm: Fix error handling in async work
      selftests: tpm: add async space test with noneexisting handle

 certs/system_keyring.c                             |  44 +-
 crypto/asymmetric_keys/Kconfig                     |  21 -
 crypto/asymmetric_keys/Makefile                    |  12 -
 crypto/asymmetric_keys/asym_tpm.c                  | 957 ---------------------
 crypto/asymmetric_keys/pkcs7_verify.c              |  13 +-
 crypto/asymmetric_keys/public_key.c                | 126 ++-
 crypto/asymmetric_keys/tpm.asn1                    |   5 -
 crypto/asymmetric_keys/tpm_parser.c                | 102 ---
 crypto/asymmetric_keys/x509.asn1                   |   2 +-
 crypto/asymmetric_keys/x509_cert_parser.c          |  34 +-
 crypto/asymmetric_keys/x509_parser.h               |   1 -
 crypto/asymmetric_keys/x509_public_key.c           |  24 -
 drivers/char/tpm/tpm-chip.c                        |  46 +-
 drivers/char/tpm/tpm-dev-common.c                  |   8 +-
 drivers/char/tpm/tpm.h                             |   2 +
 drivers/char/tpm/tpm2-space.c                      |  73 +-
 drivers/char/tpm/xen-tpmfront.c                    |   8 +-
 drivers/firmware/efi/mokvar-table.c                |   2 +-
 include/crypto/asym_tpm_subtype.h                  |  19 -
 include/keys/system_keyring.h                      |  14 +
 security/integrity/Kconfig                         |  13 +
 security/integrity/Makefile                        |   1 +
 security/integrity/digsig.c                        |  15 +-
 security/integrity/integrity.h                     |  17 +-
 .../integrity/platform_certs/keyring_handler.c     |  18 +-
 .../integrity/platform_certs/keyring_handler.h     |   5 +
 security/integrity/platform_certs/load_uefi.c      |   4 +-
 .../integrity/platform_certs/machine_keyring.c     |  77 ++
 security/keys/keyctl_pkey.c                        |  14 +-
 security/keys/trusted-keys/trusted_core.c          |   6 +-
 tools/testing/selftests/tpm2/tpm2.py               |  31 +
 tools/testing/selftests/tpm2/tpm2_tests.py         |  45 +-
 32 files changed, 486 insertions(+), 1273 deletions(-)
 delete mode 100644 crypto/asymmetric_keys/asym_tpm.c
 delete mode 100644 crypto/asymmetric_keys/tpm.asn1
 delete mode 100644 crypto/asymmetric_keys/tpm_parser.c
 delete mode 100644 include/crypto/asym_tpm_subtype.h
 create mode 100644 security/integrity/platform_certs/machine_keyring.c
