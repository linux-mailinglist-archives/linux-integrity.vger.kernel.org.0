Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9F2976BD73
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Aug 2023 21:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjHATMt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Aug 2023 15:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjHATMr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Aug 2023 15:12:47 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0AB441BF5;
        Tue,  1 Aug 2023 12:12:45 -0700 (PDT)
Received: from [10.137.114.52] (unknown [131.107.159.180])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4E97D238AE99;
        Tue,  1 Aug 2023 12:12:44 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4E97D238AE99
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1690917164;
        bh=WDPyxQYUrT1OuL5jCB4Yx3BUjHclVnSk8QQX5DOJwNg=;
        h=Date:To:Cc:From:Subject:From;
        b=E4jc79E5/CiAauEkbMv1o+vjZzUDs0o5o6UR/C6tGqhqVnyzoNwwOb6xtyiZnSemS
         ajI3K4kZ1AS/mixx+GoDxsh7ZZi6vnIRksdByPeHdrZ5nRn52cnSPT9uCLY4hXFBSk
         XEGQt4X1kn25StUET97navTGXEkxdizNpdLAuxLM=
Message-ID: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
Date:   Tue, 1 Aug 2023 12:12:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        peterhuewe@gmx.de, jarkko@kernel.org, jgg@ziepe.ca,
        kgold@linux.ibm.com, bhe@redhat.com, vgoyal@redhat.com,
        dyoung@redhat.com, kexec@lists.infradead.org, jmorris@namei.org,
        Paul Moore <paul@paul-moore.com>, serge@hallyn.com
Cc:     code@tyhicks.com, nramas@linux.microsoft.com,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-security-module@vger.kernel.org
From:   Sush Shringarputale <sushring@linux.microsoft.com>
Subject: [RFC] IMA Log Snapshotting Design Proposal
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

================================================
| A. Problem Statement                         |
================================================
Depending on the IMA policy, the IMA log can consume a lot of Kernel 
memory on
the device.  For instance, the events for the following IMA policy 
entries may
need to be measured in certain scenarios, but they can also lead to a 
verbose
IMA log when the device is running for a long period of time.
┌───────────────────────────────────────┐
│# PROC_SUPER_MAGIC                     │
│measure fsmagic=0x9fa0                 │
│# SYSFS_MAGIC                          │
│measure fsmagic=0x62656572             │
│# DEBUGFS_MAGIC                        │
│measure fsmagic=0x64626720             │
│# TMPFS_MAGIC                          │
│measure fsmagic=0x01021994             │
│# RAMFS_MAGIC                          │
│measure fsmagic=0x858458f6             │
│# SECURITYFS_MAGIC                     │
│measure fsmagic=0x73636673             │
│# OVERLAYFS_MAGIC                      │
│measure fsmagic=0x794c7630             │
│# log, audit or tmp files              │
│measure obj_type=var_log_t             │
│measure obj_type=auditd_log_t          │
│measure obj_type=tmp_t                 │
└───────────────────────────────────────┘

Secondly, certain devices are configured to take Kernel updates using Kexec
soft-boot.  The IMA log from the previous Kernel gets carried over and the
Kernel memory consumption problem worsens when such devices undergo multiple
Kexec soft-boots over a long period of time.

The above two scenarios can cause IMA log to grow and consume Kernel memory.

In addition, a large IMA log can add pressure on the network bandwidth when
the attestation client sends it to remote-attestation-service.

Truncating IMA log to reclaim memory is not feasible, since it makes the 
log go
out of sync with the TPM PCR quote making remote attestation fail.

A sophisticated solution is required which will help relieve the memory
pressure on the device and continue supporting remote attestation without
disruptions.

-------------------------------------------------------------------------------
================================================
| B. Proposed Solution                         |
================================================
In this document, we propose an enhancement to the IMA subsystem to improve
the long-running performance by snapshotting the IMA log, while still
providing mechanisms to verify its integrity using the PCR quotes.

The remainder of the document describes details of the proposed solution 
in the
following sub-sections.
  - High-level Work-flow
  - Snapshot Triggering Mechanism
  - Design Choices for Storing Snapshots
  - Attestation-Client and Remote-Attestation-Service Side Changes
  - Example Walk-through
  - Open Questions

-------------------------------------------------------------------------------
================================================
| B.1 High-level Work-flow                     |
================================================
Pre-requisites:
- IMA Integrity guarantees are maintained.

