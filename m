Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47714D79AC
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Mar 2022 04:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbiCNDip (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 13 Mar 2022 23:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbiCNDin (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 13 Mar 2022 23:38:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0143DE013;
        Sun, 13 Mar 2022 20:37:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 718D5B80CDD;
        Mon, 14 Mar 2022 03:37:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D108CC340E9;
        Mon, 14 Mar 2022 03:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647229051;
        bh=K/Bb9AFQPgK9PzPqEzQS+im6UIEx//eVjDa74PHyN94=;
        h=Date:From:To:Cc:Subject:From;
        b=JjZf1v4T5tFu/+MU4R/z/c4mBo1IerW9syUM4OK30NGy4NQUtv8ORL0vl0E2VwiJ6
         iw32U8sCuNyEDKGo8gxzOU3LED9fojX4pT3xjeY+hpT9ccUNW2fvOsiQO975GUvRUm
         tmy5nns+WhecldBxdwuKRYxqg7EmZwhQn67rkMG18R/q4Ws/6TNJmCFZDZBZrcA/MP
         wa4jSJmyGGnfOe5SxLqTsVeilAznmy9GecnXSMjtLZESUJyhwceHmG3ZQ26vDTAey4
         U/aSn3rQRqM975dBR4kD56JlnBT+zSS3eSs/kyPAHjonupcBgV6E0l3t+eNL461AdA
         d9a9KHm9myrYA==
Date:   Mon, 14 Mar 2022 05:36:44 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, James Morris <jmorris@namei.org>,
        David Howells <dhowells@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [GIT PULL] TPM DEVICE DRIVER updates for v5.18
Message-ID: <Yi64TJXqto+VdoOo@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi,

In order to split the work a bit we've aligned with David Howells more or
less that I take more hardware/firmware aligned keyring patches, and he
takes care more of the framework aligned patches.

For TPM the patches worth of highlighting are the fixes for refcounting
provided by Lino Sanfilippo and James Bottomley.

Eric B. has done a bunch obvious (but important) fixes but there's one a
bit controversial: removal of asym_tpm. It was added in 2018 when TPM1
was already declared as insecure and world had moved on to TPM2. I don't
know how this has passed all the filters but I did not have a chance to
see the patches when they were out. I simply cannot commit on
maintaining this because it was from all angles just wrong to take it in
the first place to the mainline kernel. Nobody should use this module
really for anything.

Finally, there is a new keyring ".machine" to hold MOK keys. In the mok
side MokListTrustedRT UEFI variable can be set, from which kernel knows
that MOK keys are kernel trusted keys and they are populated to the machine
keyring. This keyring linked to the secondary trusted keyring, which means
that can be used like any kernel trusted keys. This keyring of course can
be used to hold other MOK'ish keys in other platforms in future.

BR, Jarkko

v2:
* https://lore.kernel.org/all/20220201003414.55380-2-ebiggers@kernel.org/ =>
  https://lore.kernel.org/all/20220208052448.409152-2-ebiggers@kernel.org/

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
