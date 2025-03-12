Return-Path: <linux-integrity+bounces-5246-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F85A5D692
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 07:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905183B69F7
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 06:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0670F1E5B7A;
	Wed, 12 Mar 2025 06:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="YlW0ppXr"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92191DB958;
	Wed, 12 Mar 2025 06:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741762215; cv=none; b=rdOy+U5BYDcDGNXLsWwZUVxxKxaD5EdEGYQD9/q2l3uo5ajA2yqO+KTRyXH21aiSigoFDQZGLr/fQXVTNITfWSCF8aNxWhXdNh6e1lT/vSJfgOqolnyTsL7NFCNdTxkZ/4J9zM3t47GI9GxL2xOHKleOpF/nYwge/5QZgdsfJwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741762215; c=relaxed/simple;
	bh=ZeT1OmVRlVrO/fSdj6AFFN7vd73r3VOLcw9nk11LfUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fAdU3vADoMoyPykbfZOU1cTBDVCj/X40Xgym3BnfgzO3Xek0BYb+FyYuwf16JIll6/E52XmUEGZBBXYi8C1NdtynQ364sIrcQQLnBFEdI8eCIItB4gCD+k91FLTxCV7oDjxJx0PSAUdt7qtwy6IX+Jcde0HdXEkXcq2N5unL8gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=YlW0ppXr; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1741762136;
	bh=ZeT1OmVRlVrO/fSdj6AFFN7vd73r3VOLcw9nk11LfUs=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=YlW0ppXrmadfQSMn3z+jtWylerGOlXtzKHBlHVYamYFc6HQ1tOz+igbGmjSFKIxFI
	 Gso1zdTUolbsiQaVwey2bBAwUBXMtzb7CxVqP61znSM+tRIzukdz3DvY7LbtS1Ko6B
	 pH7dEEaztQFCrOuxe3ruPA/2B0o5WKCKCGcxDMXY=
X-QQ-mid: bizesmtpip2t1741762133tx1dghw
X-QQ-Originating-IP: Vqr9QUOR+aNYU++/YuJFxQ0VMdww6zQpmr5lkAB4HoU=
Received: from [IPV6:240e:668:120a::212:156] ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 12 Mar 2025 14:48:51 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 18320088929036632054
Message-ID: <F0B8DC7D8609F78E+f602292f-27ed-41e0-81d9-911174ee1da0@uniontech.com>
Date: Wed, 12 Mar 2025 14:48:51 +0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add include/linux/tpm*.h to TPM maintainers
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org, James.Bottomley@hansenpartnership.com,
 stefanb@linux.ibm.com, ardb@kernel.org, roberto.sassu@huawei.com,
 viro@zeniv.linux.org.uk, gourry@gourry.net
References: <3E528EFF1AE81A17+20250311131440.1468875-1-wangyuli@uniontech.com>
 <Z9EofB1oLBUgu05C@kernel.org>
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
In-Reply-To: <Z9EofB1oLBUgu05C@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------hloQ2qONxBIKwsIRUS307UCg"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: M28vnsO5i7WetvdyFFGBltUaTadplbtN7W5vXs2iEWJYyb+V6HIz44nB
	aghSe+p9xDy9RucKT4dpGN0oyzHjPi3mCPlnydCty3IgUN8dqv4H2Tstic3oFeqMg2YKHuu
	SoJFdTytPWIcbch3q9CwLcnzFiazHC+kXUo0mWZkfkeTUJoyPUk7IQmSwNE7zrtQ+ThkCEB
	4Q6KZAz7yiwxDJNPFSFohGgqvtzaO0Tne/baqGCLrkyeAbC4xcaiHYQuoU3JzMGUcLljTpR
	DGSGvE1c7zPFW29qfppm4wUdRN39sDQGxql2GP9QL4iizI7RrGMcHB4enJOvZtPLgrQlEsx
	Yx1XzC7rEsDYO5CKXOG++HRBfIfnuXjPAINJYQlC/llA6MEDhl7CGy77SSbCUXlZ4rtDgdA
	wrLXylv5stUusFv5tglmitXp+SePWhGt+NV3wCEa5386ZYqXvJG3P4DOWyTPTQ31APVDmOc
	FMdSsHMU2SuUbQbNwm9VPBCwEGuBpDx8UkwgLnrM5KFN4tIG/ez+y/yHmDvyid1nMXY3gIo
	vroG/B6UR0FA31bQsnxzYuzyE527MetdJsCHHU7Hf24L9bvbdjR8M84j3Mc3wPUQDL5sw5d
	KfHWUZcpWLYhM7AsaOwmkfMBD3PGoX+jkPyQQZktcbifeBAGig+vw3Y+orw23ZqYEcH+fyz
	eLGMt1ZnvIZC4oawcBhBhflvBejvilo0hT6XeagT2XWv8s5FKletPGNLTfBwgKjYK9gOtck
	hsfaQBoGd3D8Rd+nDDYerbbmdln0zRxMP2QRb84BCgzTnRlPuHXNdDPuThlynDOKezOHWHm
	h8HAqA+E9ntkALSloL35O9fy4SGy+bWivam+ei88zD3wrASUxIsPuEfZme/h6bYROIhNLE2
	JPV7WbyLgZl4a4J5vKU0lJVPxfOi9oPA5hJ7qV2HTrVh4icX1zO4zA7W8J2UPBFFmlFWJgi
	6ZvLmedY3311275uuIKhBmSOdZGeX6C3uwFww4YyceqEtiXvL0wR4SR7zNXlzfX8PfV/FgC
	XE/v61i4zSYE9rpPzUzG4XCLN4ibw=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------hloQ2qONxBIKwsIRUS307UCg
