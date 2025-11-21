Return-Path: <linux-integrity+bounces-7660-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 204A2C7B97B
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Nov 2025 20:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97233A59C9
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Nov 2025 19:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553DB2E041A;
	Fri, 21 Nov 2025 19:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="drYTpxhG"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC670299931;
	Fri, 21 Nov 2025 19:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763754842; cv=none; b=mvvwv0yfDmWrybc1SdYjBo+Cx5wVwmBxyEBQLBobIMO91kAHFfh8rC1ipdc08/cDLnaGyzL4fnCu5VIsucjKiEqZV771+DAszZXImy7QduRbfhCNZN9U70CxAKNi2r7LKZJVdThKwsrdFsLk7ICzkV8xv7njqeSi858izcmodpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763754842; c=relaxed/simple;
	bh=O9bbpUQKrHol6x52s1vMoVkdVKLBpHGD/HARRVaR4HY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d8FzlUo00mwGAWOF8M+YRptzbnTihTfhMPQd+bZChh9xWQY85vsPxlz6MZwyPUzda8ydMqL/wWS58Z5tbSfPhqZALW9iKOmZaOaqMaPCEqSshwHjum2oRU+yJpP48KwcfCIG6Bh5kZel0YjdnhdPzEztUdOeET1yFq5sWQwhnu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=drYTpxhG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.232.236] (unknown [20.236.10.163])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4B55821203B1;
	Fri, 21 Nov 2025 11:53:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4B55821203B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763754839;
	bh=8wkyrbdJcd0NmYmrtFqPIBRTPhZvZjdiBtdnal/Beik=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=drYTpxhG6bNwnFCaf71MGeN9+9edF+82bJpc6fD2C06EGVO04LALA0hviIIhlHaQm
	 7bTH+b4XYRcOxwfZkkTuJUNhSJaUJQ5bRgqf4MCDPJsCik2lYvz5zIOPF2LxTKkVIM
	 KAwK9loS602DI4VpLJr0q4OObQubgc36Ty6gLLUI=
Message-ID: <1d9d1c8d-671b-4956-abb3-6f069c9f5a22@linux.microsoft.com>
Date: Fri, 21 Nov 2025 11:53:57 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 0/1] Implement IMA Event Log Trimming
To: Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
Cc: Roberto Sassu <roberto.sassu@huawei.com>,
 Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>,
 linux-security-module@vger.kernel.org,
 Steven Chen <chenste@linux.microsoft.com>,
 Gregory Lumen <gregorylumen@linux.microsoft.com>,
 Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
 Sush Shringarputale <sushring@linux.microsoft.com>
References: <20251119213359.39397-1-anirudhve@linux.microsoft.com>
 <629289c119a1a71d8d7a1208ec3676e006d4d527.camel@linux.ibm.com>
Content-Language: en-US
From: Anirudh Venkataramanan <anirudhve@linux.microsoft.com>
In-Reply-To: <629289c119a1a71d8d7a1208ec3676e006d4d527.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/2025 2:58 PM, Mimi Zohar wrote:
> On Wed, 2025-11-19 at 13:33 -0800, Anirudh Venkataramanan wrote:
>>
>>
>>   2. The kernel uses the userspace supplied PCR values to trim the IMA
>>      measurements list at a specific point, and so these are referred to as
>>      "trim-to PCR values" in this context.
>>
>>      Note that the kernel doesn't really understand what these userspace
>>      provided PCR values mean or what IMA event they correspond to, and so
>>      it does its own IMA event replay till either the replayed PCR values
>>      match with the userspace provided ones, or it runs out of events.
>>
>>      If a match is found, the kernel can proceed with trimming the IMA
>>      measurements list. This is done in two steps, to keep locking context
>>      minimal.
>>
>>      step 1: Find and return the list entry (as a count from head) of exact
>>              match. This does not lock the measurements list mutex, ensuring
>>              new events can be appended to the log.
>>
>>      step 2: Lock the measurements list mutex and trim the measurements list
>>              at the previously identified list entry.
>>
>>     If the trim is successful, the trim-to PCR values are saved as "starting
>>     PCR values". The next time userspace wants to replay the IMA event log,
>>     it will use the starting PCR values as the base for the IMA event log
>>     replay.
> 
> Depending on the IMA policy, the IMA measurement list may contain integrity
> violations, such as "ToM/ToU" (Time of Measurement/Time of Use) or "open-
> writer". Either the userspace supplied PCR values will not match any measurement
> record or the PCR values will be "fixed" to match the well known violation hash
> value extended into the TPM.  Depending on how the userspace PCR values will
> subsequently be used, saving the "fixed" PCR values could result in whitewashing
> the integrity of the measurement list.
> 

Yes, we account for this. IMA documentation [1] notes that:

"An all zeros hash indicates a measurement log violation. IMA is 
invalidating an entry. Trust in entries after that are up to the end 
user. If the Template Data Hash is all zeros, an all ones digest is 
extended."

A userspace verifier could be designed with a user option like 
"--ignore-violations". This would extend a digest of all ones in the 
event replay process and arrive at the same per-event PCR values that 
the TPM originally did. The trimming logic in the kernel would do the 
same thing.

By "whitewashing", you mean that violations will also get trimmed? Given 
that trust in entries post violation is up to the user, is this a 
problem? The IMA log itself can still be saved by userspace for further 
analysis, auditing, etc. The point of trimming is to get it out of the 
kernel memory.

Thanks!
Ani

[1] 
https://ima-doc.readthedocs.io/en/latest/event-log-format.html#template-data-hash

