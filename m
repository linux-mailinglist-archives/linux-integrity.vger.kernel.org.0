Return-Path: <linux-integrity+bounces-4931-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490DBA3DE7A
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 16:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 072C83BC8A6
	for <lists+linux-integrity@lfdr.de>; Thu, 20 Feb 2025 15:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081171D5CFB;
	Thu, 20 Feb 2025 15:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Tt2XKhX5"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E83761FCE
	for <linux-integrity@vger.kernel.org>; Thu, 20 Feb 2025 15:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740065090; cv=none; b=beSB+0PzB85d3Pch442Tgt69lX162QIdIsXItjamXU2Y+SGD+u8td7uKWIMJJKDEl8NIJwjAFNXrP9LLOe2MDsKEfsy/YrK6CC5d+VhvYJOg2n41GDeb27WGKhh5whUJSaUFQZIDLu2iJPMPQKgEnVohbxZNfznE1FL+qN2npuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740065090; c=relaxed/simple;
	bh=Z/3f9J1/v2u7QvVVirG2inJTS5NABOpE9rI6SUjWRAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B2rsj5aAvy6v4pS+egfFlGuPX7S4eeAWFtUk3HjwtzaPQbhRzn//KeXCqP2bhZd5FsbRqD6RRBhbUiBrM1AEEDV9zNeJaK4FGUB9eHANhH1nLWdUTBgLx0nrzk3J5lx1fm9K7eUOwtZRJefu3yJzq7+xbg8ps1z7+SJgV0EVpm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Tt2XKhX5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51K5Nm4W026526;
	Thu, 20 Feb 2025 15:24:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=8TEung
	8offz8ywyx4dV2JoztcS7W6omsuKnE0gpNPtM=; b=Tt2XKhX5ZE5ogcf710JPIA
	Ib0z/PFDRKkSCdlZCEFPC1KodrBC3K9YqE3Ni7CH2nWE8Q7auwTDfpiRMDaiZz1J
	hxmyb1lkWx7gB2VzOMywFcmrA4SdFiki1ljiWhNY46GWMfCNDeSvKaSUjZlD8LFa
	SrL+xY/XlFE5t53nnpFN6nOsT/dBUiWtzJFSoewuwScmCrBwiJJ4P1XZzHYR6yM7
	gD1CyKWvA36KCZUiiYJbjGmcuZ2jWO/PocxRStdU+b1Z6WMCOyMTlnszoUnZzm5T
	HrC9UHfHz5PkyQiLx0FejeOp0pvnHUaNtXr68nsT+Py+9D299M29IYodYJdubsSw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wx78ju2g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 15:24:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51KEepYm027095;
	Thu, 20 Feb 2025 15:24:36 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w025anx2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Feb 2025 15:24:36 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51KFOZMQ28311890
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 15:24:35 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57C6558059;
	Thu, 20 Feb 2025 15:24:35 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F3FD58055;
	Thu, 20 Feb 2025 15:24:35 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Feb 2025 15:24:34 +0000 (GMT)
Message-ID: <c7b2536d-2217-4f51-839b-23742bee9ea7@linux.ibm.com>
Date: Thu, 20 Feb 2025 10:24:34 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ima: limit the number of ToMToU integrity violations
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: roberto.sassu@huawei.com, Petr Vorel <pvorel@suse.cz>
References: <20250219162131.416719-1-zohar@linux.ibm.com>
 <20250219162131.416719-3-zohar@linux.ibm.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20250219162131.416719-3-zohar@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 6aewytiULTu-YNtjWn8WFa-cQVHcO88N
X-Proofpoint-ORIG-GUID: 6aewytiULTu-YNtjWn8WFa-cQVHcO88N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_06,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 phishscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 spamscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502200108



On 2/19/25 11:21 AM, Mimi Zohar wrote:
> Each time a file in policy, that is already opened for read, is opened
> for write a Time-of-Measure-Time-of-Use (ToMToU) integrity violation
> audit message is emitted and a violation record is added to the IMA
> measurement list, even if a ToMToU violation has already been recorded.
> 
> Limit the number of ToMToU integrity violations for an existing file
> open for read.
> 
> Note: The IMA_MUST_MEASURE atomic flag must be set from the reader side
> based on policy.  This may result in a per open reader additional ToMToU
> violation.
> 
> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Tested-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>   security/integrity/ima/ima_main.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index cde3ae55d654..f1671799a11b 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -129,9 +129,10 @@ static void ima_rdwr_violation_check(struct file *file,
>   		if (atomic_read(&inode->i_readcount) && IS_IMA(inode)) {
>   			if (!iint)
>   				iint = ima_iint_find(inode);
> +
>   			/* IMA_MEASURE is set from reader side */
> -			if (iint && test_bit(IMA_MUST_MEASURE,
> -						&iint->atomic_flags))
> +			if (iint && test_and_clear_bit(IMA_MUST_MEASURE,
> +						       &iint->atomic_flags))
>   				send_tomtou = true;
>   		}
>   	} else {


