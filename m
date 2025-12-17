Return-Path: <linux-integrity+bounces-8094-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7B7CC8BA9
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Dec 2025 17:18:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFC1D311A628
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Dec 2025 16:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7ED35CBC0;
	Wed, 17 Dec 2025 16:02:01 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158CF362156;
	Wed, 17 Dec 2025 16:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765987321; cv=none; b=XJ77gL7CKfbVvsVqtPCC8I/KFPEgJDArJA+VDkFYiL9O/M0/TyLGTpFc/vvbJb2m56nY1cPcvUgLowCuWCcTwtdFbEU+2uYQrEJuvjA6iAdI/IIIODSL0PfNL5rO73OqR1bmokgFMNioAOZpm4OrnJ5xfis+3a0X/f0SXAx0MkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765987321; c=relaxed/simple;
	bh=3tBfnhIcvaOCvVLu6oUHI66R0KQ2Zu83oZM/wnioNdU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qkc/t+hyDcOgouNiB8pcovdVwR3SGD5Uu7gVPYM/we3Rui+UaEkcCAiEy9AOe9+ZnTeLESu0MN51nPKC8X8gwy98gyXyACcYA/AlozBH7UAJjmVfcUaxhmqWH1U8PCU1UESaeQ7Jv70PoxV+2HIb72nbJXBmZ4o+BGSe/zjzZH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4dWdmL2wszzpTpL;
	Thu, 18 Dec 2025 00:00:02 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 73E8B40499;
	Thu, 18 Dec 2025 00:01:49 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAX4Wvj00JpZZRFAA--.54377S2;
	Wed, 17 Dec 2025 17:01:48 +0100 (CET)
Message-ID: <41ead1c44a678b597ffd3350cce332a8a5d4ac7c.camel@huaweicloud.com>
Subject: Re: [RFC][PATCH v2] ima: Add support for staging measurements for
 deletion and trimming
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mimi Zohar <zohar@linux.ibm.com>, corbet@lwn.net,
 dmitry.kasatkin@gmail.com,  eric.snowberg@oracle.com, paul@paul-moore.com,
 jmorris@namei.org, serge@hallyn.com
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	gregorylumen@linux.microsoft.com, chenste@linux.microsoft.com, 
	nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>
Date: Wed, 17 Dec 2025 17:01:36 +0100
In-Reply-To: <45ca26a5b08f42fb1318cd78a62dda20b9adb84e.camel@linux.ibm.com>
References: <20251212171932.316676-1-roberto.sassu@huaweicloud.com>
	 <45ca26a5b08f42fb1318cd78a62dda20b9adb84e.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwAX4Wvj00JpZZRFAA--.54377S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCF1fZFyUJw1rZrWrCr1UGFg_yoW5GrW7pF
	WfW3409a1DJ34Syr18Gw48K34Fv3yxtan8Jrn8G3s5AFn8GFy09F90kw4ava98Jryktr1Y
	vwsIvFZ8W3WDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAFBGlCIZcJMQABsn

On Wed, 2025-12-17 at 10:26 -0500, Mimi Zohar wrote:
> Hi Roberto,
>=20
> Thank you!  Everything is working as designed.
>=20
> - Only public functions require kernel-doc comments, but other functions =
would
> benefit having a comment.
>=20
> - As I mentioned in response to Steven's patch, "After trimming the measu=
rement
> list, existing verifiers, which walk the IMA measurement list, will obvio=
usly
> fail to match the PCRs.  Breaking existing userspace applications is a pr=
oblem
> and, unfortunately, requires yet another Kconfig option.  It needs to be =
at
> least mentioned here in the patch description."

Hi Mimi

sure.

> On Fri, 2025-12-12 at 18:19 +0100, Roberto Sassu wrote:
> > From: Roberto Sassu <roberto.sassu@huawei.com>
> >=20
> > Introduce the ability of staging the entire (or a portion of the) IMA
> > measurement list for deletion. Staging means moving the current content=
 of
> > the measurement list to a separate location, and allowing users to read=
 and
> > delete it. This causes the measurement list to be atomically truncated
> > before new measurements can be added.=C2=A0
>=20
> This last sentence is the crux of your of your proposal.
>  -> "quickly be atomically ... so ..."

Ok.

> I must be missing something.  With the ability of trimming N records, it'=
s
> unclear to me the benefit of staging the measurement list and requiring a
> separate deletion. The measurement list can be read before trimming witho=
ut
> loosing any measurements.  Like now, the entire measurement list could be=
 moved
> to a staging area. Instead of freeing all of the records, only N records =
would
> be freed.  Afterwards the remaining staged measurements (N+1) could be re=
stored
> to the head of the measurement list.

My hope is to avoid trimming based on N in the kernel, but rather offer
the same functionality on a user space service that simply gets all the
measurements it can from the kernel (with the stage all approach), and
exposes the desired measurements to requesting applications (based on N
or based on a PCR value, as Microsoft requested).

I think it was already mentioned earlier in the discussion. By reading
and trimming at two different times, there is a race window where two
separate remote attestation agents determine N on the current
measurements list and attempt to trim one after another with the same
N, but the latter attempts to do it on an already trimmed measurements
list. They could take the write lock for the read too to avoid that.

The stage all approach is not susceptible to this race window, because
it does not require a prior read before the operation.

Thanks

Roberto


