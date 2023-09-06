Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0059A7944BD
	for <lists+linux-integrity@lfdr.de>; Wed,  6 Sep 2023 22:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244269AbjIFUtj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 6 Sep 2023 16:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjIFUti (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 6 Sep 2023 16:49:38 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 858FDE9;
        Wed,  6 Sep 2023 13:49:34 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 386KbjGN031693;
        Wed, 6 Sep 2023 20:49:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=ZOmile8toGMLhacgR3CMqYQ63APzpk7xXZn55kY+VmU=;
 b=aAT5S9AWxYpzJxQclgD9aEQeReFbbyTNQBBTEPrqIkEJoZDcRcvs3aiHIxNc4rQQdTKU
 qhAid/Scsh1A64Rd6LO42utPBfndaRarjn/XHOuv9HgLIhsHr83JrUgUTJPoqgS4u69x
 +OBEqf0Gz3iVFtoHl/X8Xtg7wPYL8dpyKrzhDYBQJwzO2jn0y5wiLMHKNfuXGx1AWxCx
 v/fYj8djBu9dYeDNzMizzMeqVf1ynIO6QsMEeAPnyfyIPSMNXCrAOBl2gv172nOkpdUZ
 b0JApWkqDVIvoB1aT6r5zPDzEpLK49ZLyCDX4TU85b+uq735G6pP9WTI9iCZbSvRC0wm jA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxythskhn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 20:49:22 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 386KbsmU032268;
        Wed, 6 Sep 2023 20:49:21 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sxythskhf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 20:49:21 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 386Js3FJ012232;
        Wed, 6 Sep 2023 20:49:20 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3svhkk65fn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Sep 2023 20:49:20 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 386KnJHq6423266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 6 Sep 2023 20:49:20 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BA4C95805A;
        Wed,  6 Sep 2023 20:49:19 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1A46458054;
        Wed,  6 Sep 2023 20:49:18 +0000 (GMT)
Received: from [9.67.51.26] (unknown [9.67.51.26])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed,  6 Sep 2023 20:49:17 +0000 (GMT)
Message-ID: <0cfdad7c-8cb9-20d3-7986-c1d3d58a33db@linux.ibm.com>
Date:   Wed, 6 Sep 2023 16:49:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal - aggregate
Content-Language: en-US
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca, bhe@redhat.com,
        vgoyal@redhat.com, dyoung@redhat.com, kexec@lists.infradead.org,
        jmorris@namei.org, Paul Moore <paul@paul-moore.com>,
        serge@hallyn.com
Cc:     code@tyhicks.com, nramas@linux.microsoft.com,
        linux-security-module@vger.kernel.org
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <598fdd62-f4c3-a6dc-ae22-8f5a9e18f570@linux.ibm.com>
 <c83e13f8-4b7d-9489-37cc-53936b24343c@linux.microsoft.com>
From:   Ken Goldman <kgold@linux.ibm.com>
In-Reply-To: <c83e13f8-4b7d-9489-37cc-53936b24343c@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FvWLUtNRAggZfi_6YArb6fXHdR8SS_Bd
X-Proofpoint-GUID: dk9mW0RJKiCg6IYjDWDUvK0TvKgywoAm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-09-06_06,2023-09-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 phishscore=0 adultscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2308100000 definitions=main-2309060178
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 9/1/2023 6:06 PM, Tushar Sugandhi wrote:
> 
> 
> On 8/30/23 11:12, Ken Goldman wrote:
>> On 8/1/2023 3:12 PM, Sush Shringarputale wrote:
>>> - A user-mode process will trigger the snapshot by opening a file in 
>>> SysFS
>>>    say /sys/kernel/security/ima/snapshot (referred to as 
>>> sysk_ima_snapshot_file
>>>    here onwards).
>>> - The Kernel will get the current TPM PCR values and PCR update 
>>> counter [2]
>>>    and store them as template data in a new IMA event 
>>> "snapshot_aggregate".
>>
>> If this is relying on a user-mode process, is there a concern that the 
>> process doesn't run. Might it be safer to have the kernel trigger the
>> snapshot.
>>
> The UM process here would be typically an attestation client
> which passes on the IMA log to the remote service for attestation.
> If the process doesn't run, the client will operate the same way as it
> does currently.

I see.

1. Ensure that the attestation client stores the snapshot in a 
well-known and widely readable location.  There can be more than one 
attestation client, and all need access to the snapshot.

There is a privacy concern around making the snapshot world-read.

2. Is there a concern that, if the client doesn't run, it doesn't solve 
the kernel memory issue?  Is this relying on a UM process to solve a 
kernel issue?
> 
>> PCR reads are not atomic, with each other and with event log appends. 
>> Is this an issue?
>>
> In this design, reading the PCR plus adding the snapshot_aggregate
> has to be an atomic operation.  Other IMA events shouldn't interfere
> with this operation. Just like IMA ensures adding an entry to the log
> plus PCR extension happens in an atomic way by holding the
> ima_extend_list_mutex [2], we intend to use a similar mechanism to
> ensure reading the PCR plus adding the snapshot_aggregate remains an
> atomic operation.  And since taking a snapshot would be a rare event
> compared to adding a generic event to IMA log - overall we expect a low
> overhead in case of snapshotting.

How would that work?  The PCR read is UM, but IMA events are kernel. The 
UM operation cannot block the kernel or there can be a deadlock, right?

(UM) PCR reads can take multiple TPM commands, and they should not block 
an (kernel) extend.

>> What is the purpose of the snapshot aggregate?  Since the entire event 
>> log has to be retained and sent to the verifier, is the aggregate 
>> redundant?
> 
> The goals of snapshot_aggregate marker are:
>      1. To allow the IMA log to be divided into multiple chunks and
>         provide attestation service the ability to verify and use the
>         latest chunk (i.e. snapshot ) for attestation.

I believe that the verifier needs the entire log the first time, whether 
there is a snapshot or not.  Shouldn't the snapshot process be opaque to 
the verifier?

> 
>      2. To indicate to the attestation service that the client device has
>         IMA log snapshotting feature enabled, and at least one snapshot
>         is taken.  So that the service can ask for previous snapshots
>         as needed.

Why does the verifier need this?  The first time, it asks for events 
starting at #0.  Next time, it asks for what's new.  It's independent of 
__where__ the log comes from.

> 
>      3. In the event of multiple snapshots, the snapshot_aggregate
>         marker has sufficient information to verify the integrity
>         of latest subset of isolated snapshots (with the help of PCR
>         quote of course)

A new verifier needs the entire log, no matter how many snapshots have 
been taken.

> 
>      4. snapshot_aggregate helps both kernel and UM define clear
>         boundaries between multiple snapshots.
>         (each new snapshot starts with either the first boot_aggregate
>          or a snapshot_aggregate event)
> 
> The overall goals of IMA log snapshotting feature are:
>      a. to relieve memory pressure on the client device.
> 
>      b. to make attestation service side processing more efficient
>         They don't have to deal with the entire log since boot,
>         as you mentioned on

I don't think snapshotting affects the verifier at all. The attestor is 
a bit more complicated, but not significantly.

