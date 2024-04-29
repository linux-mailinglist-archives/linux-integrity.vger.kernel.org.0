Return-Path: <linux-integrity+bounces-2278-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF678B63B3
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 22:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB96A1F22DF5
	for <lists+linux-integrity@lfdr.de>; Mon, 29 Apr 2024 20:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFC51649CD;
	Mon, 29 Apr 2024 20:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="UdzN3HtF"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D061635CC;
	Mon, 29 Apr 2024 20:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714422693; cv=none; b=OaOgD6mmsma+BjRC8FSJNuDf+n1lCQqTy1o88PAj/xFWnyDBJp97hV0iDztqnObHviYJcq3o6o/TEYnDUQlnDnTMRh3QR5SUwTlia2zs6FIaV4gj3eYvC8TqqHXu6AXfouvoKCX9h1jEcCSPD0jGrmgoPpyEuFzRk7do/GW8U/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714422693; c=relaxed/simple;
	bh=+AcALnLhrxyTrreUNrnR/m4lugS1ce1ISYEJdO6iTjI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=umRS3aYc7L98t9mdYugrfmwDYJrSsz7Up2OzA8FnSkRh5cix080N97qvaKT5uW7mif1SzBaLoQUp0JXylyFHzwjsRQIeTLBmAh8pHAb9bXlCJv7S914BFIBiRdJcNPkKIZR5fYia9a1DE4YqTpbyAWCtFf4BiHtjxMYOG7A4Suc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=UdzN3HtF; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1714422691;
	bh=+AcALnLhrxyTrreUNrnR/m4lugS1ce1ISYEJdO6iTjI=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:From;
	b=UdzN3HtFcXu1zUiQNJCCoNWGLCk0TUUWpHXfbO7NjeRZNWh8jOrMWvJxgf6z2QlKz
	 QuwpajX/8SgVK0RDgvX10Q8sGZsvRd7MiKCCptj2QdD8kwNKLcSMbKBIzf2G6Ox1NL
	 A7BgegBV5qVF4cbWVJJUE9scqpldIRz+2TYpUD7g=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 174E012819F3;
	Mon, 29 Apr 2024 16:31:31 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id ES8C9BIFO3Kc; Mon, 29 Apr 2024 16:31:31 -0400 (EDT)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 802031280AB2;
	Mon, 29 Apr 2024 16:31:30 -0400 (EDT)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>,
	keyrings@vger.kernel.org,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH v8 21/22] Documentation: add tpm-security.rst
Date: Mon, 29 Apr 2024 16:28:10 -0400
Message-Id: <20240429202811.13643-22-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
References: <20240429202811.13643-1-James.Bottomley@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document how the new encrypted secure interface for TPM2 works and how
security can be assured after boot by certifying the NULL seed.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

---
v7: add review
---
 Documentation/security/tpm/tpm-security.rst | 216 ++++++++++++++++++++
 1 file changed, 216 insertions(+)
 create mode 100644 Documentation/security/tpm/tpm-security.rst

