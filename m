Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21F342299B4
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Jul 2020 16:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730346AbgGVOE4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Jul 2020 10:04:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3624 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728837AbgGVOE4 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Jul 2020 10:04:56 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06ME1pFM010319;
        Wed, 22 Jul 2020 10:04:49 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32e1x84rxc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 10:04:48 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06ME4bkN013511;
        Wed, 22 Jul 2020 14:04:46 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma04fra.de.ibm.com with ESMTP id 32dbmn1asx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 22 Jul 2020 14:04:45 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06ME4hYu32702854
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Jul 2020 14:04:43 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F966A4054;
        Wed, 22 Jul 2020 14:04:43 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D24D3A405C;
        Wed, 22 Jul 2020 14:04:42 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.139.199])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 22 Jul 2020 14:04:42 +0000 (GMT)
Message-ID: <1595426682.5311.83.camel@linux.ibm.com>
Subject: Re: [PATCH] IMA: Add test for kexec cmdline measurement
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Lachlan Sneff <t-josne@linux.microsoft.com>, pvorel@suse.cz,
        ltp@lists.linux.it
Cc:     nramas@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org
Date:   Wed, 22 Jul 2020 10:04:42 -0400
In-Reply-To: <20200721182440.4169-1-t-josne@linux.microsoft.com>
References: <20200721182440.4169-1-t-josne@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-22_05:2020-07-22,2020-07-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxscore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2007220099
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-07-21 at 14:24 -0400, Lachlan Sneff wrote:

<snip>

> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
> new file mode 100644
> index 000000000..7d71557ee
> --- /dev/null
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_kexec.sh
> @@ -0,0 +1,93 @@
> +#!/bin/sh
> +# SPDX-License-Identifier: GPL-2.0-or-later
> +# Copyright (c) 2020 Microsoft Corporation
> +# Author: Lachlan Sneff <t-josne@linux.microsoft.com>
> +#
> +# Verify that kexec cmdline is measured correctly.
> +
> +TST_NEEDS_CMDS="kexec sed xargs printf grep"
> +TST_CNT=1
> +TST_NEEDS_DEVICE=1
> +
> +. ima_setup.sh
> +
> +# Since the test is executed inside some sort of
> +# separate shell, *most* environment variables are
> +# not accessible, so there's no way to set it from
> +# the outside.
> +#
> +# `/boot/vmlinuz-$(uname-r)` is where the image is
> +# located on many systems, but not all. Therefore,
> +# if the image is not located there, require the
> +# user to copy it to `/tmp/Image`.
> +#
> +# Ideally, this test shouldn't even require an image,
> +# since it doesn't actually reboot, but the IMA cmdline
> +# measurement occurs after the image is parsed and verified,
> +# so we must pass a valid kernel image. There is a possiblity of
> +# putting together a "faux" kernel image that has the right headers
> +# and appears to be signed correctly, but doesn't actually contain any
> +# code, but, after investigating that possiblity, it appears to be
> +# quite difficult (and would require a new faux kernel for each arch).

The comment formatting is inconsistent.  Please correct.

> +IMAGE="/boot/vmlinuz-$(uname -r)"
> +if [ ! -f $IMAGE ]; then
> +    IMAGE="/tmp/Image"
> +fi
> +
> +measure() {
> +    local found temp_file="file.txt" temp_file2="file2.txt" algorithm \
> +        digest expected_digest
> +
> +    echo -n "$1" > $temp_file
> +    grep "kexec-cmdline" $ASCII_MEASUREMENTS > $temp_file2
> +
> +    while read found
> +    do
> +        algorithm=$(echo "$found" | cut -d' ' -f4 | cut -d':' -f1)
> +        digest=$(echo "$found" | cut -d' ' -f4 | cut -d':' -f2)
> +
> +        expected_digest=$(compute_digest $algorithm $temp_file)
> +
> +        if [ "$digest" = "$expected_digest" ]; then
> +            return 0
> +        fi
> +    done < $temp_file2
> +
> +    return 1
> +}
> +
> +# Test that the kexec cmdline is measured correctly.
> +# NOTE: This does *not* actually reboot.
> +test1() {
> +    # Strip the `BOOT_IMAGE=...` part from the cmdline.
> +    local cmdline="$(sed 's/BOOT_IMAGE=[^ ]* //' /proc/cmdline)"
> +    if ! kexec -sl $IMAGE --reuse-cmdline; then
> +        tst_brk TCONF "kexec failed: $?"
> +    fi

Most likely one of the reasons for the kexec to fail is that the
kernel image isn't properly signed.  How about checking the secure-
boot status to provide some contextual information.

> +
> +    if ! measure "$cmdline"; then
> +        tst_brk TFAIL "kexec cmdline was measured incorrectly"
> +    fi

This assumes that a kexec command line measurement was found.  The
output needs to differentiate between no measurement and an invalid
measurement.  In the case that the rule doesn't exist, at that point
you have a choice of skipping the test or extending the IMA policy. 

The kernel kexec selftests checks both the Kconfig and the IMA runtime
policy.  Different testing infrastructures have different policies
about basing tests on them.

> +
> +    cmdline="foo"

Wondering if unknown command line options could cause the kexec to
fail.

> +    if ! kexec -sl $IMAGE --append=$cmdline; then
> +        tst_brk TCONF "kexec failed: $?"
> +    fi

Should the first kernel image be unloaded first?

Mimi

> +
> +    if ! measure "$cmdline"; then
> +        tst_brk TFAIL "kexec cmdline was measured incorrectly"
> +    fi
> +
> +    cmdline="bar"
> +    if ! kexec -sl $IMAGE --command-line=$cmdline; then
> +        tst_brk TCONF "kexec failed: $?"
> +    fi
> +
> +    if ! measure "$cmdline"; then
> +        tst_brk TFAIL "kexec cmdline was measured incorrectly"
> +    fi
> +
> +    tst_res TPASS "kexec cmldine was measured correctly"
> +}
> +
> +tst_run

