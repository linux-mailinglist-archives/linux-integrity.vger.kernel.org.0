Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C0537B2D8
	for <lists+linux-integrity@lfdr.de>; Wed, 12 May 2021 01:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbhEKX7m (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 11 May 2021 19:59:42 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:50435 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229637AbhEKX7l (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 11 May 2021 19:59:41 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 21CC45C0150;
        Tue, 11 May 2021 19:58:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 11 May 2021 19:58:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=benboeckel.net;
         h=date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=F405VTvvDsLYnK6i0Qg9HJcn6wq
        Vw6Lc1ypuVa795h4=; b=d0mjyYNmUtfM63vRox75IS7DSosOcuQ8PmFHqVoOx6e
        2HYM2UltloGTeodM11l2042yiRXp5Qw7lTEWzJIexX8RsqvlF/Gyv2/jpPfq6Duo
        dOYFybU7CkYRte1gBWKn0EYcYELAYgISKxsZD/XARLGsDwXyuZmEWvxnVIcTmHVw
        CLs8zbjUl0SC508mKnPENnWBEXclvg/77DAtp7w447n+uPfkl1mEJs6lQp+Ryw6A
        Ge9q7NLgCWjIpm6ljbfLHBLuDmB8Flxp+SDstaLlgjFUeqxC2GMojk9VqJfIZzqi
        Gq4QbzhUMNZsS5LELWckvBwYAAXLTh0Etn47RkW/b/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=F405VT
        vvDsLYnK6i0Qg9HJcn6wqVw6Lc1ypuVa795h4=; b=Y/ON5KOjz7C/clVFtc7JfR
        uwRgZvKJ5iOAfP7dsQQIA6my/yzmJHAH5CncMDrxDEoVkf2XDS+mey9FT2a4/A55
        /pBrynjp9hw4KJpZ0TtRjnyrRohd5Z+HCkgoB71chS+U1Wd/gwCqhH8koLss8fpm
        pwTgB/lPoqxZqOVGYgVuZXhVYNNAvm5Ic/92rvl8fm3pBpo09lDQCtwSJuBFUXHb
        DYp76Jzqz8nIM5OpgRqkTPFzLgtEnctoIUSGcUnQLNYt1IC09JHDUyW+77IEh2Y0
        13zMDMqCAimftbr8I3vExtAoiXo3n92NHSPLLcw1I85NuvM5uUf0oLdJqZkMzg8A
        ==
X-ME-Sender: <xms:KRqbYGEqWd28FAatUEyD2c8w0srsPvySHT46odRIUxqLK1hy81RxbQ>
    <xme:KRqbYHVNbNLWegh-0usJqHTdxBTFibJ62WUAqQFyT368Orbyuj_78smqYmMRrg3f3
    oqXekm7vHwv6EU4GU0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdehuddgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjfgesthdtrodttderjeenucfhrhhomhepuegvnhcu
    uehovggtkhgvlhcuoehmvgessggvnhgsohgvtghkvghlrdhnvghtqeenucggtffrrghtth
    gvrhhnpedtveetgfehfeekvddthffgkeelheduudeffefggedvjedvkeekueetgffhudfh
    jeenucfkphepvdegrdduieelrddvtddrvdehheenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehmvgessggvnhgsohgvtghkvghlrdhnvght
X-ME-Proxy: <xmx:KRqbYAJx8LpXVPTBahbQB-np72Eca0UHTnynH-DjbgS2CFck7u_Qnw>
    <xmx:KRqbYAFWo8wUQ0aUhIx0D3JmGN5eQFCXJSyerNDZ3gtrscD8tiFXew>
    <xmx:KRqbYMVIAESeoqHH_GXVE9bUgzlYeXiocve1edk6TamrE_8pQGsfyQ>
    <xmx:KhqbYGe38-L3BMU3a5sNE3jpnNypSNX2sbB8603XbL6eklx7I5XLkA>
Received: from localhost (unknown [24.169.20.255])
        by mail.messagingengine.com (Postfix) with ESMTPA;
        Tue, 11 May 2021 19:58:33 -0400 (EDT)
Date:   Tue, 11 May 2021 19:58:32 -0400
From:   Ben Boeckel <me@benboeckel.net>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     keyrings@vger.kernel.org, Ben Boeckel <mathstuf@gmail.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH v2 1/1] trusted-keys: match tpm_get_ops on all return
 paths
Message-ID: <YJsaKJvgExLmjhoH@erythro.dev.benboeckel.internal>
References: <20210429192156.770145-1-list.lkml.keyrings@me.benboeckel.net>
 <20210429192156.770145-2-list.lkml.keyrings@me.benboeckel.net>
 <YJmf4Q0l+MTFEaEo@erythro.dev.benboeckel.internal>
 <YJsXN47MTF/TpsKX@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YJsXN47MTF/TpsKX@kernel.org>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Wed, May 12, 2021 at 02:45:59 +0300, Jarkko Sakkinen wrote:
> I applied it, probably will do additional PR for v5.13 in order to fix
> some urgent tpm_tis issues, so I'll include this to the same pull
> request. Thanks for fixing this!

Thanks for the update :) .

--Ben
