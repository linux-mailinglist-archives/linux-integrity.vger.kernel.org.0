Return-Path: <linux-integrity+bounces-7703-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620BCC8FA11
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 18:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03C963ABCDC
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Nov 2025 17:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C782E7BDF;
	Thu, 27 Nov 2025 17:18:06 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02A22DC780;
	Thu, 27 Nov 2025 17:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764263885; cv=none; b=KdMS5i80Wca/hw8/OQXjXFy3wl7XbfFf+WKbm9rmomzKhgCtXJl/TMp4JQA6ZZ2TlW7BkhO3Jw9a5jhKHamLbCduiTEN56kUOSXhgr03PHRVTrq1eYfVWUqfU/LoGuhOzcFLKxwQUjf81fltokrFXoWNEcM7fnx++i8u17Ok/nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764263885; c=relaxed/simple;
	bh=a8WR3f67LKcyBamT2NsN62oLNE7f8zUSAqolLpJGnps=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jh3o8Zq0eeYLrOe1Tr1WQwPaMRbH0zHLO+xlB1N5x4DpH2UeJsx5shBGcgTgzK1BMlHeduFxWGrHw1PMqyizqHzrEJPsm7DhDY/uRuLJbymn/FR/a9OZpMuOlNErul+y14ocPqGJ1vXFMl0KqJPniTROh7atx+b3/ZbhZQ6YETA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dHNPt3XPjz1HC5W;
	Fri, 28 Nov 2025 01:16:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id E9F371402DB;
	Fri, 28 Nov 2025 01:17:54 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDnwIi6hyhpM2cvAQ--.65380S2;
	Thu, 27 Nov 2025 18:17:54 +0100 (CET)
Message-ID: <a6e73690e73b7a3e190719d179dbc73b93d1c1f1.camel@huaweicloud.com>
Subject: Re: [PATCH v7 01/11] tpm: Cap the number of PCR banks
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-integrity@vger.kernel.org, ross.philipson@oracle.com, Jonathan
 McDowell <noodles@earth.li>, Stefano Garzarella <sgarzare@redhat.com>,
 Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>, Roberto Sassu
 <roberto.sassu@huawei.com>,  Jonathan McDowell <noodles@meta.com>, Peter
 Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-kernel@vger.kernel.org
Date: Thu, 27 Nov 2025 18:17:42 +0100
In-Reply-To: <aSiG7l_1E12r_56c@kernel.org>
References: <20251127135445.2141241-1-jarkko@kernel.org>
	 <20251127135445.2141241-2-jarkko@kernel.org>
	 <69de8fea4851ef378613e66685c3c34c43d71f05.camel@huaweicloud.com>
	 <aSiG7l_1E12r_56c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDnwIi6hyhpM2cvAQ--.65380S2
X-Coremail-Antispam: 1UD129KBjvJXoWrtFW5GFy5Jr43uryrAF1DWrg_yoW8JF1kpF
	Zaq3W7ZF1Yqr4rA34qka4Ikryvka97KFnrXwn5Zr18Zr97Wr1akw1Iq34xWa4F9ryUt3W8
	t343Za4xA3ZFvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAFBGkntCQLBQACsR

On Thu, 2025-11-27 at 19:14 +0200, Jarkko Sakkinen wrote:
> On Thu, Nov 27, 2025 at 05:09:38PM +0100, Roberto Sassu wrote:
> > On Thu, 2025-11-27 at 15:54 +0200, Jarkko Sakkinen wrote:
> > > From: Jarkko Sakkinen <jarkko.sakkinen@opinsys.com>
> > >=20
> > > tpm2_get_pcr_allocation() does not cap any upper limit for the number=
 of
> > > banks. Cap the limit to eight banks so that out of bounds values comi=
ng
> > > from external I/O cause on only limited harm.
> > >=20
> > > Cc: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Sorry, I realized that you are expecting me to review.
> >=20
> > I have a couple of questions:
> > - Could you explain better how out of bounds would occur, since one
> >   could check the number of PCR banks?
> > - Is dynamic allocation that bad? And if yes, why?
> > - Couldn't you just check that the number of available PCR banks is=C2=
=A0
> >   below the threshold you like and keep dynamic allocation?
> > - Is removing tpm1_get_pcr_allocation() improving code readability?
>=20
> nr_possible_banks is read from external source i.e., neither kernel nor
> CPU fully control its value. This causes *uncontrolled* dynamic
> allocation. Thus, it must be capped to some value.

Sure, I'm fine with capping. Isn't that enough?

Thanks

Roberto

> > Thanks
> >=20
> > Roberto
>=20
> BR, Jarkko


