Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3730C4C8F62
	for <lists+linux-integrity@lfdr.de>; Tue,  1 Mar 2022 16:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235810AbiCAPrN (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 1 Mar 2022 10:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235713AbiCAPrN (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 1 Mar 2022 10:47:13 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8609527E0;
        Tue,  1 Mar 2022 07:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646149563;
        bh=CNTbDLm/SXlfrI/Yw70t8qZjmfwCUbk5EeiLym2vS3o=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=OqC9dpJ3yht3ymwKViwQ6Jqu/47pCQjQJCutG//Mw/O396ZZE5aD4yZuzZBir1EXy
         g9A1/c1uZKi3x+R0OjNIgbce6t0mqQmK6iYwx1omHJQ4heVHbfnqt3WO6wNgCdcP0Q
         4oWrygvTkjGUIQtB2qoX3uVWn2WK2bQNUcNa6+G8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.178.74] ([149.172.237.68]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMobU-1nfdeA3ROW-00ImCR; Tue, 01
 Mar 2022 16:46:02 +0100
Subject: Re: [PATCH v8 0/1] tpm: fix reference counting for struct tpm_chip
To:     Stefan Berger <stefanb@linux.ibm.com>, peterhuewe@gmx.de,
        jarkko@kernel.org, jgg@ziepe.ca
Cc:     stefanb@linux.vnet.ibm.com, James.Bottomley@hansenpartnership.com,
        David.Laight@ACULAB.COM, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, p.rosenberger@kunbus.com
References: <20220301022108.30310-1-LinoSanfilippo@gmx.de>
 <a7a2c56c-a82b-40a9-68e5-7e6d92427c70@linux.ibm.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <fbb0a768-dbef-bb6e-f77b-f40a4da7f8bb@gmx.de>
Date:   Tue, 1 Mar 2022 16:45:59 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a7a2c56c-a82b-40a9-68e5-7e6d92427c70@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:l49twx3iq+56+pdB2eO5/63gkDHhNjH0/WXOoYU80/wUXFqDRxb
 49CAPOfq/lQ0DHeC95gvHjTF5qGvfaoM8EEtNxqqKp2CblmJ6eEzOB8bhQS0tqyNKi5l+yY
 fdzkAgPCD6Q3AdzFj2exLDsQARTkXEZNx5wJ5HI7B0TnAeEKlsr3yf54jhJ65mWjITVDU3M
 ZHEqQKoj8XAjuX82js40w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bz4EH9nboAk=:kvWMoadFvgpJG2LMr8o9Cd
 RAQv7YWSUePsU0cPeMkx1LR2z7gMLBlReBsvqFaGADLOfaIujzBRkswF5uUm9119qSezUHekk
 ePHxBO/VwnPlagWznNtZf38thaDprEGZ85Ye2HVp+xjzbmyEpdugrUQjyQAwH3GCOPKXSXSNy
 qvP+nruQc5kMN+dWOtV7qYBwqPRA57pyYYNB20IzcR4vfBan8SI+imDm9lY+AzEuM1RGvowNT
 YleJ/EadRiSw9BxutDXHw1XoNtExwcmEuDmwLXxxbm86ILQazPoMuZu0xOE1XBczGGzJ+Z1LJ
 WxkJUCzOREvyTIzfZqoxwowsZFhYTI7NcdvQtMzJPLG00+Hbc33MGT54ofg0xFpIm7oI8TjwE
 3be2pfdQND+X1tJZPhHirpwKj/zf2SzjMZzoiayXdAIrdEYr0iftsL5Hlo5gCu/gGsm7rh6hm
 qn9ETUNcc3pRhxXWRBFfY/WG5jx/mtJALk6yGKeZ4nzck15c0UqyYa+lm0WUC2NC7S/9Igv0E
 eDPJEyxoWoOP/mKEGiDfyGOp4FmPH3yZPZ1AsKNqtNduzr30u+NlRvWzP1asdAtHxFlhG9yDq
 DYWyGqUJI1FGhFWl6ePzdADzh6Ld3MjpJx8m+YjLaxMkcO+BgtEpC9+Ufyq4J8wnqPUzVvff6
 y8jdknYZjMjvgm3f31Tww+PFraVHYddnGVlA/+WYUeG8M1KC2Jc4sJ8QfMV0GyyItxMij9TQU
 IJWgwTG0jeRK8CjeSKNSbbGcEaQGP2copLqhd6ClLIZ8N0lsfHMkF3GBMPaozxOUHUcHSONKX
 iwI4mykkMLkSLTtjECWBTnPkRjnHeO3nnOD/QZGjsvbZOjPilpb2AGEq+oWlMC5UnLNNSYED9
 YLvXm9QA3/zeuMB7H1xKFSkpuMe3BfRQtDa7VRiHSyHHOHNfjOLsim/A35J4P7unsUEX8Go4t
 TgZf6psia4nkoLy6bU4RTMGhNKz7FCs1BHK6pRCkSS2rsd6/wl8GArhgB48lNdSuL1gPsNMDb
 4lb7PRe1r7FhLbit/BxJhfvxXsCcC/j5BDmZyFlX5wazqvoCV/R95MOpuket1ASRqA/ZOe2eC
 KEs5Jp06NMyJ5E=
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 01.03.22 at 14:56, Stefan Berger wrote:

>
> We also need to apply this patch here to fix another crash:
>
> https://lore.kernel.org/all/20210615091410.17007-2-vincent.whitchurch@ax=
is.com/
>

Right, this is another issue that should be fixed. The bugfix you mention =
is essentially the same
as James proposed over two years ago:

https://lore.kernel.org/linux-integrity/e7566e1e48f5be9dca034b4bfb67683b5d=
3cb88f.camel@HansenPartnership.com/

Regards,
Lino





