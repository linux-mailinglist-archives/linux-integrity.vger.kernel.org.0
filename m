Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D69B111D771
	for <lists+linux-integrity@lfdr.de>; Thu, 12 Dec 2019 20:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730620AbfLLTvI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 12 Dec 2019 14:51:08 -0500
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:51332 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730284AbfLLTvH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 12 Dec 2019 14:51:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 6EE618EE18E;
        Thu, 12 Dec 2019 11:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576180266;
        bh=VicjdT418xSLEpNgSSEEdl15cSxj3tKlnApHKIrDh68=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IG/SDE+G+Bh6jjYVnBW+sLkyO5teFK/h0FPv+4TWLLOcKx7TLgQMhVZRY3vMKYyQX
         FvwQE56nzinL+1heBDNryWQpdItqt+TggX5OlOL1Ju5wT7ZQDQ0baEDj2ZYFSjBOir
         dPiOQbfSKqDf5lD0N5oaxNRrwg2H5kvF39CtdAAE=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Ddk6vEX5Wprp; Thu, 12 Dec 2019 11:51:06 -0800 (PST)
Received: from [9.232.197.95] (unknown [129.33.253.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 2757B8EE0C7;
        Thu, 12 Dec 2019 11:51:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1576180266;
        bh=VicjdT418xSLEpNgSSEEdl15cSxj3tKlnApHKIrDh68=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=IG/SDE+G+Bh6jjYVnBW+sLkyO5teFK/h0FPv+4TWLLOcKx7TLgQMhVZRY3vMKYyQX
         FvwQE56nzinL+1heBDNryWQpdItqt+TggX5OlOL1Ju5wT7ZQDQ0baEDj2ZYFSjBOir
         dPiOQbfSKqDf5lD0N5oaxNRrwg2H5kvF39CtdAAE=
Message-ID: <1576180263.10287.4.camel@HansenPartnership.com>
Subject: Re: [PATCH =v2 3/3] tpm: selftest: cleanup after unseal with wrong
 auth/policy test
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Tadeusz Struk <tadeusz.struk@intel.com>,
        jarkko.sakkinen@linux.intel.com
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca,
        mingo@redhat.com, jeffrin@rajagiritech.edu.in,
        linux-integrity@vger.kernel.org, will@kernel.org, peterhuewe@gmx.de
Date:   Thu, 12 Dec 2019 14:51:03 -0500
In-Reply-To: <157617293957.8172.1404790695313599409.stgit@tstruk-mobl1>
References: <157617292787.8172.9586296287013438621.stgit@tstruk-mobl1>
         <157617293957.8172.1404790695313599409.stgit@tstruk-mobl1>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, 2019-12-12 at 09:48 -0800, Tadeusz Struk wrote:
> Unseal with wrong auth or wrong policy test affects DA lockout
> and eventually causes the tests to fail with:
> "ProtocolError: TPM_RC_LOCKOUT: rc=0x00000921"
> when the tests run multiple times.
> Send tpm clear command after the test to reset the DA counters.
> 
> Signed-off-by: Tadeusz Struk <tadeusz.struk@intel.com>
> ---
>  tools/testing/selftests/tpm2/test_smoke.sh |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/tpm2/test_smoke.sh
> b/tools/testing/selftests/tpm2/test_smoke.sh
> index cb54ab637ea6..8155c2ea7ccb 100755
> --- a/tools/testing/selftests/tpm2/test_smoke.sh
> +++ b/tools/testing/selftests/tpm2/test_smoke.sh
> @@ -3,3 +3,8 @@
>  
>  python -m unittest -v tpm2_tests.SmokeTest
>  python -m unittest -v tpm2_tests.AsyncTest
> +
> +CLEAR_CMD=$(which tpm2_clear)
> +if [ -n $CLEAR_CMD ]; then
> +	tpm2_clear -T device
> +fi

TPM2_Clear reprovisions the SPS ... that would make all currently
exported TPM keys go invalid.  I know these tests should be connected
to a vTPM, so doing this should be safe, but if this accidentally got
executed on your laptop all TPM relying functions would be disrupted,
which doesn't seem to be the best thing to hard wire into a test.

What about doing a TPM2_DictionaryAttackLockReset instead, which is the
least invasive route to fixing the problem ... provided you know what
the lockout authorization is.

James

