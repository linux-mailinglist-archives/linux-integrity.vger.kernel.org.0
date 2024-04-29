Return-Path: <linux-integrity+bounces-2281-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 912DB8B65B1
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Apr 2024 00:26:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B56D71C21588
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 22:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E99D8194C61;
	Mon, 29 Apr 2024 22:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PpFHPEvs"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE281779BD;
	Mon, 29 Apr 2024 22:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714429581; cv=none; b=GR4v3xJ0VDDXN/hINLcVA5gDn5IraKHWGhHgACIngFxZqlc5vRcrSeeTv8GQrliJGcmlHz1nXtcn8lLH4gbSRembp3KNhMZITxqulYVfZGZ5eGwQ1SOto6U444VdsENmDOpO7n0zriYGPqqCGcamrn9Gj28t+A9SJ4IHW/vjXj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714429581; c=relaxed/simple;
	bh=Rtp/Fgag/+EJnygnO5Iz0OamyK+5KOmdaLhATBryGAI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=tA8xhW2Q7j4T3THJYEjzDb9CaXjXB3t1N+a9Yu02+OuSDd1lT50Jf9QgjjfWgeko1RUFQqYT3uutih7jtFJ+E9Frv5DOqgfuInUVyQjH7LFGnKpkapUbabKBHcc3xw5+kxmMdwd9zKLmLwC0oIsPLfiniiYPH4AT/ibjvTQdg0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PpFHPEvs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CF7FC113CD;
	Mon, 29 Apr 2024 22:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714429581;
	bh=Rtp/Fgag/+EJnygnO5Iz0OamyK+5KOmdaLhATBryGAI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=PpFHPEvsUI1o4UxAnLCBnGXd0sJOMHJ527WbtC5RqUm4Vk7scsTZ/R9WV9DUpEEKB
	 Orn3ieEZIovrCZ6gdFBho8QNDC6NWewoZz8nRoBl8kTorvRijKMtnBmw6OQkYqWS03
	 ERxyxfDozPeCy3o9eYQvnm40Ji0dzTNDnKRWxehdONlHf+oiseAvNCUn852+dChS+t
	 7DBquNpy5+aE1S6qdSlGth+UeiKLn6xtQYAKboGoA/3sQRmilPz3gPsrEja4I3vCiQ
	 MkUJcNDH16uHa14QMD6IRJuISPsHn1Bn5ZkICOHB0Sk1yNUGWiEt8JaZ12FovLo5H3
	 QJAvk3niDu5PQ==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 30 Apr 2024 01:26:18 +0300
Message-Id: <D0WYKBCRV1BS.EWPTEY7QUG85@kernel.org>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v8 00/22] add integrity and security to TPM2
 transactions
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "Jarkko Sakkinen" <jarkko@kernel.org>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.17.0
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
 <D0WYH9UDXCZC.3OZ9MSOVTDBE1@kernel.org>
In-Reply-To: <D0WYH9UDXCZC.3OZ9MSOVTDBE1@kernel.org>

