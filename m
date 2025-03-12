Return-Path: <linux-integrity+bounces-5242-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17098A5D5F6
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 07:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32514175A26
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 06:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A622D1DE4E5;
	Wed, 12 Mar 2025 06:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bS60GNsj"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9651922F6;
	Wed, 12 Mar 2025 06:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741760513; cv=none; b=gnzjsU8cdt7X0CnI5ybvpJ61oN6W4qAugHaJ8zJEhQ3GK80JvFvKz/+O6bFniNjW9Pgg/akA9fFRu/nYGomhoAEe4MzZMiyoFBS5ZpGOf4BXkreoGrQdlt82hlD8sTRD2uNiG7l9r/2MsEsjSUr8XK1AeUoLbYf+X7S0u3hI7eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741760513; c=relaxed/simple;
	bh=FV9MCMpxrhX8pJZGObltZGLJfv74ruTHiIvW6OILA6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=orsQ+1dMF7UfhLKaw3yCS82bYBDZ/Ght5lezi9x+TLyXR5MoAZUbAccmToHaJeEE7aKOmvItM41+PZZ4m5EBRMf5mN/STLn5sbuG9ps0+Y+XQCrUlQBBAx3QxJlN4/iHXZp86yeqYdKXp6yLgOddISTpJg29FoeTo4qyf6uDS0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bS60GNsj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956D5C4CEE3;
	Wed, 12 Mar 2025 06:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741760513;
	bh=FV9MCMpxrhX8pJZGObltZGLJfv74ruTHiIvW6OILA6c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bS60GNsjv5nCxsqhRhvg9qDMkiimQH4tqQFWodYqo63Xj/AEa/6oQGsu1ea2vCv0I
	 /FuGcTJui8mWXTJMWAesT83wAtfcvesfHBS+VKB6aZNK6Eh+BkEAglAPYjePXED/Eh
	 a63USW4JE2rx6toGhJc4Pczqw/BXxhG16vX3FZTpPASxbByR3d68UtmqklkKb0D+7U
	 RzIsKB3TGqm42LTE8MsEqT6jg3xHkq4MSP3czGk5CSGT/KJWs/lHwNuAIsetoQpadj
	 yfOqMjomj5Z/sOZtHlHj6z8BvjPTwWE4rAYdSoS3/gM54UMflSTs7eb90Kr8OdYad9
	 oEvpn9p0odqZg==
Date: Wed, 12 Mar 2025 08:21:49 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, ardb@kernel.org, gourry@gourry.net,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	zhanjun@uniontech.com, niecheng1@uniontech.com,
	guanwentao@uniontech.com, Chen Linxuan <chenlinxuan@uniontech.com>
Subject: Re: [PATCH] tpm: eventlog: Declare mapping_size __maybe_unused
Message-ID: <Z9En_ZP4jZE0bkAF@kernel.org>
References: <10590A3A04DA011F+20250311120115.1451048-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10590A3A04DA011F+20250311120115.1451048-1-wangyuli@uniontech.com>

