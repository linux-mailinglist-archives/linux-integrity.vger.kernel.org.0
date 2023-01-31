Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC702682332
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Jan 2023 05:24:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjAaEYE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Jan 2023 23:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjAaEYD (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Jan 2023 23:24:03 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C0939B97;
        Mon, 30 Jan 2023 20:24:01 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id F00E15C0432;
        Mon, 30 Jan 2023 23:23:58 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 30 Jan 2023 23:23:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1675139038; x=
        1675225438; bh=AgFF+s1pqvfOkBMmvcofZVkXngc67HknL6cuU/nEjoA=; b=Y
        Li3K18G7NPHhEv4WQ0jknPjIcAda5Lb823lV7mB4p16bjHWpwbOZE6jnS67CJxPL
        zWWl7Rh7q3r1CWajVPj7d7JdC3rbN0oZPVFOhGLV34LFLQDmQ04A3c3x4ueuojD4
        jAr6lDlhU6mmIqvYGscQa8IV4PzwHAv2Plpv5SeFjoHcMzFxrnlKptrpKumPUBON
        2YMDRz1aoN+VPTIzNZ+LhEkNKqgVYSzxXJkDlyo8Gz9Ygrll9bqNXjdYb2k4+UJL
        NN5KFl5FmTmRliUJGbeRhSMten2fkYn8NPng5NP/yWTcOAVfeTMRzUixnDW8lo66
        ybsCZvoy0q0p/3FfaMKmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1675139038; x=
        1675225438; bh=AgFF+s1pqvfOkBMmvcofZVkXngc67HknL6cuU/nEjoA=; b=g
        Zj+me40w8LhxXR3pEtyqOY32VkSI/QiokKWdJcye/uF7DwR/lCCoK7kSrh0GaTVw
        WP2w98TnzC4+nG3SWE3L98XpdWBD/BMC6h1QkOkCwsRfUdZ7IRH3u/HmkeclQ49d
        lsNZaAgRi5vjqO6nti7GyZ5EIwpYjvxfR2pGllGY1pEdZjygU+en+uPpuusbXNzw
        UWh5tf3nOG1Md4MkLyNgWciUUWCwcC+L5XCSRAkr/NLDFPl7h+yiRp+jJgryVmt7
        2RgTvD3vwqQK195WPFOEBfnhUmNm6h3ihVBVsvGL5KLTxWGcKaSXFbyJJl6s/6/K
        vzH6k6H8q+bWgtryNWKmg==
X-ME-Sender: <xms:3pfYY-re7ilIVmoI8cfUJNc8Jn3OMEiim6urIdDJaGTYkCBhNzfb7w>
    <xme:3pfYY8pBqSp9FYbeVp5X028XFIjuKcyqRA1oP9ED3AdXwiFTJCjU2sJv135MLvq0i
    3dr5CN4nM8xf9jfmQ>
X-ME-Received: <xmr:3pfYYzPXxAQaA9-Wqs4ddVdbP8grO8MmWGAYOOuqk93fZxoS3yJXUEsNx1veZUqhTy2IddqVMg_osIxrM3lBWtwQBfBjYHw19_-8rTg894tLrg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudeffedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdlfedtmdenucfjughrpefkuffhvfevffgjfhgtgfgfggesthhqredt
    tderjeenucfhrhhomheptfhushhsvghllhcuvehurhhrvgihuceorhhushgtuhhrsehruh
    hsshgvlhhlrdgttgeqnecuggftrfgrthhtvghrnheptefgieelhfeufeevvdekheeifeej
    gfefgeehtedukeeigfduuddtueekteevleelnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomheprhhushgtuhhrsehruhhsshgvlhhlrdgttg
X-ME-Proxy: <xmx:3pfYY97eDsPsH8SYAcjF77vKnWKKsDVQ5nQDwkDMpJba-7RqjhXj1w>
    <xmx:3pfYY94cfJ4bj0enECW_RBnKvA1yyzx_Wsu6ksp_MXHxFvlNhKchrA>
    <xmx:3pfYY9haVp5yNQppUKeczPkALc5vk-L-Hv1U-boDMS4Vsy9o8oWj_w>
    <xmx:3pfYY1wrlzYvGxGRHGYSIATEaw-82xWcqo7ux9bYxgHujkmu8AdFxA>
Feedback-ID: i4421424f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Jan 2023 23:23:54 -0500 (EST)
Message-ID: <658d61ef8b6b6bb45fa946283b04c75dfac7a749.camel@russell.cc>
Subject: Re: [PATCH v4 16/24] powerpc/pseries: Implement signed update for
 PLPKS objects
From:   Russell Currey <ruscur@russell.cc>
To:     Andrew Donnellan <ajd@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-integrity@vger.kernel.org
Cc:     sudhakar@linux.ibm.com, bgray@linux.ibm.com, erichte@linux.ibm.com,
        gregkh@linuxfoundation.org, nayna@linux.ibm.com,
        linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        gjoyce@linux.ibm.com, gcwilson@linux.ibm.com, joel@jms.id.au
Date:   Tue, 31 Jan 2023 15:23:52 +1100
In-Reply-To: <63aaa01d1649f2905b3bff8009bb9c3a47c82e50.camel@linux.ibm.com>
References: <20230120074306.1326298-1-ajd@linux.ibm.com>
         <20230120074306.1326298-17-ajd@linux.ibm.com>
         <CQ04OOT6CW1A.MCLZN2B4BTWK@bobo>
         <63aaa01d1649f2905b3bff8009bb9c3a47c82e50.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3 (3.46.3-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-01-30 at 15:43 +1100, Andrew Donnellan wrote:
> On Tue, 2023-01-24 at 14:16 +1000, Nicholas Piggin wrote:
> > > diff --git a/arch/powerpc/platforms/pseries/plpks.c
> > > b/arch/powerpc/platforms/pseries/plpks.c
> > > index 1189246b03dc..796ed5544ee5 100644
> > > --- a/arch/powerpc/platforms/pseries/plpks.c
> > > +++ b/arch/powerpc/platforms/pseries/plpks.c
> > > @@ -81,6 +81,12 @@ static int pseries_status_to_err(int rc)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D -ENOENT;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case H_BUSY:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case H_LONG_BUSY_ORDER_1_M=
SEC:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case H_LONG_BUSY_ORDER_10_=
MSEC:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case H_LONG_BUSY_ORDER_100=
_MSEC:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case H_LONG_BUSY_ORDER_1_S=
EC:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case H_LONG_BUSY_ORDER_10_=
SEC:
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case H_LONG_BUSY_ORDER_100=
_SEC:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0err =3D -EBUSY;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0break;
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0case H_AUTHORITY:
> >=20
> > This is a bit sad to maintain here. It's duplicating bits with
> > hvcs_convert, and a bunch of open coded places. Probably not the
> > series to do anything about. Would be nice if we could standardise
> > it though.
>=20
> Agreed - though we're not going to touch it in this series.
>=20
> >=20
> > > @@ -184,14 +190,17 @@ static struct label *construct_label(char
> > > *component, u8 varos, u8 *name,
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 u1=
6 namelen)
> > > =C2=A0{
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct label *label;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0size_t slen;
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0size_t slen =3D 0;
> > > =C2=A0
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!name || namelen =
> PLPKS_MAX_NAME_SIZE)
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0return ERR_PTR(-EINVAL);
> > > =C2=A0
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0slen =3D strlen(component)=
;
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (component && slen > si=
zeof(label->attr.prefix))
> > > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0return ERR_PTR(-EINVAL);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0// Support NULL component =
for signed updates
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (component) {
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0slen =3D strlen(component);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0if (slen > sizeof(label->attr.prefix))
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ret=
urn ERR_PTR(-EINVAL);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0}
> >=20
> > Is this already a bug? Code checks for component !=3D NULL but
> > previously
> > calls strlen which would oops on NULL component AFAIKS. Granted
> > nothing
> > is actually using any of this these days.
>=20
> True, it should have been checking for NULL first, but as you say no-
> one is using it.
>=20
> >=20
> > It already seems like it's supposed to be allowed to rad NULL
> > component
> > with read_var though? Why the differences, why not always allow
> > NULL
> > component? (I assume there is some reason, I just don't know
> > anything
> > about secvar or secure boot).
>=20
> I think the comment confuses more than it clarifies, I'll remove it.
>=20
> As you say, read_var() should work fine with component =3D=3D NULL,
> though
> write_var() checks it. The only rule I can find in the spec is that
> signed update calls *must* set the component to NULL. I'm seeking
> clarification on that.

Signed update calls *must* set the component to NULL.

We could just call construct_label() with NULL as the component
directly but I think it's better to explicitly check var->component and
return so the caller knows what they're trying to do is wrong.

>=20
> > > +EXPORT_SYMBOL(plpks_signed_update_var);
> >=20
> > Sorry I missed it before -- can this be a _GPL export?
>=20
> Indeed it should be - actually, I should check if I can get rid of
> the
> export completely...
>=20

