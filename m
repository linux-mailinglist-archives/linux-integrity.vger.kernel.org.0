Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE48448DDF8
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jan 2022 20:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237796AbiAMTB6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jan 2022 14:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234896AbiAMTB6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jan 2022 14:01:58 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2C8C06173E
        for <linux-integrity@vger.kernel.org>; Thu, 13 Jan 2022 11:01:57 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id d7so17799852ybo.5
        for <linux-integrity@vger.kernel.org>; Thu, 13 Jan 2022 11:01:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=s7no2mwVnA8Y80ATpS2yfSJHmaemb43/gEhIUgG9MmM=;
        b=gPCx5wOTSGBrerJ3v9PTzZCXk8wTYnMG0lJySi/8uJGluds5qYvAPEg9ZeyOqPDb59
         dFGNzcjpQxJ4Beh1LKBzocOKeH5m5Bj1mlhwE4i0HWTwS2NX/Vtt8xsaJX17s8lUA8ij
         2HVwFi9hd0KM+ME0XvPem16FvjYPtR/Fg1ovfKBfhGkv7XT17UmewT0saNB/mloNrIDq
         HkoZr13GL4wP98jRgZgwu9G80UFvWFCU4aFwqMV+wClPqJSKl3oKCslNwqDZesFYrR3s
         AdNtvwEUDMbFQ0c3YzeEg6EDqq+8FhscNHklN5kbycsJ+CA3b4023govT5tYJ6V+0/cg
         oP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=s7no2mwVnA8Y80ATpS2yfSJHmaemb43/gEhIUgG9MmM=;
        b=GRX12jvY/V9hrG7oNzBkizI6Qw9++mwtO6i2c3LoXa1PDPzIezSEkpLk43i/MXyOSK
         +dJ2YJu+A6WnjcO08jYwui6Rjs8zhkifFh18Ck4vYHC430HpB3Lknb0i4DgmQDeCh7/y
         Bw1q4TkTmv9ffIhCkmO1Bm/O6cTYR4CU4ugdlYLZ3HHS4iKnAlc/VIFqUmDFeU6gJxKV
         5bXe81Bf1DG+O25CwNLTUEj6RgAKORKZB0BmeOJ/NZJfdCnENuDEEQYD0Zo5clOkGCZH
         ap/3byE3qenp1W9p2tGKL4CEXIjGyS41sIPoHZPqqqEO4534i5EUaEfEZ3zBZW7wEH0V
         qZlg==
X-Gm-Message-State: AOAM531r6CSl3w/+7UIxwfzAe0hKAvmiLwUZF+P9NYzMnmwJdq06Ixz/
        jd3uDve+BWhrR1slAqJsI4oE2AA9jWiApq23Y9aY/ZtYKF9pUw==
X-Google-Smtp-Source: ABdhPJzFSwMgP9xhJ00b311ltVFfDwnHYMUk0+UKogKKtjb52j2BhgejGEbBcjDESWOu8l8hrlRkET+Vm1i+5/lRWhA=
X-Received: by 2002:a25:bbc7:: with SMTP id c7mr7138512ybk.725.1642100516241;
 Thu, 13 Jan 2022 11:01:56 -0800 (PST)
MIME-Version: 1.0
References: <20211229215330.4134835-1-yaelt@google.com> <e29dc7de-b656-7c27-2294-fb4936e99e69@linux.vnet.ibm.com>
In-Reply-To: <e29dc7de-b656-7c27-2294-fb4936e99e69@linux.vnet.ibm.com>
From:   Yael Tiomkin <yaelt@google.com>
Date:   Thu, 13 Jan 2022 14:01:45 -0500
Message-ID: <CAKoutNspnn-VuKsxODYdX4P68vCpRveRFG=FKCVG9Vu-vev4fg@mail.gmail.com>
Subject: Re: [PATCH v4] KEYS: encrypted: Instantiate key with user-provided
 decrypted data
