Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A08B22C4A4
	for <lists+linux-integrity@lfdr.de>; Fri, 24 Jul 2020 14:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726488AbgGXMCX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 24 Jul 2020 08:02:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49712 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726326AbgGXMCX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 24 Jul 2020 08:02:23 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 06OC2D4j074841;
        Fri, 24 Jul 2020 08:02:16 -0400
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32faep9vr3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 08:02:15 -0400
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 06OC1Pe3010384;
        Fri, 24 Jul 2020 12:01:55 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma06fra.de.ibm.com with ESMTP id 32brbgux1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 24 Jul 2020 12:01:55 +0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 06OC1qTJ63963402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 24 Jul 2020 12:01:53 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DD09511C050;
        Fri, 24 Jul 2020 12:01:52 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E78F911C04C;
        Fri, 24 Jul 2020 12:01:51 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.202.187])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 24 Jul 2020 12:01:51 +0000 (GMT)
Message-ID: <1595592111.5211.246.camel@linux.ibm.com>
Subject: Re: [PATCH v4 2/2] IMA: Add test for kexec cmdline measurement
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org
Date:   Fri, 24 Jul 2020 08:01:51 -0400
In-Reply-To: <20200724070038.29491-2-pvorel@suse.cz>
References: <20200724070038.29491-1-pvorel@suse.cz>
         <20200724070038.29491-2-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-07-24_03:2020-07-24,2020-07-24 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0
 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007240089
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, 2020-07-24 at 09:00 +0200, Petr Vorel wrote:
> From: Lachlan Sneff <t-josne@linux.microsoft.com>
> 
> IMA policy can be set to measure the command line passed in the kexec
> system call. Add a testcase that verifies that the IMA subsystem
> correctly measure the cmdline specified during a kexec.
> 
> Note that this test does not actually reboot.
> 
> Ideally, test shouldn't even require an image, since it doesn't actually
> reboot, but the IMA cmdline measurement occurs after the image is parsed
> and verified, so we must pass a valid kernel image.
> 
> There is a possibility of putting together a dummy kernel image that has
> the right headers and appears to be signed correctly, but doesn't
> actually contain any code, but, after investigating that possibility, it
> appears to be quite difficult (and would require a dummy kernel for each
> arch).

This test attempts to kexec the existing running kernel image.  To
kexec a different kernel image export IMA_KEXEC_IMAGE=<pathname>.
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Lachlan Sneff <t-josne@linux.microsoft.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
> sent version with few my fixes.
> @Mimi: could you please have a quick look? (I know you reviewed previous
> version.)

Thanks, Petr.  Just a couple of comments ...

 
<snip>

> +# Test that the kexec cmdline is measured correctly.
> +# NOTE: This does *not* actually reboot.
> +test1() {
> +	if [ ! -f "$IMA_KEXEC_IMAGE" ]; then
> +		tst_brk TCONF "Kernel image not found ('$IMA_KEXEC_IMAGE'), specify it in \$IMA_KEXEC_IMAGE"
> +	fi
> +
> +	# Strip the `BOOT_IMAGE=...` part from the cmdline.
> +	local cmdline="$(sed 's/BOOT_IMAGE=[^ ]* //' /proc/cmdline)"
> +
> +	if ! kexec -sl $IMA_KEXEC_IMAGE --reuse-cmdline; then
> +		tst_res TCONF "kexec failed: $?"
> +
> +		local sb_status="$(bootctl status 2>/dev/null | grep 'Secure Boot' \
> +			| tr -d ' ' | sed 's/SecureBoot:*//')"
> +
> +		if [ "$sb_status" = "enabled" ]; then
> +			tst_res TINFO "secure boot is enabled, the specified kernel image may not be signed"
> +		fi

Independently of the secure boot status, the IMA policy itself could require a signature.

For example, a recent software update is preventing one of my test
laptops from booting with secure boot enabled, but the custom IMA
policy still requires the kexec kernel image to be signed.

Search the IMA policy for an appraise "func=KEXEC_KERNEL_CHECK" policy
rule.

> +
> +		return
> +	fi
> +
> +	kexec -su
> +
> +	if ! measure "$cmdline"; then
> +		tst_res TFAIL "unable to find a correct entry in the IMA log"
> +
> +		check_policy_readable
> +
> +		if ! grep "measure func=KEXEC_CMDLINE" $IMA_POLICY >/dev/null; then
> +			tst_brk TCONF "The IMA policy does not specify 'measure func=KEXEC_CMDLINE', see IMA test README"
> +		fi
> +

Other than the policy "action" - measure/dont_measure,
audit/dont_audit, appraise/dont_appraise - being the first keyword,
the ordering of the policy options and flags is flexible.  Most
policies do provide the "func" option immediately following the
"action".  This would normally work.


> +		return
> +	fi
> +
> +	cmdline="foo"
> +	if ! kexec -sl $IMA_KEXEC_IMAGE --append=$cmdline; then
> +		tst_brk TCONF "kexec failed: $?"
> +	fi
> +

The error messages are exactly the same here and below.  Should a hint
be provided as to which one failed?

Mimi

> +	kexec -su
> +
> +	if ! measure "$cmdline"; then
> +		tst_brk TFAIL "unable to find a correct entry in the IMA log"
> +	fi
> +
> +	cmdline="bar"
> +	if ! kexec -sl $IMA_KEXEC_IMAGE --command-line=$cmdline; then
> +		tst_brk TCONF "kexec failed: $?"
> +	fi
> +
> +	kexec -su
> +
> +	if ! measure "$cmdline"; then
> +		tst_brk TFAIL "unable to find a correct entry in the IMA log"
> +	fi
> +
> +	tst_res TPASS "kexec cmdline was measured correctly"
> +}
> +
> +tst_run

