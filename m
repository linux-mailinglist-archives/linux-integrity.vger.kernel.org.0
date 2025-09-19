Return-Path: <linux-integrity+bounces-7188-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4220B89216
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 12:46:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CB2C173959
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Sep 2025 10:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AC7A2FE581;
	Fri, 19 Sep 2025 10:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sv6KfX8O"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7902719755B;
	Fri, 19 Sep 2025 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758278794; cv=none; b=A+nZfYavanycXYlY0pHir5XgeqzPIoGYwpAgqNUcTkh3iZnae+XIbLu1cI5S+jMiGqXNvvMuMnDuW2ptCSB++JdBuPdx9RAjkbliRybavSdRSiZqRJ4q7ajuzeXoSbW44MLK0ZoCli4iIG2+BlcTfZ9ZOh+Vvo5nMWIaXTV4J24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758278794; c=relaxed/simple;
	bh=8rcQ8dHDqH+OOZHlitig5BfULl+NOzd+I4zJy7zB0To=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=QDRA5c96n2J0Hf7aBH+9RqPrQUfS91LhAziWEyAHnWF1/7IyAvj2hSRc6nNZxr+1gyR03QSvxPxUPxsEKX+Z0vjJy4EkGZefTay2xNrwxXwxsDm48+NyI3H6vEJ3+tYbfUdxv1hw+wyJWqF9T2IQ8fPhxDn8puOZJukbjuwlW74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sv6KfX8O; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58JAQ2Rs027553;
	Fri, 19 Sep 2025 10:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ef8yMK
	f3wizlHTGsZmRNZLg73MsyvOnNFj0hRwQBovg=; b=sv6KfX8OSLG6yYd5jxygbk
	iyucAnu+oDJoh4OIwsES2P6XNF7wPB7SZIvaE9sFXG8AR6cfQWdnkzdr0E7H/Ye3
	dr+4+YT1svsg1BmAbSXSVquQCV8QTC4fkpH6f9Cb8uswU/wE+X5hQ1CBOSzAxv13
	i7dkdJOFpTAxMir4AEL/IZbBejzWy78QdDrFes2zt8DMrLTCbq4Wfn+dPgJTVQMv
	laBByREVr1PTs5RutLYGoI6KtaRsoYVYn4ajq2GZoSk2nRux0OTLRdzZxEcWqayk
	HTgFpScXs9pdAFTovUHgvxye7sMEN7xYTi6F30QkESmjyqZwE86sCTw1CeHrTbDw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4pg5cq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 10:45:28 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58JAjRkl024467;
	Fri, 19 Sep 2025 10:45:27 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 497g4pg5cn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 10:45:27 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58J8fnTx005935;
	Fri, 19 Sep 2025 10:45:26 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 495jxuknnq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Sep 2025 10:45:26 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58JAjP1732178838
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 10:45:26 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C48725805A;
	Fri, 19 Sep 2025 10:45:25 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C47C358051;
	Fri, 19 Sep 2025 10:45:24 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.169.163])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Sep 2025 10:45:24 +0000 (GMT)
Message-ID: <e64f4f0a2b91e9085a55fd4573e8562e22681050.camel@linux.ibm.com>
Subject: Re: [PATCH v4 03/34] lsm: consolidate lsm_allowed() and
 prepare_lsm() into lsm_prepare()
From: Mimi Zohar <zohar@linux.ibm.com>
To: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
        Roberto Sassu	
 <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>,
        =?ISO-8859-1?Q?Micka=EBl_Sala=FCn?=	 <mic@digikod.net>,
        =?ISO-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
        Kees Cook
 <kees@kernel.org>, Micah Morton <mortonm@chromium.org>,
        Casey Schaufler	
 <casey@schaufler-ca.com>,
        Tetsuo Handa
 <penguin-kernel@I-love.SAKURA.ne.jp>,
        Nicolas Bouchinet
 <nicolas.bouchinet@oss.cyber.gouv.fr>,
        Xiu Jianfeng <xiujianfeng@huawei.com>
In-Reply-To: <20250916220355.252592-39-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
	 <20250916220355.252592-39-paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 19 Sep 2025 06:45:24 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwNCBTYWx0ZWRfX40189Q8tFzow
 YlXPpAGsipL0NM20m5loXj2Um/vaRQiGSMFldeVqqErYS9+sfZF9wckKN+TeG6twkvJkhDSebQv
 nPqVJ0b/CObufsFQNrTH0WNZa9xqtKzrtzgpxDZ5IdV87AE5iMc3gLGJ3OJOYCdBh3q9ciYY5Cc
 /00zgENF57+NO8OAfWmBRWg2orvYyilLhfl1mLR6t1yCMaNi+9cwyNZWrYC4e+UumY+r/TcndC6
 uMU49QyBuGIae91a7p7T/964wjgdKnaJ9JG4PPE3wz374Fkb2cABFvoIySQ+i+gpm40ROgiGqNu
 JZ0IbZDkLtynZSrK64KQImJHVopwUL0epe1pO/BlnVbooxTITRImYDaMyxE1Bme+mOHdyioQV3m
 GZ0RChNf
