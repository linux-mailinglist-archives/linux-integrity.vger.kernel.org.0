Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2E92D7159
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Dec 2020 09:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403778AbgLKIP5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Dec 2020 03:15:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:55554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388352AbgLKIPj (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Dec 2020 03:15:39 -0500
Date:   Fri, 11 Dec 2020 10:14:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607674498;
        bh=iBKehJ8hF1AD6c9e71eHXqVLRytDmT9uPZqT5CPhPn8=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=BnekXr6flXd64QnmUlaSAHpzXJVBVlAbibmGSOi8846t51TlJ7Rzp4wc3xBYfBLto
         x3vNrRVNhOqPUSmcUyzYekb14dcC9GpzsGgIL7wxqZyM6B9hXPB4Bx1Ol1QFKKBXJd
         KlWgVr2h7Ox5eG7ZucJNKVWdkBC3qq/YNtHqYj5ZEXjof8sB+rk8lHCCDIqiGjFK/C
         LSOoMkwbgZ5Wo+i58UL59pk7nBWsm5xa0cOlyfdd8BMVFsiaW+YCVuKxz/ylPRLgsR
         Mhbx61H5mwAQnO4JEuQt6ttrzw2/+uMTWLPXKmI9z5o3EGDGYjprZm0tAN4DXxHgbT
         1eB+hOsgHXZdg==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Elaine Palmer <erpalmer@us.ibm.com>, sumit.garg@linaro.org,
        George Wilson <gcwilson@us.ibm.com>, zgu@us.ibm.com
Subject: Re: [PATCH] doc: trusted-encrypted: updates with TEE as a new trust
 source (update)
Message-ID: <20201211081454.GA5262@kernel.org>
References: <20201209164249.715178-1-zohar@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201209164249.715178-1-zohar@linux.ibm.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Dec 09, 2020 at 11:42:49AM -0500, Mimi Zohar wrote:
> From: Elaine Palmer <erpalmer@us.ibm.com>
> 
> Update trusted key documentation with additional comparisons between
> discrete TPMs and TEE.
> 
> Signed-off-by: Elaine Palmer <erpalmer@us.ibm.com>

Right, so OP-TEE is not the same as TEE. I did not know this and the
patch set does not underline this.

I re-checked the patches and none of them say explicitly that OP-TEE
is an application living inside TEE.

This essentially means that the backend needs to be renamed as "op_tee".

All patches need to be rewritten according to this.


> ---
>  .../security/keys/trusted-encrypted.rst       | 73 +++++++++++++++++--
>  1 file changed, 65 insertions(+), 8 deletions(-)
> 
> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
> index 16042c8ff8ae..90c02105ab89 100644
> --- a/Documentation/security/keys/trusted-encrypted.rst
> +++ b/Documentation/security/keys/trusted-encrypted.rst
> @@ -14,12 +14,14 @@ convenience, and are integrity verified.
>  Trust Source
>  ============
>  
> -Trust Source provides the source of security for the Trusted Keys, on which
> -basis Trusted Keys establishes a Trust model with its user. A Trust Source could
> -differ from one system to another depending on its security requirements. It
> -could be either an off-chip device or an on-chip device. Following section
> -demostrates a list of supported devices along with their security properties/
> -guarantees:
> +A trust source provides the source of security for Trusted Keys.  This
> +section lists currently supported trust sources, along with their security
> +considerations.  Whether or not a trust source is sufficiently safe depends
> +on the strength and correctness of its implementation, as well as the threat
> +environment for a specific use case.  Since the kernel doesn't know what the
> +environment is, and there is no metric of trust, it is dependent on the
> +consumer of the Trusted Keys to determine if the trust source is sufficiently
> +safe.
>  
>    *  Root of trust for storage
>  
> @@ -116,6 +118,59 @@ guarantees:
>           Provides no protection by itself, relies on the underlying platform for
>           features such as tamper resistance.
>  
> +  *  Provisioning - the trust source's unique and verifiable cryptographic
> +     identity is provisioned during manufacturing
> +
> +     (1) TPM
> +
> +         The unique and verifiable cryptographic identity is the endorsement
> +         key (EK) or its primary seed.  A review of the generation of the EK
> +         and its accompanying certificate is part of the Common Criteria
> +         evaluation of the product's lifecycle processes (ALC_*).  See "TCG
> +         Protection Profile for PC Client Specific TPM 2"
> +
> +     (2) TEE
> +
> +         A protection profile for TEEs does not yet exist.  Therefore, the
> +         provisioning process that generates the Hardware Unique Key is not
> +         evaluated by an independent third party and is highly dependent on
> +         the manufacturing environment.

Comparing TPM and TEE does not make logically any sense given that TPM
is application and TEE a platfrom.

> +
> +
> +  *  Cryptography
> +
> +     (1) TPM
> +
> +         As part of the TPM's mandatory Common Criteria evaluation, the
> +         correctness of the TPM's implementation of cryptographic algorithms,
> +         the protection of keys, and the generation of random numbers, and other
> +         security-relevant functions must be documented, reviewed, and tested by
> +         an independent third party evaluation agency.  It must meet the
> +         requirements of FIPS 140-2, FIPS 140-3, or ISO/IEC 19790:2012.
> +
> +     (2) TEE
> +
> +         Evaluations of cryptographic modules within TEEs are not required, but
> +         some are available for specific implementations within TEEs.
> +
> +
> +  *  Interfaces and APIs
> +
> +     (1) TPM
> +
> +         TPMs have well-documented, standardized interfaces and APIs.
> +
> +     (2) TEE
> +
> +         Unless TEEs implement functionality such as a virtual TPM, they have
> +         custom interfaces and APIs.
> +
> +
> +  *  Threat model
> +
> +     The strength and appropriateness of a particular TPM or TEE for a given
> +     purpose must be assessed when using them to protect security-relevant data.
> +
>  
>  Key Generation
>  ==============
> @@ -123,8 +178,10 @@ Key Generation
>  Trusted Keys
>  ------------
>  
> -New keys are created from trust source generated random numbers, and are
> -encrypted/decrypted using trust source storage root key.
> +New keys are created from random numbers generated in the trust source. They
> +are encrypted/decrypted using a child key in the storage key hierarchy.
> +Encryption and decryption of the child key must be protected by a strong
> +access control policy within the trust source.
>  
>    *  TPM (hardware device) based RNG
>  
> -- 
> 2.18.4
> 
> 

/Jarkko
