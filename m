Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3D2665D0D
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Jan 2023 14:52:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233965AbjAKNvv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 Jan 2023 08:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239150AbjAKNvE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 Jan 2023 08:51:04 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF04117E0C
        for <linux-integrity@vger.kernel.org>; Wed, 11 Jan 2023 05:50:28 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id d66so3308002vsd.9
        for <linux-integrity@vger.kernel.org>; Wed, 11 Jan 2023 05:50:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7LAKnLeBR5eLwdJ22qJTkc3+tzTh8gFdJWVbk//qrL8=;
        b=Kl1ti1I23Avmnuwiv38OdtSziwlZxlWvhm2kOez3YF40j6CkK3sIl4gyBPYy1TLNiD
         DIYZwNuW79BTNLFj6dQTzzgqBipn8XcT3ckOh6dhgqJCTyLu2lLQRuZWGCdZ0DIK51n9
         ACHZ/suJ3Ps4mipc6YyrGs6PqHzo/h06ednX7HxkKWJmGv2f8lUE5cpRm/fJuhKBMX6t
         Gn0VGzC9CUrh4Nmv32MdQXcytOjb3/awcL9CzQJaWnjrat64xPKiuc6Yea2sOEepCArb
         polRW+qu3pai7MXuFMF5QLRMPyv1lejftTQnGCFLromvDGxHTHXKmyo/KVSJwbO0BN2j
         K8sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7LAKnLeBR5eLwdJ22qJTkc3+tzTh8gFdJWVbk//qrL8=;
        b=HoNM6KkiP+hjAq3lzfMsl+ZVyIxQe9HtiI4NJl+aRfx9Gha3iWH2ENvuWvEze68TBQ
         n8PqcdgDvdmYcDOfQfOS3zQyGYcAkVLD+N2Z3r4pWSobWoovUVLrsS+177FJv1NBGs1E
         ZBtNzekM+Z76+e54M+y0XkNwEB49yMYR0g4lMBVpCB+OElH3vnhMMewQeKU+HAPvq1xu
         ShR1aDwDidh2YDB9hWLUiR9bWZj20Q2XvQGWDMi24mFW7+k+FjCotW42jpjzAdv7PTLI
         //o4bHP8d9QfiAW8IlRCQ8bQRBeSQNMQTW0KMnSNeej3xpgeI+qLMGdu1Ok/st75Zqkv
         Rqmg==
X-Gm-Message-State: AFqh2kqiFovEzjHPEMn8NLUNevUjKS8vbA9vlu1ZQzxWecrwn4NO/Ca/
        6eLAKPiLei7mcF2HGcsf5mWFNtU12U8crFaBPPE=
X-Google-Smtp-Source: AMrXdXsTqWoIhK0qqGMHLRH6G5Wx6LhWfuiqrOwhzDn6cMpP5r2hO5dcycD4F4UrpJcGklopfqhYfmcIl8WgTFlyHW4=
X-Received: by 2002:a05:6102:21ab:b0:3b2:fa8f:ae01 with SMTP id
 i11-20020a05610221ab00b003b2fa8fae01mr3887005vsb.47.1673445027987; Wed, 11
 Jan 2023 05:50:27 -0800 (PST)
MIME-Version: 1.0
References: <CADg8p94+rY5B937YweMo=5aGS4Dhz2z4QW-BiAdkVdiWCm-u9w@mail.gmail.com>
 <3bd7c0b2c9937c30082381f92624e98902c72ece.camel@HansenPartnership.com>
 <CADg8p94qd-Kx9Xn2LwqypFeAsV734wv7CvswPmGqJZa+ENPpRg@mail.gmail.com>
 <2910376b6912885f696afebf43b820513c004dbb.camel@HansenPartnership.com>
 <63a8c022-1407-d701-e756-070e299b5803@linux.ibm.com> <CAFftDdr6qs33HaaPK3MMmyi9-mMjUuLURt9PAum6hJ3N3m=_iw@mail.gmail.com>
 <a763fdc8e247e217b5efe860be4aebccb708b245.camel@HansenPartnership.com>
 <CAFftDdrnoc7zsxqLGuGDVK9fh1xh3E3dT2+9rKm7BPr114ZjFA@mail.gmail.com>
 <CADg8p94cniETuUFYBw5tOYxBOSMwjYxYZ6Q-bp=WgYvH-e=U_g@mail.gmail.com> <119b5fbe23c8ded539b03cb19e5e9107c8189580.camel@HansenPartnership.com>
In-Reply-To: <119b5fbe23c8ded539b03cb19e5e9107c8189580.camel@HansenPartnership.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Wed, 11 Jan 2023 07:50:16 -0600
Message-ID: <CAFftDdpus-TyHg4iOHFH9Ph4bkD5rW8zUtjaXoc6SbvwS+6JgA@mail.gmail.com>
Subject: Re: Seal/Unseal trusted keys against PCR policy
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Sughosh Ganu <sughosh.ganu@linaro.org>,
        Ken Goldman <kgold@linux.ibm.com>,
        linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Jan 11, 2023 at 6:31 AM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Wed, 2023-01-11 at 17:49 +0530, Sughosh Ganu wrote:
> > On Sat, 7 Jan 2023 at 04:43, William Roberts
> > <bill.c.roberts@gmail.com> wrote:
> [...]
> > > tpm2_sessionconfig prints the raw handle for this purpose. I think
> > > we added it when someone specifically needed the raw handle  to
> > > pass to the kernel.
> >
> > I tried getting the raw handle using the tpm2_sessionconfig command
> > on the context file, and I did get the session handle. The session
> > digest also matches the policy digest that was used at the time of
> > the trusted key creation. However, when I pass the session handle
> > value through the policyhandle parameter for the key loading
> > operation, the unsealing fails.
> >
> > I run the following commands for the key load operation.
> >
> > # tpm2_startauthsession -S session.ctx --policy-session
> > # tpm2_policypcr -S session.ctx -l sha256:10
> > # tpm2_sessionconfig session.ctx  <--- Running this gives me the
> > session handle.
> > # keyctl add trusted kmk-trusted "load `cat kmk-trusted.blob`
> > keyhandle=0x81000001 hash=sha256 policyhandle=0x03000000" @u
> >
> > [  217.219048] tpm tpm0: A TPM error (2328) occurred unsealing
>
> Error 2328 is TPM_RC_REFERENCE_S0 - the 1st authorization session
> handle references a session that is not loaded
>
> So it looks like the session is still context saved, pointing to an
> error in the toolkit.
>

Yes, this jogged my memory that we talked about implementing this between
Imran (The other main developer) and I. If we don't context save in the tool,
both tpm2-abrmd and in-kernel will flush the handle.

I think the cleanest option would be to add a --wait-for-sighup option where
the tool sleeps until sighup is delivered. For scripts, folks could
just lunch it in the
background, grab the handle output and then kill -s sighuhp %1 or whatever.

That's pretty easy to add, let me know and I can respond with a PR on github.

<snip>
