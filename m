Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FB56ECCC0
	for <lists+linux-integrity@lfdr.de>; Mon, 24 Apr 2023 15:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231839AbjDXNMH (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 24 Apr 2023 09:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231860AbjDXNMG (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 24 Apr 2023 09:12:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CBF4C1C;
        Mon, 24 Apr 2023 06:11:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51A45621BF;
        Mon, 24 Apr 2023 13:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D2EC433EF;
        Mon, 24 Apr 2023 13:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682341895;
        bh=c4uQV+PeeWQbdjmm++41yCkhklUf0vFo+mEnmBVEE9s=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ItU2UXIeqFhA2Xz5XgBYJ2UtYKTvls8nD5IQr0QaBPRaOcYTO3x5mEQXTyf4lIPvQ
         WzVxlbfG7FLxXaDC/VhAf3CAXrBHXBZS4Y7EJOgvn6RHf3aIXiPG0GZa6ellcsbr+w
         BmsOGuzE0QPctGGrJEQuBuzcVpl4V71K65wM1o9HO8i5stypoEiJE3yfyrx5yuzl3N
         UGOpEcao13IY5Xa5RnuMSyK+wSIHi4y+q3zNWdrtd5MCBMrM39iUmZFwPIGIfDBDjj
         AfnQDb3/s5InVpMwnYL3En1ESF3Yt3IcHGRJ6wAMBbTbRxewxbIRJlHoCqJH71R9TG
         qU/E5tmwHS2LA==
Message-ID: <532ba1ebeda04e0089bd257670aeefc1624604be.camel@kernel.org>
Subject: Re: [Patch V10 2/3] tpm_tis-spi: Add hardware wait polling
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Krishna Yarlagadda <kyarlagadda@nvidia.com>, jsnitsel@redhat.com,
        robh+dt@kernel.org, peterhuewe@gmx.de, jgg@ziepe.ca,
        krzysztof.kozlowski+dt@linaro.org, linux-spi@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        jonathanh@nvidia.com, skomatineni@nvidia.com, ldewangan@nvidia.com
Date:   Mon, 24 Apr 2023 16:11:30 +0300
In-Reply-To: <3df39f0b-70dc-4b42-bae1-72c07607cbc7@sirena.org.uk>
References: <20230421091309.2672-1-kyarlagadda@nvidia.com>
         <20230421091309.2672-3-kyarlagadda@nvidia.com>
         <CS48A9Y752N4.QEM73WVMZYLQ@suppilovahvero>
         <3df39f0b-70dc-4b42-bae1-72c07607cbc7@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.0-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-04-24 at 12:56 +0100, Mark Brown wrote:
> On Sun, Apr 23, 2023 at 06:08:16PM +0300, Jarkko Sakkinen wrote:
>=20
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
>=20
> > Should I pick these patches?
>=20
> I've queued the spi side already.

OK, great, thanks.

BR, Jarkko

