Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5791030EC0D
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Feb 2021 06:31:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbhBDFbm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Feb 2021 00:31:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbhBDFbg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Feb 2021 00:31:36 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0D3C061786
        for <linux-integrity@vger.kernel.org>; Wed,  3 Feb 2021 21:30:56 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id r23so24606ljh.1
        for <linux-integrity@vger.kernel.org>; Wed, 03 Feb 2021 21:30:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2uSRokrJ+R6V6ON0IfFPRQWKuZNn7Av5SOzhnWtouhQ=;
        b=O2tNeL3LdZ+GRpOnLxKGwG7QQOaZCj9MzitgrUevmXaMNhqN4PNcKxZMu4BuGWy3os
         M3zx/0XOG/MGkb1FbGeBv2qRzgsGxIRWcCiMTtPjFgZ0UcR3r/YxGTZUUo+pbWw/YVY2
         y4CHzAjoJSXMN+V5STVWn31P/K7JXEoGr9cPvl0dShrAzqbTMUEYTaRliYNckVUq2J41
         vnZvwhq/eS6IgDbLXjUYyVeIdI1JBeOQBdUe9xe/Yh8CHlEjF8DpY/NiaFTJ/miCr/OR
         QiwX+vU9G6yR0vzRcYBH8lPtEp9ahVcl+FIJ7sL5zNHFFVZs+THabzK2rRqG9A3sB5pQ
         Nw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2uSRokrJ+R6V6ON0IfFPRQWKuZNn7Av5SOzhnWtouhQ=;
        b=dTaBZcaLIlqK0JylZVoGkyRNogH4G3q3t8UBlrdddbVabzeanTz6EIpITxqAk/paHg
         3xxGTnoqjICYIwj7mJvIawXdmQn6j7RZ0OpBHN7oLxDxcw0kCHbweDAjxETE4e9nXomO
         n4h9XNUtC8/GZzdDAryMNm6OrwhfFGCwQ4/KcmNN7d0WjoHg2dK8VaVp0ks1rbN9anW4
         w8AsDadBlXaUHb66Uy0/Bxib/Hfx5mUrqaaC4cLxfwWXbqQBdAhCcCnIbZ2C7vFf/TV5
         hYZsXMAMOdesZ5RBW24V7HI2tCC20s048fuNui8QtfkIF2WkDFVMGHdb40bSwbyzPZRG
         NiDw==
X-Gm-Message-State: AOAM533kP4hob6byWzuSJTJvmjO/6XA9K35AY7cXgrX/Bm4JNx49vo0G
        Ns+z8Js2JpJc4gRKcdaK7OA8mZwn9ULwWEMbYBXRyQ==
X-Google-Smtp-Source: ABdhPJzsP7qEqW5rTwE/GX3ywp9PCwS0wHO1gQIoUhiXvPxw4thue90Z8q0WVFTbwOYKvwscIkD1CNpkJcS1/bVY+i0=
X-Received: by 2002:a2e:91d0:: with SMTP id u16mr3828312ljg.480.1612416654551;
 Wed, 03 Feb 2021 21:30:54 -0800 (PST)
MIME-Version: 1.0
References: <74830d4f-5a76-8ba8-aad0-0d79f7c01af9@pengutronix.de>
 <6dc99fd9ffbc5f405c5f64d0802d1399fc6428e4.camel@kernel.org>
 <d1bed49f89495ceb529355cb41655a208fdb2197.camel@linux.ibm.com>
 <8b9477e150d7c939dc0def3ebb4443efcc83cd85.camel@pengutronix.de>
 <18529562ed71becf21401ec9fd9d95c4ac44fdc0.camel@linux.ibm.com>
 <CAFA6WYMn519aF=uodjnSUZ+kKaRzdoh6Enu0OsRMge=21iBNBA@mail.gmail.com>
 <2012751fd653c284679aa2c6ac9a56a5edbf1410.camel@pengutronix.de>
 <CAFA6WYNbf+Jncj0jF4abLhWH8RUWDORf0kcWi021hxBmq-NK=g@mail.gmail.com> <1310b10eaaf246c326f8d74bd47c91d738ea976b.camel@pengutronix.de>
