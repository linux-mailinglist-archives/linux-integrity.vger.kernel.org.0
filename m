Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1628B4BD5A8
	for <lists+linux-integrity@lfdr.de>; Mon, 21 Feb 2022 07:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344687AbiBUFrm (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Feb 2022 00:47:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbiBUFrk (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Feb 2022 00:47:40 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC66946642
        for <linux-integrity@vger.kernel.org>; Sun, 20 Feb 2022 21:47:16 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id e5so16515997lfr.9
        for <linux-integrity@vger.kernel.org>; Sun, 20 Feb 2022 21:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=JbIYMIikAiiYsMQjvJDTONlx3jkn31Swz54kIVO1y+I=;
        b=LWcPAigwjEjtkFdWJ+l4G0QrdNQAExteK0oZEWbx4n1TjkAmtGfvJngOs/6JTobgtm
         VFEV6amo3LoWGhXPXMkS2eEaJZUCSF25ZL6rS9Fh6StTaLUJRmIOJXNrmoiPBED4rbmJ
         6tskNMtOUlipbcmMMJFtQ/rcJoJjKP/NcQoKA2+dG2pd5kJO8dEP3/xdpo3PGLlGLpNV
         ssNe1OcPhuLSlgReRQDV+ShFLXhkGkT7CtzWIWknSN2Tu3b3fT1/nDTN5QX6mmEH4dd+
         uBAPyd1AjsKwC5kx79hSqylmFLCwQwX2b/kFgdS8hAh1lxuOob/n+ttMDCLp+6HbA0Q8
         St/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=JbIYMIikAiiYsMQjvJDTONlx3jkn31Swz54kIVO1y+I=;
        b=NUSJpHnCv+H68joxQceoCr6d2rrX3GBgBh3PBaSXlRh9+XWAjfxdXIASEXzHt6i86T
         U3Q+LqXWuoAibKphpR6JDaN+C+k1GWzcr/nnS7RJTHv8yzzZ/7za7rJSKj3f5YL+0wnZ
         N4Rvn2NQ6lHSZapXowKvP9gTlJeSC9F6KdSkfoBbA9vRkC2iDE+HKqiJ3bwgc60hDoVx
         jUUn2lkKnL8Yfh1jze0trzf66M9oNkfGetc0faI7NAP2CVONX0JXiYcyPLjgn1DvDI0D
         9akUlm8Ct+gUB5gULsUvGpafXFuPoWURrMQz7RiKAaVg5vh3U5IJp07a6t07xDZJJ1CG
         O8/Q==
X-Gm-Message-State: AOAM532lUwxScrK3mXkDJY98a+665dcrCOGDcIsuc9hJuK7ECzdQuzNN
        XRI94XSK5rQJGqTBksaUPawDNrWh4/1R4LlI9RoFog==
X-Google-Smtp-Source: ABdhPJy8QyE/KB4SvO/vI5uKdsQEEbPLXKsR6TppqPoBJSnmrV2JJ74Z86/Zv369KHatfNd4w38pv9un7/fq/TIaIE8=
X-Received: by 2002:a05:6512:965:b0:443:7340:9893 with SMTP id
 v5-20020a056512096500b0044373409893mr13023446lft.119.1645422434969; Sun, 20
 Feb 2022 21:47:14 -0800 (PST)
MIME-Version: 1.0
References: <20220215141953.1557009-1-yaelt@google.com>
In-Reply-To: <20220215141953.1557009-1-yaelt@google.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 21 Feb 2022 11:17:03 +0530
Message-ID: <CAFA6WYNbfnkwt8jpZET+-t7gQwMV5q2dPHPuuiCPKGUAGf38xA@mail.gmail.com>
Subject: Re: [PATCH v5] KEYS: encrypted: Instantiate key with user-provided
 decrypted data
To:     Yael Tzur <yaelt@google.com>
Cc:     linux-integrity@vger.kernel.org, jejb@linux.ibm.com,
        jarkko@kernel.org, zohar@linux.ibm.com, corbet@lwn.net,
        dhowells@redhat.com, jmorris@namei.org, serge@hallyn.com,
        keyrings@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 15 Feb 2022 at 19:50, Yael Tzur <yaelt@google.com> wrote:
>
> For availability and performance reasons master keys often need to be
> released outside of a Key Management Service (KMS) to clients. It
> would be beneficial to provide a mechanism where the
> wrapping/unwrapping of data encryption keys (DEKs) is not dependent
> on a remote call at runtime yet security is not (or only minimally)
> compromised. Master keys could be securely stored in the Kernel and
> be used to wrap/unwrap keys from Userspace.
>
> The encrypted.c class supports instantiation of encrypted keys with
> either an already-encrypted key material, or by generating new key
> material based on random numbers. This patch defines a new datablob
> format: [<format>] <master-key name> <decrypted data length>
> <decrypted data> that allows to inject and encrypt user-provided
> decrypted data. The decrypted data must be hex-ascii encoded.
>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Yael Tzur <yaelt@google.com>
> ---
>
> Notes:
>     v -> v2: fixed compilation error.
>
>     v2 -> v3: modified documentation.
>
>     v3 -> v4: modified commit message.
>
>     v4 -> v5: added config option to enable feature, and modified input v=
alidation.
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

>  .../security/keys/trusted-encrypted.rst       | 25 +++++--
>  security/keys/Kconfig                         | 19 +++--
>  security/keys/encrypted-keys/encrypted.c      | 72 ++++++++++++++-----
>  3 files changed, 87 insertions(+), 29 deletions(-)
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
> diff --git a/security/keys/Kconfig b/security/keys/Kconfig
> index 969122c7b92f..0e30b361e1c1 100644
> --- a/security/keys/Kconfig
> +++ b/security/keys/Kconfig
> @@ -98,10 +98,21 @@ config ENCRYPTED_KEYS
>         select CRYPTO_RNG
>         help
>           This option provides support for create/encrypting/decrypting k=
eys
> -         in the kernel.  Encrypted keys are kernel generated random numb=
ers,
> -         which are encrypted/decrypted with a 'master' symmetric key. Th=
e
> -         'master' key can be either a trusted-key or user-key type.
> -         Userspace only ever sees/stores encrypted blobs.
> +         in the kernel.  Encrypted keys are instantiated using kernel
> +         generated random numbers or provided decrypted data, and are
> +         encrypted/decrypted with a 'master' symmetric key. The 'master'
> +         key can be either a trusted-key or user-key type. Only encrypte=
d
> +         blobs are ever output to Userspace.
> +
> +         If you are unsure as to whether this is required, answer N.
> +
> +config USER_DECRYPTED_DATA
> +       bool "Allow encrypted keys with user decrypted data"
> +       depends on ENCRYPTED_KEYS
> +       help
> +         This option provides support for instantiating encrypted keys u=
sing
> +         user-provided decrypted data.  The decrypted data must be hex-a=
scii
> +         encoded.
>
>           If you are unsure as to whether this is required, answer N.
>
> diff --git a/security/keys/encrypted-keys/encrypted.c b/security/keys/enc=
rypted-keys/encrypted.c
> index 87432b35d771..ebfb8129fb92 100644
> --- a/security/keys/encrypted-keys/encrypted.c
> +++ b/security/keys/encrypted-keys/encrypted.c
> @@ -78,6 +78,11 @@ static const match_table_t key_tokens =3D {
>         {Opt_err, NULL}
>  };
>
> +static bool user_decrypted_data =3D IS_ENABLED(CONFIG_USER_DECRYPTED_DAT=
A);
> +module_param(user_decrypted_data, bool, 0);
> +MODULE_PARM_DESC(user_decrypted_data,
> +       "Allow instantiation of encrypted keys using provided decrypted d=
ata");
> +
>  static int aes_get_sizes(void)
>  {
>         struct crypto_skcipher *tfm;
> @@ -158,7 +163,7 @@ static int valid_master_desc(const char *new_desc, co=
nst char *orig_desc)
>   * datablob_parse - parse the keyctl data
>   *
>   * datablob format:
> - * new [<format>] <master-key name> <decrypted data length>
> + * new [<format>] <master-key name> <decrypted data length> [<decrypted =
data>]
>   * load [<format>] <master-key name> <decrypted data length>
>   *     <encrypted iv + data>
>   * update <new-master-key name>
> @@ -170,7 +175,7 @@ static int valid_master_desc(const char *new_desc, co=
nst char *orig_desc)
>   */
>  static int datablob_parse(char *datablob, const char **format,
>                           char **master_desc, char **decrypted_datalen,
> -                         char **hex_encoded_iv)
> +                         char **hex_encoded_iv, char **decrypted_data)
>  {
>         substring_t args[MAX_OPT_ARGS];
>         int ret =3D -EINVAL;
> @@ -231,6 +236,7 @@ static int datablob_parse(char *datablob, const char =
**format,
>                                 "when called from .update method\n", keyw=
ord);
>                         break;
>                 }
> +               *decrypted_data =3D strsep(&datablob, " \t");
>                 ret =3D 0;
>                 break;
>         case Opt_load:
> @@ -595,7 +601,8 @@ static int derived_key_decrypt(struct encrypted_key_p=
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
> @@ -604,6 +611,7 @@ static struct encrypted_key_payload *encrypted_key_al=
loc(struct key *key,
>         unsigned int encrypted_datalen;
>         unsigned int format_len;
>         long dlen;
> +       int i;
>         int ret;
>
>         ret =3D kstrtol(datalen, 10, &dlen);
> @@ -613,6 +620,24 @@ static struct encrypted_key_payload *encrypted_key_a=
lloc(struct key *key,
>         format_len =3D (!format) ? strlen(key_format_default) : strlen(fo=
rmat);
>         decrypted_datalen =3D dlen;
>         payload_datalen =3D decrypted_datalen;
> +
> +       if (decrypted_data) {
> +               if (!user_decrypted_data) {
> +                       pr_err("encrypted key: instantiation of keys usin=
g provided decrypted data is disabled since CONFIG_USER_DECRYPTED_DATA is s=
et to false\n");
> +                       return ERR_PTR(-EINVAL);
> +               }
> +               if (strlen(decrypted_data) !=3D decrypted_datalen) {
> +                       pr_err("encrypted key: decrypted data provided do=
es not match decrypted data length provided\n");
> +                       return ERR_PTR(-EINVAL);
> +               }
> +               for (i =3D 0; i < strlen(decrypted_data); i++) {
> +                       if (!isxdigit(decrypted_data[i])) {
> +                               pr_err("encrypted key: decrypted data pro=
vided must contain only hexadecimal characters\n");
> +                               return ERR_PTR(-EINVAL);
> +                       }
> +               }
> +       }
> +
>         if (format) {
>                 if (!strcmp(format, key_format_ecryptfs)) {
>                         if (dlen !=3D ECRYPTFS_MAX_KEY_BYTES) {
> @@ -740,13 +766,14 @@ static void __ekey_init(struct encrypted_key_payloa=
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
> @@ -760,21 +787,26 @@ static int encrypted_init(struct encrypted_key_payl=
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
> +                                  epayload->decrypted_datalen);
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
> @@ -787,6 +819,7 @@ static int encrypted_instantiate(struct key *key,
>         char *master_desc =3D NULL;
>         char *decrypted_datalen =3D NULL;
>         char *hex_encoded_iv =3D NULL;
> +       char *decrypted_data =3D NULL;
>         size_t datalen =3D prep->datalen;
>         int ret;
>
> @@ -799,18 +832,18 @@ static int encrypted_instantiate(struct key *key,
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
> @@ -860,7 +893,7 @@ static int encrypted_update(struct key *key, struct k=
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
> @@ -869,7 +902,7 @@ static int encrypted_update(struct key *key, struct k=
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
> 2.35.1.265.g69c8d7142f-goog
>
