Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5DD74DD73
	for <lists+linux-integrity@lfdr.de>; Mon, 10 Jul 2023 20:38:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjGJSiI (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 10 Jul 2023 14:38:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjGJSiH (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 10 Jul 2023 14:38:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF09DF;
        Mon, 10 Jul 2023 11:38:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 47A7661193;
        Mon, 10 Jul 2023 18:38:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3ACE2C433C7;
        Mon, 10 Jul 2023 18:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689014285;
        bh=oDS27tMrJVOBiZY57a+Ie8tABqwg5aAwz9QA3VZd2U0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ru2Zb17q5QYtxC+JqO+OEMltt4uxzx5xdMQUW79j/15YksroEXdTBaBSGQpUFBNuD
         E6JTSOGUzIwNCWN7KDkLBwVUfcy9weJmES0ws49q8Yd2LLnC496c3HEyK/oLqhWnlJ
         6y6UYAvU3Fft1iEU/MvvYw2fU4Qbx6b+k/aJ8s/6DbNr5RyuvC7DhXu1h8p0wKSqUu
         UUyVoJBD6deIMTb8hg/gWt0caQsvAfJhHzx2gKGjCmZJgT3Djm8m1DFhLWxXOXV5Ls
         uwjl6xkDtPSLqQ/U09FE5kRfWHwn6xvhOFRX10ga9mt7ERoC1jXItAJoCnzV60lmMg
         Glki5J1aqPAKQ==
Message-ID: <36a25631960bc178b318e319f1db0d4d275c910f.camel@kernel.org>
Subject: Re: [PATCH v2 1/2] tpm/tpm_tis: Disable interrupts for Framework
 Laptop Intel 12th gen
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Christian Hesse <mail@eworm.de>
Cc:     linux-integrity@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Peter Huewe <peterhuewe@gmx.de>, stable@vger.kernel.org,
        roubro1991@gmail.com
Date:   Mon, 10 Jul 2023 21:38:01 +0300
In-Reply-To: <ZKxHfTkgKHYqhBz2@ziepe.ca>
References: <20230710133836.4367-1-mail@eworm.de>
         <20230710142916.18162-1-mail@eworm.de> <ZKxHfTkgKHYqhBz2@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon, 2023-07-10 at 15:01 -0300, Jason Gunthorpe wrote:
> On Mon, Jul 10, 2023 at 04:28:43PM +0200, Christian Hesse wrote:
> > This device suffer an irq storm, so add it in tpm_tis_dmi_table to
> > force polling.
>=20
> I can't help but feel like we are doing something wrong in the Linux
> driver that we keep having IRQ problems.
>=20
> Surely Windows uses the IRQ on these devices? How does it work
> reliably there?
>=20
> Jason

I'm about to send a PR to Linus with a pile of IRQ fixes for v6.4
feature.

BR, Jarkko

