Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6256D600AD3
	for <lists+linux-integrity@lfdr.de>; Mon, 17 Oct 2022 11:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231335AbiJQJdC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 17 Oct 2022 05:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiJQJcu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 17 Oct 2022 05:32:50 -0400
X-Greylist: delayed 358 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 17 Oct 2022 02:32:48 PDT
Received: from smtp-bc0a.mail.infomaniak.ch (smtp-bc0a.mail.infomaniak.ch [IPv6:2001:1600:4:17::bc0a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3234F39C
        for <linux-integrity@vger.kernel.org>; Mon, 17 Oct 2022 02:32:48 -0700 (PDT)
Received: from smtp-2-0001.mail.infomaniak.ch (unknown [10.5.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4MrWpZ0skczMq6HQ;
        Mon, 17 Oct 2022 11:26:46 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4MrWpX6ttJzMppMq;
        Mon, 17 Oct 2022 11:26:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1665998806;
        bh=Dtqqx/if1ibvMMPRjJERffrtCsRUnCY7m3rsjyXBRgM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZXlehtNi2gROMyNPvpn6xEoGYafMaWeNVUohoi9gv1Z4tBj0H/9jnrJ5/voT2jG4y
         LBugl+JkVyZXe5aAVsNkGo5lqG8xC04RjwAsOu046lQhjfSnh2SaV0yVJbyLBGznpH
         02GvexwKNa0ZQ7DAq2kAwMOrfv5LdSU1KP9zpX7w=
Message-ID: <0d2b9d34-2eda-8aa6-d596-eb1899645192@digikod.net>
Date:   Mon, 17 Oct 2022 11:26:44 +0200
MIME-Version: 1.0
User-Agent: 
Subject: Re: [PATCH 1/9] integrity: Prepare for having "ima" and "evm"
 available in "integrity" LSM
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>
Cc:     Mimi Zohar <zohar@linux.ibm.com>, Paul Moore <paul@paul-moore.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        linux-security-module@vger.kernel.org,
        linux-integrity@vger.kernel.org, KP Singh <kpsingh@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
References: <20221013222702.never.990-kees@kernel.org>
 <20221013223654.659758-1-keescook@chromium.org>
 <08a8b202-69b4-e154-28f5-337a898acf61@digikod.net>
 <202210141050.A8DF7D10@keescook>
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
In-Reply-To: <202210141050.A8DF7D10@keescook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org


On 14/10/2022 19:59, Kees Cook wrote:
> On Fri, Oct 14, 2022 at 04:40:01PM +0200, Mickaël Salaün wrote:
>> This is not backward compatible
> 
> Why? Nothing will be running LSM hooks until init finishes, at which
> point the integrity inode cache will be allocated. And ima and evm don't
> start up until lateinit.
> 
>> , but can easily be fixed thanks to
>> DEFINE_LSM().order
> 
> That forces the LSM to be enabled, which may not be desired?

This is not backward compatible because currently IMA is enabled 
independently of the "lsm=" cmdline, which means that for all installed 
systems using IMA and also with a custom "lsm=" cmdline, updating the 
kernel with this patch will (silently) disable IMA. Using ".order =
LSM_ORDER_FIRST," should keep this behavior.

BTW, I think we should set such order (but maybe rename it) for LSMs 
that do nothing unless configured (e.g. Yama, Landlock).


> 
>> Side node: I proposed an alternative to that but it was Nacked:
>> https://lore.kernel.org/all/20210222150608.808146-1-mic@digikod.net/
> 
> Yeah, for the reasons pointed out -- that can't work. The point is to
> not have The Default LSM. I do think Casey's NAK was rather prickly,
> though. ;)

I don't agree, there is no "the default LSM", and this new behavior is 
under an LSM_AUTO configuration option.
