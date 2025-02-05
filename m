Return-Path: <linux-integrity+bounces-4724-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CD8A28241
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Feb 2025 03:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2FF43A5372
	for <lists+linux-integrity@lfdr.de>; Wed,  5 Feb 2025 02:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD9D212B0A;
	Wed,  5 Feb 2025 02:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U2m9dvnj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5674A25A65E;
	Wed,  5 Feb 2025 02:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738724392; cv=none; b=oqmkYQ2Yc3Iy+YPJgOVjpjeYrYyBcxDQX3aDs0pwtiv6ApqRXv9brujUtJZpJvNF39HacuOn+w0RFwpbNSJKVGGqw3dz252wB27sIPtpIPlsxrN3xSaX1v0S7r7CEztLd9QZ525ETT6P4Pf4T46A6zeujXgB8QJnLNvKRVwo3EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738724392; c=relaxed/simple;
	bh=sYStc87QTwMl+FVwFU1qW0OH7vOKR/8Sy0De2ETxsaI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pUwNx888Lj98PHb1W6+1+4tQbOVJgIUReUgbaEtxbHoYOIr5RmVDsZor2wR+r3WrsfXKUMfsIG0EIfrRJwLN5YmYacskshZHqwXvaUQXwPqfzCibtqgETB5rSaj7S2i6idZ7XghEEM/2QaM7IiC7mDTlJyat/j9zWFA3/Qa/KuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U2m9dvnj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51519CkT014189;
	Wed, 5 Feb 2025 02:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sYStc8
	7QTwMl+FVwFU1qW0OH7vOKR/8Sy0De2ETxsaI=; b=U2m9dvnjnWWMtijqNsFgsW
	+1IEm39Uoe9BWxP66AitJhRdLDZP/5TY/mxUj5TjMPA6UZfl6tPG62oS1Z4mJTLU
	ZtpD+qSRTCknzHQUtBPXLBKErWi5gKBQtMiTgj0tA7lkI5K1pNZkd570okL949AR
	u4DUsqwL7ierb+0ccDksl0f3BpMEFV8MMJHwPEJkOF+YFgDVRF5ELy9n0p9p6HC0
	vum8uC+0gYRAXcygc8YY6jsV9pd/FSK3BBAcuiHNVdA6lDE/szny8HIHZM3o9vOr
	qujXPjUkyLFHdLkPpjU9z5iBfb0Sjgvd3TFOH+T+UN68vM+l4QgLbwm1mmzWH+kw
	==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kx29gc1s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 02:59:34 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 5152xY5o014989;
	Wed, 5 Feb 2025 02:59:34 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44kx29gc1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 02:59:34 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5151Nwdn005258;
	Wed, 5 Feb 2025 02:59:33 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44j05jxeq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Feb 2025 02:59:33 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5152xVjZ30999180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Feb 2025 02:59:31 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1109C58056;
	Wed,  5 Feb 2025 02:59:32 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5FDC45803F;
	Wed,  5 Feb 2025 02:59:31 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.30.140])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Feb 2025 02:59:31 +0000 (GMT)
Message-ID: <bbfce282a00854c220eddb1ffcde7c6d839efe5e.camel@linux.ibm.com>
Subject: Re: [PATCH] ima: Reset IMA_NONACTION_RULE_FLAGS after post_setattr
From: Mimi Zohar <zohar@linux.ibm.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, dmitry.kasatkin@gmail.com,
        eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>,
        stable@vger.kernel.org
Date: Tue, 04 Feb 2025 21:59:31 -0500
In-Reply-To: <20250204125720.1326257-1-roberto.sassu@huaweicloud.com>
References: <20250204125720.1326257-1-roberto.sassu@huaweicloud.com>
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
X-Proofpoint-GUID: i8FWhhR1o8ynWsjyfh7__tbe3wZ8RFTz
X-Proofpoint-ORIG-GUID: JAxLJEhDOO32DzSD8fPllQKo9naRWG3n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-05_01,2025-02-04_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502050019

On Tue, 2025-02-04 at 13:57 +0100, Roberto Sassu wrote:
> From: Roberto Sassu <roberto.sassu@huawei.com>
>=20
> Commit 0d73a55208e9 ("ima: re-introduce own integrity cache lock")
> mistakenly reverted the performance improvement introduced in commit
> 42a4c603198f0 ("ima: fix ima_inode_post_setattr"). The unused bit mask wa=
s
> subsequently removed by commit 11c60f23ed13 ("integrity: Remove unused
> macro IMA_ACTION_RULE_FLAGS").
>=20
> Restore the performance improvement by introducing the new mask
> IMA_NONACTION_RULE_FLAGS, equal to IMA_NONACTION_FLAGS without
> IMA_NEW_FILE, which is not a rule-specific flag.
>=20
> Finally, reset IMA_NONACTION_RULE_FLAGS instead of IMA_NONACTION_FLAGS in
> process_measurement(), if the IMA_CHANGE_ATTR atomic flag is set (after
> file metadata modification).
>=20
> With this patch, new files for which metadata were modified while they ar=
e
> still open, can be reopened before the last file close (when security.ima
> is written), since the IMA_NEW_FILE flag is not cleared anymore. Otherwis=
e,
> appraisal fails because security.ima is missing (files with IMA_NEW_FILE
> set are an exception).
>=20
> Cc: stable@vger.kernel.org=C2=A0# v4.16.x
> Fixes: 0d73a55208e9 ("ima: re-introduce own integrity cache lock")
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>

Thanks!

Mimi

