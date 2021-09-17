Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D6C740F700
	for <lists+linux-integrity@lfdr.de>; Fri, 17 Sep 2021 14:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243081AbhIQMDJ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 17 Sep 2021 08:03:09 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:54196 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242369AbhIQMDJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 17 Sep 2021 08:03:09 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A503222187;
        Fri, 17 Sep 2021 12:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631880106;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k/5EOzsGM6nQtu672ekPbAuo7rQAvduu3ow5Cim/r2s=;
        b=RNGasadQK8nqjPPD5TUJklwHWD5LTA+PA+f6KQ+6VlsRK710WhflpjRnL6BNtoi49M3dKe
        nYe6oTFG+9sRPfAh8hIn83/2ODWdkSHa1W/HH/fdKxuO1AiJJuM/zFTLbgMg0/G22LJAMf
        KQ+mwaPI56NOkJ4j9YjkkyJ3jYsOV0w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631880106;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k/5EOzsGM6nQtu672ekPbAuo7rQAvduu3ow5Cim/r2s=;
        b=11b5k7x5byaejbmTiaMVGnA+Y9ZFXcrnI8koZ4x+IB70hKCdOaUl6M30ZHR/YgZGRVeUqs
        Gx0KtMJVso66EdCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6EAD613AB8;
        Fri, 17 Sep 2021 12:01:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id VdOHGaqDRGFDOgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 17 Sep 2021 12:01:46 +0000
Date:   Fri, 17 Sep 2021 14:01:44 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Alex Henrie <alexh@vpitech.com>
Cc:     linux-integrity@vger.kernel.org, ltp@lists.linux.it,
        zohar@linux.ibm.com, alexhenrie24@gmail.com
Subject: Re: [PATCH ltp v3 2/2] IMA: Add tests for uid, gid, fowner, and
 fgroup options
Message-ID: <YUSDqLQ1xJX7PEja@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210914161503.97495-1-alexh@vpitech.com>
 <20210914161503.97495-2-alexh@vpitech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210914161503.97495-2-alexh@vpitech.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hi Alex,

> +test4()
> +{
> +	local user="nobody"
> +
> +	tst_check_cmds chgrp chown sg sudo || return
> +
> +	# try to write to the policy, then check whether it can be written again
> +	cat $IMA_POLICY > $IMA_POLICY 2> /dev/null
This is not needed because require_policy_writable call

> +	require_policy_writable
> +
> +	ROD rm -f $TEST_FILE
> +	tst_res TINFO "verify measuring user files when requested via uid"
> +	ROD echo "measure uid=$(id -u $user)" \> $IMA_POLICY
> +	ROD echo "$(date) uid test" \> $TEST_FILE
> +	sudo -n -u $user sh -c "cat $TEST_FILE > /dev/null"
> +	ima_check
> +
As I noted at first patch unfortunately we need another require_policy_writable
call here.  Because we don't grep kernel config for CONFIG_IMA_WRITE_POLICY,
we just try to write empty string (invalid), thus policy must be repeatedly
checked (see ima_policy.sh). Because after first write to policy (ROD echo
"measure uid=$(id -u $user)" \> $IMA_POLICY) policy will be removed on systems
without CONFIG_IMA_WRITE_POLICY.

> +	ROD rm -f $TEST_FILE
> +	tst_res TINFO "verify measuring user files when requested via fowner"
> +	ROD echo "measure fowner=$(id -u $user)" \> $IMA_POLICY
> +	ROD echo "$(date) fowner test" \> $TEST_FILE
> +	chown $user $TEST_FILE
> +	cat $TEST_FILE > /dev/null
> +	ima_check
> +
> +	if tst_kvcmp -lt 5.16; then
> +		tst_brk TCONF "gid and fgroup options require kernel 5.16 or newer"
> +	fi
> +
> +	ROD rm -f $TEST_FILE
> +	tst_res TINFO "verify measuring user files when requested via gid"
> +	ROD echo "measure gid=$(id -g $user)" \> $IMA_POLICY
> +	ROD echo "$(date) gid test" \> $TEST_FILE
> +	sudo sg $user "sh -c 'cat $TEST_FILE > /dev/null'"
> +	ima_check
> +
> +	ROD rm -f $TEST_FILE
> +	tst_res TINFO "verify measuring user files when requested via fgroup"
> +	ROD echo "measure fgroup=$(id -g $user)" \> $IMA_POLICY
> +	ROD echo "$(date) fgroup test" \> $TEST_FILE
> +	chgrp $user $TEST_FILE
> +	cat $TEST_FILE > /dev/null
> +	ima_check
> +}
> +
>  tst_run

I still have 2 concerns about this patch (sorry that I didn't realise it before)

1) repeated running of ima_measurements.sh is broken:
ima_measurements 1 TINFO: verify adding record to the IMA measurement list
ima_measurements 1 TBROK: failed to get algorithm/digest for '/tmp/LTP_ima_measurements.6WSmgkHZ13/test.txt': measurement record not found

