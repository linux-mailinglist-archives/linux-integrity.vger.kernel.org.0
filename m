Return-Path: <linux-integrity+bounces-45-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FBB7EB6AA
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Nov 2023 19:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43F44B20AA2
	for <lists+linux-integrity@lfdr.de>; Tue, 14 Nov 2023 18:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6FE443C;
	Tue, 14 Nov 2023 18:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="skACyuzp"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EBF1FD3
	for <linux-integrity@vger.kernel.org>; Tue, 14 Nov 2023 18:58:39 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A40FF4;
	Tue, 14 Nov 2023 10:58:38 -0800 (PST)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEIXqVk017685;
	Tue, 14 Nov 2023 18:58:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=e9myKv7gYQgnWacBTIa2Qmdo52E2fuIFXcT/0aKE0Fw=;
 b=skACyuzpIMG/V3xvhZ0gxlUA5ZrF+DuZwjlf+h4DPKV3Tul76aYzj9+aYQ1z0HF5rSZa
 NC6kWxYlHfrCriAV92RONQncqChp82QBXIc98cWsb7yiP8QO45okKu6ZIuRMVDz029bW
 ipca6ivUpLchkdi/KeM9hTCZ3HxRmnBSxTK46UfQQfbQYChx+hHsRvD/OwCsmRqu2s80
 aq0geQGuAJUhWNApSKrEVbvJZOkE3q3EfwNF4Scc7uv0vxHsFhCYRhifyKkBfEDiDBTu
 uCQ+xOjY65qaNuceliJG4zYN6jN7VCNEuUT41oapfvop/6YzfZHohqzjl7FJQj7bzP8l DQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucdxth5fh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Nov 2023 18:58:17 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3AEIhvAL014158;
	Tue, 14 Nov 2023 18:58:16 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ucdxth5f4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Nov 2023 18:58:16 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3AEGY4hj020108;
	Tue, 14 Nov 2023 18:58:16 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uamxn9wc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 14 Nov 2023 18:58:16 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3AEIwFqZ14942856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 14 Nov 2023 18:58:15 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0142C5805A;
	Tue, 14 Nov 2023 18:58:15 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED10058051;
	Tue, 14 Nov 2023 18:58:13 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 14 Nov 2023 18:58:13 +0000 (GMT)
Message-ID: <ce2e6de7-4289-442e-8209-fb7c01f51e14@linux.ibm.com>
Date: Tue, 14 Nov 2023 13:58:13 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
Content-Language: en-US
To: Sush Shringarputale <sushring@linux.microsoft.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca,
        Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com, vgoyal@redhat.com,
        Dave Young <dyoung@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        jmorris@namei.org, Paul Moore <paul@paul-moore.com>, serge@hallyn.com,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-security-module@vger.kernel.org
Cc: Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
 <53db2f31-e383-445f-b746-961958a619bd@linux.ibm.com>
 <5dfcb0d6-8cbf-428e-b8c1-30333fc668b5@linux.microsoft.com>
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <5dfcb0d6-8cbf-428e-b8c1-30333fc668b5@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: HtwahexQ60FJmtfXYXLaNtuc8KDvQvev
X-Proofpoint-ORIG-GUID: QY7C3PjP5IaOZtDqQjqhIzCQXdMkUzZE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-14_19,2023-11-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=624
 lowpriorityscore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311140144



On 11/14/23 13:36, Sush Shringarputale wrote:
> 
> 
> On 11/13/2023 10:59 AM, Stefan Berger wrote:
>>
>>
>> On 10/19/23 14:49, Tushar Sugandhi wrote:
>>> =======================================================================
>>> | Introduction |
>>> =======================================================================
>>> This document provides a detailed overview of the proposed Kernel
>>> feature IMA log snapshotting.  It describes the motivation behind the
>>> proposal, the problem to be solved, a detailed solution design with
>>> examples, and describes the changes to be made in the clients/services
>>> which are part of remote-attestation system.  This is the 2nd version
>>> of the proposal.  The first version is present here[1].
>>>
>>> Table of Contents:
>>> ------------------
>>> A. Motivation and Background
>>> B. Goals and Non-Goals
>>>      B.1 Goals
>>>      B.2 Non-Goals
>>> C. Proposed Solution
>>>      C.1 Solution Summary
>>>      C.2 High-level Work-flow
>>> D. Detailed Design
>>>      D.1 Snapshot Aggregate Event
>>>      D.2 Snapshot Triggering Mechanism
>>>      D.3 Choosing A Persistent Storage Location For Snapshots
>>>      D.4 Remote-Attestation Client/Service-side Changes
>>>          D.4.a Client-side Changes
>>>          D.4.b Service-side Changes
>>> E. Example Walk-through
>>> F. Other Design Considerations
>>> G. References
>>>
>>
>> Userspace applications will have to know
>> a) where are the shard files?
> We describe the file storage location choices in section D.3, but user
> applications will have to query the well-known location described there.
>> b) how do I read the shard files while locking out the producer of the 
>> shard files?
>>
>> IMO, this will require a well known config file and a locking method 
>> (flock) so that user space applications can work together in this new 
>> environment. The lock could be defined in the config file or just be 
>> the config file itself.
> The flock is a good idea for co-ordination between UM clients. While
> the Kernel cannot enforce any access in this way, any UM process that
> is planning on triggering the snapshot mechanism should follow that
> protocol.  We will ensure we document that as the best-practices in
> the patch series.

It's more than 'best practices'. You need a well-known config file with 
well-known config options in it.

All clients that were previously just trying to read new bytes from the 
IMA log cannot do this anymore in the presence of a log shard producer 
but have to also learn that a new log shard has been produced so they 
need to figure out the new position in the log where to read from. So 
maybe a counter in a config file should indicate to the log readers that 
a new log has been produced -- otherwise they would have to monitor all 
the log shard files or the log shard file's size.

Iff the log-shard producer were configured to discard leading parts of 
the log then that should also be noted in a config file so clients, that 
need to see the beginning of the log, can refuse early on to work on a 
machine that either is configured this way or where the discarding has 
already happened.

   Stefan

> - Sush

