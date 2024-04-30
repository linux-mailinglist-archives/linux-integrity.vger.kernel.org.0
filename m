Return-Path: <linux-integrity+bounces-2297-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 133CD8B8216
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Apr 2024 23:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3189F1C227AC
	for <lists+linux-integrity@lfdr.de>; Tue, 30 Apr 2024 21:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBDB1BED73;
	Tue, 30 Apr 2024 21:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s9QOn4hq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B461A38DE;
	Tue, 30 Apr 2024 21:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714513734; cv=none; b=p0svXKHaiwiqeK99FE4l3Lxz6sykVdyS0fbaogpmsngWdaIzF5Ij2+yPl11CPrkSJ7KIOcNAnMh7EZNTLNvLvvvziZS01ruvS5/UrnLb4wvXd44e8Zc1E6F/rtmZjltd0XHOnU/X0lw0a4xazM0JJD8NWSbyAv+CJcnBV9ukq9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714513734; c=relaxed/simple;
	bh=v1zVpKbULAsgrG4Epg9joAmJsGX/uwlSWuzAFHZwsvM=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=LPrTtKX3ZmonMZqIOQxpF77TsREVsj+EmP8iWHOcWVuRPv+eG4ka1TgU3O0oBkVCKu+KX9ikP1I5IrkTVDxDxjVydiNrDKsYIKtjMlWeT0o3nfHhHJXqr6Kc3UA9ycTGyzHpCEGRT4bc2N+ob8QOnuqWo4YXGSXeDbblDUvfYT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s9QOn4hq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5350C2BBFC;
	Tue, 30 Apr 2024 21:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714513733;
	bh=v1zVpKbULAsgrG4Epg9joAmJsGX/uwlSWuzAFHZwsvM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s9QOn4hqEVdDs3W/zH7em6ZUyz2Q3eyuNQya5SQBfL29Qc2AbQIJLk4SSA+F5Wi2+
	 XOygMDAGlw6oDo2PIXdePSDgxn3wV31s5AklKxM/qT07FlbN/gxqDX4VjgdxwKLJTe
	 TzFoJ6CtKNSgtbZ8UrosyurhTIoYsSJGpvcsCckLkafB9AcPISfwwsoySx+rUzDjRH
	 SONdc3hD4mozI5xcqcXbn/n/Ydk7/GXscjnQoH6IZkccSjzwZMa6+G8/1SzdVCMw6G
	 NZzui5qk97GoCwNDmYqtk/mIjyp/RdmMBppx6DXM4dNEIwF+m1zzvNwDVKkVu6nRzc
	 sH6Qmh40Dz4Fg==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 01 May 2024 00:48:50 +0300
Message-Id: <D0XSE6G33OHS.1B4OFPN0NCEIM@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "James Bottomley" <James.Bottomley@HansenPartnership.com>,
 <linux-integrity@vger.kernel.org>
Cc: <keyrings@vger.kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>
Subject: Re: [PATCH v8 00/22] add integrity and security to TPM2
 transactions
X-Mailer: aerc 0.17.0
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
 <D0WYH9UDXCZC.3OZ9MSOVTDBE1@kernel.org>
 <eef3292f4680c22b817021f973a34a1657b82c86.camel@HansenPartnership.com>
In-Reply-To: <eef3292f4680c22b817021f973a34a1657b82c86.camel@HansenPartnership.com>