X-Proofpoint-ORIG-GUID: NbSdPWAJL-nvq_cPCa7H1aXTNKB1X6Kp
X-Proofpoint-GUID: RIEv9JjUofPfpaQeQxFLMq0uDfsRcQt7
X-Authority-Analysis: v=2.4 cv=cNzgskeN c=1 sm=1 tr=0 ts=68cd3448 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=vpqfxihKAAAA:8 a=DfNHnWVPAAAA:8
 a=xVhDTqbCAAAA:8 a=VnNF1IyMAAAA:8 a=uyOS974J1sCVxvdx_DUA:9 a=QEXdDO2ut3YA:10
 a=AULIiLoY-XQsE5F6gcqX:22 a=rjTVMONInIDnV1a_A2c_:22 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_03,2025-09-19_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509160204

On Tue, 2025-09-16 at 18:03 -0400, Paul Moore wrote:
> Simplify and consolidate the lsm_allowed() and prepare_lsm() functions
> into a new function, lsm_prepare().
>=20
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: John Johansen <john.johhansen@canonical.com>
> Signed-off-by: Paul Moore <paul@paul-moore.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  security/lsm_init.c | 109 +++++++++++++++++++-------------------------
>  1 file changed, 46 insertions(+), 63 deletions(-)
>=20
> diff --git a/security/lsm_init.c b/security/lsm_init.c
> index 124213b906af..6f40ab1d2f54 100644
> --- a/security/lsm_init.c
> +++ b/security/lsm_init.c
> @@ -123,22 +123,6 @@ static void __init append_ordered_lsm(struct lsm_inf=
o *lsm, const char *from)
>  		   is_enabled(lsm) ? "enabled" : "disabled");
>  }
> =20
> -/* Is an LSM allowed to be initialized? */
> -static bool __init lsm_allowed(struct lsm_info *lsm)
> -{
> -	/* Skip if the LSM is disabled. */
> -	if (!is_enabled(lsm))
> -		return false;
> -
> -	/* Not allowed if another exclusive LSM already initialized. */
> -	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
> -		init_debug("exclusive disabled: %s\n", lsm->name);
> -		return false;
> -	}
> -
> -	return true;
> -}
> -
>  static void __init lsm_set_blob_size(int *need, int *lbs)
>  {
>  	int offset;
> @@ -151,54 +135,53 @@ static void __init lsm_set_blob_size(int *need, int=
 *lbs)
>  	*need =3D offset;
>  }
> =20
> -static void __init lsm_set_blob_sizes(struct lsm_blob_sizes *needed)
> +/**
> + * lsm_prepare - Prepare the LSM framework for a new LSM
> + * @lsm: LSM definition
> + */
> +static void __init lsm_prepare(struct lsm_info *lsm)
>  {
> -	if (!needed)
> +	struct lsm_blob_sizes *blobs;
> +
> +	if (!is_enabled(lsm)) {
> +		set_enabled(lsm, false);
> +		return;
> +	} else if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && exclusive) {
> +		init_debug("exclusive disabled: %s\n", lsm->name);
> +		set_enabled(lsm, false);
>  		return;
> -
> -	lsm_set_blob_size(&needed->lbs_cred, &blob_sizes.lbs_cred);
> -	lsm_set_blob_size(&needed->lbs_file, &blob_sizes.lbs_file);
> -	lsm_set_blob_size(&needed->lbs_ib, &blob_sizes.lbs_ib);
> -	/*
> -	 * The inode blob gets an rcu_head in addition to
> -	 * what the modules might need.
> -	 */
> -	if (needed->lbs_inode && blob_sizes.lbs_inode =3D=3D 0)
> -		blob_sizes.lbs_inode =3D sizeof(struct rcu_head);
> -	lsm_set_blob_size(&needed->lbs_inode, &blob_sizes.lbs_inode);
> -	lsm_set_blob_size(&needed->lbs_ipc, &blob_sizes.lbs_ipc);
> -	lsm_set_blob_size(&needed->lbs_key, &blob_sizes.lbs_key);
> -	lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
> -	lsm_set_blob_size(&needed->lbs_perf_event, &blob_sizes.lbs_perf_event);
> -	lsm_set_blob_size(&needed->lbs_sock, &blob_sizes.lbs_sock);
> -	lsm_set_blob_size(&needed->lbs_superblock, &blob_sizes.lbs_superblock);
> -	lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
> -	lsm_set_blob_size(&needed->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
> -	lsm_set_blob_size(&needed->lbs_xattr_count,
> -			  &blob_sizes.lbs_xattr_count);
> -	lsm_set_blob_size(&needed->lbs_bdev, &blob_sizes.lbs_bdev);
> -	lsm_set_blob_size(&needed->lbs_bpf_map, &blob_sizes.lbs_bpf_map);
> -	lsm_set_blob_size(&needed->lbs_bpf_prog, &blob_sizes.lbs_bpf_prog);
> -	lsm_set_blob_size(&needed->lbs_bpf_token, &blob_sizes.lbs_bpf_token);
> -}
> -
> -/* Prepare LSM for initialization. */
> -static void __init prepare_lsm(struct lsm_info *lsm)
> -{
> -	int enabled =3D lsm_allowed(lsm);
> -
> -	/* Record enablement (to handle any following exclusive LSMs). */
> -	set_enabled(lsm, enabled);
> -
> -	/* If enabled, do pre-initialization work. */
> -	if (enabled) {
> -		if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
> -			exclusive =3D lsm;
> -			init_debug("exclusive chosen:   %s\n", lsm->name);
> -		}
> -
> -		lsm_set_blob_sizes(lsm->blobs);
>  	}
> +
> +	/* Mark the LSM as enabled. */
> +	set_enabled(lsm, true);
> +	if ((lsm->flags & LSM_FLAG_EXCLUSIVE) && !exclusive) {
> +		init_debug("exclusive chosen:   %s\n", lsm->name);
> +		exclusive =3D lsm;
> +	}
> +
> +	/* Register the LSM blob sizes. */
> +	blobs =3D lsm->blobs;
> +	lsm_set_blob_size(&blobs->lbs_cred, &blob_sizes.lbs_cred);
> +	lsm_set_blob_size(&blobs->lbs_file, &blob_sizes.lbs_file);
> +	lsm_set_blob_size(&blobs->lbs_ib, &blob_sizes.lbs_ib);
> +	/* inode blob gets an rcu_head in addition to LSM blobs. */
> +	if (blobs->lbs_inode && blob_sizes.lbs_inode =3D=3D 0)
> +		blob_sizes.lbs_inode =3D sizeof(struct rcu_head);
> +	lsm_set_blob_size(&blobs->lbs_inode, &blob_sizes.lbs_inode);
> +	lsm_set_blob_size(&blobs->lbs_ipc, &blob_sizes.lbs_ipc);
> +	lsm_set_blob_size(&blobs->lbs_key, &blob_sizes.lbs_key);
> +	lsm_set_blob_size(&blobs->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
> +	lsm_set_blob_size(&blobs->lbs_perf_event, &blob_sizes.lbs_perf_event);
> +	lsm_set_blob_size(&blobs->lbs_sock, &blob_sizes.lbs_sock);
> +	lsm_set_blob_size(&blobs->lbs_superblock, &blob_sizes.lbs_superblock);
> +	lsm_set_blob_size(&blobs->lbs_task, &blob_sizes.lbs_task);
> +	lsm_set_blob_size(&blobs->lbs_tun_dev, &blob_sizes.lbs_tun_dev);
> +	lsm_set_blob_size(&blobs->lbs_xattr_count,
> +			  &blob_sizes.lbs_xattr_count);
> +	lsm_set_blob_size(&blobs->lbs_bdev, &blob_sizes.lbs_bdev);
> +	lsm_set_blob_size(&blobs->lbs_bpf_map, &blob_sizes.lbs_bpf_map);
> +	lsm_set_blob_size(&blobs->lbs_bpf_prog, &blob_sizes.lbs_bpf_prog);
> +	lsm_set_blob_size(&blobs->lbs_bpf_token, &blob_sizes.lbs_bpf_token);
>  }
> =20
>  /* Initialize a given LSM, if it is enabled. */
> @@ -361,7 +344,7 @@ static void __init ordered_lsm_init(void)
>  		ordered_lsm_parse(builtin_lsm_order, "builtin");
> =20
>  	for (lsm =3D ordered_lsms; *lsm; lsm++)
> -		prepare_lsm(*lsm);
> +		lsm_prepare(*lsm);
> =20
>  	report_lsm_order();
> =20
> @@ -505,7 +488,7 @@ int __init early_security_init(void)
>  	for (lsm =3D __start_early_lsm_info; lsm < __end_early_lsm_info; lsm++)=
 {
>  		if (!lsm->enabled)
>  			lsm->enabled =3D &lsm_enabled_true;
> -		prepare_lsm(lsm);
> +		lsm_prepare(lsm);
>  		initialize_lsm(lsm);
>  	}
> =20


