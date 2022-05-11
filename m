Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30DB7523019
	for <lists+linux-integrity@lfdr.de>; Wed, 11 May 2022 12:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238407AbiEKKAU (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 May 2022 06:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238277AbiEKJ7s (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 May 2022 05:59:48 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 685641DEC58;
        Wed, 11 May 2022 02:59:38 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id F2CD822247;
        Wed, 11 May 2022 11:59:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1652263176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JZhWWO3QstT97s01mFu1Bt71dN/IqXZaokx+ODMQ35w=;
        b=Cynq8uSxjBN0lAP/BLcfwojdc2XLfbG7IlqaDCl4Ro8j3QEO5eihr0NCX3F2IbyhxkIY/a
        0qdhWP9yV/NR+LKNwkxZgTQVTKOFBtV3U47sMr8EHWa8+zT0SZiczTeDS5/mo9jXEP/wfv
        Fp7Sy97rrxMgIQ2dBjP46NCleJRcHSg=
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Wed, 11 May 2022 11:59:35 +0200
From:   Michael Walle <michael@walle.cc>
To:     =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>
Cc:     Pankaj Gupta <pankaj.gupta@nxp.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>, kernel@pengutronix.de,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>,
        Franck Lenormand <franck.lenormand@nxp.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [EXT] [PATCH v9 3/7] crypto: caam - determine whether CAAM
 supports blob encap/decap
In-Reply-To: <c3c1fbf2-c73a-02ec-d2cb-354880a84d5f@nxp.com>
References: <20220506062553.1068296-1-a.fatoum@pengutronix.de>
 <20220506062553.1068296-4-a.fatoum@pengutronix.de>
 <DU2PR04MB8630501008F661C596C0106295C69@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <5e7c0b3c9bc285f1cf9f7b20f055aa376e1688cc.camel@pengutronix.de>
 <DU2PR04MB8630A6F925454E5C007FA3EA95C89@DU2PR04MB8630.eurprd04.prod.outlook.com>
 <232eb799dbbd341c305e911f85341409@walle.cc>
 <c3c1fbf2-c73a-02ec-d2cb-354880a84d5f@nxp.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <a3b290ee4367309739948c06c11964f4@walle.cc>
X-Sender: michael@walle.cc
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

Am 2022-05-11 11:48, schrieb Horia Geantă:
> On 5/11/2022 12:21 PM, Michael Walle wrote:
>> Hi,
>> 
>> Am 2022-05-11 11:16, schrieb Pankaj Gupta:
>>>> -----Original Message-----
>>>> From: Ahmad Fatoum <a.fatoum@pengutronix.de>
>>>> Sent: Monday, May 9, 2022 6:34 PM
>>>> To: Pankaj Gupta <pankaj.gupta@nxp.com>; Horia Geanta
>>>> <horia.geanta@nxp.com>; Herbert Xu <herbert@gondor.apana.org.au>;
>>>> David S.
>>>> Miller <davem@davemloft.net>
>>>> Cc: kernel@pengutronix.de; Michael Walle <michael@walle.cc>; James
>>>> Bottomley <jejb@linux.ibm.com>; Jarkko Sakkinen <jarkko@kernel.org>;
>>>> Mimi
>>>> Zohar <zohar@linux.ibm.com>; David Howells <dhowells@redhat.com>;
>>>> James
>>>> Morris <jmorris@namei.org>; Eric Biggers <ebiggers@kernel.org>; 
>>>> Serge
>>>> E.
>>>> Hallyn <serge@hallyn.com>; Jan Luebbe <j.luebbe@pengutronix.de>; 
>>>> David
>>>> Gstir
>>>> <david@sigma-star.at>; Richard Weinberger <richard@nod.at>; Franck
>>>> Lenormand <franck.lenormand@nxp.com>; Matthias Schiffer
>>>> <matthias.schiffer@ew.tq-group.com>; Sumit Garg
>>>> <sumit.garg@linaro.org>;
>>>> linux-integrity@vger.kernel.org; keyrings@vger.kernel.org; linux-
>>>> crypto@vger.kernel.org; linux-kernel@vger.kernel.org; 
>>>> linux-security-
>>>> module@vger.kernel.org
>>>> Subject: Re: [EXT] [PATCH v9 3/7] crypto: caam - determine whether
>>>> CAAM
>>>> supports blob encap/decap
>>>> 
>>>> Caution: EXT Email
>>>> 
>>>> Hello Pankaj,
>>>> 
>>>> On Mon, 2022-05-09 at 12:39 +0000, Pankaj Gupta wrote:
>>>>>> -       if (ctrlpriv->era < 10)
>>>>>> +       comp_params = rd_reg32(&ctrl->perfmon.comp_parms_ls);
>>>>>> +       ctrlpriv->blob_present = !!(comp_params & CTPR_LS_BLOB);
>>>>>> +
>>>>>> +       if (ctrlpriv->era < 10) {
>>>>>>                 rng_vid = (rd_reg32(&ctrl->perfmon.cha_id_ls) &
>>>>>>                            CHA_ID_LS_RNG_MASK) >>
>>>>>> CHA_ID_LS_RNG_SHIFT;
>>>>> 
>>>>> Check for AES CHAs for Era < 10, should be added.
>>>> 
>>>> Do I need this? I only do this check for Era >= 10, because 
>>>> apparently
>>>> there are
>>>> Layerscape non-E processors that indicate BLOB support via
>>>> CTPR_LS_BLOB, but
>>>> fail at runtime. Are there any Era < 10 SoCs that are similarly
>>>> broken?
>>>> 
>>> 
>>> For non-E variants, it might happen that Blob protocol is enabled, 
>>> but
>>> number of AES CHA are zero.
>>> If the output of below expression is > 0, then only blob_present
>>> should be marked present or true.
>>> For era > 10, you handled. But for era < 10, please add the below 
>>> code.
>> 
>> Are there any CAAMs which can be just enabled partially for era < 10?
>> I didn't found anything. To me it looks like the non-export controlled
>> CAAM is only available for era >= 10. For era < 10, the CAAM is either
>> fully featured there or it is not available at all and thus the node
>> is removed in the bootloader (at least that is the case for 
>> layerscape).
>> 
> Qouting from our previous discussion in U-boot:
> https://patchwork.ozlabs.org/project/uboot/patch/20200602150904.1997-1-michael@walle.cc/#2457448
> 
> "
> Based on previous (NXP-internal) discussions, non-E crypto module is:
> -fully disabled on: LS1021A (ARMv7), LS1043A, LS1088A, LS2088A
> (and their personalities)
> -partially [*] disabled on: LS1012A, LS1028A, LS1046A, LX2160A
> (and their personalities)
> "
> 
> From the partially disabled list, LS1028A and LX2160A have CAAM Era 10,
> while LS1012A and LS1046A integrate CAAM Era 8.

Thanks for clarification. Do you know it that is a layerscape feature?
I had a look at the imx8mn which have a era 9 and it doesn't have the
PKHA_VERSION register which indicates the partially disabled PKHA
block. Thus I concluded that there is no partially disabled feature
on era < 10.

Unfortunately, I don't have a security manual for the LS1012A and
LS1046A so I cannot check there.

-michael
