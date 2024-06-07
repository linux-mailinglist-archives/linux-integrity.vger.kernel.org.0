Return-Path: <linux-integrity+bounces-2844-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 723E58FF8B7
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jun 2024 02:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F112F28572E
	for <lists+linux-integrity@lfdr.de>; Fri,  7 Jun 2024 00:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706B38F5E;
	Fri,  7 Jun 2024 00:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="K5l0crm1"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB56A1843;
	Fri,  7 Jun 2024 00:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717720914; cv=none; b=mlO+3ZDf7ETlnlDy7vPVO47xAeQUhY3/PrhQAJQKwtdbixlGxFeZmjpyypTvlSAwz721C2LMFTXHNImM6elaZUzMYjBbVumQIfAJXU4WAm45sfKd1S7itIc8+64Ne3U7GmwulJCfTjdzbskg1hOS1YT22CgQwDxn/4A+lcLYuCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717720914; c=relaxed/simple;
	bh=fzxAwNJN4mJrDlPMuUyG1MgkU9qmbMcO23w88KXDjsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=IPyJ1VYwawcGuDm5VNNvA1gTPmrGlK4KGpOwCLCZwbn5QdsMGeg9XZk3UYI11NCHZpD2p6Lu3/O1dUAAZ7WndgqbmmFHFi3FukiKO9VmOSBIGqIe+4VWzD7lhdALU+0YWOZM9MUTCnGAm0ZTHOb6R8SwTPOaKErTXa2894vofNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=K5l0crm1; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 456LDahp031023;
	Fri, 7 Jun 2024 00:41:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	j58ShJkkIFOMNe2apzn0w5NZrsLF2xZTKWcc4kUHdsI=; b=K5l0crm1k/sprEYj
	etKNlsZGsY4mYnoDaLQWFSM7XSpXy0TBt7rNbkMlysxuj3D3JIWIZGTuiiHNJiAZ
	n3SaqQh5pLzGfAqHhhULHszl7X/xIGgRACVw4kc7G7D/J//RvL7XbirQHyWqwjPG
	F4pXa1oK9Cr931fC6c/yy3+MUn4uFnwvq6vDRKFcr32Zbtl6tYWEc4D04Nn+5l6S
	2tdzMkNHJ380JbjO+sZX6ETbkRGfEmAVh4YV7TEivhoHRh8aOA+/PUZwbuXeVsgk
	H9tGYjmO/yUtxX6U8KfkOKahdvUiz9XMJdQkIrgvWKTSK0CPQF5fuONF56guWh7o
	iaTpbA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yj87rp76e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Jun 2024 00:41:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4570fRhH025110
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 7 Jun 2024 00:41:27 GMT
Received: from [10.48.241.109] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 6 Jun 2024
 17:41:26 -0700
Message-ID: <f5cb3543-d5f4-466e-89f4-d8e8996ab480@quicinc.com>
Date: Thu, 6 Jun 2024 17:41:25 -0700
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KEYS: trusted: add missing MODULE_DESCRIPTION()
Content-Language: en-US
To: Jarkko Sakkinen <jarkko@kernel.org>,
        James Bottomley
	<James.Bottomley@HansenPartnership.com>,
        Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James
 Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>
CC: <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
        <linux-security-module@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <20240530-md-trusted-v2-1-151f0c7be272@quicinc.com>
 <D1RDT52OY7S6.J625EB7S0KVR@kernel.org>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
In-Reply-To: <D1RDT52OY7S6.J625EB7S0KVR@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: V3iQYBDvuDJdXuNqt6p67hGepvlsDdhs
X-Proofpoint-ORIG-GUID: V3iQYBDvuDJdXuNqt6p67hGepvlsDdhs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_20,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 spamscore=0 mlxlogscore=999 adultscore=0 lowpriorityscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406070004

On 6/4/2024 9:43 AM, Jarkko Sakkinen wrote:
> On Thu May 30, 2024 at 5:43 PM EEST, Jeff Johnson wrote:
>> kbuild reports:
>>
>> WARNING: modpost: missing MODULE_DESCRIPTION() in security/keys/trusted-keys/trusted.o
>>
>> Add the missing MODULE_DESCRIPTION() macro invocation.
>>
>> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>> ---
>> Changes in v2:
>> - reword commit text per Jarkko's guidance
>> - Link to v1: https://lore.kernel.org/r/20240529-md-trusted-v1-1-56c9a0ae8e28@quicinc.com
>> ---
>>  security/keys/trusted-keys/trusted_core.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/security/keys/trusted-keys/trusted_core.c b/security/keys/trusted-keys/trusted_core.c
>> index 5113aeae5628..f4ab16d59663 100644
>> --- a/security/keys/trusted-keys/trusted_core.c
>> +++ b/security/keys/trusted-keys/trusted_core.c
>> @@ -395,4 +395,5 @@ static void __exit cleanup_trusted(void)
>>  late_initcall(init_trusted);
>>  module_exit(cleanup_trusted);
>>  
>> +MODULE_DESCRIPTION("Trusted Key support");
> 
> First this should be just "Trusted key type".

OK, I can make that change in v3

> 
> Second: neither encrypted keys has the description.
> 
> So I'd consider also "Encrypted key type" for that one.
> 
> So this really needs two patches to be done properly.

In my x86 allmodconfig build I'm getting a single warning in security/keys:

WARNING: modpost: missing MODULE_DESCRIPTION() in security/keys/trusted-keys/trusted.o

And my current patch fixes that warning.

But I do see that security/keys/encrypted-keys/encrypted.c has a 
MODULE_LICENSE() but not a MODULE_DESCRIPTION().  Looks like that doesn't 
generate warning because it isn't built as a module, even in an allmodconfig 
build:
CONFIG_TRUSTED_KEYS=m
CONFIG_HAVE_TRUSTED_KEYS=y
CONFIG_TRUSTED_KEYS_TPM=y
CONFIG_TRUSTED_KEYS_TEE=y
CONFIG_ENCRYPTED_KEYS=y

But I'll add a MODULE_DESCRIPTION() in case it is ever built as a module.

/jeff

