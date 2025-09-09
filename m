Return-Path: <linux-integrity+bounces-7041-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E2AB5017D
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Sep 2025 17:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5504E2D31
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Sep 2025 15:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B702331A56D;
	Tue,  9 Sep 2025 15:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YPsi05+d"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16ED125D209;
	Tue,  9 Sep 2025 15:31:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757431906; cv=none; b=pdABBwkYeTsnYQq0El1Xie3AoCDFDRTQFTZgeoghyDbqMk9ptHTfYBvOjSpFZZvVqQAfaDuyBdodJDpzIc3EgFoZiLJpGmMtiSHmxEGghJmKbjn7QOLo/NDKsmOfm3bVijYeg0Ri+Yf78LARweeSjcPCJrTUqjSH4BmqyneJYYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757431906; c=relaxed/simple;
	bh=9u4csa/Fww/W7t8uP7zd9sB1+c5iLLbS/3N7rDstuh4=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=aNe9UmqN8wCqkvaDcwJ2KWtiBN4JDOrC/W7rYYFNF6cPozkDGFQIG/3SbFETVD58JgEQCoRe+jRBSrlO0DNx/bKb2VgY1Lhqnc1vPtVHK+c8KiCqUm9QDQmpacTlm4e7FpOuEr3GShQjUbON65v6kt6TPX+LtZey8Tp2HqDa5rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YPsi05+d; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 589Bd18F018250;
	Tue, 9 Sep 2025 15:31:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=90Byf5
	XT5MVaruoMf5NIbSiGdAOV7cZPs2ms46N+2LA=; b=YPsi05+dFuGfVRukLZbm9E
	wQLhH9DhwNhgJ8Dz4+FB5hINwSYpknUXM6cISW9HqXUYj28ieN+bVRsK497f3umO
	9iGJKsdmDBgX+7w4T9hGjXRY2vMZC6Qh1YzbMVTHp5Nsqw5dd47bxuuTaJ2G/Vfg
	EfMO4hqMs4Tc1KWUlfkTExjkqAI+7IZH18ygMuM8VXjFP0pVS3Ufs954epJOhl95
	/Tad37qIrQtUupup7wGUC6PfgWLhFXcPLt5zCPAb29X60gOvc/jr3dCyMa2bionw
	Sag8W7oC2H4pjGMf+p4cCHYwiCoLmfq3NVsOUvUekYDwefPjQF5GHGBx9dezjkrw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cff8rj8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 15:31:24 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 589FVG7f019321;
	Tue, 9 Sep 2025 15:31:23 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cff8rhw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 15:31:23 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 589E5aTX010613;
	Tue, 9 Sep 2025 15:31:22 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4910smurvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Sep 2025 15:31:22 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 589FVLdm29950706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Sep 2025 15:31:22 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB3FC58063;
	Tue,  9 Sep 2025 15:31:21 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3145D58057;
	Tue,  9 Sep 2025 15:31:21 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.147.133])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Sep 2025 15:31:21 +0000 (GMT)
Message-ID: <5aeecf1aa6eff8ae0ea0a9e95d5df79aee338b32.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: setting security.ima to fix security.evm for a
 file with IMA signature
From: Mimi Zohar <zohar@linux.ibm.com>
To: Coiby Xu <coxu@redhat.com>, linux-integrity@vger.kernel.org
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry Kasatkin	
 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul
 Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E.
 Hallyn"	 <serge@hallyn.com>,
        "open list:SECURITY SUBSYSTEM"	
 <linux-security-module@vger.kernel.org>,
        open list	
 <linux-kernel@vger.kernel.org>
