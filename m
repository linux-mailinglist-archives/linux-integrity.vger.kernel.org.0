Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5CE7821D7
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Aug 2023 05:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbjHUDgn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 20 Aug 2023 23:36:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjHUDgm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 20 Aug 2023 23:36:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABEBA1;
        Sun, 20 Aug 2023 20:36:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD9AB62353;
        Mon, 21 Aug 2023 03:36:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86C9C433C8;
        Mon, 21 Aug 2023 03:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692588999;
        bh=R9xNAjyzFeWOUdSG6YFm/6Dcf84E+jNKuvpOQezsZPY=;
        h=From:To:Cc:Subject:Date:From;
        b=kFc+Oq07e2tulD8NnAXZyl01i0Du7KvGF0XC8Hjz+1IvKam7sf0Ia+rcuvbfgyHtN
         zGi4y5bwzFMbEJCRX2tBrjewztyfe84nXTwdJj/aWW7XaJuKgXkuQhVg8ho2WOwYpT
         BDo5MkF2+BX7/FGc3atOGygK6JPraE4YVg891ISpNP1Ezxl+IeJh4RSwIKGHXn5Wwf
         aG+69Uoo3vmT/XwmmlwLSk/WwoS7tFzR/7cjA+NAS7nZabagQd2CGvSoCgE6zI92wj
         jAVhUXPccI+UjTp1ujI3C6GFTeYP6tnKN0KliJm5kR3ChmAu1pfLFAi7zZAXTaze+L
         XvNJV75bSac6A==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     linux-integrity@vger.kernel.org
Cc:     keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        William Roberts <bill.c.roberts@gmail.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Mimi Zohar <zohar@linux.ibm.com>
Subject: [PATCH 0/5] Extend struct tpm_buf to support sized buffers (TPM2B)
Date:   Mon, 21 Aug 2023 03:36:25 +0000
Message-Id: <20230821033630.1039527-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
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

Jarkko Sakkinen (4):
  tpm: Store TPM buffer length
  tpm: Detach tpm_buf_reset() from tpm_buf_init()
  tpm: Support TPM2 sized buffers (TPM2B)
  KEYS: trusted: tpm2: Use struct tpm_buf for sized buffers

 drivers/char/tpm/Makefile                 |   1 +
 drivers/char/tpm/tpm-buf.c                | 126 ++++++++++++++++++++++
 drivers/char/tpm/tpm-interface.c          |  18 +++-
 drivers/char/tpm/tpm-sysfs.c              |   3 +-
 drivers/char/tpm/tpm1-cmd.c               |  26 +++--
 drivers/char/tpm/tpm2-cmd.c               |  36 +++++--
 drivers/char/tpm/tpm2-space.c             |   7 +-
 drivers/char/tpm/tpm_vtpm_proxy.c         |  13 +--
 include/linux/tpm.h                       |  93 +++-------------
 security/keys/trusted-keys/trusted_tpm1.c |  12 +--
 security/keys/trusted-keys/trusted_tpm2.c |  51 +++++----
 11 files changed, 249 insertions(+), 137 deletions(-)
 create mode 100644 drivers/char/tpm/tpm-buf.c

-- 
2.39.2

