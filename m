Return-Path: <linux-integrity+bounces-3777-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34311997AF0
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Oct 2024 05:00:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D25D31F21292
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Oct 2024 03:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AD1B18F2FF;
	Thu, 10 Oct 2024 03:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IjLIvnyK"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FCE11922FA;
	Thu, 10 Oct 2024 03:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728529235; cv=none; b=oBTJ7czlyT4Neuyt9P6VBlXupuePlGusPRmCdP/qSSSWLYWy+SiFsgLGHYuzB8VXA4y+vv09uFHQJ3wuvKSnByy0uSIMxbxKxgByz7KTAWiSV7zKGoxyCrQDIDPZtOVN0Gdiz6X2ddTYl9ujdkcdyXJKm06YQA1WZcoZ3xDcqeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728529235; c=relaxed/simple;
	bh=MnrLU7z2fHrTe3oR54L+g1X9kZ/IjoihrAiAYKbbqEo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DmJNsC2b0nCsobzQ1/x4Y3X/EjlnLFK6chInhT+74i1MlKgJVx3OadpGgJDyYDreE8iEzdEjFzexCI0uytxp1h/6eYUmvc4Kbv0Dt0Z7ZouBfcZHEfDlIAYw9KfhDyHuG5bgaeHkTSA/Vt485ekTg2+33FdtQRAatp9b3XnJn4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IjLIvnyK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49A0TBrv021183;
	Thu, 10 Oct 2024 03:00:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	5BC4w+RoOgjvSGYx83JC+eqKZkpQCHleyGaGN22MBdA=; b=IjLIvnyKp7RvMD96
	1d+CXBmio06XwTf8k+0uCJlgcaVpYrglAXxTkHnOEXBsgPI1vCMfJ9Xtne3RIWgE
	lhivaeFOK1un4YXzyWrBfAL6GQMcSijjl+yYp3W9FTmS8YrukHUJiq1tyxb8YkF9
	9gvgrx1GANhh0GajBVqlS7aaUciK0NY0d23R1jePmDg+FNxcAjE2t8bAHE4HGhQA
	P/13Fg6AJO5YRcqc/9dVYt9Pr5bedJIEFiv/EJfvUDm3BGe+STFCywWABHiLfspF
	5jzqh927+MB4QMQKgqqo5mhV00I6ZzuFLbjdunDCHkVWUWUWhceAldqwGwP6cpnH
	VqNdQw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4264dv8fq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 03:00:15 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49A30FnC027889;
	Thu, 10 Oct 2024 03:00:15 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4264dv8fq0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 03:00:15 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49A0jrPQ011516;
	Thu, 10 Oct 2024 03:00:13 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423g5xwhxy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 03:00:13 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49A30DXq48300376
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 03:00:13 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7989C5805C;
	Thu, 10 Oct 2024 03:00:13 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BFC25805A;
	Thu, 10 Oct 2024 03:00:12 +0000 (GMT)
Received: from li-43857255-d5e6-4659-90f1-fc5cee4750ad.ibm.com (unknown [9.61.45.194])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 10 Oct 2024 03:00:12 +0000 (GMT)
Message-ID: <451b428e61c508305f28438ebeb97cb4dd7401ca.camel@linux.ibm.com>
Subject: Re: [PATCH][next] integrity: Use static_assert() to check struct
 sizes
From: Mimi Zohar <zohar@linux.ibm.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Roberto Sassu
 <roberto.sassu@huawei.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Date: Wed, 09 Oct 2024 23:00:11 -0400
In-Reply-To: <ZrVBC9dGwukjfhet@cute>
References: <ZrVBC9dGwukjfhet@cute>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4iLvXDPnycY9Mj_ygct8LyzuPW0Atc-Z
X-Proofpoint-ORIG-GUID: uhROfs-kJ5R7fQucufBWMRihBKh6JpOC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_23,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0 clxscore=1011
 phishscore=0 priorityscore=1501 spamscore=0 malwarescore=0 mlxlogscore=793
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410100017

On Thu, 2024-08-08 at 16:04 -0600, Gustavo A. R. Silva wrote:
> Commit 38aa3f5ac6d2 ("integrity: Avoid -Wflex-array-member-not-at-end
> warnings") introduced tagged `struct evm_ima_xattr_data_hdr` and
> `struct ima_digest_data_hdr`. We want to ensure that when new members
> need to be added to the flexible structures, they are always included
> within these tagged structs.
>=20
> So, we use `static_assert()` to ensure that the memory layout for
> both the flexible structure and the tagged struct is the same after
> any changes.
>=20
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Sorry for the delay.  It's now queued in next-integrity.

thanks,

Mimi


