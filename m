Return-Path: <linux-integrity+bounces-9634-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6F9ZO/gQEGrJTAYAu9opvQ
	(envelope-from <linux-integrity+bounces-9634-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 10:16:56 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B6B5B0694
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 10:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B8A76302E7C5
	for <lists+linux-integrity@lfdr.de>; Fri, 22 May 2026 08:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A5C2C032C;
	Fri, 22 May 2026 08:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="Z2kPyC+w"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FFE239EF05
	for <linux-integrity@vger.kernel.org>; Fri, 22 May 2026 08:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779437806; cv=none; b=ZULmulOT9mwaft9I50hKSgRNF2dJIYKomD6HHjpWtpiuLeDxtOYzMx4XOq8ShnM9rSlWzZjzdVs3j/hr4IivvNQ7PmqYlwqi3m+xhTioWDOYd8s8EsHWkziis5l9xWQxo/QR34J+cl+OivgGk0fFinmL1dyTVrwrBGuYL7PeE58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779437806; c=relaxed/simple;
	bh=4xr6TiUPW8v1GkJ2kQh+aF08s5fPR+TLtY9G5S+pan0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZu7Qnks7b0qdP4RUU/IlC+PbvQG2Be6IMYsPHxo4nwLSj6UwoEwEJSBYyNjW5VS/8kSVijkBVol0MbEtNoMHWodnM3ppRB7OOUNoo2PS1wxqtch6KKy5whITEjfKRuH8qfFB1vMAJ9AiuNo5CV7VFOc66kixJ0cAliFpqN9hxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=Z2kPyC+w; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-488a8ca4aadso68680295e9.3
        for <linux-integrity@vger.kernel.org>; Fri, 22 May 2026 01:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1779437803; x=1780042603; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3w5FjT/WZBxeuDvVvB7bWeB0eUVUUyftobEv50KkzpY=;
        b=Z2kPyC+wj+bezCgK81TqyXpH9deHhgbalx0zkveS5+3Ipm6yj4rVrvqaGlpDfX5HsU
         BIs7AznBPmj7fmQ6d/zMOXmSBOVt0TKK+Y57PneGFax1hs69ZfyfXcT1BpvH/cVKRnc/
         xM6XwDUdRR6wjaFInRJa4wcjVQP+JI4I4xybyWAegZTfG1E6vqc4aC4h00kqUU76vJRr
         XkCIGURQNTj55w2K1YuGsi1qruMUx3hmYXBQd+0RtEy3p2cUcG8CD6NEoFE88mpdH3CD
         x20LaDub6E/6JNlQXzzq7P/s+RdWhuZMPWrPHNos0g//dnbC6+RFvo6Cf7eVo8p7tyif
         g1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779437803; x=1780042603;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3w5FjT/WZBxeuDvVvB7bWeB0eUVUUyftobEv50KkzpY=;
        b=jZNP31dJ/oG+YaEDiTe2mKbPEyuK4mv7UpZ1kEIB+OXwybqsvTIFYB0jgXUybByjb9
         QzNAG2WcNKPETXdqNsJJDlCpwOR1bmLGuzOqZorRtaIW7VBsV7ulpBhsFCK0Ash4wEjC
         KetiEMZNVU665CuqEqvv2dTtowOyDFjtuvSOAzT5NqjOx55H0Q3YYYHT/IdhPLGmQDZJ
         F5xuz7eY1chiyHIetqTZOd1zm9KKR1Oy0rC0KipB+S2R1MHfM/oXB3PY0jno+YQbufIF
         gboBR4717/gwMUQodykGOeRocncoT/oozf0u9hwkszsyTH+Tz0j6ewKxKnmeASoE0Tn1
         5BJw==
X-Forwarded-Encrypted: i=1; AFNElJ8e9S6TknkZ3ehQ1Kpmj/QfrWxFTaLNWZxME7KP7jrXNl8uKMxedS7obmvwvEqUU3Yz1GEVhkF2PYGcmdkZWRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YybFgbBrUrauyZh49VC64jY0fdjo83Dt9ngfcVLO8pNkOM19BWj
	Bmc1B2K3uCv7jK17wEITAf/i1jZLy2G+cPPI2mdPXX5GtjFbyl8hP1v7wLflmB4h0lXwVUmtD24
	gfq5wvnU=
X-Gm-Gg: Acq92OH/RUvrriaBAD5F/3erAQHX6BmziBPgpiIt6Phtf8qp/yg5tng1tdbfJ3K8L2c
	PcbJ8srSoD67ntq3VyWCFrkmgVe2SvPe8bqqOUVFwYRSLsIN5HyfytdUn3km6eVi6/n6gUCbMhv
	7rtQ40/UTrFmBxCGkWSAXSuUV+lZP+wXZLMst4Tazr6qnsK1OUTMXryqcR35OTQL2UkLadHSqmM
	lqzGqo7BbuOvmkUVWDBv5M1nXBsn9olI0/Vxb8lVCTNRPBNHmApmqAwUtAvIY+2EZpN/je4z0Du
	RNzNCd6wUR3mM7BQLhqNvXi91ZIE5gjG6K6QASCuRyZ88Ntn2JlwWS6By62VdJqL72Zyaeu3vdr
	FCsR2B+qnVy5E/ct67MfhzOyOYFILWKADutMGvOdDwULzTLED1ttcOUnXo0UKmiRqAUyY4w4y4R
	NPXZ6MLPrNsWCJz2AC5rka1HGOdC+W3Q2mLlUMRhI4E0+WicXoiVQiLiL1a125ur/mlpdztOZ0g
	2aWgMftCPk4QEcDOd8hERpgkg==
X-Received: by 2002:a05:600c:a402:b0:488:a882:c7 with SMTP id 5b1f17b1804b1-490426ddc0fmr22001735e9.25.1779437802772;
        Fri, 22 May 2026 01:16:42 -0700 (PDT)
Received: from localhost (p200300f65f47db041c3ec60b7ac1bfbb.dip0.t-ipconnect.de. [2003:f6:5f47:db04:1c3e:c60b:7ac1:bfbb])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49042af0ac1sm10569715e9.31.2026.05.22.01.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 01:16:40 -0700 (PDT)
Date: Fri, 22 May 2026 10:16:39 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, 
	Claudiu Beznea <claudiu.beznea@tuxon.dev>, linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tpm: Use named initializers for arrays of i2c_device_data
Message-ID: <ag_vkHJjmCo_FFa5@monoceros>
References: <20260518134035.644762-2-u.kleine-koenig@baylibre.com>
 <ag98e88678TSfwxG@kernel.org>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ureockz27qr6vm2b"
Content-Disposition: inline
In-Reply-To: <ag98e88678TSfwxG@kernel.org>
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[baylibre.com:s=google];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9634-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FREEMAIL_CC(0.00)[gmx.de,ziepe.ca,microchip.com,bootlin.com,tuxon.dev,vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[baylibre.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[u.kleine-koenig@baylibre.com,linux-integrity@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,baylibre.com:dkim]
X-Rspamd-Queue-Id: 67B6B5B0694
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--ureockz27qr6vm2b
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] tpm: Use named initializers for arrays of i2c_device_data
MIME-Version: 1.0

Hello Jarkko,

On Fri, May 22, 2026 at 12:43:23AM +0300, Jarkko Sakkinen wrote:
> On Mon, May 18, 2026 at 03:40:35PM +0200, Uwe Kleine-K=F6nig (The Capable=
 Hub) wrote:
> > The union added to struct i2c_device_id enables further cleanups like:
> >=20
> > 	diff --git a/drivers/regulator/ad5398.c b/drivers/regulator/ad5398.c
> > 	index 0123ca8157a8..dfb0b07500a7 100644
> > 	--- a/drivers/regulator/ad5398.c
> > 	+++ b/drivers/regulator/ad5398.c
> > 	@@ -207,8 +207,8 @@ struct ad5398_current_data_format {
> > 	 static const struct ad5398_current_data_format df_10_4_120 =3D {10, 4=
, 0, 120000};
> >=20
> > 	 static const struct i2c_device_id ad5398_id[] =3D {
> > 	-	{ .name =3D "ad5398", .driver_data =3D (kernel_ulong_t)&df_10_4_120 =
},
> > 	-	{ .name =3D "ad5821", .driver_data =3D (kernel_ulong_t)&df_10_4_120 =
},
> > 	+	{ .name =3D "ad5398", .driver_data_ptr =3D &df_10_4_120 },
> > 	+	{ .name =3D "ad5821", .driver_data_ptr =3D &df_10_4_120 },
> > 	 	{ }
> > 	 };
> > 	 MODULE_DEVICE_TABLE(i2c, ad5398_id);
> > 	@@ -219,8 +219,7 @@ static int ad5398_probe(struct i2c_client *client)
> > 	 	struct regulator_init_data *init_data =3D dev_get_platdata(&client->=
dev);
> > 	 	struct regulator_config config =3D { };
> > 	 	struct ad5398_chip_info *chip;
> > 	-	const struct ad5398_current_data_format *df =3D
> > 	-	                (struct ad5398_current_data_format *)id->driver_data;
> > 	+	const struct ad5398_current_data_format *df =3D id->driver_data_ptr;
> >=20
> > 	 	chip =3D devm_kzalloc(&client->dev, sizeof(*chip), GFP_KERNEL);
> > 	 	if (!chip)

[redacted the example as it didn't compile as presented, added "_ptr" on
last hunk's + line.]
=20
> > that are an improvement for readability (again!) and it keeps some
> > properties of the pointers (here: being const) without having to pay
> > attention for that. (I didn't find a tpm driver that benefits, so this
> > is "only" a regulator driver example.)
> >=20
> > My additional motivation for this effort is CHERI[1]. This is a hardware
> > extension that uses 128 bit pointers but unsigned long is still 64 bit.
> > So with CHERI you cannot store pointers in unsigned long variables.
>=20
> I don't understand why any of this should be merged to be honest and
> why I should care about CHERI when reviewing mainline patches.

While I think and hope that CHERI will become relevant for the industry soo=
n,
it's ok to not care about CHERI today and I mostly mentioned it to be
transparent about *my* motivation.

Our eventual goal is to bring CHERI support to mainline linux so my team
mates and I have to find a way to get patches like that in. In my eyes
this compares well to PREEMPT RT: With that you have to follow more
rules in some situations and implementing these and running an RT kernel
makes bugs pop up that also affect mainline.

So I claim that working on CHERI is obviously beneficial to folks who
have CHERI hardware, but also helps those who don't as CHERI is a way to
easily spot a relevant set of bugs.

> Clean up can be side-effect but not a purpose.

Oh, I disagree. Having code in a state where you can easily see what
happens helps to concentrate on the parts that are more complicated. So
it's a win for maintenance and lowering the entry bar for people who are
not used to Linux kernel code. There are parts in the kernel that are
complicated, and we won't get rid of them, because operating systems are
complicated. But my POV here is that making it easier where it's
possible is a good thing and a reason for itself. You might call that a
paper cut only, but these add up.

Also with the union in i2c_device_id the compiler warns you if some code
is lacking a "const". So it becomes harder to make mistakes, this is
also a reason that in my book is good enough for itself.

Best regards
Uwe

--ureockz27qr6vm2b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmoQENsACgkQj4D7WH0S
/k45kAgAqkAkvJVYFJvmCb/Ow6OtCLbDmgMC4pHbX+AFjY//4ZasznV3eliwAL0U
JO2SE9QCUPVHR3X2kJ5vHU8M9O3tH5UTd3sIoCClyfAvAvHznK1aNc5tL3EMkZs+
//OcE3tbopZobdoqZk5TW/zG1NO9JD+RELeeG0bZSFIjoxCxb6u4CK6e9RnkZpfZ
yICl5zzDrpjm0/DZCz3Te4S2CTgSm0Bnt9QqBaQLLyzu3KpdI8zzwC2O+hrJRY38
TCabhRp55hin4KsVspCZoyGvf36029DKTSeN+LlFZfjuecW43z6eh9YJL3rurCAu
bOM3HPSHoo/xqjKlSmLHKx1hXwks9Q==
=ePXN
-----END PGP SIGNATURE-----

--ureockz27qr6vm2b--