diff --git a/Documentation/security/tpm/tpm-security.rst b/Documentation/security/tpm/tpm-security.rst
new file mode 100644
index 000000000000..4f633f251033
--- /dev/null
+++ b/Documentation/security/tpm/tpm-security.rst
@@ -0,0 +1,216 @@
+.. SPDX-License-Identifier: GPL-2.0-only
+
+TPM Security
+============
+
+The object of this document is to describe how we make the kernel's
+use of the TPM reasonably robust in the face of external snooping and
+packet alteration attacks (called passive and active interposer attack
+in the literature).  The current security document is for TPM 2.0.
+
+Introduction
+------------
+
+The TPM is usually a discrete chip attached to a PC via some type of
+low bandwidth bus.  There are exceptions to this such as the Intel
+PTT, which is a software TPM running inside a software environment
+close to the CPU, which are subject to different attacks, but right at
+the moment, most hardened security environments require a discrete
+hardware TPM, which is the use case discussed here.
+
+Snooping and Alteration Attacks against the bus
+-----------------------------------------------
+
+The current state of the art for snooping the `TPM Genie`_ hardware
+interposer which is a simple external device that can be installed in
+a couple of seconds on any system or laptop.  Recently attacks were
+successfully demonstrated against the `Windows Bitlocker TPM`_ system.
+Most recently the same `attack against TPM based Linux disk
+encryption`_ schemes.  The next phase of research seems to be hacking
+existing devices on the bus to act as interposers, so the fact that
+the attacker requires physical access for a few seconds might
+evaporate.  However, the goal of this document is to protect TPM
+secrets and integrity as far as we are able in this environment and to
+try to insure that if we can't prevent the attack then at least we can
+detect it.
+
+Unfortunately, most of the TPM functionality, including the hardware
+reset capability can be controlled by an attacker who has access to
+the bus, so we'll discuss some of the disruption possibilities below.
+
+Measurement (PCR) Integrity
+---------------------------
+
+Since the attacker can send their own commands to the TPM, they can
+send arbitrary PCR extends and thus disrupt the measurement system,
+which would be an annoying denial of service attack.  However, there
+are two, more serious, classes of attack aimed at entities sealed to
+trust measurements.
+
+1. The attacker could intercept all PCR extends coming from the system
+   and completely substitute their own values, producing a replay of
+   an untampered state that would cause PCR measurements to attest to
+   a trusted state and release secrets
+
+2. At some point in time the attacker could reset the TPM, clearing
+   the PCRs and then send down their own measurements which would
+   effectively overwrite the boot time measurements the TPM has
+   already done.
+
+The first can be thwarted by always doing HMAC protection of the PCR
+extend and read command meaning measurement values cannot be
+substituted without producing a detectable HMAC failure in the
+response.  However, the second can only really be detected by relying
+on some sort of mechanism for protection which would change over TPM
+reset.
+
+Secrets Guarding
+----------------
+
+Certain information passing in and out of the TPM, such as key sealing
+and private key import and random number generation, is vulnerable to
+interception which HMAC protection alone cannot protect against, so
+for these types of command we must also employ request and response
+encryption to prevent the loss of secret information.
+
+Establishing Initial Trust with the TPM
+---------------------------------------
+
+In order to provide security from the beginning, an initial shared or
+asymmetric secret must be established which must also be unknown to
+the attacker.  The most obvious avenues for this are the endorsement
+and storage seeds, which can be used to derive asymmetric keys.
+However, using these keys is difficult because the only way to pass
+them into the kernel would be on the command line, which requires
+extensive support in the boot system, and there's no guarantee that
+either hierarchy would not have some type of authorization.
+
+The mechanism chosen for the Linux Kernel is to derive the primary
+elliptic curve key from the null seed using the standard storage seed
+parameters.  The null seed has two advantages: firstly the hierarchy
+physically cannot have an authorization, so we are always able to use
+it and secondly, the null seed changes across TPM resets, meaning if
+we establish trust on the null seed at start of day, all sessions
+salted with the derived key will fail if the TPM is reset and the seed
+changes.
+
+Obviously using the null seed without any other prior shared secrets,
+we have to create and read the initial public key which could, of
+course, be intercepted and substituted by the bus interposer.
+However, the TPM has a key certification mechanism (using the EK
+endorsement certificate, creating an attestation identity key and
+certifying the null seed primary with that key) which is too complex
+to run within the kernel, so we keep a copy of the null primary key
+name, which is what is exported via sysfs so user-space can run the
+full certification when it boots.  The definitive guarantee here is
+that if the null primary key certifies correctly, you know all your
+TPM transactions since start of day were secure and if it doesn't, you
+know there's an interposer on your system (and that any secret used
+during boot may have been leaked).
+
+Stacking Trust
+--------------
+
+In the current null primary scenario, the TPM must be completely
+cleared before handing it on to the next consumer.  However the kernel
+hands to user-space the name of the derived null seed key which can
+then be verified by certification in user-space.  Therefore, this chain
+of name handoff can be used between the various boot components as
+well (via an unspecified mechanism).  For instance, grub could use the
+null seed scheme for security and hand the name off to the kernel in
+the boot area.  The kernel could make its own derivation of the key
+and the name and know definitively that if they differ from the handed
+off version that tampering has occurred.  Thus it becomes possible to
+chain arbitrary boot components together (UEFI to grub to kernel) via
+the name handoff provided each successive component knows how to
+collect the name and verifies it against its derived key.
+
+Session Properties
+------------------
+
+All TPM commands the kernel uses allow sessions.  HMAC sessions may be
+used to check the integrity of requests and responses and decrypt and
+encrypt flags may be used to shield parameters and responses.  The
+HMAC and encryption keys are usually derived from the shared
+authorization secret, but for a lot of kernel operations that is well
+known (and usually empty).  Thus, every HMAC session used by the
+kernel must be created using the null primary key as the salt key
+which thus provides a cryptographic input into the session key
+derivation.  Thus, the kernel creates the null primary key once (as a
+volatile TPM handle) and keeps it around in a saved context stored in
+tpm_chip for every in-kernel use of the TPM.  Currently, because of a
+lack of de-gapping in the in-kernel resource manager, the session must
+be created and destroyed for each operation, but, in future, a single
+session may also be reused for the in-kernel HMAC, encryption and
+decryption sessions.
+
+Protection Types
+----------------
+
+For every in-kernel operation we use null primary salted HMAC to
+protect the integrity.  Additionally, we use parameter encryption to
+protect key sealing and parameter decryption to protect key unsealing
+and random number generation.
+
+Null Primary Key Certification in Userspace
+===========================================
+
+Every TPM comes shipped with a couple of X.509 certificates for the
+primary endorsement key.  This document assumes that the Elliptic
+Curve version of the certificate exists at 01C00002, but will work
+equally well with the RSA certificate (at 01C00001).
+
+The first step in the certification is primary creation using the
+template from the `TCG EK Credential Profile`_ which allows comparison
+of the generated primary key against the one in the certificate (the
+public key must match).  Note that generation of the EK primary
+requires the EK hierarchy password, but a pre-generated version of the
+EC primary should exist at 81010002 and a TPM2_ReadPublic() may be
+performed on this without needing the key authority.  Next, the
+certificate itself must be verified to chain back to the manufacturer
+root (which should be published on the manufacturer website).  Once
+this is done, an attestation key (AK) is generated within the TPM and
+it's name and the EK public key can be used to encrypt a secret using
+TPM2_MakeCredential.  The TPM then runs TPM2_ActivateCredential which
+will only recover the secret if the binding between the TPM, the EK
+and the AK is true. the generated AK may now be used to run a
+certification of the null primary key whose name the kernel has
+exported.  Since TPM2_MakeCredential/ActivateCredential are somewhat
+complicated, a more simplified process involving an externally
+generated private key is described below.
+
+This process is a simplified abbreviation of the usual privacy CA
+based attestation process.  The assumption here is that the
+attestation is done by the TPM owner who thus has access to only the
+owner hierarchy.  The owner creates an external public/private key
+pair (assume elliptic curve in this case) and wraps the private key
+for import using an inner wrapping process and parented to the EC
+derived storage primary.  The TPM2_Import() is done using a parameter
+decryption HMAC session salted to the EK primary (which also does not
+require the EK key authority) meaning that the inner wrapping key is
+the encrypted parameter and thus the TPM will not be able to perform
+the import unless is possesses the certified EK so if the command
+succeeds and the HMAC verifies on return we know we have a loadable
+copy of the private key only for the certified TPM.  This key is now
+loaded into the TPM and the Storage primary flushed (to free up space
+for the null key generation).
+
+The null EC primary is now generated using the Storage profile
+outlined in the `TCG TPM v2.0 Provisioning Guidance`_; the name of
+this key (the hash of the public area) is computed and compared to the
+null seed name presented by the kernel in
+/sys/class/tpm/tpm0/null_name.  If the names do not match, the TPM is
+compromised.  If the names match, the user performs a TPM2_Certify()
+using the null primary as the object handle and the loaded private key
+as the sign handle and providing randomized qualifying data.  The
+signature of the returned certifyInfo is verified against the public
+part of the loaded private key and the qualifying data checked to
+prevent replay.  If all of these tests pass, the user is now assured
+that TPM integrity and privacy was preserved across the entire boot
+sequence of this kernel.
+
+.. _TPM Genie: https://www.nccgroup.trust/globalassets/about-us/us/documents/tpm-genie.pdf
+.. _Windows Bitlocker TPM: https://dolosgroup.io/blog/2021/7/9/from-stolen-laptop-to-inside-the-company-network
+.. _attack against TPM based Linux disk encryption: https://www.secura.com/blog/tpm-sniffing-attacks-against-non-bitlocker-targets
+.. _TCG EK Credential Profile: https://trustedcomputinggroup.org/resource/tcg-ek-credential-profile-for-tpm-family-2-0/
+.. _TCG TPM v2.0 Provisioning Guidance: https://trustedcomputinggroup.org/resource/tcg-tpm-v2-0-provisioning-guidance/
-- 
2.35.3


