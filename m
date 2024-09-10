Return-Path: <linux-integrity+bounces-3499-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E47E2972CDD
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2024 11:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 632DFB26813
	for <lists+linux-integrity@lfdr.de>; Tue, 10 Sep 2024 09:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E751779B1;
	Tue, 10 Sep 2024 09:05:36 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D972C186E4B;
	Tue, 10 Sep 2024 09:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725959136; cv=none; b=mUnVn8QsZLHGRV0qqD1WbUeDMpqty9Ce4PFX1zeHvWLEWyWRlPKfr+LEyaRjm0u5b5463e6HQtqG9lgs4dfp8GtIbd5GnMFs0kQAyvdQk00mGN4bGRExHRNbMddrCMams+RTJfNjpCBX1Ja8r4qDJ0ancM1QnjmH0fJkkRdZmFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725959136; c=relaxed/simple;
	bh=ME5ZSrMnAqqvaRqAbtgEZO0yBtF+Og84eHKlHTZAUAA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Qm2CNPx4iBrEmBNX+EA9xRFP4OqKMmI0MmIemiY4I8Uw6TZmEFtUS6ganUrRnfXp8//g5h5IJD1V7Le7iEgzR4eCrv+CyHvJ2XhSK6XzBsln9J0zeTJOhHimQmUHlu+uCQnS7lrTPMRUewyQq8H2qzCSpr7jP5fcg/i/ZYSWwuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4X2xwb1N4Hz9v7JM;
	Tue, 10 Sep 2024 16:40:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 0A724140134;
	Tue, 10 Sep 2024 17:05:18 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAXqC_DC+Bm7ZKiAA--.51699S2;
	Tue, 10 Sep 2024 10:05:16 +0100 (CET)
Message-ID: <92fbcc4c252ec9070d71a6c7d4f1d196ec67eeb0.camel@huaweicloud.com>
Subject: Re: [regression] significant delays when secureboot is enabled
 since 6.10
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Linux regressions mailing list <regressions@lists.linux.dev>, James
 Bottomley <James.Bottomley@HansenPartnership.com>, Jarkko Sakkinen
 <jarkko@kernel.org>
Cc: keyrings@vger.kernel.org, "linux-integrity@vger.kernel.org"
	 <linux-integrity@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Pengyu Ma <mapengyu@gmail.com>
Date: Tue, 10 Sep 2024 11:05:04 +0200
In-Reply-To: <0b4a5a86-a9f6-42d1-a9ba-ec565b336d3a@leemhuis.info>
References: <0b4a5a86-a9f6-42d1-a9ba-ec565b336d3a@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAXqC_DC+Bm7ZKiAA--.51699S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zr1fXry3Kr15AF48AF1rXrb_yoW8Zw13pa
	y8Kw4rKryvq3WIka1kAw109FWqy395JryYkwn8G34rAa43Za4kZw1S9r4YgFyjvrykGa1F
	vFsF9r1qk3s5AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQACBGbfqvQF9wAAsS

On Tue, 2024-09-10 at 11:01 +0200, Linux regression tracking (Thorsten
Leemhuis) wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker.
>=20
> James, Jarkoo, I noticed a report about a regression in
> bugzilla.kernel.org that appears to be caused by this change of yours:
>=20
> 6519fea6fd372b ("tpm: add hmac checks to tpm2_pcr_extend()") [v6.10-rc1]
>=20
> As many (most?) kernel developers don't keep an eye on the bug tracker,
> I decided to forward it by mail. To quote from
> https://bugzilla.kernel.org/show_bug.cgi?id=3D219229 :
>=20
> > When secureboot is enabled,
> > the kernel boot time is ~20 seconds after 6.10 kernel.
> > it's ~7 seconds on 6.8 kernel version.
> >=20
> > When secureboot is disabled,
> > the boot time is ~7 seconds too.
> >=20
> > Reproduced on both AMD and Intel platform on ThinkPad X1 and T14.
> >=20
> > It probably caused autologin failure and micmute led not loaded on AMD =
platform.
>=20
> It was later bisected to the change mentioned above. See the ticket for
> more details.

Hi

I suspect I encountered the same problem:

https://lore.kernel.org/linux-integrity/b8a7b3566e6014ba102ab98e10ede0d574d=
8930e.camel@huaweicloud.com/

Going to provide more info there.

Roberto

> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
>=20
> [1] because bugzilla.kernel.org tells users upon registration their
> "email address will never be displayed to logged out users"
>=20
> P.S.: let me use this mail to also add the report to the list of tracked
> regressions to ensure it's doesn't fall through the cracks:
>=20
> #regzbot introduced: 6519fea6fd372b
> #regzbot from: Pengyu Ma <mapengyu@gmail.com>
> #regzbot duplicate: https://bugzilla.kernel.org/show_bug.cgi?id=3D219229
> #regzbot title: tpm: significant delays when secureboot is enabled
> #regzbot ignore-activity


