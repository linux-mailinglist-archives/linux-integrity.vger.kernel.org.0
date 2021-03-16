Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDD2B33D955
	for <lists+linux-integrity@lfdr.de>; Tue, 16 Mar 2021 17:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbhCPQZl (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 16 Mar 2021 12:25:41 -0400
Received: from linux.microsoft.com ([13.77.154.182]:38736 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238699AbhCPQZa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 16 Mar 2021 12:25:30 -0400
Received: from [192.168.0.104] (c-73-42-176-67.hsd1.wa.comcast.net [73.42.176.67])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8515020B39C5;
        Tue, 16 Mar 2021 09:25:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8515020B39C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1615911930;
        bh=0WQyAU+sUYUvNFbd8iMWMBlnllo8ARQyBXHmuopB4zg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=roEPolJhTU4EYEyQ5OnQRfg9xkMVALA/iI9cMtFn0EgtSr1IX8ffJNfSnPuUyDxO6
         zXQgutpuczdTFZntVxssZdIrIpLTvzT2fRnuCdLA+PQ1FiLASMfTwi3e7b23yQVzNm
         6hIsaQZgD5W003oe5eozzBkTTMOWGoFOZwoPGFsg=
Subject: Re: [PATCH 2/2] IMA/ima_keys.sh: Require evmctl 1.3.2
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Tushar Sugandhi <tusharsu@linux.microsoft.com>,
        linux-integrity@vger.kernel.org
References: <20210316150600.16461-1-pvorel@suse.cz>
 <20210316150600.16461-2-pvorel@suse.cz>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <cedd3e94-8374-9600-96b2-a14412e22e14@linux.microsoft.com>
Date:   Tue, 16 Mar 2021 09:25:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210316150600.16461-2-pvorel@suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/16/21 8:06 AM, Petr Vorel wrote:
> Test requires fix 19b77c8 ("ima-evm-utils: Fix reading of sigfile").
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   testcases/kernel/security/integrity/ima/tests/ima_keys.sh | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> index c9eef4b68..aba1711a5 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> @@ -92,7 +92,9 @@ test1()
>   # that the certificate is measured correctly by IMA.
>   test2()
>   {
> -	tst_require_cmds evmctl keyctl openssl
> +	tst_require_cmds keyctl openssl
> +
> +	require_evmctl "1.3.2"
>   
>   	local cert_file="$TST_DATAROOT/x509_ima.der"
>   	local keyring_name="key_import_test"
> 

Reviewed-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>

  -lakshmi