The proposed high level work-flow of IMA log snapshotting is as follows:
- A user-mode process will trigger the snapshot by opening a file in SysFS
   say /sys/kernel/security/ima/snapshot (referred to as 
sysk_ima_snapshot_file
   here onwards).
- The Kernel will get the current TPM PCR values and PCR update counter [2]
   and store them as template data in a new IMA event "snapshot_aggregate".
   This event will be measured by IMA using critical data measurement
   functionality [1].  Recording regular IMA events will be paused while
   "snapshot_aggregate" is being computed using the existing IMA mutex lock.
- Once the "snapshot_aggregate" is computed and measured in IMA log, the 
prior
   IMA events will be made available in the sysk_ima_snapshot_file.
- The UM process will copy those IMA events from sysk_ima_snapshot_file to a
   snapshot file on disk chosen by UM (referred to as UM_snapshot_file here
   onwards).  The location, file-system type, access permissions etc. of the
   UM_snapshot_file would be controlled by UM process itself.
- Once UM is done copying the IMA events from sysk_ima_snapshot_file to
   UM_snapshot_file, it will indicate to the Kernel that the snapshot can be
   finalized by triggering a write with any data to the 
sysk_ima_snapshot_file.
   UM process cannot prevent the IMA log purge operation after this point.
- The Kernel will truncate the current IMA log and and clear HTable up 
to the
   "snapshot_aggregate" marker.
- The Kernel will measure the PCR update counter as part of measuring
   snapshot_aggregate, so that it can be used by the remote attestation 
service
   for detecting missing events.
- UM can prevent the IMA log purge by closing the sysk_ima_snapshot_file
   without performing a write operation on it.  In this case, while the
   "snapshot_aggregate" marker may still be in the log, the event can be 
ignored
   since the previous entries in the IMA log will not be purged.

Note:
- This work-flow should work when interleaved with Kexec 'load' and 
'execute'
   events and should not cause IMA log + snapshot to go out of sync with PCR
   quotes. The implementation details are omitted from this document for
   brevity.
-------------------------------------------------------------------------------
================================================
| B.2 Snapshot Triggering Mechanism            |
================================================
The IMA subsystem will create a new file: /sys/kernel/security/ima/snapshot
(a.k.a. sysk_ima_snapshot_file). A UM process opening this file will trigger
the snapshot.  The file will be opened exclusively, so only one UM 
process can
trigger the snapshot at a time.
Once the kernel has written the snapshot_aggregate marker to the IMA 
log, the
IMA log prior to that can be read by UM on the same FD.  When UM writes some
data to sysk_ima_snapshot_file, the kernel will finalize the snapshot.  
If UM
closes sysk_ima_snapshot_file without writing to it, the Kernel will not
purge the IMA log.

If a system administrator requires that only a specific client process 
should
trigger the snapshot, this capability can be set as an SeLinux policy.

-------------------------------------------------------------------------------
================================================
| B.3 Design Choices for Storing Snapshots     |
================================================
Choosing the snapshot location is handled by the UM process.  The Kernel 
will
wait for the UM process to indicate that the current IMA log has been 
written to
UM_snapshot_file and then the Kernel will truncate the IMA log. UM is
responsible to clear any existing UM_snapshot_file(s) on system start or 
on a
hard reboot/power cycle.

-------------------------------------------------------------------------------
======================================================================
| B.4 Attestation-Client and Remote-Attestation-Service Side Changes |
======================================================================
A remote attestation client and service will need to be aware of the
snapshot_aggregate marker and how it should be handled.  A typical 
attestation
path on the device will remain the same - send the current IMA log along 
with
the signed TPM PCR quotes to the remote attestation-service.  But the
attestation clients and remote services need to be aware that they need 
to use
UM_snapshot_file(s) too, along with PCR quotes and the data in
"snapshot_aggregate" event in IMA log to re-establish the chain of trust if
the feature is enabled and a snapshot is taken.

-------------------------------------------------------------------------------
================================================
| B.4.1 Attestation-Client side changes        |
================================================
To use snapshot feature, the attestation client is required to know
     - if snapshotting is supported/enabled by the Kernel
     - if snapshotting is supported/enabled by the 
remote-attestation-service
       it interacts with
     - the correct order of UM_snapshot_file(s) for backtracking through the
       IMA log

