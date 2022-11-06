Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B16161E5B4
	for <lists+linux-integrity@lfdr.de>; Sun,  6 Nov 2022 20:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiKFTtI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 6 Nov 2022 14:49:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbiKFTtH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 6 Nov 2022 14:49:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CCD10B5A
        for <linux-integrity@vger.kernel.org>; Sun,  6 Nov 2022 11:49:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 024DCB80C99
        for <linux-integrity@vger.kernel.org>; Sun,  6 Nov 2022 19:49:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31D26C433D6;
        Sun,  6 Nov 2022 19:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667764143;
        bh=kq6hwWijdYijurm/EVOcZmR02KOQMSkCa0/b7m29JJQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IVYx5OS2T17vDTwMYIjSoiHnrd2uy/EiXA0hWX0nHbBCi+R4rQCs0n4fGfuJedv4M
         a0QuqhunkAN+icDf+MblRlRXaj3UG00DCxmcN0SJXG7jyxTsuvCnTnA6Ng1xtMrjQP
         mXVGJQjD4RQOnIIrlLdpGt/KiFnDSWSffASVaP6vfZm6IrsLnfJJmGr6JgR6R49WyS
         y3H8mnkBk98e9Pwog9YGf4QAsbJPSN1vqLv+d3uhmAedOhyDm279Sw4V0uVM4QtJ+v
         ZePzbzppa2ytA0NF8TauZYHz6TQrQv3UIaRLG1QK0Uf94QEdeCgU8GxsJ+L7X/SyKL
         EH7I8H1+/+yfw==
Date:   Sun, 6 Nov 2022 21:48:40 +0200
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jan Dabros <jsd@semihalf.com>
Cc:     linux-integrity@vger.kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        gregkh@linuxfoundation.org, arnd@arndb.de, rrangel@chromium.org,
        timvp@google.com, apronin@google.com, mw@semihalf.com,
        upstream@semihalf.com
Subject: Re: [PATCH v2 1/3] char: tpm: Protect tpm_pm_suspend with locks
Message-ID: <Y2f/pExGdDBGhNZA@kernel.org>
References: <20221103145450.1409273-1-jsd@semihalf.com>
 <20221103145450.1409273-2-jsd@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221103145450.1409273-2-jsd@semihalf.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Nov 03, 2022 at 03:54:48PM +0100, Jan Dabros wrote:
> Currently tpm transactions are executed unconditionally in
> tpm_pm_suspend() function, what may lead to races with other tpm
> accessors in the system.
> 
> Add proper locking mechanisms by calling tpm_try_get_ops() which is a
> wrapper on tpm_chip_start().
> 
> Signed-off-by: Jan Dabros <jsd@semihalf.com>

AFAIK processes are freezed before suspend callbacks are called, and
the callbacks are called sequentially. I have no idea what is meant
by "TPM accessor" here.

Please describe the concurrency scenario in the commit message where the
race could happen, if it is hard to reproduce, and add an appropriate fixes
tag.

BR, Jarkko
