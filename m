Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA80F40902D
	for <lists+linux-integrity@lfdr.de>; Mon, 13 Sep 2021 15:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244820AbhIMNul (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Mon, 13 Sep 2021 09:50:41 -0400
Received: from mxout70.expurgate.net ([194.37.255.70]:55347 "EHLO
        mxout70.expurgate.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243603AbhIMNsL (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 13 Sep 2021 09:48:11 -0400
Received: from [127.0.0.1] (helo=localhost)
        by relay.expurgate.net with smtp (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1mPmIN-0004dK-P6; Mon, 13 Sep 2021 15:46:51 +0200
Received: from [195.243.126.94] (helo=securemail.tdt.de)
        by relay.expurgate.net with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <fe@dev.tdt.de>)
        id 1mPmIN-00014X-29; Mon, 13 Sep 2021 15:46:51 +0200
Received: from securemail.tdt.de (localhost [127.0.0.1])
        by securemail.tdt.de (Postfix) with ESMTP id 64BF3240042;
        Mon, 13 Sep 2021 15:46:50 +0200 (CEST)
Received: from mail.dev.tdt.de (unknown [10.2.4.42])
        by securemail.tdt.de (Postfix) with ESMTP id E51A0240041;
        Mon, 13 Sep 2021 15:46:49 +0200 (CEST)
Received: from mail.dev.tdt.de (localhost [IPv6:::1])
        by mail.dev.tdt.de (Postfix) with ESMTP id 584BF20110;
        Mon, 13 Sep 2021 15:46:48 +0200 (CEST)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 13 Sep 2021 15:46:48 +0200
From:   Florian Eckert <fe@dev.tdt.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     peterhuewe@gmx.de, jarkko@kernel.org,
        Eckert.Florian@googlemail.com, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] tpm/tpm_i2c_infineon: Fix init endian vendor check
In-Reply-To: <20210913130210.GD3544071@ziepe.ca>
References: <20210913120521.18572-1-fe@dev.tdt.de>
 <20210913130210.GD3544071@ziepe.ca>
Message-ID: <690f5a5f846c4ef966713b4970d07737@dev.tdt.de>
X-Sender: fe@dev.tdt.de
User-Agent: Roundcube Webmail/1.3.16
X-Spam-Status: No, score=-1.0 required=5.0 tests=ALL_TRUSTED,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.dev.tdt.de
X-purgate-ID: 151534::1631540811-00000C04-D5556CE0/0/0
X-purgate: clean
X-purgate-type: clean
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Hello Jason,

>> The device works than as expected.
>> 
>> Signed-off-by: Florian Eckert <fe@dev.tdt.de>
>> ---
>> v2:
>> * use variable type instead of le32_to_cpus function call
>>  drivers/char/tpm/tpm_i2c_infineon.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> And if you do this it need to be made sparse clean/etc

Sorry for the stupid question, but what exactly do you mean?

-- Florian
