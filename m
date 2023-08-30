Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7CC478E175
	for <lists+linux-integrity@lfdr.de>; Wed, 30 Aug 2023 23:30:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241498AbjH3Val (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 30 Aug 2023 17:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241419AbjH3Vak (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 30 Aug 2023 17:30:40 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E0ACF2;
        Wed, 30 Aug 2023 14:30:13 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37UK6dIg004194;
        Wed, 30 Aug 2023 20:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=e93Bl9XZntPEfHvLWbt5rb7qPCDrqn8uHJ5nvbQx5uo=;
 b=sHyhMp1YZ/jjC1GtFaem53QJRbxTiNJfCnF6WMhvXiw22Q6qGbFVdMZyfchcCbrEIJAb
 yGOl4B1/MbTuaYpIkgoe12OJjVomTklqgzTWcF5Ka0mcMnNwqBS9ePlqJDmH+cfLy4kp
 MBpIL4+ZQZVD0YFI83ZI1/izhlPp6tyu4xYbLnWiIdZOhR2fKjsFIs4v2By9c+Wmasu7
 BESNUWtABBxlTwBvlBj5rOOrSc4fc19zHaR0hK7weH+74dyEP6PmXIfZ4ZERQq5sgmJ5
 fg/jKtneurcy3o7Vn05Q8AUnPfvER+YjdVLZk8bEkPSuV5e+ryI3nXR8Dq9j0EKIdACN HQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3st86tfh13-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 20:25:11 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37UKKEGQ018628;
        Wed, 30 Aug 2023 20:25:10 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3st86tfh0m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 20:25:10 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37UJAa2e019174;
        Wed, 30 Aug 2023 20:25:09 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sqxe1x8t3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 20:25:09 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
        by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37UKP8f965667530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Aug 2023 20:25:08 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3629858058;
        Wed, 30 Aug 2023 20:25:08 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7A1FA58059;
        Wed, 30 Aug 2023 20:25:06 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.185.26])
        by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Wed, 30 Aug 2023 20:25:06 +0000 (GMT)
Message-ID: <930e517c724fac27f7a1a4165af51dbc37cce4a0.camel@linux.ibm.com>
Subject: Re: [RFC] IMA Log Snapshotting Design Proposal
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Sush Shringarputale <sushring@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca, kgold@linux.ibm.com,
        bhe@redhat.com, vgoyal@redhat.com, dyoung@redhat.com,
        kexec@lists.infradead.org, jmorris@namei.org, serge@hallyn.com,
        code@tyhicks.com, nramas@linux.microsoft.com,
        Tushar Sugandhi <tusharsu@linux.mic>,
        linux-security-module@vger.kernel.org,
        AmirGoldstein <amir73il@gmail.com>
Date:   Wed, 30 Aug 2023 16:25:05 -0400
In-Reply-To: <CAHC9VhTvK=sJUgCUS0H9BWWXPnj3e0XkfE-4vB3-oxyt2_Wj9w@mail.gmail.com>
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
         <277db5491460d5fd607785f2bcc733de39022a35.camel@linux.ibm.com>
         <bf794136-703a-0d33-e245-7e723007b5c0@linux.microsoft.com>
         <0e1511e8819b24ab8a34a7b15821f06eff688f29.camel@linux.ibm.com>
         <8bc0f024-fc12-cb32-7af0-e500948cc6db@linux.microsoft.com>
         <7e32afa2596b9d8cfdc275614575b2023cd1d673.camel@linux.ibm.com>
         <CAHC9VhSVO9t=9e9JmniXKoqqvMv42E4dVeYtQTWZ4Eih3Sfr0Q@mail.gmail.com>
         <ed16f899485cbd559f9e6d7fbe17fa0d92335c20.camel@linux.ibm.com>
         <CAHC9VhTjej-GFjvEQhnL-HWnnkvJKA_DuOA_Md1KkV24Tx5haA@mail.gmail.com>
         <077249ac2bf2cb6d34347514e921720bb0f30b66.camel@linux.ibm.com>
         <CAHC9VhTvK=sJUgCUS0H9BWWXPnj3e0XkfE-4vB3-oxyt2_Wj9w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xnZaXGWsJw4XGqbNxHOZ8EL2lL5-k4XM
