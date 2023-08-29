Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC39978CDFD
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Aug 2023 23:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233765AbjH2VGD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Aug 2023 17:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239403AbjH2VFr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Aug 2023 17:05:47 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC3F1BB;
        Tue, 29 Aug 2023 14:05:42 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37TK76oj004278;
        Tue, 29 Aug 2023 21:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ihzL/W9FzcQZ7fm2BjHiLVww0oMlJIP35gQzj14CL7Q=;
 b=M8RYeQZ84aYrwKkwhLeteCej3JkPfQ9kmN6ODV1mKYHOQBxMOqO6PjIYfivyHeFx10QE
 aAlGSwfl/mY0sAZ2kSQFlwGCU7sIav2ley+ZUzZSGFrdj6DLzB7CgCiOwK30ArUivWcD
 /OnMbO4jm3wnhnwzmpYf1bA4kR7EuImbce9ylAHNiBA4rf4Ksgkd2Ff7trtUnSNLXTe8
 VBMEo2+QPu2F8gZXggG4PxZxJ3yMdOtmtKUQenVZ0QjQ1f4jHzcknG8fjXz/OHV8DSLB
 Nv0/wi1b1vE6j9vueQ27IIcT/XGCvI+UOjHnOU/Zk1SEmVMStH3vg/eFB4gNpWaOBKbx SQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sspm92tqe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 21:05:17 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 37TL2bN9002641;
        Tue, 29 Aug 2023 21:04:53 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sspm92px4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 21:04:53 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 37TKYEaS014209;
        Tue, 29 Aug 2023 21:03:26 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sqwxjx307-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Aug 2023 21:03:26 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
        by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37TL3PXQ62914864
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Aug 2023 21:03:26 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A066F5805D;
        Tue, 29 Aug 2023 21:03:25 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B49555805A;
        Tue, 29 Aug 2023 21:03:23 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.61.191.86])
        by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 29 Aug 2023 21:03:23 +0000 (GMT)
Message-ID: <ed16f899485cbd559f9e6d7fbe17fa0d92335c20.camel@linux.ibm.com>
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
Date:   Tue, 29 Aug 2023 17:03:23 -0400
In-Reply-To: <CAHC9VhSVO9t=9e9JmniXKoqqvMv42E4dVeYtQTWZ4Eih3Sfr0Q@mail.gmail.com>
References: <c5737141-7827-1c83-ab38-0119dcfea485@linux.microsoft.com>
         <277db5491460d5fd607785f2bcc733de39022a35.camel@linux.ibm.com>
         <bf794136-703a-0d33-e245-7e723007b5c0@linux.microsoft.com>
         <0e1511e8819b24ab8a34a7b15821f06eff688f29.camel@linux.ibm.com>
         <8bc0f024-fc12-cb32-7af0-e500948cc6db@linux.microsoft.com>
         <7e32afa2596b9d8cfdc275614575b2023cd1d673.camel@linux.ibm.com>
         <CAHC9VhSVO9t=9e9JmniXKoqqvMv42E4dVeYtQTWZ4Eih3Sfr0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SNasfXgdex7kTnOpdfzuDRVJ4MjVLi2H
X-Proofpoint-GUID: q7YUS0B9NJtwKeo5JRBEMGYn2EfM2VGN
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-29_14,2023-08-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 spamscore=0 suspectscore=0 impostorscore=0
 phishscore=0 mlxscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2308100000
 definitions=main-2308290181
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2023-08-29 at 15:34 -0400, Paul Moore wrote:
> On Mon, Aug 21, 2023 at 7:08 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
> > On Mon, 2023-08-21 at 15:05 -0700, Sush Shringarputale wrote:
> > > On 8/14/2023 3:02 PM, Mimi Zohar wrote:
> > > > On Mon, 2023-08-14 at 14:42 -0700, Sush Shringarputale wrote:
> > > >>> This design seems overly complex and requires synchronization between
> > > >>> the "snapshot" record and exporting the records from the measurement
> > > >>> list.  None of this would be necessary if the measurements were copied
> > > >>> from kernel memory to a backing file (e.g. tmpfs), as described in [1].
> > > Even if the Kernel maintains the link between a tmpfs exported and an
> > > in-memory IMA log - it still has to copy the tmpfs portion to the
> > > Kernel memory during kexec soft boot.  tmpfs is cleared during kexec,
> > > so this copying of tmpfs back to kernel memory is necessary to preserve
> > > the integrity of the log during kexec.  But the copying would add back
> > > the memory pressure on the node during kexec (which may result in
> > > out-of-memory), defeating the purpose of the overall effort/feature.
> > > Copying to a regular *persistent* protected file seems a cleaner
> > > approach, compared to tmpfs.
> >
> > From a kernel perspective, it doesn't make a difference if userspace
> > provides a tmpfs or persistent file.  As per the discussion
> > https://lore.kernel.org/linux-integrity/CAOQ4uxj4Pv2Wr1wgvBCDR-tnA5dsZT3rvdDzKgAH1aEV_-r9Qg@mail.gmail.com/#t
> > , userspace provides the kernel with the file descriptor of the opened
> > file.
> >
> > > We prototyped this solution, however it
> > > does not seem to be a common pattern within the Kernel to write state
> > > directly to files on disk file systems.  We considered two potential
> > > options:
> >
> > If no file descriptor is provided, then the measurements aren't copied
> > and removed from the securityfs file.  If there are write errors, the
> > measurements aren't removed from the securityfs file until the write
> > errors are resolved.
> 
> It sounds like this approach would require the file/filesystem to be
> continuously available for the life of the system once the log was
> snapshotted/overflowed to persistent storage, yes?  Assuming that is
> the case, what happens if the file/filesystem becomes inaccessible at
> some point and an attestation client attempts to read the entire log?

The main purpose of the change is to addres kernel memory pressure. 
Two designs are being discussed: Sush's "snapshotting" design and
Amir's original suggestion of continously exporting the measurement
records to a tmpfs or regular file.  Both designs require verifying the
initial attestation quote by walking the entire measurement list,
calculating the expected TPM PCR value(s).  That doesn't change.

-- 
thanks,

Mimi

