Return-Path: <linux-integrity+bounces-4966-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2FBA3FDA2
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 18:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 716DE3A967C
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 17:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B251D23FC6B;
	Fri, 21 Feb 2025 17:36:59 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96B01E9B31
	for <linux-integrity@vger.kernel.org>; Fri, 21 Feb 2025 17:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740159419; cv=none; b=oJIoGF8kLXkzr7CMFPmhZAeO5K7C6PQ9t6XZJzM4xNOCsQLYcLtI18Qr6CHz2+uHwq80KF5oivEvWR+0IzqqJGB+P6flZz3A4+c6L3Y0HAD3xIHgUKmujn/mAUwtxSksSXr5P93zPrw5oKQpcZuSaOkvirMqEJrygT3+DyqJlG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740159419; c=relaxed/simple;
	bh=Iq49SOIixZa/n7khqZh4SBayw9UziwzXB4i/7wulsdQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=t94qrtkTbD6fjlMyTFdG35Fl9+ZkwVlxlfn48iwAx76hmSxkYvzlPAGbdV+2xiE9wjiwM8Ow94WZU3E9UtT26ESMLeAiCgdjZxl8DNllARXwZApsc/pb2OiE3Gw+Rj5pU5sb+XGYxkX8fno1o9QZm3xSVICeY0f5lUeZ1b0QPEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4YzxPY1dHFz9v7JP
	for <linux-integrity@vger.kernel.org>; Sat, 22 Feb 2025 01:06:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 63AF3140419
	for <linux-integrity@vger.kernel.org>; Sat, 22 Feb 2025 01:36:47 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwAX6Uepubhn+6LrAg--.50277S2;
	Fri, 21 Feb 2025 18:36:46 +0100 (CET)
Message-ID: <62e715f5ea0e901f7fd4185e996871eb9f2e14e2.camel@huaweicloud.com>
Subject: Re: [PATCH 2/2] ima: limit the number of ToMToU integrity violations
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: roberto.sassu@huawei.com, Stefan Berger <stefanb@linux.ibm.com>, Petr
 Vorel <pvorel@suse.cz>
Date: Fri, 21 Feb 2025 18:36:37 +0100
In-Reply-To: <20250219162131.416719-3-zohar@linux.ibm.com>
References: <20250219162131.416719-1-zohar@linux.ibm.com>
	 <20250219162131.416719-3-zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwAX6Uepubhn+6LrAg--.50277S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Zw45CFWUCryfZw4kKFWxZwb_yoW8CFW3p3
	y8KFWfGFs3KFyjkw1kG3W2vay0g34rKa48Wr45Z34UAFn3Xr1FqrySk3Wjyr93GF9ayr1I
	qr4ay39xAan0kaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
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
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxU7IJmUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAGBGe4JdgGEgAFsw

On Wed, 2025-02-19 at 11:21 -0500, Mimi Zohar wrote:
> Each time a file in policy, that is already opened for read, is opened
> for write a Time-of-Measure-Time-of-Use (ToMToU) integrity violation
> audit message is emitted and a violation record is added to the IMA
> measurement list, even if a ToMToU violation has already been recorded.
>=20
> Limit the number of ToMToU integrity violations for an existing file
> open for read.
>=20
> Note: The IMA_MUST_MEASURE atomic flag must be set from the reader side
> based on policy.  This may result in a per open reader additional ToMToU
> violation.

Probably the goal can be summarized as to limit emitting consecutive
ToMToU violations.

In the previous patch, we are not emitting a new open_writers violation
until all writers close the file. Here, it is a bit different, we are
not emitting an additional ToMToU violation until there is another
reader matching the policy. Maybe we should highlight this difference.

> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  security/integrity/ima/ima_main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index cde3ae55d654..f1671799a11b 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -129,9 +129,10 @@ static void ima_rdwr_violation_check(struct file *fi=
le,
>  		if (atomic_read(&inode->i_readcount) && IS_IMA(inode)) {
>  			if (!iint)
>  				iint =3D ima_iint_find(inode);
> +
>  			/* IMA_MEASURE is set from reader side */
> -			if (iint && test_bit(IMA_MUST_MEASURE,
> -						&iint->atomic_flags))
> +			if (iint && test_and_clear_bit(IMA_MUST_MEASURE,

Since IMA_MUST_MEASURE is only used for violations, what if we rename
it to:

IMA_TOMTOU_MAY_EMIT

Thanks

Roberto

> +						       &iint->atomic_flags))
>  				send_tomtou =3D true;
>  		}
>  	} else {


