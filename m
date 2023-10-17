Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA3B7CCB2F
	for <lists+linux-integrity@lfdr.de>; Tue, 17 Oct 2023 20:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235002AbjJQSvZ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 17 Oct 2023 14:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234963AbjJQSvZ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 17 Oct 2023 14:51:25 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9256BF0
        for <linux-integrity@vger.kernel.org>; Tue, 17 Oct 2023 11:51:23 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d9beb865a40so2640920276.1
        for <linux-integrity@vger.kernel.org>; Tue, 17 Oct 2023 11:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1697568683; x=1698173483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1j8E84ykBKtkhB7y9PxztHZ9P/6cyMaN8QtwhDRi5Po=;
        b=Y8Vl8DBaBNtjAOCM/MWDthg+L23DOuja9vDD8qMSZIdJSiuW7hI3Cz+i6pm1Ro754A
         1WPxRO0aENo/HuQ9fM+/p14MsczUyUPMlHI7lG/ZTAcEMeJ4oMqOX1lF+sV16FnMN3JJ
         E+t8QbD+hpNknxjKCJDEesOvG5/zZt++RpLDUewHREFhC8xUqBMBoUBI/ZWiIORXmvz4
         3G4RhFBa7nyrOczCsOLhOtNlGg8JNfRXcXjPI1QceMSBQ8jOseQIWscUUnFaLJ1HhqcR
         /5b254BSkoZ9ue8zbgXKizPqhvaY0ho2fBEfwFjO5s5xCDEcTRYNrcmQQmwBPz0+5Svm
         llyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697568683; x=1698173483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1j8E84ykBKtkhB7y9PxztHZ9P/6cyMaN8QtwhDRi5Po=;
        b=oXvkv77KrrB3hP2U6RDiq0+HQqR1Wsl0grBuc4pGMorPy24KHzOwguFDtfvtXpvqgC
         VoHzf9tAtg4KuOWmTNxsepoVkXaggsyBqlfnWcR4oDJ5/SODrG4zUhrRvINWGIovqacI
         iMnGnk8yCeu3wuuJMyXrCSQuc+jHwNsXkLWqmqntNqarpg5fkjrGRp1xHDpk3UX7emAx
         f6qCkpMhByhQNYx5aYv6Axibmedd1fmgAN0xBR3Arq3Vji67aQdOueU1MvshAlTbM6mj
         WwVZgwxvJpUGwTr0ccHrYgIKzY5nA4FYc/NdFiFRHh+9t5TQu4+8lGSHxdjTMYTpNeiw
         JvNg==
X-Gm-Message-State: AOJu0YzY4nDiGPnr8bg5Uwt9uT6ySCswpE3u+Onqy3fXL2lnGKAKZ9Qd
        qjtZsVpFG3RmZmvq7zS/3hway0XJym87Gp0PHUSk
X-Google-Smtp-Source: AGHT+IFBS+duacPG1F94RS4DGEOiPgfLB1HdSk+mU+9IrMxtV/zJeqygqtk2ORcH3vxvuDl4HWJHfDKtID9ez07xico=
X-Received: by 2002:a25:50d:0:b0:d99:de67:c3dc with SMTP id
 13-20020a25050d000000b00d99de67c3dcmr3190714ybf.2.1697568682729; Tue, 17 Oct
 2023 11:51:22 -0700 (PDT)
MIME-Version: 1.0
References: <CEA476C1-4CE5-4FFC-91D7-6061C8605B18@oracle.com>
 <ba2f5560800608541e81fbdd28efa9875b35e491.camel@linux.ibm.com>
 <932231F5-8050-4436-84B8-D7708DC43845@oracle.com> <7335a4587233626a39ce9bc8a969957d7f43a34c.camel@linux.ibm.com>
 <FD6FB139-F901-4E55-9705-E7B0023BDBA8@oracle.com> <1149b6dbfdaabef3e48dc2852cc76aa11a6dd6b0.camel@linux.ibm.com>
 <4A0505D0-2933-43BD-BEEA-94350BB22AE7@oracle.com> <20230913.Ceifae7ievei@digikod.net>
 <D0F16BFD-72EB-4BE2-BA3D-BAE1BCCDCB6F@oracle.com> <20230914.shah5al9Kaib@digikod.net>
 <20231005.dajohf2peiBu@digikod.net> <d3b51f26c14fd273d41da3432895fdce9f4d047c.camel@linux.ibm.com>
 <CAHC9VhRdU1CZJpPSEdSmui-Xirr0j261K=+SM7KiDwiPG-JSrQ@mail.gmail.com>
 <a851227aaa75ab16b0d6dd93433e1ee1679715f9.camel@linux.ibm.com>
 <CAHC9VhS_Ttdy5ZB=jYdVfNyaJfn_7G1wztr5+g0g7uUDForXvA@mail.gmail.com> <5c795b4cf6d7460af205e85a36194fa188136c38.camel@linux.ibm.com>
