Return-Path: <linux-integrity+bounces-7856-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 11ACDCADF09
	for <lists+linux-integrity@lfdr.de>; Mon, 08 Dec 2025 18:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7E0953011332
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Dec 2025 17:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5215024676D;
	Mon,  8 Dec 2025 17:50:36 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AD4231A55;
	Mon,  8 Dec 2025 17:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765216236; cv=none; b=uDEAyjXEOkcNOIewL2NXdODUpfTWFbzgm9PPFZVHacqeuOQ2YX20AzF6XUzqJkCkbVkyU/Qe36qLlNRL/65aIn4b3uqeiGhZoM+BpwyHZuH+UONc2QV3hao4wZeoCczhALJM5NYaMKfhWlgCNutoLHu+qX89sLPH2jSKM3bXpvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765216236; c=relaxed/simple;
	bh=ugrq+1fhdT8zSMcIAvHLQgqka7EAB/wEn/mJ23StHjM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UojX5Nkw7Gf9V5Ux6PJqouYW33ZiYpdI/hGEZogmCszh3lPLS+uglqipbM01VYskBdLem6godI4ZkU7l1y9bGLt51ZgAsIEvLQpZnV0PqLP9gEeBnNj5NmoLceRyWzuULpwVh5VLmGE79sf5nNeqAXrlmL7wVHXFG264eni71Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dQ8c86TWfz1HCZj;
	Tue,  9 Dec 2025 01:48:56 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 851AB40569;
	Tue,  9 Dec 2025 01:50:30 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDnPDHcDzdpdgiSAA--.7539S2;
	Mon, 08 Dec 2025 18:50:29 +0100 (CET)
Message-ID: <6b5e09ad1388d4352ccab6170a4eae6f574dcfeb.camel@huaweicloud.com>
Subject: Re: [PATCH 1/1] IMA event log trimming
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Gregory Lumen <gregorylumen@linux.microsoft.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, steven chen
 <chenste@linux.microsoft.com>, linux-integrity@vger.kernel.org, 
 zohar@linux.ibm.com, roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com, 
 eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com,  linux-security-module@vger.kernel.org,
 anirudhve@linux.microsoft.com,  nramas@linux.microsoft.com,
 sushring@linux.microsoft.com
Date: Mon, 08 Dec 2025 18:50:17 +0100
In-Reply-To: <862fa081-df51-084-ae2c-efa0eae0ca7e@linux.microsoft.com>
References: <20251202232857.8211-1-chenste@linux.microsoft.com>
	  <20251202232857.8211-2-chenste@linux.microsoft.com>
	  <099492ee58996b6f18d73232677757ecadb14cb7.camel@huaweicloud.com>
	  <34d739c2cf15baf78dff5acb7ae3ddd7ad47f219.camel@HansenPartnership.com>
	 <1ca00e3238e804db9280abf8655364c2662754ca.camel@huaweicloud.com>
	 <862fa081-df51-084-ae2c-efa0eae0ca7e@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDnPDHcDzdpdgiSAA--.7539S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF4DZr4DXF4xWw4xCFWDtwb_yoW5Gw47pF
	W3G34kGrWDJa4kGw1kAw4xJr409ws5JF4UGrn5Wa4fZ3Z8ur929ryYy3ya9an7Ar4kt34Y
	v3yIqry5Xa1qyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAQBGk2ve4EHAAAsB

On Mon, 2025-12-08 at 09:21 -0800, Gregory Lumen wrote:
> > Rather than designing the interface absent use cases, could we give use
> > cases first so we know it fits?
>=20
> I would also like to request that we include operational considerations i=
n=20
> the interface design; specifically, which additional signals can or shoul=
d=20
> be made available to UM to assist in diagnosing log validation failures.=
=20
> This seems called for as any form of log trimming will introduce a new=
=20
> potential cause for validation failures (unexpected trimming).
>=20
> With the proposed changes, the only signal available to system operators=
=20
> is the validation failure itself, with no signal that could be used to=
=20
> determine if the failure was the result of an unexpected trim or a loss o=
f=20
> synchronization between the log and the PCRs (either through an unexpecte=
d=20
> PCR extend, or tampering with the measurement list). Any of these may=20
> indicate malicious activity, but they may also result from system=20
> configuration issues that operators would need to diagnose and resolve.

I don't agree with this. User space can keep a persistent state, and
resume from where it was interrupted. There is no risk of loss of data,
if user space deletes staged measurements only after the read is
complete.

The same comment applies for coordination between different user space
agents. It would not be too hard to expose an interface managed by a
new user space component, providing similar data as IMA (even showing
the full measurements list without its users being aware of the
snapshots). The other agents can fetch the data from the new interface.

And also, I don't see the problem in developing more complex user space
programs which link the measurement entries to PCR values, and anything
that is desirable.

And if from the kernel perspective all we need to do is a list replace,
for me that is the most efficient solution.

Roberto

> Tracking and exposing either the total number of trimmed measurements or=
=20
> the most recent trimmed-to PCR values by the kernel would allow system=
=20
> operators to determine whether a failure was caused by unexpected trimmin=
g=20
> or integrity issues. (Storing the PCR values also enables validation of=
=20
> the retained measurements even after an unexpected trim, though I=E2=80=
=99m unsure=20
> how often that signal would prove useful.)
>=20
> Neither approach appears to add any additional attack surface beyond=20
> raising the likelihood of incorrectly or insecurely implemented UM=20
> attestation agents. Though that risk (and the additional kernel=20
> complexity) should be weighed against the value of the additional=20
> diagnostic signals.
>=20
> -Gregory Lumen


