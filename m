Return-Path: <linux-integrity+bounces-9657-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOWOOLn5E2puHwcAu9opvQ
	(envelope-from <linux-integrity+bounces-9657-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 25 May 2026 09:26:49 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A694C5C71CF
	for <lists+linux-integrity@lfdr.de>; Mon, 25 May 2026 09:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 080F7300101B
	for <lists+linux-integrity@lfdr.de>; Mon, 25 May 2026 07:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9C43D1A98;
	Mon, 25 May 2026 07:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="nBaY/qZe"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FBC36E469
	for <linux-integrity@vger.kernel.org>; Mon, 25 May 2026 07:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779694006; cv=none; b=KwMYBFJeTsAjR7sVCIBTRlqommYn775HLgdyR9yJw2lKptdqHfjqoJQSJieXpJtFyYU6HVZMJTb6WAvwtGdO2euEgNyoOce7hzBX2FmEvvL6VrLHYg/gs/Ro6dv/LXPY9W1CqSDgG34UBAGmOTOpsRkYTERBggp4yAhOtSrWHwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779694006; c=relaxed/simple;
	bh=VUGI187LbyURwGio3hctbiSTY5kdZTW5jVv9fi/0Ru4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pScPv7u24YrE+3oU2EZhN4eQMBDa4uHdGRqBOSO9bZzyn03fNfyYDaSMLBJzm+M/aifjcaCm6z14iQ2BE13E2OJ++6L4RuwnxwDdiqtb6VOzjTbh451yvccMZIIZS+of2hO/iW8rNh9fiRGGtPZtiJr4exvTfCOtrPUzqRZVqJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=nBaY/qZe; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-459bf19e87bso5351778f8f.1
        for <linux-integrity@vger.kernel.org>; Mon, 25 May 2026 00:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779694003; x=1780298803; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VUGI187LbyURwGio3hctbiSTY5kdZTW5jVv9fi/0Ru4=;
        b=nBaY/qZexASnj4DXB71/ziGDnQUTp2oC+/nzYMVMAlK3fqQVVbzDAt4uWvudp+0znl
         SK5gyfLB/6l2cqy45JJ40WbEPUFnsPo0w+igp5XEYAklCbbh+dAsg0YLs/17HmTeRoIy
         2sLZl5KOV56zqrf4wqNguFjVSnqc6TwgQy0gV0/XP2sU7ekFGofJhmL3Y8f+5LEU+sh2
         Dawd8zjt7HAAWCKYHYJbtVn5Mx4Zw80UcDlG9Q9qwpY8USmnyY5bAAzDG+/93rCOn1de
         vr4Svi/pTl4Hp6LPgBMPbLPM14aNEHtKdSL3pEXUIFP0+UPjsVSxQhMzjjauUZe9Ee/a
         Z5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779694003; x=1780298803;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VUGI187LbyURwGio3hctbiSTY5kdZTW5jVv9fi/0Ru4=;
        b=YYeD22bts7AR/ODXaP9chzqH+udnAsCFjXqdOZTnZ/arIQN5rLfHNRrgM1zn0gpl1Z
         5GvPyooQNveF9j+D2pZrUADPTUhRiA1Wf4o5qHO6kG0JRyq9kkNvuUlrBo/BygqJkbwW
         QsCe175UeQK2Tw+2eb/HDHj+AccNihOX28hL3A2nZW4RpCNwNAHe4V1ojpY//0ldGVxw
         YatvXDl9KpPQzt68Ph0FoMCXkloCWO2gcUDD/k8ugFTJOcL8EdwwuLv16emLbnAWsO91
         ax+CiiHUBlP1Ykqj5hKYo9poqLyTFmkPbHwXTlw40am4KqSjz+EiEOx+RV8d3VFkqGM9
         zrwg==
X-Forwarded-Encrypted: i=1; AFNElJ9SHnnLa2j0lCItHhWQly0saRaWgqMef7eUxRti0DmcLEQJ3cdumeU11IF/XE6M+blT94vkTqfqSmIPa0Lr4vo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOehyWtsjx6VaJv1HFq2Bihkd/c6aqUWeECrQmV1ZzxdtXOHa7
	i/d7z5bG8VTyxY+p3MVzVyQTMIlvYxF6M/R2YtZx2x19MlJOgyYf2qBVv5fgmTrRNnc=
X-Gm-Gg: Acq92OH1SC2UoE6Ertz4Cmps7jQp1HtqHPls1GDwoHQ3/6emLK/9GmnMiwyQu+1JhIY
	Jx7c5/RQb9YScn5Wu17LmVOSeZA28j1wZgeA7YR+LOFN0HI+efUfe34uGVq1wqwaHDPW4YrGmky
	EU8dMgzCgglk9PtYZdUM69iuwmNgC/wQNSbVcJm4zUMw/d0AdvApldLOBM5XjrJUaK0+5aP3QGc
	CmCcYgBnf39f09TBQW21KMBHSyfav9UvSf4chqi0jKJmd05sBBMAKVDk0IidsPvDAnhjanK7wo0
	0W5RlVf80A3kHyVnG2knWSu83vYHppYTggRrUM5k1amlHUleyJrfyGoJxpuy5R66cBXoNYNPG0G
	SHEJLcidnS0vGDajehLx//L4YkzsNchYnzzlaj3MrXLPjzvm39Mamh21C75Ba05QIhA6nK1U4f1
	8L0wPUo869AWl4ecS6O7FeRqDN3FKJ
X-Received: by 2002:a05:6000:2c10:b0:43d:7a97:78b5 with SMTP id ffacd0b85a97d-45eb38d63a7mr22301124f8f.33.1779694002754;
        Mon, 25 May 2026 00:26:42 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-45eb6d47b82sm24823111f8f.19.2026.05.25.00.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 00:26:41 -0700 (PDT)
Date: Mon, 25 May 2026 09:26:40 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Use named initializers for arrays of i2c_device_data
Message-ID: <ahP3V5viwMtnH9PC@monoceros>
References: <20260518134035.644762-2-u.kleine-koenig@baylibre.com>
 <ag98e88678TSfwxG@kernel.org>
 <ag_vkHJjmCo_FFa5@monoceros>
 <ahBPlW1l2RAdxpT6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="5nopveidoqhxaoas"
Content-Disposition: inline
In-Reply-To: <ahBPlW1l2RAdxpT6@kernel.org>
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9657-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,microchip.com,bootlin.com,tuxon.dev,vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A694C5C71CF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--5nopveidoqhxaoas
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] tpm: Use named initializers for arrays of i2c_device_data
MIME-Version: 1.0

