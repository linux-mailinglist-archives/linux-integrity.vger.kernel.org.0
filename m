Return-Path: <linux-integrity+bounces-4843-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5FDA38496
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 14:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CBC216443A
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Feb 2025 13:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD2021C9EF;
	Mon, 17 Feb 2025 13:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dXyhg6jn"
X-Original-To: linux-integrity@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA2D21C9EB
	for <linux-integrity@vger.kernel.org>; Mon, 17 Feb 2025 13:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739798794; cv=none; b=s+jvi7cFPN2nNNsXJBxpZYUvNN259W5vuHQzTptf8eIJ/zMTBtVyCXqpeM2nB5myRQIvjhT2G+SDAQT2h9L7RJHy9rlkECWF72Ng/VG/OX71CQAdQN0LgkmkMYTcPy1TB3hTIz+x/PNkTpVghZivD0zKToP9ha31gGGq+tcVSeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739798794; c=relaxed/simple;
	bh=DNxlrxo/fM/gH6fJhjPnt1bcYPA2MpIpizS9I76bqoQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nuGx7TQ70CS96OcUdb2QFZuQ2+Bv7c3oNuB9v2GJdj1QoYShD5q70fdQcdZkVO4L8dW9FFHB6bIKp3j44jYoABnK1+5Uv5alswoS9ZnRg7MPwfHXtIuVSDXEJMDB7jdBFeR7NVSJyf9MYX/a8rFPyu+t6y+VoaY/BlTs+QxaGa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dXyhg6jn; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5de38c3d2acso6818735a12.1
        for <linux-integrity@vger.kernel.org>; Mon, 17 Feb 2025 05:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1739798790; x=1740403590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r7ROHAK7yXG4Vb6b4hAz1EWLFsgJ5WjZ8YXHo26HyT0=;
        b=dXyhg6jnP1GG/AU0uF3KeZptsImRHKwO+k/Lskeb2JeqX+yZXCwdcF5ewt7v/7bsPk
         KaXtYvnN53UfZsdJQoZdaVpiOqRzR/7zsIvBevLJcFEVoH/BdROuK0oyv2fIWRyckrFp
         T6mWlcguCBSYeXGpCyVezsD3pcfq93/yYOlD1TA3DJgvM1e2cFhxABV4iaAtHMFERMLP
         tYEA4rWPau6Bp6sAswf3p9qy/r/FmimL3a+/UxUfoO+C8vEgP5k+1Ghpd3U/qta2+VgC
         PS+IDjojnx+L04SWxQf1K4VtCWeciJejh3hcFt5Z9cB+BTFHe3tNxkqx+Khk7H59ZgKx
         MwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739798790; x=1740403590;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r7ROHAK7yXG4Vb6b4hAz1EWLFsgJ5WjZ8YXHo26HyT0=;
        b=Hy7k4GlhKcK59+OXH+uMRT7XIEfKwxNLjJ6Fa2+6V5BA+w9yeO9WADeDAIiH3R1s/g
         Xf7l9lDPYrBSrs7ajCwwWHHEgv9w6Pf1E9Iw8PlUs23oed6m16tjmHHSG0ISPyWTFLTD
         fPl8Lsh1v9U04JHtTj+yMjepn3GHALafk7FNvRN1g+V1HZZKNh5qwNzE9FAtkpFkb+bs
         zcnASgDYx7R7PWj5qLBEX8NcPTj4tGVyndf8hgqTpPrqY4Bp+ZIDflOB+vBO0Zj8hvII
         C2UZK7lsD9w4UI1wN2kxpNu5YlUm1IZ/aqFpDDB0oURjHLmmPW/RYQ2YrvsXQII12pgW
         jw3Q==
X-Gm-Message-State: AOJu0YzEWnulXxiagH5uLPS9LfwVSJZb7n+x5Jjkl+WPOj48ZeaBv2Kq
	WWPo1f4F1A6Qw1ePC8Ps6gUET+JpPM6fQR33wl7uLbE02eQqRrSWysCYdl9Vm3g=
