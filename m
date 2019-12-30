Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE5DF12D4A2
	for <lists+linux-integrity@lfdr.de>; Mon, 30 Dec 2019 22:14:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727733AbfL3VOT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 30 Dec 2019 16:14:19 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33292 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727691AbfL3VOS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 30 Dec 2019 16:14:18 -0500
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 790912010C33;
        Mon, 30 Dec 2019 13:14:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 790912010C33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1577740457;
        bh=Bu/8zUbgFjbXS2yKm478+Ao0RnZWaeg5lkupjtP5E20=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=R4GSPCV4i4L3hSCC5v4j4e4C8mOPWZrG8yxCrzHNEwPiopgjoJL2unWPBawMxBfUN
         J49aaMvARp4xbVFz3Dq7Oi8HAFLG7gLa+X6EgzM7Ej4Mzi+1TAOsbSoSwUPiZGOZxX
         K26E9RmJyUlOYKa0LjstXcvvCFO8fYElxNX/jI3I=
Subject: Re: [IMA] 11b771ffff:
 BUG:sleeping_function_called_from_invalid_context_at_kernel/locking/mutex.c
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        linux-integrity@vger.kernel.org, lkp@lists.01.org
References: <20191227142335.GE2760@shao2-debian>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <2a831fe9-30e5-63b4-af10-a69f327f7fb7@linux.microsoft.com>
Date:   Mon, 30 Dec 2019 13:14:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191227142335.GE2760@shao2-debian>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/27/19 6:23 AM, kernel test robot wrote:

Hi Rong,

> 
> 
> To reproduce:
> 
>          # build kernel
> 	cd linux
> 	cp config-5.5.0-rc1-00011-g11b771ffff8fc .config
> 	make HOSTCC=gcc-7 CC=gcc-7 ARCH=x86_64 olddefconfig prepare modules_prepare bzImage
> 
>          git clone https://github.com/intel/lkp-tests.git
>          cd lkp-tests
>          bin/lkp qemu -k <bzImage> job-script # job-script is attached in this email
> 
> 
> 
> Thanks,
> Rong Chen
> 

Thanks for reporting this issue.

I built the kernel with the config you'd provided.

When running lkp-tests using the command line given, I see the following 
error and the test stops.

	bin/lkp qemu -k ../linux-5.5/arch/x86/boot/bzImage job-script

/usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 
https://download.01.org/0day-ci/lkp-qemu/pkg/linux/x86_64-rhel-7.6/gcc-7/11b771ffff8fc0bfc176b829d986896a7d97a44c/linux-headers.cgz 
-N -P 
/root/.lkp/cache/pkg/linux/x86_64-rhel-7.6/gcc-7/11b771ffff8fc0bfc176b829d986896a7d97a44c

Failed to download 
pkg/linux/x86_64-rhel-7.6/gcc-7/11b771ffff8fc0bfc176b829d986896a7d97a44c/linux-headers.cgz

Please let me know what I am missing.

Full output of the command is given below:

bin/lkp qemu -k ../linux-5.5/arch/x86/boot/bzImage job-script

result_root: 
/root/.lkp//result/kernel_selftests/kselftests-03/vm-snb/debian-x86_64-2019-11-14.cgz/x86_64-rhel-7.6/gcc-7/11b771ffff8fc0bfc176b829d986896a7d97a44c/8
downloading initrds ...
/usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 
https://download.01.org/0day-ci/lkp-qemu/osimage/debian/debian-x86_64-2019-11-14.cgz 
-N -P /root/.lkp/cache/osimage/debian
408859 blocks
/usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 
https://download.01.org/0day-ci/lkp-qemu/osimage/deps/debian-x86_64-2018-04-03.cgz/run-ipconfig_2018-04-03.cgz 
-N -P /root/.lkp/cache/osimage/deps/debian-x86_64-2018-04-03.cgz
1414 blocks
/usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 
https://download.01.org/0day-ci/lkp-qemu/osimage/deps/debian-x86_64-2018-04-03.cgz/lkp_2019-08-05.cgz 
-N -P /root/.lkp/cache/osimage/deps/debian-x86_64-2018-04-03.cgz
1670 blocks
/usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 
https://download.01.org/0day-ci/lkp-qemu/osimage/deps/debian-x86_64-2018-04-03.cgz/rsync-rootfs_2018-04-03.cgz 
-N -P /root/.lkp/cache/osimage/deps/debian-x86_64-2018-04-03.cgz
8268 blocks
/usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 
https://download.01.org/0day-ci/lkp-qemu/osimage/deps/debian-x86_64-2018-04-03.cgz/kernel_selftests_2019-12-25.cgz 
-N -P /root/.lkp/cache/osimage/deps/debian-x86_64-2018-04-03.cgz
932372 blocks
/usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 
https://download.01.org/0day-ci/lkp-qemu/osimage/pkg/debian-x86_64-2018-04-03.cgz/kernel_selftests-x86_64-0dcf36db-1_2019-12-25.cgz 
-N -P /root/.lkp/cache/osimage/pkg/debian-x86_64-2018-04-03.cgz
30125 blocks
/usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 
https://download.01.org/0day-ci/lkp-qemu/pkg/linux/x86_64-rhel-7.6/gcc-7/11b771ffff8fc0bfc176b829d986896a7d97a44c/linux-headers.cgz 
-N -P 
/root/.lkp/cache/pkg/linux/x86_64-rhel-7.6/gcc-7/11b771ffff8fc0bfc176b829d986896a7d97a44c
Failed to download 
pkg/linux/x86_64-rhel-7.6/gcc-7/11b771ffff8fc0bfc176b829d986896a7d97a44c/linux-headers.cgz


