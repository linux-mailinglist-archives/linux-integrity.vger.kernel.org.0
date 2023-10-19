Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECEA7D0204
	for <lists+linux-integrity@lfdr.de>; Thu, 19 Oct 2023 20:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbjJSSt2 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 Oct 2023 14:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233020AbjJSSt1 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 Oct 2023 14:49:27 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 19A92CA;
        Thu, 19 Oct 2023 11:49:23 -0700 (PDT)
Received: from [192.168.86.69] (unknown [50.46.228.62])
        by linux.microsoft.com (Postfix) with ESMTPSA id 454DC20B74C0;
        Thu, 19 Oct 2023 11:49:22 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 454DC20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1697741362;
        bh=d2JVGRdv8gCcfFfmeYalZ8EYM/3NfqEVrcnGI3WvI5g=;
        h=Date:To:Cc:From:Subject:From;
        b=sNCbO4IQA6lHhxfw1f2WkM3fFczWPPHZSHYB2/vrqBescY9XnB2uITCRqwSLAQEbE
         4s+FguYPXscLPl6h4osoXw2WMxN9lYpC9erG/B4WnWLEIKrlEupFA9cGpzTeShluy1
         G9NwHhFd6TXgjfccwN/199BI8n+MHAqKuB+yNqgA=
Message-ID: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
Date:   Thu, 19 Oct 2023 11:49:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     linux-integrity@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>,
        peterhuewe@gmx.de, Jarkko Sakkinen <jarkko@kernel.org>,
        jgg@ziepe.ca, Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com,
        vgoyal@redhat.com, Dave Young <dyoung@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        jmorris@namei.org, Paul Moore <paul@paul-moore.com>,
        serge@hallyn.com,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-security-module@vger.kernel.org
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Sush Shringarputale <sushring@linux.microsoft.com>
From:   Tushar Sugandhi <tusharsu@linux.microsoft.com>
Subject: [RFC V2] IMA Log Snapshotting Design Proposal
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

=======================================================================
| Introduction                                                        |
=======================================================================
This document provides a detailed overview of the proposed Kernel
feature IMA log snapshotting.  It describes the motivation behind the
proposal, the problem to be solved, a detailed solution design with
examples, and describes the changes to be made in the clients/services
which are part of remote-attestation system.  This is the 2nd version
of the proposal.  The first version is present here[1].

Table of Contents:
------------------
A. Motivation and Background
B. Goals and Non-Goals
     B.1 Goals
     B.2 Non-Goals
C. Proposed Solution
     C.1 Solution Summary
     C.2 High-level Work-flow
D. Detailed Design
     D.1 Snapshot Aggregate Event
     D.2 Snapshot Triggering Mechanism
     D.3 Choosing A Persistent Storage Location For Snapshots
     D.4 Remote-Attestation Client/Service-side Changes
         D.4.a Client-side Changes
         D.4.b Service-side Changes
E. Example Walk-through
F. Other Design Considerations
G. References

Change Log:
-----------
This RFC proposal doc has the following changes compared to its first
version[1]
     - Added table of contents for easy navigation through the doc.
     - Clearly defined problem and added goals and non-goals this
       proposal plans to achieve.
     - Added diagrams in section "C.2 High-level Work-flow" to help
       the audience better understand the steps proposed.
     - Provided more clarity on changes needed in attestation client and
       remote attestation service to benefit from this feature.
     - Made the necessary changes to the doc based on the new learnings
       from the investigations done in the past few months.
     - Added section "F. Other Design Considerations" to address various
       concerns brought up in the first version[1] of this doc on the
       following topics:
         o TPM-PCR update counter
         o EK/AIK Public Cert
         o implications of exporting and removing records from the IMA
           measurement list
         o attestation client restarts and the remote attestation
           service being stateless
         o using 'tmpfs' to store the snapshots
         o TPM seal-unseal scenario
=======================================================================
| A. Motivation and Background                                        |
=======================================================================
Depending on the IMA policy, the IMA log can consume a lot of Kernel
memory on the system.  For instance, the events for the following IMA
policy entries may need to be measured in certain scenarios, but they
can also lead to a verbose IMA log when the system is running for a
long period of time.
┌───────────────────────────────────────┐
│# PROC_SUPER_MAGIC                     │
│measure fsmagic=0x9fa0                 │
│# SYSFS_MAGIC                          │
│measure fsmagic=0x62656572             │
│# DEBUGFS_MAGIC                        │
│measure fsmagic=0x64626720             │
│# TMPFS_MAGIC                          │
│measure fsmagic=0x01021994             │
│# RAMFS_MAGIC                          │
│measure fsmagic=0x858458f6             │
│# SECURITYFS_MAGIC                     │
│measure fsmagic=0x73636673             │
│# OVERLAYFS_MAGIC                      │
│measure fsmagic=0x794c7630             │
│# log, audit or tmp files              │
│measure obj_type=var_log_t             │
│measure obj_type=auditd_log_t          │
│measure obj_type=tmp_t                 │
└───────────────────────────────────────┘

