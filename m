Return-Path: <linux-integrity+bounces-1187-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 144DC8540B9
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Feb 2024 01:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 905831F2A181
	for <lists+linux-integrity@lfdr.de>; Wed, 14 Feb 2024 00:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0508821;
	Wed, 14 Feb 2024 00:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gk0SvyMT"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6150A7F;
	Wed, 14 Feb 2024 00:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707869591; cv=none; b=l1aSW++2fRQxQMLYoElXeVlqJuG0sX/157geSGr2llHJWhqpHL20jkJqubnyuhCVk2bzKOEE2aaME3uch4NfwlgMh+be5gDSUfTkqVhHbSw+EifqNPANsU4bunVJY7A3a+JVET73sJ4I0pA6cao7vTtEc92ZyPSOT+letnXhLzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707869591; c=relaxed/simple;
	bh=YjRxLXMYjQj3SykZc5RCVnmpptEAKVGxlOa5zDENcso=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=sQ4ISfaY/1BmdVcZUCtiTHC/9goR+xUSCRieANMat8DmoDK0k/+y7PCv6yPNkLojbDhdpjdC1yRNEYOMeyg/gvRuMafazfP+W9zNDeoc5KwV1Tk3PDZpaHVRn6AMOgNMUMa3ldD5O5fKLYGDZbN0Z295d6rb66aPD/W+TNWUV5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gk0SvyMT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2D9EC433C7;
	Wed, 14 Feb 2024 00:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707869591;
	bh=YjRxLXMYjQj3SykZc5RCVnmpptEAKVGxlOa5zDENcso=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Gk0SvyMTUVbS6SW29SW6KVXh9v+1DrxuX+rFG/jLRW5N1B+Xd3KRxvHOzIiC5smMD
	 /mR4Q0PHlAehqCr/ZhHfq5LXDs1hOuCWzPJs1KzEy9kXejBQCARgyNn8Q0j4dDeKOu
	 88gsgobFZ96O/n6TU28k99Ajxm0QO2aHr3uncZ/ErhPUk6FrZghzbT5xzitU1Cfh68
	 HTEauBGoExtwBPts/NjcvYgwotuMqI/g4f5ThRYzQyw8HqDk2AIGuk2lkS4vHcmxYV
	 9GXZcb5YVF5AwJc2E0f7cvJXhpnOE4nRVqYJRoquB/EvX9d6Oi56/ye74yyYSxudNX
	 tFczRsTCx0iow==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 14 Feb 2024 02:13:07 +0200
Message-Id: <CZ4D8PADNQOW.2TVPZ4KW8MV5B@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v7 00/21] add integrity and security to TPM2
 transactions
X-Mailer: aerc 0.16.0
References: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
In-Reply-To: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>

On Tue Feb 13, 2024 at 7:13 PM EET, James Bottomley wrote:
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
> v5: update to proposed tpm-buf implementation (for ease of use all
> precursor patches are part of this series, so the actual session HMAC
> and encryption begins at patch 10) and add review feedback
> v6: split the original sessions patch into three and change the config
> variable name
> v7: Collect reviews and add extra patch to check for and disable the TPM =
on
> detecting a reset attack.
>
> James
>
> ---
>
> Ard Biesheuvel (1):
>   crypto: lib - implement library version of AES in CFB mode
>
> James Bottomley (13):
>   tpm: Move buffer handling from static inlines to real functions
>   tpm: add buffer function to point to returned parameters
>   tpm: export the context save and load commands
>   tpm: Add NULL primary creation
>   tpm: Add HMAC session start and end functions
>   tpm: Add HMAC session name/handle append
>   tpm: Add the rest of the session HMAC API
>   tpm: add hmac checks to tpm2_pcr_extend()
>   tpm: add session encryption protection to tpm2_get_random()
>   KEYS: trusted: Add session encryption protection to the seal/unseal
>     path
>   tpm: add the null key name as a sysfs export
>   Documentation: add tpm-security.rst
>   tpm: disable the TPM if NULL name changes
>
> Jarkko Sakkinen (7):
>   tpm: Remove unused tpm_buf_tag()
>   tpm: Remove tpm_send()
>   tpm: Update struct tpm_buf documentation comments
>   tpm: Store the length of the tpm_buf data separately.
>   tpm: TPM2B formatted buffers
>   tpm: Add tpm_buf_read_{u8,u16,u32}
>   KEYS: trusted: tpm2: Use struct tpm_buf for sized buffers
>
>  Documentation/security/tpm/tpm-security.rst |  216 ++++
>  drivers/char/tpm/Kconfig                    |   14 +
>  drivers/char/tpm/Makefile                   |    2 +
>  drivers/char/tpm/tpm-buf.c                  |  251 ++++
>  drivers/char/tpm/tpm-chip.c                 |    6 +
>  drivers/char/tpm/tpm-interface.c            |   26 +-
>  drivers/char/tpm/tpm-sysfs.c                |   18 +
>  drivers/char/tpm/tpm.h                      |   14 +
>  drivers/char/tpm/tpm2-cmd.c                 |   53 +-
>  drivers/char/tpm/tpm2-sessions.c            | 1223 +++++++++++++++++++
>  drivers/char/tpm/tpm2-space.c               |   11 +-
>  include/crypto/aes.h                        |    5 +
>  include/keys/trusted_tpm.h                  |    2 -
>  include/linux/tpm.h                         |  296 +++--
>  lib/crypto/Kconfig                          |    5 +
>  lib/crypto/Makefile                         |    3 +
>  lib/crypto/aescfb.c                         |  257 ++++
>  security/keys/trusted-keys/trusted_tpm1.c   |   23 +-
>  security/keys/trusted-keys/trusted_tpm2.c   |  136 ++-
>  19 files changed, 2366 insertions(+), 195 deletions(-)
>  create mode 100644 Documentation/security/tpm/tpm-security.rst
>  create mode 100644 drivers/char/tpm/tpm-buf.c
>  create mode 100644 drivers/char/tpm/tpm2-sessions.c
>  create mode 100644 lib/crypto/aescfb.c

Thank you. I'll test this with QEMU and at least x86 before
giving any feedback. Just denoting that I've not missed this.
I should hopefully have bandwidth next week to achieve this.

BR, Jarkko

