Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC1731E4C2C
	for <lists+linux-integrity@lfdr.de>; Wed, 27 May 2020 19:41:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388311AbgE0Rli (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 27 May 2020 13:41:38 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2387564AbgE0Rlh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 27 May 2020 13:41:37 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04RHVtfX109827;
        Wed, 27 May 2020 13:41:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=fWXCF03RRSSnsjJCyoWRsfQVSY3s9+re/ycDQN0vrck=;
 b=QFW6e1AmZCoQ/jMR4e7ClRVQTUv9qfs2qtVkE6/z8tbO+QsiIh5E1vWDe/iF4B6R3jkh
 HrCAWOF24+lI7hKhU1waJy9lwAKRh+NSXw48TqhYpOSw2ZQ4ijYIYtQfIXHs4wMgwbCN
 hKZezIxs9jsNBMPU1SySs1tb5PsGW2pqLN26VbKYW8Et9PV7+M7xuc2Nnuh7JDhxghN3
 mZsrsQEvNtlayK+QQdOXF4PeRDuba+5M1FymQ82kNG18lP+2GVSaec/k3nU8eqcWPftT
 CLId0lQTq54S0WpK+AQ0sabx5elOIgeSThDjL/WtPpWKUh8LbKF3P7eO5mRBDRqcpGu1 5A== 
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 319svy6a18-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 13:41:26 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 04RHZxRu005485;
        Wed, 27 May 2020 17:41:24 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 316uf8bc4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 27 May 2020 17:41:24 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04RHfMgv61800732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 27 May 2020 17:41:22 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E76E1A405C;
        Wed, 27 May 2020 17:41:21 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2D597A405B;
        Wed, 27 May 2020 17:41:21 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.130.2])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 27 May 2020 17:41:21 +0000 (GMT)
Message-ID: <1590601280.16219.1.camel@linux.ibm.com>
Subject: Re: [LTP v2 1/1] ima_tpm.sh: Fix for calculating boot aggregate
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Petr Cervinka <pcervinka@suse.com>,
        Cyril Hrubis <chrubis@suse.cz>, linux-integrity@vger.kernel.org
Date:   Wed, 27 May 2020 13:41:20 -0400
In-Reply-To: <20200527071434.28574-1-pvorel@suse.cz>
References: <20200527071434.28574-1-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-05-27_03:2020-05-27,2020-05-27 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 impostorscore=0 bulkscore=0 suspectscore=0 cotscore=-2147483648
 clxscore=1011 mlxscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2004280000 definitions=main-2005270133
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Petr,

On Wed, 2020-05-27 at 09:14 +0200, Petr Vorel wrote:
> Fixes test for kernel commit: 6f1a1d103b48 ima: ("Switch to
> ima_hash_algo for boot aggregate") from current linux-integrity tree.
> 
> Tests was failing, because it expect SHA1 hash, but for TPM 2.0 is
> now used IMA default hash algorithm (by default default SHA256).
> This is similar for entries in IMA measurement list so we can reuse
> already existing code.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> changes v1->v2:
> * removing global variables from get_algorithm_digest (hopefully it's
> less ugly)
> 
> Tested only on VM. Can anybody test it on real HW?

With just this change, the ima_tpm.sh test is failing.  I assume it is
failing because it is reading the SHA1 TPM bank, not the SHA256 bank
to calculate the boot_aggregate hash.

ima_tpm 1 TINFO: timeout per run is 0h 5m 0s
ima_tpm 1 TINFO: IMA kernel config:
ima_tpm 1 TINFO: CONFIG_IMA=y
ima_tpm 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=10
ima_tpm 1 TINFO: CONFIG_IMA_LSM_RULES=y
ima_tpm 1 TINFO: CONFIG_IMA_NG_TEMPLATE=y
ima_tpm 1 TINFO: CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
ima_tpm 1 TINFO: CONFIG_IMA_DEFAULT_HASH_SHA256=y
ima_tpm 1 TINFO: CONFIG_IMA_DEFAULT_HASH="sha256"
ima_tpm 1 TINFO: CONFIG_IMA_WRITE_POLICY=y
ima_tpm 1 TINFO: CONFIG_IMA_READ_POLICY=y
ima_tpm 1 TINFO: CONFIG_IMA_APPRAISE=y
ima_tpm 1 TINFO: CONFIG_IMA_ARCH_POLICY=y
ima_tpm 1 TINFO: CONFIG_IMA_TRUSTED_KEYRING=y
ima_tpm 1 TINFO: CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
ima_tpm 1 TINFO: CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=y
ima_tpm 1 TINFO: CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT=y
ima_tpm 1 TINFO: /proc/cmdline: BOOT_IMAGE=/boot/vmlinuz-5.6.0-rc3+.signed root=UUID=119f1a79-c391-4e37-905d-3a503284cadb ro quiet splash ima-policy=tcb
ima_tpm 1 TINFO: verify boot aggregate
ima_tpm 1 TINFO: used algorithm: sha256
ima_tpm 1 TINFO: IMA boot aggregate: 'b2341e4ccea25be7fa750830fb5fdf4bef1c44a4'
ima_tpm 1 TFAIL: bios boot aggregate does not match IMA boot aggregate (3fd5dc717f886ff7182526efc5edc3abb179a5aac1ab589c8ec888398233ae5b)
ima_tpm 2 TINFO: verify PCR values
ima_tpm 2 TINFO: evmctl version: evmctl 1.2
ima_tpm 2 TCONF: TPM Hardware Support not enabled in kernel or no TPM chip found
ima_tpm 3 TINFO: AppArmor enabled, this may affect test results
ima_tpm 3 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root)
ima_tpm 3 TINFO: loaded AppArmor profiles: none

Summary:
passed   0
failed   1
skipped  1
warnings 0

# head -1 /sys/kernel/security/ima/ascii_runtime_measurements

10 a3132d2501128ff527171658d40d8deb61e2292b ima-ng
sha256:3fd5dc717f886ff7182526efc5edc3abb179a5aac1ab589c8ec888398233ae5
b boot_aggregate

The ima-evm-utils next-testing branch has code to calculate the
boot_aggregate based on multiple banks.

# evmctl ima_boot_aggregate

sha1:4cf3d105b1a1a41b951cc6431f0801c01fe50b24
sha256:3fd5dc717f886ff7182526efc5edc3abb179a5aac1ab589c8ec888398233ae5b

There's also a new test to verify the boot_aggregate.

$ VERBOSE=1 make check TESTS=boog_aggregate.test

Both need some review and testing before being released.

thanks,

Mimi
