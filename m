Return-Path: <linux-integrity+bounces-4506-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5C929FF075
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Dec 2024 17:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 964FE161932
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Dec 2024 16:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA7186F30F;
	Tue, 31 Dec 2024 16:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lkxIBrgk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4331C683
	for <linux-integrity@vger.kernel.org>; Tue, 31 Dec 2024 16:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735660923; cv=none; b=dwVtZj5DPLvPyQhzkhdcMDUZNNobFFZsBaCu4tqSqBwkGGabPMfkLw9xmdZ9VeO4EiI83G2VVbvL8emu1DYhmMGAvxMpTwkVSEI/oCyBimaNErR55kYx3oiTlLvx1+m9QwvZT8LZBnOTlN6Mw8fzeNp5tKDH6wpwGFW6YF3PxfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735660923; c=relaxed/simple;
	bh=cdWWBD+210tsGLylTIXiLwBx6DbEBZhOUSD10YhtLOs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S+jMHQJze7X9vE96cGfzLkbBqfoi+I0gQA6dkXM9JExDx5umbxJ7GCG57FCW0MNWxaD0Zr1wm/TIniwe9+NzePX9Bnmo1VLP414pSy4Zq6xcnDjuMlTsvcuWtVsz0HzMkVjduVG1JcjF2oRnT7KmLOwFYPWk/cBsUT57NcdhQoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lkxIBrgk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BVDsaCf023925;
	Tue, 31 Dec 2024 16:01:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TU8HT3
	TnCYL9X+3v8zjQpaKU1mxtq8vYakq654PhsK0=; b=lkxIBrgk0AhILLpL4W+ucj
	Dojo1lfbP4K7G7TOAPuQUewlM+nAzTXcJvSpadH8cmHre1Esdk4vFp43EsmE+rFz
	R5Jq+X+i635F2ghOOnCZc5IpGP3BcDGAfajAqDDAop3zaDyD00FcvoYpX1CmS+4d
	KeEm5bhsXDgnEA37OxsVUcsoicVBdSHuaiv0Eop1x7mzGq0RD+lXK+L0KIM0OlWu
	mXRyvzZdIGDg5v30UZzUmuOzMjT0suqBkf+P7Cr2GR9p9aStUuSET2/sIcNH8Zof
	W9DyGPsDFiV+uDpiZ7svV/vXrKw3nLsK5LZOPvCICpmrvwTOs317hBm5GArqew+w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43v5nhaprk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Dec 2024 16:01:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4BVFCrop010215;
	Tue, 31 Dec 2024 16:01:54 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43tvnnaqkv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 31 Dec 2024 16:01:53 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4BVG1rAR16319176
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 31 Dec 2024 16:01:53 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A5205806F;
	Tue, 31 Dec 2024 16:01:53 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F00D058066;
	Tue, 31 Dec 2024 16:01:52 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.178.58])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 31 Dec 2024 16:01:52 +0000 (GMT)
Message-ID: <fa7b251e0b7966e9d32117996f4ae8390bc4f6cc.camel@linux.ibm.com>
Subject: Re: [PATCH v2 1/8] IMA: Add TCB policy as an example for
 ima_measurements.sh
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org
Date: Tue, 31 Dec 2024 11:01:52 -0500
In-Reply-To: <20241213222014.1580991-2-pvorel@suse.cz>
References: <20241213222014.1580991-1-pvorel@suse.cz>
	 <20241213222014.1580991-2-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2EeMxUkeY8pFf7_JC1UpSblQEpDVqzLe
X-Proofpoint-GUID: 2EeMxUkeY8pFf7_JC1UpSblQEpDVqzLe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 phishscore=0 mlxscore=0 malwarescore=0 mlxlogscore=999 impostorscore=0
 spamscore=0 priorityscore=1501 suspectscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412310135

Hi Petr,

On Fri, 2024-12-13 at 23:20 +0100, Petr Vorel wrote:
> Taken from IMA docs [1], removed dont_measure fsmagic=3D0x1021994 (tmpfs)
> as suggested by Mimi.
>=20
> [1] https://ima-doc.readthedocs.io/en/latest/ima-policy.html#ima-tcb
>=20
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

After thinking about it some more, anyone interested in constraining the
"measure func=3DFILE_CHECK" rules based on LSM labels to avoid integrity
violations would need to reboot the system anyway. [1]

For this reason, please include the new dont_measure tmpfs rule as proposed=
 in
"[PATCH] ima: limit the builtin 'tcb' dont_measure tmpfs policy rule". [2]

[1] Integrity violations -
https://ima-doc.readthedocs.io/en/latest/event-log-format.html#template-dat=
a-hash

[2]
https://lore.kernel.org/linux-integrity/20241230142333.1309623-2-zohar@linu=
x.ibm.com/

thanks,

Mimi

> ---
> I would like to check in ima_measurements.sh for this policy as an
> variant to ima_policy=3Dtcb command line parameter. Do I need to check fo=
r
> all of these (suppose all are in ima_policy=3Dtcb).
>=20
>  .../ima/datafiles/ima_measurements/tcb.policy | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 testcases/kernel/security/integrity/ima/datafiles/ima=
_measurements/tcb.policy
>=20
> diff --git a/testcases/kernel/security/integrity/ima/datafiles/ima_measur=
ements/tcb.policy b/testcases/kernel/security/integrity/ima/datafiles/ima_m=
easurements/tcb.policy
> new file mode 100644
> index 0000000000..1c919f7260
> --- /dev/null
> +++ b/testcases/kernel/security/integrity/ima/datafiles/ima_measurements/=
tcb.policy
> @@ -0,0 +1,19 @@
> +dont_measure fsmagic=3D0x9fa0
> +dont_measure fsmagic=3D0x62656572
> +dont_measure fsmagic=3D0x64626720
> +dont_measure fsmagic=3D0x1cd1
> +dont_measure fsmagic=3D0x42494e4d
> +dont_measure fsmagic=3D0x73636673
> +dont_measure fsmagic=3D0xf97cff8c
> +dont_measure fsmagic=3D0x43415d53
> +dont_measure fsmagic=3D0x27e0eb
> +dont_measure fsmagic=3D0x63677270
> +dont_measure fsmagic=3D0x6e736673
> +dont_measure fsmagic=3D0xde5e81e4
> +measure func=3DMMAP_CHECK mask=3DMAY_EXEC
> +measure func=3DBPRM_CHECK mask=3DMAY_EXEC
> +measure func=3DFILE_CHECK mask=3D^MAY_READ euid=3D0
> +measure func=3DFILE_CHECK mask=3D^MAY_READ uid=3D0
> +measure func=3DMODULE_CHECK
> +measure func=3DFIRMWARE_CHECK
> +measure func=3DPOLICY_CHECK


