Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE9339461C
	for <lists+linux-integrity@lfdr.de>; Fri, 28 May 2021 18:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhE1Q6d (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 28 May 2021 12:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbhE1Q6a (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 28 May 2021 12:58:30 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F37A2C06174A
        for <linux-integrity@vger.kernel.org>; Fri, 28 May 2021 09:54:44 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id j189so4741185qkf.2
        for <linux-integrity@vger.kernel.org>; Fri, 28 May 2021 09:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=u5n6FAe1v4UAJsByHudl5A+mBMcdBJxk3zfDYSRF99Y=;
        b=jFLeqpfeWkzr1ATFdlIGUWyBh2/6QQc1YtPVe8quqe7PH0ppWYHDHf75EOn0U5y1l7
         gsaFXz/cONNT0PhJINKo85unmp4DSUrAdIKKLTuqlWuzp+NA55nHX1AUKY3ljymss1d+
         3zXh3+ACYoq2tGsRyvszxBskNcO+LLG9LHEzzaCIJt84KvI6Y8BDLPoF6b1sfyHiGTOm
         MmwAZR9BAWh6OQ8TCMUeg65vaDVnm8vx79y50R7mLdi8cBRYGS8pRqBnyV+cmuNtaoVZ
         +Hbpzyl5YX3cIQFTajZlQ4K2dudgi4O9C1RSwMqFfLNUi9s4R5y8glrIR4WtSOy07JQ7
         Es3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=u5n6FAe1v4UAJsByHudl5A+mBMcdBJxk3zfDYSRF99Y=;
        b=p8uSLlgHJ4JQwMKq3dmoXmk9PlgxjUp32C6KwTbmf/KQQ0N1OGmU9BHUs37n4hok5S
         UanZQRVJvAip6yLKYgzYga2egHep1dgjJ4BccVkgycs75xMY/mrHBiB2A9x4PozOqFjH
         T0mMCtSLZslvsylY0ejWMEyElqMWRuk2eNwZs5kVuRNyUgipQFf+8uHzUWA8BJTQ7BAx
         /stEXhoQcS7+H0SrpHK59OsMjMdog5bmuZKThRJ9MTPH9SpVNfgTPUK4NjQP921jgD6h
         ZdN9uoPYDYD3ViuwoIPz50D5J2DZvBoKyTIlOeLIG69PXfql20EkgWkq3CgO6m2+nwGb
         yClw==
X-Gm-Message-State: AOAM532N5UOJ3Jju+krxVpQHnzy1QW7Xq3S10hwJ77iQJDAs0JiA9WGN
        1JEqfD+TwrBTBX8HNizRTGRFMA==
X-Google-Smtp-Source: ABdhPJw9y0vly2p2+Ces1zMO0fCsYFxZ7usZ/Alf/KGodiWhC9SDIqIgZS9UY/gM1syptqb7/pktJQ==
X-Received: by 2002:a05:620a:b09:: with SMTP id t9mr4956512qkg.17.1622220884079;
        Fri, 28 May 2021 09:54:44 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-113-94.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.113.94])
        by smtp.gmail.com with ESMTPSA id 7sm3868806qkd.20.2021.05.28.09.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 09:54:43 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lmfkw-00G0fm-On; Fri, 28 May 2021 13:54:42 -0300
Date:   Fri, 28 May 2021 13:54:42 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Wellbrock <a.wellbrock@mailbox.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Peter Huewe <peterhuewe@gmx.de>,
        Peter Robinson <pbrobinson@gmail.com>,
        linux-integrity@vger.kernel.org
Subject: Re: [PATCH] tpm_tis_spi: add missing SPI device ID entries
Message-ID: <20210528165442.GJ1096940@ziepe.ca>
References: <20210527152352.3835076-1-javierm@redhat.com>
 <20210527161156.GH1096940@ziepe.ca>
 <f0afae88-419f-6792-c795-b15e724ba739@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0afae88-419f-6792-c795-b15e724ba739@redhat.com>
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 27, 2021 at 06:42:25PM +0200, Javier Martinez Canillas wrote:

> Fixing the spi_uevent() function would be pretty trivial but that
> would break all the drivers and platforms that are relying on the
> current behaviour.

Oh this makes me sad to read after all these years :(

It shure would be nice if multiple modaliases could be reported for
situations like this.

Jason
