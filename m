Return-Path: <linux-integrity+bounces-6597-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB459AF673B
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 03:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9FB1C415DD
	for <lists+linux-integrity@lfdr.de>; Thu,  3 Jul 2025 01:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FC8157E99;
	Thu,  3 Jul 2025 01:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b4L3lFIM"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8310F4400;
	Thu,  3 Jul 2025 01:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751506758; cv=none; b=FNVUPdLAGX0WmifOG3fLZ9xlA4/KqRjkj82oGyl64Lqhm/3B888nT9YrYtqIk+T5fAkE59Si6HOOq+RH6myykrIB1BUIikhAowwoURrxBAR8GZEQ1Inwv6rQTwyc1mJUE8p/L7fOxbyeJfUDEE5KY0Twdzzxo8lxOzGjvJCpq9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751506758; c=relaxed/simple;
	bh=Is9CT0Pk2pnhqnJf/3yGZr2STJU9K7oUXqy0zbJFcCI=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 Date:MIME-Version; b=Bu2SddXXvnxfTUogedp9CO0/OqjeEb12avRe3RV6/j7vrh6Iw7j27xJz/FcoYqgAHwo8ynB4TcnOYtSgM0eTztW50t0F2sYXkzryrGJc1e+ZyxgPlyefO4FWwrQb8Mp0Fl8FkIO7YUh9FhhYfYlbTQs2aq/ZKoTFUOypSOlmdd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b4L3lFIM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 562JEAxQ003793;
	Thu, 3 Jul 2025 01:38:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xgpVyo
	LPh9JdhYBwUjqBEZjWvAdIc2zVJFh7ZQkPLrQ=; b=b4L3lFIMHGyWmS95nHIWRl
	h9DRdGUb2nGcL/94yxLei0wURBf1o8sIkM2wWKH+Sw5cpfWPMCUi/PHLXNLxC2xH
	GBjP7tPOwggeK6mtiy2XMDP4TI9iVe3pUoZIViaZzyOOX57CVTDT+b+CoyHk6N7h
	0FQvKDHndXCoP/gzpvoNh/FsB70oEyg2nelcqHqKf4CYYWweKNDeupcieG6y1mtn
	Npb941m9Twm6vF/BYn8Z/VCcEiMvPERje11ZFtw0a1YQt/LSXOB7U9/rWL5EZGID
	kABh2ml9ah7UXaVybZkhO9Sx99QVwTwFR2ANXq4r2uE0o3TX0uSV3S0NRerwCALw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84dgwfs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 01:38:45 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5631YEmd000959;
	Thu, 3 Jul 2025 01:38:44 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47j84dgwfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 01:38:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 562MZRJ6006841;
	Thu, 3 Jul 2025 01:38:43 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47jvxmj8qq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Jul 2025 01:38:43 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5631cgPX24511054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 3 Jul 2025 01:38:42 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1B0458059;
	Thu,  3 Jul 2025 01:38:41 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C598C58058;
	Thu,  3 Jul 2025 01:38:39 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.102.8])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  3 Jul 2025 01:38:39 +0000 (GMT)
Message-ID: <eb91dcf034db28e457a4482faa397dd7632f00fd.camel@linux.ibm.com>
Subject: Re: [PATCH v2] integrity: Extract secure boot enquiry function out
 of IMA
From: Mimi Zohar <zohar@linux.ibm.com>
To: GONG Ruiqi <gongruiqi1@huawei.com>,
        Roberto Sassu
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Madhavan Srinivasan	
 <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Heiko
 Carstens	 <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander
 Gordeev	 <agordeev@linux.ibm.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
        Christophe Leroy	
 <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle
 <svens@linux.ibm.com>, "Lee, Chun-Yi" <jlee@suse.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, Lu Jialin <lujialin4@huawei.com>,
        Nayna Jain	
 <nayna@linux.ibm.com>
