Return-Path: <linux-integrity+bounces-1097-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 831E384D8D4
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Feb 2024 04:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FFC3287648
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Feb 2024 03:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04D63A27E;
	Thu,  8 Feb 2024 03:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="J+ALAwZx"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868C0381A0
	for <linux-integrity@vger.kernel.org>; Thu,  8 Feb 2024 03:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707362338; cv=none; b=faTrM5+S5bB25W/282nHgz3UvHFFWXtycOi5bXbPcRRo2O/yZIXLK+WEMRzG8t0R3HOTo9DYM3DoDbPMguVidtVKK0Y5isdBpwEhAVls5uzzkATNfnXhtIy7o8knYhlAihAlqdjSgpOtqyB/P0CpHR/xsbvWqItQ5ONQ46nPfyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707362338; c=relaxed/simple;
	bh=37C8wHKkFtCgauXCSbJ0K0033CwclbsBYM6zu4EoMqQ=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=K6KhcqZrW3RlPbirwXx7Boe1BFFkVGOEmYwy5t3QMbIzE2i2alTftahkhKAKMQgIOvJ8HBy03voQTUNMqVlpH/5R6UgcvPUc33/p7xyGlxLNdNkV6uRQglyjaEBnDrzHP9iA5BKW3V+74/6wsi4zUs1T5Pq5xxSX33ctzC/nRlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=J+ALAwZx; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-429f53f0b0bso6494271cf.2
        for <linux-integrity@vger.kernel.org>; Wed, 07 Feb 2024 19:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707362332; x=1707967132; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5YYKKXwV8EnPDOLQo34T5zWPkOZ7s9lMeF+LE0Waxr4=;
        b=J+ALAwZxQ4d32VhV3+wyNiF8Hu7L77VOz5jdDjlBrYYYHvbIymH7PVzLANy+rxSUjI
         R4yQr7vFZNlsR0rW0birQIGjQ5Jjnuti7K8jO/tjz+Rs+obXQTi7N7Y5Fi6g5fj+5f/i
         7o8ndV76aPT3v3NGle8ot5rl43xcbG8+97ITY7Ff59Txjl/fvMu9Px/kcOiYEw3MeBb4
         3Li27zCri1MfT6Cxmic7DOeGiRpn3hFnmfeVZe+1GEzZDUBHzj9tGy8zWuWw2A48wuGQ
         sK1N1dZi+LK3fkbDXKM7FpFMLFLlCMGCYkV+LeQQK6a8hoepvFcOxw+t0I9OcSJEn//E
         /JhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707362332; x=1707967132;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5YYKKXwV8EnPDOLQo34T5zWPkOZ7s9lMeF+LE0Waxr4=;
        b=m4o1lI3XESymgSpa3ebKYo9lt0jkbfwxfusAUf2fwbX/RQv7577VoxERoPNy8DcJxA
         WoY7rLFx2irh8GMn4iOYjMJoFzKBgz8PGo7MUJnYZ8G/umqew07XLvoT7eP1P6SBllwq
         +5u7HdAvlalimsyJlYx5y8J+9NvMCS/1GYsRd9IIBo88WvFUB+gz1JxUNic098yzHeSj
         UW04hkiHhZOb6ys/Mszq4a0bXXAfaJBxdj9MHWoMmiBazG3Z1WI+3pAv55LE8b0inwVj
         0MoOPvd00pLfWNFrWaRdE+aDu9J5EWHNeOX9rrUckdUkTVd3adiXOVuCxEOdFo7jTvGj
         Lu1A==
X-Gm-Message-State: AOJu0YxFfN6AeZsL9dwkSXWqZ4klivVHhZCtmXqtcQzfWCYEVUsZq4rT
	AtSHaLY4nawzgX5ZOEx/NCr+0NkInE2NvwKt/vHEDkpoA7uNP2THQbf0hFbmFg==
