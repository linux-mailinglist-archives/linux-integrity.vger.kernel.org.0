Return-Path: <linux-integrity+bounces-2417-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 350FB8C65DC
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2024 13:38:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381201C208F5
	for <lists+linux-integrity@lfdr.de>; Wed, 15 May 2024 11:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049D814AB4;
	Wed, 15 May 2024 11:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jkbIRIYw"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21975101C8
	for <linux-integrity@vger.kernel.org>; Wed, 15 May 2024 11:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715773110; cv=none; b=TQZI8OPhdobch6ytJX12Cuj/13Mtf2LBaWlN8nu84IHxcXHNFp7Np0lxpvyqYdyRReY23WeQ0ly6y5NoAqsibFbAzarXa8UyX5gj3S1uLRXdVWUIczU6xquqIhygLruUfNGaiJSgYofay7z1tcecoT/BalCT7tqZvLfpXFALfYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715773110; c=relaxed/simple;
	bh=+B0w/o7yTjZrqBN8DhZmltvH1d9+dlMi0ttqbQo67tg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Mime-Version; b=czLiMBT+SXGA76WHCKNpVCsmLSL4o+KFX9oq3cX+xtksHQvw/LLhPq7y7F5QVX6rSu9TI4XBMrrPTQGkilOpex53lmBhSYukqAIO5J2JF0cxK3HtCycsywmGEAua+QU+b0xXNKYtIOA+ugW6AH5/jI+XeFzvLN7QFq0IHlfvrgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jkbIRIYw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44FBRicT012997;
	Wed, 15 May 2024 11:38:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=nrcd5VDPfh4qdtrZ+onxcl9Cuuy5S1JXHvIoN5QUxck=;
 b=jkbIRIYwZYWxs24KkslmXJLLvXagnq7cxUfwCiMBVc//qH0Jm4LM48PxlQQWVndV/kCk
 DDGR+wqUad3CHowY7iBo4JJVmFgMME70uSU325X+4TKCnKelAm3TjKJ2VhcKyt6Kllaz
 ahgosVDik2Fz3a/5MFYh4W/GtFuHLBffugEEqEqhwqJAsrpdexjXHbgtgChaZuWYt4/n
 asAAq/F1sS4GAb45Y73JcARxB/28iltyvD4e+PCM3gbwUCdRm10jBzE38Wj2Wnn3+qB6
 OYQOIZ7/qIUqduR/EbYs0o1H6wiQ56qFN6I1ARC0B8QE4JKLAwaqzeP1/V0Swpqm2bkd iw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y4v6j80qg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 11:38:17 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44F8PRkk002257;
	Wed, 15 May 2024 11:38:16 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2m0pbb2p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 11:38:16 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44FBcDNG34799892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 11:38:15 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71B3A58052;
	Wed, 15 May 2024 11:38:13 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 29F1058065;
	Wed, 15 May 2024 11:38:13 +0000 (GMT)
Received: from li-5cd3c5cc-21f9-11b2-a85c-a4381f30c2f3.ibm.com (unknown [9.61.158.76])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 May 2024 11:38:13 +0000 (GMT)
Message-ID: <30a81894f2397c353aeae91c7237a4373e3d8cfe.camel@linux.ibm.com>
Subject: Re: [ima-evm-utils PATCH 0/2] Fix issue with tests and provider on
 Ubuntu 24.04
From: Mimi Zohar <zohar@linux.ibm.com>
To: Stefan Berger <stefanb@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: roberto.sassu@huawei.com
Date: Wed, 15 May 2024 07:38:12 -0400
In-Reply-To: <20240514182300.92440-1-stefanb@linux.ibm.com>
References: <20240514182300.92440-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-25.el8_9) 
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SicvTxqJZuoB3V5PqKQFj_5OmxBocjiL
X-Proofpoint-ORIG-GUID: SicvTxqJZuoB3V5PqKQFj_5OmxBocjiL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_06,2024-05-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 malwarescore=0
 adultscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=939 clxscore=1011
 spamscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405150080

On Tue, 2024-05-14 at 14:22 -0400, Stefan Berger wrote:
> The 1st patch fixes an issue on Ubuntu 24.04 due to which an OpenSSL
> provider could not be used.
> 
> The 2nd patch passes --engine pkcs11 or --provider pkcs11 options via
> EVNCTL_ENGINE variable so that the proper values are used on the command
> line for a pkcs11 test case evmctl.
> 
> Regards,
>    Stefan
> 
> Stefan Berger (2):
>   evmctl: Replace OSS_PROVIDER_load with OSSL_PROVIDER_try_load (Ubuntu)
>   tests: Use EVMCTL_ENGINE to set engine or provider for test case

Thanks, Stefan.  Both patches are now queued.

Mimi


