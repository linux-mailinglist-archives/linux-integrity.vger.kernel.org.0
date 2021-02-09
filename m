Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCC3315068
	for <lists+linux-integrity@lfdr.de>; Tue,  9 Feb 2021 14:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbhBINiP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 9 Feb 2021 08:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbhBINhh (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 9 Feb 2021 08:37:37 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57695C061788
        for <linux-integrity@vger.kernel.org>; Tue,  9 Feb 2021 05:36:56 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id l27so17832033qki.9
        for <linux-integrity@vger.kernel.org>; Tue, 09 Feb 2021 05:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rQDN9SsYyOm1+6OzrJKfjjujxeS9Kf+poa36QyspUHo=;
        b=S69bRY1mHQ3ZCVAh+fPnTuBsl7+eZNIht8JRwW20nRzCxS36nimK/5rd3kMxq+2pHb
         HYLgTwbxmGuFoEWrr+ZAmtFQq2a1xkgs1UJHIqGMntO5E7iIiLAyLHN2n93bZnF6Ty+m
         /MxYtzcA3z5JPJ5KYQAq8hNtH4LFEu4cx+E1K3uTmRwMhdIiExWgloutL2q4659LRmo3
         9eIMozKPjtU3aQe3UcZ3QxGdbwJ0G60qISvLyNkM/NXZEgYisRGyhlOyDOUpCWy2o7Fl
         nN7JY9LFC7D+kXbUCcEC7j5+HK2qxI2CKEM7D4b69O+whsMYQQliwa3D3yRZcGOUmx0T
         4U2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rQDN9SsYyOm1+6OzrJKfjjujxeS9Kf+poa36QyspUHo=;
        b=cnrhgtruwef+Zai5BpsnXqoosPGKRkQ/hO6Yg5ZubOFLyxbu+l5P5H5W5Cvp9EmylV
         Rfj989b3gTl/vO1sQdDDHSSPZEjmj73WA2++QHezYvw7QH+I5sjyUfe8grxwL+FcQ991
         xOf0BdMTy6cyRKkoRZH0yFMettBht8f1+MobvOU1PbvNqmHXD06+2Ii8danANiipjoaQ
         ++tA5UKhoWXLv6hjeKakOawaj+otxI/IGDglHew+307NMaHQy/UveNfX3rtimSGsggYk
         lDBABkYqRM224jtoRPcsQ4NGMDzj759+vDujCHELpcnZ5j7qO1JpJ3BhzKPyBHhbXif8
         pAAA==
X-Gm-Message-State: AOAM531oHqo79E5quBDJB5sPbcaI0mhInIydEy6GD/1B3xIZ7tLFwDf0
        T8Q0p5y11P1lWBvTQHMr0HJ5bN3S5uiLirJu
X-Google-Smtp-Source: ABdhPJwQw6W1kHlfnJVOsEKJxg8Vk8eql2NS8SYRCjTHZ68Dr1qE31sHp7DvgGGwh+sr2aoUfACiUg==
X-Received: by 2002:a37:aec5:: with SMTP id x188mr21372955qke.144.1612877815500;
        Tue, 09 Feb 2021 05:36:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-115-133.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.115.133])
        by smtp.gmail.com with ESMTPSA id f8sm16383731qth.6.2021.02.09.05.36.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 05:36:54 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1l9TCH-005RIO-Tr; Tue, 09 Feb 2021 09:36:53 -0400
Date:   Tue, 9 Feb 2021 09:36:53 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc:     James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Lino Sanfilippo <LinoSanfilippo@gmx.de>, peterhuewe@gmx.de,
        stefanb@linux.vnet.ibm.com, stable@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] tpm: in tpm2_del_space check if ops pointer is
 still valid
Message-ID: <20210209133653.GC4718@ziepe.ca>
References: <1612482643-11796-1-git-send-email-LinoSanfilippo@gmx.de>
 <1612482643-11796-3-git-send-email-LinoSanfilippo@gmx.de>
 <7308e5e9f51501bd92cced8f28ff6130c976b3ed.camel@HansenPartnership.com>
 <YByrCnswkIlz1w1t@kernel.org>
 <ee4adfbb99273e1bdceca210bc1fa5f16a50c415.camel@HansenPartnership.com>
 <20210205172528.GP4718@ziepe.ca>
 <08ce58ab-3513-5d98-16a5-b197276f6bce@kunbus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08ce58ab-3513-5d98-16a5-b197276f6bce@kunbus.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Feb 09, 2021 at 12:52:17PM +0100, Lino Sanfilippo wrote:
> > @@ -640,8 +643,10 @@ void tpm_chip_unregister(struct tpm_chip *chip)
> >  	if (IS_ENABLED(CONFIG_HW_RANDOM_TPM))
> >  		hwrng_unregister(&chip->hwrng);
> >  	tpm_bios_log_teardown(chip);
> > -	if (chip->flags & TPM_CHIP_FLAG_TPM2)
> > +	if (chip->flags & TPM_CHIP_FLAG_TPM2) {
> >  		cdev_device_del(&chip->cdevs, &chip->devs);
> > +		put_device(&chip->devs);
> > +	}
> >  	tpm_del_char_device(chip);
> >  }
> >  EXPORT_SYMBOL_GPL(tpm_chip_unregister);
> > 
> 
> I tested the solution you scetched and it fixes the issue for me. Will you send a (real) patch for this?

No, feel free to bundle this up with any fixes needed and send it with
a Signed-off-by from both of us

I did it pretty fast so it will need a careful read that there isn't a
typo

Thanks,
Jason
