Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C0E6CF5C4
	for <lists+linux-integrity@lfdr.de>; Wed, 29 Mar 2023 23:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbjC2V72 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 29 Mar 2023 17:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjC2V71 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 29 Mar 2023 17:59:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005A34229;
        Wed, 29 Mar 2023 14:59:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 557F6B820F8;
        Wed, 29 Mar 2023 21:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C092DC433EF;
        Wed, 29 Mar 2023 21:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680127164;
        bh=ljDaLKLthqQnKDSNdw368P4iGOmyLBXnc7NxO3F9wm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=THFI3avC4d9jZ2EOJjI+Iv6P7SEFAN2y+jTf1Lr7P1jpNbAJz+08OZDGZmwJ2nBsR
         O47mz4jGQi2Xqypd5JaAEXzexGycAUDNwV6cB2qbc0DwR54/xyhdDIwY0+UbWkVOOi
         4GrEWaXphePpfN8HwwqUyTkvcVCHkVXh51sTR+ZK7MiZKAOuEbcLmOZOv+szbizIln
         U+6iP43VB17Qg9T1qYL3SdChwbAWxCrxceSeGw7F/HdZEaqEAwu2B+2a3BMxGbrsI+
         wqrprCPj5pC3lwIOLpXbEgL67ePRRruye2JEylrtTiLrwWCQRoPb/af61tAIetMf+C
         99WnMexCSCIvA==
Date:   Thu, 30 Mar 2023 00:59:21 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        error27@gmail.com, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH next] tpm: Fix a possible dereference of ERR_PTR in
 tpm_init()
Message-ID: <20230329215921.2yjebtrscuo66km2@kernel.org>
References: <20230321061416.626561-1-harshit.m.mogalapalli@oracle.com>
 <ZBlkRCWAJXWkTQI2@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBlkRCWAJXWkTQI2@kroah.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Mar 21, 2023 at 09:01:08AM +0100, Greg Kroah-Hartman wrote:
> On Mon, Mar 20, 2023 at 11:14:15PM -0700, Harshit Mogalapalli wrote:
> > Smatch reports:
> > 	drivers/char/tpm/tpm-interface.c:470 tpm_init() error:
> > 	'tpm_class' dereferencing possible ERR_PTR()
> > 
> > If class_create() returns error pointer, we are dereferencing a possible
> > error pointer. Fix this by moving the dereference post error handling.
> > 
> > Fixes: a010eb881243 ("tpm: fix up the tpm_class shutdown_pre pointer when created")
> > Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> > ---
> > This is based on static analysis, only compile tested.
> 
> Thanks for this, good catch, I've queued it up in my tree now as I have
> the offending change that caused this.

OK, thank you!

BR, Jarkko
