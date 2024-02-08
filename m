Return-Path: <linux-integrity+bounces-1087-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B8E84D886
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Feb 2024 04:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B086D2817E2
	for <lists+linux-integrity@lfdr.de>; Thu,  8 Feb 2024 03:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ACBF31A81;
	Thu,  8 Feb 2024 03:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YAdLnDRt"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA5828DC8
	for <linux-integrity@vger.kernel.org>; Thu,  8 Feb 2024 03:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707362326; cv=none; b=gqiK8vDkBS+Casv+mIBukEjGgQVK3W8KOWcQ56y6b/rcAduxnhQhMFN36tIEIrT1g9K9ojrd1pYfvA8NSmlydPaITvnUMH9o2wB7gHikNpbRPr44H0xPcxKFInPGO2dP1OcDhmgqJ/mzP0uZxyEF2n++2NW6yhljkNdO3scq75A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707362326; c=relaxed/simple;
	bh=uD1EwQymZvC306l+hibbHVba/gxJzxwEF5SMUsbwjiQ=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=JIPWQtukNW0UfwCJfPdYFBssyFx26MiiLdDJvN5gGMTHZp1n9FuPegq9j3PC4sKG4Jd3b6auSjx8JlvIRCa8dyxUW0JB7q09GeANNiOaFaIA5Yec+5RFaYNPuTgTQ2USMVHBeO1PkP8VBOCdkzC9ceJyvusYrBtuVolW9ZZfYvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YAdLnDRt; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-68c4fb9e7ccso6161566d6.3
        for <linux-integrity@vger.kernel.org>; Wed, 07 Feb 2024 19:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707362321; x=1707967121; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=si1duUiyzmO6RTjzgo+pEU+Lev5ar6TxvuDsNBuTLD4=;
        b=YAdLnDRtHi358i3VZEwlehsBGs3+b9AIHcfMVl7I8eHEr4aZs8/zKBAjevMYW2ooSC
         CJRpy1wvzCmBuwdlMsJ0ZwQfBSp6qsT2spVAI7dR1aw2BH7RHnXqWPNYg1VpLAOymQfL
         kANUEaMVJ5FOcdIQNJ62aL6WugWjMIq8Yff0MSN6YYiu0Gfc+MxapOOXZCZI4vW+qFgA
         ao1djKJfjzwdTfjHhD7N9zSzvIg4GDEhMXiAfBUk7/yhXS+FYI+OuIdRTgVG/03NP/9J
         UHeRtyi4t+Wgu7mNzcPUnHop1mkOemax22UCUMRz0jk/GI3/Qru+2o2xasfRg7Ct7lcX
         GQ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707362321; x=1707967121;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=si1duUiyzmO6RTjzgo+pEU+Lev5ar6TxvuDsNBuTLD4=;
        b=tymU9bvKi+SIskeuoE9TovmwDQXz+WVw52i8sSAgKnOh9PebzULopAULjKi0s2Nceq
         UWYlB2+q4tMng97bU7wUMBb2JR2cuVgMTDXdi4ZQHelUpa6nWikm8boxmTW4xMfBXagb
         tuicpqQlLEK9xeZnon6/p1YBMn2ZuU2jrjAB/qX2oiXJEwfnL15uye8w/khzBhGGz4f8
         fD2iEhCsMqcbLdbdw5DdsL4D7En5coVv+3y2ZWgpMhb1jaGLgb6Df1U+69NMhwYt1g72
         7BN8/kiMbrQRtPNIGHfdbeT2M8Z/fO3RiNcnjkIMq7kUdU84DKPJ2kthtPtmYSOtzvAB
         ORzA==
X-Gm-Message-State: AOJu0YzxWd91lsx7M3YSbJsAMyyju/0sHblJe2U4YglASkJRWfusq5Fy
	fT05gONnt0V65hw3ds7KBiX/X0Oh/Aitq7+Y3Pe/NFct9zeN+r/zbwI/XAw88A==
