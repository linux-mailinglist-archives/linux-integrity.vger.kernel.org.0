Return-Path: <linux-integrity+bounces-345-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FE0E803DB3
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 19:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1A40B20921
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Dec 2023 18:57:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6855F2FC38;
	Mon,  4 Dec 2023 18:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AlbBda2w"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5D3F0;
	Mon,  4 Dec 2023 10:56:57 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4IrMNO023527;
	Mon, 4 Dec 2023 18:56:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=rLD9OBiK0t3GW2iPMaqsONUqgMT3CHVh4jx+bRDjQfA=;
 b=AlbBda2whc1HJD06qtwLizFeGKRgQpNYm5rXQEi+SZMoJ7iu1aUnp+G+E1yQQ5YuQoyr
 YkLWnFjOSEgV62QPZwXSksGq3xLQ49ccXPkFVacifd6OTOtyjh1BlxNLICZdxAQ6yrtb
 GMAyaE/nzlbuk+AcJilaRZm+YOLbG1+NEV6BZkt/oVTa7rxGn6adistOXh4hAWm27gBs
 tI6i8EjUjl1JgcG3dmDyMska2lM/wrBgFZCA5gy4uJYkbRRoO5K5GjwOBte3b+kWFehc
 LAadCn84q8nLiJsJ/wvsEOxlNTmOzJdo3V7FZnnHKJGMw8z8UXujeAuG/N5Yi98/jsI6 Uw== 
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3usmee04qa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 18:56:46 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3B4GvxnF025431;
	Mon, 4 Dec 2023 18:56:45 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3urewta7v9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 04 Dec 2023 18:56:45 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3B4Iuig71770178
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Dec 2023 18:56:44 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 839585805A;
	Mon,  4 Dec 2023 18:56:44 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1FA7658052;
	Mon,  4 Dec 2023 18:56:44 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  4 Dec 2023 18:56:44 +0000 (GMT)
Message-ID: <1d8de077-9dd3-432e-90de-0a5b7dafcd75@linux.ibm.com>
Date: Mon, 4 Dec 2023 13:56:43 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/13] add integrity and security to TPM2 transactions
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-integrity@vger.kernel.org
Cc: Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ryBDgvG6_DU1WhPtNuL5N1l6t-SYR1yd
X-Proofpoint-ORIG-GUID: ryBDgvG6_DU1WhPtNuL5N1l6t-SYR1yd
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-04_18,2023-12-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 malwarescore=0 clxscore=1015 mlxlogscore=999 suspectscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311060000 definitions=main-2312040146



On 4/3/23 17:39, James Bottomley wrote:
> The interest in securing the TPM against interposers, both active and
> passive has risen to fever pitch with the demonstration of key
> recovery against windows bitlocker:
> 
> https://dolosgroup.io/blog/2021/7/9/from-stolen-laptop-to-inside-the-company-network
> 
> And subsequently the same attack being successful against all the
> Linux TPM based security solutions:
> 
> https://www.secura.com/blog/tpm-sniffing-attacks-against-non-bitlocker-targets
> 
> The attacks fall into two categories:
> 
> 1. Passive Interposers, which sit on the bus and merely observe
> 2. Active Interposers, which try to manipulate TPM transactions on the
>     bus using man in the middle and packet stealing to create TPM state
>     the interposer owner desires.

I think this is another capability of an interposer that should be 
mentioned here, unless technically not possible but I would not know why:

3. Active Interposers that send their own commands to the TPM to for 
example cause DoS attacks.

If we protect PCR extensions now and the interposer can send his own PCR 
extensions and the TPM 2 accepts them (TPM doesn't have a mode to reject 
unprotected commands in general), why protect the PCR extensions from 
IMA then?

    Stefan
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
> https://lore.kernel.org/linux-integrity/1568031515.6613.31.camel@HansenPartnership.com/
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
>    crypto: lib - implement library version of AES in CFB mode
> 
> James Bottomley (12):
>    tpm: move buffer handling from static inlines to real functions
>    tpm: add kernel doc to buffer handling functions
>    tpm: add buffer handling for TPM2B types
>    tpm: add cursor based buffer functions for response parsing
>    tpm: add buffer function to point to returned parameters
>    tpm: export the context save and load commands
>    tpm: Add full HMAC and encrypt/decrypt session handling code
>    tpm: add hmac checks to tpm2_pcr_extend()
>    tpm: add session encryption protection to tpm2_get_random()
>    KEYS: trusted: Add session encryption protection to the seal/unseal
>      path
>    tpm: add the null key name as a sysfs export
>    Documentation: add tpm-security.rst
> 
>   Documentation/security/tpm/tpm-security.rst |  216 ++++
>   drivers/char/tpm/Kconfig                    |   13 +
>   drivers/char/tpm/Makefile                   |    2 +
>   drivers/char/tpm/tpm-buf.c                  |  307 +++++
>   drivers/char/tpm/tpm-chip.c                 |    3 +
>   drivers/char/tpm/tpm-sysfs.c                |   18 +
>   drivers/char/tpm/tpm.h                      |   14 +
>   drivers/char/tpm/tpm2-cmd.c                 |   52 +-
>   drivers/char/tpm/tpm2-sessions.c            | 1158 +++++++++++++++++++
>   drivers/char/tpm/tpm2-space.c               |    8 +-
>   include/crypto/aes.h                        |    5 +
>   include/linux/tpm.h                         |  257 ++--
>   lib/crypto/Kconfig                          |    5 +
>   lib/crypto/Makefile                         |    3 +
>   lib/crypto/aescfb.c                         |  257 ++++
>   security/keys/trusted-keys/trusted_tpm2.c   |   82 +-
>   16 files changed, 2275 insertions(+), 125 deletions(-)
>   create mode 100644 Documentation/security/tpm/tpm-security.rst
>   create mode 100644 drivers/char/tpm/tpm-buf.c
>   create mode 100644 drivers/char/tpm/tpm2-sessions.c
>   create mode 100644 lib/crypto/aescfb.c
> 