X-Google-Smtp-Source: AGHT+IHeUg/nvLftCQhAVfMO5rcnWuzO5K8H+v6YgVFlbO+3nI9ayCgyjXt657JAkrlQfHXaHRsrMQ==
X-Received: by 2002:ac8:59c9:0:b0:42c:41b3:def2 with SMTP id f9-20020ac859c9000000b0042c41b3def2mr4604039qtf.29.1707362332481;
        Wed, 07 Feb 2024 19:18:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWjvnchhWUdKe0QMjauOwOdIRFUB/ZiUdGsODbJAILA5ioe4p3RsZZdz7wSWdLQUuJqW8RNrTbEybZvgNVywAvhnhX7/I95vAilFSSHW/Oy2dL1mAMSRMGJl7jModi1CMitibTT2h1KKlLKqLedU/Tqz4gBY4ah48VRk5a0ScKTA8xcPsyA5354aLpQM8rV2JE4oVeSZhJur6yb4Vi69/igUPa8ntw7KPZmoAWaDznFss3DYDVhoyEB4szn373SRTD/MaM8Nx/ITKDa3AKrCOnSgnUVvDWIgwu8YwjUviAhkcOjqpTRu7evvWTu9i9grBNO42D+1T0iB5pxTaY/np5a91xY9hJEt0rtpZAdckKDoxX2AUqL5TML/KuB/kftOHSU06XiFqKADEHz9+g7caqVOXpW24igOdf27aXFMXPXPneSpxdRcJHm4oL14UKPmcw7nITPIi46GZtXdUSYGsRxjPPSBSXnTn3KLZHbL+HhyMKAwa926UKNlwjTCXT0PO6JLsrZIkgV+2MzFUrrEV8oiKO2hqsW+ElPMcVsMPRDjX4k/OJrx07kfn08cYUonrR7PO7JqMv2N+OLjJHqOmOeN8Z7/wUZHbuh/vjb0Q8ePJyex93MddL/0BlAq/g6i4W4DeNsf6AWKhRJOMrkDMJLzFElKGw8ZPSntgpsra050qRyGaBsrlL5onrYN+GMarOD7KYV6CZz76cf7Aq7hcMaQcmYAczOcPe1OJuSoclU7S8agiIiLfgdXrRwOkEsFMGETszhSz7sBrvXf8jMUcAt/LVJKKZdUcvUQopm9BICyHPXs/I71FaAZ7gJyYRg9psJb2jaj5ZgTU67VD7W2UjVnF0DdpkXQl80pznBfBCAU49+rlnWervFf7PB7CcF7/MeKEWibqtNF4wOeycz4EwOiyCep4mCkhaB1hVbITt4/WhSd5RB
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id z8-20020ac87ca8000000b0042992b06012sm1076059qtv.2.2024.02.07.19.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 19:18:52 -0800 (PST)
Date: Wed, 07 Feb 2024 22:18:51 -0500
Message-ID: <70e3be2a7f9672a9b193ac2b240540b8@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Roberto Sassu <roberto.sassu@huaweicloud.com>, viro@zeniv.linux.org.uk, brauner@kernel.org, chuck.lever@oracle.com, jlayton@kernel.org, neilb@suse.de, kolga@netapp.com, Dai.Ngo@oracle.com, tom@talpey.com, jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, dhowells@redhat.com, jarkko@kernel.org, stephen.smalley.work@gmail.com, eparis@parisplace.org, casey@schaufler-ca.com, shuah@kernel.org, mic@digikod.net
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Subject: Re: [PATCH v9 20/25] ima: Move to LSM infrastructure
References: <20240115181809.885385-21-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240115181809.885385-21-roberto.sassu@huaweicloud.com>

On Jan 15, 2024 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> Move hardcoded IMA function calls (not appraisal-specific functions) from
> various places in the kernel to the LSM infrastructure, by introducing a
> new LSM named 'ima' (at the end of the LSM list and always enabled like
> 'integrity').
> 
> Having IMA before EVM in the Makefile is sufficient to preserve the
> relative order of the new 'ima' LSM in respect to the upcoming 'evm' LSM,
> and thus the order of IMA and EVM function calls as when they were
> hardcoded.
> 
> Make moved functions as static (except ima_post_key_create_or_update(),
> which is not in ima_main.c), and register them as implementation of the
> respective hooks in the new function init_ima_lsm().
> 
> Select CONFIG_SECURITY_PATH, to ensure that the path-based LSM hook
> path_post_mknod is always available and ima_post_path_mknod() is always
> executed to mark files as new, as before the move.
> 
> A slight difference is that IMA and EVM functions registered for the
> inode_post_setattr, inode_post_removexattr, path_post_mknod,
> inode_post_create_tmpfile, inode_post_set_acl and inode_post_remove_acl
> won't be executed for private inodes. Since those inodes are supposed to be
> fs-internal, they should not be of interest of IMA or EVM. The S_PRIVATE
> flag is used for anonymous inodes, hugetlbfs, reiserfs xattrs, XFS scrub
> and kernel-internal tmpfs files.
> 
> Conditionally register ima_post_key_create_or_update() if
> CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS is enabled. Also, conditionally register
> ima_kernel_module_request() if CONFIG_INTEGRITY_ASYMMETRIC_KEYS is enabled.
> 
> Finally, add the LSM_ID_IMA case in lsm_list_modules_test.c.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Acked-by: Chuck Lever <chuck.lever@oracle.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  fs/file_table.c                               |   2 -
>  fs/namei.c                                    |   6 -
>  fs/nfsd/vfs.c                                 |   7 --
>  fs/open.c                                     |   1 -
>  include/linux/ima.h                           | 104 ------------------
>  include/uapi/linux/lsm.h                      |   1 +
>  security/integrity/Makefile                   |   1 +
>  security/integrity/ima/Kconfig                |   1 +
>  security/integrity/ima/ima.h                  |   6 +
>  security/integrity/ima/ima_main.c             |  78 +++++++++----
>  security/integrity/integrity.h                |   1 +
>  security/keys/key.c                           |   9 +-
>  security/security.c                           |  63 ++---------
>  .../selftests/lsm/lsm_list_modules_test.c     |   3 +
>  14 files changed, 83 insertions(+), 200 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com

