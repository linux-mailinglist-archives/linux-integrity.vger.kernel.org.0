Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95A5D62FBAA
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Nov 2022 18:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242207AbiKRRbc (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Nov 2022 12:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241962AbiKRRbY (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Nov 2022 12:31:24 -0500
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363E68B13D
        for <linux-integrity@vger.kernel.org>; Fri, 18 Nov 2022 09:31:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1668792682; bh=joM9FjX9yY0Ffp0i0RocKngYvfq9IvvZ9DctAz2LvYY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=THyTTjjv1pap6ffUP+riZ1qy5rjk1Va7eCfmhW+2JZg8j4zgJDqFW/3sRqrX8HbfenwyMZ1d2k/ayr9zV8HskNnCR/2idHnno7Nl1fz6qjZP7MpwBBgWGs1GAwqOTdWl/Cx4LSyag+H6L44sml3iQzkgyS0zydACGFEP9dpSSB0TlGoh6GdSNxNwatLqQ16P50H+3p2qdIpLu2pMuZLcM6lwnqPobBr51FpHV5YSeK2CARpkGtzs8djmkb9JWNzQrRApc+c1ghi8sJEEN6TRqRfikCFK9rQAL8SmIeUZ5kiZ03BOW1J35r/9OCHyleArB4F2F/xw3q+KtB3Hw4hbNA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1668792682; bh=grKUV/PgsX9HfUEG+2QjWbqECZxacrViPcAVKUJNnJb=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=MkFHxOox9Qvluwuteq1abp79XYkIaO8gfw1GA3yAXp1WDVgYF+S172oVuuVF7wrGlORufR3nJDvyG5tOsdz/rdvpf++Ghgq9mBF4kuyKBIMHRDu9zR+i2yB0OpRrk+c8qoWyqrfqD+OlZZu68IhnS7UEvda9uaCB+fpBxnZbA5G8HLtcDaMeFK/x1VAWsDJFe3o8j1NAsODT5C2+L2+CyCaLi78uV2tBR9/cUG1S7uqB9AmR0PQKX5Ru2O/+ToimfOJDFq863vd7LnHVMMwx1P9e8MDc32kaLigVa63mGO1GStNvWRiCNszToKuw4kyuRMM/+XVuZC98p42QYhrVLQ==
X-YMail-OSG: ujy22XEVM1kj5fkMsoI7MgmDAj3_xmtDSjGXHNrPgKteEMXDdIvWp_mCVutbTfQ
 Mn4lfsW_T7QTacyp_mYcbyFml.x8gsPGncB4tgsqCcFEuFacwgcwrF08ySdZzKkedAjxbEhbMRG7
 yuDsUKUORVfNWLfo3VokIhQLS00zYlu9Cn9tdmL.FKGRPILuEkZjap3NY.X.60DJySVYPFglIed5
 JF3H_sU21o11W1sVfQk8Jqc01k8R65pqdt.yygYNcNQKy33zRe12aw1cO1XVaswZ_3ICYS.fHiDS
 F.bGVYgTAK_KlyPrGg.mA4cX6XLMhm7P2.0sUsAo0v7kvavAqkfU079rYveFiRu.aSKhVYZa0Url
 Ov74LA1U_w8jrq4KYmVwLyWfO_3ENJFuhAm7Z6PMwwuKMc4WFO0xNSXAT.ydgMxE.3ZO7ztYqUKW
 LMyk7ofacY9O0vNh0KpBbKec3zi2rr0FXFcHR9shnq6AYI0.TOc6DFeYKV40qtHsMgKNQbZb1O_K
 6KJM87DsAV6AcN5D2v3zZxI23RCNhQFyI0hpxKhXQRdnUbIPvmaH1zVuob6OgGqUPBc28IDst0JT
 qXmSctXu0adbAdap_7JoV561CwiaYza_vYKVhMk6JpOcwWcAnMJCJtTr5TERNjV3pLG_4MV7IZFk
 e5TsQuEzddMk1lpY7JVfDlWssh.iU2Rty9vGnueUFDT7pIywcOvUKlh0o2LJfk0Wkwjh1m5S7qWd
 zA36M7JAaQCC5dVK7uDw4VDH8gfrM48_73jIOnwEo29rqiIIbmWkz7kEuYvelbYSI4tPim6VPKCg
 FUckF0jQIi5ZBhEtrmclto2OPp66KmPlo7ePmu4IziqIDnvONaD0kL95_XYe4_vbktHuG862lRVC
 Dy2Sxwi.XtaSdbuaLmn1MaYTf1LSjVj3dIByyFEJ0of37kgA3zJB2EsUwrAmQQO1D8vU64trser5
 pj2H3.PQuwIxAWv5Zj.o4Fgf6_ai4cOzYtEa517PRu78gzsmv8WEJpxYg60VOCLCBrQWfK0tD_ve
 c3GtLYeSdRvGgCdcYVuoBxjGtNncbI0P5WbG2gorQBR1TK5uWRy0AeSQ0oEQ1USRV0SphEz56IJO
 0kWwOlvb0QLN8GqhUlNx._C_YvQsM4mbzGGEaMRc.ZUZI8pMgS0OaWOjxV7o99RuY0AZFPO.Dvxb
 JuHhurN8U0ngNGLFjhzk0VujGpcl6uoGJRzQnL336o9V5YaoK8RbhavACSBOLglX.Y10XK79Gjmk
 26p62Pocj5HtnJI9kKmp2LfGjyMVEC.nvWWl1dzWJfsLguNMaGF1G.xs1rP.ODFdTiTnVFLx_wM2
 wonDfoKSiqpGXU5VZCc0jl22yAe6tcv7a9Q0hRMjHVc6KGDKe_riVlQOWaXe5mdAKN7beX6mtQfE
 iZJuWE8LvGy8LlOufTgbyNfK9jiiiiEZFcBz4Oh1L18dCDXLwXSdzFqtM2fCtGFaaTQ9Z4i3HHI4
 oXGJOInmSP8QdseuS.OQT5gHO9fWjo_knfwXQUq8zCxxvcmfegEgzOvBjrlQlFnvi5On89rk2qrJ
 JogA59e.55OSOoApY1kAA0G.S3.17Qtx.y484UDaQrhOqj2aSYrnGHwW1UQLUspvFgZjHfqwaTmw
 I05higu4xLDXoQgQN51MmANpNO335zIB3pXo60Dx2lOQxFWth5FeFLaIe1Egs4Aon06GFKDnBZyK
 Eiy7EWA85gx6heotxM9ihGlKXc44mA53C_gXMXikl8aj_Lv7j6tAUHoG1Y0rGdSO1eSxGrpWWt8c
 7SwoyqAcjamVwyNeYMhu9WrJ_rhQ9ORY0roe5feNtAFzIGhKzsTxKyatA8DFPtyyeYDcrOCNF3aG
 aXFOogzsuDfmQRfpkRqHEGkA1uk7Ggn29OAiN6CB_FVhRkCgMvq3QIxxAZ_OFWJwVMHKhG6SzUQr
 3.EPqS8Pp.gWZy1ji4JEcLh8wO4AvOsEPlc9bl68Ub0chMWZgXHVrsXH8ErXzTxVGBENX5qK81B7
 V4hUan0cjvZjuaQEX8R1s5HL0KK_Lc7vcbPMpLCE6Aw2t.hFtQKKKfeCONsB.AirY7x1DEklKE22
 q2y8PSa0v.Ze0Iqey4JPIYq32tFpRELMEpLHo0L4Z2GDA4wA2HFzTgh7DRq3hNFVTc44VTczis7W
 ljLLksidGozkHFSFRqMwHC3pC1Cs8gKqZK4IPTjjZZEbP.WSvYFuksTtjPZLgPqgQYQBCK8nEQb.
 Azo1dwC3rLLSR86b.SOIH1oceTEvjPrm5NqLFpypO5b3Vawccrpu8oes2MTXfTIAUgVt3SUxLIqa
 GbmcSvYYAnHRvrntc
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Fri, 18 Nov 2022 17:31:22 +0000
Received: by hermes--production-bf1-5878955b5f-gz9tn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID dcd9318dc1733a2cfe89c5975364176f;
          Fri, 18 Nov 2022 17:31:21 +0000 (UTC)
Message-ID: <fb3f423a-a56e-b6ed-d1e7-476605d607f8@schaufler-ca.com>
Date:   Fri, 18 Nov 2022 09:31:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 3/5] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        reiserfs-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        keescook@chromium.org, nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        casey@schaufler-ca.com
References: <20221110094639.3086409-1-roberto.sassu@huaweicloud.com>
 <20221110094639.3086409-4-roberto.sassu@huaweicloud.com>
 <4c1349f670dc3c23214a5a5036e43ddaa0a7bc89.camel@linux.ibm.com>
 <fe16a03a-102e-b3e1-cc3f-5bad3c28fad7@huaweicloud.com>
 <3ffb9bb4ab203b5e0459c3892ded4ae0cd80458b.camel@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <3ffb9bb4ab203b5e0459c3892ded4ae0cd80458b.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20863 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/18/2022 7:10 AM, Mimi Zohar wrote:
> On Fri, 2022-11-18 at 10:14 +0100, Roberto Sassu wrote:
>>>> +static int security_check_compact_xattrs(struct xattr *xattrs,
>>>> +                                     int num_xattrs, int *checked_xattrs)
>>> Perhaps the variable naming is off, making it difficult to read.   So
>>> although this is a static function, which normally doesn't require a
>>> comment, it's definitely needs one.
>> Ok, will improve it.
>>
>>>> +{
>>>> +    int i;
>>>> +
>>>> +    for (i = *checked_xattrs; i < num_xattrs; i++) {
>>> If the number of "checked" xattrs was kept up to date, removing the
>>> empty xattr gaps wouldn't require a loop.  Is the purpose of this loop
>>> to support multiple per LSM xattrs?
>> An LSM might reserve one or more xattrs, but not set it/them (for 
>> example because it is not initialized). In this case, removing the gaps 
>> is needed for all subsequent LSMs.
> Including this sort of info in the function description or as a comment
> in the code would definitely simplify review.
>
> security_check_compact_xattrs() is called in the loop after getting
> each LSM's xattr(s).  Only the current LSMs xattrs need to be
> compressed, yet the loop goes to the maximum number of xattrs each
> time. Just wondering if there is a way of improving it.

At security module registration each module could identify how
many xattrs it uses. That number could be used to limit the range
of the loop. I have to do similar things for the forthcoming LSM
syscalls and module stacking beyond that.


>
