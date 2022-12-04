Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90360641E15
	for <lists+linux-integrity@lfdr.de>; Sun,  4 Dec 2022 17:59:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbiLDQ76 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 4 Dec 2022 11:59:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiLDQ75 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 4 Dec 2022 11:59:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA65312D27
        for <linux-integrity@vger.kernel.org>; Sun,  4 Dec 2022 08:59:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92827B80AFA
        for <linux-integrity@vger.kernel.org>; Sun,  4 Dec 2022 16:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0334CC433D6;
        Sun,  4 Dec 2022 16:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670173194;
        bh=ccXtbzK9TVgt0JBPkIX/alc1R86GWWZZHZ+NjBAueXA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ge4EDCQ3lwFdmTEvlky6S8B/G2TejqJkeKcX7scwL0pzQQMkVmafBtips+QcTOmB0
         tzIQBqNUTN6SwbCUUqXTj8YMODLNUqTJO7Bd5etsV0BNGtt4OGcj2gxHZ7NT43D+6i
         kXuWlTbdgMbjHP8OwMeiiPYC81A9yuNiMw8OCX+pYUd6z5e5l7MhG8Pmm8DzWI8cn9
         yFgZEL8FnxSlwNyEY+ZHTytW5CzjqcKecZvjrvKfpOMFUpbtFlCwfOg8q14YXKilru
         wGQXplgshLTUoURY1wdyfWUxvpomv8wXNO9MbA+9NQ+vrSwyowp5H475cg6JlDzwro
         Cif+cDjm3xJlg==
Date:   Sun, 4 Dec 2022 16:59:49 +0000
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Maxim Uvarov <maxim.uvarov@linaro.org>
Cc:     Yuan Can <yuancan@huawei.com>, peterhuewe@gmx.de, jgg@ziepe.ca,
        sumit.garg@linaro.org, jens.wiklander@linaro.org,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm/tpm_ftpm_tee: Fix error handling in ftpm_mod_init()
Message-ID: <Y4zSBeCDDlcrzyWd@kernel.org>
References: <20221124031926.16963-1-yuancan@huawei.com>
 <Y4QNhBTwC9M9hXm4@kernel.org>
 <CAD8XO3YWE50kq3U-tJ=Xjq0UvhGn_t8C0QPcTX+wTDME7STJjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD8XO3YWE50kq3U-tJ=Xjq0UvhGn_t8C0QPcTX+wTDME7STJjg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 28, 2022 at 09:42:15AM +0300, Maxim Uvarov wrote:
> yea, for backward compatibility both platfrom_driver and driver_ were
> supported. Maybe it's time to reconsider this now...
> Thanks for the clean up fix.
> 
> Reviewed-by: Maxim Uvarov <maxim.uvarov@linaro.org>

Applied to git://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git

> Best regards,
> Maxim.

BR, Jarkko