To:     Nayna <nayna@linux.vnet.ibm.com>
Cc:     linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>, corbet@lwn.net,
        dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com,
        keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Jan 10, 2022 at 11:04 AM Nayna <nayna@linux.vnet.ibm.com> wrote:
>
>
> On 12/29/21 16:53, Yael Tiomkin wrote:
> > The encrypted.c class supports instantiation of encrypted keys with
> > either an already-encrypted key material, or by generating new key
> > material based on random numbers. This patch defines a new datablob
> > format: [<format>] <master-key name> <decrypted data length>
> > <decrypted data> that allows to instantiate encrypted keys using
> > user-provided decrypted data, and therefore allows to perform key
> > encryption from userspace. The decrypted key material will be
> > inaccessible from userspace.
> >
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > Signed-off-by: Yael Tiomkin <yaelt@google.com>
> > ---
> >
> > Notes:
> >      v -> v2: fixed compilation error.
> >
> >      v2 -> v3: modified documentation.
> >
> >      v3 -> v4: modified commit message.
> >
> >   .../security/keys/trusted-encrypted.rst       | 25 ++++++--
> >   security/keys/encrypted-keys/encrypted.c      | 62 +++++++++++++-----=
-
> >   2 files changed, 63 insertions(+), 24 deletions(-)
> >
> > diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Docume=
ntation/security/keys/trusted-encrypted.rst
> > index 80d5a5af62a1..f614dad7de12 100644
> > --- a/Documentation/security/keys/trusted-encrypted.rst
> > +++ b/Documentation/security/keys/trusted-encrypted.rst
> > @@ -107,12 +107,13 @@ Encrypted Keys
> >   --------------
> >
> >   Encrypted keys do not depend on a trust source, and are faster, as th=
ey use AES
> > -for encryption/decryption. New keys are created from kernel-generated =
random
> > -numbers, and are encrypted/decrypted using a specified =E2=80=98master=
=E2=80=99 key. The
> > -=E2=80=98master=E2=80=99 key can either be a trusted-key or user-key t=
ype. The main disadvantage
> > -of encrypted keys is that if they are not rooted in a trusted key, the=
y are only
> > -as secure as the user key encrypting them. The master user key should =
therefore
> > -be loaded in as secure a way as possible, preferably early in boot.
> > +for encryption/decryption. New keys are created either from kernel-gen=
erated
> > +random numbers or user-provided decrypted data, and are encrypted/decr=
ypted
> > +using a specified =E2=80=98master=E2=80=99 key. The =E2=80=98master=E2=
=80=99 key can either be a trusted-key or
> > +user-key type. The main disadvantage of encrypted keys is that if they=
 are not
