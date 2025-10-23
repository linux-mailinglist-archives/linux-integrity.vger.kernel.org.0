Return-Path: <linux-integrity+bounces-7516-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFB8C01813
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Oct 2025 15:43:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 751751A6536B
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Oct 2025 13:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB546322C99;
	Thu, 23 Oct 2025 13:35:59 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFA430BF55;
	Thu, 23 Oct 2025 13:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761226559; cv=none; b=one5OnOEO338D7cfYNcdmrtKe1+obf7oIJ5/9/42yuvhM+/P/h0EKG+rvzrRrM9qOyjI166Bnpsb9/de5Oi+AQ4opbPBCfLAqErtslYqlV13J4wKsNvaXz8sSyrun4zsiJ2L0FBpvHEV8JPZa3klGni90aqgg2ke1rUUcSkc51M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761226559; c=relaxed/simple;
	bh=wGU/S2LTwlCClO0hA/PN5mbemp2kwCK+/WHfdY+ctQo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BaxH6xnEJ9glLGG7Od2qFuHT2Bz4z53bPRNid6KIPXuNOEzsnQT8EGSLuRPkqGhibEHVXcH13Bc0rFnQa/FROP7wj4GGfB9lwNTlc06xxIS9Trg8QiFK3VwW6IEsnbCb0dVvmH1YhP7nxJBy9ZNHyPMsz7t/ULn4Ho4iG9c/7HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4csn8Z5qq5z1HC4J;
	Thu, 23 Oct 2025 21:35:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 84DB31402DE;
	Thu, 23 Oct 2025 21:35:49 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCHr3wsL_po9nzBAA--.31688S2;
	Thu, 23 Oct 2025 14:35:49 +0100 (CET)
Message-ID: <d51ffec03676bcd6f5427f81829073f06921d84f.camel@huaweicloud.com>
Subject: Re: [PATCH] KEYS: encrypted: Use designated initializers for
 match_table_t structs
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, Thorsten Blum
	 <thorsten.blum@linux.dev>
Cc: Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>, 
 Jarkko Sakkinen <jarkko@kernel.org>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, 
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 23 Oct 2025 15:35:37 +0200
In-Reply-To: <e60f6a07d00c1fd87b4509947e8738ecab9560b4.camel@HansenPartnership.com>
References: <20251009115817.368170-2-thorsten.blum@linux.dev>
	 <9e7488652ab73d7c5c2f93ea3c68253a9f08cd82.camel@HansenPartnership.com>
	 <93D80E9A-7CBC-40D1-BC21-7BC2BB465AC4@linux.dev>
	 <e60f6a07d00c1fd87b4509947e8738ecab9560b4.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwCHr3wsL_po9nzBAA--.31688S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Cr4ktF45GFyxWF1xGr1xKrg_yoW8Zw4xpa
	yrKasxKrWDAr1Iyrn7t392v34Svr9xta45Jrn8ur93C34kWF9ayr1ftF4F9F9xur47Gr12
	vF48XayDAr9FyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAKBGj5iHcJJQAAsN

On Thu, 2025-10-09 at 09:51 -0400, James Bottomley wrote:
> On Thu, 2025-10-09 at 15:30 +0200, Thorsten Blum wrote:
> > On 9. Oct 2025, at 14:44, James Bottomley wrote:
> > > On Thu, 2025-10-09 at 13:58 +0200, Thorsten Blum wrote:
> > > > Use designated initializers for 'key_format_tokens' and
> > > > 'key_tokens' to allow struct fields to be reordered more easily
> > >=20
> > > How does it improve that?=C2=A0 The key,value pairs are surrounded by
> > > braces so we just cut and paste the lot anyway.
> >=20
> > Using designated initializers (especially for global structs) allows
> > the fields of struct match_token from linux/parser.h to be reordered
> > or extended more easily, improving overall maintainability.
>=20
> Why would we ever want to reorder them?  The reason the ordering is
> {token, parser} string is because that's the nicest order to read them
> in.

I also join James regarding this. I find it fine as it is.

Consider also that there might be patches depending on this change that
cannot be automatically ported to stable kernels. Then, extra work is
required to find which dependencies are needed and backport them as
well.

Thanks

Roberto

> > > > and to improve readability.
> > >=20
> > > I don't think I agree with this when looking through the code,
> > > especially because this is the way it's done for *every* option in
> > > the entire key subsystem.=C2=A0 So firstly I really don't think it's
> > > helpful for only encrypted keys to be different from everything
> > > else and secondly when I read the code (as I often do to figure out
> > > what the options mean), the additional .token and .pattern just get
> > > in the way of what I'm looking for.
> >=20
> > I just stumbled upon this and didn't check any other files.
>=20
> jejb@lingrow:~/git/linux> git grep 'match_table_t'|wc -l
> 49
>=20
> I'll leave it as an exercise to you to figure out how many use the
> style you're proposing.
>=20
> There's definite advantage in uniformity and even if I accepted the
> readability argument, which I don't, it's too small a reason to churn
> nearly 50 files one at a time.
>=20
> Regards,
>=20
> James
>=20


