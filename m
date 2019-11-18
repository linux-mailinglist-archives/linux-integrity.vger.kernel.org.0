Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA0711003B4
	for <lists+linux-integrity@lfdr.de>; Mon, 18 Nov 2019 12:22:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbfKRLWX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 18 Nov 2019 06:22:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:57826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726461AbfKRLWW (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 18 Nov 2019 06:22:22 -0500
Received: from localhost (unknown [89.205.134.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9F05D2067D;
        Mon, 18 Nov 2019 11:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574076142;
        bh=OS+6pBh0YtQl2IEclxkdgczAts6g38dIU89aC1tfCh8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SxZuuitp7F6Ngudiv5xG6ZfFvvC2t8JCgCndMiC3NygJxIm7TLIEENPZ0bMLDf6eD
         PoHu8ERtHqdo9/GcgEb97bTbcymoiigD0UX+/QqPXu9Wkxy+mKrUIO2mG04Fi8sWnD
         Q81z4dBvt4uIqaiw4BXfq9uYRNicgMfDNtwtArFY=
Date:   Mon, 18 Nov 2019 12:22:18 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     David Binderman <dcb314@hotmail.com>
Cc:     "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jarkko.sakkinen@linux.intel.com" <jarkko.sakkinen@linux.intel.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-5.4-rc8/drivers/char/tpm/tpm1-cmd.c:735: possible missing
 return value check
Message-ID: <20191118112218.GA156486@kroah.com>
References: <DB7PR08MB3801D9F4D5822D36E57282F39C4D0@DB7PR08MB3801.eurprd08.prod.outlook.com>
 <20191118092721.GA154812@kroah.com>
 <DB7PR08MB38017F9C07DA5D40B3133AED9C4D0@DB7PR08MB3801.eurprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DB7PR08MB38017F9C07DA5D40B3133AED9C4D0@DB7PR08MB3801.eurprd08.prod.outlook.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Nov 18, 2019 at 09:42:01AM +0000, David Binderman wrote:
> Hello there Greg,
> 
> >Great, how about you submit a patch to resolve this?  That way you can
> >get the full credit for finding and resolveing the issue?
> 
> No thanks. I gave up bothering to send in patches when I found
> out my emails cc'ing to the linux kernel mailing list get bounced.

Yes, hotmail.com emails have been rejected from there for many years.
If you wish to contribute to the kernel you need to use a different
email domain, sorry.

good luck!

greg k-h
