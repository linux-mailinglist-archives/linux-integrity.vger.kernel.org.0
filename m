Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E47113775C
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Jan 2020 20:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgAJTkX (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Jan 2020 14:40:23 -0500
Received: from sonic306-8.consmr.mail.bf2.yahoo.com ([74.6.132.47]:34402 "EHLO
        sonic306-8.consmr.mail.bf2.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728683AbgAJTkV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Jan 2020 14:40:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1578685219; bh=TCZwFe3u+eyFVAhwTghiuuIh3Kd9qo/9L7Vp+eBVimA=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=koLrrMaGpCAZGmEf5CSXTbxibXp5+juwfrChXOrMof7hqtTN/dorSFno/kIgTXsyOJNq9iIIx7hLGND3+uAUrm7H9n0TIQcJZ+eIy3TtmwSKsnz7Uzr9cRGLC5vDhZlfg3Iwu5VPnWQFelL3/7aPAAITGoKYIrFrqsUoSW2ec4rbK4D9BO2IBycyahmwToXMbTcqjCfw4X44DbvNhRRWL22Ar2nJiMH7foX0riiWcs/paBDQbK6qYJuULlQZlfcg8ucqRhnrB8DTMD+dEQEtIhY7aDm1J5gb+cAi4ytkltDQvAD1sdFXhyCl7DDd1xHOqY3zRbqgBlX1FKMQYn/YEA==
X-YMail-OSG: YOYwdwUVM1mAkhv0uA0Bs8FCVZKcL3unUIOVrJLdc19rBxw_7kFiJV3KYB0DBb7
 9.o.fwmDY969GNYtRNkB1lejAnyfMpgubJimC1g00LiavX3zYgo_C_KPAGRsp8u5g4xhhc5lzn7J
 DmJeD6Ui4ecxZKaQQnGQtDUrC0jfwscFJXxme4ky8K4iaxxdbWSdeSFxhWAI9MsHyjySN_XohYYk
 GpM58P2guy6byBwp4J3i2hhiaRY0FcmA2UtS9LS54NYuz5RuFNmXtWJCLiAygnKQ5IY6bft0rNIC
 kb4wvZwqYP7NztHtUSIKfgI7kjpcS5h5zvx9Mh8y8.LuEfwrwAoujFHlPsDskE1y4dJu_I6p.vqB
 YF1aG29D.Z.8v0kOkkBZzybGGxdOn3WZXXL335zE.S7fa0msYGHa5cgZ5T39kHpEsJ1Cm9SuplZN
 yf5ctqR9lk5aEb315xZkOZEYJNrnyd1hTAd2KGt2NAkGrQEdreHuL1_B1Vna3pHslSGWDV8t5WXz
 OBXZmIVwXX8o_FFrkCSZOkxNKuCUJoNNKJf4MbVJ0KKsoVlcMBHh5ViqMuemhwg6VoyxqoU4X2cP
 BfdCb5xvCfgpZw6d9by6TH1nIad33t4Vj03j4SZpYPO3jTxI_4y3MQqEyxR8x8HQBeHVZJbQUnEu
 yRLVTYiBYg5P1ZE5qA5QgXkN.C3HP.S8rTTkqI61jM3stkRWNEU7pn_5TvfqRGZxD.3779qJ9dg.
 DVXwAd2o4TbfKmGtfiUeEM7MOHmQF1ZeqIEfZyVdMsHwFJAvuXtw9umGI4N7L0F.BSF3rjbr_wmQ
 fbDFrVFa5VXi9hh7_rEycBowqt2xlpPZ4N0x04VnemN7TrGFCmVjn8fjGkNQkPR7vXp3sv_1sKdA
 bMDHO4XrVAXNKi._dkRLhoV_KesBA.4UxFm9p.543zOHlk9rb8wOHvWQjGm8LUI4tSn0SPuMoraQ
 _Yio2TqmfSTKm0UpmwWhl0RJ431JzFwlcvKR3QPrRpR.kA3U88N97bnH4qPeu_M4vvIxuN7AU1Wr
 op8wxjGHCTkCfYG9mm6dY46ZxnniRNa8Xhb_EKT0ngX07eD6vsFU3zjbTudoG749PuZTOhW4Ad.3
 GwpXGbIo2SYBkiK.HvDoVI90rX9D7hKJxg9qVTFl2lg_K4LbAVvnIlBGgUvmZz7FkAm3HmUzECdd
 p10DPLgeoFV2SJ.plSucteN63jNANXJ0d9Rs7Kd6G_KwfHhgESrmwgBkKqCkodDT0v_8pa2Ot8IH
 pY4.lJrfUcrWFlr4lfUXDEX_m8GfojE8_jyMS7VA.1YYpojgN2KDd8ck9Uj5MBobOX2YdJnN_7L1
 k3D4FB97iYhFfKQB67xvux74vfMdL2Mx50AcxyKkJ038k5bhNK3B0pGxyzlRrNYVzelQvnfAw1IM
 4sGUn38AfqzQ56jRUCuIJxLxU8V6eiszCRtex
Received: from sonic.gate.mail.ne1.yahoo.com by sonic306.consmr.mail.bf2.yahoo.com with HTTP; Fri, 10 Jan 2020 19:40:19 +0000
Received: by smtp410.mail.gq1.yahoo.com (Oath Hermes SMTP Server) with ESMTPA ID 914338581e9972fab9bf8856862b4e8a;
          Fri, 10 Jan 2020 19:40:14 +0000 (UTC)
Subject: Re: [PATCH v13 26/25] Audit: Multiple LSM support in audit rules
To:     Mimi Zohar <zohar@linux.ibm.com>, casey.schaufler@intel.com,
        jmorris@namei.org, linux-security-module@vger.kernel.org,
        selinux@vger.kernel.org
Cc:     keescook@chromium.org, john.johansen@canonical.com,
        penguin-kernel@i-love.sakura.ne.jp, paul@paul-moore.com,
        sds@tycho.nsa.gov,
        "linux-audit@redhat.com" <linux-audit@redhat.com>,
        linux-integrity@vger.kernel.org,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20191224235939.7483-1-casey.ref@schaufler-ca.com>
 <20191224235939.7483-1-casey@schaufler-ca.com>
 <ee5e4cea-b6c1-fa12-30de-8fc9007d69e9@schaufler-ca.com>
 <1578587607.5147.63.camel@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
Openpgp: preference=signencrypt
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <e6945c33-a540-9d0a-ba71-3602b8e38154@schaufler-ca.com>
Date:   Fri, 10 Jan 2020 11:40:13 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
In-Reply-To: <1578587607.5147.63.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Mailer: WebService/1.1.14873 hermes Apache-HttpAsyncClient/4.1.4 (Java/1.8.0_181)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 1/9/2020 8:33 AM, Mimi Zohar wrote:
> Hi Casey,
>
> On Fri, 2020-01-03 at 10:53 -0800, Casey Schaufler wrote:
>> With multiple possible security modules supporting audit rule
>> it is necessary to keep separate data for each module in the
>> audit rules. This affects IMA as well, as it re-uses the audit
>> rule list mechanisms.
> While reviewing this patch, I realized there was a bug in the base IMA
> code.  With Janne's bug fix, that he just posted, I think this patch
> can now be simplified.

How and when do you plan to get Janne's fix in? It's looking like
stacking won't be in for 5.6.

> My main concern is the number of warning messages that will be
> generated.  Any time a new LSM policy is loaded, the labels will be
> re-evaulated whether or not they are applicable to the particular LSM,
> causing unnecessary warnings.

Uhg. 

>
> Mimi
>
