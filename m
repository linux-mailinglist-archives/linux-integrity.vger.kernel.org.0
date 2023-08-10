Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B7C3777A3B
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Aug 2023 16:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbjHJONU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 10 Aug 2023 10:13:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbjHJONS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 10 Aug 2023 10:13:18 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACDBB125;
        Thu, 10 Aug 2023 07:13:17 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37AE9Q83005751;
        Thu, 10 Aug 2023 14:12:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=AzlZCMaJMcdfJJyhKQ2Gu2EaT86A1sk8zWryu7STChA=;
 b=Wc83agc+oZDFgImWGDbcJD5GYXrYDJWdmtQP3uMQOmg/jaCVN+fQWGDnqMfrBzeMQIVP
 HH7fEBMEx3mdN1urN9Dn1q7zRqvmRVoOMpYl0qEph5ECNyie6jIH6Oopi6TEG+oJfYAE
 TUXZxWqFdbjUfGaLqyG9w++fyIb8MMX60pWlmDhE8kNm7pFjXGokHObL+Cnh8BeN7z45
 oDAmJtIRIe9IkbmxwtvbL7vWq4SkvNunpbnVknLmRNqxnxpGK2+0bKIQMIu11SiYoiM/
 GM2a6ZkaJt0Gx6PDt0Dx7kG2V/18zcbOSlh8T8s4b4FZWNViWBem6johyalKHri2DBeX 1w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sd162gfgv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 14:12:46 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37AE9TwU006123;
        Thu, 10 Aug 2023 14:12:46 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sd162gfg6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 14:12:46 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37AD9ad0001802;
        Thu, 10 Aug 2023 14:12:45 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sa3f29mw3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 14:12:45 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37AEChge2425518
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Aug 2023 14:12:43 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D51CB58065;
        Thu, 10 Aug 2023 14:12:43 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 72E0058055;
        Thu, 10 Aug 2023 14:12:42 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 10 Aug 2023 14:12:42 +0000 (GMT)
Message-ID: <011d8a79-236f-dc20-08fc-b5da7dd1d5a7@linux.ibm.com>
Date:   Thu, 10 Aug 2023 10:12:42 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
Content-Language: en-US
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        kgold@linux.ibm.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, kexec@lists.infradead.org, jmorris@namei.org,
        Paul Moore <paul@paul-moore.com>, serge@hallyn.com
Cc:     code@tyhicks.com, nramas@linux.microsoft.com,
        linux-security-module@vger.kernel.org
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <b748230c8ee291288afcf48898507556c3aa7c71.camel@HansenPartnership.com>
 <5d21276a-daac-fc9b-add9-62e7c04bbdcd@linux.ibm.com>
 <b538f7d2-5a04-46d0-3792-a18653230a95@linux.microsoft.com>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <b538f7d2-5a04-46d0-3792-a18653230a95@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: d1clrWNetBzJyZ8Sad1BUvSH3NEwA-Z4