In-Reply-To: <1310b10eaaf246c326f8d74bd47c91d738ea976b.camel@pengutronix.de>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 4 Feb 2021 11:00:43 +0530
Message-ID: <CAFA6WYOuG6uy1_T67fvefRaY+YnOz5TDYY9j8fFhM2F=UXmNCg@mail.gmail.com>
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
        <linux-security-module@vger.kernel.org>, kernel@pengutronix.de,
        Eric Biggers <ebiggers@kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 3 Feb 2021 at 19:16, Jan L=C3=BCbbe <jlu@pengutronix.de> wrote:
>
> On Wed, 2021-02-03 at 17:20 +0530, Sumit Garg wrote:
> > On Tue, 2 Feb 2021 at 18:04, Jan L=C3=BCbbe <jlu@pengutronix.de> wrote:
> > >
> > > On Tue, 2021-02-02 at 17:45 +0530, Sumit Garg wrote:
> > > > Hi Jan,
> > > >
> > > > On Sun, 31 Jan 2021 at 23:40, James Bottomley <jejb@linux.ibm.com> =
wrote:
> > > > >
> > > > > On Sun, 2021-01-31 at 15:14 +0100, Jan L=C3=BCbbe wrote:
> > > > > > On Sun, 2021-01-31 at 07:09 -0500, Mimi Zohar wrote:
> > > > > > > On Sat, 2021-01-30 at 19:53 +0200, Jarkko Sakkinen wrote:
> > > > > > > > On Thu, 2021-01-28 at 18:31 +0100, Ahmad Fatoum wrote:
> > > > > > > > > Hello,
> > > > > > > > >
> > > > > > > > > I've been looking into how a migration to using
> > > > > > > > > trusted/encrypted keys would look like (particularly with=
 dm-
> > > > > > > > > crypt).
> > > > > > > > >
> > > > > > > > > Currently, it seems the the only way is to re-encrypt the
> > > > > > > > > partitions because trusted/encrypted keys always generate=
 their
> > > > > > > > > payloads from RNG.
> > > > > > > > >
> > > > > > > > > If instead there was a key command to initialize a new
> > > > > > > > > trusted/encrypted key with a user provided value, users c=
ould
> > > > > > > > > use whatever mechanism they used beforehand to get a plai=
ntext
> > > > > > > > > key and use that to initialize a new trusted/encrypted ke=
y.
> > > > > > > > > From there on, the key will be like any other trusted/enc=
rypted
> > > > > > > > > key and not be disclosed again to userspace.
> > > > > > > > >
> > > > > > > > > What are your thoughts on this? Would an API like
> > > > > > > > >
> > > > > > > > >   keyctl add trusted dmcrypt-key 'set <content>' # user-
> > > > > > > > > supplied content
> > > > > > > > >
> > > > > > > > > be acceptable?
> > > > > > > >
> > > > > > > > Maybe it's the lack of knowledge with dm-crypt, but why thi=
s
> > > > > > > > would be useful? Just want to understand the bottleneck, th=
at's
> > > > > > > > all.
> > > > > >
> > > > > > Our goal in this case is to move away from having the dm-crypt =
key
> > > > > > material accessible to user-space on embedded devices. For an
> > > > > > existing dm-crypt volume, this key is fixed. A key can be loade=
d into
> > > > > > user key type and used by dm-crypt (cryptsetup can already do i=
t this
> > > > > > way). But at this point, you can still do 'keyctl read' on that=
 key,
> > > > > > exposing the key material to user space.
> > > > > >
> > > > > > Currently, with both encrypted and trusted keys, you can only
> > > > > > generate new random keys, not import existing key material.
> > > > > >
> > > > > > James Bottomley mentioned in the other reply that the key forma=
t will
> > > > > > become compatible with the openssl_tpm2_engine, which would pro=
vide a
> > > > > > workaround. This wouldn't work with OP-TEE-based trusted keys (=
see
> > > > > > Sumit Garg's series), though.
> > > > >
> > > > > Assuming OP-TEE has the same use model as the TPM, someone will
> > > > > eventually realise the need for interoperable key formats between=
 key
