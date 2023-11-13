Return-Path: <linux-integrity+bounces-41-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E22627EA2A5
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Nov 2023 19:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99A3A280E64
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Nov 2023 18:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEC5224ED;
	Mon, 13 Nov 2023 18:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="If6jd5xA"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5B11DDD6
	for <linux-integrity@vger.kernel.org>; Mon, 13 Nov 2023 18:14:36 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 80A5ED53;
	Mon, 13 Nov 2023 10:14:35 -0800 (PST)
Received: from [10.137.114.52] (unknown [131.107.159.180])
	by linux.microsoft.com (Postfix) with ESMTPSA id C5F7F20B74C1;
	Mon, 13 Nov 2023 10:14:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C5F7F20B74C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1699899275;
	bh=PQZ5UmPmG9pef+E8G3YPru2uMvofveJcbTaptSpXym8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=If6jd5xAyRgPs1mkzjtt0JuLiVptdwy3eAWFRmV0jEc6GBjz9CKpOBgCdemAX9/OQ
	 BUcs3cRJYY9NUnjcxmMd8YbDg5IN0bJQnobcdzFp2exSnOMR7/PVaz3vPz+nbFH/z+
	 16Yr5nQc2vWnH3kaKyVCXQd87neogo/GzKDQeza8=
Message-ID: <86366328-512e-47a0-950d-450412319c26@linux.microsoft.com>
Date: Mon, 13 Nov 2023 10:14:34 -0800
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
To: Ken Goldman <kgold@linux.ibm.com>,
 Tushar Sugandhi <tusharsu@linux.microsoft.com>,
 linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
 peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca,
 bhe@redhat.com, vgoyal@redhat.com, Dave Young <dyoung@redhat.com>,
 "kexec@lists.infradead.org" <kexec@lists.infradead.org>, jmorris@namei.org,
 Paul Moore <paul@paul-moore.com>, serge@hallyn.com,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 linux-security-module@vger.kernel.org
Cc: Tyler Hicks <tyhicks@linux.microsoft.com>,
 Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <1f7bdb13-859e-46ce-b327-8043e7dbd598@linux.ibm.com>
Content-Language: en-US
From: Sush Shringarputale <sushring@linux.microsoft.com>
In-Reply-To: <1f7bdb13-859e-46ce-b327-8043e7dbd598@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 10/31/2023 11:37 AM, Ken Goldman wrote:
> On 10/19/2023 2:49 PM, Tushar Sugandhi wrote:
>>    f. A new event, "snapshot_aggregate", will be computed and measured
>>         in the IMA log as part of this feature.  It should help the
>>         remote-attestation client/service to benefit from the IMA log
>>         snapshot feature.
>>         The "snapshot_aggregate" event is described in more details in
>>         section "D.1 Snapshot Aggregate Event" below.
>
> What is the use case for the snapshot aggregate?  My thinking is:
>
> 1. The platform must retain the entire measurement list.  Early 
> measurements can never be discarded because a new quote verifier
> must receive the entire log starting at the first measurement.
>
> In this case, isn't the snapshot aggregate redundant?
Not quite. The snapshot aggregate still has a purpose, which is to stitch
together the snapshots on the disk and the in-memory segment of the IMA
log. The specific details are in the RFC Section D.1, quoted here:

The "snapshot_aggregate" marker provides the following benefits:

a. It facilitates the IMA log to be divided into multiple chunks and
provides mechanism to verify the integrity of the system using only the
latest chunks during remote attestation.

b. It provides tangible evidence from Kernel to the attestation client
that IMA log snapshotting has been enabled and at least one snapshot
exists on the system.

c. It helps both the Kernel and UM attestation client define clear
boundaries between multiple snapshots.

d. In the event of multiple snapshots, the last measured
"snapshot_aggregate" marker, which is present in the current segment of
the IMA log, has sufficient information to verify the integrity of the
IMA log segment as well as the previous snapshots using the PCR quotes.

e. In the event of multiple snapshots, say N, if the remote-attestation
service has already processed the last N-1 snapshots, it can efficiently
parse through them by just processing "snapshot_aggregate" events to
compute the PCR quotes needed to verify the events in the last snapshot.
This should drastically improve the IMA log processing efficiency of
the service.

>
> 2. There is a disadvantage to redundant data.  The verifier must 
> support this new event type. It receives this event and must validate 
> the aggregate against the snapshot-ed events. This is an attack 
> surface. The attacker can send an aggregate and snapshot-ed 
> measurements that do not match to exploit a flaw in the verifier.
I disagree with this.  Redundancy is a moot point because
"snapshot_aggregate" is required for the points mentioned above.
- Sush

