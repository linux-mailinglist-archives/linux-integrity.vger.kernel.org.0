Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E71952DEC3
	for <lists+linux-integrity@lfdr.de>; Thu, 19 May 2022 22:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244878AbiESUvs (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 19 May 2022 16:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244979AbiESUvg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 19 May 2022 16:51:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CC24EF4F;
        Thu, 19 May 2022 13:51:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D7A06B8288A;
        Thu, 19 May 2022 20:51:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3687DC385AA;
        Thu, 19 May 2022 20:51:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652993464;
        bh=gResFGt0OUUyfoww+2TLimDFy+zUQwPWohGqdQAsLk0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ji+KbvckQL+YS+VdJs7DTARHnwAIGKaWBqEj64fkNAlf8XgGg1IAH+ULw7RM7Scvl
         yLa6p7vtEPr1FEnbYpg4+feCcHvNNP+jrR3P2fun+g9tyZGIryi3p+hwhO//H6ReHY
         JvMDN8XgQ028YoDKhrBKstFlM2lwpW3ydfH4PBcw9yi4XmGdskx//va6JpS1nIbHOD
         87R8DOU2xbNAcSsi08sd7PEfI40X2znw1Mw+FhodDeCTLQV+MT3E2xA+uJsAPdj+Ap
         adsQPvzMIPqlQzhLrHSvFeCHraBWOD9rU0pIvQIs8TaIk8G0+Pgg3Zb8i95TepUUsm
         b6eTlIfED8RYw==
Date:   Thu, 19 May 2022 23:49:25 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     GUO Zihua <guozihua@huawei.com>
Cc:     linux-integrity@vger.kernel.org, zohar@linux.ibm.com,
        dhowells@redhat.com, keyrings@vger.kernel.org
Subject: Re: [PATCH] keys: Use struct_size and size_add helper with alloc
Message-ID: <YoatVbXu5g6f7gD7@iki.fi>
References: <20220519024702.215223-1-guozihua@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519024702.215223-1-guozihua@huawei.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Thu, May 19, 2022 at 10:47:02AM +0800, GUO Zihua wrote:
> Use struct_size helper for calculating size of flexible struct to avoid
> potential issues and improve readibility. Use size_add to calculate
> addition of size to prevent potential issues.

What issues? Please explicitly state the issues.

BR, Jarkko
