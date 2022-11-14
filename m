Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B8162877B
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Nov 2022 18:52:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236542AbiKNRwF (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Nov 2022 12:52:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236681AbiKNRva (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Nov 2022 12:51:30 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA8422293
        for <linux-integrity@vger.kernel.org>; Mon, 14 Nov 2022 09:51:28 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id kt23so30224534ejc.7
        for <linux-integrity@vger.kernel.org>; Mon, 14 Nov 2022 09:51:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dFbOq8KvPfyqv8Tvmztn6miVwXV7s2YCAIN0rDZgKn8=;
        b=kZAUj86IXe75dnl5U1/0XlxZ6WiVvz4JF/MFnWu5WfrqUcHIfpIwloMIqexqEiyr6V
         K/9kWKkJfuHr15e10x1+ONoUzzBsMmZYVXI/2yoTq+2rhQtzN9nD2QPPLoO00VQgpHyF
         NTtevwQQPEukJ10Av1iiOWVTKuNvLTl68r8Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dFbOq8KvPfyqv8Tvmztn6miVwXV7s2YCAIN0rDZgKn8=;
        b=QNDyC+JegCFSu1GVzJRG1u5/Hxil0SehKqOQnzM7LR634XKKJ+QwBhofo+VLHbggvL
         11PHLzIl534MGxCl/URg+l0S1uxWAF7+c70GU5lUuu2cskZ1ejg9N4/G6nmjCbl55XBk
         HJYVqwxjoJ+vNJ5tF+2hBqqzmLC2d64wI4673j7x36SuUwRBTRRiNayWIZFPTcKB7cwz
         SxY1CThr7abwAclME3pOA1pFz0Rv8PJChCT7u8GU+WY0u8Am/nqX6yxelKbob7HbLv3K
         U4ox3nw1X4+6uWj1AMbWUmRAwLDuidQoVn2MxeA5uYN8PTYeYsEYDaIEiASM4TTMJ3ro
         7Yrw==
X-Gm-Message-State: ANoB5pkw1GUTdwFJhBNHe4cMJBfB1l53Yg+zDdd944qNjvO2OeLiGm6P
        +O4JWzgc1KVWBBuB06OilizyR00dEKQU1w==
X-Google-Smtp-Source: AA0mqf5fMpW0GXplGoZJ3AWZFK8brpa4Rgzkj353yarldo2qqa6bwQEn+eONlOAhsyybhxE2BBSOWQ==
X-Received: by 2002:a17:907:11c7:b0:7ad:821f:a3e5 with SMTP id va7-20020a17090711c700b007ad821fa3e5mr10839610ejb.554.1668448286956;
        Mon, 14 Nov 2022 09:51:26 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id f12-20020a17090631cc00b0078d46aa3b82sm4387814ejf.21.2022.11.14.09.51.26
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 09:51:26 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id y16so19655586wrt.12
        for <linux-integrity@vger.kernel.org>; Mon, 14 Nov 2022 09:51:26 -0800 (PST)
X-Received: by 2002:adf:f10a:0:b0:236:863c:22d with SMTP id
 r10-20020adff10a000000b00236863c022dmr8382325wro.590.1668447818962; Mon, 14
 Nov 2022 09:43:38 -0800 (PST)
MIME-Version: 1.0
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.4.Ieb1215f598bc9df56b0e29e5977eae4fcca25e15@changeid>
 <Y3FfhrgvBNey6T7V@sol.localdomain> <ff23b4e24222037959c2a784496c7ee91024e6c5.camel@linux.ibm.com>
 <CAE=gft63-jdKqKmepB+LXPm6WUWSnz+CMWcWWnyN1y-EnS4kVg@mail.gmail.com> <c31d1a3af53515f2a9d3f53eb27ce698e796f9b9.camel@linux.ibm.com>
In-Reply-To: <c31d1a3af53515f2a9d3f53eb27ce698e796f9b9.camel@linux.ibm.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 14 Nov 2022 09:43:02 -0800
X-Gmail-Original-Message-ID: <CAE=gft6L6bMtzbqUfH_NAsFz2r0Nw7kkbCPXcr2nYj5n31FYQg@mail.gmail.com>
Message-ID: <CAE=gft6L6bMtzbqUfH_NAsFz2r0Nw7kkbCPXcr2nYj5n31FYQg@mail.gmail.com>
Subject: Re: [PATCH v5 04/11] security: keys: trusted: Include TPM2 creation data
To:     jejb@linux.ibm.com
Cc:     Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org,
        corbet@lwn.net, linux-integrity@vger.kernel.org,
        gwendal@chromium.org, dianders@chromium.org, apronin@chromium.org,
        Pavel Machek <pavel@ucw.cz>, Ben Boeckel <me@benboeckel.net>,
        rjw@rjwysocki.net, Kees Cook <keescook@chromium.org>,
        dlunev@google.com, zohar@linux.ibm.com,
        Matthew Garrett <mgarrett@aurora.tech>, jarkko@kernel.org,
        linux-pm@vger.kernel.org, David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E. Hallyn" <serge@hallyn.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 14, 2022 at 8:56 AM James Bottomley <jejb@linux.ibm.com> wrote:
>
> On Mon, 2022-11-14 at 08:32 -0800, Evan Green wrote:
> > On Sun, Nov 13, 2022 at 7:32 PM James Bottomley <jejb@linux.ibm.com>
> > wrote:
> > >
> > > On Sun, 2022-11-13 at 13:20 -0800, Eric Biggers wrote:
> > > > On Fri, Nov 11, 2022 at 03:16:29PM -0800, Evan Green wrote:
> > > > > diff --git a/security/keys/trusted-keys/tpm2key.asn1
> > > > > b/security/keys/trusted-keys/tpm2key.asn1
> > > > > index f57f869ad60068..608f8d9ca95fa8 100644
> > > > > --- a/security/keys/trusted-keys/tpm2key.asn1
> > > > > +++ b/security/keys/trusted-keys/tpm2key.asn1
> > > > > @@ -7,5 +7,18 @@ TPMKey ::= SEQUENCE {
> > > > >         emptyAuth       [0] EXPLICIT BOOLEAN OPTIONAL,
> > > > >         parent          INTEGER ({tpm2_key_parent}),
> > > > >         pubkey          OCTET STRING ({tpm2_key_pub}),
> > > > > -       privkey         OCTET STRING ({tpm2_key_priv})
> > > > > +       privkey         OCTET STRING ({tpm2_key_priv}),
> > > > > +       ---
> > > > > +       --- A TPM2B_CREATION_DATA struct as returned from the
> > > > > TPM2_Create command.
> > > > > +       ---
> > > > > +       creationData    [1] EXPLICIT OCTET STRING OPTIONAL
> > > > > ({tpm2_key_creation_data}),
> > > > > +       ---
> > > > > +       --- A TPM2B_DIGEST of the creationHash as returned from
> > > > > the
> > > > > TPM2_Create
> > > > > +       --- command.
> > > > > +       ---
> > > > > +       creationHash    [2] EXPLICIT OCTET STRING OPTIONAL
> > > > > ({tpm2_key_creation_hash}),
> > > > > +       ---
> > > > > +       --- A TPMT_TK_CREATION ticket as returned from the
> > > > > TPM2_Create command.
> > > > > +       ---
> > > > > +       creationTk      [3] EXPLICIT OCTET STRING OPTIONAL
> > > > > ({tpm2_key_creation_tk})
> > > > >         }
> > > >
> > > > The commit that added this file claimed:
> > > >
> > > >         "The benefit of the ASN.1 format is that it's a standard
> > > > and thus the
> > > >         exported key can be used by userspace tools
> > > > (openssl_tpm2_engine,
> > > >         openconnect and tpm2-tss-engine"
> > > >
> > > > Are these new fields in compliance with whatever standard that
> > > > was referring to?
> > >
> > > Not really, no.  The current use case (and draft standard) is
> > > already using [1] for policies and [2] for importable keys:
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/tree/doc/draft-bottomley-tpm2-keys.xml
> > >
> > > I'm actually planning to use [3] for signed policies.  There's no
> > > reason why you can't use [4] though.  Since the creation data, hash
> > > and ticket are likely used as a job lot, it strikes me they should
> > > be a single numbered optional sequence instead of individually
> > > numbered, since you're unlikely to have one without the others.
> >
> > Thanks, I was hoping James might pipe up and tell me what to do.
> > Grouping them as a single numbered optional sequence sounds
> > reasonable to me. Is your draft too far along to squeeze this in?
>
> Not at all.  The draft only becomes frozen once I submit it to the IETF
> which, so far thanks to lack of any reviewers I haven't done (That's
> why I was also thinking of adding signed policies).
>
> >  If it is and I'm on my own to draft up and submit this, I would
> > definitely appreciate any pointers on getting started you might have.
> >
> > I notice the draft and the code seem to be out of alignment.
>
> The kernel code is out of alignment just because development moves a
> bit slowly.  Policy based keys were submitted a long time ago as part
> of the original move to interoperable sealed keys based on ASN.1:
>
> https://lore.kernel.org/all/20200616160229.8018-7-James.Bottomley@HansenPartnership.com/
>
> But eventually the policy part was split out and forgotten about.  I
> think the only complete implementation of the draft standard is the
> openssl_tpm2_engine.
>
> >  I'm unfamiliar with this process, is the idea to get through all the
> > iterations and land the standard, then fix up the code? What happens
> > to existing data handed out in the old format?
>
> No, it doesn't matter at all.  That's the whole point of using ASN.1
> explicit optionals: the ASN.1 is always backwards compatible.  If I
> ever submit the draft, there'll have to be a new RFC to add new
> explicit optionals, but keys conforming to the old RFC will still be
> valid under the new one.

Ah I see, with the optionals in mind things do line up again.

>
> Of course, since openssl_tpm2_engine is the complete reference
> implementation that means I'll have to add the creation PCRs
> implementation to it ... unless you'd like to do it?

I am willing to help as I'm the one making the mess. How does it
sequence along with your draft submission (before, after,
simultaneous)?
