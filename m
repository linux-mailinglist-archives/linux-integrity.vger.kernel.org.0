Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA4835F19BB
	for <lists+linux-integrity@lfdr.de>; Sat,  1 Oct 2022 06:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiJAELP (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 1 Oct 2022 00:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJAELO (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 1 Oct 2022 00:11:14 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079CA152223;
        Fri, 30 Sep 2022 21:11:13 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id u59-20020a17090a51c100b00205d3c44162so10801001pjh.2;
        Fri, 30 Sep 2022 21:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=IaKNEILjLdmdyt0z3VvghgJoZw3pvY15kvjcuAyHXSc=;
        b=J+wvEZb+E8I5upc9wjVeAqzSDWpH/1nWslevZY4kAB3vrIdHSuXE+3zEs48LMUjt3N
         9XJp6XUmlgeDp/utjQu5J5/4fwsW3C/dW+i/Qo+op+5XblZTRDnCZXP4TZ3l3W0QAGoi
         uTI1WPVZ7cVjcXxxEMvnhLxuAhR842jIxt3JwLI0NX0NciuE8qmWf4OS4TT8QEj5LZww
         TJ53/IO/c6x6n+TJV2r8SxxUZ4vR2fW/b/8mf0eGUnPWKAa5YrR17Hu+pLd2GdMUYMBP
         EEfH8r3RPKznTRkYfD1KucxmpwJnhtrIdY5edLXPo6fJxHTt0Y1Uol995xgzA5BFAmA9
         d4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=IaKNEILjLdmdyt0z3VvghgJoZw3pvY15kvjcuAyHXSc=;
        b=o29ySOEM5CpSuHWNZMg8468MezvKkW3H56jPvq9DkCNJCu/Z9H7fl9iEF0a0uFPi1K
         f75TTtJ5VtXPDyz7Hvn35EmS+bPR/aL/a64pCFIUYgwdlEWR90P0DxZPnCoJmnqmTqPi
         kbLt+YCE849+RtKvgD2MGMoIBq6GeHwx82qJ0n6E9pB/gXy5lu0/ofd3ko7lbCenzhRZ
         2HL8jWbKGRzV8dllO830C3/CtXK6MKoQrh1VMCETAr/3nFGCt274JKjnM06QxXgjbK1D
         q6SEVaB7unzJ2B9eag8+Khg6SFy5ThAUY4YCDyG0HarGX55QaNUVg/CD1WtkX9sfFcG7
         CrQg==
X-Gm-Message-State: ACrzQf3ZB7HAs+Vob6iara5vRVrWKswFU2Dzz05a2ia89Owkmhew5ZDF
        5iN4Ig0Zk3yk//Hx0MAtGv7zymnBnYc=
X-Google-Smtp-Source: AMsMyM6pe7KDaQ1n7Ctf0gu6TL1dQMIFIvzOCRmbcNgjWRXIfhGaAEnjchH3mg+Y1+gAsZ2Vxnxc5w==
X-Received: by 2002:a17:903:40c3:b0:17a:8db:2728 with SMTP id t3-20020a17090340c300b0017a08db2728mr12008671pld.1.1664597472405;
        Fri, 30 Sep 2022 21:11:12 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:63e7:415:943b:4707])
        by smtp.gmail.com with ESMTPSA id l7-20020a170903120700b001766a3b2a26sm2761393plh.105.2022.09.30.21.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 21:11:11 -0700 (PDT)
Date:   Fri, 30 Sep 2022 21:11:09 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] tpm: st33zp24: drop support for platform data
Message-ID: <Yze93XOi2+IBVOI+@google.com>
References: <20220926053958.1541912-1-dmitry.torokhov@gmail.com>
 <YzdT6kkPXSXZ9hdB@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzdT6kkPXSXZ9hdB@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, Sep 30, 2022 at 11:39:06PM +0300, Jarkko Sakkinen wrote:
> On Sun, Sep 25, 2022 at 10:39:56PM -0700, Dmitry Torokhov wrote:
> > There are no users of st33zp24_platform_data in mainline, and new boards
> > should be using device tree or ACPI to describe resources, so let's drop
> > support for platform data from the driver.
> 
> Nit: drop instead of let's drop (needs also different sentence structure
> obviously).

OK.

> 
> Also, please leave predictions out, or back them up with data. It's good
> enough reason to remove code, if it is not used for anything. I really
> don't care about "should" part. It is is out-of-scope for a kernel
> patch.

This is not a prediction, but a statement. The idea I was trying to
express is that platform data is needed for legacy boards, those that
predate device tree and/or ACPI support. Therefore there will be no
new users of it appearing in the kernel, as we will not accept a new
board/architecture it using wither ACPI or DT.

Thanks.

-- 
Dmitry
