Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEA91790388
	for <lists+linux-integrity@lfdr.de>; Sat,  2 Sep 2023 00:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjIAWGu (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 1 Sep 2023 18:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjIAWGt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 1 Sep 2023 18:06:49 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 94A19469D;
        Fri,  1 Sep 2023 15:06:46 -0700 (PDT)
Received: from [192.168.86.41] (unknown [50.46.242.41])
        by linux.microsoft.com (Postfix) with ESMTPSA id D3815212A784;
        Fri,  1 Sep 2023 15:06:45 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D3815212A784
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1693606006;
        bh=MAPRirw43SQMAfz9BXvFsZVrtiSMUrdiYLmeabyub5w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bDc71/vAEO8noPu3QZzGncOeJGhePJcsYowD2WoxUuQ3PhfdPsMNiq3K3D1zPV17/
         iAAp0/G2gkvF6AoRvzYK20DojoEfmfkdu1VC6cILfwGa1CqvszKVyb271J28IYvAJv
         maR9SveydEYU9f2y8hl1lF6xQg7bbbtoC2s8S0LI=
Message-ID: <c83e13f8-4b7d-9489-37cc-53936b24343c@linux.microsoft.com>
Date:   Fri, 1 Sep 2023 15:06:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal - aggregate
Content-Language: en-US
To:     Ken Goldman <kgold@linux.ibm.com>,
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
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
In-Reply-To: <598fdd62-f4c3-a6dc-ae22-8f5a9e18f570@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-21.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 8/30/23 11:12, Ken Goldman wrote:
> On 8/1/2023 3:12 PM, Sush Shringarputale wrote:
>> - A user-mode process will trigger the snapshot by opening a file in 
>> SysFS
>>    say /sys/kernel/security/ima/snapshot (referred to as 
>> sysk_ima_snapshot_file
>>    here onwards).
>> - The Kernel will get the current TPM PCR values and PCR update 
>> counter [2]
>>    and store them as template data in a new IMA event 
>> "snapshot_aggregate".
> 
> If this is relying on a user-mode process, is there a concern that the 
> process doesn't run. Might it be safer to have the kernel trigger the
> snapshot.
> 
The UM process here would be typically an attestation client
which passes on the IMA log to the remote service for attestation.
If the process doesn't run, the client will operate the same way as it
does currently.

Kernel triggering snapshot would come with its own issues of Kernel
storing the snapshot on some persistent file-system. They are being
discussed on the main thread [1].

> PCR reads are not atomic, with each other and with event log appends. Is 
> this an issue?
> 
In this design, reading the PCR plus adding the snapshot_aggregate
has to be an atomic operation.  Other IMA events shouldn't interfere
with this operation. Just like IMA ensures adding an entry to the log
plus PCR extension happens in an atomic way by holding the
ima_extend_list_mutex [2], we intend to use a similar mechanism to
ensure reading the PCR plus adding the snapshot_aggregate remains an
atomic operation.  And since taking a snapshot would be a rare event
compared to adding a generic event to IMA log - overall we expect a low
overhead in case of snapshotting.

However, please note that the event addition to IMA logs will *not*
be paused while the log is written out to disk by the UM process.

> The PCR update counter can change between PCR reads.  What is its purpose?
> 
Earlier we believed the PCR update counter will help with keeping track
of events in the IMA log snapshot. But I soon realized (and it was
also pointed out by Stefan Berger on the PCR update counter patch-series 
[3]) that the update counter gets incremented on updates to any PCR
(including the PCRs not touched by IMA).

I agree that update counter may not be a reliable marker for this
particular feature.

We have put that series [3] on hold for other higher priority work items
in the IMA/kexec space.

> What is the purpose of the snapshot aggregate?  Since the entire event 
> log has to be retained and sent to the verifier, is the aggregate 
> redundant?

The goals of snapshot_aggregate marker are:
     1. To allow the IMA log to be divided into multiple chunks and
        provide attestation service the ability to verify and use the
        latest chunk (i.e. snapshot ) for attestation.

     2. To indicate to the attestation service that the client device has
        IMA log snapshotting feature enabled, and at least one snapshot
        is taken.  So that the service can ask for previous snapshots
        as needed.

     3. In the event of multiple snapshots, the snapshot_aggregate
        marker has sufficient information to verify the integrity
        of latest subset of isolated snapshots (with the help of PCR
        quote of course)

     4. snapshot_aggregate helps both kernel and UM define clear
        boundaries between multiple snapshots.
        (each new snapshot starts with either the first boot_aggregate
         or a snapshot_aggregate event)

The overall goals of IMA log snapshotting feature are:
     a. to relieve memory pressure on the client device.

     b. to make attestation service side processing more efficient
        They don't have to deal with the entire log since boot,
        as you mentioned on

     c. Reduce network bandwidth usage by sending less data
        for each attestation request.

We missed stating them explicitly in the original RFC proposal we
sent. We will add them in the next version of the proposal.

References:

[1] Re: [RFC] IMA Log Snapshotting Design Proposal - Paul Moore 
(kernel.org)
https://lore.kernel.org/linux-integrity/CAHC9VhQbnyd2nvmL-t=3kXppsm985ps+NPJ5QDvM1WSS-Hd_Ew@mail.gmail.com/


[2] ima_extend_list_mutex
https://elixir.bootlin.com/linux/latest/source/security/integrity/ima/ima_queue.c#L159

[3] Re: [PATCH 0/6] Measuring TPM update counter in IMA - Stefan Berger 
(kernel.org)
https://lore.kernel.org/linux-integrity/a4a5e40b-abc1-27fa-3984-cee18fb4522c@linux.ibm.com/

Thanks,
