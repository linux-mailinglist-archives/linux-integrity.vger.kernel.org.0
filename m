Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD83F30438B
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Jan 2021 17:16:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404124AbhAZQPf (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Jan 2021 11:15:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:44594 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392809AbhAZQPc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Jan 2021 11:15:32 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 10QG2iP6120828;
        Tue, 26 Jan 2021 11:14:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=AhvSL2TAJ80kVGaC+dSvTyUh5/MyoptmSJ6r3fC+XAY=;
 b=ZTMFb/pHBVMD4wPQ29Cmj/ljFhB+EcSBIxcMTEGkg/i6sTeqXoJhjHhJ19bDQ+VzlpoC
 t74KowwyAF64Dm+da7cmNzSIYOnAn6r5+wOOoRd5yEikICYN9cYJzdSHceY7winO9Rlu
 6XDKU7K6CSsMbz7VeKts4kmzY9aZA/rR0DP/B7pny/je2tAO/h3jqfjonRsR8WIgQ9kE
 P3wpWEHqyPFPvCYLafIrTDAYB+2GIxuB8enV4SV3rjZI421lN1t6yY/1c+Y9amRNYudP
 SFXGebDe39D5ynaZga8XSzcAqHl1f1FZEyrPU5zN6gLxSI+6rSrJc2+rQ/XGHoNyo4Fs +A== 
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 36amnaux7c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jan 2021 11:14:50 -0500
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 10QGDB4O023245;
        Tue, 26 Jan 2021 16:14:48 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma06ams.nl.ibm.com with ESMTP id 368b2h2y0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 26 Jan 2021 16:14:48 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 10QGEkcm22086112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jan 2021 16:14:46 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0EB5FA4054;
        Tue, 26 Jan 2021 16:14:46 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62B02A405C;
        Tue, 26 Jan 2021 16:14:44 +0000 (GMT)
Received: from li-f45666cc-3089-11b2-a85c-c57d1a57929f.ibm.com (unknown [9.160.59.15])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 26 Jan 2021 16:14:44 +0000 (GMT)
Message-ID: <1e60a5577d42470e83900de4f8a8c631b0949112.camel@linux.ibm.com>
Subject: Re: [PATCH v3] IMA: Measure kernel version in early boot
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Raphael Gianotti <raphgi@linux.microsoft.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        tusharsu@linux.microsoft.com, nramas@linux.microsoft.com,
        tyhicks@linux.microsoft.com
Date:   Tue, 26 Jan 2021 11:14:43 -0500
In-Reply-To: <20210126005044.2010-1-raphgi@linux.microsoft.com>
References: <20210126005044.2010-1-raphgi@linux.microsoft.com>
Content-Type: text/plain; charset="ISO-8859-15"
X-Mailer: Evolution 3.28.5 (3.28.5-14.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-26_08:2021-01-26,2021-01-26 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 suspectscore=0 phishscore=0 impostorscore=0
 spamscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2101260084
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2021-01-25 at 16:50 -0800, Raphael Gianotti wrote:
> The integrity of a kernel can be verified by the boot loader on cold
> boot, and during kexec, by the current running kernel, before it is
> loaded. However, it is still possible that the new kernel being
> loaded is older than the current kernel, and/or has known
> vulnerabilities. Therefore, it is imperative that an attestation
> service be able to verify the version of the kernel being loaded on
> the client, from cold boot and subsequent kexec system calls,
> ensuring that only kernels with versions known to be good are loaded.
> 
> Measure the kernel version using ima_measure_critical_data() early on
> in the boot sequence, reducing the chances of known kernel
> vulnerabilities being exploited. With IMA being part of the kernel,
> this overall approach makes the measurement itself more trustworthy.
> 
> To enable measuring the kernel version "ima_policy=critical_data"
> needs to be added to the kernel command line arguments.
> For example,
>         BOOT_IMAGE=/boot/vmlinuz-5.11.0-rc3+ root=UUID=fd643309-a5d2-4ed3-b10d-3c579a5fab2f ro nomodeset ima_policy=critical_data
> 
> If runtime measurement of the kernel version is ever needed, the
> following should be added to /etc/ima/ima-policy:
> 
>         measure func=CRITICAL_DATA label=kernel_info
> 
> To extract the measured data after boot, the following command can be used:
> 
>         grep -m 1 "kernel_version" \
>         /sys/kernel/security/integrity/ima/ascii_runtime_measurements
> 
> Sample output from the command above:
> 
>         10 a8297d408e9d5155728b619761d0dd4cedf5ef5f ima-buf
>         sha256:5660e19945be0119bc19cbbf8d9c33a09935ab5d30dad48aa11f879c67d70988
>         kernel_version 352e31312e302d7263332d31363138372d676564623634666537383234342d6469727479
> 
> The above corresponds to the following (decoded) version string:

Instead of the above, the following is clearer.

    The above hex-ascii string corresponds to the kernel version
    (e.g. xxd -r -p):
> 
>         5.11.0-rc3-16187-gedb64fe78244-dirty

> 
> Signed-off-by: Raphael Gianotti <raphgi@linux.microsoft.com>

Assuming the above or similar change,

Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>

