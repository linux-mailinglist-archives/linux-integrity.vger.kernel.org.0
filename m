Return-Path: <linux-integrity+bounces-7913-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 719ECCB6403
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 15:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9F8FA3010A97
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 14:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E2D28D8DF;
	Thu, 11 Dec 2025 14:50:39 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D372D5932;
	Thu, 11 Dec 2025 14:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765464638; cv=none; b=hY2A5e4phaxfJ9b0TfqeC8YwHLqZ/bzRTUuPXkWPL4yXDvqfnvCaEf0Xj+ju4U3NNhWqzg7NTlMC/RfBoBTOEoooSxqkOtDSQc0ELEesuVmQCR7z7+GSf7mv4mQ1cHT/Toycv8psHsS6Jdg5kbjrQ6wgxQNTZmtJrTMnREmzMUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765464638; c=relaxed/simple;
	bh=phVezHEZsvYhsOx5ihY+7Hz2BGkvcWpP1lKSBbwAxzw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qEO8+iKntJ7DP/uPtVjSXc8Ghtkw0VTD4yS+rL4ApGgI9TFA0w6JWqQfxTqUuEuQci6pyc/3/5jx/OVGyQSpCDl6tuUdfU2DHyesos0U/XSCmUDVlLsZ7XdnbxvvGwj+hi9dJSsWKH/r3tg+2IcR28aN//1pVueyst+O24gBYSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTPS id 4dRwT149vbzpV7w;
	Thu, 11 Dec 2025 22:48:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 67CA94056B;
	Thu, 11 Dec 2025 22:50:33 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwDH2Qov2jppD5e9AA--.15946S2;
	Thu, 11 Dec 2025 15:50:32 +0100 (CET)
Message-ID: <2f550d4cd860022e990d1de62049df85a6a86df8.camel@huaweicloud.com>
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
Date: Thu, 11 Dec 2025 15:50:22 +0100
In-Reply-To: <d7418d0afa696b8da67e4f25fd0dc1b9d6fd908f.camel@huaweicloud.com>
References: <20251209101725.3680225-1-roberto.sassu@huaweicloud.com>
	 <207fd6d7-53c-57bb-36d8-13a0902052d1@linux.microsoft.com>
	 <d7418d0afa696b8da67e4f25fd0dc1b9d6fd908f.camel@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwDH2Qov2jppD5e9AA--.15946S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KryUZw47GF1xAr1fCr43GFg_yoW8Xry7pa
	yxCw1Ikr4DX34Syw10qr1Iya4F93yktr4DJr15Ka4rC345XF1v9F4F93yYqa4DArsayF1Y
	vanYqrs8C3WqyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOB
	MKDUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgATBGk6smwCrAABs3

On Thu, 2025-12-11 at 10:56 +0100, Roberto Sassu wrote:
> On Wed, 2025-12-10 at 11:12 -0800, Gregory Lumen wrote:
> > Roberto,
> >=20
> > The proposed approach appears to be workable. However, if our primary g=
oal=20
> > here is to enable UM to free kernel memory consumed by the IMA log with=
 an=20
> > absolute minimum of kernel functionality/change, then I would argue tha=
t=20
> > the proposed Stage-then-delete approach still represents unnecessary=
=20
> > complexity when compared to a trim-to-N solution. Specifically:

The benefit of the Stage-then-delete is that you don't need to scan the
IMA measurements list in advance to determine what to trim, you just
trim everything by swapping list head (very fast) and then you can read
and delete the measurements out of the hot path.

[...]

>=20
> > - There exists a potential UM measurement-loss race condition introduce=
d=20
> > by the staging functionality that would not exist with a trim-to-N=20
> > approach. (Occurs if a kexec call occurs after a UM agent has staged=
=20
> > measurements for deletion, but has not completed copying them to=20
> > userspace). This could be avoided by persisting staged measurements acr=
oss=20
> > kexec calls at the cost of making the proposed change larger.
>=20
> The solution is to coordinate the staging with kexec in user space.

To avoid requiring coordination in user space, I will try to see if I
could improve my patch to prepend the staged entries to the current
measurement list, before serializing them for kexec().

Roberto


