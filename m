Return-Path: <linux-integrity+bounces-177-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63AFE7F3AF6
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 02:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 44187B21371
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Nov 2023 01:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9275138D;
	Wed, 22 Nov 2023 01:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SgyEA36N"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0ED68197;
	Tue, 21 Nov 2023 17:01:41 -0800 (PST)
Received: from [192.168.86.69] (unknown [50.46.228.62])
	by linux.microsoft.com (Postfix) with ESMTPSA id CD13920B74C0;
	Tue, 21 Nov 2023 17:01:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CD13920B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1700614900;
	bh=HbRh+tVXzcEae7WnOeARgNufEiTgkxOEUKje4fiF4Xo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=SgyEA36NCuW4YyxFnAsWvVeUwVMZ9/wxu2D0E0sYCCtrdxSXO4fKREJKsOBj2OKEu
	 hqvs27EmAJgRNkjdNVJEPEfiMZNsmu3L62+aDttMybQyri98oy4afwhMznyS44Yu8s
	 /KGxLicwehNTHHKxl/Exl6B5jwA+V69HtmVdvyes=
Message-ID: <e0cf16b3-514e-45bd-b6f8-7638ed57b00e@linux.microsoft.com>
Date: Tue, 21 Nov 2023 17:01:38 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>, Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
 Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca,
 Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com, vgoyal@redhat.com,
 Dave Young <dyoung@redhat.com>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>, jmorris@namei.org,
 serge@hallyn.com, James Bottomley <James.Bottomley@hansenpartnership.com>,
 linux-security-module@vger.kernel.org,
 Tyler Hicks <tyhicks@linux.microsoft.com>,
 Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
 Sush Shringarputale <sushring@linux.microsoft.com>
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <8bff2bf1a4629aacec7b6311d77f233cb75b2f8a.camel@linux.ibm.com>
 <CAHC9VhRm9Tzz3C-VTdXS4s1_-kPQQ6RXMt8JGCS4jorJ0VURyQ@mail.gmail.com>
From: Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <CAHC9VhRm9Tzz3C-VTdXS4s1_-kPQQ6RXMt8JGCS4jorJ0VURyQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/16/23 14:28, Paul Moore wrote:
> On Tue, Oct 31, 2023 at 3:15 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>> On Thu, 2023-10-19 at 11:49 -0700, Tushar Sugandhi wrote:
>>
>> [...]
>>> -----------------------------------------------------------------------
>>> | C.1 Solution Summary                                                |
>>> -----------------------------------------------------------------------
>>> To achieve the goals described in the section above, we propose the
>>> following changes to the IMA subsystem.
>>>
>>>       a. The IMA log from Kernel memory will be offloaded to some
>>>          persistent storage disk to keep the system running reliably
>>>          without facing memory pressure.
>>>          More details, alternate approaches considered etc. are present
>>>          in section "D.3 Choices for Storing Snapshots" below.
>>>
>>>       b. The IMA log will be divided into multiple chunks (snapshots).
>>>          Each snapshot would be a delta between the two instances when
>>>          the log was offloaded from memory to the persistent storage
>>>          disk.
>>>
>>>       c. Some UM process (like a remote-attestation-client) will be
>>>          responsible for writing the IMA log snapshot to the disk.
>>>
>>>       d. The same UM process would be responsible for triggering the IMA
>>>          log snapshot.
>>>
>>>       e. There will be a well-known location for storing the IMA log
>>>          snapshots on the disk.  It will be non-trivial for UM processes
>>>          to change that location after booting into the Kernel.
>>>
>>>       f. A new event, "snapshot_aggregate", will be computed and measured
>>>          in the IMA log as part of this feature.  It should help the
>>>          remote-attestation client/service to benefit from the IMA log
>>>          snapshot feature.
>>>          The "snapshot_aggregate" event is described in more details in
>>>          section "D.1 Snapshot Aggregate Event" below.
>>>
>>>       g. If the existing remote-attestation client/services do not change
>>>          to benefit from this feature or do not trigger the snapshot,
>>>          the Kernel will continue to have it's current functionality of
>>>          maintaining an in-memory full IMA log.
>>>
>>> Additionally, the remote-attestation client/services need to be updated
>>> to benefit from the IMA log snapshot feature.  These proposed changes
>>>
>>> are described in section "D.4 Remote-Attestation Client/Service Side
>>> Changes" below, but their implementation is out of scope for this
>>> proposal.
>>
>> As previously said on v1,
>>     This design seems overly complex and requires synchronization between the
>>     "snapshot" record and exporting the records from the measurement list. [...]
>>
>>     Concerns:
>>     - Pausing extending the measurement list.
>>
>> Nothing has changed in terms of the complexity or in terms of pausing
>> the measurement list.   Pausing the measurement list is a non starter.
> 
> The measurement list would only need to be paused for the amount of
> time it would require to generate the snapshot_aggregate entry, which
> should be minimal and only occurs when a privileged userspace requests
> a snapshot operation.  The snapshot remains opt-in functionality, and
> even then there is the possibility that the kernel could reject the
> snapshot request if generating the snapshot_aggregate entry was deemed
> too costly (as determined by the kernel) at that point in time.
> 
Thanks Paul for responding and sharing your thoughts.


Hi Mimi,
To address your concern about pausing the measurements -
We are not proposing to pause the measurements for the entire duration
of UM <--> Kernel interaction while taking a snapshot.

We are simply proposing to pause the measurements when we get the TPM
PCR quotes to add them to "snapshot_aggregate". (which should be a very
small time window). IMA already has this mechanism when two separate
modules try to add entry to IMA log - by using
mutex_lock(&ima_extend_list_mutex); in ima_add_template_entry.


We plan to use this existing locking functionality.
Hope this addresses your concern about pausing extending the measurement
list.

~Tushar

>> Userspace can already export the IMA measurement list(s) via the
>> securityfs {ascii,binary}_runtime_measurements file(s) and do whatever
>> it wants with it.  All that is missing in the kernel is the ability to
>> trim the measurement list, which doesn't seem all that complicated.
> 
>>From my perspective what has been presented is basically just trimming
> the in-memory measurement log, the additional complexity (which really
> doesn't look that bad IMO) is there to ensure robustness in the face
> of an unreliable userspace (processes die, get killed, etc.) and to
> establish a new, transitive root of trust in the newly trimmed
> in-memory log.
> 
> I suppose one could simplify things greatly by having a design where
> userspace  captures the measurement log and then writes the number of
> measurement records to trim from the start of the measurement log to a
> sysfs file and the kernel acts on that.  You could do this with, or
> without, the snapshot_aggregate entry concept; in fact that could be
> something that was controlled by userspace, e.g. write the number of
> lines and a flag to indicate if a snapshot_aggregate was desired to
> the sysfs file.  I can't say I've thought it all the way through to
> make sure there are no gotchas, but I'm guessing that is about as
> simple as one can get.
> 
> If there is something else you had in mind, Mimi, please share the
> details.  This is a very real problem we are facing and we want to
> work to get a solution upstream.
> 

