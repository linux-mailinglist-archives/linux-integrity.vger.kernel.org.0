Return-Path: <linux-integrity+bounces-4690-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE58A25F65
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Feb 2025 17:00:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52D0E1884A64
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Feb 2025 16:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93E2A1F37B8;
	Mon,  3 Feb 2025 16:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="O/xh1Quy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CFE202F9D
	for <linux-integrity@vger.kernel.org>; Mon,  3 Feb 2025 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738598431; cv=none; b=fpN8fyxr+QHdg/jTPZxXbu+WvulOj+CrhIpnS0wp+O4NCKkpaZrHuDAQW/TEZAetY5LS+subCgw0umIkVwG9Na/OSMd0rJ3gcgxA4auWM/A+BgU5uZcj+F1X+tmsMrTEPQuuUte3eMw6Vf2dEdkKiWqLYN9Dr3SVWT3DShyD0pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738598431; c=relaxed/simple;
	bh=Jt5WYlSWo3XoaS/SRHWq+MSJdJpcrSjdkxsAjiG6ruE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KzTnVA36xDsWeCZA7HlWXtHwO30Fnloj9uVUHU8613BMpu85xiD1RZB1JhseJ4f6iOUSxGZEzD5qTqaRuntSw+zOilmDjUpEPpRzyz7uKkNWZDaFEeOnGU3Tpvy1/gDwFIklRpxoqQydNlDcRKbVjGNxhjR+p47z+KeFg9oM+JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=O/xh1Quy; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5137Wq3l014520;
	Mon, 3 Feb 2025 16:00:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=mh1EaX
	CRk9gCrfTq0Sj0NtgEFMOXSC56emU6Jgqw4QQ=; b=O/xh1QuyxaFh3DJunZeda2
	qhne8iQYC9YDJZ3DrwZb2tFWdxqB4rDEaj/sBnYyrDIR7Dr9tb6LhUlSmGEmMQk0
	4VDfOy9QWtbum+3l/lQCN8CaQ2rBkc9TKNY3UbqQ5Eax5QYtiMiUwttAph7pWlcm
	xRQ/7pOKxeOE5ttRNdVtWIZwZMrwMFbHqNPOtnxZjtwM+a0wpgRPNmEttbRmd519
	HzsKqK8UzHliTAd4PaFkFS1vgC2krqIAnABr3MI1sn8el94P1v3R3mc63HpOOZ81
	T5cTRf9+rfxThdK+9za8vnWhzMNX2mNENVq3k9FMLmfkZmCEDVfUzR+kX6U+h/Hw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44jsgnja8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 16:00:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 513Fiket006535;
	Mon, 3 Feb 2025 16:00:21 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44hyek70pv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Feb 2025 16:00:21 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 513G0LDi28836560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Feb 2025 16:00:21 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15C085805C;
	Mon,  3 Feb 2025 16:00:21 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D01D658051;
	Mon,  3 Feb 2025 16:00:20 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.83.5])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Feb 2025 16:00:20 +0000 (GMT)
Message-ID: <19d67fb8887a2b322978a8901850587b0ac343b1.camel@linux.ibm.com>
Subject: Re: [PATCH v3 07/10] ima_setup.sh: Add digest index detection for
 ima-buf format
From: Mimi Zohar <zohar@linux.ibm.com>
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org
Date: Mon, 03 Feb 2025 11:00:20 -0500
In-Reply-To: <20250114112915.610297-8-pvorel@suse.cz>
References: <20250114112915.610297-1-pvorel@suse.cz>
	 <20250114112915.610297-8-pvorel@suse.cz>
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
X-Proofpoint-GUID: oeAhcrL5viRetUjl1IowcwHaUVyzHPkh
X-Proofpoint-ORIG-GUID: oeAhcrL5viRetUjl1IowcwHaUVyzHPkh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-03_07,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 phishscore=0
 mlxscore=0 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502030117

On Tue, 2025-01-14 at 12:29 +0100, Petr Vorel wrote:
> ima-buf format might be loaded via loading policy in the next commit.
>=20
> Signed-off-by: Petr Vorel <pvorel@suse.cz>


"ima-buf" is used in "[PATCH v3 05/10] IMA: Read required policy from file"=
.

Otherwise,=20
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
> =C2=A0testcases/kernel/security/integrity/ima/tests/ima_setup.sh | 2 +-
> =C2=A01 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> index af5584951c..1f01f18cf6 100644
> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> @@ -242,7 +242,7 @@ set_digest_index()
> =C2=A0	# parse digest index
> =C2=A0	# https://www.kernel.org/doc/html/latest/security/IMA-templates.ht=
ml#use
> =C2=A0	case "$template" in
> -	ima|ima-ng|ima-sig) DIGEST_INDEX=3D4 ;;
> +	ima|ima-buf|ima-ng|ima-sig) DIGEST_INDEX=3D4 ;;
> =C2=A0	*)
> =C2=A0		# using ima_template_fmt kernel parameter
> =C2=A0		local IFS=3D"|"


