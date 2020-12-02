Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966682CC6BB
	for <lists+linux-integrity@lfdr.de>; Wed,  2 Dec 2020 20:35:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727146AbgLBTew (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 2 Dec 2020 14:34:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgLBTew (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 2 Dec 2020 14:34:52 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9453C0613CF;
        Wed,  2 Dec 2020 11:34:11 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id r6so1942373qtm.3;
        Wed, 02 Dec 2020 11:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1Wk+CAE1KvZQne0n7C3iLulWineyglxiQ8gJr5x5grc=;
        b=FAhLa6G8eX+fjpnVroXPFkvBDEQOpaU5GjpyozPh9wLYSrllX5qwb9OWEoRX2GAjL/
         a8zjBccMgbmaZs07bzs/vJPZl66PyaKj9xZ40f7nJibhGbMFejZlKlvor5F95dWFSVn6
         OprO2gwLFF39lWSjifoAi/6q3MHzhaZoxaoRrr0XKGpYu6Sz7ItpK98PEJUYB/7bn7Vm
         pGBUvkTE4EFEuWCddCflaiV0GBPL0XRkD2QUi9nlgzx24m86bJlQaMEsncBMUO7m1DZw
         /ZTypAw8BCUoNv15fQErE121Q3FDVNy4pvkvucyhxWwfBmocxQB53oBtFDSi6Icmx7hl
         3fFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=1Wk+CAE1KvZQne0n7C3iLulWineyglxiQ8gJr5x5grc=;
        b=RTtDiFC72XvFANrN2nhLpnBqFeDI6ScLjd1umgF/dKi8f3WSXyxTyQ4TZFlllbTHYo
         qPndbnxNR/DlFW98bl2ihtoXRIduGyUbYCnv16p2/f6GKLbtOiZhAIXL0hUwIPry+uyk
         fs3umYN+LuzVez0gzu+3DOdJRj33P0OV5GHk+gZJcQCRnPzAxqX0rOCt1o7PuDpKXctg
         EaF/85fuwlWusOt+jlgOCbUuBE9GYQyvV3dlMK/sQO1DXxgxs8xNNz7EiClYLdSoWWAu
         I4OjCDubcmYN4DQhT+j1L/eb4D7tbGsxsvBaHq0caOLG8O6ktRghEhg1wIC1IzvZ9RNx
         N+bA==
X-Gm-Message-State: AOAM533haPS6UmbLSp+0iLlIh8h+wI7WHoGJEBDxchqyvax3UQt5pvGU
        IynS9R+LPokzRYR59qBeLhM=
X-Google-Smtp-Source: ABdhPJxJqIVwHaVuexoGYpw1rpgol+wjWjfEEsC5HnzxfkY+wYFRQcS/bkFadsGeTDcgJ2n+PrlpKg==
X-Received: by 2002:aed:33c4:: with SMTP id v62mr4186172qtd.19.1606937650828;
        Wed, 02 Dec 2020 11:34:10 -0800 (PST)
Received: from elaines-2018-ibm-macbook-pro.lan (c-71-192-139-151.hsd1.nh.comcast.net. [71.192.139.151])
        by smtp.gmail.com with ESMTPSA id u13sm2589321qta.87.2020.12.02.11.34.08
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Dec 2020 11:34:10 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH v8 3/4] doc: trusted-encrypted: updates with TEE as a new
 trust source
From:   gmail Elaine Palmer <erpalmerny@gmail.com>
In-Reply-To: <1604419306-26105-4-git-send-email-sumit.garg@linaro.org>
Date:   Wed, 2 Dec 2020 14:34:07 -0500
Cc:     jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com,
        jejb@linux.ibm.com, dhowells@redhat.com, jens.wiklander@linaro.org,
        corbet@lwn.net, jmorris@namei.org, serge@hallyn.com,
        casey@schaufler-ca.com, janne.karhunen@gmail.com,
        daniel.thompson@linaro.org, Markus.Wamser@mixed-mode.de,
        lhinds@redhat.com, keyrings@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        Kenneth Goldman <kgoldman@us.ibm.com>, gcwilson@linux.ibm.com,
        zgu@us.ibm.com, stefanb@us.ibm.com, NAYNA JAIN1 <naynjain@ibm.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <81A6B61D-3811-4957-B270-52AE5FA6DE4F@gmail.com>
References: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
 <1604419306-26105-4-git-send-email-sumit.garg@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


Hi Sumit, =20

Thank you for the detailed descriptions and examples of trust sources =
for Trusted Keys.   A group of us in IBM (Stefan Berger, Ken Goldman, =
Zhongshu Gu, Nayna Jain, Elaine Palmer, George Wilson, Mimi Zohar) have =
been doing related work for quite some time, and we have one primary =
concern and some suggested changes to the document.=20

Our primary concern is that describing a TEE as a Trust Source needs to =
be more specific.   For example, "ARM TrustZone" is not sufficient, but =
"wolfSSL embedded SSL/TLS library with ARM TrustZone CryptoCell-310" is. =
 Just because a key is protected by software running in a TEE is not =
enough to establish trust.  Just like cryptographic modules, a Trust =
Source should be defined as a specific implementation on specific =
hardware with well-documented environmental assumptions, dependencies, =
and threats.

In addition to the above concern, our suggested changes are inline =
below.

> Begin forwarded message:
>=20
> From: Sumit Garg <sumit.garg@linaro.org>
> Subject: [PATCH v8 3/4] doc: trusted-encrypted: updates with TEE as a =
new trust source
> Date: November 3, 2020 at 11:01:45 AM EST
> To: jarkko.sakkinen@linux.intel.com, zohar@linux.ibm.com, =
jejb@linux.ibm.com
> Cc: dhowells@redhat.com, jens.wiklander@linaro.org, corbet@lwn.net, =
jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com, =
janne.karhunen@gmail.com, daniel.thompson@linaro.org, =
Markus.Wamser@mixed-mode.de, lhinds@redhat.com, =
keyrings@vger.kernel.org, linux-integrity@vger.kernel.org, =
linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, =
linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, =
op-tee@lists.trustedfirmware.org, Sumit Garg <sumit.garg@linaro.org>
>=20
> Update documentation for Trusted and Encrypted Keys with TEE as a new
> trust source. Following is brief description of updates:
>=20
> - Add a section to demostrate a list of supported devices along with
> their security properties/guarantees.
> - Add a key generation section.
> - Updates for usage section including differences specific to a trust
> source.
>=20
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
> Documentation/security/keys/trusted-encrypted.rst | 203 =
++++++++++++++++++----
> 1 file changed, 171 insertions(+), 32 deletions(-)
>=20
> diff --git a/Documentation/security/keys/trusted-encrypted.rst =
b/Documentation/security/keys/trusted-encrypted.rst
> index 1da879a..16042c8 100644
> --- a/Documentation/security/keys/trusted-encrypted.rst
> +++ b/Documentation/security/keys/trusted-encrypted.rst
> @@ -6,30 +6,161 @@ Trusted and Encrypted Keys are two new key types =
added to the existing kernel
> key ring service.  Both of these new types are variable length =
symmetric keys,
> and in both cases all keys are created in the kernel, and user space =
sees,
> stores, and loads only encrypted blobs.  Trusted Keys require the =
availability
> -of a Trusted Platform Module (TPM) chip for greater security, while =
Encrypted
> -Keys can be used on any system.  All user level blobs, are displayed =
and loaded
> -in hex ascii for convenience, and are integrity verified.
> +of a Trust Source for greater security, while Encrypted Keys can be =
used on any
> +system. All user level blobs, are displayed and loaded in hex ascii =
for
> +convenience, and are integrity verified.
>=20
> -Trusted Keys use a TPM both to generate and to seal the keys.  Keys =
are sealed
> -under a 2048 bit RSA key in the TPM, and optionally sealed to =
specified PCR
> -(integrity measurement) values, and only unsealed by the TPM, if PCRs =
and blob
> -integrity verifications match.  A loaded Trusted Key can be updated =
with new
> -(future) PCR values, so keys are easily migrated to new pcr values, =
such as
> -when the kernel and initramfs are updated.  The same key can have =
many saved
> -blobs under different PCR values, so multiple boots are easily =
supported.
>=20
> -TPM 1.2
> --------
> +Trust Source
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>=20
> -By default, trusted keys are sealed under the SRK, which has the =
default
> -authorization value (20 zeros).  This can be set at takeownership =
time with the
> -trouser's utility: "tpm_takeownership -u -z".
> +Trust Source provides the source of security for the Trusted Keys, on =
which
> +basis Trusted Keys establishes a Trust model with its user. A Trust =
Source could
> +differ from one system to another depending on its security =
requirements. It
> +could be either an off-chip device or an on-chip device. Following =
section
> +demostrates a list of supported devices along with their security =
properties/
> +guarantees:
Please change the following=20
"Trust Source provides the source of security for the Trusted Keys, on =
which basis Trusted Keys establishes a Trust model with its user."=20
to=20
"A trust source provides the source of security for the Trusted Keys.  =
Whether or not a trust source is sufficiently safe depends on the =
strength and correctness of its implementation, as well as the threat =
environment for a specific use case.  Since the kernel doesn't know what =
the environment is, and there is no metric of trust, it is dependent on =
the consumer of the Trusted Keys to determine if the trust source is =
sufficiently safe."
>=20
> -TPM 2.0
> --------
> +  *  Root of trust for storage
>=20
> -The user must first create a storage key and make it persistent, so =
the key is
> -available after reboot. This can be done using the following =
commands.
> +     (1) TPM (Trusted Platform Module: hardware device)
> +
> +         Rooted to Storage Root Key (SRK) which never leaves the TPM =
that
> +         provides crypto operation to establish root of trust for =
storage.
> +
> +     (2) TEE (Trusted Execution Environment: OP-TEE based on Arm =
TrustZone)
> +
> +         Rooted to Hardware Unique Key (HUK) which is generally burnt =
in on-chip
> +         fuses and is accessible to TEE only.
> +
> +  *  Execution isolation
> +
> +     (1) TPM
> +
> +         Fixed set of operations running in isolated execution =
environment.
> +
> +     (2) TEE
> +
> +         Customizable set of operations running in isolated execution
> +         environment verified via Secure/Trusted boot process.
> +
> +  * Optional binding to platform integrity state
> +
> +     (1) TPM
> +
> +         Keys can be optionally sealed to specified PCR (integrity =
measurement)
> +         values, and only unsealed by the TPM, if PCRs and blob =
integrity
> +         verifications match. A loaded Trusted Key can be updated =
with new
> +         (future) PCR values, so keys are easily migrated to new PCR =
values,
> +         such as when the kernel and initramfs are updated. The same =
key can
> +         have many saved blobs under different PCR values, so =
multiple boots are
> +         easily supported.
> +
> +     (2) TEE
> +
> +         Relies on Secure/Trusted boot process for platform =
integrity. It can
> +         be extended with TEE based measured boot process.
> +
> +  *  On-chip versus off-chip
> +
> +     (1) TPM
> +
> +         Off-chip device connected via serial bus (like I2C, SPI =
etc.) exposing
> +         physical access which represents an attack surface that can =
be
> +         mitigated via tamper detection.
> +
> +     (2) TEE
> +
> +         On-chip functionality, immune to this attack surface.
> +
> +  *  Memory attacks (DRAM based like attaching a bus monitor etc.)
> +
> +     (1) TPM
> +
> +         Immune to these attacks as it doesn=E2=80=99t make use of =
system DRAM.
> +
> +     (2) TEE
> +
> +         An implementation based on TrustZone protected DRAM is =
susceptible to
> +         such attacks. In order to mitigate these attacks one needs =
to rely on
> +         on-chip secure RAM to store secrets or have the entire TEE
> +         implementation based on on-chip secure RAM. An alternative =
mitigation
> +         would be to use encrypted DRAM.
> +
> +  *  Side-channel attacks (cache, memory, CPU or time based)
> +
> +     (1) TPM
> +
> +         Immune to side-channel attacks as its resources are isolated =
from the
> +         main OS.
> +
> +     (2) TEE
> +
> +         A careful implementation is required to mitigate against =
these attacks
> +         for resources which are shared (eg. shared memory) with the =
main OS.
> +         Cache and CPU based side-channel attacks can be mitigated =
via
> +         invalidating caches and CPU registers during context switch =
to and from
> +         the secure world.
> +         To mitigate against time based attacks, one needs to have =
time
> +         invariant implementations (like crypto algorithms etc.).
> +
> +  *  Resistance to physical attacks (power analysis, electromagnetic =
emanation,
> +     probes etc.)
> +
> +     (1) TPM
> +
> +         Provides limited protection utilizing tamper resistance.
> +
> +     (2) TEE
> +
> +         Provides no protection by itself, relies on the underlying =
platform for
> +         features such as tamper resistance.
> +
> +
please add the following:

* Provisioning - the trust source's unique and verifiable cryptographic =
identity is provisioned during manufacturing

(1) TPM
The unique and verifiable cryptographic identity is the endorsement key =
(EK) or its primary seed.  A review of the generation of the EK and its =
accompanying certificate is part of the Common Criteria evaluation of =
the product's lifecycle processes (ALC_*).  See "TCG Protection Profile =
for PC Client Specific TPM 2" =
(https://trustedcomputinggroup.org/resource/pc-client-protection-profile-f=
or-tpm-2-0/).

(2) TEE
A protection profile for TEEs does not yet exist.  Therefore, the =
provisioning process that generates the Hardware Unique Key is not =
evaluated by an independent third party and is highly dependent on the =
manufacturing environment. =20


* Cryptography
(1) TPM
As part of the TPM's mandatory Common Criteria evaluation, the =
correctness of the TPM's implementation of cryptographic algorithms, the =
protection of keys, and the generation of random numbers, and other =
security-relevant functions must be documented, reviewed, and tested by =
an independent third party evaluation agency.  It must meet the =
requirements of FIPS 140-2, FIPS 140-3, or ISO/IEC 19790:2012.=20

(2) TEE
Evaluations of cryptographic modules within TEEs are not required, but =
some are available for specific implementations within TEEs.



* Interfaces and APIs
(1) TPMs have well-documented, standardized interfaces and APIs.
(2) Unless they implement functionality such as a virtual TPM, TEEs have =
custom interfaces and APIs.=20



* Threat model
The strength and appropriateness of  TPMs and TEEs for a given purpose =
must be assessed when using them to protect security-relevant data.   =20=


We suggest documenting environmental assumptions and dependencies in a =
high-level threat model for each additional trust source.  Just as each =
new LSM needs to comply with Documentation/security/lsm-development.rst, =
each new Trusted Key source should provide a high-level threat model.   =
An example of a high-level threat model is "Common Security Threats =
v1.0=E2=80=9D =
(https://www.opencompute.org/documents/common-security-threats-notes-1-pdf=
 ).=20

The original Trusted Keys implementation assumed discrete physical TPMs =
for key protection.  However, even physical TPMs themselves vary based =
on the manufacturer and systems in which they are placed.  The embedded =
chipset, firmware load, algorithms, packaging, pins, and countermeasures =
vary.  (Threats and mitigations on physical TPMs are well documented, =
e.g., "Threat Model of a Scenario Based on Trusted Platform Module 2.0 =
Specification=E2=80=9D (http://ceur-ws.org/Vol-1011/6.pdf).

Specific to Trusted Keys and TPMs, there is some discussion of threats =
and mitigations in the Integrity_overview.pdf on the IMA wiki:

	=E2=80=A2 The trusted key component does two things to help with =
secure key management on Linux. First, it provides a kernel key ring =
service in which the symmetric encryption keys are never visible in =
plain text to userspace. The keys are created in the kernel, and sealed =
by a hardware device such as a TPM, with userspace seeing only the =
sealed blobs. Malicious or compromised applications cannot steal a =
trusted key, since only the kernel can see the unsealed blobs. Secondly, =
the trusted keys can tie key unsealing to the integrity measurements, so =
that keys cannot be stolen in an offline attack, such as by booting an =
unlocked Linux image from CD or USB.  As the measurements will be =
different, the TPM chip will refuse to unseal the keys, even for the =
kernel.

Consumers of Trusted Keys in different environments need enough =
information so that they can create their own threat models tailored to =
their use cases.  For the present submission, a high-level security =
model of ARM TrustZone and how Trusted Keys key protection is =
implemented along with an enumeration of security considerations for =
end-use threat models would be appropriate. =20

An excellent and related paper describes the strengths, weaknesses, and =
countermeasures of a firmware TPM implemented within a TEE.  See "fTPM: =
A Software-only Implementation of a TPM Chip=E2=80=9D =
(https://www.usenix.org/conference/usenixsecurity16/technical-sessions/pre=
sentation/raj)


> +Key Generation
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Trusted Keys
> +------------
> +
> +New keys are created from trust source generated random numbers, and =
are
> +encrypted/decrypted using trust source storage root key.
Please change the following
"New keys are created from trust source generated random numbers, and =
are encrypted/decrypted using trust source storage root key."
to
"New keys are created from random numbers generated in the trust source. =
They are encrypted/decrypted using a child key in the storage key =
hierarchy.  Encryption and decryption of the child key must be protected =
by a strong access control policy within the trust source. =E2=80=9C

Thank you.=20
Elaine
_____________________________________
Elaine R. Palmer, Senior Technical Staff Member
Secure Systems and Academy of Technology
IBM T.J. Watson Research Center=
