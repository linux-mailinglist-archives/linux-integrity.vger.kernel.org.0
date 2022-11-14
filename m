Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 828FA628593
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Nov 2022 17:38:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237879AbiKNQix (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Nov 2022 11:38:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237839AbiKNQij (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Nov 2022 11:38:39 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C5BB633D
        for <linux-integrity@vger.kernel.org>; Mon, 14 Nov 2022 08:33:35 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id bj12so29613267ejb.13
        for <linux-integrity@vger.kernel.org>; Mon, 14 Nov 2022 08:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fdHhTpZNmQxUEi2mbASnWXi91JoJlz5SqgpuzvGvbqs=;
        b=Ck1gj2RHs6kKr8eo0lLZILNZm9cTLBmDBgd3gbZIiMsgfnGD3JCQsqadXh2xLzzWDB
         1lPmOGx9KUAFcKRtzpsAkB/jzN2nyVsb7J2RGxm+IgmxzSWRs+xzhCPqnycw71njMhHU
         0JqDeR+Ls0TsMcPMDlQtzx7Tuxw277l1DoPnQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fdHhTpZNmQxUEi2mbASnWXi91JoJlz5SqgpuzvGvbqs=;
        b=tjj/W2WWLxMuj8vRyE4mMO7aZPaScmiDXR6D9erpN/qRl4I7TpPR4SWtbvGvKW5iVl
         UgX+y6AU8SF3yo5RF1dH7gDPjwf1QavOmows0kb1+tgXxn2+8RuXGemvpMvmjMULPLtc
         5whN3W/7F0ZF7I/1VjU8QRkGb4ji6SsBElfwORG2FkLoXsuxj6Eyt2VjCuNAHVSRcEAG
         X+SK4NsZRHrOk2UV6Z7bHzMBD7wzIBYRIZT3z6z8l5ZhO/f8q42wZQCMzyB1LdHHx0FX
         CvCuoWFmY4SAeCkib1VkupHpfvaFX2TIR4TD60dUbVbU+jJvqajrtqPlOgJXEsw+U/nG
         WwWA==
X-Gm-Message-State: ANoB5pnsVYdOB8pq2gkTG7Yf8tD+X6+qK9rKYm7XEAfiR6GBUPYm1HEL
        Bdbl7TcLOcrqghd5QkudqLFVe1u0WQKH8A==
X-Google-Smtp-Source: AA0mqf78Howhp/A48vMsUKHmTyVjUoNHcqvuaLlfh64Yu4DwdsR6eTzW6pajN2d+ad8nEyS39S69yg==
X-Received: by 2002:a17:907:3101:b0:7ad:cda3:93c7 with SMTP id wl1-20020a170907310100b007adcda393c7mr11272006ejb.500.1668443613242;
        Mon, 14 Nov 2022 08:33:33 -0800 (PST)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com. [209.85.128.53])
        by smtp.gmail.com with ESMTPSA id o5-20020a056402038500b004619f024864sm4967544edv.81.2022.11.14.08.33.32
        for <linux-integrity@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 08:33:32 -0800 (PST)
Received: by mail-wm1-f53.google.com with SMTP id 129-20020a1c0287000000b003cfe48519a6so1387361wmc.0
        for <linux-integrity@vger.kernel.org>; Mon, 14 Nov 2022 08:33:32 -0800 (PST)
X-Received: by 2002:a05:600c:4e0e:b0:3cf:87c6:890b with SMTP id
 b14-20020a05600c4e0e00b003cf87c6890bmr8708365wmq.194.1668443611668; Mon, 14
 Nov 2022 08:33:31 -0800 (PST)
MIME-Version: 1.0
References: <20221111231636.3748636-1-evgreen@chromium.org>
 <20221111151451.v5.4.Ieb1215f598bc9df56b0e29e5977eae4fcca25e15@changeid>
 <Y3FfhrgvBNey6T7V@sol.localdomain> <ff23b4e24222037959c2a784496c7ee91024e6c5.camel@linux.ibm.com>
In-Reply-To: <ff23b4e24222037959c2a784496c7ee91024e6c5.camel@linux.ibm.com>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 14 Nov 2022 08:32:55 -0800
X-Gmail-Original-Message-ID: <CAE=gft63-jdKqKmepB+LXPm6WUWSnz+CMWcWWnyN1y-EnS4kVg@mail.gmail.com>
Message-ID: <CAE=gft63-jdKqKmepB+LXPm6WUWSnz+CMWcWWnyN1y-EnS4kVg@mail.gmail.com>
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

On Sun, Nov 13, 2022 at 7:32 PM James Bottomley <jejb@linux.ibm.com> wrote:
>
> On Sun, 2022-11-13 at 13:20 -0800, Eric Biggers wrote:
> > On Fri, Nov 11, 2022 at 03:16:29PM -0800, Evan Green wrote:
> > > diff --git a/security/keys/trusted-keys/tpm2key.asn1
> > > b/security/keys/trusted-keys/tpm2key.asn1
> > > index f57f869ad60068..608f8d9ca95fa8 100644
> > > --- a/security/keys/trusted-keys/tpm2key.asn1
> > > +++ b/security/keys/trusted-keys/tpm2key.asn1
> > > @@ -7,5 +7,18 @@ TPMKey ::= SEQUENCE {
> > >         emptyAuth       [0] EXPLICIT BOOLEAN OPTIONAL,
> > >         parent          INTEGER ({tpm2_key_parent}),
> > >         pubkey          OCTET STRING ({tpm2_key_pub}),
> > > -       privkey         OCTET STRING ({tpm2_key_priv})
> > > +       privkey         OCTET STRING ({tpm2_key_priv}),
> > > +       ---
> > > +       --- A TPM2B_CREATION_DATA struct as returned from the
> > > TPM2_Create command.
> > > +       ---
> > > +       creationData    [1] EXPLICIT OCTET STRING OPTIONAL
> > > ({tpm2_key_creation_data}),
> > > +       ---
> > > +       --- A TPM2B_DIGEST of the creationHash as returned from the
> > > TPM2_Create
> > > +       --- command.
> > > +       ---
> > > +       creationHash    [2] EXPLICIT OCTET STRING OPTIONAL
> > > ({tpm2_key_creation_hash}),
> > > +       ---
> > > +       --- A TPMT_TK_CREATION ticket as returned from the
> > > TPM2_Create command.
> > > +       ---
> > > +       creationTk      [3] EXPLICIT OCTET STRING OPTIONAL
> > > ({tpm2_key_creation_tk})
> > >         }
> >
> > The commit that added this file claimed:
> >
> >         "The benefit of the ASN.1 format is that it's a standard and
> > thus the
> >         exported key can be used by userspace tools
> > (openssl_tpm2_engine,
> >         openconnect and tpm2-tss-engine"
> >
> > Are these new fields in compliance with whatever standard that was
> > referring to?
>
> Not really, no.  The current use case (and draft standard) is already
> using [1] for policies and [2] for importable keys:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jejb/openssl_tpm2_engine.git/tree/doc/draft-bottomley-tpm2-keys.xml
>
> I'm actually planning to use [3] for signed policies.  There's no
> reason why you can't use [4] though.  Since the creation data, hash and
> ticket are likely used as a job lot, it strikes me they should be a
> single numbered optional sequence instead of individually numbered,
> since you're unlikely to have one without the others.

Thanks, I was hoping James might pipe up and tell me what to do.
Grouping them as a single numbered optional sequence sounds reasonable
to me. Is your draft too far along to squeeze this in? If it is and
I'm on my own to draft up and submit this, I would definitely
appreciate any pointers on getting started you might have.

I notice the draft and the code seem to be out of alignment. I'm
unfamiliar with this process, is the idea to get through all the
iterations and land the standard, then fix up the code? What happens
to existing data handed out in the old format?

-Evan
