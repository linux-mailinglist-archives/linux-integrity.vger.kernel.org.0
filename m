Return-Path: <linux-integrity+bounces-9168-lists+linux-integrity=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-integrity@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBmlBVwO3WlsZQkAu9opvQ
	(envelope-from <linux-integrity+bounces-9168-lists+linux-integrity=lfdr.de@vger.kernel.org>)
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Apr 2026 17:40:12 +0200
X-Original-To: lists+linux-integrity@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E73C3EE155
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Apr 2026 17:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 76B1230234EA
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Apr 2026 15:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46E33E122F;
	Mon, 13 Apr 2026 15:39:41 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9663E122E;
	Mon, 13 Apr 2026 15:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776094781; cv=none; b=GXJhixyPEni82bFYr2O2JQys5k5iGtr/PqJddOE843qoz0kNM25ll6wflYJKV32KqW3+bD3aLyAEu+5ZCh7PW+j2rQiYADYWtQW7j/dsZqO7Pn0y8SKHYCVnPP1NGHpPTUvFw4i2h0xIQlR6ZuzjSbg/8miO2sqopzJ2FfYty00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776094781; c=relaxed/simple;
	bh=KLHXMxmpNRD6wvf4gCGYsc4aoUyDu7HAGgr8qoNH8eU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bRI2sZdLUirq4tLfX080V96ITfaCs98SlHbNpQq54hJLcgVyCkXuqpaBR4ClvyqOCK8o/bRV0E1NYgtGKbMDHrDcXjgs8kbQLX861DEeWWzdjqzFRNF5g19bvjTGfwTG6ICWPuizqEUCzFqHKi+No+osVwJkaZK6bUtjOqaqXcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.224.196])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fvWFs5CDTztf5N;
	Mon, 13 Apr 2026 23:16:17 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id E0FB84056C;
	Mon, 13 Apr 2026 23:20:14 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwC3xN6mCd1pR5okAA--.31610S2;
	Mon, 13 Apr 2026 16:20:14 +0100 (CET)
Message-ID: <d95993e3d879bec4c9e3416906d409cca9c8ffeb.camel@huaweicloud.com>
Subject: Re: [PATCH] evm: zero-initialize the evm_xattrs read buffer
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>, Mimi Zohar <zohar@linux.ibm.com>, 
 Roberto Sassu <roberto.sassu@huawei.com>
Cc: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg
	 <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, James Morris
	 <jmorris@namei.org>, Serge Hallyn <serge@hallyn.com>, 
	linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 13 Apr 2026 17:20:04 +0200
In-Reply-To: <20260407153002.2-evm-xattrs-pengpeng@iscas.ac.cn>
References: <20260407153002.2-evm-xattrs-pengpeng@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwC3xN6mCd1pR5okAA--.31610S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFW5Aw4UAr1fGw4kZF4kCrg_yoW8Jw4xpF
	sxtayDtrn8XrykCF98AF1rua4rW3yYkryUGrsavw1vvF9IvryxXr92krWUur1rKrW0yw45
	t3Wvyr1Yk3Z0qaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgACBGnckwUOtQACse
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9168-lists,linux-integrity=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DMARC_NA(0.00)[huaweicloud.com];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[linux-integrity];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[roberto.sassu@huaweicloud.com,linux-integrity@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.983];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huaweicloud.com:mid,iscas.ac.cn:email]
X-Rspamd-Queue-Id: 8E73C3EE155
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 2026-04-07 at 14:09 +0800, Pengpeng Hou wrote:
> evm_read_xattrs() allocates size + 1 bytes, fills them from the list of
> enabled xattrs and then passes strlen(temp) to simple_read_from_buffer().
> When no configured xattrs are enabled, the fill loop stores nothing and
> temp[0] remains uninitialized, so strlen() reads beyond initialized
> memory.
>=20
> Use kzalloc() so the empty-list case stays a valid empty C string.

Please also add the Fixes: tag with the relevant commit.

> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  security/integrity/evm/evm_secfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/=
evm_secfs.c
> index acd840461902..03d376fa36c2 100644
> --- a/security/integrity/evm/evm_secfs.c
> +++ b/security/integrity/evm/evm_secfs.c
> @@ -145,7 +145,7 @@ static ssize_t evm_read_xattrs(struct file *filp, cha=
r __user *buf,
>  		size +=3D strlen(xattr->name) + 1;
>  	}
> =20
> -	temp =3D kmalloc(size + 1, GFP_KERNEL);
> +	temp =3D kzalloc(size + 1, GFP_KERNEL);

Yes, or just set temp[size] to the terminator so that we don't waste
computation. Can you also change sprintf() to snprintf()?

Thanks

Roberto

>  	if (!temp) {
>  		mutex_unlock(&xattr_list_mutex);
>  		return -ENOMEM;


