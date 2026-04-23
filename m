Return-Path: <linux-integrity+bounces-9288-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNVUK4zt6Wm2nAIAu9opvQ
	(envelope-from <linux-integrity+bounces-9288-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 11:59:40 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E259F450272
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 11:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73D6930B3023
	for <lists+linux-integrity@lfdr.de>; Thu, 23 Apr 2026 09:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0B9A3E8C50;
	Thu, 23 Apr 2026 09:49:53 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A841A3E8678;
	Thu, 23 Apr 2026 09:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776937793; cv=none; b=ROFIEs7pWJy3ER41TFuUf/yVtx1J9/kI+q45qYow7dAArroA59lk7Z/GZOoPtTsGG70OT9Bn6LUoxlHLnyoFKXrSKhnmr0bUW8yHrDb0no7nVHAn/JCWz266bEXDE5be+skl+kOK6wDRepQeLx95HZkon3GGE/OR1+Q+paMqFS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776937793; c=relaxed/simple;
	bh=syGA7ZdLUO0147ZNNmKHaGKn7eH8cy44Ad67/dJbKZg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WVTyNsijyaB9hufRbBaUrxzFDjYFfbus9XJMLv0y2x4p9c1iIInIll9G6CtnVMND2EQkBqMb3bGHh3XVYT4GjwF2go8mIG8m43tLi/En8/NvDKYFfaUTJFtPV53UdNo11pImCxbkJG3fhoRVbgJ+1bQf1kwRkSNOcfSRVEyg+A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.235])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4g1W2t09XlzwPDw;
	Thu, 23 Apr 2026 17:27:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 9127240568;
	Thu, 23 Apr 2026 17:31:42 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwDnNdD25ulpW2i8AA--.7468S2;
	Thu, 23 Apr 2026 10:31:42 +0100 (CET)
Message-ID: <65b84a79af689a0571bafc990ed0bfdb25236418.camel@huaweicloud.com>
Subject: Re: [PATCH v2] evm: terminate and bound the evm_xattrs read buffer
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg
	 <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, James Morris
	 <jmorris@namei.org>, Serge Hallyn <serge@hallyn.com>, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Thu, 23 Apr 2026 11:31:31 +0200
In-Reply-To: <b28a714c-aabe-49f3-a8ab-274feff34d85@huaweicloud.com>
References: <20260407153002.2-evm-xattrs-pengpeng@iscas.ac.cn>
	 <20260417223004.1-evm-xattrs-v2-pengpeng@iscas.ac.cn>
	 <b28a714c-aabe-49f3-a8ab-274feff34d85@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwDnNdD25ulpW2i8AA--.7468S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4furWxCFW3Xry7Cr17Wrg_yoW5Gw4kpF
	Z8ta4Utrn5XryDGFW3J3W7u3s3G395GF1UGw4fG3W2yas0vr92gFykKFy5uFyfZr48Ar4Y
	q3s8AF9093W5X3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAMBGnpwf8CwgAFsy
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9288-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DMARC_NA(0.00)[huaweicloud.com];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,huaweicloud.com:mid]
X-Rspamd-Queue-Id: E259F450272
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-04-17 at 10:30 +0200, Roberto Sassu wrote:
> On 4/17/2026 2:44 PM, Pengpeng Hou wrote:
> > evm_read_xattrs() allocates size + 1 bytes, fills them from the list of
> > enabled xattrs, and then passes strlen(temp) to
> > simple_read_from_buffer(). When no configured xattrs are enabled, the
> > fill loop stores nothing and temp[0] remains uninitialized, so strlen()
> > reads beyond initialized memory.
> >=20
> > Explicitly terminate the buffer after allocation, use snprintf() for
> > each formatted line, and pass the accumulated length to
>=20
> pass the accumulate length (without risk of truncation) to ...
>=20
> > simple_read_from_buffer().
> >=20
> > Fixes: fa516b66a1bf ("EVM: Allow runtime modification of the set of ver=
ified xattrs")
> > Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> > ---
> > Changes since v1:
> > - add the Fixes tag
> > - replace sprintf() with snprintf()
> > - explicitly terminate the buffer instead of switching to kzalloc()
> >=20
> >   security/integrity/evm/evm_secfs.c | 11 ++++++-----
> >   1 file changed, 6 insertions(+), 5 deletions(-)
> >=20
> > diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/ev=
m/evm_secfs.c
> > index acd840461902..b7882a4ce9d0 100644
> > --- a/security/integrity/evm/evm_secfs.c
> > +++ b/security/integrity/evm/evm_secfs.c
> > @@ -127,8 +127,8 @@ static ssize_t evm_read_xattrs(struct file *filp, c=
har __user *buf,
> >   			       size_t count, loff_t *ppos)
> >   {
> >   	char *temp;
> > -	int offset =3D 0;
> > -	ssize_t rc, size =3D 0;
> > +	size_t offset =3D 0, size =3D 0;
> > +	ssize_t rc;
> >   	struct xattr_list *xattr;
> >  =20
> >   	if (*ppos !=3D 0)
> > @@ -150,17 +150,18 @@ static ssize_t evm_read_xattrs(struct file *filp,=
 char __user *buf,
> >   		mutex_unlock(&xattr_list_mutex);
> >   		return -ENOMEM;
> >   	}
>=20
> Please add a newline here.
>=20
> > +	temp[size] =3D '\0';
> >  =20
> >   	list_for_each_entry(xattr, &evm_config_xattrnames, list) {
> >   		if (!xattr->enabled)
> >   			continue;
> >  =20
> > -		sprintf(temp + offset, "%s\n", xattr->name);
> > -		offset +=3D strlen(xattr->name) + 1;
>=20
> Also a comment like:
>=20
> /*
>   * No truncation possible: size is computed over the same
>   * enabled xattrs under xattr_list_mutex, so offset never exceeds size.
>   */
>=20
> to motivate why it is fine to increment offset without checking.

Any progress? The changes should be straightforward.

Thanks

Roberto

> Thanks
>=20
> Roberto
>=20
> > +		offset +=3D snprintf(temp + offset, size + 1 - offset, "%s\n",
> > +				   xattr->name);
> >   	}
> >  =20
> >   	mutex_unlock(&xattr_list_mutex);
> > -	rc =3D simple_read_from_buffer(buf, count, ppos, temp, strlen(temp));
> > +	rc =3D simple_read_from_buffer(buf, count, ppos, temp, offset);
> >  =20
> >   	kfree(temp);
> >  =20


