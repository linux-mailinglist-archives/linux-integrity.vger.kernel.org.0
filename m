Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2EF7448B9
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Jun 2019 19:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729222AbfFMRLD (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Jun 2019 13:11:03 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36196 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729192AbfFLWbz (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 12 Jun 2019 18:31:55 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5CMVRDN052774
        for <linux-integrity@vger.kernel.org>; Wed, 12 Jun 2019 18:31:53 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2t37twwe5r-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 12 Jun 2019 18:31:53 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 12 Jun 2019 23:31:51 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 12 Jun 2019 23:31:46 +0100
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5CMVjkq55836814
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jun 2019 22:31:45 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20D615205F;
        Wed, 12 Jun 2019 22:31:45 +0000 (GMT)
Received: from dhcp-9-31-103-88.watson.ibm.com (unknown [9.31.103.88])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 2CA8B52054;
        Wed, 12 Jun 2019 22:31:44 +0000 (GMT)
Subject: Re: [PATCH V8 3/3] Call ima_kexec_cmdline to measure the cmdline
 args
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Prakhar Srivastava <prsriva02@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     roberto.sassu@huawei.com, vgoyal@redhat.com,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Dave Young <dyoung@redhat.com>,
        kexec <kexec@lists.infradead.org>
Date:   Wed, 12 Jun 2019 18:31:43 -0400
In-Reply-To: <20190612221549.28399-4-prsriva02@gmail.com>
References: <20190612221549.28399-1-prsriva02@gmail.com>
         <20190612221549.28399-4-prsriva02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19061222-0012-0000-0000-00000328A073
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19061222-0013-0000-0000-00002161A9C6
Message-Id: <1560378703.4578.91.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-12_13:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906120158
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

[Cc: kexec mailing list]

Hi Eric, Dave,

On Wed, 2019-06-12 at 15:15 -0700, Prakhar Srivastava wrote:
> During soft reboot(kexec_file_load) boot cmdline args
> are not measured.Thus the new kernel on load boots with
> an assumption of cold reboot.
> 
> This patch makes a call to the ima hook ima_kexec_cmdline,
> added in "Define a new IMA hook to measure the boot command
> line arguments"
> to measure the boot cmdline args into the ima log.
> 
> - call ima_kexec_cmdline from kexec_file_load.
> - move the call ima_add_kexec_buffer after the cmdline
> args have been measured.
> 
> Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
Cc: Eric W. Biederman <ebiederm@xmission.com>
Cc: Dave Young <dyoung@redhat.com>

Any chance we could get some Acks?

thanks,

Mimi

> ---
>  kernel/kexec_file.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index 072b6ee55e3f..b0c724e5d86c 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -198,9 +198,6 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  		return ret;
>  	image->kernel_buf_len = size;
>  
> -	/* IMA needs to pass the measurement list to the next kernel. */
> -	ima_add_kexec_buffer(image);
> -
>  	/* Call arch image probe handlers */
>  	ret = arch_kexec_kernel_image_probe(image, image->kernel_buf,
>  					    image->kernel_buf_len);
> @@ -241,8 +238,14 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  			ret = -EINVAL;
>  			goto out;
>  		}
> +
> +		ima_kexec_cmdline(image->cmdline_buf,
> +				  image->cmdline_buf_len - 1);
>  	}
>  
> +	/* IMA needs to pass the measurement list to the next kernel. */
> +	ima_add_kexec_buffer(image);
> +
>  	/* Call arch image load handlers */
>  	ldata = arch_kexec_kernel_image_load(image);
>  

