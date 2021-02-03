Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3667730D92D
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Feb 2021 12:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233972AbhBCLvc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 3 Feb 2021 06:51:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234119AbhBCLva (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 3 Feb 2021 06:51:30 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C404C0613D6
        for <linux-integrity@vger.kernel.org>; Wed,  3 Feb 2021 03:50:49 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id e15so12700506lft.13
        for <linux-integrity@vger.kernel.org>; Wed, 03 Feb 2021 03:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=cOD/DHQlOSZ7fugmG47GUh/NK1JYxHNBoQ9+0qs9dMQ=;
        b=v9jPIxlvxSCQ/bTLzDIx/1JIXSpRw2NXw1XiUkWX7APLSFRqxIQClpxUtc9z1MMUCw
         ZPdKx1FlIAcSI0NAJLnFrdJNH1xtuZEpF87S0+r/9SupVdk+D7//GDtlhwarTOweA8GY
         qrcHfVgEhRR3oYBOXwWiv9ABFKzhqOuJAmH1FGs+nO7M4H4nGp3Un4dls3Si5EMtxn/i
         osB1UvQNexSBq94z3rDkm+U/FKxgBue55d6tY2OK04Ho2HigAG7w4dWebxfkGqLGkOQL
         okUWHIC+BG5AvkqvylxTWJsrBGUwpb4i6VxsMDgAdxSZBnwGPHIkjcFMQpvlyakitdp1
         Bj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cOD/DHQlOSZ7fugmG47GUh/NK1JYxHNBoQ9+0qs9dMQ=;
        b=fnKJiwL/gx1l3PlUEWxi3eZq6OvN85G+H74jHAvEjRgGk28l0A6ePYF5v/z4Jt3Cqx
         BJcF8KY0bNrsBcguc/drNiuQSJ34QHTt6gqp7z3gYL+M+0GAsg3Vj8kCIGj095APQkML
         Xuqn9S6UXsWE8eEXdScyUf1cXC7INf7oUhMVAYxOFDM+jWoLhZ0qGfpGCOy/8Vt+4kb1
         lMHgk2DGt62I+KzjK4FhSU6qGAx5/qls3aQ8sMI69lOewZMeEpzX6Ova+f9bHzOZaIKc
         RUITJ1zbzAijjbrIqIgid3SFIFgRWccgJncBXLmhXYM9j8LBbzb5YF2NpvfJu4/2EvbU
         bRPQ==
X-Gm-Message-State: AOAM533wlS7qVam/wJILL0L8ZiY3vRQv/GZ0+rz4qwhxuHC/X0zbpBPu
        TARYZnMrSf3BOaQNXREEw5VLe4Agyv0DXevcbXeglw==
X-Google-Smtp-Source: ABdhPJxm93cdTAPl6mJX4bj/5/52s16IRBAo/arqepqGXR8NM99fuOAxt4ZL1ZDDkNBtyJN3Z/9KJIYLtiamgkgxWDs=
X-Received: by 2002:ac2:47f8:: with SMTP id b24mr1520091lfp.108.1612353047926;
 Wed, 03 Feb 2021 03:50:47 -0800 (PST)
MIME-Version: 1.0
References: <74830d4f-5a76-8ba8-aad0-0d79f7c01af9@pengutronix.de>
 <6dc99fd9ffbc5f405c5f64d0802d1399fc6428e4.camel@kernel.org>
 <d1bed49f89495ceb529355cb41655a208fdb2197.camel@linux.ibm.com>
 <8b9477e150d7c939dc0def3ebb4443efcc83cd85.camel@pengutronix.de>
 <18529562ed71becf21401ec9fd9d95c4ac44fdc0.camel@linux.ibm.com>
 <CAFA6WYMn519aF=uodjnSUZ+kKaRzdoh6Enu0OsRMge=21iBNBA@mail.gmail.com> <2012751fd653c284679aa2c6ac9a56a5edbf1410.camel@pengutronix.de>
In-Reply-To: <2012751fd653c284679aa2c6ac9a56a5edbf1410.camel@pengutronix.de>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 3 Feb 2021 17:20:36 +0530
Message-ID: <CAFA6WYNbf+Jncj0jF4abLhWH8RUWDORf0kcWi021hxBmq-NK=g@mail.gmail.com>
Subject: Re: Migration to trusted keys: sealing user-provided key?
To:     =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>
Cc:     James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        David Howells <dhowells@redhat.com>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2 Feb 2021 at 18:04, Jan L=C3=BCbbe <jlu@pengutronix.de> wrote:
>
> On Tue, 2021-02-02 at 17:45 +0530, Sumit Garg wrote:
> > Hi Jan,
> >
> > On Sun, 31 Jan 2021 at 23:40, James Bottomley <jejb@linux.ibm.com> wrot=
e:
> > >
> > > On Sun, 2021-01-31 at 15:14 +0100, Jan L=C3=BCbbe wrote:
> > > > On Sun, 2021-01-31 at 07:09 -0500, Mimi Zohar wrote:
> > > > > On Sat, 2021-01-30 at 19:53 +0200, Jarkko Sakkinen wrote:
> > > > > > On Thu, 2021-01-28 at 18:31 +0100, Ahmad Fatoum wrote:
> > > > > > > Hello,
> > > > > > >
> > > > > > > I've been looking into how a migration to using
> > > > > > > trusted/encrypted keys would look like (particularly with dm-
> > > > > > > crypt).
> > > > > > >
> > > > > > > Currently, it seems the the only way is to re-encrypt the
> > > > > > > partitions because trusted/encrypted keys always generate the=
ir
> > > > > > > payloads from RNG.
> > > > > > >
> > > > > > > If instead there was a key command to initialize a new
> > > > > > > trusted/encrypted key with a user provided value, users could
> > > > > > > use whatever mechanism they used beforehand to get a plaintex=
t
> > > > > > > key and use that to initialize a new trusted/encrypted key.
> > > > > > > From there on, the key will be like any other trusted/encrypt=
ed
> > > > > > > key and not be disclosed again to userspace.
> > > > > > >
> > > > > > > What are your thoughts on this? Would an API like
> > > > > > >
> > > > > > >   keyctl add trusted dmcrypt-key 'set <content>' # user-
> > > > > > > supplied content
> > > > > > >
> > > > > > > be acceptable?
> > > > > >
> > > > > > Maybe it's the lack of knowledge with dm-crypt, but why this
> > > > > > would be useful? Just want to understand the bottleneck, that's
> > > > > > all.
> > > >
> > > > Our goal in this case is to move away from having the dm-crypt key
> > > > material accessible to user-space on embedded devices. For an
> > > > existing dm-crypt volume, this key is fixed. A key can be loaded in=
to
> > > > user key type and used by dm-crypt (cryptsetup can already do it th=
is
> > > > way). But at this point, you can still do 'keyctl read' on that key=
,
> > > > exposing the key material to user space.
> > > >
> > > > Currently, with both encrypted and trusted keys, you can only
> > > > generate new random keys, not import existing key material.
> > > >
> > > > James Bottomley mentioned in the other reply that the key format wi=
ll
> > > > become compatible with the openssl_tpm2_engine, which would provide=
 a
> > > > workaround. This wouldn't work with OP-TEE-based trusted keys (see
> > > > Sumit Garg's series), though.
> > >
> > > Assuming OP-TEE has the same use model as the TPM, someone will
> > > eventually realise the need for interoperable key formats between key
> > > consumers and then it will work in the same way once the kernel gets
> > > updated to speak whatever format they come up with.
> >
> > IIUC, James re-work for TPM trusted keys is to allow loading of sealed
> > trusted keys directly via user-space (with proper authorization) into
> > the kernel keyring.
> >
> > I think similar should be achievable with OP-TEE (via extending pseudo
> > TA [1]) as well to allow restricted user-space access (with proper
> > authorization) to generate sealed trusted key blob that should be
> > interoperable with the kernel. Currently OP-TEE exposes trusted key
> > interfaces for kernel users only.
>
> What is the security benefit of having the key blob creation in user-spac=
e
> instead of in the kernel? Key import is a standard operation in HSMs or P=
KCS#11
> tokens.

User authentication, AFAIK most of the HSMs or PKCS#11 require that
for key import. But IIUC, your suggested approach to load plain key
into kernel keyring and say it's *trusted* without any user
authentication, would it really be a trusted key? What prevents a
rogue user from making his key as the dm-crypt trusted key?

>
> I mainly see the downside of having to add another API to access the unde=
rlying
> functionality (be it trusted key TA or the NXP CAAM HW *) and requiring
> platform-specific userspace code.

I am not sure why you would call the standardized TEE interface [1] to
be platform-specific, it is meant to be platform agnostic. And I think
we can have openssl_tee_engine on similar lines as the
openssl_tpm2_engine.

[1] https://globalplatform.org/specs-library/tee-client-api-specification/

-Sumit

>
> This CAAM specific API (in out-of-tree patches) was exactly the part I wa=
s
> trying to get rid of. ;)
>
> Regards,
> Jan
>
> --
> Pengutronix e.K.                           |                             =
|
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  =
|
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    =
|
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 =
|
>
