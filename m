Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6D6562FB61
	for <lists+linux-integrity@lfdr.de>; Fri, 18 Nov 2022 18:15:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242425AbiKRRPn (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Fri, 18 Nov 2022 12:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242515AbiKRRP3 (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 18 Nov 2022 12:15:29 -0500
Received: from sonic316-26.consmr.mail.ne1.yahoo.com (sonic316-26.consmr.mail.ne1.yahoo.com [66.163.187.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B32F9373C
        for <linux-integrity@vger.kernel.org>; Fri, 18 Nov 2022 09:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1668791723; bh=ofzSYaVcpdyw7JpRIdAZc2NiawoEta6Y3WTUmTaL0qY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=N0csH36KUZcLDS2Xk5ghz4CDUx1hzy8ixsY7eKNhJBu0/4zf9n4EfzPm2r7FxTQXi0wPkfJslnWHqBZ3T9tC/D2Cd3irDtPmHSW+lOfMwRH0a20bRMSr1MNq8EPtkTLpf2s4Nf87qC8fVIHcohs3/zbEbzVhMxOMv2rMbc1xl4mfsknKDP+pO7wNr4Oro6SetSDnWcLiVRSMbgzUOg3jmFuaCHsOC5GlUTumCGsB5Dm7X95zB9PIhqMErgKOWi02DuzEWHfMBdtRZXtf/QvOgFjMiaGDPn9v0leWSBof4lZaL1RMcTjl8/c2DVGGo19OGMKd17BQgNXS41WM/opDtA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1668791723; bh=Tz9Xu2Ne++0tD8c8ERH4hElQmi0Z1CKb+JUUY6wi9Yj=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=hcrWw4YXu/uN1eTS4PatNCrX+siBhatRJVBwBN+KUbqIPVLXIN8LmWWb6GLGpq93vPUEsa5FwC7cl5of2sq7w1gpWaxIShuvIFpQ7zQH5EPjKxmy+NQJ2d5gC51U/o6B1t3uXxZ3EF110jrRbLE7NOxoFqlIyPxWeCBRmqsol8iVX9oCZx61NWSh2ZKxZZPplzaUQmrZCalHTXYPQ/9Wi2uN7pnn7Ywa8VLAzLEbxaOTygcpkmDja7N/tTaeVVVxCnjYidnLuJz8vnaplilpM3wJrtZ+K22GwZycLgHrDomdnPSMIaHZtk/Un2J5mEgSe1GaLjJ9PqU7VKTvEjM+7A==
X-YMail-OSG: 3vSjfOgVM1n_I3giGrsS3W4wCXCBETQj8z7OjIh.hZ3ZiTbodvgy7nDYT1foIqO
 se.wjg9E631mQ8bWnGGHIKyb6tidGNCv2oEBG4tu53axerPiXkCoST.I24bscAoFHI.vBu4p6ksI
 J.PVWdTCpbrzaec3Tk.IRE5mb.FFW5DkEqsm86PocV69vZLSvuyeZU6HGQ.uKHQRcBLRtfSYbimk
 D3XatGVarzjAPaF_eYUK2H_KM1pMDFtpAW91JRwInuxKH3cYP5fY3W8A5qydB3I_zFRoKcl90Lmv
 6MErziJK5qaAw2sVaVZpz1md5pKB95RPU_AcrXlah4Uh51eWzn5d_48dNtyaCBzgI8eRvSysEysY
 TLegBGljaO0yWDve3fLIHwWafWx87RgWQUBkSxQUOn0SfGIO4A2jnfjxM1LH8tVMiTQvC2JX8kU1
 nGFYJohD1C8Dd07vXuQOL8uz1vmGl8bJzwo4FRN6dXXMPHFiTB1VtqQq_dtmru5q3j64eHPxpTHF
 fy0XzWU6Pr8SsRgj3dFcXoT8aVjpAJDTDgCOJaNBAd2MqolFIN2DWA26rEU.1lMC5RuU93i8.IPY
 jLPmM51EODKTyceVduv1u7dRjFJ.EESYoEkkwFcgC4.8HbCSkSvdwWY1kw3_kzL3xHIJYETY.Xn2
 vI8Mqne80upmDCRm9uqz7I6iCW84uR4JFQk34CreVQQCBDpDQa2OEV0CsKuJPRWVBjdkXzMlMJx6
 ZbBlVILCuFhm1Kbz.rwqG4eQ41vhPwfJXyj1LPKZQo53JguZbG_U4hrj_Xbdz1CIU1k4UbCO0FMk
 rzSxOkHMrEXVbMar2Jr47GAvaUJJMw45qrn6aReBQeLOvnR7olsxicvKAtt.7DXD3jaoPGWQ3GBX
 kmW.LsNn_rj5C5f45M_D4KXBr8lc37QDWETU7GHRPa1O05ZwWyx.pyN08Q54LQXNTzy2_paMjJxP
 mAoFAy2lk6CSBJaq4uO62Llu_gO2R0t6hprSB2JnN0bUjb8wJLC6KkC4enM8z2zKFyCX1JqcjFg4
 hl98Rgt_nY_wqZVgK9gn77OZNcB4VvHtMqsGXy3xWbeXGWPuLmTtrpveweSs8KSeKnDw22t0Bwki
 Vb3fO7Nn87vxVsX1Zc1EtzT9FmLDktyhFifNtZfju_YYJsmL968EEiG_5kAQpV.Uvo65WASOHZA6
 Qn0tNPvIhz05IkpPoN1gm96KBjfXhTcDUpZuLLJdukMVbbN1V4yHzTS6J.JSN_eZlflEcdGkrbGi
 qw2_8NZEa0p2ypWAq2yja2ZRZBTNSkijFnvKQKQrp106PeqsufzHtgo_JDI_XUkq2n9XkD0ue0f4
 f1eg8UVE0GAO8yWgF4CJhRcKrhUHt.OOAZzB1vVB_xGYBY7bwMQd9sDvWoKuJDB_8cjprVGa6iWn
 9fU7Jr5PysV47v9bNM9pO4lrAWwVeBW_ebHNAGXKUEYcVajIG0xcVqZcJiR7rlD6mx8.JsqBow_u
 wDqi9RM4BadycWu6Yj_2i6LgdL6BhpXn5d998jI8w.rvCWRTaL5Eq5Xue4FwOpgAs14qC3G1YUrX
 IXvAJ9i996hcEi_tG6q63dMe28SCB9HJJNEIu8ut2w7iNSFLpHkdXC6t92FuV4QLIvl.AGGdvL38
 2cFP.fYAzrE.j1jp4oc6qltjmzdGjcCxciKNlNai01cdty9MCkysQ4v3LvVKU3d65Vsdqpax7CAo
 _UYnrxakR79ejjKK7GA.MISZC_kPzWVqUSzk4nw7lf9YCEmZGKpqY46m8TrQf7bcS_eBIcO_634p
 wbnL.4TNOzqBXlQgaGb0uS.B31Unl8HK30fx2Rpp9Xa15dMYaiyzrl_80mGEINVFkKAN2RUVwVTz
 T9x6YFhkX86_Nin0iJ6pt6IBHEGlJM4uzqf5yj1JRIjiH189uxFRg2Hd8OExQpXyp.mlZOgfcgaW
 VgUXd0610b4uITly8G41QSPby8K0hcnVmnEJemMCYp9uPwp4Obylc9BWD1EvIxGiP6.fQWT6DFvE
 7ObPRwfXDltZWt1G2bFaXKQGHm23okN2zFZYqX_4OYu5YrEYjEZalI0yml5hubpIRWUciHi9_UCa
 MMADCXknufSQkzhzfh7cTDH0vdsUnwmNv5iMrcWVd18i_XbsoAE5eXuGYN7QAmmyquCH98K971H1
 wfUtw8l.MKm5kAzHLD.Oo3HE1hqaWcn4mFXeiOZoOSdDPTk2op06IusfGwmZ8BHdVFgTkvz1UQjk
 mm.zN4zofzGUIgsuBXu1_kTxUUTJU1262vhtISvRthr.FLoFCIweyFe72LFeg46Z8XjtO7Pdgt0S
 kz3PiwgU6Vaw-
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic316.consmr.mail.ne1.yahoo.com with HTTP; Fri, 18 Nov 2022 17:15:23 +0000
Received: by hermes--production-bf1-5878955b5f-xc4c6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID ea4aac5d2e626bcbff0e7c90f82744aa;
          Fri, 18 Nov 2022 17:15:21 +0000 (UTC)
Message-ID: <7cb8dd49-5c8d-1df5-1859-21553ec30637@schaufler-ca.com>
Date:   Fri, 18 Nov 2022 09:15:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 3/5] security: Allow all LSMs to provide xattrs for
 inode_init_security hook
To:     Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Mimi Zohar <zohar@linux.ibm.com>, dmitry.kasatkin@gmail.com,
        paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        stephen.smalley.work@gmail.com, eparis@parisplace.org
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
Content-Language: en-US
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <fe16a03a-102e-b3e1-cc3f-5bad3c28fad7@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailer: WebService/1.1.20863 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-integrity.vger.kernel.org>
X-Mailing-List: linux-integrity@vger.kernel.org

On 11/18/2022 1:14 AM, Roberto Sassu wrote:
> On 11/17/2022 5:05 PM, Mimi Zohar wrote:
>> hOn Thu, 2022-11-10 at 10:46 +0100, Roberto Sassu wrote:
>>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>>
>>> Currently, security_inode_init_security() supports only one LSM
>>> providing
>>> an xattr and EVM calculating the HMAC on that xattr, plus other inode
>>> metadata.
>>>
>>> Allow all LSMs to provide one or multiple xattrs, by extending the
>>> security
>>> blob reservation mechanism. Introduce the new lbs_xattr field of the
>>> lsm_blob_sizes structure, so that each LSM can specify how many
>>> xattrs it
>>> needs, and the LSM infrastructure knows how many xattr slots it should
>>> allocate.
>>
>> Perhaps supporting per LSM multiple xattrs is a nice idea, but EVM
>> doesn't currently support it.  The LSM xattrs are hard coded in
>> evm_config_default_xattrnames[],  based on whether the LSM is
>> configured.  Additional security xattrs may be included in the
>> security.evm calculation, by extending the list via
>> security/integrity/evm/evm_xattrs.
>
> EVM wouldn't notice whether it is the same LSM that provide multiple
> xattrs or multiple LSMs provided one xattr. As long as the xattr array
> contains consecutive xattrs, that would be fine. In the IMA/EVM test I
> included a test case where an LSM provides two xattrs (seems to work
> fine).
>
>>> Dynamically allocate the xattrs array to be populated by LSMs with the
>>> inode_init_security hook, and pass it to the latter instead of the
>>> name/value/len triple.
>>>
>>> Since the LSM infrastructure, at initialization time, updates the
>>> number of
>>> the requested xattrs provided by each LSM with a corresponding
>>> offset in
>>> the security blob (in this case the xattr array), it makes
>>> straightforward
>>> for an LSM to access the right position in the xattr array.
>>>
>>> There is still the issue that an LSM might not fill the xattr, even
>>> if it
>>> requests it (legitimate case, for example it might have been loaded
>>> but not
>>> initialized with a policy). Since users of the xattr array (e.g. the
>>> initxattrs() callbacks) detect the end of the xattr array by
>>> checking if
>>> the xattr name is NULL, not filling an xattr would cause those users to
>>> stop scanning xattrs prematurely.
>>>
>>> Solve that issue by introducing security_check_compact_xattrs(),
>>> which does
>>> a basic check of the xattr array (if the xattr name is filled, the
>>> xattr
>>> value should be too, and viceversa), and compacts the xattr array by
>>> removing the holes.
>>>
>>> An alternative solution would be to let users of the xattr array
>>> know the
>>> number of elements of the xattr array, so that they don't have to
>>> check the
>>> termination. However, this seems more invasive, compared to a simple
>>> move
>>> of few array elements.
>>>
>>> Finally, adapt both SELinux and Smack to use the new definition of the
>>> inode_init_security hook, and to correctly fill the designated slots
>>> in the
>>> xattr array.
>>>
>>> Signed-off-by: Roberto Sassu <roberto.sassu@huawei.com>
>>> ---
>>
>>> diff --git a/security/security.c b/security/security.c
>>> index a0e9b4ce2341..b62f192de6da 100644
>>> --- a/security/security.c
>>> +++ b/security/security.c
>>> @@ -30,8 +30,6 @@
>>>   #include <linux/msg.h>
>>>   #include <net/flow.h>
>>>   -#define MAX_LSM_EVM_XATTR    2
>>> -
>>>   /* How many LSMs were built into the kernel? */
>>>   #define LSM_COUNT (__end_lsm_info - __start_lsm_info)
>>>   @@ -210,6 +208,7 @@ static void __init lsm_set_blob_sizes(struct
>>> lsm_blob_sizes *needed)
>>>       lsm_set_blob_size(&needed->lbs_msg_msg, &blob_sizes.lbs_msg_msg);
>>>       lsm_set_blob_size(&needed->lbs_superblock,
>>> &blob_sizes.lbs_superblock);
>>>       lsm_set_blob_size(&needed->lbs_task, &blob_sizes.lbs_task);
>>> +    lsm_set_blob_size(&needed->lbs_xattr, &blob_sizes.lbs_xattr);
>>>   }
>>>     /* Prepare LSM for initialization. */
>>> @@ -346,6 +345,7 @@ static void __init ordered_lsm_init(void)
>>>       init_debug("msg_msg blob size    = %d\n",
>>> blob_sizes.lbs_msg_msg);
>>>       init_debug("superblock blob size = %d\n",
>>> blob_sizes.lbs_superblock);
>>>       init_debug("task blob size       = %d\n", blob_sizes.lbs_task);
>>> +    init_debug("xattr slots          = %d\n", blob_sizes.lbs_xattr);
>>>         /*
>>>        * Create any kmem_caches needed for blobs
>>> @@ -1100,34 +1100,78 @@ static int security_initxattrs(struct inode
>>> *inode, const struct xattr *xattrs,
>>>       return 0;
>>>   }
>>
>>> +static int security_check_compact_xattrs(struct xattr *xattrs,
>>> +                     int num_xattrs, int *checked_xattrs)
>>
>> Perhaps the variable naming is off, making it difficult to read.   So
>> although this is a static function, which normally doesn't require a
>> comment, it's definitely needs one.
>
> Ok, will improve it.
>
>>> +{
>>> +    int i;
>>> +
>>> +    for (i = *checked_xattrs; i < num_xattrs; i++) {
>>
>> If the number of "checked" xattrs was kept up to date, removing the
>> empty xattr gaps wouldn't require a loop.  Is the purpose of this loop
>> to support multiple per LSM xattrs?
>
> An LSM might reserve one or more xattrs, but not set it/them (for
> example because it is not initialized). In this case, removing the
> gaps is needed for all subsequent LSMs.

This is in fact the case with Smack. All file system objects have SMACK64 attributes,
some have SMACK64EXEC, others SMACK64MMAP and still others SMACK64TRANSMUTE.

>
>>> +        if ((!xattrs[i].name && xattrs[i].value) ||
>>> +            (xattrs[i].name && !xattrs[i].value))
>>> +            return -EINVAL;
>>> +
>>> +        if (!xattrs[i].name)
>>> +            continue;
>>> +
>>> +        if (i == *checked_xattrs) {
>>> +            (*checked_xattrs)++;
>>> +            continue;
>>> +        }
>>> +
>>> +        memcpy(xattrs + (*checked_xattrs)++, xattrs + i,
>>> +               sizeof(*xattrs));
>>> +        memset(xattrs + i, 0, sizeof(*xattrs));
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>   int security_inode_init_security(struct inode *inode, struct inode
>>> *dir,
>>>                    const struct qstr *qstr,
>>>                    const initxattrs initxattrs, void *fs_data)
>>>   {
>>> -    struct xattr new_xattrs[MAX_LSM_EVM_XATTR + 1];
>>> -    struct xattr *lsm_xattr, *evm_xattr, *xattr;
>>> -    int ret = -EOPNOTSUPP;
>>> +    struct security_hook_list *P;
>>> +    struct xattr *new_xattrs;
>>> +    struct xattr *xattr;
>>> +    int ret = -EOPNOTSUPP, cur_xattrs = 0;
>>>         if (unlikely(IS_PRIVATE(inode)))
>>>           goto out_exit;
>>>   +    if (!blob_sizes.lbs_xattr)
>>> +        goto out_exit;
>>> +
>>>       if (!initxattrs ||
>>>           (initxattrs == &security_initxattrs && !fs_data)) {
>>>           ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
>>> -                    dir, qstr, NULL, NULL, NULL);
>>> +                    dir, qstr, NULL);
>>>           goto out_exit;
>>>       }
>>> -    memset(new_xattrs, 0, sizeof(new_xattrs));
>>> -    lsm_xattr = new_xattrs;
>>> -    ret = call_int_hook(inode_init_security, -EOPNOTSUPP, inode,
>>> dir, qstr,
>>> -                        &lsm_xattr->name,
>>> -                        &lsm_xattr->value,
>>> -                        &lsm_xattr->value_len);
>>> -    if (ret)
>>> -        goto out;
>>> +    /* Allocate +1 for EVM and +1 as terminator. */
>>> +    new_xattrs = kcalloc(blob_sizes.lbs_xattr + 2,
>>> sizeof(*new_xattrs),
>>> +                 GFP_NOFS);
>>> +    if (!new_xattrs) {
>>> +        ret = -ENOMEM;
>>> +        goto out_exit;
>>> +    }
>>> +    hlist_for_each_entry(P, &security_hook_heads.inode_init_security,
>>> +                 list) {
>>> +        ret = P->hook.inode_init_security(inode, dir, qstr,
>>> new_xattrs);
>>> +        if (ret && ret != -EOPNOTSUPP)
>>> +            goto out;
>>> +        if (ret == -EOPNOTSUPP)
>>> +            continue;
>>> +        ret = security_check_compact_xattrs(new_xattrs,
>>> +                            blob_sizes.lbs_xattr,
>>> +                            &cur_xattrs);
>>
>> Defining a variable named "cur_xattrs" to indicate the number of xattrs
>> compressed is off.  Perhaps use cur_num_xattrs?   Similarly,
>> "checked_xattrs" should be num_checked_xattrs.  Or change the existing
>> num_xattrs to max_num_xattrs and rename checked_xattrs to num_xattrs.
>
> Ok.
>
> Thanks
>
> Roberto
>
>> thanks,
>>
>> Mimi
>>
>>> +        if (ret < 0) {
>>> +            ret = -ENOMEM;
>>> +            goto out;
>>> +        }
>>> +    }
>>>   -    evm_xattr = lsm_xattr + 1;
>>> -    ret = evm_inode_init_security(inode, lsm_xattr, evm_xattr);
>>> +    ret = evm_inode_init_security(inode, new_xattrs,
>>> +                      new_xattrs + cur_xattrs);
>>>       if (ret)
>>>           goto out;
>>>       ret = initxattrs(inode, new_xattrs, fs_data);
>>> @@ -1142,6 +1186,7 @@ int security_inode_init_security(struct inode
>>> *inode, struct inode *dir,
>>>               continue;
>>>           kfree(xattr->value);
>>>       }
>>> +    kfree(new_xattrs);
>>>   out_exit:
>>>       if (initxattrs == &security_initxattrs)
>>>           return ret;
>
