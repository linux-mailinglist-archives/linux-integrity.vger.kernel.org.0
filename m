Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D60377908B
	for <lists+linux-integrity@lfdr.de>; Fri, 11 Aug 2023 15:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235067AbjHKNOi (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 11 Aug 2023 09:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235180AbjHKNOh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 11 Aug 2023 09:14:37 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DEC430E3;
        Fri, 11 Aug 2023 06:14:37 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37BDDB3F023688;
        Fri, 11 Aug 2023 13:14:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=UTiKQPxHP9+XInf9M6OcL0KU+QcNX4/A6BYAnvAqRVY=;
 b=k8LiqP+is9xI9s8s1+DDDkSu1lIJyK+oFJGmlYvsa8JQ9cjHY+/TlxpJFwFdARYbjHRU
 GJjiz8a6FG/lIKdDM+ssihGt+h4hCmFsW1ymKjlxAGRrCbdtu7/V7mP5EVl0qhVdxFKD
 hZA21cakpykPRfj6bkR6NFtiPDa4UYVdL/cte6sX1Ylo3wajTUViaXN2Qd6PrMV+BRb9
 6PKpWcWrePULRrw2EsFnPgCQFq49BfSDGEp83lMVKcSXAPZ08FlJ2x6nZEsi4rXhi7Ep
 RcDKwG8wNp7x85fCloRFGGUlzZulqQe87DDRgfKG0+yvdoZjIoCwXJvJPC33iqKwV6Lc uQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sdnh18kc8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 13:14:21 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37BD2ZaS028781;
        Fri, 11 Aug 2023 13:14:20 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sdnh18kc1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 13:14:20 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37BCFBCS006638;
        Fri, 11 Aug 2023 13:14:19 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sa0rtubdy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 11 Aug 2023 13:14:19 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37BDEIaW2359886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Aug 2023 13:14:19 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D4E605805B;
        Fri, 11 Aug 2023 13:14:18 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C682F5806E;
        Fri, 11 Aug 2023 13:14:16 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.113.246])
        by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 11 Aug 2023 13:14:16 +0000 (GMT)
Message-ID: <277db5491460d5fd607785f2bcc733de39022a35.camel@linux.ibm.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, kgold@linux.ibm.com,
        bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, jmorris@namei.org,
        Paul Moore <paul@paul-moore.com>, serge@hallyn.com
Cc:     code@tyhicks.com, nramas@linux.microsoft.com,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-security-module@vger.kernel.org
Date:   Fri, 11 Aug 2023 09:14:16 -0400
In-Reply-To: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 5wfxI5iACBOcd6QVHIzpBngjg7NYlKbN
X-Proofpoint-GUID: 54esZe1azSU04H6l--Yq-t-MdNBGd7Xf
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-11_04,2023-08-10_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308110119
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Sush, Tushar,

On Tue, 2023-08-01 at 12:12 -0700, Sush Shringarputale wrote:
> ================================================
> | A. Problem Statement                         |
> ================================================
> Depending on the IMA policy, the IMA log can consume a lot of Kernel 
> memory on
> the device.  For instance, the events for the following IMA policy 
> entries may
> need to be measured in certain scenarios, but they can also lead to a 
> verbose
> IMA log when the device is running for a long period of time.
> ┌───────────────────────────────────────┐
> │# PROC_SUPER_MAGIC                     │
> │measure fsmagic=0x9fa0                 │
> │# SYSFS_MAGIC                          │
> │measure fsmagic=0x62656572             │
> │# DEBUGFS_MAGIC                        │
> │measure fsmagic=0x64626720             │
> │# TMPFS_MAGIC                          │
> │measure fsmagic=0x01021994             │
> │# RAMFS_MAGIC                          │
> │measure fsmagic=0x858458f6             │
> │# SECURITYFS_MAGIC                     │
> │measure fsmagic=0x73636673             │
> │# OVERLAYFS_MAGIC                      │
> │measure fsmagic=0x794c7630             │
> │# log, audit or tmp files              │
> │measure obj_type=var_log_t             │
> │measure obj_type=auditd_log_t          │
> │measure obj_type=tmp_t                 │
> └───────────────────────────────────────┘
> 
> Secondly, certain devices are configured to take Kernel updates using Kexec
> soft-boot.  The IMA log from the previous Kernel gets carried over and the
> Kernel memory consumption problem worsens when such devices undergo multiple
> Kexec soft-boots over a long period of time.
> 
> The above two scenarios can cause IMA log to grow and consume Kernel memory.
> 
> In addition, a large IMA log can add pressure on the network bandwidth when
> the attestation client sends it to remote-attestation-service.
> 
> Truncating IMA log to reclaim memory is not feasible, since it makes the 
> log go
> out of sync with the TPM PCR quote making remote attestation fail.
> 
> A sophisticated solution is required which will help relieve the memory
> pressure on the device and continue supporting remote attestation without
> disruptions.

