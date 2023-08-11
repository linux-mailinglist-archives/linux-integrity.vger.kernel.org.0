Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84714779390
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Aug 2023 17:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236673AbjHKP51 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Aug 2023 11:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231364AbjHKP51 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Aug 2023 11:57:27 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2CA8330D5;
        Fri, 11 Aug 2023 08:57:26 -0700 (PDT)
Received: from [192.168.87.33] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3EFB920FD0DE;
        Fri, 11 Aug 2023 08:57:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3EFB920FD0DE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1691769445;
        bh=zdTZE46AC8XAcWdlVWP+KP3ZBU6mAfYi7siVLldLQyw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=k4AlgKxEQE0nNZShm8hOi8/E5PIJILFlXh+hf+CccgFQjV2xJTIsKJU07QmBmptnX
         KoFCnVY3j4FyACoWuL/HkFeMBTj3lTgipUG26Pcd2V6XwxH8+DpYvIlYqm0H31cmc2
         5ab1jqMuReitE2mAt29x9TM1e9QmFkjRFhMcBwUI=
Message-ID: <aba709f8-a808-9aa4-8322-430e3997f686@linux.microsoft.com>
Date:   Fri, 11 Aug 2023 08:57:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
Content-Language: en-US
To:     Stefan Berger <stefanb@linux.ibm.com>,
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
 <011d8a79-236f-dc20-08fc-b5da7dd1d5a7@linux.ibm.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <011d8a79-236f-dc20-08fc-b5da7dd1d5a7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-18.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 8/10/23 07:12, Stefan Berger wrote:
> 
> 
> On 8/9/23 21:15, Tushar Sugandhi wrote:
>> Thanks a lot Stefan for looking into this proposal,
>> and providing your feedback. We really appreciate it.
>>
>> On 8/7/23 15:49, Stefan Berger wrote:
>>>
>>>
>>> On 8/1/23 17:21, James Bottomley wrote:
>>>> On Tue, 2023-08-01 at 12:12 -0700, Sush Shringarputale wrote:
>>>> [...]
>>>>> Truncating IMA log to reclaim memory is not feasible, since it makes
>>>>> the log go out of sync with the TPM PCR quote making remote
>>>>> attestation fail.
>>>>
>>>> This assumption isn't entirely true.  It's perfectly possible to shard
>>>> an IMA log using two TPM2_Quote's for the beginning and end PCR values
>>>> to validate the shard.  The IMA log could be truncated in the same way
>>>> (replace the removed part of the log with a TPM2_Quote and AK, so the
>>>> log still validates from the beginning quote to the end).
>>>>
>>>> If you use a TPM2_Quote mechanism to save the log, all you need to do
>>>> is have the kernel generate the quote with an internal AK.  You can
>>>> keep a record of the quote and the AK at the beginning of the truncated
>>>> kernel log.  If the truncated entries are saved in a file shard it
>>>
>>> The truncation seems dangerous to me. Maybe not all the scenarios 
>>> with an attestation
>>> client (client = reading logs and quoting) are possible then anymore, 
>>> such as starting
>>> an attestation client only after truncation but a verifier must have 
>>> witnessed the
>>> system's PCRs and log state before the truncation occurred.
>> You are correct that truncation on it’s own is dangerous. It needs to be
>> accompanied by (a) saving the IMA log data to disk as snapshots, (b) 
>> adding the
>> necessary TPM PCR quotes to the current IMA log (as James mentioned 
>> above),
>> (c) attestation clients having an ability to send the past snapshots 
>> to the
>> remote-attestation-service (verifiers), (d) and verifiers having an 
>> ability
>> to use the snapshots along with current IMA logs for the purpose of 
>> attestation.
>> All these points are explained in the original RFC email in sections 
>> B.1 through B.5 [1].
> 
> I read it.
> 
> Maybe you have dismissed the PCR update counter already...
> I am not sure what the PCR update counter is supposed to help with. It 
> won't allow you to detect
> missing log events but rather will confuse anyone looking at it when my 
> application extends PCR 12
> for example, which also affects the update counter. It's a global 
> counter that increases with every
> PCR extension (except PCR 16, 21, 22, 23) and if used as proposed would 
> prevent any application from
> extending PCRs.
> 
> https://github.com/stefanberger/libtpms/blob/master/src/tpm2/PCR.c#L667
> https://github.com/stefanberger/libtpms/blob/master/src/tpm2/PCR.c#L629
> https://github.com/stefanberger/libtpms/blob/master/src/tpm2/PCR.c#L161
> 
> 
Agree with your point about TPM PCR update counter Stefan.
I will bring it up in the update counter patch series discussion [1].