In-Reply-To: <20250909041954.1626914-1-coxu@redhat.com>
References: <20250909041954.1626914-1-coxu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Sep 2025 11:31:20 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LIpIJ4Th07-G7SHRm1oHskGpVS30Mlud
X-Proofpoint-GUID: Vjm5K-ly7Hr2I-wroiZSdDn6d9Ge4Wwu
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68c0484c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=vUXcQdf43LBxS_wO:21 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=20KFwNOVAAAA:8
 a=_UlRNL-Y48Z5G6zc6kMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfX+04/QzGKh42V
 7R3TZfQ5zixYo4gMQfKXaKQZHxt5tr3UCtAOLCxTYfFEvrb+o6EgJST+U0E19vYjwWpTeu04TDR
 IlM7W3x5WTYsPGS3I5SJK9j1AKdPKADvttGJYv7C44r1T4R9tGfD+24/sb//PrIr/FLgxXe6T8p
 3Kn/hdo0dsYf3BfVF3T6tVGgCFNegFGcr4ZYJHhchs5eRlnX8DF+38SYw7x9FpRh9NA4bDvly8N
 KgZAO8HiO870zMRO2cl8a98/9ANGG/3ErAd+o9WmO5SdDNOUsbA6lrFt0S+MRCwQtbqyBv5bmtE
 oYVUsQSFBfXEoxvmT9wc9c1LBJ2WbJzcjjI5cCii8wQxrTuu0JJypxzxLq5rU3JTYmAVsOW8R8v
 +zitNgjl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-09_02,2025-09-08_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020

On Tue, 2025-09-09 at 12:19 +0800, Coiby Xu wrote:
> When both IMA and EVM fix modes are enabled, accessing a file with IMA
> signature won't cause security.evm to be fixed. But this doesn't happen
> to a file with correct IMA hash already set because accessing it will
> cause setting security.ima again which triggers fixing security.evm
> thanks to security_inode_post_setxattr->evm_update_evmxattr.
>=20
> Let's use the same mechanism to fix security.evm for a file with IMA
> signature.
>=20
> Signed-off-by: Coiby Xu <coxu@redhat.com>

Agreed, re-writing the file signature stored as security.ima would force
security.evm to be updated.

Unfortunately, I'm missing something. ima_appraise_measurement() first veri=
fies
the existing security.evm xattr, before verifying the security.ima xattr.  =
If
the EVM HMAC fails to verify, it immediately exits ima_appraise_measurement=
().=20
security.ima in this case is never verified.

This patch seems to address the case where the existing security.evm is val=
id,
but the file signature stored in security.ima is invalid.  (To get to the n=
ew
code, the "status" flag is not INTEGRITY_PASS.)  Re-writing the same invali=
d
file signature would solve an invalid security.evm, but not an invalid IMA =
file
signature.  What am I missing?

thanks,

Mimi

> ---
>  security/integrity/ima/ima_appraise.c | 27 +++++++++++++++++++++------
>  1 file changed, 21 insertions(+), 6 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/i=
ma/ima_appraise.c
> index f435eff4667f..18c3907c5e44 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -595,12 +595,27 @@ int ima_appraise_measurement(enum ima_hooks func, s=
truct ima_iint_cache *iint,
>  		integrity_audit_msg(audit_msgno, inode, filename,
>  				    op, cause, rc, 0);
>  	} else if (status !=3D INTEGRITY_PASS) {
> -		/* Fix mode, but don't replace file signatures. */
> -		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig &&
> -		    (!xattr_value ||
> -		     xattr_value->type !=3D EVM_IMA_XATTR_DIGSIG)) {
> -			if (!ima_fix_xattr(dentry, iint))
> -				status =3D INTEGRITY_PASS;
> +		/*
> +		 * Fix mode, but don't replace file signatures.
> +		 *
> +		 * When EVM fix mode is also enabled, security.evm will be
> +		 * fixed automatically when security.ima is set because of
> +		 * security_inode_post_setxattr->evm_update_evmxattr.
> +		 */
> +		if ((ima_appraise & IMA_APPRAISE_FIX) && !try_modsig) {
> +			if (!xattr_value ||
> +			    xattr_value->type !=3D EVM_IMA_XATTR_DIGSIG) {
> +				if (ima_fix_xattr(dentry, iint))
> +					status =3D INTEGRITY_PASS;
> +			} else if (xattr_value->type =3D=3D EVM_IMA_XATTR_DIGSIG &&
> +				   evm_revalidate_status(XATTR_NAME_IMA)) {
> +				if (!__vfs_setxattr_noperm(&nop_mnt_idmap,
> +							   dentry,
> +							   XATTR_NAME_IMA,
> +							   xattr_value,
> +							   xattr_len, 0))
> +					status =3D INTEGRITY_PASS;
> +			}
>  		}
> =20
>  		/*
>=20
> base-commit: b320789d6883cc00ac78ce83bccbfe7ed58afcf0


