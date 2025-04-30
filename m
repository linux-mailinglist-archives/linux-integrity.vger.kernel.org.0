Return-Path: <linux-integrity+bounces-6076-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6744AAA44EC
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 10:12:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C65B91BC2EF7
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Apr 2025 08:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC1D213E79;
	Wed, 30 Apr 2025 08:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O1lF81cS"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE81A20DD63;
	Wed, 30 Apr 2025 08:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746000742; cv=none; b=K8ODZzfPz62l6OI2U9kpOd0VT1oYuAwisknaRhIOiUPJprPT9lkLWCn4u622jjXp/geiASnvz3fNlzkZ1VapJqLkYfg4IrZsfis7RkUY/Hatd8Bsh2lHRW/hOZVyLutqOlRHuCqZDCXKs/NmMct61mTUKyNvcC+gkpFp02zgmrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746000742; c=relaxed/simple;
	bh=7u7EHnLDjvbuHO332SUMgMxgOAqA2DgO8dXyVsu01lc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kC3+toEr2F6o3EiSoQaqig000Vp7wltpeK/UvdjvM3LpaRFgIMat7wHPsa0IfuVnne1NGEpwfDoKt/pdgNvAwQHCgVq/pN1DX9a9mKGZ3Mfzkwwfv2STPoR+1Ab0CrTroboa9KBZbPEmfZLm5F2Fn5/P2ZHr4165U1aBYNRKOO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O1lF81cS; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39c266c2dd5so7607439f8f.3;
        Wed, 30 Apr 2025 01:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746000739; x=1746605539; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:content-language:references:cc:to:from
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7u7EHnLDjvbuHO332SUMgMxgOAqA2DgO8dXyVsu01lc=;
        b=O1lF81cSykzSB1gV5d4Hlx9KYA0uQEBQx2w1rD7s8rX8dL7dHHR3YMqlcaVTi09Tc2
         tCA08pCxVpOV7Eno9QmbqLAL/Wxs6CudlSLG5Ft39HIr5+cV1hdXXdStFKcM62EPOnLu
         OvxqW5NToLMQF72GhVDscqjWO1DO6m4DJnl389AtCirn5SBK1ujsCh6wScr5XKoup6hg
         YnwP7kVHw8IaqvrvDhlzwTT3Zlcp5+ff19noy7/oTrsVroOsLzSb4e60Xmhd41boiHq9
         2tAGAQmcxE0r2201cxh+ZvrQelvqdKhobUuXznIPbl9uYGuV+/4Y5BP/X9bqaBkTOgLT
         Sesw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746000739; x=1746605539;
        h=in-reply-to:autocrypt:content-language:references:cc:to:from
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7u7EHnLDjvbuHO332SUMgMxgOAqA2DgO8dXyVsu01lc=;
        b=XAFD+7/RCcEstprpWshmhuYvT1hUb1GhSlBTxHqUEtiQGm13o89A6C2rHJyaZVeNWQ
         sAYCnkkKr9RjXXmZLb0LInk/HXL2XwQsznyDuZyckTdPVS48b/4W2ZI6++q4cKKoIKoU
         J6fD/vmgwjrxKnHSdrSbw4I0SOq4m1cjfOEhiMIHcETd7n2XzxBxJV0pb/SRhL9YFF4o
         UuCsWHtQlrXI8QT/jIYe9nNyC8SYSW/avV9FMn5pUG7k8v99+E2pvUnrJRm2aqkkbom2
         EkKongBgnOHHq+sE0upYqVA5XJfCvXR9vKSS1htribdeDlgZzSBKiGtUecF+/Z5KX7PH
         8QLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUl6N3O37b9hOnDBhF3wMlzi5E2Vg9XxXZTFn+NxbOEoBw5tRCjFH/y3DTeCh4S8C35rXTDl9rSwexJ/ITJ@vger.kernel.org, AJvYcCXMYbRCkqAeftVnB4lpwHDn3Edu6nHrG+otcSagXpg2s9TxrXfWjdS62vslBfccfwrUy/ungWY5cmQEmGEMYyI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzreIVex6lpot777tJQKjm+06KZVg0aU2QfDybfXJgtNphKUGHr
	EsDNgnP23fVPCpNLNuMlEe5yCxIoWZxJ9idTOhub/FDAK9wxwfAw
