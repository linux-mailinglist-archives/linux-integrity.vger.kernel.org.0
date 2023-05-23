Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C0270E5A7
	for <lists+linux-integrity@lfdr.de>; Tue, 23 May 2023 21:36:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233678AbjEWTgC (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 15:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233459AbjEWTgB (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 15:36:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14CC8184;
        Tue, 23 May 2023 12:35:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C286635F7;
        Tue, 23 May 2023 19:35:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7A3C433D2;
        Tue, 23 May 2023 19:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684870543;
        bh=8UAWbMOvWVlLXA/9nZRNOtM83fge0RgtLqk1AKszgiM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Eox9NlFKpx9DQ9qZDiOfGD014YFndCguOTBgs14k7GKu4oV60R34IIZLhS47P1Ck6
         gENWYYFrAp3kSW2ANucrEt3EDJoqMOVt+JvP+E6rTzSWmnMa3kTSMoPYCnv3M9xDmx
         9nub8BSbW4ee6aFGxCnv5c0GS80dtWlzhJowqG3pJv2FeZkt+fXC+g6RyQufhJnqwD
         lxi8AGG3Isbjgkg7jfZ4ytABoFZiNB42a4MoD6uPWiBNA0EiZIZQKXka3WwWAfFRIW
         +RoEZO+KUvfspc8Vq18h+ZmqNY1D1BQteFRt1VumM6RY7/wbiJ8w/6kZk0WgFNxjdb
         qpIXkAhnOLJWA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 23 May 2023 22:35:38 +0300
Message-Id: <CSTWRBU7DGSV.3490IUZBBV5P7@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     =?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        "Lino Sanfilippo" <LinoSanfilippo@gmx.de>, <peterhuewe@gmx.de>,
        <jgg@ziepe.ca>
Cc:     <jsnitsel@redhat.com>, <hdegoede@redhat.com>,
        <oe-lkp@lists.linux.dev>, <lkp@intel.com>, <peterz@infradead.org>,
        <linux@mniewoehner.de>, <linux-integrity@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <l.sanfilippo@kunbus.com>,
        <lukas@wunner.de>, <p.rosenberger@kunbus.com>
Subject: Re: [PATCH 1/2] tpm, tpm_tis: Handle interrupt storm
X-Mailer: aerc 0.14.0
References: <20230522143105.8617-1-LinoSanfilippo@gmx.de>
 <c772bcdf-8256-2682-857c-9a6d344606d0@linux.intel.com>
In-Reply-To: <c772bcdf-8256-2682-857c-9a6d344606d0@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Tue May 23, 2023 at 9:48 AM EEST, P=C3=A9ter Ujfalusi wrote:
>
>
> On 22/05/2023 17:31, Lino Sanfilippo wrote:
> > From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
> >=20
> > Commit e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test") enabled
> > interrupts instead of polling on all capable TPMs. Unfortunately, on so=
me
> > products the interrupt line is either never asserted or never deasserte=
d.
> >=20
> > The former causes interrupt timeouts and is detected by
> > tpm_tis_core_init(). The latter results in interrupt storms.
> >=20
> > Recent reports concern the Lenovo ThinkStation P360 Tiny, Lenovo ThinkP=
ad
> > L490 and Inspur NF5180M6:
> >=20
> > https://lore.kernel.org/linux-integrity/20230511005403.24689-1-jsnitsel=
@redhat.com/
> > https://lore.kernel.org/linux-integrity/d80b180a569a9f068d3a2614f062cfa=
3a78af5a6.camel@kernel.org/
> >=20
> > The current approach to avoid those storms is to disable interrupts by
> > adding a DMI quirk for the concerned device.
>
> This looked promising, however it looks like the UPX-i11 needs the DMI
> quirk.

My take is this:

1. Keep calmd and add DMI quirks (for some time).
2. Let's reconsider if this becomes a too pressuring issue.
3. If there is need for IRQ detection, let's pick a parameter that
   would be also *intuitive* tuning parameter [1].

[1] https://lore.kernel.org/linux-integrity/CSTW9UX4ERDZ.VBD1QIWLBM75@suppi=
lovahvero/

BR, Jarkko
