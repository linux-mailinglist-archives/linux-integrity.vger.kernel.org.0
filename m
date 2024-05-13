Return-Path: <linux-integrity+bounces-2369-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 518A68C4147
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2024 14:59:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056F21F216DB
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2024 12:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E326C14F9FF;
	Mon, 13 May 2024 12:59:20 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5DC1474BC;
	Mon, 13 May 2024 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715605160; cv=none; b=gmB2+ENfnxubeEdb3i9N8KJ5xSWoGpvN//CyX+Bu8hpFTNFUaIyRuR8pOg+inHAsx7P3503QuMt62od9V7e78f/uXI1jLA/fmjq3K4e+D8KOsmrNVtTcj90n3Dz/2BQS0qJoXdEGuoVaVTzdWtrLAN5S2IzJCqgTLhZGohSOt2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715605160; c=relaxed/simple;
	bh=0yjd/sb4uh3W+XLlUFtH7oE6+l6oTatynFqvAd22PdU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C0+VbnlVznJJXSt1vAHDhj+vM19eJysyS/jUAOLQ69VCwOfFj8ReeT2ZjjHSMPQVaw1IGbleTjusKPopFL+ccCJpgmgPJJBpja54A5+pD135Mo89iUJ/DHdlDMlOMjeVIhXC4V5kGEnK7xIOPNv7i82k1lZMieslbw1jkrendkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4VdJz11Fx4z9v7Hk;
	Mon, 13 May 2024 20:42:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 0518C140555;
	Mon, 13 May 2024 20:59:02 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwD36hOKDkJmEmMYCA--.45732S2;
	Mon, 13 May 2024 13:59:01 +0100 (CET)
Message-ID: <dba181a54e76ba2916ecd4747f76e40e6fbbb757.camel@huaweicloud.com>
Subject: Re: [PATCH] arch/x86/um: Disable UBSAN sanitization
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Johannes Berg <johannes@sipsolutions.net>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
Cc: x86@kernel.org, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org,  zohar@linux.ibm.com,
 linux-integrity@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Mon, 13 May 2024 14:58:46 +0200
In-Reply-To: <f88384a305b90708db3b30012f9edf09690dc5ee.camel@sipsolutions.net>
References: <20240513122754.1282833-1-roberto.sassu@huaweicloud.com>
	 <d4f4666bf745e83ea00b466b7a7cfb5132b8c7b9.camel@sipsolutions.net>
	 <096121b3e74a7971b5e6a3d77ca8889380de1885.camel@huaweicloud.com>
	 <f88384a305b90708db3b30012f9edf09690dc5ee.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwD36hOKDkJmEmMYCA--.45732S2
X-Coremail-Antispam: 1UD129KBjvdXoW7Xr4fXF4xJw48Xry8Zw4DCFg_yoWDGrXEva
	s2yFW8K39xWF47A39Igr98Janrtr40krn8J34xGFnxtw1kAFWkGa4kArWSvwn5J3W8tF97
	u34DtF1rGr1ayjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWUJVWUCwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIE14v26r4j6F4UM28EF7xvwVC2z280aVCY1x0267
	AKxVW8JVW8Jr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
	k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQACBF1jj51CKgAAsD

On Mon, 2024-05-13 at 14:52 +0200, Johannes Berg wrote:
> On Mon, 2024-05-13 at 14:42 +0200, Roberto Sassu wrote:
> > On Mon, 2024-05-13 at 14:29 +0200, Johannes Berg wrote:
> > > On Mon, 2024-05-13 at 14:27 +0200, Roberto Sassu wrote:
> > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > >=20
> > > > Disable UBSAN sanitization on UML, since UML does not support it.
> > > >=20
> > >=20
> > > Luckily, that isn't actually true, nor does it actually do this at al=
l.
> > > Please fix the commit message.
> >=20
> > Thanks, I was actually wondering. I based that statement based on
> > ARCH_HAS_UBSAN=3Dn.
> >=20
> > Any other solution would be ok.
>=20
> Not sure I get it. What you're doing in the patch is perfectly fine and
> almost certainly required, but you're definitely not disabling UBSAN on
> ARCH=3Dum as you described in the commit message?

Ok, I guess the right word is instrumentation (got it from commit
d4be85d068b44). And the reason is that the vDSO is executing in user
space. Will fix it.

Thanks

Roberto


