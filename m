Return-Path: <linux-integrity+bounces-1099-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D5784D8E2
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Feb 2024 04:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E454CB2361A
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Feb 2024 03:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5C23C48F;
	Thu,  8 Feb 2024 03:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="acyS8Z/R"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0600B38391
	for <linux-integrity@vger.kernel.org>; Thu,  8 Feb 2024 03:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707362340; cv=none; b=NObNV5CHE0ijlmEUM38E3n/5OM3sh5nJWFpFeXnOHoAaLiS1h+cvgFN45lpq+F/DJdlJeBPQq0o51TgkIunEEQaregVyD+Frsd/uprmzxVI0V9YZbqNoEimNkzliOd9NfnU/ba4ER5bHsIFNLcV1QNJqzBfXl+P5M3P3QZPuu+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707362340; c=relaxed/simple;
	bh=GXUPBwjyTapvWjNtvBJBKoFYSFcsWJwH+eGj4SD5Q70=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=PiCnG1QaBo9EF1m7tp+lzccJBIBZKcIgYBe2hLn0h1sFjl/l5TJZZnlsX1HvlWOw5skdbOU9Soz4etl0dSpNem2Fh4/tAtroI/c847wXfTzY/pqq9HlKFKp/d+DKZC0q+BP0xBTRxAAu5YNQsIWGZ+kRaYyWu5fWpvo5MGUMYDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=acyS8Z/R; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-42a8b99eaf9so9489861cf.1
        for <linux-integrity@vger.kernel.org>; Wed, 07 Feb 2024 19:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707362334; x=1707967134; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=otFcps0stZB4weUc21xAn/KKbQgQbMJ9m7dxETe93ls=;
        b=acyS8Z/R0dIZh2wswvf1lWx1CspWtvaaeeEQnLFFQOYo/sptS81IGt/ltXbhMd2YQt
         Wq0LYq6i0fi3JLbcKsavndaGtsRcXGmRZx8nanIx+GVfARsqkIcyQShyM3cqMWVzm3h9
         mqAbuD5yYHRnSAOMbCUU6rgDFoqCUmlAw2czFl6mIjP0yrRP7yFYfq9PI/guxg/Nprs3
         1calN35kgJaeeFt2L8lj/eWXaopf+l4cToJ4gv//KlshW+RN8oNZjY2hC71vfkntzb10
         VzCew6kVKGJ4WSYW2zonsLMVtxlIjuNDCYSw81eaf84pkYnsrqvdmG15Z3jPILdScTQB
         GQzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707362334; x=1707967134;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=otFcps0stZB4weUc21xAn/KKbQgQbMJ9m7dxETe93ls=;
        b=p5DxiS/Z7AdK7QcGuvnPFXMz77BjXzWCImLwiA/aqpYjvAa7ZdbeswiBHE2izjbfnj
         cMaH+ybojyMmXLbl42WLAHKsv3FqrDd+1JKxGOtxa1a3LpgkEG1NfKjr7gt5YJQ2GMAf
         8u865hJScUUD/oI6aBXl/LqOQWTCGPQKQrztup4WvhEZgEwb6b8RW5xk5ak6drjSv88n
         XDzsW17qtQBFq15bkbPhzwkF4bjOq8c/LVa7REGjQd5yPH5pOVVyMHikf7sX7OIRiC45
         KDhAJBg5tQXhwgPEINULuTjEbnC8MIa32ZzSlj9yE+KCMLcLy+92eg9Aym6FjB/ttLmD
         tbvQ==
X-Gm-Message-State: AOJu0YwtpY06FTNqjDW9pcikMRVUSbI8z4gQjXUY5btgwiyA8BVdv5Rp
	lUqFzJgJcL7h1XhckbR3UGIyQtJTAXNXU0xzJGJJ5Kezyfp9RVsVO6tDlkUQlw==
