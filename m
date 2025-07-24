Return-Path: <linux-integrity+bounces-6720-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D05BB11498
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Jul 2025 01:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35C2F1CE3C37
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Jul 2025 23:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411A1242D90;
	Thu, 24 Jul 2025 23:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="mzC2pGXt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sonic309-27.consmr.mail.ne1.yahoo.com (sonic309-27.consmr.mail.ne1.yahoo.com [66.163.184.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7305B244EA0
	for <linux-integrity@vger.kernel.org>; Thu, 24 Jul 2025 23:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753400065; cv=none; b=HdODeHO6vj1wRiXIOTK89Zfi66E8JiLXCv8x9gHU20qOf+H0ZuIDIua18cbklhQU/Y5g2Af8O8/MEmD8WQYvs5NcAvyHza9omLmm8Z/o5X3lTGYcOR+fOQH7pOb949vHck9g7hfH1n26YaL7oqQXQvo18ASTSub6TQ4JvIFOzGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753400065; c=relaxed/simple;
	bh=ioXQp1llylav4B1xNfMygcqE2qNF1HCGn0gRxrRnUz8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WWt9dwY5svEWEtDqVWgoBEQogfciQO2sXZfVOxOm6zxZOWwz95pIXTV9Gp/rtbEpaUWRNbS7sbEHVK5+NaCLlOUdUgf8iqyyvAq/YIKPqNbvcxEOp2M7v2wQ9DhsMeErXtx/zSOmU5Er0JP/ddQqRDNb8SqonkJqO6eNyeGw5Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=mzC2pGXt; arc=none smtp.client-ip=66.163.184.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753400062; bh=BeVswaypEfmVYwNCGfhDnf+mgHbS1Raxu1m8bvx7K2Q=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=mzC2pGXtMBBfCnOm3aJyd883EZRN0eJ9gZagA/4Eg0jOIp41StFQSMd3HphdmLKCNbD0i86xlmgVdkocAKqoHln4fa7Qr4GYC+x1OE6FUVP76cQgF/JfuOtV2UIa1P5CnVbQlo/ZOeCNHef05ufiYRhdM+D+Ns96/Ij68QU9To2f/A9lrIt3YYHH8T7+ek5lIHp51Mct7AQzW8rnq4toBOC5j3Z+K8Z/VIjpK1Hc5zfSFlqTe0XbIX8ET9f7oGBIDuEcPWe7Dbc8h3kYhmqW53Bnsk++26awSEYNJ6uIOnzoBmV+BGOtgDhKMouENYVcf3nb0ZYfciPiMEZvisQEiA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1753400062; bh=soCmkRIdyM1BcYlBMoa5x15XmkEGpUSyX+XzH4Zb3LS=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=nUNHKaEn9XP6ghFCCdNV4XqQekJZeD3Zn258SxzIuT6IGXDvaE+sd9y9qXXXe7XjfV0sSoU9Qj9Q3BDb3F8MtLJlz7bnmWyN3XbSfm/RJM7zEmr56M0AgiARf3K2UxC0YmniRGn4F10IGzhzG5MTiBx0XG9XBSpVvaNsA4Wm4jxb0QtAkKAieie7ho2S1CvKC7TQaQZZIeWdYPCfZ6yf1y9ifRE2jtAO4JBKsx+dbMEb6hLwMRRfuNRYNXcODsFQ1qMbxfU0zQcfJr5Q4N85KqFdieqZfjlmN2pZcHqy8WI3w5A1YDYt2h+LZEX4VHXsSxUZ85i48xnIfcg3Hwi9iA==