If the problem is kernel memory, then using a single tmpfs file has
already been proposed [1].  As entries are added to the measurement
list, they are copied to the tmpfs file and removed from kernel memory.
Userspace would still access the measurement list via the existing
securityfs file.

The IMA measurement list is a sequential file, allowing it to be read
from an offset.  How much or how little of the measuremnt list is read
by the attestation client and sent to the attestation server is up to
the attestation client/server.

If the problem is not kernel memory, but memory pressure in general,
then instead of a tmpfs file, the measurement list could similarly be
copied to a single persistent file [1].

> 
> -------------------------------------------------------------------------------
> ================================================
> | B. Proposed Solution                         |
> ================================================
> In this document, we propose an enhancement to the IMA subsystem to improve
> the long-running performance by snapshotting the IMA log, while still
> providing mechanisms to verify its integrity using the PCR quotes.
> 
> The remainder of the document describes details of the proposed solution 
> in the
> following sub-sections.
>   - High-level Work-flow
>   - Snapshot Triggering Mechanism
>   - Design Choices for Storing Snapshots
>   - Attestation-Client and Remote-Attestation-Service Side Changes
>   - Example Walk-through
>   - Open Questions
> -------------------------------------------------------------------------------
> ================================================
> | B.1 High-level Work-flow                     |
> ================================================
> Pre-requisites:
> - IMA Integrity guarantees are maintained.
> 
> The proposed high level work-flow of IMA log snapshotting is as follows:
> - A user-mode process will trigger the snapshot by opening a file in SysFS
>    say /sys/kernel/security/ima/snapshot (referred to as 
> sysk_ima_snapshot_file
>    here onwards).

Please fix the mailer so that it doesn't wrap sentences.   Adding blank
lines between bullets would improve readability.

> - The Kernel will get the current TPM PCR values and PCR update counter [2]
>    and store them as template data in a new IMA event "snapshot_aggregate".
>    This event will be measured by IMA using critical data measurement
>    functionality [1].  Recording regular IMA events will be paused while
>    "snapshot_aggregate" is being computed using the existing IMA mutex lock.

> - Once the "snapshot_aggregate" is computed and measured in IMA log, the 
> prior
>    IMA events will be made available in the sysk_ima_snapshot_file.

> - The UM process will copy those IMA events from sysk_ima_snapshot_file to a
>    snapshot file on disk chosen by UM (referred to as UM_snapshot_file here
>    onwards).  The location, file-system type, access permissions etc. of the
>    UM_snapshot_file would be controlled by UM process itself.

> - Once UM is done copying the IMA events from sysk_ima_snapshot_file to
>    UM_snapshot_file, it will indicate to the Kernel that the snapshot can be
>    finalized by triggering a write with any data to the 
> sysk_ima_snapshot_file.

>    UM process cannot prevent the IMA log purge operation after this point.
> - The Kernel will truncate the current IMA log and and clear HTable up 
> to the
>    "snapshot_aggregate" marker.

> - The Kernel will measure the PCR update counter as part of measuring
>    snapshot_aggregate, so that it can be used by the remote attestation 
> service
>    for detecting missing events.

> - UM can prevent the IMA log purge by closing the sysk_ima_snapshot_file
>    without performing a write operation on it.  In this case, while the
>    "snapshot_aggregate" marker may still be in the log, the event can be 
> ignored
>    since the previous entries in the IMA log will not be purged.
> 
> Note:
> - This work-flow should work when interleaved with Kexec 'load' and 
> 'execute'
>    events and should not cause IMA log + snapshot to go out of sync with PCR
>    quotes. The implementation details are omitted from this document for
>    brevity.

This design seems overly complex and requires synchronization between
the "snapshot" record and exporting the records from the measurement
list.  None of this would be necessary if the measurements were copied
from kernel memory to a backing file (e.g. tmpfs), as described in [1].

What is the real problem - kernel memory pressure, memory pressure in
general, or disk space?  Is the intention to remove or offload the
exported measurements?

Concerns:
- Pausing extending the measurement list.

[1] 
https://lore.kernel.org/linux-integrity/CAOQ4uxj4Pv2Wr1wgvBCDR-tnA5dsZT3rvdDzKgAH1aEV_-r9Qg@mail.gmail.com/#t

-- 
thanks,

Mimi

