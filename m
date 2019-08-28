Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1ACDA058A
	for <lists+linux-integrity@lfdr.de>; Wed, 28 Aug 2019 17:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726475AbfH1PDJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 28 Aug 2019 11:03:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:26526 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726394AbfH1PDJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 28 Aug 2019 11:03:09 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7SExSiI155939
        for <linux-integrity@vger.kernel.org>; Wed, 28 Aug 2019 11:03:07 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2untjuc21y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 28 Aug 2019 11:03:06 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 28 Aug 2019 16:03:05 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 28 Aug 2019 16:03:03 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x7SF32Nk51380474
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Aug 2019 15:03:02 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5DD51A4060;
        Wed, 28 Aug 2019 15:03:02 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E23DA4064;
        Wed, 28 Aug 2019 15:03:01 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.129.156])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 28 Aug 2019 15:03:01 +0000 (GMT)
Subject: Re: TPM 2.0 Linux sysfs interface
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Piotr =?ISO-8859-1?Q?Kr=F3l?= <piotr.krol@3mdeb.com>,
        linux-integrity@vger.kernel.org
Cc:     Petr Vorel <pvorel@suse.cz>, Ken Goldman <kgold@linux.ibm.com>
Date:   Wed, 28 Aug 2019 11:03:01 -0400
In-Reply-To: <3329329f-4bf4-b8cd-dee8-eb36e513c728@3mdeb.com>
References: <3329329f-4bf4-b8cd-dee8-eb36e513c728@3mdeb.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19082815-0016-0000-0000-000002A3EE8C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19082815-0017-0000-0000-000033043FD2
Message-Id: <1567004581.6115.33.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-28_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908280156
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc'ing Petr Vorel]

Hi Piotr,

On Tue, 2019-08-27 at 01:24 +0200, Piotr Król wrote:
> Hi all,
> I'm moving here discussion that I started with Jarkko and Peter on LinkedIn.
> 
> I'm preparing for 2 talks during LPC 2019 System Boot MC and one of it
> will discuss TPM 2.0 sysfs support [1]. This was discussed couple times
> [2] and explained why it is not done yet by Jarkko [3].
> 
> Why is this important?
> - there seem to be no default method to distinguish if we dealing with
> TPM 1.2 or 2.0 in the system. 

Agreed, this affects both the LTP IMA tests and ima-evm-utils package,
which need to support both TPM 1.2 and 2.0 for the forseeable future.
The LTP IMA tests check different sysfs files to determine if it is
TPM 1.2 or TPM 2.0 (eg. /sys/class/tpm/tpm0/device/description,
/sys/class/tpm/tpm0/device/pcrs and /sys/class/misc/tpm0/device/pcrs),
but the "description" file is not defined by all TPM 2.0's.  It
shouldn't be that difficult to define a single common sysfs file.

> - distros use various tools to detect TPM based on sysfs (e.g. Qubes OS
> scripts)
> - tpm2-software has ton of dependencies, is not easy to build,
> development is way faster then distros can manage and packages are often
> out of date or even broken, so using it can be troublesome
> - for deeply embedded systems adding fully-featured tpm2-software
> doesn't make sense e.g. if we just need PCRs values
> 
> Jarkko comment on detecting 1.2 vs 2.0:
> "Detecting TPM 2.0 is dead easy: send any idempotent TPM 2.0 command and
> check if the tag field matches 0x8002 (TPM_NO_SESSIONS). The sysfs
> features for TPM 1.2 are for the large part useless as you can get the
> same data by using TPM commands."
> 
> Ok, but doesn't this mean I need TPM2 software stack?
> Peter mentioned that it can be tricky to invoke such tools early in boot
> process.

ima-evm-utils now uses the TPM 2.0 TSS[1] to read the PCRs.  I haven't
tried using it during boot, but I don't forsee a problem. I guess it
depends on how early you need to read the PCRs.

Mimi

[1] https://git.code.sf.net/p/ibmtpm20tss/tss

> 
> Finally, I do not feel expert in the field of Linux integrity and don't
> want to argue for sysfs if it doesn't make sense for TPM 2.0, but if
> that's the situation I would like to know what are the best practices to
> solve above issues. If you think there is something important to be
> discussed in above context please let me know.
> 
> [1] https://linuxplumbersconf.org/event/4/contributions/516/
> [2]
> https://patchwork.kernel.org/project/linux-integrity/list/?series=&submitter=&state=*&q=sysfs&archive=&delegate=
> [3] https://lwn.net/Articles/624241/
> 
> Best Regards,

