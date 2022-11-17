Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C715C62E350
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Nov 2022 18:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239954AbiKQRkb (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Nov 2022 12:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240134AbiKQRk3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Nov 2022 12:40:29 -0500
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17CDBCE0A
        for <linux-integrity@vger.kernel.org>; Thu, 17 Nov 2022 09:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1668706827; bh=7cG/UmMwskn0mw9PJK5+8p2gHf8hbmYHaFbog4AuhNA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=EPGKOTejZH2ylVXwWfu/edGEGodMdSXDsRHuQQO6iRuwcUwsKXlceX0cjtNOV9wkg2a/yP3cRP/yjdCEwmH09aOii4sU5a8zbvOxE6QtxvbJX5FZyXXDb6hyKroKNcOToli7VtEAc3HtjLJnCCdyNMNT93jrhjAk/M+LpOdtpHhdC7JgWWXhpmTTgMGKRzLCXZT1Xx/XkjefkzteeZN0kZbx2j+ka0mTFLGSrNip4in6oOgiAbioIDkIiZEetfd9pxPsPbXVigQ+dnYE59gXlLYN4slz9AlsgIAFH6JXidltpYDI2G7P7quR7cBvXDQYHhL8HeLhAMaw+Pt1fodDFA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1668706827; bh=557SfNlI9MJG9qfXXJg5hdAvGHIQBNj9aDMLX0JF2MA=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=PeGRM0iBa+1BH8qouZVVvVJZKtaAQaNh2rHeKWuBKlH5wPOuEaJCxD15zEGWIA8MHge0SqwX8FwpEyQd+yiVJwX/KOMaFHv1hpCXgexbbzdMN/5R+OWCA9ANMjZ2sOSpRFWQUIZWEd5luCnGfmqvntq+g0kqvp4xR/FjilWwcspJgvFvNIcw8Xy8sk8MXkGnIBmZHYeUJi5DiW8X0kPr1SL9HztrTX3ElQJmUqFEpsy2J5bGALRGqDXL6nv3P9upjoRLeUs6C70hYASvVeDR04UdavqhTdJ594qb40OYPdOt8Ux+KDRsKg557bkeKYzahjFtUPcHr7Swb2WYQxZ9ig==
X-YMail-OSG: 7gxi79MVM1lw09vrzO_8HGGVFYWCuyixybop5B9B_4QLnHga4X9sGyC.UyEzCie
 kRN0vQDu5gvXjVT9dlhmxDF1z.qzSUGUhHK7y_Kv8OeQKrbMqRjw2INOQydcjs563sOnlbsNZtYR
 0R7v1Wwr6KIo3u3UYXEFH69EU.fwFliWGxpfy.TETuDMDkQhcNPgltFyiUZk6Cl0Ltxs00T3A3PE
 n1qtuFKRnTxP9Dk_krmIYivS6QgC.b_hRn6B_Ky0v2gr1q3ZDqcpTxJIucV_cFRenVSA0sXum.Ek
 vyP_v3HCnGBMLYGu1aL0IJtHodS1IVLImwaxWK7mJtXA6FVxVLPpa2q1VA1N24J.n_vh_7oL0D0m
 0l0.3.29SVOZ.mE6r8L_bTvRtIbZpY5sKhhvSNpySb0zd8TqP.Mg9Eoro_A14svRvPbSXz1WtkeR
 8Wl6dq11LjmEU0hNX1FTzysW9N1U4fWJAjSgNYGNx4aM_KtoS_PZmDZ6KViV3zpgtXy3jh89.tyF
 YySeItWLvKAPLSWrx2Q1BdJnwIBN0dUerNeDXZqFVtVhlo6PAd1YjfFRDa.1PQJOkohCxQcq13fN
 Yd5ewXUIGCzNGhV9aH3QHBw_auWrsc5305qTtpDlB074FSDN0MWrwk5eqarrYO1DyrJx18jUMyOE
 Rs6434R5JjiIEy2XKuD_I9bL9ur_uPG.GR8orhXn.QEzPvhSJxg9Kj1GU12IYcIkHr2PAcx5vHAm
 jG_zuQyZUN_m7u9yx4MxYqWeNSj2JH8Z4L4mHGalFgEhQxcBXPvy.AZqJYrCFnamUYptTQiBcuWb
 3B4dxk5ZIfkhKtOoFDQzAUyJBAIG2FLgqCocGtSze57HYhAxluZxG.N2FCXkH7iCTcGCgNQsXErM
 k9L6oFRYL6wTInFiJvmjEliW.vKoHJk5bqNRmCFQAoiFbqRkJxdcvG2uJUigmgSgVX5qGw2Tt5Ws
 hCkmD66sCzBkQbq682qy6hZCJ7Y23GjzE0tAJZJcP2jQnMpsheiOJiFHUFuzxCkIOiMTua7bDrQ1
 Fl9ftQqCM6_BtUU5RSSAOaxjtRATui95jDmeKAW8XR56KU2xgbgw89tgdFYWfVgYmwCuP2ulwDSx
 0gNemsfTeDv1MvJPDFvh92o9MZHVMLW4SeWPHCiEEYQM3EprXdUGGxRC1VacPkcILJ5Ud7yBkLtD
 v2UB9Yc9cnfM6RcTyN9_6b6BwTmP33mQ4BaEafNMOLN1BXbrEVYNHvE7IOA9RtXKP_JLjewROnyr
 NWlpEcPTt_QHBVI7qqe.8.fhkyFNzhadtoRvSNDo7KVyTrzRdcPqfgKYSe_kScUyRBeATqoAU16V
 PLA8K3fiPtfU7rWDSMMVf_xSBOFKnKkNyP9.2EGLKAxo8nSMk_lg_YX8gwn8.BvGok7zC3CuIwxL
 .sv6mWx37U6H9WWeOmwVv9ec5pjnLlEukXM7YxD0o2bJ2PhN2RyeW6u6rzEtmyhrU7HaFhLKi9mn
 yzQO.BbIVA1NhFaKrGN4QMR3_4p3gTIKNRPWA7.Mk1hStDePimpXoV_OduYNwGR2IQaVMUQwi_hr
 g3dcTf1CvX7r10SW6rcSIREjvUVhYmxeJ9y.abNhKczt9ZhjSb05eLG92LkoN1GTralF0Hz_jyFx
 yiMxdcqGV9VxVcelK64R4H29R_PTI4yWRlEWB8qKPiR8MLxbdm.BD01VV7Ib6d4kUS6p92ptxtpE
 FHzSNzV68x0k.6HXYDF5YFxw4fSTQdO6WWNtH.Rl8cz4lBeH0mgOWPbd5d.YA8gpHyRpDDYv2DhE
 UKW7NUiAYBLmLOuDlz2p9bC7l3HNfhnCvWGulnMkGQR6Nj21IZLFaDSH35HV71MIjw8AFLmntGxY
 7hIDbMYu2gafGwKrlE.Z3fRb1wuZmW.NwbxHA9qigbYQVzxsrCLI.GsYPkfvkSHLVSr.I6JHKkG8
 IO8nMtiRnPp7vVtkaAw3Hvt4CvpZnZCm5D3hI5aweXquvbUAytYGvST5pOKtKUg6HkkL6kt1dF4P
 nCsv5nMxHYk1gV1EMr9dg5mYf3RQOBS9TiGvzRqrjrB1iYcT7LPIHx3vqGCLDEeCc0_IXW6OCmhp
 tF1B3JO2XAWYInZ2g9e2qCCJWgJSTW1CExs443u8sNf1r_veHEpPOuTGHrV5Sm943rMsnwmbJrP2
 xef8kHLhABSx3cY_VRxR81nn8J_RhyZGvgsF6muHFJPMdeWyS9jaCCfIy8d3vRrXzazfVcIQQMMK
 LRI4h76ehiNZzf22aFvBXNwo81Mu3J9cAuwqwRw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 17 Nov 2022 17:40:27 +0000
Received: by hermes--production-bf1-5878955b5f-xc4c6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 9d740a995f4d4dea3f4d7f7eebc0ba6b;
          Thu, 17 Nov 2022 17:40:22 +0000 (UTC)
Message-ID: <66df8ebe-1ed2-c839-8a5f-cc0a26bad6c3@schaufler-ca.com>
Date:   Thu, 17 Nov 2022 09:40:20 -0800
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
 <026075fa-0b58-9041-0727-b75e19499356@schaufler-ca.com>
 <6b4d47765a4ddcfdf07158f3ad0737fa3aa5823e.camel@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <6b4d47765a4ddcfdf07158f3ad0737fa3aa5823e.camel@linux.ibm.com>
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

On 11/17/2022 9:24 AM, Mimi Zohar wrote:
> On Thu, 2022-11-17 at 09:18 -0800, Casey Schaufler wrote:
>> On 11/17/2022 8:05 AM, Mimi Zohar wrote:
>>> hOn Thu, 2022-11-10 at 10:46 +0100, Roberto Sassu wrote:
>>>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>>>
>>>> Currently, security_inode_init_security() supports only one LSM providing
>>>> an xattr and EVM calculating the HMAC on that xattr, plus other inode
>>>> metadata.
>>>>
>>>> Allow all LSMs to provide one or multiple xattrs, by extending the security
>>>> blob reservation mechanism. Introduce the new lbs_xattr field of the
>>>> lsm_blob_sizes structure, so that each LSM can specify how many xattrs it
>>>> needs, and the LSM infrastructure knows how many xattr slots it should
>>>> allocate.
>>> Perhaps supporting per LSM multiple xattrs is a nice idea, but EVM
>>> doesn't currently support it.  The LSM xattrs are hard coded in
>>> evm_config_default_xattrnames[],  based on whether the LSM is
>>> configured.  Additional security xattrs may be included in the
>>> security.evm calculation, by extending the list via
>>> security/integrity/evm/evm_xattrs.
>> Smack uses multiple xattrs. All file system objects have a SMACK64
>> attribute, which is used for access control. A program file may have
>> a SMACK64EXEC attribute, which is the label the program will run with.
>> A library may have a SMACK64MMAP attribute to restrict loading. A
>> directory may have a SMACK64TRANSMUTE attribute, which modifies the
>> new object creation behavior.
>>
>> The point being that it may be more than a "nice idea" to support
>> multiple xattrs. It's not a hypothetical situation.
> And each of these addiitonal Smack xattrs are already defined in 
> evm_config_default_xattrnames[].

Then I'm confused by the statement that "EVM doesn't currently support it".

