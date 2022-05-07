Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C661351E9CA
	for <lists+linux-integrity@lfdr.de>; Sat,  7 May 2022 21:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379861AbiEGT7G (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sat, 7 May 2022 15:59:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232233AbiEGT7E (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sat, 7 May 2022 15:59:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BC5A11A1D;
        Sat,  7 May 2022 12:55:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0E3D7B8015B;
        Sat,  7 May 2022 19:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B35C385A5;
        Sat,  7 May 2022 19:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651953314;
        bh=GE4qxmKc4hd0PwCU32+Nzu5+CaM7yGVkr02S6I+bqYg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cU1zSXVBll/YpqsF5emyhSR5kWJTF37LyjcFFQEoBFQUsNxK2OiDYxUn4lvkEa6xp
         lGIp+xj8wWqPYzMJtBTNaFl0gm7h8tCtMW8sFGvCuY9yc1474Okyjp8ipjjr0dMQTQ
         UApPl+2wks75xNS+jbbCKlRJ6CMSlOPj0qd1VsYLlhQGGvk/zA000woKeRODxXUCet
         Ofg+nPpFc/6rZDz3TH2FBy/s2umD2DnKgjTXX5r8Eu2xW4kMcTDqv3L8saotgxnh1p
         8LtB/vN+89TCDjHIkRfZCWCfvRHOJflqBULl3kh2jIbxsIRIBr3GzBKRGrihUYUPp4
         8aGJOBZsjpk2w==
Date:   Sat, 7 May 2022 22:56:49 +0300
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Johannes Holland <johannes.holland@infineon.com>
Cc:     linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org, peterhuewe@gmx.de,
        jgg@ziepe.ca, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2 3/4] tpm: Implement command and response retry in
 tpm_tis_core
Message-ID: <YnbPAa0LZA3aGiZA@iki.fi>
References: <20220506170013.22598-1-johannes.holland@infineon.com>
 <20220506170013.22598-3-johannes.holland@infineon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220506170013.22598-3-johannes.holland@infineon.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Fri, May 06, 2022 at 07:00:15PM +0200, Johannes Holland wrote:
> Some errors during command transmission and response reception are
> recoverable. Implement the specified retry mechanisms.
> 
> Recoverable errors during response reception:
>  * invalid response size during header read
>  * left over data:
>    a communication error can lead to a FIFO read of 0xFFs and an
>    unexpected STS.dataAvail = 1, subsequently
>  * CRC mismatch
> 
> Recoverable errors during transmit:
>  * CRC mismatch
> 
> Signed-off-by: Johannes Holland <johannes.holland@infineon.com>

You should split this multiple patch, each implementing one retry
mechanism (CRC's can for recv and transmit can be in a single path
tho):

https://www.kernel.org/doc/html/latest/process/submitting-patches.html#separate-your-changes

BR, Jarkko