On Tue Apr 30, 2024 at 10:23 PM EEST, James Bottomley wrote:
> On Tue, 2024-04-30 at 01:22 +0300, Jarkko Sakkinen wrote:
> > On Mon Apr 29, 2024 at 11:27 PM EEST, James Bottomley wrote:
> > > The interest in securing the TPM against interposers, both active
> > > and
> > > passive has risen to fever pitch with the demonstration of key
> > > recovery against windows bitlocker:
> > >=20
> > > https://dolosgroup.io/blog/2021/7/9/from-stolen-laptop-to-inside-the-=
company-network
> > >=20
> > > And subsequently the same attack being successful against all the
> > > Linux TPM based security solutions:
> > >=20
> > > https://www.secura.com/blog/tpm-sniffing-attacks-against-non-bitlocke=
r-targets
> > >=20
> > > The attacks fall into two categories:
> > >=20
> > > 1. Passive Interposers, which sit on the bus and merely observe
> > > 2. Active Interposers, which try to manipulate TPM transactions on
> > > the
> > > =C2=A0=C2=A0 bus using man in the middle and packet stealing to creat=
e TPM
> > > state
> > > =C2=A0=C2=A0 the interposer owner desires.
> > >=20
> > > Our broadest interposer target is the use of TPM_RS_PW for password
> > > authorization which sends the actual password to the TPM without
> > > any
> > > obfuscation and effectively hands it to any interposer. The way to
> > > fix
> > > this is to use real sessions for HMAC capabilities to ensure
> > > integrity
> > > and to use parameter and response encryption to ensure
> > > confidentiality
> > > of the data flowing over the TPM bus.=C2=A0 HMAC sessions by agreeing=
 a
