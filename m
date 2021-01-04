Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3DD2E94FA
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Jan 2021 13:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726509AbhADMh1 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 4 Jan 2021 07:37:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726503AbhADMh0 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 4 Jan 2021 07:37:26 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D73C061574
        for <linux-integrity@vger.kernel.org>; Mon,  4 Jan 2021 04:36:46 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id o13so63960243lfr.3
        for <linux-integrity@vger.kernel.org>; Mon, 04 Jan 2021 04:36:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2Lf24XZaekOCpuprhGil81c4ICWDfsrJGvymacGYiWI=;
        b=VtzX1n/iBS01micJLy2DlapTbdG9RJv8+zJMG0ihWOHLN/ds5A3vPmYJzvVB7v4Ygm
         eFtZuAzzM5pCcmQtwTt5SJooz/3uiI4AWv+HL1w5iZX/3bPfn2FqKmVGvfNwWpB42XqR
         Qc279gLiRY8HmYc82uJ3ai5B637+VrnChSwMKcW4qUpcMT14l6WMSNuJhKFfY0C2u3wu
         WLzoS4P83h9VXNo36HlLgwF8kKrcmBDWv0HJHVV8adE+ccUBK7f7+hZWVq4ZJHOPP/OJ
         2xay4S8Pqjy0bHI93iTtCQD7bAH42wKdNzvR8HSo96GPlMbZBWsI+mdQIda9UVvqS1SC
         KI8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2Lf24XZaekOCpuprhGil81c4ICWDfsrJGvymacGYiWI=;
        b=g3RejMHQWoKvWCG/01Ziamo+J8lV+gjjmlWlhFv8qQX5COh3y6V+OQeLVG85+hWKfm
         5T+ariQtoLlzIznjkxDW7gBw+SFF8rQZmq8po/JeqJlRTjdDcDFnXXPnbodPWSwZSIol
         xIg59sB0lAF2QFd/DJ1bOvi2u68+r/vCLxNq6lVWzbhFPmG1RzRzKi+s8jIPu2ASsAEz
         zl68HctocOas/3JrMNEz/9XCTx7uLSI19dGdNcFny2WtGM0S7vhMHYo68ykViMJ3VDVL
         NEzwuoGCL1JzvA/qq9Db9DgGOq+s/MsHzxGH9VSw5dVFdVZN6iYLM1T1ngQokfXOvMPP
         2b7A==
X-Gm-Message-State: AOAM5308GqBkwK51iTgQocAWf6P5p4k/SILcb8leqlVoJaAYEaeoYTGn
        PnZguMCsaey7MB3UbZ/68UNGcx3ppRZdkkUNrGSy0w==
X-Google-Smtp-Source: ABdhPJylnIOaCjWyGOmnal32tT61uHYPLI3oW2Kr0Yz0Ix3E1BOPGYzrCqFb8nlrTkE7V65QISlFw5qzqfLMLZXCFSs=
X-Received: by 2002:a2e:b896:: with SMTP id r22mr33720099ljp.442.1609763804703;
 Mon, 04 Jan 2021 04:36:44 -0800 (PST)
MIME-Version: 1.0
References: <20201209164249.715178-1-zohar@linux.ibm.com> <20201211081454.GA5262@kernel.org>
In-Reply-To: <20201211081454.GA5262@kernel.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 4 Jan 2021 18:06:33 +0530
Message-ID: <CAFA6WYMt5+zX09bdgugSq9SgqF=V_OfOZee8fBEAv1thFLs3nA@mail.gmail.com>
Subject: Re: [PATCH] doc: trusted-encrypted: updates with TEE as a new trust
 source (update)
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        Elaine Palmer <erpalmer@us.ibm.com>,
        George Wilson <gcwilson@us.ibm.com>, zgu@us.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Jarkko,

On Fri, 11 Dec 2020 at 13:44, Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> On Wed, Dec 09, 2020 at 11:42:49AM -0500, Mimi Zohar wrote:
> > From: Elaine Palmer <erpalmer@us.ibm.com>
> >
> > Update trusted key documentation with additional comparisons between
> > discrete TPMs and TEE.
> >
> > Signed-off-by: Elaine Palmer <erpalmer@us.ibm.com>
>
> Right, so OP-TEE is not the same as TEE. I did not know this and the
> patch set does not underline this.
>
> I re-checked the patches and none of them say explicitly that OP-TEE
> is an application living inside TEE.

This patch-set provides a trust source based on generic TEE interface
where underlying TEE implementations like OP-TEE (drivers/tee/optee/),
AMD TEE (drivers/tee/amdtee/) etc. can easily be hooked up. And this
is similar to the TPM interface where underlying TPM implementations
like discrete TPM, virtual TPM, firmware TPM etc. can be easily hooked
up.