[1] 
https://patchwork.kernel.org/project/linux-integrity/cover/20230801181917.8535-1-tusharsu@linux.microsoft.com/ 


> The shards should will need to be written into some sort of standard 
> location or a config file needs to
> be defined, so that everyone knows where to find them and how they are 
> named.
> 
We thought about well known standard location earlier.
Letting the Kernel choose the name/location of the snapshot
file comes with its own complexity. Our initial stance is we don’t
want to handle that at Kernel level, and let the UM client choose
the location/naming of the snapshot files. But we are happy to
reconsider if the community requests it.
> 
>>>
>>> I think an ima-buf (or similar) log entry in IMA log would have to 
>>> appear at the beginning of the
>>> truncated log stating the value of all PCRs that IMA touched 
>>> (typically only PCR 10
>>> but it can be others). The needs to be done since the quote itself 
>>> doesn't
>>> provide the state of the individual PCRs. This would at least allow 
>>> an attestation
>>> client to re-read the log from the beginning (when it is re-start or 
>>> started for the
>>> first time after the truncation). 
>>   Agreed. See the description of snapshot_aggregate in Section B.5 in the
>> original RFC email [1].
>>> However, this alone (without the
>>> internal AK quoting the old state) could lead to abuse where I could 
>>> create totally
>>> fake IMA logs stating the state of the PCRs at the beginning (so the 
>>> verifier
>>> syncs its internal PCR state to this state). 
>> Yes, the PCR quotes sent to the verifier must be signed by the AK that
>> is trusted by the verifier. That assumption is true regardless of IMA log
>> snapshotting feature.
>>> Further, even with the AK-quote that
>>> you propose I may be able to create fake logs and trick a verifier into
>>> trusting the machine IFF it doesn't know what kernel this system was 
>>> booted with
>>> that I may have hacked to provide a fake AK-quote that just happens 
>>> to match the
>>> PCR state presented at the beginning of the log.
>>>
>> If the Kernel is compromised, then all-bets are off.
>> (Regardless of IMA log snapshotting feature.)
>>> => Can a truncated log be made safe for attestation when the 
>>> attestation starts
>>> only after the truncation occurred?
>>>
>> Yes. If the “PCR quotes in the snapshot_aggregate event in IMA log”
> 
> PCR quote or 'quotes'? Why multiple?
> 
> Form your proposal but you may have changed your opinion  following what 
> I see in other messages:
> "- The Kernel will get the current TPM PCR values and PCR update counter 
> [2]
>     and store them as template data in a new IMA event 
> "snapshot_aggregate"."
> 
> Afaik TPM quote's don't give you the state of the individual PCR values, 
> therefore
> I would expect to at least find the 'PCR values' of all the PCRs that 
> IMA touched to
> be in the snapshot_aggregate so I can replay all the following events on 
> top of these
> PCR values and come up with the values that were used in the "final PCR 
> quote". This
> is unless you expect the server to take an automatic snapshot of the 
> values of the
> PCRs  that it computed while evaluating the log in case it ever needs to 
> go back.
> 
I meant a single set of PCR values captured when snapshot_aggregate
is logged. Sorry for the confusion.

>> + "replay of rest of the events in IMA log" results in the “final PCR 
>> quotes”
>> that matches with the “AK signed PCR quotes” sent by the client, then 
>> the truncated
>> IMA log can be trusted. The verifier can either ‘trust’ the “PCR 
>> quotes in the
>> snapshot_aggregate event in IMA log” or it can ask for the (n-1)th 
>> snapshot shard
>> to check the past events.
> 
> For anything regarding determining the 'trustworthiness of a system' one 
> would have to
> be able to go back to the very beginning of the log *or* remember in 
> what state a
> system was when the latest snapshot was taken so that if a restart 
> happens it can resume
> with that assumption about state of trustworthiness and know what the 
> values of the PCRs
> were at that time so it can resume replaying the log (or the server 
> would get these
> values from the log).
> 
Correct. We intend to support the above. I hope our proposal
description captures it. BTW, when you say ‘restart’, you mean the UM
process restart, right? Because in case of a Kernel restart
(i.e. cold-boot) the past IMA log (and the TPM state) is lost,
and old snapshots (if any) are useless.

