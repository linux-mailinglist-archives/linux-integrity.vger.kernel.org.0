Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5356977C292
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Aug 2023 23:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjHNVm7 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Aug 2023 17:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232988AbjHNVmt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Aug 2023 17:42:49 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79722127;
        Mon, 14 Aug 2023 14:42:47 -0700 (PDT)
Received: from [10.137.114.52] (unknown [131.107.159.180])
        by linux.microsoft.com (Postfix) with ESMTPSA id B551D2109420;
        Mon, 14 Aug 2023 14:42:46 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B551D2109420
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692049366;
        bh=VrEk2AwesVAfdmRxYbk7yzrle2lO+wL2DH0neWh4nIQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=S9GJfn2Od14pgUphZugp6ChcUbBhcvXvRJJmXAiyk9k0z3kSl+E7o5AKgw4z88jwL
         GHNffr/RbYjde/7Z9L/cbq9qtsFY8czbDmddnuFb0bFiUsO9uo3CQTJitVPIBdmlGu
         e3BMNSfcYTNf9J+kZYDV2PXmY+kiBu7LT/aaNkpM=
Message-ID: <bf794136-703a-0d33-e245-7e723007b5c0@linux.microsoft.com>
Date:   Mon, 14 Aug 2023 14:42:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        kgold@linux.ibm.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, kexec@lists.infradead.org, jmorris@namei.org,
        Paul Moore <paul@paul-moore.com>, serge@hallyn.com
Cc:     code@tyhicks.com, nramas@linux.microsoft.com,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-security-module@vger.kernel.org
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
 <277db5491460d5fd607785f2bcc733de39022a35.camel@linux.ibm.com>
Content-Language: en-US
From:   Sush Shringarputale <sushring@linux.microsoft.com>
In-Reply-To: <277db5491460d5fd607785f2bcc733de39022a35.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Mimi,

Thanks for your feedback on this.


