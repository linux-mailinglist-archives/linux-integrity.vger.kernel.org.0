Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF97C243E71
	for <lists+linux-integrity@lfdr.de>; Thu, 13 Aug 2020 19:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgHMRmn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 13 Aug 2020 13:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMRmm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 13 Aug 2020 13:42:42 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B29C061757;
        Thu, 13 Aug 2020 10:42:42 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id v1so1162702qvn.3;
        Thu, 13 Aug 2020 10:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=edsea6bQ5zXUVSUZDs0jIcxJxKWes/2OHbEIYo9gFg8=;
        b=OkEW6+U1d8ittfMnhMm6LTbWK/TofKCfZN5THOAR/5ixg+VXIOPannmlJ9xy+++WSs
         doRVENdXxfobbA/C2ltOo7+wyGM4lshkQUy9ltdHiXPLWeP5QyfIKqE34xyCE5yDBGcc
         J8Wo+mNo8fBy2y3DLIhEWoxU6E1qjDYvKhepxW8eeJio/QU5sMxmzu70wDC+G5X0eZ7f
         UQ5f78YSu/w38/Om46mL0EhgnFKK6XrEc6r7D4XTh1xU6bXetGqn2H92P5v3+ttu7Ghn
         TjPmG6WTcd0EoIFjc7w7wI7OoQsZ7eeUn75KBzBqoCjjt9/DOpONqsnMnS0NjOKYSZbt
         dNgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=edsea6bQ5zXUVSUZDs0jIcxJxKWes/2OHbEIYo9gFg8=;
        b=IwYSNigyJYLIhk2cEADDcnsLT+pql9RVbDHJawHv7e1Ch9re17YrGNMf8Uywuj0d0n
         JehlcV64zUDZlDKsH+w7F8IUp0dG8/eFRXzNan9vBs36DrmYrEMyY8dDnVe646Ac1AKd
         /O/PHSv6gKDW6BDdnyBnQqzSZ4SCqJu9hP+8pO/Cw1plKRASwE5Yv7EWEUeEMDt9wKmU
         Vhb7npFcy10DxlxPN51rhhqS4PVoasfIW3EHoj1xo2YHsgAG5yJWnS4W4LxaCLKYzuF5
         n4iem1ucg9uHW3K7AJsJpRfxeDjBxwMhMUFn4WfhCAnoREpwF32kK0I9aiMWVzGytFCV
         P7xQ==
X-Gm-Message-State: AOAM530UwZNLvGffFLKat+VicpKIREJzPUFbU8jC1yTUzbP0OVgHvjtP
        Gw3ytix46KbyY6d/PqLmFZ0=
X-Google-Smtp-Source: ABdhPJwJZHKhXz3ZAdrQAHXpJueeSr6wdckjie6kcf0SLr5f+NxuJacbfNMjuDfNMP1bU8t7zd8U7A==
X-Received: by 2002:ad4:470f:: with SMTP id k15mr5738488qvz.216.1597340561433;
        Thu, 13 Aug 2020 10:42:41 -0700 (PDT)
Received: from [192.168.1.190] (pool-68-134-6-11.bltmmd.fios.verizon.net. [68.134.6.11])
        by smtp.gmail.com with ESMTPSA id h20sm5956400qkk.79.2020.08.13.10.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Aug 2020 10:42:41 -0700 (PDT)
Subject: Re: [PATCH 2/2] SELinux: Measure state and hash of policy using IMA
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        zohar@linux.ibm.com, casey@schaufler-ca.com
Cc:     tyhicks@linux.microsoft.com, tusharsu@linux.microsoft.com,
        sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul Moore <paul@paul-moore.com>
References: <20200813170707.2659-1-nramas@linux.microsoft.com>
 <20200813170707.2659-3-nramas@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <5f738fd8-fe28-5358-b3d8-b671b45caa7f@gmail.com>
Date:   Thu, 13 Aug 2020 13:42:40 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813170707.2659-3-nramas@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 8/13/20 1:07 PM, Lakshmi Ramasubramanian wrote:

