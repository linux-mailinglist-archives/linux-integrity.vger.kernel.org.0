Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2C1134729
	for <lists+linux-integrity@lfdr.de>; Wed,  8 Jan 2020 17:07:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728320AbgAHQGI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 8 Jan 2020 11:06:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60318 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728399AbgAHQGI (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 8 Jan 2020 11:06:08 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 008G3SB2169266
        for <linux-integrity@vger.kernel.org>; Wed, 8 Jan 2020 11:06:06 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xapd7q1b4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Wed, 08 Jan 2020 11:06:05 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 8 Jan 2020 16:06:03 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 Jan 2020 16:05:58 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 008G5vX934865562
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jan 2020 16:05:58 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E0627AE045;
        Wed,  8 Jan 2020 16:05:57 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C9B4DAE055;
        Wed,  8 Jan 2020 16:05:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.80.223.32])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  8 Jan 2020 16:05:56 +0000 (GMT)
Subject: Re: [PATCH v2] ima: add the ability to query the hash of a given
 file.
From:   Mimi Zohar <zohar@linux.ibm.com>
To:     Florent Revest <revest@chromium.org>,
        linux-integrity@vger.kernel.org
Cc:     kpsingh@chromium.org, mjg59@google.com, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Florent Revest <revest@google.com>
Date:   Wed, 08 Jan 2020 11:05:56 -0500
In-Reply-To: <20200106162524.164650-1-revest@chromium.org>
References: <20200106162524.164650-1-revest@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20010816-4275-0000-0000-00000395D6AF
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010816-4276-0000-0000-000038A9C44D
Message-Id: <1578499556.5222.157.camel@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-08_04:2020-01-08,2020-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0 phishscore=0
 priorityscore=1501 bulkscore=0 mlxlogscore=999 mlxscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001080131
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2020-01-06 at 17:25 +0100, Florent Revest wrote:
> From: Florent Revest <revest@google.com>
> 
> This allows other parts of the kernel (perhaps a stacked LSM allowing
> system monitoring, eg. the proposed KRSI LSM [1]) to retrieve the hash
> of a given file from IMA if it's present in the iint cache.
> 
> It's true that the existence of the hash means that it's also in the
> audit logs or in /sys/kernel/security/ima/ascii_runtime_measurements,
> but it can be difficult to pull that information out for every
> subsequent exec.  This is especially true if a given host has been up
> for a long time and the file was first measured a long time ago.
> 
> This is based on Peter Moody's patch:
>  https://sourceforge.net/p/linux-ima/mailman/message/33036180/

FYI, but unlike the audit log/IMA measurement list, the iint cache
entries can be removed.  Refer to security_inode_free().  Perhaps
mention of this difference should be included, here, in the patch
description.

> 
> [1] https://lkml.org/lkml/2019/9/10/393
> 
> Signed-off-by: Florent Revest <revest@google.com>

Assuming, with the above difference, you're still interested in having
this feature upstreamed and addressing the comments above and below:

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  include/linux/ima.h               |  6 ++++
>  security/integrity/ima/ima_main.c | 46 +++++++++++++++++++++++++++++++
>  2 files changed, 52 insertions(+)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 6d904754d858..d621c65ba9a5 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -23,6 +23,7 @@ extern int ima_read_file(struct file *file, enum kernel_read_file_id id);
>  extern int ima_post_read_file(struct file *file, void *buf, loff_t size,
>  			      enum kernel_read_file_id id);
>  extern void ima_post_path_mknod(struct dentry *dentry);
> +extern int ima_file_hash(struct file *file, char *buf, size_t buf_size);
>  extern void ima_kexec_cmdline(const void *buf, int size);
>  
>  #ifdef CONFIG_IMA_KEXEC
> @@ -91,6 +92,11 @@ static inline void ima_post_path_mknod(struct dentry *dentry)
>  	return;
>  }
>  
> +static inline int ima_file_hash(struct file *file, char *buf, size_t buf_size)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
>  static inline void ima_kexec_cmdline(const void *buf, int size) {}
>  #endif /* CONFIG_IMA */
>  
> diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
> index d7e987baf127..3799b6c6c3b8 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -445,6 +445,52 @@ int ima_file_check(struct file *file, int mask)
>  }
>  EXPORT_SYMBOL_GPL(ima_file_check);
>  
> +/**
> + * ima_file_hash - return the stored measurement if a file has been hashed.
> + * @file: pointer to the file
> + * @buf: buffer in which to store the hash
> + * @buf_size: length of the buffer
> + *
> + * On success, return the hash algorithm (as defined in the enum hash_algo).
> + * If buf is not NULL, this function also outputs the hash into buf.

As of Linux 5.4.y, IMA support for appended file signatures was added.
 Should we indicate that the file hash returned is based on the entire
file, including the appended signature?

Mimi


> + * If the hash is larger than buf_size, then only buf_size bytes will be copied.
> + * It generally just makes sense to pass a buffer capable of holding the largest
> + * possible hash: IMA_MAX_DIGEST_SIZE
> + *
> + * If IMA is disabled or if no measurement is available, return -EOPNOTSUPP.
> + * If the parameters are incorrect, return -EINVAL.
> + */
> +int ima_file_hash(struct file *file, char *buf, size_t buf_size)
> +{
> +	struct inode *inode;
> +	struct integrity_iint_cache *iint;
> +	int hash_algo;
> +
> +	if (!file)
> +		return -EINVAL;
> +
> +	if (!ima_policy_flag)
> +		return -EOPNOTSUPP;
> +
> +	inode = file_inode(file);
> +	iint = integrity_iint_find(inode);
> +	if (!iint)
> +		return -EOPNOTSUPP;
> +
> +	mutex_lock(&iint->mutex);
> +	if (buf) {
> +		size_t copied_size;
> +
> +		copied_size = min_t(size_t, iint->ima_hash->length, buf_size);
> +		memcpy(buf, iint->ima_hash->digest, copied_size);
> +	}
> +	hash_algo = iint->ima_hash->algo;
> +	mutex_unlock(&iint->mutex);
> +
> +	return hash_algo;
> +}
> +EXPORT_SYMBOL_GPL(ima_file_hash);
> +
>  /**
>   * ima_post_create_tmpfile - mark newly created tmpfile as new
>   * @file : newly created tmpfile

