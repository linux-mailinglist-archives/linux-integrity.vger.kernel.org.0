Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76ED92DD864
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Dec 2020 19:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgLQSbL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Dec 2020 13:31:11 -0500
Received: from linux.microsoft.com ([13.77.154.182]:58646 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbgLQSbL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Dec 2020 13:31:11 -0500
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id EDEFB20B717A;
        Thu, 17 Dec 2020 10:30:29 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EDEFB20B717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1608229830;
        bh=MGlSEbnnlqPYIh5vvkUAJ9wW9ncNIo/aKpPc5ykNpWA=;
        h=Subject:From:To:Cc:References:Date:In-Reply-To:From;
        b=MBs0E0/64gfpXXWMig+JHbYgTQl0GVsOSxSIdumb+USW3RMdDr84Beh9aeCAMpKPq
         K5HBuk5POcskxq0qZGZ5WCP4UsaJvIRMaDIX6IOGHpr7kRfA7oyHbxSm2BWWrolczs
         6faFUqmqpBy8Uy6I1wMgOSKbSN2OH8ySkSZiw0p8=
Subject: Re: [PATCH v12 3/4] arm64: Free DTB buffer if fdt_open_into() fails
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
To:     zohar@linux.ibm.com, bauerman@linux.ibm.com, robh@kernel.org,
        takahiro.akashi@linaro.org, gregkh@linuxfoundation.org,
        will@kernel.org, catalin.marinas@arm.com, mpe@ellerman.id.au
Cc:     james.morse@arm.com, sashal@kernel.org, benh@kernel.crashing.org,
        paulus@samba.org, frowand.list@gmail.com,
        vincenzo.frascino@arm.com, mark.rutland@arm.com,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        pasha.tatashin@soleen.com, allison@lohutok.net,
        masahiroy@kernel.org, bhsharma@redhat.com, mbrugger@suse.com,
        hsinyi@chromium.org, tao.li@vivo.com, christophe.leroy@c-s.fr,
        prsriva@linux.microsoft.com, balajib@linux.microsoft.com,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20201217173708.6940-1-nramas@linux.microsoft.com>
 <20201217173708.6940-4-nramas@linux.microsoft.com>
Message-ID: <50e52d9b-db37-f95b-7056-d90476475fd9@linux.microsoft.com>
Date:   Thu, 17 Dec 2020 10:30:29 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201217173708.6940-4-nramas@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/17/20 9:37 AM, Lakshmi Ramasubramanian wrote:
> create_dtb() function allocates memory for the device tree blob (DTB)
> and calls fdt_open_into(). If this call fails the memory allocated
> for the DTB is not freed before returning from create_dtb() thereby
> leaking memory.

Typo in the email address of James Morse (ARM.com). Sorry about that.
Adding the correct email address.

  -lakshmi

> 
> Call vfree() to free the memory allocated for the DTB if fdt_open_into()
> fails.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
>   arch/arm64/kernel/machine_kexec_file.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/machine_kexec_file.c b/arch/arm64/kernel/machine_kexec_file.c
> index 7de9c47dee7c..3e045cd62451 100644
> --- a/arch/arm64/kernel/machine_kexec_file.c
> +++ b/arch/arm64/kernel/machine_kexec_file.c
> @@ -65,8 +65,10 @@ static int create_dtb(struct kimage *image,
>   
>   		/* duplicate a device tree blob */
>   		ret = fdt_open_into(initial_boot_params, buf, buf_size);
> -		if (ret)
> +		if (ret) {
> +			vfree(buf);
>   			return -EINVAL;
> +		}
>   
>   		ret = of_kexec_setup_new_fdt(image, buf, initrd_load_addr,
>   					     initrd_len, cmdline);
> 