Secondly, certain systems are configured to take Kernel updates using
Kexec soft-boot.  The IMA log from the previous Kernel gets carried
over and the Kernel memory consumption problem worsens when such
systems undergo multiple Kexec soft-boots over a long period of time.

The above two scenarios can cause IMA log to consume significant memory
on the system.

In addition, processing a larger IMA log on the Remote-Attestation
service-side is both time consuming and inefficient - because majority
of the events would be already attested in the previous attestation
requests.

To solve this problem, putting a cap on the in-memory IMA log, or
truncating IMA log to reclaim memory are not practical solutions.
Putting a cap would result in events not getting measured in the IMA
log, which would be a security vulnerability.  Truncating the log would
make the log go out of sync with the TPM PCR quote, resulting in the
remote attestation of the system to fail until the system goes through
a hard reboot.  Therefore, both these solutions are unacceptable.

A sophisticated solution is required in this case which will help
reduce the memory pressure on the system and continue supporting remote
attestation for a longer duration without disruptions.

=======================================================================
| B. Goals and Non-Goals                                              |
=======================================================================
-----------------------------------------------------------------------
| B.1 Goals                                                           |
-----------------------------------------------------------------------
To address the issues described in the section above, we propose
enhancements to the IMA subsystem to achieve the following goals:

  a. Reduce memory pressure on the Kernel caused by larger in-memory
     IMA logs.

  b. Preserve the system's ability to get remotely attested using the
     IMA log, even after implementing the enhancements to reduce memory
     pressure caused by the IMA log. IMA's Integrity guarantees should
     be maintained.

  c. Provide mechanisms from Kernel side to the remote attestation
     service to make service-side processing more efficient.

-----------------------------------------------------------------------
| B.2 Non-Goals                                                       |
-----------------------------------------------------------------------
  a. Implementing the changes needed in the remote attestation
     client/service to benefit from the proposed enhancements are out of
     scope of this proposal.  However, we will briefly discuss what needs
     to be done in that space.

=======================================================================
| C. Proposed Solution                                                |
=======================================================================

This section provides high level summary of the proposed solution and
the necessary steps in the work-flow.  The details of each aspect of
the solution and the alternate approaches considered etc. are discussed
in section "D. Detailed Design".

-----------------------------------------------------------------------
| C.1 Solution Summary                                                |
-----------------------------------------------------------------------
To achieve the goals described in the section above, we propose the
following changes to the IMA subsystem.

     a. The IMA log from Kernel memory will be offloaded to some
        persistent storage disk to keep the system running reliably
        without facing memory pressure.
        More details, alternate approaches considered etc. are present
        in section "D.3 Choices for Storing Snapshots" below.

     b. The IMA log will be divided into multiple chunks (snapshots).
        Each snapshot would be a delta between the two instances when
        the log was offloaded from memory to the persistent storage
        disk.

     c. Some UM process (like a remote-attestation-client) will be
        responsible for writing the IMA log snapshot to the disk.

     d. The same UM process would be responsible for triggering the IMA
        log snapshot.

     e. There will be a well-known location for storing the IMA log
        snapshots on the disk.  It will be non-trivial for UM processes
        to change that location after booting into the Kernel.

     f. A new event, "snapshot_aggregate", will be computed and measured
        in the IMA log as part of this feature.  It should help the
        remote-attestation client/service to benefit from the IMA log
        snapshot feature.
        The "snapshot_aggregate" event is described in more details in
        section "D.1 Snapshot Aggregate Event" below.

     g. If the existing remote-attestation client/services do not change
        to benefit from this feature or do not trigger the snapshot,
        the Kernel will continue to have it's current functionality of
        maintaining an in-memory full IMA log.

Additionally, the remote-attestation client/services need to be updated
to benefit from the IMA log snapshot feature.  These proposed changes
are described in section "D.4 Remote-Attestation Client/Service Side
Changes" below, but their implementation is out of scope for this
proposal.

-----------------------------------------------------------------------
| C.2 High-level Work-flow                                            |
-----------------------------------------------------------------------
This section describes the steps to take a snapshot of the IMA log.

