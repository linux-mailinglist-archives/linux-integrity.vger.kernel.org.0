Return-Path: <linux-integrity+bounces-4965-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E240DA3FCB9
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 18:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21DD1189AB04
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Feb 2025 16:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8085122A1D3;
	Fri, 21 Feb 2025 16:58:35 +0000 (UTC)
X-Original-To: linux-integrity@vger.kernel.org
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A51214A85
	for <linux-integrity@vger.kernel.org>; Fri, 21 Feb 2025 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=14.137.139.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740157115; cv=none; b=Pyc/qHCY+1mMCRD6MrpfJ5dvZWQ//S5XgnGfljrGdl9pegaz1GMlXWSy4ZeNLAh9n7lMnIBeMLhr++9/kElSRK38HlpPWqzcvjm/OjIQeWgoK0McID49zsKhAwxum41EiTuZnFW/OylHgjhtcYrnXe4DVcV/NdcvqjcoEq8nM3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740157115; c=relaxed/simple;
	bh=deI/TO8S/hY/4GAtaVfOTzfWsAbDaGtlVeuYMSfOH+g=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IDEBRRf/K50ge5SDtRzbYkBaeM/d4KwwWxMhTNwcRUjbfcXA14bPFOrD3v4bxJqfBBCzl4oohhRoaxnxaQimUUt8JJecxlOSbUVc2ajCKRuCapEPMg7oclRoQNX4cFGA2FVNqPStY6XxB5/rrdvEHyGaewyPxzpBO5nkPCBy6mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=14.137.139.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.18.186.29])
	by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4YzwYG2BKyz9v7JQ
	for <linux-integrity@vger.kernel.org>; Sat, 22 Feb 2025 00:28:34 +0800 (CST)
Received: from mail02.huawei.com (unknown [7.182.16.47])
	by mail.maildlp.com (Postfix) with ESMTP id 813DA140E60
	for <linux-integrity@vger.kernel.org>; Sat, 22 Feb 2025 00:57:29 +0800 (CST)
Received: from [127.0.0.1] (unknown [10.204.63.22])
	by APP1 (Coremail) with SMTP id LxC2BwCXaUg4sLhnXzTrAg--.33714S2;
	Fri, 21 Feb 2025 17:56:29 +0100 (CET)
Message-ID: <21d652e28fed8d9db409045425a6dffbdb13a87c.camel@huaweicloud.com>
Subject: Re: [PATCH 1/2] ima: limit the number of open-writers integrity
 violations
From: Roberto Sassu <roberto.sassu@huaweicloud.com>
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: roberto.sassu@huawei.com, Stefan Berger <stefanb@linux.ibm.com>, Petr
 Vorel <pvorel@suse.cz>
Date: Fri, 21 Feb 2025 17:56:21 +0100
In-Reply-To: <20250219162131.416719-2-zohar@linux.ibm.com>
References: <20250219162131.416719-1-zohar@linux.ibm.com>
	 <20250219162131.416719-2-zohar@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-CM-TRANSID:LxC2BwCXaUg4sLhnXzTrAg--.33714S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr4kXr1kZF1DuryDAr4ktFb_yoW5Gw4kpa
	yqqFWrKryktFy7Crn5t3W3ZayrK348tay7Wws8Aw1vvFs8X3Wvgr1fXFyYyryfWFySyryx
	tr42v3y5Za1Dt37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UtR6wUUUUU=
X-CM-SenderInfo: purev21wro2thvvxqx5xdzvxpfor3voofrz/1tbiAgAGBGe4JdYF9wABsf

On Wed, 2025-02-19 at 11:21 -0500, Mimi Zohar wrote:
> Each time a file in policy, that is already opened for write, is opened
> for read an open-writers integrity violation audit message is emitted
> and a violation record is added to the IMA measurement list, even if an
> open-writers violation has already been recorded.
>=20
> Limit the number of open-writers integrity violations for an existing
> file open for write to one.  After the existing file open for write
> closes (__fput), subsequent open-writers integrity violations may occur.

More precisely, may be emitted again.

> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
> Change log v1:
> - Basesd on Stefan's RFC comments, updated the patch description and code=
.

Based.

Could be also useful to have here what is changed.

>  security/integrity/ima/ima.h      |  1 +
>  security/integrity/ima/ima_main.c | 11 +++++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima.h b/security/integrity/ima/ima.h
> index a4f284bd846c..7f21568544dd 100644
> --- a/security/integrity/ima/ima.h
> +++ b/security/integrity/ima/ima.h
> @@ -182,6 +182,7 @@ struct ima_kexec_hdr {
>  #define IMA_CHANGE_ATTR		2
>  #define IMA_DIGSIG		3
>  #define IMA_MUST_MEASURE	4
> +#define IMA_LIMIT_VIOLATIONS	5

I like to name variables in a way that it is clear what the intent is.
Thinking about it, maybe:

IMA_OPEN_WRITERS_EMITTED

Thanks

Roberto

>  /* IMA integrity metadata associated with an inode */
>  struct ima_iint_cache {
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index 28b8b0db6f9b..cde3ae55d654 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -137,8 +137,13 @@ static void ima_rdwr_violation_check(struct file *fi=
le,
>  	} else {
>  		if (must_measure)
>  			set_bit(IMA_MUST_MEASURE, &iint->atomic_flags);
> -		if (inode_is_open_for_write(inode) && must_measure)
> -			send_writers =3D true;
> +
> +		/* Limit number of open_writers violations */
> +		if (inode_is_open_for_write(inode) && must_measure) {
> +			if (!test_and_set_bit(IMA_LIMIT_VIOLATIONS,
> +					      &iint->atomic_flags))
> +				send_writers =3D true;
> +		}
>  	}
>=20
>  	if (!send_tomtou && !send_writers)
> @@ -167,6 +172,8 @@ static void ima_check_last_writer(struct ima_iint_cac=
he *iint,
>  	if (atomic_read(&inode->i_writecount) =3D=3D 1) {
>  		struct kstat stat;
>=20
> +		clear_bit(IMA_LIMIT_VIOLATIONS, &iint->atomic_flags);
> +
>  		update =3D test_and_clear_bit(IMA_UPDATE_XATTR,
>  					    &iint->atomic_flags);
>  		if ((iint->flags & IMA_NEW_FILE) ||
> --
> 2.48.1
>=20


