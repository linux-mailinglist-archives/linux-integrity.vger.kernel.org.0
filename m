Return-Path: <linux-integrity+bounces-7025-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FA95B4802C
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Sep 2025 23:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02777176B29
	for <lists+linux-integrity@lfdr.de>; Sun,  7 Sep 2025 21:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16E8D27707;
	Sun,  7 Sep 2025 21:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s/P4vl1p"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C25315D34;
	Sun,  7 Sep 2025 21:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757279940; cv=none; b=emHDewLznMbMMR7ELGtq5simTISTyDuMvzgx8h83EB7hNigwRmdasVhgLlpJwfpnj6JE+hnwbeoRMXj6YgaIl2KQuQbBAIHlHFajteYlAdjcPTi3oJpqYGgpi0ncN0ZQbVtLgjDB8YaYU2i26k/AbC50GoJBY52Ppd4pbZyRCQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757279940; c=relaxed/simple;
	bh=Se/FnQ0OuCi47oqqaAsntbYlMh9htb4nMcnaGFARuIQ=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=fO7u3hZws0QMMQQ8Mwwi2gCy05PNGCBIFLfGbZJwmU4t5EuLYoCqG85ub8OASHi2RKujAC8DeNz97oIVNdAFeCoqoZ8vwk0/IRMHP/DVpqRqS9vcAgEouIlYSoBVEo9zHuI5MQ4RT5wmqtlepmGZ1Bj78CS6hmoDXwhi6QTz+Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s/P4vl1p; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587JdV9D012159;
	Sun, 7 Sep 2025 21:17:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Wb8e79
	mOzqFM+h6F4+Xiru1xvg7XAr2jFUJ/6Yvk9cg=; b=s/P4vl1p5oZCCCn5B3nSth
	FDVZgudandAsqhC8wIrkPqEs/XL/YbIKY6roiOkrzDHox7pQJRAw52D5me6O9C+F
	u7mTempLW3xA2VM6+XobYhLxLZx+i4GsYuYTyBAUV5Pp/fBUathQGUEEH9VOEOc3
	sX7SV9yZgBwNS6IwX/ndBVTySKMO+8zJj7HBOevxum4KwFVvRPfJoKFm2eNS9o1q
	BjSbGP+B0DN64y+7KPL+EgeCpS/LKDkqIBp5IBqu7ml97/n/LyP8cbFKoP0Xqrxa
	N0QoUmAWvnnMVRsLWfJZz+NAA4eDtfyRSD6Oomwl1/ZT+VAOQUiEeIMmbcAtymqQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490xycjwth-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Sep 2025 21:17:44 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 587H1ogu011428;
	Sun, 7 Sep 2025 21:17:43 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 490y9u39vp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Sep 2025 21:17:43 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 587LHgot56099238
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 7 Sep 2025 21:17:42 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 527E65803F;
	Sun,  7 Sep 2025 21:17:42 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0A8058055;
	Sun,  7 Sep 2025 21:17:40 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.133.224])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  7 Sep 2025 21:17:40 +0000 (GMT)
Message-ID: <82f22f97486622408bec772a9b025e301c8fa2f4.camel@linux.ibm.com>
Subject: Re: [PATCH] ima,evm: move initcalls to the LSM framework
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, paul@paul-moore.com,
        roberto.sassu@huawei.com
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
        selinux@vger.kernel.org, john.johansen@canonical.com, wufan@kernel.org,
        mic@digikod.net, kees@kernel.org, mortonm@chromium.org,
        casey@schaufler-ca.com, penguin-kernel@i-love.sakura.ne.jp,
        nicolas.bouchinet@oss.cyber.gouv.fr, xiujianfeng@huawei.com