> > +rooted in a trusted key, they are only as secure as the user key encry=
pting
> > +them. The master user key should therefore be loaded in as secure a wa=
y as
> > +possible, preferably early in boot.
> >
> >
> >   Usage
> > @@ -199,6 +200,8 @@ Usage::
> >
> >       keyctl add encrypted name "new [format] key-type:master-key-name =
keylen"
> >           ring
> > +    keyctl add encrypted name "new [format] key-type:master-key-name k=
eylen
> > +        decrypted-data" ring
> >       keyctl add encrypted name "load hex_blob" ring
> >       keyctl update keyid "update key-type:master-key-name"
> >
> > @@ -303,6 +306,16 @@ Load an encrypted key "evm" from saved blob::
> >       82dbbc55be2a44616e4959430436dc4f2a7a9659aa60bb4652aeb2120f149ed19=
7c564e0
> >       24717c64 5972dcb82ab2dde83376d82b2e3c09ffc
> >
> > +Instantiate an encrypted key "evm" using user-provided decrypted data:=
:
> > +
> > +    $ keyctl add encrypted evm "new default user:kmk 32 `cat evm_decry=
pted_data.blob`" @u
> > +    794890253
> > +
> > +    $ keyctl print 794890253
> > +    default user:kmk 32 2375725ad57798846a9bbd240de8906f006e66c03af53b=
1b382d
> > +    bbc55be2a44616e4959430436dc4f2a7a9659aa60bb4652aeb2120f149ed197c56=
4e0247
> > +    17c64 5972dcb82ab2dde83376d82b2e3c09ffc
> > +
> >   Other uses for trusted and encrypted keys, such as for disk and file =
encryption
> >   are anticipated.  In particular the new format 'ecryptfs' has been de=
fined
> >   in order to use encrypted keys to mount an eCryptfs filesystem.  More=
 details
> > diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/e=
ncrypted-keys/encrypted.c
> > index 87432b35d771..baf6fba5e05e 100644
> > --- a/security/keys/encrypted-keys/encrypted.c
> > +++ b/security/keys/encrypted-keys/encrypted.c
> > @@ -159,6 +159,7 @@ static int valid_master_desc(const char *new_desc, =
const char *orig_desc)
> >    *
> >    * datablob format:
> >    * new [<format>] <master-key name> <decrypted data length>
> > + * new [<format>] <master-key name> <decrypted data length> <decrypted=
 data>
> >    * load [<format>] <master-key name> <decrypted data length>
> >    *     <encrypted iv + data>
> >    * update <new-master-key name>
> > @@ -170,7 +171,7 @@ static int valid_master_desc(const char *new_desc, =
const char *orig_desc)
> >    */
> >   static int datablob_parse(char *datablob, const char **format,
> >                         char **master_desc, char **decrypted_datalen,
> > -                       char **hex_encoded_iv)
> > +                       char **hex_encoded_iv, char **decrypted_data)
> >   {
> >       substring_t args[MAX_OPT_ARGS];
> >       int ret =3D -EINVAL;
> > @@ -231,6 +232,8 @@ static int datablob_parse(char *datablob, const cha=
r **format,
> >                               "when called from .update method\n", keyw=
ord);
> >                       break;
> >               }
> > +             *decrypted_data =3D strsep(&datablob, " \t");
> > +
> >               ret =3D 0;
> >               break;
> >       case Opt_load:
> > @@ -595,7 +598,8 @@ static int derived_key_decrypt(struct encrypted_key=
_payload *epayload,
> >   static struct encrypted_key_payload *encrypted_key_alloc(struct key *=
key,
> >                                                        const char *form=
at,
> >                                                        const char *mast=
er_desc,
> > -                                                      const char *data=
len)
> > +                                                      const char *data=
len,
> > +                                                      const char *decr=
ypted_data)
> >   {
> >       struct encrypted_key_payload *epayload =3D NULL;
> >       unsigned short datablob_len;
> > @@ -604,6 +608,7 @@ static struct encrypted_key_payload *encrypted_key_=
alloc(struct key *key,
> >       unsigned int encrypted_datalen;
> >       unsigned int format_len;
> >       long dlen;
> > +     int i;
> >       int ret;
> >
> >       ret =3D kstrtol(datalen, 10, &dlen);
> > @@ -613,6 +618,20 @@ static struct encrypted_key_payload *encrypted_key=
_alloc(struct key *key,
> >       format_len =3D (!format) ? strlen(key_format_default) : strlen(fo=
rmat);
> >       decrypted_datalen =3D dlen;
> >       payload_datalen =3D decrypted_datalen;
> > +
> > +     if (decrypted_data) {
> > +             if (strlen(decrypted_data) !=3D decrypted_datalen) {
> > +                     pr_err("encrypted key: decrypted data provided do=
es not match decrypted data length provided\n");
> > +                     return ERR_PTR(-EINVAL);
> > +             }
> > +             for (i =3D 0; i < strlen(decrypted_data); i++) {
> > +                     if (!isalnum(decrypted_data[i])) {
>
> User-provided decrypted data may have special characters, commonly used
> in passwords or key phrases, apart from alphanumeric.  Replace isalnum
> with !iscntrl() to validate against control characters but allow special
> characters.
>
> Thanks & Regards,
>
>       - Nayna
>

Hi Nayna,
I wonder if we should use isprint() instead?

Yael
