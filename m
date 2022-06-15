Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53D354D440
	for <lists+linux-integrity@lfdr.de>; Thu, 16 Jun 2022 00:08:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347891AbiFOWIv (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 15 Jun 2022 18:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350414AbiFOWIe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 15 Jun 2022 18:08:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD24A42A05;
        Wed, 15 Jun 2022 15:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1655330901;
        bh=YTzmET/tH2HD8vOlvz/aarT5wNU4Ip1N3B72KZ7IcGk=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=M+R8dVlcrWrxDoEJaFd+2B2arPG4kRQ5o/Pl5ml8s6+JVeg0LtR8tLsWo1NiERQf+
         c9vEbJBQOooek12I1zWL5F6etOx15X4sC1vWWPDHqj9VEINmLPIPm2sG3slvmxn3i4
         Wk+Y6oaySoEqHaYUcLXD53PjocQW5gW2giI2ytKQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.2.17]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3siG-1nbIuL2VpQ-00zoYT; Thu, 16
 Jun 2022 00:08:21 +0200
Subject: Re: [PATCH v5 06/10] tpm, tpm_tis: Only handle supported interrupts
 in wait_for_tpm_stat()
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
References: <20220610110846.8307-1-LinoSanfilippo@gmx.de>
 <20220610110846.8307-7-LinoSanfilippo@gmx.de> <YqojLqfoy2NXTTGV@iki.fi>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <a4a88b28-0ea0-b285-fe5c-d42944032db2@gmx.de>
Date:   Thu, 16 Jun 2022 00:08:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <YqojLqfoy2NXTTGV@iki.fi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ar6jD7PFDwwoQrLs5YTXC8YDLE4YHM7JD6SlZk+JA+1urt37hif
 xYp1fE1XpWkUVCjwSg9Q9jpYtPvHLJRFfunu33pmok024ISn4M2fUw64JE4TEVVIOg6ZfDz
 GWDlw3yynrw42c7PcdLgPUinItNCEMGMIq/ZdBsxtgogj5eyaDnXWLxOWSWl+txwFa6emZ5
 CwtA3y8oXhGGHfI+EQ0Og==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YHYBtC2OOZ8=:gwZGfpcLCOoQ6RZA9zz8ZG
 3Se0kGCFHbwQtdW8bkpkC4kUYErd2gKFdUzPXWj65dxKYtp3bpECHcPfM5PsUsErg6ZJ/QLMk
 SpiGxrFvZTie0gCdZlHEqiKuu3shQ21AU9i9DHMgknQgy+cOZZR4+Vk1RiWEf+Uyxhr+R5Qr8
 9BEgtexupotZ7jOoEIvO/E9KISlKdE1lXnXBTy9dUkay3o16PYYaoL73XPRTZwd+hFb4WVeAn
 WUkXzzZVHgnlLNPz2u57CJ5KOUPBeCqc9V6LTeTGPxUGVTgfWM+4VyrmdWkLQsUvPAQcYSXEj
 ICqVxw+6FUHUZuF/cq5GV+PgBN3b6/HKI7Np48/dN+CIcDXjhanuHeGBZxEdmNx5gRKdpp3B8
 e00xTszh+SGw4ePXqsKDlesWbGQP7d48cYe7CbXhCH93iw1gE/IDZPaZXBY21tJyEPLgafqvn
 leMloaYjUkya21uV2nFi+0D/Eiwp2NeRVoBl1SuxdSdlimjNEIpxZKOcER6tgFk4p38S2Und0
 UylynBR+8sq4IYhKVKMt39mH2fGv8LzTk18wBbs424Ndu8bLdpEjkA+00/IQKIQJQfvEfjWSP
 NbmmSuWoIDxJ2lY1ewJ//FKpWTr6EzbhvtchHgW7PydqNuXPH53wgmXSTTslyWkSdNFjmCM9R
 I6fUYmx02kc/L0zkpDjrnPu416CkjPOGKepkpUKWbx08vrAdMpid/7gRUboyPkJEjJKldmuXC
 aNVPdx5qxN2qacWM/txsAFlmhOKS0aTP4OOQX60w4k6xRppLJWtthZyS+ciYajNFCzLQBoOy/
 QAgOxcfLsRQsOSlIe2dPMjA/pNqrfT3dyrQn7N+uvc69D7klM21nHms5zhSOwDF0K8/tJpyGm
 ZeFkSeoJs2dq/+1ENWB2cPBMw18COFnpyAjrvrcPX2lMNEX5HZSQtzny/+7Vftk3ngn8GY/l5
 vQF05Eb9LOtOMg9WZ6TFBnvvNMGLmerFNKjUgqjOvelGqkINT98zHJd8YMBD/ApGzcyFt5OMB
 bZgvJqIx8j+CWqcZx4tM5bp1Uphbny6WWNlB/qsUmH3bX95v1/FZ/2eS23ESNdK4rR/TMccnu
 VwMN/Z6E53ObIVaBFTTgtteXhXza0tAg4GQwlBKCowMCPEBWSxEDkFDYg==
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 15.06.22 at 20:21, Jarkko Sakkinen wrote:
> On Fri, Jun 10, 2022 at 01:08:42PM +0200, LinoSanfilippo@gmx.de wrote:
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> According to the TPM Interface Specification (TIS) interrupts for
>> "stsValid" and "commandReady" might not be supported.
>>
>> Take this into account and only wait for interrupts which are actually =
in
>> use in wait_for_tpm_stat(). After that process all the remaining status
>> changes by polling the status register.
>>
>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>> ---
>>  drivers/char/tpm/tpm_tis_core.c | 46 ++++++++++++++++++++++++---------
>>  1 file changed, 34 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/char/tpm/tpm_tis_core.c b/drivers/char/tpm/tpm_tis=
_core.c
>> index 2f03fefa1706..028bec44362d 100644
>> --- a/drivers/char/tpm/tpm_tis_core.c
>> +++ b/drivers/char/tpm/tpm_tis_core.c
>> @@ -53,41 +53,63 @@ static int wait_for_tpm_stat(struct tpm_chip *chip,=
 u8 mask,
>>  	long rc;
>>  	u8 status;
>>  	bool canceled =3D false;
>> +	u8 active_irqs =3D 0;
>
> Something like sts_mask would be a better name. Calling it
> 'active_irqs' is a bit confusing.

Ok.

Regards,
Lino
