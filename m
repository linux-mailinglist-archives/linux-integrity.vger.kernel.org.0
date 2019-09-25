Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B510BDF9D
	for <lists+linux-integrity@lfdr.de>; Wed, 25 Sep 2019 16:03:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406387AbfIYODv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 25 Sep 2019 10:03:51 -0400
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:59952 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405102AbfIYODv (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 25 Sep 2019 10:03:51 -0400
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 56AE38EE175;
        Wed, 25 Sep 2019 07:03:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1569420230;
        bh=wgQLAhQ0gpMYuJqIxafxVyPJc5xPW8c1DYEePcqkeJU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=MoYk9zg8Do4chGVdWYcE0CzTP4WxSWWl2MmooufUyNgrNOggM6gv8+5ym91rluB01
         T9zP9EU/8mHdQL7K0Yaubf5zjl97Mnl6uxrU2SiOCil4kfpDfsBjsnePZHqaXjHKmR
         abdVTqnGv4Bzttn3OX7EPkAg2DkpyBAYnW/hSS1A=
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id bz3oqnN4PUpl; Wed, 25 Sep 2019 07:03:49 -0700 (PDT)
Received: from [9.232.197.57] (unknown [129.33.253.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 462748EE0E9;
        Wed, 25 Sep 2019 07:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=hansenpartnership.com;
        s=20151216; t=1569420229;
        bh=wgQLAhQ0gpMYuJqIxafxVyPJc5xPW8c1DYEePcqkeJU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=X+uzUSLdrthDd94MjAzzF/mQ+tu0lWcZNyf+zUIDja9t9EKsDz6oiJ/ZNG2gvKiEa
         yfskMWikzGLvJpq0Z7unefkclRQmKdUr8VxwuFWgizbKwabVGz66yaXjpvy2PbbRDR
         NAD/asi2+/1w5ZWBs/mGZPl6OIj7w1j2DytR14BI=
Message-ID: <1569420226.3642.24.camel@HansenPartnership.com>
Subject: Re: [PATCH] tpm: Detach page allocation from tpm_buf
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        linux-integrity@vger.kernel.org
Cc:     Mimi Zohar <zohar@linux.ibm.com>,
        Jerry Snitselaar <jsnitsel@redhat.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        Stefan Berger <stefanb@linux.vnet.ibm.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        open list <linux-kernel@vger.kernel.org>
Date:   Wed, 25 Sep 2019 10:03:46 -0400
In-Reply-To: <20190925134842.19305-1-jarkko.sakkinen@linux.intel.com>
References: <20190925134842.19305-1-jarkko.sakkinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, 2019-09-25 at 16:48 +0300, Jarkko Sakkinen wrote:
[...]
> +	data_page = alloc_page(GFP_HIGHUSER);
> +	if (!data_page)
> +		return -ENOMEM;
> +
> +	data_ptr = kmap(data_page);

I don't think this is such a good idea.  On 64 bit it's no different
from GFP_KERNEL and on 32 bit where we do have highmem, kmap space is
at a premium, so doing a highmem allocation + kmap is more wasteful of
resources than simply doing GFP_KERNEL.  In general, you should only do
GFP_HIGHMEM if the page is going to be mostly used by userspace, which
really isn't the case here.

James

