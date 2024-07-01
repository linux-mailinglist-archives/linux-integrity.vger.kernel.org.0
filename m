Return-Path: <linux-integrity+bounces-2960-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A265391E820
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 21:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D402F1C21C90
	for <lists+linux-integrity@lfdr.de>; Mon,  1 Jul 2024 19:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A1B116EBF8;
	Mon,  1 Jul 2024 19:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="AHmdnpuj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82C315DBD6;
	Mon,  1 Jul 2024 19:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719860474; cv=pass; b=ex/HgGqDFi1qVv1oWnzM2aElM5TCPbOlEjqoWgeBpcmhgSXEBjx3K0LQTpaeU0R8Kww8mhocG284MrxZwATO4UYB+hZq40ROUPijEXqMljm+H1DHAKFwew2P3/arlQ+g3j6YqiHdQH/soAykceuWqXsSpGEfFMUX2bBJjRGkW7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719860474; c=relaxed/simple;
	bh=16Iug4X6vDTiEMG2MnMQffFlRMNdyP9SlE5oswGewJ0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=gbJ4jsYl7RSAVcST8rTB/m/qGYe3yhfGnVxW2CjBqVtagBubkBIR59ZwAGzXM4FLtKxDB3g8ybo8RQeSiOD3+zNq/POcYH+I8vVTEm7QBVuLN6kbgpYrseZESCOzRYYbIyBmV7h8dioC8l5YgnLAysRQcdNSM3pFhZJUkPaRNkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=AHmdnpuj; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from localhost (83-245-197-232.elisa-laajakaista.fi [83.245.197.232])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4WCb3m67tPz49Px4;
	Mon,  1 Jul 2024 22:01:08 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1719860469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UFdKNGhm4fd8mnyMx9lxPsPdnIHGKCX9D2T3jRpMtYE=;
	b=AHmdnpuj8lmOtNhL3gAT8QJLEvyjQEUuoZBoVBkA4WgW73DHusAH5w0OqP80s1n02VXeQ1
	1gMFlEptPp2M4kmowJwlJmRmVO9Pr5O+GIkWJaGhigJrQblMRu+TfIEl07Uh5Z0BfQO45Z
	B9nRUF5zjNHmgcgw2qHn6kvmyrB2kyPdX18ivLNxmUbPJjFr5XtxKxhp865UwMcwFASO7H
	6bldFr63vqXWH5eAOsZ6F19UgGrxqZLIXYM8yzu6dfy17zTNaBHTMSMyCSg14NbDe6B7rG
	92tyiypkuA/I/4MW8CPtmRIszhFCh4nurRpWdAaWLfumOxZaIlITcnsyPsyIiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1719860469;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UFdKNGhm4fd8mnyMx9lxPsPdnIHGKCX9D2T3jRpMtYE=;
	b=FXdDSELbvygc9gHUh3yf7nk6ZqCnWoTOduv/JYdx14r4rIQpOSbBgwj9kZZjoMZJH8oo8p
	tYRATjKIjl/NO94nEqnaeWl46O9371lewkx8amRioASmUvsR0AHDDzeYqeXVkcWR/x7xOD
	Utg5WzlhNU6L8sKJJeT9N/Yf2MXnDlefQWwiziUH/qBY4iOO0voenBz4TFn275tstwJq+N
	jpnLzaYEEtUXs132EDCdQctWTtZWn/3Jfq4VljE0omm4d/1OhujvA3HEQZphFz2ERPuwIX
	/VEX33vlp+DhZEpegPyPqzThzk/r1GQcO2HDMzRgUl1MnjFAwpVEw6nEa+F0ZA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1719860469; a=rsa-sha256;
	cv=none;
	b=euy5uRNFCw3n+A+4ytH7y3KTDtLNi1T7vNWTo/z60oI1vmplp8hKBnCkGRixS1wjyxySjX
	Vv04H+Qd3uxY++tIFJAmF7JrkVXTd9/hi2LsICWY8WmCn78DhF8wck/nN5xCnJsc2Xp77P
	MffjvI4nGyxs2TSiAaJCSIFm2rIKm6H+AjXe8v65ukQoXRFD/GtyfnJbSlvhOuvD0y3ekl
	I1xgux0IZdV9KQY/0AA8rK47eG5R1V2/j9MifSGwYw6ztI8tCWFhrtYVonddJ5cOKQa0Yq
	JerJCbJPwh6JnYmZd0c9evU+PURs3m/2Po6JojHOETtFXvmcLLdO2e5SgY9IYw==
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 01 Jul 2024 19:01:08 +0000
Message-Id: <D2EFNJTR80JS.1RW91OVY1UH1N@iki.fi>
From: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>
To: "Stefan Berger" <stefanb@linux.ibm.com>, "Jarkko Sakkinen"
 <jarkko@kernel.org>, "Linux regressions mailing list"
 <regressions@lists.linux.dev>
