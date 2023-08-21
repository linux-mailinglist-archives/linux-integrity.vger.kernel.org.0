Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E81783567
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Aug 2023 00:05:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230331AbjHUWFU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Aug 2023 18:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjHUWFU (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Aug 2023 18:05:20 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7897210E;
        Mon, 21 Aug 2023 15:05:18 -0700 (PDT)
Received: from [10.137.114.52] (unknown [131.107.159.180])
        by linux.microsoft.com (Postfix) with ESMTPSA id B1F992126CAD;
        Mon, 21 Aug 2023 15:05:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B1F992126CAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1692655517;
        bh=27Gt5g39km05HA5Jc2OsnUkxm3ZtTJbBzolAHyq7W6E=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WtMc/7fA+E88b/6c1PGfS2o3acsD8mvwk8oqoYIai5KwzJabvkzPWm8wbgfpKa4tp
         C2AAAViBNa+wg/cYNefMtzr2qSwwvLL9108tzOLmj8DwzAvEKcKIbOfMAURlJCP+++
         yojGMn7V7ij3AOoQEmMDyT9CDu3/SR9QYZzJPAQw=
Message-ID: <8bc0f024-fc12-cb32-7af0-e500948cc6db@linux.microsoft.com>
Date:   Mon, 21 Aug 2023 15:05:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
Content-Language: en-US
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
 <bf794136-703a-0d33-e245-7e723007b5c0@linux.microsoft.com>
 <0e1511e8819b24ab8a34a7b15821f06eff688f29.camel@linux.ibm.com>
From:   Sush Shringarputale <sushring@linux.microsoft.com>
In-Reply-To: <0e1511e8819b24ab8a34a7b15821f06eff688f29.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-23.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 8/14/2023 3:02 PM, Mimi Zohar wrote:
> On Mon, 2023-08-14 at 14:42 -0700, Sush Shringarputale wrote:
>>> This design seems overly complex and requires synchronization between
>>> the "snapshot" record and exporting the records from the measurement
>>> list.  None of this would be necessary if the measurements were copied
>>> from kernel memory to a backing file (e.g. tmpfs), as described in [1].
Even if the Kernel maintains the link between a tmpfs exported and an
in-memory IMA log - it still has to copy the tmpfs portion to the
Kernel memory during kexec soft boot.  tmpfs is cleared during kexec,
so this copying of tmpfs back to kernel memory is necessary to preserve
the integrity of the log during kexec.  But the copying would add back
the memory pressure on the node during kexec (which may result in
out-of-memory), defeating the purpose of the overall effort/feature.
Copying to a regular *persistent* protected file seems a cleaner
approach, compared to tmpfs.  We prototyped this solution, however it
does not seem to be a common pattern within the Kernel to write state
directly to files on disk file systems.  We considered two potential
options:

Option (A): (RECOMMENDED)
             Let Kernel write the file using KM file APIs
--------------------------------------------
     Use Kernel mode file APIs such as _file_open_root_, _vfs_llseek_,
     and _vfs_write_ to use a persistent file on disk.  There is not
     sufficient precedent for this pattern in the Kernel currently, so
     we need guidance from area experts on the best mechanism to
     implement this.

     As for the location of the file, we suggest setting this in
     KConfig. The file will be created by the Kernel, so it should be
     protected from UM access.  Additionally, on a full boot, the
     file should be cleared by the Kernel.

   POTENTIAL ISSUES AND MITIGATIONS
     - handling IO errors from KM

       A potential mitigation for this is to retry the failed write.
       This assumes that the vfs_write Kernel method can handle any
       failures gracefully without causing crashes.


     - using file system paths to resolve the file from KM

       Using the file_open_root seems to provide sufficient resiliency
       against this.  The file can be located at a well known location
       to minimize potential concerns.  However, any guidance in
       minimizing squatting risks would be greatly appreciated.

     - the file could be tampered by UM

       There needs to be a lock/kernel-only-permission on the file
       so that a UM process cannot tamper with the file.  A description
       on how this file would be protected was provided at [2].


Option (B): (NOT RECOMMENDED)
             Hand over the file writing to UM
--------------------------------------------
     Alternately, UM could write the file contents and decide the
     location of the file on disk.  If we want to preserve the Kernel
     behavior of rendering the IMA log as a single monolithic log on
     client (as ascii/binary_runtime_measurements file), the
     Kernel will have to read from a file written by UM and combine it
     with the remaining in-kernel-memory IMA log events.

     This approach of a Kernel reading from a UM written file as an
     IMA log violates the call stack, and thus it is not recommended.

If UM is to handle writing the IMA log to disk, the Kernel cannot read
those snapshotted events again.  Integrity of the IMA log can still be
maintained - a solution implementing this was in the original proposal
we submitted [1].

We appreciate the community's feedback on helping mold this feature to a
suitable implementation.

Thanks,
Sush and Tushar.


References:
[1]
https://lore.kernel.org/linux-integrity/c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com/ 


[2]
https://lore.kernel.org/linux-integrity/CAOQ4uxiBAGKco1BKgyLOMY54r_Ck2jnvz8RCFODD-V87CGqLEw@mail.gmail.com/ 

>>>
>>> What is the real problem - kernel memory pressure, memory pressure in
>>> general, or disk space?  Is the intention to remove or offload the
>>> exported measurements?
>> The main concern is the memory pressure on both the kernel and the
>> attestation client
>> when it sends the request.  The concern you bring up is valid and we are
>> working on
>> creating a prototype.  There is no intention to remove the exported
>> measurements.
> Glad to hear that you're not intending to remove the exported
> measurements.
>
> Defining and including a new record in the measurement list measurement
> is fine, if it helps with attestation and doesn't require pausing the
> measurements.
>

