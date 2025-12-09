Return-Path: <linux-integrity+bounces-7866-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F80CAF792
	for <lists+linux-integrity@lfdr.de>; Tue, 09 Dec 2025 10:38:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B74FA3028180
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Dec 2025 09:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7F0269D18;
	Tue,  9 Dec 2025 09:37:08 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482B521FF55;
	Tue,  9 Dec 2025 09:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765273028; cv=none; b=V8V7kaEKG6b/UbAYMjty/yXkOWEIR+/rWjyrYJFGjvXlxlM5SxjxYz7za9BsPDF/HX/V1fM5HK597DJppm9vnKAuJ4pRC7SYRw3sSPPoL0XVUsww8UeVqzw2wYRFo73/KIJdZmUxIxkVZmnm8xjN2UKItEnxwdGxHWJ+0nkzjpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765273028; c=relaxed/simple;
	bh=3ZclGatReBjs4lijHIn4/vP51TImvrks08wmlBe1Jp8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AkK5eX/DXh5Y6VdyoqfgP9h1+/MEz+0GrYm0xRn9hEEE94665oNGIrJSTWUF9G9yzKCJGhoUbwz1+6XO56UMYS5SwhJRIR1xi3Zo4PKrFM1/q81Rf9wGaSiICoIp9nXXMRxKZGAsrI8ov58CaZB2UgSGw6wUQpO6n9MMZ2VsWfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dQYcH3kNrz1HCDb;
	Tue,  9 Dec 2025 17:35:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id E800D40569;
	Tue,  9 Dec 2025 17:37:01 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBHXxCz7TdpdkSbAA--.64937S2;
	Tue, 09 Dec 2025 10:37:01 +0100 (CET)
Message-ID: <736e21826c6a283d74d592393c392abbff56a409.camel@huaweicloud.com>
Subject: Re: [PATCH 1/1] IMA event log trimming
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: James Bottomley <James.Bottomley@HansenPartnership.com>, steven chen
	 <chenste@linux.microsoft.com>, linux-integrity@vger.kernel.org
Cc: zohar@linux.ibm.com, roberto.sassu@huawei.com,
 dmitry.kasatkin@gmail.com,  eric.snowberg@oracle.com, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com, 
 linux-security-module@vger.kernel.org, anirudhve@linux.microsoft.com, 
 gregorylumen@linux.microsoft.com, nramas@linux.microsoft.com, 
 sushring@linux.microsoft.com
Date: Tue, 09 Dec 2025 10:36:48 +0100
In-Reply-To: <d0c00469a8501483baffaf1158102c0f2c5211e8.camel@HansenPartnership.com>
References: <20251202232857.8211-1-chenste@linux.microsoft.com>
	 <20251202232857.8211-2-chenste@linux.microsoft.com>
	 <099492ee58996b6f18d73232677757ecadb14cb7.camel@huaweicloud.com>
	 <34d739c2cf15baf78dff5acb7ae3ddd7ad47f219.camel@HansenPartnership.com>
	 <1ca00e3238e804db9280abf8655364c2662754ca.camel@huaweicloud.com>
	 <d0c00469a8501483baffaf1158102c0f2c5211e8.camel@HansenPartnership.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwBHXxCz7TdpdkSbAA--.64937S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXw4DuF1fury7JrWxtF1xGrg_yoW5GrWfpF
	WSg34xCFnrtaySy34kZw18CryF9ws5XFW5Gr1kGr95A3s8GFs29r1jk3yYv397Ar9xJF1a
	qa1aqFyYka4DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgARBGk2vesNLwAAs8

On Tue, 2025-12-09 at 07:17 +0900, James Bottomley wrote:
> On Mon, 2025-12-08 at 10:40 +0100, Roberto Sassu wrote:
> > I have the impression that none the functionality you cited has to be
> > implemented in the kernel, because the only component one can trust
> > to verify the integrity of the IMA measurements list is the TPM.
> > Whether either the kernel or user space retain the measurements is
> > irrelevant.
>=20
> That's correct, I'm not advocating moving quoting into the kernel.  Co-
> ordinating the trim with where the quote gets you to is phenomenally
> useful.  While you could theoretically store any mismatch in userspace,
> having two locations for the log makes it more error prone.
>=20
> > I believe that the only role of the kernel is to get rid of the
> > measurements entries as fast as possible (the kernel would act more
> > like a buffer).
>=20
> I wouldn't say that, I'd say to get rid of measurements that the user
> has indicated are of no further use.

Different users could have different and conflicting requirements, and
we would spend time trying to conciliate those. We can avoid that by
doing it the same for everyone, and the additional cost of handling it
I believe it is fair.

I could accept staging N entries since I already agreed with Gregory
and Steven, and since it requires only an extra iteration in the linked
list. The other desired functionality should be implemented in user
space.

> > This was actually the intent of my original proposal in
> > https://github.com/linux-integrity/linux/issues/1=C2=A0. The idea of
> > staging (was snapshotting, but Mimi thinks the term is not accurate)
> > is simply to detach the entire IMA measurement list as fast as
> > possible. Further read and delete after staging is done without
> > interfering with new measurements (sure, the detaching of the hash
> > table is not yet as efficient as I hoped).
>=20
> From the application point of view, offloading the log and random
> points is a bit more work because now the log collector has to be
> modified to look in multiple locations and we'd also need an agreement
> of where those locations are and how the log is sequenced in a naming
> scheme so it's the same for every distribution.  If the application is
> in charge of trimming the log at a particular point, collection remains
> the same (it can simply be the existing in-kernel location), so we
> don't need a cross distro agreement, and the trim can simply be added
> as an extra function.

It could be a single location, the user space program would be
responsible to present the IMA measurement list as if it was never
trimmed.

Roberto


