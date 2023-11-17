Return-Path: <linux-integrity+bounces-81-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D24847EFB8A
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Nov 2023 23:41:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60D8FB20B96
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Nov 2023 22:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B122246551;
	Fri, 17 Nov 2023 22:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="iHpPlaOp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5D8FD194;
	Fri, 17 Nov 2023 14:41:46 -0800 (PST)
Received: from [10.137.114.52] (unknown [131.107.159.180])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2826D20B74C0;
	Fri, 17 Nov 2023 14:41:45 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2826D20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1700260905;
	bh=orjxgtrNLgPOQYG1EeIPZWuhMWqqoJLBesmwg7RvjbE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iHpPlaOpfAkoYFJ9FqFRdX/pHVe8xCZE8w8oVWmMG88896yM9zTc8B1BuplNYqk5M
	 R6zcotzAuweQaE1G9dRdSGvhJeD85n3dHOhPPX0ExZ1ipbMtlGHLgXBt+31Tx1SNzk
	 lzn994NmMM6WScrqGcblyY3A10vKN0CLyKz6MvXY=
Message-ID: <9e60ad72-fa7a-4a2f-b980-700e98818537@linux.microsoft.com>
Date: Fri, 17 Nov 2023 14:41:44 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
To: Paul Moore <paul@paul-moore.com>, Stefan Berger <stefanb@linux.ibm.com>
Cc: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
 linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
 peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca,
 Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com, vgoyal@redhat.com,
 Dave Young <dyoung@redhat.com>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>, jmorris@namei.org,
 serge@hallyn.com, James Bottomley <James.Bottomley@hansenpartnership.com>,
 linux-security-module@vger.kernel.org,
 Tyler Hicks <tyhicks@linux.microsoft.com>,
 Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <53db2f31-e383-445f-b746-961958a619bd@linux.ibm.com>
 <5dfcb0d6-8cbf-428e-b8c1-30333fc668b5@linux.microsoft.com>
 <ce2e6de7-4289-442e-8209-fb7c01f51e14@linux.ibm.com>
 <CAHC9VhQ2ZGxAyB0Zy=BQAyJe7ofknaXaAgsgtt5G-ENExdHA=A@mail.gmail.com>
 <1ed2d72c-4cb2-48b3-bb0f-b0877fc1e9ca@linux.ibm.com>
 <CAHC9VhTxQZ5+omZdjwtQwe7MJeAdaLAXP2d5GgyyABLRYkWkGw@mail.gmail.com>
Content-Language: en-US
From: Sush Shringarputale <sushring@linux.microsoft.com>
In-Reply-To: <CAHC9VhTxQZ5+omZdjwtQwe7MJeAdaLAXP2d5GgyyABLRYkWkGw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/16/2023 2:56 PM, Paul Moore wrote:
> On Thu, Nov 16, 2023 at 5:41 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>> On 11/16/23 17:07, Paul Moore wrote:
>>> On Tue, Nov 14, 2023 at 1:58 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>>>> On 11/14/23 13:36, Sush Shringarputale wrote:
>>>>> On 11/13/2023 10:59 AM, Stefan Berger wrote:
>>>>>> On 10/19/23 14:49, Tushar Sugandhi wrote:
>>>>>>> =======================================================================
>>>>>>> | Introduction |
>>>>>>> =======================================================================
>>>>>>> This document provides a detailed overview of the proposed Kernel
>>>>>>> feature IMA log snapshotting.  It describes the motivation behind the
>>>>>>> proposal, the problem to be solved, a detailed solution design with
>>>>>>> examples, and describes the changes to be made in the clients/services
>>>>>>> which are part of remote-attestation system.  This is the 2nd version
>>>>>>> of the proposal.  The first version is present here[1].
>>>>>>>
>>>>>>> Table of Contents:
>>>>>>> ------------------
>>>>>>> A. Motivation and Background
>>>>>>> B. Goals and Non-Goals
>>>>>>>        B.1 Goals
>>>>>>>        B.2 Non-Goals
>>>>>>> C. Proposed Solution
>>>>>>>        C.1 Solution Summary
>>>>>>>        C.2 High-level Work-flow
>>>>>>> D. Detailed Design
>>>>>>>        D.1 Snapshot Aggregate Event
>>>>>>>        D.2 Snapshot Triggering Mechanism
>>>>>>>        D.3 Choosing A Persistent Storage Location For Snapshots
>>>>>>>        D.4 Remote-Attestation Client/Service-side Changes
>>>>>>>            D.4.a Client-side Changes
>>>>>>>            D.4.b Service-side Changes
>>>>>>> E. Example Walk-through
>>>>>>> F. Other Design Considerations
>>>>>>> G. References
>>>>>>>
>>>>>> Userspace applications will have to know
>>>>>> a) where are the shard files?
>>>>> We describe the file storage location choices in section D.3, but user
>>>>> applications will have to query the well-known location described there.
>>>>>> b) how do I read the shard files while locking out the producer of the
>>>>>> shard files?
>>>>>>
>>>>>> IMO, this will require a well known config file and a locking method
>>>>>> (flock) so that user space applications can work together in this new
>>>>>> environment. The lock could be defined in the config file or just be
>>>>>> the config file itself.
>>>>> The flock is a good idea for co-ordination between UM clients. While
>>>>> the Kernel cannot enforce any access in this way, any UM process that
>>>>> is planning on triggering the snapshot mechanism should follow that
>>>>> protocol.  We will ensure we document that as the best-practices in
>>>>> the patch series.
>>>> It's more than 'best practices'. You need a well-known config file with
>>>> well-known config options in it.
>>>>
>>>> All clients that were previously just trying to read new bytes from the
>>>> IMA log cannot do this anymore in the presence of a log shard producer
>>>> but have to also learn that a new log shard has been produced so they
>>>> need to figure out the new position in the log where to read from. So
>>>> maybe a counter in a config file should indicate to the log readers that
>>>> a new log has been produced -- otherwise they would have to monitor all
>>>> the log shard files or the log shard file's size.
>>> If a counter is needed, I would suggest placing it somewhere other
>>> than the config file so that we can enforce limited write access to
>>> the config file.
>>>
>>> Regardless, I imagine there are a few ways one could synchronize
>>> various userspace applications such that they see a consistent view of
>>> the decomposed log state, and the good news is that the approach
>>> described here is opt-in from a userspace perspective.  If the
>> A FUSE filesystem that stitches together the log shards from one or
>> multiple files + IMA log file(s) could make this approach transparent
>> for as long as log shards are not thrown away. Presumably it (or root)
>> could bind-mount its files over the two IMA log files.
>>
>>> userspace does not fully support IMA log snapshotting then it never
>>> needs to trigger it and the system behaves as it does today; on the
>> I don't think individual applications should trigger it , instead some
>> dedicated background process running on a machine would do that every n
>> log entries or so and possibly offer the FUSE filesystem at the same
>> time. In either case, once any application triggers it, all either have
>> to know how to deal with the shards or FUSE would make it completely
>> transparent.
FUSE would be a reasonable user space co-ordination implementation.  A
privileged process would trigger the snapshot generation and provide the
mountpoint to read the full IMA log backed by shards as needed by relying
parties.

Whether it is a privileged daemon or some other agent that triggers the
snapshot, it shouldn't impact the Kernel-side implementation.

- Sush
> Yes, performing a snapshot is a privileged operation which I expect
> would be done and managed by a dedicated daemon running on the system.
>


