Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A17615F85B
	for <lists+linux-integrity@lfdr.de>; Thu,  4 Jul 2019 14:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbfGDMmY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 4 Jul 2019 08:42:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727114AbfGDMmX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 4 Jul 2019 08:42:23 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x64CdxmM025479
        for <linux-integrity@vger.kernel.org>; Thu, 4 Jul 2019 08:42:22 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2thh0shhqf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 04 Jul 2019 08:42:22 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 4 Jul 2019 13:42:20 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 4 Jul 2019 13:42:18 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x64CgGqC20316404
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Jul 2019 12:42:16 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 99590A405C;
        Thu,  4 Jul 2019 12:42:16 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A61F6A405B;
        Thu,  4 Jul 2019 12:42:15 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.110.72])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Jul 2019 12:42:15 +0000 (GMT)
Subject: Re: Problem with the kernels trusted module on "inactive" TPM
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Roberto Sassu <roberto.sassu@huawei.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        CrazyT <crazyt2019+lml@gmail.com>, keyrings@vger.kernel.org
Cc:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        jejb@linux.ibm.com, Nayna Jain <nayna@linux.ibm.com>
Date:   Thu, 04 Jul 2019 08:42:05 -0400
In-Reply-To: <cb46e05d-f9bd-2d58-0996-390cfbf6f786@huawei.com>
References: <CACnrVGfhkpsSWbCai4+5WEOhRukEr7JWDUnFdM-5D+FUyov+nQ@mail.gmail.com>
         <f4b36912-0fb0-1e83-1ad2-fb1d2313c08e@huawei.com>
         <4e3579a4d84aa7e2c80e5068eb1f7a30e17a655b.camel@linux.intel.com>
         <cb46e05d-f9bd-2d58-0996-390cfbf6f786@huawei.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19070412-0012-0000-0000-0000032F3D86
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070412-0013-0000-0000-00002168943B
Message-Id: <1562244125.6165.95.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-04_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907040159
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing Nayna]

On Thu, 2019-07-04 at 14:25 +0200, Roberto Sassu wrote:
> On 7/4/2019 12:42 PM, Jarkko Sakkinen wrote:
> > On Mon, 2019-07-01 at 17:22 +0300, Roberto Sassu wrote:
> >> Adding to the discussion Jarkko (the maintainer of the trusted key) and
> >> the linux-integrity mailing list.
> > 
> > I'm a co-maintainer (added James and Mimi).
> > 
> >>> some people (including me) have problems with the "trusted" kernel module.
> >>> As a result to this also the ecryptfs-module won't load.
> >>> (https://bugs.archlinux.org/task/62678)
> >>> If you use an "inactive" TPM module, the "trusted" module won't load
> >>> anymore.
> >>> The command modprobe just responds with "Bad address".
> >>> The strace-command shows that init_module fails with EFAULT.
> >>> I believe the reason for this is that the trusted-module handles
> >>> inactive modules the same as active modules.
> >>> This results in an error.
> >>>
> >>> For example:
> >>>
> > https://github.com/torvalds/linux/commit/0b6cf6b97b7ef1fa3c7fefab0cac897a1c4a3400#diff-c01228e6d386afb29df6aac17d9dd7abR1251
> >>>
> >>> My guess is that init_digests(); returns EFAULT in that case.
> >>> The " if (!chip)" check above probably needs to check if the chip is
> >>> "inactive".
> >>>
> >>> "inactive" = still visible to the system, but not functional.
> >>> It seems to be the default bios-setting for TPM on thinkpad.
> >>> (btw.: i have no clue why anybody would need something like that)
> >>>
> >>> Sadly i have no idea how you would check for an inactive chip,else i
> >>> would have send a patch instead.
> >>> But I hope the info i wrote is enough to get it fixed by somebody.
> >>
> >> Thanks for the report. If you see -EFAULT, tpm_get_random() is probably
> >> returning 0.
> >>
> >> Jarkko, we could consider it as non-critical error, and handle it as if
> >> the TPM is not found. What do you think?
> > 
> > Not sure I get this. Wasn't the issue fixed in c78719203fc6 or is there
> > something missing?
> 
> It seems it is not enough. A TPM is found but does not return data to
> tpm_get_random(), I think.

While working with Nayna (and George) on the "tpm: fixes uninitialized
allocated banks for IBM vtpm driver" patch, I wondered what happens if
the chip is enabled, but none of the banks were enabled.  Could this
be the "inactive" state?

Mimi

