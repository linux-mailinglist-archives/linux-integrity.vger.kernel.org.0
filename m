Return-Path: <linux-integrity+bounces-3506-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF62973A05
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2024 16:36:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E32A1F261DE
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2024 14:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1337919413F;
	Tue, 10 Sep 2024 14:36:42 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E1418C928;
	Tue, 10 Sep 2024 14:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725979002; cv=none; b=pMqb5CodPEpA3JyyqpzGjKYdFbA6jR5sWNbSxPCgVVKwfJ2xefYxBJ41lUU+35z6KgXwo2YExVUgUdGsYDyg/e/ziNOnyuJuSJs4SQKmvLf8xsgQERh/+H/MHn9UIm0a0WrswOTbXxEJpXa09xh2nT40UAiI9uUlfMLw4uoNUoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725979002; c=relaxed/simple;
	bh=wOLpU1b/pM0DovA9W+IpisxUVNxMO82yHVCaODl2umk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BzBDXl5WLUk9IGwdYPP2H+rCB5DF7rEN+tO2Kh53UqlAmivxMSj6WiNJ0U+eoE2xV7aSioXM6RtW+J8Jp6l2vNx0AMAkjzloEs5N7stDMPVNCp7BbduJ3UKAL8heKwpk7z/9ocVb0tgZrHj1OPlJW3UDVvkFhk+MLCtDGaqeCHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4X35Gh1rqnz9v7Jf;
	Tue, 10 Sep 2024 22:11:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 24186140133;
	Tue, 10 Sep 2024 22:36:34 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDndy9oWeBmAWqmAA--.53179S2;
	Tue, 10 Sep 2024 15:36:33 +0100 (CET)
Message-ID: <a9502b8097841c36ca13871b22149eadd3fde355.camel@huaweicloud.com>
Subject: Re: [PATCH v2 00/14] KEYS: Add support for PGP keys and signatures
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Jonathan McDowell <noodles@earth.li>
Cc: dhowells@redhat.com, dwmw2@infradead.org, herbert@gondor.apana.org.au, 
 davem@davemloft.net, linux-kernel@vger.kernel.org,
 keyrings@vger.kernel.org,  linux-crypto@vger.kernel.org,
 zohar@linux.ibm.com,  linux-integrity@vger.kernel.org, Roberto Sassu
 <roberto.sassu@huawei.com>,  adrian@suse.de, ro@suse.de
Date: Tue, 10 Sep 2024 16:36:21 +0200
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
X-CM-TRANSID:LxC2BwDndy9oWeBmAWqmAA--.53179S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZF1kJFWfWr1DWr17AFyUtrb_yoW8CFW3pa
	yrWF1ayFWkJw1SkFnav3WUGFWjy39rJF15JwnxXrykCwn0qFya9F1xKa15u3s8WFn3Cw1q
	vrW3Ja17G398AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgACBGbfq3sLqwACsP

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

Removed support for v3 PGP signatures... but that broke openSUSE
Tumbleweed.

[  295.837602] PGPL: Signature packet with unhandled version 3

Roberto


