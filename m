Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA74C408735
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Sep 2021 10:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238251AbhIMIlq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Sep 2021 04:41:46 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:50244 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238229AbhIMIlj (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Sep 2021 04:41:39 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id DC3581FFAA;
        Mon, 13 Sep 2021 08:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631522421;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KD9wM/7qWqNzdEKbj8UfE38r0cX5g54K+576RN3MS2o=;
        b=rW7yOGAy0MiP5oabJJg2mHf4o0xkYQS16XFLh6iPx1oGIJ90N9bfk2c8P+CE9TGO6xylQe
        vGiqQXX3Vtmh+cZW0OBUNjK4wsy0dUVCzB9n2SS8igwqYLNkk5/db2djRJd5mIXetcBzdr
        V17JBqfX5SYEGOI6v+DlcZycB975fUU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631522421;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KD9wM/7qWqNzdEKbj8UfE38r0cX5g54K+576RN3MS2o=;
        b=7PeplFo5FXrvFSYK4WVN5HSlOOm+IxJwv+gbprCwpx5ofV8lZS0zNMY9wyVumqqP5EJ7Ak
        fOJeuC0/VWMcnpBQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id A7AC5132AB;
        Mon, 13 Sep 2021 08:40:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id LTY9J3UOP2GMFAAAGKfGzw
        (envelope-from <pvorel@suse.cz>); Mon, 13 Sep 2021 08:40:21 +0000
Date:   Mon, 13 Sep 2021 10:40:20 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Alex Henrie <alexh@vpitech.com>
Cc:     linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        zohar@linux.ibm.com, alexhenrie24@gmail.com
Subject: Re: [PATCH ltp v2] IMA: Add tests for uid, gid, fowner, and fgroup
 options
Message-ID: <YT8OdIYtP/FaC52z@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210910164448.28302-1-alexh@vpitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210910164448.28302-1-alexh@vpitech.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Alex,

> Requires "ima: add gid support".

> v2:
> - Add sudo to list of required commands
> - Check policy writability
> - Check kernel version
> - Use `sudo sg` to test the gid option
> - Don't try to restore the original policy after testing

...
> -	check_policy_writable
> +	require_policy_writable
Good point to fix function name. But could you please do the rename and move to
ima_setup.sh in separate commit?

Also, why do you extending test3()? Wouldn't be more readable to add test4()?
See notes below.

...
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_measurements.sh
...
> -TST_NEEDS_CMDS="awk cut sed"
> +TST_NEEDS_CMDS="awk cut sed sg sudo"
I'm sorry, I was wrong. sudo is needed just in the last test, thus
original check "tst_check_cmds sudo || return" is enough.
Having it TST_NEEDS_CMDS it requires it also for old kernels, which is necessary.

chgrp and sg you newly introduced, should be also tested by tst_check_cmds,
after checking kernel version.

>  TST_SETUP="setup"
>  TST_CNT=3
>  TST_NEEDS_DEVICE=1
> @@ -20,6 +20,8 @@ setup()
>  	TEST_FILE="$PWD/test.txt"
>  	POLICY="$IMA_DIR/policy"
>  	[ -f "$POLICY" ] || tst_res TINFO "not using default policy"
> +
> +	require_policy_writable
This changes test to require CONFIG_IMA_WRITE_POLICY=y. Most distributions does
not have it, thus you'd disable testing for most distros. Not having policy
readable and writeable everywhere greatly complicates IMA testing.
...
>  }

> @@ -103,7 +105,7 @@ test3()
>  	local file="$dir/test.txt"

>  	# Default policy does not measure user files
> -	tst_res TINFO "verify not measuring user files"
> +	tst_res TINFO "verify not measuring user files by default"
>  	tst_check_cmds sudo || return

>  	if ! id $user >/dev/null 2>/dev/null; then
> @@ -116,9 +118,38 @@ test3()
>  	cd $dir
>  	# need to read file to get updated $ASCII_MEASUREMENTS
>  	sudo -n -u $user sh -c "echo $(date) user file > $file; cat $file > /dev/null"
> +	EXPECT_FAIL "grep $file $ASCII_MEASUREMENTS"
>  	cd ..

> -	EXPECT_FAIL "grep $file $ASCII_MEASUREMENTS"
> +	tst_res TINFO "verify measuring user files when requested via uid"
> +	ROD echo "measure uid=$(id -u $user)" \> $IMA_POLICY
This is the reason for require_policy_writable.
Previously it was possible to run it without:

ima_measurements 1 TPASS: correct digest found
ima_measurements 2 TINFO: verify updating record in the IMA measurement list
ima_measurements 2 TINFO: computing digest for sha256 algorithm
ima_measurements 2 TPASS: correct digest found
ima_measurements 3 TINFO: verify not measuring user files
ima_measurements 3 TPASS: grep /tmp/LTP_ima_measurements.6nhS7ScgBn/user/test.txt /sys/kernel/security/ima/ascii_runtime_measurements failed as expected

I'd keep the old EXPECT_FAIL variant (suppose it's still valid and don't require
writable policy) and definitely separate new tests.
Remember, test should run the same on older kernels (we don't want to drop
coverage on older distros / enterprise distros).

> +	ROD echo "$(date) uid test" \> $TEST_FILE
> +	sudo -n -u $user sh -c "cat $TEST_FILE > /dev/null"
> +	ima_check
> +
> +	tst_res TINFO "verify measuring user files when requested via fowner"
> +	ROD echo "measure fowner=$(id -u $user)" \> $IMA_POLICY
> +	ROD echo "$(date) fowner test" \> $TEST_FILE
> +	chown $user $TEST_FILE
> +	cat $TEST_FILE > /dev/null
> +	ima_check
> +
> +	if tst_kvcmp -lt 5.15; then
> +		tst_brk TCONF "gid and fgroup options require kernel 5.15 or newer"
> +	fi
> +
> +	tst_res TINFO "verify measuring user files when requested via gid"
> +	ROD echo "measure gid=$(id -g $user)" \> $IMA_POLICY
> +	ROD echo "$(date) gid test" \> $TEST_FILE
> +	sudo sg $user "sh -c 'cat $TEST_FILE > /dev/null'"
> +	ima_check
> +
> +	tst_res TINFO "verify measuring user files when requested via fgroup"
> +	ROD echo "measure fgroup=$(id -g $user)" \> $IMA_POLICY
> +	ROD echo "$(date) fgroup test" \> $TEST_FILE
> +	chgrp $user $TEST_FILE
> +	cat $TEST_FILE > /dev/null
> +	ima_check
>  }
...

Kind regards,
Petr
