Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FCD5236E2
	for <lists+linux-integrity@lfdr.de>; Wed, 11 May 2022 17:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244902AbiEKPPo (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 May 2022 11:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245622AbiEKPPm (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 May 2022 11:15:42 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF48BC00;
        Wed, 11 May 2022 08:15:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 814E4B82150;
        Wed, 11 May 2022 15:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB3B4C340EE;
        Wed, 11 May 2022 15:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652282138;
        bh=G8ODxZcP7Vlbg0tslFT1viIzjbWtd/kr7cloCFyP0uA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FNDYqUiWtZXQd8N7OE5qpoVgkPxsZxXy24gvAeu2JMYGnYhyblXXVBuQeQ1DpEFJe
         4ZLvIx/vMbuLRSVqsDriMcNOdzhdvS6XGSQsVpOrTBA9mV4lfff+Ywas8t08425eas
         4y1ytOfwNeDbnDOKdQJQc53C7k6ADJHNxxN3UjPvGDl+kMF65bCgnPhWEI2LrbwKBb
         +vwp/428DLj7HtXcj1uR/fg5d4LyJR6RuAz/2CHnJ/dayMbYNTpYCWGMt5NZKzSF8V
         7wrQviVqQNgOlkA8eOO5s/WtkoKflmmZhQvrkgxrETWtcZCrsv7m/bljj2jCfeFhP2
         Fr6VJC1iNQL3w==
Date:   Wed, 11 May 2022 18:14:08 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Johannes Holland <johannes.holland@infineon.com>
Cc:     linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterhuewe@gmx.de, jgg@ziepe.ca
Subject: Re: [PATCH] tpm: increase timeout for kselftests
Message-ID: <YnvSwJxOg+IZxrxz@kernel.org>
References: <20220510111607.22984-1-johannes.holland@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510111607.22984-1-johannes.holland@infineon.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, May 10, 2022 at 01:16:08PM +0200, Johannes Holland wrote:
> Due to CreatePrimary commands which need to create RSA keys of
> increasing size, the timeout value need to be raised, as well.
> Default is 300s.
> 
> Signed-off-by: Johannes Holland <johannes.holland@infineon.com>
> ---
> A timeout of anything below 600s still lead to occasional timeouts for
> me. Therefore, I propose 600s as a new value. 
> 
>  tools/testing/selftests/tpm2/settings | 2 ++
>  1 file changed, 2 insertions(+)
>  create mode 100644 tools/testing/selftests/tpm2/settings
> 
> diff --git a/tools/testing/selftests/tpm2/settings b/tools/testing/selftests/tpm2/settings
> new file mode 100644
> index 000000000000..919bc3803f03
> --- /dev/null
> +++ b/tools/testing/selftests/tpm2/settings
> @@ -0,0 +1,2 @@
> +timeout=600
> +
> -- 
> 2.34.1
> 

Could cope but I did not get why it needs to be raised.

BR, Jarkko