X-Proofpoint-GUID: 52qOGm2PUVla_gYmUO2WWY6XvqqAG-VH
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-30_16,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 phishscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308300182
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-08-29 at 19:15 -0400, Paul Moore wrote:
> On Tue, Aug 29, 2023 at 5:54 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Tue, 2023-08-29 at 17:30 -0400, Paul Moore wrote:
> > > On Tue, Aug 29, 2023 at 5:05 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > On Tue, 2023-08-29 at 15:34 -0400, Paul Moore wrote:
> > > > > On Mon, Aug 21, 2023 at 7:08 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > > > > > On Mon, 2023-08-21 at 15:05 -0700, Sush Shringarputale wrote:
> > > > > > > On 8/14/2023 3:02 PM, Mimi Zohar wrote:
> > > > > > > > On Mon, 2023-08-14 at 14:42 -0700, Sush Shringarputale wrote:
> > > > > > > >>> This design seems overly complex and requires synchronization between
> > > > > > > >>> the "snapshot" record and exporting the records from the measurement
> > > > > > > >>> list.  None of this would be necessary if the measurements were copied
> > > > > > > >>> from kernel memory to a backing file (e.g. tmpfs), as described in [1].
> > > > > > > Even if the Kernel maintains the link between a tmpfs exported and an
> > > > > > > in-memory IMA log - it still has to copy the tmpfs portion to the
> > > > > > > Kernel memory during kexec soft boot.  tmpfs is cleared during kexec,
> > > > > > > so this copying of tmpfs back to kernel memory is necessary to preserve
> > > > > > > the integrity of the log during kexec.  But the copying would add back
> > > > > > > the memory pressure on the node during kexec (which may result in
> > > > > > > out-of-memory), defeating the purpose of the overall effort/feature.
> > > > > > > Copying to a regular *persistent* protected file seems a cleaner
> > > > > > > approach, compared to tmpfs.
> > > > > >
> > > > > > From a kernel perspective, it doesn't make a difference if userspace
> > > > > > provides a tmpfs or persistent file.  As per the discussion
> > > > > > https://lore.kernel.org/linux-integrity/CAOQ4uxj4Pv2Wr1wgvBCDR-tnA5dsZT3rvdDzKgAH1aEV_-r9Qg@mail.gmail.com/#t
> > > > > > , userspace provides the kernel with the file descriptor of the opened
> > > > > > file.
> > > > > >
> > > > > > > We prototyped this solution, however it
> > > > > > > does not seem to be a common pattern within the Kernel to write state
> > > > > > > directly to files on disk file systems.  We considered two potential
> > > > > > > options:
> > > > > >
> > > > > > If no file descriptor is provided, then the measurements aren't copied
> > > > > > and removed from the securityfs file.  If there are write errors, the
> > > > > > measurements aren't removed from the securityfs file until the write
> > > > > > errors are resolved.
> > > > >
> > > > > It sounds like this approach would require the file/filesystem to be
> > > > > continuously available for the life of the system once the log was
> > > > > snapshotted/overflowed to persistent storage, yes?  Assuming that is
> > > > > the case, what happens if the file/filesystem becomes inaccessible at
> > > > > some point and an attestation client attempts to read the entire log?
> > > >
> > > > The main purpose of the change is to addres kernel memory pressure.
> > > > Two designs are being discussed: Sush's "snapshotting" design and
> > > > Amir's original suggestion of continously exporting the measurement
> > > > records to a tmpfs or regular file.  Both designs require verifying the
> > > > initial attestation quote by walking the entire measurement list,
> > > > calculating the expected TPM PCR value(s).  That doesn't change.
> > >
> > > Sure, but my question is about what happens if portions of the
> > > measurement list disappear due to file/filesystem problems?  How is
> > > that handled?
> >
> > With the "snapshotting" solution there could be multiple files, so
> > portions could be missing.  The other solution, the preferred solution,
> > would be one file.
> 
> With the snapshotting approach the kernel doesn't need to maintain
> ongoing access to a file, that is left up to the user process
> performing the attestation (or simply inspecting the logs).  I have to
> ask, for the third time now in as many hours, how does the proposed
> kernel-holds-an-fd-open solution handle the case where the
> file/filesystem is no longer accessible?  The snapshotting approach
> should be much more resilient here as the error recovery paths can be
> much more involved than what we would have available in the kernel,
> not to mention the flexibility of allowing a user process to determine
> how to store and manage the snapshotted log.
> 
> Considering that the snapshotting approach is opt-in (userspace has to
> initiate the snapshot), I'm not sure the concern over log offsets is a
> significant objection: existing userspace will never trigger a
> snapshot, and new userspace that could potentially trigger a snapshot
> should be written to take that into account.

Your initial question was "what happens if the file/filesystem becomes
inaccessible at some point and an attestation client attempts to read
the entire log?".  For what reason would it be inaccessible?  For the
original single tmpfs file, what would make it inaccessible?  In the
"snapshotting" design this problem becomes a userspace issue.

The first sentence of the cover letter is "Depending on the IMA policy,
the IMA log can consume a lot of Kernel memory on the device." 
Copying/exporting the measurements from kernel memory to a single
(tmpfs) file resolves the kernel memory pressure issue.  The entire
measurement list would remain accessible via the securityfs file.  As
previously mentioned in this thread, it wouldn't resolve the kexec
issue of allocating a buffer large enough for really large measurement
lists.

If the real motivation for this patch set is trimming the measurement
list, the cover letter needs to say that.  The existing "snapshotting"
design requires locking of the entire measurement list while copying
and trimming it.  The "snapshotting" design needs to be simplified. 
Perhaps a trusted userspace process could copy the measurements and
then trigger trimming of the in kernel memory/tmpfs measurement list.

-- 
thanks,

Mimi

