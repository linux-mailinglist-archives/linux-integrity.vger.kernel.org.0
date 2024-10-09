Return-Path: <linux-integrity+bounces-3759-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E33997033
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Oct 2024 18:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFF6EB22DEA
	for <lists+linux-integrity@lfdr.de>; Wed,  9 Oct 2024 16:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BBFE161313;
	Wed,  9 Oct 2024 15:34:40 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978F513C3CD;
	Wed,  9 Oct 2024 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728488080; cv=none; b=KM0oRnuWuulL5a36vveN7KLhIk2V1PGoOdwXDIWOBh2KCX43QTm+JbIzutSsEmWwQuQLNZbyP3td+lcxwFysnglScXEdxgM3EP/yAupl8k1bs/3njxNA7mFUf1TomNAoYMD0CuABNdEgUwlNbkAhkuJ6P00xrKd62NOo8RSuQ4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728488080; c=relaxed/simple;
	bh=RW21aL7hEjFdY8FDbod/O3KcVXfGbz45B8tZe/zolCE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CThpYiCla5x3U+UBx144/WI1OHJYDGTB6fADnNUMtrMMjxF17zWNEj6w12kmdS3pF8rVNpI2vIG4pFxS64rCjwAJYANsNKDFamJ/0dN/n8R9Mh/hQdbc79cgfEmF8+xmtBPsZ9g0edhTXbVS+8aqvOxBzR1G437cI05R83yhCts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4XNxJ63PTGz9v7Hl;
	Wed,  9 Oct 2024 23:14:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 2E3BE14025A;
	Wed,  9 Oct 2024 23:34:29 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBnFsd4ogZn+hqLAg--.3779S2;
	Wed, 09 Oct 2024 16:34:28 +0100 (CET)
Message-ID: <187d23d7c1a02a9240cfa6caa8e502361cb77f2d.camel@huaweicloud.com>
Subject: Re: [PATCH] ima: Fix OOB read when violation occurs with ima
 template.
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: David Fernandez Gonzalez <david.fernandez.gonzalez@oracle.com>, Mimi
 Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg
 <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>,
 linux-integrity@vger.kernel.org,  linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: harshit.m.mogalapalli@oracle.com, vegard.nossum@oracle.com
Date: Wed, 09 Oct 2024 17:34:12 +0200
In-Reply-To: <20241009145335.1297855-1-david.fernandez.gonzalez@oracle.com>
References: <20241009145335.1297855-1-david.fernandez.gonzalez@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwBnFsd4ogZn+hqLAg--.3779S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF1rZFWDWF1kGr18uw4DArb_yoW5Kw4Upa
	yvgw42kF1DJas3WFnrAa42va1Ig3yFkrnrGr48Gr1YyF90qr1UZa1FyryI9rWxJFWrZa4x
	ta1IqrnxZw4jya7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUF1
	v3UUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQALBGcF5ngL8QACsK

On Wed, 2024-10-09 at 14:53 +0000, David Fernandez Gonzalez wrote:
> When processing a violation inside ima_eventdigest_init,
> ima_eventdigest_init_common will be called with cur_digest
> being NULL. hash_algo is always set to HASH_ALGO__LAST.
>=20
> Inside ima_eventdigest_init_common, since digest is NULL,
> offset will be calculated by accessing hash_digest_size
> with HASH_ALGO__LAST, one element OOB.
>=20
> This will be used to calculate the amount of bytes
> to be copied as file content hash. Depending on the memory,
> this could lead to the 0 hash not being recorded if offset is 0,
> the violation not being recorded at all if offset is too big
> (as it will be used to allocate the buffer in
> ima_write_template_field_data), or potentially leaking
> memory values into the measurements file, if offset is big
> enough but can still be used to allocate the buffer.

Hi David

thanks a lot for the patch! We currently have another similar in our
queue:

https://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git/c=
ommit/?h=3Dnext-integrity&id=3Dfa8a4ce432e82cc138e61fab7f44d60f9e720d47


Will be sent to Linus soon.

Thanks

Roberto

> UBSAN: array-index-out-of-bounds in security/integrity/ima/ima_template_l=
ib.c:329:29
> index 23 is out of range for type 'int [23]'
> CPU: 0 UID: 0 PID: 383 Comm: journal-offline Not tainted 6.12.0-rc2 #14
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x64/0x80
>  __ubsan_handle_out_of_bounds+0xc6/0x100
>  ima_eventdigest_init_common+0x297/0x2c0
>  ? ima_add_violation+0x10b/0x260
>  ? __pfx_ima_eventdigest_init_common+0x10/0x10
>  ? path_openat+0x739/0x1ba0
>  ? do_filp_open+0x168/0x290
>  ? do_sys_openat2+0x126/0x160
>  ima_eventdigest_init+0xba/0x280
>  ? __pfx_ima_eventdigest_init+0x10/0x10
>  ? srso_alias_return_thunk+0x5/0xfbef5
>  ? __kmalloc_noprof+0x1cd/0x490
>  ? ima_alloc_init_template+0xd8/0x2f0
>  ima_alloc_init_template+0x1d1/0x2f0
>  ima_add_violation+0x10b/0x260
>  ...
>=20
> HASH_ALGO__LAST is only passed to ima_eventdigest_init_common
> for ima template. This change ensures to set an appropriate hash_algo
> value before calculating the offset.
>=20
> Cc: stable@vger.kernel.org
> Fixes: 9fab303a2cb3 ("ima: fix violation measurement list record")
> Signed-off-by: David Fernandez Gonzalez <david.fernandez.gonzalez@oracle.=
com>
> ---
>  security/integrity/ima/ima_template_lib.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima_template_lib.c b/security/integri=
ty/ima/ima_template_lib.c
> index 4183956c53af..7a46d720303b 100644
> --- a/security/integrity/ima/ima_template_lib.c
> +++ b/security/integrity/ima/ima_template_lib.c
> @@ -318,15 +318,19 @@ static int ima_eventdigest_init_common(const u8 *di=
gest, u32 digestsize,
>  				      hash_algo_name[hash_algo]);
>  	}
> =20
> -	if (digest)
> +	if (digest) {
>  		memcpy(buffer + offset, digest, digestsize);
> -	else
> +	} else {
>  		/*
>  		 * If digest is NULL, the event being recorded is a violation.
>  		 * Make room for the digest by increasing the offset by the
>  		 * hash algorithm digest size.
>  		 */
> +		if (hash_algo =3D=3D HASH_ALGO__LAST) /* To handle ima template case *=
/
> +			hash_algo =3D ima_template_hash_algo_allowed(ima_hash_algo) ?
> +				ima_hash_algo : HASH_ALGO_SHA1;
>  		offset +=3D hash_digest_size[hash_algo];
> +	}
> =20
>  	return ima_write_template_field_data(buffer, offset + digestsize,
>  					     fmt, field_data);


