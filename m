Return-Path: <linux-integrity+bounces-4018-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 876659BBA62
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 17:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7388B219C9
	for <lists+linux-integrity@lfdr.de>; Mon,  4 Nov 2024 16:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D7F213632B;
	Mon,  4 Nov 2024 16:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b="fw4fj6Cl"
X-Original-To: linux-integrity@vger.kernel.org
Received: from sender4-of-o51.zoho.com (sender4-of-o51.zoho.com [136.143.188.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3181C07CF;
	Mon,  4 Nov 2024 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730738067; cv=pass; b=PxrxzOSBNPnxX1PJT/sq3zREqesOs5Y3i1YQV6bAWNqT0v10gNpd/dEJGk9hJbvGgUxu3Xls6sOVDW21Ms/W1p+T5zh6T0sQ0r8MAue9RmhajNRyHzcv9Bk+Fk999fM711sY4m4BzuqvhDo3/Geb5yM/3BwysLSRybFk3SAPzvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730738067; c=relaxed/simple;
	bh=O3ts0Sn5oGEmmtyGPHBGZeZGhbMncFy6kasQkaU0P2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fqciQ6nJY/OmVuyMLqB71yK3OmO2wWn8MjMqPoAPzOkPlCQDiUd8jEFzKAwOtgfN6ksxDT4gwoTi3H4IK77UHFwXFr997bGwr0YJiTBBnsQwtGJOWdYyyJQzYrp3mdYF6u6OtrrmxkLZBG+qXyGuObAqhtcP2i/5/tX5lgkJ22I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com; spf=pass smtp.mailfrom=apertussolutions.com; dkim=pass (1024-bit key) header.d=apertussolutions.com header.i=dpsmith@apertussolutions.com header.b=fw4fj6Cl; arc=pass smtp.client-ip=136.143.188.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apertussolutions.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apertussolutions.com
ARC-Seal: i=1; a=rsa-sha256; t=1730738049; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Q2PiTkVcUbcGRzJTo/jvoQgUSofZND60VcOH/YQfW9Bn5jgBx2kJ929Y4vB+w1pMdFZckvCjYMN2IV8FzMQxXoosV0rtHG+0QzPdA0ocvSRtI6Amvv7n8MTyV6px5Hx4mW2N3JfYRfXUGI4t5UWpR1DYsE+myRqhbib6YySeJmo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1730738049; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rsrQF6JmRXZQE7tb3or5gcxfQ5EVQBWdPFCL/XboCU4=; 
	b=oMAFBe6Jz9EEMImxPVn4jBE7wj0SJJ9X4BqAj+pmYHGvQbaegW4ONSTzyupOVj3VfjoyjDBWId87NTFBhUjv5jYkAM1qpx03/cOOENs/CAdph3svAuNAmaCKPz6uf9Qy5oh4LRZgFasYOk389Ash/kNao5ymO7Akd+K9VeSNSKA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=apertussolutions.com;
	spf=pass  smtp.mailfrom=dpsmith@apertussolutions.com;
	dmarc=pass header.from=<dpsmith@apertussolutions.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1730738049;
	s=zoho; d=apertussolutions.com; i=dpsmith@apertussolutions.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=rsrQF6JmRXZQE7tb3or5gcxfQ5EVQBWdPFCL/XboCU4=;
	b=fw4fj6ClNoVpQVxUnVZ3q9VlZ1qG0zOXKaC7uZkU2gM6QTu0B3QCyUxXBQWpxhoG
	bfWkjSc9Ethcu3C/ueWSaXLDKh2Ox/A2chz4pHtwJjOr1FkkqgH9bhYGXMfGC6FkvnV
	O4xxgKGWpEKClxGbMt/ztuAubTNXG+nmjgXIP9VU=
Received: by mx.zohomail.com with SMTPS id 1730738048053964.0860644735224;
	Mon, 4 Nov 2024 08:34:08 -0800 (PST)
Message-ID: <102f7de4-a2d0-4315-9bce-6489504180fb@apertussolutions.com>
Date: Mon, 4 Nov 2024 11:34:06 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/4] Alternative TPM patches for Trenchboot
To: James Bottomley <James.Bottomley@HansenPartnership.com>,
 Ard Biesheuvel <ardb@kernel.org>
Cc: Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
 Ross Philipson <ross.philipson@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, Peter Huewe <peterhuewe@gmx.de>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 "open list:TPM DEVICE DRIVER" <linux-integrity@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, trenchboot-devel@googlegroups.com
References: <20241102152226.2593598-1-jarkko@kernel.org>
 <D5BW0P0HH0QL.7Y4HBLJGEDL8@kernel.org>
 <e745226d-4722-43ed-86ad-89428f56fcba@apertussolutions.com>
 <D5DCPWBQ2M7H.GAUEVUKGC3G0@kernel.org>
 <CAMj1kXGd5KAXiFr3rEq3cQK=_970b=eRT4X6YKVSj2PhN6ACrw@mail.gmail.com>
 <97d4e1a0-d86e-48a9-ad31-7e53d6885a96@apertussolutions.com>
 <CAMj1kXFEJYVs7p6QLEAU-T+xfoWhkFi=PE9QpJ4Oo4oh3eM38Q@mail.gmail.com>
 <7b324454-bc34-4cc4-bd12-99268a543508@apertussolutions.com>
 <3bc70b659c1c86c0f08c6d91a6d894ce58825e04.camel@HansenPartnership.com>
Content-Language: en-US
From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
In-Reply-To: <3bc70b659c1c86c0f08c6d91a6d894ce58825e04.camel@HansenPartnership.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 11/4/24 08:21, James Bottomley wrote:
> On Mon, 2024-11-04 at 07:19 -0500, Daniel P. Smith wrote:
>> On 11/4/24 06:55, 'Ard Biesheuvel' via trenchboot-devel wrote:
> [...]
>>> I was referring specifically to the read-write sysfs node that
>>> permits user space to update the default TPM locality. Does it need
>>> to be writable? And does it need to exist at all?
> 
> This was my question here, which never got answered as well:
> 
> https://lore.kernel.org/linux-integrity/685f3f00ddf88e961e2d861b7c783010774fe19d.camel@HansenPartnership.com/
> 
>> Right, sorry. As I recall, that was introduce due to the sequence of
>> how the TPM driver handled locality, moving back to Locality 0 after
>> done sending cmds. In the Oracle implementation, the initramfs takes
>> integrity measurements of the environment it is about to kexec into,
>> eg.  target kernel, initramfs, file system, etc. Some of these
>> measurements should go into PCR 17 and PCR 18, which requires
>> Locality 2 to be able extend those PCRs. If the slmodule is able to
>> set the locality for all PCR extends coming from user space to be
>> Locality 2, that removes the current need for it.
> 
> Well, no, that's counter to the desire to have user space TPM commands
> and kernel space TPM commands in different localities.  I thought the
> whole point of having locality restricted PCRs is so that only trusted
> entities (i.e. those able to access the higher locality) could extend
> into them.  If you run every TPM command, regardless of source, in the
> trusted locality, that makes the extends accessible to everyone and
> thus destroys the trust boundary.

As to Locality switching:
The call sequence is,
   tpm_pcr_extend -> tpm_find_get_ops -> tpm_try_get_ops ->
     tpm_chip_start -> if (chip->locality == -1) tpm_request_locality
And when the extend completes:
   out: tpm_put_ops -> tpm_chip_stop -> tpm_relinquish_locality ->
     chip->locality = -1;

We made slmodule set the locality value used by request/relinquish back 
to 0 when it was done with its initialization and then the sysfs nodes 
to allow the runtime to request it when it needed to send measurements. 
This is because we did not want to pin how it works to the one use case
currently focused on.

By definition I provided earlier, in our use case the initramfs is part 
of the TCB as it is embedded into the kernel. As to the locality roles, 
according to TPM Platform Profile:
  - Locality 2: Dynamically Launched OS (Dynamic OS) “runtime” environment.
  - Locality 1: An environment for use by the Dynamic OS.

> It also doesn't sound like the above that anything in user space
> actually needs this facility.  The measurements of kernel and initramfs
> are already done by the boot stub (to PCR9, but that could be changed)
> so we could do it all from the trusted entity.

I apologies for not expressing this clearer, as that statement is 
incorrect. The currently deployed use case works as follows:

[SRTM] --> [GRUB] -- (DLE, terminates SRTM chain) -->
   [CPU] -- (starts DRTM chain) --> [SINIT ACM] -->
   [SL kernel + initramfs] -- (load/measure/kexec) --> [target kernel]

As one can see, the SRTM is terminated and its components are not used 
in the DRTM chain. This model reproduces the tboot model, with several 
enhancements, including the ability for a single solution that supports 
and works on Intel, AMD, and we are currently enabling Arm. It is not 
the only model that can be used, which several were presented at 2020 
Plumbers. A detailed version of a deployed implementation of the secure 
upgrade use case was detailed in the 2021 FOSSDEM presentation. Where 
the LCP policy is used to tell the ACM what [SL kernel + initramfs] are 
allowed to be started by TXT. This allows the ability to launch into an 
upgrade state without having to reboot.

In case the question comes up from those not familiar, the kexec does an 
GETSEC[SEXIT] which closes off access to Localities 1 and 2, thus 
locking the DRTM PCR values. It brings the CPUs out of SMX mode so the 
target kernel does not require to have any knowledge about running in 
that mode.

v/r,
dps

