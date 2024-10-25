Return-Path: <linux-integrity+bounces-3911-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 421B29AF5F3
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2024 02:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565DB1C21237
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2024 00:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3008923AB;
	Fri, 25 Oct 2024 00:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="Z9JGRhwZ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92481859;
	Fri, 25 Oct 2024 00:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729815080; cv=none; b=bgYbBOo3zTziAB7/dkpG2sM/GlZJ3jX0HhALhKaHDpBH1RCeuSkI59C0HGBHofumS8doWbeSVzG8rKnhHUcOolWyCoJvKTjTNt19xc/MSRp6EWwadOH/y/aC2DQTRKeGaEGhGk4W27XsWtVWcp2CUr3MSFYG96vmoq2PLyH6WfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729815080; c=relaxed/simple;
	bh=8KusYx+RHJMTU21LdOIcRKa3lfznJXVCXXS7fB80TKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i+Tgtw0Nt0qwAmoA9I12pB+GgPRGb2Z8hg5HL4pKdgyGKQGM95FGro6dTlzOeXDmH175YwyTrnW3vgY6VA/qW8UX6gGmUUTzoF0B0h1FOUUEv86cTIG/mUg5aachSfNbLjvfxb5tdmAmn+xiBONVN7vJPLX3bMq8JrKA1ckbQew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=Z9JGRhwZ; arc=none smtp.client-ip=212.227.17.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1729815065; x=1730419865; i=christian@heusel.eu;
	bh=0YLl7MfTCMROivBkVhz/S8UqG5gQEiGAZl8EPHKXjA8=;
	h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:
	 MIME-Version:Content-Type:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=Z9JGRhwZBssFRPS1GeM17+bdihGoFAg05XOselLvmQQpNn7dFtXml/rQXpppjg4R
	 7Oa1VCtVuqfCG6uz2EEtkAEGX0yktEZPI6uVYlQY2JRZ5MOhUBOPGhTy5ZJnZUx90
	 9TM8PjjPtup6K9GnNqoFX6dHNvhuE6R4OkxU0j9ABqhnioXjKvrylmcTNf2HDbT7O
	 RQcptABS+WrcLeCe+/rb0YkbwE5T3r9o3EGs7xlnWp2LVGHm6vS1wXgE7M2bBGl1+
	 MvH7UFKud3phpSDLYN+1vxPSFIFN/EI5aO7/ZHsBPmCejfK/Igzdd8NfBXraE8HqV
	 /aYH58c9yd7fXvJyLA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from localhost ([141.70.80.5]) by mrelayeu.kundenserver.de (mreue109
 [212.227.15.183]) with ESMTPSA (Nemesis) id 1MStKq-1tSmcJ0u2I-00XOI6; Fri, 25
 Oct 2024 02:11:05 +0200
Date: Fri, 25 Oct 2024 02:11:04 +0200
From: Christian Heusel <christian@heusel.eu>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, James Bottomley <James.Bottomley@hansenpartnership.com>
Cc: linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org, 
	regressions@lists.linux.dev
Subject: [REGRESSION][BISECTED] tpm: Popping noise in USB headphones since
 1b6d7f9eb150 
Message-ID: <7d052744-4bfa-40bc-ba06-1b4c47a5eb87@heusel.eu>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="hyqovalspjnbywsu"
Content-Disposition: inline
X-Provags-ID: V03:K1:XHGnoMCjI2jsjpR4Yyc+j23yPeYMuncudwjVOVMogyqc4Iu4J+E
 l9bh1wnuyfcIkOZti8S1YXqH8TVeqrfJThJa81iDhietfAYtfmyG7iwDRpkDZm+R88wg0If
 xSFj4odHA7CTtI/7H6jC05kSjb3X+9CCLDomK18kL/wqfONzzlEf7r+oQDxfqDF3OOOWwke
 Cg/k3gVTDOMKgT61t2a7g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:X61aV1cTQzU=;evD4zKSkyCM1UpKtmKpPSp0fR2F
 kLr5JbNCP7aD8IgsPpequ0jaxmK1dyTsiaQPOaZGSz/l2/hRct6ptu/4RX3fi5MOI91xjWZMc
 SBkPFiGyCTemteOz3xZFWAs6lChnxxg+LjiAWMx9dLNZyHzlFo5RnqlSVCfhhyQh3hgTWfYD2
 hZHb3fMu3QC278K0Oc58HIFusWmA1Wi7xPnwGAMAjmjl4+51MsZhZgWRKOko0KfVVDHjuF+/T
 9jzKBrEC0NdOcVW16pV8P5oqP0TXixCU35UdszDIqc4o5IxmRZbRoB5Z7JxcRM8rPf0uAxaph
 66+0TgUo0zmJsMcSn0PJbZGlh3gu8V3CBhYQDUhuGHK1i1tmRI9x4fmAaKukURogKBVIQQ8JL
 J9ohx9EaljilFltoLTEL4v95aTdsaaqJrd6FNT07+U+lBZc0HChucZUgar9CpoyRP553SEfOk
 LvwkFCveE4fbJLhm3p1ZsTjPESnz/NcKOmstMDOg3ghTwWe/fk7l29BGuPvRMApkVqaYA4Vmw
 lt0h/D+gLnS7v9orj8BTRUEV1KWeSAxO3IKtPpztk7l3tiymViruVgqci91U71xzgYt9pXNjF
 XZr82gyeOp3gRT4ZNCZYnpCRfS4s1oWwiRGRuKnrL89Nb8oa5ecbXUT8nPZ55pTl9MV6wLO4+
 johqxPJZClafRzkP1n6olEY3NTergZ5ndv0l7q6xXYBMtPQjqmuk3KXnMO2G9MA9VrporAnu2
 ihvOrx+WdlaFLRUUcCwD57Wf495LoVJ9Q==


