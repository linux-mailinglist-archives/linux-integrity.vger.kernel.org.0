Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EAB63C3F6
	for <lists+linux-integrity@lfdr.de>; Tue, 29 Nov 2022 16:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235745AbiK2Pj4 (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Tue, 29 Nov 2022 10:39:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235951AbiK2Pjx (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 29 Nov 2022 10:39:53 -0500
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3542955AA2
        for <linux-integrity@vger.kernel.org>; Tue, 29 Nov 2022 07:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669736389; bh=aS4qJAF4z8K3/s5yGPKxlY1D2luVFB8NMnvEFjOx3S8=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=UCIRYfwJp5dnGKfLWNOCIDvxQZp4JMl8Ebh7ryzXxAMfE1mc5NF4igvFnWL6+NkGFVF3rxe4/oa5TDAMPqAqpuw5CGUu0Rusos4DjUc1BbQXt8gMGQiJ49V8gCaeC3NFpQQZHol8bfrjtLBujY01g3wDrHrstNbOckEkj+r4//CafwKbpv3a+A5hfZ1IsiiG+tZvOETbXPheXY/binn4bWW08BxM7QLHh0Vie9Y2zED9iW+BCbijyfyf2eTDPG66WcsIPzf3FxcSrzp1coaPJqnCx0GzeNLbMJzvNvHXyl3ubcDaBC3m/jEuOzEH093wMqhStd+C5zyJpux9iYozCw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1669736389; bh=Pr27aGc/OX9Ho8hBH0yo+8Vyjejsegj+/K462uaAuUa=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=LIATda0hhwQXu1NV91UXQY66oJTyl/wadPbJXbVy0VXCEJsxLkN831GEUp0yLWIVNnUEtvobODyJ4oRxEPEZxXBRBIPHxdzq/ND2WezoUeFPyb9P1Hqtrmi8sMl3CTHU5ybwKgNl8Jn/AJGHn39Eo7ZbwtTBnwgqW5LhjJxsKk9pVcBK0m57mxhZwp1zn3Cdhkdr1p5ipawBa4UMgB7g3IIX/aZayOze5fJwDQDO+S6c71QDmdSL4q4WvqhT5HfYMDqu+andkLLDKZ8oTXGahdXk9Jo8Xq2/MYZaz3daokStqto+Cooa1r7y6fE0hALEAGmk8SBsTKGU460yiLKwrQ==
X-YMail-OSG: SvXqCeQVM1lKZRCOPXx5n5UGD0rNol1csgmAMB3JhTJYUYVP1CWh7AKAlDOAde_
 r2JTFCqaTcNyhA_eaiHo2Vv1U08qvAeiCyJIdzrTjaOTNWyqqvjvVtON44pfghw_pHkx7CHsfE0W
 HbmfFm00RSGbmncdum3QVGwNs1YMIOBN54srxlMbKuedU2oBwercb_Y0DN379oDOWyI0pE4WLszm
 Y_tarBM4yRNxgwibBI8CK7zemR0Lx127uR5vVWjUitlxU1brd_ZICbhBX4qe.vFz1J5kOPHZOaqy
 PTtGRuFUwbXFEjebsR3VC0Ylnj1hCO7a2EOED4XvJUTlAyRyTacY03quyuEFhSKwCDceXdMkhPfC
 hj5RNfxXHBtyXgWe5IXBtkLCJvTtfONs1Q2Na4eVX4g39wsIwMzW5UKW5wWdFchxFozqlYq8M7t2
 bKjadVi0To45ldTvuuu6MokUT1.JOzV5ZPYoGS9b83fls6wHep5JJLDjxKL4y3ZTYtJHATFkF9zl
 t5th5TS1_lzPClcwAQ24p6tC91LeXeAi8mG52siLu702RGL5c0M.MUB80KH5798_ullbdP9XNRf8
 k7VukVP_sqRg1NTzNLzF32GT_Acg9zdkfM1knYpfzl5dZ1i2Cp44dT5DrqowaMZ49qlQzF.KVIYn
 W2XOhZ8IgmM6vvumbuWMnqiH_jgyK47N2B5VvqteRJ6kLtp0D97wlsScMyV5zB.X0sYsEe5PUOVy
 E6iKp_eOqyjzt4YeJ_sktkfUBTrb5Ccy.1JCH7PWn2y.NEWONd6y9F7hBrfcMXOibj.cI.DqmmP0
 Jkl1L.GgONO1Eg3ITnzCA0Y9LiX47GS7QbAr_2MecRIQb3xPohT9hQcTm7D7t8vJxUoURUaCLi_5
 Krux69V2f3Br4pVzFLU2x7_H2tgse98PxtY7cUnl.5Ik0a3tPs4EkySHuYfOHwfEpTuAdtxOhb66
 qXuI8nrsCfJD_KFUNXcHKLDDiBtGtZXWAWoOjs1gv4lStLo2rAUi7Y3LQYxgjYejHxJldBAl595Z
 CvK.Vmz4B0wEIWNz0YB8uLv79XIi4a5GmA1rLwi4.g_0D0dSyabMwg_MYq6ZspLoiCEuF5HdFFWy
 sjUwbTRudadFZHU0itgRLqLF__FXDAqqrYcd3sdRgVYbeYIL9Q8hFAfHYg8uqY1RboMH9e6Je1tH
 rzBMDOqcBss3hnP09T1GsPjdW2JPOfagJRt3mTisEx356gVMDdBnPCIF3iWojZzJTrmKXwP.oEg5
 kHxM7GzuCZuKko7TkiBZAfNkKk5FAkP0z5qGFyEoza4_EGXBvAQubV6QIzNsz8UHx1XXmwnBhjWX
 22WNF2RUG41OTLrNngNTjz7Xi3QNPme.BDp0EytvQl9OzwTDIQxA_rXsJpHCL6GI5hYWwYIs1sYD
 bcJnMscRnQfecDV_w0SMxjuYHB3NSF3nRlzeMITtSQ5PnUh78cKfRUbRSvNf6FsgS5L5f9xhCQVu
 0cRhzpvnxY5lqMNiBcIzoNeBsOQh7ZM4boM.XyojVIuRGeaMFsEoA7zfhvMwUzxZl5pDCO4FBS6u
 j4MtS7Z6thd3YF3Qc4Zpbs0RwhYjt5kte2WrU3ezYFWxJ80kpEkDkSI1wMnaK3nemGCn4ooXivXm
 uX4UrRDqQ0.thfRxZjaPXAucAyLPq5bmxgGZXiX94CvzB.xOsKzbs0v4QZnG46yiQ.LsL_PoXE46
 9QVkF5DB5.0Jr1LYKDNE16zUUwBKD7gun1Lr4BC0Pw_WAA3KNFROgD06_NeOGUtBSfcnlAIx4ijs
 sjaV6dr_gEmfipAD_d3Fnq1TwDGpIeHeAsW5YSnbfMR98K0kUv04ScWALau6bSxzGMyqjOWgAcb8
 .KFMsmfPJHj_qU0wvfJlVlrEw7RuU_kBz4jcIzPqG7NSuMKmAmSmayt0D4Whaet9t5HNa.h8rwa2
 6fprqK1Ln_v1kLCPt.lQ3XdLN5huZoRCoeLJM6LwWIaam_TU81U5THfuKiKmEpQUYXsX.wd9Xh5c
 JJ04g3ybpRUTQ76udcxryGGKYKdwN73NPdNWap43.jm_GZbgXgSjVFwalh2O_jfw5uibeWTKeAS_
 zc.ORh_q6nLRoDRtSVFrFqCqc1QalRMSlmVfNdANB4vL4xv8bQbEjNiWNzLlIfJDWOgjebvJdoNw
 NLSuTyNVl2QuGphxweBvisGFtOCT65KC3IebdLhK18BONru3hoBmayvL61Wk4SoWlGxu6tKKUkE8
 dMbMj7xuXDBd2Hxb3iETfxaruqgjz8fIYCdQ-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Tue, 29 Nov 2022 15:39:49 +0000
Received: by hermes--production-gq1-579bc4bddd-hwj6j (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 53dcf3609291d16c651c1285730a1577;
          Tue, 29 Nov 2022 15:39:45 +0000 (UTC)
Message-ID: <50232f2b-d5ce-1e5a-3f5b-8d3eb53fe1ec@schaufler-ca.com>
Date:   Tue, 29 Nov 2022 07:39:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v6 4/6] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
Content-Language: en-US
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>, mark@fasheh.com,
        jlbec@evilplan.org, joseph.qi@linux.alibaba.com,
        dmitry.kasatkin@gmail.com, paul@paul-moore.com, jmorris@namei.org,
        serge@hallyn.com, stephen.smalley.work@gmail.com,
        eparis@parisplace.org
Cc:     ocfs2-devel@oss.oracle.com, reiserfs-devel@vger.kernel.org,
        linux-integrity@vger.kernel.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-kernel@vger.kernel.org, keescook@chromium.org,
        nicolas.bouchinet@clip-os.org,
        Roberto Sassu <roberto.sassu@huawei.com>,
        casey@schaufler-ca.com
References: <20221123154712.752074-1-roberto.sassu@huaweicloud.com>
 <20221123154712.752074-5-roberto.sassu@huaweicloud.com>
 <13350b79f708cb089e2ff2ee5cead52bafb10982.camel@linux.ibm.com>
 <bb63eba9a9f24558f4a1acd9bf012b59b5c6e98e.camel@huaweicloud.com>
 <9859294adb0a9b9587ea7fb70a836a312aaf3c69.camel@linux.ibm.com>
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <9859294adb0a9b9587ea7fb70a836a312aaf3c69.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.20863 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/29/2022 3:23 AM, Mimi Zohar wrote:
> On Thu, 2022-11-24 at 09:17 +0100, Roberto Sassu wrote:
>> On Wed, 2022-11-23 at 20:14 -0500, Mimi Zohar wrote:
>>> Hi Roberto,
>>>
>>> On Wed, 2022-11-23 at 16:47 +0100, Roberto Sassu wrote:
>>>>  int security_inode_init_security(struct inode *inode, struct inode *dir,
>>>>                                  const struct qstr *qstr,
>>>>                                  const initxattrs initxattrs, void *fs_data)
>>>>  {
>>>> -       struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
>>>> -       struct xattr *lsm_xattr, *evm_xattr, *xattr;
>>>> -       int ret;
>>>> +       struct security_hook_list *P;
>>>> +       struct xattr *new_xattrs;
>>>> +       struct xattr *xattr;
>>>> +       int ret = -EOPNOTSUPP, num_filled_xattrs = 0;
>>>>  
>>>>         if (unlikely(IS_PRIVATE(inode)))
>>>>                 return 0;
>>>>  
>>>> +       if (!blob_sizes.lbs_xattr)
>>>> +               return 0;
>>>> +
>>>>         if (!initxattrs)
>>>>                 return call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
>>>> -                                    dir, qstr, NULL, NULL, NULL);
>>>> -       memset(new_xattrs, 0, sizeof(new_xattrs));
>>>> -       lsm_xattr = new_xattrs;
>>>> -       ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode, dir, qstr,
>>>> -                                               &lsm_xattr->name,
>>>> -                                               &lsm_xattr->value,
>>>> -                                               &lsm_xattr->value_len);
>>>> -       if (ret)
>>>> +                                   dir, qstr, NULL);
>>>> +       /* Allocate +1 for EVM and +1 as terminator. */
>>>> +       new_xattrs = kcalloc(blob_sizes.lbs_xattr + 2, sizeof(*new_xattrs),
>>>> +                            GFP_NOFS);
>>>> +       if (!new_xattrs)
>>>> +               return -ENOMEM;
>>>> +
>>>> +       hlist_for_each_entry(P, &security_hook_heads.inode_init_security,
>>>> +                            list) {
>>>> +               ret = P->hook.inode_init_security(inode, dir, qstr, new_xattrs);
>>>> +               if (ret && ret != -EOPNOTSUPP)
>>>> +                       goto out;
>>>> +               if (ret == -EOPNOTSUPP)
>>>> +                       continue;
>>> In this context, -EOPNOTSUPP originally signified that the filesystem
>>> does not support writing xattrs.  Writing any xattr would fail. 
>>> Returning -ENODATA for no LSM xattr(s) data would seem to be more
>>> appropriate than -EOPNOTSUPP.
>> Hi Mimi
>>
>> I thought about adding new return values. Currently only -EOPNOTSUPP
>> and -ENOMEM are expected as errors.
>>
>> However, changing the conventions would mean revisiting the LSMs code
>> and ensuring that they follow the new conventions.
>>
>> I would be more in favor of not touching it.
> Casey, Paul, any comment?

I don't see value in adding -ENODATA as a value special to
the infrastructure. What would the infrastructure do differently?
The use of -EOPNOTSUPP isn't consistent throughout, and the amount
of "correctness" you get by returning -ENODATA is really small.

>
>>>> +               /*
>>>> +                * As the number of xattrs reserved by LSMs is not directly
>>>> +                * available, directly use the total number blob_sizes.lbs_xattr
>>>> +                * to keep the code simple, while being not the most efficient
>>>> +                * way.
>>>> +                */
>>>> +               ret = security_check_compact_filled_xattrs(new_xattrs,
>>>> +                                                          blob_sizes.lbs_xattr,
>>>> +                                                          &num_filled_xattrs);
>>>> +               if (ret < 0) {
>>>> +                       ret = -ENOMEM;
>>>> +                       goto out;
>>>> +               }
>>>> +       }
>>>> +
>>>> +       if (!num_filled_xattrs)
>>>>                 goto out;
>>>>  
>>>> -       evm_xattr = lsm_xattr + 1;
>>>> -       ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
>>>> +       ret = evm_inode_init_security(inode, new_xattrs,
>>>> +                                     new_xattrs + num_filled_xattrs);
>>>>         if (ret)
>>>>                 goto out;
>>>>         ret = initxattrs(inode, new_xattrs, fs_data);
>>>>  out:
>>>>         for (xattr = new_xattrs; xattr->value != NULL; xattr++)
>>>>                 kfree(xattr->value);
>>>> +       kfree(new_xattrs);
>>>>         return (ret == -EOPNOTSUPP) ? 0 : ret;
>>>>  }
>>> b
>
