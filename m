Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172367BA113
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Oct 2023 16:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237207AbjJEOnb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Oct 2023 10:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237347AbjJEOjE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Oct 2023 10:39:04 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB75555DD8
        for <linux-integrity@vger.kernel.org>; Thu,  5 Oct 2023 07:05:37 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-59f4f80d084so10894167b3.1
        for <linux-integrity@vger.kernel.org>; Thu, 05 Oct 2023 07:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1696514737; x=1697119537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YUPOooK4Ns6DH/Jalgn9lVTRMXc80w0ZAjwIoNKA7QA=;
        b=gZJjm7wIgO3iNaVndIuYT4UV17QLvXVqy6yrN8Ec6SpZ1nPqHW9BOYT9/GBBD2pxUY
         4X6htYn6c+WhUk2zH/Ppo9KAs97EYf/C5jPcdpK6dBpy5vqEYhqHKDSBAWyau5FJH84h
         y0yt9V/2+L5zoliDdtajzBAAVTAOcuemc6Dp53MKB/NmrALbmsdPSCdVqnFUt0PV1PFk
         SM5UvQ/PBgLUYEybmLEXY+7EjY2/Z/M3tEW7ME5LUcvM4gNv3LUBa8lkS5aaZ2T1W50K
         QgFN7cgf79mUY8nEGz0LU993w2u2BA+LaJA58F7x7VOPCvsWz5UcDkQPS9CaD/Ps1kCr
         1tGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696514737; x=1697119537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YUPOooK4Ns6DH/Jalgn9lVTRMXc80w0ZAjwIoNKA7QA=;
        b=FZJjHiqOLj2mHQ6jbbrg4hlJOcmF5JtRWfUwWrMLD5Xx3J3wggY/FhifFWIKG88a26
         GoBi43mjgqjZKJl4GzzYYwd1u7q1EP17AfeehFfuVrG1zNPcQ7VXobGYoGH8vKcFchDi
         IW8L6AY7KKJLBVXBg3NtDirAZnsUDN1orG/mKwVmhG6oe5ohSo5j8PNFZj9g7wM0vuwE
         2EMkIc0736HchJs4Si3VnQebg3RN5Y4IdP1WGpcaU/x7DmSVzwrepz4cM05WJuDc1OrR
         7SqUwywWZwOxg60QionkpPvj6J8vZzPWpv2rvwHN7m5z4VKBYVtQ0Rqv4CIcXSRHU4ab
         R9/w==
X-Gm-Message-State: AOJu0YyN1vJQwofv1ka5MLhOGY+6GF1pQx401a5uuj4LDFRDt37/ixoL
        ip2NGgNTFu3YR5ga5APd9DeumdN06ERQrnnXMOld
X-Google-Smtp-Source: AGHT+IEhII1+ssm6kMv+2+D8NIey8gXMZEJQg4s9lOhq3v8CS0TIyvbGSdMA3HXKy2CrlPTC5uALpYCU+9MbO/YcHp4=
X-Received: by 2002:a25:bb83:0:b0:d80:1bbf:fabf with SMTP id
 y3-20020a25bb83000000b00d801bbffabfmr4580170ybg.2.1696514736829; Thu, 05 Oct
 2023 07:05:36 -0700 (PDT)
MIME-Version: 1.0
References: <CEA476C1-4CE5-4FFC-91D7-6061C8605B18@oracle.com>
 <ba2f5560800608541e81fbdd28efa9875b35e491.camel@linux.ibm.com>
 <932231F5-8050-4436-84B8-D7708DC43845@oracle.com> <7335a4587233626a39ce9bc8a969957d7f43a34c.camel@linux.ibm.com>
 <FD6FB139-F901-4E55-9705-E7B0023BDBA8@oracle.com> <1149b6dbfdaabef3e48dc2852cc76aa11a6dd6b0.camel@linux.ibm.com>
 <4A0505D0-2933-43BD-BEEA-94350BB22AE7@oracle.com> <20230913.Ceifae7ievei@digikod.net>
 <D0F16BFD-72EB-4BE2-BA3D-BAE1BCCDCB6F@oracle.com> <20230914.shah5al9Kaib@digikod.net>
 <20231005.dajohf2peiBu@digikod.net>
In-Reply-To: <20231005.dajohf2peiBu@digikod.net>
From:   Paul Moore <paul@paul-moore.com>
Date:   Thu, 5 Oct 2023 10:05:25 -0400
Message-ID: <CAHC9VhQioMnXdbBugn3h8TBmOPvv_pCehMh8ON5LOOPmt1=6LA@mail.gmail.com>
Subject: Re: RFC: New LSM to control usage of x509 certificates
To:     Eric Snowberg <eric.snowberg@oracle.com>,
        =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc:     "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 5, 2023 at 6:32=E2=80=AFAM Micka=C3=ABl Sala=C3=BCn <mic@digiko=
d.net> wrote:
>
> The initial subject was "Re: [PATCH] certs: Restrict blacklist updates
> to the secondary trusted keyring":
> https://lore.kernel.org/all/20230908213428.731513-1-eric.snowberg@oracle.=
com/
>
> On Thu, Sep 14, 2023 at 10:34:44AM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> > CCing the LSM mailing list for this potential new LSM proposal:
> > On Wed, Sep 13, 2023 at 10:29:58PM +0000, Eric Snowberg wrote:
> > > > On Sep 13, 2023, at 4:21 AM, Micka=C3=ABl Sala=C3=BCn <mic@digikod.=
net> wrote:
> > > > On Wed, Sep 13, 2023 at 02:40:17AM +0000, Eric Snowberg wrote:
> > > >>> On Sep 12, 2023, at 4:47 PM, Mimi Zohar <zohar@linux.ibm.com> wro=
te:

[Just a reminder that trimming massive emails to the relevant portions
is a nice thing to do]

> > > > A complementary approach would be to create an
> > > > LSM (or a dedicated interface) to tie certificate properties to a s=
et of
> > > > kernel usages, while still letting users configure these constraint=
s.
> > >
> > > That is an interesting idea.  Would the other security maintainers be=
 in
> > > support of such an approach?  Would a LSM be the correct interface?
> > > Some of the recent work I have done with introducing key usage and CA
> > > enforcement is difficult for a distro to pick up, since these changes=
 can be
> > > viewed as a regression.  Each end-user has different signing procedur=
es
> > > and policies, so making something work for everyone is difficult.  Le=
tting the
> > > user configure these constraints would solve this problem.

I can't say that I have been following this thread very closely, but I
see no reason why we wouldn't support a LSM that enforces access
controls on certificates/keys based on their attributes/properties.
We do have some LSM control points for the kernel keyring, which are
used by at least one LSM, but I'm sure you would probably need some
additional control points.

If you are interested in pursuing the creation of a new LSM, and
likely new LSM hooks, we do have some documented guidelines you should
keep in mind:

* https://github.com/LinuxSecurityModule/kernel/blob/main/README.md

--=20
paul-moore.com
