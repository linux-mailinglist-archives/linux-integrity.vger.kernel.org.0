Return-Path: <linux-integrity+bounces-7914-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 401EACB657C
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 16:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E7693005EA2
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 15:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB968304980;
	Thu, 11 Dec 2025 15:24:56 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED3A303C9B;
	Thu, 11 Dec 2025 15:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765466696; cv=none; b=oQ9Ha0tRSv6naGW6lmNZkuYnYt6gMauj1vokmaGfYP6HEFMw2cqZ0ry8dX1/FemaQehXFwucqRV5M4xrHx0zBoCEB1PoCrKdPv0XqdyjnPOwIWvc62t+xSebar7DaI/Z68uoP34TOe1wL2j1NOZ9rvUK9PPibRVXXsecYcYYoyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765466696; c=relaxed/simple;
	bh=FFBgc2nJLs1dViD4ivxMx6AI8sPcarJjZO3QIYEmPZk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=W4eTkmFQrDSyty3LrkvSld/ktDwjgHP9BG9xPiUVTMv9ZzO74A7Ngu1zjpiX+3pb5H7rC2RM0D2FD6fXCsBiUKtU/9U4iN5gA4+M1Qthve4Aj5HyAliPnVRoF6R+6SHU4uYx/6Ghf3ijbOhi4J+MC3WeFVcgV5ljVX8Xeyzn1As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dRxDh2ktFzsjqf;
	Thu, 11 Dec 2025 23:23:16 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 2D4C640569;
	Thu, 11 Dec 2025 23:24:51 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAney844jpppBO_AA--.18321S2;
	Thu, 11 Dec 2025 16:24:50 +0100 (CET)
Message-ID: <75d8b82a2e493ca919926310c5f381221555d82d.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH] ima: Add support for staging measurements for
 deletion
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Gregory Lumen <gregorylumen@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, 
 eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com,  linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
  linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
 chenste@linux.microsoft.com, nramas@linux.microsoft.com, Roberto Sassu
 <roberto.sassu@huawei.com>
Date: Thu, 11 Dec 2025 16:24:38 +0100
In-Reply-To: <2f550d4cd860022e990d1de62049df85a6a86df8.camel@huaweicloud.com>
References: <20251209101725.3680225-1-roberto.sassu@huaweicloud.com>
	 <207fd6d7-53c-57bb-36d8-13a0902052d1@linux.microsoft.com>
	 <d7418d0afa696b8da67e4f25fd0dc1b9d6fd908f.camel@huaweicloud.com>
	 <2f550d4cd860022e990d1de62049df85a6a86df8.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAney844jpppBO_AA--.18321S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Kry5Zr1rCr1xZr4Utw1UJrb_yoW8Ww4rpa
	yxG3Wj9F4DX34akw1Iqwn2y3yFk3yrtr4DJr15Ka4ru345XF1v9F4F93yYqa4DCrsIyr1a
	vFW0qay5C3WqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQATBGk6sm8DCAACsR

On Thu, 2025-12-11 at 15:50 +0100, Roberto Sassu wrote:
> On Thu, 2025-12-11 at 10:56 +0100, Roberto Sassu wrote:
> > On Wed, 2025-12-10 at 11:12 -0800, Gregory Lumen wrote:
> > > Roberto,
> > >=20
> > > The proposed approach appears to be workable. However, if our primary=
 goal=20
> > > here is to enable UM to free kernel memory consumed by the IMA log wi=
th an=20
> > > absolute minimum of kernel functionality/change, then I would argue t=
hat=20
> > > the proposed Stage-then-delete approach still represents unnecessary=
=20
> > > complexity when compared to a trim-to-N solution. Specifically:
>=20
> The benefit of the Stage-then-delete is that you don't need to scan the
> IMA measurements list in advance to determine what to trim, you just
> trim everything by swapping list head (very fast) and then you can read
> and delete the measurements out of the hot path.

I forgot: I will also add in my patch the ability to stage and trim in
one step, to satisfy your use case.

Roberto

> [...]
>=20
> >=20
> > > - There exists a potential UM measurement-loss race condition introdu=
ced=20
> > > by the staging functionality that would not exist with a trim-to-N=
=20
> > > approach. (Occurs if a kexec call occurs after a UM agent has staged=
=20
> > > measurements for deletion, but has not completed copying them to=20
> > > userspace). This could be avoided by persisting staged measurements a=
cross=20
> > > kexec calls at the cost of making the proposed change larger.
> >=20
> > The solution is to coordinate the staging with kexec in user space.
>=20
> To avoid requiring coordination in user space, I will try to see if I
> could improve my patch to prepend the staged entries to the current
> measurement list, before serializing them for kexec().
>=20
> Roberto


