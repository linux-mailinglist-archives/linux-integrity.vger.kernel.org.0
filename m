Return-Path: <linux-integrity+bounces-7556-lists+linux-integrity=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E90C3C28826
	for <lists+linux-integrity@lfdr.de>; Sat, 01 Nov 2025 23:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 975423BB6B2
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Nov 2025 22:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E6CA288502;
	Sat,  1 Nov 2025 22:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uWtuQJ7l"
X-Original-To: linux-integrity@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E516D1B7F4;
	Sat,  1 Nov 2025 22:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762035056; cv=none; b=epnmiZg/Lhspm9qlvf0uNqVrXiDSW3auc43znFXFtxJxsTvKCMJqBwfiDjxpCt+F70j8PieqFdETSlLTNtXepHjHk/xmFxSVhaISSgrc0WLpNZQXFJNQu2KenoeMIPX/6NUb5kEJbtRKnkKDe7MMv/NCF0E8p3p4TN0X5Ujx82s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762035056; c=relaxed/simple;
	bh=oluztI+MIemez6HwqODfyI/rPIrU07A52mxjJ/pFf8Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eErf/WHtSX3vd29uhuChyPGOxB0ip5fRxj0f5ECIKq0JgjYOXh1vglQealI22VKCSohVVaDiJJNA4e3Yw2liaGRwS/T5/bMGBSvmSHt6dLD2cCYCg1mnL/xuf0uiCv/wdJeGblkx85ivyUyBjg1OoAcV6hRSk2bUaPNzcIm0j80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uWtuQJ7l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C19C4CEF1;
	Sat,  1 Nov 2025 22:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762035055;
	bh=oluztI+MIemez6HwqODfyI/rPIrU07A52mxjJ/pFf8Q=;
	h=Date:Reply-To:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uWtuQJ7lC7ZOsCjZ+xKQd42045lUa3wn/Usaokuh/KYyWXEKy1Auo3yRdUOfNR5SC
	 Bz5vDHORskHb1hgmOIG7Tr1+RNzMXrU+P1wdFdrIzksmgZbvpheivc+OuVUP5G+O76
	 oXYJgRcuCnkaqaHeojeFI1gVe/yL43B0y7vaho86JKNU5IXzwTMfG2vc1+2Txc/Nic
	 F7NftRx8uuoNWtcxI9RmIqKzC9xXtJTJ7p8RNG05S+32HQpDsJdAQWFK9puc8tEKVH
	 5S2eBtGx19+KRtDMkFvFHtqNha0aXX0TM5yXDoRtAOMxgFRQO9O4QkCZbFXER6Wqkq
	 HpLxPGszmhuwA==
Message-ID: <3bf85718-8cea-4982-944d-b4c7a4faaf8f@kernel.org>
Date: Sat, 1 Nov 2025 23:10:51 +0100
Precedence: bulk
X-Mailing-List: linux-integrity@vger.kernel.org
List-Id: <linux-integrity.vger.kernel.org>
List-Subscribe: <mailto:linux-integrity+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-integrity+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Daniel Gomez <da.gomez@kernel.org>
Subject: Re: [PATCH] module: Only declare set_module_sig_enforced when
 CONFIG_MODULE_SIG=y
To: Coiby Xu <coxu@redhat.com>, linux-modules@vger.kernel.org
Cc: linux-integrity@vger.kernel.org, kernel test robot <lkp@intel.com>,
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>,
 Sami Tolvanen <samitolvanen@google.com>,
 "open list:MODULE SUPPORT" <linux-kernel@vger.kernel.org>
References: <20251031080949.2001716-1-coxu@redhat.com>
Content-Language: en-US
From: Daniel Gomez <da.gomez@kernel.org>
Organization: kernel.org
In-Reply-To: <20251031080949.2001716-1-coxu@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/10/2025 09.09, Coiby Xu wrote:
> Currently, set_module_sig_enforced is declared as long as CONFIG_MODULES
> is enabled. This can lead to a linking error if
> set_module_sig_enforced is called with CONFIG_MODULE_SIG=n,
> 
>     ld: security/integrity/ima/ima_appraise.o: in function `ima_appraise_measurement':
>     security/integrity/ima/ima_appraise.c:587:(.text+0xbbb): undefined reference to `set_module_sig_enforced'

It's a bit unclear whether you're referring to a current upstream issue (which I
couldn't find as of -rc3), or if this is just a hypothetical scenario.

> 
> So only declare set_module_sig_enforced when CONFIG_MODULE_SIG is
> enabled.

I only see cases where code has a safeguard like in
security/integrity/ima/ima_efi.c:71

		if (IS_ENABLED(CONFIG_MODULE_SIG))
			set_module_sig_enforced();

> 
> Note this issue hasn't caused a real problem because all current callers
> of set_module_sig_enforced e.g. security/integrity/ima/ima_efi.c
> depend on CONFIG_MODULE_SIG=y.

I think the correct term we should use here is runtime safeguard. The code does
not actually depend on that config, nor is there any dep in Kconfig.

> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202510030029.VRKgik99-lkp@intel.com/
> Signed-off-by: Coiby Xu <coxu@redhat.com>


Just minor nits regarding the commit message structure. This change should allow
us to remove the safeguard from users of set_module_sig_enforced().


Other than that, LGTM,

Reviewed-by: Daniel Gomez <da.gomez@samsung.com>

