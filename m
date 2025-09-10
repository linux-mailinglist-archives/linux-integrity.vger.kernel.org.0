Return-Path: <linux-integrity+bounces-7045-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CF0B516B7
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Sep 2025 14:21:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 198CD174570
	for <lists+linux-integrity@lfdr.de>; Wed, 10 Sep 2025 12:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68E2318152;
	Wed, 10 Sep 2025 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U2v3S3Jf"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD41314B91;
	Wed, 10 Sep 2025 12:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757506887; cv=none; b=gI+BO+uKZQRaJcmd6l/Y79ZAL/cERwBb9D6Lr4nRQY8PCrHyTDYhrqV6F6l8ozG9NBXFZTye2ZUv6vTPXxxyJlXiO4zbiOOcE7Ydaw72buVsgaBHpb164dps/LKs92wlDNP6+Po+hppy04zmFPWjsimCJd6Ei5YprSo7VtgkVJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757506887; c=relaxed/simple;
	bh=7wuC/HcaHF4I9pw2yi2x2cypDzYc5KuP2H8+jUJFos0=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=TbwkN8Xfrc6dtjAGcYmPfbHoXzI3rWHGEvXTqmwf9qaXnWB2O4ZMt9BUzqJqUFT3uriPpHQaZGlzRvXvTjeGTHvri4ZqAEVl5LcWiBi+k0hDFeawGORg4LRysEVXvYeDpHx8kh43QnE85LExjrPFGXxVsrqdeBp3nPdQdPQDY9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U2v3S3Jf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58A5XvAO010958;
	Wed, 10 Sep 2025 12:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Wm6ObA
	UM6Ra3mXu/iqfiRZqi8eQvB5Kjt46I3ybPgFg=; b=U2v3S3Jf1prJE37+yXTAIN
	8YMyOu3bCdPVYGDhFJpaLn6HaffIEqchbUDounTYld7nriEG6ddSNWJfgEtcIHUZ
	RhlA9k3toeEouzplngrMqkpRK3h7iLMbiBO+OPahBtFX5OyD1YXd5fV5d5vftDuB
	R2iKmeHNdNGAeShkaT2Arjq1WFYoybIv+MtFfnZ29z74XKw93NKQ3VXLkCqh1Ojg
	PvhRToPFXrdUCf8n+QROc0Es2bG4ZfBJ3yGwDLSCsiqeVRfOE8Xvio5ecAkPT/Rp
	O7cISBrikJmNNQg6yKLcD48jI7S4D6lYsCpo8FuM0YBM8wQH6IPYbGOlWOAoVsIQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cffe1dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 12:21:07 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58AC98kx027958;
	Wed, 10 Sep 2025 12:21:07 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 490cffe1dq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 12:21:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58A9jXoc007895;
	Wed, 10 Sep 2025 12:21:05 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49109prcdp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Sep 2025 12:21:05 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58ACL4K063701434
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Sep 2025 12:21:05 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D72BD58055;
	Wed, 10 Sep 2025 12:21:04 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F04A58043;
	Wed, 10 Sep 2025 12:21:04 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.153.78])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Sep 2025 12:21:04 +0000 (GMT)
Message-ID: <7790048d4dc468792b428e80ceae7261a97a896d.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ima: don't clear IMA_DIGSIG flag when setting
 non-IMA xattr
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
In-Reply-To: <20250908105825.1573222-1-coxu@redhat.com>
References: <20250902042515.759750-1-coxu@redhat.com>
	 <20250908105825.1573222-1-coxu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Sep 2025 08:21:03 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0Cf5JexUbD-23jt0wWvf_SJE434MYWJl
X-Proofpoint-GUID: -J3YCBMJ7QEUXFeZnVOB-pW-7jAWt6z-
X-Authority-Analysis: v=2.4 cv=EYDIQOmC c=1 sm=1 tr=0 ts=68c16d33 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=20KFwNOVAAAA:8 a=910HjdCciHtYCj_r2X8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMCBTYWx0ZWRfX9N7Iozi70nie
 SlcTkSD6poG6xGkBGkVvlkH/zUQN+GIHT9LN8lzMiFlqgKCE86t8+NarM5TTNDnxOyNwUJtaM1W
 03RmcKoOTO7nqwKAGdMlxEQa5zdxNG3K/irXEmpIkHlg6005h7FuNmnqYYTK7qd+ATIOHLYELZ6
 cC5va5jDa7W/g1TOM+TKYxZ5Fbbejcy5BWL7IfYQqQYSfu06lWL023EAK79x0HMfeyGn/RKUeYy
 k4YMcpPVIoNPv++ZVJYQgmIennDg/5oG47JR/UBRsKUrUIdQOvsMBDP+UFOitqhHPDKqWYxz0FC
 4CM4lCRvpxIx3Dcbex6D+13jvmwmz6LBtvPjsENQ2ym5ukpvqVv6PQQbnN7Go5lD0LWs9+3aQXS
 Td5f6kFD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-10_01,2025-09-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0 impostorscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060020

On Mon, 2025-09-08 at 18:58 +0800, Coiby Xu wrote:
> Currently when both IMA and EVM are in fix mode, the IMA signature will
> be reset to IMA hash if a program first stores IMA signature in
> security.ima and then sets security.selinux for a file.

The problem description should be generic.

-> and then writes some other security xattr for the file.

Start a new paragraph here for the example.
> For example, on
> Fedora, after booting the kernel with "ima_appraise=3Dfix evm=3Dfix
> ima_policy=3Dappraise_tcb" and installing rpm-plugin-ima, reinstalling a
> package will not make good reference IMA signature generated. Instead
> IMA hash is generated,
>     # getfattr -m - -d -e hex /usr/bin/bash
>     # file: usr/bin/bash
>     security.ima=3D0x0404...
>=20
> This happens because when setting selinux.selinux, the IMA_DIGSIG flag
> that had been set early was cleared. As a result, IMA hash is generated
> when the file is closed.

Start a new paragraph here, adding a sentence describing the solution to th=
e
problem. For example,

Prevent replacing the IMA file signature with a file hash, by preventing th=
e
IMA_DIGSIG flag from being reset.

>=20
> Here's a minimal C reproducer,
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

Thanks, Coiby.  The updated patch looks good.  Have you looked at the other
calls to ima_reset_appraise_flags() to make sure they don't need to be adju=
sted?

thanks,

Mimi

> ---
>  security/integrity/ima/ima_appraise.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
>=20
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/i=
ma/ima_appraise.c
> index f435eff4667f..4e4750ea41ad 100644
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


