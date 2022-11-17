Return-Path: <linux-integrity-owner@vger.kernel.org>
X-Original-To: lists+linux-integrity@lfdr.de
Delivered-To: lists+linux-integrity@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BCEB62E2C1
	for <lists+linux-integrity@lfdr.de>; Thu, 17 Nov 2022 18:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240576AbiKQRTB (ORCPT <rfc822;lists+linux-integrity@lfdr.de>);
        Thu, 17 Nov 2022 12:19:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240673AbiKQRSa (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Thu, 17 Nov 2022 12:18:30 -0500
Received: from sonic310-30.consmr.mail.ne1.yahoo.com (sonic310-30.consmr.mail.ne1.yahoo.com [66.163.186.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 025AA7FC24
        for <linux-integrity@vger.kernel.org>; Thu, 17 Nov 2022 09:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1668705495; bh=bUB+Go+QZbKc+o/akfQR2CSJPJ5Io/Mye21Vk6SdZvY=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=LFc2wh9yKuM3aPvQDJY0c2S+/+VfQNVZyy44BG0NE5LvC6bk3+4q5uFg+Q4YgONc4MWIYCTxvtydpkF0HyBS+ZR6xQrGAt1xfPN2lMdxGNfWm5SR3DJryfoh6Jj9n0SWZcXwV0iwXzQk8nujWzLGSphqSuBfGofsfWaYuIXGtd87Vj3QyvU0LTGjfiz1juim3bmmFxOXC/wdrmYHhfVtppxcUzJ2/5sAqL0rcU0KwbFdLZ5cynYzvgeURNYnT3B3Do5dlFNfHCYYoxcaAOcvs1Ut3C94XPBxw4RwBtaKY9eOhFd12CyjJpECV7mYdA35HHVcHl+Wiils/O3xmTr9og==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1668705495; bh=qvQ3VF57H/im/O2ex+C3p1MLV0ig8qAkyl2rnu/mJWY=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=gPLCvvpqTPKKzvIGDrAH2aqTAiOyggFyQa0gQQbS/bT8407JXEc91iG0J9qPwD46L4pe3N38I2eh0Y5/P3XgoOAhv654jJmuy44hZ+iDL+chz87Cl84oVDrfxrp8POwVlwQ9OZNxzKEsXliQwkv97Yzdc9YsCkmG185A6xM6YYZAHZBn36Bu0QFMH5AqAb7KVCGiqfLE4668Sx/eT79KQ1bz2+OZRI7713mTo5veTfgUH/VgU9087AbJ2L+rgX8syOVfgbjrkB42qWtzzoW50qjgl9ze07oKxVRwC/Lqvg8uHTRfsiohTfSt0klEJfex4Ff6BBfxfGghg+zM/KGmhQ==
X-YMail-OSG: ubBl91YVM1kcM38HiGODfLa_lpKDMUzCJOmMjXkj2f4mlZcUQzEP.9C2nROwhcL
 bAHhi6zRnZl5DGsy8XJ.nB5Rtlm2kwQ.xq88ckpL9SHWIC3uyAr5kRFewuXze9vaSjTqOVjrunmr
 RLtKse53glOhO6FL6fHvfJvScE7Q2y0JHf0XPsWcnfy3hkTc1soFOSNr2SoKTn9IuPihiYTTflV7
 ivpQIf5fueTju2JDIncxRHRkp6ePDthIEyfpyvR6IvhksOjb4xVCrIIOt8Bx30En3n_Lq9tiRKB.
 Ebm5vwSksL1AtBRKblnPIUc5yiMj41hPH5VSvxsIa8zMWTTG6RRmBANzETbHhTEmB1ojPnnaTEtV
 aLp1YgfCc6yIulRAzMQ5EupID_AxIjXFzrqXs8SNZ.ZOW6.pM6.IZ4NEQhzj2wpOALMd5oxcGwVO
 ELAfLSEcSab3q6LRSrtLwEmsDOA3S0ck35TVKFBWNAEAvAbx23Zdi2scjdmJipL2gqzNnAiS0I_S
 OsIj5L83kTlYCnjo8XmRmfbnstKs3lLdzd7GGRFPoBAw2XrSqlAq7wXF.G0.vgkVA7X75E6tLzG7
 IwSVmoJVjsNscnWQZVh5G.JDs8A_5xnAJ8QzI6oyo0OcZNyzNpsXb6asGaru3cfarRrlF1E1pls0
 .LvyP5og5_zDfGi459clAzHNFm2YZOC7xADrvFO6sSvNnB4A7KXgO8_.Oh3SlIYV9TLkzBZwe_Ih
 9ce8Nn0xeluu1G9adMaT_pjE2PXO5s20ni2NDB0Hy9We33alwvzuVUMK.XJgz19GuWwz042Pbr28
 3PkDVTMaDMX0OPQDh52R3OutNZgm9kvOj0qX8Y_9BQ6alHKDLJ_deLI2LJc3TI523_oMnVwhXn49
 VBnwqxGUwbkBEeoRdkmehIpuMkov94V1usXCRnkhQDHLvhYuqE0chfb9E6TFtp8DOPCYYfCujvn7
 M3ykW_a7cwQar3yl8QtfNKwt5Q0R3NCHsh6MpATyY.QguXU089ITVHKKuhmUpQ999MhKuCKH_x3j
 LYHFUgCiCiEUi7Bx1jXVr4jN3lVzznSxDwLQjnELuLrf61R4ddUf8Ber1PVWr9nn9_AWsVYBeYMg
 EmlRZz8rYRGBVuWHI0tWspnSf8fDGiTM2mTm2Nl.YYZp.1Nuu4UilCYMkks_a4GNiwD4vgZNQ0fB
 k04lyJZC466JiJua2e6Wn5kLga7MuvdBRao5wNZd1sVCBT8Q4vQFRVMoclLAsieDI2Fzv.9ayg6Y
 FdO6fk_dg.3QxWMh5mkOdm4cvSDLAJCSVrYChrztPqE7rE8wyzv59ZsKgYoQOpXLKnl0yTGdow1K
 2lhGt6Ufgyv0g_aXztYIuKjCa9LHHuMAocEABDRNvC2601r8_qJjn9rGsqXG1BR8fE8xZgwEPv0H
 H2I1mHHLsMPVvMndvRvM2fsQ7NPzjCSamlQvDzEdZbPB2ah4jNlxzObwOKtsGwsI6PfffuEsNidG
 yjh2rYxB1wElGJDSgh9jvmZKUMT7wYeFV0a1tpM5.CRks6BrJHPG1cekA8XDSOvl6nU3Imm6bWp8
 Tals3JIX9QlZZjkUHwog7x90jz7QkkSrfySWc9IjgWUx18DW9lsLJKPLQ.qGDZeaLdckGwYU..FQ
 EuZLDCTQUTy.zJxBzIBllFC6c.rIitpu_YXgCITV.24yYe_fdBAGsLOAtocZmjmFDWn0AKAYSrk_
 2QeNQ.j0g.QG9l7M6T_88xUHpXp1bYRvkDe25dsummQSEgNGLRS6OLkOV5rSsw0n2xsoi1ayZ20Z
 8cZ3Cz.f3BFLPlk4qSK.DElYoI1YJWOSaRsHcbBl_d_o1LJ67PBFYHyX0PaDuZ2pvkJnWdbkVXe_
 _0n6hNOVP41gmLhTQkeK0r4PH02.MMdW1oAt6KxTb6mrfh.K9XR8M2ALXjGRY4EnGynLbt1rJ2.n
 67I3FTNhst9cEdg_4UhyNoD7VGSKIt0BtGGIvsZBXrrRgqJc.Iha0r4VE2pedw2hxmDecKff8WRd
 0m7HVdpQ7PsydZBCyRuRDVa.1ECMgWi8AFl82jl9SfzzUWdXznf7aMBn2DUBHDtU7UWgnUP98tzQ
 fVyHHLKfM95VyRy1Vw.U65m6erPn9mKulufiIRIHBBkoc.8TmSlkxlfpoZnWoezH0ZqmV0xwYQfQ
 CX3KDgCzNo2j.kHhjd.TJYwwQiatSyVJC024MrfxUoBKeA2LlPd9QcMBhItD3QaCQ2S7tLjJERis
 uKrSkp1xJTPhC8CoVYs71qO4GpJEt.sCGpw--
X-Sonic-MF: <casey@schaufler-ca.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ne1.yahoo.com with HTTP; Thu, 17 Nov 2022 17:18:15 +0000
Received: by hermes--production-bf1-5878955b5f-gz9tn (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7e8e1adb96e2ded1b69c072141632441;
          Thu, 17 Nov 2022 17:18:13 +0000 (UTC)
Message-ID: <026075fa-0b58-9041-0727-b75e19499356@schaufler-ca.com>
Date:   Thu, 17 Nov 2022 09:18:12 -0800
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
From:   Casey Schaufler <casey@schaufler-ca.com>
In-Reply-To: <4c1349f670dc3c23214a5a5036e43ddaa0a7bc89.camel@linux.ibm.com>
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

On 11/17/2022 8:05 AM, Mimi Zohar wrote:
> hOn Thu, 2022-11-10 at 10:46 +0100, Roberto Sassu wrote:
>> From: Roberto Sassu <roberto.sassu@huawei.com>
>>
>> Currently, security_inode_init_security() supports only one LSM providing
>> an xattr and EVM calculating the HMAC on that xattr, plus other inode
>> metadata.
>>
>> Allow all LSMs to provide one or multiple xattrs, by extending the security
>> blob reservation mechanism. Introduce the new lbs_xattr field of the
>> lsm_blob_sizes structure, so that each LSM can specify how many xattrs it
>> needs, and the LSM infrastructure knows how many xattr slots it should
>> allocate.
> Perhaps supporting per LSM multiple xattrs is a nice idea, but EVM
> doesn't currently support it.  The LSM xattrs are hard coded in
> evm_config_default_xattrnames[],  based on whether the LSM is
> configured.  Additional security xattrs may be included in the
> security.evm calculation, by extending the list via
> security/integrity/evm/evm_xattrs.

Smack uses multiple xattrs. All file system objects have a SMACK64
attribute, which is used for access control. A program file may have
a SMACK64EXEC attribute, which is the label the program will run with.
A library may have a SMACK64MMAP attribute to restrict loading. A
directory may have a SMACK64TRANSMUTE attribute, which modifies the
new object creation behavior.

The point being that it may be more than a "nice idea" to support
multiple xattrs. It's not a hypothetical situation.