X-YMail-OSG: 2T3cRc0VM1mBA2Y4u2xfAgDT0tCHatA6xBOdNrQdTapqtTAAQzOTXoqUx6Z3aJ4
 j1cP0yer2_5JfGH3hROHZKHM895XMs5pnCzhvCQGJBoF2qzHakmpnZwMe6H8p.ERbHgVmpSXUpkU
 QtyBT7W72SQVdeO8alDquKR1B3TKMJndQWfTL2lTvNOquKjMxImvSHGWPbvyVa.77C7fcQsM5D51
 gl3iqVPn3QTRrVtFRcKb7BpOVvDIFWeQiVzDlndpuGkUK49ZC_P9NJNMpJWd2uyi.k2Zyj0Jzdn7
 GzQ6xf32FdnfGI7cjwKdxF9FHGEKufdn7aDwEdv3lx5bkdy5pSZbHqgELJsnr3qhvMlsnvjMo7Te
 CAl.wOzmeKAOz9XZTsTccxJ7xGAKdzI0YZ2ubXNFCfaM882nzhQGxhuuJGW5NeJRiqgvoh0f3lBa
 HLSy0sljy7Jk_JOcrN9vjUXMPfZx.bVUoDPa5AN1cXhwsRB32iwBFN8mJkSg1wdfF2m8.tfNQvj.
 CsuxS8Y0QIm4Xl4qRzeINvMkrJIVfheI5bHUmLdypYhnfloUmdHG8BHTa4vdHW2tIcjqiM44jOWT
 59XN0YJpVswYqk8u8lxX8pzDz4l1cpO5U7wyC37CtIeReskodLwuaboA0_L81Cyi4yPBq_4QZGHF
 J8pVavQtvsfKXuOwaV2yxZ7ZXNpDImRPQuJO3mYUWHvctIF9Jja9lD0hA.xpRIZ1dbYDffERCc93
 xZj5TFZW9ao.Pm_6KqyGGyvBzRepQSfmgpSPfcPwxD4v57eicwlwUilIlGHtvUySj3A3cjLvu4Zi
 xgYlIkE5llKDhU6uGEUO5TEKWTMKMIi8q8BbG4kB9F5GfJHay0_bI4az7AOcIJ78BPV42q_4jRkp
 9utOMMFjwUpuyF16RWFLZNu0kDtSo2ohvruTRyQdb42oCxoAD.uPJzgcraADSSlhu9l_0Ospr_kt
 nISTHp94oqQ6tWglui4Llf_RcJ4JLdjAxtZgWfMndf_N5T.lpCXzj8srwQA7npCyIvanYwDQClow
 XRSE0ddI3YS1oU36nbnUZpnZvM0DfSZvhn9FUWr_NHAl86hafznUKEawiNab3Cz9QnmJw15cp8uU
 IOFcePEyqDhQj0y5_BrW_KLLaMGMXJNqEGs6yM7RaoIGO2P.f_14AqgDEiPnpL420WATD7daDJUJ
 37Sw6ohTDOUoVIn0dkqmZ1Zdoql4QbCFWHa6t1iLvaJXnmlXjTTdrNk35vJgTpOH2m99VCM_7MpD
 Wzl6OGs7KzKVb7dE0GkuT2zb8Xnk5A2aBbuxeOR2Vhpj6wLLkEJDsKFqC2JYjmVW5XdbfzbpeB6E
 KIIibwqj9nlX1hzjUwqv04GdgVQ1yifmf_2UXF9Q67EoLjim4hJvn.wCxAVhiTY494zUV38NCdj8
 YrfOZuQUzrljc3cQbAJ47HGIp2sDHjoVDJHA788_eqolESg_padkT0Hi6imY.uAbuMwYujd3h920
 prT.bp_A2zqkBqfrZBKgRafr6HhcObhOGfvGqAB6vu7QnXlDfvSGRpLhkBSADJugx2lJJxLMg.Wr
 1qg6AV9bzfREVrf6gCUFSt6cp0VRsIi5QYAF03_rJcM4vx537b1CY2CGwHXhTkWurqK0A4XNr_WT
 DEBvdslEQwT.crbQgPfizivPuN1kCSntEX17eChv14gY7aE1UUxOw4mdumYOqQHtOo4VRBP5FgWH
 rF4hekWY2LIJc4lfHQaWIb6CoUzud7sEscvpijM84tXAByxLwBgBZ9B6qVvoI0Z25BuPCAEvJq_e
 T10P_3t2lUygGbxvpqFDGHgL_qzXnPQlAQITTqqV82bsiAV0oDZ.DUhDJhvSe4DaFGDdUZvnjQNv
 xQeFRP_UPnQxhna6MTrH94QuaxByp.6fGEYethU_QcZzzfXKzcQy_lOx7AcCzaBJ5jL0PiVkhrhk
 H3mO5blTdnYQ817C2i118zC.ObMdwAgEcomapiifOi.4d7mHdYExngswQTFypOjQ4JEAEK2VbkC3
 bzH5.ekLEgZgG3NflJQfYT.2QnaqEftjJrEn7ZXHIs4QsbkEtJghLubK_hM4H3Rjr_H1TH8nkuBk
 8Nay8v4kM0mNs6j9DDOsnPgddtFlq7L4A2H8rbL86O109Bv3DVLqRz1LYlsNsfLLY4oDfMBnmNC2
 2J9QTq6xx2.DLFkQkEQAcuEomVbUyY5CmDaB1PDFXTIpkQc9CpsOFpJx0QhFpOYAYc36ePc1ffDV
 nAWT6fP5SDUKOWritIbD5vlHcFyhhriPwxUvaUq2Y7p329oHgi_7ZF_yAsUx7B_BL3ZyrzZuBSwF
 7FZx7pQNciTKiRxe5O8exMyvMadhJVtmnQNFKWw--
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: f6bd0986-020f-4525-b274-6cbbe4c5f883
Received: from sonic.gate.mail.ne1.yahoo.com by sonic309.consmr.mail.ne1.yahoo.com with HTTP; Thu, 24 Jul 2025 23:34:22 +0000
Received: by hermes--production-gq1-74d64bb7d7-2dlqg (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 2f6d63f940a2fb2152fc42b74714e4e3;
          Thu, 24 Jul 2025 23:34:16 +0000 (UTC)
Message-ID: <3b90b753-7dfe-4341-98b9-fbb5efdc1d56@schaufler-ca.com>
Date: Thu, 24 Jul 2025 16:34:14 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 22/34] lsm: group lsm_order_parse() with the other
 lsm_order_*() functions
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
 linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
 Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 Fan Wu <wufan@kernel.org>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?=
 <mic@digikod.net>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>,
 Casey Schaufler <casey@schaufler-ca.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
 <20250721232142.77224-58-paul@paul-moore.com>
