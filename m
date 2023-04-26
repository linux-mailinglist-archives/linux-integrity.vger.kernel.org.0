Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 789026EEBF2
	for <lists+linux-integrity@lfdr.de>; Wed, 26 Apr 2023 03:32:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238025AbjDZBcz (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 25 Apr 2023 21:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238582AbjDZBcy (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 25 Apr 2023 21:32:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA39C7285;
        Tue, 25 Apr 2023 18:32:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B1B1631D2;
        Wed, 26 Apr 2023 01:32:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A38C4339B;
        Wed, 26 Apr 2023 01:32:52 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="SAItAn7N"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1682472769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=r25p03fdrefLLIs3GBzIbC3crrQbvzO3nczQ2QmY0cg=;
        b=SAItAn7NMSY77eg9Io6CBYsewpW1LLwwan8mYW1btzeQGi/YnRPmCHw4/ZvsMr+BFdJiRX
        t69QdbfOKfZ8USMkbKkC6lwyEs84OuOkk1NzbPc1+Z8efqB0pEKxA5/EfuoNwpQkDD+7DI
        A1Dn+esTfUAP02YzQWpc+W9PztitKk0=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 55a014c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 26 Apr 2023 01:32:48 +0000 (UTC)
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-42e6ac0cd5aso1578770137.1;
        Tue, 25 Apr 2023 18:32:47 -0700 (PDT)
X-Gm-Message-State: AAQBX9c3WaaBCTlJMtYrP1g+tI1JLEG1NXn9ZaHA7ExYf/Ig2xlluYcN
        FSHkEdRV/rJ3Ms7iaVXxLxRpdnHUaNL7mKFZvIc=
X-Google-Smtp-Source: AKy350aXPJ0Ug8IJ+bpj8J2OAtNFfW/UZ7/mN9FffQSgP6UrZtYSZuN1ItVA3sI3nX+1gV2epfv9qJEh6aTpDr3Hxfc=
X-Received: by 2002:a67:b34a:0:b0:42e:6689:d762 with SMTP id
 b10-20020a67b34a000000b0042e6689d762mr8917039vsm.8.1682472766555; Tue, 25 Apr
 2023 18:32:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:2695:0:b0:75c:e750:ab with HTTP; Tue, 25 Apr 2023
 18:32:45 -0700 (PDT)
In-Reply-To: <CS68AWILHXS4.3M36M1EKZLUMS@suppilovahvero>
References: <Y60RoP77HnwaukEA@zx2c4.com> <7ebab1ff-48f1-2737-f0d3-25c72666d041@leemhuis.info>
 <Y7w74EBYP3+FHlkw@zx2c4.com> <4268d0ac-278a-28e4-66d1-e0347f011f46@leemhuis.info>
 <ZBBmVhwsTf/URoqs@kernel.org> <CAHmME9rxeE32g7nKqeVLwRodDNM8QyZUNd54cyE6mZW7FcqD-g@mail.gmail.com>
 <ZBBxMl5rVjY9FGS9@kernel.org> <ZBBxxftnXHVOjm92@kernel.org>
 <ZBB8R9H3CyQnNfCt@zx2c4.com> <ZBCDeleGG/fFlkt+@kernel.org>
 <ZEKlzaQhjd8sbE7I@kernel.org> <CAHmME9q9DZyYo7G__ks=XSrS4kS8sUUZ+eF3c1VSnGCAvfBR+Q@mail.gmail.com>
 <CS48U6SYIBVB.V05DUEX5I01F@suppilovahvero> <CS68AWILHXS4.3M36M1EKZLUMS@suppilovahvero>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 26 Apr 2023 03:32:45 +0200
X-Gmail-Original-Message-ID: <CAHmME9o3HK2ju-HBYpSbB_7-9x5A2rD0ev3gaiLLjB_J8-Ju4Q@mail.gmail.com>
Message-ID: <CAHmME9o3HK2ju-HBYpSbB_7-9x5A2rD0ev3gaiLLjB_J8-Ju4Q@mail.gmail.com>
Subject: Re: [REGRESSION] suspend to ram fails in 6.2-rc1 due to tpm errors
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jan Dabros <jsd@semihalf.com>,
        regressions@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Altmanninger <aclopte@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Nice work! Happy that you got it figured out. That trace seems
consistent with what I was seeing in my traces, so I think you've
spotted the right bug.

Jason
