Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD370776D6D
	for <lists+linux-integrity@lfdr.de>; Thu, 10 Aug 2023 03:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjHJBPu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 9 Aug 2023 21:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHJBPt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 9 Aug 2023 21:15:49 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CE96E1BD;
        Wed,  9 Aug 2023 18:15:48 -0700 (PDT)
Received: from [192.168.87.33] (c-98-237-170-177.hsd1.wa.comcast.net [98.237.170.177])
        by linux.microsoft.com (Postfix) with ESMTPSA id B431D20FC4EA;
        Wed,  9 Aug 2023 18:15:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B431D20FC4EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1691630148;
        bh=WDzxSOItJ03IYMTUWQ/lOeMY7qiRvNMmxaG1DgqmKo4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=boWQxa0hnd4R+o/Z15/ouy62SVdNlNc9KF4DAZsb1V16lUpudujcKsuK4WLb4db9S
         r200n80+tshG2xHSTAERUEc0QkPUu5jioUSVKbh/hUlA+hrLhuMGA9OIqnuh1+dur9
         4+5RZSyoVPTqctvDI5J1F2dUhEhkoLpn/x9kFWD0=
Message-ID: <b538f7d2-5a04-46d0-3792-a18653230a95@linux.microsoft.com>
Date:   Wed, 9 Aug 2023 18:15:47 -0700
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
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <5d21276a-daac-fc9b-add9-62e7c04bbdcd@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-20.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Thanks a lot Stefan for looking into this proposal,
and providing your feedback. We really appreciate it.

On 8/7/23 15:49, Stefan Berger wrote:
>
>
> On 8/1/23 17:21, James Bottomley wrote:
>> On Tue, 2023-08-01 at 12:12 -0700, Sush Shringarputale wrote:
>> [...]
>>> Truncating IMA log to reclaim memory is not feasible, since it makes
>>> the log go out of sync with the TPM PCR quote making remote
>>> attestation fail.
>>
>> This assumption isn't entirely true.  It's perfectly possible to shard
>> an IMA log using two TPM2_Quote's for the beginning and end PCR values
>> to validate the shard.  The IMA log could be truncated in the same way
>> (replace the removed part of the log with a TPM2_Quote and AK, so the
>> log still validates from the beginning quote to the end).
>>
>> If you use a TPM2_Quote mechanism to save the log, all you need to do
>> is have the kernel generate the quote with an internal AK.  You can
>> keep a record of the quote and the AK at the beginning of the truncated
>> kernel log.  If the truncated entries are saved in a file shard it
>
> The truncation seems dangerous to me. Maybe not all the scenarios with 
> an attestation
> client (client = reading logs and quoting) are possible then anymore, 
> such as starting
> an attestation client only after truncation but a verifier must have 
> witnessed the
> system's PCRs and log state before the truncation occurred.
You are correct that truncation on it’s own is dangerous. It needs to be
accompanied by (a) saving the IMA log data to disk as snapshots, (b) 
adding the
necessary TPM PCR quotes to the current IMA log (as James mentioned above),
(c) attestation clients having an ability to send the past snapshots to the
remote-attestation-service (verifiers), (d) and verifiers having an ability
to use the snapshots along with current IMA logs for the purpose of 
attestation.
All these points are explained in the original RFC email in sections B.1 
through B.5 [1].
>
> I think an ima-buf (or similar) log entry in IMA log would have to 
> appear at the beginning of the
> truncated log stating the value of all PCRs that IMA touched 
> (typically only PCR 10
> but it can be others). The needs to be done since the quote itself 
> doesn't
> provide the state of the individual PCRs. This would at least allow an 
> attestation
> client to re-read the log from the beginning (when it is re-start or 
> started for the
> first time after the truncation). 
  Agreed. See the description of snapshot_aggregate in Section B.5 in the
original RFC email [1].
> However, this alone (without the
> internal AK quoting the old state) could lead to abuse where I could 
> create totally
> fake IMA logs stating the state of the PCRs at the beginning (so the 
> verifier
> syncs its internal PCR state to this state). 
Yes, the PCR quotes sent to the verifier must be signed by the AK that
is trusted by the verifier. That assumption is true regardless of IMA log
snapshotting feature.
> Further, even with the AK-quote that
> you propose I may be able to create fake logs and trick a verifier into
> trusting the machine IFF it doesn't know what kernel this system was 
> booted with
> that I may have hacked to provide a fake AK-quote that just happens to 
> match the
> PCR state presented at the beginning of the log.
>
If the Kernel is compromised, then all-bets are off.
(Regardless of IMA log snapshotting feature.)
> => Can a truncated log be made safe for attestation when the 
> attestation starts
> only after the truncation occurred?
>
Yes. If the “PCR quotes in the snapshot_aggregate event in IMA log”
+ "replay of rest of the events in IMA log" results in the “final PCR 
quotes”
that matches with the “AK signed PCR quotes” sent by the client, then 
the truncated
IMA log can be trusted. The verifier can either ‘trust’ the “PCR quotes 
in the
snapshot_aggregate event in IMA log” or it can ask for the (n-1)th 
snapshot shard
to check the past events.

> => Even if attestation was occurring 'what' state does an attestation 
> server
> need to carry around for an attested-to system so that the truncation 
> is 'safe'
> and I cannot create fake AK-quotes and fake IMA logs with initial PCR 
> states?
Assuming most of the client devices take a snapshot at specific checkpoints,
the “PCR quotes in the snapshot_aggregate event in IMA log” will be the 
same for them.
The remote attestation server will have to remember these golden PCR quotes.
It doesn't have to remember the state of each client device.

> Can I ever restart the client and have it read the truncated log from the
> beginning and what type of verification needs to happen on the server 
> then?
>
Yes, restarting the client should be possible.
> It seems like the server would have to remember the state of the IMA 
> PCRs upon
> last truncation to detect a possible attack. This would make staring 
> to monitor
> a system after truncation impossible -- would be good to know these 
> details.
>
The server is not forced to remember the state of IMA PCRs. It can
always ask for the last n snapshot files (shards) and replay the events. 
Even
though the data is truncated from the IMA log, it is not totally lost. It is
simply being transferred to the disk. It is saved by UM as snapshot 
files/shards.
The goal of IMA snapshotting is to reduce the Kernel memory pressure on the
client devices - to save them from out-of-memory errors which are harder 
to manage
on long running clients. It comes with a cost of additional work on the 
server
side to attest those clients.


Being said that, in the current proposal, taking a snapshots is totally 
optional
and controlled by UM attestation clients. If the 
attestation-clients/services are
not-ready/don’t-want to take advantage of IMA log snapshotting, they 
don’t have to.

No snapshot will be taken, and the client-service can process the 
monolithic IMA
log just like they do today.

[1] 
https://lore.kernel.org/all/c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com/#t 


>
>
>
>> should have a beginning and end quote and a record of the AK used.
>> Since verifiers like Keylime are already using this beginning and end
>> quote for sharded logs, it's the most natural format to feed to
>> something externally for verification and it means you don't have to
>> invent a new format to do the same thing.
>>
>> Regards,
>>
>> James
>>
>>
>> _______________________________________________
>> kexec mailing list
>> kexec@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/kexec