In-Reply-To: <5c795b4cf6d7460af205e85a36194fa188136c38.camel@linux.ibm.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 17 Oct 2023 14:51:11 -0400
Message-ID: <CAHC9VhTug20M0ET=QojUPtjrGkeHfU=ADDNrKfXmLTQPG_i1vw@mail.gmail.com>
Subject: Re: RFC: New LSM to control usage of x509 certificates
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Kanth Ghatraju <kanth.ghatraju@oracle.com>,
        Konrad Wilk <konrad.wilk@oracle.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Oct 17, 2023 at 1:59=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
> On Tue, 2023-10-17 at 13:29 -0400, Paul Moore wrote:
> > On Tue, Oct 17, 2023 at 1:09=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com=
> wrote:
> > > On Tue, 2023-10-17 at 11:45 -0400, Paul Moore wrote:
> > > > On Tue, Oct 17, 2023 at 9:48=E2=80=AFAM Mimi Zohar <zohar@linux.ibm=
.com> wrote:
> > > > > On Thu, 2023-10-05 at 12:32 +0200, Micka=C3=ABl Sala=C3=BCn wrote=
:
> > > > > > > > > A complementary approach would be to create an
> > > > > > > > > LSM (or a dedicated interface) to tie certificate propert=
ies to a set of
> > > > > > > > > kernel usages, while still letting users configure these =
constraints.
> > > > > > > >
> > > > > > > > That is an interesting idea.  Would the other security main=
tainers be in
> > > > > > > > support of such an approach?  Would a LSM be the correct in=
terface?
> > > > > > > > Some of the recent work I have done with introducing key us=
age and CA
> > > > > > > > enforcement is difficult for a distro to pick up, since the=
se changes can be
> > > > > > > > viewed as a regression.  Each end-user has different signin=
g procedures
> > > > > > > > and policies, so making something work for everyone is diff=
icult.  Letting the
> > > > > > > > user configure these constraints would solve this problem.
> > > > >
> > > > > Something definitely needs to be done about controlling the usage=
 of
> > > > > x509 certificates.  My concern is the level of granularity.  Woul=
d this
> > > > > be at the LSM hook level or even finer granaularity?
> > > >
> > > > You lost me, what do you mean by finer granularity than a LSM-based
> > > > access control?  Can you give an existing example in the Linux kern=
el
> > > > of access control granularity that is finer grained than what is
> > > > provided by the LSMs?
> > >
> > > The current x509 certificate access control granularity is at the
> > > keyring level.  Any key on the keyring may be used to verify a
> > > signature.  Finer granularity could associate a set of certificates o=
n
> > > a particular keyring with an LSM hook - kernel modules, BPRM, kexec,
> > > firmware, etc.  Even finer granularity could somehow limit a key's
> > > signature verification to files in particular software package(s) for
> > > example.
> > >
> > > Perhaps Micka=C3=ABl and Eric were thinking about a new LSM to contro=
l usage
> > > of x509 certificates from a totally different perspective.  I'd like =
to
> > > hear what they're thinking.
> > >
> > > I hope this addressed your questions.
> >
> > Okay, so you were talking about finer granularity when compared to the
> > *current* LSM keyring hooks.  Gotcha.
> >
> > If we need additional, or modified, hooks that shouldn't be a problem.
> > Although I'm guessing the answer is going to be moving towards
> > purpose/operation specific keyrings which might fit in well with the
> > current keyring level controls.
>
> I don't believe defining per purpose/operation specific keyrings will
> resolve the underlying problem of granularity.

Perhaps not completely, but for in-kernel operations I believe it is
an attractive idea.

--=20
paul-moore.com
