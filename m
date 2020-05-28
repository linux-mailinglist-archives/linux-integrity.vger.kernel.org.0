Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F09BF1E65D8
	for <lists+linux-integrity@lfdr.de>; Thu, 28 May 2020 17:19:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404219AbgE1PTv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 28 May 2020 11:19:51 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52226 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404360AbgE1PTu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 28 May 2020 11:19:50 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04SF4o6u149583;
        Thu, 28 May 2020 11:19:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=AkYoOoW4vlrLjWZxKHRE2hM3biIzIjSPx7848KWJ9ZQ=;
 b=RBGNSEsMFXjdygx6mEiSvzMw0Sr0EgtVnhUMb546VroLfYEj9KZOKciuJ8FVuqGLoF58
 3hBEMHZMMDIsCFXk5VLBc6il1E8VV/nSwE2MaFoaRAn6V9qDU57eJZWeMcLtNdJC3J7G
 drN3f42ufkScQD6WFzTDVq5TFhCTLwQxqOQEf4NCfmc/mwExKGM2MMaPAJjczITfToQv
 /XEUnjED745BNltPt1KpjcEF4+4i+rXutBAbU1jIaIdAh1mNvFNKUYjdJ5ZHZnAg6nWD
 EQA7wXJQPPMQtZnhCp/p8BXeEnroSki/6TgnsUUWLTAnza8Lhn9lmBpNtP19eSabqtpw EQ== 
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 319s3cstv9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 May 2020 11:19:10 -0400
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04SFFWUr015949;
        Thu, 28 May 2020 15:19:09 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03ams.nl.ibm.com with ESMTP id 316uf8a5cg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 May 2020 15:19:08 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04SFJ6qS51970196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 May 2020 15:19:06 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BBEF1AE045;
        Thu, 28 May 2020 15:19:06 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA8DCAE04D;
        Thu, 28 May 2020 15:19:05 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.227.237])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 28 May 2020 15:19:05 +0000 (GMT)
Message-ID: <1590679145.4457.39.camel@linux.ibm.com>
Subject: Re: [LTP v2 1/1] ima_tpm.sh: Fix for calculating boot aggregate
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>
Cc:     ltp@lists.linux.it, Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Petr Cervinka <pcervinka@suse.com>,
        Cyril Hrubis <chrubis@suse.cz>,
        linux-integrity@vger.kernel.org, Vitaly Chikunov <vt@altlinux.org>
