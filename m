Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9945327B487
	for <lists+linux-integrity@lfdr.de>; Mon, 28 Sep 2020 20:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbgI1Sdy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 28 Sep 2020 14:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgI1Sdy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 28 Sep 2020 14:33:54 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D46C061755
        for <linux-integrity@vger.kernel.org>; Mon, 28 Sep 2020 11:33:53 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id ef16so968189qvb.8
        for <linux-integrity@vger.kernel.org>; Mon, 28 Sep 2020 11:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=p+SpF48k8xH8DSde5J8/cC12uw3Ut6dROoiyEJjAI9g=;
        b=RBX2JCJ8ATRX5ix/Go18ipPfTmPFLrWdbz5tnkyOoHn+Jrn3wB4wruLKgDTrp2BeMf
         fF0gWtKTo1TNOmDi0+v55TCW+aUaw/ckMkg3HDVy21g7i70TpQ+Q1+Mm6oapsqEuQdFa
         h62vcmFpPmv10c/gjmvRC8MFVOb6w3oqH6IhEoLeZTmYVgSrdnoBRWxramRdye4PtouO
         uZPCSOG6hUUkPnN0yfYYe0p+6SnnLn183aAmROiNHAllWK8psCzBLgad979cE+NstpM8
         b4oy6emlB+LXl11DCPcCAbXab96CwbnYDywR5NhoJVqw8JrOdxIWSVFTbgWrhugqWXHv
         KA7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=p+SpF48k8xH8DSde5J8/cC12uw3Ut6dROoiyEJjAI9g=;
        b=k1Uazo7MLuJ35bkemwzdUWPWcRcJwzSEjt6Yv3xI/usm7v2RESYpaIuFs+8TO0Ooxd
         /SEYLdJ8V7Z8/M4dR6iQWFliq2gtHFMgnTZfylB8mf47q4FND3BAppaMjFJ6SZnp4L7j
         Wk8Sri0pyYlq/iWHDviiywDbOC4UWOkDJ7NZ4EfIK4dS5/2NmfVG7kOWkONmHBMFa/0H
         nFdfJ96F//jVWV6jRwZLsWAZ5vlLwSijhgGX2pERfTbac2thactT2kQhwnx0hsoTpetr
         AnPTu3yXj3PYc3Dr+1zpDQnTjUN2TpWuorv3EtvsSFWnOJVcAFK8MLtDSIo6IbXLKkZD
         MCKw==
X-Gm-Message-State: AOAM532N53yjmP5N71jSUZvxSh9qRPG4yPzrKB+yEwOf6XCJy8ul3ias
        Do3a2sB5pEtfuT9wUCOIi3IzbncBfgOhD6ON
X-Google-Smtp-Source: ABdhPJzhNFJODnQQwM8iQOmkMSDHtv1NUlP57/e0B3fdqXG4wQ4Pa7Ie19rd2X5wFwIKQ6ErWMvjvQ==
X-Received: by 2002:a0c:e5cf:: with SMTP id u15mr789369qvm.24.1601318033135;
        Mon, 28 Sep 2020 11:33:53 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id 10sm1868616qkk.88.2020.09.28.11.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 11:33:52 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kMxyB-002T2a-QB; Mon, 28 Sep 2020 15:33:51 -0300
Date:   Mon, 28 Sep 2020 15:33:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>
Subject: Re: [PATCH] tpm_tis: Add a check for invalid status
Message-ID: <20200928183351.GA587339@ziepe.ca>
References: <9bad3da0c31ae2620aaae0d75748c3387afa3d47.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9bad3da0c31ae2620aaae0d75748c3387afa3d47.camel@HansenPartnership.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 28, 2020 at 11:00:12AM -0700, James Bottomley wrote:
> Some TIS based TPMs can return 0xff to status reads if the locality
> hasn't been properly requested.  Detect this condition by checking the
> bits that the TIS spec specifies must return zero are clear and return
> zero in that case.  Also drop a warning so the problem can be
> identified in the calling path and fixed (usually a missing
> try_get_ops()).
> 
> Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> 
> This is the patch I've been using to catch and kill all the points in
> the stack where we're not properly using get/put ops on the tpm chip.

If this is a problem add a lockdep on ops_sem in various places too?

Jason
