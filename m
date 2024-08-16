Return-Path: <linux-integrity+bounces-3330-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D343954918
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Aug 2024 14:47:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC7491F24BB7
	for <lists+linux-integrity@lfdr.de>; Fri, 16 Aug 2024 12:47:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B32191F84;
	Fri, 16 Aug 2024 12:46:59 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900F41991BB;
	Fri, 16 Aug 2024 12:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723812419; cv=none; b=Ghcb3e8ZjtD39Q8wCC/FZE8Nmi97Nnbn3uB90PFDk2Dxq75JNx2hpoWQc/C5fbC+J/3Nc/fI7IzY0JbvJJ5vd0VWwpUihXO4t5R95ER8PHWrrHtcSaWeY1T4D9QB0EdvuA0Eo5HYpkZzr9XmmHNAmqekHoUVAVQebMV4j0gKdxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723812419; c=relaxed/simple;
	bh=jFD73xGsQIz18ke3m88ajT/gZe74KPkUJca2QFGcGLU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ptGzsmjsUa0RMlXC4IRYBZCn+Lcv2FtHDiO3UCHCfJt0RT+9uvQzsw6yz6kNe0o6QzHNOGBYy0GU765grj25IDsbFRm5f6gNqgE/nPnxWEOK0c+pQidERgQIzT1WL5yykcfONs17Xd4v166y6xs7HLccEYdsNSj7JLXx6URqGW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4WlgdN2WLLz9v7Jf;
	Fri, 16 Aug 2024 20:04:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id B6534140B34;
	Fri, 16 Aug 2024 20:28:28 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCHCoXjRb9mHDdNAQ--.2087S2;
	Fri, 16 Aug 2024 13:28:28 +0100 (CET)
Message-ID: <3b04a8fc177eee5ce2eaa24ae8164140188478c0.camel@huaweicloud.com>
Subject: Re: [PATCH][next] integrity: Use static_assert() to check struct
 sizes
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Mimi Zohar
 <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, Dmitry
 Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg
 <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date: Fri, 16 Aug 2024 14:28:16 +0200
In-Reply-To: <ZrVBC9dGwukjfhet@cute>
References: <ZrVBC9dGwukjfhet@cute>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwCHCoXjRb9mHDdNAQ--.2087S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CFWDAFWUuF1UAF43ZFyxZrb_yoW8Ar1fpF
	yqga4UCrWjqr1I9FnrAFW3ZF4Sg3y0qr1UXr45Jw1FyFnIyr10qF9YyryrCa43KrWDKr1S
	yFs0qr45AwsrtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgARBGa+tfgJSAAAsD

On Thu, 2024-08-08 at 16:04 -0600, Gustavo A. R. Silva wrote:
> Commit 38aa3f5ac6d2 ("integrity: Avoid -Wflex-array-member-not-at-end
> warnings") introduced tagged `struct evm_ima_xattr_data_hdr` and
> `struct ima_digest_data_hdr`. We want to ensure that when new members
> need to be added to the flexible structures, they are always included
> within these tagged structs.
>=20
> So, we use `static_assert()` to ensure that the memory layout for
> both the flexible structure and the tagged struct is the same after
> any changes.

Looks good to me.

Tested-by: Roberto Sassu <roberto.sassu@huawei.com>
Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks

Roberto

> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  security/integrity/integrity.h | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/security/integrity/integrity.h b/security/integrity/integrit=
y.h
> index 660f76cb69d3..c2c2da691123 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -37,6 +37,8 @@ struct evm_ima_xattr_data {
>  	);
>  	u8 data[];
>  } __packed;
> +static_assert(offsetof(struct evm_ima_xattr_data, data) =3D=3D sizeof(st=
ruct evm_ima_xattr_data_hdr),
> +	      "struct member likely outside of __struct_group()");
> =20
>  /* Only used in the EVM HMAC code. */
>  struct evm_xattr {
> @@ -65,6 +67,8 @@ struct ima_digest_data {
>  	);
>  	u8 digest[];
>  } __packed;
> +static_assert(offsetof(struct ima_digest_data, digest) =3D=3D sizeof(str=
uct ima_digest_data_hdr),
> +	      "struct member likely outside of __struct_group()");
> =20
>  /*
>   * Instead of wrapping the ima_digest_data struct inside a local structu=
re


