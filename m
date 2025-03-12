Return-Path: <linux-integrity+bounces-5244-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF1EA5D667
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 07:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA9C189C195
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 06:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9521E51F1;
	Wed, 12 Mar 2025 06:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="p+JulkP6"
X-Original-To: linux-integrity@vger.kernel.org
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.197.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAB035947;
	Wed, 12 Mar 2025 06:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.154.197.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741761446; cv=none; b=ijkPv4lOG+EV8jlvAAf7J2aitLSSfMdWDQhwzrp4I73hsMk3jkzHr2I/CZP8vuFkficjF22D0yYo5TqfCMvT+whHK851Dpj6qUgGwSqua2/DSQwBb7WknUwMk0b5qbA2yMZk1ur2W3/fE7nOmpimSIaKFkq0V+lS4f2RivtZRgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741761446; c=relaxed/simple;
	bh=Rl1S1vLk6P/otaDdrbMIKCdzpNZZAKitgRBiT2k8H40=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BGpz0SnTjC/HwTFe9Tg1shllc4Pz5LAvNFZUW0UBDKiw3ReHSGswt/G/JZfZFhO5Btet+4eKr24sapNrvVwyLF3oMkX+DwnJwlHy/ojoIJhAwXqx4n5FS92LTiabzoyeeFPl07BmrHAj8rNZIKLb1Jnj8Q0Ov25hHCYXXyC12a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=p+JulkP6; arc=none smtp.client-ip=43.154.197.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1741761396;
	bh=Rl1S1vLk6P/otaDdrbMIKCdzpNZZAKitgRBiT2k8H40=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=p+JulkP6eoPaMwjpxGfkAmWJEGlmqenwezd2lQRJQAFwSrKWBr4/d85yDKReMXNas
	 yrv8SM+RLCWltUPUr4+GkM3IxPv6zAbAE2c9sFNrDz4f4/EkoA80UzYtyCkCmgt+CZ
	 fXCejxovIcXOTLqIalKzwrfcJzyj46gN4VxsOM8c=
X-QQ-mid: bizesmtpip4t1741761384t2xqr1u
X-QQ-Originating-IP: vdOjE5+vS3S57PGNSU3j3eCiUR/2DKcQdZ+RzDdm/4Y=
Received: from [IPV6:240e:668:120a::212:156] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 12 Mar 2025 14:36:23 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 15479327412074088821
Message-ID: <7D1A8A81E3AA4A52+a1158f17-c22d-4a2e-9188-4d3fc28ffc0c@uniontech.com>
Date: Wed, 12 Mar 2025 14:36:22 +0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: eventlog: Declare mapping_size __maybe_unused
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, ardb@kernel.org, gourry@gourry.net,
 linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
 zhanjun@uniontech.com, niecheng1@uniontech.com, guanwentao@uniontech.com,
 Chen Linxuan <chenlinxuan@uniontech.com>
References: <10590A3A04DA011F+20250311120115.1451048-1-wangyuli@uniontech.com>
 <Z9Enmy6mpl07LtX6@kernel.org>
Content-Language: en-US
From: WangYuli <wangyuli@uniontech.com>
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <Z9Enmy6mpl07LtX6@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------aMqXGruLGR0Ovd5Ne5Gh1IMm"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NRlQ2yI36hZTPTQileG89EKE81/LyPgjqyXdNd53l014DI7ijnTxG9ac
	uk/rd/TPyeq0FNaJrwob/Nzs3yrZhWW/ihgPjMxAY8eMNUjJF0HvB3nKSTcmwl4b+2t+X8+
	2A+NaYfwaTUqNEpxDhWMFIZbczClfZZuUh9JTgdaTuixxXezrwahFJjnui58UZBwf2YQlej
	N5A9CC3g9QCSCwBmGfXuK378bWBqVjIFXig6B40MpjVTk9ZVVydN4bgKkEL+BKkKzh6tJSF
	ZBfE26sO8KpSZ1l8o1F1dxxKjZoIpjyyjBsWD+gd/j562IhoIBSdnl9VwLH4sULWjDTb0Mq
	TeYMQDmC1vvXIAAGxQdK0yvxEgGXnmpZ+4kAvwx1Rg9F2YkynEuvzHCTmaicXaeer5cvGcz
	S6Kgh1r0ptjvtfGuxkysSF8Lb2qRDTEPpfAwYl04mgk+Z+rTy4dAr2VYRYj71CLYzvEWAfk
	iE7gJO6nPokQfn2HW8hFCoCNmPBfS+pjRIuTppdQKeon7c9Lq8pLIBQwkz66mRQ+/i3wel8
	8SdVztYW9W20vdU4xFA3vT53eFRknNLjRi1omLAd4apfQsnREPug0sfJpGP9OcI+keFXEIn
	UuRKDdvePY59VwQPj1tCqPaDcq+/1Hfh2AxGv9CihyKjXUEakatVw5wmxXsIeYuO44CZ2R/
	3sE9rdlzqRlDHgJxe318Yp/Dwks6ehBqIyJOejlF8bWQDq1OQSr2/ZcMnLrfrnUqQUchsIg
	xYoB6Z8+IMqlSY836lxlsHp1gDfG0PcVyh0Wxga0aYc4FPeUraTAtaUqBcj1DAeNbQ8hmC7
	MdzmOiCULDVLTZDJucfFuKyFSThwZTOZNe4+21IwLLfPn46bSewVdj2I01vuE7n4i/fWcoD
	EwEm2485n8LM8rE0l5jwOCZEHVF6Tj09hGillpEa/4TsvwCic1cH0Vr2qaCt/+VmTncAfSM
	3oorHvD7CAvx3cREwdufMhaVjs77eZmoEPHPfDw0p3cswLmcDNML/Ep3V95QXGuLliPNzdq
	qEYlejJDdkPgq0xjqnyjqCHERYDnuSQsCbj4bOluJ+XjaIUaoBv5B6GuNSqYt+jEiAmoLwN
	g==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------aMqXGruLGR0Ovd5Ne5Gh1IMm
