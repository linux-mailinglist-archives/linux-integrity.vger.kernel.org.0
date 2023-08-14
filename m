Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E43B477BF0C
	for <lists+linux-integrity@lfdr.de>; Mon, 14 Aug 2023 19:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229992AbjHNRdp (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 14 Aug 2023 13:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230432AbjHNRde (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 14 Aug 2023 13:33:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85B14133;
        Mon, 14 Aug 2023 10:33:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1907E60F13;
        Mon, 14 Aug 2023 17:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6333CC433C8;
        Mon, 14 Aug 2023 17:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692034411;
        bh=dMLWHmmWTHTpECQlogQ0Ns+k8Paiopb9T66lZHlkhII=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=h8GDb/X2iClmuQ5zfnXPmiXaDl9Kr6TqdPk9iMRYifdCs5TcOthXO4Hnmac1V1af8
         mSo/bA8Uy1YoHuUBNr0W10qyeGiRKlZp6XGLSE7/C1qPbgwLQ23lxZdARJSGYc7Tq4
         PWAl705L0Cd1cvET+qYqT4H5ANbjo17n8elx8weikQQ0MVb99e5FMid9DcOOI6WQOd
         XUxLS1Yq0OSdv4mcDxAOPu66/N5DeAPo9DXiZ9jd+UibphFES1gctSEicQJ7NOSsbq
         rWljLJkhTLkxwNy2kdSq8LWYtYqz456/8ICTDs/lKeFKEZyT3CJVYStPUaR1Ojc0cb
         8JbvVV4wtiIcA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 14 Aug 2023 20:33:27 +0300
Message-Id: <CUSG4ZTYMMD3.30DE3M55W3CJ1@suppilovahvero>
Cc:     "Linux kernel regressions list" <regressions@lists.linux.dev>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Christian Hesse" <mail@eworm.de>, <stable@vger.kernel.org>,
        <roubro1991@gmail.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Christian Hesse" <list@eworm.de>,
        <linux-integrity@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] tpm/tpm_tis: Disable interrupts for Framework
 Laptop Intel 12th gen
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Grundik" <ggrundik@gmail.com>,
        "Thorsten Leemhuis" <regressions@leemhuis.info>,
        "Lino Sanfilippo" <LinoSanfilippo@gmx.de>
X-Mailer: aerc 0.14.0
References: <20230710133836.4367-1-mail@eworm.de>
 <20230710142916.18162-1-mail@eworm.de>
 <20230710231315.4ef54679@leda.eworm.net>
 <bd0587e16d55ef38277ab1f6169909ae7cde3542.camel@kernel.org>
 <bb5580e93d244400c3330d7091bf64868aa2053f.camel@gmail.com>
 <0f272843a33a1706dbcbb2d84b02e3951ee60cbb.camel@kernel.org>
 <fdd5fd9ece045ebd1888672a75f157e64ade98fb.camel@gmail.com>
 <a588d1d3-12e0-b078-b6cc-b0a63c54ab37@leemhuis.info>
 <CUPW0XP1RFXI.162GZ78E46TBJ@suppilovahvero>
 <CUPWEV9HSGHY.MLO0B4RRH4RR@suppilovahvero>
 <5806ebf113d52c660e1c70e8a57cc047ab039aff.camel@gmail.com>
 <CUPZF09RGD86.VQN9BOMEYZX5@suppilovahvero>
 <2c5abdca1e93894ff3ee41ab1da90a5f8e38657f.camel@gmail.com>
In-Reply-To: <2c5abdca1e93894ff3ee41ab1da90a5f8e38657f.camel@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Sat Aug 12, 2023 at 2:28 PM EEST, Grundik wrote:
> On Fri, 2023-08-11 at 23:01 +0300, Jarkko Sakkinen wrote:
> >=20
> >=20
> > Thanks for sharing your opinion. I'll take the necessary steps.
> >=20
>
> I was thinking... Maybe I'm wrong, maybe I mistaking, but isnt this TPM
> located inside of the CPU chip? So that issue is not specific to laptop
> vendor or model, but its CPU-specific.

Nope, tpm_tis is MMIO interface for so called FIFO register interface,
it could be backed e.g. by SPI [*]. It is a physical layer for MMIO.
There's other backends too such as tpm_tis_i2c where kernel is directly
exposed to the physical layer.

> My MSI A12MT laptop has i5-1240P, Framework laptops mentioned in this
> thread, also has i5-1240P CPU. Unfortunately there are no such
> information about other affected models, but could it be just that CPU
> line?

[*] https://lkml.org/lkml/2023/8/14/1065

BR, Jarkko
