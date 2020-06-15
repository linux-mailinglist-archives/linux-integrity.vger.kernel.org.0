Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 267381FA15D
	for <lists+linux-integrity@lfdr.de>; Mon, 15 Jun 2020 22:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731254AbgFOUVv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 15 Jun 2020 16:21:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:65106 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731467AbgFOUVu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 15 Jun 2020 16:21:50 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05FK3avK129600;
        Mon, 15 Jun 2020 16:21:38 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31pc7mxx7b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Jun 2020 16:21:38 -0400
Received: from m0098396.ppops.net (m0098396.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 05FK4IeV133316;
        Mon, 15 Jun 2020 16:21:38 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 31pc7mxx6p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Jun 2020 16:21:37 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 05FKL4oH030697;
        Mon, 15 Jun 2020 20:21:35 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 31mpe7spaq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 15 Jun 2020 20:21:35 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 05FKLXRK65470676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 15 Jun 2020 20:21:33 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6B37E11C050;
        Mon, 15 Jun 2020 20:21:33 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5911D11C052;
        Mon, 15 Jun 2020 20:21:32 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.184.11])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 15 Jun 2020 20:21:32 +0000 (GMT)
Message-ID: <1592252491.11061.181.camel@linux.ibm.com>
Subject: Re: [LTP v2 1/1] ima_tpm.sh: Fix for calculating boot aggregate
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Bruno Meneguele <bmeneg@redhat.com>, Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Petr Cervinka <pcervinka@suse.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>,
        Maurizio Drocco <maurizio.drocco@ibm.com>
