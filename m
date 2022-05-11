Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5CDC523B32
	for <lists+linux-integrity@lfdr.de>; Wed, 11 May 2022 19:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345344AbiEKRNV (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 May 2022 13:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345336AbiEKRNV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 May 2022 13:13:21 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED47170F10;
        Wed, 11 May 2022 10:13:19 -0700 (PDT)
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id A7F8F22205;
        Wed, 11 May 2022 19:13:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1652289197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=npwkMmic3eVPlZhpwj5rxb1QYIswVUssmBLRYqELZ8U=;
        b=kFd2hM8LE8TfYJ+duByj+KgoHppTeMdfuZGkgZamccC/CSp+ABcID0BaCIEWDmv6cbzj/6
        N7jPiDC3juuEk3/WjBx4vebxjOVyYAzyFmwkumVpGqsSu2YaGXiiVm2MwDxuj5ErkP3MAb
        R5UvvwiMBpuIgi6+w18Geh8tAfxXe2Q=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 11 May 2022 19:13:16 +0200
From:   Michael Walle <michael@walle.cc>
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Bottomley <jejb@linux.ibm.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>, kernel@pengutronix.de,
        Pankaj Gupta <pankaj.gupta@nxp.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        =?UTF-8?Q?Horia_Geant=C4=83?= <horia.geanta@nxp.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Biggers <ebiggers@kernel.org>,
        Jan Luebbe <j.luebbe@pengutronix.de>,
        David Gstir <david@sigma-star.at>,
        Richard Weinberger <richard@nod.at>,
        Franck LENORMAND <franck.lenormand@nxp.com>,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Sumit Garg <sumit.garg@linaro.org>, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Subject: Re: [PATCH v9 7/7] MAINTAINERS: add KEYS-TRUSTED-CAAM
In-Reply-To: <YnvTyd8s4T+s/uAL@kernel.org>
References: <20220506062553.1068296-1-a.fatoum@pengutronix.de>
 <20220506062553.1068296-8-a.fatoum@pengutronix.de> <YnbH2Fgn/JFOU3Rf@iki.fi>
 <YnbIiJynQq/tcFa2@iki.fi>
 <e49920e6-0852-ad3d-5758-604655591671@pengutronix.de>
 <YnvTyd8s4T+s/uAL@kernel.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <9ef8e6ee30ddaf71864dbdd50bb8a70f@walle.cc>
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

Am 2022-05-11 17:18, schrieb Jarkko Sakkinen:
> On Wed, May 11, 2022 at 12:48:53PM +0200, Ahmad Fatoum wrote:
>> On 07.05.22 21:29, Jarkko Sakkinen wrote:
>> >>> +KEYS-TRUSTED-CAAM
>> >>> +M:	Ahmad Fatoum <a.fatoum@pengutronix.de>
>> >>> +R:	Pengutronix Kernel Team <kernel@pengutronix.de>
>> >>> +L:	linux-integrity@vger.kernel.org
>> >>> +L:	keyrings@vger.kernel.org
>> >>> +S:	Maintained
>> >>> +F:	include/keys/trusted_caam.h
>> >>> +F:	security/keys/trusted-keys/trusted_caam.c
>> >>> +
>> >>>  KEYS/KEYRINGS
>> >>>  M:	David Howells <dhowells@redhat.com>
>> >>>  M:	Jarkko Sakkinen <jarkko@kernel.org>
>> >>> --
>> >>> 2.30.2
>> >>>
>> >>
>> >> Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
>> >
>> > 3/7 would probably need tested-by. Other than that this starts to look
>> > good...
>> 
>> It has been tested by me on an i.MX6 (era < 10 with blobbing support)
>> and by Michael on a LS1028A (era >= 10, both with and without blobbing
>> support).
>> 
>> Cheers,
>> Ahmad
> 
> Michael, can you give a tested-by for the corresponding patch?

I guess there will be a new version and esp a change of that patch.
I'll retest once the new version is out.

-michael