Content-Language: en-US
From: Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20250721232142.77224-58-paul@paul-moore.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.24187 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

On 7/21/2025 4:21 PM, Paul Moore wrote:
> Move the lsm_order_parse() function near the other lsm_order_*()
> functions to improve readability.
>
> No code changes.
>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>


> ---
>  security/lsm_init.c | 138 ++++++++++++++++++++++----------------------
>  1 file changed, 69 insertions(+), 69 deletions(-)
>
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 7e794f4515ea..ada9b5448409 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -169,75 +169,6 @@ static void __init lsm_order_append(struct lsm_info *lsm, const char *src)
>  	lsm_pr_dbg("enabling LSM %s:%s\n", src, lsm->id->name);
>  }
>  
> -/**
> - * lsm_blob_size_update - Update the LSM blob size and offset information
> - * @sz_req: the requested additional blob size
> - * @sz_cur: the existing blob size
> - */
> -static void __init lsm_blob_size_update(unsigned int *sz_req,
> -					unsigned int *sz_cur)
> -{
> -	unsigned int offset;
> -
> -	if (*sz_req == 0)
> -		return;
> -
> -	offset = ALIGN(*sz_cur, sizeof(void *));
> -	*sz_cur = offset + *sz_req;
> -	*sz_req = offset;
> -}
> -
> -/**
> - * lsm_prepare - Prepare the LSM framework for a new LSM
> - * @lsm: LSM definition
> - */
> -static void __init lsm_prepare(struct lsm_info *lsm)
> -{
> -	struct lsm_blob_sizes *blobs = lsm->blobs;
> -
> -	if (!blobs)
> -		return;
> -
> -	/* Register the LSM blob sizes. */
> -	blobs = lsm->blobs;
> -	lsm_blob_size_update(&blobs->lbs_cred, &blob_sizes.lbs_cred);
> -	lsm_blob_size_update(&blobs->lbs_file, &blob_sizes.lbs_file);
> -	lsm_blob_size_update(&blobs->lbs_ib, &blob_sizes.lbs_ib);
> -	/* inode blob gets an rcu_head in addition to LSM blobs. */
> -	if (blobs->lbs_inode && blob_sizes.lbs_inode == 0)
> -		blob_sizes.lbs_inode = sizeof(struct rcu_head);
> -	lsm_blob_size_update(&blobs->lbs_inode, &blob_sizes.lbs_inode);
> -	lsm_blob_size_update(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
> -	lsm_blob_size_update(&blobs->lbs_key, &blob_sizes.lbs_key);
> -	lsm_blob_size_update(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
> -	lsm_blob_size_update(&blobs->lbs_perf_event,
> -			     &blob_sizes.lbs_perf_event);
> -	lsm_blob_size_update(&blobs->lbs_sock, &blob_sizes.lbs_sock);
> -	lsm_blob_size_update(&blobs->lbs_superblock,
> -			     &blob_sizes.lbs_superblock);
> -	lsm_blob_size_update(&blobs->lbs_task, &blob_sizes.lbs_task);
> -	lsm_blob_size_update(&blobs->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
> -	lsm_blob_size_update(&blobs->lbs_xattr_count,
> -			     &blob_sizes.lbs_xattr_count);
> -	lsm_blob_size_update(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
> -}
> -
> -/**
> - * lsm_init_single - Initialize a given LSM
> - * @lsm: LSM definition
> - */
> -static void __init lsm_init_single(struct lsm_info *lsm)
> -{
> -	int ret;
> -
> -	if (!lsm_is_enabled(lsm))
> -		return;
> -
> -	lsm_pr_dbg("initializing %s\n", lsm->id->name);
> -	ret = lsm->init();
> -	WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
> -}
> -
>  /**
>   * lsm_order_parse - Parse the comma delimited LSM list
>   * @list: LSM list
> @@ -308,6 +239,75 @@ static void __init lsm_order_parse(const char *list, const char *src)
>  	}
>  }
>  
> +/**
> + * lsm_blob_size_update - Update the LSM blob size and offset information
> + * @sz_req: the requested additional blob size
> + * @sz_cur: the existing blob size
> + */
> +static void __init lsm_blob_size_update(unsigned int *sz_req,
> +					unsigned int *sz_cur)
> +{
> +	unsigned int offset;
> +
> +	if (*sz_req == 0)
> +		return;
> +
> +	offset = ALIGN(*sz_cur, sizeof(void *));
> +	*sz_cur = offset + *sz_req;
> +	*sz_req = offset;
> +}
> +
> +/**
> + * lsm_prepare - Prepare the LSM framework for a new LSM
> + * @lsm: LSM definition
> + */
> +static void __init lsm_prepare(struct lsm_info *lsm)
> +{
> +	struct lsm_blob_sizes *blobs = lsm->blobs;
> +
> +	if (!blobs)
> +		return;
> +
> +	/* Register the LSM blob sizes. */
> +	blobs = lsm->blobs;
> +	lsm_blob_size_update(&blobs->lbs_cred, &blob_sizes.lbs_cred);
> +	lsm_blob_size_update(&blobs->lbs_file, &blob_sizes.lbs_file);
> +	lsm_blob_size_update(&blobs->lbs_ib, &blob_sizes.lbs_ib);
> +	/* inode blob gets an rcu_head in addition to LSM blobs. */
> +	if (blobs->lbs_inode && blob_sizes.lbs_inode == 0)
> +		blob_sizes.lbs_inode = sizeof(struct rcu_head);
> +	lsm_blob_size_update(&blobs->lbs_inode, &blob_sizes.lbs_inode);
> +	lsm_blob_size_update(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
> +	lsm_blob_size_update(&blobs->lbs_key, &blob_sizes.lbs_key);
> +	lsm_blob_size_update(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
> +	lsm_blob_size_update(&blobs->lbs_perf_event,
> +			     &blob_sizes.lbs_perf_event);
> +	lsm_blob_size_update(&blobs->lbs_sock, &blob_sizes.lbs_sock);
> +	lsm_blob_size_update(&blobs->lbs_superblock,
> +			     &blob_sizes.lbs_superblock);
> +	lsm_blob_size_update(&blobs->lbs_task, &blob_sizes.lbs_task);
> +	lsm_blob_size_update(&blobs->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
> +	lsm_blob_size_update(&blobs->lbs_xattr_count,
> +			     &blob_sizes.lbs_xattr_count);
> +	lsm_blob_size_update(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
> +}
> +
> +/**
> + * lsm_init_single - Initialize a given LSM
> + * @lsm: LSM definition
> + */
> +static void __init lsm_init_single(struct lsm_info *lsm)
> +{
> +	int ret;
> +
> +	if (!lsm_is_enabled(lsm))
> +		return;
> +
> +	lsm_pr_dbg("initializing %s\n", lsm->id->name);
> +	ret = lsm->init();
> +	WARN(ret, "%s failed to initialize: %d\n", lsm->id->name, ret);
> +}
> +
>  /**
>   * lsm_static_call_init - Initialize a LSM's static calls
>   * @hl: LSM hook list

