Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B04783618
	for <lists+linux-integrity@lfdr.de>; Tue, 22 Aug 2023 01:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbjHUXIS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 21 Aug 2023 19:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjHUXIS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 21 Aug 2023 19:08:18 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E81130;
        Mon, 21 Aug 2023 16:08:16 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37LN6WJS000663;
        Mon, 21 Aug 2023 23:07:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=36XwjfYqUjEXR6AeSWBYlEfAWJFkC+REbYhvlu74dS8=;
 b=cDg917xMpI2GCYjLi9mj0BNewIyd3fHrFKD6BE7z+FgAP9daXaaDPh05+s83WsT1zoOd
 L1iR/+sjHbaajjWCVhUaV865TYweRy2bbWgkVFZEbi3X3Ksr2leMVm7uq1hOXSvH8Q7F
 Ey1b+OZ++tnNctUKqOUAOwqcokFHOnhKhU6YM7rOCnCos3EYMtHPYlHiVzL0KBKaqzB1
 /HAGw/i4flwJVGoMPFNrWgRKWd0WQG4KB7tO81VL7d54ZzoS8OuipzM/Y5+4mtxjeLyW
 fozeznDtzaGkzFVzLOdDL0BBpkeF9uCRSl0io0lEYA/f1oggOMyvuRa9wzD7YUX5pKw/ sg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3smha6g0vb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 23:07:45 +0000
Received: from m0353724.ppops.net (m0353724.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37LN6YeU000738;
        Mon, 21 Aug 2023 23:07:44 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3smha6g0v1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 23:07:44 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37LN0io6009007;
        Mon, 21 Aug 2023 23:07:44 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3smak9apga-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Aug 2023 23:07:44 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37LN7hra32571968
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Aug 2023 23:07:43 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 89C8F58095;
        Mon, 21 Aug 2023 23:07:43 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C521258098;
        Mon, 21 Aug 2023 23:07:41 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.28.246])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Mon, 21 Aug 2023 23:07:41 +0000 (GMT)
Message-ID: <7e32afa2596b9d8cfdc275614575b2023cd1d673.camel@linux.ibm.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, kgold@linux.ibm.com,
        bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, jmorris@namei.org,
        Paul Moore <paul@paul-moore.com>, serge@hallyn.com
Cc:     code@tyhicks.com, nramas@linux.microsoft.com,
        Tushar Sugandhi <tusharsu@linux.mic>,
        linux-security-module@vger.kernel.org,
        AmirGoldstein <amir73il@gmail.com>
Date:   Mon, 21 Aug 2023 19:07:41 -0400
In-Reply-To: <8bc0f024-fc12-cb32-7af0-e500948cc6db@linux.microsoft.com>
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
         <277db5491460d5fd607785f2bcc733de39022a35.camel@linux.ibm.com>
         <bf794136-703a-0d33-e245-7e723007b5c0@linux.microsoft.com>
         <0e1511e8819b24ab8a34a7b15821f06eff688f29.camel@linux.ibm.com>
         <8bc0f024-fc12-cb32-7af0-e500948cc6db@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: -D5ax3zTZYRyNtlaU9dqh-d7Pa5BF0kz
X-Proofpoint-ORIG-GUID: qWv9fjzMfaiyoG6e153jXVRcztQr7EwZ
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-21_10,2023-08-18_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 impostorscore=0
 malwarescore=0 mlxlogscore=999 suspectscore=0 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308210212
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-08-21 at 15:05 -0700, Sush Shringarputale wrote:
> 
> On 8/14/2023 3:02 PM, Mimi Zohar wrote:
> > On Mon, 2023-08-14 at 14:42 -0700, Sush Shringarputale wrote:
> >>> This design seems overly complex and requires synchronization between
> >>> the "snapshot" record and exporting the records from the measurement
> >>> list.  None of this would be necessary if the measurements were copied
> >>> from kernel memory to a backing file (e.g. tmpfs), as described in [1].
> Even if the Kernel maintains the link between a tmpfs exported and an
> in-memory IMA log - it still has to copy the tmpfs portion to the
> Kernel memory during kexec soft boot.  tmpfs is cleared during kexec,
> so this copying of tmpfs back to kernel memory is necessary to preserve
> the integrity of the log during kexec.  But the copying would add back
> the memory pressure on the node during kexec (which may result in
> out-of-memory), defeating the purpose of the overall effort/feature.
> Copying to a regular *persistent* protected file seems a cleaner
> approach, compared to tmpfs.

