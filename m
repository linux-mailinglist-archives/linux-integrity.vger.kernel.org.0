Return-Path: <linux-integrity+bounces-1824-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B975881B97
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Mar 2024 04:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43CA283B9E
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Mar 2024 03:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3A0C8E2;
	Thu, 21 Mar 2024 03:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="JLbY4nIz"
X-Original-To: linux-integrity@vger.kernel.org
Received: from omta40.uswest2.a.cloudfilter.net (omta40.uswest2.a.cloudfilter.net [35.89.44.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D40BA22
	for <linux-integrity@vger.kernel.org>; Thu, 21 Mar 2024 03:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710992385; cv=none; b=da4MOEaOXmb9DxFqwme8TwM1ESeBAs0gDd8vEJdcF7OGz5Jn3iEtmSsQqWyGM6gbbc9rQ+uA0zGfjbY9mhFZTxuQ7wlC2KuwslLpSNBaHK1MRP2pp4tYT+9FA8Gs31saqX5KNQvXeBsP4D92Yl/G1xCYrOvGC4wEPuuQtfB6Zc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710992385; c=relaxed/simple;
	bh=e/oB7EHyTS+qrUZJuOHpe7f0RTBTpNdPueEV7DX+ZNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EJnlTSlCKAXlsp6n50swsBHBe5rCO4807jKdeL6gm8Mp4/vBfAcsyCltt5hkDejJ4Rg0Oz7Ti4fBrpz0ML6+VsD/VQBpOII+bYRbF3zydqLEOcWRC8BLuzsfnBMgEQJdZw5M9cWxS2JhDvb6cyebsu4tM/AtbkcwC5fsx5e4GHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=JLbY4nIz; arc=none smtp.client-ip=35.89.44.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-6003a.ext.cloudfilter.net ([10.0.30.151])
	by cmsmtp with ESMTPS
	id myjcrrM0GPM1hn9HErobWW; Thu, 21 Mar 2024 03:39:36 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id n9HDrlLted4oen9HErYnvJ; Thu, 21 Mar 2024 03:39:36 +0000
X-Authority-Analysis: v=2.4 cv=aYKqngot c=1 sm=1 tr=0 ts=65fbabf8
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=UtBFqMlDG83dypD0sxEoAQ==:17
 a=IkcTkHD0fZMA:10 a=K6JAEmCyrfEA:10 a=wYkD_t78qR0A:10
 a=pzMpKnHA-g9QxEOb-IoA:9 a=QEXdDO2ut3YA:10
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=xx+crt5ANis/Uvu0cR7hGXRkyaHIWmqFF50ZDHk5Svo=; b=JLbY4nIzWuQCLgb5ICw49FDMKR
	/gzQINzFzoX6F2pjGfaO9J9u2drVa6xUl1c6zzZXdkMIikDGwHM+aNybzI4h7mquctoZL0V6fpxFG
	UNS0VuXi5ReVD1ibKpHXBlaaaLHyQ1O3mqrVxaiV4GZIyKz5gEdWQE/9+mF+OYuqBYeEq6EDQaeow
	P4sFbE1/rYZdydtTB5L3q4LClbdRtLtr56zsxXiR9/amRYqtQqK0svhm0BNpcIqolP3e0mmcDnuIz
	4V30tSlXG5ydaBoBibFWe/ub4uOi4RfU7C/5CK/8Y9+IGqBkSSSGQHME3VWCISZcbH2WfcK4qq13d
	kfzvj7Xw==;
Received: from [201.172.174.229] (port=41350 helo=[192.168.15.14])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1rn9HD-00172A-03;
	Wed, 20 Mar 2024 22:39:35 -0500
Message-ID: <fe36683b-ec78-4f83-b4ad-8dca35e4fa09@embeddedor.com>
Date: Wed, 20 Mar 2024 21:39:32 -0600
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] integrity: Avoid -Wflex-array-member-not-at-end
 warnings
Content-Language: en-US
To: Mimi Zohar <zohar@linux.ibm.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
 Kees Cook <keescook@chromium.org>
References: <ZeYKWrXvACBBrAP8@neat>
 <bbae0060d6ed7a0b033dc07e8d26c9d68585080b.camel@linux.ibm.com>
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <bbae0060d6ed7a0b033dc07e8d26c9d68585080b.camel@linux.ibm.com>
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
X-Exim-ID: 1rn9HD-00172A-03
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.14]) [201.172.174.229]:41350
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFaErk9CBxVZzo5aOgcdRjrcaqpxKZip9Jog62kCg62t6WLKbjdPzPHis/z8HAwBb4Gvji+X45uWhjqO4EGoVB4kovJ/R8EK8iKvr0Xxz//GLBgaQwbR
 mJCgeRymgtQXn7n7Md6srW9+bjW1dhQ5S7IDxwjTgdq5MXCd/FtdlLxdisSs3vHN3KOoWzu+IIh72lVHIMvyy/kTaxct/sTx/qr3Al/5ue4HVvnEI3rJduBD



On 20/03/24 19:19, Mimi Zohar wrote:
> Hi Gustavo,
> 
> Sorry for the delay...

No worries. :)

> 
> On Mon, 2024-03-04 at 11:52 -0600, Gustavo A. R. Silva wrote:
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
>> middle of another struct, we use the `struct_group_tagged()` helper to
>> separate the flexible array from the rest of the members in the flexible
>> structure:
>>
>> struct ima_digest_data {
>>          struct_group_tagged(ima_digest_data_hdr, hdr,
>>
>> 	... the rest of the members
>>
>>          );
>>          u8 digest[];
>> } __packed;
>>
>> With the change described above, we can now declare an object of the
>> type of the tagged struct, without embedding the flexible array in the
>> middle of another struct:
>>
>>   struct ima_max_digest_data {
>>          struct ima_digest_data_hdr hdr;
>>          u8 digest[HASH_MAX_DIGESTSIZE];
>>   } __packed;
>>
>> We also use `container_of()` whenever we need to retrieve a pointer to
>> the flexible structure.
> 
> Nice!
> 
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
> A similar change would need to be made to struct evm_digest:
> 
> struct evm_digest {
>          struct ima_digest_data hdr;
>          char digest[IMA_MAX_DIGEST_SIZE];
> } __packed;
> 
> Is there are another patch?

Oh, I missed that one. I'll include it and send v2, shortly.

Thanks!
--
Gustavo

