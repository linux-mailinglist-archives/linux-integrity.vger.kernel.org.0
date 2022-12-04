Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 905B7641E0E
	for <lists+linux-integrity@lfdr.de>; Sun,  4 Dec 2022 17:53:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbiLDQxK (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 4 Dec 2022 11:53:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiLDQxK (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 4 Dec 2022 11:53:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED9749FF3;
        Sun,  4 Dec 2022 08:53:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9B992B80ACA;
        Sun,  4 Dec 2022 16:53:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E33C8C433D6;
        Sun,  4 Dec 2022 16:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670172786;
        bh=VrQ5fq3fx8KuNp5ylQozI8eq9+U1u9UGalGdEsSX4Uo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tPeu7ur/3uKq+L7UxoYaswwZ8SEoX8GJJ5s/Ph/GHWIwQXek8Aekie7sg35laiMm0
         UZsBtQadTd75MJfzHeheSa1NMdjg7l4tKK2bmCdluvFzGcdKtXi67JYnwpqerbkHpK
         b56htLXh6LRJfsIpNlwfqvWu9d8Wv2abETHGXWJljLrrDvuheQT2lgTDLGVvBgm0TH
         mkIEgcDjiVomeQ3EvK7MtgKzt8pr5Ag2vkFDnfsUf3kbMbMIKR0kY1GHM+279yqB+F
         XADDeyjKn6S95KWZzBg6yzwkqidBA065TbpLGthNz3hjhR29jzGnFtktY/oWUJiXWO
         d/tNlllyfzbGA==
Date:   Sun, 4 Dec 2022 16:53:01 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Eric Snowberg <eric.snowberg@oracle.com>,
        keyrings@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Pearson <markpearson@lenovo.com>,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 1/3] certs: log hash value on blacklist error
Message-ID: <Y4zQbWJZpJV7KTTJ@kernel.org>
References: <20221118040343.2958-1-linux@weissschuh.net>
 <20221118040343.2958-2-linux@weissschuh.net>
 <Y4QK2cmptp4vpRj/@kernel.org>
 <8b9e9bf8-ae44-485a-9b30-85a71a236f06@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b9e9bf8-ae44-485a-9b30-85a71a236f06@t-8ch.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 28, 2022 at 02:59:20AM +0100, Thomas Weißschuh wrote:
> On 2022-11-28 03:11+0200, Jarkko Sakkinen wrote:
> > "Make blacklisted hash available in klog"
> > 
> > On Fri, Nov 18, 2022 at 05:03:41AM +0100, Thomas Weißschuh wrote:
> > > Without this information these logs are not actionable.
> > 
> > Without blacklisted hash?
> > 
> > > For example on duplicate blacklisted hashes reported by the system
> > > firmware users should be able to report the erroneous hashes to their
> > > system vendors.
> > > 
> > > While we are at it use the dedicated format string for ERR_PTR.
> > 
> > Lacks the beef so saying "while we are at it" makes no sense.
> 
> What about this:
> 
>   [PATCH] certs: make blacklisted hash available in klog
> 
>   One common situation triggering this log statement are duplicate hashes
>   reported by the system firmware.
> 
>   These duplicates should be removed from the firmware.
> 
>   Without logging the blacklisted hash triggering the issue however the users
>   can not report it properly to the firmware vendors and the firmware vendors
>   can not easily see which specific hash is duplicated.
> 
>   While changing the log message also use the dedicated ERR_PTR format
>   placeholder for the returned error value.

Looks looks a lot better thank you!

> > > Fixes: 6364d106e041 ("certs: Allow root user to append signed hashes to the blacklist keyring")
> > 
> > Why does this count as a bug?
> 
> These error logs are confusing to users, prompting them to waste time
> investigating them and even mess with their firmware settings.
> (As indicated in the threads linked from the cover letter)
> 
> The most correct fix would be patches 2 and 3 from this series.
> 
> I was not sure if patch 2 would be acceptable for stable as it introduces new
> infrastructure code.
> So patch 1 enables users to report the issue to their firmware vendors and get
> the spurious logs resolved that way.
> 
> If these assumptions are incorrect I can fold patch 1 into patch 3.
> 
> But are patch 2 and 3 material for stable?

I cannot say anything conclusive to this before seeing updated version of
the patch set.

BR, Jarkko
