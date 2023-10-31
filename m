Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3157DD698
	for <lists+linux-integrity@lfdr.de>; Tue, 31 Oct 2023 20:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231148AbjJaTPr (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 31 Oct 2023 15:15:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbjJaTPq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 31 Oct 2023 15:15:46 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D16491;
        Tue, 31 Oct 2023 12:15:40 -0700 (PDT)
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39VJ64Xs015677;
        Tue, 31 Oct 2023 19:15:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=+yXy4WSHyDcwc/7E+THauqCohmDAAp9/zz+ywcQn+uo=;
 b=fr9UwCDcgQ7WyQL3Gp71Kw96ggxAxC6O0UnvVwEQ0l5r+ilU01AmsFiCZ4PQT6P9C2ts
 wxhe/TZ6MIt0actRlJYtWC8MqlyfX5tdVJkg+PNolq7JyVz4rSFiVy76I3Ow+OFKgys+
 BinKKpl0D0x/yZ2yX0/ZgWfYkVG+8wC5NeqXpmsmDdUXyEktMUZZYhtsuqM2KTRpF3KH
 VKAGv53Xsh7uCBy0dGgH07HLm5rUkTqQSY0lIy73uMbMQlaV7TaaZyaG65D1lOB+mZXo
 yoOH8zRD1nPxWpVwqpHDsMXNKaQT8gFBeeUx2mDCsO/lCi2SbvqY+PIBbGbs8CP6P6bw dA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u37engbgu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 19:15:27 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39VJ6FjG016821;
        Tue, 31 Oct 2023 19:15:26 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3u37engbg8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 19:15:26 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
        by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39VGuld9000595;
        Tue, 31 Oct 2023 19:15:25 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
        by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3u1cmt36bv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 31 Oct 2023 19:15:25 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
        by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39VJFODp30212624
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 31 Oct 2023 19:15:24 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8836F58059;
        Tue, 31 Oct 2023 19:15:24 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8480258043;
        Tue, 31 Oct 2023 19:15:23 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.watson.ibm.com (unknown [9.31.99.90])
        by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 31 Oct 2023 19:15:23 +0000 (GMT)
Message-ID: <8bff2bf1a4629aacec7b6311d77f233cb75b2f8a.camel@linux.ibm.com>
Subject: Re: [RFC V2] IMA Log Snapshotting Design Proposal
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de,
        Jarkko Sakkinen <jarkko@kernel.org>, jgg@ziepe.ca,
        Ken Goldman <kgold@linux.ibm.com>, bhe@redhat.com,
        vgoyal@redhat.com, Dave Young <dyoung@redhat.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        jmorris@namei.org, Paul Moore <paul@paul-moore.com>,
        serge@hallyn.com,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        linux-security-module@vger.kernel.org
Cc:     Tyler Hicks <tyhicks@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Sush Shringarputale <sushring@linux.microsoft.com>
Date:   Tue, 31 Oct 2023 15:15:23 -0400
In-Reply-To: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
References: <6c0c32d5-e636-2a0e-5bdf-538c904ceea3@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: JQ0J4TKAhpdc1PTUEC36MTsLJOfaqcOI
X-Proofpoint-GUID: uxibXmpy_Y42dffhUCT28Dvgquls48YH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-31_06,2023-10-31_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 mlxscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2310310155
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2023-10-19 at 11:49 -0700, Tushar Sugandhi wrote:

[...]
> -----------------------------------------------------------------------
> | C.1 Solution Summary                                                |
> -----------------------------------------------------------------------
> To achieve the goals described in the section above, we propose the
> following changes to the IMA subsystem.
> 
>      a. The IMA log from Kernel memory will be offloaded to some
>         persistent storage disk to keep the system running reliably
>         without facing memory pressure.
>         More details, alternate approaches considered etc. are present
>         in section "D.3 Choices for Storing Snapshots" below.
> 
>      b. The IMA log will be divided into multiple chunks (snapshots).
>         Each snapshot would be a delta between the two instances when
>         the log was offloaded from memory to the persistent storage
>         disk.
> 
>      c. Some UM process (like a remote-attestation-client) will be
>         responsible for writing the IMA log snapshot to the disk.
> 
>      d. The same UM process would be responsible for triggering the IMA
>         log snapshot.
> 
>      e. There will be a well-known location for storing the IMA log
>         snapshots on the disk.  It will be non-trivial for UM processes
>         to change that location after booting into the Kernel.
> 
>      f. A new event, "snapshot_aggregate", will be computed and measured
>         in the IMA log as part of this feature.  It should help the
>         remote-attestation client/service to benefit from the IMA log
>         snapshot feature.
>         The "snapshot_aggregate" event is described in more details in
>         section "D.1 Snapshot Aggregate Event" below.
> 
>      g. If the existing remote-attestation client/services do not change
>         to benefit from this feature or do not trigger the snapshot,
>         the Kernel will continue to have it's current functionality of
>         maintaining an in-memory full IMA log.
> 
> Additionally, the remote-attestation client/services need to be updated
> to benefit from the IMA log snapshot feature.  These proposed changes
> 
> are described in section "D.4 Remote-Attestation Client/Service Side
> Changes" below, but their implementation is out of scope for this
> proposal.

As previously said on v1,
   This design seems overly complex and requires synchronization between the
   "snapshot" record and exporting the records from the measurement list. [...] 

   Concerns:
   - Pausing extending the measurement list.

Nothing has changed in terms of the complexity or in terms of pausing
the measurement list.   Pausing the measurement list is a non starter.

Userspace can already export the IMA measurement list(s) via the
securityfs {ascii,binary}_runtime_measurements file(s) and do whatever
it wants with it.  All that is missing in the kernel is the ability to
trim the measurement list, which doesn't seem all that complicated.

Mimi