X-Proofpoint-ORIG-GUID: Ig9_J3FBkFIeHo8PbqGgh2ahUsgOX2BV
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_11,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 clxscore=1015 mlxscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308100120
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 8/9/23 21:15, Tushar Sugandhi wrote:
> Thanks a lot Stefan for looking into this proposal,
> and providing your feedback. We really appreciate it.
> 
> On 8/7/23 15:49, Stefan Berger wrote:
>>
>>
>> On 8/1/23 17:21, James Bottomley wrote:
>>> On Tue, 2023-08-01 at 12:12 -0700, Sush Shringarputale wrote:
>>> [...]
>>>> Truncating IMA log to reclaim memory is not feasible, since it makes
>>>> the log go out of sync with the TPM PCR quote making remote
>>>> attestation fail.
>>>
>>> This assumption isn't entirely true.  It's perfectly possible to shard
>>> an IMA log using two TPM2_Quote's for the beginning and end PCR values
>>> to validate the shard.  The IMA log could be truncated in the same way
>>> (replace the removed part of the log with a TPM2_Quote and AK, so the
>>> log still validates from the beginning quote to the end).
>>>
>>> If you use a TPM2_Quote mechanism to save the log, all you need to do
>>> is have the kernel generate the quote with an internal AK.  You can
>>> keep a record of the quote and the AK at the beginning of the truncated
>>> kernel log.  If the truncated entries are saved in a file shard it
>>
>> The truncation seems dangerous to me. Maybe not all the scenarios with an attestation
>> client (client = reading logs and quoting) are possible then anymore, such as starting
>> an attestation client only after truncation but a verifier must have witnessed the
>> system's PCRs and log state before the truncation occurred.
> You are correct that truncation on it’s own is dangerous. It needs to be
> accompanied by (a) saving the IMA log data to disk as snapshots, (b) adding the
> necessary TPM PCR quotes to the current IMA log (as James mentioned above),
> (c) attestation clients having an ability to send the past snapshots to the
> remote-attestation-service (verifiers), (d) and verifiers having an ability
> to use the snapshots along with current IMA logs for the purpose of attestation.
> All these points are explained in the original RFC email in sections B.1 through B.5 [1].

I read it.

Maybe you have dismissed the PCR update counter already...
I am not sure what the PCR update counter is supposed to help with. It won't allow you to detect
missing log events but rather will confuse anyone looking at it when my application extends PCR 12
for example, which also affects the update counter. It's a global counter that increases with every
PCR extension (except PCR 16, 21, 22, 23) and if used as proposed would prevent any application from
extending PCRs.

https://github.com/stefanberger/libtpms/blob/master/src/tpm2/PCR.c#L667
https://github.com/stefanberger/libtpms/blob/master/src/tpm2/PCR.c#L629
https://github.com/stefanberger/libtpms/blob/master/src/tpm2/PCR.c#L161


The shards should will need to be written into some sort of standard location or a config file needs to
be defined, so that everyone knows where to find them and how they are named.


>>
>> I think an ima-buf (or similar) log entry in IMA log would have to appear at the beginning of the
>> truncated log stating the value of all PCRs that IMA touched (typically only PCR 10
>> but it can be others). The needs to be done since the quote itself doesn't
>> provide the state of the individual PCRs. This would at least allow an attestation
>> client to re-read the log from the beginning (when it is re-start or started for the
>> first time after the truncation). 
>   Agreed. See the description of snapshot_aggregate in Section B.5 in the
> original RFC email [1].
>> However, this alone (without the
>> internal AK quoting the old state) could lead to abuse where I could create totally
>> fake IMA logs stating the state of the PCRs at the beginning (so the verifier
>> syncs its internal PCR state to this state). 
> Yes, the PCR quotes sent to the verifier must be signed by the AK that
> is trusted by the verifier. That assumption is true regardless of IMA log
> snapshotting feature.
>> Further, even with the AK-quote that
>> you propose I may be able to create fake logs and trick a verifier into
>> trusting the machine IFF it doesn't know what kernel this system was booted with
>> that I may have hacked to provide a fake AK-quote that just happens to match the
>> PCR state presented at the beginning of the log.
>>
> If the Kernel is compromised, then all-bets are off.
> (Regardless of IMA log snapshotting feature.)
>> => Can a truncated log be made safe for attestation when the attestation starts
>> only after the truncation occurred?
>>
> Yes. If the “PCR quotes in the snapshot_aggregate event in IMA log”

PCR quote or 'quotes'? Why multiple?

Form your proposal but you may have changed your opinion  following what I see in other messages:
"- The Kernel will get the current TPM PCR values and PCR update counter [2]
    and store them as template data in a new IMA event "snapshot_aggregate"."

Afaik TPM quote's don't give you the state of the individual PCR values, therefore
I would expect to at least find the 'PCR values' of all the PCRs that IMA touched to
be in the snapshot_aggregate so I can replay all the following events on top of these
PCR values and come up with the values that were used in the "final PCR quote". This
is unless you expect the server to take an automatic snapshot of the values of the
PCRs  that it computed while evaluating the log in case it ever needs to go back.