On Tue, Mar 11, 2025 at 08:01:15PM +0800, WangYuli wrote:
> Given that when CONFIG_EFI is not enabled, do_mapping is inherently
> false. Thus, the mapping_size variable is set but remains unused,
> resulting in a compilation warning.
> 
> Simply annotating it with __maybe_unused will resolve this compilation
> warning.
> 
> [ Fix follow errors with clang-19 when W=1e: ]
>   In file included from drivers/char/tpm/tpm1-cmd.c:21:
>   ./include/linux/tpm_eventlog.h:167:6: error: variable 'mapping_size' set but not used [-Werror,-Wunused-but-set-variable]
>     167 |         int mapping_size;
>         |             ^
>   1 error generated.
>   make[8]: *** [scripts/Makefile.build:207: drivers/char/tpm/tpm1-cmd.o] Error 1
>   make[8]: *** Waiting for unfinished jobs....
>   In file included from drivers/char/tpm/tpm-dev-common.c:19:
>   In file included from drivers/char/tpm/tpm.h:28:
>   ./include/linux/tpm_eventlog.h:167:6: error: variable 'mapping_size' set but not used [-Werror,-Wunused-but-set-variable]
>     167 |         int mapping_size;
>         |             ^
>   1 error generated.
>   make[8]: *** [scripts/Makefile.build:207: drivers/char/tpm/tpm-dev-common.o] Error 1
>   In file included from drivers/char/tpm/tpm2-cmd.c:14:
>   In file included from drivers/char/tpm/tpm.h:28:
>   ./include/linux/tpm_eventlog.h:167:6: error: variable 'mapping_size' set but not used [-Werror,-Wunused-but-set-variable]
>     167 |         int mapping_size;
>         |             ^
>   1 error generated.
>   In file included from drivers/char/tpm/tpm-dev.c:16:
>   In file included from drivers/char/tpm/tpm-dev.h:6:
>   In file included from drivers/char/tpm/tpm.h:28:
>   ./include/linux/tpm_eventlog.h:167:6: error: variable 'mapping_size' set but not used [-Werror,-Wunused-but-set-variable]
>     167 |         int mapping_size;
>         |             ^
>   1 error generated.
>   make[8]: *** [scripts/Makefile.build:207: drivers/char/tpm/tpm-dev.o] Error 1
>   make[8]: *** [scripts/Makefile.build:207: drivers/char/tpm/tpm2-cmd.o] Error 1
>   make[8]: *** [scripts/Makefile.build:207: drivers/char/tpm/tpmrm-dev.o] Error 1
>   In file included from drivers/char/tpm/tpm-chip.c:24:
>   ./include/linux/tpm_eventlog.h:167:6: error: variable 'mapping_size' set but not used [-Werror,-Wunused-but-set-variable]
>     167 |         int mapping_size;
>         |             ^
>   1 error generated.
>   In file included from drivers/char/tpm/tpm-sysfs.c:16:
>   In file included from drivers/char/tpm/tpm.h:28:
>   ./include/linux/tpm_eventlog.h:167:6: error: variable 'mapping_size' set but not used [-Werror,-Wunused-but-set-variable]
>     167 |         int mapping_size;
>         |             ^
>   1 error generated.
>   make[8]: *** [scripts/Makefile.build:207: drivers/char/tpm/tpm-chip.o] Error 1
>   make[8]: *** [scripts/Makefile.build:207: drivers/char/tpm/tpm-sysfs.o] Error 1
>   In file included from drivers/char/tpm/tpm2-sessions.c:71:
>   In file included from drivers/char/tpm/tpm.h:28:
>   ./include/linux/tpm_eventlog.h:167:6: error: variable 'mapping_size' set but not used [-Werror,-Wunused-but-set-variable]
>     167 |         int mapping_size;
>         |             ^
>   1 error generated.
>   make[8]: *** [scripts/Makefile.build:207: drivers/char/tpm/tpm2-sessions.o] Error 1
>   In file included from drivers/char/tpm/tpm-interface.c:28:
>   ./include/linux/tpm_eventlog.h:167:6: error: variable 'mapping_size' set but not used [-Werror,-Wunused-but-set-variable]
>     167 |         int mapping_size;
>         |             ^
>   1 error generated.
>   make[8]: *** [scripts/Makefile.build:207: drivers/char/tpm/tpm-interface.o] Error 1
>   In file included from drivers/char/tpm/tpm2-space.c:16:
>   In file included from drivers/char/tpm/tpm.h:28:
>   ./include/linux/tpm_eventlog.h:167:6: error: variable 'mapping_size' set but not used [-Werror,-Wunused-but-set-variable]
>     167 |         int mapping_size;
>         |             ^
>   1 error generated.
>   make[8]: *** [scripts/Makefile.build:207: drivers/char/tpm/tpm2-space.o] Error 1
>   In file included from drivers/char/tpm/eventlog/tpm1.c:24:
>   ./include/linux/tpm_eventlog.h:167:6: error: variable 'mapping_size' set but not used [-Werror,-Wunused-but-set-variable]
>     167 |         int mapping_size;
>         |             ^
>   1 error generated.
>   make[8]: *** [scripts/Makefile.build:207: drivers/char/tpm/eventlog/tpm1.o] Error 1
>   In file included from drivers/char/tpm/eventlog/common.c:20:
>   ./include/linux/tpm_eventlog.h:167:6: error: variable 'mapping_size' set but not used [-Werror,-Wunused-but-set-variable]
>     167 |         int mapping_size;
>         |             ^
>   1 error generated.
>   make[8]: *** [scripts/Makefile.build:207: drivers/char/tpm/eventlog/common.o] Error 1
>   In file included from drivers/char/tpm/eventlog/tpm2.c:20:
>   ./include/linux/tpm_eventlog.h:167:6: error: variable 'mapping_size' set but not used [-Werror,-Wunused-but-set-variable]
>     167 |         int mapping_size;
>         |             ^
>   1 error generated.
>   make[8]: *** [scripts/Makefile.build:207: drivers/char/tpm/eventlog/tpm2.o] Error 1
>   In file included from drivers/char/tpm/tpm_vtpm_proxy.c:24:
>   In file included from drivers/char/tpm/tpm.h:28:
>   ./include/linux/tpm_eventlog.h:167:6: error: variable 'mapping_size' set but not used [-Werror,-Wunused-but-set-variable]
>     167 |         int mapping_size;
>         |             ^
>   1 error generated.
>   make[8]: *** [scripts/Makefile.build:207: drivers/char/tpm/tpm_vtpm_proxy.o] Error 1
>   make[7]: *** [scripts/Makefile.build:465: drivers/char/tpm] Error 2
>   make[6]: *** [scripts/Makefile.build:465: drivers/char] Error 2
>   make[6]: *** Waiting for unfinished jobs....
> 
> Suggested-by: Chen Linxuan <chenlinxuan@uniontech.com>
> Signed-off-by: WangYuli <wangyuli@uniontech.com>
> ---
>  include/linux/tpm_eventlog.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/tpm_eventlog.h b/include/linux/tpm_eventlog.h
> index 891368e82558..7ca58b2e96e8 100644
> --- a/include/linux/tpm_eventlog.h
> +++ b/include/linux/tpm_eventlog.h
> @@ -164,7 +164,7 @@ static __always_inline u32 __calc_tpm2_event_size(struct tcg_pcr_event2_head *ev
>  	struct tcg_efi_specid_event_head *efispecid;
>  	struct tcg_event_field *event_field;
>  	void *mapping = NULL;
> -	int mapping_size;
> +	__maybe_unused int mapping_size;

NAK for the code change. Unused is not a problem.
Uninitialized is.

>  	void *marker;
>  	void *marker_start;
>  	u32 halg_size;
> -- 
> 2.47.2
> 
>
BR, Jarkko

