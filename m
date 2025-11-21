Return-Path: <linux-integrity+bounces-7659-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 049D3C7B73E
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Nov 2025 20:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9361034859E
	for <lists+linux-integrity@lfdr.de>; Fri, 21 Nov 2025 19:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E5CA2D248C;
	Fri, 21 Nov 2025 19:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="J0AfYHWt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB4B25334B;
	Fri, 21 Nov 2025 19:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763752406; cv=none; b=bVum+/NW8S7tEWHtZ/hHAM+4Ya+GTB4wLPbrU3evJrbY2B1LA5/qzigTbof8/T2zFVyJMyQkr3Unom68JOVIfNQlx4ztRpCO5IljmGYQ/yyX4m2REE+pxakZPXp08Vn+2WnNKwv0iZZLTc+jNIaI26FV+cCR2mRmFqa9ZypAqQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763752406; c=relaxed/simple;
	bh=oMpkdV/F67SlPK3dILmfMTsyYab3OdshdHQ95AVKtmE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CmKaKD0U7QEn9homii5KwURKDoRUEbYw2yQizzAeVbl6JdaInYiZ31HJIj/vTjU4jnrKwb2T4JBiHLHgm9mp+ppRusdGR1qds0oZzknHtXA/sJI5MPsIYe/D0MrWgyGXALmCyu5haVJ+SCSIiojZ+d+sCJZa014pHtak2UyLGds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=J0AfYHWt; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [100.65.232.236] (unknown [20.236.10.120])
	by linux.microsoft.com (Postfix) with ESMTPSA id 1F54C2120702;
	Fri, 21 Nov 2025 11:13:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1F54C2120702
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1763752402;
	bh=PyWREj6CmooOdtxayAxYR2wMPsxJdXeYh8HnDvBb5Mw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J0AfYHWtP0IlKinYDG00WNqVSOZ8Uv/4BHyElJwi3w81b3ejGcNz8kUBYvygfRG6X
	 jvYHIypqWDf6e6ciPky6shzi7rqEvtOABrzRVPCUdToKTegAjX1SoM+JJ5FSJh/YL6
	 g/aWRm8wSenap7V64dZkRl/zhwPLG85f05C+MINs=
Message-ID: <a77e9609-f6bd-4e6d-88be-5422f780b496@linux.microsoft.com>
Date: Fri, 21 Nov 2025 11:13:20 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v1 0/1] Implement IMA Event Log Trimming
To: Roberto Sassu <roberto.sassu@huaweicloud.com>,
 linux-integrity@vger.kernel.org
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu
 <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
 Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>,
 James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>,
 linux-security-module@vger.kernel.org,
 Steven Chen <chenste@linux.microsoft.com>,
 Gregory Lumen <gregorylumen@linux.microsoft.com>,
 Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
 Sush Shringarputale <sushring@linux.microsoft.com>
References: <20251119213359.39397-1-anirudhve@linux.microsoft.com>
 <7722dff4e68ef5fb7f39bd732a8a77422bad5549.camel@huaweicloud.com>
Content-Language: en-US
From: Anirudh Venkataramanan <anirudhve@linux.microsoft.com>
In-Reply-To: <7722dff4e68ef5fb7f39bd732a8a77422bad5549.camel@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/20/2025 3:02 AM, Roberto Sassu wrote:
> On Wed, 2025-11-19 at 13:33 -0800, Anirudh Venkataramanan wrote:
>> ==========================================================================
>>> A. Introduction                                                        |
>> ==========================================================================
>>
>> IMA events are kept in kernel memory and preserved across kexec soft
>> reboots. This can lead to increased kernel memory usage over time,
>> especially with aggressive IMA policies that measure everything. To reduce
>> memory pressure, it becomes necessary to discard IMA events but given that
>> IMA events are extended into PCRs in the TPM, just discarding events will
>> break the PCR extension chain, making future verification of the IMA event
>> log impossible.
>>
>> This patch series proposes a method to discard IMA events while keeping the
>> log verifiable. While reducing memory pressure is the primary objective,
>> the second order benefit of trimming the IMA log is that IMA log verifiers
>> (local userspace daemon or a remote cloud service) can process smaller IMA
>> logs on a rolling basis, thus avoiding re-verification of previously
>> verified events.
> 
> Hi Anirudh

