Return-Path: <linux-integrity+bounces-3553-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B99FE977B0B
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Sep 2024 10:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76D9528915D
	for <lists+linux-integrity@lfdr.de>; Fri, 13 Sep 2024 08:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38801D798B;
	Fri, 13 Sep 2024 08:30:40 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522021BCA19;
	Fri, 13 Sep 2024 08:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726216240; cv=none; b=FmH/Vjcqm6hWzRF7XG2bRrlQSkec73gG8C//skY2WcmMYzLU9MDyB+4jphzBBdGoKdt+vAnYvEYkJEAFyVRq34OByZCm1OzBZDLlHLxSv6jRShicfGPFExRaqf/1GJ5oSQq5Ef9UCDn1V/SPMOgZggr3fKQYfArZ3mZkeBrSdQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726216240; c=relaxed/simple;
	bh=kPrSg6p6aTVQXXcjD7xT55A6UN3j0AilK3uKI03SJuY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KZyvSAoG4+tx7bNGnIEmvHrLSkIQekXbu41eWvRBLNTUqTpKsUxURq9Rjp3z7laqtILzPlQbKIMGkurhef8i2kRX5LAK/KWWA3+S4gZFuQJFGLJheqILT8rXx02TirqkH/s8VaGj5RAVHambcopz3OIlrlDvrCmW6dFxc80EBRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4X4n0v135Cz9v7JT;
	Fri, 13 Sep 2024 16:05:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id C27AE140360;
	Fri, 13 Sep 2024 16:30:27 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwCX+ckW+ONmdJzVAA--.9008S2;
	Fri, 13 Sep 2024 09:30:25 +0100 (CET)
Message-ID: <b4a3e55650a9e9f2302cf093e5cc8e739b4ac98f.camel@huaweicloud.com>
Subject: Re: [PATCH v3 00/14] KEYS: Add support for PGP keys and signatures
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: dhowells@redhat.com, dwmw2@infradead.org, davem@davemloft.net, 
	linux-kernel@vger.kernel.org, keyrings@vger.kernel.org, 
	linux-crypto@vger.kernel.org, zohar@linux.ibm.com, 
	linux-integrity@vger.kernel.org, torvalds@linux-foundation.org, 
	roberto.sassu@huawei.com, linux-security-module@vger.kernel.org
Date: Fri, 13 Sep 2024 10:30:11 +0200
In-Reply-To: <ZuPDZL_EIoS60L1a@gondor.apana.org.au>
References: <ZuPDZL_EIoS60L1a@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwCX+ckW+ONmdJzVAA--.9008S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGryrJw4DKr1UZr4kWF1rWFg_yoW5tryUpr
	45Aa9xKwnrJr17K3s7Jw4xCa4I9ws3C3W5Gr9xJr1Fywn8GF1I9r1S9w4UWF1kCr4xJr1Y
	vwsFvr12k3srZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAFBGbjn-sDtwABsX

On Fri, 2024-09-13 at 12:45 +0800, Herbert Xu wrote:
> Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:

+ linux-security-module

> >=20
> > For the envisioned use cases, PGP operations cannot be done in user spa=
ce,
> > since the consumers are in the kernel itself (Integrity Digest Cache an=
d
> > IMA). Also they cannot be done in a trusted initial ram disk, since PGP
> > operations can occur also while the system is running (e.g. after softw=
are
> > package installation).
>=20
> Does this address Linus's objections? If not then we cannot proceed.

I hope to get an answer from him.

> Personally I don't think the argument above holds water.  With
> IPsec we had a similar issue of authenticating untrusted peers
> using public key cryptography.  In that case we successfully
> delegated the task to user-space and it is still how it works
> to this day.

That makes sense, since it is not the kernel holding secrets on behalf
of user space, it is user space passing the crypto material to the
kernel (if I remember IPSEC correctly). Failure of user space to hold
its secrets or to tamper with the task has only effect in user space.

With my understanding, I'm citing a source enumerating the requirements
of a secure system:

James P. Anderson: Computer Security Technology Planning Study

The first requirement of a component enforcing a security policy on a
Target of Evaluation (TOE), aka the reference monitor, is that it must
be tamperproof [1].

The security policy I want to enforce is: all code that the system
executes has been built by a trusted source (e.g. a Linux
distribution).

I want to leverage the kernel to enforce such security policy, and I
assume that the kernel can be fortified enough (for example through the
lockdown LSM) to be considered tamperproof against the TOE (the user
space processes).

The first problem I see in delegating the public crypto task to user
space is that it is at the same time part of the reference monitor
(since it is used to enforce the security policy) and it is a TOE too.

The second problem is, assuming that the task is verified through other
means other than PGP (but again, we are still relying on the public
crypto functionality to be performed by the kernel, for this to work),
that I didn't get a confirmation that user space can have equivalent
isolation guarantees as the kernel:

https://lore.kernel.org/linux-integrity/eb31920bd00e2c921b0aa6ebed8745cb013=
0b0e1.camel@huaweicloud.com/


Please, keep in mind that I already proposed what you suggested:

https://lore.kernel.org/linux-kernel/20230317145240.363908-1-roberto.sassu@=
huaweicloud.com/#r


After discussing with some kernel developers, the outcome was that a
better choice would be to put the code in the kernel, if I want
reasonable tamperproof guarantees.

Thanks

Roberto


[1] https://seclab.cs.ucdavis.edu/projects/history/papers/ande72a.pdf (page=
 17)

> A user-space daemon dedicated to public key crypto seems equally
> applicable to your scenario.
>=20
> The original application that brought public key crypto into the
> kernel was module loading.  If we really wanted to we could extend
> the user-space verification to modules too and perhaps kick all
> public key crypto out of the kernel.
>=20
> The complexity and lack of reviewer attention in this area means
> that we're more likely to introduce security holes into the kernel
> with such code.
>=20
> Cheers,