In-Reply-To: <20250628063251.321370-1-gongruiqi1@huawei.com>
References: <20250628063251.321370-1-gongruiqi1@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Jul 2025 21:38:39 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: AK6aKBga4oupROxNi37kIoTGk3q8-5S4
X-Proofpoint-GUID: uDLi-sImN3F6mgsunZuJI4XJFtTsseEO
X-Authority-Analysis: v=2.4 cv=Ib6HWXqa c=1 sm=1 tr=0 ts=6865df25 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=i0EeH86SAAAA:8 a=S3K_XBxPWrw5AGGlcUgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAzMDAwOCBTYWx0ZWRfXy2T4VTZGAdYP sUju6z4tCTzdEu3yCSnNzl9jOk3a4Ybp+UEyit+nsO1F3Rgn1K5leqHez3AipMUriRQ47LArP40 9BIqUj1y+Bwq3B6h56eZ8DCtsDqi+DKDsWMDAYm4+YLvPQsohUdOM06LkKYeK88Imwvhck9/FKo
 RqhPOZlG8YHqnt9HTM0wcWpofMPCBacYx0/fzrLe8sEh0fXC8+meVu/0kh2zeoxYclYP478kWTh sK9ePhL+SfXMtDKJaKxDGBhNzTab5Y2zo9cq55R3XU88nQ8TJSh4mTASDybyMK5UU67y0xVmxwQ ESS/8ZY/oYFc2rySDpumZmdXH5mBW1Ba2NXxmGHm4qkTbGVckU9hBrIXoqf43+N17w7NMatu3TU
 yJrPAtqTjqPi4XMtScNX9MOfw5mHsMbrSdiWPhSSMhgXCy4Rf4Z4bRb9sltJlp2H9t2Gt+qB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-03_01,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1011 mlxlogscore=691 lowpriorityscore=0 impostorscore=0
 mlxscore=0 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507030008

[CC: Nayna Jain]

On Sat, 2025-06-28 at 14:32 +0800, GONG Ruiqi wrote:
> Commit 92ad19559ea9 ("integrity: Do not load MOK and MOKx when secure
> boot be disabled") utilizes arch_ima_get_secureboot() to perform a
> secure boot status check before loading the Machine Owner Key (MOK).
> However, only when CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=3Dy can this
> function be functional, while this config has nothing to do with secure
> boot or MOK loading.
>=20
> Given that arch_ima_get_secureboot() is just a helper to retrieve info
> about secure boot via EFI and doesn't necessarily be a part of IMA,
> rename it to arch_integrity_get_secureboot(), decouple its functionality
> from IMA and extract it to be a integrity subsystem helper, so that both
> certificate loading and IMA can make use of it.
>=20
> Compile-tested on powerpc, s390 and x86, with CONFIG_IMA_ARCH_POLICY=3Dn
> and =3Dy based on defconfig and allmodconfig.
>=20
> Signed-off-by: GONG Ruiqi <gongruiqi1@huawei.com>

The original reason for querying the secure boot status of the system was i=
n
order to differentiate IMA policies.  Subsequently, the secure boot check w=
as
also added to safely allow loading of the certificates stored in MOK. So lo=
ading
IMA policies and the MOK certificates ARE dependent on the secure boot mode=
.
                                                                           =
    =20
What is your real motivation for moving the secure boot checking out of IMA=
?   =20
                                                                           =
    =20
FYI, there are a number of problems with the patch itself.  From a very hig=
h
level: =20
                                                                           =
    =20
- The EFI secure boot check is co-located with loading the architecture spe=
cific
policies.  By co-locating the secure boot check with loading the architectu=
re
specific IMA policies, there aren't any ifdef's in C code.  Please refer to=
 the
"conditional compilation" section in the kernel coding-style documentation =
on
avoiding ifdef's in C code.
                                                                           =
    =20
- Each architecture has it's own method of detecting secure boot. Originall=
y the
x86 code was in arch/x86, but to prevent code duplication it was moved to I=
MA.=20
The new file should at least be named efi_secureboot.c. =20
                                                                           =
    =20
- The patch title should be about moving and renaming the secure boot check=
.=20
The patch description should include a valid reason for the change.

Mimi & Nayna