Hello Jarkko,

On Fri, May 22, 2026 at 03:44:05PM +0300, Jarkko Sakkinen wrote:
> On Fri, May 22, 2026 at 10:16:39AM +0200, Uwe Kleine-K=F6nig (The Capable=
 Hub) wrote:
> > On Fri, May 22, 2026 at 12:43:23AM +0300, Jarkko Sakkinen wrote:
> > > Clean up can be side-effect but not a purpose.
> >=20
> > Oh, I disagree. Having code in a state where you can easily see what
> > happens helps to concentrate on the parts that are more complicated. So
> > it's a win for maintenance and lowering the entry bar for people who are
> > not used to Linux kernel code. There are parts in the kernel that are
> > complicated, and we won't get rid of them, because operating systems are
> > complicated. But my POV here is that making it easier where it's
> > possible is a good thing and a reason for itself. You might call that a
> > paper cut only, but these add up.
> >=20
> > Also with the union in i2c_device_id the compiler warns you if some code
> > is lacking a "const". So it becomes harder to make mistakes, this is
> > also a reason that in my book is good enough for itself.
>=20
> Actually what I said is more important than ever before given AI agents.
>=20
> If I start to accept pure cleanups from humans it's like invitiation for
> slop. This is actually an area where it would be advicable for any
> maintainer to tighten the acceptance criteria.

I also disagree here. If a patch improves something (be it security,
runtime behaviour or maintainability) that should be reason enough to
accept it. If it's created by AI (or a by a newbie with the help of AI)
that's a reason to make sure the patch has the intended effect, but
that's essentially the same for any patch.

I agree that AI might get problematic if it floods maintainers and
effectively becomes a DOS attack to maintainer resources. But that
doesn't necessarily makes the patches it proposes bad.

Best regards
Uwe

--5nopveidoqhxaoas
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoT+aoACgkQj4D7WH0S
/k55kAf/WirBb5saUL7Ev1pLCl0q58GbEQKdqUbGyrvbSGc8cYglVsjopgwdVjFp
ymNsegq7ZumAxs1QumcIGgBgJTXh4eKCr9zk1FHJFQRoTQuXoEbTwXjgXsXlz43J
P48HBaRfkRQtMIAuvnhE8pfEW7KJIABItUfU+kigDHRHTqXJ3TscK+b8MosASlKa
Ov+7gbB4C8G68C0+TWv7gF/6rOqDERrUyC4DxbODXEN4GJubP4IXA3JyhZBAGrb8
gNxvnxN6OilwrQdTwoBLLUy/mrVsO/yu/R3a49aAa1EBlQrHPeLCoJ0YfoCe5MY/
Oj9A1we/OkHpCZteDY4mRxrhwhBtaw==
=Y5x4
-----END PGP SIGNATURE-----

--5nopveidoqhxaoas--

