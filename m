Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C2B58C9B2
	for <lists+linux-integrity@lfdr.de>; Mon,  8 Aug 2022 15:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243198AbiHHNpX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 8 Aug 2022 09:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243134AbiHHNpW (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 8 Aug 2022 09:45:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F5F73893;
        Mon,  8 Aug 2022 06:45:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B55D3B80EA1;
        Mon,  8 Aug 2022 13:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A234BC433C1;
        Mon,  8 Aug 2022 13:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659966317;
        bh=a8EU6eGbgWuI9B2ElfWOtvEkJxdtJvEBO0Sx4mMYwzQ=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=WUDcfYUE+/C4GY6bP96exqGCPwib378v8h7/9uULoLgZoE79oHM1LRomIjlcgYXyF
         K0X2cIl9VnrgViNfDMgNoxN27Wm6QAnfdMhjI5k7lmaLdcKGQ5beT8NzRrKzwKQ+dA
         z59FI6SO+Ebrjqq8alLtSjRYBWScRi5ERU5oaTzdqNmxflnBu1d7Bl+KX/XR75ZfKT
         qLCKHvvG/wLoug+BtNFCclMWF158zRgKBGXrwiiDj3erDjvrUlWrUHlQN2LvH6meT3
         +QlLqcKys0DjKDv2jO+6Tzo7zlgEWgdm28QAf3gwBxBoG92YA1TSU87I3VILlpixVX
         LVvYNJ2q4tjPA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Howells <dhowells@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [GIT PULL] tpmdd updates for v5.20
References: <20220803210228.158993-1-jarkko@kernel.org>
        <87pmhgikhk.fsf@kernel.org>
        <5653318a776a8044f413ed1a4b6e3965fac2297e.camel@HansenPartnership.com>
        <87czdfi6t9.fsf@kernel.org> <Yu6qQHMoBzC4zprg@kernel.org>
Date:   Mon, 08 Aug 2022 16:45:12 +0300
In-Reply-To: <Yu6qQHMoBzC4zprg@kernel.org> (Jarkko Sakkinen's message of "Sat,
        6 Aug 2022 20:52:00 +0300")
Message-ID: <87o7wun91z.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Jarkko Sakkinen <jarkko@kernel.org> writes:

>> Odd, I haven't noticed any UTF-8 problems in my setup but Gnus/Emacs is
>> known to be picky. After some more investigation I noticed this in
>> Jarkko's email:
>> 
>> Content-Type: text/plain; charset=y
>> 
>> I admit I'm not up to par with the latest cool stuff but that charset
>> can't be valid, right? :)
>
> I must have pressed 'y' and enter, instead of enter,
> when git send-email asked whether to use UTF-8 or
> something like that.
>
> Sorry about that :-) I don't recall doing that but
> that is what it looks like for me.

Hehe, that indeed sounds likely. Thanks, I was curious where that 'y'
came from :)

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
