Return-Path: <linux-integrity+bounces-4713-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75F2AA26907
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Feb 2025 01:51:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 010C93A52E2
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Feb 2025 00:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2CC13F434;
	Tue,  4 Feb 2025 00:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="JqzDLA8k"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958B1143C5D
	for <linux-integrity@vger.kernel.org>; Tue,  4 Feb 2025 00:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738630225; cv=none; b=JbLzw3ydZ7YgxcDqrZuxPv4pjkyBr9/SrsV65AlVlKxOeYD5RydwBw2EBetqe6S4bze32jIcYRzi+hqUAH5NdIAx1mQhgtzjiyomA5u/zP0cQtPb0wVF3IFzEKzvhbqJtgJcYX2ErBn4QksWSlxdYd6O+UHRRayWwZVQ5CAx+sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738630225; c=relaxed/simple;
	bh=iFD7h3eA60RTkB1tif+Q3mte1FUD/lUZQjV+uaohdwk=;
	h=Message-ID:Subject:From:To:Cc:In-Reply-To:References:Content-Type:
	 MIME-Version:Date; b=HU83jiZ6wiUGJ0sOXlDhKnoxnhqWs/Z30lArFx4aVpHVjZI4Z0LVazuznIRkBNl96gqMmF00cFrCCrHQODnf3Q9cTCpNUa/08koi3y+K0GbUhE0sJt4cvSwENsyGaILQBCKEWrMYgsoJYRIKNb3IyaKbCG4WreLI0/cqShTpp90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=JqzDLA8k; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 513MvaiK027290;
	Tue, 4 Feb 2025 00:50:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iFD7h3
	eA60RTkB1tif+Q3mte1FUD/lUZQjV+uaohdwk=; b=JqzDLA8kb8QTFeSl+MtUjh
	yZ24+8vdg4GjNbh35wfmQSfKSFeqmUoa9jq3pIy3yVy09tiUfPDqSBYleI8WIHGQ
	TQFPtJY9ALgAzm16UExvZ8kSkBZPqRTbP77QhR/B0tTkgG7ZSGMgTvSkD2uoGVbU
	kBq5j9HrZGCR0EnJY5dwrDZpUOS/fjVQD0kTzfdhjQnvuKQbf5kh9ZfUyBq39Zsy
	Upgwc05HT11S+XamWH0TKOZL5t0wvK9/FsDUi+0Lp9X0xdzo9tikxloFJxP/SMAP
	IX5sSf5Zrjbsq62WvRyt0SR5B5FIt47UAT/2f/2BXpeaQSMWqOkPJpIYMoIem1sA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jkv961ke-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 00:50:16 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 513NPWWD024635;
	Tue, 4 Feb 2025 00:50:15 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hxxn11p1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Feb 2025 00:50:15 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5140oFmI19923702
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Feb 2025 00:50:15 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E06A85806D;
	Tue,  4 Feb 2025 00:50:14 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E9E258068;
	Tue,  4 Feb 2025 00:50:14 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.18.96])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Feb 2025 00:50:14 +0000 (GMT)
Message-ID: <4e4fb197b7127f8d82705ec441e8a273cd237b7f.camel@linux.ibm.com>
Subject: Re: [PATCH] IMA: measure.policy: limit dont_measure tmpfs policy
 to func=FILE_CHECK
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org
In-Reply-To: <20250203210233.1407530-1-pvorel@suse.cz>
References: <20250203210233.1407530-1-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 03 Feb 2025 18:48:10 -0500
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OSMniuTFzQyC2Z-dKRU-m4GR0-1MMSrz
X-Proofpoint-ORIG-GUID: OSMniuTFzQyC2Z-dKRU-m4GR0-1MMSrz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_10,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 mlxscore=0 suspectscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502040002

On Mon, 2025-02-03 at 22:02 +0100, Petr Vorel wrote:
> add func=3DFILE_CHECK to dont_measure tmpfs
>=20
> Similarly to tcb.policy limit dont_measure tmpfs policy to func=3DFILE_CH=
ECK.
> This allows to do extra measurements, e.g. kexec boot command line, see
> kernel commit
>=20
> 7eef7c8bac9a ("ima: limit the builtin 'tcb' dont_measure tmpfs policy rul=
e")
>=20
> Also remove leading 0 from tmpfs magic (to match IMA docs and tcb.policy)=
.
>=20
> Suggested-by: Mimi Zohar <zohar@linux.ibm.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
> =C2=A0.../security/integrity/ima/datafiles/ima_policy/measure.policy=C2=
=A0 | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git
> a/testcases/kernel/security/integrity/ima/datafiles/ima_policy/measure.po=
licy
> b/testcases/kernel/security/integrity/ima/datafiles/ima_policy/measure.po=
licy
> index 9976ddf2de..8abd05fb1a 100644
> --- a/testcases/kernel/security/integrity/ima/datafiles/ima_policy/measur=
e.policy
> +++ b/testcases/kernel/security/integrity/ima/datafiles/ima_policy/measur=
e.policy
> @@ -8,7 +8,7 @@ dont_measure fsmagic=3D0x62656572
> =C2=A0# DEBUGFS_MAGIC
> =C2=A0dont_measure fsmagic=3D0x64626720
> =C2=A0# TMPFS_MAGIC
> -dont_measure fsmagic=3D0x01021994
> +dont_measure fsmagic=3D0x1021994 func=3DFILE_CHECK
> =C2=A0# SECURITYFS_MAGIC
> =C2=A0dont_measure fsmagic=3D0x73636673
> =C2=A0measure func=3DFILE_MMAP mask=3DMAY_EXEC


