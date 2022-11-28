Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 098AB63AE9A
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Nov 2022 18:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231278AbiK1RMQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Nov 2022 12:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232907AbiK1RLn (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Nov 2022 12:11:43 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91B3C2717D
        for <linux-integrity@vger.kernel.org>; Mon, 28 Nov 2022 09:11:41 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2A9DE21AAA;
        Mon, 28 Nov 2022 17:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669655500; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eoPxt44j0lFPPdRr2uYVMHaWWWyHBdqm/SEmz7Hgco4=;
        b=kCehE7JCKvbfHhzasdMdMoMS87HqeowkyxOzPEbZg+V/ZKMZpQw4S+GQyMrpQFemlUCIOH
        DEjGt17pa+Jeh8YIqrNwStY4qWPJ111PdfhlN1aRno7umbYiyRdlgiY5q/Z1fJAaKNvpG6
        w4yBgcvoC9lvkgzJOBqs5npoB3Z5PCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669655500;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eoPxt44j0lFPPdRr2uYVMHaWWWyHBdqm/SEmz7Hgco4=;
        b=TUXJE0MYxuXLMCacNFnsfHs4Ldc++g7hWq7xXLaEuaWttoyqMSr/gnCj0kL0uq1Kc7DsuA
        338W+uMVpdFJzKBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3D081326E;
        Mon, 28 Nov 2022 17:11:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XevoOsvrhGP5fAAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 28 Nov 2022 17:11:39 +0000
Message-ID: <8b03ca81-c7ec-bf51-e54a-400107e28f32@suse.cz>
Date:   Mon, 28 Nov 2022 18:11:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 1/3] char: tpm: Protect tpm_pm_suspend with locks
Content-Language: en-US
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>,
        linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, arnd@arndb.de, rrangel@chromium.org,
        timvp@google.com, apronin@google.com, mw@semihalf.com,
        upstream@semihalf.com
References: <20221103145450.1409273-1-jsd@semihalf.com>
 <20221103145450.1409273-2-jsd@semihalf.com> <Y2f/pExGdDBGhNZA@kernel.org>
 <CAOtMz3MRyTVHEmoiR95jUCtEM-JXNMVLzE08HiENPhdpWL2LVA@mail.gmail.com>
 <Y2kzzf6XAy5SwJva@kernel.org> <Y4TqFR71MitDHEEH@zx2c4.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <Y4TqFR71MitDHEEH@zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/28/22 18:04, Jason A. Donenfeld wrote:
> Hi Jarkko,
> 
> On Mon, Nov 07, 2022 at 06:35:25PM +0200, Jarkko Sakkinen wrote:
>> On Mon, Nov 07, 2022 at 09:45:41AM +0100, Jan Dąbroś wrote:
>> > niedz., 6 lis 2022 o 20:49 Jarkko Sakkinen <jarkko@kernel.org> napisał(a):
>> > >
>> > > On Thu, Nov 03, 2022 at 03:54:48PM +0100, Jan Dabros wrote:
>> > > > Currently tpm transactions are executed unconditionally in
>> > > > tpm_pm_suspend() function, what may lead to races with other tpm
>> > > > accessors in the system.
>> > > >
>> > > > Add proper locking mechanisms by calling tpm_try_get_ops() which is a
>> > > > wrapper on tpm_chip_start().
>> > > >
>> > > > Signed-off-by: Jan Dabros <jsd@semihalf.com>
>> > >
>> > > AFAIK processes are freezed before suspend callbacks are called, and
>> > > the callbacks are called sequentially. I have no idea what is meant
>> > > by "TPM accessor" here.
>> > 
>> > User space processes are freezed before suspend, but kernel threads
>> > are not freezable by default. In my particular case it was a hwrng
>> > thread started from drivers/char/hw_random/core.c - I was referring to
>> > it as "TPM accessor". For sure I should be more precise in a commit
>> > msg.
>> 
>> OK, great.
>> 
>> > 
>> > > Please describe the concurrency scenario in the commit message where the
>> > > race could happen, if it is hard to reproduce, and add an appropriate fixes
>> > > tag.
>> > 
>> > I will describe my scenario in more detail in the next version.
>> > Regarding the "fixes" tag - I'm not too familiar with it, but looking
>> > at the kernel submission guide, "fixes" should be used either when
>> > there was a particular commit in the past which introduced the bug or
>> > if a patch fixes an already logged bug entry (so that one can paste
>> > URL). In my case both are not applicable, so please advise what
>> > exactly I should put after this tag?
>> 
>> It is 
>> 
>> Fixed: <12 character prefix of the hash> ("short summary")
>> 
>> It should point out to the commit, which introduced the issue/bug.
> 
> Somebody just reported a bug to me in hwrng stuff, which I traced down
> to this lack of tpm_try_get_ops(), and then I coded up the exact same
> patch as Jan's here, saw it fixed the problem, and then realized it was
> already submitted in that exact form.
> 
> Because of some recent hwrng changes, this bug will be triggered more
> often than it was before.
> 
> So, even though Jan hasn't submitted a v+1, do you think you could take
> this 1/3 commit, fix up the commit message or whatever you need there,
> and get this in for 6.1-rc8? It's an important fix.

For the record, the bug report is here:
https://lore.kernel.org/all/c5ba47ef-393f-1fba-30bd-1230d1b4b592@suse.cz/
(patch author Jan and TPM maintainers were Cc'd)

FWIW I tested the patch 1/3 on top of rc7 and didn't reproduce the issue.
But also had no luck of reproducing it on plain rc7 yet, so it doesn't say
much, unfortunately.

> Thanks,
> Jason

