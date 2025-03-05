Return-Path: <linux-integrity+bounces-5092-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1D1A4F279
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 01:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F1761890A30
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Mar 2025 00:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2962327450;
	Wed,  5 Mar 2025 00:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RdQDNyoX"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D35419BBA
	for <linux-integrity@vger.kernel.org>; Wed,  5 Mar 2025 00:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741134198; cv=none; b=UgPI3E0NKuy6AMZtWBaVVAh+ese3IVOYiX0z87bQen7sKpn5BQ+JMfOo4SORhrl4fmaKU4/07bRV0Sp791PRo7a55Vfa6oIUCG/pvuXcoLmZLwV1sAjLjSON+fJeoN/jmn5IjPe7GpZm65Sy1IGNAPxVzS1fEnqwVdsWDdC+t0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741134198; c=relaxed/simple;
	bh=EMm2jrTYaTVwDIb7fIqq/SrPdw8NSX14iaJPNP9LZ2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZIYUsI9YALBmQCvOxXPMw54mH45vIVvkjRAShPwyqDW4EUTgSt22QUrSwYRcY81knYwxxd/9YLXa9O20ZSGG7aV7JEFxn8xFB+WaFhqm9+jZhe+wRo1Rii3zW8/WKXpathwOtX6TR4FmiPnTUMO1sYtvhsSUc7pK2qC4w99J1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RdQDNyoX; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e60a35eb84fso4418021276.3
        for <linux-integrity@vger.kernel.org>; Tue, 04 Mar 2025 16:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741134194; x=1741738994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4YiDLYB2Xyv0i3lSlJtAUBvLRrjWhRXqsvlbXIFqzQ=;
        b=RdQDNyoXM7IPhz6ZcFdiO2YoIKx40O8RUIXLuPFtlR7VRRQPCGAzgNL1OzG8Erl0aC
         sjqRZrpJMXwcMRCVLt4oWh3qM274V0LG56D0xUPgoHXHezq6iSEPpRc2FX+STQf/vvf0
         vaShhwR1oHgaGveBc0p9AlQqQeK4wpGqkzEqiazCdSc6XOtrt43aFVVZ+tiJqt4+oZEJ
         xKKLhP06KG8nsbGkRvBMHvyTg8eMiDSaCseRwpNWH/Sy81DkDR0vGNmiur6sW6Z2rxd/
         VDxgds4JokUodF1FYXoVsTxBBloLCrr7zG9aIXWJx46rZic/h+X+kOzqZC+61yWcME2L
         574Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741134194; x=1741738994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4YiDLYB2Xyv0i3lSlJtAUBvLRrjWhRXqsvlbXIFqzQ=;
        b=F89mCWy4efFY3ntmwXSFqZnzGKkGnY5jmlnS//8D+hF4flR7Ojs4Y87ugujQzpYLJU
         WurpYCQGSj2ILIZyRzWNT1KSddVUYFk6a7OfDZwaCByrLNmiiXO31XDdlB8gR4Ez7df5
         fzJ7gwS4IneO+r1e0LrhsercvD/VQ2Ta/cZVNOkasw+/V3CgvgOGtw06nfqOzk2lIXS0
         R1nR2Mu5AkDg4C/yZrBJ7vXSZs0xbM4lD0htFjoFuanJgE1ZZ++PkpXnnakoQYUCaktb
         y+aHVG2F9fDt5J6mMMQIa6xSTlKzoID2qsIZdahWOWwRimancjJzarbiaGalrzAakflK
         rUnA==
X-Forwarded-Encrypted: i=1; AJvYcCUAG3bNtdaHdVhDlcanKM9f9aUWjpt2z2KJWDuvA+XMfRK2SSnCoOg+eYYo382RNNb9JXCtuWMJmAgGTbql8n4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD0PTIdw0uoMfMlzxHqfQmHpRbjGSPJVfisLll6GmafwGL0bYO
	12xPyZmNCwJeo1/UzJX+CScgT1wLwicnomxwtQ+keg6UYXQ5GVTjYXFRlgWBHn8OtcyNiZ6MNRf
	0+rxWPr/pt0yUzX7Bq+IcANwQViw5nhkFxsqe
X-Gm-Gg: ASbGncsHJpBMGfdcaX5IVyVwP0DQahDklUqdruEzj3jyWRhsql3PIxy8sUGPoOuH7En
	plqPurMdUYghu+K+YIpJUrFTrB9lplwZZ1l9yxzP7DA5KaJ0z/YFEenFrReSnAZ9y6W+vyvTfY5
	yQI6we1lJv8bzwj/5mcG5GAgCEbg==
