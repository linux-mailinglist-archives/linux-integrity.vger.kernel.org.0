Return-Path: <linux-integrity+bounces-1442-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D55B7861A7E
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 18:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63694288E10
	for <lists+linux-integrity@lfdr.de>; Fri, 23 Feb 2024 17:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 970BC12FB11;
	Fri, 23 Feb 2024 17:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="s4CzUCmk"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E842F1339BA
	for <linux-integrity@vger.kernel.org>; Fri, 23 Feb 2024 17:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708710263; cv=none; b=ows5ceM8sEUV2B+CohbcDRccUYre+vJiCx07XcaT5OJ0ogTkIwMK6f5F/E97iUpxKabaBGncds56k9/36ggAUSIUoreMRm/dUV39Oh86QO/mFuqawS3SBQXBCaM3eicyvkQ4lx7suj/NQbFbJALt6pEd7CdVPa65jvX+QrCVxiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708710263; c=relaxed/simple;
	bh=mkddNeucC+zhos3oY7WGjLFTKfYFoSLMS9uSkc4u59c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KpU5srKagBgxyBf1W7WS56QUB89VwKqGbMpaw659pzqyAcJA+Q2hPyBCu52j2mSLZME0PugiOyOng610kigHug3I6+VaHlF1GrrPEruirp9wRScyrQ9FxZt0JEaSyWgWDcR/5SUPu9irYpa8RfSiuiclnND0kKZWUX3JeAI4uU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=s4CzUCmk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41NHSOYF017363;
	Fri, 23 Feb 2024 17:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=66BF3BqQjfL0z4iK8IG8vQCxBAMl/21G5IUgJ1QxdXI=;
 b=s4CzUCmkeaz9pt20RJX42woupw26UNRj/mqS81u3tP+/IgwXwbKOVa+XLV6U+iIb8mfC
 xFijGE9C69NxR/CCssEYh/q3Mcu8w+NH3FeCt2U1S4XLA1Ps2xFzZGnecau2tp7MlQdY
 7+QQDWPZntbWbzMEbMSv+YvK1Wz3N2V1QXRKiVxBidm2q0qagIuyE32oirNwFttxJfDz
 LH758ujQpNHnTfmQTfkAGly8X11PKQC77DWhOSahdFNQq80AcbIUTSCWZjhWyWdPYN93
 /ao51ZsMzIS4y+WJ4GqwMdrGKQOLlqDUHEqK1tkNs24cVoL9Vqp4KS4xu/TXWDbj63jd dA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3weysr0d1y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:43:55 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41NHeWgX030824;
	Fri, 23 Feb 2024 17:43:55 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3weysr0d1f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:43:54 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41NHH0xB009627;
	Fri, 23 Feb 2024 17:43:53 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wb84pxydj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 17:43:53 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41NHhokL26804820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Feb 2024 17:43:52 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A4805806B;
	Fri, 23 Feb 2024 17:43:48 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 80C1858056;
	Fri, 23 Feb 2024 17:43:47 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 23 Feb 2024 17:43:47 +0000 (GMT)
Message-ID: <a79a57aa-3b70-4406-919f-bb09bc0a2c12@linux.ibm.com>
Date: Fri, 23 Feb 2024 12:43:46 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ima-evm-utils: PATCH v1 1/1] Change license to LGPL-2.0-or-later
 and GPL-2.0-or-later
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-integrity@vger.kernel.org
Cc: a.mardegan@omp.ru, git@andred.net, dbaryshkov@gmail.com,
        ebiggers@google.com, sorenson@redhat.com, gcwilson@linux.ibm.com,
        James.Bottomley@HansenPartnership.com, kgoldman@us.ibm.com,
        mjg59@srcf.ucam.org, patrick.ohly@intel.com, patrick@puiterwijk.org,
        petr.vorel@gmail.com, roberto.sassu@huawei.com,
        stephen.smalley.work@gmail.com, tianjia.zhang@linux.alibaba.com,
        vt@altlinux.org, vgoyal@redhat.com, z.jasinski@samsung.com
References: <9205ed32da8814d8c4d9bde5a03d92c7588f1d9a.1708503094.git.dmitry.kasatkin@gmail.com>
 <5dd2108599f11c9f9ea73a4f127ec969347bc78f.camel@linux.ibm.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <5dd2108599f11c9f9ea73a4f127ec969347bc78f.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jol92aEu6VK57TwMoY_F0c91rX6dYrtD
X-Proofpoint-ORIG-GUID: YT9bEybJKq0CoenG8bcT1pmg-5tDFfSf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_03,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 clxscore=1011 priorityscore=1501 adultscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402230129



On 2/23/24 12:42, Mimi Zohar wrote:
> On Wed, 2024-02-21 at 10:11 +0200, Dmitry Kasatkin wrote:
>> Currently libimaevm provided by this project is used by the tool evmctl,
>> which is also provided by this project.
>>
>> An issue was reported about using libimaevm with other software. Its
>> GPL2-only license makes it incompatible to use with other licenses, in
>> particular GPL3-only.
>>
>> To address this issue, change the project license to GPL-2.0-or-later
>> and libimaevm to LGPL 2.0 or later.
>>
>> Signed-off-by: Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
> 
> Thanks, Dmitry!
> 
> Acked-by: Mimi Zohar <zohar@linux.ibm.com>
> 
Acked-by: Stefan Berger <stefanb@linux.ibm.com>