--hyqovalspjnbywsu
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [REGRESSION][BISECTED] tpm: Popping noise in USB headphones since
 1b6d7f9eb150 
MIME-Version: 1.0

Hello everyone,

Adam reports that since switching to the 6.10 kernel they have a popping
sound from time to time (roughly every 10 minues) on their headphones
which are connected via a [UGREEN's 5-in-1 USB-C Hub][0].

We have then done a [lengthy bisection][1] on the mainline kernel which
came to the conclusion that the following commit is the culprit of the
issue:

    1b6d7f9eb150 ("tpm: add session encryption protection to tpm2_get_rando=
m()")

Since I thought that these results are likely not correct Adam has
verified our results again by re-testing the bisection steps and again
came to the same conclusion. Additionally I have shot the same question
[at Jarkko on Mastodon] to find out if it's possible that changes in the
TPM subsystem can have such an effect.. Without knowing the exact commit
we had bisected to he pointed to the same functionality:

> Jarkko Sakkinen (@jarkko@social.kernel.org):
>
> @gromit i might actually might have hunch for this but have been
> unmotivated to move forward before these patches are merged. One thing
> at a time IMHO, especially with performance fixes.
> NOTE: this is a hyphothesis.
>
> tpm2_get_random() needs to be reconsidered with encryption as hwrng
> calls it often enough and there's now more overhead.
>
> It pulls entropy in small chunks subtracting the length in the look
> like you would use read() syscall from user space. This is not right.
> This leads to small and variable size exchanges and yeah generally
> that equates to an inefficient implemenation with bad latency
> properties.

If there are any patches to test or if further input is needed from the
initial reporter on our Bugtracker we can do that!

Thank you all for your hard work on the kernel!

Cheers,
Chris


[0]: https://uk.ugreen.com/collections/hubs-1/products/ugreen-5-in-1-4k-hdm=
i-usb-c-hub
[1]: https://gitlab.archlinux.org/archlinux/packaging/packages/linux/-/issu=
es/79#note_210599
[2]: https://chaos.social/@gromit/113345582873908273

---
#regzbot introduced: 1b6d7f9eb150=20
#regzbot link: https://gitlab.archlinux.org/archlinux/packaging/packages/li=
nux/-/issues/79
#regzbot link: https://chaos.social/@gromit/113345582873908273
#regzbot title: tpm: popping sound in headphones connected via USB-C

--hyqovalspjnbywsu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEb3ea3iR6a4oPcswTwEfU8yi1JYUFAmca4hgACgkQwEfU8yi1
JYV65g/8D7BbnNUC1vdgjd2YHrXu4QakYdAq/BX5W+CR80lJ2+gKH3Zc5uK8uyMv
eEAt63W8TXJicV+gch6xiVgB/7rg3FBXBfOcV7HbNqLvrIy9ijkWzWRnw922kC6P
QZkyc30/7k8B1UkiPTho4rfvsChhUHOf/B3IhpdPT5vSDMU++psQpFS+Wcb7DrxI
acBATpgRdh/hb7ZOyQVZ8rQAVtaLw7GFrlDzSOof2OKLAnCfqXL88p21LfD4/twl
dhti8J5SlE4S6Xo8z7UK5F/lSO+Mxd9CZy3Xr41YWrCFz2T2DyQGUptCVp7ke8Bd
9Hf+VDYLTmAVV3aEfQdygErBIahwi7rOML24LRseFeJkWBDerNcwE7dyVrFcOSXP
95PkG3TMTCOnxhhvw6oVgAKYmYa9f0hkuinXbN8EfY4LAqd+xnMfP1lhoRgVSHpk
2KETCWfHOwNU6Bgsjbtn+Qeohrl0f9QPxJvCfkgrlD/t1PDuVtwCxCD+/AnVijJc
bGMO5OpMuKUPN0R3sueHTlwUBmhgIIQnuL7epgyRSdOoRSSMa9MBPhHfWDDLfRi2
+rVmfLWwH38nZFoIv9ZwWmCdURH2CvZ3J5QIiOmWBS1AY9zfvw71Z1FJX4gXfyFv
iAOYad+ph9LFyZNG0SjG41MooCy6j85A8+iayWqA2kHhOx3TcN0=
=pkob
-----END PGP SIGNATURE-----

--hyqovalspjnbywsu--