Hi Roberto,

Thanks for the feedback! Few questions below.

> 
> I will rephrase this paragraph, to be sure that I understood it
> correctly.
> 
> You are proposing a method to trim the measurement list and, at the
> same time, to keep the measurement list verifiable after trimming. The
> way you would like to achieve that is to keep the verification state in
> the kernel in the form of PCR values.
> 
> Those values mean what verifiers have already verified. Thus, for the
> next verification attempt, verifiers take the current PCR values as
> starting values, replay the truncated IMA measurement list, and again
> you match with the current PCR values and you trim until that point.
> 
> So the benefit of this proposal is that you keep the verification of
> the IMA measurement list self-contained by using the last verification
> state (PCR starting value) and the truncated IMA measurement list as
> the inputs of your verification.

Your understanding as described above is correct.

> 
> Let me reiterate on the trusted computing principles IMA relies on for
> providing the evidence about a system's integrity.
> 
> Unless you are at the beginning of the measurement chain, where the
> Root of Trust for Measurement (RTM) is trusted by assumption, the
> measurements done by a component can be trusted because that component
> was already measured by the previous component in the boot chain,
> before it had any chance to corrupt the system.
> 
> In the context of IMA, IMA can be trusted to make new measurements
> because it measures every file before those files could cause any harm
> to the system. So, potentially IMA and the kernel can be corrupted by
> any file.
> 
> What you are proposing would not work, because you are placing trust in
> an input (the PCR starting value) that can be manipulated at any time
> by a corrupted kernel, before you had the chance to detect such
> corruption.

If starting PCR values can be corrupted, the IMA measurements list can 
also be corrupted, right?

More generally, what integrity guarantees can be provided (if any) if 
the kernel itself is corrupted?

> 
> Let me describe a scenario where I could take advantage of such
> weakness. After the first measurement list trim, I perform an attack on
> the system such that it corrupts the kernel. IMA added a new entry in
> the measurement list, which would reveal the attack.
> 
> But, since I have control of the kernel, I conveniently update the PCR
> starting value to replay the new measurement entry, and remove the
> measurement entry from the measurement list.
> 
> Now, from the perspective of the user space verifiers everything is
> fine, the truncated IMA measurement list is clean, no attack, and the
> current PCR values match by replaying the new PCR starting value with
> the remaining of the IMA measurement list.

Wouldn't the verifier detect the attack when it sees that its 
recalculated PCR values don't match up to the PCR digest in the TPM quote?

