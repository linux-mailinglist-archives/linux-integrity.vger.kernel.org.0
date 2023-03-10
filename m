Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 165296B522F
	for <lists+linux-integrity@lfdr.de>; Fri, 10 Mar 2023 21:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbjCJUuY (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 10 Mar 2023 15:50:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjCJUuX (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 10 Mar 2023 15:50:23 -0500
Received: from sonic314-27.consmr.mail.ne1.yahoo.com (sonic314-27.consmr.mail.ne1.yahoo.com [66.163.189.153])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48778568B
        for <linux-integrity@vger.kernel.org>; Fri, 10 Mar 2023 12:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678481400; bh=KdM6F2zSCxYq550y3/x8Lg3b4muVh7ZZO4D5IzcZ3Es=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=ckggdJGsi+D6p3VumnhYp7J6yc0lvrI++QVQtGZuxC/RgitMnt5pJwFAtdbrCo91dflnc807qLyrB8OAXWTAjoPXklAb+OmIWi05y789GIqUoOQE7wFF9Kw5tG3ol42p/a7ROTxbotfga5H+zjrNdJVkRsg51BTR2rm9wqbx5DXGkGCawe4t2aPF6/r6C+KHr9py/07Gxg6cRz6XwCmSdk/NzZgEUu6OJt+xwQBfYwhuel9ETyiOvr49qkrZuRCprBDrEzkpXNN7+kfK+MUs4y9MSHdkIGkvh8X4NC6RpSEHHWBUks+4bez6sMs+StXPAzwqfvI2syhh+8vksnIdGg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678481400; bh=UlQOGfrSNXky7sYU/8vxZH4eYFo0q8Lq2B6GuuIaAoE=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=jxWQx9h9C4UbVrVEuimFTg2WbOYmF8eBGINZqQuLZVACNu0r9zL5dXqan458KbMVHaE3QHzf8WJBlyXSEeW2rd/HrbguN+oHY9gozlZ9ZtT8hy2N6r1XP32pXMZ+293p2WwT30H3TQEtX0DeLn3te+twVoSBbVN7z/o8iwZUK9KZuWMXDqYwFn/2gq/EUyNwkMGEJVUQda4LopMZV1SZUGTrquWfY3L2Ct1ExDXiILa/lLnAZJMsx4djtR9iilIY1KyqGoy0OldcDMfihVW+3HnKC+TXxrFRJOdgGarYZnTeRsNy3pAyF8wvCDc4vIV6TOETKiJYVH9BUjkdPC9buQ==
X-YMail-OSG: 05BQRp4VM1ma6dHjYYKYYhbeOJtbV1Q8g4GgaQyh0ssvVJZCimtCGjCWsRkodOI
 9XYcghxOsAGw9MSbFbL5U9wrQ7o4u9yBvtoQKXvj4r7e6Jl5NcMESpNa8spvhc8AU0LtQsVJBS53
 90RGJP74QwxrewYQHJ.4VD7xqssZM_EG3tw1SR85XSqWYJCX3hOVj2Bqq3gqPiAAmFaq9wFdA.3S
 Q18ZfHqtSg7k2CP9zn0Tn5FTi75Ogh.0bN4vq4hBgwfwPxEAhlz46yJKNFUbmz.pqLZ5lOarlU3Z
 NU8w4sOZ.iQbwKpYh7Wof6HN3BV0PTfCKCpIUtPwy8bFAdJ0dJkMgSW6tkv2FCxkR661C5UszU3m
 5KMJ0cmztt.fVy5XUMcFXrQvcINp3ndG6d7xv_bXHeFL4K.jwBUZTjqDXMGUagmr4W5X8dDLOds1
 j8k5gr_RSmLT9CFPcsEFDuO8CL_jP62ODoHDSTWmrAC5BfnjLhjFCU0XRh2tvk59SJ_JpVQrjH2D
 EPHi36esK1DKd49fu1uZsagRKe4zvMuzpIAubZICgdbgoctDamLwKIsXrhTuhEAXbvex5CQQLOjX
 t7HROjbr9uFnU2Gj7cei4.Ytk_tzZPqDzmwUSNtjnUUFZfcM7O35TQnyWnKennI.wNVLFZHtAVL5
 XQG2GuYMWrIOFevOdrsQX9llqxxkT1uNDi4st_xZlq_CjJhJygdOPec.Igc09pHfeS78AIsmfB_L
 m8.tYvebJIqiQATqYvzk73pRtXTXhpWCe3.UYuHA.qekaZYHrunjuS_jeVCgQoAentmnlf08zTJC
 m5ScpdK0Dh_5xHLW9Uq2TYpfAnU7stIJPXzPS3icuvIiBFgNgtCiExVppEdnFA5OLqFd0caVKnuW
 7o7ZfphQlsmO1Vomm8zY0FvGKNIcyryexFctwGolBG4F0G8wfW3LOLUnB1HzF2ApZNCIRSDpViZg
 TbTTsVozQORwW5SmQGkOcMci0IBMCF8Plaicv7mQlPWe_M9jVjyMzVMIkcIMHG.8GHs24k9qeNzi
 ypXFyDM_gNjpVzob8pQ4JxsjbxEX4PNcTRhyGWWscadCIrvnDgcuCEXNL_Qr4yMue0mpTYT2eq4O
 8h7Qj7pMuZJfQOl81H7dywrudDNxWmf.u9Eb74_SyvuiRY.r_5GEKa8yDZGJTN9Wa7nZn.k94rzn
 YyYq9lSxQuZoSpwEvznu4VCUqUvmoKP.5Ga1lahPK.27J8w7DUoFt8GoyDcM3AZ92vCfNkEx_3Zs
 UOezSmMS__IiK3yL9EYBhrAhN_mJbtmLyjBwJda108Zvje7_E9qSqPzea7Y.z9OGqOtwWSt5Rkza
 0QbXoLNDeIrjl9AdFCMyyrf0n40aQcM2DQBFbnuEMz2R0AbKbYn_o6msgBOVbOOSlIm2tAfVCqGo
 AB3qAv4HoPednZJQGfpb84sC.SFAS6wWdV0IVZ0ePIvzo4.eyFMo3PgMuNqR1Yj2Vhtmvt5EsJ77
 .XWxqiRu82i6c9sXjBZdi7IS69kFdwNsbz5ahUNd5KjAugy1_zoMMtEnyLV67NmlsTZpXSQ62zRN
 yY.ZaQq.w0dFkturFqm3UkbwXUR8XquRgUfo4.YTwPRpYiHomyvuIEKiH2tVgJjb4swgh0EBTbyV
 5k6GnbmGX2pQTGjp8mOntumbaPfiyE3kTELQINboi_e6z_dXuhiYu3ubHyUqwPyhZHBNTGZBV.MV
 Bs3pdu5krKTb8o_pbqwAyQVxkgGV9NkZ4gZJrdRIZjVUrWtvxylv.a2WvlalZKk6e3YGz1I0w6rn
 hvfAAQ1uz8D6PfLgR5TrvzOk5ZXjsXjn36bhJrMXQg4O.svCVrXmAwmlg7XmRZqNdtQxh23OTaiX
 GhXM1NlxLI_.AHDOatIZCS8cJCN74FVkDvYPdH2p5aAVFdEf6fqg3wFSqcf7B2oV_Bvog5syfSZn
 lGjVactHlLnh6g4evRkCe_7aXIYFf0hqxvrY2rs2vGpj0C.1ClnJp_HeumSxjgwG_KTq5U9bdSku
 iR12qgChpC0W.aXfoKn9IhHjnX5w976dJxxiRK_VLgJhW2PL_4p7Be8tLjBQNFuABd25uCvu11rk
 JXC0gLEkpfjhlT7YVioGExO9O6r8HWaiKJT_zrQGmWv3HHZqpx3aOIcMvjTr2VlrqMDb.At1yhYv
 ionTvxFH4E618o2CP10zcFa8xUugz1tvTC_VZwjqg01JqodWBebZdpvb41Cv6.WXS2QNVhdAqLsE
 j1MvSwWAHGJ1h3uWZuH5a_tN8lq2kopO0p0ycTZO0XpBX5ovgPF2OSTzqES5B.N4rYi_qnjKOGq1
 zDFCYFeLNAug-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic314.consmr.mail.ne1.yahoo.com with HTTP; Fri, 10 Mar 2023 20:50:00 +0000
Received: by hermes--production-ne1-759c9b8c64-f7wvp (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4519a212add4ad7f27e5b83a7a787923;
          Fri, 10 Mar 2023 20:49:58 +0000 (UTC)
Message-ID: <e6a975ce-3880-1429-f013-40604e361c8f@schaufler-ca.com>
Date:   Fri, 10 Mar 2023 12:49:57 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v1 0/2] Add destructor hook to LSM modules
Content-Language: en-US
To:     Mirsad Goran Todorovac <mirsad.goran.todorovac@alu.hr>,
        linux-kernel@vger.kernel.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Christian_G=c3=b6ttsche?= <cgzones@googlemail.com>,
        =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>,
        Frederick Lawler <fred@cloudflare.com>, casey@schaufler-ca.com
References: <20230310192614.GA528@domac.alu.hr>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <20230310192614.GA528@domac.alu.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.21284 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 3/10/2023 11:26 AM, Mirsad Goran Todorovac wrote:
> LSM security/integrity/iint.c had the case of kmem_cache_create() w/o a proper
> kmem_cache_destroy() destructor.

LSMs should be using the security blobs associated with system objects
rather than doing their own memory management.

>
> Introducing the release() hook would enable LSMs to release allocated resources
> on exit, and in proper order, rather than dying all together with kernel shutdown
> in an undefined order.
>
> Thanks,
> 	Mirsad
>
> ---
>  include/linux/lsm_hooks.h | 1 +
>  security/integrity/iint.c | 7 +++++++
>  2 files changed, 8 insertions(+)
>
> --
> Mirsad Goran Todorovac
> Sistem inženjer
> Grafički fakultet | Akademija likovnih umjetnosti
> Sveučilište u Zagrebu
>  
> System engineer
> Faculty of Graphic Arts | Academy of Fine Arts
> University of Zagreb, Republic of Croatia
> The European Union
