Return-Path: <linux-integrity+bounces-7228-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B103B925B5
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Sep 2025 19:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C95047A6D8C
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Sep 2025 17:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C513126D5;
	Mon, 22 Sep 2025 17:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YT1O4Y/p"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297C73112BF;
	Mon, 22 Sep 2025 17:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758561099; cv=none; b=l6JOX86d5+WlZSS18ryEdKhZymUT0OgmFs38alTCoTWaVT7DrawuGnn2LDOATOfNwYO4pZMPh+yqETOed3ZCf7Do5uq3PfRtDcFEZXcV7f5zf9ydzuHinId1a7C1bI2K1JfIRyd2bzXvTkv/symKqQLI7PgeUwfrDY3kZUNWlf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758561099; c=relaxed/simple;
	bh=M+uzMYFznpcelmL6bFLZIlBwII0Rh3tn2rBrSHgYEPg=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=j/2TmQQlRfS+wuTyeXxBtoBY7/03lvyCQ9x3GaTmCK/lWBOIqjtXU4DKsGJdfL6UrNneWdcXS7CfmRhrzv3c+9PSEHtfHpsYmIH6x3JmGtxSkOjPG3kAnuRKVv/9IhSWIimFyNvWE5w1JYlDxDeyEpWOTV+VU/KZ1PD6htvXphE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YT1O4Y/p; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MEBfJH019166;
	Mon, 22 Sep 2025 17:11:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=uGUaih
	jrnrBVDmg75B1XmTax7n/b2o5zTsts9ts6UDA=; b=YT1O4Y/pux9UsIjnAnk8p2
	WFjOjAG0H7S2W1hcDzROFGp3hkDM0DcOHxqUE936BUw0iq3PpdfXCe3SYFRrcmwg
	aWGUpaAGZcQ724CqhOCfnyDE3ZDLH6g+HXhZLH6sk57pZ0GtdwEGaG9LN/lyeR08
	CCRRVqQfZR2AQ+dZ8zLIgjsC1BA9w4oz/D01HrEJgXPLlmNamVBFIbo+1siehLkd
	YvZOb3AzKsrv14P5UK5FIi3o+UoVMkLDbUElwD3WhW3QMLALjyYk4BOl01Cu/HKO
	AGl3pcN/hhN268uyaojY9eT1W2qRVM75sIivQPRwp8kR2/pRxNYaTgUp1iRCxoPg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499hpq46v5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 17:11:15 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58MHBF0m020602;
	Mon, 22 Sep 2025 17:11:15 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499hpq46v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 17:11:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58MFRRF4008777;
	Mon, 22 Sep 2025 17:11:14 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a6yxqc2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 17:11:14 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58MHBD2927001494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 17:11:14 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CDA5558058;
	Mon, 22 Sep 2025 17:11:13 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25C1858057;
	Mon, 22 Sep 2025 17:11:13 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.103.101])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Sep 2025 17:11:13 +0000 (GMT)
Message-ID: <9808ce35ea839c02aec4656bbbb9c01eaf1eb232.camel@linux.ibm.com>
Subject: Re: [PATCH v3] ima: don't clear IMA_DIGSIG flag when setting or
 removing non-IMA xattr
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
In-Reply-To: <20250915055524.2187783-1-coxu@redhat.com>
References: <20250902042515.759750-1-coxu@redhat.com>
	 <20250915055524.2187783-1-coxu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 22 Sep 2025 13:11:12 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-2.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FrEF/3rq c=1 sm=1 tr=0 ts=68d18333 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=20KFwNOVAAAA:8 a=WJBhaHD_QqhgIenamqsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ueQGuQpjQczE5407otwEgc_uEMWPKehD
X-Proofpoint-GUID: uRzp0SdF_LNjVasTM3neG87UcM6QygCd
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE5MDIyNCBTYWx0ZWRfX4Mc/eKXOTRgJ
 mZUIiNRHJ3Kg7Vjn6UAH/QlRfbBQuDyqNLtv0BoksyT88rxXtuNXuPze4CODpbYql9iAX7uSbcy
 +3REQ++0FimlteWkgg4xKTTsdI/1R2QaElLyRyDFVPUj8N8tfEoTkuOyUOkudxJZHCt0TjXUErY
 0WHjsksDC9adCS7dpcXZseJ/hI+T8lV4B1AxruSi5iCnxjWo6jCrTsJdHa+fkIDgWuBiMccLWMF
 TV5egJu+mvuWkMKtCXTqAV+4uAove2DrGbuZUvNlDYL+u2Vbmd+/KX7/JMDmU1fKxTJsb78Srkg
 54FB4kfutOkpnFB/GFUaH82ZyIZIOeI1PWlPUB/ejAB7py2/lt+hnFOT1lgVnQQeVpmJ0Z98hZM
 PfQGwdrS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_01,2025-09-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 clxscore=1015 impostorscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509190224

