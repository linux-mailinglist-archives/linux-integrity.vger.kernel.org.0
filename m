Return-Path: <linux-integrity+bounces-3159-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3621F933C3F
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 13:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26E81F23CAD
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Jul 2024 11:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DAA14A097;
	Wed, 17 Jul 2024 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="KkGrP6yc"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BEFBA4B;
	Wed, 17 Jul 2024 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721215659; cv=pass; b=u8LbHRImUso5TuEF5gXXLbbzFzr6aJDr8Wzaz2FwgucO0I1oYTy/sHrzEXZjDwrMQ60BkJb+GNgQNzOx+EDS3n8Pr80bGFcRfoLr5imQiofpRWvppu/0XZ0s8WB+bLUoq3fiaB3UnsDIZmB7F3xfX4prT43/zTBvvY5GlO4eaz0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721215659; c=relaxed/simple;
	bh=QBwcm5iJ4MLetmXCTuzrWX/DfOEOXa+hoiaY70Oc+Xs=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=eT3Qebu4wGTJ1kXk1bkn5UeZ8Ti/ju4FLpQZN6cMkpT6NpmXKpxmMOwjf1OwXGP7647cD+6E2YhU2M9bzjHvoTRbyZCR490//YnGj1PiGqqYwKG/ASmp/c0j2pYpX+rYmCiZQYAKucvdTcQzyE8IWhm5LNvGIEXBN8MLNyhu6x4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=KkGrP6yc; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Received: from localhost (83-245-197-232.elisa-laajakaista.fi [83.245.197.232])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sakkinen)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4WPDDw3ljNz49Q5d;
	Wed, 17 Jul 2024 14:27:28 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1721215650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QBwcm5iJ4MLetmXCTuzrWX/DfOEOXa+hoiaY70Oc+Xs=;
	b=KkGrP6ycd8DcVgI63/M0TVx/m8Y9LSMA5FIT+SqTwuE0QtmucneYVbWOAJLrkxRyIwaBpL
	4zkzIGXtXcdNqljkhxa7x4hvc8cc/J3rEeKTKRLe1oDsKaLWtxIvF/UjGXSgI7H1lzR47h
	kN6lxtjKdl2Q1xLfiWBWXSEot7Di+teFG7KPSb1afbnisAFN2uNnthnPyCSZHWXD1csgQ2
	/F/P++FnNZS9dhkidQd+tOUDTdtU7lj0VucYmhJXXSzDrW2D+Br/xSyftEaueMKoLxa6Ey
	I8FkuVkCvTzxCzoGtO5jkqzVmNbqdVRSx+ngJHxsr+2y1X9JyPu/nWCK74pV4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1721215650;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QBwcm5iJ4MLetmXCTuzrWX/DfOEOXa+hoiaY70Oc+Xs=;
	b=l7LkrQo4eT8DkaJSjtEkgW9Wa5p7g8nNxaT2KpXNnwsRD6il+NC2Mv+XHxoCQJOE/n+P4E
	qcTtmvpPqcJSRXH4239IE7Kn8QpxUFZV/jJoHyxCM1z/BoLjIj5qFP/ceZ1oLJ2o+zDV5a
	p2SYx3J1fflJ0xqeUZhWgWrvtR7ZiXr+ULbl5KNoIeV8iPpWt+ooNd0PFI0iKoZFgumwIS
	9HVpL4R2LgPNcZ7foUiF+xSRJq8wiJPBt85k2V+N9q3I2QN5sr5iqRhHR7T9z9CAceN3vH
	8m1gezSMjNZvlIZDAjbP1qiYcjqOah0O5vqOO2A8DAlqmnHllsT3xuGbxLNifQ==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1721215650; a=rsa-sha256;
	cv=none;
	b=wN/q/HmHadc2e4bVyCqzQAES+W3ubU9j7/rKzXfJfuycjh3aUDfskAapXW67QfsBub4Olg
	IrVuMmGnyU6y0COaN3Ktu7esX3NIGl9vhkPGCJQnCffQXUGgwWmY/f0ah3qcOyIHfp9S7W
	7vCY0tIM+aHagbA8PnGOQb4DDme1qQoIpRMsIFiGjp02/CVbPH3uF8egnxs5xLrYLpG2M2
	J36qwyLwtfa4Gd1gnruW+ira4XlPnDoTeCKxktns/+8yY85/ZqeLDbTRcTDii4F8ZclNWL
	Z791yuSwgNWZ9/K9bTN1pEA0+xxoa305D6EmYdldMF79faLlrcRoDeLBzKWn3g==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=sakkinen smtp.mailfrom=jarkko.sakkinen@iki.fi
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jul 2024 14:27:28 +0300
Message-Id: <D2RS0WWX03O1.2BBRF131UTSXC@iki.fi>
From: "Jarkko Sakkinen" <jarkko.sakkinen@iki.fi>
To: "David Gstir" <david@sigma-star.at>, "Jarkko Sakkinen"
 <jarkko@kernel.org>
Cc: "sigma star Kernel Team" <upstream+dcp@sigma-star.at>, "James Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Mimi Zohar"
 <zohar@linux.ibm.com>, "David Howells" <dhowells@redhat.com>, "Paul Moore"
 <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>, "Serge E.
 Hallyn" <serge@hallyn.com>, "David Oberhollenzer"
 <david.oberhollenzer@sigma-star.at>, "Richard Weinberger" <richard@nod.at>,
 "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
 "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"
 <linux-security-module@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "kernel test robot" <lkp@intel.com>
Subject: Re: [PATCH 1/2] KEYS: trusted: fix DCP blob payload length
 assignment
X-Mailer: aerc 0.17.0
References: <20240703125353.46115-1-david@sigma-star.at>
 <D2RQC1H7N1JI.1W4JT8FI0R8L4@kernel.org>
 <CE5319C4-F81F-4C70-AF74-B0B32DC60CCE@sigma-star.at>
In-Reply-To: <CE5319C4-F81F-4C70-AF74-B0B32DC60CCE@sigma-star.at>

On Wed Jul 17, 2024 at 2:03 PM EEST, David Gstir wrote:
> Jarkko,
>
> > On 17.07.2024, at 12:07, Jarkko Sakkinen <jarkko@kernel.org> wrote:
> >=20
> > On Wed Jul 3, 2024 at 3:53 PM EEST, David Gstir wrote:
> >> The DCP trusted key type uses the wrong helper function to store
> >> the blob's payload length which can lead to the wrong byte order
> >> being used in case this would ever run on big endian architectures.
> >>=20
> >> Fix by using correct helper function.
> >>=20
> >> Signed-off-by: David Gstir <david@sigma-star.at>
> >> Suggested-by: Richard Weinberger <richard@nod.at>
> >=20
> > You cannot suggest a change that you author yourself.
> >=20
> >> Reported-by: kernel test robot <lkp@intel.com>
> >> Closes: https://lore.kernel.org/oe-kbuild-all/202405240610.fj53EK0q-lk=
p@intel.com/
> >> Fixes: 2e8a0f40a39c ("KEYS: trusted: Introduce NXP DCP-backed trusted =
keys")
> >=20
> > Tags are in wrong order. For next round:
>
> here=E2=80=99s me relying on checkpatch.pl to tell me this, but it did no=
t. :-/
> Anyways, thanks for reviewing! I=E2=80=99ll fix the tags and send v2.

Cool, might take over a week before response from my side but I'm sure
we get this to some rc of 6.11. I've purposely kept my 6.11 PR feature
free because the merge window was right in the middle of my holiday
:-)

BR, Jarkko

