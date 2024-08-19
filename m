Return-Path: <linux-integrity+bounces-3359-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE256956E75
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2024 17:16:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EA4AB2390C
	for <lists+linux-integrity@lfdr.de>; Mon, 19 Aug 2024 15:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A929C4644E;
	Mon, 19 Aug 2024 15:15:23 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9820A3A8F0;
	Mon, 19 Aug 2024 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724080523; cv=none; b=aihjZ33uuS4+kF6tNpvWKaQCROtprHvgGIluneGqyPwPYBpMBCbqzIzNFAnZPdAVtWRqr7hsxqvGDKveue4O4CK305AL0Botk9r5iGwuOA9P4TpmR2SRo1CNuPk1GJZSOMzmIAkRSD1EonnAc39HzSnyaLkLrx72eOizwoyANFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724080523; c=relaxed/simple;
	bh=eBgQOaG5792MypyuAUQklFLUNmtxOLNrLOLKzEly7xo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TO5LtSG7dXwL2wQMpzJq+/j0qHfrdpN4xVkFKhfxcpc8EIepsoitJF4XcLpxQEakJfrnF1/GQqCykvsTvJkhS0EAonxvUN1SbfwW/FnL6eZnIVhKCmPaO1ng2xGwonxPZ96BDDZYv56ZEcTPt6lF+SXjJUX8Cke5mPraBojhFWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4WnbJf1VL5z9v7Hj;
	Mon, 19 Aug 2024 22:56:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 9050814101D;
	Mon, 19 Aug 2024 23:15:12 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAHi4V4YcNm5o6AAQ--.28507S2;
	Mon, 19 Aug 2024 16:15:12 +0100 (CET)
Message-ID: <f142b1c4e662d4701a2ab67fa5fc839ab7109e5e.camel@huaweicloud.com>
Subject: Re: [PATCH v2 00/14] KEYS: Add support for PGP keys and signatures
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Jonathan McDowell <noodles@earth.li>
Cc: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au, 
 davem@davemloft.net, linux-kernel@vger.kernel.org,
 keyrings@vger.kernel.org,  linux-crypto@vger.kernel.org,
 zohar@linux.ibm.com,  linux-integrity@vger.kernel.org, Roberto Sassu
 <roberto.sassu@huawei.com>
Date: Mon, 19 Aug 2024 17:15:02 +0200
In-Reply-To: <ZsNf1VdfkHqD8R4Q@earth.li>
References: <20240818165756.629203-1-roberto.sassu@huaweicloud.com>
	 <ZsNf1VdfkHqD8R4Q@earth.li>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAHi4V4YcNm5o6AAQ--.28507S2
X-Coremail-Antispam: 1UD129KBjvJXoWxArWrXFy3WrWxKw1DZryUtrb_yoW5GF48pa
	yFkFn8Jr98JFnxCanxZw4UZrWYyrZ3J3W5Grnxt34Fyr1YqFnIvF18KF4ru39xWr4fAw4v
	qrW5tw13u398AaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOB
	MKDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAABGbCqfEHWgAAsk

On Mon, 2024-08-19 at 16:08 +0100, Jonathan McDowell wrote:
> On Sun, Aug 18, 2024 at 06:57:42PM +0200, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Support for PGP keys and signatures was proposed by David long time ago=
,
> > before the decision of using PKCS#7 for kernel modules signatures
> > verification was made. After that, there has been not enough interest t=
o
> > support PGP too.
>=20
> You might want to update the RFC/bis references to RFC9580, which was
> published last month and updates things.

Yes, makes sense (but probably isn't too much hassle to support more
things for our purposes?)

> Also, I see support for v2 + v3 keys, and this doesn't seem like a good
> idea. There are cryptographic issues with fingerprints etc there and I
> can't think of a good reason you'd want the kernel to support them. The
> same could probably be said of DSA key support too.

Uhm, if I remember correctly I encountered some old PGP keys used to
verify RPM packages (need to check). DSA keys are not supported, since
the algorithm is not in the kernel.

Thanks

Roberto

> > Lately, when discussing a proposal of introducing fsverity signatures i=
n
> > Fedora [1], developers expressed their preference on not having a separ=
ate
> > key for signing, which would complicate the management of the distribut=
ion.
> > They would be more in favor of using the same PGP key, currently used f=
or
> > signing RPM headers, also for file-based signatures (not only fsverity,=
 but
> > also IMA ones).
> >=20
> > Another envisioned use case would be to add the ability to appraise RPM
> > headers with their existing PGP signature, so that they can be used as =
an
> > authenticated source of reference values for appraising remaining
> > files [2].
> >=20
> > To make these use cases possible, introduce support for PGP keys and
> > signatures in the kernel, and load provided PGP keys in the built-in
> > keyring, so that PGP signatures of RPM headers, fsverity digests, and I=
MA
> > digests can be verified from this trust anchor.
> >=20
> > In addition to the original version of the patch set, also introduce
> > support for signature verification of PGP keys, so that those keys can =
be
> > added to keyrings with a signature-based restriction (e.g. .ima). PGP k=
eys
> > are searched with partial IDs, provided with signature subtype 16 (Issu=
er).
> > Search with full IDs could be supported with
> > draft-ietf-openpgp-rfc4880bis-10, by retrieving the information from
> > signature subtype 33 (Issuer Fingerprint). Due to the possibility of ID
> > collisions, the key_or_keyring restriction is not supported.
>=20
>=20
> J.
>=20


