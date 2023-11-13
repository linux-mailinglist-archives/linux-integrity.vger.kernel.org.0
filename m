Return-Path: <linux-integrity+bounces-42-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A03CD7EA337
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Nov 2023 20:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 948411C208C4
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Nov 2023 19:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB97E22EF6;
	Mon, 13 Nov 2023 19:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WTptFFiH"
X-Original-To: linux-integrity@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D49A22EEF
	for <linux-integrity@vger.kernel.org>; Mon, 13 Nov 2023 19:00:13 +0000 (UTC)
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FFC10DA;
	Mon, 13 Nov 2023 11:00:11 -0800 (PST)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADIF202009069;
	Mon, 13 Nov 2023 18:59:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=IT6nR1umc5yLo6di+xTljouCgYu0PudLsDCQ9al543Y=;
 b=WTptFFiH8h0o1tEzutAKxWMW0zY8ZkmulLoEYvxnipfM2fwZiUVht1FBvV7TBWxXV42B
 ve8wVgB2Gh4/et6FkQIsEsuOtfehPadxqYb0HucsiV6RH7keMOAV44yp1TojPu0xxE7K
 B4q+bR5s76Mz0IDIVjieUI+DX3sMDSL40vtJhDXkabrzSIFGHFrGcRxop44WxHCH83AO
 PHKgUM6Iy6g8TpSbC+I5O6XlHQGt8rTY5WwEJ3BaaKJyqMolCzfSTiGNTfTZixzr0p4F
 HiC6+BnXCNQMjoQ30BQEIYTvEhCXZdxnvYOgV1mVrlZ89uq1CWarPQe7YHmYZjDvhts8 sg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ubrtdh8ye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Nov 2023 18:59:50 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3ADIKFZd026750;
	Mon, 13 Nov 2023 18:59:49 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ubrtdh8y6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Nov 2023 18:59:49 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3ADH43Nb003787;
	Mon, 13 Nov 2023 18:59:48 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uanekans5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Nov 2023 18:59:48 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3ADIxlqF24314410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Nov 2023 18:59:47 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0C655805D;
	Mon, 13 Nov 2023 18:59:47 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A806258059;
	Mon, 13 Nov 2023 18:59:46 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Nov 2023 18:59:46 +0000 (GMT)
Message-ID: <53db2f31-e383-445f-b746-961958a619bd@linux.ibm.com>
Date: Mon, 13 Nov 2023 13:59:46 -0500
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
To: Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca,
        Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com, vgoyal@redhat.com,
        Dave Young <dyoung@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        jmorris@namei.org, Paul Moore <paul@paul-moore.com>, serge@hallyn.com,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-security-module@vger.kernel.org
Cc: Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Sush Shringarputale <sushring@linux.microsoft.com>
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WmvznxFZu7yxlghfWUryTRibdYfAFIYI
X-Proofpoint-ORIG-GUID: 2jVIVTCM0GihU6zmaxUPEHXg_m1XX5Cl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-13_09,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 priorityscore=1501
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 clxscore=1011 malwarescore=0 mlxlogscore=505
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311060000
 definitions=main-2311130153



On 10/19/23 14:49, Tushar Sugandhi wrote:
> =======================================================================
> | Introduction                                                        |
> =======================================================================
> This document provides a detailed overview of the proposed Kernel
> feature IMA log snapshotting.  It describes the motivation behind the
> proposal, the problem to be solved, a detailed solution design with
> examples, and describes the changes to be made in the clients/services
> which are part of remote-attestation system.  This is the 2nd version
> of the proposal.  The first version is present here[1].
> 
> Table of Contents:
> ------------------
> A. Motivation and Background
> B. Goals and Non-Goals
>      B.1 Goals
>      B.2 Non-Goals
> C. Proposed Solution
>      C.1 Solution Summary
>      C.2 High-level Work-flow
> D. Detailed Design
>      D.1 Snapshot Aggregate Event
>      D.2 Snapshot Triggering Mechanism
>      D.3 Choosing A Persistent Storage Location For Snapshots
>      D.4 Remote-Attestation Client/Service-side Changes
>          D.4.a Client-side Changes
>          D.4.b Service-side Changes
> E. Example Walk-through
> F. Other Design Considerations
> G. References
> 

Userspace applications will have to know
a) where are the shard files?
b) how do I read the shard files while locking out the producer of the 
shard files?

IMO, this will require a well known config file and a locking method 
(flock) so that user space applications can work together in this new 
environment. The lock could be defined in the config file or just be the 
config file itself.