The protocol between the attestation-client and remote-attestation-service
needs to be updated to send previous snapshots to the service as requested.

For service transition, clients connected to a service unaware of
snapshot_aggregate should not write any data to the sysk_ima_snapshot_file
before closing it.  This will add the snapshot_aggregate marker to the IMA
log without purging the log.  Once the service implements snapshot_aggregate
parsing, the client can implement the functionality to  write to the
sysk_ima_snapshot_file each time it triggers the snapshot.  This would 
indicate
to the Kernel that the log should be purged.

-------------------------------------------------------------------------------
================================================
| B.4.2 Remote-Attestation-Service side changes|
================================================
For remote attestation to work, the service will need to know how to 
validate
the snapshot_aggregate entry in the IMA log.  It will have to read the PCR
values present in the template data of snapshot_aggregate event in the 
latest
IMA log, and ensure that the PCR quotes align with the contents of the past
UM_snapshot_file(s).  This will re-establish the chain of trust needed 
for the
device to pass remote attestation.  This will also maintain the ability of
the remote-attestation-service to seal the secrets, if the client-server use
TPM unseal mechanism to attest the state of the device.

The client-service protocol will need an implementation for requesting
previous snapshots of the IMA logs.  There may be various scenarios when
such a request is made such as:
     - the service requires all the data since boot based on admin decisions
     - linked IMA events are split across a snapshot boundary
     - any other protocol level decision

The service will need to request the client to send the old 
UM_snapshot_file(s)
and ensure that the log replay still generates the expected PCR values 
provided
in the quote.

To avoid asking for previous snapshot chunks from the device, the service
may maintain the past attestation status of the device at a given snapshot
checkpoint.  This would require the service to be stateful, but it will
relieve the storage pressure on the device as well as the network bandwidth
once the attestation-client starts taking snapshots.
-------------------------------------------------------------------------------
================================================
| B.5 Example Walk-through                     |
================================================
For illustration, we provide an example of the snapshot scenario. Assume
the below is the IMA log on a system before a snapshot is taken.
┌───┬─────────────┬────────┬───────────────┬─────────────────┬────────────┐
│PCR│Template Hash│Template│   Data Hash   │    Data File │TemplateData│
├───┼─────────────┼────────┼───────────────┼─────────────────┼────────────┤
│10 │322a847385...│ima-sig │sha256:309c... │boot_aggregate │            │
├───┼─────────────┼────────┼───────────────┼─────────────────┼────────────┤
│10 │92dbf55061...│ima-buf │sha256:b93e... │kernel_version...│352342347...│
├───┼─────────────┼────────┼───────────────┼─────────────────┼────────────┤
│11 │e8e12d9532...│ima-buf │sha256:cd00... │dm_table_load....│568956899...│
├───┼─────────────┼────────┼───────────────┼─────────────────┼────────────┤
│12 │e8e12d9532...│ima-sig │sha256:5601... │/usr/lib/modul...│            │
└───┴─────────────┴────────┴───────────────┴─────────────────┴────────────┘

For this example, the PCR values in sha256 bank are as follows:

     sha256:
         0 : 
0xDA009CB9DDBF2DF2FD5982A8E44492718D3CAE516A99847262790479368F82B6
         ...
         ...
         10: 
0xB93EBF68FC66C6B6F5E2D0E34E113D84303BC0D5DA0B419F059DE27EAE3BAA29
         11: 
0xCD00ABB3D84DB0F0419F2064ECD8AD4C01A1ADCDCADB15DEED47BA6FCE40D420
         12: 
0x560153FB6A0CC6033475994ECA726765892BB48772682F692E44A0393281DB45
         ...
         ...
         23: 
0x0000000000000000000000000000000000000000000000000000000000000000

If a snapshot is taken at this point, the current IMA log will be written to
disk.  No additional events will be measured in the log until the 
snapshot is
complete.

The state of the IMA log after the snapshot:
┌───┬─────────┬────────┬─────────────┬──────────────────┬─────────────────────┐
│PCR│Template │Template│ Data Hash   │     Data File    │ Template      │
│   │ Hash    │        │             │     Data File    │ Data        │
├───┼─────────┼────────┼─────────────┼──────────────────┼─────────────────────┤
│10 │e55cba...│ima-buf │Sha256:30a...│snapshot_aggregate│ 
<TEMPLATE_DATA>   │
│   │         │        │             │                  │   see the 
grammar   │
│   │         │        │             │                  │ below          │
└───┴─────────┴────────┴─────────────┴──────────────────┴─────────────────────┘
  where the Data Hash of the log line is -
  Append(H(snapshot_file),PCR0,PCR1,...PCR23).  All available PCR banks 
