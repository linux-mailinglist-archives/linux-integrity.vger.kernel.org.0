Return-Path: <linux-integrity+bounces-3516-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BBDD974F1A
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 11:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859CC1C210C0
	for <lists+linux-integrity@lfdr.de>; Wed, 11 Sep 2024 09:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1FD11714A1;
	Wed, 11 Sep 2024 09:55:51 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94414153820;
	Wed, 11 Sep 2024 09:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726048551; cv=none; b=PEGtF4e5WsnM8T9sHSHxvsFI71cqHZQH8mqX0iCUQi44P7BPCAQYRHfRNq4B6fj+7txw/oivCorwa1vTIsM13OLtSOM8yvJ6BFSq7eiRL5bIZsKhNIpI3YgrgXO2VzyZePrxpnVvPAKX84TGUoJULWLa64fK9eaK2Cho3WFPGrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726048551; c=relaxed/simple;
	bh=pqsQYybeyYCDsOvPt+6+YrugYdGqWC0sdV8avoQ+enI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ei93sPu6LVS7IYKBtF+IHxyFZDWvj0a08cknQnxkfFrVon52kE5+/1KuSNSasBLnmWWb7aY1KOleJuRW2Fd89NAVqGcueNH00cljrhXI8ThfBpldqLj5vr8mDVip13rWbyb4+6eDcRHNIEJfkEauOb6wWpBOB1yjivur6V8xIlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4X3b6p2b2xz9v7NP;
	Wed, 11 Sep 2024 17:36:18 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id BDCC61404A8;
	Wed, 11 Sep 2024 17:55:35 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAnazIOaeFmhK2zAA--.63556S2;
	Wed, 11 Sep 2024 10:55:35 +0100 (CET)
Message-ID: <34c4c5b31e795144a6fdd258c99ce3da89c97c03.camel@huaweicloud.com>
Subject: Re: [PATCH v2 00/14] KEYS: Add support for PGP keys and signatures
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Jonathan McDowell <noodles@earth.li>
Cc: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au, 
 davem@davemloft.net, linux-kernel@vger.kernel.org,
 keyrings@vger.kernel.org,  linux-crypto@vger.kernel.org,
 zohar@linux.ibm.com,  linux-integrity@vger.kernel.org, Roberto Sassu
 <roberto.sassu@huawei.com>,  adrian@suse.de, ro@suse.de
Date: Wed, 11 Sep 2024 11:55:23 +0200
In-Reply-To: <ZuBi56VwWxxX2Ce5@earth.li>
References: <20240818165756.629203-1-roberto.sassu@huaweicloud.com>
	 <ZsNf1VdfkHqD8R4Q@earth.li>
	 <f142b1c4e662d4701a2ab67fa5fc839ab7109e5e.camel@huaweicloud.com>
	 <ZsSkTs4TFfx2pK8r@earth.li>
	 <a9502b8097841c36ca13871b22149eadd3fde355.camel@huaweicloud.com>
	 <6c7e34b65d73e9fa2ba0fd39b357b9eb42ee0449.camel@huaweicloud.com>
	 <ZuBi56VwWxxX2Ce5@earth.li>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAnazIOaeFmhK2zAA--.63556S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4xKr4fWFWDZw1kuF4Durg_yoW5Zryxpa
	y8JF1YyFZ5Jwn7AF1vyw1DCFWYy39rJF15Xwn8J348Crn0qFya9F1xKFW5u3s8Wr1xGw1j
	vrW3J3y3W3s8AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQADBGbg-HQFrQAAsg

On Tue, 2024-09-10 at 16:16 +0100, Jonathan McDowell wrote:
> On Tue, Sep 10, 2024 at 04:51:22PM +0200, Roberto Sassu wrote:
> > On Tue, 2024-09-10 at 16:36 +0200, Roberto Sassu wrote:
> > > On Tue, 2024-08-20 at 15:12 +0100, Jonathan McDowell wrote:
> > > > On Mon, Aug 19, 2024 at 05:15:02PM +0200, Roberto Sassu wrote:
> > > > > On Mon, 2024-08-19 at 16:08 +0100, Jonathan McDowell wrote:
> > > > > > On Sun, Aug 18, 2024 at 06:57:42PM +0200, Roberto Sassu wrote:
> > > > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > > >=20
> > > > > > > Support for PGP keys and signatures was proposed by David lon=
g time ago,
> > > > > > > before the decision of using PKCS#7 for kernel modules signat=
ures
> > > > > > > verification was made. After that, there has been not enough =
interest to
> > > > > > > support PGP too.
> > > > > >=20
> > > > > > You might want to update the RFC/bis references to RFC9580, whi=
ch was
> > > > > > published last month and updates things.
> > > > >=20
> > > > > Yes, makes sense (but probably isn't too much hassle to support m=
ore
> > > > > things for our purposes?)
> > > >=20
> > > > I'm mostly suggesting that the comments/docs point to the latest
> > > > standard rather than the draft version, not changing to support the=
 new
> > > > v6 keys.
> > > >=20
> > > > > > Also, I see support for v2 + v3 keys, and this doesn't seem lik=
e a good
> > > > > > idea. There are cryptographic issues with fingerprints etc ther=
e and I
> > > > > > can't think of a good reason you'd want the kernel to support t=
hem. The
> > > > > > same could probably be said of DSA key support too.
> > > > >=20
> > > > > Uhm, if I remember correctly I encountered some old PGP keys used=
 to
> > > > > verify RPM packages (need to check). DSA keys are not supported, =
since
> > > > > the algorithm is not in the kernel.
> > > >=20
> > > > I would question the benefit gained from using obsolete key/signatu=
re
> > > > types for verification (I was involved in the process of Debian dro=
pping
> > > > them back in *2010* which was later than it should have been). Drop=
ping
> > > > the code for that path means a smaller attack surface/maintenance
> > > > overhead for something that isn't giving a benefit.
> > >=20
> > > Removed support for v3 PGP signatures... but that broke openSUSE
> > > Tumbleweed.
>=20
> Is this a signature from a v3 key, or a v3 signature? Unfortunately
> there are implementations which will issue a v3 signature even from a v4
> key; IIRC this ambiguity has been cleared up in the updated RFC.

Yes, it looks a v3 signature from a v4 key.


> > > [  295.837602] PGPL: Signature packet with unhandled version 3
> >=20
> > To add more context, this patch set adds the ability to the kernel to
> > verify the PGP signature of RPM packages against Linux distributions
> > PGP keys.
>=20
> > The purpose of this is to verify the authenticity of such RPM packages,
> > and to extract from them file digests, which are in turn used as
> > reference values for integrity check (appraisal) with IMA.
>=20
> I don't believe allowing a v3 *key* gives a useful verification that is
> worth supporting. However unfortunately I think it sounds like support
> for v3 signatures from v4 keys is necessary.

Yes, after re-adding support for v3 signatures, openSUSE Tumbleweed is
back to normal, does IMA appraisal with RPM packages.

Thanks

Roberto