> + "replay of rest of the events in IMA log" results in the “final PCR quotes”
> that matches with the “AK signed PCR quotes” sent by the client, then the truncated
> IMA log can be trusted. The verifier can either ‘trust’ the “PCR quotes in the
> snapshot_aggregate event in IMA log” or it can ask for the (n-1)th snapshot shard
> to check the past events.

For anything regarding determining the 'trustworthiness of a system' one would have to
be able to go back to the very beginning of the log *or* remember in what state a
system was when the latest snapshot was taken so that if a restart happens it can resume
with that assumption about state of trustworthiness and know what the values of the PCRs
were at that time so it can resume replaying the log (or the server would get these
values from the log).

The AK quotes by the kernel (which adds a 2nd AK key) that James is proposing
could be useful if the entire log, consisting of multiple shards, is very large and
cannot be transferred from the client to the server in one go so that the server could
evaluate the 'final PCR quote' immediately . However, if a client can indicated 'I will
send more the next time and I have this much more to transfer' and the server allows
this multiple times (until all the 1MB shards of the 20MB log are transferred) then that
kernel AK key would not be necessary since presumably the "final PCR quote", created
by a user space client, would resolve whether the entire log is trustworthy.

> 
>> => Even if attestation was occurring 'what' state does an attestation server
>> need to carry around for an attested-to system so that the truncation is 'safe'
>> and I cannot create fake AK-quotes and fake IMA logs with initial PCR states?
> Assuming most of the client devices take a snapshot at specific checkpoints,
> the “PCR quotes in the snapshot_aggregate event in IMA log” will be the same for them.
> The remote attestation server will have to remember these golden PCR quotes.

I thought maybe 'golden PCR values'... because those let me replay PCR extensions from
a previous point.

> It doesn't have to remember the state of each client device.

Can you give a reason for this? You mean the state doesn't need to be remembered for client
devices whose log hasn't been truncated?

  
>> Can I ever restart the client and have it read the truncated log from the
>> beginning and what type of verification needs to happen on the server then?
>>
> Yes, restarting the client should be possible.

Yes, this must be possible.

>> It seems like the server would have to remember the state of the IMA PCRs upon
>> last truncation to detect a possible attack. This would make staring to monitor
>> a system after truncation impossible -- would be good to know these details.
>>
> The server is not forced to remember the state of IMA PCRs. It can
> always ask for the last n snapshot files (shards) and replay the events. Even
> though the data is truncated from the IMA log, it is not totally lost. It is
> simply being transferred to the disk. It is saved by UM as snapshot files/shards.
> The goal of IMA snapshotting is to reduce the Kernel memory pressure on the
> client devices - to save them from out-of-memory errors which are harder to manage
> on long running clients. It comes with a cost of additional work on the server
> side to attest those clients.

Agreed.
> 
> 
> Being said that, in the current proposal, taking a snapshots is totally optional
> and controlled by UM attestation clients. If the attestation-clients/services are
> not-ready/don’t-want to take advantage of IMA log snapshotting, they don’t have to.

Agreed.

> 
> No snapshot will be taken, and the client-service can process the monolithic IMA
> log just like they do today.
> 

Agreed.

> [1] https://lore.kernel.org/all/c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com/#t
> 
>>
>>
>>
>>> should have a beginning and end quote and a record of the AK used.
>>> Since verifiers like Keylime are already using this beginning and end
>>> quote for sharded logs, it's the most natural format to feed to
>>> something externally for verification and it means you don't have to
>>> invent a new format to do the same thing.
>>>
>>> Regards,
>>>
>>> James
>>>
>>>
>>> _______________________________________________
>>> kexec mailing list
>>> kexec@lists.infradead.org
>>> http://lists.infradead.org/mailman/listinfo/kexec
> 
