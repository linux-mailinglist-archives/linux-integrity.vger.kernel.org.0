Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB7036EBD3D
	for <lists+linux-integrity@lfdr.de>; Sun, 23 Apr 2023 07:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjDWFmX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 23 Apr 2023 01:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjDWFmW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 23 Apr 2023 01:42:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC7DE54;
        Sat, 22 Apr 2023 22:42:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B4BFE60B56;
        Sun, 23 Apr 2023 05:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D853C433EF;
        Sun, 23 Apr 2023 05:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682228540;
        bh=flO1C8K7rzs0k5cLXngRVg1N1l7i473Ww+CIHh1Gmgg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=j2xHqI3yx48mrhBMtM3czRH+cx/o5aYBfXApWPe5RAwT/Vwcp05Fbtwf0TbaZVuO+
         jt+m1u8uDDVlyKGtvIobZu0/oA8+3aQMoFz8FhhYeT/oUh9Q8MjVJoikUv8NyXSMqk
         TZD6OLPMu9vvoJMRq6UlzDHkQC3Lt2IQu8KPyBxDa6jJd3QPfXft2rUdpKbPRin8Et
         mQvyqQaxAGQdjG7dm/WDU6Re3XYhGLaG/LsCy+Tw2Y/RXWJpSHDqMdi0SvCNJQ+dBl
         5IQ07piz+cETP7HbG/L1vw7LpJu0Ji1A02p80c/WszWf9zzaIKm1SnGkD5Go6tsY40
         dAhRRvFEZ2jZw==
Message-ID: <5cba3e687e84107b2a82121b6676143e93d4f32c.camel@kernel.org>
Subject: Re: [PATCH v4 00/13] add integrity and security to TPM2 transactions
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc:     keyrings@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>
Date:   Sun, 23 Apr 2023 08:42:16 +0300
In-Reply-To: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-04-03 at 17:39 -0400, James Bottomley wrote:
> The interest in securing the TPM against interposers, both active and
> passive has risen to fever pitch with the demonstration of key
> recovery against windows bitlocker:
>=20
> https://dolosgroup.io/blog/2021/7/9/from-stolen-laptop-to-inside-the-comp=
any-network
>=20
> And subsequently the same attack being successful against all the
> Linux TPM based security solutions:
>=20
> https://www.secura.com/blog/tpm-sniffing-attacks-against-non-bitlocker-ta=
rgets
>=20
> The attacks fall into two categories:
>=20
> 1. Passive Interposers, which sit on the bus and merely observe
> 2. Active Interposers, which try to manipulate TPM transactions on the
>    bus using man in the middle and packet stealing to create TPM state
>    the interposer owner desires.
>=20
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
>=20
> To protect TPM transactions where there isn't a shared secret
> (i.e. the command is something like a PCR extension which doesn't
> involve a TPM object with a password) we have to do a bit more work to
> set up sessions with a passed in encrypted secret (called a salt) to
> act in place of the shared secret in the HMAC.  This secret salt is
> effectively a random number encrypted to a public key of the TPM.  The
> final piece of the puzzle is using parameter input and response return
> encryption, so any interposer can't see the data passing from the
> application to the TPM and vice versa.
>=20
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
>=20
> The final part of the puzzle is that the machine owner must have a
> fixed idea of the EK of their TPM and should have certified this with
> the TPM manufacturer.  On every boot, the certified EK public key
> should be used to do a make credential/activate credential attestation
> key insertion and then the null key certified with the attestation
> key.  We can follow a trust on first use model where an OS
> installation will extract and verify a public EK and save it to a read
> only file.
>=20
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
>=20
> This was originally sent over four years ago, with the last iteration
> being:
>=20
> https://lore.kernel.org/linux-integrity/1568031515.6613.31.camel@HansenPa=
rtnership.com/
>=20
> I'm dusting it off now because various forces at Microsoft and Google
> via the Open Compute Platform are making a lot of noise about
> interposers and we in the linux kernel look critically lacking in that
> regard, particularly for TPM trusted keys.
>=20
> ---
> v2 fixes the problems smatch reported and adds more explanation about
> the code motion in the first few patches
> v3 rebases the encryption to be against Ard's new library function, the
> aescfb addition of which appears as patch 1.
> v4 refreshes Ard's patch, adds kernel doc (including a new patch to
> add it to the moved tpm-buf functions) updates and rewords some commit
> logs
>=20
> James
>=20
> ---
>=20
> Ard Biesheuvel (1):
>   crypto: lib - implement library version of AES in CFB mode
>=20
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
>=20
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
>=20

OK, so I have a kernel with the patches applied. How can I verify
that this working?

Are there any other user visible things than handle for the null
key? Even for that this lacks any useful instructions how to use
it while testing. For the null key I'm not even sure if the claim
is correct, given that kernel is always a middle-man, even when
user space uses /dev/tpm0. A bit more detail would help...

BR, Jarkko

