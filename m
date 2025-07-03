Return-Path: <linux-integrity+bounces-6598-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07CE1AF6740
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 03:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D283E480AC6
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 01:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2764A45009;
	Thu,  3 Jul 2025 01:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SxumQl2/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64FE624B26;
	Thu,  3 Jul 2025 01:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751506881; cv=none; b=CvZOwPW9dqKQw+cr58nYBZj7g0CnavJ233Y+Bq9RUxkj4+0/Pox2cBnpyrT2f4N2tnI7aZesa3VZXBwh6IturxwG5oNNlw1EYlxNTbKc8S7p7bn4wadN95ZYjDyJq0+ghBIC6nR883E5pzEA/ydQ0LyjNwqkXJ2YK2g1XLhrKT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751506881; c=relaxed/simple;
	bh=bYk+beEvyNSrtWe8TLCnuZ3Czg7guwJvIJTUr8dpyl8=;
	h=Message-ID:Subject:From:To:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=oRcwaIedq3WBb/7cnS0iOzOPsgknxgvIh5CMvTmxi8Mxn4QL/x2dYbOONsWlDzWhr2GVaLkEvaTm/Y5dEuJ8AJ9UzTr0YaiyHqZSglmq0o/no0nej3luA3aHGGYRcxFdVXbz9ZF6C7BYtjfT+e45Db1NxDK57FmpmL0yrea1tS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SxumQl2/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562GGrmp005007;
	Thu, 3 Jul 2025 01:40:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=R5PNGw
	dUeo1P2y29DTq2u13P0iKMarZk0BBQqNMHgXI=; b=SxumQl2/xHfsBe/esso+Ix
	hwYdBlOaiNP2LXYH92TcYFXdPAgyMNnAEyawWWg2h1oYOa1PQjKDTlKaAVCEUS3B
	GhjzuHKyAJvS106OYOBkOWSZrq1kVLqPuWS8tr7eqQcnWi6kG7AFxAxYYDtCEjK8
	30yvamMYiRRsaxkH0q7IKxjvEilF+ne+KFfX/rpypHSC5isC/kYAt5AM49wEq1W9
	Legh7XDcdDGApb215o/4lytx9Hvr49PojIGWZ8qW5R9oMPtfl2qXSJAxCIBGceOA
	jj/rhaYYU0V3zA7oMN2nVip4AMAD3D7gFErL/YATGVaL1pmbY3u5xDneMXCs8Qvg
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j5ttgtvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 01:40:55 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5631YCSK016241;
	Thu, 3 Jul 2025 01:40:55 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j5ttgtvu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 01:40:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 562MDsKr011823;
	Thu, 3 Jul 2025 01:40:54 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47jv7n2cen-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 01:40:54 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5631ermp30409432
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Jul 2025 01:40:53 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EBBF58052;
	Thu,  3 Jul 2025 01:40:53 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1E0B158050;
	Thu,  3 Jul 2025 01:40:52 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.102.8])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Jul 2025 01:40:52 +0000 (GMT)
Message-ID: <1a6cf2097487816e4b93890ad760f18fe750bd70.camel@linux.ibm.com>
Subject: Re: [PATCH] Revert "integrity: Do not load MOK and MOKx when
 secure boot be disabled"
From: Mimi Zohar <zohar@linux.ibm.com>
To: Lennart Poettering <mzxreary@0pointer.de>,
        Jarkko Sakkinen	
 <jarkko@kernel.org>,
        Roberto Sassu <roberto.sassu@huawei.com>,
        Dmitry
 Kasatkin	 <dmitry.kasatkin@gmail.com>,
        Eric Snowberg
 <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris
 <jmorris@namei.org>,
        "Serge E. Hallyn"	 <serge@hallyn.com>, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Lee,
 Chun-Yi" <joeyli.kernel@gmail.com>
In-Reply-To: <Z9wDxeRQPhTi1EIS@gardel-login>
References: <Z9wDxeRQPhTi1EIS@gardel-login>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Jul 2025 21:40:51 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: iXih6juvG1pOvD8zDxh_LayWe2zjWSgh
X-Authority-Analysis: v=2.4 cv=UtNjN/wB c=1 sm=1 tr=0 ts=6865dfa7 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=Aly7C2BPMCjRMeM9-aoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Ou1YQEP7s2rHaZnTt0poCHIdHxTm9rIN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDAwOCBTYWx0ZWRfX3a8f3jU1gpWl PH7I7voBC+vshsJccDRdBHsp1T0Cc3+8yK3oqRwmdvU3qQOa08m4WQC+nObPsfwCXIzkttyGOIr R+TrNI1bNtkIw0zJzdMOvWoEzfednqjW4ISc/eZPJz3YqhElQj2OIZmMHU9ALi8S61MJZ32gm8C
 6qRCuXTNOqU8b/E6vLNwvpiCp/QfD6GliwMgPCC0IBRVEg/32URcU1KcEQX46u5AGNtLcG15VeE WNqAm9NhqYtwBcmVkxQMGFurqmuKz4y9OeccIgA6fkV2nekxWJFUNrtGquD2riIuJHctHRGxPzz 39AmkDDtcQaKC5d2DF7T8KS/RyGk+dFg5yV4bY29/T0a18O54NyoY1x/hRcJfQZdr2220EBkE8g
 FkJ40jXU97fW/A8HOT71B+yk4GtZ/ssp67m3GFcLfYImjJSphChPrDwyzsaNxAzYo742NoZW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_01,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 priorityscore=1501 phishscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 impostorscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030008

