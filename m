Return-Path: <linux-integrity+bounces-5311-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4128FA67277
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 12:20:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B403BD018
	for <lists+linux-integrity@lfdr.de>; Tue, 18 Mar 2025 11:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0329920B1E1;
	Tue, 18 Mar 2025 11:20:05 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33EB1FCF47;
	Tue, 18 Mar 2025 11:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742296804; cv=none; b=OURlnRNohtRwZpvhKCP+fYAhH9yz775A0XabMXtmNG4/13tncZI0+365wqXfk4TJ6zjd3RBH3tiOGtV+dABnYY4bVDLEpRctVhmuLxikNUdTsj+yeIP3O4nsDFHtB1PBsfZejQxeheo11sosoU1cEsRxvW9x6qDN4PpXTqj+nYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742296804; c=relaxed/simple;
	bh=E4bvhLucTAO1dUIzTjxHKYt4vtYiDxItZT2Baea8gno=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PycksySdOnli1WtbUr1/ye4IcyY5Yb5yFIg8mm2b3wOs7OCb4WgiAtPFomAFdrToGhsigFcdV0ixtM931+7uEl6hie/2MDpbnNY8J07Efmn8iGA0017r8PtDluwTGWHgeWS+wqpbph4Vk4dACXYkbyaBhm2gF/NFlDzfuIXD3Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ZH85X6PVlzsR5W;
	Tue, 18 Mar 2025 19:00:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 651F81404A6;
	Tue, 18 Mar 2025 19:01:08 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDHmUhpUtlndFRpBA--.29145S2;
	Tue, 18 Mar 2025 12:01:07 +0100 (CET)
Message-ID: <d01f5ae9654ca07aa93cb061b21b79ff5c83aa79.camel@huaweicloud.com>
Subject: Re: [RFC PATCH v1 0/7] ima: get rid of hard dependency on SHA-1
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Nicolai Stange <nstange@suse.de>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>, Jarkko Sakkinen <jarkko@kernel.org>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
 linux-integrity@vger.kernel.org,  linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 18 Mar 2025 12:00:54 +0100
In-Reply-To: <20250313173339.3815589-1-nstange@suse.de>
References: <20250313173339.3815589-1-nstange@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDHmUhpUtlndFRpBA--.29145S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAF43GF1DKFyDAF1rGFWkCrg_yoWrGFyfpF
	Z2gF4Ykr18ZFyxGwnrAa129FWSg3y8CFy5Grn3Jw10vwnIva42gr48tF109FyfWryfX347
	tFn2y3s8Ca1UZFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UAwIDUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQALBGfZG1wDYAACsW

On Thu, 2025-03-13 at 18:33 +0100, Nicolai Stange wrote:
> Hi all,
>=20
> if no SHA-1 implementation was available to the kernel, IMA init would
> currently fail, rendering the whole subsystem unusable.
>=20
> This patch series is an attempt to make SHA-1 availability non-mandatory
> for IMA. The main motivation is that NIST announced to sunset SHA-1 by
> 2030 ([1]), whereby any attempt to instantiate it when booted in FIPS mod=
e
> would have to be made to fail with -ENOENT. As this does potentially have
> an impact on lifetimes for FIPS certifications issued today, distros migh=
t
> be interested in disabling SHA-1 downstream soon already.
>=20
> Anyway, making IMA to work without a SHA-1 implementation available is no=
t
> so straightforward, mainly due to that established scheme to substitute
> padded SHA-1 template hashes for PCR banks with unmapped/unavailable algo=
s.
> There is some userspace around expecting that existing behavior, e.g. the
> ima_measurement command from ([2]), and breaking that in certain scenario=
s
> is inevitable.
>=20
> I tried to make it the least painful possible, and I think I arrived at
> a not completely unreasonable solution in the end, but wouldn't be too
> surprised if you had a different stance on that. So I would be curious
> about your feedback on whether this is a route worth pursuing any further=
.
> FWIW, the most controversial parts are probably
>  - [1/7] ima: don't expose runtime_measurements for unsupported hashes
>  - [6/7] ima: invalidate unsupported PCR banks once at first use
>=20
> Note that I haven't tested this series thoroughly yet -- for the time bei=
ng
> I only ran a couple of brief smoke tests in a VM w/o a TPM  (w/ and w/o
> SHA-1 disabled of course).

+ Jarkko

Hi Nicolai

thanks a lot for the patches. Still didn't go through them, but if I
understood correctly you assume that the SHA1 PCR bank would be still
seen by IMA.

In light of deprecation of SHA1, is this assumption correct?

I would expect that TPM manufacturers or even the TPM driver would
change to fullfill that.

I guess the first stage would be making sure that the SHA1 PCR bank is
unusable at the TPM driver level. A first thought would be to extend
the SHA1 PCR bank with a random value at boot (or earlier), so that the
remote attestation would never work on that PCR bank. At that point, I
would probably go further and not expose the SHA1 PCR bank at all, so
you would have less problems on IMA side.

The second stage would probably be that the TPM firmware would be
updated, not allowing the SHA1 PCR bank to be allocated.

Other than that, sure, also actions need to be done to remove SHA1
support in IMA (will look at your patches).

Roberto

> Many thanks!
>=20
> Nicolai
>=20
> [1] https://www.nist.gov/news-events/news/2022/12/nist-retires-sha-1-cryp=
tographic-algorithm
> [2] https://github.com/linux-integrity/ima-evm-utils.git
>=20
> Nicolai Stange (7):
>   ima: don't expose runtime_measurements for unsupported hashes
>   ima: always create runtime_measurements sysfs file for ima_hash
>   ima: move INVALID_PCR() to ima.h
>   ima: track the set of PCRs ever extended
>   tpm: enable bank selection for PCR extend
>   ima: invalidate unsupported PCR banks once at first use
>   ima: make SHA1 non-mandatory
>=20
>  drivers/char/tpm/tpm-interface.c      | 29 +++++++++-
>  drivers/char/tpm/tpm.h                |  3 +-
>  drivers/char/tpm/tpm2-cmd.c           | 29 +++++++++-
>  include/linux/tpm.h                   |  3 +
>  security/integrity/ima/Kconfig        | 14 +++++
>  security/integrity/ima/ima.h          |  9 +++
>  security/integrity/ima/ima_crypto.c   | 83 ++++++++++++++++-----------
>  security/integrity/ima/ima_fs.c       | 41 +++++++------
>  security/integrity/ima/ima_policy.c   |  5 +-
>  security/integrity/ima/ima_queue.c    | 26 ++++++++-
>  security/integrity/ima/ima_template.c |  7 +++
>  11 files changed, 190 insertions(+), 59 deletions(-)
>=20


