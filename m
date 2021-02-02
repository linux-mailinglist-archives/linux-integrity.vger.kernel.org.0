Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A51430BE04
	for <lists+linux-integrity@lfdr.de>; Tue,  2 Feb 2021 13:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbhBBMRO (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Feb 2021 07:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbhBBMQl (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Feb 2021 07:16:41 -0500
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39DCC061573
        for <linux-integrity@vger.kernel.org>; Tue,  2 Feb 2021 04:16:00 -0800 (PST)
Received: by mail-lj1-x22b.google.com with SMTP id l12so23691165ljc.3
        for <linux-integrity@vger.kernel.org>; Tue, 02 Feb 2021 04:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0+Zjc9HcGBWe93FYmHXna3X9LqtTp1gTSq6F/T/9fOQ=;
        b=Ll8bykj1dubotak4+Jma/C9Ds62+0a8QWT64VISsd+iFWL7b9eo5BqLc5ah57MFBoy
         Ewa5zURdEWJF2EVI7HsYn2TIDfhAvMgn4R5V3AuIXQBo6FRtuBdGpV4A79SoIbxO7FYt
         bgobei/r1O3bwNigSIwhBIW2HRAfomX5tDF/x2Y4RloPjOLS3q9iUimJMILzG0ppKrwM
         boxG09J88WxBkjnRNVQhkBaNq6Dr02kGqlFhRJ9s3xHbJyL1A+ACtN75dHQjR+Y5wkBt
         VfSlpV+7O4IXe06S/N4OBOPlsDwqPNIqxG7mnaFtBtUN3s+3xH679rclsgZ62nCIyixZ
         C3Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0+Zjc9HcGBWe93FYmHXna3X9LqtTp1gTSq6F/T/9fOQ=;
        b=ZwL44P60+P0rf9duXRKGgh6YNGhqts5R28+j/GKf4GhlCuSUdIJ2M6oZ0Jk+9j0ws0
         l9lNAkerLGMGl3nuDDzWp0x9FDgt7hZn2xt7f0oWBYIMMtq4FazVlyfcrNh1ZvJjkBek
         GAniTwifQUpYv0Eum9fDnADTO8cpUYKpCFaT5Hd2rgPvkv2bzYxYiKRVQIMY5JcqLgzU
         stEzsIlJojinFe80ceDGl1gk7kshPtT+rqw+5zoUNQ3QGFJjZj9lkBrabpoRYnCnzn1Y
         zegPsHu44R8TOm1oA8fMv83m6icGlRsD2lF0osW3UELA4pk1AEpJ/eIncI2Ulz06/mVk
         MMpg==
X-Gm-Message-State: AOAM533RFuA0cn5Y+kH0c02ugTk+LEJJvZmO0uhgLdSw7VnLIj8TyZrM
        pOB3jAO3b8NBlHIM1y9Vd6Fkx675nTJSMLftb0ELKg==
X-Google-Smtp-Source: ABdhPJzpJRdXjQVJfcLJBT0/H51rvfkKNS23o7JY2IArnJy8Z7vu0NVErtpxkoVMKraX7YtN1W8eSqGQw6CTE2C+wjk=
X-Received: by 2002:a2e:804a:: with SMTP id p10mr4560346ljg.226.1612268159081;
 Tue, 02 Feb 2021 04:15:59 -0800 (PST)
MIME-Version: 1.0
References: <74830d4f-5a76-8ba8-aad0-0d79f7c01af9@pengutronix.de>
 <6dc99fd9ffbc5f405c5f64d0802d1399fc6428e4.camel@kernel.org>
 <d1bed49f89495ceb529355cb41655a208fdb2197.camel@linux.ibm.com>
 <8b9477e150d7c939dc0def3ebb4443efcc83cd85.camel@pengutronix.de> <18529562ed71becf21401ec9fd9d95c4ac44fdc0.camel@linux.ibm.com>
In-Reply-To: <18529562ed71becf21401ec9fd9d95c4ac44fdc0.camel@linux.ibm.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 2 Feb 2021 17:45:47 +0530
Message-ID: <CAFA6WYMn519aF=uodjnSUZ+kKaRzdoh6Enu0OsRMge=21iBNBA@mail.gmail.com>
Subject: Re: Migration to trusted keys: sealing user-provided key?
To:     James Bottomley <jejb@linux.ibm.com>,
        =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
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

Hi Jan,

On Sun, 31 Jan 2021 at 23:40, James Bottomley <jejb@linux.ibm.com> wrote:
>
> On Sun, 2021-01-31 at 15:14 +0100, Jan L=C3=BCbbe wrote:
> > On Sun, 2021-01-31 at 07:09 -0500, Mimi Zohar wrote:
> > > On Sat, 2021-01-30 at 19:53 +0200, Jarkko Sakkinen wrote:
> > > > On Thu, 2021-01-28 at 18:31 +0100, Ahmad Fatoum wrote:
> > > > > Hello,
> > > > >
> > > > > I've been looking into how a migration to using
> > > > > trusted/encrypted keys would look like (particularly with dm-
> > > > > crypt).
> > > > >
> > > > > Currently, it seems the the only way is to re-encrypt the
> > > > > partitions because trusted/encrypted keys always generate their
> > > > > payloads from RNG.
> > > > >
> > > > > If instead there was a key command to initialize a new
> > > > > trusted/encrypted key with a user provided value, users could
> > > > > use whatever mechanism they used beforehand to get a plaintext
> > > > > key and use that to initialize a new trusted/encrypted key.
> > > > > From there on, the key will be like any other trusted/encrypted
> > > > > key and not be disclosed again to userspace.
> > > > >
> > > > > What are your thoughts on this? Would an API like
> > > > >
> > > > >   keyctl add trusted dmcrypt-key 'set <content>' # user-
> > > > > supplied content
> > > > >
> > > > > be acceptable?
> > > >
> > > > Maybe it's the lack of knowledge with dm-crypt, but why this
> > > > would be useful? Just want to understand the bottleneck, that's
> > > > all.
> >
> > Our goal in this case is to move away from having the dm-crypt key
> > material accessible to user-space on embedded devices. For an
> > existing dm-crypt volume, this key is fixed. A key can be loaded into
> > user key type and used by dm-crypt (cryptsetup can already do it this
> > way). But at this point, you can still do 'keyctl read' on that key,
> > exposing the key material to user space.
> >
> > Currently, with both encrypted and trusted keys, you can only
> > generate new random keys, not import existing key material.
> >
> > James Bottomley mentioned in the other reply that the key format will
> > become compatible with the openssl_tpm2_engine, which would provide a
> > workaround. This wouldn't work with OP-TEE-based trusted keys (see
> > Sumit Garg's series), though.
>
> Assuming OP-TEE has the same use model as the TPM, someone will
> eventually realise the need for interoperable key formats between key
> consumers and then it will work in the same way once the kernel gets
> updated to speak whatever format they come up with.

IIUC, James re-work for TPM trusted keys is to allow loading of sealed
trusted keys directly via user-space (with proper authorization) into
the kernel keyring.

I think similar should be achievable with OP-TEE (via extending pseudo
TA [1]) as well to allow restricted user-space access (with proper
authorization) to generate sealed trusted key blob that should be
interoperable with the kernel. Currently OP-TEE exposes trusted key
interfaces for kernel users only.

[1] https://github.com/OP-TEE/optee_os/blob/master/ta/trusted_keys/entry.c

-Sumit

>
> > > We upstreamed "trusted" & "encrypted" keys together in order to
> > > address this sort of problem.   Instead of directly using a
> > > "trusted" key for persistent file signatures being stored as
> > > xattrs, the "encrypted" key provides one level of
> > > indirection.   The "encrypted" key may be encrypted/decrypted with
> > > either a TPM based "trusted" key or with a "user" type symmetric
> > > key[1].
> > >
> > > Instead of modifying "trusted" keys, use a "user" type "encrypted"
> > > key.
> >
> > I don't see how this would help. When using dm-crypt with an
> > encrypted key, I can't use my existing key material.
> >
> > Except for the migration aspect, trusted keys seem ideal. Only a
> > single exported blob needs to be stored and can only be loaded/used
> > again on the same (trusted) system. Userspace cannot extract the key
> > material.
>
> Yes, that's what I was thinking ... especially when you can add policy
> to the keys, which includes PCR locking.  Part of the problem is that
> changing policy, which you have to do if something happens to update
> the PCR values, is technically a migration, so your trusted keys for
> dm-crypt are really going to have to be migrateable.
>
> > To get to this point on systems in the field without re-encryption of
> > the whole storage, only the initial trusted/encrypted key creation
> > would need to allow passing in existing key material.
>
> What about a third option: why not make dm-crypt store the master key
> it uses as an encrypted key (if a parent trusted key is available)?
> That way you'd be able to extract the encrypted form of the key as
> root, but wouldn't be able to extract the actual master key.
>
> James
>
>
