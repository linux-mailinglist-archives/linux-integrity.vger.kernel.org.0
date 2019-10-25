Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2290FE5465
	for <lists+linux-integrity@lfdr.de>; Fri, 25 Oct 2019 21:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727252AbfJYTcq (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 25 Oct 2019 15:32:46 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:40552 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbfJYTcq (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 25 Oct 2019 15:32:46 -0400
Received: by mail-qk1-f194.google.com with SMTP id y81so2815201qkb.7
        for <linux-integrity@vger.kernel.org>; Fri, 25 Oct 2019 12:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=iz1ZKgeeP9IMy1jysqX68USYM4mMvFqFgNxXC+uayME=;
        b=c1sbAsOY9I0jzJgCr1l/kqQ+VtQvCVtPe7r2afQuXcUDwtiA5pMnNUsCNT1CXsaUss
         +1nfSq02QINb5Fqu/sdAZCkiHEtQwGqG26VnnvLvIyrv8enGjT1JAgsKOWd8P0OOznn3
         DXWy4OYWtH1Wyyv6LAz8sElnukuxF/Uz+0ntGWDcxuKTix34ZG6l+C5Wi2aLlV7LJSQR
         MZL8dmwTHlkhSAjkw2AiFvrseEZZhJozEdvAoObH+vuvba/yhvDNEHRukJlWxf2QlbOs
         4ADXV4nI1ryhZV2t7JXE3hwdmMXa9TtlqNN1LZCSitQF5F72chbKFbWjA4U4sxgs+DlL
         QPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=iz1ZKgeeP9IMy1jysqX68USYM4mMvFqFgNxXC+uayME=;
        b=D2ve9sOo+vnHYvDtIg2fESF9tnjGxpUG7tgBkT8y06bhS0cJRtxhLTFA/iTg/CRk1d
         tro1R1R/rRu72t3fizD5I8VphbRZSeHeg2rMwwAJ6ODOwdgn8VOe+NwszsYLi+k/S6zr
         LVLn2xQCyC6hBCOj+3v8IxcizMkELbOKuIYxFVh45bcPWQQhEm3/h2fxCSYBJs0U2EwE
         elbakUU+Hj5ooAnf/BY/8y4K9bJGFEip68M58wuZjP16JgFBicvRb5sV0jVAIlhftqR7
         yjoN+WVbkePevQZCBPoJC9PMj9jHCSoBnV3Oktw9EnPY62g+zRh97bQz8q+sipBYvVZE
         Wa2Q==
X-Gm-Message-State: APjAAAWZ5RXJ1X4kUFyY36PUr9HJ6BLA5p2IucNr6daI72SSAQ8NCzGz
        tdcv0/qodcJekX+QkKHBrq1DBw==
X-Google-Smtp-Source: APXvYqwnox1bvRxbaAC3dNVKNlUpLPIQdPSHTrzN3ZgFbHEYJbFlmhocZZFdkqQoARkHnIOSh1I9jQ==
X-Received: by 2002:a37:a391:: with SMTP id m139mr4751542qke.234.1572031964194;
        Fri, 25 Oct 2019 12:32:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id q44sm2659476qtk.16.2019.10.25.12.32.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 25 Oct 2019 12:32:43 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iO5KF-0008P1-5P; Fri, 25 Oct 2019 16:32:43 -0300
Date:   Fri, 25 Oct 2019 16:32:43 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm: Add major_version sysfs file
Message-ID: <20191025193243.GI23952@ziepe.ca>
References: <20191025142847.14931-1-jsnitsel@redhat.com>
 <1572027516.4532.41.camel@linux.ibm.com>
 <20191025184522.5txabdikcrn2dgvj@cantor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191025184522.5txabdikcrn2dgvj@cantor>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Oct 25, 2019 at 11:45:22AM -0700, Jerry Snitselaar wrote:
> On Fri Oct 25 19, Mimi Zohar wrote:
> > On Fri, 2019-10-25 at 07:28 -0700, Jerry Snitselaar wrote:
> > > Easily determining what TCG version a tpm device implements
> > > has been a pain point for userspace for a long time, so
> > > add a sysfs file to report the tcg version of a tpm device.
> > 
> > Use "TCG" uppercase consistently.
> >  
> > > 
> > > Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
> > > Cc: Peter Huewe <peterhuewe@gmx.de>
> > > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > > Cc: linux-integrity@vger.kernel.org
> > > Signed-off-by: Jerry Snitselaar <jsnitsel@redhat.com>
> > 
> > thanks!
> > 
> > Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> > 
> > FYI, on my system(s) the new file is accessible as
> > /sys/class/tpm/tpm0/version_major.  Does this need to be documented
> > anywhere?
> > 
> > 
> 
> Yes, there should be an entry added to
> Documentation/ABI/stable/sysfs-class-tpm.
> I will fix that up and the TCG not being uppercase in a v2.
> 
> Should Documentation/ABI/stable/sysfs-class-tpm updated in
> some way to reflect that those are all links under device
> now and not actually there.

Applications should not use the link version, that path was a
mistake. The link is for compatability with old userspace.

Jason
