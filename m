Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3013133F242
	for <lists+linux-integrity@lfdr.de>; Wed, 17 Mar 2021 15:08:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231705AbhCQOIQ (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 17 Mar 2021 10:08:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231749AbhCQOIJ (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 17 Mar 2021 10:08:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B864AC06175F
        for <linux-integrity@vger.kernel.org>; Wed, 17 Mar 2021 07:08:08 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=[IPv6:::1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1lMWqB-00045n-H7; Wed, 17 Mar 2021 15:08:03 +0100
Subject: Re: [PATCH v1 0/3] KEYS: trusted: Introduce support for NXP
 CAAM-based trusted keys
To:     Richard Weinberger <richard.weinberger@gmail.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?Q?Horia_Geant=c4=83?= <horia.geanta@nxp.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        James Bottomley <jejb@linux.ibm.com>, kernel@pengutronix.de,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        Udit Agarwal <udit.agarwal@nxp.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>
References: <cover.56fff82362af6228372ea82e6bd7e586e23f0966.1615914058.git-series.a.fatoum@pengutronix.de>
 <CAFLxGvzWLje+_HFeb+hKNch4U1f5uypVUOuP=QrEPn_JNM+scg@mail.gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Message-ID: <ca2a7c17-3ed0-e52f-2e2f-c0f8bbe10323@pengutronix.de>
Date:   Wed, 17 Mar 2021 15:08:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <CAFLxGvzWLje+_HFeb+hKNch4U1f5uypVUOuP=QrEPn_JNM+scg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-integrity@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Richard,

On 17.03.21 00:10, Richard Weinberger wrote:
> On Tue, Mar 16, 2021 at 6:24 PM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>> This series has been tested with dmcrypt[5] on an i.MX6DL.
> 
> Do have this series also in a git repo to pull from?
> I'd like to give it a test on various systems.

Yes, please pull git://git.pengutronix.de/afa/linux
Branch v5.12/topic/trusted-source-caam

It includes these three patches on top of Jarkko's linux-tpmdd/master.

>> Looking forward to your feedback.
> 
> Thanks for working on this! David and I will have a closer look these days.

Great. Here is a simple testing regiment that could help you getting started:

# First boot
    DEV=/dev/loop0
    ALGO=aes-cbc-essiv:sha256
    KEYNAME=kmk
    BLOCKS=20

    mount -o remount,rw /
    fallocate -l $((BLOCKS*512)) ~/loop0.img
    losetup -P $DEV ~/loop0.img
    KEY="$(keyctl add trusted $KEYNAME 'new 32' @s)"
    keyctl pipe $KEY >~/kmk.blob

    TABLE="0 $BLOCKS crypt $ALGO :32:trusted:$KEYNAME 0 $DEV 0 1 allow_discards"
    echo $TABLE | dmsetup create mydev
    echo $TABLE | dmsetup load mydev
    dd if=/dev/zero of=/dev/mapper/mydev || true
    echo "It works!" 1<> /dev/mapper/mydev
    cryptsetup close mydev

# Second boot
    DEV=/dev/loop0
    ALGO=aes-cbc-essiv:sha256
    KEYNAME=kmk
    BLOCKS=20

    losetup -P $DEV ~/loop0.img
    keyctl add trusted $KEYNAME "load $(cat ~/kmk.blob)" @s
    TABLE="0 $BLOCKS crypt $ALGO :32:trusted:$KEYNAME 0 $DEV 0 1 allow_discards"
    echo $TABLE | dmsetup create mydev
    echo $TABLE | dmsetup load mydev

# Should print that It works!
    hexdump -C /dev/mapper/mydev

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
