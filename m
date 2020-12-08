Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57C8E2D2ED9
	for <lists+linux-integrity@lfdr.de>; Tue,  8 Dec 2020 16:57:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbgLHP4o (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 8 Dec 2020 10:56:44 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10850 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730224AbgLHP4n (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 8 Dec 2020 10:56:43 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B8FXQB9082451;
        Tue, 8 Dec 2020 10:55:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=sgslLMZMuUiYSpTZavlRw+pWO63NAuMG+xEOhlbTbd4=;
 b=MJaprZ7qsJnz1TMqXS8jHqxzSCDwFAgTDq1WVHtnwWLZDuneeuq7cDqvVrqyFuPyViR/
 MAxyXMbi4tkjGThy9PmRxcZcxE57GsGjivEU/OvQ+V4qJBfFrfnj93gjgsxbPPJ7McAu
 h/fKyjeDDkc10+l/c/hPnHkpOEQIbyCOe42sPFON3zrG9tbHtHvaypOd21vsTlaP7BkL
 dJhKcEsFQkEGK0+hLiABiQEaCM24MTghsnW+flRRp6RDQqAg0b4B/7GRV6nFJccJGvS9
 X/VgSaFjrqiIcnODnNcTF/9jJszrsqdLld24QUbM6Q7igG3JE/+0h+hrCN+O34sXzPur cg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35a5ufw61v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 10:55:34 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B8FXf4i083877;
        Tue, 8 Dec 2020 10:55:33 -0500
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35a5ufw5yw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 10:55:33 -0500
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B8FcOTW015905;
        Tue, 8 Dec 2020 15:55:31 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 3581u81w2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Dec 2020 15:55:31 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B8FtS8025559390
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Dec 2020 15:55:28 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8041252051;
        Tue,  8 Dec 2020 15:55:28 +0000 (GMT)
Received: from sig-9-65-221-14.ibm.com (unknown [9.65.221.14])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id EA9F552052;
        Tue,  8 Dec 2020 15:55:23 +0000 (GMT)
Message-ID: <f00c8c7dd1e184e139e6cb5aba2b4a1c5fc68363.camel@linux.ibm.com>
Subject: Re: [PATCH v8 3/4] doc: trusted-encrypted: updates with TEE as a
 new trust source
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Sumit Garg <sumit.garg@linaro.org>,
        jarkko.sakkinen@linux.intel.com, jejb@linux.ibm.com,
        Elaine Palmer <erpalmer@us.ibm.com>
Cc:     dhowells@redhat.com, jens.wiklander@linaro.org, corbet@lwn.net,
        jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com,
        janne.karhunen@gmail.com, daniel.thompson@linaro.org,
        Markus.Wamser@mixed-mode.de, lhinds@redhat.com,
        keyrings@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        op-tee@lists.trustedfirmware.org,
        George Wilson <gcwilson@us.ibm.com>
Date:   Tue, 08 Dec 2020 10:55:23 -0500
In-Reply-To: <1604419306-26105-4-git-send-email-sumit.garg@linaro.org>
References: <1604419306-26105-1-git-send-email-sumit.garg@linaro.org>
         <1604419306-26105-4-git-send-email-sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-12.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-08_09:2020-12-08,2020-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 adultscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012080096
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Sumit, Jarkko,

Re-posting Elaine Palmer's comments, inline below, trimmed and properly
formatted.

On Tue, 2020-11-03 at 21:31 +0530, Sumit Garg wrote:
> Update documentation for Trusted and Encrypted Keys with TEE as a new
> trust source. Following is brief description of updates:
> 
> - Add a section to demostrate a list of supported devices along with
>   their security properties/guarantees.
> - Add a key generation section.
> - Updates for usage section including differences specific to a trust
>   source.
> 
> Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
> Reviewed-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> ---
>  Documentation/security/keys/trusted-encrypted.rst | 203 ++++++++++++++++++----
>  1 file changed, 171 insertions(+), 32 deletions(-)
> 
> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
> index 1da879a..16042c8 100644
> --- a/Documentation/security/keys/trusted-encrypted.rst
> +++ b/Documentation/security/keys/trusted-encrypted.rst
> @@ -6,30 +6,161 @@ Trusted and Encrypted Keys are two new key types added to the existing kernel
>  key ring service.  Both of these new types are variable length symmetric keys,
>  and in both cases all keys are created in the kernel, and user space sees,
>  stores, and loads only encrypted blobs.  Trusted Keys require the availability
> -of a Trusted Platform Module (TPM) chip for greater security, while Encrypted
> -Keys can be used on any system.  All user level blobs, are displayed and loaded
> -in hex ascii for convenience, and are integrity verified.
> +of a Trust Source for greater security, while Encrypted Keys can be used on any
> +system. All user level blobs, are displayed and loaded in hex ascii for
> +convenience, and are integrity verified.
>  
> -Trusted Keys use a TPM both to generate and to seal the keys.  Keys are sealed
> -under a 2048 bit RSA key in the TPM, and optionally sealed to specified PCR
> -(integrity measurement) values, and only unsealed by the TPM, if PCRs and blob
> -integrity verifications match.  A loaded Trusted Key can be updated with new
> -(future) PCR values, so keys are easily migrated to new pcr values, such as
> -when the kernel and initramfs are updated.  The same key can have many saved
> -blobs under different PCR values, so multiple boots are easily supported.
>  
> -TPM 1.2
> --------
> +Trust Source
> +============
>  
> -By default, trusted keys are sealed under the SRK, which has the default
> -authorization value (20 zeros).  This can be set at takeownership time with the
> -trouser's utility: "tpm_takeownership -u -z".
> +Trust Source provides the source of security for the Trusted Keys, on which
> +basis Trusted Keys establishes a Trust model with its user.

A trust source provides the source of security for the Trusted
Keys.  Whether or not a trust source is sufficiently safe depends on
the strength and correctness of its implementation, as well as the
threat environment for a specific use case.  Since the kernel doesn't
know what the environment is, and there is no metric of trust, it is
dependent on the consumer of the Trusted Keys to determine if the trust
source is sufficiently safe.

>  A Trust Source could
> +differ from one system to another depending on its security requirements. It
> +could be either an off-chip device or an on-chip device. Following section
> +demostrates a list of supported devices along with their security properties/
> +guarantees:
>  
> -TPM 2.0
> --------
> +  *  Root of trust for storage
>  
> -The user must first create a storage key and make it persistent, so the key is
> -available after reboot. This can be done using the following commands.
> +     (1) TPM (Trusted Platform Module: hardware device)
> +
> +         Rooted to Storage Root Key (SRK) which never leaves the TPM that
> +         provides crypto operation to establish root of trust for storage.
> +
> +     (2) TEE (Trusted Execution Environment: OP-TEE based on Arm TrustZone)
> +
> +         Rooted to Hardware Unique Key (HUK) which is generally burnt in on-chip
> +         fuses and is accessible to TEE only.
> +
> +  *  Execution isolation
> +
> +     (1) TPM
> +
> +         Fixed set of operations running in isolated execution environment.
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
> +         Keys can be optionally sealed to specified PCR (integrity measurement)
> +         values, and only unsealed by the TPM, if PCRs and blob integrity
> +         verifications match. A loaded Trusted Key can be updated with new
> +         (future) PCR values, so keys are easily migrated to new PCR values,
> +         such as when the kernel and initramfs are updated. The same key can
> +         have many saved blobs under different PCR values, so multiple boots are
> +         easily supported.
> +
> +     (2) TEE
> +
> +         Relies on Secure/Trusted boot process for platform integrity. It can
> +         be extended with TEE based measured boot process.
> +
> +  *  On-chip versus off-chip
> +
> +     (1) TPM
> +
> +         Off-chip device connected via serial bus (like I2C, SPI etc.) exposing
> +         physical access which represents an attack surface that can be
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
> +         Immune to these attacks as it doesn’t make use of system DRAM.
> +
> +     (2) TEE
> +
> +         An implementation based on TrustZone protected DRAM is susceptible to
> +         such attacks. In order to mitigate these attacks one needs to rely on
> +         on-chip secure RAM to store secrets or have the entire TEE
> +         implementation based on on-chip secure RAM. An alternative mitigation
> +         would be to use encrypted DRAM.
> +
> +  *  Side-channel attacks (cache, memory, CPU or time based)
> +
> +     (1) TPM
> +
> +         Immune to side-channel attacks as its resources are isolated from the
> +         main OS.
> +
> +     (2) TEE
> +
> +         A careful implementation is required to mitigate against these attacks
> +         for resources which are shared (eg. shared memory) with the main OS.
> +         Cache and CPU based side-channel attacks can be mitigated via
> +         invalidating caches and CPU registers during context switch to and from
> +         the secure world.
> +         To mitigate against time based attacks, one needs to have time
> +         invariant implementations (like crypto algorithms etc.).
> +
> +  *  Resistance to physical attacks (power analysis, electromagnetic emanation,
> +     probes etc.)
> +
> +     (1) TPM
> +
> +         Provides limited protection utilizing tamper resistance.
> +
> +     (2) TEE
> +
> +         Provides no protection by itself, relies on the underlying platform for
> +         features such as tamper resistance.
> +

Please add the following topics:

* Provisioning - the trust source's unique and verifiable cryptographic
identity is provisioned during manufacturing

(1) TPM

The unique and verifiable cryptographic identity is the endorsement key
(EK) or its primary seed.  A review of the generation of the EK and its
accompanying certificate is part of the Common Criteria evaluation of
the product's lifecycle processes (ALC_*).  See "TCG Protection Profile
for PC Client Specific TPM 2" (
https://trustedcomputinggroup.org/resource/pc-client-protection-profile-for-tpm-2-0/
).

(2) TEE

A protection profile for TEEs does not yet exist.  Therefore, the
provisioning process that generates the Hardware Unique Key is not
evaluated by an independent third party and is highly dependent on the
manufacturing environment.


* Cryptography

(1) TPM

As part of the TPM's mandatory Common Criteria evaluation, the
correctness of the TPM's implementation of cryptographic algorithms,
the protection of keys, and the generation of random numbers, and other
security-relevant functions must be documented, reviewed, and tested by
an independent third party evaluation agency.  It must meet the
requirements of FIPS 140-2, FIPS 140-3, or ISO/IEC 19790:2012. 

(2) TEE

Evaluations of cryptographic modules within TEEs are not required, but
some are available for specific implementations within TEEs.


* Interfaces and APIs

(1) TPM

 TPMs have well-documented, standardized interfaces and APIs.

(2) TEE

Unless TEEs implement functionality such as a virtual TPM, they have
custom interfaces and APIs. 


* Threat model

The strength and appropriateness of TPMs and TEEs for a given purpose
must be assessed when using them to protect security-relevant data.

> +
> +Key Generation
> +==============
> +
> +Trusted Keys
> +------------
> +
> +New keys are created from trust source generated random numbers, and are
> +encrypted/decrypted using trust source storage root key.

New keys are created from random numbers generated in the trust source.
They are encrypted/decrypted using a child key in the storage key
hierarchy.  Encryption and decryption of the child key must be
protected by a strong access control policy within the trust source.

Thank you,

Elaine (and Mimi)

