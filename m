Return-Path: <linux-integrity+bounces-1163-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 229DD8536EC
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Feb 2024 18:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 468C21C21D0C
	for <lists+linux-integrity@lfdr.de>; Tue, 13 Feb 2024 17:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A355FBB5;
	Tue, 13 Feb 2024 17:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="iSi/yI55"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DEA5FB94;
	Tue, 13 Feb 2024 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844423; cv=none; b=cXUYXIrN5B+y+NNZfUN8J58PIYu0Wg+RqfLINOCyo7DSJ3QJf7tYf157osLTJKGpsmoHyPWxJRD9qs5rsgIBGZitUWUe1RrMbSCKaMKnBLUBTeDfiI9piMWY/6xRZHoCJOcE936iKh+c6Cem7p6WbcfjPq784jaoWRHRMkUcIGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844423; c=relaxed/simple;
	bh=ZdXq6kNcJpcEPF9RajtyqN8ExbiKtKGM2tjWvleXpAY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e6gDksG8b4numZvt1or3U1wmrUjiGWLK3cFKOtPv9z/93h+hLLNTKM+TLslXVYgNFBSU+XJLvrxOwBGkzAlerVHzTagVDkVnRqFa2igjL4sN74LKA/Z4cLgeZkSM/0kUIL1gV9yM8Znwp324j7VUSdRsl5U9iMaEJaNAtfx4v+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=iSi/yI55; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1707844419;
	bh=ZdXq6kNcJpcEPF9RajtyqN8ExbiKtKGM2tjWvleXpAY=;
	h=From:To:Subject:Date:Message-Id:From;
	b=iSi/yI55KySabzncDsF9NC7IIbfKP36B25MgtStSir7gHhe6DbumFCb2nfj5IP34I
	 +Exb8UImIapK2gshY7QMt2fg24L3bz4fMQHl0aJtHh5G6m06RHiuDGz37f+q5HmUUN
	 v4xRFOurd9cZnhtHjArbDRHUS6jSA47ldOvVm58Y=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 4E1DD1280BEA;
	Tue, 13 Feb 2024 12:13:39 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id hWFj8Ysn5_yi; Tue, 13 Feb 2024 12:13:39 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 886E51280BAC;
	Tue, 13 Feb 2024 12:13:38 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v7 00/21] add integrity and security to TPM2 transactions
Date: Tue, 13 Feb 2024 12:13:13 -0500
Message-Id: <20240213171334.30479-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
v3 rebases the encryption to be against Ard's new library function, the
aescfb addition of which appears as patch 1.
v4 refreshes Ard's patch, adds kernel doc (including a new patch to
add it to the moved tpm-buf functions) updates and rewords some commit
logs
v5: update to proposed tpm-buf implementation (for ease of use all
precursor patches are part of this series, so the actual session HMAC
and encryption begins at patch 10) and add review feedback
v6: split the original sessions patch into three and change the config
variable name
v7: Collect reviews and add extra patch to check for and disable the TPM on
detecting a reset attack.

James

---

Ard Biesheuvel (1):
  crypto: lib - implement library version of AES in CFB mode

James Bottomley (13):
  tpm: Move buffer handling from static inlines to real functions
  tpm: add buffer function to point to returned parameters
  tpm: export the context save and load commands
  tpm: Add NULL primary creation
  tpm: Add HMAC session start and end functions
  tpm: Add HMAC session name/handle append
  tpm: Add the rest of the session HMAC API
  tpm: add hmac checks to tpm2_pcr_extend()
  tpm: add session encryption protection to tpm2_get_random()
  KEYS: trusted: Add session encryption protection to the seal/unseal
    path
  tpm: add the null key name as a sysfs export
  Documentation: add tpm-security.rst
  tpm: disable the TPM if NULL name changes

Jarkko Sakkinen (7):
  tpm: Remove unused tpm_buf_tag()
  tpm: Remove tpm_send()
  tpm: Update struct tpm_buf documentation comments
  tpm: Store the length of the tpm_buf data separately.
  tpm: TPM2B formatted buffers
  tpm: Add tpm_buf_read_{u8,u16,u32}
  KEYS: trusted: tpm2: Use struct tpm_buf for sized buffers

 Documentation/security/tpm/tpm-security.rst |  216 ++++
 drivers/char/tpm/Kconfig                    |   14 +
 drivers/char/tpm/Makefile                   |    2 +
 drivers/char/tpm/tpm-buf.c                  |  251 ++++
 drivers/char/tpm/tpm-chip.c                 |    6 +
 drivers/char/tpm/tpm-interface.c            |   26 +-
 drivers/char/tpm/tpm-sysfs.c                |   18 +
 drivers/char/tpm/tpm.h                      |   14 +
 drivers/char/tpm/tpm2-cmd.c                 |   53 +-
 drivers/char/tpm/tpm2-sessions.c            | 1223 +++++++++++++++++++
 drivers/char/tpm/tpm2-space.c               |   11 +-
 include/crypto/aes.h                        |    5 +
 include/keys/trusted_tpm.h                  |    2 -
 include/linux/tpm.h                         |  296 +++--
 lib/crypto/Kconfig                          |    5 +
 lib/crypto/Makefile                         |    3 +
 lib/crypto/aescfb.c                         |  257 ++++
 security/keys/trusted-keys/trusted_tpm1.c   |   23 +-
 security/keys/trusted-keys/trusted_tpm2.c   |  136 ++-
 19 files changed, 2366 insertions(+), 195 deletions(-)
 create mode 100644 Documentation/security/tpm/tpm-security.rst
 create mode 100644 drivers/char/tpm/tpm-buf.c
 create mode 100644 drivers/char/tpm/tpm2-sessions.c
 create mode 100644 lib/crypto/aescfb.c

-- 
2.35.3


