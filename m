Return-Path: <linux-integrity+bounces-2693-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DAA38D2A16
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2024 03:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E2811C23C11
	for <lists+linux-integrity@lfdr.de>; Wed, 29 May 2024 01:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3501F13E41D;
	Wed, 29 May 2024 01:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W86N+DVI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891E054F95;
	Wed, 29 May 2024 01:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716947452; cv=none; b=Qy+lipWvWIu2Qx/WupksUgUM0njuayPZzcXvUcHVzqQZj9GoTRh4zXpTabUsgV8lZC5oe4FlUMvktoHAaSNSZbDzdtml3laFx83xgdwO50acqnM/epDnq3dRCyzOC1SXki5CXmaLH+xdIgypEb3Bd59nw5fA5W5qiY+JlrqpshU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716947452; c=relaxed/simple;
	bh=/qtOjP1RlF/FN7zclhrsBp1avL7HC78PDggKJ48KInE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q6IIok+4wb0lCm+5SRaWTl+ARa4TTx2snGVuTyYhpl3fYwBBHs+rLNllbuGHW40mZyTp7Vk+gX7FH+W8FOtVv3swe9vhZilOLfxw6C4p+P6tyeJKLeNFmU3FDjbFYHn7z3nKEv2VHAH54oQzkCVGN+qUu2g4ZjKrNL+5YmFjSP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W86N+DVI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44T1J2ur016581;
	Wed, 29 May 2024 01:50:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc :
 content-transfer-encoding : content-type : date : from : in-reply-to :
 message-id : mime-version : references : subject : to; s=pp1;
 bh=18e5f2V5wYwa//AXQoETnqRxYbmEXog+v0GD6re4QDI=;
 b=W86N+DVICq0EzEVAV3nQjeBONDQUkfzD82w+kaeC4ASU2EvSkXlaMtP2Hh+x0UZWlnVd
 WL32qdO/mb+RXrNJOVWWyBd8yz9NHytWPFcotR56mYdMDP7iJPnO57CTX8TEQJmxDZSS
 MbunYHpic8O9dE6h5KNaMILdW4NJsIiFAzXywoUSbi7Dy7YL6n++Tx9yn8rNg+CZgqG0
 l28rjgyDeuVRwQcohnPx4QL83pC9HXdgKv9u8eLXw7XrNPP5CCht4i3xgK8AU4zcQHFF
 M8pHWbVFhiuOYzUwqUprCDRNtx0M9K/eb6jV0+syZAryFbu7duX51rsFptHyyLiYaW3B fA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ydtk3g220-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 01:50:21 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44T1oK7t030265;
	Wed, 29 May 2024 01:50:20 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ydtk3g21w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 01:50:20 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44T0NX0o026733;
	Wed, 29 May 2024 01:50:19 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ydpd2h6x4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 May 2024 01:50:19 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44T1oHN723069022
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 May 2024 01:50:19 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC2835806D;
	Wed, 29 May 2024 01:50:16 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E57D058055;
	Wed, 29 May 2024 01:50:14 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 May 2024 01:50:14 +0000 (GMT)
Message-ID: <14d0baf4-fa41-4a08-925d-90f028117352@linux.ibm.com>
Date: Tue, 28 May 2024 21:50:13 -0400
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/5] KEYS: trusted: Change -EINVAL to -E2BIG
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
 <20240528210823.28798-3-jarkko@kernel.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20240528210823.28798-3-jarkko@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PQ-J8mJnvVf2cN96SS9-nuPuwfKldJRy
X-Proofpoint-ORIG-GUID: _qkRw_-n6ewNKIshDIJmVzW32UTOKZno
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-28_14,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 spamscore=0 impostorscore=0
 clxscore=1011 lowpriorityscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=794 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405290010



On 5/28/24 17:08, Jarkko Sakkinen wrote:
> Report -E2BIG instead of -EINVAL when too large size for the key blob is
> requested.
> 
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>

> ---
>   security/keys/trusted-keys/trusted_tpm2.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/security/keys/trusted-keys/trusted_tpm2.c b/security/keys/trusted-keys/trusted_tpm2.c
> index 8b7dd73d94c1..06c8fa7b21ae 100644
> --- a/security/keys/trusted-keys/trusted_tpm2.c
> +++ b/security/keys/trusted-keys/trusted_tpm2.c
> @@ -122,7 +122,7 @@ static int tpm2_key_decode(struct trusted_key_payload *payload,
>   		return ret;
>   
>   	if (ctx.priv_len + ctx.pub_len > MAX_BLOB_SIZE)
> -		return -EINVAL;
> +		return -E2BIG;
>   
>   	blob = kmalloc(ctx.priv_len + ctx.pub_len + 4, GFP_KERNEL);
>   	if (!blob)

