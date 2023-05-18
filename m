Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38DF37087C7
	for <lists+linux-integrity@lfdr.de>; Thu, 18 May 2023 20:29:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjERS3h (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 18 May 2023 14:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjERS3g (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 18 May 2023 14:29:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5B71B6
        for <linux-integrity@vger.kernel.org>; Thu, 18 May 2023 11:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684434528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZoOCyUhfshjqiWx1RRGNm+zxB7amhG6MwKVi2N7UXyc=;
        b=UI/PjRfEAKrFiWKjf8fISTg6AEyXPzMiCsFhglIv+hvqLWQqNU373i70pzSrJteHYzEVZj
        JYdiLTdoVvVqcHn7sTgEesR+d8qObsXVIyr6cqYjCO3MnQK9nlauo58lV4IUUKWUQc0LPi
        oIaKpQFU34PN2YoqKlmwtSxBcoF/3WE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-O-ko5b3GNF2Z3eLEROJ04g-1; Thu, 18 May 2023 14:28:46 -0400
X-MC-Unique: O-ko5b3GNF2Z3eLEROJ04g-1
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-3f6872ff794so18744051cf.1
        for <linux-integrity@vger.kernel.org>; Thu, 18 May 2023 11:28:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684434526; x=1687026526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZoOCyUhfshjqiWx1RRGNm+zxB7amhG6MwKVi2N7UXyc=;
        b=UskmZ3kL/Aj+0cQIfmAi3VHDv1mjmcp/PsXX69lPadT8Ln+L5iFk6vV5pnfcRrfpAj
         6rqp1oys/0NFYTcyONGWYtia1rF9POwsLqO+ziTtbgq2SMPDn1xBJUkS2yS44nH+Z7yf
         XERgsOqo2fmAYpbsxBeX9YF83Jg+XhArn2p1QjSFRHYWI0HgcIt94ejjOKON3D+oyzLj
         QLBmCkf+Er3BgpD3MVOVw81UbpgsM9JflT/6/kR8uo0CswbZcoMT7+kYgQyHV9hRtUL2
         3z7zBJVUjvMoojhldEnM8HJwC3aNcB8/0lzwnw65MLCwJ21c13D0ANu6lY2xldwRU7tY
         SvhQ==
X-Gm-Message-State: AC+VfDysm3Uj7WsPwVKhi28NHl24zrnQbwH29gxoNfwK8VZCNsSsHnDT
        bzuW9hWfVS7TEHRoxV1J7dHAS4CV3U0KFcH3Bi2FAeTZ4G4NT+sYwtV7R2+CIl5T9xaJASds62P
        6c8/kzI66HplNx/Lbbe6RSmx+G86q
X-Received: by 2002:a05:622a:152:b0:3f5:41d9:fddb with SMTP id v18-20020a05622a015200b003f541d9fddbmr1163444qtw.47.1684434526269;
        Thu, 18 May 2023 11:28:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ78W2zAGWvSvDR1brUGAqTFQs3yXE6GKD14ttBdpFaqUXpLV7M9B6iNBpNGztxVS1Q6I6uXdw==
X-Received: by 2002:a05:622a:152:b0:3f5:41d9:fddb with SMTP id v18-20020a05622a015200b003f541d9fddbmr1163415qtw.47.1684434526063;
        Thu, 18 May 2023 11:28:46 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id x5-20020a05620a01e500b0074fb15e2319sm557599qkn.122.2023.05.18.11.28.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 May 2023 11:28:45 -0700 (PDT)
Date:   Thu, 18 May 2023 11:28:43 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>, stable@vger.kernel.org,
        Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] tpm/tpm_tis: Disable interrupts for more Lenovo devices
Message-ID: <h7pelzgnae6kgrydhbp2ffoj4xctux3vx3s5yhiexskaykhcha@stxphc5cc3gy>
References: <20230511005403.24689-1-jsnitsel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511005403.24689-1-jsnitsel@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 10, 2023 at 05:54:03PM -0700, Jerry Snitselaar wrote:
> The P360 Tiny suffers from an irq storm issue like the T490s, so add
> an entry for it to tpm_tis_dmi_table, and force polling. There also
> previously was a report from the previous attempt to enable interrupts
> that involved a ThinkPad L490. So an entry is added for it as well.
> 
> Reported-by: Peter Zijlstra <peterz@infradead.org> # P360 Tiny
> Closes: https://lore.kernel.org/linux-integrity/20230505130731.GO83892@hirez.programming.kicks-ass.net/
> Cc: stable@vger.kernel.org # 6.2

For the stable folks this can be ignored though it won't hurt anything if someone does
backport it. The code enabling interrupts went into 6.4-rc1, not 6.2.

Regards,
Jerry

