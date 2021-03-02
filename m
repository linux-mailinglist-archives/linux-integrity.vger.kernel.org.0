Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88F7032B30E
	for <lists+linux-integrity@lfdr.de>; Wed,  3 Mar 2021 04:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233817AbhCCB3P (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 2 Mar 2021 20:29:15 -0500
Received: from us2-ob1-2.mailhostbox.com ([162.210.70.53]:59773 "EHLO
        us2-ob1-2.mailhostbox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242293AbhCBIYB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 2 Mar 2021 03:24:01 -0500
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hello@oswalpalash.com)
        by us2.outbound.mailhostbox.com (Postfix) with ESMTPSA id 0A033182368;
        Tue,  2 Mar 2021 07:52:32 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oswalpalash.com;
        s=20160715; t=1614671552;
        bh=YKuKXn7CtU6RhyLQwQluFj130cGpc9IGAnjZZJFeVVE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc;
        b=Lfo10Fxoj4Txyqp5sG0f65YzV8ZfBgebaECWow+ymbWhoR20ZppHtLqqAT9Xblyb4
         irTD9rU1ihF/EYvgqqYIZvj9BCNvPPaB+TNvsjaFAHzsmI0tTrXAUGs6WLzH232mZ/
         smrrbth05VC7l/e0UF64+1rBUq7VpXaq22m5iK+k=
Received: by mail-lf1-f52.google.com with SMTP id f1so29848632lfu.3;
        Mon, 01 Mar 2021 23:52:31 -0800 (PST)
X-Gm-Message-State: AOAM532l5VBwgkorHS/jrdX95qyv8gDkk9PqLVPi9W8letE31qBywysL
        Np3BozAvvwBnRzhVRNeZW3QDC8XdJKZ0j7d4oc4=
X-Google-Smtp-Source: ABdhPJxY6cyizpRdsLSaQCkJcStJRYN3Q+Hpq26TtcHaPZNqeqn8edElaDBFE65cAzpurPBt3srBdHzYvresyCXBIqg=
X-Received: by 2002:a19:7ed6:: with SMTP id z205mr11535045lfc.12.1614671550346;
 Mon, 01 Mar 2021 23:52:30 -0800 (PST)
MIME-Version: 1.0
References: <YC/3n585TNJ500Ps@kernel.org>
In-Reply-To: <YC/3n585TNJ500Ps@kernel.org>
From:   Palash Oswal <hello@oswalpalash.com>
Date:   Tue, 2 Mar 2021 13:22:18 +0530
X-Gmail-Original-Message-ID: <CAGyP=7eV=CfgCp1OKt1mDN0erz5Zq40ePapJvF0wCnHfzOR=Xg@mail.gmail.com>
Message-ID: <CAGyP=7eV=CfgCp1OKt1mDN0erz5Zq40ePapJvF0wCnHfzOR=Xg@mail.gmail.com>
Subject: Re: [PATCH] ima: Replacing deprecated strlcpy with strscpy ~~~~~~~~~ Replace
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-CMAE-Score: 0
X-CMAE-Analysis: v=2.3 cv=ermhMbhX c=1 sm=1 tr=0
        a=Lq6r7wnCGV6iLQba78UrEg==:117 a=IkcTkHD0fZMA:10 a=dESyimp9J3IA:10
        a=8_4whJBMvIpeHjROzMMA:9 a=QEXdDO2ut3YA:10 a=gME-wNpD-40A:10
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Apologies for the in-accurate description. This patch is covered under
the patch-set by Romain Perier ( https://lkml.org/lkml/2021/2/22/739 )
and can be disregarded.

Best Regards,
Palash

On Fri, Feb 19, 2021 at 11:09 PM Jarkko Sakkinen <jarkko@kernel.org> wrote:
>
> Reply-To:
> In-Reply-To: <20210219084038.GA7564@g3.oswalpalash.com>
>
> On Fri, Feb 19, 2021 at 02:10:38PM +0530, Palash Oswal wrote:
> > The strlcpy() function is unsafe in that the source buffer length
> > is unbounded or possibly be non NULL terminated. This can cause
> > memory over-reads, crashes, etc.
> >
> > Link: https://github.com/KSPP/linux/issues/89
> > Signed-off-by: Palash Oswal <hello@oswalpalash.com>
>
> The long description does not explain what the commit does, and
> does not include any details about deprecation of strlcpy(), which
> at least I'm not aware of.
>
> I don't think *length* ever is NULL terminated. The first sentence
> is somewhat weird. Also strlcpy() does have a bounds check.
>
> Generally, the description and reasoning is sloppy to say the
> least.
>
> /Jarkko
>
>
> > ---
> >  security/integrity/ima/ima_api.c    | 2 +-
> >  security/integrity/ima/ima_policy.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/security/integrity/ima/ima_api.c b/security/integrity/ima/ima_api.c
> > index 1dd70dc68ffd..2f3b8257181d 100644
> > --- a/security/integrity/ima/ima_api.c
> > +++ b/security/integrity/ima/ima_api.c
> > @@ -399,7 +399,7 @@ const char *ima_d_path(const struct path *path, char **pathbuf, char *namebuf)
> >       }
> >
> >       if (!pathname) {
> > -             strlcpy(namebuf, path->dentry->d_name.name, NAME_MAX);
> > +             strscpy(namebuf, path->dentry->d_name.name, NAME_MAX);
> >               pathname = namebuf;
> >       }
> >
> > diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima/ima_policy.c
> > index 9b45d064a87d..010839aef6ba 100644
> > --- a/security/integrity/ima/ima_policy.c
> > +++ b/security/integrity/ima/ima_policy.c
> > @@ -791,7 +791,7 @@ static int __init ima_init_arch_policy(void)
> >               char rule[255];
> >               int result;
> >
> > -             result = strlcpy(rule, *rules, sizeof(rule));
> > +             strscpy(rule, *rules, sizeof(rule));
> >
> >               INIT_LIST_HEAD(&arch_policy_entry[i].list);
> >               result = ima_parse_rule(rule, &arch_policy_entry[i]);
> >
> > base-commit: f6692213b5045dc461ce0858fb18cf46f328c202
> > --
> > 2.27.0
> >
> >
