Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8CA6D6F33
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Apr 2023 23:44:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236519AbjDDVoo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 4 Apr 2023 17:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236450AbjDDVon (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 4 Apr 2023 17:44:43 -0400
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC0510D2;
        Tue,  4 Apr 2023 14:44:42 -0700 (PDT)
Received: by mail-vs1-xe2d.google.com with SMTP id df34so29731598vsb.8;
        Tue, 04 Apr 2023 14:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680644681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rzm7dSvf3pj94c64Y8ldWoEoQKQWGolJek7/mCokcLo=;
        b=HMWTeliJm1sVeu0vjl35/Qt8rCKS/ODnlCRmcV37LyyuXfvZSj+ervV5UpwlppZHb0
         RHmjQeSQF5AKmU0LbIbPDV1KG8ixGLDVowmttxcg55jeQJFyQ1BBLiIfE1Lia8El/I42
         WinHMyGdjASJTewukWTm0TXLTux4hP/4B02qGbcmsarUEmrAXk9PoJwRhzenlB8GibU6
         f57a5+Tm9KfNrQ01APrcGQrrldqMPjOrgnO+KwS8FSBQHICrsCmjfLcCgnmXMyEM3WDq
         mrmDXss+6BFJxGGSY0xsLfyJpMm1pmUDCDSWeWc+Y8J57ei8TDC76JXZaYysDlh8h2nU
         o7VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680644681;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rzm7dSvf3pj94c64Y8ldWoEoQKQWGolJek7/mCokcLo=;
        b=5+e1lmPNLGipDunDUrRti4S9TbcljXVlWjtXGw3eVzrW41Q0wEhlcpmSjjdwQqmZNI
         mV/7KuW2Z4zAvmNTd8Xam++smFWyFgdWezM6o7LyLcjpj14GYEJOUqyko+HVGpn3tk4O
         NgKR8iLZzS7R84Atitq63FQG0cFCX560EKNKM2yoKx0wAEa5sxpao2/t+sQ7sc39HQ+q
         gcbnxns6gaZzXA37aW8yPiXMVvPYwgGIkQZMG8tBkO1mPFvfGxfVmz99BgGa3LWCsHn9
         KVH403nVf9p+/V4On7OEHM9LB5DgRVCym8U1Y9eriGclCkSUHZC+iiVtFQCp7yd5oBhF
         upDA==
X-Gm-Message-State: AAQBX9fvDpjt9tfhHQfAq9f6P0hYOPJDOZKioXwXx4/E0zdrK2KuJTke
        Ww2wYIGNImCCwAUHvFWZ8X8r81Q69m93Y8Cb2+N31qFs
X-Google-Smtp-Source: AKy350Zgf3/qMqYPrSsAXGvz3kke9W8qtq4NcKt2ShCQld/anDCOZdk91ER+umKE0swSCf/7Uat2sSrE2QIuqfRSX1Q=
X-Received: by 2002:a67:ca87:0:b0:411:b4c2:c6c0 with SMTP id
 a7-20020a67ca87000000b00411b4c2c6c0mr3394038vsl.0.1680644681412; Tue, 04 Apr
 2023 14:44:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230403214003.32093-1-James.Bottomley@HansenPartnership.com>
 <CAFftDdpTWjtNEf=E5V0X1c5ZrG=LQKo1WH6n0Ok2DE7jsh6yqg@mail.gmail.com>
 <414fd2f5e49f9772dd1de4bd281a63e27e60e934.camel@HansenPartnership.com>
 <CAFftDdqeaRWvfvZfGwdXYaFcGBNirDV75JsuRR88FSdCrYmKpg@mail.gmail.com>
 <c025ff772580552ced343d88c608b41cd3e11889.camel@HansenPartnership.com>
 <CAFftDdp84qYaL+VuUXNiMbgPadOzZF1aS07ewW_jTJfM=0yDjA@mail.gmail.com> <294ff9aa398234d5e0a1aba20c406daf7b2f57ab.camel@HansenPartnership.com>
In-Reply-To: <294ff9aa398234d5e0a1aba20c406daf7b2f57ab.camel@HansenPartnership.com>
From:   William Roberts <bill.c.roberts@gmail.com>
Date:   Tue, 4 Apr 2023 16:44:30 -0500
Message-ID: <CAFftDdq7dwKB-xRdfopiLL5catews=0s1==6DaKWqzNK9srSMw@mail.gmail.com>
Subject: Re: [PATCH v4 00/13] add integrity and security to TPM2 transactions
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko@kernel.org>, keyrings@vger.kernel.org,
        Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 4, 2023 at 4:33=E2=80=AFPM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> On Tue, 2023-04-04 at 16:10 -0500, William Roberts wrote:
> > On Tue, Apr 4, 2023 at 3:19=E2=80=AFPM James Bottomley
> > <James.Bottomley@hansenpartnership.com> wrote:
> > >
> > > On Tue, 2023-04-04 at 14:42 -0500, William Roberts wrote:
> > > > On Tue, Apr 4, 2023 at 2:18=E2=80=AFPM James Bottomley
> > > > <James.Bottomley@hansenpartnership.com> wrote:
> > > > >
> > > > > On Tue, 2023-04-04 at 13:43 -0500, William Roberts wrote:
> > > > > [...]
> > > > > > > The final part of the puzzle is that the machine owner must
> > > > > > > have a fixed idea of the EK of their TPM and should have
> > > > > > > certified this with the TPM manufacturer.  On every boot,
> > > > > > > the certified EK public key should be used to do a make
> > > > > > > credential/activate credential attestation key insertion
> > > > > > > and then the null key certified with the attestation key.
> > > > > > > We can follow a trust on first use model where an OS
> > > > > > > installation will extract and verify a public EK and save
> > > > > > > it to a read only file.
> > > > > >
> > > > > > Ahh I was wondering how you were going to bootstrap trust
> > > > > > using the NULL hierarchy.
> > > > >
> > > > > Well, actually, I changed my mind on the details of this one:
> > > > > the make credential/activate credential round trip is a huge
> > > > > faff given that there's no privacy issue.  I think what we
> > > > > should do is simply store the name of a known signing EK on
> > > > > first install (using the standard P-256 derivation of the EK
> > > > > template but with TPMA_OBJECT_SIGN additionally set).  Then you
> > > > > can use the signing EK to certify the NULL key directly and
> > > > > merely check the signing EK name against the stored value to
> > > > > prove everything is correct.
> > > > >
> > > >
> > > > Yeah that model is much simpler. My guess is that on install it
> > > > would persist this "Signing EK" to a specific address that is
> > > > different from the typical EK Address?
> > >
> > > Actually, since this is used to prove trust in the TPM, we can't
> > > have the TPM store it;
> >
> > Hmm, I think we miscommunicated here. At some point you need to call
> > TPM2_CreatePrimary with the "Signing EK" template which would require
> > Endorsement Hierarchy (EH) Auth.
>
> That's right.  Then you hash what you get back and check it against the
> name file.
>
> >  So I would imagine this key would be persistend to avoid needing it
> > all the time?
>
> You could, but the benefit is marginal given how fast the Elliptic
> Curve calculation can be done.  Remember the key is only needed for a
> quote or a certification, so that's once per boot to certify the NULL
> seed and possibly a handful of other uses.
>
> > Then the use of TPM2_Certify using the "EK Signing" key would also
> > need EH Auth since AuthPolicy is coupled to EH Auth via PolicySecret.
> > I'm just thinking every time these commands are invoked, especially
> > if this is used during boot, where EH Auth would be coming from or am
> > I missing something?
>
> No, but then TPM2_CreatePrimary needs the hierarchy authorizations.
> The standard assumption I tend to make is that they're empty for both
> the endorsement and owner.
>

That's been proven not to be a good assertion. Just look at the bugs on sys=
temd
about not working if Owner Auth is set. I think it's important to look at m=
odels
that support auth being set for the hierarchy and minimizing the need on it=
.
Hierarchy Auth could even be a policy, thankfully I haven't bumped into tha=
t
yet.

If this "EK Signing" key is persisted and the AuthPolicy of the key
cleared we would only
need EH Auth one time versus assuming it's always empty. This would
essentially be
an SRK for the EH but includes sign attribute (ERK :-p).

But if we're shoving stuff into a read only config, these options
could be set in the config file
(ie use a persistent handle at location XXX, no auth, etc). But *not*
hardcoding EH auth into
the config file.

I would hate to see requirements requiring that hierarchy auth remains empt=
y.

> Although if there's a use case that actually wants them set for some
> reason, then I think there might be a case for removing the policy from
> the EK template, but if not, it's easier just to follow what the TCG
> says with the addition of the signing permission.
>
> > > it's going to have to be somewhere in the root
> > > filesystem, like /etc.  Ideally it would be in the immutable part
> > > of /etc so it is write once on install.
> > >
> >
> > I'm assuming this would be the template or name of the "Signing EK"?
>
> Just the name, I think, assuming everyone agrees on the template.  If
> there's going to be a question about which template then we'd need
> both.
>
> James
>