On 8/11/2023 6:14 AM, Mimi Zohar wrote:
> Hi Sush, Tushar,
>
> On Tue, 2023-08-01 at 12:12 -0700, Sush Shringarputale wrote:
>> ================================================
>> | A. Problem Statement                         |
>> ================================================
>> Depending on the IMA policy, the IMA log can consume a lot of Kernel
>> memory on
>> the device.  For instance, the events for the following IMA policy
>> entries may
>> need to be measured in certain scenarios, but they can also lead to a
>> verbose
>> IMA log when the device is running for a long period of time.
>> ┌───────────────────────────────────────┐
>> │# PROC_SUPER_MAGIC                     │
>> │measure fsmagic=0x9fa0                 │
>> │# SYSFS_MAGIC                          │
>> │measure fsmagic=0x62656572             │
>> │# DEBUGFS_MAGIC                        │
>> │measure fsmagic=0x64626720             │
>> │# TMPFS_MAGIC                          │
>> │measure fsmagic=0x01021994             │
>> │# RAMFS_MAGIC                          │
>> │measure fsmagic=0x858458f6             │
>> │# SECURITYFS_MAGIC                     │
>> │measure fsmagic=0x73636673             │
>> │# OVERLAYFS_MAGIC                      │
>> │measure fsmagic=0x794c7630             │
>> │# log, audit or tmp files              │
>> │measure obj_type=var_log_t             │
>> │measure obj_type=auditd_log_t          │
>> │measure obj_type=tmp_t                 │
>> └───────────────────────────────────────┘
>>
>> Secondly, certain devices are configured to take Kernel updates using Kexec
>> soft-boot.  The IMA log from the previous Kernel gets carried over and the
>> Kernel memory consumption problem worsens when such devices undergo multiple
>> Kexec soft-boots over a long period of time.
>>
>> The above two scenarios can cause IMA log to grow and consume Kernel memory.
>>
>> In addition, a large IMA log can add pressure on the network bandwidth when
>> the attestation client sends it to remote-attestation-service.
>>
>> Truncating IMA log to reclaim memory is not feasible, since it makes the
>> log go
>> out of sync with the TPM PCR quote making remote attestation fail.
>>
>> A sophisticated solution is required which will help relieve the memory
>> pressure on the device and continue supporting remote attestation without
>> disruptions.
> If the problem is kernel memory, then using a single tmpfs file has
> already been proposed [1].  As entries are added to the measurement
> list, they are copied to the tmpfs file and removed from kernel memory.
> Userspace would still access the measurement list via the existing
> securityfs file.
>
> The IMA measurement list is a sequential file, allowing it to be read
> from an offset.  How much or how little of the measuremnt list is read
> by the attestation client and sent to the attestation server is up to
> the attestation client/server.
>
> If the problem is not kernel memory, but memory pressure in general,
> then instead of a tmpfs file, the measurement list could similarly be
> copied to a single persistent file [1].
The suggested approach in this RFC discussion using a vfs_tmpfile was
only discussed but no prototype was created back then.  We are
discussing the approach internally now and will respond with more
details about it.
>> -------------------------------------------------------------------------------
>> ================================================
>> | B. Proposed Solution                         |
>> ================================================
>> In this document, we propose an enhancement to the IMA subsystem to improve
>> the long-running performance by snapshotting the IMA log, while still
>> providing mechanisms to verify its integrity using the PCR quotes.
>>
>> The remainder of the document describes details of the proposed solution
>> in the
>> following sub-sections.
>>    - High-level Work-flow
>>    - Snapshot Triggering Mechanism
>>    - Design Choices for Storing Snapshots
>>    - Attestation-Client and Remote-Attestation-Service Side Changes
>>    - Example Walk-through
>>    - Open Questions
>> -------------------------------------------------------------------------------
>> ================================================
>> | B.1 High-level Work-flow                     |
>> ================================================
>> Pre-requisites:
>> - IMA Integrity guarantees are maintained.
>>
>> The proposed high level work-flow of IMA log snapshotting is as follows:
>> - A user-mode process will trigger the snapshot by opening a file in SysFS
>>     say /sys/kernel/security/ima/snapshot (referred to as
>> sysk_ima_snapshot_file
>>     here onwards).
> Please fix the mailer so that it doesn't wrap sentences.   Adding blank
> lines between bullets would improve readability.
Noted, will do.
>> - The Kernel will get the current TPM PCR values and PCR update counter [2]
>>     and store them as template data in a new IMA event "snapshot_aggregate".
>>     This event will be measured by IMA using critical data measurement
>>     functionality [1].  Recording regular IMA events will be paused while
>>     "snapshot_aggregate" is being computed using the existing IMA mutex lock.
>> - Once the "snapshot_aggregate" is computed and measured in IMA log, the
>> prior
>>     IMA events will be made available in the sysk_ima_snapshot_file.
>> - The UM process will copy those IMA events from sysk_ima_snapshot_file to a
>>     snapshot file on disk chosen by UM (referred to as UM_snapshot_file here
>>     onwards).  The location, file-system type, access permissions etc. of the
>>     UM_snapshot_file would be controlled by UM process itself.
>> - Once UM is done copying the IMA events from sysk_ima_snapshot_file to
>>     UM_snapshot_file, it will indicate to the Kernel that the snapshot can be
>>     finalized by triggering a write with any data to the
>> sysk_ima_snapshot_file.
>>     UM process cannot prevent the IMA log purge operation after this point.
>> - The Kernel will truncate the current IMA log and and clear HTable up
>> to the
>>     "snapshot_aggregate" marker.
>> - The Kernel will measure the PCR update counter as part of measuring
>>     snapshot_aggregate, so that it can be used by the remote attestation
>> service
>>     for detecting missing events.
>> - UM can prevent the IMA log purge by closing the sysk_ima_snapshot_file
>>     without performing a write operation on it.  In this case, while the
>>     "snapshot_aggregate" marker may still be in the log, the event can be
>> ignored
>>     since the previous entries in the IMA log will not be purged.
>>
>> Note:
>> - This work-flow should work when interleaved with Kexec 'load' and
>> 'execute'
>>     events and should not cause IMA log + snapshot to go out of sync with PCR
>>     quotes. The implementation details are omitted from this document for
>>     brevity.
> This design seems overly complex and requires synchronization between
> the "snapshot" record and exporting the records from the measurement
> list.  None of this would be necessary if the measurements were copied
> from kernel memory to a backing file (e.g. tmpfs), as described in [1].
>
> What is the real problem - kernel memory pressure, memory pressure in
> general, or disk space?  Is the intention to remove or offload the
> exported measurements?
The main concern is the memory pressure on both the kernel and the 
attestation client
when it sends the request.  The concern you bring up is valid and we are 
working on
creating a prototype.  There is no intention to remove the exported 
measurements.
- Sush
> Concerns:
> - Pausing extending the measurement list.
>
> [1]
> https://lore.kernel.org/linux-integrity/CAOQ4uxj4Pv2Wr1wgvBCDR-tnA5dsZT3rvdDzKgAH1aEV_-r9Qg@mail.gmail.com/#t
>
