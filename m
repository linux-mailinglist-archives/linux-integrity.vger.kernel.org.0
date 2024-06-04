Return-Path: <linux-integrity+bounces-2795-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFC818FBBC0
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jun 2024 20:42:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF5AD1C20F73
	for <lists+linux-integrity@lfdr.de>; Tue,  4 Jun 2024 18:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A7514A08F;
	Tue,  4 Jun 2024 18:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tL8xvdVq"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 309E312BF18;
	Tue,  4 Jun 2024 18:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717526544; cv=none; b=DeHl12454eCdzaKQLk6KzJME5cW6+VwGrX03iK2YFhhXMSp7RZcsr5cUH34Aapc6Z/c7VuiAIocpZVWETDoN8NolBq0GNWTOwnf8VIEWWI55gCr2IGEietSCekjarcwxMrQmF6esny8Vz6nIBNa5asiDHovQWxApj42nv48ZcmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717526544; c=relaxed/simple;
	bh=qgbdL3XgkUmsP7El5caXTlwZqyNDhmeJrKRWHyoam3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eGNEzWxjJccCLK5FFQNdUq3ECXIsrBfj1HGjdoYbZEt7sx99wGY3OnoiJ8/aBN6HGMbgjg4cYhCfCRJBhN0O37eiWvRizo8y0xmRMmthFeO9TB5bhaCPgYxJG/KkNo72kR5C9m+CIR7sruk5f1ZBxIFCq7hBz0NERQt4wLjI8yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tL8xvdVq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 454IKHdR030016;
	Tue, 4 Jun 2024 18:41:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=Awnrs9s7Dn+rSu3FZcgywEz7ggEw1I9fqEwMmZnbofc=;
 b=tL8xvdVqwmS7c+2Q6bQY7DWNUJPPBbzV2z99CItiW14nFJpGXaM7jkzRZhXxCgWaWHmV
 vuDM6aiZXPNPIzDw+e3Ths3H1JYI6hwsRlPdFUtqQqlAcKnDkPVXdLIXkLZ1DlHv2T7O
 inqbqZBqrb0eYvbwYOg+l0rdwyg6Jr/Z9XEPOrE1bmdA40M/PlhrL+tDQghUzo+jj/+H
 AJ5hL1FuNaw5UBwpq/5M+mIOVCE5UlyWVKI8MrmfKmcWiSC3uRtNQBf7oWo2KbMLr4aI
 g6jPRD6nhqi2hcPvpdFCavVtLNbb6f7D+bQhF63QJ9RDOm9ToOIUgWc9dhjhwvLB1BvC yg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yj7py042q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 18:41:51 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 454IfpgQ032364;
	Tue, 4 Jun 2024 18:41:51 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yj7py042h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 18:41:50 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 454GuJGq026671;
	Tue, 4 Jun 2024 18:41:49 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ygffmygp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Jun 2024 18:41:49 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 454Ifk3m40305334
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Jun 2024 18:41:49 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EAA65805B;
	Tue,  4 Jun 2024 18:41:46 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0763C58060;
	Tue,  4 Jun 2024 18:41:45 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Jun 2024 18:41:44 +0000 (GMT)
Message-ID: <6f0e04c2-4602-4407-9af5-f72610021a6a@linux.ibm.com>
Date: Tue, 4 Jun 2024 14:41:44 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/5] crypto: tpm2_key: Introduce a TPM2 key type
To: Jarkko Sakkinen <jarkko@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Andreas.Fuchs@infineon.com, James Prestwood <prestwoj@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-crypto@vger.kernel.org,
        Lennart Poettering <lennart@poettering.net>,
        "David S. Miller" <davem@davemloft.net>,
        open list <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>, David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>
References: <20240528210823.28798-1-jarkko@kernel.org>
 <20240528210823.28798-4-jarkko@kernel.org>
 <97dd7485-51bf-4e47-83ab-957710fc2182@linux.ibm.com>
 <D1REOCZ2XHRY.4U47RZ20QET1@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <D1REOCZ2XHRY.4U47RZ20QET1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: w_DQGgAQ2dwu6MnVHL0p-sJPe_stY7lc
X-Proofpoint-GUID: Pdci5PsERwmMjAj19oUSTHaQnLm7SV5N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-04_09,2024-06-04_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=605 clxscore=1015 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406040150



On 6/4/24 13:23, Jarkko Sakkinen wrote:
> On Fri May 31, 2024 at 3:35 AM EEST, Stefan Berger wrote:
>>

>>>    
>>> -	rc = tpm2_key_decode(payload, options, &blob);
>>> -	if (rc) {
>>> -		/* old form */
>>> +	key = tpm2_key_decode(payload->blob, payload->blob_len);
>>> +	if (IS_ERR(key)) {
>>> +		/* Get the error code and reset the pointer to the key: */
>>> +		rc = PTR_ERR(key);
>>> +		key = NULL;
>>> +
>>> +		if (rc == -ENOMEM)
>>> +			return -ENOMEM;
>>> +
>>> +		/* A sanity check, as only -EBADMSG or -ENOMEM are expected: */
>>> +		if (rc != -EBADMSG)
>>> +			pr_err("tpm2_key_decode(): spurious error code %d\n", rc);
>>
>> tpm2_key_decode seems simple enough that it only returns key, -ENOMEM or
>> EBADMSG.
> 
> So what is your suggestion here?

You can remove the check resuling in pr_err().

> 
> The reasoning here is that asymmetric keys use -EBADMSG not only as
> error but also iterator, when probing which can load a specific key.
> 

