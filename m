Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B3567A08E
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Jan 2023 18:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233302AbjAXRzZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 24 Jan 2023 12:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231987AbjAXRzY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Jan 2023 12:55:24 -0500
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21702DBF9;
        Tue, 24 Jan 2023 09:55:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1674582920;
        bh=XkXkGOZV7jMy92XYpc0lADXdqarybGHtjT9jiW/wzaI=;
        h=From:To:Subject:Date:Message-Id:From;
        b=ubXncMX1a3lGS3mw0WKsqd2/pl8/aRPR5azDbpv7VN3VSzbtb8hcTzTN4Jg1sysSH
         jXqK+Tm1YDtGytlc8bjotBkvONZG+OJy9DdU8JwiGUUvWg6/vWnDjamVfmdBnpFH0o
         0Aj5FEb+FEnt8iFAtPnt1Di7GH9c4rJ0lQrk4qBQ=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id A0EE612861E3;
        Tue, 24 Jan 2023 12:55:20 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AOEheCsp8NVe; Tue, 24 Jan 2023 12:55:20 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 115F612861A7;
        Tue, 24 Jan 2023 12:55:20 -0500 (EST)
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     linux-integrity@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v2 00/11] add integrity and security to TPM2 transactions
Date:   Tue, 24 Jan 2023 12:55:05 -0500
Message-Id: <20230124175516.5984-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

The interest in securing the TPM against interposers, both active and
passive has risen to fever pitch with the demonstration of key
recovery against windows bitlocker:

https://dolosgroup.io/blog/2021/7/9/from-stolen-laptop-to-inside-the-company-network

And subsequently the same attack being successful against all the
Linux TPM based security solutions:

https://www.secura.com/blog/tpm-sniffing-attacks-against-non-bitlocker-targets

The attacks fall into two categories:

1. Passive Interposers, which sit on the bus and merely observe
2. Active Interposers, which try to manipulate TPM transactions on the
   bus using man in the middle and packet stealing to create TPM state
   the interposer owner desires.

Our broadest interposer target is the use of TPM_RS_PW for password
authorization which sends the actual password to the TPM without any
obfuscation and effectively hands it to any interposer. The way to fix
this is to use real sessions for HMAC capabilities to ensure integrity
and to use parameter and response encryption to ensure confidentiality
of the data flowing over the TPM bus.  HMAC sessions by agreeing a
challenge with the TPM and then giving a response which is a HMAC of
the password and the challenge, so the application proves knowledge of
the password to the TPM without ever transmitting the password itself.
Using HMAC sessions when sending commands to the TPM also provides
some measure of protection against active interposers, since the
interposer can't interfere with or delete a HMAC'd command (because
they can't manufacture a response with the correct HMAC).

To protect TPM transactions where there isn't a shared secret
(i.e. the command is something like a PCR extension which doesn't
involve a TPM object with a password) we have to do a bit more work to
set up sessions with a passed in encrypted secret (called a salt) to
act in place of the shared secret in the HMAC.  This secret salt is
effectively a random number encrypted to a public key of the TPM.  The
final piece of the puzzle is using parameter input and response return
encryption, so any interposer can't see the data passing from the
application to the TPM and vice versa.

The most insidious interposer attack of all is a reset attack: since
the interposer has access to the TPM bus, it can assert the TPM reset
line any time it wants.  When a TPM resets it mostly comes back in the
same state except that all the PCRs are reset to their initial values.
Controlling the reset line allows the interposer to change the PCR
state after the fact by resetting the TPM and then replaying PCR
extends to get the PCRs into a valid state to release secrets, so even
if an attack event was recorded, the record is erased.  This reset
attack violates the fundamental princible of non-repudiability of TPM
logs.  Defeating the reset attack involves tying all TPM operations
within the kernel to a property which will change detectably if the
TPM is reset.  For that reason, we tie all TPM sessions to the null
hierarchy we obtain at start of day and whose seed changes on every
reset.  If an active interposer asserts a TPM reset, the new null
primary won't match the kernel's stored one and all TPM operations
will start failing because of HMAC mismatches in the sessions.  So if
the kernel TPM code keeps operating, it guarantees that a reset hasn't
occurred.

The final part of the puzzle is that the machine owner must have a
fixed idea of the EK of their TPM and should have certified this with
the TPM manufacturer.  On every boot, the certified EK public key
should be used to do a make credential/activate credential attestation
key insertion and then the null key certified with the attestation
key.  We can follow a trust on first use model where an OS
installation will extract and verify a public EK and save it to a read
only file.

This patch series adds a simple API which can ensure the above
properties as a layered addition to the existing TPM handling code.
This series now includes protections for PCR extend, getting random
numbers from the TPM and data sealing and unsealing.  It therefore
eliminates all uses of TPM2_RS_PW in the kernel and adds encryption
protection to sensitive data flowing into and out of the TPM.  The
first four patches add more sophisticated buffer handling to the TPM
which is needed to build the more complex encryption and
authentication based commands.  Patch 6 adds all the generic
cryptography primitives and patches 7-9 use them in critical TPM
operations where we want to avoid or detect interposers.  Patch 10
exports the name of the null key we used for boot/run time
verification and patch 11 documents the security guarantees and
expectations.

This was originally sent over four years ago, with the last iteration
being:

https://lore.kernel.org/linux-integrity/1568031515.6613.31.camel@HansenPartnership.com/

I'm dusting it off now because various forces at Microsoft and Google
via the Open Compute Platform are making a lot of noise about
interposers and we in the linux kernel look critically lacking in that
regard, particularly for TPM trusted keys.

---
v2 fixes the problems smatch reported and adds more explanation about
the code motion in the first few patches

James

---

James Bottomley (11):
  tpm: move buffer handling from static inlines to real functions
  tpm: add buffer handling for TPM2B types
  tpm: add cursor based buffer functions for response parsing
  tpm: add buffer function to point to returned parameters
  tpm: export the context save and load commands
  tpm: Add full HMAC and encrypt/decrypt session handling code
  tpm: add hmac checks to tpm2_pcr_extend()
  tpm: add session encryption protection to tpm2_get_random()
  KEYS: trusted: Add session encryption protection to the seal/unseal
    path
  tpm: add the null key name as a sysfs export
  Documentation: add tpm-security.rst

 Documentation/security/tpm/tpm-security.rst |  214 ++++
 drivers/char/tpm/Kconfig                    |   13 +
 drivers/char/tpm/Makefile                   |    2 +
 drivers/char/tpm/tpm-buf.c                  |  197 +++
 drivers/char/tpm/tpm-sysfs.c                |   14 +
 drivers/char/tpm/tpm.h                      |   14 +
 drivers/char/tpm/tpm2-cmd.c                 |   54 +-
 drivers/char/tpm/tpm2-sessions.c            | 1216 +++++++++++++++++++
 drivers/char/tpm/tpm2-space.c               |    8 +-
 include/linux/tpm.h                         |  252 ++--
 security/keys/trusted-keys/trusted_tpm2.c   |   85 +-
 11 files changed, 1944 insertions(+), 125 deletions(-)
 create mode 100644 Documentation/security/tpm/tpm-security.rst
 create mode 100644 drivers/char/tpm/tpm-buf.c
 create mode 100644 drivers/char/tpm/tpm2-sessions.c

-- 
2.35.3

