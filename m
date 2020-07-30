Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECD1F233953
	for <lists+linux-integrity@lfdr.de>; Thu, 30 Jul 2020 21:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgG3Tun (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 30 Jul 2020 15:50:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:46978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730587AbgG3Tuk (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 30 Jul 2020 15:50:40 -0400
Received: from localhost.localdomain (pool-96-246-152-186.nycmny.fios.verizon.net [96.246.152.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D1A22074B;
        Thu, 30 Jul 2020 19:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596138640;
        bh=YvcGbYZEw3vFmip1LWbW7P2dPiKLq+rSoC2yjz9Nw/A=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Xk3mmOsJjzD8KcGkOW+392890YPvEG3jzTlNo/swEFXpPUJzzze0j44g36LLDDIw4
         uOPtgEqmcONDTlsXzGvluBFv6LYvVXqmcjP47IjT9NFY/TslmutretGymK0f2omBVq
         QcbAlfBk/LUlzgj6EUJX7DMthm88Ygk2zf33fHQs=
Message-ID: <1596138638.25003.6.camel@kernel.org>
Subject: Re: [PATCH v5 2/4] IMA: Add policy related helpers
From:   Mimi Zohar <zohar@kernel.org>
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     Lachlan Sneff <t-josne@linux.microsoft.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        balajib@linux.microsoft.com, linux-integrity@vger.kernel.org
Date:   Thu, 30 Jul 2020 15:50:38 -0400
In-Reply-To: <20200727223041.13110-3-pvorel@suse.cz>
References: <20200727223041.13110-1-pvorel@suse.cz>
         <20200727223041.13110-3-pvorel@suse.cz>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.20.5 (3.20.5-1.fc24) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, 2020-07-28 at 00:30 +0200, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Other than inverting the [ -f $IMA_POLICY ] tests.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
> New in v5.
> 
>  .../security/integrity/ima/tests/ima_setup.sh | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> index 975ce9cbb..c46f273ab 100644
> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> @@ -54,6 +54,45 @@ compute_digest()
>  	return 1
>  }
>  
> +check_policy_readable()
> +{
> +	if [ -f $IMA_POLICY ]; then
> +		tst_res TINFO "missing $IMA_POLICY (reboot or CONFIG_IMA_WRITE_POLICY=y required)"
> +		return 1
> +	fi
> +	cat $IMA_POLICY > /dev/null 2>/dev/null
> +}
> +
> +require_policy_readable()
> +{
> +	if [ -f $IMA_POLICY ]; then
> +		tst_brk TCONF "missing $IMA_POLICY (reboot or CONFIG_IMA_WRITE_POLICY=y required)"
> +	fi
> +	if ! check_policy_readable; then
> +		tst_brk TCONF "cannot read IMA policy (CONFIG_IMA_READ_POLICY=y required)"
> +	fi
> +}
> +
> +check_ima_policy_content()
> +{
> +	local pattern="$1"
> +	local grep_params="${2--q}"
> +
> +	check_policy_readable || return 1
> +	grep $grep_params "$pattern" $IMA_POLICY
> +}
> +
> +require_ima_policy_content()
> +{
> +	local pattern="$1"
> +	local grep_params="${2--q}"
> +
> +	require_policy_readable
> +	if ! grep $grep_params "$pattern" $IMA_POLICY; then
> +		tst_brk TCONF "IMA policy does not specify '$pattern'"
> +	fi
> +}
> +
>  require_ima_policy_cmdline()
>  {
>  	local policy="$1"

