Return-Path: <linux-integrity+bounces-7924-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B0BCB7084
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 20:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A37D300183C
	for <lists+linux-integrity@lfdr.de>; Thu, 11 Dec 2025 19:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 239E62BDC3F;
	Thu, 11 Dec 2025 19:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="dnWwjBI7"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85F07258CD9;
	Thu, 11 Dec 2025 19:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765482451; cv=none; b=bKbOtcpI6oiN4Bk+gSKeI3q+4Q2XhwZbw6TZNBIVhyOHzAWsNM8jBbkOg70fUip9AcQKOYng6ghIhla27zz1jK8zc0rZeJB4yxotDIDLtII708QGmNkJTVjrbQZwLMvPC4uNZ9iHoRA1Cc7o5gMv6BapV5uvkVGzfSW7RxS0OfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765482451; c=relaxed/simple;
	bh=LoOPCQcUMjoYFouhC/Ilgjou9PIAfIpYQTuSBYhCktE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m86K+Qtj6ythidJDChQn3Vm62t+a6Klh1jm4XDXiIBA6Gjwx3bSG9M8O9+N/biSU38M3qZXa1cdtwe9FXVQT50xK5Ms8s6fQ0SJaj/9q4cU+IULkUwLEApYT2shjRlqqx8U475ryoUn5ucafOQ5WhEBkMucH18FOMSZQ/XqfcbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=dnWwjBI7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [10.17.64.150] (unknown [131.107.8.22])
	by linux.microsoft.com (Postfix) with ESMTPSA id 7EE392016010;
	Thu, 11 Dec 2025 11:47:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7EE392016010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1765482448;
	bh=7yPVbpgvZ9W1EUrUdFBO7HKSQiuoVNNeKCzKRzuYK2I=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=dnWwjBI72KS5eubDv/iGMOePiSsru122Ed8hBChxIHGP67O3vw0UAZ7wucVke93vS
	 56aJfFUW2WSOYW09hOBYto5OlnnneYlj5KBHET4y8rWA+YA11Fvy/Odaa5qI/wPfhP
	 Jm9G7Kqi0zWHhaMOGgR3ZKZvTs+QnvXqduYQG5Ew=
Message-ID: <d736d6cf-4582-4b53-8b23-1a15bd2ec2f4@linux.microsoft.com>
Date: Thu, 11 Dec 2025 11:47:27 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC][PATCH] ima: Add support for staging measurements for
 deletion
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
 Gregory Lumen <gregorylumen@linux.microsoft.com>
Cc: corbet@lwn.net, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com,
 eric.snowberg@oracle.com, paul@paul-moore.com, jmorris@namei.org,
 serge@hallyn.com, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org,
 nramas@linux.microsoft.com, Roberto Sassu <roberto.sassu@huawei.com>,
 steven chen <chenste@linux.microsoft.com>
References: <20251209101725.3680225-1-roberto.sassu@huaweicloud.com>
 <207fd6d7-53c-57bb-36d8-13a0902052d1@linux.microsoft.com>
 <d7418d0afa696b8da67e4f25fd0dc1b9d6fd908f.camel@huaweicloud.com>
Content-Language: en-US
From: steven chen <chenste@linux.microsoft.com>
In-Reply-To: <d7418d0afa696b8da67e4f25fd0dc1b9d6fd908f.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/11/2025 1:56 AM, Roberto Sassu wrote:
> On Wed, 2025-12-10 at 11:12 -0800, Gregory Lumen wrote:
>> Roberto,
>>
>> The proposed approach appears to be workable. However, if our primary goal
>> here is to enable UM to free kernel memory consumed by the IMA log with an
>> absolute minimum of kernel functionality/change, then I would argue that
>> the proposed Stage-then-delete approach still represents unnecessary
>> complexity when compared to a trim-to-N solution. Specifically:
>>
>> - Any functional benefit offered through the introduction of a staged
>> measurement list could be equally achieved in UM with a trim-to-N solution
>> coupled with the proposed ima_measure_users counter for access locking.
> Ok, let's quantify the complexity of each solution. Let's assume that
> the IMA measurements list has M entries and you want to trim at N < M.
>
> Staging:
>
> 1st. trim at N
>
> (kernel)
> 1. list lock (write side) -> list replace (swap the heads) -> list unlock
> 2. read M -> file (file contains 0..M)
> 3. for each 0..M -> delete entry
>
> (user)
> 1. for each 0..N in file -> replay PCR
> 2. trim at N (keep N + 1..M)
>
>
> 2nd. trim at O
>
> (kernel)
> 1. list lock -> list replace (swap the heads) -> list unlock
> 2. read P -> file (file contains N + 1..P)
> 3. for each M + 1..P -> delete entry
>
> (user)
> 1. for each N + 1..O in file -> replay PCR
> 2. trim at O (keep O + 1..P)
>
>
>
> Trimming:
>
> 1st. trim at N
>
> (kernel)
> 1. list lock (read side) -> for each 0..M -> read in file (file now contains 0..M) -> list unlock
>
> (user)
> 1. for each 0..N -> replay PCR
> 2. discard N + 1..M
>
> (kernel)
>
> 1. list lock (write side) -> for each 0..N -> trim -> list unlock
>
>
> 2nd. trim at O
>
> (kernel)
> 1. list lock (read side) -> for each N + 1..P -> read in file (file now contains N + 1..P) -> list unlock
>
> (user)
> 1. for each N + 1..O -> replay PCR
> 2. discard O + 1..P
>
> (kernel)
>
> 1. list lock (write side) -> for each N + 1..O -> trim -> list unlock
>
>
> You can try to optimize it a bit by prematurely ending the reading
> before M and P, and by replaying the PCR on a partial buffer.
>
>
> But still:
>
> I just swap list heads in the hot path (still need to do the same for
> the hash table, postponed to later), and do the free later once there
> is no contention with new measurements.
>
> In your case you are taking the lock and walking the list two times,
> once as a reader and once as a writer, and discarding measurements in
> user space that you already have.
>
> I think your solution is more complex.
This is not the case, please check the released version 2 of trim N 
entries patch as bellow:

[PATCH v2 0/1] Trim N entries of IMA event logs
<https://lore.kernel.org/linux-integrity/20251210235314.3341-1-chenste@linux.microsoft.com/T/#t>


The following are the steps for trim N solution:
     User space reads list without lock
     User space decides to trim N entries and send command to kernel
     Kernel will lock the list use the same or less time as staged 
solution use

All work done.

>
>> - There exists a potential UM measurement-loss race condition introduced
>> by the staging functionality that would not exist with a trim-to-N
>> approach. (Occurs if a kexec call occurs after a UM agent has staged
>> measurements for deletion, but has not completed copying them to
>> userspace). This could be avoided by persisting staged measurements across
>> kexec calls at the cost of making the proposed change larger.
> The solution is to coordinate the staging with kexec in user space.
>
>
> Roberto