On Mon, 2025-09-15 at 13:55 +0800, Coiby Xu wrote:
> Currently when both IMA and EVM are in fix mode, the IMA signature will
> be reset to IMA hash if a program first stores IMA signature in
> security.ima and then writes/removes some other security xattr for the
> file.
>=20
> For example, on Fedora, after booting the kernel with "ima_appraise=3Dfix
> evm=3Dfix ima_policy=3Dappraise_tcb" and installing rpm-plugin-ima,
> installing/reinstalling a package will not make good reference IMA
> signature generated. Instead IMA hash is generated,
>=20
>     # getfattr -m - -d -e hex /usr/bin/bash
>     # file: usr/bin/bash
>     security.ima=3D0x0404...
>=20
> This happens because when setting security.selinux, the IMA_DIGSIG flag
> that had been set early was cleared. As a result, IMA hash is generated
> when the file is closed.
>=20
> Similarly, IMA signature can be cleared on file close after removing
> security xattr like security.evm or setting/removing ACL.
>=20
> Prevent replacing the IMA file signature with a file hash, by preventing
> the IMA_DIGSIG flag from being reset.
>=20
> Here's a minimal C reproducer which sets security.selinux as the last
> step which can also replaced by removing security.evm or setting ACL,
>=20
>     #include <stdio.h>
>     #include <sys/xattr.h>
>     #include <fcntl.h>
>     #include <unistd.h>
>     #include <string.h>
>     #include <stdlib.h>
>=20
>     int main() {
>         const char* file_path =3D "/usr/sbin/test_binary";
>         const char* hex_string =3D "030204d33204490066306402304";
>         int length =3D strlen(hex_string);
>         char* ima_attr_value;
>         int fd;
>=20
>         fd =3D open(file_path, O_WRONLY|O_CREAT|O_EXCL, 0644);
>         if (fd =3D=3D -1) {
>             perror("Error opening file");
>             return 1;
>         }
>=20
>         ima_attr_value =3D (char*)malloc(length / 2 );
>         for (int i =3D 0, j =3D 0; i < length; i +=3D 2, j++) {
>             sscanf(hex_string + i, "%2hhx", &ima_attr_value[j]);
>         }
>=20
>         if (fsetxattr(fd, "security.ima", ima_attr_value, length/2, 0) =
=3D=3D -1) {
>             perror("Error setting extended attribute");
>             close(fd);
>             return 1;
>         }
>=20
>         const char* selinux_value=3D "system_u:object_r:bin_t:s0";
>         if (fsetxattr(fd, "security.selinux", selinux_value, strlen(selin=
ux_value), 0) =3D=3D -1) {
>             perror("Error setting extended attribute");
>             close(fd);
>             return 1;
>         }
>=20
>         close(fd);
>=20
>         return 0;
>     }
>=20
> Signed-off-by: Coiby Xu <coxu@redhat.com>

Thanks, Coiby.  The patch is now queued in next-integrity.
> ---
>  security/integrity/ima/ima_appraise.c | 23 ++++++++++++++++++-----
>  1 file changed, 18 insertions(+), 5 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/i=
ma/ima_appraise.c
> index f435eff4667f..5149ff4fd50d 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -694,6 +694,15 @@ static int ima_protect_xattr(struct dentry *dentry, =
const char *xattr_name,
>  	return 0;
>  }
> =20
> +/*
> + * ima_reset_appraise_flags - reset ima_iint_cache flags
> + *
> + * @digsig: whether to clear/set IMA_DIGSIG flag, tristate values
> + *          0: clear IMA_DIGSIG
> + *          1: set IMA_DIGSIG
> + *         -1: don't change IMA_DIGSIG
> + *
> + */
>  static void ima_reset_appraise_flags(struct inode *inode, int digsig)
>  {
>  	struct ima_iint_cache *iint;
> @@ -706,9 +715,9 @@ static void ima_reset_appraise_flags(struct inode *in=
ode, int digsig)
>  		return;
>  	iint->measured_pcrs =3D 0;
>  	set_bit(IMA_CHANGE_XATTR, &iint->atomic_flags);
> -	if (digsig)
> +	if (digsig =3D=3D 1)
>  		set_bit(IMA_DIGSIG, &iint->atomic_flags);
> -	else
> +	else if (digsig =3D=3D 0)
>  		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
>  }
> =20
> @@ -794,6 +803,8 @@ static int ima_inode_setxattr(struct mnt_idmap *idmap=
, struct dentry *dentry,
>  		digsig =3D (xvalue->type =3D=3D EVM_IMA_XATTR_DIGSIG);
>  	} else if (!strcmp(xattr_name, XATTR_NAME_EVM) && xattr_value_len > 0) =
{
>  		digsig =3D (xvalue->type =3D=3D EVM_XATTR_PORTABLE_DIGSIG);
> +	} else {
> +		digsig =3D -1;
>  	}
>  	if (result =3D=3D 1 || evm_revalidate_status(xattr_name)) {
>  		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
> @@ -807,7 +818,7 @@ static int ima_inode_set_acl(struct mnt_idmap *idmap,=
 struct dentry *dentry,
>  			     const char *acl_name, struct posix_acl *kacl)
>  {
>  	if (evm_revalidate_status(acl_name))
> -		ima_reset_appraise_flags(d_backing_inode(dentry), 0);
> +		ima_reset_appraise_flags(d_backing_inode(dentry), -1);
> =20
>  	return 0;
>  }
> @@ -815,11 +826,13 @@ static int ima_inode_set_acl(struct mnt_idmap *idma=
p, struct dentry *dentry,
>  static int ima_inode_removexattr(struct mnt_idmap *idmap, struct dentry =
*dentry,
>  				 const char *xattr_name)
>  {
> -	int result;
> +	int result, digsig =3D -1;
> =20
>  	result =3D ima_protect_xattr(dentry, xattr_name, NULL, 0);
>  	if (result =3D=3D 1 || evm_revalidate_status(xattr_name)) {
> -		ima_reset_appraise_flags(d_backing_inode(dentry), 0);
> +		if (!strcmp(xattr_name, XATTR_NAME_IMA))
> +			digsig =3D 0;
> +		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);
>  		if (result =3D=3D 1)
>  			result =3D 0;
>  	}
>=20
> base-commit: 7aac71907bdea16e2754a782b9d9155449a9d49d


