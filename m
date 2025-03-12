Return-Path: <linux-integrity+bounces-5241-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A35A5D5F4
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 07:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D54F7A596D
	for <lists+linux-integrity@lfdr.de>; Wed, 12 Mar 2025 06:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381661DFD86;
	Wed, 12 Mar 2025 06:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYZ7IeBV"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0E11DB551;
	Wed, 12 Mar 2025 06:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741760415; cv=none; b=fSHWuZ7jmLLIAshuezZkaprB34oCordK3RqgPS6O6W8Nn2MjEJteOthWtUVNCRlLeccKbNNS04ZFcC8ByCOr7r2CA/HFzlOjIqZespDTLfE4fH7E61qUAoqmBCyhZ2+Sjgb/+g9sOTs4bNAzwrw/tf0dsGkXO9ovdO4pnffKLPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741760415; c=relaxed/simple;
	bh=eJ64bZuGqF9RS/MD8GPBsOjrzRNYJWooDKbZZUu6ItQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZzYBlIWHN6ccNBpDZUsLHpOmHZLJSvD9Z0s4Sj8pbgLacNv0zM1TyDs8XnQKrx9vJeF1nxGq5QU/UFKFoSisrOhicnV/45bcpq8svqzOiADoJo1R9MYcEMe1DMuZ6BVqPTFZCSAMd0BRBcSWd3hcRJf7ZoFLwMT1/MfEU098OV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYZ7IeBV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286A0C4CEE3;
	Wed, 12 Mar 2025 06:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741760414;
	bh=eJ64bZuGqF9RS/MD8GPBsOjrzRNYJWooDKbZZUu6ItQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AYZ7IeBVBqixiG0kPRQ6MLIPkQoyG1BFBus4kl0Uy5tEjjfhy2VSROkWzT1vQduhA
	 9psIt7SK6TsUtq49LcRUZFvNajVPrU6PKT85P9qxrMh89dvf0ZAeEljn/y/Zcp0Eq+
	 BG/8nECdTUS6RLBfOuM664ahvrGNR3YYyuxsEUcaIUrLdXrp0KC556mNaAP4PNk7Zk
	 RMdqAPsWJYwgJ1sFEuDiyHeyfuAllrxFSRWKdAvOwSC45lZeY/WPOgSzkDvp/qzusv
	 ng73E3MEL/xlTHmg0d8p0Ln0EXoPfUOju+0ckZ2g4aeuDuGtLuEUxyXTM9qq2dhFia
	 R2qU6k74MoHmA==
Date: Wed, 12 Mar 2025 08:20:11 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: peterhuewe@gmx.de, jgg@ziepe.ca, ardb@kernel.org, gourry@gourry.net,
	linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
	zhanjun@uniontech.com, niecheng1@uniontech.com,
	guanwentao@uniontech.com, Chen Linxuan <chenlinxuan@uniontech.com>
Subject: Re: [PATCH] tpm: eventlog: Declare mapping_size __maybe_unused
Message-ID: <Z9Enmy6mpl07LtX6@kernel.org>
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

Why do we care clang-19 with W=1e?

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

Only one instance that demonstrates the issue please.

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
>  	void *marker;
>  	void *marker_start;
>  	u32 halg_size;
> -- 
> 2.47.2
> 
> 


BR, Jarkko