On Tue Apr 30, 2024 at 1:22 AM EEST, Jarkko Sakkinen wrote:
> On Mon Apr 29, 2024 at 11:27 PM EEST, James Bottomley wrote:
> > The interest in securing the TPM against interposers, both active and
> > passive has risen to fever pitch with the demonstration of key
> > recovery against windows bitlocker:
> >
> > https://dolosgroup.io/blog/2021/7/9/from-stolen-laptop-to-inside-the-co=
mpany-network
> >
> > And subsequently the same attack being successful against all the
> > Linux TPM based security solutions:
> >
> > https://www.secura.com/blog/tpm-sniffing-attacks-against-non-bitlocker-=
targets
> >
> > The attacks fall into two categories:
> >
> > 1. Passive Interposers, which sit on the bus and merely observe
> > 2. Active Interposers, which try to manipulate TPM transactions on the
> >    bus using man in the middle and packet stealing to create TPM state
> >    the interposer owner desires.
> >
> > Our broadest interposer target is the use of TPM_RS_PW for password
> > authorization which sends the actual password to the TPM without any
> > obfuscation and effectively hands it to any interposer. The way to fix
> > this is to use real sessions for HMAC capabilities to ensure integrity
> > and to use parameter and response encryption to ensure confidentiality
> > of the data flowing over the TPM bus.  HMAC sessions by agreeing a
> > challenge with the TPM and then giving a response which is a HMAC of
> > the password and the challenge, so the application proves knowledge of
> > the password to the TPM without ever transmitting the password itself.
> > Using HMAC sessions when sending commands to the TPM also provides
> > some measure of protection against active interposers, since the
> > interposer can't interfere with or delete a HMAC'd command (because
> > they can't manufacture a response with the correct HMAC).
> >
> > To protect TPM transactions where there isn't a shared secret
> > (i.e. the command is something like a PCR extension which doesn't
> > involve a TPM object with a password) we have to do a bit more work to
> > set up sessions with a passed in encrypted secret (called a salt) to
> > act in place of the shared secret in the HMAC.  This secret salt is
> > effectively a random number encrypted to a public key of the TPM.  The
> > final piece of the puzzle is using parameter input and response return
> > encryption, so any interposer can't see the data passing from the
> > application to the TPM and vice versa.
> >
> > The most insidious interposer attack of all is a reset attack: since
> > the interposer has access to the TPM bus, it can assert the TPM reset
> > line any time it wants.  When a TPM resets it mostly comes back in the
> > same state except that all the PCRs are reset to their initial values.
> > Controlling the reset line allows the interposer to change the PCR
> > state after the fact by resetting the TPM and then replaying PCR
> > extends to get the PCRs into a valid state to release secrets, so even
> > if an attack event was recorded, the record is erased.  This reset
> > attack violates the fundamental princible of non-repudiability of TPM
> > logs.  Defeating the reset attack involves tying all TPM operations
> > within the kernel to a property which will change detectably if the
> > TPM is reset.  For that reason, we tie all TPM sessions to the null
> > hierarchy we obtain at start of day and whose seed changes on every
> > reset.  If an active interposer asserts a TPM reset, the new null
> > primary won't match the kernel's stored one and all TPM operations
> > will start failing because of HMAC mismatches in the sessions.  So if
> > the kernel TPM code keeps operating, it guarantees that a reset hasn't
> > occurred.
> >
> > The final part of the puzzle is that the machine owner must have a
> > fixed idea of the EK of their TPM and should have certified this with
> > the TPM manufacturer.  On every boot, the certified EK public key
> > should be used to do a make credential/activate credential attestation
> > key insertion and then the null key certified with the attestation
> > key.  We can follow a trust on first use model where an OS
> > installation will extract and verify a public EK and save it to a read
> > only file.
> >
> > This patch series adds a simple API which can ensure the above
> > properties as a layered addition to the existing TPM handling code.
> > This series now includes protections for PCR extend, getting random
> > numbers from the TPM and data sealing and unsealing.  It therefore
> > eliminates all uses of TPM2_RS_PW in the kernel and adds encryption
> > protection to sensitive data flowing into and out of the TPM.  The
> > first four patches add more sophisticated buffer handling to the TPM
> > which is needed to build the more complex encryption and
> > authentication based commands.  Patch 6 adds all the generic
> > cryptography primitives and patches 7-9 use them in critical TPM
> > operations where we want to avoid or detect interposers.  Patch 10
> > exports the name of the null key we used for boot/run time
> > verification and patch 11 documents the security guarantees and
> > expectations.
> >
> > This was originally sent over four years ago, with the last iteration
> > being:
> >
> > https://lore.kernel.org/linux-integrity/1568031515.6613.31.camel@Hansen=
Partnership.com/
> >
> > I'm dusting it off now because various forces at Microsoft and Google
> > via the Open Compute Platform are making a lot of noise about
> > interposers and we in the linux kernel look critically lacking in that
> > regard, particularly for TPM trusted keys.
> >
> > ---
> > v2 fixes the problems smatch reported and adds more explanation about
> > the code motion in the first few patches
> > v3 rebases the encryption to be against Ard's new library function, the
> > aescfb addition of which appears as patch 1.
> > v4 refreshes Ard's patch, adds kernel doc (including a new patch to
> > add it to the moved tpm-buf functions) updates and rewords some commit
> > logs
> > v5: update to proposed tpm-buf implementation (for ease of use all
> > precursor patches are part of this series, so the actual session HMAC
> > and encryption begins at patch 10) and add review feedback
> > v6: split the original sessions patch into three and change the config
> > variable name
> > v7: Collect reviews and add extra patch to check for and disable the TP=
M on
> > detecting a reset attack.
> > v8: split KDF out, add tpm_ prefix + other cosmetic updates
> >
> > James
> >
> > ---
> >
> > Ard Biesheuvel (1):
> >   crypto: lib - implement library version of AES in CFB mode
> >
> > James Bottomley (14):
> >   tpm: Move buffer handling from static inlines to real functions
> >   tpm: add buffer function to point to returned parameters
> >   tpm: export the context save and load commands
> >   tpm: Add NULL primary creation
> >   tpm: Add TCG mandated Key Derivation Functions (KDFs)
> >   tpm: Add HMAC session start and end functions
> >   tpm: Add HMAC session name/handle append
> >   tpm: Add the rest of the session HMAC API
> >   tpm: add hmac checks to tpm2_pcr_extend()
> >   tpm: add session encryption protection to tpm2_get_random()
> >   KEYS: trusted: Add session encryption protection to the seal/unseal
> >     path
> >   tpm: add the null key name as a sysfs export
> >   Documentation: add tpm-security.rst
> >   tpm: disable the TPM if NULL name changes
> >
> > Jarkko Sakkinen (7):
> >   tpm: Remove unused tpm_buf_tag()
> >   tpm: Remove tpm_send()
> >   tpm: Update struct tpm_buf documentation comments
> >   tpm: Store the length of the tpm_buf data separately.
> >   tpm: TPM2B formatted buffers
> >   tpm: Add tpm_buf_read_{u8,u16,u32}
> >   KEYS: trusted: tpm2: Use struct tpm_buf for sized buffers
> >
> >  Documentation/security/tpm/tpm-security.rst |  216 ++++
> >  drivers/char/tpm/Kconfig                    |   14 +
> >  drivers/char/tpm/Makefile                   |    2 +
> >  drivers/char/tpm/tpm-buf.c                  |  251 ++++
> >  drivers/char/tpm/tpm-chip.c                 |    6 +
> >  drivers/char/tpm/tpm-interface.c            |   26 +-
> >  drivers/char/tpm/tpm-sysfs.c                |   18 +
> >  drivers/char/tpm/tpm.h                      |   14 +
> >  drivers/char/tpm/tpm2-cmd.c                 |   53 +-
> >  drivers/char/tpm/tpm2-sessions.c            | 1280 +++++++++++++++++++
> >  drivers/char/tpm/tpm2-space.c               |   11 +-
> >  include/crypto/aes.h                        |    5 +
> >  include/keys/trusted_tpm.h                  |    2 -
> >  include/linux/tpm.h                         |  316 +++--
> >  lib/crypto/Kconfig                          |    5 +
> >  lib/crypto/Makefile                         |    3 +
> >  lib/crypto/aescfb.c                         |  257 ++++
> >  security/keys/trusted-keys/trusted_tpm1.c   |   23 +-
> >  security/keys/trusted-keys/trusted_tpm2.c   |  136 +-
> >  19 files changed, 2443 insertions(+), 195 deletions(-)
> >  create mode 100644 Documentation/security/tpm/tpm-security.rst
> >  create mode 100644 drivers/char/tpm/tpm-buf.c
> >  create mode 100644 drivers/char/tpm/tpm2-sessions.c
> >  create mode 100644 lib/crypto/aescfb.c
>
> Thanks for the update!
>
> I think I asked this already earlier but unfortunately could not
> find the corresponding email from lore.
>
> Anyway, I've tested this series with QEMU i.e. to the point that
> I know that it does not break anything in the case when things are
> working as expected.
>
> What I would like to test is the negative case when the null key
> name changes and see what happens.
>
> I recall that you had some version of QEMU that had ability to test
> this and my latest question on that was what QEMU baseline it was
> expected to be applied over.
>
> Since I could not find the email subthread I neither have the patch nor
> do know the baseline. So if you could help with these details then we
> can move forward.
>
> I can also work with QEMU Git fork if you have one and point out
> QEMU_OVERRIDE_SRCDIR to the clone.
>
> It is somewhat mandatory IMHO to be able to test this to both=20
> directions, right?

Right and obviously 3rd option is to send a PR to
https://gitlab.com/jarkkojs/linux-tpmdd-test.

I.e. patch file goes to patches/qemu (BR2_GLOBAL_PATCH_DIR
points there).

BR, Jarkko


