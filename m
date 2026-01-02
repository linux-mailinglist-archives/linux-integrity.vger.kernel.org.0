Return-Path: <linux-integrity+bounces-8147-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC403CEEC4B
	for <lists+linux-integrity@lfdr.de>; Fri, 02 Jan 2026 15:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8EBDF300EE47
	for <lists+linux-integrity@lfdr.de>; Fri,  2 Jan 2026 14:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755FE21773D;
	Fri,  2 Jan 2026 14:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="r4VlfkmB"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA90D2153D4;
	Fri,  2 Jan 2026 14:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767364414; cv=none; b=Ac4d6i4G1AdpWUmBa1mSC8RQ/qPdiUn09mJO45bE98U0hl7GXcjnZoBv12QZBDqnyW3ECg+t+Qa+902vLytS1e1AoRXkddAv/3pUDzVhjJmFOpUFZByA5eR7H3o3ATpefDn2gKjn6fyT5v2n84YxX2kPBiUx15sDJaLVelH9xig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767364414; c=relaxed/simple;
	bh=icFKavWTxpbqVwKSos9/jvpEhvpHdMYn+jSXfuIuwsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BWOIdKgWWp/s0p2mVwtUz5Exu4LS6FS43WZCcXf16tG8Nvk04UlUCdjFdugrgMlT+tCk+sep14ejGIFscPqZHz0/QpntnY7g9b0RyuY9AQCEySsDDEhAAeqCHgAQOhB8Td2/KPRR65kryqXR1iIiPJwnYc+7EPRa5fcuYpiIKKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=r4VlfkmB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.1.91] (108-224-74-107.lightspeed.tukrga.sbcglobal.net [108.224.74.107])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6752E2124E3C;
	Fri,  2 Jan 2026 06:33:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6752E2124E3C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1767364410;
	bh=qbHG+Tw4XciLlS0G2pLKNnfrIdUptEZMMJOjYD90t04=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r4VlfkmB1uK7MTVEKERU/Obbujsp/t1CFN1mwLByJclFH5Q/CSGRjZlrnf7/ZdbNx
	 9Iuu8KDJrrSCVc+SUyoxntkHlpbZW5zgIdoYe4sgLix+t0/sD+hLWgZKb8XBr1DlTT
	 Aplb/AuddLnl9qhO8c2mnDUTDZNOvCejIAjOR5hE=
Message-ID: <4aaac6b2-54a8-496c-b456-51a2bd9ddf51@linux.microsoft.com>
Date: Fri, 2 Jan 2026 06:33:28 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 1/1] IMA event log trimming
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: roberto.sassu@huawei.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, corbet@lwn.net, serge@hallyn.com,
 paul@paul-moore.com, jmorris@namei.org,
 linux-security-module@vger.kernel.org, anirudhve@linux.microsoft.com,
 gregorylumen@linux.microsoft.com, nramas@linux.microsoft.com,
 sushring@linux.microsoft.com, linux-doc@vger.kernel.org,
 steven chen <chenste@linux.microsoft.com>
References: <20251210235314.3341-1-chenste@linux.microsoft.com>
 <20251210235314.3341-2-chenste@linux.microsoft.com>
 <d80958ec-f139-41e9-afa0-a5aca94221de@linux.microsoft.com>
 <c93907cb0f08f9baa320488989aa87e7867ee9da.camel@linux.ibm.com>
 <b9d7bcea-3784-4ad6-b494-374db0c00cc6@linux.microsoft.com>
 <9a26898f46406314be1308e5416c0d51cedf44a4.camel@linux.ibm.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <9a26898f46406314be1308e5416c0d51cedf44a4.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/23/2025 2:32 PM, Mimi Zohar wrote:
> On Tue, 2025-12-16 at 11:59 -0800, steven chen wrote:
>>>>> +{
>>>>> +	struct ima_queue_entry *qe, *qe_tmp;
>>>>> +	LIST_HEAD(ima_measurements_staged);
>>>>> +	unsigned int i;
>>>>> +	long cur = number_logs;
>>> The variable name "number_logs" is confusing.  As I mentioned in the patch
>>> description, there is one measurement list with multiple records.  There aren't
>>> multiple logs in the kernel (other than the staged list).
>> Will update it to "req_value". Thanks!
> Please refer to the section titled "Naming" in Documentation/process/coding-
> style.rst.  Since this is the number of records being deleted, perhaps a better
> variable name would be "num_records".
>
Will update. Thanks

Steven