X-Google-Smtp-Source: AGHT+IGOLBgkI0Cnk4j24VyTAA7d3ChoOytypLLEWobuiO8gJGe4SQT14bcYnIvbbRk+2AFMGCgF13qrN5gAjSrMY80=
X-Received: by 2002:a05:6902:1683:b0:e60:b17c:423f with SMTP id
 3f1490d57ef6-e611e1e7b91mr1711475276.28.1741134194264; Tue, 04 Mar 2025
 16:23:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241017155516.2582369-1-eric.snowberg@oracle.com>
 <c490397315c2704e9ef65c8ad3fefedb239f1997.camel@linux.ibm.com>
 <72F52F71-C7F3-402D-8441-3D636A093FE8@oracle.com> <CAHC9VhRHEw5c+drC=aX4xTqWoQJJZ+qkJ7aHUT5dcu+Q5f7BqA@mail.gmail.com>
 <CAHC9VhSJpnaAK1efgs1Uk0Tr3CaDNR1LiDU-t_yDKDQG6J-74Q@mail.gmail.com>
 <E20C617B-EA01-4E69-B5E2-31E9AAD6F7A2@oracle.com> <506e8e58e5236a4525b18d84bafa9aae80b24452.camel@linux.ibm.com>
 <CAHC9VhTsZntLdGBV7=4suauS+rzSQv1O4UAoGcy2vEB02wRkoA@mail.gmail.com>
 <c580811716f550ed5d6777db5e143afe4ad06edc.camel@linux.ibm.com>
 <CAHC9VhTz6U5rRdbJBWq0_U4BSKTsiGCsaX=LTgisNNoZXZokOA@mail.gmail.com>
 <FD501FB8-72D2-4B10-A03A-F52FC5B67646@oracle.com> <CAHC9VhR961uTFueovLXXaOf-3ZAnvQCWOTfw-wCRuAKOKPAOKw@mail.gmail.com>
 <73B78CE7-1BB8-4065-9EBA-FB69E327725E@oracle.com>
In-Reply-To: <73B78CE7-1BB8-4065-9EBA-FB69E327725E@oracle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 4 Mar 2025 19:23:03 -0500
X-Gm-Features: AQ5f1JrNkibyfl_g34dPES-fz_iVnpfHCEdaTH0VQZ1SvczNe3olHp_2oU87GRs
Message-ID: <CAHC9VhRMUkzLVT5GT5c5hgpfaaKubzcPOTWFDpOmhNne0sswPA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 00/13] Clavis LSM
To: Eric Snowberg <eric.snowberg@oracle.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, 
	David Woodhouse <dwmw2@infradead.org>, 
	"herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>, 
	Ard Biesheuvel <ardb@kernel.org>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	"casey@schaufler-ca.com" <casey@schaufler-ca.com>, Stefan Berger <stefanb@linux.ibm.com>, 
	"ebiggers@kernel.org" <ebiggers@kernel.org>, Randy Dunlap <rdunlap@infradead.org>, 
	open list <linux-kernel@vger.kernel.org>, 
	"keyrings@vger.kernel.org" <keyrings@vger.kernel.org>, 
	"linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, 
	"linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, 
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 9:47=E2=80=AFAM Eric Snowberg <eric.snowberg@oracle.=
com> wrote:
> > On Mar 3, 2025, at 3:40=E2=80=AFPM, Paul Moore <paul@paul-moore.com> wr=
ote:
> > On Fri, Feb 28, 2025 at 12:52=E2=80=AFPM Eric Snowberg <eric.snowberg@o=
racle.com> wrote:
> >>> On Feb 28, 2025, at 9:14=E2=80=AFAM, Paul Moore <paul@paul-moore.com>=
 wrote:
> >>> On Fri, Feb 28, 2025 at 9:09=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.c=
om> wrote:
> >>>> On Thu, 2025-02-27 at 17:22 -0500, Paul Moore wrote:
> >>>>>
> >>>>> I'd still also like to see some discussion about moving towards the
> >>>>> addition of keyrings oriented towards usage instead of limiting
> >>>>> ourselves to keyrings that are oriented on the source of the keys.
> >>>>> Perhaps I'm missing some important detail which makes this
> >>>>> impractical, but it seems like an obvious improvement to me and wou=
ld
> >>>>> go a long way towards solving some of the problems that we typicall=
y
> >>>>> see with kernel keys.
> >>
> >> The intent is not to limit ourselves to the source of the key.  The ma=
in
> >> point of Clavis is to allow the end-user to determine what kernel keys
> >> they want to trust and for what purpose, irrespective of the originati=
ng
> >> source (.builtin_trusted, .secondary, .machine, or .platform). If we c=
ould
> >> go back in time, individual keyrings could be created that are oriente=
d
> >> toward usage.   The idea for introducing Clavis is to bridge what we
> >> have today with kernel keys and allow them to be usage based.
> >
> > While it is unlikely that the current well known keyrings could be
> > removed, I see no reason why new usage oriented keyrings could not be
> > introduced.  We've seen far more significant shifts in the kernel over
> > the years.
>
> Could you further clarify how a usage oriented keyring would work?  For
> example, if a kernel module keyring was added, how would the end-user
> add keys to it while maintaining a root of trust?

Consider it an exercise left to the reader :)

I imagine there are different ways one could do that, either using
traditional user/group/capability permissions and/or LSM permissions,
it would depend on the environment and the security goals of the
overall system.

--=20
paul-moore.com