X-Gm-Gg: ASbGncsc8UeCCIA4maCfcOlj3DfMsZvlht8TnhTs0GBfONyxsnid/9rN/3At4h9Z9Ac
	y0C07e9/YdMBkmLx+ESq1kkUjR4xSp8TzlabQNHPv2bSLdO1mKQQdXKQ/DgGpDfcXtG3in3lE82
	6yxzzX+CplkYq7uLzQAeiKFzLXGMpGQAxwDs+e0VKLE5F/GF9jA/XJwBmFVmunOzS1SXsRTesYk
	pd0x+c7YeUb8qXk0OGo1JDfAPGKZWhUk5fRLxjQIqrdg+BCXec3MY0PH2K+rs7u2qB2ONKZVgo/
	F4vyHR5G+ltnHsWJlwZk+D8PHDZE6k5vcmb7kFYQTy1xyHKc4A==
X-Google-Smtp-Source: AGHT+IGgHgY18PFBnd5t+8ucO9Z0WWK1WUYE94xqRisL1dNMunzWegt3SO8SY7MT5aXWtps6BjICYQ==
X-Received: by 2002:a5d:6484:0:b0:391:466f:314e with SMTP id ffacd0b85a97d-3a08f76125dmr1756596f8f.16.1746000738890;
        Wed, 30 Apr 2025 01:12:18 -0700 (PDT)
Received: from [192.168.1.248] ([194.120.133.25])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a073e5d4b0sm16160618f8f.89.2025.04.30.01.12.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 01:12:18 -0700 (PDT)
Message-ID: <53188863-f8bc-4b10-aa72-d14ff2465fbe@gmail.com>
Date: Wed, 30 Apr 2025 09:12:09 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tpm: remove kmalloc failure error message
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250430080037.848396-1-colin.i.king@gmail.com>
Content-Language: en-US
Autocrypt: addr=colin.i.king@gmail.com; keydata=
 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
 FVPMkxl2UyaayDvhrO9kNXvl1SKCpdzCMQ==
In-Reply-To: <20250430080037.848396-1-colin.i.king@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------2tT5T0GzweR3SsLQegxKoLFI"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------2tT5T0GzweR3SsLQegxKoLFI
Content-Type: multipart/mixed; boundary="------------8qIu0ct51Zhs0LSykD0lRhPI";
 protected-headers="v1"
From: "Colin King (gmail)" <colin.i.king@gmail.com>
To: Peter Huewe <peterhuewe@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, linux-integrity@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <53188863-f8bc-4b10-aa72-d14ff2465fbe@gmail.com>
Subject: Re: [PATCH] tpm: remove kmalloc failure error message
References: <20250430080037.848396-1-colin.i.king@gmail.com>
In-Reply-To: <20250430080037.848396-1-colin.i.king@gmail.com>

--------------8qIu0ct51Zhs0LSykD0lRhPI
Content-Type: multipart/mixed; boundary="------------HJBXQeBsjJYHOMru5WacE1ma"

--------------HJBXQeBsjJYHOMru5WacE1ma
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