In-Reply-To: <20250902125457.2689519-1-roberto.sassu@huaweicloud.com>
References: <9f35539de7188c6b853c55b76958a286131f5928.camel@huaweicloud.com>
	 <20250902125457.2689519-1-roberto.sassu@huaweicloud.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 07 Sep 2025 17:17:40 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UMZf4YzorFjEKbuZYUgSO0iq_8y_5oGJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDIzNSBTYWx0ZWRfX/AEt7NODZfhX
 fhdg1LmtkAcR1eLaZqnx6yHaaze9Kow5UJhQDP/fRKOBoCK786sXaMktVN1TZg8SCKQ4HCLGfxo
 byXtcVVsGeHTnlqJriv4o/LJH8sCKMZJayaLB+8NGmxq0pL4+o/LPy6+B6ziNDiZs0rHOZW2qOi
 LC8Y74DSBAMVoZ3WSwfQVZGuKXsT2nPLPinMZLlK1GRikVIkK8wD1BOvRzGi7QOTjnZuWIMpaEs
 UH3KT++4MauP3SVBvrgVsxhPsu+cB4mZ0u6RqMhpW8L85++qLBUW3tIolALVAQKhqbyFgMITFTW
 MPcYEKLU/BKVNiEqHFo+gvjLlXFpZIh8df1L27GwZ9Ts9H2AsZooZPl4xhkJp2/dKP16vhUDC6e
 uYTIArn+
X-Proofpoint-GUID: UMZf4YzorFjEKbuZYUgSO0iq_8y_5oGJ
X-Authority-Analysis: v=2.4 cv=F59XdrhN c=1 sm=1 tr=0 ts=68bdf678 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=xVhDTqbCAAAA:8 a=i0EeH86SAAAA:8
 a=VnNF1IyMAAAA:8 a=qYjNB4YJ_WdnM4YJFFYA:9 a=QEXdDO2ut3YA:10
 a=GrmWmAYt4dzCMttCBZOh:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-07_08,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 clxscore=1015
 impostorscore=0 bulkscore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509060235

On Tue, 2025-09-02 at 14:54 +0200, Roberto Sassu wrote:
> From: Paul Moore <paul@paul-moore.com>

Remove above ...

>=20
> This patch converts IMA and EVM to use the LSM frameworks's initcall
> mechanism. It moved the integrity_fs_init() call to ima_fs_init() and
> evm_init_secfs(), to work around the fact that there is no "integrity" LS=
M,
> and introduced integrity_fs_fini() to remove the integrity directory, if
> empty. Both integrity_fs_init() and integrity_fs_fini() support the
> scenario of being called by both the IMA and EVM LSMs.
>=20
> It is worth mentioning that this patch does not touch any of the
> "platform certs" code that lives in the security/integrity/platform_certs
> directory as the IMA/EVM maintainers have assured me that this code is
> unrelated to IMA/EVM, despite the location, and will be moved to a more

This wording "unrelated to IMA/EVM" was taken from Paul's patch description=
, but
needs to be tweaked.  Please refer to my comment on Paul's patch.

> relevant subsystem in the future.
>=20
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>, but not yet tested.