The proposed high level work-flow of IMA log snapshotting is as
follows:
     a. A user-mode process will trigger the snapshot by opening a file
        in SysFS say /sys/kernel/security/ima/snapshot (referred to as
        "sysk_ima_snapshot_file" here onwards).
        See Step #a in Diagram #1 below.

     b. The Kernel will get the current TPM PCR values and store them as
        template data in a new IMA event "snapshot_aggregate".
        This event will be measured by IMA using critical data
        measurement functionality[2].
        Measuring the "snapshot_aggregate" will be an atomic operation
        similar to any other IMA log measurement.
        See Step #b and #c in Diagram #1 below.

     c. Once the "snapshot_aggregate" is computed and measured in IMA
        log, the prior IMA events will be made available in the
        "sysk_ima_snapshot_file".
        See Step #b and #c in Diagram #1 below.

                                Diagram #1
                                ----------
            Step #a                                   Step #b and #c
           ---------                                 ----------------
     (In-memory IMA log)                         (In-memory IMA log)
    .--------------------.                     .----------------------.
    | Event #E1          |                     | Event #E1            |
    | Event #E2          |                     | Event #E2            |
    |                    |                     |                      |
    |                    |                     | "snapshot_aggregate" |
    |                    |                     |   (#E1+#E2)          |
    '--------------------'                     '----------------------'
              ^                                            ^
              |                                            |
              |                                            |
KM         *Kernel*                step #b.Kernel writes  |
---          |                       "snapshot_aggregate" |
UM           |                                to IMA log  |
              |                                            |
              |                    step #c.Kernel writes   |
              |                    the events E2 and E3 to |
              |                     sysk_ima_snapshot_file |
              V                                            V
    (sysk_ima_snapshot_file)                   (sysk_ima_snapshot_file)
    .--------------------.                      .--------------------.
    |                    |                      | Event #E1          |
    |       {Empty}      |        ====>         | Event #E2          |
    |                    |                      |                    |
    '--------------------'                      '--------------------'
              ^                                            ^
              |                                            |
              |Step #a Client opens                        |
              |sysk_ima_snapshot_file                      |
              |                                            |
   *Attestation Client (UM)*                   *Attestation Client (UM)*
              |                                            |
              |                                            |
              |                                            |
              V                                            V
   UM_snapshot_file  (on DISK)               UM_snapshot_file  (on DISK)
    .--------------------.                      .--------------------.
    |                    |                      |                    |
    |       {Empty}      |                      |       {Empty}      |
    |                    |                      |                    |
    '--------------------'                      '--------------------'

     d. The UM process will copy those IMA events from
        "sysk_ima_snapshot_file" to a snapshot file on disk chosen by UM
        (referred to as "UM_snapshot_file" here onwards).
        The location, file-system type, access permissions etc. of the
        "UM_snapshot_file" would be controlled by UM process itself.
        As described in section D.3, the location of "UM_snapshot_file"
        should be well-known.
        See Step #d in Diagram #2 below.

     e. Once UM is done copying the IMA events from
        "sysk_ima_snapshot_file" to "UM_snapshot_file", it will indicate
        to the Kernel that the snapshot can be finalized by triggering a
        write with any data to the "sysk_ima_snapshot_file".  UM process
        cannot prevent the IMA log purge operation after this point.
        See Step #e in Diagram #2 below.

                                Diagram #2
                                ----------
            Step #d                                   Step #e
           ---------                                 --------
     (In-memory IMA log)                         (In-memory IMA log)
    .--------------------.                     .----------------------.
    | Event #1           |                     | Event #1             |
    | Event #2           |                     | Event #2             |
    |"snapshot_aggregate"|                     | "snapshot_aggregate" |
    |   (#E1+#E2)        |                     |   (#E1+#E2)          |
    '--------------------'                     '----------------------'
              ^                                            ^
              |                                            |
              |                                            |
KM         *Kernel*                                    *Kernel*
---          |                                            |
UM           |                                            |
              |                                            |
              |                                            |
              |                                            |
              V                                            V
    (sysk_ima_snapshot_file)                   (sysk_ima_snapshot_file)
    .--------------------.                      .--------------------.
    | Event #E1          |                      | "done"             |
    | Event #E2          |        ====>         |                    |
    |                    |                      |                    |
    '--------------------'                      '--------------------'
             ^                                             ^
             |Step #d Client copies                        |
             |events to UM_snapshot_file                   |
             |                                             |
             |                                             |
             |                       step #e Client writes |
             |                        "done" to the file   |
             |                     sysk_ima_snapshot_file  |
             |                                             |
  *Attestation Client (UM)*                   *Attestation Client (UM)*
             |                                             |
             |                                             |
             |                                             |
             V                                             V
   UM_snapshot_file  (on DISK)               UM_snapshot_file  (on DISK)
    .--------------------.                      .--------------------.
    | Event #E1          |                      |Event #E1           |
    | Event #E2          |                      |Event #E2           |
    |                    |                      |                    |
    '--------------------'                      '--------------------'

     f. The Kernel will truncate the current IMA log and and clear
        HTable up to the "snapshot_aggregate" marker.
        See Step #f in Diagram #3 below.

                                Diagram #3
                                ----------
            Step #f
           ---------
      (In-memory IMA log)
    .----------------------.
    | "snapshot_aggregate" |
    | Event #E4            |
    | Event #E5            |
    '----------------------'
              ^
              |
              | Step #f
KM           | Kernel removes the old events before
---          |  "snapshot_aggregate" i.e. #E1 and #E2.
UM           | And continues to measure the new events
              | i.e. #E4 and #E5
              |
              |
              V
   (sysk_ima_snapshot_file)
    .--------------------.
    | "done"             |
    |                    |
    |                    |
    '--------------------'
              ^
              |
              |
              | Attestation Client can now close
              | the sysk_ima_snapshot_file.
              | When it is reopened by the client, a new snapshot will
              | be triggered.
              V
   UM_snapshot_file  (on DISK)
    .--------------------.
    | Event #E1          |
    | Event #E2          |
    |                    |
    '--------------------'
     g. Optionally, UM can prevent the IMA log purge by closing the
        "sysk_ima_snapshot_file" without performing a write operation
        on it.  In this case, the events in the IMA log before
        the latest "snapshot_aggregate" will not be purged.
        While the "snapshot_aggregate" marker may still remain in the
        log as an intermediate entry, it can be ignored since it will
        not interfere with the remote attestation.

     h. This work-flow should work when interleaved with Kexec 'load'
        and 'execute' events and should not cause IMA log + snapshot to
        go out of sync with PCR quotes.  The implementation details are
        omitted from this document for brevity.

=======================================================================
| D. Detailed Design                                                  |
=======================================================================

-----------------------------------------------------------------------
| D.1 Snapshot Aggregate Event                                        |
-----------------------------------------------------------------------
When the IMA log snapshot is triggered, IMA will pause the measurements
and start computing and measurement of the event "snapshot_aggregate".

The Template Data of the "snapshot_aggregate" event will have the
following grammar:
     TEMPLATE_DATA      := <Snapshot_Counter>";"<PCR_Banks>";"
     Snapshot_Counter   := "Snapshot_Attempt_Count="
                               <num. snapshot attempts>
     PCR_Banks          := <PCR_Bank>";"|<PCR_Banks> "," <PCR_Bank>";"
     PCR_Bank           := <PCR_Hash Type> ":" <PCRn>
     PCR_Hash_Type      := "sha1"|"sha256"|"sha384"
     PCRn               := "PCR"<N>":"<PCR_Hash>
     PCR_Hash           := <hash of the PCR N>
     N                  := [0-23]

The Data Hash of the "snapshot_aggregate" event log line is -
  Append(H(snapshot_file),PCR0,PCR1,...PCR23).  All available PCR banks
  will be  included in the template data in a known structure.

The events generated between the window of "triggering of
a snapshot" and "computation and measurement of the 'snapshot_aggregate'
event data" will be queued, and they will be measured in the IMA log
after the "snapshot_aggregate" event data is computed and measured.

After "snapshot_aggregate" event data is computed and measured, the UM
process will dump the events before "snapshot_aggregate" to a well
known location on persistent storage in "UM_snapshot_file".  Once the
UM process signals that work is complete, IMA will remove those events
from the IMA log.  IMA log will now have "snapshot_aggregate" as the
first event in it.

The "snapshot_aggregate" marker provides the following benefits:
     a. It facilitates the IMA log to be divided into multiple chunks
        and provides mechanism to verify the integrity of the system
        using only the latest chunks during remote attestation.

     b. It provides tangible evidence from Kernel to the attestation
        client that IMA log snapshotting has been enabled and at least
        one snapshot exists on the system.

     c. It helps both the Kernel and UM attestation client define clear
        boundaries between multiple snapshots.

     d. In the event of multiple snapshots, the last measured
        "snapshot_aggregate" marker, which is present in the current
        segment of the IMA log, has sufficient information to verify the
        integrity of the IMA log segment as well as the previous
        snapshots using the PCR quotes.

     e. In the event of multiple snapshots, say N, if the
        remote-attestation service has already processed the last N-1
        snapshots, it can efficiently parse through them by just
        processing "snapshot_aggregate" events to compute the PCR quotes
        needed to verify the events in the last snapshot.  This should
        drastically improve the IMA log processing efficiency of the
        service.

-----------------------------------------------------------------------
| D.2 Snapshot Triggering Mechanism                                   |
-----------------------------------------------------------------------
The snapshot triggering mechanism is as described below:

     a. The IMA subsystem will create a new file:
        /sys/kernel/security/ima/snapshot
       (a.k.a. sysk_ima_snapshot_file).

     b. A UM process opening this file will trigger a snapshot.
        The file will be opened exclusively, so only one UM process can
        trigger the snapshot at a time.

     c. Once the kernel has written the "snapshot_aggregate" marker to
        the IMA log, the IMA log prior to that event can be read by UM
        on the same FD.

     d. When UM writes some data to "sysk_ima_snapshot_file", the kernel
        will finalize the snapshot by purging the in-memory IMA log.

     e. If UM closes "sysk_ima_snapshot_file" without writing to it,
        the Kernel will not purge the IMA log.

     f. If a system administrator requires that only a specific client
        process should trigger the snapshot, this capability can be set
        as an SeLinux policy.

-----------------------------------------------------------------------
| D.3 Choosing A Persistent Storage Location For Snapshots            |
-----------------------------------------------------------------------
Choosing the snapshot location is handled by the UM process.  The
location should be a well-known location, potentially set in a
configuration file or the IMA policy file under /etc.  The
configuration file should be marked as read-only for UM processes.

The Kernel will wait for the UM process to indicate that the current
IMA log has been written to "UM_snapshot_file" and only then the Kernel
will truncate the in-memory IMA log.  UM is responsible to clear any
existing UM_snapshot_file(s) on system start or on a hard reboot/power
cycle.

During the first RFC, concerns were raised over the protections of the
"UM_snapshot_file".  Just like the current IMA log sent over the
network to the attestation service, the "UM_snapshot_file" file is not
resistant to modifications, neither should it be.  The TPM PCR quote
provides the guarantee that the IMA log has not been modified - the
same PCR quote continues to provide that guarantee for the snapshot
files as well.
Using the template data in the snapshot_aggregate marker, the
attestation service can validate the integrity of the data provided in
the past snapshots.  The log is validated all the way to the final
event, which is validated by the PCR quote.

-----------------------------------------------------------------------
| D.4 Remote-Attestation Client/Service-side Changes                  |
-----------------------------------------------------------------------
A remote attestation client and service will need to be aware of the
"snapshot_aggregate" marker and how it should be handled.  A typical
attestation path on the system will remain the same - send the current
IMA log along with the signed TPM PCR quotes to the remote
attestation-service.  But the attestation clients and remote services
need to be aware that they need to use "UM_snapshot_file(s)" too,
along with PCR quotes and the data in "snapshot_aggregate" event in IMA
log to re-establish the chain of trust if the feature is enabled and a
snapshot is taken.

As mentioned above, if the existing remote-attestation client/services
do not change to benefit from the log snapshotting feature, or do not
trigger the snapshot, the Kernel will continue to have it's current
functionality of maintaining an in-memory full IMA log.

   D.4.a Client-side changes
-----------------------------------------------------------------------
To use snapshot feature, the attestation client is required to know
     - if snapshotting is supported/enabled by the Kernel
     - if snapshotting is supported/enabled by the remote-attestation
       service it interacts with
     - the correct order of UM_snapshot_file(s) for backtracking through
       the IMA log

The protocol between the remote-attestation client and service needs to
be updated to send previous snapshots to the service as requested.

If the service is not yet ready to process the "snapshot_aggregate"
events and the snapshots, then the clients should not write any data to
the sysk_ima_snapshot_file before closing it.  This will add the
"snapshot_aggregate" marker to the IMA log without purging the log.
Once the service implements "snapshot_aggregate" event parsing, the
client can implement the functionality to  write to the
"sysk_ima_snapshot_file" each time it triggers the snapshot.  This
would indicate to the Kernel that the log should be purged.

   D.4.b Service-side changes
-----------------------------------------------------------------------
For the remote attestation to work, the service will need to know how
to validate the "snapshot_aggregate" entry in the IMA log.  It will
have to read the PCR values present in the template data of the
"snapshot_aggregate" event in the latest IMA log segment, and ensure
that the PCR quotes align with the contents of the past
UM_snapshot_file(s).  This will re-establish the chain of trust needed
for the system to pass remote attestation.  This will also maintain the
ability of the remote-attestation service to seal the secrets, if the
client-server use TPM seal/unseal mechanism to attest the state of the
system.

The client-service protocol will need an implementation for requesting
previous snapshots of the IMA logs.  There may be various scenarios
when such a request is made such as:
     - the service is stateless and requires all the data since boot
       for evaluating if the attestation should succeed or not.
     - there are linked IMA events that are split across a snapshot
       boundary
     - the expected event that the service is looking for is not present
       in the current list of IMA log + UM_snapshot_file(s).

The service will need to request the client to send the old
UM_snapshot_file(s) and ensure that the log replay still generates the
expected PCR values provided in the quote.

To avoid asking for previous snapshot chunks from the system, the
service may maintain the past attestation status of the system at a
given snapshot checkpoint.  This would make the service more efficient
in processing IMA logs for attestation.  It will reduce the persistent
storage space requirements on the client.  But it would require the
service to be stateful.  It's a trade-off which needs to be evaluated
by the owners of the remote attestation service.

If the clients are not yet updated to trigger snapshots, they will
still be sending the IMA log in its entirety without any
"snapshot_aggregate" event recorded in the log.  Processing such IMA
logs is an existing service behavior, and the service should continue
supporting it until all the clients are updated to take IMA log
snapshots.  The service can use the presence of the
"snapshot_aggregate" event in the IMA log to determine and track which
clients in the fleet have the capability to generate IMA log snapshot.

=======================================================================
| E. Example Walk-through                                             |
=======================================================================
This section provides an example walk-through of the IMA log snapshot
capturing scenario.  Assume a system has below IMA log before a
snapshot is taken.
┌───┬─────────────┬────────┬────────────┬────────────────┬────────────┐
│PCR│Template Hash│Template│ Data Hash  │   Data File    │TemplateData│
├───┼─────────────┼────────┼────────────┼────────────────┼────────────┤
│10 │322a847385...│ima-sig │sha256:309..│boot_aggregate  │            │
├───┼─────────────┼────────┼────────────┼────────────────┼────────────┤
│10 │92dbf55061...│ima-buf │sha256:b93..│kernel_version..│352342347...│
├───┼─────────────┼────────┼────────────┼────────────────┼────────────┤
│11 │e8e12d9532...│ima-buf │sha256:cd0..│dm_table_load.. │568956899...│
├───┼─────────────┼────────┼────────────┼────────────────┼────────────┤
│12 │e8e12d9532...│ima-sig │sha256:560..│/usr/lib/modul..│            │
└───┴─────────────┴────────┴────────────┴────────────────┴────────────┘

For this example, the PCR values in sha256 bank are as follows:

     sha256:
         0 : 0xDA009CB9DDBF2DF2...8D3CAE516A99847262790479368F82B6
         ...
         ...
         10: 0xB93EBF68FC66C6B6...303BC0D5DA0B419F059DE27EAE3BAA29
         11: 0xCD00ABB3D84DB0F0...01A1ADCDCADB15DEED47BA6FCE40D420
         12: 0x560153FB6A0CC603...892BB48772682F692E44A0393281DB45
         ...
         ...
         23: 0x0000000000000000...00000000000000000000000000000000

If a snapshot is taken at this point, the current IMA log will be
written to the disk.  The events generated between the window of
"triggering of a snapshot" and "computation and measurement of the
snapshot_aggregate event data" will be queued, and they will be
measured in the IMA log after the "snapshot_aggregate" event data is
computed and measured.

The state of the IMA log after the snapshot:
┌───┬─────────┬────────┬───────────┬──────────────────┬───────────────┐
│PCR│Template │Template│ Data Hash │     Data File    │ Template      │
│   │ Hash    │        │           │                  │   Data        │
├───┼─────────┼────────┼───────────┼──────────────────┼───────────────┤
│10 │e55cba...│ima-buf │Sha256:30a.│snapshot_aggregate│<TEMPLATE_DATA>│
│   │         │        │           │                  │see the grammar│
│   │         │        │           │                  │   below       │
└───┴─────────┴────────┴───────────┴──────────────────┴───────────────┘

  where the Data Hash of the log line is -
  Append(H(snapshot_file),PCR0,PCR1,...PCR23).  All available PCR banks
  will be  included in the template data in a known structure.

The Template Data will follow the grammar below:
     TEMPLATE_DATA      := <Snapshot_Counter>";"<PCR_Banks>";"
     Snapshot_Counter   := "Snapshot_Attempt_Count="
                               <num. snapshot attempts>
     PCR_Banks          := <PCR_Bank>";"|<PCR_Banks> "," <PCR_Bank>";"
     PCR_Bank           := <PCR_Hash Type> ":" <PCRn>
     PCR_Hash_Type      := "sha1"|"sha256"|"sha384"
     PCRn               := "PCR"<N>":"<PCR_Hash>
     PCR_Hash           := <hash of the PCR N>
     N                  := [0-23]

The state of the PCRs after the snapshot:
     (Only PCR 10 will change, since "snapshot_aggregate" is extended
      in that PCR.)
     sha256:
         0 : 0xDA009CB9DDBF2DF2...8D3CAE516A99847262790479368F82B6
         ...
         ...
         10 : 0x30A1B69F09A9599...2518394A8E1A3B8D343D4458E6FB0B04
         11 : 0xCD00ABB3D84DB0F...01A1ADCDCADB15DEED47BA6FCE40D420
         12 : 0x560153FB6A0CC60...892BB48772682F692E44A0393281DB45
         ...
         ...
         23: 0x0000000000000000...00000000000000000000000000000000

An example of "snapshot_aggregate" template data is given below.
10 e55cba... ima-buf  Sha256:30a... snapshot_aggregate
     Snapshot_Attempt_Count=7;
     sha256:PCR0:0xDA009CB9DDBF2DF2...8D3CAE516A99847262790479368F82B6,
     sha256:PCR1:0x30A1B69F09A9599E...2518394A8E1A3B8D343D4458E6FB0B04,
     ...
     sha256:PCR23:0x30A1B69F09A9599...2518394A8E1A3B8D343D4458E6FB0B04;

Future IMA events can then continue to be extended in the assigned PCRs
and added in the IMA log after snapshot_aggregate.  Since IMA
measurements extend the TPM-PCRs and computing snapshot_aggregate
involves reading TPM PCR banks, IMA measurements must be suspended
until the snapshot_aggregate is computed and measured.  Otherwise,
these two operations may interfere with each other compromising the
integrity of the system.

The remote-attestation-service can verify the contents of the past
(N-1) UM_snapshot_file(s) by replaying the events in them and comparing
them with the PCR values stored in template data of the first
"snapshot_aggregate" event of subsequent IMA log.

=======================================================================
| F. Other Design Considerations                                      |
=======================================================================
     a. In v1 of this RFC proposal , it was discussed [5] if we should
        use TPM-PCR update counter in the "snapshot_aggregate" event.
            => After the initial investigation and prototyping[3], we
               discovered the TPM PCR counter gets incremented when any
               of the PCRs in the PCR bank gets updated.  The counter is
               not specific to any single PCR (e.g. PCR 10 where IMA
               extends the measurements by default).
               Adding TPM PCR counter to "snapshot_aggregate" event
               won't provide any additional benefits, therefore we do
               not plan to include it in any of the IMA log
               measurements.

     b. In v1 of this RFC proposal , it was discussed [6] if we should
        add the EK/AIK Public Cert as part of "snapshot_aggregate" event
        data.
            => In a typical remote attestation scenario that does not
               use IMA log snapshotting, the EK/AIK public cert
               typically needs to be sent to the remote attestation
               service along with IMA log and TPM PCR quotes.  The
               EK/AIK public cert verifies that the TPM PCR quotes are
               signed by a genuine TPM, which in turn verifies that the
               IMA log is not tampered with.  Since the EK/AIK public
               cert is anyways sent outside of the IMA log in this
               scenario, it is not needed to be sent as part of IMA log
               again.  In other scenarios (e.g. seal/unseal, and some
               cases fTPM/vTPM), the EK/AIK public cert is either
               unavailable or is not used for remote attestation.
               Therefore we will not be adding the EK/AIK public cert as
               part of "snapshot_aggregate" event data.

     c. In one of the previous attempts so to export the IMA log [4],
        several aspects of the problem were discussed.
            o "The implications of exporting and removing records from
              the IMA measurement list needs to be considered carefully"
                  => We are addressing that in this design by
                     introducing the IMA event "snapshot_aggregate", a
                     well known location to store them, coordination
                     between the Kernel and the UM process to trigger
                     and capture the snapshot, and providing guidance to
                     the client/service to process the events.
            o Conflating the two different use cases - i.e. both UM and
              the Kernel requesting exporting and removing of the
              measurement list records.
                  => We are addressing that in this design by allowing
                     only UM to request the snapshot, and store it on
                     the well known persistent storage.  Whereas only
                     Kernel being responsible for removing the exported
                     events from the Kernel memory.
                     The responsibilities of the Kernel and UM client are
                     clearly defined, and they are distinct from each
                     other.
            o The feedback from the IMA maintainer on exporting the IMA
              log [4] was that the user-space would be responsible for
              safely storing the measurements.  The kernel would only be
              responsible for limiting permission, perhaps based on a
              capability, before removing records from the measurement
              list.
                  => We have incorporated this feedback in our design.
                      - The UM process triggers the snapshot.
                      - The UM process is responsible for storing the
                        snapshot on the persistent storage.
                      - The Kernel co-ordinates with the UM process
                        before removing the records from the measurement
                        list.

     d. In v1 of this RFC proposal, some clarification was needed to
        address the attestation client restarts and the remote
        attestation service being stateless[7].
            => As mentioned in the "Non-Goals" section above,
               implementing the changes needed in the remote attestation
               client/service are out of scope for this document.
               However, taking the IMA log snapshots should not
               interfere with the ability of the client to restart at
               any point.  Even if the client restarts and does not write
               any data to "sysk_ima_snapshot_file" after recording the
               "snapshot_aggregate" event, IMA will not purge the records
               from the IMA log.  There is no data loss, and the system
               overall keeps the ability to attest itself remotely.
               Similarly, the remote-attestation-service being state-less
               or not is orthogonal to the IMA log snapshot feature.
               As discussed in detail in section D.4.b above, that
               decision should be made by the service owner after
               weighing the pros and cons.

     e. In v1 of this RFC proposal, there was discussion on using 'tmpfs'
        as a location to store the snapshot.  Even though 'tmpfs' may
        simplify some aspects of implementing the snapshotting feature,
        it doesn't really help achieving the main goal of the feature -
        i.e. reducing the memory pressure on the Kernel.
        This is because:
           - The 'tmpfs' is part of the system's memory and not
             persistent storage[8].  Moving part of IMA log to 'tmpfs'
             doesn't really address the memory pressure problem we are
             trying to solve.
           - The 'tmpfs' is an ephemeral storage.  It's contents are lost
             on reboots.  Therefore, during kexec soft-boots, the
             contents would have to be brought back to the main memory
             so that they can be mapped to the memory of the next kernel.
             Otherwise, remote attestation would fail post kexec soft
             reboot.
        Because of the above reasons, we will not store snapshots on
        'tmpfs'.

     f. In v1 of this RFC proposal, there was discussion about supporting
        TPM seal-unseal scenario in the context of IMA log snapshots[9].
        In a typical seal-unseal scenario, some secret is sealed using
        the TPM-PCR quotes on the service-side.  The service may check
        the IMA log have expected contents before sealing the secret.
        The TPM on the client-side can only unseal the secret if the PCR
        quotes are not changed since the time secret was sealed.  IMA log
        snapshots as a feature does not alter this process of
        seal-unseal.  Therefore it should not impact the core process of
        seal-unseal.  Although, as mentioned in section D.4, changes are
        needed in client/service side functionality to request snapshots
        to verify the contents of IMA log which are not present in the
        latest log segment.

We appreciate your comments on this proposal.

=======================================================================
| G. References                                                       |
=======================================================================
[1] [RFC] IMA Log Snapshotting Design Proposal (V1)
https://lore.kernel.org/linux-integrity/c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com/T/#m35e7d885db365b0aac4382830b39d446eb5efdb5

[2] IMA: support for measuring kernel integrity critical data
https://patchwork.kernel.org/project/linux-integrity/cover/20210108040708.8389-1-tusharsu@linux.microsoft.com/

[3] Measuring TPM update counter in IMA
https://patchwork.kernel.org/project/linux-integrity/cover/20230801181917.8535-1-tusharsu@linux.microsoft.com/

[4] Re: [PATCH v2] ima: export the measurement list when needed
https://lore.kernel.org/linux-integrity/1580998432.5585.411.camel@linux.ibm.com/

[5] TPM-PCR Update counters in IMA log snapshots
https://lore.kernel.org/linux-integrity/c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com/T/#m775b8b092e06bed4694b418e9d642c4d2642ee8f

[6] Adding EK/AIK Public Cert to the IMA log snapshots
https://lore.kernel.org/linux-integrity/c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com/T/#m48ec6d9ceaca40030604b2336f0ef0ada8d39e6a
https://lore.kernel.org/linux-integrity/c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com/T/#m41081713da1ca15867b623bf7d2ffb822c1fe3fd
https://lore.kernel.org/linux-integrity/c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com/T/#mb8bc2398ce4d2d71bce539776169e53b9f33c8d8

[7] About Client restarts and remote attestation service being
       stateless
https://lore.kernel.org/linux-integrity/c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com/T/#m33fc4005b94e6fab79153800a06af40477c3be65 


[8] Tmpfs
https://www.kernel.org/doc/html/latest/filesystems/tmpfs.html

[9] TPM Seal-Unseal
https://lore.kernel.org/linux-integrity/c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com/T/#m12c1b35c6d130a6ee181a8cce4c1ebdea412a19b

Thanks!
Sush & Tushar
