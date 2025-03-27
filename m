Return-Path: <linux-integrity+bounces-5486-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25144A736D7
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 17:30:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7F916D1C8
	for <lists+linux-integrity@lfdr.de>; Thu, 27 Mar 2025 16:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9160919C546;
	Thu, 27 Mar 2025 16:29:38 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB5D32F3B;
	Thu, 27 Mar 2025 16:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743092978; cv=none; b=AYNx8YTkoacqNsnq+/dGK0YxNNkkDBheBwjuYcberclrRVisUwuvKTwuRh9i5078oVbxJMRTXU9Tx9dRzMF57EGmwFkDK0BNlRCuUHx5HHRBQi4B5xtbVgNed+vY9DKKry65bIm++cw7jqu/LtByKaI1A3frt7jQmUSzdjzQonE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743092978; c=relaxed/simple;
	bh=smNazMYrmLP7FOK1l8FsdTynBL+oU8j8CFtel+Zj/W8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=O+Bvn85w59zJM6EbNE253qAvNeS0uHxXK4Xf/9BkE04v/fD7sx5sWC0MBqlIWaTnIilAq12Sm0zxnAUXXd75aXjvxYXQEMEm0tywIwoVHEP48/dkQV7m29xhv7zxG6huZhWjLAQI8xiQ5GAy26KvsXnMF2hFmnE8jdIno1WmVnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.51])
	by frasgout11.his.huawei.com (SkyGuard) with ESMTPS id 4ZNpy55Fvsz1HCHG;
	Fri, 28 Mar 2025 00:29:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.27])
	by mail.maildlp.com (Postfix) with ESMTP id D062514036E;
	Fri, 28 Mar 2025 00:29:26 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP2 (Coremail) with SMTP id GxC2BwBXC97dfOVnKPXwBA--.34744S2;
	Thu, 27 Mar 2025 17:29:26 +0100 (CET)
Message-ID: <287838024e2bbac3d3b17a8fdf4da2bf6996fa23.camel@huaweicloud.com>
Subject: Re: [PATCH v3] ima: process_measurement() needlessly takes
 inode_lock() on MAY_READ
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Frederick Lawler <fred@cloudflare.com>, Mimi Zohar
 <zohar@linux.ibm.com>,  Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Roberto Sassu <roberto.sassu@huawei.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>, "Serge E. Hallyn"
	 <serge@hallyn.com>, linux-ima-devel@lists.sourceforge.net, 
	linux-integrity@vger.kernel.org, linux-ima-user@lists.sourceforge.net, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@cloudfalre.com
Date: Thu, 27 Mar 2025 17:29:14 +0100
In-Reply-To: <20250327160916.279090-1-fred@cloudflare.com>
References: <20250327160916.279090-1-fred@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:GxC2BwBXC97dfOVnKPXwBA--.34744S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uF47Jw1rWw4DGr4rJF4ktFb_yoW8Wr18pa
	n5tay8CF1UKFyjkF97Ga9FvanYg3yxKr18G3y5ZF10k3Zavr1v9Fn8K3Wj9ryfGr9Yya4a
	vr4YgrW5Za1qyFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAQAABGfk+N0HDgAAsq

On Thu, 2025-03-27 at 11:09 -0500, Frederick Lawler wrote:
> On IMA policy update, if a measure rule exists in the policy,
> IMA_MEASURE is set for ima_policy_flags which makes the violation_check
> variable always true. Coupled with a no-action on MAY_READ for a
> FILE_CHECK call, we're always taking the inode_lock().
>=20
> This becomes a performance problem for extremely heavy read-only workload=
s.
> Therefore, prevent this only in the case there's no action to be taken.
>=20
> Signed-off-by: Frederick Lawler <fred@cloudflare.com>

Thanks Frederick!

Acked-by: Roberto Sassu <roberto.sassu@huawei.com>

Roberto

> ---
> Changes since v2:
> - s/mask & MAY_WRITE/file->f_mode & FMODE_WRITE/
>=20
> Changes since v1:
> - Add MAY_WRITE && action check to violation_check to avoid MAY_READ
>   only situations
> ---
>  security/integrity/ima/ima_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index 9b87556b03a7..bc453f5a7531 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -237,7 +237,9 @@ static int process_measurement(struct file *file, con=
st struct cred *cred,
>  				&allowed_algos);
>  	violation_check =3D ((func =3D=3D FILE_CHECK || func =3D=3D MMAP_CHECK =
||
>  			    func =3D=3D MMAP_CHECK_REQPROT) &&
> -			   (ima_policy_flag & IMA_MEASURE));
> +			   (ima_policy_flag & IMA_MEASURE) &&
> +			   ((action & IMA_MEASURE) ||
> +			    (file->f_mode & FMODE_WRITE)));
>  	if (!action && !violation_check)
>  		return 0;
> =20