X-Google-Smtp-Source: AGHT+IHFFz5/7Z/fdwdSa2FnRPas4NNB4AlHkLHQ9z8CPU0B/CZNZZq3CF3i+9gIvevWdPO2woWrDQ==
X-Received: by 2002:a05:622a:1792:b0:42c:b22:adc9 with SMTP id s18-20020a05622a179200b0042c0b22adc9mr8878842qtk.17.1707362334418;
        Wed, 07 Feb 2024 19:18:54 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX2SgqtyeXiRmraFSrm1+eGdFPAcILDt0E5xylLbpk4Pi8w1VK4WPvznufD108x+ZbDZUBSLiAYLOZ7ApTPH8K4po/ppreHz7WEwVjACdXoMMqO3PseGP/7ykN5TTJnpON+fslpE4zGsLYwOleANje1kGpMswXeREKcLFWgS75g6zxYbJqnUv/bi5JpCMW7IIzyqYHwG2gZNu+mVvjlrXLBog/82+mlPN7PM8KD/GpXhPv30Z/UZiQqMd8+GQTJUa7gd9OVrlr+8WhwM1ft0jOic2h2eT0T1pGZhzw57uy0oMm2n15wjGiBhhtuvkmyojFWSJ+778gaI76IHTlkxvQpGuu4lqGW1GxUwGWvx5VxpvHtSOy3mG7cdiLJ6yNJRzudwuY1LOYKCkyIZwSJC9eEs8uD2T7XYxKMjt68Vg2KYCyUY1+ZmhNd6WsdwayeEmpk2wDZ6vVLk6X6AeTDoiGmC0ToyJMVtPWV8znKT5cbhVddtpRHduAVJUZlAuaTl8wdb/Sl7VDzM0QDaHBQDEYi9sy9WdVRdIprMksHzvEsulbekjXa7Ttt3+jeiNuGZtyvAkK4jNUgF8gdJMSK4s0jtXEC3ezFJWihgleEqrvQ+ryyFaC333diwEVO6FrxH7uRjglu6iYshOeJPlxh0jrsMea+z7nslMo6YkAIFjIoSCbGVqb5Fl57uD9k/SipBrXILQHqQHCm7eQ+nocR6TkanmfRD4Ym+yMPzVVOO8WHqGtvXAqj/eIYT5pM9owBnDlHA//SjiC5nv4byvbO3AbMPXEJcaqNYJ8rr2H8qKyfWMhp37kWzmcSRBQRXS/RhK0sITI5lKrJGoOTE3S7sB3YfRIIKm5dp2YBDAcs+53VQcqmUdpJBPCcVVlIKJE95Id9/KYGLD2TKkZuZblCuTWhf+DuPCOeD62w/NVpXWNLveCMoIZ+
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id g3-20020ac84803000000b00429bd898838sm1062943qtq.47.2024.02.07.19.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 19:18:54 -0800 (PST)
Date: Wed, 07 Feb 2024 22:18:53 -0500
Message-ID: <4e96a5f2552a51e386f327689f64dae0@paul-moore.com>
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
Subject: Re: [PATCH v9 22/25] evm: Move to LSM infrastructure
References: <20240115181809.885385-23-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240115181809.885385-23-roberto.sassu@huaweicloud.com>

On Jan 15, 2024 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> As for IMA, move hardcoded EVM function calls from various places in the
> kernel to the LSM infrastructure, by introducing a new LSM named 'evm'
> (last and always enabled like 'ima'). The order in the Makefile ensures
> that 'evm' hooks are executed after 'ima' ones.

Let's add a comment to the Makefile about this so everyone knows not
to mix up the ordering, otherwise this looks good to me.

At some point I think we may want to introduce the concept of numerical
priorities to security_add_hooks() to add some additional granularity
beyond the LSM_ORDER_XXX priority, but that is something we can do
later.

Acked-by: Paul Moore <paul@paul-moore.com>

> Make EVM functions as static (except for evm_inode_init_security(), which
> is exported), and register them as hook implementations in init_evm_lsm().
> Also move the inline functions evm_inode_remove_acl(),
> evm_inode_post_remove_acl(), and evm_inode_post_set_acl() from the public
> evm.h header to evm_main.c.
> 
> Unlike before (see commit to move IMA to the LSM infrastructure),
> evm_inode_post_setattr(), evm_inode_post_set_acl(),
> evm_inode_post_remove_acl(), and evm_inode_post_removexattr() are not
> executed for private inodes.
> 
> Finally, add the LSM_ID_EVM case in lsm_list_modules_test.c
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  fs/attr.c                                     |   2 -
>  fs/posix_acl.c                                |   3 -
>  fs/xattr.c                                    |   2 -
>  include/linux/evm.h                           | 113 -----------------
>  include/uapi/linux/lsm.h                      |   1 +
>  security/integrity/evm/evm_main.c             | 118 +++++++++++++++---
>  security/security.c                           |  43 ++-----
>  .../selftests/lsm/lsm_list_modules_test.c     |   3 +
>  8 files changed, 116 insertions(+), 169 deletions(-)

--
paul-moore.com