Date:   Thu, 28 May 2020 11:19:05 -0400
In-Reply-To: <20200528140747.GA8401@dell5510>
References: <20200527071434.28574-1-pvorel@suse.cz>
         <1590601280.16219.1.camel@linux.ibm.com> <20200528140747.GA8401@dell5510>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-28_03:2020-05-28,2020-05-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0
 bulkscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 priorityscore=1501
 cotscore=-2147483648 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005280101
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2020-05-28 at 16:07 +0200, Petr Vorel wrote:
> Hi Mimi,
> 
> thanks a lot for testing!
> 
> > On Wed, 2020-05-27 at 09:14 +0200, Petr Vorel wrote:
> > > Fixes test for kernel commit: 6f1a1d103b48 ima: ("Switch to
> > > ima_hash_algo for boot aggregate") from current linux-integrity tree.
> 
> > > Tests was failing, because it expect SHA1 hash, but for TPM 2.0 is
> > > now used IMA default hash algorithm (by default default SHA256).
> > > This is similar for entries in IMA measurement list so we can reuse
> > > already existing code.
> 
> > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > ---
> > > changes v1->v2:
> > > * removing global variables from get_algorithm_digest (hopefully it's
> > > less ugly)
> 
> > > Tested only on VM. Can anybody test it on real HW?
> 
> > With just this change, the ima_tpm.sh test is failing.  I assume it is
> > failing because it is reading the SHA1 TPM bank, not the SHA256 bank
> > to calculate the boot_aggregate hash.
> First question: is it correct to take sha256? Because on my test below it's
> reading sha1, because that's the content of /sys/kernel/security/ima/ascii_runtime_measurements
> 
> I thought just kernel commit: 6f1a1d103b48 ima: ("Switch to ima_hash_algo for
> boot aggregate") from current linux-integrity tree is needed, but I tested it on
> b59fda449cf0 ("ima: Set again build_ima_appraise variable") (i.e. having all
> Robeto's ima patches,  missing just last 2 commits from next-integrity head).
> What is needed to get your setup?

This isn't a configuration problem, but an issue of reading PCRs and
calculating the TPM bank appropriate boot_aggregate.  If you're
calculating a sha256 boot_aggregate, then the test needs to read and
calculate the boot_aggregate by reading the SHA256 TPM bank.

> We both have CONFIG_IMA_DEFAULT_HASH_SHA256=y and CONFIG_IMA_DEFAULT_HASH="sha256".
> 
> > ima_tpm 1 TINFO: timeout per run is 0h 5m 0s
> > ima_tpm 1 TINFO: IMA kernel config:
> > ima_tpm 1 TINFO: CONFIG_IMA=y
> > ima_tpm 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=10
> > ima_tpm 1 TINFO: CONFIG_IMA_LSM_RULES=y
> > ima_tpm 1 TINFO: CONFIG_IMA_NG_TEMPLATE=y
> > ima_tpm 1 TINFO: CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
> > ima_tpm 1 TINFO: CONFIG_IMA_DEFAULT_HASH_SHA256=y
> > ima_tpm 1 TINFO: CONFIG_IMA_DEFAULT_HASH="sha256"
> > ima_tpm 1 TINFO: CONFIG_IMA_WRITE_POLICY=y
> > ima_tpm 1 TINFO: CONFIG_IMA_READ_POLICY=y
> > ima_tpm 1 TINFO: CONFIG_IMA_APPRAISE=y
> > ima_tpm 1 TINFO: CONFIG_IMA_ARCH_POLICY=y
> > ima_tpm 1 TINFO: CONFIG_IMA_TRUSTED_KEYRING=y
> > ima_tpm 1 TINFO: CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
> > ima_tpm 1 TINFO: CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
> > ima_tpm 1 TINFO: CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
> > ima_tpm 1 TINFO: /proc/cmdline: BOOT_IMAGE=/boot/vmlinuz-5.6.0-rc3+.signed root=UUID=119f1a79-c391-4e37-905d-3a503284cadb ro quiet splash ima-policy=tcb
> > ima_tpm 1 TINFO: verify boot aggregate
> > ima_tpm 1 TINFO: used algorithm: sha256
> > ima_tpm 1 TINFO: IMA boot aggregate: 'b2341e4ccea25be7fa750830fb5fdf4bef1c44a4'
> > ima_tpm 1 TFAIL: bios boot aggregate does not match IMA boot aggregate (3fd5dc717f886ff7182526efc5edc3abb179a5aac1ab589c8ec888398233ae5b)
> > ima_tpm 2 TINFO: verify PCR values
> > ima_tpm 2 TINFO: evmctl version: evmctl 1.2
> > ima_tpm 2 TCONF: TPM Hardware Support not enabled in kernel or no TPM chip found
> > ima_tpm 3 TINFO: AppArmor enabled, this may affect test results
> > ima_tpm 3 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root)
> > ima_tpm 3 TINFO: loaded AppArmor profiles: none
> 
> > Summary:
> > passed   0
> > failed   1
> > skipped  1
> > warnings 0
> 
> 
> BTW my results on custom kernel:
> ima_tpm 1 TINFO: timeout per run is 0h 5m 0s
> ima_tpm 1 TINFO: IMA kernel config:
> ima_tpm 1 TINFO: CONFIG_IMA=y
> ima_tpm 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=10
> ima_tpm 1 TINFO: CONFIG_IMA_LSM_RULES=y
> ima_tpm 1 TINFO: CONFIG_IMA_NG_TEMPLATE=y
> ima_tpm 1 TINFO: CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
> ima_tpm 1 TINFO: CONFIG_IMA_DEFAULT_HASH_SHA256=y
> ima_tpm 1 TINFO: CONFIG_IMA_DEFAULT_HASH="sha256"
> ima_tpm 1 TINFO: CONFIG_IMA_APPRAISE=y
> ima_tpm 1 TINFO: CONFIG_IMA_APPRAISE_BOOTPARAM=y
> ima_tpm 1 TINFO: CONFIG_IMA_APPRAISE_MODSIG=y
> ima_tpm 1 TINFO: CONFIG_IMA_TRUSTED_KEYRING=y
> ima_tpm 1 TINFO: CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY=y
> ima_tpm 1 TINFO: /proc/cmdline: BOOT_IMAGE=/boot/vmlinuz-5.3.18-20-default root=/dev/mapper/system-root crashkernel=121M,high crashkernel=72M,low isofrom=/dev/disk/by-uuid/3271-1AD6:/openSUSE-Tumbleweed-NET-x86_64-Snapshot20161222-Media.iso isofrom_device=/dev/disk/by-uuid/3271-1AD6 isofrom_system=/openSUSE-Tumbleweed-NET-x86_64-Snapshot20161222-Media.iso loader=syslinux quiet resume=/dev/system/swap splash=silent quiet showopts
> ima_tpm 1 TINFO: IMA kernel config:
> ima_tpm 1 TINFO: CONFIG_IMA=y
> ima_tpm 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=10
> ima_tpm 1 TINFO: CONFIG_IMA_LSM_RULES=y
> ima_tpm 1 TINFO: CONFIG_IMA_NG_TEMPLATE=y
> ima_tpm 1 TINFO: CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
> ima_tpm 1 TINFO: CONFIG_IMA_DEFAULT_HASH_SHA256=y
> ima_tpm 1 TINFO: CONFIG_IMA_DEFAULT_HASH="sha256"
> ima_tpm 1 TINFO: CONFIG_IMA_APPRAISE=y
> ima_tpm 1 TINFO: CONFIG_IMA_APPRAISE_BOOTPARAM=y
> ima_tpm 1 TINFO: CONFIG_IMA_APPRAISE_MODSIG=y
> ima_tpm 1 TINFO: CONFIG_IMA_TRUSTED_KEYRING=y
> ima_tpm 1 TINFO: CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY=y
> ima_tpm 1 TINFO: /proc/cmdline: BOOT_IMAGE=/boot/vmlinuz-5.3.18-20-default root=/dev/mapper/system-root crashkernel=121M,high crashkernel=72M,low isofrom=/dev/disk/by-uuid/3271-1AD6:/openSUSE-Tumbleweed-NET-x86_64-Snapshot20161222-Media.iso isofrom_device=/dev/disk/by-uuid/3271-1AD6 isofrom_system=/openSUSE-Tumbleweed-NET-x86_64-Snapshot20161222-Media.iso loader=syslinux quiet resume=/dev/system/swap splash=silent quiet showopts
> ima_tpm 1 TINFO: verify boot aggregate
> ima_tpm 1 TINFO: used algorithm: sha1
> ima_tpm 1 TINFO: IMA boot aggregate: '1172f0990296510ed39403b4f1de83c82e093aae'
> ima_tpm 1 TPASS: bios boot aggregate matches IMA boot aggregate (1172f0990296510ed39403b4f1de83c82e093aae)
> ima_tpm 2 TINFO: verify PCR values
> ima_tpm 2 TINFO: evmctl version: evmctl 1.2.1
> ima_tpm 2 TINFO: new PCRS path, evmctl >= 1.1 required
> ima_tpm 2 TINFO: verify PCR (Process Control Register)
> ima_tpm 2 TPASS: aggregate PCR value matches real PCR value
> 
> Summary:
> passed   2
> failed   0
> skipped  0
> warnings 0
> 
> 
> > # head -1 /sys/kernel/security/ima/ascii_runtime_measurements
> 
> > 10 a3132d2501128ff527171658d40d8deb61e2292b ima-ng
> > sha256:3fd5dc717f886ff7182526efc5edc3abb179a5aac1ab589c8ec888398233ae5
> > b boot_aggregate
> 
> mine:
> 10 c125a1d3684a9737f20f6c1bc880782fae60fb28 ima-ng sha1:1172f0990296510ed39403b4f1de83c82e093aae boot_aggregate
> 
> > The ima-evm-utils next-testing branch has code to calculate the
> > boot_aggregate based on multiple banks.
> I see, 696bf0b ("ima-evm-utils: calculate the digests for multiple TPM banks")
> I wonder whether it's reasonable trying to port that to ima_boot_aggregate.c or
> just depend on evmctl. External dependencies are sometimes complicated, but for
> IMA I incline to just require evmctl.

Unlike TPM 1.2, the TPM 2.0 device driver doesn't export the TPM PCRs.
 Not only would you have a dependency on ima-evm-utils, but also on a
userspace application(s) for reading the TPM PCRs.  That dependency
exists whether you're using evmctl to calculate the boot_aggregate or
doing it yourself.

> 
> > # evmctl ima_boot_aggregate
> 
> > sha1:4cf3d105b1a1a41b951cc6431f0801c01fe50b24
> > sha256:3fd5dc717f886ff7182526efc5edc3abb179a5aac1ab589c8ec888398233ae5b
> 
> Thus obviously evmctl (from next-testing) also gets only sha1
> ./src/evmctl ima_boot_aggregate
> sha1:1172f0990296510ed39403b4f1de83c82e093aae
> 
> > There's also a new test to verify the boot_aggregate.
> 
> > $ VERBOSE=1 make check TESTS=boog_aggregate.test
> BTW I got some errors
> ...
> make  check-TESTS
> make[2]: Entering directory '/home/foo/ima-evm-utils/tests'
> make[3]: Entering directory '/home/foo/ima-evm-utils/tests'
> make[4]: Entering directory '/home/foo/ima-evm-utils/tests'
> make[4]: Nothing to be done for 'boog_aggregate.log'.
> make[4]: Leaving directory '/home/foo/ima-evm-utils/tests'
> fatal: making test-suite.log: failed to create boog_aggregate.trs
> fatal: making test-suite.log: failed to create boog_aggregate.log
> make[3]: *** [Makefile:516: test-suite.log] Error 1
> make[3]: Leaving directory '/home/foo/ima-evm-utils/tests'
> make[2]: *** [Makefile:625: check-TESTS] Error 2
> make[2]: Leaving directory '/home/foo/ima-evm-utils/tests'
> make[1]: *** [Makefile:692: check-am] Error 2
> make[1]: Leaving directory '/home/foo/ima-evm-utils/tests'
> make: *** [Makefile:514: check-recursive] Error 1

[Cc'ing Vitaly]

The boot_aggregate.trs and boot_aggregate.log files are being created
in the tests/ directory.  Is that directory read-only?
 
> 
> > Both need some review and testing before being released.
> Any estimation when code is released?

Probably not before the next open window, but definitely before it is
released.

Mimi
