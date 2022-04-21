Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20AE850A3CE
	for <lists+linux-integrity@lfdr.de>; Thu, 21 Apr 2022 17:15:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355292AbiDUPST (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 21 Apr 2022 11:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiDUPSS (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 21 Apr 2022 11:18:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F0C32ED6;
        Thu, 21 Apr 2022 08:15:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D702061B50;
        Thu, 21 Apr 2022 15:15:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7CCCC385A5;
        Thu, 21 Apr 2022 15:15:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650554128;
        bh=dXYX28jG4L4NQMvfx7CP9y/C1JaKTliUm0ZkRga+wD8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L8CJL7qO1C5wzadWiWIJZ/CCyz15k1igx10N9spuyO0BjvBYgpiSe4NOL2CRZApiy
         rOF2nLKGoxyRDDchUNZwSBPSzV4mXXb6e3NS0J5YaGW4PL5cC3RmnDP7hiU4NAYxJV
         JEaEjfAWNe11e8SpnC3VUzp27OYqDfSPiapTAICgyLgO5CCuiIkiO51dSJQohbdB3o
         C2XqBkutfKsq5gVTkOK6fncc5bAfhfDUgEeAu0XZJBS47nkT0YTpbUb9kkcWq216IC
         OVKH/OlywNZ28aMlq5F1HmzLyjvwkBmcVHVGbiuny6cI5/ZtfDuhz7QXH8DD1Q0rSb
         WLyaA7UgrR8Sw==
Date:   Thu, 21 Apr 2022 18:14:12 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, James Morris <jmorris@namei.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?us-ascii?B?PT9pc28tODg1OS0xP1E/TWlja2E9RUJsX1NhbGE9RkNuPz0=?= 
        <mic@linux.microsoft.com>
Subject: Re: [GIT PULL] TPM DEVICE DRIVER updates for tpmdd-next-v5.18-rc4
Message-ID: <YmF0xMsEKVVfCmH6@kernel.org>
References: <Yl95wykQMHc/tIq8@kernel.org>
 <649342.1650451678@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <649342.1650451678@warthog.procyon.org.uk>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, Apr 20, 2022 at 11:47:58AM +0100, David Howells wrote:
> Jarkko Sakkinen <jarkko@kernel.org> wrote:
> 
> > Mickaël's patches to add signed hash to the blacklist keyring that were
> > left out from the original v5.18 PR. They should be safe to include to
> > rc4 as they've been in circulation for ages, and have been tested
> > throughly.
> 
> Barring a bit in patch 3 where I think strncmp() would be better employed for
> checking prefixes (and can be fixed up later):
> 
> Reviewed-by: David Howells <dhowells@redhat.com>

Thanks David.

BR, Jarkko