> > > challenge with the TPM and then giving a response which is a HMAC
> > > of
> > > the password and the challenge, so the application proves knowledge
> > > of
> > > the password to the TPM without ever transmitting the password
> > > itself.
> > > Using HMAC sessions when sending commands to the TPM also provides
> > > some measure of protection against active interposers, since the
> > > interposer can't interfere with or delete a HMAC'd command (because
> > > they can't manufacture a response with the correct HMAC).
> > >=20
> > > To protect TPM transactions where there isn't a shared secret
> > > (i.e. the command is something like a PCR extension which doesn't
> > > involve a TPM object with a password) we have to do a bit more work
> > > to
> > > set up sessions with a passed in encrypted secret (called a salt)
> > > to
> > > act in place of the shared secret in the HMAC.=C2=A0 This secret salt=
 is
> > > effectively a random number encrypted to a public key of the TPM.=C2=
=A0
> > > The
> > > final piece of the puzzle is using parameter input and response
> > > return
> > > encryption, so any interposer can't see the data passing from the
> > > application to the TPM and vice versa.
> > >=20
> > > The most insidious interposer attack of all is a reset attack:
> > > since
> > > the interposer has access to the TPM bus, it can assert the TPM
> > > reset
> > > line any time it wants.=C2=A0 When a TPM resets it mostly comes back =
in
> > > the
> > > same state except that all the PCRs are reset to their initial
> > > values.
> > > Controlling the reset line allows the interposer to change the PCR
> > > state after the fact by resetting the TPM and then replaying PCR
> > > extends to get the PCRs into a valid state to release secrets, so
> > > even
> > > if an attack event was recorded, the record is erased.=C2=A0 This res=
et
> > > attack violates the fundamental princible of non-repudiability of
> > > TPM
> > > logs.=C2=A0 Defeating the reset attack involves tying all TPM operati=
ons
> > > within the kernel to a property which will change detectably if the
> > > TPM is reset.=C2=A0 For that reason, we tie all TPM sessions to the n=
ull
> > > hierarchy we obtain at start of day and whose seed changes on every
> > > reset.=C2=A0 If an active interposer asserts a TPM reset, the new nul=
l
> > > primary won't match the kernel's stored one and all TPM operations
> > > will start failing because of HMAC mismatches in the sessions.=C2=A0 =
So
> > > if
> > > the kernel TPM code keeps operating, it guarantees that a reset
> > > hasn't
> > > occurred.
> > >=20
> > > The final part of the puzzle is that the machine owner must have a
> > > fixed idea of the EK of their TPM and should have certified this
> > > with
> > > the TPM manufacturer.=C2=A0 On every boot, the certified EK public ke=
y
> > > should be used to do a make credential/activate credential
> > > attestation
> > > key insertion and then the null key certified with the attestation
> > > key.=C2=A0 We can follow a trust on first use model where an OS
> > > installation will extract and verify a public EK and save it to a
> > > read
> > > only file.
> > >=20
> > > This patch series adds a simple API which can ensure the above
> > > properties as a layered addition to the existing TPM handling code.
> > > This series now includes protections for PCR extend, getting random
> > > numbers from the TPM and data sealing and unsealing.=C2=A0 It therefo=
re
> > > eliminates all uses of TPM2_RS_PW in the kernel and adds encryption
> > > protection to sensitive data flowing into and out of the TPM.=C2=A0 T=
he
> > > first four patches add more sophisticated buffer handling to the
> > > TPM
> > > which is needed to build the more complex encryption and
> > > authentication based commands.=C2=A0 Patch 6 adds all the generic
> > > cryptography primitives and patches 7-9 use them in critical TPM
> > > operations where we want to avoid or detect interposers.=C2=A0 Patch =
10
> > > exports the name of the null key we used for boot/run time
> > > verification and patch 11 documents the security guarantees and
> > > expectations.
> > >=20
> > > This was originally sent over four years ago, with the last
> > > iteration
> > > being:
> > >=20
> > > https://lore.kernel.org/linux-integrity/1568031515.6613.31.camel@Hans=
enPartnership.com/
> > >=20
> > > I'm dusting it off now because various forces at Microsoft and
> > > Google
> > > via the Open Compute Platform are making a lot of noise about
> > > interposers and we in the linux kernel look critically lacking in
> > > that
> > > regard, particularly for TPM trusted keys.
> > >=20
> > > ---
> > > v2 fixes the problems smatch reported and adds more explanation
> > > about
> > > the code motion in the first few patches
> > > v3 rebases the encryption to be against Ard's new library function,
> > > the
> > > aescfb addition of which appears as patch 1.
> > > v4 refreshes Ard's patch, adds kernel doc (including a new patch to
> > > add it to the moved tpm-buf functions) updates and rewords some
> > > commit
> > > logs
> > > v5: update to proposed tpm-buf implementation (for ease of use all
> > > precursor patches are part of this series, so the actual session
> > > HMAC
> > > and encryption begins at patch 10) and add review feedback
> > > v6: split the original sessions patch into three and change the
> > > config
> > > variable name
> > > v7: Collect reviews and add extra patch to check for and disable
> > > the TPM on
> > > detecting a reset attack.
> > > v8: split KDF out, add tpm_ prefix + other cosmetic updates
> > >=20
> > > James
> > >=20
> > > ---
> > >=20
> > > Ard Biesheuvel (1):
> > > =C2=A0 crypto: lib - implement library version of AES in CFB mode
> > >=20
> > > James Bottomley (14):
> > > =C2=A0 tpm: Move buffer handling from static inlines to real function=
s
> > > =C2=A0 tpm: add buffer function to point to returned parameters
> > > =C2=A0 tpm: export the context save and load commands
> > > =C2=A0 tpm: Add NULL primary creation
> > > =C2=A0 tpm: Add TCG mandated Key Derivation Functions (KDFs)
> > > =C2=A0 tpm: Add HMAC session start and end functions
> > > =C2=A0 tpm: Add HMAC session name/handle append
> > > =C2=A0 tpm: Add the rest of the session HMAC API
> > > =C2=A0 tpm: add hmac checks to tpm2_pcr_extend()
> > > =C2=A0 tpm: add session encryption protection to tpm2_get_random()
> > > =C2=A0 KEYS: trusted: Add session encryption protection to the
> > > seal/unseal
> > > =C2=A0=C2=A0=C2=A0 path
> > > =C2=A0 tpm: add the null key name as a sysfs export
> > > =C2=A0 Documentation: add tpm-security.rst
> > > =C2=A0 tpm: disable the TPM if NULL name changes
> > >=20
> > > Jarkko Sakkinen (7):
> > > =C2=A0 tpm: Remove unused tpm_buf_tag()
> > > =C2=A0 tpm: Remove tpm_send()
> > > =C2=A0 tpm: Update struct tpm_buf documentation comments
> > > =C2=A0 tpm: Store the length of the tpm_buf data separately.
> > > =C2=A0 tpm: TPM2B formatted buffers
> > > =C2=A0 tpm: Add tpm_buf_read_{u8,u16,u32}
> > > =C2=A0 KEYS: trusted: tpm2: Use struct tpm_buf for sized buffers
> > >=20
> > > =C2=A0Documentation/security/tpm/tpm-security.rst |=C2=A0 216 ++++
> > > =C2=A0drivers/char/tpm/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 14 +
> > > =C2=A0drivers/char/tpm/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
=C2=A0=C2=A0=C2=A0 2 +
> > > =C2=A0drivers/char/tpm/tpm-buf.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 =
251 ++++
> > > =C2=A0drivers/char/tpm/tpm-chip.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=
=C2=A0 6 +
> > > =C2=A0drivers/char/tpm/tpm-interface.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 26 +-
> > > =C2=A0drivers/char/tpm/tpm-sysfs.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 18 =
+
> > > =C2=A0drivers/char/tpm/tpm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 14 +
> > > =C2=A0drivers/char/tpm/tpm2-cmd.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 =
53 +-
> > > =C2=A0drivers/char/tpm/tpm2-sessions.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 1280
> > > +++++++++++++++++++
> > > =C2=A0drivers/char/tpm/tpm2-space.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 11 +-
> > > =C2=A0include/crypto/aes.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 5 +
> > > =C2=A0include/keys/trusted_tpm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0=C2=A0 2 -
> > > =C2=A0include/linux/tpm.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 316 +++--
> > > =C2=A0lib/crypto/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 5 +
> > > =C2=A0lib/crypto/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0 3 +
> > > =C2=A0lib/crypto/aescfb.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 257 ++++
> > > =C2=A0security/keys/trusted-keys/trusted_tpm1.c=C2=A0=C2=A0 |=C2=A0=
=C2=A0 23 +-
> > > =C2=A0security/keys/trusted-keys/trusted_tpm2.c=C2=A0=C2=A0 |=C2=A0 1=
36 +-
> > > =C2=A019 files changed, 2443 insertions(+), 195 deletions(-)
> > > =C2=A0create mode 100644 Documentation/security/tpm/tpm-security.rst
> > > =C2=A0create mode 100644 drivers/char/tpm/tpm-buf.c
> > > =C2=A0create mode 100644 drivers/char/tpm/tpm2-sessions.c
> > > =C2=A0create mode 100644 lib/crypto/aescfb.c
> >=20
> > Thanks for the update!
> >=20
> > I think I asked this already earlier but unfortunately could not
> > find the corresponding email from lore.
>
> Well, you did, but at that time I didn't have the null name change
> detection so:
>
> >=20
> > Anyway, I've tested this series with QEMU i.e. to the point that
> > I know that it does not break anything in the case when things are
> > working as expected.
> >=20
> > What I would like to test is the negative case when the null key
> > name changes and see what happens.
> >=20
> > I recall that you had some version of QEMU that had ability to test
> > this and my latest question on that was what QEMU baseline it was
> > expected to be applied over.
>
> Yes, I added patches to qemu to make it talk directly to the mssim TPM
> reference implementation
>
> https://github.com/microsoft/ms-tpm-20-ref
>
> so I could be sure I was testing against the reference implementation.
> However, they also have the advantage that you can use wireshark to
> dump the TPM transactions (ensuring encryption).  You can also tamper
> with the TPM state from the outside by connecting to the TPM socket.
>
> For the case you want, you can simulate a reset by killing and
> restarting the tpm server (you have to power it up and issue the
> startup command manually).  The next TPM command the kernel tries
> should see the null name change and react accordingly.
>
> It looks like the current qemu patches fail to apply again, so I just
> reposted them against qemu git head:
>
> https://lore.kernel.org/qemu-devel/20240430190855.2811-1-James.Bottomley@=
HansenPartnership.com/
>
> > Since I could not find the email subthread I neither have the patch
> > nor do know the baseline. So if you could help with these details
> > then we can move forward.
> >=20
> > I can also work with QEMU Git fork if you have one and point out
> > QEMU_OVERRIDE_SRCDIR to the clone.
>
> I only have the patches in a local git repository, but I could push
> qemu up onto kernel.org if it would help?

That definitely does help. I can point out my build to that repository,
(or actually clone of it).

As said the "valid flow" has been tested multiple times. I guess I can
hold v6.10 PR to next week so there is still time to barely squeeze this
to v6.10.

BR, Jarkko

