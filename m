Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F58C48DF82
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jan 2022 22:20:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235055AbiAMVTl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jan 2022 16:19:41 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30176 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235144AbiAMVTj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Jan 2022 16:19:39 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20DKS908012145;
        Thu, 13 Jan 2022 21:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=gglTjkJQfUQeW1de/xy1Uu37Ciw6EQP2ZvTjwgTy8g8=;
 b=Pn+xY/c0IJINFihRCVKn6Bcv2cZD1xtU+ilXssjX57BMGpsk82WltbrXBPLceEHH3t0n
 XK/4BM3taLSTqdsxGKp/bte4pauyJ1q3VX2ElUnL1dDLHO1JLSn5aBKpNsgpCQ3+QAiO
 e2rLaQSbvhG/XvYb7228Nxghkx45mqkfoUiXLgzMJGn3LJXdl5t+2rvWWlJZ2DSgRvha
 SEvv4uOdUVBNSP89zmcsJHSYg07ERt+dus4GVMiWD1ATbSus96cSCdB5i9Iba8ij25g7
 NFbessQqN3BZI8h+yGmbhW/J2mxKqDrtMGasgKB9/ral1FnPzGgkY3aesoeBQcuM5u9K 1Q== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dju55h1fn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 21:19:35 +0000
Received: from m0127361.ppops.net (m0127361.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 20DLDuhc031078;
        Thu, 13 Jan 2022 21:19:35 GMT
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3dju55h1fe-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 21:19:35 +0000
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 20DLHwQX019673;
        Thu, 13 Jan 2022 21:19:34 GMT
Received: from b03cxnp08026.gho.boulder.ibm.com (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
        by ppma02dal.us.ibm.com with ESMTP id 3df28cnncj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 13 Jan 2022 21:19:34 +0000
Received: from b03ledav002.gho.boulder.ibm.com (b03ledav002.gho.boulder.ibm.com [9.17.130.233])
        by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 20DLJXQU33292630
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 13 Jan 2022 21:19:33 GMT
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 83D3913604F;
        Thu, 13 Jan 2022 21:19:33 +0000 (GMT)
Received: from b03ledav002.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2E37136061;
        Thu, 13 Jan 2022 21:19:32 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
        by b03ledav002.gho.boulder.ibm.com (Postfix) with ESMTP;
        Thu, 13 Jan 2022 21:19:32 +0000 (GMT)
Message-ID: <4b59d305-6858-1514-751a-37853ad777be@linux.ibm.com>
Date:   Thu, 13 Jan 2022 16:19:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] tpm: vtpm_proxy: Avoid device-originated buffer overflow
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Peter Huewe <peterhuewe@gmx.de>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20220113002727.3709495-1-keescook@chromium.org>
From:   Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20220113002727.3709495-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uN_XodsZ-6rQp0VYokR1dUX0tyVpPSlM
X-Proofpoint-GUID: wApIpmcjT2Lfp7eHeYAXTbKLYI-eziLm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-13_09,2022-01-13_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 phishscore=0 clxscore=1011 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2201130129
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 1/12/22 19:27, Kees Cook wrote:
> When building with -Warray-bounds, this warning was emitted:
>
> In function 'memset',
>      inlined from 'vtpm_proxy_fops_read' at drivers/char/tpm/tpm_vtpm_proxy.c:102:2:
> ./include/linux/fortify-string.h:43:33: warning: '__builtin_memset' pointer overflow between offset 164 and size [2147483648, 4294967295]
> [-Warray-bounds]
>     43 | #define __underlying_memset     __builtin_memset
>        |                                 ^
>
> There was no checking of the req_len value from the device. A malicious
> (or buggy) device could end up leaking (and when wiping) memory contents
> beyond the end of the proxy buffer.
>
> Cc: Peter Huewe <peterhuewe@gmx.de>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Jason Gunthorpe <jgg@ziepe.ca>
> Cc: linux-integrity@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>   drivers/char/tpm/tpm_vtpm_proxy.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/char/tpm/tpm_vtpm_proxy.c b/drivers/char/tpm/tpm_vtpm_proxy.c
> index 91c772e38bb5..5c865987ba5c 100644
> --- a/drivers/char/tpm/tpm_vtpm_proxy.c
> +++ b/drivers/char/tpm/tpm_vtpm_proxy.c
> @@ -91,7 +91,7 @@ static ssize_t vtpm_proxy_fops_read(struct file *filp, char __user *buf,
>   
>   	len = proxy_dev->req_len;
>   
> -	if (count < len) {
> +	if (count < len || len > sizeof(proxy_dev->buffer)) {
>   		mutex_unlock(&proxy_dev->buf_lock);
>   		pr_debug("Invalid size in recv: count=%zd, req_len=%zd\n",
>   			 count, len);


Thanks for this patch.

I just want to clarify this. In vtpm_proxy_tpm_op_send() we have the 
only place that sets req_len to a value larger than 0:

static int vtpm_proxy_tpm_op_send(struct tpm_chip *chip, u8 *buf, size_t 
count)
{
     struct proxy_dev *proxy_dev = dev_get_drvdata(&chip->dev);

     if (count > sizeof(proxy_dev->buffer)) {
         dev_err(&chip->dev,
             "Invalid size in send: count=%zd, buffer size=%zd\n",
             count, sizeof(proxy_dev->buffer));
         return -EIO;
     }

[...]

     proxy_dev->req_len = count;
     memcpy(proxy_dev->buffer, buf, count);

[...]

}


The above makes sure that we cannot copy more bytes into the 
proxy_dev->buffer than the what the buffer has bytes for.

It then sets req_len to a valid value that is less or equal to the 
buffer size.

Considering this your check above seems to only be there to make the 
compiler happy but otherwise I don't see that this is a real problem 
with a buffer overflow?!

Nevertheless, let all those compilers be happy:

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