will be
  included in the template data in a known structure.

The Template Data will follow the grammar below:
     TEMPLATE_DATA := 
<PCR_Update_Counter>";"<Snapshot_Counter>";"<PCR_Banks>";"
     PCR_Update_Counter := "PCR_Counter="<PCR update counter value from TPM>
     Snapshot_Counter := "Snapshot_Attempt_Count=" <num. of snapshots 
attempted>
     PCR_Banks          := <PCR_Bank>";"|<PCR_Banks> "," <PCR_Bank>";"
     PCR_Bank           := <PCR_Hash Type> ":" <PCRn>
     PCR_Hash_Type      := "sha1"|"sha256"|"sha384"
     PCRn               := "PCR"<N>":"<PCR_Hash>
     N                  := [0-23]
     PCR_Hash           := <hash_of_the_pcr_N>

The state of the PCRs after the snapshot:
     (Only PCR 10 will change, since snapshot_aggregate is being extended
      in that PCR.)
     sha256:
         0 : 
0xDA009CB9DDBF2DF2FD5982A8E44492718D3CAE516A99847262790479368F82B6
         ...
         ...
         10 : 
0x30A1B69F09A9599ED45FFEA5C94000852518394A8E1A3B8D343D4458E6FB0B04
         11 : 
0xCD00ABB3D84DB0F0419F2064ECD8AD4C01A1ADCDCADB15DEED47BA6FCE40D420
         12 : 
0x560153FB6A0CC6033475994ECA726765892BB48772682F692E44A0393281DB45
         ...
         ...
         23: 
0x0000000000000000000000000000000000000000000000000000000000000000

An example of "snapshot_aggregate" template data is given below.
10 e55cba... ima-buf  Sha256:30a... snapshot_aggregate
     PCR_Counter=11;
     Snapshot_Attempt_Count=7;
sha256:PCR0:0xDA009CB9DDBF2DF2FD5982A8E44492718D3CAE516A99847262790479368F82B6,
sha256:PCR1:0x30A1B69F09A9599ED45FFEA5C94000852518394A8E1A3B8D343D4458E6FB0B04,
     ...
sha256:PCR23:0x30A1B69F09A9599ED45FFEA5C94000852518394A8E1A3B8D343D4458E6FB0B04;

Future logs can then continue to extend the assigned PCRs.  Since IMA
measurements extend the TPM-PCRs and computing snapshot_aggregate involves
reading TPM PCR banks, IMA measurements must be suspended until the
snapshot_aggregate is computed and measured.  Otherwise, these two 
operations
may interfere with each other compromising the integrity of the system.

The remote-attestation-service can verify the contents of the past (N-1)
UM_snapshot_file(s) by replaying the events in them and comparing them
with the PCR values stored in template data of the first 
"snapshot_aggregate"
event of subsequent IMA log.

-------------------------------------------------------------------------------
================================================
| C. Open Questions                            |
================================================
1. There is a known issue with PCRs being reset after hibernate [3].  Is 
there
   any proposed solution for the hibernate problem? Can we reuse parts 
of it for
   IMA log snapshotting?

-------------------------------------------------------------------------------
We appreciate your comments on this proposal as well as pointers to any
prior efforts made in addressing this issue.

Thanks!
Sush & Tushar

-------------------------------------------------------------------------------
================================================
| D. References                                |
================================================
[1] IMA: support for measuring kernel integrity critical data
https://patchwork.kernel.org/project/linux-integrity/cover/20210108040708.8389-1-tusharsu@linux.microsoft.com/

[2] Measuring TPM update counter in IMA
https://patchwork.kernel.org/project/linux-integrity/cover/20230801181917.8535-1-tusharsu@linux.microsoft.com/

[3] TPM: Hibernate with IMA PCR 10
https://lore.kernel.org/linux-integrity/2bc656bf67af52e0b9a68e91c5b574e0ab4ffa8e.camel@linux.ibm.com/

