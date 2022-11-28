Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 508BC63B278
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Nov 2022 20:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiK1TqT (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Nov 2022 14:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiK1TqS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Nov 2022 14:46:18 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0726205D7
        for <linux-integrity@vger.kernel.org>; Mon, 28 Nov 2022 11:46:17 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4DBC221BAF;
        Mon, 28 Nov 2022 19:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1669664776; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GnWuf9eKMbo/ZQxVNCABKLXYsQa/NyaTKvztPuS64Uc=;
        b=3LCkBR9r1SEOPnpdG1FlqeU131Zp60b8ltP++6Ok2kSwo+PFF4joshRTrDslYAjHjLuuXK
        GtB93k2fFMqKE74WjyuR7n3BYJBP8VFjzAORrTUZjLquDmG000RIJhpBlPLksWxuF5ZnOr
        MsSSakxvnE052TRbB7AJfYdPeVsKktU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1669664776;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GnWuf9eKMbo/ZQxVNCABKLXYsQa/NyaTKvztPuS64Uc=;
        b=Yv+fYP3BvHMbt4TnZ5r10WiB1YVknqvcE2vE36o3KF0Pb/9d53A8KmbpW9z9/OP+dPyj0o
        Ud8V8/dzv+iQ0YBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1BDD913273;
        Mon, 28 Nov 2022 19:46:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id DqEfBggQhWMBRwAAMHmgww
        (envelope-from <vbabka@suse.cz>); Mon, 28 Nov 2022 19:46:16 +0000
Message-ID: <ba0ab8be-2bce-e78e-89df-5f8898506209@suse.cz>
Date:   Mon, 28 Nov 2022 20:46:15 +0100
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
 <CAHmME9qGEHPAPwQbTu_Xv4Vx79w-3BooiX9O5wR4MtfNrTOD5g@mail.gmail.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <CAHmME9qGEHPAPwQbTu_Xv4Vx79w-3BooiX9O5wR4MtfNrTOD5g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_SOFTFAIL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/28/22 18:07, Jason A. Donenfeld wrote:
> On Mon, Nov 28, 2022 at 6:04 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
>> > >
>> > > > Please describe the concurrency scenario in the commit message where the
>> > > > race could happen, if it is hard to reproduce, and add an appropriate fixes
>> > > > tag.
>> > >
>> > > I will describe my scenario in more detail in the next version.
>> > > Regarding the "fixes" tag - I'm not too familiar with it, but looking
>> > > at the kernel submission guide, "fixes" should be used either when
>> > > there was a particular commit in the past which introduced the bug or
>> > > if a patch fixes an already logged bug entry (so that one can paste
>> > > URL). In my case both are not applicable, so please advise what
>> > > exactly I should put after this tag?
>> >
>> > It is
>> >
>> > Fixed: <12 character prefix of the hash> ("short summary")
>> >
>> > It should point out to the commit, which introduced the issue/bug.
>>
>> Somebody just reported a bug to me in hwrng stuff, which I traced down
>> to this lack of tpm_try_get_ops(), and then I coded up the exact same
>> patch as Jan's here, saw it fixed the problem, and then realized it was
>> already submitted in that exact form.
>>
>> Because of some recent hwrng changes, this bug will be triggered more
>> often than it was before.
>>
>> So, even though Jan hasn't submitted a v+1, do you think you could take
>> this 1/3 commit, fix up the commit message or whatever you need there,
>> and get this in for 6.1-rc8? It's an important fix.
>>
>> Thanks,
>> Jason
> 
> And if it helps, here's some more metadata:
> 
> Tested-by: Jason A. Donenfeld <Jason@zx2c4.com>
> Reported-by: Vlastimil Babka <vbabka@suse.cz>

You can make that:
Reported-and-tested-by: Vlastimil Babka <vbabka@suse.cz>

> Link: https://lore.kernel.org/all/c5ba47ef-393f-1fba-30bd-1230d1b4b592@suse.cz/
> Cc: stable@vger.kernel.org

Not an expert here but looks like a valid Fixes: would be
Fixes: e891db1a18bf ("tpm: turn on TPM on suspend for TPM 1.x")

The 6.1-rc1 commit 3b006c439d58d ("hwrng: core - start hwrng kthread also
for untrusted sources") likely exposed the bug in my case, but it wouldn't
be the real root cause. But it makes it prudent to get the fix to 6.1.

