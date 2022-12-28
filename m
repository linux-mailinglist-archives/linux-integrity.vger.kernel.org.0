Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AC526586C7
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Dec 2022 21:40:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiL1UkW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Dec 2022 15:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbiL1UkV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Dec 2022 15:40:21 -0500
Received: from mail-ua1-x936.google.com (mail-ua1-x936.google.com [IPv6:2607:f8b0:4864:20::936])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A94165AE
        for <linux-integrity@vger.kernel.org>; Wed, 28 Dec 2022 12:40:20 -0800 (PST)
Received: by mail-ua1-x936.google.com with SMTP id e24so3780160uam.10
        for <linux-integrity@vger.kernel.org>; Wed, 28 Dec 2022 12:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lKDYx6Ecy9/r2FM7TTQ4aQ5xrn1QPytf3YNqwTn+XSc=;
        b=sp9TJ2gQgUGBpgLxvEh/5t+OmM9wwBjbQNKsdF9hGzyTCbMgzcK6mFjWMftMG8ED0R
         VX6m0rTZ0AkP/Brp4lveZQdqivUj5f8bXgDC98e/E3RYQDmbcEdq4pyed9SfAPjVu9du
         7NY3CUO2D+imaVDaf5v17bMxG+8kostIQ/BeP5ZqCETUtRh5OwoGY+C2aOtWvxyx2zp7
         tnPDEwpOI4+3O/NYGojqR+hp/OTIjJQTSLdNWTAAESnXq2FB4grelKeOxz533mTIjrJz
         tAYKpYXCLXs3/qAXBQ8J3m+B99jsLib/MXj5rY4Yn7GhHFgC6qh6aMh0W9gsMnApc3Mc
         Dg2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lKDYx6Ecy9/r2FM7TTQ4aQ5xrn1QPytf3YNqwTn+XSc=;
        b=NWaWI5G9UT+sr0Mkil64f4kXsUXRkjK88467358qUQC3v+rUZBw78Z1X4k/VsKvFGm
         xqRkrvaHYtr6tKk/fa3LInx9UxKO19dYWeOUWJGjV1Aeo2E3KgudRi20kmZhtB+fgKAP
         /ysnDhiOyhVvMko8zMmBYjgOnIWK0k5t3WJMU5Hjs6CCNatw9pQ4+01GUVYBWRa14TLN
         oAdY0b2YJ9d6lCZUvEvvIXIkZJn5r9x9UKlSoaGLLVnSklYBKxGO3sXAu6qHYw4cicWb
         PfIOj6maGLZDajDxDGJhhylqA8xGlLvwuhWNfA0SkzQrHrDy5lfVpUREWICltOwxHoZN
         +Q9g==
X-Gm-Message-State: AFqh2krKNRJ6GLJbLjTCT8PAdIHy9DJQ0quxXF6KObnDnur+kaAs9MKb
        /qpZZG3Wmho+bXXJATbfxOo0eSJyepgDDR6o6E7rv+L5T4yD3VFx
X-Google-Smtp-Source: AMrXdXs275TDfbjwrMyFDOxP7eJKDl/7sCCSCHjCRBLe+NE+/nJUHau88ZMFhPOlsZvIRTJv4A2+hFbMjs0Fa6+nfFI=
X-Received: by 2002:ab0:6182:0:b0:419:2865:3ae7 with SMTP id
 h2-20020ab06182000000b0041928653ae7mr2522451uan.70.1672260019408; Wed, 28 Dec
 2022 12:40:19 -0800 (PST)
MIME-Version: 1.0
References: <CADg8p94+rY5B937YweMo=5aGS4Dhz2z4QW-BiAdkVdiWCm-u9w@mail.gmail.com>
 <3bd7c0b2c9937c30082381f92624e98902c72ece.camel@HansenPartnership.com>
In-Reply-To: <3bd7c0b2c9937c30082381f92624e98902c72ece.camel@HansenPartnership.com>
From:   Sughosh Ganu <sughosh.ganu@linaro.org>
Date:   Thu, 29 Dec 2022 02:10:08 +0530
Message-ID: <CADg8p94qd-Kx9Xn2LwqypFeAsV734wv7CvswPmGqJZa+ENPpRg@mail.gmail.com>
Subject: Re: Seal/Unseal trusted keys against PCR policy
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

hi James,

On Tue, 27 Dec 2022 at 21:10, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Tue, 2022-12-27 at 09:44 +0530, Sughosh Ganu wrote:
> > hi,
> > I am looking to use PCR policy to seal and unseal trusted keys. I
> > tried using the interface described in the documentation [1], but I
> > get an unseal error at the time of a key load operation. I came
> > across a thread [2] which is pretty much the error that I get. As per
> > my understanding of what James had explained on that thread, the API
> > was broken for TPM2.0 based devices. Has that since been fixed.
>
> Yes, that's been fixed for a while:
>
> f2219745250f security: keys: trusted: use ASN.1 TPM2 key format for the
> blobs
>
> >  If so, has there been a change in the user interface for sealing and
> > unsealing the trusted keys.
> >
> > Here are the steps that I follow.
> >
> > # tpm2_createpolicy --policy-pcr --pcr-list sha256:10 --policy
> > pcr10_bin.policy > pcr.policy
> >
> > # cat pcr.policy
> > 16ef916486174ed6f68b09629d2920dd7493d0918fff1247420934c3836100d3
> >
> > #keyctl add trusted kmk-pcr "new 32 keyhandle=0x81000001 hash=sha256
> > policydigest=`cat pcr.policy`" @u
> > 588568314
> >
> > # keyctl pipe 588568314 > kmk-pcr.blob
> >
> > On a reboot (or even w/o a reboot, after deleting the key)
> > #keyctl add trusted kmk-pcr "load `cat kmk-pcr.blob`
> > keyhandle=0x81000001 hash=sha256 policydigest=`cat pcr.policy`" @u
> > add_key: Operation not permitted
>
> To reload a sealed key, you have to construct a policy session with the
> matching policy digest and pass it down to the kernel with
> policyhandle=

Thanks for your reply. For reloading the sealed key, I am trying to
start a policy session through the tpm2_startauthsession command,
followed by the tpm2_policypcr command to get the same policy digest.
However, I am not sure how to get the session handle. As per my
understanding, the policyhandle is a uint32_t object. However, none of
the above two commands give back the session handle. I tried the
tpm2_getcap command with the handles-saved-session, which shows a
handle once I have run the tpm2_startauthsession command. However,
providing this value to the keyctl command as policyhandle does not
work. Can you please point out what I am doing wrong?

-sughosh