Date:   Mon, 15 Jun 2020 16:21:31 -0400
In-Reply-To: <20200615194134.GF129694@glitch>
References: <20200527071434.28574-1-pvorel@suse.cz>
         <1590601280.16219.1.camel@linux.ibm.com> <20200528140747.GA8401@dell5510>
         <1590679145.4457.39.camel@linux.ibm.com> <20200528160527.GA27243@dell5510>
         <20200615194134.GF129694@glitch>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-15_03:2020-06-15,2020-06-15 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=999 clxscore=1015 impostorscore=0 malwarescore=0
 cotscore=-2147483648 priorityscore=1501 lowpriorityscore=0 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006150111
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-06-15 at 16:41 -0300, Bruno Meneguele wrote:
> On Thu, May 28, 2020 at 06:05:27PM +0200, Petr Vorel wrote:
> > Hi Mimi,
> > ...
> > > > > With just this change, the ima_tpm.sh test is failing.  I assume it is
> > > > > failing because it is reading the SHA1 TPM bank, not the SHA256 bank
> > > > > to calculate the boot_aggregate hash.
> > > > First question: is it correct to take sha256? Because on my test below it's
> > > > reading sha1, because that's the content of /sys/kernel/security/ima/ascii_runtime_measurements
> > 
> > > > I thought just kernel commit: 6f1a1d103b48 ima: ("Switch to ima_hash_algo for
> > > > boot aggregate") from current linux-integrity tree is needed, but I tested it on
> > > > b59fda449cf0 ("ima: Set again build_ima_appraise variable") (i.e. having all
> > > > Robeto's ima patches,  missing just last 2 commits from next-integrity head).
> > > > What is needed to get your setup?
> > 
> > > This isn't a configuration problem, but an issue of reading PCRs and
> > > calculating the TPM bank appropriate boot_aggregate.  If you're
> > > calculating a sha256 boot_aggregate, then the test needs to read and
> > > calculate the boot_aggregate by reading the SHA256 TPM bank.
> > OK, I tested it on TPM 1.2 (no TPM 2.0 available atm).
> > I guess you have TPM 2.0, that's why I didn't spot this issue.
> > 
> > To sum that: my patch is required for any system without physical TPM with with
> > kernel with b59fda449cf0 + it also works for TPM 1.2 (regardless kernel
> > version), because TPM 1.2 supports sha1 only boot aggregate.
> > 
> > But testing on kernel with b59fda449cf0 with TPM 2.0 is not only broken with
> > this patch, but also on current version in master, right? As you have
> > sha256:3fd5dc717f886ff7182526efc5edc3abb179a5aac1ab589c8ec888398233ae5 anyway.
> > So this patch would help at least testing on VM without vTPM.
> > 
> 
> If we consider to delay this change until we have the ima-evm-utils
> released with the ima_boot_aggregate + make this test dependent on
> both ima-evm-utils and tsspcrread, would it be worth to SKIP the test in
> case a TPM2.0 sha256 bank is detected instead of FAIL? Thus we could
> have the test fixed for TPM1.2 && no-TPM cases until we get the full
> support for multiple banks?

As long as we're dealing with the "boot_aggregate", Maurizio just
posted a kernel patch for including PCR 8 & 9 in the boot_aggregate.
 The existing IMA LTP "boot_aggregate" test is going to need to
support this change.

I'd appreciate if someone could send me a TPM event log, the PCRs, and
the associated IMA ascii_runtime_measurements "boot_aggregate" from a
system with a discrete TPM 2.0 with PCRs 8 & 9 events.

> 
> > ...
> > > > > The ima-evm-utils next-testing branch has code to calculate the
> > > > > boot_aggregate based on multiple banks.
> > > > I see, 696bf0b ("ima-evm-utils: calculate the digests for multiple TPM banks")
> > > > I wonder whether it's reasonable trying to port that to ima_boot_aggregate.c or
> > > > just depend on evmctl. External dependencies are sometimes complicated, but for
> > > > IMA I incline to just require evmctl.
> > 
> > > Unlike TPM 1.2, the TPM 2.0 device driver doesn't export the TPM PCRs.
> > >  Not only would you have a dependency on ima-evm-utils, but also on a
> > > userspace application(s) for reading the TPM PCRs.  That dependency
> > > exists whether you're using evmctl to calculate the boot_aggregate or
> > > doing it yourself.
> > Hm, things get complicated.
> > Yep I remember your patch to skip verifying TPM 2.0 PCR values
> > https://patchwork.ozlabs.org/project/ltp/patch/1558041162.3971.2.camel@linux.ibm.com/
> > At least thanks to Jerry Snitselaar since v5.6 we have
> > /sys/class/tpm/tpm*/tpm_version_major. We could check this (+ try also
> > /sys/class/tpm/tpm0/device/description for older kernels).
> > 
> > BTW on my system there is also /sys/class/tpm/tpm0/ppi/version, which has 1.2,
> > not sure if it indicate TPM 1.2, but I wouldn't rely on that.
> > 
> 
> IIUC 'tpm_version_major' should be the only safe reference of the actual
> TCG spec version being implemented by the hw TPM, in a sysfs standard
> output.

That was only upstreamed in linux-v5.6.  Has it been backported?

The PCRs are not exported for TPM 2.0, unfortunately, making
regression tests dependent on a userspace app.  The existing LTP
ima_tpm.sh test looks for the PCRs in either
/sys/class/tpm/tpm0/device/pcrs or /sys/class/misc/tpm0/device/pcrs.
 Perhaps piggyback on the pseudo PCR file to test for TPM 1.2.

> 
> > ...
> > > > > There's also a new test to verify the boot_aggregate.
> > 
> > > > > $ VERBOSE=1 make check TESTS=boog_aggregate.test
> > > > BTW I got some errors
> > > > ...
> > > > make  check-TESTS
> > > > make[2]: Entering directory '/home/foo/ima-evm-utils/tests'
> > > > make[3]: Entering directory '/home/foo/ima-evm-utils/tests'
> > > > make[4]: Entering directory '/home/foo/ima-evm-utils/tests'
> > > > make[4]: Nothing to be done for 'boog_aggregate.log'.
> > > > make[4]: Leaving directory '/home/foo/ima-evm-utils/tests'
> > > > fatal: making test-suite.log: failed to create boog_aggregate.trs
> > > > fatal: making test-suite.log: failed to create boog_aggregate.log
> > > > make[3]: *** [Makefile:516: test-suite.log] Error 1
> > > > make[3]: Leaving directory '/home/foo/ima-evm-utils/tests'
> > > > make[2]: *** [Makefile:625: check-TESTS] Error 2
> > > > make[2]: Leaving directory '/home/foo/ima-evm-utils/tests'
> > > > make[1]: *** [Makefile:692: check-am] Error 2
> > > > make[1]: Leaving directory '/home/foo/ima-evm-utils/tests'
> > > > make: *** [Makefile:514: check-recursive] Error 1
> > 
> > > [Cc'ing Vitaly]
> > 
> > > The boot_aggregate.trs and boot_aggregate.log files are being created
> > > in the tests/ directory.  Is that directory read-only?
> > Yes, drwxr-xr-x. Testing on fresh clone and issue persists.
> > 
> 
> Yes, same thing here.. but didn't really check the reason for that. Will
> take a time later to see what's happening.

Thanks, much appreciated.  I'm not seeing that here.

Mimi