Cc: <naveen.n.rao@linux.ibm.com>, <linux-kernel@vger.kernel.org>,
 <linux-integrity@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] tpm: ibmvtpm: Call tpm2_sessions_init() to initialize
 session support
X-Mailer: aerc 0.17.0
References: <20240617193408.1234365-1-stefanb@linux.ibm.com>
 <9e167f3e-cd81-45ab-bd34-939f516b05a4@linux.ibm.com>
 <55e8331d-4682-40df-9a1b-8a08dc5f6409@leemhuis.info>
 <9f86a167074d9b522311715c567f1c19b88e3ad4.camel@kernel.org>
 <53d96a8b-26ef-46a3-9b68-3d791613e47c@linux.ibm.com>
In-Reply-To: <53d96a8b-26ef-46a3-9b68-3d791613e47c@linux.ibm.com>

On Mon Jul 1, 2024 at 6:29 PM UTC, Stefan Berger wrote:
>
>
> On 7/1/24 11:22, Jarkko Sakkinen wrote:
> > On Fri, 2024-06-28 at 17:00 +0200, Linux regression tracking (Thorsten =
Leemhuis) wrote:
> >> [CCing the regression list]
> >>
> >> On 20.06.24 00:34, Stefan Berger wrote:
> >>> Jarkko,
> >>>  =C2=A0 are you ok with this patch?
> >>
> >> Hmmm, hope I did not miss anythng, but looks like nothing happened for
> >> about 10 days here. Hence:
> >>
> >> Jarkko, looks like some feedback from your side really would help to
> >> find a path to get this regression resolved before 6.10 is released.
> >>
> >> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' ha=
t)
> >=20
> > Sorry for latency, and except a bit more slow phase also during
> > July because I'm most of this month on Holiday, except taking care
> > 6.11 release.
> >=20
> > This really is a bug in the HMAC code not in the IBM driver as
> > it should not break because of a new feature, i.e. this is only
> > correct conclusions, give the "no regressions" rule.
> >=20
> > Since HMAC is by default only for x86_64 and it does not break
> > defconfig's, we should take time and fix the actual issue.
>
> It was enabled it on my ppc64 system after a git pull -- at least I did=
=20
> not enable it explicitly. Besides that others can enable it on any arch=
=20
> unless you now change the 'default x86_64' to a 'depends x86_64' iiuc=20
> otherwise the usage of a Fixes: , as I used in my patch, would be justifi=
ed.
>
> config TCG_TPM2_HMAC
> 	bool "Use HMAC and encrypted transactions on the TPM bus"
> 	default X86_64
> 	select CRYPTO_ECDH
> 	select CRYPTO_LIB_AESCFB
> 	select CRYPTO_LIB_SHA256
>
> https://elixir.bootlin.com/linux/v6.10-rc6/source/drivers/char/tpm/Kconfi=
g

Yep, it is still a bug, and unmodified IBM vtpm driver must be expected
to work. I was merely saying that there is some window to  fix it properly
instead of duct tape since it is not yet widely enable feature.

I was shocked to see that the implementation has absolutely no checks
whether chip->auth was allocated. I mean anything that would cause
tpm2_sessions_init() not called could trigger null dereference.

So can you test this and see how your test hardware behaves:

https://lore.kernel.org/linux-integrity/20240701170735.109583-1-jarkko@kern=
el.org/T/#u

I'll modify it accrodingly if problems persist. Please put your feedback
over there. I cannot anything but compile test so it could be that
I've ignored something.

BR, Jarkko