TkFLLCBzZW50IHRoZSB3cm9uZyBwYXRjaCEgRG9oLg0KDQpPbiAzMC8wNC8yMDI1IDA5OjAw
LCBDb2xpbiBJYW4gS2luZyB3cm90ZToNCj4gVGhlIGttYWxsb2MgZmFpbHVyZSBtZXNzYWdl
IGlzIGp1c3Qgbm9pc2UuIFJlbW92ZSBpdCBhbmQNCj4gcmVwbGFjZSAtRUZBVUxUIHdpdGgg
LUVOT01FTSBhcyBzdGFuZGFyZCBmb3Igb3V0IG9mIG1lbW9yeQ0KPiBhbGxvY2F0aW9uIGVy
cm9yIHJldHVybnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDb2xpbiBJYW4gS2luZyA8Y29s
aW4uaS5raW5nQGdtYWlsLmNvbT4NCj4gLS0tDQo+IA0KPiBWMTogcmVtb3ZlIHRyYWlsaW5n
IHNwYWNlIGFmdGVyIFxuDQo+IFYyOiByZW1vdmUgZW50aXJlIG1lc3NhZ2UsIG9yaWdpbmFs
bHkganVzdCByZW1vdmVkIGEgdHJhaWxpbmcgc3BhY2UNCj4gVjM6IHJlcGxhY2UgLUVGQVVM
VCB3aXRoIC1FTk9NRU0NCj4gDQo+IC0tLQ0KPiAgIGRyaXZlcnMvY2hhci90cG0vZXZlbnRs
b2cvdHBtMS5jIHwgNSArLS0tLQ0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KSwgNCBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvdHBt
L2V2ZW50bG9nL3RwbTEuYyBiL2RyaXZlcnMvY2hhci90cG0vZXZlbnRsb2cvdHBtMS5jDQo+
IGluZGV4IDEyZWU0MmEzMWM3MS4uNzczZTllNTM3OTkxIDEwMDY0NA0KPiAtLS0gYS9kcml2
ZXJzL2NoYXIvdHBtL2V2ZW50bG9nL3RwbTEuYw0KPiArKysgYi9kcml2ZXJzL2NoYXIvdHBt
L2V2ZW50bG9nL3RwbTEuYw0KPiBAQCAtMjU3LDExICsyNTcsOCBAQCBzdGF0aWMgaW50IHRw
bTFfYXNjaWlfYmlvc19tZWFzdXJlbWVudHNfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZv
aWQgKnYpDQo+ICAgCSAgICAodW5zaWduZWQgY2hhciAqKSh2ICsgc2l6ZW9mKHN0cnVjdCB0
Y3BhX2V2ZW50KSk7DQo+ICAgDQo+ICAgCWV2ZW50bmFtZSA9IGttYWxsb2MoTUFYX1RFWFRf
RVZFTlQsIEdGUF9LRVJORUwpOw0KPiAtCWlmICghZXZlbnRuYW1lKSB7DQo+IC0JCXByaW50
ayhLRVJOX0VSUiAiJXM6IEVSUk9SIC0gTm8gTWVtb3J5IGZvciBldmVudCBuYW1lXG4gIiwN
Cj4gLQkJICAgICAgIF9fZnVuY19fKTsNCj4gKwlpZiAoIWV2ZW50bmFtZSkNCj4gICAJCXJl
dHVybiAtRUZBVUxUOw0KPiAtCX0NCj4gICANCj4gICAJLyogMXN0OiBQQ1IgKi8NCj4gICAJ
c2VxX3ByaW50ZihtLCAiJTJkICIsIGRvX2VuZGlhbl9jb252ZXJzaW9uKGV2ZW50LT5wY3Jf
aW5kZXgpKTsNCg0K
--------------HJBXQeBsjJYHOMru5WacE1ma
Content-Type: application/pgp-keys; name="OpenPGP_0x68C287DFC6A80226.asc"
Content-Disposition: attachment; filename="OpenPGP_0x68C287DFC6A80226.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBE6TJCgBEACo6nMNvy06zNKj5tiwDsXXS+LhT+LwtEsy9EnraKYXAf2xwazc
ICSjX06efanlyhB0figzQO0n/tP7BcfMVNG7n1+DC71mSyRK1ZERcG1523ajvdZO
xbBCTvTitYOy3bjs+LXKqeVMhK3mRvdTjjmVpWnWqJ1LL+Hn12ysDVVfkbtuIm2N
oaSEC8Ae8LSSyCMecd22d9PnLR4UeFgrWEkQsqROq6ZDJT9pBLGe1ZS0pVGhkRyB
P9GP65oPev39SmfAx9R92SYJygCy0pPvBMWKvEZS/7bpetPNx6l2xu9UvwoeEbpz
UvH26PHO3DDAv0ynJugPCoxlGPVf3zcfGQxy3otydNTWkP6Wh3Q85m+AlifgKZud
jZLrO6c+fAw/jFu1UMjNuyhgShtFU7NvEzL3RqzFf9O1qM2muj83IeFQ1FZ65QAi
CdTa3npz1vHc7N4uEQBUxyXgXfCI+A5yDnjHwzU0Y3RYS52TA3nfa08yLGPLTf5w
yAREkFYou20vh5vRvPASoXx6auVf1MuxokDShVhxLpryBnlKCobs4voxN54BUO7m
zuERXN8kadsxGFzItAyfKYzEiJrpUB1yhm78AecDyiPlMjl99xXk0zs9lcKriaBy
VUv/NsyJFQj/kmdxox3XHi9K29kopFszm1tFiDwCFr/xumbZcMY17Yi2bQARAQAB
zSdDb2xpbiBJYW4gS2luZyA8Y29saW4uaS5raW5nQGdtYWlsLmNvbT7CwZEEEwEI
ADsCGwMFCwkIBwMFFQoJCAsFFgIDAQACHgECF4AWIQRwYtqk8AG5xmFnAM9owoff
xqgCJgUCY8GcawIZAQAKCRBowoffxqgCJtd/EACIWcaxfVt/MH4qqo5ELsjCFPVp
+RhVpQDWy8v9Np2YbTcZ4AY2Zj4Pq/HrZ3F/Bh02v85C6mNv8BDTKev6Qcq3BYw0
iqw6/xLNvRcSFHM81mQI9xtnAWIWfI9k5hpX19QooPIIP3GOMdMc1uRUGTxTgTFA
AsAswRY3kMzo6k7arQnUs9zbiZ9SmS43qWOIxzGnvneekHHDAcomc/oho7kgj6rK
p/f9qRrhForkgVQwdj6iBlW934yRXzeFVF3wr7Lk5GQNIEkJiNQPZs54ojBS/Kx6
3UTLT1HgOp6UY9RPEi9wubmUR+J6YjLRZMr5PCcA86EYmRoysnnJ8Q/SlBVD8npp
GVEcuvrbH3MBfhmwOPDc3RyLkEtKfSTB92k1hsmRkx9zkyuUzhcSnqQnpWGJD+xt
KHvcHRT7Uxaa+SDwUDM36BjkyVcZQy8c+Is2jA55uwNgPpiA7n82pTeT+FRGd+7i
CLQHaryu6FO6DNDv09RbPBjIiC/q814aeKJaSILP1ld9/PEBrLPdm+6lG6OKOt9D
DV6jPmfR96FydjxcmI1cgZVgPomSxv2JB1erOggB8rmX4hhWYsVQl1AXZs3LdEpJ
6clmCPspn/ufZxHslgR9/WR1EvPMQc8XtssF55p8ehRIcVSXDRcMFr3ZuqMTXcL6
8YbDmv5OGS95O1Gs4c0iQ29saW4gS2luZyA8Y29saW4ua2luZ0B1YnVudHUuY29t
PsLBdwQTAQgAIQUCTwq47wIbAwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgAAKCRBo
woffxqgCJo1bD/4gPIQ0Muy5TGHqTQ/bSiQ9oWjS5rAQvsrsVwcm2Ka7Uo8LzG8e
grZrYieJxn3Qc22b98TiT6/5+sMa3XxhxBZ9FvALve175NPOz+2pQsAV88tR5NWk
5YSzhrpzi7+klkWEVAB71hKFZcT0qNlDSeg9NXfbXOyCVNPDJQJfrtOPEuutuRuU
hrXziaRchqmlhmszKZGHWybmPWnDQEAJdRs2Twwsi68WgScqapqd1vq2+5vWqzUT
JcoHrxVOnlBq0e0IlbrpkxnmxhfQ+tx/Sw9BP9RITgOEFh6tf7uwly6/aqNWMgFL
WACArNMMkWyOsFj8ouSMjk4lglT96ksVeCUfKqvCYRhMMUuXxAe+q/lxsXC+6qok
Jlcd25I5U+hZ52pz3A+0bDDgIDXKXn7VbKooJxTwN1x2g3nsOLffXn/sCsIoslO4
6nbr0rfGpi1YqeXcTdU2Cqlj2riBy9xNgCiCrqrGfX7VCdzVwpQHyNxBzzGG6JOm
9OJ2UlpgbbSh6/GJFReW+I62mzC5VaAoPgxmH38g0mA8MvRT7yVpLep331F3Inmq
4nkpRxLd39dgj6ejjkfMhWVpSEmCnQ/Tw81z/ZCWExFp6+3Q933hGSvifTecKQlO
x736wORwjjCYH/A3H7HK4/R9kKfL2xKzD+42ejmGqQjleTGUulue8JRtpM1AQ29s
aW4gSWFuIEtpbmcgKEludGVsIENvbGluIElhbiBLaW5nIGtleSkgPGNvbGluLmtp
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
=3DQKm6
-----END PGP PUBLIC KEY BLOCK-----

