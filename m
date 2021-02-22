Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01321320FF8
	for <lists+linux-integrity@lfdr.de>; Mon, 22 Feb 2021 05:14:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhBVEN4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 21 Feb 2021 23:13:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14180 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229974AbhBVENz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 21 Feb 2021 23:13:55 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11M4AEkW130456;
        Sun, 21 Feb 2021 23:13:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=kpb2TlLhOjclsLeoYqcSuqxpuRn9QHnDDMTb4RlAfUY=;
 b=Kb6MlIxpl2IJBbkrqcVQpqIo8BO2Qgy8W75dLm8Czlj2vrE+lhW17QX492eLhnY68pKb
 KHd7JYg8zqkxrKgiBdBSKmu0H/nak/BAmS9iyywyBKd/MISA1elGZ9Wbb2ah7dwKWIyT
 IEbd1u7K4UDK1SHTLJr9/aYVOFbXnh0gWkW503UsKrTi44zrRi68FLRRB0IZUxLJnklv
 KxWKBriSVtoeNW9rJ6BazTDS4EOT9DXsHhuqNyijZE9dLDgBlD4OlsY4l+naTbYl0iu8
 rcCC02TXBQ/O1wvhhwG7u9pOwqwjd768DKhRghSINikqQcOWt6SJdEeLdGV9lCUYvRtd lQ== 
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36v5770ad0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 21 Feb 2021 23:13:06 -0500
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 11M49jbW029391;
        Mon, 22 Feb 2021 04:11:57 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04ams.nl.ibm.com with ESMTP id 36tt2898ja-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 22 Feb 2021 04:11:57 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 11M4BsCN41353554
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Feb 2021 04:11:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B5DC311C050;
        Mon, 22 Feb 2021 04:11:54 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A956E11C04C;
        Mon, 22 Feb 2021 04:11:52 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.211.43.123])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 22 Feb 2021 04:11:52 +0000 (GMT)