Content-Type: multipart/mixed; boundary="------------XspLKyCEZU1NC3ckEnYdDtF0";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, linux-integrity@vger.kernel.org,
 linux-kernel@vger.kernel.org, James.Bottomley@hansenpartnership.com,
 stefanb@linux.ibm.com, ardb@kernel.org, roberto.sassu@huawei.com,
 viro@zeniv.linux.org.uk, gourry@gourry.net
Message-ID: <f602292f-27ed-41e0-81d9-911174ee1da0@uniontech.com>
Subject: Re: [PATCH] MAINTAINERS: Add include/linux/tpm*.h to TPM maintainers
References: <3E528EFF1AE81A17+20250311131440.1468875-1-wangyuli@uniontech.com>
 <Z9EofB1oLBUgu05C@kernel.org>
In-Reply-To: <Z9EofB1oLBUgu05C@kernel.org>

--------------XspLKyCEZU1NC3ckEnYdDtF0
Content-Type: multipart/mixed; boundary="------------ikyPs1h6UXoPdZge66IHIDn7"

--------------ikyPs1h6UXoPdZge66IHIDn7
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgSmFya2tvLA0KDQpPbiAyMDI1LzMvMTIgMTQ6MjMsIEphcmtrbyBTYWtraW5lbiB3cm90
ZToNCj4gIlN1Ym5hbWVzIiBhcmUgc2VwYXJhdGVkIHdpdGggc3BhY2UsIG5vdCB3aXRoIGNh
bWVsIGNhc2UuDQo+DQpJdCdzIGp1c3QgYSBtYXR0ZXIgb2YgcmVnaW9uYWwgY3VsdHVyYWwg
ZGlmZmVyZW5jZXMuDQoNCkluIG15IGNvdW50cnksIHdlIGRvbid0IGhhdmUgdGhlIGNvbmNl
cHQgb2YgIlN1Ym5hbWUiIGluIG5hbWVzLg0KDQpXZSBvbmx5IGhhdmUgIlN1cm5hbWUiIGFu
ZCAiR2l2ZW4gbmFtZSIsIGFuZCBvdXIgY29udmVudGlvbiBpcyB0byBwdXQgDQp0aGUgc3Vy
bmFtZSBmaXJzdCwgZm9sbG93ZWQgYnkgdGhlIGdpdmVuIG5hbWUsIHdpdGhvdXQgYSBzcGFj
ZSBpbiBiZXR3ZWVuLg0KDQpTbyBJIGRvbid0IHRoaW5rIEkgbmVlZCB0byBtYWtlIGFueSBj
aGFuZ2VzIHRvIG15IHNpZ24tb2ZmLg0KDQpPZiBjb3Vyc2UsIGFzIHlvdSBhcmUgdGhlIFRQ
TSBtYWludGFpbmVyLCBJIHJlc3BlY3QgeW91ciBvcGluaW9uLCBhbmQgaWYgDQp5b3Ugc3Ry
b25nbHkgaW5zaXN0LCBJIGNhbiBjaGFuZ2UgbXkgc2lnbi1vZmYgYnV0IG9ubHkgZm9yIGFs
bCBmdXR1cmUgDQpUUE0tcmVsYXRlZCBjb21taXRzLCBwZXJoYXBzIGJ5IHVzaW5nIFVuaWNv
ZGUgY2hhcmFjdGVycyBpbnN0ZWFkIG9mIA0Kc3BlbGxpbmcgaXQgb3V0IHdpdGggRW5nbGlz
aCBsZXR0ZXJzLg0KDQpUaGFua3MsDQoNCi0tIA0KDQrnjovmmLHlipsNCg0K
--------------ikyPs1h6UXoPdZge66IHIDn7
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

--------------ikyPs1h6UXoPdZge66IHIDn7--

--------------XspLKyCEZU1NC3ckEnYdDtF0--

--------------hloQ2qONxBIKwsIRUS307UCg
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnoEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZ9EuUwUDAAAAAAAKCRDF2h8wRvQL7nNV
APUez0RhRHISuD3+JZAK81GPM0NmU5GoGKOza6Ic4OZ5AQCyRXVzJzw65nD1PU1hdyyj21sGi2GX
Di/k2Di9+3/dBg==
=6WD8
-----END PGP SIGNATURE-----

--------------hloQ2qONxBIKwsIRUS307UCg--