First run:
ima_measurements 1 TINFO: timeout per run is 0h 5m 0s
ima_measurements 1 TINFO: IMA kernel config:
ima_measurements 1 TINFO: CONFIG_IMA=y
ima_measurements 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=10
ima_measurements 1 TINFO: CONFIG_IMA_LSM_RULES=y
ima_measurements 1 TINFO: CONFIG_IMA_NG_TEMPLATE=y
ima_measurements 1 TINFO: CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
ima_measurements 1 TINFO: CONFIG_IMA_DEFAULT_HASH_SHA256=y
ima_measurements 1 TINFO: CONFIG_IMA_DEFAULT_HASH="sha256"
ima_measurements 1 TINFO: CONFIG_IMA_READ_POLICY=y
ima_measurements 1 TINFO: CONFIG_IMA_APPRAISE=y
ima_measurements 1 TINFO: CONFIG_IMA_APPRAISE_BOOTPARAM=y
ima_measurements 1 TINFO: CONFIG_IMA_APPRAISE_MODSIG=y
ima_measurements 1 TINFO: CONFIG_IMA_TRUSTED_KEYRING=y
ima_measurements 1 TINFO: CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY=y
ima_measurements 1 TINFO: CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
ima_measurements 1 TINFO: /proc/cmdline: BOOT_IMAGE=/boot/vmlinuz-5.3.18-54-default root=UUID=478230c4-ef04-4f7e-ad47-733fd1f28a76 ima_policy=tcb splash=silent video=1024x768 plymouth.ignore-serial-consoles console=ttyS0 console=tty softlockup_panic=1 kernel.softlockup_panic=1 mitigations=auto ignore_loglevel
ima_measurements 1 TINFO: verify adding record to the IMA measurement list
ima_measurements 1 TINFO: computing digest for sha256 algorithm
ima_measurements 1 TPASS: correct digest found
ima_measurements 2 TINFO: verify updating record in the IMA measurement list
ima_measurements 2 TINFO: computing digest for sha256 algorithm
ima_measurements 2 TPASS: correct digest found
ima_measurements 3 TINFO: verify not measuring user files by default
ima_measurements 3 TPASS: grep /tmp/LTP_ima_measurements.ma8YpOrvRS/user/test.txt /sys/kernel/security/ima/ascii_runtime_measurements failed as expected
ima_measurements 4 TINFO: verify measuring user files when requested via uid
ima_measurements 4 TINFO: computing digest for sha256 algorithm
ima_measurements 4 TPASS: correct digest found
ima_measurements 4 TCONF: IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y)

Summary:
passed   4
failed   0
broken   0
skipped  1
warnings 0

Repeated run:
ima_measurements 1 TINFO: timeout per run is 0h 5m 0s
ima_measurements 1 TINFO: IMA kernel config:
ima_measurements 1 TINFO: CONFIG_IMA=y
ima_measurements 1 TINFO: CONFIG_IMA_MEASURE_PCR_IDX=10
ima_measurements 1 TINFO: CONFIG_IMA_LSM_RULES=y
ima_measurements 1 TINFO: CONFIG_IMA_NG_TEMPLATE=y
ima_measurements 1 TINFO: CONFIG_IMA_DEFAULT_TEMPLATE="ima-ng"
ima_measurements 1 TINFO: CONFIG_IMA_DEFAULT_HASH_SHA256=y
ima_measurements 1 TINFO: CONFIG_IMA_DEFAULT_HASH="sha256"
ima_measurements 1 TINFO: CONFIG_IMA_READ_POLICY=y
ima_measurements 1 TINFO: CONFIG_IMA_APPRAISE=y
ima_measurements 1 TINFO: CONFIG_IMA_APPRAISE_BOOTPARAM=y
ima_measurements 1 TINFO: CONFIG_IMA_APPRAISE_MODSIG=y
ima_measurements 1 TINFO: CONFIG_IMA_TRUSTED_KEYRING=y
ima_measurements 1 TINFO: CONFIG_IMA_KEYRINGS_PERMIT_SIGNED_BY_BUILTIN_OR_SECONDARY=y
ima_measurements 1 TINFO: CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=y
ima_measurements 1 TINFO: /proc/cmdline: BOOT_IMAGE=/boot/vmlinuz-5.3.18-54-default root=UUID=478230c4-ef04-4f7e-ad47-733fd1f28a76 ima_policy=tcb splash=silent video=1024x768 plymouth.ignore-serial-consoles console=ttyS0 console=tty softlockup_panic=1 kernel.softlockup_panic=1 mitigations=auto ignore_loglevel
ima_measurements 1 TINFO: verify adding record to the IMA measurement list
ima_measurements 1 TBROK: failed to get algorithm/digest for '/tmp/LTP_ima_measurements.6WSmgkHZ13/test.txt': measurement record not found
ima_measurements 1 TINFO: computing digest for  algorithm
ima_measurements 1 TCONF: cannot compute digest for  algorithm
ima_measurements 1 TINFO: AppArmor enabled, this may affect test results
ima_measurements 1 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root)
ima_measurements 1 TINFO: loaded AppArmor profiles: none

I need to have closer look what the problem is. It can be fixed by checking
policy with require_policy_writable in the setup. But that's problem for missing
coverage (TCONF for first 3 tests).

2) writing policy in ima_measurement.sh leads to TCONF ima_policy.sh on systems
without CONFIG_IMA_WRITE_POLICY. This has has no easy solution. Either we manage
to load each policy for each overlay [1] or add support for reboot to LTP [2] and
restart after each test or just some functionality will be skipped due policy
disappear after writting.

But still IMHO it'd be better to separate test4() into it's own file to not
affect the original 3 tests in ima_measurement.sh (unless we fix the problem
with repeated running of ima_measurement.sh).

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/issues/720
[2] https://github.com/linux-test-project/ltp/issues/868
