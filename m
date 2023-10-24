Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6B0B7D4660
	for <lists+linux-integrity@lfdr.de>; Tue, 24 Oct 2023 05:53:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232481AbjJXDxM (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 Oct 2023 23:53:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232303AbjJXDwr (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Oct 2023 23:52:47 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7494D10C6
        for <linux-integrity@vger.kernel.org>; Mon, 23 Oct 2023 20:52:32 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-4197fa36b6aso23509821cf.3
        for <linux-integrity@vger.kernel.org>; Mon, 23 Oct 2023 20:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1698119551; x=1698724351; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qf06v0uPyEibN6HVL4g78GrmaDMN+Y6zqErrL4AHRpg=;
        b=LPSttgk7Qv+YzGWvLuwItsNg1cdw80wadMUUgFQnJQh1lLcRxguvT8dpaBb9zkDHeb
         S1u+ySEcWIXHFfsbzopRwYX83zdwR054lNJplS59qgJGOKnhfouIBAa9k7Tch4IDIqgW
         6DTNjUsOYIJq4sVigcipZdCLuVTv+/hNo3E69ObyRNXPW/eOXJT5uHRgO+WWfwsp73cY
         XH73yHsmO5ZuyFq+HzTv9SLOhpf+9irJ1aKzUCPoENDEQrTf38jFCJjcGOUNRqui160E
         5ODb46TPq3MgBIag8VMrFSW5I5Ofz9Alj7yoo2yyujJ8uKs6HZshqb83wQjtlzmAMPBH
         VQNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698119551; x=1698724351;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qf06v0uPyEibN6HVL4g78GrmaDMN+Y6zqErrL4AHRpg=;
        b=rRJ8r/ExCYNIrp/biW0KKZlpYHLSkPGT1bsBYK5RnsGIk0v3v/gtf4lmcKVN1tLucN
         jmClGVE9YKpyWAegct8Kte+d97Q329r/wDpFPKE4QMwiqYOLUGbpb+QkLHy0L/+U7pFh
         wOqauqoq/6EzmxgwU/1c/Fqdq/ShX1jSH78LnbKU6EDkg14jFfgaT2f8eWy/QSHPQIcS
         +f4vm4Vw4FmHrXRy6+xUKPETsoTTmcfLF3IjQv3BgyBW2rLlSbCIl+4Ea+feaj58uMiY
         U9Z7uM1XxhUExS+Nx4bmu9FlhtmXypDwChLTaCBXLEXyy/Rj0ZnFSyi0tDcmADi/Ds1y
         Qo4g==
X-Gm-Message-State: AOJu0YxJpjD3ejWzSQIaWsQPS7tPHzhtMkwrJwT4MJJrietDhJKXeMfB
        eqqDMfuXXjgvY4UQuDmIhDK/
X-Google-Smtp-Source: AGHT+IGouATwOYXmK2YwrFbZyHQ9JLHk3FA04Mh6g6shppq2ZH5U7Zjd9ZU0vWlK7itlmdw9ByftTg==
X-Received: by 2002:a0c:aa11:0:b0:66d:63ff:80ab with SMTP id d17-20020a0caa11000000b0066d63ff80abmr7949580qvb.7.1698119551260;
        Mon, 23 Oct 2023 20:52:31 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id lg8-20020a056214548800b0066d05ed3778sm3363056qvb.56.2023.10.23.20.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 20:52:30 -0700 (PDT)
Date:   Mon, 23 Oct 2023 23:52:30 -0400
Message-ID: <2121d9724f32ea5926574f9aba806b69.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Fan Wu <wufan@linux.microsoft.com>, corbet@lwn.net,
        zohar@linux.ibm.com, jmorris@namei.org, serge@hallyn.com,
        tytso@mit.edu, ebiggers@kernel.org, axboe@kernel.dk,
        agk@redhat.com, snitzer@kernel.org, eparis@redhat.com
Cc:     linux-doc@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@redhat.com, audit@vger.kernel.org,
        roberto.sassu@huawei.com, linux-kernel@vger.kernel.org,
        Fan Wu <wufan@linux.microsoft.com>
Subject: Re: [PATCH RFC v11 12/19] dm: add finalize hook to target_type
References: <1696457386-3010-13-git-send-email-wufan@linux.microsoft.com>
In-Reply-To: <1696457386-3010-13-git-send-email-wufan@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Oct  4, 2023 Fan Wu <wufan@linux.microsoft.com> wrote:
> 
> This patch adds a target finalize hook.
> 
> The hook is triggered just before activating an inactive table of a
> mapped device. If it returns an error the __bind get cancelled.
> 
> The dm-verity target will use this hook to attach the dm-verity's
> roothash metadata to the block_device struct of the mapped device.
> 
> Signed-off-by: Fan Wu <wufan@linux.microsoft.com>
> ---
> v1-v10:
>   + Not present
> ---
>  drivers/md/dm.c               | 12 ++++++++++++
>  include/linux/device-mapper.h |  7 +++++++
>  2 files changed, 19 insertions(+)

We need an ACK and confirmation from Alasdair and/or Mike that this
is the right approach.

> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 64a1f306c96c..3be9cc35306d 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -2239,6 +2239,18 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
>  		goto out;
>  	}
>  
> +	for (unsigned int i = 0; i < t->num_targets; i++) {
> +		struct dm_target *ti = dm_table_get_target(t, i);
> +
> +		if (ti->type->finalize) {
> +			ret = ti->type->finalize(ti);
> +			if (ret) {
> +				old_map = ERR_PTR(ret);
> +				goto out;
> +			}
> +		}
> +	}
> +
>  	old_map = rcu_dereference_protected(md->map, lockdep_is_held(&md->suspend_lock));
>  	rcu_assign_pointer(md->map, (void *)t);
>  	md->immutable_target_type = dm_table_get_immutable_target_type(t);
> diff --git a/include/linux/device-mapper.h b/include/linux/device-mapper.h
> index 69d0435c7ebb..4040e84a8ec7 100644
> --- a/include/linux/device-mapper.h
> +++ b/include/linux/device-mapper.h
> @@ -160,6 +160,12 @@ typedef int (*dm_dax_zero_page_range_fn)(struct dm_target *ti, pgoff_t pgoff,
>   */
>  typedef size_t (*dm_dax_recovery_write_fn)(struct dm_target *ti, pgoff_t pgoff,
>  		void *addr, size_t bytes, struct iov_iter *i);
> +/*
> + * Returns:
> + *  < 0 : error
> + *  = 0 : success
> + */
> +typedef int (*dm_finalize_fn) (struct dm_target *target);
>  
>  void dm_error(const char *message);
>  
> @@ -209,6 +215,7 @@ struct target_type {
>  	dm_dax_direct_access_fn direct_access;
>  	dm_dax_zero_page_range_fn dax_zero_page_range;
>  	dm_dax_recovery_write_fn dax_recovery_write;
> +	dm_finalize_fn finalize;
>  
>  	/* For internal device-mapper use. */
>  	struct list_head list;
> -- 
> 2.25.1

--
paul-moore.com
