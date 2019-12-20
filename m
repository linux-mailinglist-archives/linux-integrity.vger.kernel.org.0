Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADC701280DF
	for <lists+linux-integrity@lfdr.de>; Fri, 20 Dec 2019 17:47:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfLTQr5 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 20 Dec 2019 11:47:57 -0500
Received: from linux.microsoft.com ([13.77.154.182]:42394 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbfLTQr5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 20 Dec 2019 11:47:57 -0500
Received: from [10.137.112.111] (unknown [131.107.147.111])
        by linux.microsoft.com (Postfix) with ESMTPSA id 1B2412010C1D;
        Fri, 20 Dec 2019 08:47:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 1B2412010C1D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1576860476;
        bh=NIUGZ+fuf2FDsvapAJaWJ5cOfekjGTTUeUXSm26IsMw=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=mtjPX2bnsRQdsMZejTUMArtWQtbrzKQSj3yviq04WLFkhlLiFjJ6iBPCoSICOedm/
         POUBGuQZqYlrRqgttnRhWGUVb/KRAzqx6fV9yG+j+UrfyWE04xQbz6AfyGUw3KLKB+
         3MpjdcsPYnkSh7Uy8LtOW0gMH4qSQZ7xX5lH+i4I=
Subject: Re: [PATCH] ima: add the ability to query ima for the hash of a given
 file.
To:     Florent Revest <revest@chromium.org>,
        linux-integrity@vger.kernel.org
Cc:     kpsingh@chromium.org, mjg59@google.com, zohar@linux.ibm.com,
        linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Florent Revest <revest@google.com>
References: <20191220163136.25010-1-revest@chromium.org>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <8f4d9c4e-735d-8ba9-b84a-4f341030e0cf@linux.microsoft.com>
Date:   Fri, 20 Dec 2019 08:48:20 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191220163136.25010-1-revest@chromium.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 12/20/2019 8:31 AM, Florent Revest wrote:

>   
> +/**
> + * ima_file_hash - return the stored measurement if a file has been hashed.
> + * @file: pointer to the file
> + * @buf: buffer in which to store the hash
> + * @buf_size: length of the buffer
> + *
> + * On success, output the hash into buf and return the hash algorithm (as
> + * defined in the enum hash_algo).

> + * If the hash is larger than buf, then only size bytes will be copied. It
> + * generally just makes sense to pass a buffer capable of holding the largest
> + * possible hash: IMA_MAX_DIGEST_SIZE

If the given buffer is smaller than the hash length, wouldn't it be 
better to return the required size and a status indicating the buffer is 
not enough. The caller can then call back with the required buffer.

If the hash is truncated the caller may not know if the hash is partial 
or not.

> + *
> + * If IMA is disabled or if no measurement is available, return -EOPNOTSUPP.
> + * If the parameters are incorrect, return -EINVAL.
> + */
> +int ima_file_hash(struct file *file, char *buf, size_t buf_size)
> +{
> +	struct inode *inode;
> +	struct integrity_iint_cache *iint;
> +	size_t copied_size;
> +
> +	if (!file || !buf)
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
> +	copied_size = min_t(size_t, iint->ima_hash->length, buf_size);
> +	memcpy(buf, iint->ima_hash->digest, copied_size);
> +	mutex_unlock(&iint->mutex);
> +
> +	return iint->ima_hash->algo;

Should the hash algorithm be copied from iinit->ima_hash to a local 
variable while holding the mutex and that one returned?

I assume iinit->mutex  is taken to ensure iinit->ima_hash is not removed 
while this function is accessing it.

thanks,
  -lakshmi

