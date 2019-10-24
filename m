Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38CD0E3BD3
	for <lists+linux-integrity@lfdr.de>; Thu, 24 Oct 2019 21:11:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390786AbfJXTLd (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 24 Oct 2019 15:11:33 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:43543 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390839AbfJXTLd (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 24 Oct 2019 15:11:33 -0400
Received: by mail-qk1-f196.google.com with SMTP id a194so20390256qkg.10
        for <linux-integrity@vger.kernel.org>; Thu, 24 Oct 2019 12:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ks1e0HacBXB8L5bemV2sH9KBhSB1vMv/PFafjR7LxiI=;
        b=GJe2G3KtpfbNJJuUouQKkkv3hltvAH3sCIZDE1wttL+QTAdIWIvOqdscjRoSUgTb6G
         Dm93IbJpj1YHW+GkxdBPclgXVveqM98+BctB1PuC7RElcaC2C9mqKX0AAmdyZgNPUUQt
         w3jhAf1EVaPt++N5pGXZuxgl+O0DbJo2VDc1lE/iXnUobi4r0u/tyQ6L3dZFiQMFnnzY
         pPx93FBrDfrXcwz0fy3VZdmxxL7xPq2x5ELTJuf+f8bA0pyBT0BbeWT+Ntg2R9aNM1bN
         vZLOcm7v63c1a5m3LbD5mNj6vwTnZSKpT5vwweKdIaHPJOoYpCeYpDvn2dDlGpLQnYNI
         m+bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ks1e0HacBXB8L5bemV2sH9KBhSB1vMv/PFafjR7LxiI=;
        b=CnK4JwHvPWq5srw985lAQLF+An8XOXPDXVB4l/pkOssCorEUlnEHtNaHePyDgSDK65
         tTa8b0ENFxIsULSWMIbyXwZaH37upc5fOEweIpjblUAV29YuAWeUXIv0on9JYbF8ni5g
         Xf8b9sSbH6wffWY3d0jMSpa9E4oqwbmx0VjuckMu3DUJ/ryNUSmfhWgwE2q6ppWievAo
         mPDrpPhGnbU3Z/5W9yCf/bTVP1lMLKymzkXUZTXKpB5tPBksYRki2PPsJKujcDvHjiRY
         al6poivEMeltM/0Ps7+UlVyqs0P2viBcy2bHyeUhsNUl2OKcfU9tkGiKiXsMiNsYEV3t
         Bujw==
X-Gm-Message-State: APjAAAVG3aiMNzq7/rnijrPaqzzHApVNobz8zAfDMDyVH51kpJN4Z5VR
        BpSFHNZN8jZDHBaFHOH78yoQh6VUL5c=
X-Google-Smtp-Source: APXvYqzy93zjMo9026HgWRK2/o7c1akpxq561kc8KDmLR9SugFVZo2L9MH8msJTYcPWhA+VdQ1934g==
X-Received: by 2002:a05:620a:200f:: with SMTP id c15mr13517958qka.263.1571944292071;
        Thu, 24 Oct 2019 12:11:32 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id f21sm12793101qte.36.2019.10.24.12.11.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 12:11:31 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iNiWB-0005Bu-7m; Thu, 24 Oct 2019 16:11:31 -0300
Date:   Thu, 24 Oct 2019 16:11:31 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Peter Huewe <peterhuewe@gmx.de>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-integrity@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] tpm: Switch to platform_get_irq_optional()
Message-ID: <20191024191131.GD23952@ziepe.ca>
References: <20191019094528.27850-1-hdegoede@redhat.com>
 <20191021154942.GB4525@linux.intel.com>
 <80409d36-53fa-d159-d864-51b8495dc306@redhat.com>
 <20191023113733.GB21973@linux.intel.com>
 <d6adeb21-f7b3-5c64-fa32-03a8ee21cc53@redhat.com>
 <20191024142519.GA3881@linux.intel.com>
 <c6a0c3e3-c5c8-80d9-b6b6-bf45d66f4b32@redhat.com>
 <20191024190942.GA12038@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191024190942.GA12038@linux.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, Oct 24, 2019 at 10:09:42PM +0300, Jarkko Sakkinen wrote:
> Why do you think that way?
> 
> I mean the commit does not even have a fixes line. It already obviously
> implies that this kind of discussion is mandatory. Your reasoning in
> this discussion does make sense. The problem is really the commit
> message supplied.
> 
> I'd guess something like this would be more appropriate:
> 
> "
> platform_get_irq() calls dev_err() on an error. As the IRQ usage in the
> tpm_tis driver is optional, this is undesirable.
> 
> Specifically this leads to this new false-positive error being logged:
> [    5.135413] tpm_tis MSFT0101:00: IRQ index 0 not found
> 
> This commit switches to platform_get_irq_optional(), which does not log
> an error, fixing this.
> 
> Fixes: 7723f4c5ecdb ("driver core: platform: Add an error message to platform_get_irq*()"
> Cc: <stable@vger.kernel.org> # 5.4.x
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> "

This is much better, yes

Jason
