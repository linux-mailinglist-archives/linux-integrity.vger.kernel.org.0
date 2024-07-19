Return-Path: <linux-integrity+bounces-3196-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D541937253
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jul 2024 04:09:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE101C20A57
	for <lists+linux-integrity@lfdr.de>; Fri, 19 Jul 2024 02:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74774174C;
	Fri, 19 Jul 2024 02:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="T/WZXoB/"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3A4537703
	for <linux-integrity@vger.kernel.org>; Fri, 19 Jul 2024 02:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721354890; cv=none; b=qjJwSJNLFs0zPwyL3lGaJ2YnzQ0EbTWgyl05Jx8vwUXm99mHYt+zimDx24g4f39BcAoNvrr506vZemn8CA2HL9rprvzylL4njH84QwzR3Iq3Q4WRGMIZKWLVDHqCYJnweCNjV6VzsJnKP7ygFIHk42X6CeCk/MWBs2AIu4iRvX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721354890; c=relaxed/simple;
	bh=K3kRa8M3XjJ6TYCBzNSI7QLaEzBmwYjbaWzmaybCoBA=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=NmLbRAwUvdp7kRSIATRfd5f0Ioa6lgC6q98OZiim8JmuSmCRvvx+SMvqurQNH3cxMHTcQX9BQK7i9fQnT4wV0rSgjprI/FFtiBkmR61RalxSRWQjr9J02dJe/+S3Cu/cFRMVgX+ZQgZttM//0mOYBKnfH2xToh1FMLvHnvlEqjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=T/WZXoB/; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-79f190d8ebfso57885785a.3
        for <linux-integrity@vger.kernel.org>; Thu, 18 Jul 2024 19:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721354887; x=1721959687; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YDBm3QRwilAu+OHaz6Ln5e9Jy4Z5QvQg9nfn3ZsegWg=;
        b=T/WZXoB/Uk5dXKxdM91e+evI9UA50w4YJkvGfiR+KicDHnrBLsl7spyVjtojoh9j9e
         iCHR6bD5sAJXIlFsHuWrttE4dC2MAqvT4yuDWQZPVv7gEZ/5uQZ3WDmZk4H48ucmH/t4
         QwJoSBjQSGvWGH4pP8QEdzEuAKxqiFhgPcNj9zgMfo6F8VfgYoykQIn6mp7KxBuI3AOc
         2eGFnFm63Pt7h3rk2pAvapCKTcjJtW5agpD0ZP9S2YrFdYKurghIoqCZEPU1+k33JGSy
         Lsi5Ag1JE2Zy1HnnsldPiHemkZ7W8W/zj+lwSZdOcqks7yVpZ5TlFdzmaXebJ0zB/30y
         LYcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721354887; x=1721959687;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YDBm3QRwilAu+OHaz6Ln5e9Jy4Z5QvQg9nfn3ZsegWg=;
        b=bSkpi27RrWG7lRme/yjCj4G7FvlAxhfP5OJXIhHHazYTt+oBKujMgYy8ZxwWobKE5A
         FqG/n781iieaCxOAaMw+/RCdcQ/0h9vFh5fc4hNoIDidhu4nCBLTg3pLCmyD6Tt6BxKl
         9z7Zu/U2jBh1DhK+WOw86HyQrxwW7m5kheTk7Vqmeq3gwW+jxnzN14OFNq3n5JU0G3jq
         f2d/dRbmIV2HwlcS+PE5gEePdBgV3W8CEjbR28uEtvD3Und72Zvl8Ij0js+CFI/f3XoV
         jYYTE+97Gj6otDwVvIkSE2O7x7BgW74xqrghJjTHwzZ8KJ/GL0Bagztrsbl3zyWwFtJt
         2tFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWupnZplUDF23vpcwI1fniw7nuxtOAEI0O5tc792hfmbNEv5kWTY0uizcXIPJ+K3IsDAN7JX7AtNjIBD5sce/YxyEVZvDNAma5MexpAxUce
X-Gm-Message-State: AOJu0YyX2h92G/9/oedUHfkZ7ThmDJ/j8R5Id4uK+I256KiezBeTc7NE
	yf1kHLYH7QU3IZm9au8fvSreNaBFCGFPrdxgsG5ca9qjtc/+lx/3jHdlQ9pzhQ==
X-Google-Smtp-Source: AGHT+IHJXqsEfMvaJ3I4voV7h0JmzEBLz/Y77YU9PWIwttNlLAz95UGh+qmMP8iEzkPgMVaZTYkx+Q==
X-Received: by 2002:a05:620a:4014:b0:79e:ff47:3307 with SMTP id af79cd13be357-7a1938c1fb6mr351466485a.8.1721354887484;
        Thu, 18 Jul 2024 19:08:07 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a198e9f7ccsm22476985a.0.2024.07.18.19.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 19:08:07 -0700 (PDT)
Date: Thu, 18 Jul 2024 22:08:06 -0400
Message-ID: <35bc63dac544edc75c25b8dc6c8c99d0@paul-moore.com>
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
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org, netdev@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org, apparmor@lists.ubuntu.com, selinux@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Brendan Jackman <jackmanb@chromium.org>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Kees Cook <keescook@chromium.org>, John Johansen <john.johansen@canonical.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>, Edward Cree <ecree.xilinx@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Trond Myklebust <trond.myklebust@hammerspace.com>, Anna Schumaker <anna@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v4 8/20] lsm: Refactor return value of LSM hook getprocattr
References: <20240711111908.3817636-9-xukuohai@huaweicloud.com>
In-Reply-To: <20240711111908.3817636-9-xukuohai@huaweicloud.com>

On Jul 11, 2024 Xu Kuohai <xukuohai@huaweicloud.com> wrote:
> 
> To be consistent with most LSM hooks, convert the return value of
> hook getprocattr to 0 or a negative error code.
> 
> Before:
> - Hook getprocattr returns length of value on success or a negative
>   error code on failure.
> 
> After:
> - Hook getprocattr returns 0 on success or a negative error code on
>   failure. An output parameter @len is introduced to hold the
>   length of value on success.
> 
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  fs/proc/base.c                |  5 ++++-
>  include/linux/lsm_hook_defs.h |  2 +-
>  include/linux/security.h      |  5 +++--
>  security/apparmor/lsm.c       |  7 +++++--
>  security/security.c           |  8 +++++---
>  security/selinux/hooks.c      | 16 +++++++++-------
>  security/smack/smack_lsm.c    | 11 ++++++-----
>  7 files changed, 33 insertions(+), 21 deletions(-)

The patch 07/20 comments also apply here.

--
paul-moore.com

