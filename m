Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D86AF6827F4
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Jan 2023 10:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232046AbjAaJC0 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Jan 2023 04:02:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbjAaJCG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Jan 2023 04:02:06 -0500
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EAC4C0FC;
        Tue, 31 Jan 2023 00:58:31 -0800 (PST)
Received: by mail-pj1-f45.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so13813842pjl.0;
        Tue, 31 Jan 2023 00:58:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BX0UGZfxPS8os5colbRVKgpsLWa69is39Zj4v+JhyhE=;
        b=ly0D4nk2P9aSK/sJZkoo1mEiXcBf0LFW4bUt/kneiPrTebL8wpsmv3JyKC3mn5ZVSP
         YAkI1sOsbu3zOFiVT1ODfpFPx1hmgIrnj7I07uLcxggNAod//gU5VDQu2iteHd2ZtCS2
         zf1HLto4/d2h/Wl8DB9NNJGMC43ucjEfGWTqpMmL/czk4oMCb+9F8YN0gUkXO7i9zA55
         l0gf7ZJmgqyf5zUvkDjYgtXEqOJbsV4dIlMXpAp6mvPndLtPLpMU3BXQyfaRr6OEXmr9
         yqwrXQUX+VPe1TtubHYWSvA5DdmFJWfnuJVKxWZbuTdd9bOi/T1Fw29npIpCR5tq7AGz
         NZEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BX0UGZfxPS8os5colbRVKgpsLWa69is39Zj4v+JhyhE=;
        b=frSDO1pHj/azoteBLAWNSZwf1lKuIM/46E4o7z5vy39EYq++JoFe65Yf6slk7BKuHj
         Xk94f/mdnxfSkSkCVzQu1OL9jioy0kI2FLi7CiszAwJbQXNLlTRbPxcq0zJbp32mzyET
         Si96c2z7lCBpA6N/DNtWd9633WKt+GepkytBaM70V0fn57B1XgBan3pB8951xWTYa+sq
         5rBcb2ElzmoBm6wn9Mc9r/9ZNCv4Z5kI4SZJYx9hDOMwc/xIXequaDTqDjnnJ9VsD4SM
         9YUaiUCU4M9vf5f711DQ1JTRT6SfSoLZEbAre9+BwH3zfINIfPQudJxGL+b/KdCTdBst
         N6zg==
X-Gm-Message-State: AO0yUKWEwlDY0glwuxqloH6G+rb2QxCNaPMmSZDvDb1YAPPIDidS5ppJ
        JzNDZUTr/c1kIf3XlmKeJ0c=
X-Google-Smtp-Source: AK7set/bgmw4FQVYher8ierqKhzmTrpUi6hwBXZSwOO5OSdUlvgGYSEN6+dlGxNHjZixrCuy4IITLg==
X-Received: by 2002:a05:6a20:7f90:b0:be:9fff:48e2 with SMTP id d16-20020a056a207f9000b000be9fff48e2mr6572327pzj.39.1675155366415;
        Tue, 31 Jan 2023 00:56:06 -0800 (PST)
Received: from localhost ([203.194.37.234])
        by smtp.gmail.com with ESMTPSA id q15-20020a056a00150f00b00593e84f2d08sm1303203pfu.52.2023.01.31.00.56.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 00:56:05 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 31 Jan 2023 18:55:58 +1000
Message-Id: <CQ690JS6Q5RG.8KHL6V7BODI0@bobo>
Cc:     <sudhakar@linux.ibm.com>, <bgray@linux.ibm.com>,
        <erichte@linux.ibm.com>, <gregkh@linuxfoundation.org>,
        <nayna@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
        <zohar@linux.ibm.com>, <gjoyce@linux.ibm.com>, <ruscur@russell.cc>,
        <gcwilson@linux.ibm.com>, <joel@jms.id.au>
Subject: Re: [PATCH v4 22/24] powerpc/pseries: Implement secvars for dynamic
 secure boot
From:   "Nicholas Piggin" <npiggin@gmail.com>
To:     "Andrew Donnellan" <ajd@linux.ibm.com>,
        <linuxppc-dev@lists.ozlabs.org>, <linux-integrity@vger.kernel.org>
X-Mailer: aerc 0.13.0
References: <20230120074306.1326298-1-ajd@linux.ibm.com>
 <20230120074306.1326298-23-ajd@linux.ibm.com>
 <CQ05ZDYG6KNU.1G9O3ITQDIHEM@bobo>
 <9f16d86e855f22823ee24e6a6236a16556425f29.camel@linux.ibm.com>
