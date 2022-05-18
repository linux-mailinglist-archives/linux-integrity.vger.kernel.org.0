Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9978352BDC8
	for <lists+linux-integrity@lfdr.de>; Wed, 18 May 2022 17:25:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238870AbiERO4N (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 18 May 2022 10:56:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239010AbiEROze (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 18 May 2022 10:55:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE28AF1D9;
        Wed, 18 May 2022 07:55:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8CD6560DC0;
        Wed, 18 May 2022 14:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4268FC385AA;
        Wed, 18 May 2022 14:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652885726;
        bh=y/nVf707/t+pKLmjuo0j1M7q/g28bwWk29Oh1R8DBz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=guZ+Xxyh9gOkTE0/y4ptl2ieLoWdWs8y2aB+SXXif8B4B9IuEuRDrUwRsuZXklT3N
         ul7wcMyOzBlrEmtToMcUWRw6rfipS9zgxXnmXFTpOSCBZ761OnPlfU2BzgzIXwH76q
         UibMwKzOH1hdVomum7sS+fYiLUEaXUMIn40NKQsVnGERenGbm4F81BOboZHxe7IpVY
         9jcmA4cH5OZTL2Z0LvDg1fLiu10iBYaPRrKvSxHCASViIEXxHCE5CmrvlRP5WYYOHp
         DeKdQsmHEOGj7bJ9CnOGrFR1d9SAn9QbK0l0othc6qYTacv6/1dm5sOEVVlGMoSM/b
         Y7FqFC23QbMUQ==
Date:   Wed, 18 May 2022 17:57:07 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Juergen Gross <jgross@suse.com>
Cc:     xen-devel@lists.xenproject.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v3 15/21] xen/tpmfront: use xenbus_setup_ring() and
 xenbus_teardown_ring()
Message-ID: <YoUJQ5KQYZyG4gj3@iki.fi>
References: <20220505081640.17425-1-jgross@suse.com>
 <20220505081640.17425-16-jgross@suse.com>
 <YnWh6P7kBtPa2aTA@kernel.org>
 <642471c7-f717-2ef4-1d6d-6fabf57db08f@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <642471c7-f717-2ef4-1d6d-6fabf57db08f@suse.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 18, 2022 at 11:41:51AM +0200, Juergen Gross wrote:
> On 07.05.22 00:32, Jarkko Sakkinen wrote:
> > On Thu, May 05, 2022 at 10:16:34AM +0200, Juergen Gross wrote:
> > > Simplify tpmfront's ring creation and removal via xenbus_setup_ring()
> > > and xenbus_teardown_ring().
> > > 
> > > Signed-off-by: Juergen Gross <jgross@suse.com>
> > 
> > Please add to the commit message why these provide an equivalent
> > functionality.
> 
> Would you be fine with:
> 
>   Simplify tpmfront's ring creation and removal via xenbus_setup_ring()
>   and xenbus_teardown_ring(), which are provided exactly for the use
>   pattern as seen in this driver.
> 
> 
> Juergen

Looks fine to me!

BR, Jarkko




