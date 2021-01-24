Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 638C0301C7B
	for <lists+linux-integrity@lfdr.de>; Sun, 24 Jan 2021 15:03:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725819AbhAXOCx (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 24 Jan 2021 09:02:53 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:50624 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725779AbhAXOCx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 24 Jan 2021 09:02:53 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10ODhSh2049852;
        Sun, 24 Jan 2021 09:02:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=uMFC1xQ6LA1lmz16wBTg03vAR5SUDLhJZCyfpExY7gQ=;
 b=ltTguhIdzdr7o1JvQxY1OVr09kclRB8xgRhuno/ojN1d/TeWVKa9e8hwDljsKpYOY/fG
 KINVaG0q9DPdh/BZlLXMm562j3i0hEKliquM6dJOv9s5HIBtxS//3qdp1lqdWVcrkhxR
 3HZDmWPSVpZi5LPy3M8I/KJsJbyxho+7R8HPiflJUeROkx3wcBPbdsjHfdy6+V2H3GTf
 x1uQDs0/8odf18Vkcf8pb+KQk3ky8OBlOBp3SYtRFJjUeaM864bQxSPFhFCM1BaiWQcD
 UGbMoqRUtJCF5JTcOKmHp/Y2G3/OFemnUmRv2H030L3WdPmIAU0bitSRv5znCQCRFS8n qg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 369a14r8p0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 Jan 2021 09:02:07 -0500
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 10OE27k0098613;
        Sun, 24 Jan 2021 09:02:07 -0500
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 369a14r8nb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 Jan 2021 09:02:07 -0500
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10OE24aU019585;
        Sun, 24 Jan 2021 14:02:04 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma02fra.de.ibm.com with ESMTP id 368be88hge-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 24 Jan 2021 14:02:04 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10OE227o38863348
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 24 Jan 2021 14:02:02 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B928AE053;
        Sun, 24 Jan 2021 14:02:02 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 10187AE055;
        Sun, 24 Jan 2021 14:01:59 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.83.155])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 24 Jan 2021 14:01:58 +0000 (GMT)
Message-ID: <5a151e3ccc1fd041482807f1caa03f1ccabe3080.camel@linux.ibm.com>
Subject: Re: [PATCH] selinux: include a consumer of the new IMA critical
 data hook
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Stephen Smalley <stephen.smalley.work@gmail.com>,
        tusharsu@linux.microsoft.com, tyhicks@linux.microsoft.com,
        casey@schaufler-ca.com, agk@redhat.com, snitzer@redhat.com,
        gmazyland@gmail.com, sashal@kernel.org,
        James Morris <jmorris@namei.org>,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date:   Sun, 24 Jan 2021 09:01:58 -0500
In-Reply-To: <CAHC9VhRyNNHm4RBNFKPyOwQM2W84JFGakDvYcaf1=MeMayAX7g@mail.gmail.com>
References: <20210114191522.4001-1-nramas@linux.microsoft.com>
         <CAHC9VhRyNNHm4RBNFKPyOwQM2W84JFGakDvYcaf1=MeMayAX7g@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-24_04:2021-01-22,2021-01-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 mlxscore=0 spamscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101240085
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2021-01-22 at 15:24 -0500, Paul Moore wrote:
> On Thu, Jan 14, 2021 at 2:15 PM Lakshmi Ramasubramanian
> <nramas@linux.microsoft.com> wrote:
> >
> > SELinux stores the active policy in memory, so the changes to this data
> > at runtime would have an impact on the security guarantees provided
> > by SELinux.  Measuring in-memory SELinux policy through IMA subsystem
> > provides a secure way for the attestation service to remotely validate
> > the policy contents at runtime.
> >
> > Measure the hash of the loaded policy by calling the IMA hook
> > ima_measure_critical_data().  Since the size of the loaded policy
> > can be large (several MB), measure the hash of the policy instead of
> > the entire policy to avoid bloating the IMA log entry.
> >
> > To enable SELinux data measurement, the following steps are required:
> >
> > 1, Add "ima_policy=critical_data" to the kernel command line arguments
> >    to enable measuring SELinux data at boot time.
> > For example,
> >   BOOT_IMAGE=/boot/vmlinuz-5.10.0-rc1+ root=UUID=fd643309-a5d2-4ed3-b10d-3c579a5fab2f ro nomodeset security=selinux ima_policy=critical_data
> >
> > 2, Add the following rule to /etc/ima/ima-policy
> >    measure func=CRITICAL_DATA label=selinux
> >
> > Sample measurement of the hash of SELinux policy:
> >
> > To verify the measured data with the current SELinux policy run
> > the following commands and verify the output hash values match.
> >
> >   sha256sum /sys/fs/selinux/policy | cut -d' ' -f 1
> >
> >   grep "selinux-policy-hash" /sys/kernel/security/integrity/ima/ascii_runtime_measurements | tail -1 | cut -d' ' -f 6
> >
> > Note that the actual verification of SELinux policy would require loading
> > the expected policy into an identical kernel on a pristine/known-safe
> > system and run the sha256sum /sys/kernel/selinux/policy there to get
> > the expected hash.
> >
> > Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> > Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> > Acked-by: Paul Moore <paul@paul-moore.com>
> > Reviewed-by: Tyler Hicks <tyhicks@linux.microsoft.com>
> > ---
> >  Documentation/ABI/testing/ima_policy |  3 +-
> >  security/selinux/Makefile            |  2 +
> >  security/selinux/ima.c               | 44 +++++++++++++++++++
> >  security/selinux/include/ima.h       | 24 +++++++++++
> >  security/selinux/include/security.h  |  3 +-
> >  security/selinux/ss/services.c       | 64 ++++++++++++++++++++++++----
> >  6 files changed, 129 insertions(+), 11 deletions(-)
> >  create mode 100644 security/selinux/ima.c
> >  create mode 100644 security/selinux/include/ima.h
> 
> Hi Mimi,
> 
> Just checking as I didn't see a reply to this from you in my inbox,
> you merged this into the IMA linux-next branch, yes?

The patches are first staged in the linux-integrity #next-integrity-
testing branch, before being staged in the #next-integrity branch,
which is picked up by linux-next.  Sorry, they've been staged in the
next-integrity-testing branch, but are now next-integrity.

Mim

