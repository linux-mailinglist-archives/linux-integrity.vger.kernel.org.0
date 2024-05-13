Return-Path: <linux-integrity+bounces-2372-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7851D8C41A2
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2024 15:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B1CC1F23801
	for <lists+linux-integrity@lfdr.de>; Mon, 13 May 2024 13:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E7615218F;
	Mon, 13 May 2024 13:17:14 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E4959164;
	Mon, 13 May 2024 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715606234; cv=none; b=r72l8sYB369vmKTlrLcP9d7I3DW98mdwwaYzn/HOA9aj1ehzomGLQ/QicZ2gxaXgXLmhgIrbGLYz1T41yJJbkqQms3K315cs+tXv1Z/1wNGXKmnauyfRcjlCjE2DQFEyoaKdgluEo2HMime0lVmMskZ+65ou1Ac2+6YKzFBjMT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715606234; c=relaxed/simple;
	bh=k+8GpZNBlKXzQ26D79fDJhu5nOiOh+IpMZings0a3n8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RxXH0KeiWkoS0j/kAtZNnPHw6EFBlCtW4QWS2WEeyGEOE4KZzMTQbSA1i520giD/bShi9ji9jrhGFqGjDBq1pBZkjkyE7YtxHDFa1raSf2Eze0Ec4YjDOFVTbaDT+ErUqOx1Oy0azEBoAnEmUrw8okof21rXa0LLes0QxZzP1kM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4VdKMp3XR6z9v7J2;
	Mon, 13 May 2024 21:00:06 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id ED8321400CB;
	Mon, 13 May 2024 21:17:08 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwB3sCTKEkJmHCQTCA--.61498S2;
	Mon, 13 May 2024 14:17:08 +0100 (CET)
Message-ID: <505192e0d4a8d336ff0e934590c761de3a72e3a9.camel@huaweicloud.com>
Subject: Re: [PATCH] arch/x86/um: Disable UBSAN sanitization
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Johannes Berg <johannes@sipsolutions.net>, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com
Cc: x86@kernel.org, linux-um@lists.infradead.org,
 linux-kernel@vger.kernel.org,  zohar@linux.ibm.com,
 linux-integrity@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Date: Mon, 13 May 2024 15:16:55 +0200
In-Reply-To: <d4f9861effd64c155f93cc712d2c7660b1cf2e4a.camel@sipsolutions.net>
References: <20240513122754.1282833-1-roberto.sassu@huaweicloud.com>
	 <d4f4666bf745e83ea00b466b7a7cfb5132b8c7b9.camel@sipsolutions.net>
	 <096121b3e74a7971b5e6a3d77ca8889380de1885.camel@huaweicloud.com>
	 <f88384a305b90708db3b30012f9edf09690dc5ee.camel@sipsolutions.net>
	 <dba181a54e76ba2916ecd4747f76e40e6fbbb757.camel@huaweicloud.com>
	 <d4f9861effd64c155f93cc712d2c7660b1cf2e4a.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwB3sCTKEkJmHCQTCA--.61498S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tFW5uF1DJryDJF43XF43Jrb_yoW8Gr48pa
	42yF1fGrsYvryIyF1vq3yYqF1vyw48Ga1UXrn8Cry7Zr1qkF1fGr43tFyrua4qgrn7Jw1Y
	krZ0q347Wr1UZF7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr1j6F4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
	AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
	aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbPEf5UUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQACBF1jj51CVgAAs-

On Mon, 2024-05-13 at 15:08 +0200, Johannes Berg wrote:
> On Mon, 2024-05-13 at 14:58 +0200, Roberto Sassu wrote:
> > On Mon, 2024-05-13 at 14:52 +0200, Johannes Berg wrote:
> > > On Mon, 2024-05-13 at 14:42 +0200, Roberto Sassu wrote:
> > > > On Mon, 2024-05-13 at 14:29 +0200, Johannes Berg wrote:
> > > > > On Mon, 2024-05-13 at 14:27 +0200, Roberto Sassu wrote:
> > > > > > From: Roberto Sassu <roberto.sassu@huawei.com>
> > > > > >=20
> > > > > > Disable UBSAN sanitization on UML, since UML does not support i=
t.
> > > > > >=20
> > > > >=20
> > > > > Luckily, that isn't actually true, nor does it actually do this a=
t all.
> > > > > Please fix the commit message.
> > > >=20
> > > > Thanks, I was actually wondering. I based that statement based on
> > > > ARCH_HAS_UBSAN=3Dn.
> > > >=20
> > > > Any other solution would be ok.
> > >=20
> > > Not sure I get it. What you're doing in the patch is perfectly fine a=
nd
> > > almost certainly required, but you're definitely not disabling UBSAN =
on
> > > ARCH=3Dum as you described in the commit message?
> >=20
> > Ok, I guess the right word is instrumentation (got it from commit
> > d4be85d068b44). And the reason is that the vDSO is executing in user
> > space. Will fix it.
>=20
> No, UBSAN is fine, but you're only disabling it for the vDSO :) The
> commit message doesn't even mention the vDSO though.

You are right, the commit message was misleading without vDSO.

Thanks

Roberto


