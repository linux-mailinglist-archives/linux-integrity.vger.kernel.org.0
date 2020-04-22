Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1C61B4AFC
	for <lists+linux-integrity@lfdr.de>; Wed, 22 Apr 2020 18:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgDVQzW (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Wed, 22 Apr 2020 12:55:22 -0400
Received: from sonic317-38.consmr.mail.ne1.yahoo.com ([66.163.184.49]:36967
        "EHLO sonic317-38.consmr.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726691AbgDVQzV (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Wed, 22 Apr 2020 12:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1587574520; bh=XS6//uIVuASeWe3YZNdt1e91gFk4ywo06uxLJ0JUstU=; h=Subject:To:Cc:References:From:Date:In-Reply-To:From:Subject; b=LZDLDriQ6JddRMyQPcFjgtmhD+brEfVIfinqiwzbaPcvPWYbmdiCqUpreplnY40i3unFpY55gXRNexSSKKawqER+NeLod2+58E8FnAI8u5ZlLzmMcH0E/4jYk0mZV2rdABewsaM2sHc6/00iNrNTQjfgKb6obqZW8cdi4cSHhtO9+CpE01CdFEye+wcaWYDD1cg/4iIr2GUVnGRWTPcPmhle3FLMw4+6j+f5kKzfJGesdy20/fkfFWEWcePNY8VFW+SeEVqHUzglASQJaTrhdtWT61qPcqCHGZQx+6um2IX7fZgUGghlxZMfTZhFA+VL6ZNNdIPXygekNZongm7J9A==
X-YMail-OSG: EGlbyDMVM1krSWiLV84qYvNn2PhvDqfaAN.XwHP.6TfWi9.xEwug5NW5ECeAXnh
 NQF2JxNWiva6UblENM70pJ7i5xAhzvRaGEtXYJu5PEdj5IcjLUVsLmuNNb2WIM7T6oIjZeDdv.R.
 1vGZMgDVre3al0xO.wZpprnO5MSWBlEYke5R0ABTZmmnSxc89G.NA9H3gAa9PzYLBTisKtnIw51w
 go3ootV5EnOdlgvrIXa6fYyRKhfEoAUPeVPTnLiwg.cF0OvuOFeHfcTQkdthKu.5HKjfik0seAh8
 2yp3ii4Kl.1lbxRkReLGTnlkLuHU3WXnsiC.05i5WScgwufCO5pKvYClLPT4zE1Om3DknCrydcHy
 ._8bfQQ1ItgIfU03gXt8wGAioaV.peN.vRMEk6epdntPTvGN5uWarVgprGR4ReRztfeSgZn_gwds
 h8TdJ8NveKvPKSQ99KLUeACrJI7NpbbNG3sAhcbhBk9fbhrhZVRa744pfyB.6ZQAAuTv8WE609Wi
 TrguyNa4Q1AUlSykI1Ph4rL18vqjBoRp8T2OpjmeKOfwrPfu2UwBcaqveWXZY8sr1uxc1tfpp_xX
 wMbHt9EwKVw8RMExQX23EqNYJ61ZoHQV5e_GyLKiCyckZcu2ESNeajDT4pz3F8wQyomzFzoBhOXk
 mamBs_BVYlliquyjXt89eaY2lBcXiYCE58f30JHeZJG1yudG_UzD.Doz6Z6ZHG6bZV5Vfa_BVoCp
 J5V3Oa2S27WNAqjR7c7ZdBYvs8VzfupRNwU2BZ_itUj57H5CLgGx9onqQKBOqXaHDYaPLgfHA32U
 lzRMdEZG5GvvZk5QJQmSZwBrFgv5iL4_4ECNnYavITeb_ERbeiAnytm.01I2Aw2H4FMDPBcTvZoe
 wA8TP0coxMdBgbb5LZxId.RnaJyZ_jMVqPJOiOOx0UkGRaSmNeC7kiNgmvKom5Ob5CYwypb8m4i6
 W8NZO6d51aToA6m1IAe8ERflsN06ArlGJzxMT1OBnlsOHI54VuDpFz4DF29kDzsUrVFzSPiUHUD5
 LeNA3kDZV5SttZ81lLKzMrMB5Lf9Le2df.O.TN36PWUwH2.VSIpJU_M0ko98Ppvq0fXbxLgU33R0
 nnoUb.HQJBiAkerQWcDYw6xxE2CxTq9Vnyk5qaIrtbhwCd1Ol2mRG8zmvjr0WoQKnc8OjHmjA2lp
 28IZX7hy1zcCz0XfXr0Kx1kJ02WEQYlyF85BmeKCZlRW4eBqGGWqECYcm6BlW6DNqP6lhRvkzf4S
 oyZcNlMY.hOj3cqarcqXuAGa5NaeqStyw9pQz1Gq5tvbkUqs87WznAYIxf6QTEA2IYhhduH2wKnq
 Qyg6hLcuH_DIG092mY9c9fSTIgiDO3r13xHmEug3rdegH6PlCz2UXgpx8CQ_GuOaSz0VXWiyjnYF
 87U4woQgvI4YtgKzSLEEBg._tlVHyJpvtMzY1FuCu5q69wlFGmjCtEnaV8RestXnqqw--
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.ne1.yahoo.com with HTTP; Wed, 22 Apr 2020 16:55:20 +0000
Received: by smtp429.mail.gq1.yahoo.com (VZM Hermes SMTP Server) with ESMTPA ID 8277937103418b12203f17b293a6facc;
          Wed, 22 Apr 2020 16:55:16 +0000 (UTC)
Subject: Re: [RFC PATCH v3 05/12] fs: add security blob and hooks for
 block_device
To:     James Morris <jmorris@namei.org>, deven.desai@linux.microsoft.com
Cc:     agk@redhat.com, axboe@kernel.dk, snitzer@redhat.com,
        "Serge E. Hallyn" <serge@hallyn.com>, zohar@linux.ibm.com,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, dm-devel@redhat.com,
        linux-block@vger.kernel.org, jannh@google.com,
        tyhicks@linux.microsoft.com, pasha.tatashin@soleen.com,
        sashal@kernel.org, jaskarankhurana@linux.microsoft.com,
        nramas@linux.microsoft.com, mdsakib@linux.microsoft.com,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Chad Sellers <csellers@tresys.com>,
        John Johansen <john.johansen@canonical.com>,
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200415162550.2324-1-deven.desai@linux.microsoft.com>
 <20200415162550.2324-6-deven.desai@linux.microsoft.com>
 <alpine.LRH.2.21.2004230234420.12318@namei.org>
From:   Casey Schaufler <casey@schaufler-ca.com>
Autocrypt: addr=casey@schaufler-ca.com; keydata=
 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
 abzjfg==
Message-ID: <ff87e1ff-b9bf-5879-0154-c72990ce608b@schaufler-ca.com>
Date:   Wed, 22 Apr 2020 09:55:15 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.LRH.2.21.2004230234420.12318@namei.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Mailer: WebService/1.1.15739 hermes Apache-HttpAsyncClient/4.1.4 (Java/11.0.6)
Sender: linux-integrity-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 4/22/2020 9:42 AM, James Morris wrote:
> On Wed, 15 Apr 2020, deven.desai@linux.microsoft.com wrote:
>
>> From: Deven Bowers <deven.desai@linux.microsoft.com>
>>
>> Add a security blob and associated allocation, deallocation and set hooks
>> for a block_device structure.
>>
>> Signed-off-by: Deven Bowers <deven.desai@linux.microsoft.com>
> Is there any feedback from block or LSM folk on the addition of a security 
> blob for block_device here?

The addition of a blob looks to have been done correctly.
As for it's use, I haven't had the chance to review the patches that
use it. I didn't see a patch that implements the hooks in a LSM,
but that could just be me. 

>
> IPE uses this is to track the status of integrity verification of e.g. 
> DM-Verity devices, per this code from a subsequent patch:
>
>
> +       ret = security_bdev_setsecurity(dm_table_get_md(v->ti->table)->bdev,
> +                                       DM_VERITY_SIGNATURE_SEC_NAME,
> +                                       v->sig->sig, v->sig->sig_size);
>
>
