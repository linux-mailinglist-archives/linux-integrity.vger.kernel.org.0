Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6799D213DF
	for <lists+linux-integrity@lfdr.de>; Fri, 17 May 2019 08:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727704AbfEQGvT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 May 2019 02:51:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:35536 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726871AbfEQGvS (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 May 2019 02:51:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B7DE8AD78;
        Fri, 17 May 2019 06:51:17 +0000 (UTC)
Date:   Fri, 17 May 2019 08:51:16 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        ltp@lists.linux.it
Subject: Re: [PATCH] ima: skip verifying TPM 2.0 PCR values
Message-ID: <20190517065116.GA8170@dell5510>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <1558041162.3971.2.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1558041162.3971.2.camel@linux.ibm.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Mimi,

> TPM 1.2 exported the PCRs.  Reading the TPM 2.0 PCRs requires a
> userspace application.  For now, skip this test.

> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Acked-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/security/integrity/ima/tests/ima_tpm.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)

> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> index 0ffc3c02247d..ebe4b4c360e4 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> @@ -88,6 +88,14 @@ test2()
>  	tst_res TINFO "verify PCR values"
>  	tst_check_cmds evmctl

> +	local tpm_description="/sys/class/tpm/tpm0/device/description"
> +	if [ -f "$tpm_description" ]; then
> +		if grep -q "^\TPM 2.0" $tpm_description; then
I guess the backslash in "^\TPM 2.0" is a typo.
If yes, no need to repost, I'll fix it when applying your patch.
+ I'd prefer join 2 ifs into single one, but that's just matter of preference,
not important.

> +			tst_res TCONF "TPM 2.0 enabled, but not supported"
> +			return 0
> +		fi
> +	fi
> +
>  	tst_res TINFO "evmctl version: $(evmctl --version)"

>  	local pcrs_path="/sys/class/tpm/tpm0/device/pcrs"

Thanks for your fix.

Kind regards,
Petr