Content-Type: multipart/mixed; boundary="------------SbOE0y3zx6FvP2wMm7INZGIy";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, ardb@kernel.org, gourry@gourry.net,
 linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
 zhanjun@uniontech.com, niecheng1@uniontech.com, guanwentao@uniontech.com,
 Chen Linxuan <chenlinxuan@uniontech.com>
Message-ID: <a1158f17-c22d-4a2e-9188-4d3fc28ffc0c@uniontech.com>
Subject: Re: [PATCH] tpm: eventlog: Declare mapping_size __maybe_unused
References: <10590A3A04DA011F+20250311120115.1451048-1-wangyuli@uniontech.com>
 <Z9Enmy6mpl07LtX6@kernel.org>
In-Reply-To: <Z9Enmy6mpl07LtX6@kernel.org>

--------------SbOE0y3zx6FvP2wMm7INZGIy
Content-Type: multipart/mixed; boundary="------------OHF0rC5JI1QzhZnYV3JsdEWG"

--------------OHF0rC5JI1QzhZnYV3JsdEWG
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgSmFya2tvLA0KDQpPbiAyMDI1LzMvMTIgMTQ6MjAsIEphcmtrbyBTYWtraW5lbiB3cm90
ZToNCj4gV2h5IGRvIHdlIGNhcmUgY2xhbmctMTkgd2l0aCBXPTFlPw0KDQoxLiB0aGUga2Vy
bmVsLCBiZWluZyBhIHNvZnR3YXJlIGVuZGVhdm9yIHByZWRpY2F0ZWQgb24gcm9idXN0bmVz
cywgDQpzaG91bGQgbm90IG5vcm1hbGx5IGNvdW50ZW5hbmNlIGJ1aWxkIGZhaWx1cmVzIHN0
ZW1taW5nIGZyb20gdG9vbGNoYWluIA0KYW5kIGNvbXBpbGF0aW9uIHNldHVwcyB0aGF0IGFy
ZSBpbXBsaWNpdGx5IHByb2plY3QtYXBwcm92ZWQuDQoNCjIuIEJlc2lkZXMsIGl0J3Mgbm90
IGFzIGlmIEdDQyBpcyBpbW11bmUgdG8gInVudXNlZC1idXQtc2V0LXZhcmlhYmxlIiANCndh
cm5pbmdzLsKgIFRoZSB0aGluZyBpcywgSSBqdXN0IGhhcHBlbiB0byBiZSB1c2luZyBjbGFu
Zy0xOSBmb3Iga2VybmVsIA0KYnVpbGRzLg0KDQo+IE9ubHkgb25lIGluc3RhbmNlIHRoYXQg
ZGVtb25zdHJhdGVzIHRoZSBpc3N1ZSBwbGVhc2UuDQoNClRoYW5rcyBmb3IgdGhlIGZlZWRi
YWNrLCBJJ2xsIGJlIG1vcmUgbWluZGZ1bCBnb2luZyBmb3J3YXJkLg0KDQotLSANCldhbmdZ
dWxpDQo=
--------------OHF0rC5JI1QzhZnYV3JsdEWG
Content-Type: application/pgp-keys; name="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSK
P+nX39DNIVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAx
FiEEa1GMzYeuKPkgqDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMB
AAAKCRDF2h8wRvQL7g0UAQCH3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfP
bwD/SrncJwwPAL4GiLPEC4XssV6FPUAY0rA68eNNI9cJLArOOARmgSyJEgorBgEE
AZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7VTL0dvPDofBTjFYDAQgHwngE
GBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIbDAAKCRDF2h8wRvQL
7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkUo9ERi7qS
/hbUdUgtitI89efbY0TVetgDsyeQiwU=3D
=3DBlkq
-----END PGP PUBLIC KEY BLOCK-----

--------------OHF0rC5JI1QzhZnYV3JsdEWG--

--------------SbOE0y3zx6FvP2wMm7INZGIy--

--------------aMqXGruLGR0Ovd5Ne5Gh1IMm
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZ9ErZgUDAAAAAAAKCRDF2h8wRvQL7lqW
APoDx2R4IE4LoMgiswGxROXtjIkD4P0wyy3LXiHVOj8DbgD/Tt11aF801D4aP90fBTf42tELLwrV
oRd+bSqyjE6enA0=
=q688
-----END PGP SIGNATURE-----

--------------aMqXGruLGR0Ovd5Ne5Gh1IMm--

