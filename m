Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A59A012094
	for <lists+linux-integrity@lfdr.de>; Thu,  2 May 2019 18:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfEBQwy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 2 May 2019 12:52:54 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36752 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726138AbfEBQwy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 2 May 2019 12:52:54 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x42GgEDB076674
        for <linux-integrity@vger.kernel.org>; Thu, 2 May 2019 12:52:52 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2s84560t0c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Thu, 02 May 2019 12:52:52 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Thu, 2 May 2019 17:52:50 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 2 May 2019 17:52:47 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x42GqkkI49152004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 2 May 2019 16:52:46 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5BC342042;
        Thu,  2 May 2019 16:52:46 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AF9334203F;
        Thu,  2 May 2019 16:52:45 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.95.175])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  2 May 2019 16:52:45 +0000 (GMT)
Subject: Re: [PATCH v3 3/4] add kexec_cmdline used to ima
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Prakhar Srivastava <prsriva02@gmail.com>,
        linux-integrity@vger.kernel.org,
        linux-secuirty-module@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ebiederm@xmission.com, vgoyal@redhat.com, nayna@linux.ibm.com
Date:   Thu, 02 May 2019 12:52:35 -0400
In-Reply-To: <20190429214743.4625-4-prsriva02@gmail.com>
References: <20190429214743.4625-1-prsriva02@gmail.com>
         <20190429214743.4625-4-prsriva02@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19050216-0016-0000-0000-00000277A6E9
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19050216-0017-0000-0000-000032D43C58
Message-Id: <1556815955.4134.78.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-02_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1905020109
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2019-04-29 at 14:47 -0700, Prakhar Srivastava wrote:
> From: Prakhar Srivastava <prsriva02@gmail.com>
> 
> prepend the kernel file name to kexec_cmdline 
> before measuring the buffer.
> 

kexec doesn't really know or care about IMA.  Other than the IMA call,
itself, nothing should be added to kexec files.  As mentioned in 1/4,
the IMA hook would be named something like ima_kexec_cmdline().

Mimi

> Signed-off-by: Prakhar Srivastava <prsriva02@gmail.com>
> ---
>  kernel/kexec_core.c | 57 +++++++++++++++++++++++++++++++++++++++++++++
>  kernel/kexec_file.c | 14 +++++++++++
>  2 files changed, 71 insertions(+)
> 
> diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
> index d7140447be75..4667f03d406e 100644
> --- a/kernel/kexec_core.c
> +++ b/kernel/kexec_core.c
> @@ -1213,3 +1213,60 @@ void __weak arch_kexec_protect_crashkres(void)
>  
>  void __weak arch_kexec_unprotect_crashkres(void)
>  {}
> +
> +/**
> + * kexec_cmdline_prepend_img_name - prepare the buffer with cmdline
> + * that needs to be measured
> + * @outbuf - out buffer that contains the formated string
> + * @kernel_fd - the file identifier for the kerenel image
> + * @cmdline_ptr - ptr to the cmdline buffer
> + * @cmdline_len - len of the buffer.
> + *
> + * This generates a buffer in the format Kerenelfilename::cmdline
> + *
> + * On success return 0.
> + * On failure return -EINVAL.
> + */
> +int kexec_cmdline_prepend_img_name(char **outbuf, int kernel_fd,
> +				const char *cmdline_ptr,
> +				unsigned long cmdline_len)
> +{
> +	int ret = -EINVAL;
> +	struct fd f = {};
> +	int size = 0;
> +	char *buf = NULL;
> +	char delimiter[] = "::";
> +
> +	if (!outbuf || !cmdline_ptr)
> +		goto out;
> +
> +	f = fdget(kernel_fd);
> +	if (!f.file)
> +		goto out;
> +
> +	size = (f.file->f_path.dentry->d_name.len + cmdline_len - 1+
> +			ARRAY_SIZE(delimiter)) - 1;
> +
> +	buf = kzalloc(size, GFP_KERNEL);
> +	if (!buf)
> +		goto out;
> +
> +	memcpy(buf, f.file->f_path.dentry->d_name.name,
> +		f.file->f_path.dentry->d_name.len);
> +	memcpy(buf + f.file->f_path.dentry->d_name.len,
> +		delimiter, ARRAY_SIZE(delimiter) - 1);
> +	memcpy(buf + f.file->f_path.dentry->d_name.len +
> +		ARRAY_SIZE(delimiter) - 1,
> +		cmdline_ptr, cmdline_len - 1);
> +
> +	*outbuf = buf;
> +	ret = size;
> +
> +	pr_debug("kexec cmdline buff: %s\n", buf);
> +
> +out:
> +	if (f.file)
> +		fdput(f);
> +
> +	return ret;
> +}
> diff --git a/kernel/kexec_file.c b/kernel/kexec_file.c
> index f1d0e00a3971..d287e139085c 100644
> --- a/kernel/kexec_file.c
> +++ b/kernel/kexec_file.c
> @@ -191,6 +191,8 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  	int ret = 0;
>  	void *ldata;
>  	loff_t size;
> +	char *buff_to_measure = NULL;
> +	int buff_to_measure_size = 0;
>  
>  	ret = kernel_read_file_from_fd(kernel_fd, &image->kernel_buf,
>  				       &size, INT_MAX, READING_KEXEC_IMAGE);
> @@ -241,6 +243,16 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  			ret = -EINVAL;
>  			goto out;
>  		}
> +
> +		/* IMA measures the cmdline args passed to the next kernel*/
> +		buff_to_measure_size =
> +			kexec_cmdline_prepend_img_name(&buff_to_measure,
> +			kernel_fd, image->cmdline_buf, image->cmdline_buf_len);
> +
> +		ima_buffer_check(buff_to_measure, buff_to_measure_size,
> +					"kexec_cmdline");
> +
> +
>  	}
>  
>  	/* Call arch image load handlers */
> @@ -253,7 +265,9 @@ kimage_file_prepare_segments(struct kimage *image, int kernel_fd, int initrd_fd,
>  
>  	image->image_loader_data = ldata;
>  out:
> +
>  	/* In case of error, free up all allocated memory in this function */
> +	kfree(buff_to_measure);
>  	if (ret)
>  		kimage_file_post_load_cleanup(image);
>  	return ret;

