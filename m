Return-Path: <linux-integrity+bounces-76-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A62687EE96D
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Nov 2023 23:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB3AC280F77
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Nov 2023 22:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 518891171E;
	Thu, 16 Nov 2023 22:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="la8DHfVy"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48BDFD6C;
	Thu, 16 Nov 2023 14:41:49 -0800 (PST)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGM2Eig014680;
	Thu, 16 Nov 2023 22:41:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=UWeoQXYLbuQWtO2zuD41eMEy1Z3NjBSjHI4ksmv99/Q=;
 b=la8DHfVySOwaOp6Lx7RzYlEsszqBD6c5r6LILCHf6kdMdz8kBuESWIdhRrw2DCPDyQN4
 rzI9NtbcmwVgqjxenyX+G1R9badm8ccLHj3Q1v7g90jB3qqs3dwNiwMs7bKJ5KO3npIa
 kK9AQzpiDlTGaDzVY1coJ2A/2/PGphbw82ArIkvqR3R2ndFh72RE9FcXYFpWAzUi4T88
 zgDWnOFxsXlizdTFpH8h4Tm0VrVYZvRz/Sn9aoC6WxldvOM4p8x6TPPFYMt9Ypgvyi24
 i79GMhu1GdivTHzH1r340f3XnMVEC5nSaUHbWWaIcHcNRS+MVlsVtZ0okyn/df1e4bN2 4Q== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uduh5gxbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 22:41:28 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AGMexuW024571;
	Thu, 16 Nov 2023 22:41:28 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uduh5gxay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 22:41:27 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AGKvQw1029919;
	Thu, 16 Nov 2023 22:41:26 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamxnssgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 22:41:26 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AGMfPQN18874966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Nov 2023 22:41:25 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CA9B5805A;
	Thu, 16 Nov 2023 22:41:25 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A8A958062;
	Thu, 16 Nov 2023 22:41:24 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Nov 2023 22:41:24 +0000 (GMT)
Message-ID: <1ed2d72c-4cb2-48b3-bb0f-b0877fc1e9ca@linux.ibm.com>
Date: Thu, 16 Nov 2023 17:41:23 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
Content-Language: en-US
To: Paul Moore <paul@paul-moore.com>
Cc: Sush Shringarputale <sushring@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca,
        Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com, vgoyal@redhat.com,
        Dave Young <dyoung@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        jmorris@namei.org, serge@hallyn.com,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-security-module@vger.kernel.org,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <53db2f31-e383-445f-b746-961958a619bd@linux.ibm.com>
 <5dfcb0d6-8cbf-428e-b8c1-30333fc668b5@linux.microsoft.com>
 <ce2e6de7-4289-442e-8209-fb7c01f51e14@linux.ibm.com>
 <CAHC9VhQ2ZGxAyB0Zy=BQAyJe7ofknaXaAgsgtt5G-ENExdHA=A@mail.gmail.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <CAHC9VhQ2ZGxAyB0Zy=BQAyJe7ofknaXaAgsgtt5G-ENExdHA=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: IACozd8m2XYnqSy0eHOuUqQBOaKuLmOT
X-Proofpoint-ORIG-GUID: UAQl6mZZ0IJikR6FJNhU3QHo2ldL3qdd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_23,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=994
 clxscore=1015 mlxscore=0 impostorscore=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160176



On 11/16/23 17:07, Paul Moore wrote:
> On Tue, Nov 14, 2023 at 1:58 PM Stefan Berger <stefanb@linux.ibm.com> wrote:
>> On 11/14/23 13:36, Sush Shringarputale wrote:
>>> On 11/13/2023 10:59 AM, Stefan Berger wrote:
>>>> On 10/19/23 14:49, Tushar Sugandhi wrote:
>>>>> =======================================================================
>>>>> | Introduction |
>>>>> =======================================================================
>>>>> This document provides a detailed overview of the proposed Kernel
>>>>> feature IMA log snapshotting.  It describes the motivation behind the
>>>>> proposal, the problem to be solved, a detailed solution design with
>>>>> examples, and describes the changes to be made in the clients/services
>>>>> which are part of remote-attestation system.  This is the 2nd version
>>>>> of the proposal.  The first version is present here[1].
>>>>>
>>>>> Table of Contents:
>>>>> ------------------
>>>>> A. Motivation and Background
>>>>> B. Goals and Non-Goals
>>>>>       B.1 Goals
>>>>>       B.2 Non-Goals
>>>>> C. Proposed Solution
>>>>>       C.1 Solution Summary
>>>>>       C.2 High-level Work-flow
>>>>> D. Detailed Design
>>>>>       D.1 Snapshot Aggregate Event
>>>>>       D.2 Snapshot Triggering Mechanism
>>>>>       D.3 Choosing A Persistent Storage Location For Snapshots
>>>>>       D.4 Remote-Attestation Client/Service-side Changes
>>>>>           D.4.a Client-side Changes
>>>>>           D.4.b Service-side Changes
>>>>> E. Example Walk-through
>>>>> F. Other Design Considerations
>>>>> G. References
>>>>>
>>>>
>>>> Userspace applications will have to know
>>>> a) where are the shard files?
>>> We describe the file storage location choices in section D.3, but user
>>> applications will have to query the well-known location described there.
>>>> b) how do I read the shard files while locking out the producer of the
>>>> shard files?
>>>>
>>>> IMO, this will require a well known config file and a locking method
>>>> (flock) so that user space applications can work together in this new
>>>> environment. The lock could be defined in the config file or just be
>>>> the config file itself.
>>> The flock is a good idea for co-ordination between UM clients. While
>>> the Kernel cannot enforce any access in this way, any UM process that
>>> is planning on triggering the snapshot mechanism should follow that
>>> protocol.  We will ensure we document that as the best-practices in
>>> the patch series.
>>
>> It's more than 'best practices'. You need a well-known config file with
>> well-known config options in it.
>>
>> All clients that were previously just trying to read new bytes from the
>> IMA log cannot do this anymore in the presence of a log shard producer
>> but have to also learn that a new log shard has been produced so they
>> need to figure out the new position in the log where to read from. So
>> maybe a counter in a config file should indicate to the log readers that
>> a new log has been produced -- otherwise they would have to monitor all
>> the log shard files or the log shard file's size.
> 
> If a counter is needed, I would suggest placing it somewhere other
> than the config file so that we can enforce limited write access to
> the config file.
> 
> Regardless, I imagine there are a few ways one could synchronize
> various userspace applications such that they see a consistent view of
> the decomposed log state, and the good news is that the approach
> described here is opt-in from a userspace perspective.  If the

A FUSE filesystem that stitches together the log shards from one or 
multiple files + IMA log file(s) could make this approach transparent 
for as long as log shards are not thrown away. Presumably it (or root) 
could bind-mount its files over the two IMA log files.

> userspace does not fully support IMA log snapshotting then it never
> needs to trigger it and the system behaves as it does today; on the

I don't think individual applications should trigger it , instead some 
dedicated background process running on a machine would do that every n 
log entries or so and possibly offer the FUSE filesystem at the same 
time. In either case, once any application triggers it, all either have 
to know how to deal with the shards or FUSE would make it completely 
transparent.

> other hand, if the userspace has been updated it can make use of the
> new functionality to better manage the size of the IMA measurement
> log.
> 

