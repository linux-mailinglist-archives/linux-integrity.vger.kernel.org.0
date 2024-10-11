Return-Path: <linux-integrity+bounces-3785-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5454499A80A
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Oct 2024 17:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 033031F22D0E
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Oct 2024 15:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F1E91974F4;
	Fri, 11 Oct 2024 15:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FYzyubZQ"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CEE194AF3;
	Fri, 11 Oct 2024 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728661245; cv=none; b=ZbC3NJ+EnJeucQ6FCoLoqzzGIl6bqtCqx3oYS62w1azB+kuYBHwYlqSZMK+U8vz91NjOs4IRCs+zHNVwb6j75ah4pAcBQCw6lsarzsnMQOEr+bINvmnmXh0Li+Xuj4HAGWVHmxz+oftE2CSgoR6Lc90qktVLLEU6Ui+0nhDZLpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728661245; c=relaxed/simple;
	bh=tVxVy8f1eOdueuP+FRZklxG2ZKTkZh+csjblCJaNsNs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=FaJEddwdq8ynvpbEevDvkPEqEe0m+AFTYU6kbl6NsHC6X00QhOTwwGvYWwSq5SuEMSpArRC7U4CAo4UU3GJfwqPoleABLxQeMXLp4Z2dDrLeFgfsk+pL4+ntHu8yolfsM4MELt4RXfOXf9pXwPBl+C59wv74XvXvdYASrNeWqq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FYzyubZQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49BEwFTt028640;
	Fri, 11 Oct 2024 15:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	M4Az6bc1Ta3OtXBrLaglWebxytc8ORkGCkixKqyzEjs=; b=FYzyubZQeWU7EPqP
	7b9YMWQgJK8/cPr8q5RH40qJJi9hNgWIFt9XIvnVaSkl7yeXBeauCPAFsNXA7l9j
	R7SQDBr9iXhqXbK/YksoMT8cPyEvpndygTHurYr2m1jbihBtL9vbW5Crf61R0GKS
	5f/oxal/xVOz8L/JEPgPlLwGj09ZKQWyvTF27myPDIjbsxTJxpSVAA7Nc2/EyhXd
	l26ryEZYtNasjgkZK6VAflfZbxIHx9DNzGjsKUSyfwahc721W7Pz1gamgVS/XwZY
	dze4hvmFJQb0n7U2Wcgt2iLyyKPU7K+E/JBCfMnQYeJsdud07MJCMOnhWSFVgBsW
	GDHqKA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42763b88fx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 15:40:32 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49BEe5OP030187;
	Fri, 11 Oct 2024 15:40:31 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 423gsn6c3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 15:40:31 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49BFeV1U44892444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Oct 2024 15:40:31 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0995A5805C;
	Fri, 11 Oct 2024 15:40:31 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9FF2858051;
	Fri, 11 Oct 2024 15:40:30 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Oct 2024 15:40:30 +0000 (GMT)
Message-ID: <50e5cfff-94f8-4a45-a32d-9cce4f48d5b4@linux.ibm.com>
Date: Fri, 11 Oct 2024 11:40:30 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ima: Suspend PCR extends and log appends when rebooting
To: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zohar@linux.ibm.com,
        roberto.sassu@huawei.com,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>
References: <20241011150522.2697216-1-stefanb@linux.ibm.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20241011150522.2697216-1-stefanb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Aqs-gjm7SZmBCNEh50J4dKGImpJP_SGl
X-Proofpoint-GUID: Aqs-gjm7SZmBCNEh50J4dKGImpJP_SGl
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-11_13,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=792 impostorscore=0
 adultscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410110107



On 10/11/24 11:05 AM, Stefan Berger wrote:
> To avoid the following types of error messages from the TPM driver, suspend
> PCR extends once the reboot notifier has been called. This avoids trying to
> use the TPM after the TPM subsystem has been shut down.
> 
> [111707.685315][    T1] ima: Error Communicating to TPM chip, result: -19
> [111707.685960][    T1] ima: Error Communicating to TPM chip, result: -19
> 
> This error could be observed on a ppc64 machine running SuSE Linux.
> 
> Signed-off-by: Tushar Sugandhi <tusharsu@linux.microsoft.com>

Some of the code is taken from Tushar's series: 
https://lore.kernel.org/linux-integrity/20240214153827.1087657-1-tusharsu@linux.microsoft.com/T/#m2d5f23959510ea2ada534febe03beff4a3f97ac7

See patch 6/8.

Tushar's series is still needed for carrying the log across kexec 
properly since without it it can still happen that the state of the PCR 
10 does not match with the IMA log if a new measurements is taken after 
the freezing of the log (currently at 'kexec load') and before the 
'kexec exec'.


