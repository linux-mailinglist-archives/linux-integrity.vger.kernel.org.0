Return-Path: <linux-integrity+bounces-3372-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9CB9588C1
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Aug 2024 16:15:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5259C1C222CD
	for <lists+linux-integrity@lfdr.de>; Tue, 20 Aug 2024 14:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD41191476;
	Tue, 20 Aug 2024 14:14:57 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D521189F3F;
	Tue, 20 Aug 2024 14:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724163297; cv=none; b=CsAxTd5cb5/VNOKvbQ7bNn2etYYkL6m5szWbFnMMhDEr3PaVlt7QI6LT7CcaYulA6xW88i/F53utLqyRsSDQON9HNfmOxjaVwm75ty3Le+3bpid4j7EQUr4zwIwRIN+6W4QETJPXdfDwm/szvGEI/vO0sx6JxU0b1EcOMmG0z3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724163297; c=relaxed/simple;
	bh=Li4il9DPZcDFmQDsu6gkCNX3IrynfYcKNpVKGyGtauc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ccAX9qUQojXkJ/6K08isZv8sOLBokw93NjZM5i3NRw2wA1dW2avOtYcodCNRujrBLYReW4bS4Dk3LuOfDi76wkNd613bpE99MMyGBqVkSJztU2ClaGzqmB7HqVm/iZd85cz0uFblW4eCCPlmKM+0OZVITcKG23WIH/m1atvNkT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4Wp9wG09J9z9v7Hk;
	Tue, 20 Aug 2024 21:55:42 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id D434A140B1C;
	Tue, 20 Aug 2024 22:14:36 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDntsPEpMRmxQiUAQ--.4381S2;
	Tue, 20 Aug 2024 15:14:36 +0100 (CET)
Message-ID: <e0a67e424dc4cd9f36252c453f046f1f6e51d363.camel@huaweicloud.com>
Subject: Re: [PATCH v2 00/14] KEYS: Add support for PGP keys and signatures
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Jonathan McDowell <noodles@earth.li>
Cc: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au, 
 davem@davemloft.net, linux-kernel@vger.kernel.org,
 keyrings@vger.kernel.org,  linux-crypto@vger.kernel.org,
 zohar@linux.ibm.com,  linux-integrity@vger.kernel.org, Roberto Sassu
 <roberto.sassu@huawei.com>
Date: Tue, 20 Aug 2024 16:14:24 +0200
In-Reply-To: <ZsSkTs4TFfx2pK8r@earth.li>
References: <20240818165756.629203-1-roberto.sassu@huaweicloud.com>
	 <ZsNf1VdfkHqD8R4Q@earth.li>
	 <f142b1c4e662d4701a2ab67fa5fc839ab7109e5e.camel@huaweicloud.com>
	 <ZsSkTs4TFfx2pK8r@earth.li>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwDntsPEpMRmxQiUAQ--.4381S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF1kJFWfWr1DWr17AFyUtrb_yoW8AFWkpa
	yrWF13tFZ5tw1SkFnay3WUGrWjy39rJF15JwnxJrykAFn0qFy09F1xKF45u3s8Grn3Cw1j
	vrW3Ja13W3s8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgABBGbD+-gF-gABsb

On Tue, 2024-08-20 at 15:12 +0100, Jonathan McDowell wrote:
> On Mon, Aug 19, 2024 at 05:15:02PM +0200, Roberto Sassu wrote:
> > On Mon, 2024-08-19 at 16:08 +0100, Jonathan McDowell wrote:
> > > On Sun, Aug 18, 2024 at 06:57:42PM +0200, Roberto Sassu wrote:
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > >=20
> > > > Support for PGP keys and signatures was proposed by David long time=
 ago,
> > > > before the decision of using PKCS#7 for kernel modules signatures
> > > > verification was made. After that, there has been not enough intere=
st to
> > > > support PGP too.
> > >=20
> > > You might want to update the RFC/bis references to RFC9580, which was
> > > published last month and updates things.
> >=20
> > Yes, makes sense (but probably isn't too much hassle to support more
> > things for our purposes?)
>=20
> I'm mostly suggesting that the comments/docs point to the latest
> standard rather than the draft version, not changing to support the new
> v6 keys.
>=20
> > > Also, I see support for v2 + v3 keys, and this doesn't seem like a go=
od
> > > idea. There are cryptographic issues with fingerprints etc there and =
I
> > > can't think of a good reason you'd want the kernel to support them. T=
he
> > > same could probably be said of DSA key support too.
> >=20
> > Uhm, if I remember correctly I encountered some old PGP keys used to
> > verify RPM packages (need to check). DSA keys are not supported, since
> > the algorithm is not in the kernel.
>=20
> I would question the benefit gained from using obsolete key/signature
> types for verification (I was involved in the process of Debian dropping
> them back in *2010* which was later than it should have been). Dropping
> the code for that path means a smaller attack surface/maintenance
> overhead for something that isn't giving a benefit.

Ok, I agree to both!

Thanks

Roberto