> > > > > consumers and then it will work in the same way once the kernel g=
ets
> > > > > updated to speak whatever format they come up with.
> > > >
> > > > IIUC, James re-work for TPM trusted keys is to allow loading of sea=
led
> > > > trusted keys directly via user-space (with proper authorization) in=
to
> > > > the kernel keyring.
> > > >
> > > > I think similar should be achievable with OP-TEE (via extending pse=
udo
> > > > TA [1]) as well to allow restricted user-space access (with proper
> > > > authorization) to generate sealed trusted key blob that should be
> > > > interoperable with the kernel. Currently OP-TEE exposes trusted key
> > > > interfaces for kernel users only.
> > >
> > > What is the security benefit of having the key blob creation in user-=
space
> > > instead of in the kernel? Key import is a standard operation in HSMs =
or PKCS#11
> > > tokens.
> >
> > User authentication, AFAIK most of the HSMs or PKCS#11 require that
> > for key import. But IIUC, your suggested approach to load plain key
> > into kernel keyring and say it's *trusted* without any user
> > authentication, would it really be a trusted key? What prevents a
> > rogue user from making his key as the dm-crypt trusted key?
>
> There is user authentication at the level of key rings. So an untrusted u=
ser
> cannot load or link keys they have no write permission for.

Here, I meant user authentication to the trust source (TPM or a TEE)
which provides assurance for a key to be trusted. So what happens in
case of user-space compromises (an untrusted user gaining root
access)?

>
> As we already have user type keys, which don't have these restrictions an=
d are
> accepted by most subsystems, any use of kernel keyrings must already make=
 sure
> that the proper keys are used.
>

The major value add of trusted keys over user keys is this trust
assurance provided by the underlying trust source.

>
> With asymmetric keys we have trusted key *rings*:
> # keyctl show %:.secondary_trusted_keys
> Keyring
>  638775388 ---lswrv      0     0  keyring: .secondary_trusted_keys
> 1071890135 ---lswrv      0     0   \_ keyring: .builtin_trusted_keys
>  816294887 ---lswrv      0     0       \_ asymmetric: Debian Secure Boot =
CA: 6ccece7e4c6c0d1f6149f3dd27dfcc5cbb419ea1
>  630436721 ---lswrv      0     0       \_ asymmetric: Debian Secure Boot =
Signer 2020: 00b55eb3b9
> Here, a key is trusted because of it's presence in a keyring, not because=
 it has
> a specific type. For example, fs-verity uses this mechanism as well.
>
>
> For the trusted key *type*, my understanding is that trusted refers to on=
ly
> being able to load and access them in specific "trusted" system states (v=
ia TPM
> PRC, TEE initialization via secure boot or SoC specific hardware status c=
hecks).
> So for example protecting against loading a data-encryption key into an u=
nsigned
> kernel.

Along with that trusted keys assures protection against any
unauthorized user access to plain key payload.

>
> > > I mainly see the downside of having to add another API to access the =
underlying
> > > functionality (be it trusted key TA or the NXP CAAM HW *) and requiri=
ng
> > > platform-specific userspace code.
> >
> > I am not sure why you would call the standardized TEE interface [1] to
> > be platform-specific, it is meant to be platform agnostic. And I think
> > we can have openssl_tee_engine on similar lines as the
> > openssl_tpm2_engine.
>
> Sorry, I meant platform-specific in the sense that some platforms use TPM=
s,
> while others use TEEs. The trusted key type was also suggested several ti=
mes as
> the correct abstraction for SoC-specific key encapsulation hardware (inst=
ead of
> custom interfaces), so there will likely be platforms which don't have a =
TPM or
> TEE, but still trusted keys.
>

Agree and for that particular reason we are trying to add an
abstraction layer in trusted keys subsystem so that other trust
sources apart from TPM or TEE can be supported as well.

-Sumit

> Regards
> Jan
>
> > [1] https://globalplatform.org/specs-library/tee-client-api-specificati=
on/
> >
>
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
