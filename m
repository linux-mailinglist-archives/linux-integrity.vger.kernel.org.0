Return-Path: <linux-integrity+bounces-5053-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ED1A4CE93
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Mar 2025 23:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433883AD4AE
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Mar 2025 22:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1C3E238142;
	Mon,  3 Mar 2025 22:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dIyl458c"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027D5235C04
	for <linux-integrity@vger.kernel.org>; Mon,  3 Mar 2025 22:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741041667; cv=none; b=K5b8BFrSOiUCGperAigpG2FMDY8UHKucOmkOrvkzpJx8Cwd312PPxZER6t/aLPnd+SlGlCDGM8NUyHswprX2Pjgk73ZPmEDdkQnhxT4Qcy8MUoc0/jqosGAS5PLuTGZ2Swl3ETT/SISiWr1T3uJ00WzWCTlARhuzc/47n9KdelA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741041667; c=relaxed/simple;
	bh=vicK7bIZ1WnoD161ydDvJAs/tiKNhejmfM8AMnZaywc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o6x7FWjiH9ilnByflFtVvjzfLwTraNTT8IxdPWYPAg9KlorklpbnxcN7ZiCrl2jdP/Fllk5g2E+ucr89JAgo9MtmLGbNon/Q/M4dEJBNSmDU/PcR6/iB+jg3EOt2JiFX4mHrE+dJd96WCf2lCW78WU2mbzvQsmXxrKcyJlqhqCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dIyl458c; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e5372a2fbddso3485461276.3
        for <linux-integrity@vger.kernel.org>; Mon, 03 Mar 2025 14:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741041665; x=1741646465; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gppqdoDdIh3oGTN/X/g9kSNpQ5mdJXAuUzpEYfPY3Z8=;
        b=dIyl458cN/fOUa2OzrFxo9g0LGojOFc2KYRK3yW6QRjj+4Zj68cjqQivIPz7CE5Z8V
         PHzZhqPiYaYLqhBdNSrYTMsiUb1njNNrnPQidHVUgyQ90V8Z2iUzWNEKtFqIrEBchWa0
         ooi3wDzlnaASp814Pg0V08EX94i296tW2WPR1lm+P+/3CuRHJt+1pvjg7Ifm2EcVlwvz
         HRrtpx6CdVsrdSNGC1ECk7BSqidSYAOmhlz/XDGHBIIyA0MUQ0bxzuflEybLN9F+mSp2
         pCPezW3xiPbzdsclv5tQhDm3bFCL8ndMr07tWk+MYKawu+tm1KyX4jyMRyBjDTCByYk9
         LtkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741041665; x=1741646465;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gppqdoDdIh3oGTN/X/g9kSNpQ5mdJXAuUzpEYfPY3Z8=;
        b=uOq3wf05XIXFAGqJDtCBb03vRXT8kg32ULX7hX6o1w8+TzAB2SGMvpRraLR7sMF8z3
         N8BwB9kNl21GYZpp8YzmsF3JEYk0AOP8GkyVF3Q68sXH/DZ6mGq8S2po+9dXDXOMu+sV
         /3BSj5mYq6Eyp8hXENIPfDmpegLaJleE7UZpE4eOUsprPkonGJLRIYmSHtSUZfqxENmr
         PXiFQFpSUaVtJZ5dnEwoetiYFSVuY5fAh6kMD163uX3tkJZjmRVme7IyVp/Urqjdvvep
         tl+8/Eps1JVbCBw0CYiYw4Mm3rYCPZx3VF0vtJwhqrm1g74BjTdvNvSS7ZCMIYX9v/Aq
         rwGg==
X-Forwarded-Encrypted: i=1; AJvYcCUJylaSUZiNQA3WUXA4AXaO9uUIk2xEeW0uh9vAMcoBTaEYHEs0f2jxaRQNIqaRuLGR+BGYDb5Vy/edcOsWjn4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPNEUvkNPWKGclseqM+3g5yhvmDrsg8h++zplE3KOjslRXSV9/
	Rb6d7kiXleW1J73lKZV9e9xiA993wv6izNlpeWcgE1n6EJbcVge4k9g+o/SrZpEJuII5bkpsdHv
	IvhjRMWCfTD+uttmcGmTJJLmtrNeOsVjR9CJ0
X-Gm-Gg: ASbGncvqmNTXIYFpJkZlX5AnTGQwNJMonT6grOf5VsrZIlxfn780rVt+nQ5X/5Scbxl
	l5QLWaWvlATsuyhVVEA7JBqhefpJWGyLCOoES6dYojb1vqbL445ANG2lAWz5uPoxvGXd2xOb+JY
	du+I0EODliMZSs9SuMQG3NrAAfzA==
X-Google-Smtp-Source: AGHT+IHEMCi3EIHgp9lfAkr/LODHorcC4bw53le19buOJnpetRd2EM04dDLuvotROD9klSYRPCtGQLhSjz7LOn2DcGY=
X-Received: by 2002:a05:6902:1104:b0:e60:8881:f30f with SMTP id
 3f1490d57ef6-e60b2ea0154mr14730659276.13.1741041664938; Mon, 03 Mar 2025
 14:41:04 -0800 (PST)
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
 <CAHC9VhTz6U5rRdbJBWq0_U4BSKTsiGCsaX=LTgisNNoZXZokOA@mail.gmail.com> <FD501FB8-72D2-4B10-A03A-F52FC5B67646@oracle.com>
In-Reply-To: <FD501FB8-72D2-4B10-A03A-F52FC5B67646@oracle.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 3 Mar 2025 17:40:54 -0500
X-Gm-Features: AQ5f1Jqy_h2drNZ3B3Ndvz9vb0FWWWRdqXZku_4aDPakn2BCROJT3md6UsPztks
Message-ID: <CAHC9VhR961uTFueovLXXaOf-3ZAnvQCWOTfw-wCRuAKOKPAOKw@mail.gmail.com>
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

On Fri, Feb 28, 2025 at 12:52=E2=80=AFPM Eric Snowberg <eric.snowberg@oracl=
e.com> wrote:
> > On Feb 28, 2025, at 9:14=E2=80=AFAM, Paul Moore <paul@paul-moore.com> w=
rote:
> > On Fri, Feb 28, 2025 at 9:09=E2=80=AFAM Mimi Zohar <zohar@linux.ibm.com=
> wrote:
> >> On Thu, 2025-02-27 at 17:22 -0500, Paul Moore wrote:
> >>>
> >>> I'd still also like to see some discussion about moving towards the
> >>> addition of keyrings oriented towards usage instead of limiting
> >>> ourselves to keyrings that are oriented on the source of the keys.
> >>> Perhaps I'm missing some important detail which makes this
> >>> impractical, but it seems like an obvious improvement to me and would
> >>> go a long way towards solving some of the problems that we typically
> >>> see with kernel keys.
>
> The intent is not to limit ourselves to the source of the key.  The main
> point of Clavis is to allow the end-user to determine what kernel keys
> they want to trust and for what purpose, irrespective of the originating
> source (.builtin_trusted, .secondary, .machine, or .platform). If we coul=
d
> go back in time, individual keyrings could be created that are oriented
> toward usage.   The idea for introducing Clavis is to bridge what we
> have today with kernel keys and allow them to be usage based.

While it is unlikely that the current well known keyrings could be
removed, I see no reason why new usage oriented keyrings could not be
introduced.  We've seen far more significant shifts in the kernel over
the years.

--=20
paul-moore.com