X-Gm-Gg: ASbGncvFEBNS0kKDTqH2hzKPk0qus0dOYD2YWyMhbeD6ASHK2vJyFG7st2gp//oawU6
	flv+TrGOsRwOWceOlTW3q15WBw3nnyA3rjaab1Ju8f6PESMK/i1I5PBAor/0b29mRmm8uKgmYtf
	HHBVE5LPzcaxCQtsl75bLKuzUoocjboTlRCd7ovjtnp+0oXczfkQhvR6x+0n551ONpb+pbNQUPV
	ja9TcEtRZeJhngwrxU2jVyf2QRKjwBpgVlqf9BzXnikPEQ3RYuLr55TfeEc0OanY75R3yVertQt
	hQpMteUGp1WkxgeRYI3Nhp6ZUFFaPbsGagK+/Ay9QANj38UviYvy+1C1VdTCvYlKdzfAS2bR6HY
	Z2BZdsBMLYoz7ruk+kYLNfIco/72buxxegjsoJNjT0sdvTvEgZ7Q=
X-Google-Smtp-Source: AGHT+IFprS7CS7mKbxQr4OZmOm4tdTlHWdD2l79TcBF9a94QmOW2xYYjoZu3wVFpVnlTl/3VVf6YHg==
X-Received: by 2002:a17:906:3290:b0:aba:f6ff:d38a with SMTP id a640c23a62f3a-abb70dce3bbmr948943666b.29.1739798790057;
        Mon, 17 Feb 2025 05:26:30 -0800 (PST)
Received: from ?IPV6:2003:ef:2f02:800:9162:c8ad:3b21:a399? (p200300ef2f0208009162c8ad3b21a399.dip0.t-ipconnect.de. [2003:ef:2f02:800:9162:c8ad:3b21:a399])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aba53376bccsm884875766b.116.2025.02.17.05.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Feb 2025 05:26:29 -0800 (PST)
Message-ID: <ea6764ea-db92-4f49-ba5a-650f62bcfa23@suse.com>
Date: Mon, 17 Feb 2025 14:26:28 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LTP] [PATCH 2/2] ima_selinux.sh: Detect SELinux before loading
 policy
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc: linux-integrity@vger.kernel.org
References: <20250217130839.2392666-1-pvorel@suse.cz>
 <20250217130839.2392666-2-pvorel@suse.cz>
Content-Language: en-US
From: Andrea Cervesato <andrea.cervesato@suse.com>
In-Reply-To: <20250217130839.2392666-2-pvorel@suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

On 2/17/25 14:08, Petr Vorel wrote:
> Adding TST_SETUP_EARLY to run test specific setup before loading policy.
> That allows to avoid loading IMA policy (which usually request reboot)
> if the test would be skipped anyway.
>
> Fixes: aac97cca96 ("ima_setup.sh: Allow to load predefined policy")
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   testcases/kernel/security/integrity/ima/tests/ima_selinux.sh | 3 ++-
>   testcases/kernel/security/integrity/ima/tests/ima_setup.sh   | 2 ++
>   2 files changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
> index 97c5d64ec5..577f7c2aca 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_selinux.sh
> @@ -13,9 +13,10 @@
>   
>   TST_NEEDS_CMDS="awk cut grep tail"
>   TST_CNT=2
> -TST_SETUP="setup"
>   TST_MIN_KVER="5.12"
>   
> +TST_SETUP_EARLY="setup"
> +
>   REQUIRED_POLICY_CONTENT='selinux.policy'
>   
>   setup()
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> index 1f1c267c4b..2a9f64978e 100644
> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> @@ -265,6 +265,8 @@ ima_setup()
>   		cd "$TST_MNTPOINT"
>   	fi
>   
> +	[ -n "$TST_SETUP_EARLY" ] && $TST_SETUP_EARLY
> +
Why not doing ". ima_setup.sh" at the end of setup() ?
>   	if ! verify_ima_policy; then
>   		load_ima_policy
>   	fi
Andrea

