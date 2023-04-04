Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 063B16D6C88
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Apr 2023 20:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235377AbjDDSni (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Apr 2023 14:43:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234826AbjDDSni (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Apr 2023 14:43:38 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BD41734;
        Tue,  4 Apr 2023 11:43:36 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id dg15so17698344vsb.13;
        Tue, 04 Apr 2023 11:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680633815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlctpKTmMGqckyFCp1S41420TL3sNP7/QEXloa70XDw=;
        b=EVbTx1isELcBPyCkEznt0kONt15CXHtyEvnLNjf2Oh2e+R7EPW3ZxIp1RUs5ixDT/H
         k8/7zchmvotPMH+JAtue3AN1kFxXMNQC6bonxMqud2R5phJ5VqeHWBwbJWz43niMBarc
         JCHtnQukK6/CoyiKL+d6wwlDJy6uo6eGuOPG5If5SPNkYApHaZNzgGUuJg8St/ZS+DYL
         7F/iHeUBN1QNSXeqVE9og51K4dghzhXJOAwMyHErZEA8AS0iCPVaN5v38KolxJdS7w+G
         3xT7DQIAbLC5/yVFBi+EmtlwH5AuaaU2tiJoBJs/TNDr1NjhjH8XkOJ/fnVf7mYqRZT/
         i12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680633815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GlctpKTmMGqckyFCp1S41420TL3sNP7/QEXloa70XDw=;
        b=aNzbpa/Ihqv4sMxONszz4eIQ1mbXn/kb6uhfXbt0HUisDHjUMqfrdemU5TrYtJGBFI
         CKm8TXqOZy4n3uzaEFdfD2N+cDd18sAfslsClwMdwWa6QaVkJH25zooTprkLo3tnsiZc
         pu5n+gCo4vgyu5xZfBysyfKb/77tSqLl5vYdNvDhNdvRozg8nB+LmSET73r+pfZDoY0M
         zSt9G3yP6TMEkgsdZY70CMLCLlvC/j/DY24/+GAPUjOvjfY6Ng8CDtHuoIsY4/UUOAb+
         z8J60sAgjxds4CBaKuKkcB0EUBFNeUGBJTWgNkav+QQZgVIgNoIaxmyUQB5ixPTOBLBD
         twWg==
X-Gm-Message-State: AAQBX9eLJL41WSXFnSQquju/by99D8NZ1d7cldk0NYKJAE6sgKABEAhp
        2dYxJ6bkK72Uq539ajPSs3yLu4V4GEfd3HnH6xw=
X-Google-Smtp-Source: AKy350ai+pVIKAps+qAaGBTpBM1ITyIhdKWaP19B8B4GmQiLCe1WBopcXbmTwRZRJnkMMsEg5DAEQV4Fp9YxUEU73Ng=
X-Received: by 2002:a67:d29a:0:b0:426:7730:1b89 with SMTP id
 z26-20020a67d29a000000b0042677301b89mr3136204vsi.0.1680633815526; Tue, 04 Apr
 2023 11:43:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Tue, 4 Apr 2023 13:43:24 -0500
Message-ID: <CAFftDdpTWjtNEf=E5V0X1c5ZrG=LQKo1WH6n0Ok2DE7jsh6yqg@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] add integrity and security to TPM2 transactions
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Apr 3, 2023 at 4:44=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> The interest in securing the TPM against interposers, both active and
> passive has risen to fever pitch with the demonstration of key
> recovery against windows bitlocker:
>
> https://dolosgroup.io/blog/2021/7/9/from-stolen-laptop-to-inside-the-comp=
any-network
>
> And subsequently the same attack being successful against all the
> Linux TPM based security solutions:
>
> https://www.secura.com/blog/tpm-sniffing-attacks-against-non-bitlocker-ta=
rgets
>

I fixed systemd, see the relevant PRS:
  - https://github.com/systemd/systemd/pulls?q=3Dis%3Apr+is%3Aclosed+author=
%3Awilliamcroberts

They had some support where they would create a primary key on each
boot and just trust it, eventually
we:
1. Added a bind key as a stop gap
2. strengthened passwords for the bind key
3. Added verification of the tpm key to a trusted public blob and used
the persistent SRK.

I could drop the bind key now if the SRK is present as it's not
needed, but it shouldn't hurt anything.
The big issue is the period of 1 to 2 where a weak pin could be
cracked offline. This occurs in
version 252 but the salt was merged in 253 and using SRK is on main.

> The attacks fall into two categories:
>
> 1. Passive Interposers, which sit on the bus and merely observe
> 2. Active Interposers, which try to manipulate TPM transactions on the
>    bus using man in the middle and packet stealing to create TPM state
>    the interposer owner desires.
>
> Our broadest interposer target is the use of TPM_RS_PW for password
> authorization which sends the actual password to the TPM without any
> obfuscation and effectively hands it to any interposer. The way to fix
> this is to use real sessions for HMAC capabilities to ensure integrity
> and to use parameter and response encryption to ensure confidentiality
> of the data flowing over the TPM bus.  HMAC sessions by agreeing a
> challenge with the TPM and then giving a response which is a HMAC of
> the password and the challenge, so the application proves knowledge of
> the password to the TPM without ever transmitting the password itself.
> Using HMAC sessions when sending commands to the TPM also provides
> some measure of protection against active interposers, since the
> interposer can't interfere with or delete a HMAC'd command (because
> they can't manufacture a response with the correct HMAC).
>
> To protect TPM transactions where there isn't a shared secret
> (i.e. the command is something like a PCR extension which doesn't
> involve a TPM object with a password) we have to do a bit more work to
> set up sessions with a passed in encrypted secret (called a salt) to
> act in place of the shared secret in the HMAC.  This secret salt is
> effectively a random number encrypted to a public key of the TPM.  The
> final piece of the puzzle is using parameter input and response return
> encryption, so any interposer can't see the data passing from the
> application to the TPM and vice versa.
>
> The most insidious interposer attack of all is a reset attack: since
> the interposer has access to the TPM bus, it can assert the TPM reset
> line any time it wants.  When a TPM resets it mostly comes back in the
> same state except that all the PCRs are reset to their initial values.
> Controlling the reset line allows the interposer to change the PCR
> state after the fact by resetting the TPM and then replaying PCR
> extends to get the PCRs into a valid state to release secrets, so even
> if an attack event was recorded, the record is erased.  This reset
> attack violates the fundamental princible of non-repudiability of TPM
> logs.  Defeating the reset attack involves tying all TPM operations
> within the kernel to a property which will change detectably if the
> TPM is reset.  For that reason, we tie all TPM sessions to the null
> hierarchy we obtain at start of day and whose seed changes on every
> reset.  If an active interposer asserts a TPM reset, the new null
> primary won't match the kernel's stored one and all TPM operations
> will start failing because of HMAC mismatches in the sessions.  So if
> the kernel TPM code keeps operating, it guarantees that a reset hasn't
> occurred.
>
> The final part of the puzzle is that the machine owner must have a
> fixed idea of the EK of their TPM and should have certified this with
> the TPM manufacturer.  On every boot, the certified EK public key
> should be used to do a make credential/activate credential attestation
> key insertion and then the null key certified with the attestation
> key.  We can follow a trust on first use model where an OS
> installation will extract and verify a public EK and save it to a read
> only file.

Ahh I was wondering how you were going to bootstrap trust using the
NULL hierarchy.

>
> This patch series adds a simple API which can ensure the above
> properties as a layered addition to the existing TPM handling code.
> This series now includes protections for PCR extend, getting random
> numbers from the TPM and data sealing and unsealing.  It therefore
> eliminates all uses of TPM2_RS_PW in the kernel and adds encryption
> protection to sensitive data flowing into and out of the TPM.  The
> first four patches add more sophisticated buffer handling to the TPM
> which is needed to build the more complex encryption and
> authentication based commands.  Patch 6 adds all the generic
> cryptography primitives and patches 7-9 use them in critical TPM
> operations where we want to avoid or detect interposers.  Patch 10
> exports the name of the null key we used for boot/run time
> verification and patch 11 documents the security guarantees and
> expectations.
>
> This was originally sent over four years ago, with the last iteration
> being:
>
> https://lore.kernel.org/linux-integrity/1568031515.6613.31.camel@HansenPa=
rtnership.com/
>
> I'm dusting it off now because various forces at Microsoft and Google
> via the Open Compute Platform are making a lot of noise about
> interposers and we in the linux kernel look critically lacking in that
> regard, particularly for TPM trusted keys.
>
> ---
> v2 fixes the problems smatch reported and adds more explanation about
> the code motion in the first few patches
> v3 rebases the encryption to be against Ard's new library function, the
> aescfb addition of which appears as patch 1.
> v4 refreshes Ard's patch, adds kernel doc (including a new patch to
> add it to the moved tpm-buf functions) updates and rewords some commit
> logs
>
> James
>
> ---
>
> Ard Biesheuvel (1):
>   crypto: lib - implement library version of AES in CFB mode
>
> James Bottomley (12):
>   tpm: move buffer handling from static inlines to real functions
>   tpm: add kernel doc to buffer handling functions
>   tpm: add buffer handling for TPM2B types
>   tpm: add cursor based buffer functions for response parsing
>   tpm: add buffer function to point to returned parameters
>   tpm: export the context save and load commands
>   tpm: Add full HMAC and encrypt/decrypt session handling code
>   tpm: add hmac checks to tpm2_pcr_extend()
>   tpm: add session encryption protection to tpm2_get_random()
>   KEYS: trusted: Add session encryption protection to the seal/unseal
>     path
>   tpm: add the null key name as a sysfs export
>   Documentation: add tpm-security.rst
>
>  Documentation/security/tpm/tpm-security.rst |  216 ++++
>  drivers/char/tpm/Kconfig                    |   13 +
>  drivers/char/tpm/Makefile                   |    2 +
>  drivers/char/tpm/tpm-buf.c                  |  307 +++++
>  drivers/char/tpm/tpm-chip.c                 |    3 +
>  drivers/char/tpm/tpm-sysfs.c                |   18 +
>  drivers/char/tpm/tpm.h                      |   14 +
>  drivers/char/tpm/tpm2-cmd.c                 |   52 +-
>  drivers/char/tpm/tpm2-sessions.c            | 1158 +++++++++++++++++++
>  drivers/char/tpm/tpm2-space.c               |    8 +-
>  include/crypto/aes.h                        |    5 +
>  include/linux/tpm.h                         |  257 ++--
>  lib/crypto/Kconfig                          |    5 +
>  lib/crypto/Makefile                         |    3 +
>  lib/crypto/aescfb.c                         |  257 ++++
>  security/keys/trusted-keys/trusted_tpm2.c   |   82 +-
>  16 files changed, 2275 insertions(+), 125 deletions(-)
>  create mode 100644 Documentation/security/tpm/tpm-security.rst
>  create mode 100644 drivers/char/tpm/tpm-buf.c
>  create mode 100644 drivers/char/tpm/tpm2-sessions.c
>  create mode 100644 lib/crypto/aescfb.c
>
> --
> 2.35.3
>
