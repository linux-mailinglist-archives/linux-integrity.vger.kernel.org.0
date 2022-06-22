Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551AF554073
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Jun 2022 04:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352458AbiFVCRt (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 21 Jun 2022 22:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbiFVCRt (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 21 Jun 2022 22:17:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8071230F5B;
        Tue, 21 Jun 2022 19:17:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C42DB81A94;
        Wed, 22 Jun 2022 02:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795D1C3411C;
        Wed, 22 Jun 2022 02:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655864265;
        bh=Hy9uGehsjDlrdBYoTgczfaFinnYGX3nIlRrm+aT86Og=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=noM6Oiz4Kaq06o4h5aJoVXOy0efNuPqWT5OzeXiF8OE5vs5tp70Zxmdl9WLlU3jq+
         GDofdZOxO6pnNby1wq3vEL6RKRT+/VL0pwTkYQC9ao8dIdFnTJC9bv0ynQ3wBw2xHd
         Jj0guKo7mojh6JO/tgvsCWNcj06xDX5JFuaXhwTUILmMsFvuUorzQYaxUok11prGXb
         l9QxK69CWeyS/SxvL9h5RpuZS023g8aclu35BOAweLB0MkXrpmpfDAWTJNy5ArVdeA
         /ZSV6GM20lshTmgHaGoHLzYLuD+qhX5ECG/qIiqZ7rz5GqIHIZRHL+gqb/CzUNYev+
         r2cwiZcfbfQ7Q==
Date:   Tue, 21 Jun 2022 19:17:43 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     xiujianfeng <xiujianfeng@huawei.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        dmitry.kasatkin@gmail.com, jmorris@namei.org, serge@hallyn.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] evm: Use IS_ENABLED to initialize .enabled
Message-ID: <YrJ7x3kCTy3ZutZ/@sol.localdomain>
References: <20220606101042.89638-1-xiujianfeng@huawei.com>
 <64511312-df94-c40b-689c-5fc3823e91f5@pengutronix.de>
 <812c4ee9-56f7-900a-df48-f3ca3e15542f@huawei.com>
 <5d0c291bb4a674a6733a18f9eb67cf40193732f4.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5d0c291bb4a674a6733a18f9eb67cf40193732f4.camel@linux.ibm.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue, Jun 21, 2022 at 10:03:39AM -0400, Mimi Zohar wrote:
> On Tue, 2022-06-21 at 18:58 +0800, xiujianfeng wrote:
> > Hi, Ahmad
> > 
> > 在 2022/6/7 14:06, Ahmad Fatoum 写道:
> > > On 06.06.22 12:10, Xiu Jianfeng wrote:
> > >> Use IS_ENABLED(CONFIG_XXX) instead of #ifdef/#endif statements to
> > >> initialize .enabled, minor simplicity improvement.
> 
> The difference between using ifdef's and IS_ENABLED is when the
> decision is made - build time, run time.   Please update the patch
> description providing an explanation for needing to make the decision
> at run time.
> 
> thanks,

IS_ENABLED() is a compile time constant.  So the patch looks fine to me.

- Eric
