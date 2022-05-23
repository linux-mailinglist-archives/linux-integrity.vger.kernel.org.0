Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35DB5531A30
	for <lists+linux-integrity@lfdr.de>; Mon, 23 May 2022 22:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbiEWT75 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 23 May 2022 15:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbiEWT75 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 May 2022 15:59:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AD8479820;
        Mon, 23 May 2022 12:59:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3EDEB80EAA;
        Mon, 23 May 2022 19:59:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23513C385A9;
        Mon, 23 May 2022 19:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653335993;
        bh=d5brdACY8CA8bzcrEJw+qY/SVjsXaiPFVho7oEehSto=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jfcQA9YK7jXWhtWLg3DK6jp3yOr1QUm1ccl8+m5gZdLKK/eM8sztmt5dsGysxJ2nt
         QMdXzQZjQZpHeYv/MAQ3p6RICbIOloTslytaTWHxP5ZNbrNF4Wil1sCNuk+Qml5stt
         UsRNfSjS+9gnoN+7lfduEwkDiv7u+40SRmH9WdcrxB2Hefavd+Gl2HxSpXwPqytC0B
         lDC0AFM73gdssjFkBuaMWjvksa2fLwUH+EazehRxWmP9OWxvQM5KXouFb7wjQOFuSP
         VY0+6cxWWmGu4aQWjgX5E+S5EbiT/egQqQNROrbBtI/ODmqNLj1y3dmynhxAZAOHQJ
         ixR3kTLl601aA==
Date:   Mon, 23 May 2022 22:58:12 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     "Guozihua (Scott)" <guozihua@huawei.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, keyrings@vger.kernel.org
Subject: Re: [PATCH] keys: Use struct_size and size_add helper with alloc
Message-ID: <YovnVMxsd2aZ9hF8@kernel.org>
References: <20220519024702.215223-1-guozihua@huawei.com>
 <YoatVbXu5g6f7gD7@iki.fi>
 <0563f30f-f5c5-f202-9091-a8ce095057e5@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0563f30f-f5c5-f202-9091-a8ce095057e5@huawei.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, May 20, 2022 at 03:35:09PM +0800, Guozihua (Scott) wrote:
> On 2022/5/20 4:49, Jarkko Sakkinen wrote:
> > On Thu, May 19, 2022 at 10:47:02AM +0800, GUO Zihua wrote:
> > > Use struct_size helper for calculating size of flexible struct to avoid
> > > potential issues and improve readibility. Use size_add to calculate
> > > addition of size to prevent potential issues.
> > 
> > What issues? Please explicitly state the issues.
> > 
> > BR, Jarkko
> > .
> 
> Hi Jarkko,
> 
> This is a clean-up/optimization patch mostly focuses on readability and no
> actual issue is observed at the moment.

But the commit message is talking about potential issues.

BR, Jarkko
