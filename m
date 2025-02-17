Return-Path: <linux-integrity+bounces-4842-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43B4BA38468
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 14:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 944B11898BEC
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 13:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 816B921C19E;
	Mon, 17 Feb 2025 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="TzucsPRV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DCB21C192
	for <linux-integrity@vger.kernel.org>; Mon, 17 Feb 2025 13:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739798170; cv=none; b=mN56FBubt2aJ46Mo6lD0HuXBsMCyc986dh/jqDZhx7t1Df3Q/xjPnp1yLcamKhsiMC/hqvKJ2Cp0Zq93i1LfnjWlYSkbqcFLkCKdIwmzmee056+i2DeyJGzqYPCc7iVLGIFYN0NOYS6wuuPN3jlxH4h6+FKuYWvGJX+hRhmsyq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739798170; c=relaxed/simple;
	bh=BWrd0EBB+VzD+V3Yv4/R8WXQXKQ+uc7HKptzA+UanHg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mof4/Y8HD6MjeU3XJO4RWFrOcCcYiHvygXl/oxw/YXTr4XdqwXX5hkKP7mGmD7pZuITLht5FjMGhCE/VK/Te1KHfn9LmO3pWPXIlaPoTTJLppss1IWSZeXdPxggAUzM6hHxToSWIZLLJ76wrhT/cVTcp2BoWplBa90t8dtN3pu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=TzucsPRV; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5dc89df7eccso7960511a12.3
        for <linux-integrity@vger.kernel.org>; Mon, 17 Feb 2025 05:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739798166; x=1740402966; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=633yEiwb0ZImCydcK293f789q+xD+CAtlXEq4SPAfcI=;
        b=TzucsPRVK7wZeM8rn9/1kKiLwomyUhqqrm62oqZp8jUlObI8I/6kD99LA+saIYJjvO
         wFVWgLF1F4PqPbgOZan1hJVaybtQFhvLPl1viKvZC/3SKlpF/pO6sjn9u4lFK+Lb3xtb
         NP5HQ99e2rB34ZJmHYtCa3weyR3doX5LMPV5jYnqC91plx8VSx5R884DnRNMBlzTW06+
         WH+RnTpFJk81Q8f2blXf8xJcW4X5CO0rR9UThpg4BAQWEW6+kKvLHeB88ZGA7jU6E4CU
         uygtr477p9r0FF2ib3tHC467PDVIvEK06nJPE014j34RBHIDcYigXfJ16WbVwu1fGvnt
         jpfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739798166; x=1740402966;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=633yEiwb0ZImCydcK293f789q+xD+CAtlXEq4SPAfcI=;
        b=V/ZqrfcoOwcVmshrFYOplpCBTkZeo6NTfInaKh8QpfFOs0I9mh/iEVvBxDbtV8CuUB
         zWjojVovfaCQjSW4SNECe/VPNVHf8T8dN3/a8mvftobbYn/2kQk3zKnT7kpJv+5OOjl3
         Md+si1/7UX/R2iCJh6pHW056uxAKexShsYngKJx/eNAhzG8wW6yfSwZLqO26V+zUdgjy
         s8bqlO81Izs1siaKqddqnWKoVf1pBVv3ql/3vvdx6zaBcPo72HN89JeNiqq9x9nkEjyR
         d3WiSVHNL55mxoAXvpp/IDjhSKtC99k4vMsQrBgYxhdqPDOgnFmpef14OjS/rcdKqYLL
         YjWg==
X-Gm-Message-State: AOJu0YwVgBC0EWihLN1NCNRMq7t/pqwD1qWZs+xn0+/Gp56VMkC8Wlnq
	FFhetP506/7biZCOJ/32x2pBzi8GLnNsH6TFmeluEbvqaqiC6fsV1kmFQzQIe1c=
X-Gm-Gg: ASbGncu3bAVkEEcu+LAHGcqrfukQo06ttETQzsTwJdnIxXIok21T3BQoSuyS9XsVROM
	swe2cazONHk6sBPiDfQCQgVAd1qcOSVwIuYFRz2LAsSBF7FZ5BHL0ziXNHufH1h1ecx0yqng96R
	9Tf0ECe+aS1XUt/YDOw8UgHSqOyVmg8N29DPl9uTgC56deNTJjRbTfQiGaPQuYz2gJ6gu3yv+5g
	jXb9d9fmK1BeuxdjedkwDT6RTuG8URYlWtr9CfgZcMTkKWSF58RohKqSmbdakbU9rnNAsrSFTsd
	8Lw53LpTwKnvg4pbrfUX6FW6oDvB2XkMXthG7xy+rgzNP1k/q7elYl99aFiI/hioKnT4yIBI6x4
	L7ZiG/ZYduSv3xpwW7ohs1F3OIdrD8uEZOYwnS6CFm1YT5DRa5DE=
X-Google-Smtp-Source: AGHT+IG/ixv4XfgO+GhXzBReL/4kbqvALq5gidmjoDKhsUheWYGjETOjdVEv2JjINY2oS0n51tyaXA==
X-Received: by 2002:a05:6402:2384:b0:5e0:36c0:7b00 with SMTP id 4fb4d7f45d1cf-5e036c07d5fmr8098648a12.31.1739798165875;
        Mon, 17 Feb 2025 05:16:05 -0800 (PST)
Received: from ?IPV6:2003:ef:2f02:800:9162:c8ad:3b21:a399? (p200300ef2f0208009162c8ad3b21a399.dip0.t-ipconnect.de. [2003:ef:2f02:800:9162:c8ad:3b21:a399])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5decdfe758asm7219295a12.0.2025.02.17.05.16.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 05:16:04 -0800 (PST)
Message-ID: <f8d6c3fd-7b1d-4d16-b034-a2b01f956870@suse.com>
Date: Mon, 17 Feb 2025 14:16:04 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LTP] [PATCH 1/2] tst_security.sh: Fix SELinux detection
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org
References: <20250217130839.2392666-1-pvorel@suse.cz>
Content-Language: en-US
From: Andrea Cervesato <andrea.cervesato@suse.com>
In-Reply-To: <20250217130839.2392666-1-pvorel@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 2/17/25 14:08, Petr Vorel wrote:
> Some SLES15 versions create /selinux directory which fails the detection
> if SELinux is actually not enabled. Therefore detect if directory
> actually contains the 'enforce' file.
>
> Also drop /selinux directory detection and detect only /sys/fs/selinux,
> /sys/fs/selinux mount point was added in kernel 3.0 in commit
> 7a627e3b9a2b ("SELINUX: add /sys/fs/selinux mount point to put selinuxfs")
> 14 years is enough, kernel 3.0 is not even supported in current LTP and
> we don't even support /selinux in C API (tst_security.c).
>
> Fixes: e7b804df65 ("shell: Add tst_security.sh helper")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   testcases/lib/tst_security.sh | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/testcases/lib/tst_security.sh b/testcases/lib/tst_security.sh
> index 05640234ea..356c28fc73 100644
> --- a/testcases/lib/tst_security.sh
> +++ b/testcases/lib/tst_security.sh
> @@ -127,8 +127,7 @@ tst_get_selinux_dir()
>   {
>   	local dir="/sys/fs/selinux"
>   
> -	[ -d "$dir" ] || dir="/selinux"
> -	[ -d "$dir" ] && echo "$dir"
> +	[ -f "$dir/enforce" ] && echo "$dir"
>   }
>   
>   # Get SELinux enforce file path