Message-ID: <88affa2e0f4951f4b1b286df50d71a22a9ac1b54.camel@linux.ibm.com>
Subject: Re: [PATCH v2] IMA: support for duplicate data measurement
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Tushar Sugandhi <tusharsu@linux.microsoft.com>
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        nramas@linux.microsoft.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 21 Feb 2021 23:11:51 -0500
In-Reply-To: <6c2d2242-119c-2a8a-8062-6326fed6a45d@linux.microsoft.com>
References: <20210217024649.23405-1-tusharsu@linux.microsoft.com>
         <ab197aa9719b4218ab497b55f0bc78a0dadc83dd.camel@linux.ibm.com>
         <5236e03f-9be4-f7f3-ec6c-29f00c16dc18@linux.microsoft.com>
         <bb4356d779720b8fa9c342647132cfeec938c296.camel@linux.ibm.com>
         <21538a53-0174-e3b4-f1e8-ddb8cc334a79@linux.microsoft.com>
         <6c2d2242-119c-2a8a-8062-6326fed6a45d@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-21_14:2021-02-18,2021-02-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 impostorscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102220034
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2021-02-18 at 14:05 -0800, Tushar Sugandhi wrote:
> On 2021-02-17 12:49 p.m., Tushar Sugandhi wrote:
> > On 2021-02-17 12:39 p.m., Mimi Zohar wrote:
> >> On Wed, 2021-02-17 at 10:53 -0800, Tushar Sugandhi wrote:
> >>> Thanks for the feedback Mimi.
> >>> Appreciate it.
> >>>
> >>> On 2021-02-17 7:03 a.m., Mimi Zohar wrote:
> >>>> Hi Tushar,
> >>>>
> >>>> The Subject line could be improved.  Perhaps something like - "IMA:
> >>>> support for duplicate measurement records"
> >>>>
> >>> Will do.
> >>>
> >>>> On Tue, 2021-02-16 at 18:46 -0800, Tushar Sugandhi wrote:
> >>>>> IMA does not measure duplicate data since TPM extend is a very 
> >>>>> expensive
> >>>>> operation.  However, in some cases, the measurement of duplicate data
> >>>>> is necessary to accurately determine the current state of the system.
> >>>>> Eg, SELinux state changing from 'audit', to 'enforcing', and back to
> >>>>> 'audit' again.  In this example, currently, IMA will not measure the
> >>>>> last state change to 'audit'.  This limits the ability of attestation
> >>>>> services to accurately determine the current state of the measurements
> >>>>> on the system.
> >>>>
> >>>> This patch description is written from your specific usecase
> >>>> perspective, but it impacts file and buffer data measurements as well,
> >>>> not only critical data measurements.  In all of these situations, with
> >>>> this patch a new measurement record is added/appended to the
> >>>> measurement list.  Please re-write the patch description making it more
> >>>> generic.
> >>>>
> >>>> For example, I would start with something like, "IMA does not include
> >>>> duplicate file, buffer or critical data measurement records ..."
> >>>>
> >>> Agreed.
> >>> I will generalize the description further and send the v3 for review.
> >>
> >> It would be good to boot with the ima_policy=tcb policy with/without
> >> your patch and account for the different number of measurements.   Are
> >> all the differences related to duplicate measurements - original file
> >> hash -> new file hash -> original file hash - similar to what you
> >> described.
> >>
> > Thanks for the ima_policy=tcb pointer.
> > 
> > I tested my patch with:
> >   - duplicate buffer content for "measure func=CRITICAL_DATA"
> >   - and reading the same file twice with "measure func=FILE_CHECK 
> > mask=MAY_READ"
> > 
> > In both the above use cases, IMA is measuring the duplicate entries with 
> > the patch, and not measuring the duplicate entries w/o the patch.
> > 
> > I will test the "ima_policy=tcb" boot-scenario as you suggested, before 
> > posting the next version.
> > 
> 
> I booted the system with "ima_policy=tcb" policy with/without my patch.
> I also removed /etc/ima/ima-policy for testing these use-cases.
> (so that it wouldn't override the policy generated by boot param 
> "ima_policy=tcb").
> 
> I double checked the contents of the kernel policy:
> #cat /sys/kernel/security/integrity/ima/policy
>      dont_measure fsmagic=0x9fa0
>      dont_measure fsmagic=0x62656572
>      dont_measure fsmagic=0x64626720
>      dont_measure fsmagic=0x1021994
>      dont_measure fsmagic=0x1cd1
>      dont_measure fsmagic=0x42494e4d
>      dont_measure fsmagic=0x73636673
>      dont_measure fsmagic=0xf97cff8c
>      dont_measure fsmagic=0x43415d53
>      dont_measure fsmagic=0x27e0eb
>      dont_measure fsmagic=0x63677270
>      dont_measure fsmagic=0x6e736673
>      dont_measure fsmagic=0xde5e81e4
>      measure func=MMAP_CHECK mask=MAY_EXEC
>      measure func=BPRM_CHECK mask=MAY_EXEC
>      measure func=FILE_CHECK mask=^MAY_READ euid=0
>      measure func=FILE_CHECK mask=^MAY_READ uid=0
>      measure func=MODULE_CHECK
>      measure func=FIRMWARE_CHECK
>      measure func=POLICY_CHECK
> 
> And then I compared the contents of the ascii_runtime_measurements with 
> and without my patch.
> 
> And here are my findings:
> 
> (1) Files like systemd-udevd, x2go_sessions etc. get measured multiple
>      times with the CONFIG_IMA_DISABLE_HTABLE=y.
>      They only get measured once with the config "=n".
> 
>      10 668df8723f5a1f57a0afe3b50d44054d66363f3e ima-ng 
> sha1:51f66e82421b93b21ad1e0a25e5efa4155c6a8e0 /lib/systemd/systemd-udevd
>      10 668df8723f5a1f57a0afe3b50d44054d66363f3e ima-ng 
> sha1:51f66e82421b93b21ad1e0a25e5efa4155c6a8e0 /lib/systemd/systemd-udevd
> 
> (2) There are lot more instances of /tmp/<random> measurement records
>      with the CONFIG_IMA_DISABLE_HTABLE=y.
>      Eg,
> 
>      10 33515851cfee4acbf24de9482ff018d33def1083 ima-ng 
> sha1:da39a3ee5e6b4b0d3255bfef95601890afd80709 /tmp/oUWCVeypLR
>      10 9d1dc0e1e54ee2e16308a824fc5780bd21b38208 ima-ng 
> sha1:da39a3ee5e6b4b0d3255bfef95601890afd80709 /tmp/etX8dy7qqy
>      10 8643a5543179b86c02d7e3e01e16b3bd2f8dbb9f ima-ng 
> sha1:da39a3ee5e6b4b0d3255bfef95601890afd80709 /tmp/I4zTWEuyMf
>      10 56e9547a4ed39036d2e790cfad78b467aa979e32 ima-ng 
> sha1:da39a3ee5e6b4b0d3255bfef95601890afd80709 /tmp/Lh5wDm6_Ep
> 
> I believe both the observations are consistent with the expected outcome 
> of the patch.

These measurement records are not a result of the scenario described in
the patch description, but as the result of different inodes being
measured.   In the first case, the measurement is most likely coming
from the initramfs, while the second measurement is after pivot root.  
Without digging, I assume the second example is the file hash of an
empty file.

> 
> Please let me know if I should test any other scenario.
> 
> I will shortly post the v3 patch with updates to description and title 
> as you suggested.

The patch description is much better, but doesn't address the duplicate
measurements without the file changing in between.   Please really
compare the before and after measurement record changes, making sure
you understand the cause for all the duplicate measurement records.  
Based on the results, please update the patch description
appropriately.

thanks,

Mimi

