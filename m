Return-Path: <linux-integrity+bounces-1090-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4846E84D89D
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Feb 2024 04:22:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04A7C286F97
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Feb 2024 03:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC967328B1;
	Thu,  8 Feb 2024 03:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dJSBc1HI"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E821DA44
	for <linux-integrity@vger.kernel.org>; Thu,  8 Feb 2024 03:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707362330; cv=none; b=V2UR7axx5erCHRpmItt/4wgLLeTPk+ESr66vn3kSbWyMUNf3suEMBqXWlIpbf8jWKIqBfT64L5V7nYWV+BE6SGLk9EFf+mchGk7yfu6agSlx4L+mqaj/v/Lc3MQoXxDHhHbN9qzcOpZJLwtbnOUMsem/2Aln6u7hVQP0Xyfl0ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707362330; c=relaxed/simple;
	bh=MJmgTQ/Z+N83kdaNSKZw8l5C67PPLjsvryWXsYHw4W4=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=IqWVmfcrRyMYtEjUBQzxma6pSTrJbeSofK0ZbPQ2TDZD5TG/FByJiyG20do5o9yPnTMhxios3slQ+Zyz6hDjfUn2lOJWvvhZP8CuJrt0VF9PpxYzPw1wLhppF76WjfBRRQ5qb3VvZC8cDmEv1MOxCWWXjX1B2fItfVXGBRj47LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dJSBc1HI; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-7d2940ad0e1so632549241.1
        for <linux-integrity@vger.kernel.org>; Wed, 07 Feb 2024 19:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707362325; x=1707967125; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=rHdU2RZz6m9RtlvtgEcA8+RigKqt3SBGaLQIaKub/WU=;
        b=dJSBc1HIFA2rm/oSzAExowCXLr5sPUCJzOuHjlgJSmMWQ6G/AMp+CgaXRN0j25Yb5X
         DoAHirarYpnmzssFa6d0rWqoC7H9ZGnZSaglq3eH0sXu4oNZGgR89EjxB0AUM64a9mbe
         yaJi//tJI3YmQGFG9JFjGG1MdM+vMq8atrSJB9OAPw0t6BslKSZjKHBkO4D0fVdNaq99
         22veuVxM6m4eK6YlBeLUzXcZ5QkU6bFzHey1Gt5ZmSMY76GXYcDtnHToocWGDSgPYXHr
         +Fva2xyc1eOK/Ks9CvWmZE93Pb2dSP8inCOxtLg2y0IzdPkTxNgz9SPSv8IzsDeNxiBK
         Ffvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707362325; x=1707967125;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rHdU2RZz6m9RtlvtgEcA8+RigKqt3SBGaLQIaKub/WU=;
        b=clGupdKtS8tlNIBtd2Ts1Dx/TJbxmLu8uB1khDaEKKudrCffEegzCrfbn+UhW/0W3N
         CgJNwbaPeeRtugFsKHCXqjBMSQ6zyEhujIQHgWHzijpIVadoANc4ORHD1225o7sB/Te4
         23sVPit5992fuzMuV7AriADFajjx6e+ow4s2dROEYzO3PyhE6+S5VxAKhHHNNF1y2PHR
         3AasxkR7Mz6IMOTb8iXSab8+9+zHjce4DxPPF2uvEGe4Kuyg3H74cojZo763EEJtyx2m
         b0Te9FDx4aWuMF8pdAB+GqYzWGeeGkKCNeyEBzC7fyEJzHV74h2gsSPH0OPtuBZPzgtX
         fHxQ==
X-Gm-Message-State: AOJu0Yxn5qDJCPR/qjwzWJTi8iLp/4QZocp0i7woazHP81nmJrEfsoap
	Y6FP9Gj82CQgD3HTX3goS/AofRqLrf4qPY85/7kyiUkzzwpYPpFrpcMUi+OYWA==
