Return-Path: <linux-integrity+bounces-3328-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FBE95484E
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Aug 2024 13:54:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F8931C21A17
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Aug 2024 11:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B105B198E80;
	Fri, 16 Aug 2024 11:53:56 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout13.his.huawei.com (frasgout13.his.huawei.com [14.137.139.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F8A6143757;
	Fri, 16 Aug 2024 11:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723809236; cv=none; b=DvCdlDrsADh4rGKvcd9yHGeMyNGiskUWLPIs3ZNuX6GG9bPwqu/muoP81pysdrOcuTSKIPwEZa20Zz4NBYblym7vasnzpYBpbV6Z7ZUd8y56mmw/9/TnKOBAc7OmbWigpbdL31EzB7hUN1CSHjhNBrX/k8MbiyMi++5VdwWmbOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723809236; c=relaxed/simple;
	bh=eojZLNJ54T7C1telZ/KLrA0gUmF3UJrn5dZ7ljL4lTs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WeT+aaVBBl5XlLROWN3KATDXcxQZ65aPrwlb7mWCgbjvEQDL99RXX41RjXjD184JTXwUKHoBgCM8OiVYn1F9GN7u7NFSugvVFIQGFf5+SLT1mAV1FZxTGm2gcSPQetBztIiaqXbrxdRhaU0HWMLo3t646rPNn6WFQcY9qlpv5MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout13.his.huawei.com (SkyGuard) with ESMTP id 4Wlfzg42L7z9v7NK;
	Fri, 16 Aug 2024 19:34:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id C0BA514037F;
	Fri, 16 Aug 2024 19:53:50 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAn98PHPb9mV9RPAQ--.34928S2;
	Fri, 16 Aug 2024 12:53:50 +0100 (CET)
Message-ID: <3cd8019f03dae99c4e43b7613df869499ec72e66.camel@huaweicloud.com>
Subject: Re: [PATCH] evm: stop avoidably reading i_writecount in
 evm_file_release
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mateusz Guzik <mjguzik@gmail.com>, zohar@linux.ibm.com, 
 roberto.sassu@huawei.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com
Cc: linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Date: Fri, 16 Aug 2024 13:53:39 +0200
In-Reply-To: <20240806133607.869394-1-mjguzik@gmail.com>
References: <20240806133607.869394-1-mjguzik@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwAn98PHPb9mV9RPAQ--.34928S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KFW3Zw1xuF43Jry8Ary7ZFb_yoW8Zr43pF
	Wftan7JFn5tryfCF92y3W7uFyru340qr18Zas5WF12vFn8JrZYqr48tr1jgFnxKrZ5Cr1f
	X3yIka45A3WDuaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrPEfUUUUU
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgARBGa+tfgI+QAAsz

On Tue, 2024-08-06 at 15:36 +0200, Mateusz Guzik wrote:
> The EVM_NEW_FILE flag is unset if the file already existed at the time
> of open and this can be checked without looking at i_writecount.

Agreed. EVM_NEW_FILE is not going to be set during the open(), only
before, in evm_post_path_mknod().

Looks good to me.

Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks

Roberto

> Not accessing it reduces traffic on the cacheline during parallel open
> of the same file and drop the evm_file_release routine from second place
> to bottom of the profile.
>=20
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>=20
> The context is that I'm writing a patch which removes one lockref
> get/put cycle on parallel open. An operational WIP reduces ping-pong in
> that area and made do_dentry_open skyrocket along with evm_file_release,
> due to i_writecount access. With the patch they go down again and
> apparmor takes the rightful first place.
>=20
> The patch accounts for about 5% speed up at 20 cores running open3 from
> will-it-scale on top of the above wip. (the apparmor + lockref thing
> really don't scale, that's next)
>=20
> I would provide better measurements, but the wip is not ready (as the
> description suggests) and I need evm out of the way for the actual
> patch.
>=20
>  security/integrity/evm/evm_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/e=
vm_main.c
> index 62fe66dd53ce..309630f319e2 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -1084,7 +1084,8 @@ static void evm_file_release(struct file *file)
>  	if (!S_ISREG(inode->i_mode) || !(mode & FMODE_WRITE))
>  		return;
> =20
> -	if (iint && atomic_read(&inode->i_writecount) =3D=3D 1)
> +	if (iint && iint->flags & EVM_NEW_FILE &&
> +	    atomic_read(&inode->i_writecount) =3D=3D 1)
>  		iint->flags &=3D ~EVM_NEW_FILE;
>  }
> =20


