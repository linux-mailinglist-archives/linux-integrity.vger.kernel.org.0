Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61A0041481F
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Sep 2021 13:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235815AbhIVLtI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Sep 2021 07:49:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54598 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230171AbhIVLtH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Sep 2021 07:49:07 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2CF5A22213;
        Wed, 22 Sep 2021 11:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632311257;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=36IdXHp84eA5CEsGV/yfxQgW/yw20QXQ/3FNdo+o1yg=;
        b=s4YSv0mRzORoRTAOpOWpRsC10u2/OTMoIiQFUiiAISGmJv66z0KsYOY3HQe3ukPE4mw2wx
        TLjcIKFTNwt6pg29Pw9G2OjfIo43lyxIRqhM2RBUrfqGpgT+xZSjFCZY7E0g2Lm+b1wTdm
        Q8Kn4gtNUR/vihG9GkuRbTnyTi+qhBI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632311257;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=36IdXHp84eA5CEsGV/yfxQgW/yw20QXQ/3FNdo+o1yg=;
        b=RHBIz4Mk5kwpH3KxjgN/lrzjlJI7/7seRWdb5TIFfKkF1KOQbXlnZdWWcW63+GKf6R25qI
        pQC05g8gk56Ac5Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ED87013D76;
        Wed, 22 Sep 2021 11:47:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id la5iONgXS2H+BgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Wed, 22 Sep 2021 11:47:36 +0000
Date:   Wed, 22 Sep 2021 13:47:35 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Alex Henrie <alexh@vpitech.com>
Cc:     linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        zohar@linux.ibm.com, alexhenrie24@gmail.com
Subject: Re: [PATCH ltp v5 2/3] IMA: Move ima_check to ima_setup.sh
Message-ID: <YUsX1/4HmzHO01GW@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210922020801.466936-1-alexh@vpitech.com>
 <20210922020801.466936-2-alexh@vpitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922020801.466936-2-alexh@vpitech.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

> Signed-off-by: Alex Henrie <alexh@vpitech.com>
> ---
>  .../integrity/ima/tests/ima_measurements.sh   | 28 -------------------
>  .../security/integrity/ima/tests/ima_setup.sh | 28 +++++++++++++++++++
>  2 files changed, 28 insertions(+), 28 deletions(-)

> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> index 1927e937c..807c5f57b 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
> @@ -17,38 +17,10 @@ setup()
>  {
>  	require_ima_policy_cmdline "tcb"

> -	TEST_FILE="$PWD/test.txt"
>  	POLICY="$IMA_DIR/policy"
>  	[ -f "$POLICY" ] || tst_res TINFO "not using default policy"
>  }

> -ima_check()
> -{
> -	local algorithm digest expected_digest line tmp
> -
> -	# need to read file to get updated $ASCII_MEASUREMENTS
> -	cat $TEST_FILE > /dev/null
> -
> -	line="$(grep $TEST_FILE $ASCII_MEASUREMENTS | tail -1)"
> -
> -	if tmp=$(get_algorithm_digest "$line"); then
> -		algorithm=$(echo "$tmp" | cut -d'|' -f1)
> -		digest=$(echo "$tmp" | cut -d'|' -f2)
> -	else
> -		tst_res TBROK "failed to get algorithm/digest for '$TEST_FILE': $tmp"
> -	fi
> -
> -	tst_res TINFO "computing digest for $algorithm algorithm"
> -	expected_digest="$(compute_digest $algorithm $TEST_FILE)" || \
> -		tst_brk TCONF "cannot compute digest for $algorithm algorithm"
> -
> -	if [ "$digest" = "$expected_digest" ]; then
> -		tst_res TPASS "correct digest found"
> -	else
> -		tst_res TFAIL "digest not found"
> -	fi
> -}
> -
>  check_iversion_support()
>  {
>  	local device mount fs
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> index 9c25d634d..976c6a86c 100644
> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> @@ -188,6 +188,7 @@ ima_setup()
>  	if [ "$TST_NEEDS_DEVICE" = 1 ]; then
>  		tst_res TINFO "\$TMPDIR is on tmpfs => run on loop device"
>  		mount_loop_device
> +		TEST_FILE="$PWD/test.txt"
This is wrong, it's causing error, unless you have $TMPDIR (usually /tmp) on
tmpfs it's not defined and leads to error:

ima_measurements 1 TINFO: verify adding record to the IMA measurement list
tst_rod: Missing filename after >
ima_measurements 1 TBROK: echo Wed Sep 22 12:24:17 CEST 2021 this is a test file > failed

And even on tmpfs it fails (maybe caused by old kernel 3.10):

ima_measurements 1 TINFO: $TMPDIR is on tmpfs => run on loop device
ima_measurements 1 TINFO: Formatting /dev/loop0 with ext3 extra opts=''
ima_measurements 1 TINFO: not using default policy
ima_measurements 1 TINFO: verify adding record to the IMA measurement list
ima_measurements 1 TBROK: failed to get algorithm/digest for '/tmp/LTP_ima_measurements.dLS7yCTHLY/mntpoint/test.txt': measurement record not found
ima_measurements 1 TINFO: computing digest for  algorithm
                                               ^
                                               => notice space - algorithm not detected
ima_measurements 1 TCONF: cannot compute digest for  algorithm
                                               ^
                                               => also here.

It's also wrong that $PWD is unique for each test and TMPDIR is removed after
test, thus TEST_FILE will not exist for the second test (ima_conditionals.sh).
Also, ima_setup(). Also, I put into ima_setup.sh IMA related variables.
TEST_FILE is not that case thus I'd keep $TEST_FILE in ima_measurements.sh and
define local test_file="$PWD/test.txt" in the only function in ima_conditionals.sh.

Also I intent do remove duplicity in ima_conditionals.sh, thus I'll send v6 in a minute.

Kind regards,
Petr