> The AK quotes by the kernel (which adds a 2nd AK key) that James is 
> proposing
> could be useful if the entire log, consisting of multiple shards, is 
> very large and
> cannot be transferred from the client to the server in one go so that 
> the server could
> evaluate the 'final PCR quote' immediately . However, if a client can 
> indicated 'I will
> send more the next time and I have this much more to transfer' and the 
> server allows
> this multiple times (until all the 1MB shards of the 20MB log are 
> transferred) then that
> kernel AK key would not be necessary since presumably the "final PCR 
> quote", created
> by a user space client, would resolve whether the entire log is 
> trustworthy.
> 
See my responses to James today [2]

[2] 
https://lore.kernel.org/all/72e39852-1ff1-c7f6-ac7e-593e8142dbe8@linux.microsoft.com/
>>
>>> => Even if attestation was occurring 'what' state does an attestation 
>>> server
>>> need to carry around for an attested-to system so that the truncation 
>>> is 'safe'
>>> and I cannot create fake AK-quotes and fake IMA logs with initial PCR 
>>> states?
>> Assuming most of the client devices take a snapshot at specific 
>> checkpoints,
>> the “PCR quotes in the snapshot_aggregate event in IMA log” will be 
>> the same for them.
>> The remote attestation server will have to remember these golden PCR 
>> quotes.
> 
> I thought maybe 'golden PCR values'... because those let me replay PCR 
> extensions from
> a previous point.
> 
>> It doesn't have to remember the state of each client device.
> 
> Can you give a reason for this? You mean the state doesn't need to be 
> remembered for client
> devices whose log hasn't been truncated?
> 
I meant it doesn’t have to be remembered for each individual
client device. Majority of the client devices will be in one of the few
golden-PCR-states when the snapshots are captured.

~ Tushar

> 
>>> Can I ever restart the client and have it read the truncated log from 
>>> the
>>> beginning and what type of verification needs to happen on the server 
>>> then?
>>>
>> Yes, restarting the client should be possible.
> 
> Yes, this must be possible.
> 
>>> It seems like the server would have to remember the state of the IMA 
>>> PCRs upon
>>> last truncation to detect a possible attack. This would make staring 
>>> to monitor
>>> a system after truncation impossible -- would be good to know these 
>>> details.
>>>
>> The server is not forced to remember the state of IMA PCRs. It can
>> always ask for the last n snapshot files (shards) and replay the 
>> events. Even
>> though the data is truncated from the IMA log, it is not totally lost. 
>> It is
>> simply being transferred to the disk. It is saved by UM as snapshot 
>> files/shards.
>> The goal of IMA snapshotting is to reduce the Kernel memory pressure 
>> on the
>> client devices - to save them from out-of-memory errors which are 
>> harder to manage
>> on long running clients. It comes with a cost of additional work on 
>> the server
>> side to attest those clients.
> 
> Agreed.
>>
>>
>> Being said that, in the current proposal, taking a snapshots is 
>> totally optional
>> and controlled by UM attestation clients. If the 
>> attestation-clients/services are
>> not-ready/don’t-want to take advantage of IMA log snapshotting, they 
>> don’t have to.
> 
> Agreed.
> 
>>
>> No snapshot will be taken, and the client-service can process the 
>> monolithic IMA
>> log just like they do today.
>>
> 
> Agreed.
> 
>> [1] 
>> https://lore.kernel.org/all/c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com/#t
>>
>>>
>>>
>>>
>>>> should have a beginning and end quote and a record of the AK used.
>>>> Since verifiers like Keylime are already using this beginning and end
>>>> quote for sharded logs, it's the most natural format to feed to
>>>> something externally for verification and it means you don't have to
>>>> invent a new format to do the same thing.
>>>>
>>>> Regards,
>>>>
>>>> James
>>>>
>>>>
>>>> _______________________________________________
>>>> kexec mailing list
>>>> kexec@lists.infradead.org
>>>> http://lists.infradead.org/mailman/listinfo/kexec
>>
