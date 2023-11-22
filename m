Return-Path: <linux-integrity+bounces-199-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E497F4903
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 15:33:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A439D2815DF
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 14:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D2D4E630;
	Wed, 22 Nov 2023 14:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="imAl28ri"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B812D79
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 06:33:32 -0800 (PST)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AME9GK2004610
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 14:33:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=YJkzrFlFC9KGN3ETtQonj/dYF3b/hD1G12Ribzv2hQc=;
 b=imAl28riMRnFh8uJeVqK7h3D1sIbkyz7VY+bYZdtUIeOQBaK/gJetCKl/biwQLL3+riu
 pY/RllnOTN/hzQwlz4pwP45NJl2gIKYfk5CgPvWUKMVzThiDSYqosf8+dPXpoEzMuPsC
 1EOYvVGw35VIsK6vis5cKS1vEOCo3JnqKqdgmHcf8uWJa8vVp/8WQ5ZgrHYKHPaVVBep
 Uud9AUMnbV7V29kzTfdDTJtYNUfZjKJiS43uWUgVhzbB741LMfvMcaxJH0QLnemsFMtl
 eN0HJnacNdHiI/XQI9S4bMZAP6zoJOJAm6IOiFlLysTa1JUV5naM7RisqaWQVE8SuV+q 4Q== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uhj8qj2cp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 14:33:31 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AMDT4dl001718
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 14:33:30 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uf93m07jw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-integrity@vger.kernel.org>; Wed, 22 Nov 2023 14:33:30 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AMEXT7x19792628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Nov 2023 14:33:29 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E4FB5805B;
	Wed, 22 Nov 2023 14:33:29 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E1DF958058;
	Wed, 22 Nov 2023 14:33:28 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Nov 2023 14:33:28 +0000 (GMT)
Message-ID: <7042007c-dcc5-404b-878c-f5f36f9fb5af@linux.ibm.com>
Date: Wed, 22 Nov 2023 09:33:28 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ima-evm-utils PATCH 09/12] Use a local hash algorithm variable
 when verifying file signatures
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <20231119165043.46960-1-zohar@linux.ibm.com>
 <20231119165043.46960-10-zohar@linux.ibm.com>
 <93aa5f57-fd8a-475f-a1b8-c8d00772b251@linux.ibm.com>
 <afbc47db6e3041bba6602d2dbd3c392ae2ac9d2e.camel@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <afbc47db6e3041bba6602d2dbd3c392ae2ac9d2e.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: o1WzuulXXAC5ZmlsT1qJXUA_T-ytCoXj
X-Proofpoint-ORIG-GUID: o1WzuulXXAC5ZmlsT1qJXUA_T-ytCoXj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-22_10,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 mlxscore=0 clxscore=1015 mlxlogscore=999
 lowpriorityscore=0 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311220103



On 11/22/23 09:14, Mimi Zohar wrote:
> On Wed, 2023-11-22 at 08:37 -0500, Stefan Berger wrote:
>>

>> Now you are passing valid parameters into verify_hash2(). Would it not
>> be possible to drop 4/12?
> 
> Just as we can't modify the library verify_hash() definition, I don't
> think we should be modifying the verify_hash2() defintion either.
> 04/12 defines and exports the final verify_hash2() definition.
> 

The question is whether verify_hash2() can be only introduced here in 
versus made available in 4/12 with a parameter that it doesn't use at 
all at that point.

