Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFE9250FC09
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Apr 2022 13:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345943AbiDZLiy (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Apr 2022 07:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238202AbiDZLiw (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Apr 2022 07:38:52 -0400
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3C72126E
        for <linux-integrity@vger.kernel.org>; Tue, 26 Apr 2022 04:35:44 -0700 (PDT)
Received: by mail-qt1-x834.google.com with SMTP id t16so299121qtr.9
        for <linux-integrity@vger.kernel.org>; Tue, 26 Apr 2022 04:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=s6jUMCKgNcOJbKhCe2A87pDthDHQOpYRrOIhMe8B0aY=;
        b=IAHnI5JyzN4tWzwVw3lRD8mqYAXZcNA6XenF6vXMhDzUwdmgX2jQMQ1v6RV+TqYYfj
         tTJUEdWEX4kFa/8xnHz99Hx2h9E0z6gcOv/Zu0wCZ4P7Tcm3rWI6/w+o/fz+LC/wG8I3
         +xZiMuoj36YEPkE1pVCCf3fOb2wzuUbaNxqPbkNaqa2cd+p6Lh7aKmYsZvUQlR6tv6iq
         k/p4hRHAmlGd8cIQJEW2sw9myhrTSe1LN7PPN0p54z6rM/LxiF/LfvcwKSvzmCbEInZ+
         jUpAu2P7DFHykHSpjdPFfpgjwy8umBv99zTCLdMn9PH5zmjzdNFsiOVV6pNIsx+lzLel
         Nveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=s6jUMCKgNcOJbKhCe2A87pDthDHQOpYRrOIhMe8B0aY=;
        b=7WDzAcZ219eMunJ+KUSfdNDspW9i+pi9G/TYq7Fu0ikVNkAhm8HI+O2G6pBHm2/vb7
         OdUGiQ0vEfd+6GWe63LCDgjxzF51JeiUTVraV1XVvoV4tS2dbtCZW6mV/Ag4cUdrIdp/
         rFcT1vXgwJUBNWxbTd12Mohh3sug2W9T96+fviu6LOHd3wicwrNpWmtR8RtRVxbMnJwf
         ni32KNpdBV0cwCqp9Mzi+072cM1FCP00kd0XRy9NnxF77A3BpBJsT9qA1AXlz2OOw3IL
         bqcM4RRNIX/eSRgUh+WJsSdQ8RpoTGPDEWnCfzYQH/1DDRmNmlpu5aEJkvDW8Ge6+rgC
         RGyA==
X-Gm-Message-State: AOAM5302ut0nixVRqHhcf1wcGAlBidORee+2qKUbvYhjGwYPmmKF4GZ3
        Q5H5AlKrMQExqHOhkxP/M4ckQg==
X-Google-Smtp-Source: ABdhPJzoijGGgIQpRe+tbXiwjuxMYfTBvpgZVP0QoCyfxaUTLWQ7oCnqTkGycTiekfvJv3jWMlHkVg==
X-Received: by 2002:ac8:5d87:0:b0:2f3:7ce3:9abf with SMTP id d7-20020ac85d87000000b002f37ce39abfmr945099qtx.624.1650972943440;
        Tue, 26 Apr 2022 04:35:43 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id a1-20020ac844a1000000b002f364521df2sm4650179qto.21.2022.04.26.04.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 04:35:42 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1njJTp-009h4I-Pe; Tue, 26 Apr 2022 08:35:41 -0300
Date:   Tue, 26 Apr 2022 08:35:41 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, Peter Huewe <peterhuewe@gmx.de>,
        linux-integrity@vger.kernel.org, kernel@pengutronix.de
Subject: Re: [PATCH] char: tpm: cr50_i2c: Drop if with an always false
 condition
Message-ID: <20220426113541.GA64706@ziepe.ca>
References: <20211112225308.1149304-1-u.kleine-koenig@pengutronix.de>
 <0c7eb1e97e73e2cd3182a98d8cf76c6a2e2e6578.camel@kernel.org>
 <20211113215340.cn5kyia7g6fcquh2@pengutronix.de>
 <671cac28ac30a1135030261948487922cfcd4d89.camel@kernel.org>
 <20211116173039.ilnj7pag7solqprd@pengutronix.de>
 <20220331132231.h2hbtxthcqsdxmil@pengutronix.de>
 <20220425191132.nm66acqichx4fmel@pengutronix.de>
 <cf3df097d436c9b54c710401783667b56931b9b8.camel@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cf3df097d436c9b54c710401783667b56931b9b8.camel@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Apr 26, 2022 at 07:35:29AM +0300, Jarkko Sakkinen wrote:

> Even if chip is expected not to be NULL, a sanity check costs nothing.
> As already said, this should be reviewed in the context of the callback
> change.
> 
> Even then, the change should rather be:
> 
>        if (!chip) {
>                dev_err(dev, "Could not get client data at remove\n");
>                return;
>        } 

If it can't happen by design it should be deleted entirely, or be
turned into a WARN_ON:

if (WARN_ON(!chip))
   return;

But I find this largely unnecessary as a null chip will reliably oops
later on in the same function.

Jason
