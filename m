Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA40865EA29
	for <lists+linux-integrity@lfdr.de>; Thu,  5 Jan 2023 12:48:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232489AbjAELsL (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 5 Jan 2023 06:48:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjAELr5 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 5 Jan 2023 06:47:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442A432EA6;
        Thu,  5 Jan 2023 03:47:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F12CBB81A84;
        Thu,  5 Jan 2023 11:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BFE2C433EF;
        Thu,  5 Jan 2023 11:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1672919273;
        bh=oNfWrEPCiHQST5cocxzmT9ZQcaQCcXc7x+DILDnIpjk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C+tkXKy5RxCAYALt8fPld5rv9FncmfkytY5XW2znWolDgOZHLqEwaQovHl69Huq8U
         0vOev2QW6Zjni5Rf22boH9PwTVEpXavoRvFl2hRTAzmAVTbPsmzv6XK13whmK4iRk1
         ZlGzfFn/6Q33o298Wt4FT3pgjafAw1bfJ8moa8PU=
Date:   Thu, 5 Jan 2023 12:47:50 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     GUO Zihua <guozihua@huawei.com>
Cc:     stable@vger.kernel.org, zohar@linux.ibm.com, paul@paul-moore.com,
        linux-integrity@vger.kernel.org, luhuaxin1@huawei.com
Subject: Re: [PATCH v6 0/3] ima: Fix IMA mishandling of LSM based rule during
Message-ID: <Y7a45tx4tvV6hDuC@kroah.com>
References: <20230105062312.14325-1-guozihua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105062312.14325-1-guozihua@huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Jan 05, 2023 at 02:23:09PM +0800, GUO Zihua wrote:
> Backports the following three patches to fix the issue of IMA mishandling
> LSM based rule during LSM policy update, causing a file to match an
> unexpected rule.
> 
> v6:
>   Removed the redundent i in ima_free_rule().

Given the huge numbers of revisions in this series, I suggest working
together with the relevant subsystem maintainers to get a final,
working, agreed-apon version before submitting it again.

thanks,

greg k-h
