Return-Path: <linux-integrity+bounces-7020-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CF1B44BAF
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Sep 2025 04:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DCED1B2458C
	for <lists+linux-integrity@lfdr.de>; Fri,  5 Sep 2025 02:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED992628C;
	Fri,  5 Sep 2025 02:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qANFTdRG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73555CA5E;
	Fri,  5 Sep 2025 02:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757040130; cv=none; b=YgbR5aXAJTvFYqZHWzWYjBzk8b4fSIOVdair5aRPVB3NomH4lp8fshS5p8fff4AUQ6J3OnnNAy2HprKQz2BTU5ujG9G8EYwCOKzxtIotmWkGNXgM8pH8dTFalY3yMTk+QWyLA4YySXV2dA+Oj8MV7sUz032jctHYHGEpcPsOHgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757040130; c=relaxed/simple;
	bh=2AVLQ+dlpLT9oz+xqhHu3hF8wKHX+qMqz/UApyvNYl0=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=jQEVdFyqMest4YG20NGUKaKeU5gwAGM58aLKppQIplq6jTWmpfXziLhg0Lvtw9WzQl8dgeiumt5Il6FKtLqGl6ZXyUCEk0J8wK/38a87smJmxyDlXZRtRuxzP/UE1zXhvOa5wQBGTnXed3jHPTV2u8xM3T0LuVllbmV1gDTzoWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qANFTdRG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58522Iqp012837;
	Fri, 5 Sep 2025 02:41:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2RCveh
	g54PQFt5qK9XI3+cLpnUwfVm7HuHLknje3RyI=; b=qANFTdRGPs3rdt479PLYQ/
	Zs8OLn1lvXNiIiDysQCBDfo97SSGP+rQxVNm/vlhSX1M3/4wOeL7udgcGSoBU3Ks
	+weA+rURpIV70a6d4DpoklwNzK8UMEMatwhQH0jWdGi940Jhg+kclHjof/Q5z00+
	PLbwo1VBnTmF5qFG9GD/8pUc6w+uh2dxiKt9jYT+3hg9wyttS6GWXGusAe14nJTb
	bXYSS4Ad8YVASD0VHCmCfCivDGW4v2COEbpTWJjADklrOx4k+3Yi+3W+LxmzxOBB
	zbuAcPpTwBhRIrGFBCEB8U86LLYHEbEnG0KCVDtiCQlZHyxnUZvJpOIM8UpKiRGQ
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48uswdnvpp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 02:41:47 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5852fkt6017392;
	Fri, 5 Sep 2025 02:41:46 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48uswdnvph-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 02:41:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 584NWheH019412;
	Fri, 5 Sep 2025 02:41:45 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vd4n7cc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 05 Sep 2025 02:41:45 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5852fiph32965296
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Sep 2025 02:41:44 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 45B0A58050;
	Fri,  5 Sep 2025 02:41:44 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 375C058052;
	Fri,  5 Sep 2025 02:41:43 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.93.44])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  5 Sep 2025 02:41:43 +0000 (GMT)
Message-ID: <d252b04934908e7e65a3299bfeffc282c7b0b12f.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: don't clear IMA_DIGSIG flag when setting non-IMA
 xattr
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
In-Reply-To: <20250902042515.759750-1-coxu@redhat.com>
References: <20250902042515.759750-1-coxu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Sep 2025 22:41:42 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PeP/hjhd c=1 sm=1 tr=0 ts=68ba4deb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=20KFwNOVAAAA:8 a=hiVKoCch6JRLWrWsl2YA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzNCBTYWx0ZWRfX71SIbWj7OgA2
 pd2YFqZxTSsBbUb6Qde7jdMj3DElAuK0chF5aykOnkGVY1C//4Az+NAE6OplW5KhuadBALJVZZH
 IAnM4x4OPn1JgXRqTGDKmzPY2xIb3Bn7rqqk+xsbeSlilaQZFbZAmnQNaP2UAOGdj+Jm/UWGyJF
 V5POErVAy64I8gKnDzO/GsAsmaaKMaljOPk6Wha/A/Tm6BbqDa7gVEMDuMtT9Qe6V1UJvX1ZIZE
 /1TXSYNln3d1AUrJHfdBbsCd4U2ihAWpvGQgNI0TdrpXOP1TaQx+VUBSo9okZlqlu/kCFRO+BY+
 4dSkarNkDtIBcWMAcDyIQN6HaEybpvmoKL+b7HGzBzPEro6kaWjkuYuGpmougA4pDZjj6N3nt8j
 L+izyEOn
X-Proofpoint-GUID: ADG9MaJ5cc-KcmW_t7i7V4AF2u4bUkKz
X-Proofpoint-ORIG-GUID: JKzzpldWwSKmBwtws2qrmRzTrDpb5l5m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-05_01,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0
 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2508300034

On Tue, 2025-09-02 at 12:25 +0800, Coiby Xu wrote:
> Currently when both IMA and EVM are in fix mode, the IMA signature will
> be reset to IMA hash if a program first stores IMA signature in
> security.ima and then sets security.selinux for a file. For example, on
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

Thanks, Coiby.  Agreed, the ability to clear the IMA_DIGSIG flag should be
limited to security.ima xattr and probably security.evm xattr.  Writing oth=
er
security xattrs should not affect the IMA_DIGSIG flag.

Even without an IMA appraise policy, the security xattrs are written out to=
 the
filesystem, but the IMA_DIGSIG flag is not cached.

Please document the tristate values:
0: clear IMA_DIGSIG
1: set IMA_DIGSIG
-1: don't change IMA_DIGSIG

> ---
>  security/integrity/ima/ima_appraise.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/i=
ma/ima_appraise.c
> index f435eff4667f..fc82161f8b30 100644
> --- a/security/integrity/ima/ima_appraise.c
> +++ b/security/integrity/ima/ima_appraise.c
> @@ -708,7 +708,7 @@ static void ima_reset_appraise_flags(struct inode *in=
ode, int digsig)
>  	set_bit(IMA_CHANGE_XATTR, &iint->atomic_flags);
>  	if (digsig)
>  		set_bit(IMA_DIGSIG, &iint->atomic_flags);

This matches both -1 and 1.  Test "digsig =3D=3D 1" here.

> -	else
> +	else if (digsig !=3D -1)

and test "digsig =3D=3D 0" here.

>  		clear_bit(IMA_DIGSIG, &iint->atomic_flags);
>  }
> =20
> @@ -794,6 +794,8 @@ static int ima_inode_setxattr(struct mnt_idmap *idmap=
, struct dentry *dentry,
>  		digsig =3D (xvalue->type =3D=3D EVM_IMA_XATTR_DIGSIG);
>  	} else if (!strcmp(xattr_name, XATTR_NAME_EVM) && xattr_value_len > 0) =
{
>  		digsig =3D (xvalue->type =3D=3D EVM_XATTR_PORTABLE_DIGSIG);
> +	} else if (result !=3D 1) {

The "if (result !=3D 1)" test is redundant.

thanks,

Mimi

> +		digsig =3D -1;
>  	}
>  	if (result =3D=3D 1 || evm_revalidate_status(xattr_name)) {
>  		ima_reset_appraise_flags(d_backing_inode(dentry), digsig);


