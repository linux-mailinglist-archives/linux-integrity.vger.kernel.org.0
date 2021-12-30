Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D1F481B3E
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Dec 2021 11:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238405AbhL3KHf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Dec 2021 05:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238394AbhL3KHf (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Dec 2021 05:07:35 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B60C06173F
        for <linux-integrity@vger.kernel.org>; Thu, 30 Dec 2021 02:07:34 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id g26so53401158lfv.11
        for <linux-integrity@vger.kernel.org>; Thu, 30 Dec 2021 02:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y2r0cp9Q58C0UEpzrCt7tywmDIYPqgZP7Xk2lCBwGtA=;
        b=wdOYggjIJQXvNSyzXqNSG+KlaJgZbQ7gdLj6snPVFIUSgl4qfZxhfD8LihtO0H4hEb
         1DlzBj7Rag48FQwoZ9x5yptFDJ8YaYitRztaJiu0NUFqDphyJOgPHN8sMzBMLRh/45Fr
         WYaS66rldAEtD8bRIQxb+LX4/R9PpTO+XkF3/VxwG0F2puyEv46MtaXyG0FNgfQGgeaN
         ZwePC1Rfo/aw9YZvTV4TGLSkOhMApgNOr0HtNGtsCfIlqvuoq4ZaABM2cbzFCL+gzCKA
         waohGQ/61m3vInsjSJ4AGF8ohrh2e4zHZZtISurU2Ae5GI3zQ4hqayDEhDC0I1j2lJZr
         8PvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y2r0cp9Q58C0UEpzrCt7tywmDIYPqgZP7Xk2lCBwGtA=;
        b=bara4Opl+T4M5dZ1Zg3WURF2KMnEV8DKmoj57xFYxUaRhkUal9AGPySGeWvMKv+AMi
         B7wlrs2n9S64wFSnVbh19/9VuuK+I9rNwRqBO4jgftLt/XtcsmSoo6pcIQr3RUmjdUOw
         ejw2Q7CWxD1Y+9eA5FbCfVIm4UsWTcJUBGmTQuKKn5ETVvv7wuDyoLKMYmxgTgggKsV1
         84oARK8N3u92BdAsLEG3+Hliyd2XTlSzgWWIcUgGEs1bFKnPqmrIm6jvIJzDYdOLA6sA
         dDtMPgMSbc5rb9kNU/s2VtyT91tnWGbVh35Lq9FEe2TIekSJiCPAX6O2PLVNE/4mIYU4
         IZtQ==
X-Gm-Message-State: AOAM533jdMd6AjZPgdfghgzNRKzIrVLWOo4iXaCmXqaUPZ4aeK5iScp2
        gDQPhESCOJFCJSbhnWPlbNnTZaeQVI3UzNQT+w3AvA==
X-Google-Smtp-Source: ABdhPJzwvx3yAmFvYGAtBvjM0hScB/3YP6XsIe2C4/v2q2cYLlASVHMq6MKUQHeAGsJEjRS/kcngHlJMCCKJHo5DRQ0=
X-Received: by 2002:a05:6512:40d:: with SMTP id u13mr26631160lfk.327.1640858852765;
 Thu, 30 Dec 2021 02:07:32 -0800 (PST)
MIME-Version: 1.0
References: <20211229215330.4134835-1-yaelt@google.com>
In-Reply-To: <20211229215330.4134835-1-yaelt@google.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 30 Dec 2021 15:37:21 +0530
Message-ID: <CAFA6WYPuPHgcnzt6j+Q-EA2Dos6vBDukrjpheo5srLVXFrifEg@mail.gmail.com>
Subject: Re: [PATCH v4] KEYS: encrypted: Instantiate key with user-provided
 decrypted data
To:     Yael Tiomkin <yaelt@google.com>
Cc:     linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        jarkko@kernel.org, zohar@linux.ibm.com, corbet@lwn.net,
        dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com,
        keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        =?UTF-8?Q?Jan_L=C3=BCbbe?= <jlu@pengutronix.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

+ Jan, Ahmad

On Thu, 30 Dec 2021 at 03:24, Yael Tiomkin <yaelt@google.com> wrote:
>
> The encrypted.c class supports instantiation of encrypted keys with
> either an already-encrypted key material, or by generating new key
> material based on random numbers. This patch defines a new datablob
> format: [<format>] <master-key name> <decrypted data length>
> <decrypted data> that allows to instantiate encrypted keys using
> user-provided decrypted data, and therefore allows to perform key
> encryption from userspace. The decrypted key material will be
> inaccessible from userspace.

This type of user-space key import feature has already been discussed
at large in the context of trusted keys here [1]. So what makes it
special in case of encrypted keys such that it isn't a "UNSAFE_IMPORT"
or "DEBUGGING_IMPORT" or "DEVELOPMENT_IMPORT", ...?

[1] https://lore.kernel.org/linux-integrity/74830d4f-5a76-8ba8-aad0-0d79f7c=
01af9@pengutronix.de/

-Sumit

>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Yael Tiomkin <yaelt@google.com>
> ---
>
> Notes:
>     v -> v2: fixed compilation error.
>
>     v2 -> v3: modified documentation.
>
>     v3 -> v4: modified commit message.
>
>  .../security/keys/trusted-encrypted.rst       | 25 ++++++--
>  security/keys/encrypted-keys/encrypted.c      | 62 +++++++++++++------
>  2 files changed, 63 insertions(+), 24 deletions(-)
>
> diff --git a/Documentation/security/keys/trusted-encrypted.rst b/Document=
ation/security/keys/trusted-encrypted.rst
> index 80d5a5af62a1..f614dad7de12 100644
> --- a/Documentation/security/keys/trusted-encrypted.rst
> +++ b/Documentation/security/keys/trusted-encrypted.rst
> @@ -107,12 +107,13 @@ Encrypted Keys
>  --------------
>
>  Encrypted keys do not depend on a trust source, and are faster, as they =
use AES
> -for encryption/decryption. New keys are created from kernel-generated ra=
ndom
> -numbers, and are encrypted/decrypted using a specified =E2=80=98master=
=E2=80=99 key. The
> -=E2=80=98master=E2=80=99 key can either be a trusted-key or user-key typ=
e. The main disadvantage
> -of encrypted keys is that if they are not rooted in a trusted key, they =
are only
> -as secure as the user key encrypting them. The master user key should th=
erefore
> -be loaded in as secure a way as possible, preferably early in boot.
> +for encryption/decryption. New keys are created either from kernel-gener=
ated
> +random numbers or user-provided decrypted data, and are encrypted/decryp=
ted
> +using a specified =E2=80=98master=E2=80=99 key. The =E2=80=98master=E2=
=80=99 key can either be a trusted-key or
> +user-key type. The main disadvantage of encrypted keys is that if they a=
re not
> +rooted in a trusted key, they are only as secure as the user key encrypt=
ing
> +them. The master user key should therefore be loaded in as secure a way =
as
> +possible, preferably early in boot.
>
>
>  Usage
> @@ -199,6 +200,8 @@ Usage::
>
>      keyctl add encrypted name "new [format] key-type:master-key-name key=
len"
>          ring
> +    keyctl add encrypted name "new [format] key-type:master-key-name key=
len
> +        decrypted-data" ring
>      keyctl add encrypted name "load hex_blob" ring
>      keyctl update keyid "update key-type:master-key-name"
>
> @@ -303,6 +306,16 @@ Load an encrypted key "evm" from saved blob::
>      82dbbc55be2a44616e4959430436dc4f2a7a9659aa60bb4652aeb2120f149ed197c5=
64e0
>      24717c64 5972dcb82ab2dde83376d82b2e3c09ffc
>
> +Instantiate an encrypted key "evm" using user-provided decrypted data::
> +
> +    $ keyctl add encrypted evm "new default user:kmk 32 `cat evm_decrypt=
ed_data.blob`" @u
> +    794890253
> +
> +    $ keyctl print 794890253
> +    default user:kmk 32 2375725ad57798846a9bbd240de8906f006e66c03af53b1b=
382d
> +    bbc55be2a44616e4959430436dc4f2a7a9659aa60bb4652aeb2120f149ed197c564e=
0247
> +    17c64 5972dcb82ab2dde83376d82b2e3c09ffc
> +
>  Other uses for trusted and encrypted keys, such as for disk and file enc=
ryption
>  are anticipated.  In particular the new format 'ecryptfs' has been defin=
ed
>  in order to use encrypted keys to mount an eCryptfs filesystem.  More de=
tails
> diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/enc=
rypted-keys/encrypted.c
> index 87432b35d771..baf6fba5e05e 100644
> --- a/security/keys/encrypted-keys/encrypted.c
> +++ b/security/keys/encrypted-keys/encrypted.c
> @@ -159,6 +159,7 @@ static int valid_master_desc(const char *new_desc, co=
nst char *orig_desc)
>   *
>   * datablob format:
>   * new [<format>] <master-key name> <decrypted data length>
> + * new [<format>] <master-key name> <decrypted data length> <decrypted d=
ata>
>   * load [<format>] <master-key name> <decrypted data length>
>   *     <encrypted iv + data>
>   * update <new-master-key name>
> @@ -170,7 +171,7 @@ static int valid_master_desc(const char *new_desc, co=
nst char *orig_desc)
>   */
>  static int datablob_parse(char *datablob, const char **format,
>                           char **master_desc, char **decrypted_datalen,
> -                         char **hex_encoded_iv)
> +                         char **hex_encoded_iv, char **decrypted_data)
>  {
>         substring_t args[MAX_OPT_ARGS];
>         int ret =3D -EINVAL;
> @@ -231,6 +232,8 @@ static int datablob_parse(char *datablob, const char =
**format,
>                                 "when called from .update method\n", keyw=
ord);
>                         break;
>                 }
> +               *decrypted_data =3D strsep(&datablob, " \t");
> +
>                 ret =3D 0;
>                 break;
>         case Opt_load:
> @@ -595,7 +598,8 @@ static int derived_key_decrypt(struct encrypted_key_p=
ayload *epayload,
>  static struct encrypted_key_payload *encrypted_key_alloc(struct key *key=
,
>                                                          const char *form=
at,
>                                                          const char *mast=
er_desc,
> -                                                        const char *data=
len)
> +                                                        const char *data=
len,
> +                                                        const char *decr=
ypted_data)
>  {
>         struct encrypted_key_payload *epayload =3D NULL;
>         unsigned short datablob_len;
> @@ -604,6 +608,7 @@ static struct encrypted_key_payload *encrypted_key_al=
loc(struct key *key,
>         unsigned int encrypted_datalen;
>         unsigned int format_len;
>         long dlen;
> +       int i;
>         int ret;
>
>         ret =3D kstrtol(datalen, 10, &dlen);
> @@ -613,6 +618,20 @@ static struct encrypted_key_payload *encrypted_key_a=
lloc(struct key *key,
>         format_len =3D (!format) ? strlen(key_format_default) : strlen(fo=
rmat);
>         decrypted_datalen =3D dlen;
>         payload_datalen =3D decrypted_datalen;
> +
> +       if (decrypted_data) {
> +               if (strlen(decrypted_data) !=3D decrypted_datalen) {
> +                       pr_err("encrypted key: decrypted data provided do=
es not match decrypted data length provided\n");
> +                       return ERR_PTR(-EINVAL);
> +               }
> +               for (i =3D 0; i < strlen(decrypted_data); i++) {
> +                       if (!isalnum(decrypted_data[i])) {
> +                               pr_err("encrypted key: decrypted data pro=
vided must be alphanumeric\n");
> +                               return ERR_PTR(-EINVAL);
> +                       }
> +               }
> +       }
> +
>         if (format) {
>                 if (!strcmp(format, key_format_ecryptfs)) {
>                         if (dlen !=3D ECRYPTFS_MAX_KEY_BYTES) {
> @@ -740,13 +759,14 @@ static void __ekey_init(struct encrypted_key_payloa=
d *epayload,
>  /*
>   * encrypted_init - initialize an encrypted key
>   *
> - * For a new key, use a random number for both the iv and data
> - * itself.  For an old key, decrypt the hex encoded data.
> + * For a new key, use either a random number or user-provided decrypted =
data in
> + * case it is provided. A random number is used for the iv in both cases=
. For
> + * an old key, decrypt the hex encoded data.
>   */
>  static int encrypted_init(struct encrypted_key_payload *epayload,
>                           const char *key_desc, const char *format,
>                           const char *master_desc, const char *datalen,
> -                         const char *hex_encoded_iv)
> +                         const char *hex_encoded_iv, const char *decrypt=
ed_data)
>  {
>         int ret =3D 0;
>
> @@ -760,21 +780,26 @@ static int encrypted_init(struct encrypted_key_payl=
oad *epayload,
>         }
>
>         __ekey_init(epayload, format, master_desc, datalen);
> -       if (!hex_encoded_iv) {
> -               get_random_bytes(epayload->iv, ivsize);
> -
> -               get_random_bytes(epayload->decrypted_data,
> -                                epayload->decrypted_datalen);
> -       } else
> +       if (hex_encoded_iv) {
>                 ret =3D encrypted_key_decrypt(epayload, format, hex_encod=
ed_iv);
> +       } else if (decrypted_data) {
> +               get_random_bytes(epayload->iv, ivsize);
> +               memcpy(epayload->decrypted_data, decrypted_data,
> +                               epayload->decrypted_datalen);
> +       } else {
> +               get_random_bytes(epayload->iv, ivsize);
> +               get_random_bytes(epayload->decrypted_data, epayload->decr=
ypted_datalen);
> +       }
>         return ret;
>  }
>
>  /*
>   * encrypted_instantiate - instantiate an encrypted key
>   *
> - * Decrypt an existing encrypted datablob or create a new encrypted key
> - * based on a kernel random number.
> + * Instantiates the key:
> + * - by decrypting an existing encrypted datablob, or
> + * - by creating a new encrypted key based on a kernel random number, or
> + * - using provided decrypted data.
>   *
>   * On success, return 0. Otherwise return errno.
>   */
> @@ -787,6 +812,7 @@ static int encrypted_instantiate(struct key *key,
>         char *master_desc =3D NULL;
>         char *decrypted_datalen =3D NULL;
>         char *hex_encoded_iv =3D NULL;
> +       char *decrypted_data =3D NULL;
>         size_t datalen =3D prep->datalen;
>         int ret;
>
> @@ -799,18 +825,18 @@ static int encrypted_instantiate(struct key *key,
>         datablob[datalen] =3D 0;
>         memcpy(datablob, prep->data, datalen);
>         ret =3D datablob_parse(datablob, &format, &master_desc,
> -                            &decrypted_datalen, &hex_encoded_iv);
> +                            &decrypted_datalen, &hex_encoded_iv, &decryp=
ted_data);
>         if (ret < 0)
>                 goto out;
>
>         epayload =3D encrypted_key_alloc(key, format, master_desc,
> -                                      decrypted_datalen);
> +                                      decrypted_datalen, decrypted_data)=
;
>         if (IS_ERR(epayload)) {
>                 ret =3D PTR_ERR(epayload);
>                 goto out;
>         }
>         ret =3D encrypted_init(epayload, key->description, format, master=
_desc,
> -                            decrypted_datalen, hex_encoded_iv);
> +                            decrypted_datalen, hex_encoded_iv, decrypted=
_data);
>         if (ret < 0) {
>                 kfree_sensitive(epayload);
>                 goto out;
> @@ -860,7 +886,7 @@ static int encrypted_update(struct key *key, struct k=
ey_preparsed_payload *prep)
>
>         buf[datalen] =3D 0;
>         memcpy(buf, prep->data, datalen);
> -       ret =3D datablob_parse(buf, &format, &new_master_desc, NULL, NULL=
);
> +       ret =3D datablob_parse(buf, &format, &new_master_desc, NULL, NULL=
, NULL);
>         if (ret < 0)
>                 goto out;
>
> @@ -869,7 +895,7 @@ static int encrypted_update(struct key *key, struct k=
ey_preparsed_payload *prep)
>                 goto out;
>
>         new_epayload =3D encrypted_key_alloc(key, epayload->format,
> -                                          new_master_desc, epayload->dat=
alen);
> +                                          new_master_desc, epayload->dat=
alen, NULL);
>         if (IS_ERR(new_epayload)) {
>                 ret =3D PTR_ERR(new_epayload);
>                 goto out;
> --
> 2.34.1.448.ga2b2bfdf31-goog
>
