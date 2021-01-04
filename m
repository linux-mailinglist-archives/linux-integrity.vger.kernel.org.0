Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BCF2E949E
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Jan 2021 13:18:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726360AbhADMQt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Jan 2021 07:16:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbhADMQs (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Jan 2021 07:16:48 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1AC8C061574
        for <linux-integrity@vger.kernel.org>; Mon,  4 Jan 2021 04:16:07 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o19so63841357lfo.1
        for <linux-integrity@vger.kernel.org>; Mon, 04 Jan 2021 04:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=a6kBpRdFMzUaRTZHdbvHFwKqArYqPus66v0IiHDwd+I=;
        b=UXAdh6B315kL1Bx1D2KkTnErKda1Xx3ZebKYt8RcJJxNfncnASDPuPDJepAAWGtbho
         BRLQ+0xkYTcuVwA9uYVXvdz3iG55xdk0cnJi7cxxRkHBx9noocrTDB98GxholILTdHKc
         OoQXSny++Nhyb1u6KDq3YrvRLNW7+kgdyqS77IUszoPdtyDiJanU+kv2e508X3SE1nz/
         6hHdv33i+LXivbcJHA1uPVLHefibSkZDD/NgqRYE1eSY9nH/K5Fw617oy+Tx580bkTbV
         Mg2BXOp/tXJk4TAxBla+mDuyoIf5SRt2XYbgjumZuo+Jjrqwp2tk0/aq7U2F2CEJToXZ
         Jurw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=a6kBpRdFMzUaRTZHdbvHFwKqArYqPus66v0IiHDwd+I=;
        b=JAOSB3CxIyWKc0Y4njPZz3ppRAS/U0TSTjUVYl8UWUz82XLXQEj6qYVQXWfcSePGTi
         OCramYQRjkxf8a2fI5pZuqaRrPtVeqohFY4n8Gtj/hCdB17EXaWEFgnqZ/tD/WiMRBOs
         VZ0RMnBguOpBlkr4+BZUWAgbQMSdf3boHZnEwnIJC1AYomSpNaBNHetgEhwWOxn0D8Zc
         ILjRt0sg0AXZzOZZOl1URBxQa+opkm8YU4TTRJYZlRuJu2WP4Je0vhDte0fecqI3p5IK
         Ovi0WOp+ZxzYoD42PvPVbMHcve7vqblr7+Em53pAcnAILCX63ZiA77ofBCwf1GFr5bar
         gBDw==
X-Gm-Message-State: AOAM532ppi1vLsE+Zpg6m2jVta7TFrPRcAgzkWcvtQlkVELhZIIPYsLG
        A/1WjFxbX0QtiLB854tfGr9iBL1YKLiuRcF7L9FMLw==
X-Google-Smtp-Source: ABdhPJyMwmd4xLggKNR4PeTJOlVWrrnPTTtLpVU0/asp1g5Dxqmxrx6o7jh2+WBsYgh3eq278mTS7xBaLfcrgIB1x24=
X-Received: by 2002:a19:e8a:: with SMTP id 132mr29939707lfo.108.1609762566403;
 Mon, 04 Jan 2021 04:16:06 -0800 (PST)
MIME-Version: 1.0
References: <20201209164249.715178-1-zohar@linux.ibm.com>
In-Reply-To: <20201209164249.715178-1-zohar@linux.ibm.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 4 Jan 2021 17:45:55 +0530
Message-ID: <CAFA6WYPEGGDGqryu1UXNeBsN9NxShEbv8CVxOp=Pt9Vc1LXB4A@mail.gmail.com>
Subject: Re: [PATCH] doc: trusted-encrypted: updates with TEE as a new trust
 source (update)
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Elaine Palmer <erpalmer@us.ibm.com>
Cc:     linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>,
        George Wilson <gcwilson@us.ibm.com>, zgu@us.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi and Elaine,

Apologies for my delayed reply as I was busy with other high priority work.

On Wed, 9 Dec 2020 at 22:14, Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> From: Elaine Palmer <erpalmer@us.ibm.com>
>
> Update trusted key documentation with additional comparisons between
> discrete TPMs and TEE.

Isn't this additional comparison limited to a particular type of TPM
(discrete TPMs) and ignored other TPM implementations (virtual TPM,
firmware TPM etc.)? I think your later comment about on-chip versus
off-chip points at these missing pieces as well.

I would rather suggest comparing TPM and TEE on the basis of
interfaces and implementation guidelines provided by corresponding
standards as I think this is the most relevant part to the kernel.

>
> Signed-off-by: Elaine Palmer <erpalmer@us.ibm.com>
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
> +         A protection profile for TEEs does not yet exist.

Really? Have a look here [1].

[1] https://globalplatform.org/specs-library/tee-protection-profile-v1-3/#

>  Therefore, the
> +         provisioning process that generates the Hardware Unique Key is not
> +         evaluated by an independent third party and is highly dependent on
> +         the manufacturing environment.
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

Kernel interface to TEE is based on the standardized TEE client API
specification from GlobalPlatform [2].

[2] https://globalplatform.org/specs-library/tee-client-api-specification/

-Sumit

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