From a kernel perspective, it doesn't make a difference if userspace
provides a tmpfs or persistent file.  As per the discussion 
https://lore.kernel.org/linux-integrity/CAOQ4uxj4Pv2Wr1wgvBCDR-tnA5dsZT3rvdDzKgAH1aEV_-r9Qg@mail.gmail.com/#t
, userspace provides the kernel with the file descriptor of the opened
file.

> We prototyped this solution, however it
> does not seem to be a common pattern within the Kernel to write state
> directly to files on disk file systems.  We considered two potential
> options:

If no file descriptor is provided, then the measurements aren't copied
and removed from the securityfs file.  If there are write errors, the
measurements aren't removed from the securityfs file until the write
errors are resolved.

Mimi

> 
> Option (A): (RECOMMENDED)
>              Let Kernel write the file using KM file APIs
> --------------------------------------------
>      Use Kernel mode file APIs such as _file_open_root_, _vfs_llseek_,
>      and _vfs_write_ to use a persistent file on disk.  There is not
>      sufficient precedent for this pattern in the Kernel currently, so
>      we need guidance from area experts on the best mechanism to
>      implement this.
> 
>      As for the location of the file, we suggest setting this in
>      KConfig. The file will be created by the Kernel, so it should be
>      protected from UM access.  Additionally, on a full boot, the
>      file should be cleared by the Kernel.
> 
>    POTENTIAL ISSUES AND MITIGATIONS
>      - handling IO errors from KM
> 
>        A potential mitigation for this is to retry the failed write.
>        This assumes that the vfs_write Kernel method can handle any
>        failures gracefully without causing crashes.
> 
> 
>      - using file system paths to resolve the file from KM
> 
>        Using the file_open_root seems to provide sufficient resiliency
>        against this.  The file can be located at a well known location
>        to minimize potential concerns.  However, any guidance in
>        minimizing squatting risks would be greatly appreciated.
> 
>      - the file could be tampered by UM
> 
>        There needs to be a lock/kernel-only-permission on the file
>        so that a UM process cannot tamper with the file.  A description
>        on how this file would be protected was provided at [2].
> 
> Option (B): (NOT RECOMMENDED)
>              Hand over the file writing to UM
> --------------------------------------------
>      Alternately, UM could write the file contents and decide the
>      location of the file on disk.  If we want to preserve the Kernel
>      behavior of rendering the IMA log as a single monolithic log on
>      client (as ascii/binary_runtime_measurements file), the
>      Kernel will have to read from a file written by UM and combine it
>      with the remaining in-kernel-memory IMA log events.
> 
>      This approach of a Kernel reading from a UM written file as an
>      IMA log violates the call stack, and thus it is not recommended.
> 
> If UM is to handle writing the IMA log to disk, the Kernel cannot read
> those snapshotted events again.  Integrity of the IMA log can still be
> maintained - a solution implementing this was in the original proposal
> we submitted [1].
> 
> We appreciate the community's feedback on helping mold this feature to a
> suitable implementation.
> 
> Thanks,
> Sush and Tushar.
> 
> 
> References:
> [1]
> https://lore.kernel.org/linux-integrity/c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com/ 
> 
> 
> [2]
> https://lore.kernel.org/linux-integrity/CAOQ4uxiBAGKco1BKgyLOMY54r_Ck2jnvz8RCFODD-V87CGqLEw@mail.gmail.com/ 
> 
> >>>
> >>> What is the real problem - kernel memory pressure, memory pressure in
> >>> general, or disk space?  Is the intention to remove or offload the
> >>> exported measurements?
> >> The main concern is the memory pressure on both the kernel and the
> >> attestation client
> >> when it sends the request.  The concern you bring up is valid and we are
> >> working on
> >> creating a prototype.  There is no intention to remove the exported
> >> measurements.
> > Glad to hear that you're not intending to remove the exported
> > measurements.
> >
> > Defining and including a new record in the measurement list measurement
> > is fine, if it helps with attestation and doesn't require pausing the
> > measurements.
> >
> 


