Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1492523D7B
	for <lists+linux-integrity@lfdr.de>; Wed, 11 May 2022 21:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346921AbiEKTbS (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 11 May 2022 15:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347010AbiEKTac (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 11 May 2022 15:30:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3342F22A89D;
        Wed, 11 May 2022 12:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1652297398;
        bh=98QCBOcQyax0rGKmfG1kKzuqMy3EQ5X/r9nNeTERjGw=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Lt1AvZjrVOMyp25OcqHr85pprH8GUfXFLfSZnurYomAjLxyJD1MRCX8CHKoKnfsnS
         CApFQsNA1JkKMErq0wcA/GfAQBYoHWpmVspFvcYHnvPhYKYH1Ea/tTcIfY7jWzqx7P
         VauliNMZdt+YBkmNuq8di4kLL8WU6UuqlHmV9/aE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.3.12]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFsYx-1nZEYz2JbD-00HMzQ; Wed, 11
 May 2022 21:29:58 +0200
Subject: Re: [PATCH v4 2/6] tpm, tpm_tis: Claim and release locality only once
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, lukas@wunner.de,
        p.rosenberger@kunbus.com, Lino Sanfilippo <l.sanfilippo@kunbus.com>
References: <20220509080559.4381-1-LinoSanfilippo@gmx.de>
 <20220509080559.4381-3-LinoSanfilippo@gmx.de> <YnudhZZGXf87U3bd@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <f576a24d-d175-0153-9992-f6dd80d57b62@gmx.de>
Date:   Wed, 11 May 2022 21:29:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YnudhZZGXf87U3bd@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2YM3NlkX/0sMI9zCc5RY9WsR+sxWJN0JqQrDj/YQAw0LZLxmRJn
 rY4U4x7LZQZf6s0BzWRcDDv1qH2TZ5TnzkcqBCFG6vTO7tADVUDTp4L2NjT4Z6ZYiwQW3gF
 pSfzJ3EosYa4IU5B70bFu5AC3vXEBPpk28KGklYf9P5d8sjj93ERAnNUSqjwCo8tPA+Ok7u
 2ISBD5k61TChIUtU77MOA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zVd0z/W2Nv0=:Rrx1YWBizcmRz3bHpDaJsH
 1ZBBQIvNHn6VlEOjcIVdXoeA1LdUrBsp5zjreoPVJkoRZoQL6r73djGhy3clnwDWhrTlzKB+x
 ajCkdzhzp3sEE6H5C9F5/gDfvttu0OkGmFHtBZOEkzcl/RpvwO7D7lcrDidScg6w598E0WF+3
 0NvLCRZw/xVIPuU7L4pe/mSbpicdwAGVnge+tgW236lHJQeNYyjhWgXa9ZTsApFHSPgfzI+In
 JWyMSBQScSPasWnUXVi+1W+S8t5KhRRw+qO5PnN0TZ0cg2fTTFZj+arMN2MTEr2ZGX9V9DNCY
 /rBmfnR1NPaXMIxanTMxvv+KxatY4BEAA/xwJT4HkPQMEvcjCN0odNvtHMSvV0om1tpbpPxwD
 p7ujpnbuRFWRrCTeCM3InK2rs0ax6eokX4/hNB035MJuudkIXISGyjTDFsDmC5c2lQ7KSQ/pH
 VEpTbyMJq3lChQ0Z7KhLufoEcF9GMEe/7wCgEolyXSFXiRStoffd7hU93nl/i0ES1yPUXLqbW
 PvBmToubPg74cS5OaQzABqneV1f6kiBcbLCDKeacFPsDQXG/PKcr02r7Z0YnZSWag3h4PZMGG
 0isuJiu5lC5HReqVoUNv55pfwOiK2UkOFnvMdJnQd4buFYEozByjasJ/aMK33oo+WKvjuzt/0
 ANljAWK/iwfaR1WYCaD1J8ta0uazkgQZPnbNkWlNqoIsjq/04WDJBJZm3Jb3Xmnoh9uuE4PxU
 lQvy19UD6R+jqJwZPdoUWCMo0rkHHK/3uqr1Jiru5Fnikw2bLeQOLdwPWrjd5UJgFVorEMsyw
 nkaKulBX2MUP2qlyeav0THQTOQVE9AKq4QFD8iWkB/zrxXUEopqd7gMYLdJJ1lqsKxqSq0hRT
 ty8MWdziaDvib4VjeUp3Bvhs82eL5mGrYzwoAypl12GvSvewU8zIDGutBCADbtBP0CAruvqbi
 HHnynzQrsGLqPbsP+P3ASOphbY4gA1fGRQyhJMPL2ImuXqkX9+DrM0uygEPIxZXWhN+x8Bdrn
 5CR6kJpumQjqJ0gVX+TTElTkm737Fc110nTSak7w9QSXpj9S5nQUcYAY7hjSZhapG4oF4ycNf
 qrWvWXuLeAG8G02hp7rgxyMRKPmh8HSX06izxMD2qd5j/Fvmj5Hv4I3AA==
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org



On 11.05.22 at 13:27, Jarkko Sakkinen wrote:
> On Mon, May 09, 2022 at 10:05:55AM +0200, Lino Sanfilippo wrote:
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> It is not necessary to claim and release the default locality for each =
TPM
>> command. Instead claim the locality once at driver startup and release =
it
>> at driver shutdown.
>>
>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>
> We are doing what we're being because of Intel TXT:
>
> https://lore.kernel.org/tpmdd-devel/20170315055738.11088-1-jarkko.sakkin=
en@iki.fi/
>
> Unfortunately cannot accept this change.
>

I do not see how the patch affects the crb code since the only changes con=
cern the
tpm_class_ops of the tis core. AFAICS crb uses its own set of tpm_class_op=
s
which are still used to claim and release the locality.

Or do I miss something?

Regards,
Lino


