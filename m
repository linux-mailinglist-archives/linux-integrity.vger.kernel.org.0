Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CED4155B1CB
	for <lists+linux-integrity@lfdr.de>; Sun, 26 Jun 2022 14:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbiFZMSh (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Sun, 26 Jun 2022 08:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbiFZMSe (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Sun, 26 Jun 2022 08:18:34 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDD5DFE6;
        Sun, 26 Jun 2022 05:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1656245898;
        bh=vCtBe7cGkT2lLAIwjEzVUoD7lfda5lBQRKp9ZNCm2Rc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=at3F9hjtf/4bdTFG/BmV4eNqL3URKj9khcFgskvkpvabzAavUmcCqCI5a/mIsK+pL
         bzxNk1nfGCuaCWmtmoaqROi/XH5HLAty6a+TJrjMoLIosJuR4sdxr3s99P2FisOhWU
         BMCsu5vbGTJgR4zLv97blWxnLZnTYhKEW4+iNrc0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.33] ([46.223.2.248]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MWASY-1o8A081Cgc-00Xegt; Sun, 26
 Jun 2022 14:18:18 +0200
Subject: Re: [PATCH v6 5/9] tpm, tpm_tis: Only handle supported interrupts
To:     Jarkko Sakkinen <jarkko@kernel.org>
Cc:     peterhuewe@gmx.de, jgg@ziepe.ca, stefanb@linux.vnet.ibm.com,
        linux@mniewoehner.de, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com
References: <20220621132447.16281-1-LinoSanfilippo@gmx.de>
 <20220621132447.16281-6-LinoSanfilippo@gmx.de> <Yrf/azvJlzWfOE9y@kernel.org>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
Message-ID: <6b950660-6a78-f329-39b4-11d585e4959c@gmx.de>
Date:   Sun, 26 Jun 2022 14:18:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Yrf/azvJlzWfOE9y@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:M740Xfb/qLCEqm++WePlCPkEVPamcZ/7f7h+2btuHpTp37jf1Yn
 fCZk2v0mYQFd9qSAA5EWRAJ8xDILKzu4v1D3Mrzs9i+Vw9qQ5QySEAekH7l4vmfAzUzxZSc
 NDmxQHnpENJMKZp9CCDUFlZNuCp4p/OoBq/ZRZry1rXRYt9Nfm1Fm3bnHiLWycEH5FyOw35
 PND4T4ZAHl6/WC+GiU4Ig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g9VUA2etXbg=:nNVzSHmX7mC8kb4lRE7aZo
 V+batSxWCPyQ2Hzz94XbUP6o/v0MadOON6n2lTkT55YdmJ/YUOFug5uDpKdukFS67p7tZcbRC
 2uUw1JpktDO5LRTzgmoV9YlVYBsgi170kFXs7x+sCrGFLCVQYHvk8diWoShci9IJqtuJo/rPk
 8qd9uqjjpxcO0pN6TfpMBdszlmOxcfdBrPtxagFD1hT0CkkE5Aya9xo3yb/frxUmqTve+73Hr
 fS9m+Bjg71zD/23a2m3h+j93ru3a0xmruW5baIAeJtBc5Po7MJs7yvm/8RniSzJFbBUffVYQT
 kGOXer80Lxq1i8qWqRhwFoJNaklmVDYYbKutxt/paOensHauyI/f8/YRI3aHLKutjVL6gt6Kv
 lOvNvq1ixaNGcmC0QPIEQgrniygk0iK+6ctvDDgEm+O2cTOX8yT/c5O7KZVNhfbm6woTJQBKM
 /gq5MNUHhj2Ue0lmLE0DqSFM6aA3i+MfujKDLnzZmoyexYPbV6WkeocNiRf+24lS1U/77IYAn
 r+vFnG1bqmWHldENjdJpojRIlpaYdoYkRmUqZ6RM+ndZS6fAsRfNC20lV+FHOA9fiPN9nP9su
 GnH1WpANMD94lfkXsYMV8e+ZAdx13pyhHKWQFUkZBUrFjYL/JFV/LgFksqIooWPMUA/4rY9be
 iJRTTrj0DrB/NQbMR3IA6Xy8fNQCkoOqkGYEVUg7K+6PosTH/XLcz/NYxpW7sGqUqO2ZBm/4Z
 R/I8HcD6ZZB/EnAOoStzOFvY4Jv72VUpKS6cKk8CcqepBWx0Ig0fqJTg3MY/kBFCx7MLDJXk0
 8O5Tjdyk+C4y1CNMPEVCCoNT4WGg8mOjC4DbI1OywbyyPzTy6BFsRnm1VUWmyUSj2VHsDRlM4
 DmfIRGMHziCIr4ppfC3cXTWbKJwa2KidMqZbkMHHNLWLqp230C2e30fvMX1CzFo/ZH5XWxUil
 ZtaxcKYZKo7lcDNgCb+IxAnp2qgONB6gjz4onAtGdOM1Av6lSUkmhAp38crNqr52w4uM+qZEc
 ZY03iUpZJg1upyg3H/hQruI1lPRm3h0YpO/BQJ1mzgymcQEbSWvYCxUNLhc47Jw18hsG0ZfaV
 2LlyI253lovekFQ/a6oNp8Zutj9eGJQnCgWV3gC5TB9sTOOaN5SlN1w1Q==
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 26.06.22 at 08:40, Jarkko Sakkinen wrote:
>
> I would instead mask out bits and write a helper function
> taking care of this:
>
> static u8 tpm_tis_filter_sts_mask(u8 int_mask, u8 sts_mask)
> {
>         struct tpm_tis_data *priv =3D dev_get_drvdata(&chip->dev);
>
>         if (!(int_mask & TPM_INTF_STS_VALID_INT))
>                 sts_mask &=3D ~TPM_STS_VALID;
>
>         if (!(int_mask & TPM_INTF_DATA_AVAIL_INT))
>                 sts_mask &=3D ~TPM_STS_DATA_AVAIL;
>
>         if (!(int_mask & TPM_INTF_CMD_READY_INT))
> 		sts_mask &=3D ~TPM_STS_COMMAND_READY;
>
>         return sts_mask;
> }
>
> Less operations and imho somewhat cleaner structure.
>
> Add suggested-by if you want.

I thought of a helper like this before but then decided to
not introduce another function to keep the code changes minimal. But yes,
it is indeed cleaner. I will do the change and resubmit the series.

Thanks for the review!

Regards,
Lino

