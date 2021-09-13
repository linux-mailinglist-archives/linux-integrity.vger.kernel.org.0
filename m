Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82E524096D1
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Sep 2021 17:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345307AbhIMPN4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Sep 2021 11:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244574AbhIMPNu (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Sep 2021 11:13:50 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB175C0C7018
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 07:03:05 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id c19so8144042qte.7
        for <linux-integrity@vger.kernel.org>; Mon, 13 Sep 2021 07:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YEvIyYeLDXUpTcJZWMj983nbdS1DgqFIWLgNvEi4/Kc=;
        b=UBFJb/UNvdtTIVCvaiSXEdqImCOifx2UsDbPJuKsWTYonXF9HcLGUZQpwlWpd+7Ah2
         LbjHtrrJg6a3J/R57I6PCgelupBiAhdh/JpCa31goTnJMpfL2+kE5rf73AP7w2x/KFwH
         lgy5G1OARWI5FY3AhcpvUpoSg58EALyljbwxgI+weoQOylI3a6qU5fnvQzSscdZ7ziPS
         9tE3acRsny/FIP0kFA0yJ3G5wg2p1OIeF+jufoAYCIsI3iGfGP1kN/lmBrlPC8qdy9DU
         CaFmTTWKf/xb3P9MijywkcnPoO/gLMAVIG5zTXYDBhiDQpCIgsHACL54WyeeTrlNyxrQ
         E5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YEvIyYeLDXUpTcJZWMj983nbdS1DgqFIWLgNvEi4/Kc=;
        b=FWrJM4fwHBnaNrFJmSjAjIBV5sWQanX4VsWKbfVtWNEDfCEDGMZM1xx5WK6dcrgGoJ
         iW+ikeE9zC4iQsOwILf0izU7+ryoV/NrE9fLaq34uDy6fV3b570wwEXEBGjS0K72Ga1b
         wrJe2NcFQy0MuIEEG4huSBudzRShlp/hZIZ+czKnVz+U41YOrvJEf4uyOJV0dgyeTkfJ
         kghtaaS2z+t+0gWXm/h5JlGExeJnBmlLTa6H5AJG5TN+1twy59CGQN/63SWm0+myVuRR
         z4jnuGFv3cZzOp8G2opBbAiV1gAUnN0r9LI1sNdvSMig2bSqOPHyd7SMqM4EVn+uVwq6
         0huQ==
X-Gm-Message-State: AOAM531JL/6Tge4HBZmcaYwrrucb7yCEG2SCm83Kxf8C/EQlPb6eS3Bu
        /LOExIOBPEl70CiB6BF6CUQ7Qg==
X-Google-Smtp-Source: ABdhPJwFd7EsMjZS09jyOS0QyiyESxT3hnj2v4ushFACgvIZP/sy5MgREfrUl8X2Mx5iMEb9dSRjVg==
X-Received: by 2002:ac8:5f86:: with SMTP id j6mr9320639qta.11.1631541784302;
        Mon, 13 Sep 2021 07:03:04 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id b15sm5219812qka.107.2021.09.13.07.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 07:03:03 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mPmY2-00GTN6-Sz; Mon, 13 Sep 2021 11:03:02 -0300
Date:   Mon, 13 Sep 2021 11:03:02 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Florian Eckert <fe@dev.tdt.de>
Cc:     peterhuewe@gmx.de, jarkko@kernel.org,
        Eckert.Florian@googlemail.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] tpm/tpm_i2c_infineon: Fix init endian vendor check
Message-ID: <20210913140302.GE3544071@ziepe.ca>
References: <20210913120521.18572-1-fe@dev.tdt.de>
 <20210913130210.GD3544071@ziepe.ca>
 <690f5a5f846c4ef966713b4970d07737@dev.tdt.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <690f5a5f846c4ef966713b4970d07737@dev.tdt.de>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, Sep 13, 2021 at 03:46:48PM +0200, Florian Eckert wrote:
> Hello Jason,
> 
> > > The device works than as expected.
> > > 
> > > Signed-off-by: Florian Eckert <fe@dev.tdt.de>
> > > v2:
> > > * use variable type instead of le32_to_cpus function call
> > >  drivers/char/tpm/tpm_i2c_infineon.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > And if you do this it need to be made sparse clean/etc
> 
> Sorry for the stupid question, but what exactly do you mean?

There is a tool called sparse that checks the endia notations and
verfies correctness

It will complain if you do

__le32 x

x = le32tocpu(x)

you neeed another variable to store the cpu version

Jason 
