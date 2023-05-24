Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47EB470EB8B
	for <lists+linux-integrity@lfdr.de>; Wed, 24 May 2023 04:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233836AbjEXCuj (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 23 May 2023 22:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239194AbjEXCug (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 23 May 2023 22:50:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85A5E1B5;
        Tue, 23 May 2023 19:50:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 195A66380D;
        Wed, 24 May 2023 02:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B780C433D2;
        Wed, 24 May 2023 02:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684896630;
        bh=BkTM5C2q4ZerwuurY3Z8V/ost1/GfN3kAGW+XpxBpUU=;
        h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
        b=UjHPrneL65lEVDz7REfAtHPZFBBVEWXXg/rwm46zLjVAq1C+NIYypq9IUw/MxBXTb
         XEv+uPCErK4eBnbxPa+bafHFuipIP1DSYrEA2p68bzFiOCBwDv5PhTFp900B+viPqh
         Je6hIVPjaVzv0aLLzew/aEgo6d7dGQ3SljY39wPzHzTum1m+uhfIRdyFfTDZrioTk5
         IKmWBDZbaNoFdZOi99pm6ObfNahH0ooUk+Jor9yrguKegs0s7+z9MqjP6RNbmkkcEH
         eWlraXWLLe3KON2XKqmKi6xGmIUEQHN4eACrdj6MqRQTJLVg+ISggHVfNRsgixb8ny
         8dsfk2btCk0kQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 24 May 2023 05:50:27 +0300
Message-Id: <CSU6091FJLXS.3MMTQQFUENGKB@suppilovahvero>
Cc:     <peterhuewe@gmx.de>, <jgg@ziepe.ca>,
        <linux-integrity@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <l.sanfilippo@kunbus.com>
Subject: Re: [PATCH - for 6.4] tpm: tpm_tis: Disable interrupts for AEON
 UPX-i11
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     =?utf-8?q?P=C3=A9ter_Ujfalusi?= <peter.ujfalusi@linux.intel.com>,
        "Jerry Snitselaar" <jsnitsel@redhat.com>
X-Mailer: aerc 0.14.0
References: <20230517122931.22385-1-peter.ujfalusi@linux.intel.com>
 <ohdpul6hax5bj5hhsnpt7i3ejbttivufmoolzunbhipexjkczi@meg3zx2yqkc7>
 <CSPMQ03V3G7G.EBWKDRE4B0XY@suppilovahvero>
 <432df3cf-da16-1f2a-02dc-e2c371c1f29c@linux.intel.com>
 <2c94260b-ac97-3f5e-331b-76f1a17ec5b5@linux.intel.com>
In-Reply-To: <2c94260b-ac97-3f5e-331b-76f1a17ec5b5@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On Mon May 22, 2023 at 10:40 AM EEST, P=C3=A9ter Ujfalusi wrote:
>
> On 18/05/2023 23:24, P=C3=A9ter Ujfalusi wrote:
> >=20
> > The version is used to differentiate the revisions of the UPX-i11
> > boards, and this issue present in all revisions.
> >=20
> >> I can squash this to the commit I pushed (it is not yet mirrored
> >> to linux-next), if I get the dmidecode info.
> >=20
> > System Information
> >         Manufacturer: AAEON
> >         Product Name: UPX-TGL01
> >         Version: V1.0
> >         Serial Number: Default string
> >         UUID: a300091d-fb1c-ce1c-1d30-0007328efc11
> >         Wake-up Type: Power Switch
> >         SKU Number: Default string
> >         Family: Default string
> >=20
> > I have used this description as it it is used for SOF, probably
> > DMI_MATCH(DMI_PRODUCT_NAME, "UPX-TGL01")
> > should be added?
>
> Jarkko: I have tested that adding the
> DMI_MATCH(DMI_PRODUCT_NAME, "UPX-TGL01")
> works.
>
> I would also do a small update to commit message: "120000 jiffies"  to
> "120000 msec".
> On my setup 120000 msec ends up to be 120000 jiffies.
>
> How do you prefer to handle this?
> I can send a v2 on top of linux-next / mainline
> I can send a fixup patch which can be squashed to the patch you have in
> your master branch atm
> Or you add this line by yourself?
>
> Either way is fine for me, whichever works best for you.

If you want to send a follow-up please do, and I can pick it.

BR, Jarkko