On Thu, 2025-03-20 at 13:02 +0100, Lennart Poettering wrote:
> This reverts commit 92ad19559ea9a8ec6f158480934ae26ebfe2c14f.
>=20
> This original commit this reverts creates a strange situation: it
> ensures more restrictive behaviour if SecureBoot is off then when it
> is on, which is the opposite of what one would expect.
>=20
> Typically, one would expect that if SB is off the validation of
> resources during the pre-kernel and kernel initialization is less
> restrictive, not more restrictive. But this check turned the world on
> its head.

Hi Lennart,

I'm really sorry for the long delay ...

From an IMA perspective, the default is to only trust keys built into the k=
ernel
or certificates signed by the builtin keys and loaded onto the
.secondary_trusted_keys keyring.
                                                                           =
    =20
The ability of loading MOK keys onto the .machine keyring and linked to the
.secondary_trusted_keys keyring is an exception based on the assumption tha=
t
that there is a secure boot chain of trust.  Allowing untrusted keys onto o=
r
linked to the .secondary_trusted_keys keyring, would potentially allow load=
ing
code signing keys onto the IMA keyring signed by untrusted MOK keys.
                                                                           =
    =20
I was really hesitant to allow this exception of loading MOK keys onto the
.machine keyring in the first place.  I'm now even more concerned.
                                                                           =
    =20
This is not just an issue of being more or less restrictive, but of adding =
a new
integrity gap when one didn't exist previously.

Mimi


>=20
> I'd like to ask for this commit to be reverted. If SB is on all bets are
> off regarding integrity of boot loaders and stuff, hence it makes no
> sense to be restrictive here: you cannot regain integrity once you gave
> it up once, hence if all bets are off anyway we might as well import any
> Mok keys passed to us into the kernel keyring.
>=20
> Or to say this differently: if an attacker got control of the pre-kernel
> boot phase they might as well patch around in the firmware apis to make
> the kernel believe it is in SB mode even if it is not. Hence the check
> carries no value. It doesn't protect anything in any effective way.
>=20
> The reason i'd like this check to go is that I'd like a nice way to
> insert keys from pre-boot into into the kernel keyring for use with
> signed dm-verity, without requiring recompilation of the kernel, and
> without SB database games. i.e. i'd like to use a regular, signed
> distro kernel, and pass to it additional keys to insert into the
> kernel keyring in a reasonable way. The mok stuff would be great for that=
,
> except it all falls apart once SB is off.
>=20
> You might wonder what signed dm-verity gives me if I have SB off. If
> we authenticate the boot phase up to Linux userspace via TPM-based PCR
> policies (i.e. measured boot) we can be sure of the boot integrity
> without having to rely on SB. But then we'd still like to use
> dm-verity based code signing for userspace.
> ---
>  security/integrity/platform_certs/load_uefi.c | 5 -----
>  1 file changed, 5 deletions(-)
>=20
> diff --git a/security/integrity/platform_certs/load_uefi.c b/security/int=
egrity/platform_certs/load_uefi.c
> index d1fdd113450a..7783bcacd26c 100644
> --- a/security/integrity/platform_certs/load_uefi.c
> +++ b/security/integrity/platform_certs/load_uefi.c
> @@ -7,7 +7,6 @@
>  #include <linux/err.h>
>  #include <linux/efi.h>
>  #include <linux/slab.h>
> -#include <linux/ima.h>
>  #include <keys/asymmetric-type.h>
>  #include <keys/system_keyring.h>
>  #include "../integrity.h"
> @@ -211,10 +210,6 @@ static int __init load_uefi_certs(void)
>  		kfree(dbx);
>  	}
>=20
> -	/* the MOK/MOKx can not be trusted when secure boot is disabled */
> -	if (!arch_ima_get_secureboot())
> -		return 0;
> -
>  	mokx =3D get_cert_list(L"MokListXRT", &mok_var, &mokxsize, &status);
>  	if (!mokx) {
>  		if (status =3D=3D EFI_NOT_FOUND)
> --
> 2.48.1
>=20
>=20
> Lennart
>=20
> --
> Lennart Poettering, Berlin
>=20


