Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B05A7138F97
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Jan 2020 11:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726163AbgAMKvE (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Jan 2020 05:51:04 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43779 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725992AbgAMKvE (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Jan 2020 05:51:04 -0500
Received: by mail-wr1-f68.google.com with SMTP id d16so8013769wre.10
        for <linux-integrity@vger.kernel.org>; Mon, 13 Jan 2020 02:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rX6hYkQTcPkxFSQTp22iI/GTbRzDTSn2mT2N78MPltg=;
        b=oKkpYKtvG22DswPrnQPe4mDphOZzPeWS9Fm/gBtPFXIi/eh1IzHY8X22AlrD5VKaYE
         s+qOTZJe21UPh7e2M2/VVXjI1lW86ypWRIgklVRlnZXV2m3TNbBYjdeCk1bOikndC3V+
         aTL2Zqv9kyPeC8epB3SLemTlwjlE2X2XmGN7A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rX6hYkQTcPkxFSQTp22iI/GTbRzDTSn2mT2N78MPltg=;
        b=UBrDQ/KO6YrV+rH2j7/BeclwX8npnOXYbLsyS0zjV9PEhqz3kB71t97Flds6T4X2YU
         9lBggz9FFUrVHCGAN0WqJ+WutrjGDlrhMj8nVaLJd8VuhcIKoNsZk8NpoqCEi1TjDZ4s
         bxPDRjIMFmd5QYD6MC7mSwBr3JQbRlNd8RXa0NBrx2gn95hUvBrfd7eM/2IwGF4pLmm2
         ju7FejCrloEh2d+q7MOwSidZy/ZjgsKIcIk3XNAnvKSXTobZH6vswNeeTPXNbA+xzWUa
         hUUpyltOeFL44MBZr2+Cp0RAXcVx85ZDb1wDG6rQCoAniRtMErT4lWNV6/0RZ3TjKEXl
         QgYw==
X-Gm-Message-State: APjAAAXgFS+0zaPDnOcgmff03Pe7wQbmRokbIHPakr1xZffkhIXO+s6e
        qjQ9EneddUYORfsXkH1M8RQaL9Fbz5pEJw==
X-Google-Smtp-Source: APXvYqzk/HkmF6+cavSIKEIJ+Fq8mnrnSFzOKUU4OvMZdAPLWjQsZPS2kwS1LaOaiSPQQo0ar0Br5A==
X-Received: by 2002:adf:ef8b:: with SMTP id d11mr12548851wro.45.1578912662627;
        Mon, 13 Jan 2020 02:51:02 -0800 (PST)
Received: from google.com ([2a00:79e0:42:204:8a21:ba0c:bb42:75ec])
        by smtp.gmail.com with ESMTPSA id s3sm13791867wmh.25.2020.01.13.02.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2020 02:51:02 -0800 (PST)
From:   KP Singh <kpsingh@chromium.org>
X-Google-Original-From: KP Singh <kpsingh>
Date:   Mon, 13 Jan 2020 11:51:00 +0100
To:     Florent Revest <revest@chromium.org>
Cc:     linux-integrity@vger.kernel.org, kpsingh@chromium.org,
        mjg59@google.com, zohar@linux.ibm.com, nramas@linux.microsoft.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Florent Revest <revest@google.com>
Subject: Re: [PATCH v3] ima: add the ability to query the cached hash of a
 given file
Message-ID: <20200113105100.GA31000@google.com>
References: <20200113094244.26678-1-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200113094244.26678-1-revest@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 13-Jan 10:42, Florent Revest wrote:
> From: Florent Revest <revest@google.com>
> 
> This allows other parts of the kernel (perhaps a stacked LSM allowing
> system monitoring, eg. the proposed KRSI LSM [1]) to retrieve the hash
> of a given file from IMA if it's present in the iint cache.
> 
> It's true that the existence of the hash means that it's also in the
> audit logs or in /sys/kernel/security/ima/ascii_runtime_measurements,
> but it can be difficult to pull that information out for every
> subsequent exec. This is especially true if a given host has been up
> for a long time and the file was first measured a long time ago.
> 
> It should be kept in mind that this function gives access to cached
> entries which can be removed, for instance on security_inode_free().
> 
> This is based on Peter Moody's patch:
>  https://sourceforge.net/p/linux-ima/mailman/message/33036180/
> 
> [1] https://lkml.org/lkml/2019/9/10/393
> 
> Signed-off-by: Florent Revest <revest@google.com>

Reviewed-by: KP Singh <kpsingh@chromium.org>

> ---
>  include/linux/ima.h               |  6 ++++
>  security/integrity/ima/ima_main.c | 49 +++++++++++++++++++++++++++++++
>  2 files changed, 55 insertions(+)
> 
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index f4644c54f648..1659217e9b60 100644
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
> index 2272c3255c7d..9fe949c6a530 100644
> --- a/security/integrity/ima/ima_main.c
> +++ b/security/integrity/ima/ima_main.c
> @@ -445,6 +445,55 @@ int ima_file_check(struct file *file, int mask)
>  }
>  EXPORT_SYMBOL_GPL(ima_file_check);
>  
> +/**
> + * ima_file_hash - return the stored measurement if a file has been hashed and
> + * is in the iint cache.
> + * @file: pointer to the file
> + * @buf: buffer in which to store the hash
> + * @buf_size: length of the buffer
> + *
> + * On success, return the hash algorithm (as defined in the enum hash_algo).
> + * If buf is not NULL, this function also outputs the hash into buf.
> + * If the hash is larger than buf_size, then only buf_size bytes will be copied.
> + * It generally just makes sense to pass a buffer capable of holding the largest
> + * possible hash: IMA_MAX_DIGEST_SIZE.
> + * The file hash returned is based on the entire file, including the appended
> + * signature.
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
> -- 
> 2.25.0.rc1.283.g88dfdc4193-goog
> 