--------------HJBXQeBsjJYHOMru5WacE1ma--

--------------8qIu0ct51Zhs0LSykD0lRhPI--

--------------2tT5T0GzweR3SsLQegxKoLFI
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEcGLapPABucZhZwDPaMKH38aoAiYFAmgR21kFAwAAAAAACgkQaMKH38aoAibn
cA/+OnoHeCsAw/FN+/OyifSzGeSjB6FFyfh9wjUvXwuW/QA8J7svUKwDndlauPR/oPSQCqmEiMDu
JQ0RVH6IBX8qst81CTKn3XfKBAzmYA8Gq+EM+HBFG+qa9l8CGNb1m7Jba4/kqJk4DIhcPvsX+U9/
0K8ZstDVBG2YDX9KAmTFgEW3k02o4uV67o+FD03vgafzN6OROSa1SfR7nGNUHFG6Xz4v4/NzyKzl
Ulr+3qEZvgmDSmiAOiK/mSaWdTqdYOyis71hZ79SEZMuD420GCgLn/OA5sOWdxsQam85AGFEKhP4
2v7XKXZ6UNaML1YC4dofOvqdWf7JUCuGU99EeguunqMRS9vlmyUD46WRm1QorI/ZneKS41ruEVdg
GMwCbNR74cKluqmtH2pvzRCK8VU5FulPxNrXBcTcey0N2YA3qBoE2BMgBGbw0Cr6OfIz51eJvOXO
Ag6k41JX/tTuVkm2nLk1fTIV2yRuhl5DIl6dvB8gspsjemj1Rlx+GDA6EmLMOUOSDAKjPajImR7S
xGkF7NQdvLLQHyyMC24UslQ6bDCDqip2PVBQWFMKaqrwe3p+FvnjOHAG+z6ap01Hb0kFyl/teMUs
5EFBJKwMixsVjvCuMGlmY6Ax0SAr6cVu50IxtY2lMVWpa0CTAL5c0JDemwrwxsRZn86aEmdQSO0w
b3k=
=9z4z
-----END PGP SIGNATURE-----

--------------2tT5T0GzweR3SsLQegxKoLFI--

