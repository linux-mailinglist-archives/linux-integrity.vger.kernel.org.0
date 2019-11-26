Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E90210A680
	for <lists+linux-integrity@lfdr.de>; Tue, 26 Nov 2019 23:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfKZWZ6 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 26 Nov 2019 17:25:58 -0500
Received: from sonic306-28.consmr.mail.ne1.yahoo.com ([66.163.189.90]:46495
        "EHLO sonic306-28.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726103AbfKZWZ6 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 26 Nov 2019 17:25:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1574807156; bh=FdmVF6GWB7U95ltgK+le1KXSFLmuXOoOQgMr2HfVH3Y=; h=Subject:To:References:Cc:From:Date:In-Reply-To:From:Subject; b=H0Hv8UWt7uja8rHkq2HmBIWOYsvZPh1ge7y/GbYPigxzo1/DcWHGhbmF/Jx+7cRYyaARwPmX3rbVoAFO6QCwu+pttwG3myJ1f0a38+p99JCurFiPC34BbMjho58C6sbGrSnpm+smX4MXMdVpHWptU6UNzuGw4u/obVuEErQfTYZTkkwgX8S7bIFQ/eC7CgXvUyyZHOiMmF4lAXNvn5q/OAUeOjZ7AWT/Sa/uPNEO/dgJ5oNK+OtCy7FnLmZrg8WvZ0yA91BytB7wcGDunTptY2KAa8O8olL0gZ+SQPgrBt0qvwyUneVcNi1Ovt8D6kBMDnQWTeUsdf1ZQkCDUMkf2w==
X-YMail-OSG: YnQ.KqIVM1m4ApvCw75uxjzRsLAbFDfqcva.Py91DJ14bdlJf8EcOHSNl8K7E6A
 xtGMytKJf0AjqmmYSEV6DV0Jeqv8JLoikuJ86iLJKAUPWl5mYjLsCWTvZ04gYJRIXcyTxhbYWOOp
 C3IS1PVcI3wiIjAynWOEdV_fsum4iz5T9agPKLTVUw_dtCAhQ0vvop7GEcmQztnR8VgQCctcGtJc
 oaOTt8eAkOPVpJJux1t10xFk1zTalM5lqvvuIOIB5HXSXbP95ynoNA60j5jNb8DYRKqbW7Qat8QZ
 B5AxaanuVCmM1m74cqepHZ3qpOnWV0MDJCEZGStpwiIiPfi4ZAjGIXWL22Pwpta8JWfV0_p8kv_w
 ciR02SVYaxkNO1Pw2X03H._WDwX8b.aTo6BW5OmbLJ06ztzvmrxKbMUXfBGxJwAuNF.I6KNiTB.g
 X6LkXvRmy8mvJe5kiP.dZFSeSeuDZ5_4u4n98x.9KlLUyUIEgp2qKBc._GVPInP6OXx4F182yjhL
 Kw7.8oaf_T1by5ynRgzCM2YFj0mLhzFAcD3WHd7_.MGX7fjZ9AKRKoFlygQwAvt5wYrlUmqQm5po
 KgmdkX.1MOu8CuBuwtgr4wyPAf1rjitAqd4DpA.SAHyNL78jlkDhKKUfUH1INHFd5Ou4LMx7rLpY
 nrOoS6urqoBTKVmkZ_JEJm.7bz8qM8SliYDYzHNpeV.umeZ8aGnaxfyYxWD33oHWQtc2NJKGLAeX
 MuZ1uSx0uAtG4UpeCE3ic0CmUHh2bN1SR.3v2HpKnjm6v7DP50Urry7vGjXAzXYFVq5LqqwlG7Nv
 EAJM7ZG4KvAASigxFyVxpUxQa7N2aIqgZyUcaVpdybeuM9dgbthY7gYvJdjIz5f7lXSNigwgKSaK
 .7GSnpdYj9kkBKXkMS5DHoB22HxwPBQaauU_r5Sjm3ae_k4uWU46GWiQuXWqz7LTLZFg4wYqYQna
 jVaTHVyaD0ztfSNIXhtwqs6YsQHzXl2v5LSNQ2QJPESeAKjZ_90TNpgRDW4ei49jyFCdSeA0kTFz
 CCQopccEJWREAilV1hZryEyagoZFNpjausf4BadO1teeVg5M1YRI6PdeYtEPWRt54VczrZQGpYSa
 Y5keRVpa562RU0huQWxDhIk9BU5qvSjuuKvOg3fmdJ5JUFtji5FhD.AcSjbow0PaSHmm0eEJzjpV
 YDGb__ekvSHIRCch_PAzzF.yzg2zwY5Eo1nDvPWTfKSmozas00Ce0K22dIt_snHBUsEp7NcYWnnI
 wlu0PHuxBIDqexVYxY4C4oN4wJbuEV3tFo_OXKOVqYf5RGqfeSTMHE5jb5Z0UoaWGRkW9PUi8QHc
 9GCNXOdOTK_rPVGczLGBaG3TYuJxF4ZdMwl_GZtB1zzfREV8bgXEwMp7nT8iRnIeexO_ETPoAiGb
 0PslYuPVGluVklnM_5ouNlxUy5KR2n.Q2YgoO5Nx.bav_U0hsCbLTAg.fkt9aEm15nbL8iDQS9VB
 k
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.ne1.yahoo.com with HTTP; Tue, 26 Nov 2019 22:25:56 +0000
Received: by smtp405.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID dd3aa43f4f1fd35225a25b7859a412fc;
          Tue, 26 Nov 2019 22:25:52 +0000 (UTC)
Subject: Re: [PATCH v10 00/25] LSM: Module stacking for AppArmor
To:     Mimi Zohar <zohar@linux.ibm.com>, linux-integrity@vger.kernel.org
References: <20191024205228.6922-1-casey@schaufler-ca.com>
 <1a7e9e00-afb5-9164-912c-84f2cde7a2e1@schaufler-ca.com>
 <1574806558.4793.265.camel@linux.ibm.com>
Cc:     Casey Schaufler <casey@schaufler-ca.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <1705dfb3-2a81-1bcf-18c1-0afd60a6c896@schaufler-ca.com>
Date:   Tue, 26 Nov 2019 14:25:52 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1574806558.4793.265.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.14728 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/26/2019 2:15 PM, Mimi Zohar wrote:
> Hi Casey,
>
> On Mon, 2019-11-25 at 12:42 -0800, Casey Schaufler wrote:
>> Has anyone from the integrity development team been watching
>> the stack patch effort? There are changes that could be of
>> concern.
> Thanks for the heads up!  Sorry for the delay in reviewing the
> patches.
>
> FYI, the IMA changes for Linux 5.5 are being upstreamed via the
> PowerPC subsystem.  With these changes, patches 9/25 and 12/25 do not
> apply cleanly.  Michael has an IMA topic branch which can be "merged",
> until -rc1 is released.[1]

I'll have a look to see how tough the merge might be.
Thanks!

>
> Mimi
>
> [1] topic/ima branch https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/ 
>