> SELinux configuration and policy are some of the critical data for this
> security module that needs to be measured. This measurement can be used
> by an attestation service, for instance, to verify if the configuration
> and policies have been setup correctly and that they haven't been tampered
> with at runtime.
>
> Measure SELinux configuration, policy capabilities settings, and the hash
> of the loaded policy by calling the IMA hook ima_measure_critical_data().
>
> Sample measurement of SELinux state and hash of the policy:
>
> 10 e32e...5ac3 ima-buf sha256:86e8...4594 selinux-state-1595389364:287899386 696e697469616c697a65643d313b656e61626c65643d313b656e666f7263696e673d303b636865636b72657170726f743d313b6e6574776f726b5f706565725f636f6e74726f6c733d313b6f70656e5f7065726d733d313b657874656e6465645f736f636b65745f636c6173733d313b616c776179735f636865636b5f6e6574776f726b3d303b6367726f75705f7365636c6162656c3d313b6e6e705f6e6f737569645f7472616e736974696f6e3d313b67656e66735f7365636c6162656c5f73796d6c696e6b733d303
> 10 9e81...0857 ima-buf sha256:4941...68fc selinux-policy-hash-1597335667:462051628 8d1d...1834
>
> To verify the measurement check the following:
>
> Execute the following command to extract the measured data
> from the IMA log for SELinux configuration (selinux-state).
>
>    grep -m 1 "selinux-state" /sys/kernel/security/integrity/ima/ascii_runtime_measurements | cut -d' ' -f 6 | xxd -r -p
>
> The output should be the list of key-value pairs. For example,
>   initialized=1;enabled=1;enforcing=0;checkreqprot=1;network_peer_controls=1;open_perms=1;extended_socket_class=1;always_check_network=0;cgroup_seclabel=1;nnp_nosuid_transition=1;genfs_seclabel_symlinks=0;
>
> To verify the measured data with the current SELinux state:
>
>   => enabled should be set to 1 if /sys/fs/selinux folder exists,
>      0 otherwise
>
> For other entries, compare the integer value in the files
>   => /sys/fs/selinux/enforce
>   => /sys/fs/selinux/checkreqprot
> And, each of the policy capabilities files under
>   => /sys/fs/selinux/policy_capabilities
>
> For selinux-policy-hash, the hash of SELinux policy is included
> in the IMA log entry.
>
> To verify the measured data with the current SELinux policy run
> the following commands and verify the output hash values match.
>
>    sha256sum /sys/fs/selinux/policy | cut -d' ' -f 1
>
>    grep -m 1 "selinux-policy-hash" /sys/kernel/security/integrity/ima/ascii_runtime_measurements | cut -d' ' -f 6
>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com> # error: implicit declaration of function 'vfree'
> Reported-by: kernel test robot <lkp@intel.com> # error: implicit declaration of function 'crypto_alloc_shash'
> Reported-by: kernel test robot <lkp@intel.com> # sparse: symbol 'security_read_selinux_policy' was not declared. Should it be static?
> ---
>   
> diff --git a/security/selinux/measure.c b/security/selinux/measure.c
> new file mode 100644
> index 000000000000..f21b7de4e2ae
> --- /dev/null
> +++ b/security/selinux/measure.c
> @@ -0,0 +1,204 @@
> +static int selinux_hash_buffer(void *buf, size_t buf_len,
> +			       void **buf_hash, int *buf_hash_len)
> +{
> +	struct crypto_shash *tfm;
> +	struct shash_desc *desc = NULL;
> +	void *digest = NULL;
> +	int desc_size;
> +	int digest_size;
> +	int ret = 0;
> +
> +	tfm = crypto_alloc_shash("sha256", 0, 0);
> +	if (IS_ERR(tfm))
> +		return PTR_ERR(tfm);
Can we make the algorithm selectable via kernel parameter and/or writing 
to a new selinuxfs node?
