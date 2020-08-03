Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29BF523A92C
	for <lists+linux-integrity@lfdr.de>; Mon,  3 Aug 2020 17:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgHCPLc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 3 Aug 2020 11:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725945AbgHCPLc (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 3 Aug 2020 11:11:32 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3FAC06174A;
        Mon,  3 Aug 2020 08:11:31 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id g26so35448487qka.3;
        Mon, 03 Aug 2020 08:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=V9lxBRsOstdXlZkICHBWAGNuwpXB0sWYaxMGJTYpWoI=;
        b=SW5VZrYNoWIOMx7PSamySgiGwnjoGxhPpOBrUsVR8GSeNi9vcCEI4YFBbMOsPjbnY7
         0l66Z3h6idmvMlbRksuZkShTuYYzS64viJwKaFEVjB4N9vn2UwSczOxOxIzxNhoM/XCx
         m1AIbcnPM8NEu7D0d4Ns5LU9yus8/owF8uAL4vSPl2Kg6mOyoA1GeI2ZDkjVRwElyEDT
         HblOYYY2vnIjSVVg3ogI7ISGhnoDWi4tWxDCrGtlAJOsBP74sd9IUGXM1KZ94GPptX2U
         U6CpsT0dodTltrHlv55iZVuIYixAWSfdQTnN/nHusIUdh+zXJaHe4Sv3Ganyh7WJ2uJS
         F9dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=V9lxBRsOstdXlZkICHBWAGNuwpXB0sWYaxMGJTYpWoI=;
        b=SlTpLqLXhUIubeM2KkH4BjPkBkJ572AwBjj0gfkPd7g9JHp+QUllZ+o8PVMlAmsdn/
         pZyYLXkp24J0sQzcJ5swKZ4SbnBAAv4Dh4Rjiq+vdh0pNxzQgmJe+A/sWlEQCRuHrkEh
         V6uahCp72HlfszFJKr9I19/vhSM0axFXNkQ/Nd+fyzW+mTXaXxVJx5o9xw1R42acde/q
         NCIdCRjUJYM6H41sdzcHonWETKqSDk7rivbRlJe4Rg//Ybnj8BOx9ysQyX2gBeAXyaO2
         MqkJhx+865KbOlm3w/4kKbDFd1GUu1CsoEtFAK7uBw0v7lIqCT8Q3yozOrcXbjpfHF4x
         Nz4w==
X-Gm-Message-State: AOAM531HV5YFSV1UzE+pd+M7Ns6zoc1IkVPl9P5hTAIlt48+ns8YtfUr
        WgtX6Py1UUeFcszoLadGt/IsFnbEqrU=
X-Google-Smtp-Source: ABdhPJxL1iKL011VE6qW3zK7vahf9MdK2ozbhfkg0ZZNn6ivaMvrFFJUWH7bu2moOX6zdffQ/UNW9A==
X-Received: by 2002:a05:620a:1325:: with SMTP id p5mr17017968qkj.357.1596467488193;
        Mon, 03 Aug 2020 08:11:28 -0700 (PDT)
Received: from [192.168.1.190] (pool-96-244-118-111.bltmmd.fios.verizon.net. [96.244.118.111])
        by smtp.gmail.com with ESMTPSA id 65sm18143082qkn.103.2020.08.03.08.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 08:11:26 -0700 (PDT)
Subject: Re: [PATCH v5 3/4] LSM: Define SELinux function to measure state and
 policy
To:     Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        zohar@linux.ibm.com, casey@schaufler-ca.com
Cc:     tyhicks@linux.microsoft.com, sashal@kernel.org, jmorris@namei.org,
        linux-integrity@vger.kernel.org, selinux@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200730034724.3298-1-nramas@linux.microsoft.com>
 <20200730034724.3298-4-nramas@linux.microsoft.com>
From:   Stephen Smalley <stephen.smalley.work@gmail.com>
Message-ID: <dfd6f9c8-d62a-d278-9b0e-6b1f5ad03d3e@gmail.com>
Date:   Mon, 3 Aug 2020 11:11:24 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200730034724.3298-4-nramas@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 7/29/20 11:47 PM, Lakshmi Ramasubramanian wrote:

> SELinux configuration and policy are some of the critical data for this
> security module that needs to be measured. This measurement can be used
> by an attestation service, for instance, to verify if the configuration
> and policies have been setup correctly and that they haven't been tampered
> with at runtime.
>
> Measure SELinux configuration, policy capabilities settings, and the
> loaded policy by calling the IMA hooks ima_measure_lsm_state() and
> ima_measure_lsm_policy() respectively.
>
> Sample measurement of SELinux state and hash of the policy:
>
> 10 e32e...5ac3 ima-buf sha256:86e8...4594 selinux-state-1595389364:287899386 696e697469616c697a65643d313b656e61626c65643d313b656e666f7263696e673d303b636865636b72657170726f743d313b6e6574776f726b5f706565725f636f6e74726f6c733d313b6f70656e5f7065726d733d313b657874656e6465645f736f636b65745f636c6173733d313b616c776179735f636865636b5f6e6574776f726b3d303b6367726f75705f7365636c6162656c3d313b6e6e705f6e6f737569645f7472616e736974696f6e3d313b67656e66735f7365636c6162656c5f73796d6c696e6b733d303
> 10 f4a7...9408 ima-ng sha256:8d1d...1834 selinux-policy-hash-1595389353:863934271
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
>    grep -m 1 "selinux-policy-hash" /sys/kernel/security/integrity/ima/ascii_runtime_measurements | cut -d' ' -f 4
>
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Suggested-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Reported-by: kernel test robot <lkp@intel.com> # error: implicit declaration of function 'vfree'
> Reported-by: kernel test robot <lkp@intel.com> # error: implicit declaration of function 'crypto_alloc_shash'
> Reported-by: kernel test robot <lkp@intel.com> # sparse: symbol 'security_read_selinux_policy' was not declared. Should it be static?

Possibly I'm missing something but with these patches applied on top of 
next-integrity, and the following lines added to /etc/ima/ima-policy:

measure func=LSM_STATE template=ima-buf
measure func=LSM_POLICY

I still don't get the selinux-state or selinux-policy-hash entries in 
the ascii_runtime_measurements file.  No errors during loading of the 
ima policy as far as I can see.