X-Google-Smtp-Source: AGHT+IHvLQXcq02jdtXjiYB+EWO8RyH6kJBsuW0V4+EMflYCtSk02qVo7oOf/26kTUWhTj/jicMJag==
X-Received: by 2002:a67:e348:0:b0:46d:20a1:e884 with SMTP id s8-20020a67e348000000b0046d20a1e884mr5620089vsm.19.1707362325290;
        Wed, 07 Feb 2024 19:18:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUVF6nCVblYoyOFaQAXpPZtiMxlfIdAAnQaKHDAzvZsXMoIL9XGJ6mdlcyCxY8xHen+T7dhpf/k1PPwwCez2gmAS4UDsGdlcjx9SCzFdq3GuQxuAqrkuuwDrdGyrNVph28wbPuri/mH7r3mq7qxFoUV+65uvvR6gneV2kKvM324oHB+71gWoKRNNmE30IuzujhOf7GVrMKhmkJw7nLuwbXvQWs4fohpVlbbybADTwp6M1oWJ12iYXqLoXeyu9iUzocLZMzDuhUl42ekGP+RqvtaAYaJtwhvc/ryCNtk3DEDfof4aLrW7L0M9sdvd2IZQqiF/Nz6v9Ju4JZhCBMNOQUbtDK1V+YPZgtPd8ShImplEIbda2sGXxzmCQ489BptIpyAobl1phcETLwGVvPCZyJjYqIoWjW+ua37fLPP/iYJiQTvWfI5cKsMim8SSurVI15GlxH4ZcszJ/+Tbb7R2bouVwy4yJy8EA9IazHiEZfykUTqdAUVhh6jwunsQF12iV5r/2XxmuwDUy01AJMFVQ4gzjLQaZ2VggI7vnu7BI2ZBgDPyEiaddJ3VMD2dwJhCGs1/h0vx/lO7lttcnRvTT1ssfF7WqiDJBisTxb2Fx6q/wRHjtasUJ7XqyD5iNDZYWeSkxYsVAaZS1KyM8O3YVvNxIPoy72pLpUSccMJxyWOLarp9rc2NkeSsJwpukzr7ZU+gVAjmY8XKTruRDLuoYDSOAGH3BSlDXURd1bfhr8PbyvXr8OoHXvnPuwaC4290ZCNn60CE+jL1/PXnnBOwmL047tBJ8q517f3W+YRJOnHg+zkQQBh7nn49Nb2LfhzL8KcBp2zFOgPgMbXp2nGKFJaZb2bcAC6nfeqMe8VGCtYBv31LIDnIIzt/JAPZMHDNvLP3iOqhI3FQSS6w59WZxKw5laYqxvSixuirWTLq4pVZPorrqtB
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id w4-20020a0cf704000000b0068c89047955sm1189707qvn.112.2024.02.07.19.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 19:18:44 -0800 (PST)
Date: Wed, 07 Feb 2024 22:18:44 -0500
Message-ID: <77e42fa37a24378fbb4f19ee9a4d2e74@paul-moore.com>
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
Subject: Re: [PATCH v9 13/25] security: Introduce file_release hook
References: <20240115181809.885385-14-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240115181809.885385-14-roberto.sassu@huaweicloud.com>

On Jan 15, 2024 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> In preparation for moving IMA and EVM to the LSM infrastructure, introduce
> the file_release hook.
> 
> IMA calculates at file close the new digest of the file content and writes
> it to security.ima, so that appraisal at next file access succeeds.
> 
> An LSM could implement an exclusive access scheme for files, only allowing
> access to files that have no references.

Let's drop the above sentence as it is is a little vague and is causing
some concern with the VFS folks.  While I want to see the hooks explained
and documented in the code, I've never been a big fan of speculating
about potential future uses of the hook, that's dangerous IMO.

Otherwise this looks good.

Acked-by: Paul Moore <paul@paul-moore.com>

> The new hook cannot return an error and cannot cause the operation to be
> reverted.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> ---
>  fs/file_table.c               |  1 +
>  include/linux/lsm_hook_defs.h |  1 +
>  include/linux/security.h      |  4 ++++
>  security/security.c           | 11 +++++++++++
>  4 files changed, 17 insertions(+)

--
paul-moore.com