> ---
>  security/integrity/evm/evm_main.c  |  3 +--
>  security/integrity/evm/evm_secfs.c | 11 +++++++++--
>  security/integrity/iint.c          | 14 ++++++++++++--
>  security/integrity/ima/ima_fs.c    | 11 +++++++++--
>  security/integrity/ima/ima_main.c  |  4 ++--
>  security/integrity/integrity.h     |  2 ++
>  6 files changed, 35 insertions(+), 10 deletions(-)
>=20
> diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/e=
vm_main.c
> index db8e324ed4e6..73d500a375cb 100644
> --- a/security/integrity/evm/evm_main.c
> +++ b/security/integrity/evm/evm_main.c
> @@ -1179,6 +1179,5 @@ DEFINE_LSM(evm) =3D {
>  	.init =3D init_evm_lsm,
>  	.order =3D LSM_ORDER_LAST,
>  	.blobs =3D &evm_blob_sizes,
> +	.initcall_late =3D init_evm,
>  };
> -
> -late_initcall(init_evm);
> diff --git a/security/integrity/evm/evm_secfs.c b/security/integrity/evm/=
evm_secfs.c
> index b0d2aad27850..c26724690cec 100644
> --- a/security/integrity/evm/evm_secfs.c
> +++ b/security/integrity/evm/evm_secfs.c
> @@ -302,10 +302,16 @@ int __init evm_init_secfs(void)
>  	int error =3D 0;
>  	struct dentry *dentry;
> =20
> -	evm_dir =3D securityfs_create_dir("evm", integrity_dir);
> -	if (IS_ERR(evm_dir))
> +	error =3D integrity_fs_init();
> +	if (error < 0)
>  		return -EFAULT;
> =20
> +	evm_dir =3D securityfs_create_dir("evm", integrity_dir);
> +	if (IS_ERR(evm_dir)) {
> +		error =3D -EFAULT;
> +		goto out;
> +	}
> +
>  	dentry =3D securityfs_create_file("evm", 0660,
>  				      evm_dir, NULL, &evm_key_ops);
>  	if (IS_ERR(dentry)) {
> @@ -329,5 +335,6 @@ int __init evm_init_secfs(void)
>  out:
>  	securityfs_remove(evm_symlink);
>  	securityfs_remove(evm_dir);
> +	integrity_fs_fini();
>  	return error;
>  }
> diff --git a/security/integrity/iint.c b/security/integrity/iint.c
> index 068ac6c2ae1e..8ec1a3436a71 100644
> --- a/security/integrity/iint.c
> +++ b/security/integrity/iint.c
> @@ -42,8 +42,11 @@ void __init integrity_load_keys(void)
>  		evm_load_x509();
>  }
> =20
> -static int __init integrity_fs_init(void)
> +int __init integrity_fs_init(void)
>  {
> +	if (integrity_dir)
> +		return 0;
> +
>  	integrity_dir =3D securityfs_create_dir("integrity", NULL);
>  	if (IS_ERR(integrity_dir)) {
>  		int ret =3D PTR_ERR(integrity_dir);
> @@ -58,4 +61,11 @@ static int __init integrity_fs_init(void)
>  	return 0;
>  }
> =20
> -late_initcall(integrity_fs_init)
> +void __init integrity_fs_fini(void)
> +{
> +	if (!integrity_dir || !simple_empty(integrity_dir))
> +		return;
> +
> +	securityfs_remove(integrity_dir);
> +	integrity_dir =3D NULL;
> +}
> diff --git a/security/integrity/ima/ima_fs.c b/security/integrity/ima/ima=
_fs.c
> index 87045b09f120..012a58959ff0 100644
> --- a/security/integrity/ima/ima_fs.c
> +++ b/security/integrity/ima/ima_fs.c
> @@ -499,9 +499,15 @@ int __init ima_fs_init(void)
>  	struct dentry *dentry;
>  	int ret;
> =20
> +	ret =3D integrity_fs_init();
> +	if (ret < 0)
> +		return ret;
> +
>  	ima_dir =3D securityfs_create_dir("ima", integrity_dir);
> -	if (IS_ERR(ima_dir))
> -		return PTR_ERR(ima_dir);
> +	if (IS_ERR(ima_dir)) {
> +		ret =3D PTR_ERR(ima_dir);
> +		goto out;
> +	}
> =20
>  	ima_symlink =3D securityfs_create_symlink("ima", NULL, "integrity/ima",
>  						NULL);
> @@ -555,6 +561,7 @@ int __init ima_fs_init(void)
>  out:
>  	securityfs_remove(ima_symlink);
>  	securityfs_remove(ima_dir);
> +	integrity_fs_fini();
> =20
>  	return ret;
>  }
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/i=
ma_main.c
> index eade8e1e3cb1..b703bfc2f470 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -1283,6 +1283,6 @@ DEFINE_LSM(ima) =3D {
>  	.init =3D init_ima_lsm,
>  	.order =3D LSM_ORDER_LAST,
>  	.blobs =3D &ima_blob_sizes,
> +	/* Start IMA after the TPM is available */
> +	.initcall_late =3D init_ima,
>  };
> -
> -late_initcall(init_ima);	/* Start IMA after the TPM is available */
> diff --git a/security/integrity/integrity.h b/security/integrity/integrit=
y.h
> index c2c2da691123..7b388b66cf80 100644
> --- a/security/integrity/integrity.h
> +++ b/security/integrity/integrity.h
> @@ -114,6 +114,8 @@ struct ima_file_id {
> =20
>  int integrity_kernel_read(struct file *file, loff_t offset,
>  			  void *addr, unsigned long count);
> +int __init integrity_fs_init(void);
> +void __init integrity_fs_fini(void);
> =20
>  #define INTEGRITY_KEYRING_EVM		0
>  #define INTEGRITY_KEYRING_IMA		1