> 
> So, in my opinion the kernel should just offer the ability to trim the
> measurement list, and a remote verifier should be responsible to verify
> the measurement list, without relying on anything from the system being
> evaluated.
> 
> Sure, the remote verifier can verify just the trimmed IMA measurement
> list, but the remote verifier must solely rely on state information
> maintained internally.
> 
> Roberto
> 
>> The method has other advantages too:
>>
>>   1. It provides a userspace interface that can be used to precisely control
>>      trim point, allowing for trim points to be optionally aligned with
>>      userspace IMA event log validation.
>>
>>   2. It ensures that all necessary information required for continued IMA
>>      log validation is made available via the userspace interface at all
>>      times.
>>
>>   3. It provides a simple mechanism for userspace applications to determine
>>      if the event log has been unexpectedly trimmed.
>>
>>   4. The duration for which the IMA Measurement list mutex must be held (for
>>      trimming) is minimal.
>>
>> ==========================================================================
>>> B. Solution                                                            |
>> ==========================================================================
>>
>> --------------------------------------------------------------------------
>>> B.1 Overview                                                           |
>> --------------------------------------------------------------------------
>>
>> The kernel trims the IMA event log based on PCR values supplied by userspace.
>> The core principles leveraged are as follows:
>>
>>   - Given an IMA event log, PCR values for each IMA event can be obtained by
>>     recalulating the PCR extension for each event. Thus processing N events
>>     from the start will yield PCR values as of event N. This is referred to
>>     as "IMA event log replay".
>>
>>   - To get the PCR value for event N + 1, only the PCR value as of event N
>>     is needed. If this can be known, events till and including N can be
>>     safely purged.
>>
>> Putting it all together, we get the following userspace + kernel flow:
>>
>>   1. A userspace application replays the IMA event log to generate PCR
>>      values and then triggers a trim by providing these values to the kernel
>>      (by writing to a pseudo file).
>>
>>      Optionally, the userspace application may verify these PCR values
>>      against the corresponding TPM quote, and trigger trimming only if
>>      the calculated PCR values match up to the expectations in the quote's
>>      PCR digest.
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
>>
>> --------------------------------------------------------------------------
>>> B.2 Kernel Interfaces                                                  |
>> --------------------------------------------------------------------------
>>
>> A new configfs pseudo file /sys/kernel/config/ima/pcrs that supports the
>> following operations is exposed.
>>
>>    read: returns starting PCR values stored in the kernel (within IMA
>>          specifically).
>>
>>   write: writes trim-to PCR values to trigger trimming. If trimming is
>>          successful, trim-to PCR values are stored as starting PCR values.
>>          requires root privileges.
>>
>> --------------------------------------------------------------------------
>>> B.3 Walk-through with a real example                                   |
>> --------------------------------------------------------------------------
>>
>> This is a real example from a test run.
>>
>> Suppose this IMA policy is deployed:
>>
>>    measure func=FILE_CHECK mask=MAY_READ pcr=10
>>    measure func=FILE_CHECK mask=MAY_WRITE pcr=11
>>
>> When the policy is deployed, a zero digest starting PCR value will be set
>> for each PCR used. If the TPM supports multiple hashbanks, there will be
>> one starting PCR value per PCR, per TPM hashbank. This can be seen in the
>> following hexdump:
>>
>> $ sudo hexdump -vC /sys/kernel/config/ima/pcrs
>> 00000000  70 63 72 31 30 3a 73 68  61 31 3a 00 00 00 00 00  |pcr10:sha1:.....|
>> 00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 70  |...............p|
>> 00000020  63 72 31 31 3a 73 68 61  31 3a 00 00 00 00 00 00  |cr11:sha1:......|
>> 00000030  00 00 00 00 00 00 00 00  00 00 00 00 00 00 70 63  |..............pc|
>> 00000040  72 31 30 3a 73 68 61 32  35 36 3a 00 00 00 00 00  |r10:sha256:.....|
>> 00000050  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
>> 00000060  00 00 00 00 00 00 00 00  00 00 00 70 63 72 31 31  |...........pcr11|
>> 00000070  3a 73 68 61 32 35 36 3a  00 00 00 00 00 00 00 00  |:sha256:........|
>> 00000080  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
>> 00000090  00 00 00 00 00 00 00 00  70 63 72 31 30 3a 73 68  |........pcr10:sh|
>> 000000a0  61 33 38 34 3a 00 00 00  00 00 00 00 00 00 00 00  |a384:...........|
>> 000000b0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
>> 000000c0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
>> 000000d0  00 00 00 00 00 70 63 72  31 31 3a 73 68 61 33 38  |.....pcr11:sha38|
>> 000000e0  34 3a 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |4:..............|
>> 000000f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
>> 00000100  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
>> 00000110  00 00                                             |..|
>> 00000112
>>
>> Let's say that a userspace utility replays the IMA event log, and triggers
>> trimming by writing the following PCR values (i.e. trim-to PCR values) to the
>> pseudo file:
>>
>> pcr10:sha256:8268782906555cf3aefc179f815c878527dd4e67eaa836572ebabab31977922c
>> pcr11:sha256:4c7f31927183eacb53d51d95b0162916fd3fca51a8d1efc6dde3805eb891fe41
>>
>> The trim is successful,
>>
>> 1. Some number of entries from the measurements log will disappear. This
>>     can be verified by reading out the ASCII or binary IMA measurements
>>     file.
>>
>> 2. The trim-to PCR values are saved as starting PCR values. This can be
>>     verified by reading out the pseudo file again as shown below. Note that
>>     even through only sha256 PCR values were written, the kernel populated
>>     sha1 and sha384 starting values as well.
>>
>> $ sudo hexdump -vC /sys/kernel/config/ima/pcrs
>>
>> 00000000  70 63 72 31 30 3a 73 68  61 31 3a c4 7f 9d 00 68  |pcr10:sha1:....h|
>> 00000010  e4 86 71 bf bc ae f0 10  12 ff 68 e2 9e 74 e4 70  |..q.......h..t.p|
>> 00000020  63 72 31 31 3a 73 68 61  31 3a 90 d7 17 ac 60 4d  |cr11:sha1:....`M|
>> 00000030  c8 25 ce 77 7d 9d 94 cf  44 7b b2 2e 2e e2 70 63  |.%.w}...D{....pc|
>> 00000040  72 31 30 3a 73 68 61 32  35 36 3a 82 68 78 29 06  |r10:sha256:.hx).|
>> 00000050  55 5c f3 ae fc 17 9f 81  5c 87 85 27 dd 4e 67 ea  |U\......\..'.Ng.|
>> 00000060  a8 36 57 2e ba ba b3 19  77 92 2c 70 63 72 31 31  |.6W.....w.,pcr11|
>> 00000070  3a 73 68 61 32 35 36 3a  4c 7f 31 92 71 83 ea cb  |:sha256:L.1.q...|
>> 00000080  53 d5 1d 95 b0 16 29 16  fd 3f ca 51 a8 d1 ef c6  |S.....)..?.Q....|
>> 00000090  dd e3 80 5e b8 91 fe 41  70 63 72 31 30 3a 73 68  |...^...Apcr10:sh|
>> 000000a0  61 33 38 34 3a 8e d6 12  18 b1 d6 cd 95 16 98 33  |a384:..........3|
>> 000000b0  2b 7d a2 d6 d9 05 c7 e8  5b 15 b0 91 c5 fc 23 d1  |+}......[.....#.|
>> 000000c0  f9 a8 8d 60 50 5c e9 64  5f d7 b3 b2 f1 9c 90 0a  |...`P\.d_.......|
>> 000000d0  45 53 5d b2 57 70 63 72  31 31 3a 73 68 61 33 38  |ES].Wpcr11:sha38|
>> 000000e0  34 3a 25 fc 21 28 31 5a  f7 c6 fb 0f 40 c9 06 e6  |4:%.!(1Z....@...|
>> 000000f0  c5 da ed 20 61 a1 03 54  4f 67 18 88 82 0f 48 d1  |... a..TOg....H.|
>> 00000100  2f e0 3d 36 46 5e 94 a4  88 51 f8 91 39 7e e5 97  |/.=6F^...Q..9~..|
>> 00000110  2c c5                                             |,.|
>> 00000112
>>
>> --------------------------------------------------------------------------
>>> C. Footnotes                                                           |
>> --------------------------------------------------------------------------
>>
>> 1. The 'pcrs' pseudo file is currently part of configfs. This was due to
>>     some early internal feedback in a different context. This can as well be
>>     in securityfs with the rest of the IMA pseudo files.
>>
>> 2. PCR values are never read out of the TPM at any point. All PCR values
>>     used are derived from IMA event log replay.
>>
>> 3. Code is "RFC quality". Refinements can be made if the method is accepted.
>>
>> 4. For functional validation, base kernel version was 6.17 stable, with the
>>     most recent tested version being 6.17.8.
>>
>> 5. Code has been validated to some degree using a python-based internal test
>>     tool. This can be published if there is community interest.
>>
>> Steven Chen (1):
>>    ima: Implement IMA event log trimming
>>
>>   drivers/Kconfig                       |   2 +
>>   drivers/Makefile                      |   1 +
>>   drivers/ima/Kconfig                   |  13 +
>>   drivers/ima/Makefile                  |   2 +
>>   drivers/ima/ima_config_pcrs.c         | 291 ++++++++++++++++++
>>   include/linux/ima.h                   |  27 ++
>>   security/integrity/ima/Makefile       |   4 +
>>   security/integrity/ima/ima.h          |   8 +
>>   security/integrity/ima/ima_init.c     |  44 +++
>>   security/integrity/ima/ima_log_trim.c | 421 ++++++++++++++++++++++++++
>>   security/integrity/ima/ima_policy.c   |   7 +-
>>   security/integrity/ima/ima_queue.c    |   5 +-
>>   12 files changed, 821 insertions(+), 4 deletions(-)
>>   create mode 100644 drivers/ima/Kconfig
>>   create mode 100644 drivers/ima/Makefile
>>   create mode 100644 drivers/ima/ima_config_pcrs.c
>>   create mode 100644 security/integrity/ima/ima_log_trim.c
>>
> 


