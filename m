Return-Path: <linux-integrity+bounces-1834-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57826885CC3
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Mar 2024 16:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05F4F28602F
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Mar 2024 15:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D178B1292D5;
	Thu, 21 Mar 2024 15:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="M9uj0aWz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F29A1292D3
	for <linux-integrity@vger.kernel.org>; Thu, 21 Mar 2024 15:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711036570; cv=none; b=FarcHZfS67NIScKIeERqm8LuZfDpTQl0TIQGKsQ+1CGfHC+xRpl1FtM49xps2mZQDLxyGciXr+ZdjdCKrK6+UnJWvwYtoiOJDfQgIezJ5e6gfns7Glci2Zg/ZOBaaKqbrgjdCbjHnLlatisDM9BtC6ZhzHhpBPlrDuTGFloWqfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711036570; c=relaxed/simple;
	bh=oUSS9WbWUjleqESpW9c98IHhFOzKOgqmvwrILKrh0+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ohBInxXW1LVvk9WTUqETQCw92wmcSLw25VL/ynVOYZl/rhgBjX9uVmTCCmo7rBAPW38shX5CQjln0wzNM1pxH2A96xmg72YR2peDUnHM16ytLGGbuW9fecjbpFOMPpK41s5cyj6I5epJFjyENKT6byppMI7t5RNrn+bCEYf6d6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=M9uj0aWz; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6004a.ext.cloudfilter.net ([10.0.30.197])
	by cmsmtp with ESMTPS
	id myjcrebH1tf2QnKm0r2q0h; Thu, 21 Mar 2024 15:56:08 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id nKltrr7FRuv6XnKlurQpu9; Thu, 21 Mar 2024 15:56:02 +0000
X-Authority-Analysis: v=2.4 cv=YbZ25BRf c=1 sm=1 tr=0 ts=65fc5892
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=UtBFqMlDG83dypD0sxEoAQ==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10
 a=pzMpKnHA-g9QxEOb-IoA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=A+WmTPuzkgZDSVrrCRyuXerhZHil+NNsnP3DC6nYWLs=; b=M9uj0aWzYqMtuCLokuF8MmFkPb
	EJ0Xg5HQdoz3H03McPCY1gKkd+rX2+3UUt6BetiYwYq6SAu2IFYyzWA1LYQWZqHUG3kqVYH8cKI9O
	c/QHrrUZDxdTFaoq21I6FdsAVX5N5n4gKzD3l3FAHCLG3lko4HdID3R/v+gw4xGsVydK6vSQbvwPT
	FAraZMHsUIJ+XuF2/GyqgS0NWSitOp/SOR0Oh/P7AF+5jhangUPumjvU46aJvHN1BvxquFDHG7ZS4
	rjwnDHCL4xgB+cYqwTpUn3OGbmCxib97UU9+IgPtUvDon8YxACiRAtdQJEAXC8gNSXT1LUNeZp3uM
	GgboiAPg==;
Received: from [201.172.174.229] (port=45852 helo=[192.168.15.10])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rnKfa-003VSS-2i;
	Thu, 21 Mar 2024 10:49:30 -0500
Message-ID: <afa0afb7-f756-45d0-97ab-44205e984199@embeddedor.com>
Date: Thu, 21 Mar 2024 09:49:29 -0600
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3][next] integrity: Avoid -Wflex-array-member-not-at-end
 warnings
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <ZfuzWku+ip4fsZrb@neat>
 <267f340e1b309cff2fab01f83a141ee465296907.camel@linux.ibm.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <267f340e1b309cff2fab01f83a141ee465296907.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.174.229
X-Source-L: No
X-Exim-ID: 1rnKfa-003VSS-2i
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.10]) [201.172.174.229]:45852
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfOGhFUAS9eDF2SnN96eDFT7ojJRnZssHtkezwb+sv3ltSliCeiji3El3AQwpPcNsk2KT9ZBpKsnCO9FrJ6EGbLMWzyJc88aYVtxvOhc/x+AMGToWazoL
 7eMqyL2bomVKv3o/T5qeWOAFqv7rdJ0bwktMAKGmB+zMBrXUf/w7wGbs8pPpDf9LrMNJuHgZweFB145rlUt3VAuPZF6LfjQatTeFeSJGc7J/2ZgEeLPH2A/d



On 3/21/24 07:58, Mimi Zohar wrote:
> On Wed, 2024-03-20 at 22:11 -0600, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end is coming in GCC-14, and we are getting
>> ready to enable it globally.
>>
>> There is currently an object (`hdr)` in `struct ima_max_digest_data`
>> that contains a flexible structure (`struct ima_digest_data`):
>>
>>   struct ima_max_digest_data {
>> 	struct ima_digest_data hdr;
>>          u8 digest[HASH_MAX_DIGESTSIZE];
>>   } __packed;
>>
>> So, in order to avoid ending up with a flexible-array member in the
>> middle of a struct, we use the `__struct_group()` helper to separate
>> the flexible array from the rest of the members in the flexible
>> structure:
>>
>> struct ima_digest_data {
>>          __struct_group(ima_digest_data_hdr, hdr, __packed,
>>
>> 	... the rest of the members
>>
>>          );
>>          u8 digest[];
>> } __packed;
>>
>> With the change described above, we can now declare an object of the
>> type of the tagged `struct ima_digest_data_hdr`, without embedding the
>> flexible array in the middle of another struct:
>>
>>   struct ima_max_digest_data {
>>          struct ima_digest_data_hdr hdr;
>>          u8 digest[HASH_MAX_DIGESTSIZE];
>>   } __packed;
>>
> 
> And similarly for 'struct evm_digest'.

Yes. :)

> 
> 
>> We also use `container_of()` whenever we need to retrieve a pointer to
>> the flexible structure.
>>
>> So, with these changes, fix the following warnings:
>>
>> security/integrity/evm/evm.h:45:32: warning: structure containing a flexible
>> array member is not at the end of another structure [-Wflex-array-member-not-
>> at-end]
>> security/integrity/evm/evm.h:45:32: warning: structure containing a flexible
>> array member is not at the end of another structure [-Wflex-array-member-not-
>> at-end]
>> security/integrity/evm/evm.h:45:32: warning: structure containing a flexible
>> array member is not at the end of another structure [-Wflex-array-member-not-
>> at-end]
> 
> I assume these messages are gone.

Yes. :)

Thanks
--
Gustavo