X-Google-Smtp-Source: AGHT+IFcLQDXFTXNBkVonqCBhwsT7rzcFQIF9qxUtzFczX0uVSEJqU58GUtTSRxkpZ8D8BjsvBGDeQ==
X-Received: by 2002:a05:6214:500a:b0:68c:ae6d:2959 with SMTP id jo10-20020a056214500a00b0068cae6d2959mr9739157qvb.26.1707362321417;
        Wed, 07 Feb 2024 19:18:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWBwV/j7yNS3pZJhR1yORNn4WYkIwtbqdmqdWteaOa6AuitJeyg/4AWnJSa20K0wpB6y2AMZM6DCThhl0JMEvK5UjxAAHVjSCQv3gaJkTNjnznvnpjT/nIuW4gnP8Zb5niSgHEskQJIlSUEQo5+HUXgL4msEqYyKRCJubqIOdSOv6ELIIAbCAQNA95QpLDzggZFyHC+DqtUCBk17UptW+F3DH4ernoafuXMegaciSbbqbckg0sXzPK1WfGSq05wgVpMVrhJgTRXpZtMaoQsQBL0pklrYTb6OixedxdgPIbx9ymiyopB57QWwz0qZdTtlvGsWoS/ql0EeTAxDnit++yKCWBjNAJQ3rpCY+EXgQX6bgUYqelEObwQC2Pj++/pUWPCkS9Qf2a6AGsDvvNXtgDa3RqYzP3EbuT1bTlfEZBg5l1GCigkM9nqaO7J4c6YZeN5kr/LzYes2o/ynSEK6DZK+SW2voXgxq3rTnRGDMitBci93vLyw1VntRniH37mZdBsSqfeWY3Vicl6bG/FwgHc6Gk2GCTRNRtgR+fIfQGk9Pl9BXS+YbBRDvQy30YYoBBbjY8nREHjgd1c3xrEtACoc5E9Yiz78ICCSHPhaCxH0g8juNcewLVKGKpxorwWpDojttO8k5mv5bqVz7pVa/O16DRxcj6QSY7WBckMTTZeugjFDjU67pC42iFNa/oI+Mb6bXX+4QUBywyk+GTgco9bVBjw7K88Bxf5IQbEJM+Pi0tb8aDZ0WlJ/wg/HZUTRaqy+LNSrsXtQSvGVTn0Ye8VEDNz+yvi2+WWiycoJJB51SCrsz50/53GL5uJbtd6oWATjFHzfV6gq4VW8uV7jwbBkotvVgNvco5gXomHGHzijkYjNZNaJtGwelaEqbpy0Akh2fUG29l6ftutfz0TiQOA+40seRRvWsZiWn5c/ATr+bUJ4szce2FpIeL7P0xDDOP2vu
 alrhHOKigBLxw=
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id pd8-20020a056214490800b0068caa42dbf3sm1186187qvb.91.2024.02.07.19.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 19:18:41 -0800 (PST)
Date: Wed, 07 Feb 2024 22:18:40 -0500
Message-ID: <a5760da4fddf640de5b5b80e5f8884c9@paul-moore.com>
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
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org, linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, keyrings@vger.kernel.org, selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>, Stefan Berger <stefanb@linux.ibm.com>
Subject: Re: [PATCH v9 9/25] security: Align inode_setattr hook definition with  EVM
References: <20240115181809.885385-10-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240115181809.885385-10-roberto.sassu@huaweicloud.com>

On Jan 15, 2024 Roberto Sassu <roberto.sassu@huaweicloud.com> wrote:
> 
> Add the idmap parameter to the definition, so that evm_inode_setattr() can
> be registered as this hook implementation.
> 
> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
> Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
> Acked-by: Casey Schaufler <casey@schaufler-ca.com>
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> ---
>  include/linux/lsm_hook_defs.h | 3 ++-
>  security/security.c           | 2 +-
>  security/selinux/hooks.c      | 3 ++-
>  security/smack/smack_lsm.c    | 4 +++-
>  4 files changed, 8 insertions(+), 4 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com>

--
paul-moore.com