In-Reply-To: <9f16d86e855f22823ee24e6a6236a16556425f29.camel@linux.ibm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue Jan 31, 2023 at 12:54 PM AEST, Andrew Donnellan wrote:
> On Tue, 2023-01-24 at 15:17 +1000, Nicholas Piggin wrote:
> > > +static const char * const plpks_var_names[] =3D {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"PK",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"KEK",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"db",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"dbx",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"grubdb",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"grubdbx",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"sbat",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"moduledb",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0"trustedcadb",
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0NULL,
> > > +};
> >=20
> > Var and key are used somewhat interchangeably? These are keys, I
> > think?
> > And plpks could have other vars but we're only interested in (at
> > least a
> > subset of) keys here if I understood right.
> >=20
> > I guess the terminology is like that throughout secvar so maybe
> > nothing
> > to be done.
>
> The "key" terminology seems to come from OPAL, while on the PLPKS side
> it's a bit of a mess but "var" follows the usage in existing code (the
> spec refers more to "objects").
>
> >=20
> > > +
> > > +static int plpks_get_variable(const char *key, u64 key_len, u8
> > > *data,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 *data_size)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct plpks_var var =3D {=
0};
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int rc =3D 0;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0var.name =3D kcalloc(key_l=
en - 1, sizeof(wchar_t),
> > > GFP_KERNEL);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!var.name)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return -ENOMEM;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D utf8s_to_utf16s(key=
, key_len - 1, UTF16_LITTLE_ENDIAN,
> > > (wchar_t *)var.name,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 key_len - 1);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc < 0)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto err;
> >=20
> > Okay I can't work out why it's key_len - 1 rather than key_len.
>
> The existing code in secvar-sysfs.c calls secvar_ops->get() with
> key_len =3D strlen(name) + 1, to include the null byte, which is what
> OPAL expects. For PLPKS, the variable name explicitly does not include
> a trailing null byte.
>
> I'll add a comment indicating as such, perhaps at some later point it
> can be reworked.
>
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0var.namelen =3D rc * 2;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0var.os =3D PLPKS_VAR_LINUX=
;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (data) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0var.data =3D data;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0var.datalen =3D *data_size;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0rc =3D plpks_read_os_var(&=
var);
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc)
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0goto err;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0*data_size =3D var.datalen=
;
> > > +
> > > +err:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0kfree(var.name);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (rc && rc !=3D -ENOENT)=
 {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0pr_err("Failed to read variable '%s': %d\n", key,
> > > rc);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0// Return -EIO since userspace probably doesn't
> > > care about the
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0// specific error
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0rc =3D -EIO;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return rc;
> > > +}
> > > +
> > > +static int plpks_set_variable(const char *key, u64 key_len, u8
> > > *data,
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 u64 data_size)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct plpks_var var =3D {=
0};
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int rc =3D 0;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u64 flags;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0// Secure variables need t=
o be prefixed with 8 bytes of
> > > flags.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0// We only want to perform=
 the write if we have at least
> > > one byte of data.
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (data_size <=3D sizeof(=
flags))
> >=20
> > So it's unstructured 8 byte of flags, not a u64 integer? Why not u8
> > flags[8] then?
>
> No, it's a u64 and it's passed in the hcall as a single u64.

In host endian? This is done so userspace can acces it with the existing
secvar API, right? I suppose that's okay...

> > > +static ssize_t plpks_secvar_format(char *buf, size_t bufsize)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct plpks_var var =3D {=
0};
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ssize_t ret;
> > > +
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0var.component =3D NULL;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0// Only the signed variabl=
es have null bytes in their
> > > names, this one doesn't
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0var.name =3D "SB_VERSION";
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0var.namelen =3D 10;
> >=20
> > Could you make that strlen(var.name) for the benefit of those of us
> > with
> > missing fingers?
>
> Will do.
>
> >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0var.datalen =3D 1;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0var.data =3D kzalloc(1, GF=
P_KERNEL);
> >=20
> > This could just point to a u8 on stack I think?
>
> Until we get VMAP_STACK and we'll have to switch back.

AFAIKS plpks_read_var does not require linear map, so should not be
required. IMO that's the right way to go for an external API, so
actually plpks_write_var is the outlier there and should be changed
to follow read and remove in not requiring special pointers.

Thanks,
Nick
