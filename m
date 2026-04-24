Return-Path: <linux-integrity+bounces-9315-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Pk/Dx4q62keJgAAu9opvQ
	(envelope-from <linux-integrity+bounces-9315-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 10:30:22 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DCD45B7E5
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 10:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B70E93012CCA
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Apr 2026 08:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF0D03264C8;
	Fri, 24 Apr 2026 08:30:13 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E783264CD;
	Fri, 24 Apr 2026 08:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777019413; cv=none; b=F4ONHXypbquPJ9ME+cVe4qnHlZTulxQApqSZOyHrl4KxALGZxzHB2/OEWYnx/Yitwcsb1SVj9EBvVwLHV8ZcNZvsNEMm8RzOu5qa3SrHvn3DCTo0CSWOAI5TmY334vwa6PM8dCi2WMpp9e+BQnltCqY6I0PjKCbRl4djw0oSNpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777019413; c=relaxed/simple;
	bh=mN9hKJgOIbUIgtW7CMIeUWc8FjfE9DZDmZHij53WAW8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Owt5KLQ0fyFuxJA5B2i4mBcyoNoKz553utMrCwRcpu5F9J7ErojhBomPxOlSc+hGXaYuGRFqrhLj2VE4K5k+wukEirGBrudeqQ9SCXc+XKFGOROZwXOPHjDANGjDIHXoc0QWkz1dF9ueWUmLRFtswQhafGIzne1FpZI2o9498FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4g25GT0PPcz1HCH8;
	Fri, 24 Apr 2026 16:09:37 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id 10F3E40571;
	Fri, 24 Apr 2026 16:14:01 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwAXwe08JutpXnDKAA--.10970S2;
	Fri, 24 Apr 2026 09:14:00 +0100 (CET)
Message-ID: <1cbfa3d83a3ae9db393fe23d677c282090c59146.camel@huaweicloud.com>
Subject: Re: [PATCH v3] evm: terminate and bound the evm_xattrs read buffer
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, Mimi Zohar <zohar@linux.ibm.com>
Cc: Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin
 <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, Serge Hallyn
 <serge@hallyn.com>,  linux-integrity@vger.kernel.org,
 linux-security-module@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Fri, 24 Apr 2026 10:13:46 +0200
In-Reply-To: <20260424070101.1-evm-v3-pengpeng@iscas.ac.cn>
References: <20260417223004.1-evm-xattrs-v2-pengpeng@iscas.ac.cn>
	 <20260424070101.1-evm-v3-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwAXwe08JutpXnDKAA--.10970S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFy3Cr4fWw43uF18ur4rKrg_yoW8Kr13pF
	Z8t3WDJFn5XryDGFW5JF17u393G3y8GFWUGrn3Gw12vasxXr9agrykKa4ruFyrJr40yw45
	t3s0kFnIyw1Yq3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgANBGnrE4cBqgAAs2
X-Rspamd-Queue-Id: B9DCD45B7E5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9315-lists,linux-integrity=lfdr.de];
	DMARC_NA(0.00)[huaweicloud.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	MID_RHS_MATCH_FROM(0.00)[];
	MAILSPIKE_FAIL(0.00)[2600:3c04:e001:36c::12fc:5321:query timed out];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,huawei.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huaweicloud.com:mid]

On Thu, 2026-04-23 at 23:30 +0800, Pengpeng Hou wrote:
> evm_read_xattrs() allocates size + 1 bytes, fills them from the list of
> enabled xattrs, and then passes strlen(temp) to
> simple_read_from_buffer(). When no configured xattrs are enabled, the
> fill loop stores nothing and temp[0] remains uninitialized, so strlen()
> reads beyond initialized memory.
>=20
> Explicitly terminate the buffer after allocation, use snprintf() for
> each formatted line, and pass the accumulated length, without risk of
> truncation, to simple_read_from_buffer().
>=20
> Fixes: fa516b66a1bf ("EVM: Allow runtime modification of the set of verif=
ied xattrs")
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>

Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks

Roberto

> ---
> Changes since v2:
> - adjust the changelog wording to mention why the accumulated length is
>   safe
> - add the blank line after the allocation error path
> - add a comment explaining why snprintf() cannot truncate in the fill loo=
p
>=20
> diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/=
evm_secfs.c
> index acd840461902..4baf5e23bc97 100644
> --- a/security/integrity/evm/evm_secfs.c
> +++ b/security/integrity/evm/evm_secfs.c
> @@ -127,8 +127,8 @@ static ssize_t evm_read_xattrs(struct file *filp, cha=
r __user *buf,
>  			       size_t count, loff_t *ppos)
>  {
>  	char *temp;
> -	int offset =3D 0;
> -	ssize_t rc, size =3D 0;
> +	size_t offset =3D 0, size =3D 0;
> +	ssize_t rc;
>  	struct xattr_list *xattr;
> =20
>  	if (*ppos !=3D 0)
> @@ -151,16 +151,22 @@ static ssize_t evm_read_xattrs(struct file *filp, c=
har __user *buf,
>  		return -ENOMEM;
>  	}
> =20
> +	temp[size] =3D '\0';
> +
> +	/*
> +	 * No truncation possible: size is computed over the same enabled
> +	 * xattrs under xattr_list_mutex, so offset never exceeds size.
> +	 */
>  	list_for_each_entry(xattr, &evm_config_xattrnames, list) {
>  		if (!xattr->enabled)
>  			continue;
> =20
> -		sprintf(temp + offset, "%s\n", xattr->name);
> -		offset +=3D strlen(xattr->name) + 1;
> +		offset +=3D snprintf(temp + offset, size + 1 - offset, "%s\n",
> +				   xattr->name);
>  	}
> =20
>  	mutex_unlock(&xattr_list_mutex);
> -	rc =3D simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
> +	rc =3D simple_read_from_buffer(buf, count, ppos, temp, offset);
> =20
>  	kfree(temp);
> =20