>
> This essentially means that the backend needs to be renamed as "op_tee".
>

I don't see any need for this, see above.

> All patches need to be rewritten according to this.
>
>
> > ---
> >  .../security/keys/trusted-encrypted.rst       | 73 +++++++++++++++++--
> >  1 file changed, 65 insertions(+), 8 deletions(-)
> >
> > diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Documentation/security/keys/trusted-encrypted.rst
> > index 16042c8ff8ae..90c02105ab89 100644
> > --- a/Documentation/security/keys/trusted-encrypted.rst
> > +++ b/Documentation/security/keys/trusted-encrypted.rst
> > @@ -14,12 +14,14 @@ convenience, and are integrity verified.
> >  Trust Source
> >  ============
> >
> > -Trust Source provides the source of security for the Trusted Keys, on which
> > -basis Trusted Keys establishes a Trust model with its user. A Trust Source could
> > -differ from one system to another depending on its security requirements. It
> > -could be either an off-chip device or an on-chip device. Following section
> > -demostrates a list of supported devices along with their security properties/
> > -guarantees:
> > +A trust source provides the source of security for Trusted Keys.  This
> > +section lists currently supported trust sources, along with their security
> > +considerations.  Whether or not a trust source is sufficiently safe depends
> > +on the strength and correctness of its implementation, as well as the threat
> > +environment for a specific use case.  Since the kernel doesn't know what the
> > +environment is, and there is no metric of trust, it is dependent on the
> > +consumer of the Trusted Keys to determine if the trust source is sufficiently
> > +safe.
> >
> >    *  Root of trust for storage
> >
> > @@ -116,6 +118,59 @@ guarantees:
> >           Provides no protection by itself, relies on the underlying platform for
> >           features such as tamper resistance.
> >
> > +  *  Provisioning - the trust source's unique and verifiable cryptographic
> > +     identity is provisioned during manufacturing
> > +
> > +     (1) TPM
> > +
> > +         The unique and verifiable cryptographic identity is the endorsement
> > +         key (EK) or its primary seed.  A review of the generation of the EK
> > +         and its accompanying certificate is part of the Common Criteria
> > +         evaluation of the product's lifecycle processes (ALC_*).  See "TCG
> > +         Protection Profile for PC Client Specific TPM 2"
> > +
> > +     (2) TEE
> > +
> > +         A protection profile for TEEs does not yet exist.  Therefore, the
> > +         provisioning process that generates the Hardware Unique Key is not
> > +         evaluated by an independent third party and is highly dependent on
> > +         the manufacturing environment.
>
> Comparing TPM and TEE does not make logically any sense given that TPM
> is application and TEE a platfrom.
>

I think comparing them on the basis of standardized interfaces to
trust source and common platform security features does make sense.

-Sumit

> > +
> > +
> > +  *  Cryptography
> > +
> > +     (1) TPM
> > +
> > +         As part of the TPM's mandatory Common Criteria evaluation, the
> > +         correctness of the TPM's implementation of cryptographic algorithms,
> > +         the protection of keys, and the generation of random numbers, and other
> > +         security-relevant functions must be documented, reviewed, and tested by
> > +         an independent third party evaluation agency.  It must meet the
> > +         requirements of FIPS 140-2, FIPS 140-3, or ISO/IEC 19790:2012.
> > +
> > +     (2) TEE
> > +
> > +         Evaluations of cryptographic modules within TEEs are not required, but
> > +         some are available for specific implementations within TEEs.
> > +
> > +
> > +  *  Interfaces and APIs
> > +
> > +     (1) TPM
> > +
> > +         TPMs have well-documented, standardized interfaces and APIs.
> > +
> > +     (2) TEE
> > +
> > +         Unless TEEs implement functionality such as a virtual TPM, they have
> > +         custom interfaces and APIs.
> > +
> > +
> > +  *  Threat model
> > +
> > +     The strength and appropriateness of a particular TPM or TEE for a given
> > +     purpose must be assessed when using them to protect security-relevant data.
> > +
> >
> >  Key Generation
> >  ==============
> > @@ -123,8 +178,10 @@ Key Generation
> >  Trusted Keys
> >  ------------
> >
> > -New keys are created from trust source generated random numbers, and are
> > -encrypted/decrypted using trust source storage root key.
> > +New keys are created from random numbers generated in the trust source. They
> > +are encrypted/decrypted using a child key in the storage key hierarchy.
> > +Encryption and decryption of the child key must be protected by a strong
> > +access control policy within the trust source.
> >
> >    *  TPM (hardware device) based RNG
> >
> > --
> > 2.18.4
> >
> >
>
> /Jarkko
