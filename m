Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86DF37D44B3
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Oct 2023 03:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjJXBPp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Oct 2023 21:15:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjJXBPo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Oct 2023 21:15:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B67A1;
        Mon, 23 Oct 2023 18:15:42 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CA5C433C7;
        Tue, 24 Oct 2023 01:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698110142;
        bh=cqNiWrCmevZV6/MtAe7Td+HZSGwJmyaPwK8QTHpAIEY=;
        h=From:To:Cc:Subject:Date:From;
        b=MbCEXWitCNCzO643GJeBocbBBx1uuJSb5yBaEWDRm2vhiPMLk9LYYoTMJr23TqxXh
         HYP5zMBWlrtkwAOjM0aTHh+oJCZDLikN/Go0GD/BVgDL6ell6xySc2jizGKQV0RkYd
         iRXDM8/I+5OMJZe9phLglDDrcRVmm9eoKS25I/E6dqLutMy1+Yr9AGUG5kzpPkRD7/
         T2J6qqV7NIQoGC03pZtoGyYrf+2K0Pzsn1pX7E9KslMcNfRgNh6O6ajxO+dWDxWJ9p
         XhErsEMLU9efTjf6rgsv5qXfbzjUrk+kH3APpSLdtWKmckFA+8KFvR9EP/oAY2DnJ4
         NdpLDghvq8k1w==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-integrity@vger.kernel.org
Cc:     keyrings@vger.kernel.org, Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH v3 0/6] Extend struct tpm_buf to support sized buffers (TPM2B)
Date:   Tue, 24 Oct 2023 04:15:18 +0300
Message-ID: <20231024011531.442587-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

This patch set implements my ideas on how to extend struct tpm_buf to
support TPM2 sized buffers (TPM2B). See Section 10.4 in TPM2 Structures
specification for more information.

The goal is to do initial groundwork for smoother landing of integrity
protection patches by James Bottomley.

I tested the patch set with:

https://github.com/jarkkojs/buildroot-tpmdd/tree/linux-6.5.y

Compilation:

make qemu_x86_64_defconfig
make 2>&1 | tee build.txt;

TPM1 startup: output/images/start-qemu.sh --use-system-swtpm --rtc --tpm1
TPM2 startup: output/images/start-qemu.sh --use-system-swtpm --rtc

For TPM2 I executed the following as the smoke test for these patches:

/usr/lib/kselftests/run_kselftest.sh
tpm2_createprimary --hierarchy o -G rsa2048 -c key.ctxt
tpm2_evictcontrol -c key.ctxt 0x81000001
keyctl add trusted kmk "new 32 keyhandle=0x81000001" @u
keyctl add encrypted 1000100010001000 "new ecryptfs trusted:kmk 64" @u

For TPM1 I tried:

keyctl add trusted kmk "new 32" @u

This caused TPM error 18, which AFAIK means that there is not SRK (?),
which is probably an issue in my swtpm configuration, which is visible
in board/qemu/start-qemu.sh.in.

v3:
- Resend with rebase to the latest upstream.

Link: https://lore.kernel.org/linux-integrity/CT5OE5VZA7D7.3B7C6CK27JIK1@suppilovahvero/
Link: https://lore.kernel.org/linux-integrity/20230403214003.32093-1-James.Bottomley@HansenPartnership.com/
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: William Roberts <bill.c.roberts@gmail.com> 
Cc: Stefan Berger <stefanb@linux.ibm.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Mimi Zohar <zohar@linux.ibm.com>

James Bottomley (1):
  tpm: Move buffer handling from static inlines to real functions

Jarkko Sakkinen (5):
  tpm: Store TPM buffer length
  tpm: Detach tpm_buf_reset() from tpm_buf_init()
  tpm: Support TPM2 sized buffers (TPM2B)
  tpm: Add tpm_buf_read_{u8,u16,u32}
  KEYS: trusted: tpm2: Use struct tpm_buf for sized buffers

 drivers/char/tpm/Makefile                 |   1 +
 drivers/char/tpm/tpm-buf.c                | 195 ++++++++++++++++++++++
 drivers/char/tpm/tpm-interface.c          |  18 +-
 drivers/char/tpm/tpm-sysfs.c              |   3 +-
 drivers/char/tpm/tpm1-cmd.c               |  26 ++-
 drivers/char/tpm/tpm2-cmd.c               |  36 ++--
 drivers/char/tpm/tpm2-space.c             |   7 +-
 drivers/char/tpm/tpm_vtpm_proxy.c         |  13 +-
 include/linux/tpm.h                       |  96 ++---------
 security/keys/trusted-keys/trusted_tpm1.c |  12 +-
 security/keys/trusted-keys/trusted_tpm2.c |  60 ++++---
 11 files changed, 325 insertions(+), 142 deletions(-)
 create mode 100644 drivers/char/tpm/tpm-buf.c

-- 
2.42.0

