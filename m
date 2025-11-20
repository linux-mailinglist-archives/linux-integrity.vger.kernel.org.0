Return-Path: <linux-integrity+bounces-7647-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5698CC733FA
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Nov 2025 10:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 93FBA4E66DA
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Nov 2025 09:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EF827FD48;
	Thu, 20 Nov 2025 09:37:16 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF73828371;
	Thu, 20 Nov 2025 09:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763631436; cv=none; b=UjcmUKGhGdYEqq5ExB5jWtiScV772JqFNbHiMLWnUafNWU+A6erq2u9f/N0d6Z4ZjU/PZyTmclIBec7CnI+kil79auMzscIQvdZPe9BVlsmo3gqQRj/pAOcBLgQy8iKDKpK5mzuFoIV39eGKeBVLXEq2OFw7h5ravF/v6GgYmTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763631436; c=relaxed/simple;
	bh=d31uDCXXqy9xuzRREMT6Ql8sqkwaqv+EWCSURIxI5ks=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EO4tZ18G7k6ggqkchB9ngVEJJPljleIcV42iy487e7HSDfozNyWQrfIJ7pn4COq+67o6I4AKEPdyHnbkz97Es8IMToqR53Z30fkuBtywQcEvMRBWGl81QBrWsosV5il2L6CbVGx5/qgXTyQjMkQ4OIZtuSNfnjx27fkAYC2QCzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dBt590XNCzvRhh;
	Thu, 20 Nov 2025 17:16:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 29AA81402DB;
	Thu, 20 Nov 2025 17:17:39 +0800 (CST)
Received: from [10.204.63.22] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwC3Q4uq3B5pOAq+AA--.32260S2;
	Thu, 20 Nov 2025 10:17:38 +0100 (CET)
Message-ID: <834970a158dd6518cda174754a5b10ea9eb2fe9b.camel@huaweicloud.com>
Subject: Re: [PATCH -next] ima: Handle error code returned by
 ima_filter_rule_match()
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Zhao Yipeng <zhaoyipeng5@huawei.com>, zohar@linux.ibm.com, 
 roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com
Cc: lujialin4@huawei.com, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 20 Nov 2025 10:17:27 +0100
In-Reply-To: <20251120071805.1604864-1-zhaoyipeng5@huawei.com>
References: <20251120071805.1604864-1-zhaoyipeng5@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwC3Q4uq3B5pOAq+AA--.32260S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tryfKFW3Cr47CF43WFWfZrb_yoW5JFWrpa
	sY9a45Ar1vgFy09F4xCFy2qayF9F4jqwnrX3s5GasF9asxZr109r1rtw15urn8GrWYkryr
	tFWj93yYyw1qv3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyvb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVWUJVW8JwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Jr0_Gr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQASBGkeebEFEQAAs8

On Thu, 2025-11-20 at 15:18 +0800, Zhao Yipeng wrote:
> In ima_match_rules(), if ima_filter_rule_match() returns -ENOENT due to
> the rule being NULL, the function incorrectly skips the 'if (!rc)' check
> and sets 'result =3D true'. The LSM rule is considered a match, causing
> extra files to be measured by IMA.
>=20
> This issue can be reproduced in the following scenario:
> After unloading the SELinux policy module via 'semodule -d', if an IMA
> measurement is triggered before ima_lsm_rules is updated,
> in ima_match_rules(), the first call to ima_filter_rule_match() returns
> -ESTALE. This causes the code to enter the 'if (rc =3D=3D -ESTALE &&
> !rule_reinitialized)' block, perform ima_lsm_copy_rule() and retry. In
> ima_lsm_copy_rule(), since the SELinux module has been removed, the rule
> becomes NULL, and the second call to ima_filter_rule_match() returns
> -ENOENT. This bypasses the 'if (!rc)' check and results in a false match.
>=20
> Call trace:
>   selinux_audit_rule_match+0x310/0x3b8
>   security_audit_rule_match+0x60/0xa0
>   ima_match_rules+0x2e4/0x4a0
>   ima_match_policy+0x9c/0x1e8
>   ima_get_action+0x48/0x60
>   process_measurement+0xf8/0xa98
>   ima_bprm_check+0x98/0xd8
>   security_bprm_check+0x5c/0x78
>   search_binary_handler+0x6c/0x318
>   exec_binprm+0x58/0x1b8
>   bprm_execve+0xb8/0x130
>   do_execveat_common.isra.0+0x1a8/0x258
>   __arm64_sys_execve+0x48/0x68
>   invoke_syscall+0x50/0x128
>   el0_svc_common.constprop.0+0xc8/0xf0
>   do_el0_svc+0x24/0x38
>   el0_svc+0x44/0x200
>   el0t_64_sync_handler+0x100/0x130
>   el0t_64_sync+0x3c8/0x3d0
>=20
> Fix this by changing 'if (!rc)' to 'if (rc <=3D 0)' to ensure that error
> codes like -ENOENT do not bypass the check and accidentally result in a
> successful match.

Thanks, it makes sense.

Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

Roberto

> Fixes: 4af4662fa4a9d ("integrity: IMA policy")
> Signed-off-by: Zhao Yipeng <zhaoyipeng5@huawei.com>
> ---
>  security/integrity/ima/ima_policy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/security/integrity/ima/ima_policy.c b/security/integrity/ima=
/ima_policy.c
> index 128fab897930..db6d55af5a80 100644
> --- a/security/integrity/ima/ima_policy.c
> +++ b/security/integrity/ima/ima_policy.c
> @@ -674,7 +674,7 @@ static bool ima_match_rules(struct ima_rule_entry *ru=
le,
>  				goto retry;
>  			}
>  		}
> -		if (!rc) {
> +		if (rc <=3D 0) {
>  			result =3D false;
>  			goto out;
>  		}


