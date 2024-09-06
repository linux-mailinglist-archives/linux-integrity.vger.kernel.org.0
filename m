Return-Path: <linux-integrity+bounces-3493-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6481F96F9B6
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 19:03:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE991B2336A
	for <lists+linux-integrity@lfdr.de>; Fri,  6 Sep 2024 17:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C831D4606;
	Fri,  6 Sep 2024 17:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AXbZrfsn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAD71D3656;
	Fri,  6 Sep 2024 17:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725642193; cv=none; b=dQLR6Wj9Fy1t7ZSMk2fuzVka1tZ5VNFqEe5rbzioKUTk/hXRUc/So03lltqrKXrjCPtJN/yt/0FFtQnlskpjBuX3TPPy8uWApkyEsW4opAtJFy35M+o/LI23YPomLbTWmkgVgA46lTOS0O2ZiALe9Kua9eUloYgyBjGqmoxcGys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725642193; c=relaxed/simple;
	bh=yWbLFIl/asMYOkEMtL1VrdhvAG4/uLy2td1Rn6/TbzA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rT4R8LvSwA69QBg/SeQDrECtGv/QAhk6peDb7D22SXnCZa/0qEZPYFWFDgeFM8Cgc6guw6GfsPgSUHanFsqqQnnyk63QsY2ZSaRIZLtw5Yrwz3LA/nijHgp259iy/towiwmgK5xOVnPS0XiucJLJTofBQBdAguV5MJLnn4fGLn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AXbZrfsn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 486Dt68d026367;
	Fri, 6 Sep 2024 17:02:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	8YYOBneB917QBCdakNuvYI37onUQ5PmLSY+eVM2JoYA=; b=AXbZrfsnlN7G6+6P
	xag44Eo7Ti/JzR943oC4grZXK5CvazRF/qqtm4uc1Uw8bpeurcjSS1r7SXi9J99Z
	DPqjhbI66Adaoq/NAQFHfovZRAKAHfdIsSUsHMWVCCPNokZAoNmqGMk9L9BU2oOF
	KT/HQlLgZUNv+gXHUu7UaNYr2pvH2o2Bw0fkJdEw8voR9LTUHymcMSlmrApGu8VC
	kWqva39KVzJS11Q1iPhwpoggnhz0fD0lfZvym6zhsomlAJ9fwloChK62fz1ciUsZ
	Cr2UUHtpqWDSxusMrkanwJRA6Jf0RIniuQOS4Xa83qYVCIkt2gtF1aBOTced9dIF
	rY0adQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 41fj1m58s8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 17:02:45 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 486FjK4u019891;
	Fri, 6 Sep 2024 17:02:41 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 41fj3xvp9n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Sep 2024 17:02:41 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 486H2evq52953428
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Sep 2024 17:02:40 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16B1858058;
	Fri,  6 Sep 2024 17:02:40 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB9795805B;
	Fri,  6 Sep 2024 17:02:38 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Sep 2024 17:02:38 +0000 (GMT)
Message-ID: <603acd64-0a6d-470b-9c9b-f6146443dc0c@linux.ibm.com>
Date: Fri, 6 Sep 2024 13:02:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 RESEND] tpm: export tpm2_sessions_init() to fix ibmvtpm
 building
To: Jarkko Sakkinen <jarkko@kernel.org>, Kexy Biscuit <kexybiscuit@aosc.io>,
        linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: linux-kernel@vger.kernel.org, mpe@ellerman.id.au,
        naveen.n.rao@linux.ibm.com, zohar@linux.ibm.com,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Mingcong Bai <jeffbai@aosc.io>
References: <20240905085219.77240-2-kexybiscuit@aosc.io>
 <D3YF52E4EVJ0.2ZJSCR5FCVIGX@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <D3YF52E4EVJ0.2ZJSCR5FCVIGX@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cFcTW404zW7yxxo24IlSG3T7nXofLOZk
X-Proofpoint-ORIG-GUID: cFcTW404zW7yxxo24IlSG3T7nXofLOZk
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_03,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 adultscore=0 lowpriorityscore=0 spamscore=0 phishscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2408220000 definitions=main-2409060125



On 9/5/24 10:26 AM, Jarkko Sakkinen wrote:
> On Thu Sep 5, 2024 at 11:52 AM EEST, Kexy Biscuit wrote:
>> Commit 08d08e2e9f0a ("tpm: ibmvtpm: Call tpm2_sessions_init() to
>> initialize session support") adds call to tpm2_sessions_init() in ibmvtpm,
>> which could be built as a module. However, tpm2_sessions_init() wasn't
>> exported, causing libmvtpm to fail to build as a module:
>>
>> ERROR: modpost: "tpm2_sessions_init" [drivers/char/tpm/tpm_ibmvtpm.ko] undefined!
>>
>> Export tpm2_sessions_init() to resolve the issue.
>>
>> Cc: stable@vger.kernel.org # v6.10+
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202408051735.ZJkAPQ3b-lkp@intel.com/
>> Fixes: 08d08e2e9f0a ("tpm: ibmvtpm: Call tpm2_sessions_init() to initialize session support")
>> Signed-off-by: Kexy Biscuit <kexybiscuit@aosc.io>
>> Signed-off-by: Mingcong Bai <jeffbai@aosc.io>
>> ---
>> V1 -> V2: Added Fixes tag and fixed email format
>> RESEND: The previous email was sent directly to stable-rc review
>>
>>   drivers/char/tpm/tpm2-sessions.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
>> index d3521aadd43e..44f60730cff4 100644
>> --- a/drivers/char/tpm/tpm2-sessions.c
>> +++ b/drivers/char/tpm/tpm2-sessions.c
>> @@ -1362,4 +1362,5 @@ int tpm2_sessions_init(struct tpm_chip *chip)
>>   
>>   	return rc;
>>   }
>> +EXPORT_SYMBOL(tpm2_sessions_init);
>>   #endif /* CONFIG_TCG_TPM2_HMAC */
> 
> Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> 
Would have tested it but machine is down..

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> BR, Jarkko
> 

